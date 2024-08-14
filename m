Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AF81AC43D
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637532; cv=none; b=Qk5WOiVqpysR9KXxhyrpeAcMm8ljt+FvDXE9L8gvt9yvxSbJjMd9OGMRfF00xTZ+f3ClKHWMhVEcWOdz8wEHn7VZQDCgSr4HZa3f1P3q7aUpxBHazVWBOWl25aodkCBa8RWs0yBmAsNbnG5/5X5jdg22S0h/mM+zyifznO27l8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637532; c=relaxed/simple;
	bh=18yXRcBLiJJ2igaJh0Rk6h9YF+bh8km+/CpCJuWg+XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mc1Th96XqiLYsssn3iDaz4Z0V8ddzZbEDM0FoEWCnJYTKiOlQMRxA9MavC5tjAC332lAh1KSWNjT+jZcFsTQlDO6eLBeP3Hmvrd0NSJ6cZVN1H0LkSPjRG3OoDcazPni2xNz8hJUVwQfpDWwlu8pVfUydYjS9TQVxWHuWhDMwLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTJAkNEC; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTJAkNEC"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d1a74a43bso4769294b3a.1
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 05:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723637529; x=1724242329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqZOuJ5ACdlNnI1FAuOh7cyhyLosrMPjPOwxyONccbE=;
        b=aTJAkNECDEMk2T2IHVFJpwSGRrvHwhNBgyi2ih4cpMq1dfMvR01pdUmoQqJC9AYEb7
         mNpYrpbWfnhTeHM2Okl55hEjuwC9LZjwTqZ3t+x9CPXCuzLDXN5VNi8fXMs9l6m2jvCU
         T37hO3xhYczdkOzeVYAKuEezsRwG20pXywuqiXO1LVfq09vcOJGqboam/2LD/wzqokuF
         7mAYLoULJF1HdHq6QgtE6SnoDWsqjdM+2tgRQpRyD0TEnuelFl9NTNMqs4pgI6pH520b
         jPwArgYi43CJKx+mAB8DYKvHr2F/JrfTyTrYVIAZLS5epaRHXX79Q3by53rio9DFkA0B
         eHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723637529; x=1724242329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqZOuJ5ACdlNnI1FAuOh7cyhyLosrMPjPOwxyONccbE=;
        b=f/836pO4bghivgS5+zrRSzAyLnshobMvLmXEae2p+s0S1ryd9+iqUuGv6oyuswVny5
         loJva31btTn6EYM8YBkiRRYUVxMIsleobGqhPJicJTZqIXEWW6dMgJAmIhhtnNQ4jTS/
         focBqhOaeIYJXE3bNwLiu4PyvVR78OTUPg7XH1OTYtG/LPAkFZJIWb551YtpDWNxdnS9
         bVSOrVAcKh6OMmxKp0gjlH/r5vXNFgdUx62pzTs38vJ1+VPdRmsNRFLXNsyqvytroocW
         DPLVqo3wmbGG4xVfcC/PxPIC6rJILMZ4MgNtOJMmX/VN7seMIe4CdUxfMEH/YnDzJZuU
         +oXw==
X-Gm-Message-State: AOJu0Yyhrxcl1Ui1TCun8DmJlvoiITFEMx4WLd8Ret6IEXTmrtQOav7+
	CNqCZLmyyU1LkMHIp5MNhexb/kTL6kFIToUOJGz65UlJVjxjXA8womhvvgaqoFQ=
X-Google-Smtp-Source: AGHT+IGReuzc0byiD4dmhtA9WCyfBDgNyiPTOnpwfi41OYxcBUYb/vy1MKNkv+FDoCM0ijOCCoxNPA==
X-Received: by 2002:a05:6a00:130e:b0:70d:2ba1:2402 with SMTP id d2e1a72fcca58-712673ee157mr2912183b3a.29.1723637529143;
        Wed, 14 Aug 2024 05:12:09 -0700 (PDT)
Received: from Ubuntu.. ([106.205.236.194])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710e5875200sm7195450b3a.37.2024.08.14.05.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:12:08 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 01/10] t: move reftable/block_test.c to the unit testing framework
Date: Wed, 14 Aug 2024 17:33:09 +0530
Message-ID: <20240814121122.4642-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240814121122.4642-1-chandrapratap3519@gmail.com>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable/block_test.c exercises the functions defined in
reftable/block.{c, h}. Migrate reftable/block_test.c to the unit
testing framework. Migration involves refactoring the tests
to use the unit testing framework instead of reftable's test
framework and renaming the tests to follow the unit-tests'
naming conventions.

While at it, ensure structs are 0-initialized with '= { 0 }'
instead of '= { NULL }' and array indices have type 'size_t'
instead of 'int'.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 Makefile                                      |  2 +-
 reftable/reftable-tests.h                     |  1 -
 t/helper/test-reftable.c                      |  1 -
 .../unit-tests/t-reftable-block.c             | 63 +++++++++----------
 4 files changed, 30 insertions(+), 37 deletions(-)
 rename reftable/block_test.c => t/unit-tests/t-reftable-block.c (67%)

diff --git a/Makefile b/Makefile
index 3863e60b66..f030283447 100644
--- a/Makefile
+++ b/Makefile
@@ -1340,6 +1340,7 @@ UNIT_TEST_PROGRAMS += t-oidmap
 UNIT_TEST_PROGRAMS += t-oidtree
 UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-reftable-basics
+UNIT_TEST_PROGRAMS += t-reftable-block
 UNIT_TEST_PROGRAMS += t-reftable-merged
 UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-strbuf
@@ -2679,7 +2680,6 @@ REFTABLE_OBJS += reftable/stack.o
 REFTABLE_OBJS += reftable/tree.o
 REFTABLE_OBJS += reftable/writer.o
 
-REFTABLE_TEST_OBJS += reftable/block_test.o
 REFTABLE_TEST_OBJS += reftable/dump.o
 REFTABLE_TEST_OBJS += reftable/pq_test.o
 REFTABLE_TEST_OBJS += reftable/readwrite_test.o
diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
index d5e03dcc1b..e25ca86ede 100644
--- a/reftable/reftable-tests.h
+++ b/reftable/reftable-tests.h
@@ -10,7 +10,6 @@ license that can be found in the LICENSE file or at
 #define REFTABLE_TESTS_H
 
 int basics_test_main(int argc, const char **argv);
-int block_test_main(int argc, const char **argv);
 int pq_test_main(int argc, const char **argv);
 int record_test_main(int argc, const char **argv);
 int readwrite_test_main(int argc, const char **argv);
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 9d378427da..4eda545fad 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -5,7 +5,6 @@
 int cmd__reftable(int argc, const char **argv)
 {
 	/* test from simple to complex. */
-	block_test_main(argc, argv);
 	tree_test_main(argc, argv);
 	pq_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
diff --git a/reftable/block_test.c b/t/unit-tests/t-reftable-block.c
similarity index 67%
rename from reftable/block_test.c
rename to t/unit-tests/t-reftable-block.c
index 90aecd5a7c..8ab3ff9ebe 100644
--- a/reftable/block_test.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -6,34 +6,30 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
-#include "block.h"
+#include "test-lib.h"
+#include "reftable/block.h"
+#include "reftable/blocksource.h"
+#include "reftable/constants.h"
+#include "reftable/reftable-error.h"
 
-#include "system.h"
-#include "blocksource.h"
-#include "basics.h"
-#include "constants.h"
-#include "record.h"
-#include "test_framework.h"
-#include "reftable-tests.h"
-
-static void test_block_read_write(void)
+static void t_block_read_write(void)
 {
 	const int header_off = 21; /* random */
 	char *names[30];
-	const int N = ARRAY_SIZE(names);
-	const int block_size = 1024;
-	struct reftable_block block = { NULL };
+	const size_t N = ARRAY_SIZE(names);
+	const size_t block_size = 1024;
+	struct reftable_block block = { 0 };
 	struct block_writer bw = {
 		.last_key = STRBUF_INIT,
 	};
 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_REF,
 	};
-	int i = 0;
+	size_t i = 0;
 	int n;
 	struct block_reader br = { 0 };
 	struct block_iter it = BLOCK_ITER_INIT;
-	int j = 0;
+	size_t j = 0;
 	struct strbuf want = STRBUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
@@ -45,11 +41,11 @@ static void test_block_read_write(void)
 	rec.u.ref.refname = (char *) "";
 	rec.u.ref.value_type = REFTABLE_REF_DELETION;
 	n = block_writer_add(&bw, &rec);
-	EXPECT(n == REFTABLE_API_ERROR);
+	check_int(n, ==, REFTABLE_API_ERROR);
 
 	for (i = 0; i < N; i++) {
 		char name[100];
-		snprintf(name, sizeof(name), "branch%02d", i);
+		snprintf(name, sizeof(name), "branch%02"PRIuMAX , (uintmax_t)i);
 
 		rec.u.ref.refname = name;
 		rec.u.ref.value_type = REFTABLE_REF_VAL1;
@@ -59,11 +55,11 @@ static void test_block_read_write(void)
 		n = block_writer_add(&bw, &rec);
 		rec.u.ref.refname = NULL;
 		rec.u.ref.value_type = REFTABLE_REF_DELETION;
-		EXPECT(n == 0);
+		check_int(n, ==, 0);
 	}
 
 	n = block_writer_finish(&bw);
-	EXPECT(n > 0);
+	check_int(n, >, 0);
 
 	block_writer_release(&bw);
 
@@ -73,11 +69,10 @@ static void test_block_read_write(void)
 
 	while (1) {
 		int r = block_iter_next(&it, &rec);
-		EXPECT(r >= 0);
-		if (r > 0) {
+		check_int(r, >=, 0);
+		if (r > 0)
 			break;
-		}
-		EXPECT_STREQ(names[j], rec.u.ref.refname);
+		check_str(names[j], rec.u.ref.refname);
 		j++;
 	}
 
@@ -90,20 +85,20 @@ static void test_block_read_write(void)
 		strbuf_addstr(&want, names[i]);
 
 		n = block_iter_seek_key(&it, &br, &want);
-		EXPECT(n == 0);
+		check_int(n, ==, 0);
 
 		n = block_iter_next(&it, &rec);
-		EXPECT(n == 0);
+		check_int(n, ==, 0);
 
-		EXPECT_STREQ(names[i], rec.u.ref.refname);
+		check_str(names[i], rec.u.ref.refname);
 
 		want.len--;
 		n = block_iter_seek_key(&it, &br, &want);
-		EXPECT(n == 0);
+		check_int(n, ==, 0);
 
 		n = block_iter_next(&it, &rec);
-		EXPECT(n == 0);
-		EXPECT_STREQ(names[10 * (i / 10)], rec.u.ref.refname);
+		check_int(n, ==, 0);
+		check_str(names[10 * (i / 10)], rec.u.ref.refname);
 
 		block_iter_close(&it);
 	}
@@ -111,13 +106,13 @@ static void test_block_read_write(void)
 	reftable_record_release(&rec);
 	reftable_block_done(&br.block);
 	strbuf_release(&want);
-	for (i = 0; i < N; i++) {
+	for (i = 0; i < N; i++)
 		reftable_free(names[i]);
-	}
 }
 
-int block_test_main(int argc, const char *argv[])
+int cmd_main(int argc, const char *argv[])
 {
-	RUN_TEST(test_block_read_write);
-	return 0;
+	TEST(t_block_read_write(), "read-write operations on blocks work");
+
+	return test_done();
 }
-- 
2.45.GIT

