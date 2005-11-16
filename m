From: exon@op5.se (Andreas Ericsson)
Subject: [PATCH] git-commit: Having $GIT_COMMITTER_NAME implies -s
Date: Thu, 17 Nov 2005 00:38:29 +0100 (CET)
Message-ID: <20051116233829.0B3C55BA81@nox.op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 17 00:45:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcWwo-0001uk-On
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 00:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030564AbVKPXoI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 18:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbVKPXoI
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 18:44:08 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:60370 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030564AbVKPXoG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 18:44:06 -0500
Received: from nox.op5.se (1-2-9-7b.gkp.gbg.bostream.se [82.182.116.45])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 3A19B6BD03
	for <git@vger.kernel.org>; Thu, 17 Nov 2005 00:44:05 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 0B3C55BA81; Thu, 17 Nov 2005 00:38:29 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12072>


I've been trying, in vain, to tell my colleagues to use the -s flag.
With this patch I can at least fix up their .profile's myself.

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 git-commit.sh |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

applies-to: a2fe76123d6f5b835d3312a70a02ed4d07e25f8e
d32c78570e25a9718721937b1ee9051e950ad1fd
diff --git a/git-commit.sh b/git-commit.sh
index 41955e8..ff9502c 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -134,8 +134,7 @@ then
 	cat "$GIT_DIR/MERGE_MSG"
 fi | git-stripspace >"$GIT_DIR"/COMMIT_EDITMSG
 
-case "$signoff" in
-t)
+if [ "$signoff" = t -o "$GIT_COMMITTER_NAME" ]; then
 	{
 		echo
 		git-var GIT_COMMITTER_IDENT | sed -e '
@@ -143,8 +142,7 @@ t)
 			s/^/Signed-off-by: /
 		'
 	} >>"$GIT_DIR"/COMMIT_EDITMSG
-	;;
-esac
+fi
 
 if [ -f "$GIT_DIR/MERGE_HEAD" ]; then
 	echo "#"
---
0.99.9.GIT
