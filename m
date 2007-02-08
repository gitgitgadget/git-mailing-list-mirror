From: Bill Lear <rael@zopyra.com>
Subject: Re: Git rescue mission
Date: Thu, 8 Feb 2007 15:57:14 -0600
Message-ID: <17867.40122.51865.575762@lisa.zopyra.com>
References: <17866.27739.701406.722074@lisa.zopyra.com>
	<Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 22:58:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFHHO-0006A5-6e
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 22:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423483AbXBHV6G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 16:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423484AbXBHV6G
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 16:58:06 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61676 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423483AbXBHV6F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 16:58:05 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l18LvLF26977;
	Thu, 8 Feb 2007 15:57:21 -0600
CC: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39099>

On Thursday, February 8, 2007 at 09:27:50 (-0800) Linus Torvalds writes:
>On Wed, 7 Feb 2007, Bill Lear wrote:
>> 
>> I have a public bare repo on my machine that I have cloned to make a
>> private repo.  I just want to sync my branches on my public and
>> private repos.  I do not want to merge across branches, I just want to
>> "sync".
>
>Ok, others already replied, but here's a few rules to ease your mind in 
>general:
>
> - First off: you can always _trivially_ get back to whatever state you 
>   had before, as long as you committed it, and didn't have any dirty 
>   state (uncommitted patches) in your working tree.
>...

Well, I have read all of the very welcome advice and am comfortable
with all of it.

However, I still have a few open issues with the other branch of this
discussion, i.e., why can we not have an update operation that
respects branches in the first place, as 'git pull' seems to do, when
run from the master branch?  I do realize that the branch 'foo' in my
repo is different from the branch 'foo' in your repo.  However, I want
to track things, and "track" here is a very appropriate word.  Tracks
don't cross, and I don't want to cross my "logically equivalent"
branches (at least yet), even though, as Linus pointed out in great
detail, this is easy to undo (though, do see below for a qualification
of "easy").

So, why should I care?

Because, an ounce of prevention is worth a pound of cure.  So, if a
pound of undo is so very easy, then, in my mind, an ounce of
preventing the problem in the first place is at least 1/16th that.

When working in a peer-to-peer relationship, I often push and pull
with my peers, perhaps on a daily basis, perhaps weekly.  Just the
other day, my peer was the one who goofed up his branches and I pulled
them into my public repo, all tangled up, and did not realize it.
Thence pulled into my private repo, did lots of work, pushed back to
my public repo, and after more time intervened, realized something was
wrong.  It took a LOT of work (for me, I'm sure for others here it
would have been much, much less) for me to 1) figure out the genesis
of the problem, and 2) figure out how to undo it all without
destroying my subsequent work.  When we both do this, and merge
unexpectedly, at different points on one branch from a different
point on another, and then pollute each others' repos, it does become
rather ... well, annoying is the best way to put it.

In CVS, if I am on branch topic and say 'cvs update', it updates my
branch topic.  If I am on branch master and say 'cvs update', it
updates my branch master.  Etc., etc.  It doesn't matter that you move
from one branch to the other, the update behavior is the same.  In
git, if I am on master, things seem to work wonderfully --- one 'git
pull' and my entire repo is synced (that is, merged) as I expect with
the other repo.

I really don't want to do 'git fetch'.  I really want 'git pull'.  I
really want the changes put into my repo, from that repo's branch X
onto my branch X, and that repo's branch Y onto my branch Y.  I really
don't want to have to remember to switch to my master branch before I
do git pull (this, however, as it stands, does seem to me to be the
best option).  Perhaps I'll just write a script 'git-sync' that does
'git checkout master; git pull'...

Jakub is of course literally correct when he says "'Crossing of the
streams' is _required_ ... If you do parallel work ... you have to
do merges".  Again, I recognize that my "foo" branch is different
from your "foo" branch, and that when they come together they are
in fact merged, but logically they are one thing --- one stream of
shared work that we don't want to slip over into another one, at
least not until we are ready.

Again, thanks to everyone for their patience.  We really do enjoy
using git --- very cool, fast, and flexible.


Bill
