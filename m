From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 05/17] strbuf: add strbuf_isspace()
Date: Thu, 30 Jan 2014 07:49:08 +0100
Message-ID: <20140130064921.7504.74582.chriscool@tuxfamily.org>
References: <20140130064217.7504.473.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 08:39:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8mDF-0005cP-Lf
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 08:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874AbaA3Hi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 02:38:56 -0500
Received: from [194.158.98.15] ([194.158.98.15]:39141 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752739AbaA3HiG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 02:38:06 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id B78185B;
	Thu, 30 Jan 2014 08:37:45 +0100 (CET)
X-git-sha1: f6ed2f13dbe4e83a54ebbd5b41c09d8321d2f951 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140130064217.7504.473.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241258>

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
