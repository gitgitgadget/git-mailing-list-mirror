From: Mark Hollomon <markhollomon@comcast.net>
Subject: [PATCH] Let merge set the default strategy.
Date: Wed, 15 Mar 2006 22:51:41 +0000 (UTC)
Message-ID: <1142463103-6986-markhollomon@comcast.net>
Cc: Johannes.Schindelin@gmx.de, markhollomon@comcast.net
X-From: git-owner@vger.kernel.org Wed Mar 15 23:51:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJepz-0000ND-Vq
	for gcvg-git@gmane.org; Wed, 15 Mar 2006 23:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbWCOWvY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Mar 2006 17:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWCOWvY
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Mar 2006 17:51:24 -0500
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:62368 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932549AbWCOWvX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Mar 2006 17:51:23 -0500
Received: from [10.0.0.3] (c-69-249-27-188.hsd1.de.comcast.net[69.249.27.188])
          by comcast.net (rwcrmhc11) with SMTP
          id <20060315225122m1100c3npte>; Wed, 15 Mar 2006 22:51:22 +0000
Date: Wed, Mar 15 17:51:43 2006 -0500
To: git@vger.kernel.org
User-Agent: send_patch 0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17620>

If the user does not set a merge strategy for git-pull,
let git-merge calculate a default strategy.

This may be preferable to the earlier patch involving
NO_PYTHON.

Signed-off-by: Mark Hollomon <markhollomon@comcast.net>


---

 git-pull.sh |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

54e2c920b8ad979bc75d25ae73300be6077f46a0
diff --git a/git-pull.sh b/git-pull.sh
index 6caf1aa..7764b70 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -71,19 +71,15 @@ case "$merge_head" in
 	;;
 ?*' '?*)
 	var=`git repo-config --get pull.octopus`
-	if test '' = "$var"
+	if test '' != "$var"
 	then
-		strategy_default_args='-s octopus'
-	else
 		strategy_default_args="-s $var"
 	fi
 	;;
 *)
 	var=`git repo-config --get pull.twohead`
-	if test '' = "$var"
-	then
-		strategy_default_args='-s recursive'
-	else
+	if test '' != "$var"
+        then
 		strategy_default_args="-s $var"
 	fi
 	;;
-- 
1.2.4.gea75
