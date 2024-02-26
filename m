Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39C112BF1C
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958065; cv=none; b=rHADcFKKSZ3ZUcaZCXFWF37ZQPxNWDcejUngOqR5esquuKyliAp/fc8/Pjte+6VpLs1cKcii5e51bRvYnFZLVrh6ni8COvcZl2y3eVv5HjznFv3gY14tZtGr9cPCLvT3jMB39qLuZlBghnyn2drvt/9pt9ykirThc5vUNUmanrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958065; c=relaxed/simple;
	bh=DUtIx8T0LD6zUwK3b8EtrUFJnXnndXzeZ0jbVJ8zNHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iArn1o5sjXNZCrD28daD9U/SOcxwYbovcjS4PMsFZIfMYHVOW/tVCP+CeQxrbUx+nhtQ0uYb0lZ+lkyTtDVCHHpiFWu2oYIbMEGpWkmkYZ6APf7tYEi77XfK50MC5R+P6Lsk7/ZEZTt4c9trJX4A4TVipCdOGbnqg+hWohf/300=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4uDwCpW; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4uDwCpW"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-412a45f4766so7730565e9.3
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 06:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708958062; x=1709562862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUVGDbmWgaIINcmJHtaEVkE9/4g/IQ417oqIVoDxRv4=;
        b=U4uDwCpW+zpH5jEEL/qqgKlE1UuYcHJQ1Ako+o5sJGH5Gj8E5xN4AAnMdIXKW0wt22
         7fbQiLZVPFiRCENl9sS/J+f6yLuN9EwipyksB3Wl8aX4LkcZqQllcSwVarfSWQe/c8lm
         3bYag2bQ61m+r4E8CDO3lz2zaNAzMJp+zKXVhIHGTWhYpV6E0hzvcQyxXMMVkRrSCtRF
         eQD/xJhLLPCSbcVhrPT4Y5Fu56ntfap1bFpuwKsOlc/oMhOiNLCFnuXVsjsAtdJhebZd
         hiaHz23E15vc40+6cLyHuhRwK+A5JgJ6+XJEl4z4iAqeyToV9LAEeHjnPn9EWeAoRSlQ
         Jy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708958062; x=1709562862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUVGDbmWgaIINcmJHtaEVkE9/4g/IQ417oqIVoDxRv4=;
        b=qIrw66LjSu+3nL8okXBAo2POCEU7ar61b/t4lu30ONjG/YtlM+z3Ugz6UFBIkQLaDm
         DmO+AgzjVtgDGvc3GcYStdHEjFzHWDe+EQktpy4Unlq7x5dqW1Y451QyRlebFVqdVg0T
         zmGxTcFQbtFc0IJCOQrglw7PxaB7SQfX9sy7doul8Wx+vX0LSvHEY6aioDNeONFUKJ+f
         em1mgUZQkGDWhivDGMdNg9m1tzDfTR0LbNdHYKxKG+r0AmOFt1HfzPE3iagghMCp7Ybf
         S92nfsv98UE266NdWy8LdqtvOWEivebLT9EP6A/nn5zl/LlQpaAQpobMVH+rj+4Kxomb
         NL5w==
X-Gm-Message-State: AOJu0Yx5al7IXBdfofMOLWUtj6I0NocmI3TotdY5qDaMFxAqLZ0aQcKv
	dDkl3k9sP6+Nvn1uhZDmN2vYeG6N3xRExI4A95Hqr0CCxR3Q4hUuIcanIINwoIw=
X-Google-Smtp-Source: AGHT+IEZhxIbGcRxZ2iCuvbYneZ6UB/tOnzhe/DDI/h92dGjfTnFIUMs1Wv5Yo+sbDsnlT8SFf4fxA==
X-Received: by 2002:a05:600c:4454:b0:412:9017:c716 with SMTP id v20-20020a05600c445400b004129017c716mr5337399wmn.17.1708958061520;
        Mon, 26 Feb 2024 06:34:21 -0800 (PST)
Received: from localhost.localdomain ([102.244.37.218])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b0041294d015fbsm8548033wmn.40.2024.02.26.06.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 06:34:21 -0800 (PST)
From: Achu Luma <ach.lumap@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Achu Luma <ach.lumap@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [Outreachy][PATCH 2/2] Port helper/test-sha256.c and helper/test-sha1.c to unit-tests/t-hash.c
Date: Mon, 26 Feb 2024 15:33:50 +0100
Message-ID: <20240226143350.3596-2-ach.lumap@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240226143350.3596-1-ach.lumap@gmail.com>
References: <20240226143350.3596-1-ach.lumap@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the recent codebase update (8bf6fbd (Merge branch
'js/doc-unit-tests', 2023-12-09)), a new unit testing framework was
merged, providing a standardized approach for testing C code. Prior to
this update, some unit tests relied on the test helper mechanism,
lacking a dedicated unit testing framework. It's more natural to perform
these unit tests using the new unit test framework.

This commit migrates the unit tests for hash functionality from the
legacy approach using the test-tool command `test-tool sha1`and
`test-tool sha256` in helper/test-sha256.c and helper/test-sha1.c to the
new unit testing framework (t/unit-tests/test-lib.h). Porting
t0013-sha1dc.sh is left for later.

The migration involves refactoring the tests to utilize the testing
macros provided by the framework (TEST() and check_*()).

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Achu Luma <ach.lumap@gmail.com>
---
 Makefile              |  2 +-
 t/helper/test-tool.c  |  1 -
 t/helper/test-tool.h  |  1 -
 t/t0015-hash.sh       | 56 --------------------------------
 t/unit-tests/t-hash.c | 75 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 76 insertions(+), 59 deletions(-)
 delete mode 100755 t/t0015-hash.sh
 create mode 100644 t/unit-tests/t-hash.c

diff --git a/Makefile b/Makefile
index 78e874099d..b73d2270f9 100644
--- a/Makefile
+++ b/Makefile
@@ -847,7 +847,6 @@ TEST_BUILTINS_OBJS += test-run-command.o
 TEST_BUILTINS_OBJS += test-scrap-cache-tree.o
 TEST_BUILTINS_OBJS += test-serve-v2.o
 TEST_BUILTINS_OBJS += test-sha1.o
-TEST_BUILTINS_OBJS += test-sha256.o
 TEST_BUILTINS_OBJS += test-sigchain.o
 TEST_BUILTINS_OBJS += test-simple-ipc.o
 TEST_BUILTINS_OBJS += test-strcmp-offset.o
@@ -1346,6 +1345,7 @@ UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGRAMS += t-prio-queue
+UNIT_TEST_PROGRAMS += t-hash
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 482a1e58a4..7bfbb75c9b 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -73,7 +73,6 @@ static struct test_cmd cmds[] = {
 	{ "serve-v2", cmd__serve_v2 },
 	{ "sha1", cmd__sha1 },
 	{ "sha1-is-sha1dc", cmd__sha1_is_sha1dc },
-	{ "sha256", cmd__sha256 },
 	{ "sigchain", cmd__sigchain },
 	{ "simple-ipc", cmd__simple_ipc },
 	{ "strcmp-offset", cmd__strcmp_offset },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index b1be7cfcf5..8139c9664d 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -66,7 +66,6 @@ int cmd__serve_v2(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 int cmd__sha1_is_sha1dc(int argc, const char **argv);
 int cmd__oid_array(int argc, const char **argv);
-int cmd__sha256(int argc, const char **argv);
 int cmd__sigchain(int argc, const char **argv);
 int cmd__simple_ipc(int argc, const char **argv);
 int cmd__strcmp_offset(int argc, const char **argv);
diff --git a/t/t0015-hash.sh b/t/t0015-hash.sh
deleted file mode 100755
index 0a087a1983..0000000000
--- a/t/t0015-hash.sh
+++ /dev/null
@@ -1,56 +0,0 @@
-#!/bin/sh
-
-test_description='test basic hash implementation'
-
-TEST_PASSES_SANITIZE_LEAK=true
-. ./test-lib.sh
-
-test_expect_success 'test basic SHA-1 hash values' '
-	test-tool sha1 </dev/null >actual &&
-	grep da39a3ee5e6b4b0d3255bfef95601890afd80709 actual &&
-	printf "a" | test-tool sha1 >actual &&
-	grep 86f7e437faa5a7fce15d1ddcb9eaeaea377667b8 actual &&
-	printf "abc" | test-tool sha1 >actual &&
-	grep a9993e364706816aba3e25717850c26c9cd0d89d actual &&
-	printf "message digest" | test-tool sha1 >actual &&
-	grep c12252ceda8be8994d5fa0290a47231c1d16aae3 actual &&
-	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha1 >actual &&
-	grep 32d10c7b8cf96570ca04ce37f2a19d84240d3a89 actual &&
-	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" |
-		test-tool sha1 >actual &&
-	grep 34aa973cd4c4daa4f61eeb2bdbad27316534016f actual &&
-	printf "blob 0\0" | test-tool sha1 >actual &&
-	grep e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 actual &&
-	printf "blob 3\0abc" | test-tool sha1 >actual &&
-	grep f2ba8f84ab5c1bce84a7b441cb1959cfc7093b7f actual &&
-	printf "tree 0\0" | test-tool sha1 >actual &&
-	grep 4b825dc642cb6eb9a060e54bf8d69288fbee4904 actual
-'
-
-test_expect_success 'test basic SHA-256 hash values' '
-	test-tool sha256 </dev/null >actual &&
-	grep e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 actual &&
-	printf "a" | test-tool sha256 >actual &&
-	grep ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb actual &&
-	printf "abc" | test-tool sha256 >actual &&
-	grep ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad actual &&
-	printf "message digest" | test-tool sha256 >actual &&
-	grep f7846f55cf23e14eebeab5b4e1550cad5b509e3348fbc4efa3a1413d393cb650 actual &&
-	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha256 >actual &&
-	grep 71c480df93d6ae2f1efad1447c66c9525e316218cf51fc8d9ed832f2daf18b73 actual &&
-	# Try to exercise the chunking code by turning autoflush on.
-	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" |
-		test-tool sha256 >actual &&
-	grep cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0 actual &&
-	perl -e "$| = 1; print q{abcdefghijklmnopqrstuvwxyz} for 1..100000;" |
-		test-tool sha256 >actual &&
-	grep e406ba321ca712ad35a698bf0af8d61fc4dc40eca6bdcea4697962724ccbde35 actual &&
-	printf "blob 0\0" | test-tool sha256 >actual &&
-	grep 473a0f4c3be8a93681a267e3b1e9a7dcda1185436fe141f7749120a303721813 actual &&
-	printf "blob 3\0abc" | test-tool sha256 >actual &&
-	grep c1cf6e465077930e88dc5136641d402f72a229ddd996f627d60e9639eaba35a6 actual &&
-	printf "tree 0\0" | test-tool sha256 >actual &&
-	grep 6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321 actual
-'
-
-test_done
diff --git a/t/unit-tests/t-hash.c b/t/unit-tests/t-hash.c
new file mode 100644
index 0000000000..b512e64bf1
--- /dev/null
+++ b/t/unit-tests/t-hash.c
@@ -0,0 +1,75 @@
+#include "test-lib.h"
+#include "hash-ll.h"
+#include "hex.h"
+#include "strbuf.h"
+
+static void check_hash_data(const void *data, size_t data_length, const char *expected, int algo) {
+	git_hash_ctx ctx;
+	unsigned char hash[GIT_MAX_HEXSZ];
+	const struct git_hash_algo *algop = &hash_algos[algo];
+
+	if (!check(!!data)) {
+    		test_msg("Error: No data provided when expecting: %s", expected);
+    		return;
+	}
+
+	algop->init_fn(&ctx);
+	algop->update_fn(&ctx, data, data_length);
+	algop->final_fn(hash, &ctx);
+
+	check_str(hash_to_hex_algop(hash, algop), expected);
+}
+
+/* Works with a NUL terminated string. Doesn't work if it should contain a NUL character. */
+#define TEST_SHA1_STR(data, expected) \
+    	TEST(check_hash_data(data, strlen(data), expected, GIT_HASH_SHA1), \
+        	"SHA1 (%s) works", #data)
+
+/* Only works with a literal string, useful when it contains a NUL character. */
+#define TEST_SHA1_LITERAL(literal, expected) \
+    	TEST(check_hash_data(literal, (sizeof(literal) - 1), expected, GIT_HASH_SHA1), \
+        	"SHA1 (%s) works", #literal)
+
+/* Works with a NUL terminated string. Doesn't work if it should contain a NUL character. */
+#define TEST_SHA256_STR(data, expected) \
+    	TEST(check_hash_data(data, strlen(data), expected, GIT_HASH_SHA256), \
+        	"SHA256 (%s) works", #data)
+
+/* Only works with a literal string, useful when it contains a NUL character. */
+#define TEST_SHA256_LITERAL(literal, expected) \
+    	TEST(check_hash_data(literal, (sizeof(literal) - 1), expected, GIT_HASH_SHA256), \
+        	"SHA256 (%s) works", #literal)
+
+int cmd_main(int argc, const char **argv) {
+	struct strbuf aaaaaaaaaa_100000 = STRBUF_INIT;
+	struct strbuf alphabet_100000 = STRBUF_INIT;
+
+	strbuf_addstrings(&aaaaaaaaaa_100000, "aaaaaaaaaa", 100000);
+	strbuf_addstrings(&alphabet_100000, "abcdefghijklmnopqrstuvwxyz", 100000);
+
+	TEST_SHA1_STR("", "da39a3ee5e6b4b0d3255bfef95601890afd80709");
+	TEST_SHA1_STR("a", "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8");
+	TEST_SHA1_STR("abc", "a9993e364706816aba3e25717850c26c9cd0d89d");
+	TEST_SHA1_STR("message digest", "c12252ceda8be8994d5fa0290a47231c1d16aae3");
+	TEST_SHA1_STR("abcdefghijklmnopqrstuvwxyz", "32d10c7b8cf96570ca04ce37f2a19d84240d3a89");
+	TEST_SHA1_STR(aaaaaaaaaa_100000.buf, "34aa973cd4c4daa4f61eeb2bdbad27316534016f");
+	TEST_SHA1_LITERAL("blob 0\0", "e69de29bb2d1d6434b8b29ae775ad8c2e48c5391");
+	TEST_SHA1_LITERAL("blob 3\0abc", "f2ba8f84ab5c1bce84a7b441cb1959cfc7093b7f");
+	TEST_SHA1_LITERAL("tree 0\0", "4b825dc642cb6eb9a060e54bf8d69288fbee4904");
+
+	TEST_SHA256_STR("", "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
+	TEST_SHA256_STR("a", "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb");
+	TEST_SHA256_STR("abc", "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad");
+	TEST_SHA256_STR("message digest", "f7846f55cf23e14eebeab5b4e1550cad5b509e3348fbc4efa3a1413d393cb650");
+	TEST_SHA256_STR("abcdefghijklmnopqrstuvwxyz", "71c480df93d6ae2f1efad1447c66c9525e316218cf51fc8d9ed832f2daf18b73");
+	TEST_SHA256_STR(aaaaaaaaaa_100000.buf, "cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0");
+	TEST_SHA256_STR(alphabet_100000.buf, "e406ba321ca712ad35a698bf0af8d61fc4dc40eca6bdcea4697962724ccbde35");
+	TEST_SHA256_LITERAL("blob 0\0", "473a0f4c3be8a93681a267e3b1e9a7dcda1185436fe141f7749120a303721813");
+	TEST_SHA256_LITERAL("blob 3\0abc", "c1cf6e465077930e88dc5136641d402f72a229ddd996f627d60e9639eaba35a6");
+	TEST_SHA256_LITERAL("tree 0\0", "6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321");
+
+	strbuf_release(&aaaaaaaaaa_100000);
+	strbuf_release(&alphabet_100000);
+
+	return test_done();
+}
--
2.43.0.windows.1

