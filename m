From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Make 'make' quiet by default
Date: Tue, 6 Mar 2007 02:09:14 -0500
Message-ID: <20070306070914.GA24477@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 08:09:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOTnW-0006Oz-Kd
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 08:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965829AbXCFHJT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 02:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965830AbXCFHJT
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 02:09:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45337 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965829AbXCFHJS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 02:09:18 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOTnQ-0006sP-0y; Tue, 06 Mar 2007 02:09:16 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D2DF020FBAE; Tue,  6 Mar 2007 02:09:14 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41548>

Per Junio's suggestion we are setting 'make' to be quiet by default,
with `make V=1` available to force GNU make back to its default
behavior of showing each command it is running.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 On top of my prior patch.

 Makefile           |    6 +++---
 perl/Makefile      |    2 +-
 templates/Makefile |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 66ab992..72d4291 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # The default target of this Makefile is...
 all::
 
-# Define QUIET_MAKE to have a less verbose compile.
+# Define V=1 to have a more verbose compile.
 #
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 # This also implies MOZILLA_SHA1.
@@ -604,7 +604,7 @@ endif
 ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif
-ifdef QUIET_MAKE
+ifndef V
 	QUIET_CC       = @echo '   ' CC $<;
 	QUIET_AR       = @echo '   ' AR $@;
 	QUIET_LINK     = @echo '   ' LINK $@;
@@ -612,7 +612,7 @@ ifdef QUIET_MAKE
 	QUIET_GEN      = @echo '   ' GEN $@;
 	QUIET_SUBDIR0  = @subdir=
 	QUIET_SUBDIR1  = ;echo '   ' SUBDIR $$subdir; $(MAKE) -C$$subdir
-	export QUIET_MAKE
+	export V
 else
 	QUIET_SUBDIR0  = $(MAKE) -C
 	QUIET_SUBDIR1  =
diff --git a/perl/Makefile b/perl/Makefile
index 2fceff2..17d004e 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -6,7 +6,7 @@ makfile:=perl.mak
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 prefix_SQ = $(subst ','\'',$(prefix))
 
-ifdef QUIET_MAKE
+ifndef V
 	QUIET = @
 endif
 
diff --git a/templates/Makefile b/templates/Makefile
index 81bd86c..b8352e7 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -1,6 +1,6 @@
 # make and install sample templates
 
-ifdef QUIET_MAKE
+ifndef V
 	QUIET = @
 endif
 
-- 
1.5.0.3.863.gf0989
