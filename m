From: Aurelien Bompard <aurelien@bompard.org>
Subject: [PATCH] honor the http.sslVerify option in shell scripts
Date: Sun, 28 Oct 2007 18:47:30 +0100
Message-ID: <200710281847.30580.aurelien@bompard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Oct 28 18:54:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImCLG-0001dN-NJ
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 18:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbXJ1RyR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Oct 2007 13:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbXJ1RyR
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 13:54:17 -0400
Received: from vitry.propolys.com ([195.154.193.97]:36709 "EHLO
	vitry.propolys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbXJ1RyQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Oct 2007 13:54:16 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Oct 2007 13:54:16 EDT
Received: (qmail 330 invoked from network); 28 Oct 2007 17:47:37 -0000
Received: from unknown (HELO gauret.homelinux.net) (abompard@88.161.125.228)
  by vitry2.propolys.com with (RC4-SHA encrypted) SMTP; 28 Oct 2007 17:47:37 -0000
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62586>

Signed-off-by: Aur=E9lien Bompard <aurelien@bompard.org>
---
 git-clone.sh     |    3 ++-
 git-ls-remote.sh |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 5e582fe..3bb683d 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -28,7 +28,8 @@ get_repo_base() {
        ) 2>/dev/null
 }

-if [ -n "$GIT_SSL_NO_VERIFY" ]; then
+if [ -n "$GIT_SSL_NO_VERIFY" -o \
+    "`git config --bool http.sslVerify`" =3D false ]; then
     curl_extra_args=3D"-k"
 fi

diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index d56cf92..3eb18d1 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -54,7 +54,8 @@ tmpdir=3D$tmp-d

 case "$peek_repo" in
 http://* | https://* | ftp://* )
-        if [ -n "$GIT_SSL_NO_VERIFY" ]; then
+        if [ -n "$GIT_SSL_NO_VERIFY" -o \
+            "`git config --bool http.sslVerify`" =3D false ]; then
             curl_extra_args=3D"-k"
         fi
        if [ -n "$GIT_CURL_FTP_NO_EPSV" -o \
--
1.5.3.3
