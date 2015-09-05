From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] Makefile: fix MAKEFLAGS tests with multiple flags
Date: Sat,  5 Sep 2015 13:22:10 +0100
Message-ID: <5c25f77717582a8f38a089da343b4cd2d6af345d.1441455709.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 14:22:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYCTz-0001jk-3D
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 14:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbbIEMWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 08:22:07 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:43484 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbbIEMWF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 08:22:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id DF480CDA609;
	Sat,  5 Sep 2015 13:22:03 +0100 (BST)
X-Quarantine-ID: <EJsOkwFbuRFK>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EJsOkwFbuRFK; Sat,  5 Sep 2015 13:22:02 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id EFB54CDA510;
	Sat,  5 Sep 2015 13:21:56 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277367>

findstring is defined as $(findstring FIND,IN) so if multiple flags are
set these tests do the wrong thing unless $(MAKEFLAGS) is the second
argument.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 34101e2..a556be6 100644
--- a/Makefile
+++ b/Makefile
@@ -1463,13 +1463,13 @@ endif
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
-ifneq ($(findstring $(MAKEFLAGS),w),w)
+ifneq ($(findstring w,$(MAKEFLAGS)),w)
 PRINT_DIR = --no-print-directory
 else # "make -w"
 NO_SUBDIR = :
 endif
 
-ifneq ($(findstring $(MAKEFLAGS),s),s)
+ifneq ($(findstring s,$(MAKEFLAGS)),s)
 ifndef V
 	QUIET_CC       = @echo '   ' CC $@;
 	QUIET_AR       = @echo '   ' AR $@;
-- 
2.5.0.466.g9af26fa
