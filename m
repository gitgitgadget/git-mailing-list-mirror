From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/9] strbuf: add strbuf_isspace()
Date: Tue, 24 Dec 2013 07:37:21 +0100
Message-ID: <20131224063726.19560.38673.chriscool@tuxfamily.org>
References: <20131224061541.19560.17773.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 24 07:39:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VvLeR-00026m-39
	for gcvg-git-2@plane.gmane.org; Tue, 24 Dec 2013 07:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332Ab3LXGja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Dec 2013 01:39:30 -0500
Received: from [194.158.98.15] ([194.158.98.15]:59739 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751090Ab3LXGik (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Dec 2013 01:38:40 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 6B4113A;
	Tue, 24 Dec 2013 07:38:19 +0100 (CET)
X-git-sha1: 2156c0a4e836224ffac39666d398b5dbdec83dc0 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131224061541.19560.17773.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239666>

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
1.8.4.1.616.g07f5c81
