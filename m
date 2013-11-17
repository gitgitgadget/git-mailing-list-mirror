From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 86/86] strbuf: remove prefixcmp() as it has been replaced
 with starts_with()
Date: Sun, 17 Nov 2013 23:07:18 +0100
Message-ID: <20131117220719.4386.4388.chriscool@tuxfamily.org>
References: <20131117215732.4386.19345.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>,
	Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 19 22:05:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VisUb-0002gl-N5
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 22:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011Ab3KSVFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 16:05:40 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:63466 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058Ab3KSVFd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 16:05:33 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 964FC58;
	Tue, 19 Nov 2013 22:05:32 +0100 (CET)
X-git-sha1: 420ad990adc571fff77a536cee22cb4839307ba6 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131117215732.4386.19345.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238048>

prefixcmp() is now useless as the previous commit replaced it
everywhere with starts_with(). So let's now remove it.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-compat-util.h | 1 -
 strbuf.c          | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index e441a6b..c4c01e7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -350,7 +350,6 @@ extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_lis
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
 extern void set_die_is_recursing_routine(int (*routine)(void));
 
-extern int prefixcmp(const char *str, const char *prefix);
 extern int starts_with(const char *str, const char *prefix);
 extern int ends_with(const char *str, const char *suffix);
 
diff --git a/strbuf.c b/strbuf.c
index 933d998..ee96dcf 100644
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
 int starts_with(const char *str, const char *prefix)
 {
 	for (; ; str++, prefix++)
-- 
1.8.4.1.561.g12affca
