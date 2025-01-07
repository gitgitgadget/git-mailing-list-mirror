Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485DE1E0499
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736241594; cv=none; b=M6vc5xl56A5hRS3PPXZCInXxybmn/uDxqVqGaERm8oaYZ/5D9hnCp4zISfYRfrHB2nFc6DLjVNHbzPdYSlUAs9avDgUZCe+NpwOGjNTFyK5kp6PjvUMQBCj6PxPmr6Gi252aYAD2j9JBJ1ZymAc1qWTS/fbfnezzXG9rEnSpq7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736241594; c=relaxed/simple;
	bh=MvNgWJkvd5BNMD2i7IVfP4VD5XUvt4tWzQATYrJ1EJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKyUXf1k3uguSoDDkBDd9JHSa6ZJJBT7rwLK49OtOHCW7eUvxD51W8TDVFw0uGzThTNZ99rwo6CPIvRPLG2x2nfKzUJbLwjJkrkke5XWo45d0JfBrLuRJZyEoOzkd/qfUE36ra3am/Ze9fLhVDiAAqtbLfMR7kHZn0Vt7p6swTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cE1jidww; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE1jidww"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aafc9d75f8bso207452466b.2
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 01:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736241589; x=1736846389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBqP/2wRPItIOoMycH4q2goZZoaIIRY6fvyVD29hUqY=;
        b=cE1jidww9Sjorniq7A3JMtbhcARzp/GQ+moCATQKa81P7YMD70Y9xQRcXSMgOJhtzy
         yDu4R1PreqcZecJOGf7IKT53eBdC52fG3gP3Ay1V7sEF0T49x+ibKNqTn7lbFOG+k9vP
         1y91o1Nzb9EAhjzECCqd97IuHgJBoJxxn1M/IM9pukL6GdypLYAQXbuCjU3tgpL35eXw
         W5Pv3i8lYHBBYdoVjinrbAk4hys053tAyDfnTmAD57274QBPgiU00geV3YsT9hqeIGZn
         OVu7sTU1XPEnXDl5oksPuU8D8JVAK8whDXIhw1WOmKSAhbeXe7xQZZ58CEuaewT39v+z
         3J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736241589; x=1736846389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBqP/2wRPItIOoMycH4q2goZZoaIIRY6fvyVD29hUqY=;
        b=iwS94OqItrrciryFAypa+nUIs55R2Kjbz0qdfBQ1DDiO8HfOb/452Ls8P2BNNtTjOZ
         Y+YMsljmQcBASqEJX/huIGOOxt3wyyOf2o1wC5jvI4CMfeuzknOrqVls8Yn/bA8+fsEe
         5eO1VnEihTKgW7NexvW6/aRXsOMQdYgANM5BZpSEPyJJooUWyFgSrhegRRaE+FbvGz8r
         2P/NS1NN7C3vOR9Bft9SfZzJ7dHXOBFJ6894Sg+843w2LyVrXSE93eflX8RgZ+NLrsGa
         +MjU9mYTJs+Gfw7AV0Fmfbiys96S+45kqsqi0k4R7FkFcPgRcQkCUZMsi7akCKQaQt/J
         A9Dg==
X-Gm-Message-State: AOJu0Yzq3d8CejJYCrH7medCQ/O3UPqkAgLm5OXjQWbxg8F7mFuv7Ztl
	A/eI718ZDC2tj/HbwMazvXBkzUk8P8Z5uIMXfgQkewpmzGqA4O/QhDtXSyirHy+7aA==
X-Gm-Gg: ASbGncuHnDv3y2MUi3RfIZu68vmb8nWksqdspa3M8Pz1ppbEJqfYcDTJHGew5qaojl8
	h5w+qlTtJEAuO6LPGkRmjAUUeE9obzw/ySAAjMdeajU5abNgdAS7fVfqdn9OrbSiB+tw3atilf2
	LksOzCZ8Sof/0Mcu2sIBoF0Jj2nMQBghp9VRwypxfrXplaW+IJaYeWo4kzSQRWjoYqf9wgEobd5
	rM5veOryJNWDilDr6nBk4Dt8YvoAIes7XCPB1ZTfu4zA0HVRylsaEkdmMZZS5GuwBVJ6Fw=
X-Google-Smtp-Source: AGHT+IGLU/o4W2Cjho0uboqHE33fWa6sK+V8y8s0CKpoCjVMbCPaVoRzKCWizwSgXV8DYOTIJ/MBiA==
X-Received: by 2002:a17:907:9722:b0:aa6:668b:2733 with SMTP id a640c23a62f3a-aac2cc722acmr6103804566b.33.1736241589070;
        Tue, 07 Jan 2025 01:19:49 -0800 (PST)
Received: from localhost.localdomain ([154.118.62.160])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0f06deb8sm2337222566b.190.2025.01.07.01.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:19:48 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 2/2] t/unit-tests: convert hash to use clar test framework
Date: Tue,  7 Jan 2025 10:19:32 +0100
Message-ID: <20250107091932.126673-3-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250107091932.126673-1-kuforiji98@gmail.com>
References: <20250107091932.126673-1-kuforiji98@gmail.com>
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
 Makefile              |  2 +-
 t/meson.build         |  2 +-
 t/unit-tests/t-hash.c | 84 ------------------------------------------
 t/unit-tests/u-hash.c | 85 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+), 86 deletions(-)
 delete mode 100644 t/unit-tests/t-hash.c
 create mode 100644 t/unit-tests/u-hash.c

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
diff --git a/t/unit-tests/t-hash.c b/t/unit-tests/t-hash.c
deleted file mode 100644
index e62647019b..0000000000
--- a/t/unit-tests/t-hash.c
+++ /dev/null
@@ -1,84 +0,0 @@
-#include "test-lib.h"
-#include "hex.h"
-#include "strbuf.h"
-
-static void check_hash_data(const void *data, size_t data_length,
-			    const char *expected_hashes[])
-{
-	if (!check(data != NULL)) {
-		test_msg("BUG: NULL data pointer provided");
-		return;
-	}
-
-	for (size_t i = 1; i < ARRAY_SIZE(hash_algos); i++) {
-		git_hash_ctx ctx;
-		unsigned char hash[GIT_MAX_HEXSZ];
-		const struct git_hash_algo *algop = &hash_algos[i];
-
-		algop->init_fn(&ctx);
-		algop->update_fn(&ctx, data, data_length);
-		algop->final_fn(hash, &ctx);
-
-		if (!check_str(hash_to_hex_algop(hash, algop), expected_hashes[i - 1]))
-			test_msg("result does not match with the expected for %s\n", hash_algos[i].name);
-	}
-}
-
-/* Works with a NUL terminated string. Doesn't work if it should contain a NUL character. */
-#define TEST_HASH_STR(data, expected_sha1, expected_sha256) do { \
-		const char *expected_hashes[] = { expected_sha1, expected_sha256 }; \
-		TEST(check_hash_data(data, strlen(data), expected_hashes), \
-		     "SHA1 and SHA256 (%s) works", #data); \
-	} while (0)
-
-/* Only works with a literal string, useful when it contains a NUL character. */
-#define TEST_HASH_LITERAL(literal, expected_sha1, expected_sha256) do { \
-		const char *expected_hashes[] = { expected_sha1, expected_sha256 }; \
-		TEST(check_hash_data(literal, (sizeof(literal) - 1), expected_hashes), \
-		     "SHA1 and SHA256 (%s) works", #literal); \
-	} while (0)
-
-int cmd_main(int argc UNUSED, const char **argv UNUSED)
-{
-	struct strbuf aaaaaaaaaa_100000 = STRBUF_INIT;
-	struct strbuf alphabet_100000 = STRBUF_INIT;
-
-	strbuf_addstrings(&aaaaaaaaaa_100000, "aaaaaaaaaa", 100000);
-	strbuf_addstrings(&alphabet_100000, "abcdefghijklmnopqrstuvwxyz", 100000);
-
-	TEST_HASH_STR("",
-		"da39a3ee5e6b4b0d3255bfef95601890afd80709",
-		"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
-	TEST_HASH_STR("a",
-		"86f7e437faa5a7fce15d1ddcb9eaeaea377667b8",
-		"ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb");
-	TEST_HASH_STR("abc",
-		"a9993e364706816aba3e25717850c26c9cd0d89d",
-		"ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad");
-	TEST_HASH_STR("message digest",
-		"c12252ceda8be8994d5fa0290a47231c1d16aae3",
-		"f7846f55cf23e14eebeab5b4e1550cad5b509e3348fbc4efa3a1413d393cb650");
-	TEST_HASH_STR("abcdefghijklmnopqrstuvwxyz",
-		"32d10c7b8cf96570ca04ce37f2a19d84240d3a89",
-		"71c480df93d6ae2f1efad1447c66c9525e316218cf51fc8d9ed832f2daf18b73");
-	TEST_HASH_STR(aaaaaaaaaa_100000.buf,
-		"34aa973cd4c4daa4f61eeb2bdbad27316534016f",
-		"cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0");
-	TEST_HASH_STR(alphabet_100000.buf,
-		"e7da7c55b3484fdf52aebec9cbe7b85a98f02fd4",
-		"e406ba321ca712ad35a698bf0af8d61fc4dc40eca6bdcea4697962724ccbde35");
-	TEST_HASH_LITERAL("blob 0\0",
-		"e69de29bb2d1d6434b8b29ae775ad8c2e48c5391",
-		"473a0f4c3be8a93681a267e3b1e9a7dcda1185436fe141f7749120a303721813");
-	TEST_HASH_LITERAL("blob 3\0abc",
-		"f2ba8f84ab5c1bce84a7b441cb1959cfc7093b7f",
-		"c1cf6e465077930e88dc5136641d402f72a229ddd996f627d60e9639eaba35a6");
-	TEST_HASH_LITERAL("tree 0\0",
-		"4b825dc642cb6eb9a060e54bf8d69288fbee4904",
-		"6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321");
-
-	strbuf_release(&aaaaaaaaaa_100000);
-	strbuf_release(&alphabet_100000);
-
-	return test_done();
-}
diff --git a/t/unit-tests/u-hash.c b/t/unit-tests/u-hash.c
new file mode 100644
index 0000000000..c7bac69d03
--- /dev/null
+++ b/t/unit-tests/u-hash.c
@@ -0,0 +1,85 @@
+#include "unit-test.h"
+#include "hex.h"
+#include "strbuf.h"
+
+static void check_hash_data(const void *data, size_t data_length,
+			    const char *expected_hashes[])
+{
+	cl_assert(data != NULL);
+
+	for (size_t i = 1; i < ARRAY_SIZE(hash_algos); i++) {
+		git_hash_ctx ctx;
+		unsigned char hash[GIT_MAX_HEXSZ];
+		const struct git_hash_algo *algop = &hash_algos[i];
+
+		algop->init_fn(&ctx);
+		algop->update_fn(&ctx, data, data_length);
+		algop->final_fn(hash, &ctx);
+
+		cl_assert_equal_s(hash_to_hex_algop(hash,algop), expected_hashes[i - 1]);
+	}
+}
+
+/* Works with a NUL terminated string. Doesn't work if it should contain a NUL character. */
+#define TEST_HASH_STR(data, expected_sha1, expected_sha256) { \
+	const char *expected_hashes[] = { expected_sha1, expected_sha256 }; \
+	check_hash_data(data, strlen(data), expected_hashes); \
+}
+
+/* Only works with a literal string, useful when it contains a NUL character. */
+#define TEST_HASH_LITERAL(literal, expected_sha1, expected_sha256) { \
+	const char *expected_hashes[] = { expected_sha1, expected_sha256 }; \
+	check_hash_data(literal, (sizeof(literal) - 1), expected_hashes); \
+}
+
+void test_hash__empty_string(void) TEST_HASH_STR("",
+	"da39a3ee5e6b4b0d3255bfef95601890afd80709",
+	"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
+
+void test_hash__single_character(void) TEST_HASH_STR("a",
+	"86f7e437faa5a7fce15d1ddcb9eaeaea377667b8",
+	"ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb")
+
+void test_hash__multi_character(void) TEST_HASH_STR("abc",
+	"a9993e364706816aba3e25717850c26c9cd0d89d",
+	"ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad")
+
+void test_hash__message_digest(void) TEST_HASH_STR("message digest",
+	"c12252ceda8be8994d5fa0290a47231c1d16aae3",
+	"f7846f55cf23e14eebeab5b4e1550cad5b509e3348fbc4efa3a1413d393cb650")
+
+void test_hash__alphabet(void) TEST_HASH_STR("abcdefghijklmnopqrstuvwxyz",
+	"32d10c7b8cf96570ca04ce37f2a19d84240d3a89",
+	"71c480df93d6ae2f1efad1447c66c9525e316218cf51fc8d9ed832f2daf18b73")
+
+void test_hash__aaaaaaaaaa_100000(void)
+{
+	struct strbuf aaaaaaaaaa_100000 = STRBUF_INIT;
+	strbuf_addstrings(&aaaaaaaaaa_100000, "aaaaaaaaaa", 100000);
+	TEST_HASH_STR(aaaaaaaaaa_100000.buf,
+		"34aa973cd4c4daa4f61eeb2bdbad27316534016f",
+		"cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0")
+	strbuf_release(&aaaaaaaaaa_100000);
+}
+
+void test_hash__alphabet_100000(void)
+{
+	struct strbuf alphabet_100000 = STRBUF_INIT;
+	strbuf_addstrings(&alphabet_100000, "abcdefghijklmnopqrstuvwxyz", 100000);
+	TEST_HASH_STR(alphabet_100000.buf,
+		"e7da7c55b3484fdf52aebec9cbe7b85a98f02fd4",
+		"e406ba321ca712ad35a698bf0af8d61fc4dc40eca6bdcea4697962724ccbde35")
+	strbuf_release(&alphabet_100000);
+}
+
+void test_hash__zero_blob_literal(void) TEST_HASH_LITERAL("blob 0\0",
+	"e69de29bb2d1d6434b8b29ae775ad8c2e48c5391",
+	"473a0f4c3be8a93681a267e3b1e9a7dcda1185436fe141f7749120a303721813")
+
+void test_hash__three_blob_literal(void) TEST_HASH_LITERAL("blob 3\0abc",
+	"f2ba8f84ab5c1bce84a7b441cb1959cfc7093b7f",
+	"c1cf6e465077930e88dc5136641d402f72a229ddd996f627d60e9639eaba35a6")
+
+void test_hash__zero_tree_literal(void) TEST_HASH_LITERAL("tree 0\0",
+	"4b825dc642cb6eb9a060e54bf8d69288fbee4904",
+	"6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321")
-- 
2.34.1

