From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Document the --(no-)edit switch of git-revert and git-cherry-pick
Date: Sat, 26 Nov 2005 23:12:44 +0100
Message-ID: <20051126221244.5131.65509.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 26 23:13:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eg8Hc-0007Ht-58
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 23:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVKZWMa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 17:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVKZWM3
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 17:12:29 -0500
Received: from w241.dkm.cz ([62.24.88.241]:63426 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750763AbVKZWM3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Nov 2005 17:12:29 -0500
Received: (qmail 5155 invoked from network); 26 Nov 2005 23:12:44 +0100
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 26 Nov 2005 23:12:44 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12789>

This switch was not documented properly. I decided not to mention
the --no-edit switch in the git-cherry-pick documentation since
we always default to no editing.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-cherry-pick.txt |    6 +++++-
 Documentation/git-revert.txt      |   11 ++++++++++-
 git-revert.sh                     |    4 ++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 26e0467..5e0ef5a 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -7,7 +7,7 @@ git-cherry-pick - Apply the change intro
 
 SYNOPSIS
 --------
-'git-cherry-pick' [-n] [-r] <commit>
+'git-cherry-pick' [--edit] [-n] [-r] <commit>
 
 DESCRIPTION
 -----------
@@ -20,6 +20,10 @@ OPTIONS
 <commit>::
 	Commit to cherry-pick.
 
+--edit::
+	With this option, `git-cherry-pick` will let you edit the commit
+	message prior committing.
+
 -r::
 	Usually the command appends which commit was
 	cherry-picked after the original commit message when
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index feebd81..f471037 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -7,7 +7,7 @@ git-revert - Revert an existing commit.
 
 SYNOPSIS
 --------
-'git-revert' [-n] <commit>
+'git-revert' [--edit | --no-edit] [-n] <commit>
 
 DESCRIPTION
 -----------
@@ -20,6 +20,15 @@ OPTIONS
 <commit>::
 	Commit to revert.
 
+--edit::
+	With this option, `git-revert` will let you edit the commit
+	message prior committing the revert. This is the default if
+	you run the command from a terminal.
+
+--no-edit::
+	With this option, `git-revert` will not start the commit
+	message editor.
+
 -n::
 	Usually the command automatically creates a commit with
 	a commit log message stating which commit was reverted.
diff --git a/git-revert.sh b/git-revert.sh
index c1aebb1..5cb02b1 100755
--- a/git-revert.sh
+++ b/git-revert.sh
@@ -19,10 +19,10 @@ esac
 usage () {
 	case "$me" in
 	cherry-pick)
-		die "usage git $me [-n] [-r] <commit-ish>"
+		die "usage git $me [--edit] [-n] [-r] <commit-ish>"
 		;;
 	revert)
-		die "usage git $me [-n] <commit-ish>"
+		die "usage git $me [--edit | --no-edit] [-n] <commit-ish>"
 		;;
 	esac
 }
