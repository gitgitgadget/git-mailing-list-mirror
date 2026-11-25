Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630814;
	b=mf2EvubeU5Vi0EMJ3abXvvEItQYRW5GuQRU+WCJrgFw66TFJSR/KzWWZJizENcTvFpqf
	 k6k4rhl6l3waP4g4ZUnm6t/xf/5VhfvG4cA3qJqoukWVdiFheYGbkl7Vl/3HS+MrKs6ec
	 KtfioZWQPEqK7nRPYFYMtctrTQ3AxcKUnISlOkhGtcrekHpWb6rYfeDJO0s6trKqlHl9N
	 EUYBpJbyDGiPPQLXPkpbKjZWEnqPNfW8X5cuTtzIpxftIlg51KMMsmzQIYgqJzGw+UFMM
	 wsfs9YIwh5ObqRL/f2zOq3qAvDZ3mJuwgESOhl1dt7R+xSB/2gQ3XiUEbbszRAGo0vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630814;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+XdwzAjlRNuAD+7vTj5CaAg1d+TtCKcQ7DmmhwfWBTo=;
	b=cJdIf0RHBz01tcljQayg/X9R3oZf6c3WnX1QgbLDVwPFq+up6TN/XCS2NLKNFU711nzw
	 6LjOCtlioQ2r0izy3pP/SxlSwEZKOGRw1CRRk4hYfwptsjxFJK7xOzK6omTy9oPEQu4xR
	 97lWU6Rj98tPZUp/lPR9lsg6g45bLsrFOl4PQTMr7Ewj35K3ShB0sKM8iZ+Ijp4sAYNRd
	 Ig//NZYAuxvcsqb+9Ri2yXUq2JNAEspIpOku6055ue4TrP5Wo+3J6FvIxrMkzP0zuO4Jt
	 d/kKhePs2FBLmapF8vJgxl+I6LTFrjVcZKYVcCdoS5UDSAVnny1ODfftaweYekx0OCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=ILh8OPTA;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD5E606A326
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 18:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DD5E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=ILh8OPTA
Received: from lena.gouders.net (ip-109-41-50-35.web.vodafone.de [109.41.50.35])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6APIJxx32481769
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 25 Nov 2026 19:20:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795630806; bh=+XdwzAjlRNuAD+7vTj5CaAg1d+TtCKcQ7DmmhwfWBTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ILh8OPTAwDPYOaDBUXMGZmk9QEVeeINRu6NjwPa/iNsGwQBXxM+ZghhRtXcBJ6aIo
	 EFreVmc7eQ5OWucdIOji/ScKE78FxHM+OzVpJorX/7DHoIPPUNUk2U7lOE3BrLQUdh
	 pSPtLw8sMxMTp0aEPLwlavMCcQvQJKbcCiJc5dww=
From: Dirk Gouders <dirk@gouders.net>
Date: Wed, 25 Nov 2026 19:19:41 +0100
Subject: [PATCH v6 1/4] utf8: add display_mode_esc_sequence_len_counted()
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
Message-Id: <20261125-master-v6-1-cb60af83d189@gouders.net>
References: <20261125-master-v6-0-cb60af83d189@gouders.net>
In-Reply-To: <20261125-master-v6-0-cb60af83d189@gouders.net>
To: git@vger.kernel.org
Cc: "Junio C Hamano <gitster@pobox.com>, Andy Koppe" <andy.koppe@gmail.com>,
        Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8462; i=dirk@gouders.net;
 h=from:subject:message-id; bh=MAy4QOmz0sd09mfIwIz5OT6PT2emRKQQiTUNqb/JabE=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLLZ1a4+X8Lh7rpuZnLQUkkhp4Cy24viOnu1C+58+5+Wc
 9zGXFWzk3ECCwMjF0OVmCLL0klFdmkqK16UfVPNhBnEygQyRVqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHSMHiBw/g0Z6QbpDen5pSmpRsV5eaomjqaWRuZGxq5mZkYmjhauFuZmbmZGpmaWjiam5q6O
 LmbG5samJo6UzAxenAMy6jNns/9P9EyXebJoqKLFSwUH08Aah9u8L4vj/nLYqVfDWWl2+t+Inww
 sLC3WVFmmhM5371m6Pi7F1/v1o3Z7dJYuuT1v+VCQ1X09a9YP+wgNeF4X2HN3ok6sbtreid+MN1
 p9fHryOc8/UubA6xPT0nUteZzucw092m79fmeSrf/8ut75p5XTLjG8nCn+uj/LImX+gj7fIPMeg
 vrJbZu9c3a6LEXzn/HynXDwdPHWjrOPieWkmTxO4DLa/3rz+16OTnysW/TG7mNBeICg29bGb+Ia
 PgT+m6B5c3Wco1nrxbst+470dqXt2q8if+mcYz6uksPxrY3f6+idhb16cfVnKIlqzL/+BzHL1y3
 Y7fVX1lrQ+VQYA
X-Developer-Key: i=dirk@gouders.net; a=openpgp;
 fpr=943B4FA3CAB8EBC55754E5EA0DA2395F431875F6

From: Junio C Hamano <gitster@pobox.com>

display_mode_esc_sequence_len() scans for an ANSI display mode
escape sequence (e.g. "ESC [ 1 ; 31 m") at the start of a string,
relying on NUL termination to stop.  Some callers, however, work on
a counted buffer: utf8_strnwidth() takes <string, len> and must not
scan past it, while strbuf_utf8_replace() knows the end.

Add display_mode_esc_sequence_len_counted() taking <ptr, len>,
which never reads at or beyond ptr[len], and make
display_mode_esc_sequence_len() a thin wrapper for NUL-terminated
strings.

Use the counted variant in utf8_strnwidth() for correctness, and in
strbuf_utf8_replace() where the length can easily be calculated.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Andy Koppe <andy.koppe@gmail.com>
[ak: warned against O(n²) degradation and suggested to use SIZE_MAX]
Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 Makefile                   |  1 +
 t/meson.build              |  1 +
 t/unit-tests/u-utf8-ansi.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++
 utf8.c                     | 35 +++++++++++++------
 utf8.h                     |  1 +
 5 files changed, 113 insertions(+), 10 deletions(-)

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
index 0000000000..a3c76b1ed3
--- /dev/null
+++ b/t/unit-tests/u-utf8-ansi.c
@@ -0,0 +1,85 @@
+#include "unit-test.h"
+#include "utf8.h"
+
+/*
+ * Test display_mode_esc_sequence_len_counted() for NUL-terminated strings.
+ */
+void test_utf8_ansi__sgr_len_counted(void)
+{
+	cl_assert_equal_u(0, display_mode_esc_sequence_len_counted("", SIZE_MAX));
+
+	cl_assert_equal_u(0, display_mode_esc_sequence_len_counted("\033", SIZE_MAX));
+	cl_assert_equal_u(0, display_mode_esc_sequence_len_counted("\033[", SIZE_MAX));
+	cl_assert_equal_u(3, display_mode_esc_sequence_len_counted("\033[m", SIZE_MAX));
+	cl_assert_equal_u(3, display_mode_esc_sequence_len_counted("\033[ma", SIZE_MAX));
+
+	cl_assert_equal_u(0, display_mode_esc_sequence_len_counted("\033[3", SIZE_MAX));
+	cl_assert_equal_u(0, display_mode_esc_sequence_len_counted("\033[31", SIZE_MAX));
+	cl_assert_equal_u(5, display_mode_esc_sequence_len_counted("\033[31m", SIZE_MAX));
+	cl_assert_equal_u(5, display_mode_esc_sequence_len_counted("\033[31ma", SIZE_MAX));
+
+	cl_assert_equal_u(0, display_mode_esc_sequence_len_counted("\033[31;", SIZE_MAX));
+	cl_assert_equal_u(6, display_mode_esc_sequence_len_counted("\033[31;m", SIZE_MAX));
+	cl_assert_equal_u(6, display_mode_esc_sequence_len_counted("\033[31;ma", SIZE_MAX));
+
+	cl_assert_equal_u(7, display_mode_esc_sequence_len_counted("\033[31;0m", SIZE_MAX));
+	cl_assert_equal_u(7, display_mode_esc_sequence_len_counted("\033[31;0ma", SIZE_MAX));
+}
+
+/*
+ * Same test as above for the wrapper display_mode_esc_sequence_len().
+ */
+void test_utf8_ansi__sgr_len(void)
+{
+	cl_assert_equal_u(0, display_mode_esc_sequence_len(""));
+
+	cl_assert_equal_u(0, display_mode_esc_sequence_len("\033"));
+	cl_assert_equal_u(0, display_mode_esc_sequence_len("\033["));
+	cl_assert_equal_u(3, display_mode_esc_sequence_len("\033[m"));
+	cl_assert_equal_u(3, display_mode_esc_sequence_len("\033[ma"));
+
+	cl_assert_equal_u(0, display_mode_esc_sequence_len("\033[3"));
+	cl_assert_equal_u(0, display_mode_esc_sequence_len("\033[31"));
+	cl_assert_equal_u(5, display_mode_esc_sequence_len("\033[31m"));
+	cl_assert_equal_u(5, display_mode_esc_sequence_len("\033[31ma"));
+
+	cl_assert_equal_u(0, display_mode_esc_sequence_len("\033[31;"));
+	cl_assert_equal_u(6, display_mode_esc_sequence_len("\033[31;m"));
+	cl_assert_equal_u(6, display_mode_esc_sequence_len("\033[31;ma"));
+
+	cl_assert_equal_u(7, display_mode_esc_sequence_len("\033[31;0m"));
+	cl_assert_equal_u(7, display_mode_esc_sequence_len("\033[31;0ma"));
+}
+
+/*
+ * Test display_mode_esc_sequence_len_counted() with length limits.
+ */
+void test_utf8_ansi__sgr_len_limited(void)
+{
+	/* sequences followed by one non-sequence character */
+	char sgr_1[] = "\033[ma";
+	char sgr_2[] = "\033[31ma";
+	char sgr_3[] = "\033[31;ma";
+	char sgr_4[] = "\033[31;0ma";
+
+	cl_assert_equal_u(0, display_mode_esc_sequence_len_counted(sgr_1, 0));
+	cl_assert_equal_u(0, display_mode_esc_sequence_len_counted(sgr_1, 1));
+	cl_assert_equal_u(0, display_mode_esc_sequence_len_counted(sgr_1, 2));
+	cl_assert_equal_u(3, display_mode_esc_sequence_len_counted(sgr_1, 3));
+	cl_assert_equal_u(3, display_mode_esc_sequence_len_counted(sgr_1, 4));
+
+	cl_assert_equal_u(0, display_mode_esc_sequence_len_counted(sgr_2, 3));
+	cl_assert_equal_u(0, display_mode_esc_sequence_len_counted(sgr_2, 4));
+	cl_assert_equal_u(5, display_mode_esc_sequence_len_counted(sgr_2, 5));
+	cl_assert_equal_u(5, display_mode_esc_sequence_len_counted(sgr_2, 6));
+
+	cl_assert_equal_u(6, display_mode_esc_sequence_len_counted(sgr_3,
+								   sizeof(sgr_3) - 2));
+	cl_assert_equal_u(6, display_mode_esc_sequence_len_counted(sgr_3,
+								   sizeof(sgr_3) - 1));
+
+	cl_assert_equal_u(7, display_mode_esc_sequence_len_counted(sgr_4,
+								   sizeof(sgr_4) - 2));
+	cl_assert_equal_u(7, display_mode_esc_sequence_len_counted(sgr_4,
+								   sizeof(sgr_4) - 1));
+}
diff --git a/utf8.c b/utf8.c
index 96460cc414..b161a5ee48 100644
--- a/utf8.c
+++ b/utf8.c
@@ -16,18 +16,31 @@ struct interval {
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
+	size_t i = 0;
+
+	if (len <= i || s[i++] != '\033')
 		return 0;
-	if (*p++ != '[')
+	if (len <= i || s[i++] != '[')
 		return 0;
-	while (isdigit(*p) || *p == ';')
-		p++;
-	if (*p++ != 'm')
+	while (i < len && (isdigit(s[i]) || s[i] == ';'))
+		i++;
+	if (len <= i || s[i++] != 'm')
 		return 0;
-	return p - s;
+	return i;
+}
+
+/* Same as above, but for a NUL-terminated string "s". */
+size_t display_mode_esc_sequence_len(const char *s)
+{
+	return display_mode_esc_sequence_len_counted(s, SIZE_MAX);
 }
 
 /* auxiliary function for binary search in interval table */
@@ -218,7 +231,8 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 		size_t skip;
 
 		while (skip_ansi &&
-		       (skip = display_mode_esc_sequence_len(string)) != 0)
+		       (skip = display_mode_esc_sequence_len_counted(string,
+							orig + len - string)) != 0)
 			string += skip;
 
 		glyph_width = utf8_width(&string, NULL);
@@ -378,7 +392,8 @@ void strbuf_utf8_replace(struct strbuf *sb_src, int pos, int width,
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

