Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187498;
	b=Re2cjdAaHXs3hYW1lcAaBEkhDBWJ36kzFtJyytxXtVHx7gUuJ7/K62V2oAol1WwgfyCR
	 ldg8GpCAX3GKtG+JbEEZRgwWr6DIctIy4ZptWw0+IYw1xQ2jlA+7FhV1SzYSjAQ01Gh9x
	 kuQrg3VwFjM/I2HFTry1VCdsFDTCdfjlh3J24cEJf2+JzvcK7w1jsHZaZ3AMiyaXUWvQu
	 mbBGIU4WqiwWmz3bdpM5GEtYHQPIPFh49RJZwfrG1G1okzlZfyoqh+eGZCcVjQOLSY5v/
	 z7c30Szu8vMDZr3UQ74z8nbyyW4ip/UYZuw39gAuUpSjl9xZDzEgMkonhDNr6ukA4mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187498;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=3OwlpOzQ/PLKdKJSIpz9xgotyrovZ7C8+JOZB1JHZHA=;
	b=aN1ndKVTkIorx/+rLbhu4Akut791IHBEZ63YZfVNvzPB3Q+R/kPRtHYx5Y7j08jmEx8A
	 BnlQx6lpoexSvf+ugP8eY1Z4h2Kijfss+7rPtoU39uPtPG820OyjPYsh0wuW1gIEdhZML
	 7dbMn+dAcfYlRYYf2cnz5tekuwliYsivX39EBizCMt5ZI4YQNReXBLKZY0fXHXDAMw39j
	 miJ+UigJLljr+Zyn6oLBR8o2GojX8qYCUy4dEX+qCpccY2udMxYAdfLNoRv7ZKg/hWFv+
	 gOEZFF20zhz0P8GvLwO1W7b7a8jlXvDpXli8g4H6pj3h6hm3jyAulZYToEhsD5e3DsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=OEpdS6y7;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B2C606A332
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 15:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87B2C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=OEpdS6y7
Received: from lena.gouders.net (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AKFBTTe2082197
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 20 Nov 2026 16:11:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795187492; bh=3OwlpOzQ/PLKdKJSIpz9xgotyrovZ7C8+JOZB1JHZHA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OEpdS6y717ncrCQTNgEeJE2wcFgo7RrH0vfSycSpnSCx1etybBWwwoDdQPQTG/0PK
	 w0AUjnR56n663WGLlRKQkDL6LarMLdRdknxR0FEXeo33T9p8loYEij6YeotrvGwHZt
	 MR7j35/4Drwh2Tf8O96NXEdWd7pqXUsNQHmSrnEA=
From: Dirk Gouders <dirk@gouders.net>
Date: Fri, 20 Nov 2026 16:11:24 +0100
Subject: [PATCH v4 1/5] utf8: introduce bounds for
 display_mode_esc_sequence_len()
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261120-master-v4-1-5ff523db7285@gouders.net>
References: <20261120-master-v4-0-5ff523db7285@gouders.net>
In-Reply-To: <20261120-master-v4-0-5ff523db7285@gouders.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dirk Gouders <dirk@gouders.net>,
        Andy Koppe <andy.koppe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8301; i=dirk@gouders.net;
 h=from:subject:message-id; bh=dZWoVViLc8aoK9Uc7Krt+bY3/OHcS+o4n6GwpqUM7xY=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLIZkhUzqlQOxTar7C1f7RdbcPatrMXyP3UGE59+sOHXd
 pkRlVPSyTiBhYGRi6FKTJFl6aQiuzSVFS/KvqlmwgxiZQKZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjpEDRI6fQSO9IN0hPb80JbWoWC8vtcTR1NLI3MjY1czMyMTRwtXC3MzNzMjUzNLRxNTc1dH
 FzNjc2NTE0dKZgYtTAGbdxNccDD3vm6Q28lYxhB+7oLWjN+Ax15nMbzaTu7bze9xoruVv2r0512
 f9t/03695O32VmyzcjkukVg9qpl6oyWfsmeSZxLecMWLfqwdk/jb/4b/NxKG9lb34U3XVn6sfJl
 myhDDw9vy6u5GX9zqrxPUT9ratgZJqBTHLoggSOG18MbT71aykL1L45mGf3ksvhixm7YtZjvsQz
 Db5dhuXWGXELJ3w6uy45IuNo0q+ti5b+dvr96eihEvcctW8Hl6473LnsSM26mfqCL8uunQpbm9s
 eWmfOveXPCXkOA7WN6YdYpjWlMAZm7E4qSC2ul9/ZfVF4yRq95CMnft7OkJp3ezvTfKOIzvVP6h
 6/19nFMWWBLwA=
X-Developer-Key: i=dirk@gouders.net; a=openpgp;
 fpr=943B4FA3CAB8EBC55754E5EA0DA2395F431875F6

From: Junio C Hamano <gitster@pobox.com>

display_mode_esc_sequence_len() scans for an ANSI display mode
escape sequence (e.g. "ESC [ 1 ; 31 m") at the start of a string,
relying on NUL termination to stop.  Some callers, however, work on
a counted buffer: utf8_strnwidth() takes <string, len> and must not
scan past it, while strbuf_utf8_replace() and
strbuf_add_wrapped_text() know (or can cheaply learn) the end.

Introduce an optional end pointer to display_mode_esc_sequence_len()
which then never reads *end or beyond when end is not NULL.
If end is NULL, display_mode_esc_sequence_len() assumes a
NUL terminated string as before.

Andy Koppe pointed out the risk of performance degrading to O(n²)
when functions process strings and have to check each position for an
escape sequence [1].  This change doesn't carry this risk.

Further, add thorough tests for both end pointer cases.

[1] https://lore.kernel.org/git/CAHWeT-aWx1VwUjM+hZ--jjSAbcMenz5Mw11y9ouFavGndUMrSA@mail.gmail.com/

Cc: Andy Koppe <andy.koppe@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 Makefile                   |  1 +
 pretty.c                   |  2 +-
 t/meson.build              |  1 +
 t/unit-tests/u-utf8-ansi.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 utf8.c                     | 34 ++++++++++++++++----------
 utf8.h                     |  2 +-
 6 files changed, 85 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index 4c84eea6e2..db8f7f5c60 100644
--- a/Makefile
+++ b/Makefile
@@ -1563,6 +1563,7 @@ CLAR_TEST_SUITES += u-string-list
 CLAR_TEST_SUITES += u-strvec
 CLAR_TEST_SUITES += u-trailer
 CLAR_TEST_SUITES += u-urlmatch-normalization
+CLAR_TEST_SUITES += u-utf8-ansi
 CLAR_TEST_SUITES += u-utf8-width
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
diff --git a/pretty.c b/pretty.c
index d8a9f370f6..58dfeb61f4 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1848,7 +1848,7 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 			while (p > sb->buf && ch - p < 10 && *p != '\033')
 				p--;
 			if (*p != '\033' ||
-			    ch + 1 - p != display_mode_esc_sequence_len(p))
+			    ch + 1 - p != display_mode_esc_sequence_len(p, ch + 1))
 				break;
 			/*
 			 * got a good ansi sequence, put it back to
diff --git a/t/meson.build b/t/meson.build
index 1cf1d95f70..ae7479a98e 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -26,6 +26,7 @@ clar_test_suites = [
   'unit-tests/u-strvec.c',
   'unit-tests/u-trailer.c',
   'unit-tests/u-urlmatch-normalization.c',
+  'unit-tests/u-utf8-ansi.c',
   'unit-tests/u-utf8-width.c',
 ]
 
diff --git a/t/unit-tests/u-utf8-ansi.c b/t/unit-tests/u-utf8-ansi.c
new file mode 100644
index 0000000000..cb75c8612b
--- /dev/null
+++ b/t/unit-tests/u-utf8-ansi.c
@@ -0,0 +1,59 @@
+#include "unit-test.h"
+#include "utf8.h"
+#include "strbuf.h"
+
+/*
+ * Test display_mode_esc_sequence_len() for NUL terminated strings.
+ */
+void test_utf8_ansi__sgr_len_null(void)
+{
+	cl_assert_equal_i(0, display_mode_esc_sequence_len("", NULL));
+
+	cl_assert_equal_i(0, display_mode_esc_sequence_len("\033", NULL));
+	cl_assert_equal_i(0, display_mode_esc_sequence_len("\033[", NULL));
+	cl_assert_equal_i(3, display_mode_esc_sequence_len("\033[m", NULL));
+
+	cl_assert_equal_i(0, display_mode_esc_sequence_len("\033[3", NULL));
+	cl_assert_equal_i(0, display_mode_esc_sequence_len("\033[31", NULL));
+	cl_assert_equal_i(5, display_mode_esc_sequence_len("\033[31m", NULL));
+
+	cl_assert_equal_i(0, display_mode_esc_sequence_len("\033[31;", NULL));
+	cl_assert_equal_i(6, display_mode_esc_sequence_len("\033[31;m", NULL));
+	cl_assert_equal_i(7, display_mode_esc_sequence_len("\033[31;0m", NULL));
+}
+
+/*
+ * Test display_mode_esc_sequence_len() with end pointers.
+ */
+void test_utf8_ansi__sgr_len_end_ptr(void)
+{
+	char *sgr_1 = (char *)"\033[m";
+	char *sgr_2 = (char *)"\033[31m";
+	char *sgr_3 = (char *)"\033[31;m";
+	char *sgr_4 = (char *)"\033[31;0m";
+
+	cl_assert_equal_i(0, display_mode_esc_sequence_len("", ""));
+
+	cl_assert_equal_i(0, display_mode_esc_sequence_len(sgr_1, sgr_1 + 1));
+	cl_assert_equal_i(0, display_mode_esc_sequence_len(sgr_1, sgr_1 + 2));
+	cl_assert_equal_i(3, display_mode_esc_sequence_len(sgr_1, sgr_1 + 3));
+
+	cl_assert_equal_i(0, display_mode_esc_sequence_len(sgr_2, sgr_2 + 1));
+	cl_assert_equal_i(0, display_mode_esc_sequence_len(sgr_2, sgr_2 + 2));
+	cl_assert_equal_i(0, display_mode_esc_sequence_len(sgr_2, sgr_2 + 3));
+	cl_assert_equal_i(0, display_mode_esc_sequence_len(sgr_2, sgr_2 + 4));
+	cl_assert_equal_i(5, display_mode_esc_sequence_len(sgr_2, sgr_2 + 5));
+
+	cl_assert_equal_i(6, display_mode_esc_sequence_len(sgr_3, sgr_3 + sizeof(sgr_3) - 1));
+	cl_assert_equal_i(7, display_mode_esc_sequence_len(sgr_4, sgr_4 + sizeof(sgr_4) - 1));
+}
+
+/*
+ * Test display_mode_esc_sequence_len() for swapped start and end pointers.
+ */
+void test_utf8_ansi__sgr_len_start_end_swap(void)
+{
+	char *sgr_1 = (char *)"\033[m";
+
+	cl_assert_equal_i(0, display_mode_esc_sequence_len(sgr_1 + 3, sgr_1));
+}
diff --git a/utf8.c b/utf8.c
index 96460cc414..48aa189624 100644
--- a/utf8.c
+++ b/utf8.c
@@ -16,18 +16,27 @@ struct interval {
 	ucs_char_t last;
 };
 
-size_t display_mode_esc_sequence_len(const char *s)
+/*
+ * Return the length of the ANSI display mode escape sequence (e.g.,
+ * "\033[1;31m") that appears at the beginning of the string starting at start,
+ * or 0 if the string does not begin with a complete such sequence.
+ * If end is NULL, assume a NUL terminated string, else never look at *end or
+ * beyond.
+ */
+size_t display_mode_esc_sequence_len(const char *start, const char *end)
 {
-	const char *p = s;
-	if (*p++ != '\033')
+	const char *p = start;
+
+	if ((end && end <= p) || *p++ != '\033')
 		return 0;
-	if (*p++ != '[')
+	if ((end && end <= p) || *p++ != '[')
 		return 0;
-	while (isdigit(*p) || *p == ';')
+	while (((end && p < end) || (!end && *p)) && (isdigit(*p) || *p == ';'))
 		p++;
-	if (*p++ != 'm')
+	if ((end && end <= p) || (!end && !*p) || *p++ != 'm')
 		return 0;
-	return p - s;
+
+	return p - start;
 }
 
 /* auxiliary function for binary search in interval table */
@@ -210,15 +219,15 @@ int utf8_width(const char **start, size_t *remainder_p)
  */
 int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 {
-	const char *orig = string;
+	const char *end = string + len;
 	size_t width = 0;
 
-	while (string && string < orig + len) {
+	while (string && string < end) {
 		int glyph_width;
 		size_t skip;
 
 		while (skip_ansi &&
-		       (skip = display_mode_esc_sequence_len(string)) != 0)
+		       (skip = display_mode_esc_sequence_len(string, end)))
 			string += skip;
 
 		glyph_width = utf8_width(&string, NULL);
@@ -279,6 +288,7 @@ void strbuf_add_wrapped_text(struct strbuf *buf,
 {
 	int indent, w, assume_utf8 = 1;
 	const char *bol, *space, *start = text;
+	const char *end = text + strlen(text);
 	size_t orig_len = buf->len;
 
 	if (width <= 0) {
@@ -299,7 +309,7 @@ void strbuf_add_wrapped_text(struct strbuf *buf,
 		char c;
 		size_t skip;
 
-		while ((skip = display_mode_esc_sequence_len(text)))
+		while ((skip = display_mode_esc_sequence_len(text, end)))
 			text += skip;
 
 		c = *text;
@@ -378,7 +388,7 @@ void strbuf_utf8_replace(struct strbuf *sb_src, int pos, int width,
 		int glyph_width;
 		size_t n;
 
-		while ((n = display_mode_esc_sequence_len(src))) {
+		while ((n = display_mode_esc_sequence_len(src, end))) {
 			strbuf_add(&dst, src, n);
 			src += n;
 		}
diff --git a/utf8.h b/utf8.h
index cf8ecb0f21..7eb7bf042a 100644
--- a/utf8.h
+++ b/utf8.h
@@ -5,7 +5,7 @@ struct strbuf;
 
 typedef unsigned int ucs_char_t;  /* assuming 32bit int */
 
-size_t display_mode_esc_sequence_len(const char *s);
+size_t display_mode_esc_sequence_len(const char *start, const char *end);
 int utf8_width(const char **start, size_t *remainder_p);
 int utf8_strnwidth(const char *string, size_t len, int skip_ansi);
 int utf8_strwidth(const char *string);

-- 
2.55.0

