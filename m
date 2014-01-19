From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 05/16] strbuf: add strbuf_isspace()
Date: Sun, 19 Jan 2014 09:53:43 +0100
Message-ID: <20140119085355.2734.74428.chriscool@tuxfamily.org>
References: <20140119083636.2734.14378.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 19 09:55:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4oAL-0008R0-Nz
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jan 2014 09:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbaASIzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jan 2014 03:55:20 -0500
Received: from [194.158.98.15] ([194.158.98.15]:49903 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751996AbaASIyt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jan 2014 03:54:49 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 52E8751;
	Sun, 19 Jan 2014 09:54:28 +0100 (CET)
X-git-sha1: 0e059d27b46f4e726315a2123caa23aaeefb4cab 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140119083636.2734.14378.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240682>

This helper function checks if a strbuf
contains only space chars or not.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 strbuf.c | 7 +++++++
 strbuf.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 83caf4a..2124bb8 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -124,6 +124,13 @@ void strbuf_ltrim(struct strbuf *sb)
 	sb->buf[sb->len] = '\0';
 }
 
+int strbuf_isspace(struct strbuf *sb)
+{
+	char *b;
+	for (b = sb->buf; *b && isspace(*b); b++);
+	return !*b;
+}
+
 struct strbuf **strbuf_split_buf(const char *str, size_t slen,
 				 int terminator, int max)
 {
diff --git a/strbuf.h b/strbuf.h
index 73e80ce..02bff3a 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -42,6 +42,7 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
 extern void strbuf_trim(struct strbuf *);
 extern void strbuf_rtrim(struct strbuf *);
 extern void strbuf_ltrim(struct strbuf *);
+extern int strbuf_isspace(struct strbuf *);
 extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
 
 /*
-- 
1.8.5.2.201.gacc5987
