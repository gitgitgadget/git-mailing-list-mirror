From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 2/3] git-branch: Add -w option to adjust branchname column width
Date: Sun, 22 Oct 2006 00:33:23 +0200
Message-ID: <11614700063082-git-send-email-hjemli@gmail.com>
References: <1161470004894-git-send-email-hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 22 00:33:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbPPK-0003AE-4g
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 00:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422854AbWJUWda (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 18:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422862AbWJUWd3
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 18:33:29 -0400
Received: from mail48.e.nsc.no ([193.213.115.48]:6576 "EHLO mail48.e.nsc.no")
	by vger.kernel.org with ESMTP id S1422853AbWJUWd0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 18:33:26 -0400
Received: from localhost.localdomain (ti231210a080-7372.bb.online.no [80.213.28.208])
	by mail48.nsc.no (8.13.8/8.13.5) with ESMTP id k9LMXOmR026850
	for <git@vger.kernel.org>; Sun, 22 Oct 2006 00:33:25 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.3.1
In-Reply-To: <1161470004894-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29681>

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 git-branch.sh |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/git-branch.sh b/git-branch.sh
index 25abd4c..0d9eb06 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE='[-r] [-v] | (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>]'
+USAGE='[-r] [-v [-w <width>]] | (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>]'
 LONG_USAGE='If no arguments, show available branches and mark current branch with a star.
 If one argument, create a new branch <branchname> based off of current HEAD.
 If two arguments, create a new branch <branchname> based off of <start-point>.'
@@ -52,6 +52,7 @@ force=
 create_log=
 verbose=
 remotes=
+width=20
 
 ls_remote_branches () {
 	git-rev-parse --symbolic --all |
@@ -62,7 +63,7 @@ ls_remote_branches () {
 		if test "$verbose" = "yes"
 		then
 			log=$(git-log --max-count=1 --pretty=oneline $ref)
-			printf "%-20s %s\n" "$ref" "$log"
+			printf "%-*s %s\n" "$width" "$ref" "$log"
 		else
 			echo "$ref"
 		fi
@@ -83,7 +84,7 @@ ls_local_branches() {
 		if test "$verbose" = "yes"
 		then
 			log=$(git-log --max-count=1 --pretty=oneline $ref)
-			printf "%s %-20s %s\n" "$pfx" "$ref" "$log"
+			printf "%s %-*s %s\n" "$pfx" "$width" "$ref" "$log"
 		else
 			echo "$pfx $ref"
 		fi
@@ -108,6 +109,10 @@ do
 		;;
 	-v)
 		verbose="yes"
+		;;
+	-w)
+		shift
+		width="$1"
 		;;
 	--)
 		shift
-- 
1.4.3.1
