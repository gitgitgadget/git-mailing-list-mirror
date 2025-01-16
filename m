Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B60E132117
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044185; cv=none; b=KCpUjCyCihpsW6eTVg6JWZzj8moSQXnmkGXNuzZzGlTUWOKH9Dr0lGtNEYfYHZj2Zbqq3n2OrXGyXLgHbvpM5N6m4KhNpYD/NJytCLaZVcA5UcCmw0BKJbMMzLj53S4q/PU+XdxkFCPKsas3/RdGN8DkVfY/KBIlvxdYLem7LUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044185; c=relaxed/simple;
	bh=6K/e8WYJqsLYizO+fJi/1H/TJJqTyblk3zV47tvHNKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbrSDg04T+9sLIYVJOoZnxfe4MKaqBm4mZ5HemUVlVZgukdXHc50SzsuiQ2TQv+bJ7UFWnnUA/v87opxoVUut3RDASY1dhhute0GAm+9Iv25LFTkaS7gy4NxUi63NQNp97UiOG9IrZYdI1ZN2thzgsD8/Hq4G/X4/07+hO4mCek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atG40fLU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atG40fLU"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43634b570c1so7602505e9.0
        for <git@vger.kernel.org>; Thu, 16 Jan 2025 08:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737044181; x=1737648981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdMNfYg/Nq9UYuGTGNO4U1NkxgEnTvWULcXRtGl+3jY=;
        b=atG40fLUISYqxSh7kYjLlrIUlWygnxS2zaTu1wvOrAyNsLrX71n+S8aBOgxRexbfed
         SYCQr+YNRgBbsNMFXRxdzwIeEdG0OMkbGBRXNNEKMqzjui65efyx5RIK7GJT4imvYgBE
         umnpLcN630Jetfv8zjdwajCcDSb40W2mVhZdak/vmfLXT575HBe+fpxRaTkXoafzSO3w
         CJvGiqNzvoUO72xG2jU/s46Mi8ZiEoxGSUo0OKybLvr1N30i5y2C8P6O4H2IaJaMyRk3
         Ckfit8MZPpRD8wGN2CgPCAM6XLblOt0MM7KdWExFvnJNq3M5HM3BM0R62y2e1VrWBRJN
         c/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737044181; x=1737648981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdMNfYg/Nq9UYuGTGNO4U1NkxgEnTvWULcXRtGl+3jY=;
        b=JV+Ppq4LsuyFOc1/eyXAAYKHH6N5Es9iwJsBSYsut3kUUHoMdtpFp7xRf0jDwQ+UdD
         JDsCo7/8+xAMqPBfKaQXhCDlfjtdsIMHoeaV0ZvTxXVop/r8h4plICUqjjj1tEl6JJoO
         d1uFyph+sWcvqokcZm7ANFtHDzTkGa19xR5PcWC0RxR5CrCJ0HaIjqvV3MW6yR9IxKph
         q6bXJdU/EDZGjnh8wKG9eU2vvK/SuLBdqgAVfK7aVT/lQ3jgOOilv0M3aTt6q/cg8oSB
         AVYLE78F0tTu94Hg4rs5hSHZD5gE6VX6xyBkNxCsr3TBuZTHYzhZ8rifnS5OhBqmjl3P
         m/9w==
X-Gm-Message-State: AOJu0YxTnaK914TvEZ1goVHbfJM+sCqu9oLqza2FLY0+I5lMzQAAi6xU
	Qj3Bm+Gs5LP1BxqrprZzVyvj9MMzJMhAAYNcL3/zUFx6R23fO4F34mmhNwEUqbh2zA==
X-Gm-Gg: ASbGncs0HWDjxK2dqLgQepy5xO2pq6kh35yq2mS0Pjtrz6r+TrzOkXRoeNHKo9q6AiZ
	VYKGrjyO1EgWTQ+0GYbPmWBRSK+soCKp3Ge6pgI54p2ULMMz76Dncwbdj8pCShuC9kbOP5potCU
	UdoARnY4i8scCF+VZUMTwOoS5FEhrg10HwtIP/ZpxawZoZ7d6HIaBWV90Hjzt9O448uYlA0wp31
	qxKnNxgbvxlglovwK0y+UWf9z449PMcwMM/+47degjgwog+iKux+ZorRxCl/FGrT9syVg==
X-Google-Smtp-Source: AGHT+IFqK2K1zN2OFciJ6+Tt44ITtzv8rPUv8BrNCTcMHnudLDqk3/pIfJPP7w7yQEouBfX6JSHH4g==
X-Received: by 2002:a05:600c:4fc2:b0:434:f3d8:62d0 with SMTP id 5b1f17b1804b1-436e26803f4mr299036085e9.3.1737044180933;
        Thu, 16 Jan 2025 08:16:20 -0800 (PST)
Received: from localhost.localdomain ([154.118.34.84])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-437c752935csm63177025e9.26.2025.01.16.08.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 08:16:20 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 2/4] t/unit-tests: convert mem-pool test to use clar test framework
Date: Thu, 16 Jan 2025 17:15:57 +0100
Message-ID: <20250116161559.91038-3-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250116161559.91038-1-kuforiji98@gmail.com>
References: <20250116104911.77405-1-kuforiji98@gmail.com>
 <20250116161559.91038-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt the mem-pool test script to use clar framework by using clar
assertions where necessary.Test functions are created as a standalone to
test different test cases.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                  |  2 +-
 t/meson.build             |  2 +-
 t/unit-tests/t-mem-pool.c | 31 -------------------------------
 t/unit-tests/u-mem-pool.c | 25 +++++++++++++++++++++++++
 4 files changed, 27 insertions(+), 33 deletions(-)
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
index 0000000000..2bc2493b7e
--- /dev/null
+++ b/t/unit-tests/u-mem-pool.c
@@ -0,0 +1,25 @@
+#include "unit-test.h"
+#include "mem-pool.h"
+
+static void test_many_pool_allocations(size_t block_alloc)
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
+	test_many_pool_allocations(1024 * 1024);
+}
+
+void test_mem_pool__tiny_block(void)
+{
+	test_many_pool_allocations(1);
+}
-- 
2.34.1

