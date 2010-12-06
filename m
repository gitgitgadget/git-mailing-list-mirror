From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 3/6] web--browse: support opera, seamonkey and elinks
Date: Mon,  6 Dec 2010 18:49:47 +0100
Message-ID: <1291657790-3719-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1291657790-3719-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 06 18:50:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPfCt-00066z-Iw
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 18:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201Ab0LFRuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 12:50:11 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35320 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191Ab0LFRuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 12:50:09 -0500
Received: by mail-wy0-f174.google.com with SMTP id 28so12273585wyb.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 09:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qjglzPYQPYXo39l0nG9KawzveHT1OvBM5+z11pubsic=;
        b=hEeAdWuI0SQtgg+Rx4rcTew46eNLts8EVehos8WagxNqIaUA9VZbNLWhjRZKdTzbOJ
         nvS0ZYeviDDlvUJW8AujqfZLaCZmK/mnn4YzzKauvPd6654QBRMawJNjnqpt/49AXTp/
         3cq9Int0zhdr8SeSaW9KwyROcn2V6+QyohIes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aoocl2Yf0y68EznLgFGXWPn322LzSYjwBJWPZQDiZLDICtFk3wtnu5Jh79vs20IM51
         aOrb0G1TU6chNwfTIf2SeXp603HQl7PKDoOf0xNa+frTffeetFXT05QhgwQVU4dRgjwJ
         8INehEmqPj3cIvTHz17sNxEPsqMo6I7wI3xHs=
Received: by 10.227.151.209 with SMTP id d17mr5935679wbw.220.1291657808502;
        Mon, 06 Dec 2010 09:50:08 -0800 (PST)
Received: from localhost ([151.60.176.40])
        by mx.google.com with ESMTPS id x3sm2481988wes.46.2010.12.06.09.50.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 09:50:07 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.664.g294b8.dirty
In-Reply-To: <1291657790-3719-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163008>

The list of supported browsers is also updated in the documentation.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Documentation/git-web--browse.txt |    6 ++++++
 git-web--browse.sh                |   14 +++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 51e8e0a..5d3ae07 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -20,8 +20,14 @@ The following browsers (or commands) are currently supported:
 
 * firefox (this is the default under X Window when not using KDE)
 * iceweasel
+* seamonkey
+* iceape
+* chromium
+* google-chrome
 * konqueror (this is the default under KDE, see 'Note about konqueror' below)
+* opera
 * w3m (this is the default outside graphical environments)
+* elinks
 * links
 * lynx
 * dillo
diff --git a/git-web--browse.sh b/git-web--browse.sh
index e48e30d..48e5a28 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -31,8 +31,8 @@ valid_custom_tool()
 
 valid_tool() {
 	case "$1" in
-	firefox | iceweasel | chrome | google-chrome | chromium |\
-	konqueror | w3m | links | lynx | dillo | open | start)
+	firefox | iceweasel | seamonkey | iceape | chrome | google-chrome | chromium |\
+	konqueror | opera | w3m | elinks | links | lynx | dillo | open | start)
 		;; # happy
 	*)
 		valid_custom_tool "$1" || return 1
@@ -104,12 +104,12 @@ fi
 
 if test -z "$browser" ; then
 	if test -n "$DISPLAY"; then
-		browser_candidates="firefox iceweasel google-chrome chrome chromium konqueror w3m links lynx dillo"
+		browser_candidates="firefox iceweasel google-chrome chrome chromium konqueror opera seamonkey iceape w3m elinks links lynx dillo"
 		if test "$KDE_FULL_SESSION" = "true"; then
 			browser_candidates="konqueror $browser_candidates"
 		fi
 	else
-		browser_candidates="w3m links lynx"
+		browser_candidates="w3m elinks links lynx"
 	fi
 	# SECURITYSESSIONID indicates an OS X GUI login session
 	if test -n "$SECURITYSESSIONID" \
@@ -140,7 +140,7 @@ else
 fi
 
 case "$browser" in
-firefox|iceweasel)
+firefox|iceweasel|seamonkey|iceape)
 	# Check version because firefox < 2.0 does not support "-new-tab".
 	vers=$(expr "$($browser_path -version)" : '.* \([0-9][0-9]*\)\..*')
 	NEWTAB='-new-tab'
@@ -168,13 +168,13 @@ konqueror)
 		;;
 	esac
 	;;
-w3m|links|lynx|open)
+w3m|elinks|links|lynx|open)
 	eval "$browser_path" "$@"
 	;;
 start)
 	exec "$browser_path" '"web-browse"' "$@"
 	;;
-dillo)
+opera|dillo)
 	"$browser_path" "$@" &
 	;;
 *)
-- 
1.7.3.2.664.g294b8.dirty
