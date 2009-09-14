From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] web--browse: fix Mac OS X GUI detection for 10.6
Date: Mon, 14 Sep 2009 10:49:01 +0200
Message-ID: <20090914084901.GB29641@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 10:56:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mn7ME-0007xe-Gw
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 10:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276AbZINIzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 04:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755274AbZINIzk
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 04:55:40 -0400
Received: from darksea.de ([83.133.111.250]:56806 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755269AbZINIzk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 04:55:40 -0400
Received: (qmail 6428 invoked from network); 14 Sep 2009 10:49:01 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 14 Sep 2009 10:49:01 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128442>

Since OS X 10.6 the variable $SECURITYSESSIONID does not exist anymore,
so lets look for the $TERM_PROGRAM variable as backup.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 git-web--browse.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index 4f5c740..a578c3a 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -111,7 +111,8 @@ if test -z "$browser" ; then
 	browser_candidates="w3m links lynx"
     fi
     # SECURITYSESSIONID indicates an OS X GUI login session
-    if test -n "$SECURITYSESSIONID"; then
+    if test -n "$SECURITYSESSIONID" \
+	    -o "$TERM_PROGRAM" = "Apple_Terminal" ; then
 	browser_candidates="open $browser_candidates"
     fi
     # /bin/start indicates MinGW
-- 
1.6.5.rc1.dirty
