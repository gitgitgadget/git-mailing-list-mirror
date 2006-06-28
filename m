From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/2] rebase: get rid of outdated MRESOLVEMSG
Date: Wed, 28 Jun 2006 02:11:06 -0700
Message-ID: <11514858673382-git-send-email-normalperson@yhbt.net>
References: <11514858662929-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jun 28 11:11:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvW4m-00028J-UA
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 11:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423235AbWF1JLK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 05:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423231AbWF1JLK
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 05:11:10 -0400
Received: from hand.yhbt.net ([66.150.188.102]:26329 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1030487AbWF1JLJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 05:11:09 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 8E7F67DC024;
	Wed, 28 Jun 2006 02:11:07 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 28 Jun 2006 02:11:07 -0700
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.rc1.g3cc8
In-Reply-To: <11514858662929-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22784>

There was a time when rebase --skip didn't work when used with
--merge, but that is no more so we don't need that message
anymore.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-rebase.sh |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 47c8e8f..16fe6e0 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -34,11 +34,6 @@ When you have resolved this problem run 
 If you would prefer to skip this patch, instead run \"git rebase --skip\".
 To restore the original branch and stop rebasing run \"git rebase --abort\".
 "
-
-MRESOLVEMSG="
-When you have resolved this problem run \"git rebase --continue\".
-To restore the original branch and stop rebasing run \"git rebase --abort\".
-"
 unset newbase
 strategy=recursive
 do_merge=
@@ -54,7 +49,7 @@ continue_merge () {
 	then
 		echo "You still have unmerged paths in your index"
 		echo "did you forget update-index?"
-		die "$MRESOLVEMSG"
+		die "$RESOLVEMSG"
 	fi
 
 	if test -n "`git-diff-index HEAD`"
@@ -87,11 +82,11 @@ call_merge () {
 		;;
 	1)
 		test -d "$GIT_DIR/rr-cache" && git-rerere
-		die "$MRESOLVEMSG"
+		die "$RESOLVEMSG"
 		;;
 	2)
 		echo "Strategy: $rv $strategy failed, try another" 1>&2
-		die "$MRESOLVEMSG"
+		die "$RESOLVEMSG"
 		;;
 	*)
 		die "Unknown exit code ($rv) from command:" \
-- 
1.4.1.rc1.g3cc8
