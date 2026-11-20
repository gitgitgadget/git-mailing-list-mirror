Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185883;
	b=NeElL6qIXqMQjzdiuodSBe3aHPEsZymmTUkrdcV84kcbAYq1/MPnroL0ggvJ/6a4aNKs
	 cM+b04uxK2fwLXGoe7Ap/T7mcFKER1Sb/alLpKrtEdKoIfH+avB96T10ejyaLkb0j1+7W
	 HAJmvHjZIzZam2jRCvgL1E8DRzh/NOwZ8xnQzHR3W/0NB6Kvhz9NnNQtxRX3YDpV2sv9f
	 8fO0JR/oyYXdfFLcGTWbwJzsHvA4FSraVmHfo+l9UG4e+Sml66zLlawwckAy9ZQxthOsU
	 volSTWiY5rL5va5f4yTQtWRLbyGZ48h5SZew1g2DNA6oo/d3u/bqTp8kTAMO32fD+BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185883;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=3OwlpOzQ/PLKdKJSIpz9xgotyrovZ7C8+JOZB1JHZHA=;
	b=Z2X93vK1YkhnNJP55PAfoeY6l/WTAw5l1eAjk+gzu8cXevjUSoLya4GSJRYo53WyMiJq
	 Gqkw9JZ73eAFkI/tE78VgfNHwG+NfW0w06Lb6F62eOal8TSucbx+p0Ny3/LXbugPwZedb
	 sucDSvxHjtgA3BhxtbbPC/T3A7FC2mwkSfdeZgnnptZ36pa4rSM+0KUap/hCupH64ejLb
	 J6YwjNLTV/iYk6BlZLzeSLAIiyVropPVq2GlKMDkYgVChODWTCQoD1+Wasso1Y4gz6ZOJ
	 gLOl5DX5lvYehIAeVXaJYJm8wPd+oqYFsROT8R0Ii5r1Oc2lcvF6Tflt0UCtb0iGQsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=p98YgBqm;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C592606A326
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 14:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C592606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=p98YgBqm
Received: from lena.gouders.net (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AKEiRt72079849
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 20 Nov 2026 15:44:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795185869; bh=3OwlpOzQ/PLKdKJSIpz9xgotyrovZ7C8+JOZB1JHZHA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=p98YgBqmgea26xBFrDk5O9qtykXqBOnb681+9tF2VbbIdz0eep7C5dvIjSaGjtp9L
	 1j2/S4VFqYWTvWvr2pBq3Rq1KBLuVJJZHP8qnZ7tGd5ZEdAFGaqWX9NXRBNsR1tI0/
	 RMUf4KmuEwxr3qc0Xm9Z44L3e+M+6fYY9lISJPEI=
From: Dirk Gouders <dirk@gouders.net>
Date: Fri, 20 Nov 2026 15:44:24 +0100
Subject: [PATCH v3 1/4] utf8: introduce bounds for
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
Message-Id: <20261120-master-v3-1-d28e8c75d26d@gouders.net>
References: <20261120-master-v3-0-d28e8c75d26d@gouders.net>
In-Reply-To: <20261120-master-v3-0-d28e8c75d26d@gouders.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dirk Gouders <dirk@gouders.net>,
        Andy Koppe <andy.koppe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8301; i=dirk@gouders.net;
 h=from:subject:message-id; bh=dZWoVViLc8aoK9Uc7Krt+bY3/OHcS+o4n6GwpqUM7xY=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLIZYs58CHxoYWbWpWfrf6x69dxPsw4rSO3X2ZTwcYGsp
 QizS9abTsYJLAyMXAxVYoosSycV2aWprHhR9k01E2YQKxPIFGmRBgYgYGHgy03MKzXSMdIz1TbU
 MwQydIwcIHL8DBrpBekO6fmlKalFxXp5qSWOppZG5kbGrmZmRiaOFq4W5mZuZkamZpaOJqbmro4
 uZsbmxqYmjpbODFycAjDrbDzY/6lorW/wivDxYn7KYJIcV1L1y67qsNJUY6VpHCsOzattvfGt03
 Jb+AGn/s7rGZ+j0xdHJoSbds4oufkwJ+lD6U6bCVf+hzj7crQEdFs9ucAZJVssl+rgFj/dW+6a/
 ORlJtqXDd7vmNnZMKVEITzJ9ecGL6mzQqvqvYsnT6uw/b8gaLdw8l2JoMnuiwWYTf5cMl/l5cGq
 K3Xff+vnnK0xha1+ZfN3a7Jmz93091cd/6HMm5+C504t//RC7fTlWQdFqh49m14VZbV7q9YC55a
 7BlYzU640FtVfeiJgIfDWn83WXKsp+Mr0DedPNTpwsumstXp1P/lguuwZf3nOu8cq9iyVWv7VdF
 esRgr3smX7AA==
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

