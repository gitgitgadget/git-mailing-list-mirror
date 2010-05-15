From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH 3/3] git-web--browse: Add support for google chrome
Date: Sun, 16 May 2010 01:28:40 +0530
Message-ID: <1273953520-25990-3-git-send-email-pavan.sss1991@gmail.com>
References: <1273953520-25990-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 21:59:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODNWW-0003WH-Co
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 21:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492Ab0EOT7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 15:59:43 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:45900 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032Ab0EOT7n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 15:59:43 -0400
Received: by pxi5 with SMTP id 5so1907345pxi.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 12:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=CzWK5jx+2bwe/LBN8JdE1GhM6qEw8w/r/wGk2gSXEV4=;
        b=Wg6SKhWusG1GMnzx7/ijVKSUjyU+4HS0Q10kH/xY7iX0GdU78PEIiQB0U7NHSucaki
         mHCT/MrGKLrJIsJsu5gVGmornEjtuO01yDqvjKLDbufq2wGXn4O2hfBv4rMA40aweggB
         aGoJczA0CBa9SwodEThKutJrJ8THLSeK4uMcc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pjT2sluNu53eaBQAsnbz/oiuBqyDIOH/Dj5B7WvJy4Bk4DHyWPY6OWOrBWJuJgTrhv
         4BPr+ylb2yaKItQKHHwr6FrRfkgC5QkgDSSbtuSa+9rB0Nu39H2nUexn/9PWFusEjGQP
         R2DsvFrmx1rpdLFu5HmHo1G1GmKN8rokmxHvk=
Received: by 10.114.86.3 with SMTP id j3mr2518786wab.152.1273953581362;
        Sat, 15 May 2010 12:59:41 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.23])
        by mx.google.com with ESMTPS id v13sm32432688wav.14.2010.05.15.12.59.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 12:59:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.16.g5d405c.dirty
In-Reply-To: <1273953520-25990-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147162>

Add support for another web browser called chrome. To
select it, the value of the browser should be 'chromium'.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 git-web--browse.sh |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index a578c3a..72dde3b 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -31,7 +31,7 @@ valid_custom_tool()
 
 valid_tool() {
 	case "$1" in
-		firefox | iceweasel | konqueror | w3m | links | lynx | dillo | open | start)
+		firefox | iceweasel | chromium | konqueror | w3m | links | lynx | dillo | open | start)
 			;; # happy
 		*)
 			valid_custom_tool "$1" || return 1
@@ -103,7 +103,7 @@ fi
 
 if test -z "$browser" ; then
     if test -n "$DISPLAY"; then
-	browser_candidates="firefox iceweasel konqueror w3m links lynx dillo"
+	browser_candidates="firefox iceweasel chromium konqueror w3m links lynx dillo"
 	if test "$KDE_FULL_SESSION" = "true"; then
 	    browser_candidates="konqueror $browser_candidates"
 	fi
@@ -146,6 +146,11 @@ case "$browser" in
 	test "$vers" -lt 2 && NEWTAB=''
 	"$browser_path" $NEWTAB "$@" &
 	;;
+    chromium)
+	# Actual command for chromium is chromium-browser.
+	# No need to specify newTab. It's default in chromium
+	eval "$browser_path-browser" "$@" &
+	;;
     konqueror)
 	case "$(basename "$browser_path")" in
 	    konqueror)
-- 
1.7.1.16.g5d405c.dirty
