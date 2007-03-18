From: James Bowes <jbowes@dangerouslyinc.com>
Subject: [PATCH] mergetool: Add support for vimdiff.
Date: Sun, 18 Mar 2007 18:28:46 -0400
Message-ID: <11742569263141-git-send-email-jbowes@dangerouslyinc.com>
Cc: junkio@cox.net, tytso@mit.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 23:29:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT3sz-0000TR-IW
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 23:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbXCRW3m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 18:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933024AbXCRW3m
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 18:29:42 -0400
Received: from ms-smtp-04.southeast.rr.com ([24.25.9.103]:52327 "EHLO
	ms-smtp-04.southeast.rr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932103AbXCRW3l (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Mar 2007 18:29:41 -0400
Received: from localhost (cpe-066-057-086-146.nc.res.rr.com [66.57.86.146])
	by ms-smtp-04.southeast.rr.com (8.13.6/8.13.6) with ESMTP id l2IMTc9O008733;
	Sun, 18 Mar 2007 18:29:39 -0400 (EDT)
X-Mailer: git-send-email 1.5.0.3
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42538>

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---
 git-mergetool.sh |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 52386a5..563c5c0 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -185,9 +185,9 @@ merge_file () {
 		mv -- "$BACKUP" "$path.orig"
 	    fi
 	    ;;
-	meld)
+	meld|vimdiff)
 	    touch "$BACKUP"
-	    meld -- "$LOCAL" "$path" "$REMOTE"
+	    $merge_tool -- "$LOCAL" "$path" "$REMOTE"
 	    if test "$path" -nt "$BACKUP" ; then
 		status=0;
 	    else
@@ -305,6 +305,8 @@ if test -z "$merge_tool" ; then
 	merge_tool=meld
     elif type emacs >/dev/null 2>&1; then
 	merge_tool=emerge
+    elif type vimdiff >/dev/null 2>&1; then
+	merge_tool=vimdiff
     else
 	echo "No available merge resolution programs available."
 	exit 1
@@ -312,7 +314,7 @@ if test -z "$merge_tool" ; then
 fi
 
 case "$merge_tool" in
-    kdiff3|tkdiff|meld|xxdiff)
+    kdiff3|tkdiff|meld|xxdiff|vimdiff)
 	if ! type "$merge_tool" > /dev/null 2>&1; then
 	    echo "The merge tool $merge_tool is not available"
 	    exit 1
-- 
1.5.0.3
