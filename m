From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/6] Introduce debug_bulkmove() in diffcore-rename.
Date: Thu,  9 Dec 2010 22:38:02 +0100
Message-ID: <1291930687-8990-2-git-send-email-ydirson@altern.org>
References: <1291930687-8990-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 22:38:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQoCN-0005wX-BB
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365Ab0LIViX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 16:38:23 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:39524 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757246Ab0LIViV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:38:21 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 9852CD480B7;
	Thu,  9 Dec 2010 22:38:15 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PQoBq-0002Sb-Em; Thu, 09 Dec 2010 22:38:14 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291930687-8990-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163330>

This is an optional debug useful while developping new builk-* features.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 diffcore-rename.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index f7afdeb..e16fdeb 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -7,6 +7,22 @@
 #include "hash.h"
 #include "sorted-array.h"
 
+#define DEBUG_BULKMOVE 0
+
+#if DEBUG_BULKMOVE
+#define debug_bulkmove(args) __debug_bulkmove args
+void __debug_bulkmove(const char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	fprintf(stderr, "[DBG] ");
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+}
+#else
+#define debug_bulkmove(args) do { /*nothing */ } while (0)
+#endif
+
 /* Table of rename/copy destinations */
 
 struct diff_rename_dst {
-- 
1.7.2.3
