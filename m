From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: update documentation with CAVEATS section
Date: Thu, 16 Aug 2007 01:56:45 -0700
Message-ID: <20070816085645.GA3159@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 10:56:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILb9y-00073e-IZ
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 10:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436AbXHPI4u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 04:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754891AbXHPI4u
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 04:56:50 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35794 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753626AbXHPI4t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 04:56:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id EFF6D2DC08D;
	Thu, 16 Aug 2007 01:56:45 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55994>

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

  I've been meaning to do this for a while, hopefully this cuts
  down on the redundant mailing list traffic about these subjects.

 Documentation/git-svn.txt |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 816340b..fbc5887 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -479,6 +479,38 @@ the user on the git side.  git-svn does however follow copy
 history of the directory that it is tracking, however (much like
 how 'svn log' works).
 
+CAVEATS
+-------
+
+For the sake of simplicity and interoperating with a less-capable system
+(SVN), it is recommended that all git-svn users clone, fetch and dcommit
+directly from the SVN server, and avoid all git-clone/pull/merge/push
+operations between git repositories and branches.  The recommended
+method of exchanging code between git branches and users is
+git-format-patch and git-am, or just dcommiting to the SVN repository.
+
+Running 'git-merge' or 'git-pull' is NOT recommended on a branch you
+plan to dcommit from.  Subversion does not represent merges in any
+reasonable or useful fashion; so users using Subversion cannot see any
+merges you've made.  Furthermore, if you merge or pull from a git branch
+that is a mirror of an SVN branch, dcommit may commit to the wrong
+branch.
+
+'git-clone' does not clone branches under the refs/remotes/ hierarchy or
+any git-svn metadata, or config.  So repositories created and managed with
+using git-svn should use rsync(1) for cloning, if cloning is to be done
+at all.
+
+Since 'dcommit' uses rebase internally, any git branches you git-push to
+before dcommit on will require forcing an overwrite of the existing ref
+on the remote repository.  This is generally considered bad practice,
+see the git-push(1) documentation for details.
+
+Do not use the --amend option of git-commit(1) on a change you've
+already dcommitted.  It is considered bad practice to --amend commits
+you've already pushed to a remote repository for other users, and
+dcommit with SVN is analogous to that.
+
 BUGS
 ----
 
-- 
Eric Wong
