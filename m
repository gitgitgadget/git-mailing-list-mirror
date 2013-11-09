From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 86/86] strbuf: remove prefixcmp() as it has been replaced with
 has_prefix()
Date: Sat, 09 Nov 2013 08:07:19 +0100
Message-ID: <20131109070720.18178.24378.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:15:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2l1-00014x-Ro
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932998Ab3KIHOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:14:44 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:37764 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933468Ab3KIHO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:26 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 201F866;
	Sat,  9 Nov 2013 08:14:25 +0100 (CET)
X-git-sha1: 8eeb78b33ba0d570c32f08bea7dd18cb82b1ce5e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237551>

prefixcmp() is now useless as the previous commit replaced it
everywhere with has_prefix(). So let's now remove it.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-compat-util.h | 1 -
 strbuf.c          | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 7930f49..c5505e6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -350,7 +350,6 @@ extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_lis
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
 extern void set_die_is_recursing_routine(int (*routine)(void));
 
-extern int prefixcmp(const char *str, const char *prefix);
 extern int has_prefix(const char *str, const char *prefix);
 extern int has_suffix(const char *str, const char *suffix);
 
diff --git a/strbuf.c b/strbuf.c
index 748be6d..199533c 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,15 +1,6 @@
 #include "cache.h"
 #include "refs.h"
 
-int prefixcmp(const char *str, const char *prefix)
-{
-	for (; ; str++, prefix++)
-		if (!*prefix)
-			return 0;
-		else if (*str != *prefix)
-			return (unsigned char)*prefix - (unsigned char)*str;
-}
-
 int has_prefix(const char *str, const char *prefix)
 {
 	for (; ; str++, prefix++)
-- 
1.8.4.1.566.geca833c
