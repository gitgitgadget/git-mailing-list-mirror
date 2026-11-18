Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036148;
	b=zClOhcZW0/k1NUiIT0J7QhqhicW8spy1jT49OsMch1NHGWoI9g/NV362caikfcnZdO2v
	 QfcNzZZpuJkaMCLvBo7FBso2YMuazRfnbmIEsJ8ATqDEiah6Q1VYEU8ISlNZk0kQQle1Z
	 WWuibC6kGGBvkYrKaHbOO0N4g1FrBjvp3sYLZ7O3/c1X0p4QvAAPxOyAPBn0LjnHryAKd
	 APsLv5iMdu6C3kw1YpRAfY3Gn7+Y2g4Etw4FMaX4YMs4ngCC67SGnlWWgs1LswZtQawVf
	 30bQWdolyu3QJM/BZMHQtgtUOvCcSp2mUlEb2IXDj49ZCDopfHrNL8UvEIr94CVBtVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036148;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=fnIhyl+69h3KVL4OWo/HPlmNh7hy7VuvAN5sJKx65DI=;
	b=KfPCOM4BncE5uB8eIzGRU+mDVz3FPUzmHByKi7ESBwC6vJ5zfm8842tWEcxGU3kPVrr2
	 B24OGvcEz9yMRw+cJ+GMe2ZS5/m+1NwMcQZtiRVtb/d3m85Z51chJrwAqZuIDoGmqpoqa
	 qcWP3y5yrQDFBs3GuWXRuC6BpCuJiHF52hcF2ct1Zq/botta2SQXktoNhLJNZ8KUunxE1
	 /gjoN+PxyskXfIRtRiadyuKfKtB/Y8SKjE3NDNCID39gTLuLpUDTNuM8XoE4cRdkcCggK
	 1c3iWsOiw5xPZ2vd8Ftd0hHizISpQW/+gsBQ8paEbxS09mrzNYwWU5lWzFEsppQPYQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=Dw7kP9yM;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB194606A336
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 21:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB194606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=Dw7kP9yM
Received: from lena.gouders.net (ip-109-41-49-52.web.vodafone.de [109.41.49.52])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AIL8tdN1931210
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 18 Nov 2026 22:09:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795036142; bh=fnIhyl+69h3KVL4OWo/HPlmNh7hy7VuvAN5sJKx65DI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Dw7kP9yMYTIOsC39JJLLUUWVJ2Hn5ZqDS9cJmCgguANH4X/PJufnovIqFKLqRn5+P
	 9Glu4S+pGdoXgwV4NkZfxqQILy0lXdg5TddBSIux2n4S4X8/S8XP+baIznaLs2ZAC2
	 alxGLvHZ9zy4pnmCM1BXatG3/4SMn9xiq5F49V6Y=
From: Dirk Gouders <dirk@gouders.net>
Date: Wed, 18 Nov 2026 22:08:50 +0100
Subject: [PATCH v2 1/4] utf8: add display_mode_esc_sequence_len_counted()
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-master-v2-1-3f2aaec15d31@gouders.net>
References: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
In-Reply-To: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5731; i=dirk@gouders.net;
 h=from:subject:message-id; bh=LD7UtCbGrXz0D0wqv/nW/3T0wLBOY7r2+JnWNPAZqp8=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLL+Cb8N3XBNrvWmvFddfP758trf+Wc79LeJRfHLc4scO
 rXO+otuJ+MEFgZGLoYqMUWWpZOK7NJUVrwo+6aaCTOIlQlkirRIAwMQsDDw5SbmlRrpGOmZahvq
 GQIZOkYOEDl+Bo30gnSH9PzSlNSiYr281BJHU0sjcyNjVzMzIxNHC1cLczM3MyNTM0tHE1NzV0c
 XM2NzY1MTR0tnBi5OAZh1K9o5GBYKMytviV21hItxmkaH/H+lm0vbZ/RxS6lu9Vxott55k+GzOZ
 pHjUUfqk61Ku97ny777+DJvxVXli3myPc+oSTz9pZ62UzFvIUSoZOKN9bzX/KOnff7l/2E/kSGR
 9se/fPgFOWec8t9q5BHWliY9x6ButfdrEtrrGP2dU83KHB3/+0RtrLkQhwzw1vDzz+Oinf1FYsW
 WobdTTo2M0F8jqr6BE/tnUn+YX1b2KNPu3+6JnlH3v7MwRvHblSXSqaaxqdP5ePeHWXttH5uAkf
 2bBehtOzin1cnqXomrXF4mVAe+orh1ltNqXeM3GaLVVMDGhYbeR5bdm+BgODb17fV3v2tNnNwam
 je4nGr9TcrAA==
X-Developer-Key: i=dirk@gouders.net; a=openpgp;
 fpr=943B4FA3CAB8EBC55754E5EA0DA2395F431875F6

From: Junio C Hamano <gitster@pobox.com>

display_mode_esc_sequence_len() scans for an ANSI display mode
escape sequence (e.g. "ESC [ 1 ; 31 m") at the start of a string,
relying on NUL termination to stop.  Some callers, however, work on
a counted buffer: utf8_strnwidth() takes <string, len> and must not
scan past it, while strbuf_utf8_replace() and
strbuf_add_wrapped_text() know (or can cheaply learn) the end.

Add display_mode_esc_sequence_len_counted() taking <ptr, len>,
which never reads at or beyond ptr[len], and make
display_mode_esc_sequence_len() a thin wrapper for NUL-terminated
strings.

Use the counted variant in utf8_strnwidth() for correctness, and in
strbuf_utf8_replace() and strbuf_add_wrapped_text() (computing the
end once upfront in the latter) to avoid measuring the remaining
text in each iteration.

Also, add some tests for the new function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 Makefile                   |  1 +
 t/meson.build              |  1 +
 t/unit-tests/u-utf8-ansi.c | 14 ++++++++++++++
 utf8.c                     | 35 ++++++++++++++++++++++++++---------
 utf8.h                     |  1 +
 5 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 4c84eea6e2..3c8dc9ca40 100644
--- a/Makefile
+++ b/Makefile
@@ -1564,6 +1564,7 @@ CLAR_TEST_SUITES += u-strvec
 CLAR_TEST_SUITES += u-trailer
 CLAR_TEST_SUITES += u-urlmatch-normalization
 CLAR_TEST_SUITES += u-utf8-width
+CLAR_TEST_SUITES += u-utf8-ansi
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
diff --git a/t/meson.build b/t/meson.build
index 1cf1d95f70..e224df58c8 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -27,6 +27,7 @@ clar_test_suites = [
   'unit-tests/u-trailer.c',
   'unit-tests/u-urlmatch-normalization.c',
   'unit-tests/u-utf8-width.c',
+  'unit-tests/u-utf8-ansi.c',
 ]
 
 clar_sources = [
diff --git a/t/unit-tests/u-utf8-ansi.c b/t/unit-tests/u-utf8-ansi.c
new file mode 100644
index 0000000000..c19d8bce78
--- /dev/null
+++ b/t/unit-tests/u-utf8-ansi.c
@@ -0,0 +1,14 @@
+#include "unit-test.h"
+#include "utf8.h"
+#include "strbuf.h"
+
+/*
+ * Test len limited functions for ANSI SGR lengths.
+ */
+void test_utf8_ansi__sgr_len(void)
+{
+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("\033[m", 2));
+	cl_assert_equal_i(3, display_mode_esc_sequence_len_counted("\033[m", 3));
+	cl_assert_equal_i(5, display_mode_esc_sequence_len_counted("\033[31m", 5));
+	cl_assert_equal_i(7, display_mode_esc_sequence_len_counted("\033[0;31m", 7));
+}
diff --git a/utf8.c b/utf8.c
index 96460cc414..d0546ab31f 100644
--- a/utf8.c
+++ b/utf8.c
@@ -16,20 +16,33 @@ struct interval {
 	ucs_char_t last;
 };
 
-size_t display_mode_esc_sequence_len(const char *s)
+/*
+ * Return the length of the ANSI display mode escape sequence (e.g.,
+ * "\033[1;31m") that appears at the beginning of the "len" bytes
+ * of string "s", or 0 if the bytes do not begin with a complete
+ * such sequence.  Never looks at s[len] or beyond.
+ */
+size_t display_mode_esc_sequence_len_counted(const char *s, size_t len)
 {
-	const char *p = s;
-	if (*p++ != '\033')
+	const char *p = s, *end = s + len;
+
+	if (end <= p || *p++ != '\033')
 		return 0;
-	if (*p++ != '[')
+	if (end <= p || *p++ != '[')
 		return 0;
-	while (isdigit(*p) || *p == ';')
+	while (p < end && (isdigit(*p) || *p == ';'))
 		p++;
-	if (*p++ != 'm')
+	if (end <= p || *p++ != 'm')
 		return 0;
 	return p - s;
 }
 
+/* Same as above, but for a NUL-terminated string "s". */
+size_t display_mode_esc_sequence_len(const char *s)
+{
+	return display_mode_esc_sequence_len_counted(s, strlen(s));
+}
+
 /* auxiliary function for binary search in interval table */
 static int bisearch(ucs_char_t ucs, const struct interval *table, int max)
 {
@@ -218,7 +231,8 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 		size_t skip;
 
 		while (skip_ansi &&
-		       (skip = display_mode_esc_sequence_len(string)) != 0)
+		       (skip = display_mode_esc_sequence_len_counted(string,
+							orig + len - string)) != 0)
 			string += skip;
 
 		glyph_width = utf8_width(&string, NULL);
@@ -279,6 +293,7 @@ void strbuf_add_wrapped_text(struct strbuf *buf,
 {
 	int indent, w, assume_utf8 = 1;
 	const char *bol, *space, *start = text;
+	const char *end = text + strlen(text);
 	size_t orig_len = buf->len;
 
 	if (width <= 0) {
@@ -299,7 +314,8 @@ void strbuf_add_wrapped_text(struct strbuf *buf,
 		char c;
 		size_t skip;
 
-		while ((skip = display_mode_esc_sequence_len(text)))
+		while ((skip = display_mode_esc_sequence_len_counted(text,
+								end - text)))
 			text += skip;
 
 		c = *text;
@@ -378,7 +394,8 @@ void strbuf_utf8_replace(struct strbuf *sb_src, int pos, int width,
 		int glyph_width;
 		size_t n;
 
-		while ((n = display_mode_esc_sequence_len(src))) {
+		while ((n = display_mode_esc_sequence_len_counted(src,
+								  end - src))) {
 			strbuf_add(&dst, src, n);
 			src += n;
 		}
diff --git a/utf8.h b/utf8.h
index cf8ecb0f21..57ca2ab270 100644
--- a/utf8.h
+++ b/utf8.h
@@ -6,6 +6,7 @@ struct strbuf;
 typedef unsigned int ucs_char_t;  /* assuming 32bit int */
 
 size_t display_mode_esc_sequence_len(const char *s);
+size_t display_mode_esc_sequence_len_counted(const char *s, size_t len);
 int utf8_width(const char **start, size_t *remainder_p);
 int utf8_strnwidth(const char *string, size_t len, int skip_ansi);
 int utf8_strwidth(const char *string);

-- 
2.55.0

