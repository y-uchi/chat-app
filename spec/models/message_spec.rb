require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  context "メッセージを保存できる場合" do
    it 'contentとimageが存在する時' do
      expect(@message).to be_valid
    end
    it 'contentのみ存在する時' do
      @message.image = nil
      expect(@message).to be_valid
    end
    it 'imageのみ存在する時' do
      @message.content = ''
      expect(@message).to be_valid
    end
  end

  context "メッセージを保存できない場合" do
    it 'contentとimageが空の時' do
      @message.image = nil
      @message.content = ''
      @message.valid?
      expect(@message.errors.full_messages).to include("Content can't be blank")
    end
    it 'roomと紐づいていないと保存できない' do
      @message.room = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("Room must exist")
    end
    it 'userが紐づいていないと保存できない' do
      @message.user = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("User must exist")
    end
  end
end
