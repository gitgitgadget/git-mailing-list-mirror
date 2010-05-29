From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCHv2] git-web--browse: Add support for google chrome and chromium
Date: Sun, 30 May 2010 00:06:51 +0530
Message-ID: <1275158211-13767-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Sat May 29 20:37:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIQuM-0003G2-5O
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 20:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841Ab0E2ShE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 May 2010 14:37:04 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:44194 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932Ab0E2ShB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 14:37:01 -0400
Received: by pxi18 with SMTP id 18so978451pxi.19
        for <git@vger.kernel.org>; Sat, 29 May 2010 11:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=0+aOpm364I+ErRRZvKAKZPTYlYe7Tjg8/6HPpff642I=;
        b=LllH9MeHdhHURau0BN+g6VCnflbD+JM8pDuIh+czQ9/OiiiIkJj/t33aka28QpUslk
         SvzWXTOnOBpsLTY2AD4z36iFEgX85yaq/c6gqOnAq9FtJp3cw62gNhSi09dNJbtXkhUs
         BADfhwqdbA2zyi/32zvyX9yoC1R6k4BV3/dK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=E1fXp26oQdCz+nYTxC3l1fQiJwGeidBSjP8hyAlZ3Zf62510A4FKkUNbB1ByQ0KVBs
         t2QOHL3OsIXZaufGubvWI9BNVz6Gm0FsndfgsoQ665BFSpJAZ9r12gjo8jNx9ru6+RSp
         wEDoy0G1ub8EEGuP9j9COpvg7/3kqJX9bVn7U=
Received: by 10.115.100.30 with SMTP id c30mr1682845wam.213.1275158219742;
        Sat, 29 May 2010 11:36:59 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.23])
        by mx.google.com with ESMTPS id f11sm31632280wai.23.2010.05.29.11.36.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 May 2010 11:36:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.20.g1e801.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147972>

Add support for google's chrome & chromium. The value of the
browser is 'chromium' or 'chrome' to select it.

You can always provide config variable for browser path if they
are not installed in right paths.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 git-web--browse.sh |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index a578c3a..dbded76 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -31,7 +31,7 @@ valid_custom_tool()
 
 valid_tool() {
 	case "$1" in
-		firefox | iceweasel | konqueror | w3m | links | lynx | dillo | open | start)
+		firefox | iceweasel | chrome | chromium | konqueror | w3m | links | lynx | dillo | open | start)
 			;; # happy
 		*)
 			valid_custom_tool "$1" || return 1
@@ -103,7 +103,7 @@ fi
 
 if test -z "$browser" ; then
     if test -n "$DISPLAY"; then
-	browser_candidates="firefox iceweasel konqueror w3m links lynx dillo"
+	browser_candidates="firefox iceweasel chrome chromium konqueror w3m links lynx dillo"
 	if test "$KDE_FULL_SESSION" = "true"; then
 	    browser_candidates="konqueror $browser_candidates"
 	fi
@@ -146,6 +146,11 @@ case "$browser" in
 	test "$vers" -lt 2 && NEWTAB=''
 	"$browser_path" $NEWTAB "$@" &
 	;;
+    chrome|chromium)
+	# Actual command for chromium is chromium-browser.
+	# No need to specify newTab. It's default in chromium
+	eval "$browser_path" "$@" &
+	;;
     konqueror)
 	case "$(basename "$browser_path")" in
 	    konqueror)
-- 
1.7.1.20.g1e801.dirty
