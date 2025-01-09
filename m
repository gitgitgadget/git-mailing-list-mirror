Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ED221B909
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736431844; cv=none; b=LUC1yZy8m4H1yCbkCrbrgqv4mp6EEexRvCE7AdzW3kzF7gffbov+q1e58RccumeDHX9A2j6Ci9Yvdv4BpXLukeHufilpUCraj5s+5AX/2EmJ70nDiJvqgMvZN0zTbE+uaQz950x57i2fmlXfd2czzvsCWjq6PsPAu0Ig4VPuyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736431844; c=relaxed/simple;
	bh=r11VFusVErmsOZSW4arU0d8CJmUe15Dw1VTWXdDvulE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCLu1RwLzDDZZGOGqJaH0Wd53+T95wkCACIzgv9LdVvDWoToaL5dgRPI2WPJ6wiu7WO5pBi0SDS+L2jwVBOwymc/pwueIP1hgQidAwPV94pLpTYOZx1TNzJVw8Qab+CINSevsez7/Nj45x9hrp9tZ0cWE3UajxvvCRj6UsjmEfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/l2Jc1k; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/l2Jc1k"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d88c355e0dso1519494a12.0
        for <git@vger.kernel.org>; Thu, 09 Jan 2025 06:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736431840; x=1737036640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhC23wdEM98P9VKcs/8SD9VrLwd3BskQLMYuEzu/yIs=;
        b=L/l2Jc1kejdDJl8neyCnap9nH9y2DWuHRup90C0D5fW34pOYpk9SS+U4gSGFbavM8A
         7okp7vz3fCYigpXmh4L05f4Ba4jNshXKfuDXKLM6pOJcBFUJK1Bl+/hZpMdCQ6w2+PkJ
         wNoisCHbPu3i99HdWp1HH2OdqcNpBAgY+/4CbOM/3zHhegtQZCmW5+Irni+Lbfgj9isP
         gFwyW+PaV13DkVimOCk5jrsXAQHArWkCXRqVq1dq/TbjTC5z92/vH04oecrRAkqj/5m+
         wJZCBWP9hjWlNph7em43swD57RfitSOTDAsiIb2MOqAF0vCtyWmKFoDaHMmHLBSUe0+X
         dLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736431840; x=1737036640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhC23wdEM98P9VKcs/8SD9VrLwd3BskQLMYuEzu/yIs=;
        b=cy7zoBu5ZqkqM7m7bAvN/0yqn2qWI6bydb70qjsEJpZdzXwIZK0/pytszB3qfvfp9P
         rHYbbE3sAB/XkKYpxlZl4B8fzxZ0q78zoqTIQE91Koc7t327O3fEMIHKal1UYXNOjds1
         plBDlU23S3fK3DKce0mcGDwQUk51WNGdEQy3BP8mLRR7hFEA4Rhvqj3+8unBhHTaYsgD
         Kw6LdSQi9a+dmzFj0H2K6mBAlj8wG47PlznlLxSWF9BCuvIMqurFqghMmFHm01NandJ2
         r4CLIlW5hPDsqYkcvHusXmZvqDIjj3UpeGpGfJV2jyr2j7PAOHQKlP+/Nv3HLVzc1vA8
         KN0g==
X-Gm-Message-State: AOJu0YxLeb8jiwh8UB9V52zV7CbloOtKPhYebUcvUMO1Eoer7gw0caS0
	8rgFhqW3zW+QR5wxjyogBSykE4/tQgGJ2WkWdUW+CgAW+gYcDQySBz9aYjg84a92RA==
X-Gm-Gg: ASbGncuDXFWIbRtCv4K1iRZb4ET8DLA9mjwtItdiN6vGSfKApP1v6EtT3S50akXBlFE
	3whg/XWr4u86VMcH/E54prrkesjjpRN2Ecw9pAa12NZUDVIIWdV9xiTJuzmjJTDYGzHXyRm1v0+
	xsJOEKYtsNX/fwdVI5yT1MVo8Hke9ykRq4Na0JRkm+sz1GrYPJtzCso9GZAq4RF9ICm2HY9q5PK
	Md/fCxBVbPro57BpmKj6bHk67odd1Rs4irDaOjFuhWF42FCse/Qqknm90NGaoxwslsEDQo=
X-Google-Smtp-Source: AGHT+IGPnLRSKSmoyH9YCDLfdHfJNjt2ZOM+H5R88+8xxkOvVW+UEjtY6KjXHXfBmAD03NdMhH7NTg==
X-Received: by 2002:a05:6402:5255:b0:5d9:b8b:e347 with SMTP id 4fb4d7f45d1cf-5d972e722e6mr6449079a12.32.1736431839850;
        Thu, 09 Jan 2025 06:10:39 -0800 (PST)
Received: from localhost.localdomain ([154.118.74.187])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d99008c37csm653558a12.6.2025.01.09.06.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 06:10:39 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v3] t/unit-tests: convert hash to use clar test framework
Date: Thu,  9 Jan 2025 15:09:52 +0100
Message-ID: <20250109140952.5267-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250108120339.225596-1-kuforiji98@gmail.com>
References: <20250108120339.225596-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt the hash test functions to clar framework by using clar
assertions where necessary. Following the consensus to convert
the unit-tests scripts found in the t/unit-tests folder to clar driven by
Patrick Steinhardt. Test functions are structured as a standalone to
test individual hash string and literal case.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
Changes relative to v2:

  - A couple of fixes to code formatting to match our standards 

Thanks
Seyi
---
Range-diff against v2:
-:  ---------- > 1:  fcc2a376a5 t/unit-tests: convert hash to use clar test framework

 Makefile                            |  2 +-
 t/meson.build                       |  2 +-
 t/unit-tests/{t-hash.c => u-hash.c} | 71 +++++++++++++++++++----------
 3 files changed, 50 insertions(+), 25 deletions(-)
 rename t/unit-tests/{t-hash.c => u-hash.c} (80%)

diff --git a/Makefile b/Makefile
index 97e8385b66..d3011e30f7 100644
--- a/Makefile
+++ b/Makefile
@@ -1338,6 +1338,7 @@ THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/%
 THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
 
 CLAR_TEST_SUITES += u-ctype
+CLAR_TEST_SUITES += u-hash
 CLAR_TEST_SUITES += u-strvec
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
@@ -1345,7 +1346,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
 UNIT_TEST_PROGRAMS += t-example-decorate
-UNIT_TEST_PROGRAMS += t-hash
 UNIT_TEST_PROGRAMS += t-hashmap
 UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-oid-array
diff --git a/t/meson.build b/t/meson.build
index 602ebfe6a2..7b35eadbc8 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1,5 +1,6 @@
 clar_test_suites = [
   'unit-tests/u-ctype.c',
+  'unit-tests/u-hash.c',
   'unit-tests/u-strvec.c',
 ]
 
@@ -41,7 +42,6 @@ test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
   'unit-tests/t-example-decorate.c',
-  'unit-tests/t-hash.c',
   'unit-tests/t-hashmap.c',
   'unit-tests/t-mem-pool.c',
   'unit-tests/t-oid-array.c',
diff --git a/t/unit-tests/t-hash.c b/t/unit-tests/u-hash.c
similarity index 80%
rename from t/unit-tests/t-hash.c
rename to t/unit-tests/u-hash.c
index e62647019b..a0320efe4b 100644
--- a/t/unit-tests/t-hash.c
+++ b/t/unit-tests/u-hash.c
@@ -1,14 +1,11 @@
-#include "test-lib.h"
+#include "unit-test.h"
 #include "hex.h"
 #include "strbuf.h"
 
 static void check_hash_data(const void *data, size_t data_length,
 			    const char *expected_hashes[])
 {
-	if (!check(data != NULL)) {
-		test_msg("BUG: NULL data pointer provided");
-		return;
-	}
+	cl_assert(data != NULL);
 
 	for (size_t i = 1; i < ARRAY_SIZE(hash_algos); i++) {
 		git_hash_ctx ctx;
@@ -19,66 +16,94 @@ static void check_hash_data(const void *data, size_t data_length,
 		algop->update_fn(&ctx, data, data_length);
 		algop->final_fn(hash, &ctx);
 
-		if (!check_str(hash_to_hex_algop(hash, algop), expected_hashes[i - 1]))
-			test_msg("result does not match with the expected for %s\n", hash_algos[i].name);
+		cl_assert_equal_s(hash_to_hex_algop(hash,algop), expected_hashes[i - 1]);
 	}
 }
 
 /* Works with a NUL terminated string. Doesn't work if it should contain a NUL character. */
 #define TEST_HASH_STR(data, expected_sha1, expected_sha256) do { \
 		const char *expected_hashes[] = { expected_sha1, expected_sha256 }; \
-		TEST(check_hash_data(data, strlen(data), expected_hashes), \
-		     "SHA1 and SHA256 (%s) works", #data); \
+		check_hash_data(data, strlen(data), expected_hashes); \
 	} while (0)
 
 /* Only works with a literal string, useful when it contains a NUL character. */
 #define TEST_HASH_LITERAL(literal, expected_sha1, expected_sha256) do { \
 		const char *expected_hashes[] = { expected_sha1, expected_sha256 }; \
-		TEST(check_hash_data(literal, (sizeof(literal) - 1), expected_hashes), \
-		     "SHA1 and SHA256 (%s) works", #literal); \
+		check_hash_data(literal, (sizeof(literal) - 1), expected_hashes); \
 	} while (0)
 
-int cmd_main(int argc UNUSED, const char **argv UNUSED)
+void test_hash__empty_string(void)
 {
-	struct strbuf aaaaaaaaaa_100000 = STRBUF_INIT;
-	struct strbuf alphabet_100000 = STRBUF_INIT;
-
-	strbuf_addstrings(&aaaaaaaaaa_100000, "aaaaaaaaaa", 100000);
-	strbuf_addstrings(&alphabet_100000, "abcdefghijklmnopqrstuvwxyz", 100000);
-
 	TEST_HASH_STR("",
 		"da39a3ee5e6b4b0d3255bfef95601890afd80709",
 		"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
+}
+
+void test_hash__single_character(void)
+{
 	TEST_HASH_STR("a",
 		"86f7e437faa5a7fce15d1ddcb9eaeaea377667b8",
 		"ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb");
+}
+
+void test_hash__multi_character(void)
+{
 	TEST_HASH_STR("abc",
 		"a9993e364706816aba3e25717850c26c9cd0d89d",
 		"ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad");
+}
+
+void test_hash__message_digest(void)
+{
 	TEST_HASH_STR("message digest",
 		"c12252ceda8be8994d5fa0290a47231c1d16aae3",
 		"f7846f55cf23e14eebeab5b4e1550cad5b509e3348fbc4efa3a1413d393cb650");
+}
+
+void test_hash__alphabet(void)
+{
 	TEST_HASH_STR("abcdefghijklmnopqrstuvwxyz",
 		"32d10c7b8cf96570ca04ce37f2a19d84240d3a89",
 		"71c480df93d6ae2f1efad1447c66c9525e316218cf51fc8d9ed832f2daf18b73");
+}
+
+void test_hash__aaaaaaaaaa_100000(void)
+{
+	struct strbuf aaaaaaaaaa_100000 = STRBUF_INIT;
+	strbuf_addstrings(&aaaaaaaaaa_100000, "aaaaaaaaaa", 100000);
 	TEST_HASH_STR(aaaaaaaaaa_100000.buf,
 		"34aa973cd4c4daa4f61eeb2bdbad27316534016f",
 		"cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0");
+	strbuf_release(&aaaaaaaaaa_100000);
+}
+
+void test_hash__alphabet_100000(void)
+{
+	struct strbuf alphabet_100000 = STRBUF_INIT;
+	strbuf_addstrings(&alphabet_100000, "abcdefghijklmnopqrstuvwxyz", 100000);
 	TEST_HASH_STR(alphabet_100000.buf,
 		"e7da7c55b3484fdf52aebec9cbe7b85a98f02fd4",
 		"e406ba321ca712ad35a698bf0af8d61fc4dc40eca6bdcea4697962724ccbde35");
+	strbuf_release(&alphabet_100000);
+}
+
+void test_hash__zero_blob_literal(void)
+{
 	TEST_HASH_LITERAL("blob 0\0",
 		"e69de29bb2d1d6434b8b29ae775ad8c2e48c5391",
 		"473a0f4c3be8a93681a267e3b1e9a7dcda1185436fe141f7749120a303721813");
+}
+
+void test_hash__three_blob_literal(void)
+{
 	TEST_HASH_LITERAL("blob 3\0abc",
 		"f2ba8f84ab5c1bce84a7b441cb1959cfc7093b7f",
 		"c1cf6e465077930e88dc5136641d402f72a229ddd996f627d60e9639eaba35a6");
+}
+
+void test_hash__zero_tree_literal(void)
+{
 	TEST_HASH_LITERAL("tree 0\0",
 		"4b825dc642cb6eb9a060e54bf8d69288fbee4904",
 		"6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321");
-
-	strbuf_release(&aaaaaaaaaa_100000);
-	strbuf_release(&alphabet_100000);
-
-	return test_done();
 }
-- 
2.34.1

