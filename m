From: "George Spelvin" <linux@horizon.com>
Subject: Git workflow: how to achieve?
Date: 24 Apr 2009 00:58:43 -0400
Message-ID: <20090424045843.7674.qmail@science.horizon.com>
Cc: linux@horizon.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 07:08:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxDdu-0003nJ-On
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 07:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127AbZDXFGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 01:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752926AbZDXFGS
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 01:06:18 -0400
Received: from science.horizon.com ([192.35.100.1]:41460 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752426AbZDXFGS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 01:06:18 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Apr 2009 01:06:12 EDT
Received: (qmail 7679 invoked by uid 1000); 24 Apr 2009 00:58:43 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117409>

Here's something I and my co-workers would like to achieve, but are not
too sure how to arrange.

I want to be committing to a feature branch, but always be compiling
and testing a merge of that branch and several others.  (Kind of like
linux-next.)  I want to be able to switch feature branches easily.

For example, I may have a background project that I'm working on slowly in
between short-term fixes.  Or I want to be running the latest kernel.org
kernel while my patches await approval.

If it's just my own projects, I can just commit in random order and
straighten things out later.  Although even that is problematic,
as I may not remember what line of development a cleanup patch is a
prerequisite for.  (This is something that darcs is apparently good at.)

But when I want to be testing something highly volatile like linux-next,
and ensuring that my work continues to merge with it cleanly, as well
as helping others with their branches, it becomes a daily pain.

The best attempt I have so far is to rebase a lot.  But that means that
I can't do any merging in my development branch lest the rebasing turn
into a mess.  And forcing everything to be linear makes changing branches
a pain.  And I can't share half-finished versions with co-workers.

This is all vaguely quilt-like, although I'd rather not worry about the
order of patches.  I suppose I'd like git to let me "commit under" the
final merge.  When I switch branches, git should reorganize the tree of
merges so that the current branch is only one merge from the HEAD.

(Another thing I've wished for that might be related is for a branch
to have a notion of its origin.  So I can rebase it onto an arbitrary
place in the commit tree without having to explicitly specify an origin.)

((Another really simple feature I keep wanting is "git commit -b
<newbranch>".  I should probably try to write a patch...))


Anyway, my feature ideas might be unworkable, and in any case, they'll
take a long time to implement.  Is there some easier way to achieve more
or less this effect?

Maybe the planned git-rebase improvements to handle merges better will
fix this, so I can just commit on top and periodically rebase the changes
under the head manually without too much pain?  (git rebase -i -p does
appear to be working better than I remember.)

H'm... in fact, it might be as easy as replacing "git pull" with
git rebase -p -i <last merge>^
(Delete the merge in the editor)
git pull <remote>

Annoying to remember, but not TOO bad.
