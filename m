From: Bill Lear <rael@zopyra.com>
Subject: Re: Any way to "flatten" a series of changes in git
Date: Thu, 22 Oct 2009 15:44:40 -0500
Message-ID: <19168.50232.47935.864407@lisa.zopyra.com>
References: <26ae428a0910221303n493fb7s701269d694110685@mail.gmail.com>
	<19168.49405.775024.649626@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Howard Miller <howard@e-learndesign.co.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 22:44:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N14We-0004xf-02
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 22:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138AbZJVUoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 16:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755951AbZJVUoi
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 16:44:38 -0400
Received: from 75-27-130-60.lightspeed.austtx.sbcglobal.net ([75.27.130.60]:33047
	"EHLO zopyra.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754862AbZJVUoi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 16:44:38 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id n9MKigR13780;
	Thu, 22 Oct 2009 14:44:42 -0600
In-Reply-To: <19168.49405.775024.649626@lisa.zopyra.com>
X-Mailer: VM 8.0.11 under Emacs 21.1.1 (i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131057>

On Thursday, October 22, 2009 at 15:30:53 (-0500) Bill Lear writes:
>On Thursday, October 22, 2009 at 21:03:44 (+0100) Howard Miller writes:
>>Hello,
>>
>>I have a branch with a whole series of commits. I want to export this
>>work to be customer (to their svn repo if that has any bearing on it).
>>All the stuff in the history is irrelevant to my customer ("committing
>>now, going to bed" etc.) so I'd like to create a new branch that only
>>has one commit.. the end point with a new message. Is this possible?
>
>git rebase is your friend.

Someone correct me if I'm wrong.

% git branch
* master
% git checkout -b my_work_branch
% [work work work, commit, commit, commit]
% git rebase -i master

You'll then get an editor buffer that looks like this:

pick 16730c6 baz 0
pick 2a844e7 baz 1
pick d6e71dc baz 2
pick d1a6995 baz 3
pick 157e675 baz 4

# Rebase ef0a89e..157e675 onto ef0a89e
#
# Commands:
#  p, pick = use commit
#  e, edit = use commit, but stop for amending
#  s, squash = use commit, but meld into previous commit
#
# If you remove a line here THAT COMMIT WILL BE LOST.
# However, if you remove everything, the rebase will be aborted.
#

Edit this to keep what you need:
pick 16730c6 baz 0
squash 2a844e7 baz 1
squash d6e71dc baz 2
squash d1a6995 baz 3
squash 157e675 baz 4

then exit the editor.  It'll pop you in another editor session to
type in a commit message for these, just type in what you need and
exit and you'll have the new commit with all the olds ones squashed
into it.


Bill
