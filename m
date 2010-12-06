From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 4/6] web--browse: better support for chromium
Date: Mon,  6 Dec 2010 18:49:48 +0100
Message-ID: <1291657790-3719-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1291657790-3719-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 06 18:50:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPfCu-00066z-3m
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 18:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214Ab0LFRuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 12:50:17 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35320 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab0LFRuO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 12:50:14 -0500
Received: by mail-wy0-f174.google.com with SMTP id 28so12273585wyb.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 09:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cN0fT2NEF6KS4uzxpPt2zZl+jgmRg8gXmBxBzuMS7ds=;
        b=Yf0V/9kdCO5+/ldkE2rlxCfUbfJOzZtGMZ7Y/50AEpCCVs76OjsBGodiIq/K2LFksD
         r/jpItom7uq47KWCk9YdhtdQuGbVKrpGvAO8vnfCHrhY4hPxyv5YlUUeEOiwON95KtVy
         Fyi+djzEYcj45KptjTHT4eIb5j9InVMUHp3JE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WMk0isOTNMLtqBBQe6xi7CALHbUpWk1pByHadf0hONdZ6FWZOYU+UONFm4fjw9ykrF
         s/ExmdU4IeLTAkpyIv+gxj4+ittPbP1if55dscxLL250o+Eoy/VS5LYPbDlgGBJBRogi
         341UCI24srF3TwtGu7Xbrj7rhq0lM5SsNgj3U=
Received: by 10.227.146.149 with SMTP id h21mr6035247wbv.139.1291657813500;
        Mon, 06 Dec 2010 09:50:13 -0800 (PST)
Received: from localhost ([151.60.176.40])
        by mx.google.com with ESMTPS id m10sm3610316wbc.10.2010.12.06.09.50.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 09:50:12 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.664.g294b8.dirty
In-Reply-To: <1291657790-3719-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163006>

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
 git-web--browse.sh                |   12 ++++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

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
index 48e5a28..b2fc3b4 100755
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
@@ -42,6 +43,10 @@ valid_tool() {
 
 init_browser_path() {
 	browser_path=$(git config "browser.$1.path")
+	if test -z "$browser_path" -a "$1" = chromium &&
+	   type chromium-browser > /dev/null 2>&1 ; then
+		browser_path=chromium-browser
+	fi
 	test -z "$browser_path" && browser_path="$1"
 }
 
@@ -104,7 +109,7 @@ fi
 
 if test -z "$browser" ; then
 	if test -n "$DISPLAY"; then
-		browser_candidates="firefox iceweasel google-chrome chrome chromium konqueror opera seamonkey iceape w3m elinks links lynx dillo"
+		browser_candidates="firefox iceweasel google-chrome chrome chromium chromium-browser konqueror opera seamonkey iceape w3m elinks links lynx dillo"
 		if test "$KDE_FULL_SESSION" = "true"; then
 			browser_candidates="konqueror $browser_candidates"
 		fi
@@ -147,8 +152,7 @@ firefox|iceweasel|seamonkey|iceape)
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
