From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: [PATCH] Trivial support for cloning and fetching via ftp://.
Date: Thu, 14 Sep 2006 05:24:04 +0300
Message-ID: <20060914022404.GA900@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 04:18:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNgo5-0003Nb-UU
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 04:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWINCSW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 22:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWINCSW
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 22:18:22 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:39911 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1750795AbWINCSW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 22:18:22 -0400
Received: from sashak ([172.25.5.107]) by taurus.voltaire.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 14 Sep 2006 05:18:20 +0300
Received: by sashak (sSMTP sendmail emulation); Thu, 14 Sep 2006 05:24:04 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 14 Sep 2006 02:18:20.0360 (UTC) FILETIME=[0C0FAC80:01C6D7A4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26974>

This adds trivial support for cloning and fetching via ftp://.

Signed-off-by: Sasha Khapyorsky <sashak@voltaire.com>
---
 git-clone.sh     |    2 +-
 git-fetch.sh     |    4 ++--
 git-ls-remote.sh |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 7060bda..e1b3bf3 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -298,7 +298,7 @@ yes,yes)
 		fi
 		git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
 		;;
-	https://*|http://*)
+	https://*|http://*|ftp://*)
 		if test -z "@@NO_CURL@@"
 		then
 			clone_dumb_http "$repo" "$D"
diff --git a/git-fetch.sh b/git-fetch.sh
index c2eebee..09a5d6c 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -286,7 +286,7 @@ fetch_main () {
 
       # There are transports that can fetch only one head at a time...
       case "$remote" in
-      http://* | https://*)
+      http://* | https://* | ftp://*)
 	  if [ -n "$GIT_SSL_NO_VERIFY" ]; then
 	      curl_extra_args="-k"
 	  fi
@@ -350,7 +350,7 @@ fetch_main () {
   done
 
   case "$remote" in
-  http://* | https://* | rsync://* )
+  http://* | https://* | ftp://* | rsync://* )
       ;; # we are already done.
   *)
     ( : subshell because we muck with IFS
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index 2fdcaf7..2c0b521 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -49,7 +49,7 @@ trap "rm -fr $tmp-*" 0 1 2 3 15
 tmpdir=$tmp-d
 
 case "$peek_repo" in
-http://* | https://* )
+http://* | https://* | ftp://* )
         if [ -n "$GIT_SSL_NO_VERIFY" ]; then
             curl_extra_args="-k"
         fi
-- 
1.4.2.gffe87-dirty
