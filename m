From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 4/6] web--browse: support opera, seamonkey and elinks
Date: Mon, 29 Nov 2010 15:47:53 +0100
Message-ID: <1291042075-19983-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 29 15:48:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN51o-00088I-M6
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 15:48:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471Ab0K2OsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 09:48:22 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36690 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab0K2OsV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 09:48:21 -0500
Received: by ewy5 with SMTP id 5so1966782ewy.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 06:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QmvNICS8nAF7gE4zLCv4Ez5eK1qWdrrlXla4mP6zrjU=;
        b=fwQDjU9ZnppTQOVnap678LjgajoVbM4fQHlskd+7O90jBVyOBZoC3QrDuvnsRG7GYL
         bOunuf/vgK7KbtJpIcTpLmpd1LXA1eP5W679ZIyE65WJ26w305GLuauizjqeFTR2pY+K
         16jGwrpWrvvGM7QmHBE5a+Ph88oEvfpGfD7cw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=F8AO1UL1RDwoa6A6rYOXnYbD5Aj44xxrwFuqloaVmbw5gUtjANB1VNR24rEJZ+l4O5
         Vc5oaoFxbvWCrVb7sQHlUW6PWl0uCRnQwK5JI7kuc3nfUS+vZOqqkd7HanupBk8nviR6
         NUz/IbVyIn7dTo3wW6Kk8Jjw7IjXdeucEPz9k=
Received: by 10.216.16.211 with SMTP id h61mr4741949weh.106.1291042100217;
        Mon, 29 Nov 2010 06:48:20 -0800 (PST)
Received: from localhost (nat.ct.ingv.it [193.206.223.100])
        by mx.google.com with ESMTPS id p4sm2427585wer.5.2010.11.29.06.48.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 06:48:19 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.624.gec6c7.dirty
In-Reply-To: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162391>

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
index b20b0e0..7b7f45f 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -31,8 +31,8 @@ valid_custom_tool()
 
 valid_tool() {
 	case "$1" in
-	firefox|iceweasel|chrome|google-chrome|chromium\
-	|konqueror|w3m|links|lynx|dillo|open|start)
+	firefox|iceweasel|seamonkey|iceape|chrome|google-chrome|chromium\
+	|konqueror|opera|w3m|elinks|links|lynx|dillo|open|start)
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
1.7.3.2.624.gec6c7.dirty
