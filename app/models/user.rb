# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true

  has_many :contacts,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'Contact'

  has_many :contact_shares,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'ContactShare',
    dependent: :destroy

  has_many :shared_contacts,
    through: :contact_shares,
    source: :contact

  has_many :authored_comments,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: 'Comment'

  has_many :comments,
    as: :commentable,
    dependent: :destroy
end
