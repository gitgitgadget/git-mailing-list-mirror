From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 1/4] Use BASIC_FLAGS for profile feedback
Date: Mon,  7 Jul 2014 23:35:08 -0700
Message-ID: <1404801311-15365-2-git-send-email-andi@firstfloor.org>
References: <1404801311-15365-1-git-send-email-andi@firstfloor.org>
Cc: Andi Kleen <ak@linux.intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 08:35:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4P0F-0005EQ-P4
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 08:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576AbaGHGfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 02:35:33 -0400
Received: from one.firstfloor.org ([193.170.194.197]:33413 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbaGHGfa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 02:35:30 -0400
Received: from basil.firstfloor.org (184-100-237-164.ptld.qwest.net [184.100.237.164])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 8C93886772;
	Tue,  8 Jul 2014 08:35:28 +0200 (CEST)
Received: by basil.firstfloor.org (Postfix, from userid 1000)
	id 5F84BA207D; Mon,  7 Jul 2014 23:35:16 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1404801311-15365-1-git-send-email-andi@firstfloor.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253009>

From: Andi Kleen <ak@linux.intel.com>

Use BASIC_CFLAGS instead of CFLAGS to set up the profile feedback
option in the Makefile.

This allows still overriding CFLAGS on the make command line
without disabling profile feedback.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 07ea105..a9770ac 100644
--- a/Makefile
+++ b/Makefile
@@ -1552,13 +1552,13 @@ endif
 PROFILE_DIR := $(CURDIR)
 
 ifeq ("$(PROFILE)","GEN")
-	CFLAGS += -fprofile-generate=$(PROFILE_DIR) -DNO_NORETURN=1
+	BASIC_CFLAGS += -fprofile-generate=$(PROFILE_DIR) -DNO_NORETURN=1
 	EXTLIBS += -lgcov
 	export CCACHE_DISABLE = t
 	V = 1
 else
 ifneq ("$(PROFILE)","")
-	CFLAGS += -fprofile-use=$(PROFILE_DIR) -fprofile-correction -DNO_NORETURN=1
+	BASIC_CFLAGS += -fprofile-use=$(PROFILE_DIR) -fprofile-correction -DNO_NORETURN=1
 	export CCACHE_DISABLE = t
 	V = 1
 endif
-- 
2.0.1
