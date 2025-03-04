Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140221FF5FB
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088027; cv=none; b=DHpWkq+YUF8j5GHhr5Bei98yOYW08RITsx6xZ24zW2FiPauD4mkpfHIWSbUkw3MsSEBO5Ug1ELusR5/lLNgTG4h6IrJ5iwcK4rlYoXROFv/giYsjNqcl9oWwjpBaoR8UPp0DvcrOw08q3gVFNKIVC8b36kN7AXmWqjVqUouzrJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088027; c=relaxed/simple;
	bh=mB30tgwIOR2srLPRGaYHZJuqHzWlly3vmeHXkOdTCHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9LBB7/Nsrsn5ie22OpgixOofNFpAJyQEvAb1XXpW66v6QJGEDsTAQ8ARYgtai4VUXMPwa3OqKZWSyBIzNV7OR7gKSdykZOX57Ccmfb4J/8QP0B4KwwPkEW7UqhS1wPc561vkZz/r2HPuwmUim+l2WHBJ5cWfWNkL6LvcIrhWDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/jEiKwk; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/jEiKwk"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso2878600f8f.3
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 03:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741088022; x=1741692822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BA1tr1Ty5Y2XeG96QWL49R6VfTP3i5pA11F2TRT1A90=;
        b=R/jEiKwkkuPXtRuikqTKuXAbj9KPnIik2QXgDOJvFdk+mCkbjUE66rTcAKzDW8hkRJ
         hgKTGXccEafaI/V0rmkZnkrEeFJeDKDbV6ryzcl8bS7k526WDTMgM+wzejhIAhLKaUao
         e1Cpyp7Fi/l5BZdV3xm9d4F32aLEn369jwoNK92T8PhmSOlhhz69/NtmP3jZ6BoHI3xM
         GxK/HSk+qADhiUg7caj98OJbJULBU8PK2TIJqY7Zx3xZ8uE0av3pemvEer4j+oYk/2EA
         auGIVy59bT76NGUdwPN+yxy1wQCtAsK5RqywDKDGRj0ayRHkBvSO9DxhTbDfoJLMqMZO
         0Kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741088022; x=1741692822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BA1tr1Ty5Y2XeG96QWL49R6VfTP3i5pA11F2TRT1A90=;
        b=ZEI05RxxL/IfdAWubfNHEmsf6eNIhFf05LlP6HRhwHlKbd82BDVjBnx2qQNATJgcIA
         esA2DmDpnpHCb8Jbm6FR4s6HTi/o25kha4cvoEfO4zJVu0EGG7N66U+U5uxhRuGPFvOL
         xqw9QBC0uollSzcMMXW3ezFFJnZ4BFJXmdfRcsmhBIo58lYMVXD1p0TZV5dy4qfqzwj9
         S0dwvIkWSrg3J0aBI1u81yPIeAY+Q0/fcGEI3hZeQeYSJCJ66UAO27Gpd/GxY9BNrgBd
         Bd9kK//E+dReyaNIrbklwFEFRB7snzimmd83c3QHKCocb7tR9Y22oHFzB+IargMbvh7Q
         hO8g==
X-Gm-Message-State: AOJu0Yze6nK9ufq+hnEH5mqYJlBjrlZzx8IvdJGCcozWaN13h2lut0Cz
	s5FydDEDZlpF03+j3yU+XfjZ69pbRj36zlT/gXf1RxfLUtLepVmfHjJLOjPiaTY=
X-Gm-Gg: ASbGncteSbB3WS80bfkFSaB7+71b/Xfs+cwCHTk2kIbDPLcb9t6xt5yNzRE9gchIQoS
	LK4f9BQBhGiYstzvfcUsuF6Yyf6PwNiNayYMGsBFESms8etoEcEBUO2U3EoeFclpzZDH+u7WCJM
	OPctFhD+nJJKc+aw2GTvAoeYlBh0zgV8y3hk1wlhpttkleXlsAUCEO5u20S1B2vt+XAjEF/g2Va
	p/fev4bvbqSblnC/OqBbVafoNkw08kbF1yNT1yz4MdPGqDqyO+PHhahLlEo6vu4IcFocOS5gc95
	XbEFNb598Rhxn2DdoCWDGmFh9sSQaMrA3up/S2lAu6YTUnC+Z8RC38pMLR8=
X-Google-Smtp-Source: AGHT+IGIrjt3+PUXhF5WC+TMO/Ox+YjF28VINOMcqQoQiz6C/gIpduegMMvUEy4VJLDe6tjPlNf6JQ==
X-Received: by 2002:a05:6000:1789:b0:391:ab2:9e87 with SMTP id ffacd0b85a97d-3910ab2a230mr5261162f8f.6.1741088022459;
        Tue, 04 Mar 2025 03:33:42 -0800 (PST)
Received: from localhost.localdomain ([154.118.41.125])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-390e47b7d12sm17764128f8f.58.2025.03.04.03.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:33:42 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 2/2] t/unit-tests: convert urlmatch-normalization test to clar
Date: Tue,  4 Mar 2025 12:33:23 +0100
Message-ID: <20250304113323.10564-3-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250304113323.10564-1-kuforiji98@gmail.com>
References: <20250304113323.10564-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt urlmatch-normalization test file to use clar testing framework by
using clar assertions where necessary.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                                      |  2 +-
 t/meson.build                                 |  2 +-
 ...alization.c => u-urlmatch-normalization.c} | 60 ++++++-------------
 3 files changed, 20 insertions(+), 44 deletions(-)
 rename t/unit-tests/{t-urlmatch-normalization.c => u-urlmatch-normalization.c} (84%)

diff --git a/Makefile b/Makefile
index 9cb68aaa61..a4787bff5d 100644
--- a/Makefile
+++ b/Makefile
@@ -1362,6 +1362,7 @@ CLAR_TEST_SUITES += u-strbuf
 CLAR_TEST_SUITES += u-strcmp-offset
 CLAR_TEST_SUITES += u-strvec
 CLAR_TEST_SUITES += u-trailer
+CLAR_TEST_SUITES += u-urlmatch-normalization
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
@@ -1378,7 +1379,6 @@ UNIT_TEST_PROGRAMS += t-reftable-reader
 UNIT_TEST_PROGRAMS += t-reftable-readwrite
 UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-reftable-stack
-UNIT_TEST_PROGRAMS += t-urlmatch-normalization
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
diff --git a/t/meson.build b/t/meson.build
index 560aa9a1f1..e6ac23df11 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -10,6 +10,7 @@ clar_test_suites = [
   'unit-tests/u-strcmp-offset.c',
   'unit-tests/u-strvec.c',
   'unit-tests/u-trailer.c',
+  'unit-tests/u-urlmatch-normalization.c',
 ]
 
 clar_sources = [
@@ -60,7 +61,6 @@ unit_test_programs = [
   'unit-tests/t-reftable-readwrite.c',
   'unit-tests/t-reftable-record.c',
   'unit-tests/t-reftable-stack.c',
-  'unit-tests/t-urlmatch-normalization.c',
 ]
 
 foreach unit_test_program : unit_test_programs
diff --git a/t/unit-tests/t-urlmatch-normalization.c b/t/unit-tests/u-urlmatch-normalization.c
similarity index 84%
rename from t/unit-tests/t-urlmatch-normalization.c
rename to t/unit-tests/u-urlmatch-normalization.c
index 1769c357b9..39f6e1ba26 100644
--- a/t/unit-tests/t-urlmatch-normalization.c
+++ b/t/unit-tests/u-urlmatch-normalization.c
@@ -1,12 +1,11 @@
-#include "test-lib.h"
+#include "unit-test.h"
 #include "urlmatch.h"
 
 static void check_url_normalizable(const char *url, unsigned int normalizable)
 {
 	char *url_norm = url_normalize(url, NULL);
 
-	if (!check_int(normalizable, ==, url_norm ? 1 : 0))
-		test_msg("input url: %s", url);
+	cl_assert_equal_i(normalizable, url_norm ? 1 : 0);
 	free(url_norm);
 }
 
@@ -14,8 +13,7 @@ static void check_normalized_url(const char *url, const char *expect)
 {
 	char *url_norm = url_normalize(url, NULL);
 
-	if (!check_str(url_norm, expect))
-		test_msg("input url: %s", url);
+	cl_assert_equal_s(url_norm, expect);
 	free(url_norm);
 }
 
@@ -26,13 +24,9 @@ static void compare_normalized_urls(const char *url1, const char *url2,
 	char *url2_norm = url_normalize(url2, NULL);
 
 	if (equal) {
-		if (!check_str(url1_norm, url2_norm))
-			test_msg("input url1: %s\n  input url2: %s", url1,
-				 url2);
-	} else if (!check_int(strcmp(url1_norm, url2_norm), !=, 0)) {
-		test_msg(" normalized url1: %s\n   normalized url2: %s\n"
-			 "  input url1: %s\n  input url2: %s",
-			 url1_norm, url2_norm, url1, url2);
+		cl_assert_equal_s(url1_norm, url2_norm);
+	} else {
+		cl_assert(strcmp(url1_norm, url2_norm) != 0);
 	}
 	free(url1_norm);
 	free(url2_norm);
@@ -43,14 +37,12 @@ static void check_normalized_url_length(const char *url, size_t len)
 	struct url_info info;
 	char *url_norm = url_normalize(url, &info);
 
-	if (!check_int(info.url_len, ==, len))
-		test_msg("     input url: %s\n  normalized url: %s", url,
-			 url_norm);
+	cl_assert_equal_i(info.url_len, len);
 	free(url_norm);
 }
 
 /* Note that only "file:" URLs should be allowed without a host */
-static void t_url_scheme(void)
+void test_urlmatch_normalization__scheme(void)
 {
 	check_url_normalizable("", 0);
 	check_url_normalizable("_", 0);
@@ -73,7 +65,7 @@ static void t_url_scheme(void)
 	check_normalized_url("AbCdeF://x.Y", "abcdef://x.y/");
 }
 
-static void t_url_authority(void)
+void test_urlmatch_normalization__authority(void)
 {
 	check_url_normalizable("scheme://user:pass@", 0);
 	check_url_normalizable("scheme://?", 0);
@@ -109,7 +101,7 @@ static void t_url_authority(void)
 	check_url_normalizable("scheme://invalid....:[", 0);
 }
 
-static void t_url_port(void)
+void test_urlmatch_normalization__port(void)
 {
 	check_url_normalizable("xyz://q@some.host:", 1);
 	check_url_normalizable("xyz://q@some.host:456/", 1);
@@ -139,7 +131,7 @@ static void t_url_port(void)
 	check_url_normalizable("xyz://[::1]:030f/", 0);
 }
 
-static void t_url_port_normalization(void)
+void test_urlmatch_normalization__port_normalization(void)
 {
 	check_normalized_url("http://x:800", "http://x:800/");
 	check_normalized_url("http://x:0800", "http://x:800/");
@@ -154,7 +146,7 @@ static void t_url_port_normalization(void)
 	check_normalized_url("https://x:000000443", "https://x/");
 }
 
-static void t_url_general_escape(void)
+void test_urlmatch_normalization__general_escape(void)
 {
 	check_url_normalizable("http://x.y?%fg", 0);
 	check_normalized_url("X://W/%7e%41^%3a", "x://w/~A%5E%3A");
@@ -164,7 +156,7 @@ static void t_url_general_escape(void)
 	check_normalized_url("X://W?!", "x://w/?!");
 }
 
-static void t_url_high_bit(void)
+void test_urlmatch_normalization__high_bit(void)
 {
 	check_normalized_url(
 		"x://q/\x01\x02\x03\x04\x05\x06\x07\x08\x0e\x0f\x10\x11\x12",
@@ -198,26 +190,26 @@ static void t_url_high_bit(void)
 		"x://q/%F0%F1%F2%F3%F4%F5%F6%F7%F8%F9%FA%FB%FC%FD%FE%FF");
 }
 
-static void t_url_utf8_escape(void)
+void test_urlmatch_normalization__utf8_escape(void)
 {
 	check_normalized_url(
 		"x://q/\xc2\x80\xdf\xbf\xe0\xa0\x80\xef\xbf\xbd\xf0\x90\x80\x80\xf0\xaf\xbf\xbd",
 		"x://q/%C2%80%DF%BF%E0%A0%80%EF%BF%BD%F0%90%80%80%F0%AF%BF%BD");
 }
 
-static void t_url_username_pass(void)
+void test_urlmatch_normalization__username_pass(void)
 {
 	check_normalized_url("x://%41%62(^):%70+d@foo", "x://Ab(%5E):p+d@foo/");
 }
 
-static void t_url_length(void)
+void test_urlmatch_normalization__length(void)
 {
 	check_normalized_url_length("Http://%4d%65:%4d^%70@The.Host", 25);
 	check_normalized_url_length("http://%41:%42@x.y/%61/", 17);
 	check_normalized_url_length("http://@x.y/^", 15);
 }
 
-static void t_url_dots(void)
+void test_urlmatch_normalization__dots(void)
 {
 	check_normalized_url("x://y/.", "x://y/");
 	check_normalized_url("x://y/./", "x://y/");
@@ -244,7 +236,7 @@ static void t_url_dots(void)
  * "http://foo" specifies neither a user name nor a password.
  * So they should not be equivalent.
  */
-static void t_url_equivalents(void)
+void test_urlmatch_normalization__equivalents(void)
 {
 	compare_normalized_urls("httP://x", "Http://X/", 1);
 	compare_normalized_urls("Http://%4d%65:%4d^%70@The.Host", "hTTP://Me:%4D^p@the.HOST:80/", 1);
@@ -253,19 +245,3 @@ static void t_url_equivalents(void)
 	compare_normalized_urls("https://@x.y/^/../abc", "httpS://@x.y:0443/abc", 1);
 	compare_normalized_urls("https://@x.y/^/..", "httpS://@x.y:0443/", 1);
 }
-
-int cmd_main(int argc UNUSED, const char **argv UNUSED)
-{
-	TEST(t_url_scheme(), "url scheme");
-	TEST(t_url_authority(), "url authority");
-	TEST(t_url_port(), "url port checks");
-	TEST(t_url_port_normalization(), "url port normalization");
-	TEST(t_url_general_escape(), "url general escapes");
-	TEST(t_url_high_bit(), "url high-bit escapes");
-	TEST(t_url_utf8_escape(), "url utf8 escapes");
-	TEST(t_url_username_pass(), "url username/password escapes");
-	TEST(t_url_length(), "url normalized lengths");
-	TEST(t_url_dots(), "url . and .. segments");
-	TEST(t_url_equivalents(), "url equivalents");
-	return test_done();
-}
-- 
2.47.0.86.g15030f9556

