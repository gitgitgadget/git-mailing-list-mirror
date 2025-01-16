Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6606719539F
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024571; cv=none; b=Iq/h0778BHSm7OrsRDF2e7C0zE3GuG3FlB4HU9hr7RZBbAmN7Y+xtVakKenU6lGQHIh60TompcvZN/cH88BqCdefVyOcs/eEsiOoWX1LXlWZNEXzNGhQkgnyrXmq4yIosxqV6+lCC066Es6iOhkuPHwEWiICWoi9Z/V8FxHR0tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024571; c=relaxed/simple;
	bh=Bo8ojpGZ3vtto3R+jupgcUFC3rekAbsIsp5jL/Ru2/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B85N6WVsYbnQiYVMJUZh9uXlnH+WyE/iKVSdU/q2+DtBv3I6X9GCY8Vd7wJtADPgzvFp0T19Z4L5zinzsjqABMwBC/+Dbwb9esI3mObyaV39mADjyfyud6aRiiox5R/EYFEMLgTTybdrUPSPqoAXyh6rNOSq1c4DZkBVxIqAWpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHHtkqLq; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHHtkqLq"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aafc9d75f8bso138810666b.2
        for <git@vger.kernel.org>; Thu, 16 Jan 2025 02:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737024567; x=1737629367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iXtlJs4Rcx29VFlm0PpIoOsU5JQxfixMasimpPPt/A=;
        b=QHHtkqLqGa/8oRQtpesYPBp6+m8mWe6OCXphg4W41S3LV7gFJHaF1zotoOVMCrwlr+
         gbhvQbRNW7MqWPX0EV27q2lQqN1mbUzx57KG2PqVwzc4bxrIbmp84GMZGhsRmI/NJFrG
         EsUSDgidI5vZ4heP3slIIZIvS91tlcHMSPREzkyKkp7kaYiFw2oXC33aLI67wyZCxrWI
         esHESuyYiVpD74nN74LjnUFaHaq17cnzO9+RNNu1dAn9EawMgSGAtnmQ17a2/9hlhp07
         +UBp7dr5oqmRuZqDV1tkBfVI4rjqwmSR3/rVQGqHleIwsji4ln8WmiMGHMvEh5bmmQAT
         mecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737024567; x=1737629367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iXtlJs4Rcx29VFlm0PpIoOsU5JQxfixMasimpPPt/A=;
        b=tGgqmYZGLV0xQPf7VahH6ZvdI3shmQf+lQPzNVr7teX40CpNIyei22RSDclnvaGPP2
         hObZIfY4f158QPUM8j6CQ7uMf1cz7jwrD9KtyEMwKyTAzlMERqOO5zPjjC97S+ZJ71K+
         RxFGHLp1+YAbECVJPKTM5UPIM4rd6OGVP9atRRg3Sejgh814lrmvL1F8+OjklV6/zkaA
         0fS+ktTZ50JJ5TW9LeNFWWnhzjfcqauGFm+7fOH0lWD2gQkm6gGXaPV5VxlhtAaSOx6r
         dritrVyHr8s1Q0QccRQzoOCiZk1JRhE6dgl57UHqdQAvN4eIxq2GY/AjW4dFFPuBlCWA
         6zuw==
X-Gm-Message-State: AOJu0YzT8cvtIwWIRNXEQhRqvmdGAzP9EH+u3MZZlzxGwHH7pOjzdzTo
	zyp1V/hVmViCahZdUAFaL5k3AInE3xc8nhg7t4oHT+oG30sa53MFbHCSB3ZO00j1ug==
X-Gm-Gg: ASbGncthqxwKir2ls5plrB9vnG2Mhm3e9Mcmype4Vq2cTgavfs/cf+9/F0Lhn8j1lD9
	DD/dXesMOHKgeP4WEm+2xsIckaPUqj2SoyVCga24l3lTFQyL2gLyMWfLwDAHsRE1aOigDMR0BEv
	SGjd7znV5q1r1YEjiDohhrKitjcWhHogTL7PucoNq17cSW+0IBLpHz28BTqM2vexhuOdXU+5fXl
	1ZRc5WC+rbj3e3eAE+63AqQ3Bookn1Q5jkrTlQIn03bQqP6OS6+PfUjet1vb4OKJjYTWg==
X-Google-Smtp-Source: AGHT+IEC4Db42XnRiuDt3gMNCO/QxxjAahGqvHSWnc/5lDFNEEI0+qyWGMRSEB54W41cbBtST4uAeQ==
X-Received: by 2002:a17:907:3da8:b0:aae:ce4c:ca40 with SMTP id a640c23a62f3a-ab2ab740698mr2754510866b.32.1737024567176;
        Thu, 16 Jan 2025 02:49:27 -0800 (PST)
Received: from localhost.localdomain ([154.118.34.84])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c9646be5sm901203966b.174.2025.01.16.02.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 02:49:26 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 2/4] t/unit-tests: convert mem-pool test to use clar test framework
Date: Thu, 16 Jan 2025 11:49:09 +0100
Message-ID: <20250116104911.77405-3-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250116104911.77405-1-kuforiji98@gmail.com>
References: <20250116104911.77405-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt the mem-pool test script to use clar framework by using clar
assertions where necessary. Following the consensus to convert the
unit-tests scripts found in the t/unit-tests folder to clar driven by
Patrick Steinhardt. Test functions are created as a standalone to test
different test cases.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                  |  2 +-
 t/meson.build             |  2 +-
 t/unit-tests/t-mem-pool.c | 31 -------------------------------
 t/unit-tests/u-mem-pool.c | 26 ++++++++++++++++++++++++++
 4 files changed, 28 insertions(+), 33 deletions(-)
 delete mode 100644 t/unit-tests/t-mem-pool.c
 create mode 100644 t/unit-tests/u-mem-pool.c

diff --git a/Makefile b/Makefile
index 97e8385b66..49ada4169d 100644
--- a/Makefile
+++ b/Makefile
@@ -1338,6 +1338,7 @@ THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/%
 THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
 
 CLAR_TEST_SUITES += u-ctype
+CLAR_TEST_SUITES += u-mem-pool
 CLAR_TEST_SUITES += u-strvec
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
@@ -1347,7 +1348,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 UNIT_TEST_PROGRAMS += t-example-decorate
 UNIT_TEST_PROGRAMS += t-hash
 UNIT_TEST_PROGRAMS += t-hashmap
-UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-oid-array
 UNIT_TEST_PROGRAMS += t-oidmap
 UNIT_TEST_PROGRAMS += t-oidtree
diff --git a/t/meson.build b/t/meson.build
index 602ebfe6a2..ffe951f9be 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1,5 +1,6 @@
 clar_test_suites = [
   'unit-tests/u-ctype.c',
+  'unit-tests/u-mem-pool.c',
   'unit-tests/u-strvec.c',
 ]
 
@@ -43,7 +44,6 @@ unit_test_programs = [
   'unit-tests/t-example-decorate.c',
   'unit-tests/t-hash.c',
   'unit-tests/t-hashmap.c',
-  'unit-tests/t-mem-pool.c',
   'unit-tests/t-oid-array.c',
   'unit-tests/t-oidmap.c',
   'unit-tests/t-oidtree.c',
diff --git a/t/unit-tests/t-mem-pool.c b/t/unit-tests/t-mem-pool.c
deleted file mode 100644
index fe500c704b..0000000000
--- a/t/unit-tests/t-mem-pool.c
+++ /dev/null
@@ -1,31 +0,0 @@
-#include "test-lib.h"
-#include "mem-pool.h"
-
-static void setup_static(void (*f)(struct mem_pool *), size_t block_alloc)
-{
-	struct mem_pool pool = { .block_alloc = block_alloc };
-	f(&pool);
-	mem_pool_discard(&pool, 0);
-}
-
-static void t_calloc_100(struct mem_pool *pool)
-{
-	size_t size = 100;
-	char *buffer = mem_pool_calloc(pool, 1, size);
-	for (size_t i = 0; i < size; i++)
-		check_int(buffer[i], ==, 0);
-	if (!check(pool->mp_block != NULL))
-		return;
-	check(pool->mp_block->next_free != NULL);
-	check(pool->mp_block->end != NULL);
-}
-
-int cmd_main(int argc UNUSED, const char **argv UNUSED)
-{
-	TEST(setup_static(t_calloc_100, 1024 * 1024),
-	     "mem_pool_calloc returns 100 zeroed bytes with big block");
-	TEST(setup_static(t_calloc_100, 1),
-	     "mem_pool_calloc returns 100 zeroed bytes with tiny block");
-
-	return test_done();
-}
diff --git a/t/unit-tests/u-mem-pool.c b/t/unit-tests/u-mem-pool.c
new file mode 100644
index 0000000000..36e31a3201
--- /dev/null
+++ b/t/unit-tests/u-mem-pool.c
@@ -0,0 +1,26 @@
+#include "unit-test.h"
+#include "mem-pool.h"
+
+static void t_calloc_100(size_t block_alloc)
+{
+	struct mem_pool pool = { .block_alloc = block_alloc };
+	size_t size = 100;
+	char *buffer = mem_pool_calloc(&pool, 1, size);
+	for (size_t i = 0; i < size; i++)
+		cl_assert_equal_i(0, buffer[i]);
+	cl_assert(pool.mp_block != NULL);
+	cl_assert(pool.mp_block->next_free != NULL);
+	cl_assert(pool.mp_block->end != NULL);
+	mem_pool_discard(&pool, 0);
+}
+
+void test_mem_pool__big_block(void)
+{
+	t_calloc_100(1024 * 1024);
+
+}
+
+void test_mem_pool__tiny_block(void)
+{
+	t_calloc_100(1);
+}
-- 
2.34.1

