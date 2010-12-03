From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 5/7] web--browse: better support for chromium
Date: Fri,  3 Dec 2010 17:47:39 +0100
Message-ID: <1291394861-11989-6-git-send-email-giuseppe.bilotta@gmail.com>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 17:48:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POYoJ-0007II-3x
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 17:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423Ab0LCQsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 11:48:18 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47167 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098Ab0LCQsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 11:48:16 -0500
Received: by mail-ww0-f44.google.com with SMTP id 36so10251895wwa.1
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 08:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MEpF2CX5UFaxjL6RNw32CUUfpKY9V1VKiLBMGmYiy5M=;
        b=xQTPjoe1O/bXQPvuuRR6mfJXl2ADBMEn59jLTBdRLRlFmMgqqjFVLTlca3LMh4Mgez
         o90lrL4DZ77/cu6Kp4ICO4mBPTHVZ1BgKYzm7g8tkhxNSRa7nsOjCcOyfx4FPeergj5K
         /v7jSGy7kzdNCkEuvzrYI6jzpsOgDrlK2EKPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hboaAFlx0qVFekhqRwIqhpK6W9XvhZH0pYkZM5QMLGe3Jw6qmM/K9hjrKsHSBCS/ML
         yFS/go6C2TrmPu3i5f53DJJ9kVM2n9gpYLFpd5sDKXsNQ86C9LBMI0hurFUgM6wp5wL3
         XOobrU55iTEi7bt06ferENPTyN5KPjk2wsla0=
Received: by 10.216.4.2 with SMTP id 2mr2161145wei.87.1291394894997;
        Fri, 03 Dec 2010 08:48:14 -0800 (PST)
Received: from localhost (nat.ct.ingv.it [193.206.223.100])
        by mx.google.com with ESMTPS id 7sm976364wet.0.2010.12.03.08.48.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 08:48:14 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.664.g294b8.dirty
In-Reply-To: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162811>

On Debian-based distributions, Chromium the browser is available under
the name chromium-browser rather than chromium, to prevent conflicts
with the Chromium B.S.U. game.

Look for chromium-browser first when setting the path for chromium, and
also add chromium-browser as a supported browser name. Document the
dual-name support, and mention the dual-name support for
(google-)chrome too.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Documentation/git-web--browse.txt |    4 ++--
 git-web--browse.sh                |   11 +++++++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 5d3ae07..c0416e5 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -22,8 +22,8 @@ The following browsers (or commands) are currently supported:
 * iceweasel
 * seamonkey
 * iceape
-* chromium
-* google-chrome
+* chromium (also supported as chromium-browser)
+* google-chrome (also supported as chrome)
 * konqueror (this is the default under KDE, see 'Note about konqueror' below)
 * opera
 * w3m (this is the default outside graphical environments)
diff --git a/git-web--browse.sh b/git-web--browse.sh
index 48e5a28..d0e99f5 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -31,7 +31,8 @@ valid_custom_tool()
 
 valid_tool() {
 	case "$1" in
-	firefox | iceweasel | seamonkey | iceape | chrome | google-chrome | chromium |\
+	firefox | iceweasel | seamonkey | iceape |\
+	chrome | google-chrome | chromium | chromium-browser |\
 	konqueror | opera | w3m | elinks | links | lynx | dillo | open | start)
 		;; # happy
 	*)
@@ -42,6 +43,9 @@ valid_tool() {
 
 init_browser_path() {
 	browser_path=$(git config "browser.$1.path")
+	if test -z "$browser_path" -a "$1" = chromium ; then
+		type chromium-browser > /dev/null 2>&1 && browser_path=chromium-browser
+	fi
 	test -z "$browser_path" && browser_path="$1"
 }
 
@@ -104,7 +108,7 @@ fi
 
 if test -z "$browser" ; then
 	if test -n "$DISPLAY"; then
-		browser_candidates="firefox iceweasel google-chrome chrome chromium konqueror opera seamonkey iceape w3m elinks links lynx dillo"
+		browser_candidates="firefox iceweasel google-chrome chrome chromium chromium-browser konqueror opera seamonkey iceape w3m elinks links lynx dillo"
 		if test "$KDE_FULL_SESSION" = "true"; then
 			browser_candidates="konqueror $browser_candidates"
 		fi
@@ -147,8 +151,7 @@ firefox|iceweasel|seamonkey|iceape)
 	test "$vers" -lt 2 && NEWTAB=''
 	"$browser_path" $NEWTAB "$@" &
 	;;
-google-chrome|chrome|chromium)
-	# Actual command for chromium is chromium-browser.
+google-chrome|chrome|chromium|chromium-browser)
 	# No need to specify newTab. It's default in chromium
 	eval "$browser_path" "$@" &
 	;;
-- 
1.7.3.2.664.g294b8.dirty
