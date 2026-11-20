Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185883;
	b=V6gTcMLLnfrkw8olSG3wWIX9HLq95/AXymb3Vxbriga2USzVgNhLO5/M1tKdDiKiyWwe
	 l2bLrjUNbhTR18kgUQzcSgxro7lhnlK+xVwrbvnTtasxe8lnCW+dVNEl7r7ad7SrUQQcy
	 iD2W1um75AXA07gqSx4QVXU/LR7ebPBtdxEJrpMsd/vZ81/YEa+cDzfevmi+krPqNC+fR
	 d5HqogieMh7dLinLTEKxGSjUgiKnzlqRzK129g8PMlkNklqWfGmhN/QFmbGoDMVY0t/AQ
	 uZGLTYZCK8cFSX5UpqnhKku2FxTQ46YGdoUOIu3de4DzhhotAnMWx0P9LGMOGzi1GTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185883;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=EyTSTA0l2LTwi9VBlXpsvayoJQab6Gmg+pi5FTDmWEg=;
	b=1NzVw8Y9VliAhiSD+q5nchG0KKoYtVB84hqEwZDlt9W6IKzaDYtydqUii2QVCGDXnJ72
	 qeFVa+vuMImvaAOYqkiQfXgS4aUT3BPMVjtlL0IcKNdeU544Nnl1ud3U5EfOpH92AcNfv
	 BOt3uO36zShFLtp73oNfyiWFWV1dWDX5lV8ORwu6RngYw/lE8/kBqPN0yxhF/9qvEa/Yz
	 TYpiDVaf6KNbc15LGQfy/qbMxq9LkvPEKty7VzbsJW/56oxY8X0h1dt151M+f655SsNet
	 cBGFFKLB9lSd9QNgieoQbX+5+21v51CraIyBQTh1DJWtCd6rHLsEmNwHsYOTzeYBbWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=thHZDnTy;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5E8606A336
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 14:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C5E8606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=thHZDnTy
Received: from lena.gouders.net (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AKEiRtA2079849
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 20 Nov 2026 15:44:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795185871; bh=EyTSTA0l2LTwi9VBlXpsvayoJQab6Gmg+pi5FTDmWEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=thHZDnTyGfJ18QilK4VrCtpwr/EN0jjmg/7vpKSY7GFJPPmZ6VEuf0XZmd4MSLCMR
	 KC3EYLdplr+KCfYrdjj23lzv9YfQf7wEp80QAsoE5oqlNLiuPwWrpqFItcZfGcXHZo
	 xkdvFHYphnbgijRd5Si5Gi85rek4cibe3N9Jh6c4=
From: Dirk Gouders <dirk@gouders.net>
Date: Fri, 20 Nov 2026 15:44:27 +0100
Subject: [PATCH v3 4/4] utf8: respect boundaries in utf8_strnwidth()
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
Message-Id: <20261120-master-v3-4-d28e8c75d26d@gouders.net>
References: <20261120-master-v3-0-d28e8c75d26d@gouders.net>
In-Reply-To: <20261120-master-v3-0-d28e8c75d26d@gouders.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dirk Gouders <dirk@gouders.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5285; i=dirk@gouders.net;
 h=from:subject:message-id; bh=hSD6PmFkXUvDRFbtWF0Z6Kge/u0nq7eV7mIIBefU5Yo=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLIZYs5YPMzy+OO3cQO/uLn8MaY6WWGDs7eUJXdvVHa78
 vBHvI98J+MEFgZGLoYqMUWWpZOK7NJUVrwo+6aaCTOIlQlkirRIAwMQsDDw5SbmlRrpGOmZahvq
 GQIZOkYOEDl+Bo30gnSH9PzSlNSiYr281BJHU0sjcyNjVzMzIxNHC1cLczM3MyNTM0tHE1NzV0c
 XM2NzY1MTR0tnBi5OAZh11/3Z/+muU/3/cbtYuGCexSRRwe3aR1RL7hTsv3NO0Hjnect1AqEbDv
 hzpuUENHXXrHijq/1k17yCBZK39hjmrD985preY4nthzME9LatXrnZ36BA3cBWQF42P/R+oF9A0
 s5QnTPvuk5nCO92nHoqdJfjaldfhq2ztO9cNn116sMFh6QrPYl8t3/obJsok3T3s/HnY2tCWs+U
 bJTUcN94xL/reH/exNlrHINiPz810PjlLmm6UYgn68qftm0JtkXxrwMzRPZOUj/wm3mH4q78Y36
 fXcRX9W0Oisq4wNbgZHIzMyL5RfLJirN//dxcF724oKkg8fLd7YeTvFec8Vv97JOPxf+E8KdH54
 X1vT6S6GLu9gcA
X-Developer-Key: i=dirk@gouders.net; a=openpgp;
 fpr=943B4FA3CAB8EBC55754E5EA0DA2395F431875F6

utf8_strnwidth() can be called with boundaries that effectively cause
incomplete multibyte sequences and we should return "len" in such
cases.

But, utf8_width is used without its optional boundary argument and
will thus work beyond the given boundary.

Fix this by using the boundary argument for utf8_width.
Add some tests that cover such situations.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 t/unit-tests/u-utf8-ansi.c  | 26 ++++++++++++++++++++++++++
 t/unit-tests/u-utf8-width.c |  9 +++++++++
 utf8.c                      | 40 +++++++++++++++++++++++++++++-----------
 utf8.h                      |  1 +
 4 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/t/unit-tests/u-utf8-ansi.c b/t/unit-tests/u-utf8-ansi.c
index cb75c8612b..909643d07d 100644
--- a/t/unit-tests/u-utf8-ansi.c
+++ b/t/unit-tests/u-utf8-ansi.c
@@ -2,6 +2,32 @@
 #include "utf8.h"
 #include "strbuf.h"
 
+/*
+ * Test the greedy function display_mode_esc_sequence_len_all().
+ */
+void test_utf8_ansi__sgr_len_greedy(void)
+{
+	char *s1 = (char *)"no ESC sequence";
+	char *s2 = (char *)"\033[m";
+	char *s3 = (char *)"\033[0;31m";
+	char *s4 = (char *)"\033[0m\033[31m";
+
+	/* no sequences */
+	cl_assert_equal_i(0, display_mode_esc_sequence_len_all("", ""));
+	cl_assert_equal_i(0, display_mode_esc_sequence_len_all(s1, s1 + 5));
+
+	/* single sequences */
+	cl_assert_equal_i(3, display_mode_esc_sequence_len_all(s2, s2 + 3));
+	cl_assert_equal_i(7, display_mode_esc_sequence_len_all(s3, s3 + 7));
+	cl_assert_equal_i(0, display_mode_esc_sequence_len_all(s3, s3 + 3));
+
+	/* multiple sequences */
+	cl_assert_equal_i(4, display_mode_esc_sequence_len_all(s4, s4 + 4));
+	cl_assert_equal_i(9, display_mode_esc_sequence_len_all(s4, s4 + 9));
+	cl_assert_equal_i(0, display_mode_esc_sequence_len_all(s4, s4 + 3));
+	cl_assert_equal_i(4, display_mode_esc_sequence_len_all(s4, s4 + 8));
+}
+
 /*
  * Test display_mode_esc_sequence_len() for NUL terminated strings.
  */
diff --git a/t/unit-tests/u-utf8-width.c b/t/unit-tests/u-utf8-width.c
index 5e2b636db9..c4df4dd6a6 100644
--- a/t/unit-tests/u-utf8-width.c
+++ b/t/unit-tests/u-utf8-width.c
@@ -2,6 +2,15 @@
 #include "utf8.h"
 #include "strbuf.h"
 
+/*
+ * Test utf8_strnwidth for cjk characters invalidated by len argument.
+ */
+void test_utf8_width__strnwidth_cjk_chopped(void)
+{
+	cl_assert_equal_i(1, utf8_strnwidth("三bytes long, 二columns wide", 1, 1));
+	cl_assert_equal_i(2, utf8_strnwidth("三bytes long, 二columns wide", 3, 1));
+}
+
 /*
  * Test utf8_strnwidth for strings with SGR sequences and corner case length
  * arguments.
diff --git a/utf8.c b/utf8.c
index 493f723e3b..9478985cbb 100644
--- a/utf8.c
+++ b/utf8.c
@@ -39,6 +39,26 @@ size_t display_mode_esc_sequence_len(const char *start, const char *end)
 	return p - start;
 }
 
+/*
+ * Count the lenght of all leading ANSI display mode escape sequences that
+ * are a prefix of the string at start up to end.
+ */
+size_t display_mode_esc_sequence_len_all(const char *start, const char *end)
+{
+	size_t seq_len = 0;
+
+	while (start + seq_len < end) {
+		size_t count = display_mode_esc_sequence_len(start + seq_len, end);
+
+		if (!count)
+			break;
+
+		seq_len += count;
+	}
+
+	return seq_len;
+}
+
 /* auxiliary function for binary search in interval table */
 static int bisearch(ucs_char_t ucs, const struct interval *table, int max)
 {
@@ -224,17 +244,18 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 
 	while (string && string < end) {
 		int glyph_width;
-		size_t skip;
+		size_t remainder;
 
 		if (skip_ansi) {
-			while ((skip = display_mode_esc_sequence_len(string, end)))
-				string += skip;
+			string += display_mode_esc_sequence_len_all(string, end);
 
 			if (string >= end)
 				break;
 		}
 
-		glyph_width = utf8_width(&string, NULL);
+		remainder = end - string;
+
+		glyph_width = utf8_width(&string, &remainder);
 		if (glyph_width > 0)
 			width += glyph_width;
 	}
@@ -311,10 +332,8 @@ void strbuf_add_wrapped_text(struct strbuf *buf,
 
 	for (;;) {
 		char c;
-		size_t skip;
 
-		while ((skip = display_mode_esc_sequence_len(text, end)))
-			text += skip;
+		text += display_mode_esc_sequence_len_all(text, end);
 
 		c = *text;
 		if (!c || isspace(c)) {
@@ -392,10 +411,9 @@ void strbuf_utf8_replace(struct strbuf *sb_src, int pos, int width,
 		int glyph_width;
 		size_t n;
 
-		while ((n = display_mode_esc_sequence_len(src, end))) {
-			strbuf_add(&dst, src, n);
-			src += n;
-		}
+		n = display_mode_esc_sequence_len_all(src, end);
+		strbuf_add(&dst, src, n);
+		src += n;
 
 		if (src >= end)
 			break;
diff --git a/utf8.h b/utf8.h
index 7eb7bf042a..fdde5af782 100644
--- a/utf8.h
+++ b/utf8.h
@@ -6,6 +6,7 @@ struct strbuf;
 typedef unsigned int ucs_char_t;  /* assuming 32bit int */
 
 size_t display_mode_esc_sequence_len(const char *start, const char *end);
+size_t display_mode_esc_sequence_len_all(const char *start, const char *end);
 int utf8_width(const char **start, size_t *remainder_p);
 int utf8_strnwidth(const char *string, size_t len, int skip_ansi);
 int utf8_strwidth(const char *string);

-- 
2.55.0

