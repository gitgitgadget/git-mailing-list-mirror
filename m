Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BA03C2F
	for <git@vger.kernel.org>; Fri, 24 May 2024 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716508835; cv=none; b=dSeGegwj/C0JM0fhYU+R6i/+wPQcgfDNe1UH8lGqOkqZl1s0L/VxDtbzeAsK07IGEtFmXIocRPNugkJ1VyJWhQfLM7IWM7CkI+n3tn0pHt4LVKYwtxCoMPK7vN5y/nPSBtR0gszF9KGaS6ex3QaNEv3n2ieNyHYqtN7CHpM3roU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716508835; c=relaxed/simple;
	bh=fjAZyfaD2ViMkrLBB9hM0vLQdJDrxn/viL8rxckIUQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIktJ2+b66wasH6rqSd0BHjeCORWx0F4x/i/dzy+mH2IgDBfJuoaC9vT/QFZSlemE3UOwtMWCxNO9gMKPIXlpyBnCNabg0czFEMCMI9q8YghU2HNul8rQ1d8Hu168bUbBR6obvAUCUL+nKk+EXJCVZejBR8oYiSjcry78eYhFD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnY+KbV9; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnY+KbV9"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f8e819a540so374679b3a.0
        for <git@vger.kernel.org>; Thu, 23 May 2024 17:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716508832; x=1717113632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znLlry+H5rvKuOiHPl8PUt16pTkQnkYyzKDiKWD+Wi8=;
        b=ZnY+KbV9iIc7uqadQTQXpggw/5G89LyZOO9uns52rMKKZQ0iB6mdPBjuz8c8Erufuq
         v2x3Vm3kfR5Jn5PvWcfcOwxNMFyA6S6pjSdJfRRn8/s2ceu6VdTnsqjBG++AZwMrbLpN
         YzAJlanxMP18NXXU8L9FeKqL+MQvrk1K5ydCgfaO7fL/MMgtVThl4sAozBufVUQuyiD+
         aEwcgb17WOeoWimjia92Rrqr1SwbSADr5Sy0L9n4dyT5/Up3PF93H9zqA2qCcgSfIeZA
         /3HPRT0a0XjImKS9wkmeTfJkwsIH09+bg5QzkdLxFe1SNPPCc++3TMUpRVGnYcqf7MN3
         SnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716508832; x=1717113632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znLlry+H5rvKuOiHPl8PUt16pTkQnkYyzKDiKWD+Wi8=;
        b=FoDD+b0FDEMdPMXEWaj7SHYK4e7LCd2b28zjJIUo5QA8WEzDtnUmFTLraYOqdd07xN
         awGoTaDRY0zrppzC514BNuty7PK4mqNDIyFHqOz1Gulpgc1pZqu/tp1gqQkUCRbATy+m
         kXPDDhFfXrCn0qJ4QJ1dVyMJhdjM1kPZINHz5LudQl4H8h601BclyCc9N7rIfgKgXAwD
         0zhiC8s0RgRn9zQb3WC1UQuNJj3Hm3NcWB76yqYPgsG594mXBLqOnyWq4cZ3mPJKrKNE
         q7hecdGCKF/UHwOEe/9rrW9HCelLz/1iNUuRT2ktSAN10YyAvtcNQdtAv7aZigN91Tac
         XbAA==
X-Forwarded-Encrypted: i=1; AJvYcCX9FnJ8tcai26ikZaDSuFHu4kOgwvufEnnf/zV+dGN3zodOdt5KE4uVaLaEe9tW9WgRJRQwMZhOREHan0hlPHKEuCcS
X-Gm-Message-State: AOJu0Yzs3QGKiMN+GkWiX5HiXa8Pzosi9y2gyTtFgWdUtfr9J5rv/w5k
	lGay0iWxnD9FXejCSUw63ZbqybQacEKg8CB5iDuVFF9yi4F/qxn7
X-Google-Smtp-Source: AGHT+IFgSWJUtrQOZoHfueK5lJlNkEmAlFwoTtLldLHrOLKf/FQyuGPKTzyA4j2392dpVj9p7YMlsg==
X-Received: by 2002:a05:6a00:27a7:b0:6f6:802d:db82 with SMTP id d2e1a72fcca58-6f8f42b6d4fmr695594b3a.23.1716508830130;
        Thu, 23 May 2024 17:00:30 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc05ab4asm165454b3a.59.2024.05.23.17.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 17:00:29 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: ach.lumap@gmail.com
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im
Subject: [PATCH v3 2/3] t/: port helper/test-sha1.c to unit-tests/t-hash.c
Date: Fri, 24 May 2024 05:29:44 +0530
Message-ID: <20240523235945.26833-3-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523235945.26833-1-shyamthakkar001@gmail.com>
References: <20240229054004.3807-1-ach.lumap@gmail.com>
 <20240523235945.26833-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

t/helper/test-sha1 and t/t0015-hash.sh test the hash implementation of
SHA-1 in Git with basic SHA-1 hash values. Migrate them to the new unit
testing framework for better debugging and runtime performance.

The sha1 subcommand from test-tool is still not removed because it is
relied upon by t0013-sha1dc (which requires 'test-tool sha1' dying
when it is used on a file created to contain the known sha1 attack)
and pack_trailer():lib-pack.sh.

Helped-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Co-authored-by: Achu Luma <ach.lumap@gmail.com>
Signed-off-by: Achu Luma <ach.lumap@gmail.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 Makefile              |  1 +
 t/t0015-hash.sh       | 22 ------------------
 t/unit-tests/t-hash.c | 54 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 22 deletions(-)
 create mode 100644 t/unit-tests/t-hash.c

diff --git a/Makefile b/Makefile
index 8f4432ae57..2b19fdf6ae 100644
--- a/Makefile
+++ b/Makefile
@@ -1335,6 +1335,7 @@ THIRD_PARTY_SOURCES += sha1collisiondetection/%
 THIRD_PARTY_SOURCES += sha1dc/%
 
 UNIT_TEST_PROGRAMS += t-ctype
+UNIT_TEST_PROGRAMS += t-hash
 UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-strbuf
diff --git a/t/t0015-hash.sh b/t/t0015-hash.sh
index 0a087a1983..2264e702d5 100755
--- a/t/t0015-hash.sh
+++ b/t/t0015-hash.sh
@@ -5,28 +5,6 @@ test_description='test basic hash implementation'
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
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
 test_expect_success 'test basic SHA-256 hash values' '
 	test-tool sha256 </dev/null >actual &&
 	grep e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 actual &&
diff --git a/t/unit-tests/t-hash.c b/t/unit-tests/t-hash.c
new file mode 100644
index 0000000000..89dfea9cc1
--- /dev/null
+++ b/t/unit-tests/t-hash.c
@@ -0,0 +1,54 @@
+#include "test-lib.h"
+#include "hash-ll.h"
+#include "hex.h"
+#include "strbuf.h"
+
+static void check_hash_data(const void *data, size_t data_length,
+			    const char *expected, int algo)
+{
+	git_hash_ctx ctx;
+	unsigned char hash[GIT_MAX_HEXSZ];
+	const struct git_hash_algo *algop = &hash_algos[algo];
+
+	if (!check(!!data)) {
+		test_msg("Error: No data provided when expecting: %s", expected);
+		return;
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
+	TEST(check_hash_data(data, strlen(data), expected, GIT_HASH_SHA1), \
+	     "SHA1 (%s) works", #data)
+
+/* Only works with a literal string, useful when it contains a NUL character. */
+#define TEST_SHA1_LITERAL(literal, expected) \
+	TEST(check_hash_data(literal, (sizeof(literal) - 1), expected, GIT_HASH_SHA1), \
+	     "SHA1 (%s) works", #literal)
+
+int cmd_main(int argc, const char **argv)
+{
+	struct strbuf aaaaaaaaaa_100000 = STRBUF_INIT;
+
+	strbuf_addstrings(&aaaaaaaaaa_100000, "aaaaaaaaaa", 100000);
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
+	strbuf_release(&aaaaaaaaaa_100000);
+
+	return test_done();
+}
-- 
2.45.1

