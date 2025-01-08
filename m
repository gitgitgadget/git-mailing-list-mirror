Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F3319AD90
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736337845; cv=none; b=G08R8NJxrb8+eoP6gggvW+XB6CACWOQn+l3JF3b4bxiA1PN1v4HITdSWeEribBlhwuv2IMeHZW/xrzPHggqkHHOTXbRypnHdDx75Cy7zEszLW019Wf3vEFd8X786mmWb2Dwp6SYcomQ4rC7MzUlN3orcBwC3mv1Fy13QEZsbMHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736337845; c=relaxed/simple;
	bh=sAQc+4+HyJOAJSnsC+6W67EWauJOngD2/WxL3+6ylCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljW3l1OIhEcZvHP3nqbWvpongrTJlEtnMRFKIIqCO88ha7FuOdk+FpzO4ylNhnGITgKzmHyYkpqAg5DBZmSNq1XuFlEQW8yWdjaaO8Cdrvg/J3DilB3mNNhA3KeOFCLuqQCME7DteoO77xAQ8rxhFegIA1XZokCsE87hvPFLDTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8KGwtc7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8KGwtc7"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaef00ab172so1942962866b.3
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 04:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736337842; x=1736942642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2ZQqLtJaKUXsJ2lgFWSwCnBIHzTBs2v89CAGmFjPwY=;
        b=N8KGwtc7N+H8QBISC1WCNJUrvLaWZDlMXMyMQIvs7VFZYWQ4/0kLlKDNcGsbEYsElL
         xNLuA0VY499IJ5LjJHewFXa0rH7u/50/PA4ppaK98Z4ssEMYNFipNG35PSeibQ1W2mKD
         mYeOkc3QdSJKQ3e1OloeGrfybATwKbmSbX9OB5cYeowfw/SK4GMQD1ta/onhwujvczRw
         gXHdypUjf5rw938aPxt6VafR+SxEycHhht7m/cYayyzkIzMIJY3H1qUUHqheVVONHkG/
         L+b8iG0aeqyuizPpkPIR3q6xLriPHq2x15KqgWg7O8zgAbOQ5gILJZdevQftMuaCgv+/
         GFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736337842; x=1736942642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2ZQqLtJaKUXsJ2lgFWSwCnBIHzTBs2v89CAGmFjPwY=;
        b=ohUIqzai+wL1CCH8TppUrZUF4yZpACU8/6WfoyLtLfx+TzN077YPS1uCS+528EjBYR
         v/CjZkuY3RneFa8MPjn6zjBUu7JnaBziYEC4eQGoTDe2YgBRIsFitpJ+HC+8bfsWACXV
         6jUWPhFzN6b3BxHs4odsLYBVZh0BTbBpmzOLHcq9MDkNjFzhsO3Na8wbRmLH/mmRVTL3
         H/k40OG+z6Aw1I3MVChDEKU5SAgib2Rt5laapiaFaqC6CtOY/77OyGoa+SXfIXZ0UvJn
         kisDkMHVtTQWaYe/JWhly02mwFcYqm7tC45uaDhofcKeCgkRGbLrFJiyCXIR2nfpHjZt
         1OQg==
X-Gm-Message-State: AOJu0YxXEOqCiDvgozDdef26aEAEOA0kLBQgQhM2Np70qt8c++t1Bnb4
	jyQIN3c1AdE+gNO6bGF/oPQOhIRY/yKJOQuIR/9Bb6nho9D6G0UEi9SuiH0ZK3VKyQ==
X-Gm-Gg: ASbGnctkZY6psok2cGljxKCRN0H7QvK1QEqj8H0ksdqu7y6rZa05UAFj99pEIT99ORW
	F/yyTDGIvMGUclZVCvM+25E3EJeXmFKvmh4RyxJ/bA6nFvnlHibd4iIfNp5TqbRAZ+eygu9aMI0
	V0wnXFl8v05ueW5RO2Ma1Wrib8uftNIrVUMOBM5bAf4IhFqxRVQwrygOomcukKn/LTuy12F3xsn
	J+MFWibOwasUxuv5rBvt7hpT+TMlAolIpVtvPw4mIXLGIMX2WH/5rwP7pxl2oJoNgiG
X-Google-Smtp-Source: AGHT+IGU2ajJI8mGeR50aS+H5Bie9QGqptT6znDOtav2wY+eThBldEOHGlkAljlIUK+z7DnGFhmQSw==
X-Received: by 2002:a05:6402:43ce:b0:5d3:f55f:8349 with SMTP id 4fb4d7f45d1cf-5d972e7107dmr5419264a12.33.1736337840033;
        Wed, 08 Jan 2025 04:04:00 -0800 (PST)
Received: from localhost.localdomain ([102.89.22.24])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f192sm25932961a12.35.2025.01.08.04.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:03:59 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 1/1] t/unit-tests: convert hash to use clar test framework
Date: Wed,  8 Jan 2025 13:03:39 +0100
Message-ID: <20250108120339.225596-2-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250108120339.225596-1-kuforiji98@gmail.com>
References: <20250107091932.126673-1-kuforiji98@gmail.com>
 <20250108120339.225596-1-kuforiji98@gmail.com>
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
 Makefile                            |  2 +-
 t/meson.build                       |  2 +-
 t/unit-tests/{t-hash.c => u-hash.c} | 75 +++++++++++++++++++----------
 3 files changed, 52 insertions(+), 27 deletions(-)
 rename t/unit-tests/{t-hash.c => u-hash.c} (79%)

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
index 602ebfe6a2..d722bc7dff 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1,6 +1,7 @@
 clar_test_suites = [
   'unit-tests/u-ctype.c',
   'unit-tests/u-strvec.c',
+  'unit-tests/u-hash.c',
 ]
 
 clar_sources = [
@@ -41,7 +42,6 @@ test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
   'unit-tests/t-example-decorate.c',
-  'unit-tests/t-hash.c',
   'unit-tests/t-hashmap.c',
   'unit-tests/t-mem-pool.c',
   'unit-tests/t-oid-array.c',
diff --git a/t/unit-tests/t-hash.c b/t/unit-tests/u-hash.c
similarity index 79%
rename from t/unit-tests/t-hash.c
rename to t/unit-tests/u-hash.c
index e62647019b..e5e2d2e033 100644
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
-	} while (0)
+		check_hash_data(data, strlen(data), expected_hashes); \
+	} while(0)
 
 /* Only works with a literal string, useful when it contains a NUL character. */
 #define TEST_HASH_LITERAL(literal, expected_sha1, expected_sha256) do { \
 		const char *expected_hashes[] = { expected_sha1, expected_sha256 }; \
-		TEST(check_hash_data(literal, (sizeof(literal) - 1), expected_hashes), \
-		     "SHA1 and SHA256 (%s) works", #literal); \
-	} while (0)
+		check_hash_data(literal, (sizeof(literal) - 1), expected_hashes); \
+	} while(0)
 
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

