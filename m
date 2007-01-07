From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] Documentation/git-svn: clarify dcommit, rebase vs pull/merge
Date: Sat, 6 Jan 2007 17:53:40 -0800
Message-ID: <20070107015340.GA18322@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 02:53:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3NEH-0001R8-Lv
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 02:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbXAGBxn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 20:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbXAGBxn
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 20:53:43 -0500
Received: from hand.yhbt.net ([66.150.188.102]:33663 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932311AbXAGBxm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 20:53:42 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id CEC247DC094;
	Sat,  6 Jan 2007 17:53:40 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 06 Jan 2007 17:53:40 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36116>

Clarify that dcommit creates a revision in SVN for every commit
in git.  Also, add 'merge' to the rebase vs pull section because
git-merge is now a first-class UI.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |   33 ++++++++++++++++++---------------
 1 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index f754d2f..ce63def 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -53,11 +53,13 @@ See '<<fetch-args,Additional Fetch Arguments>>' if you are interested in
 manually joining branches on commit.
 
 'dcommit'::
-	Commit all diffs from a specified head directly to the SVN
+	Commit each diff from a specified head directly to the SVN
 	repository, and then rebase or reset (depending on whether or
-	not there is a diff between SVN and head).  It is recommended
-	that you run git-svn fetch and rebase (not pull) your commits
-	against the latest changes in the SVN repository.
+	not there is a diff between SVN and head).  This will create
+	a revision in SVN for each commit in git.
+	It is recommended that you run git-svn fetch and rebase (not
+	pull or merge) your commits against the latest changes in the
+	SVN repository.
 	An optional command-line argument may be specified as an
 	alternative to HEAD.
 	This is advantageous over 'set-tree' (below) because it produces
@@ -408,19 +410,20 @@ See also:
 	git-svn multi-init
 ------------------------------------------------------------------------
 
-REBASE VS. PULL
----------------
+REBASE VS. PULL/MERGE
+---------------------
 
 Originally, git-svn recommended that the remotes/git-svn branch be
-pulled from.  This is because the author favored 'git-svn set-tree B'
-to commit a single head rather than the 'git-svn set-tree A..B' notation
-to commit multiple commits.
-
-If you use 'git-svn set-tree A..B' to commit several diffs and you do not
-have the latest remotes/git-svn merged into my-branch, you should use
-'git rebase' to update your work branch instead of 'git pull'.  'pull'
-can cause non-linear history to be flattened when committing into SVN,
-which can lead to merge commits reversing previous commits in SVN.
+pulled or merged from.  This is because the author favored
+'git-svn set-tree B' to commit a single head rather than the
+'git-svn set-tree A..B' notation to commit multiple commits.
+
+If you use 'git-svn set-tree A..B' to commit several diffs and you do
+not have the latest remotes/git-svn merged into my-branch, you should
+use 'git rebase' to update your work branch instead of 'git pull' or
+'git merge'.  'pull/merge' can cause non-linear history to be flattened
+when committing into SVN, which can lead to merge commits reversing
+previous commits in SVN.
 
 DESIGN PHILOSOPHY
 -----------------

-- 
Eric Wong
