From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] git-clone: quote destination directory name
Date: Fri, 11 Nov 2005 00:19:04 -0500
Message-ID: <1131686344.31172.24.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 11 06:22:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaRKA-00011C-7i
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 06:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVKKFTI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 00:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbVKKFTI
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 00:19:08 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:39363 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932361AbVKKFTG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 00:19:06 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EaRJZ-0006p8-VF
	for git@vger.kernel.org; Fri, 11 Nov 2005 00:19:06 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EaRJZ-0001AU-18
	for git@vger.kernel.org; Fri, 11 Nov 2005 00:19:05 -0500
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11558>

git-clone doesn't quote the full path to the destination directory,
which causes it to fail if the path contains spaces or other characters
interpreted by the shell.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/git-clone.sh b/git-clone.sh
index 4fdd652..0f37dff 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -163,7 +163,7 @@ yes,yes)
 			rm -f "$D/.git/TMP_ALT"
 		if test -f "$D/.git/TMP_ALT"
 		then
-		    ( cd $D &&
+		    ( cd "$D" &&
 		      . git-parse-remote &&
 		      resolve_alternates "$repo" <"./.git/TMP_ALT" ) |
 		    while read alt
@@ -191,7 +191,7 @@ yes,yes)
 	;;
 esac
 
-cd $D || exit
+cd "$D" || exit
 
 if test -f ".git/HEAD"
 then


-- 
Regards,
Pavel Roskin
