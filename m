Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7657187FE5
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510332; cv=none; b=lL+Ys8P0/u8S3IU9GnbtKk6Kiw9nUTMVo/jGqjuWtbvV+dAtldOanZQcp6/9s90XYYytqjOhA1Cyzpc8Yth9neRxr9NCAty3be5E9TvUO3TfMlbSs8itxVntF0U8RQdqmIZSuU23e3kfc2JD4eZyu6m1fJp/zS0BdhGaoH4B+5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510332; c=relaxed/simple;
	bh=3maJGZLQFy6uzTGwfimpdYlYH7mPuIRSv6/kGJ2VmP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyIb4clDWsfsE8vJZa9pmzFZkx03n/i7X7I3jSyo/lqtHHxDLrFj937CIUEgc7j5IBh7EWj6Ync9d93pSyodIGh2IPD7nP99WwedCn/lTSZpHD5byZF/k0/e61JhSTzNZiyhwg24HgvaYNByY3bHSK7HOsHBhyGWwTs0jsL1rxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Phne8xWz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Phne8xWz"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc4fcbb131so60184655ad.3
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 04:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722510329; x=1723115129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWFYUT0nNbkUmcoynWmQbbaLqTcO6uJXhtAvh7Z3QKs=;
        b=Phne8xWzzEpsyad2/qWOVLl7VcUvK6vAVBBECG34HnTWYOug/ZJsGTtIc399jdl5NN
         lSzHt1qf3OBH6IZ3ZzHaiI80tquLhH0QfLf7ZbKoqlXd4blzo4yvvNd26Oocr4JCHyVA
         9lpUFKB0fjJJtu7+ubAWFqwAqZ4UhRLOO7S56w6LAQ1h3ayChZay4vxKOHgaLGFSxPRi
         Vhjn1XjHScolFmXMzGMA1H+nm5uxIjJYi28/PivnhGENtKhlM7F1ztP6t14wbM940IkM
         PAFQkamYODQul0uIWAFSazdZVe4qsQQsX5fGr2s+1uCtQk6/A8dqY1XJeYgLFktCgpGM
         k92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510329; x=1723115129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWFYUT0nNbkUmcoynWmQbbaLqTcO6uJXhtAvh7Z3QKs=;
        b=GWCX6PvPkj3+7scRv5PJkFPC6izhkNIj0sZYh/nFyygK1GYVMZJNJj+CvC7h3mlF1S
         0jFqrdlacYyldi7Ueo0PvNNXTTMiOFqLGcGNuI/oE4kaggpORjQu6Bvl6f//79j1/M+d
         Jmhrypy4bk02oqzwXvxzCpSP8mYYi1Fxl+P9QHPReHvn1wonVpbVRYQk3iACjQofU+f9
         Dc65JL2tXW7ToUe5x8T8sepEMp328jpHMnRPJzZ5aeos/TNIZ5tj6IXd+Am/a7W/84qZ
         x+Zmxu6kzHEbrle96smgEvg8ObWvkEy6mUAlH4y3UdKuh2xfnkoxn2kPLlMLnozm8XsZ
         G99w==
X-Gm-Message-State: AOJu0Yw5qarC0r0uZzB1QI4q/Hc3XS/eCvjrG7twTqDF5gSStMhxDDfL
	B6xSFDuoIPVRciIVdynUEBOXzbSGvIFfdkRYb+8LQ4244jDdURvomzkgiQ==
X-Google-Smtp-Source: AGHT+IGmI1sZunKvQ4YJc3vZYOqIsoVGz16xnT7DrjpZ52uGqUX0rkyJGdNnbeZvF+KWFNAqm/PULg==
X-Received: by 2002:a17:902:e748:b0:1fb:62e8:ae98 with SMTP id d9443c01a7336-1ff4ce51dcbmr2285505ad.3.1722510329158;
        Thu, 01 Aug 2024 04:05:29 -0700 (PDT)
Received: from Ubuntu.. ([106.194.76.199])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7edd90dsm136663985ad.161.2024.08.01.04.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 04:05:28 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 3/7] t: move reftable/pq_test.c to the unit testing framework
Date: Thu,  1 Aug 2024 16:29:44 +0530
Message-ID: <20240801110453.5087-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240801110453.5087-1-chandrapratap3519@gmail.com>
References: <20240725093855.4201-1-chandrapratap3519@gmail.com>
 <20240801110453.5087-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable/pq_test.c exercises a priority queue defined by
reftable/pq.{c, h}. Migrate reftable/pq_test.c to the unit testing
framework. Migration involves refactoring the tests to use the unit
testing framework instead of reftable's test framework, and
renaming the tests to align with unit-tests' standards.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 Makefile                                      |  2 +-
 reftable/reftable-tests.h                     |  1 -
 t/helper/test-reftable.c                      |  1 -
 .../pq_test.c => t/unit-tests/t-reftable-pq.c | 39 ++++++++-----------
 4 files changed, 17 insertions(+), 26 deletions(-)
 rename reftable/pq_test.c => t/unit-tests/t-reftable-pq.c (61%)

diff --git a/Makefile b/Makefile
index d6479092a0..1ee83e98dc 100644
--- a/Makefile
+++ b/Makefile
@@ -1340,6 +1340,7 @@ UNIT_TEST_PROGRAMS += t-oidmap
 UNIT_TEST_PROGRAMS += t-oidtree
 UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-reftable-basics
+UNIT_TEST_PROGRAMS += t-reftable-pq
 UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-strcmp-offset
@@ -2681,7 +2682,6 @@ REFTABLE_OBJS += reftable/writer.o
 REFTABLE_TEST_OBJS += reftable/block_test.o
 REFTABLE_TEST_OBJS += reftable/dump.o
 REFTABLE_TEST_OBJS += reftable/merged_test.o
-REFTABLE_TEST_OBJS += reftable/pq_test.o
 REFTABLE_TEST_OBJS += reftable/readwrite_test.o
 REFTABLE_TEST_OBJS += reftable/stack_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
index 114cc3d053..67283faf06 100644
--- a/reftable/reftable-tests.h
+++ b/reftable/reftable-tests.h
@@ -12,7 +12,6 @@ license that can be found in the LICENSE file or at
 int basics_test_main(int argc, const char **argv);
 int block_test_main(int argc, const char **argv);
 int merged_test_main(int argc, const char **argv);
-int pq_test_main(int argc, const char **argv);
 int record_test_main(int argc, const char **argv);
 int readwrite_test_main(int argc, const char **argv);
 int stack_test_main(int argc, const char **argv);
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index aa6538a8da..b808ad3e12 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -7,7 +7,6 @@ int cmd__reftable(int argc, const char **argv)
 	/* test from simple to complex. */
 	block_test_main(argc, argv);
 	tree_test_main(argc, argv);
-	pq_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
 	merged_test_main(argc, argv);
 	stack_test_main(argc, argv);
diff --git a/reftable/pq_test.c b/t/unit-tests/t-reftable-pq.c
similarity index 61%
rename from reftable/pq_test.c
rename to t/unit-tests/t-reftable-pq.c
index b7d3c80cc7..a78aba9e71 100644
--- a/reftable/pq_test.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -6,35 +6,28 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
-#include "system.h"
-
-#include "basics.h"
-#include "constants.h"
-#include "pq.h"
-#include "record.h"
-#include "reftable-tests.h"
-#include "test_framework.h"
+#include "test-lib.h"
+#include "reftable/constants.h"
+#include "reftable/pq.h"
 
 void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
 {
-	int i;
-	for (i = 1; i < pq.len; i++) {
-		int parent = (i - 1) / 2;
-
-		EXPECT(pq_less(&pq.heap[parent], &pq.heap[i]));
+	for (size_t i = 1; i < pq.len; i++) {
+		size_t parent = (i - 1) / 2;
+		check(pq_less(&pq.heap[parent], &pq.heap[i]));
 	}
 }
 
-static void test_pq(void)
+static void t_pq(void)
 {
-	struct merged_iter_pqueue pq = { NULL };
+	struct merged_iter_pqueue pq = { 0 };
 	struct reftable_record recs[54];
-	int N = ARRAY_SIZE(recs) - 1, i;
+	size_t N = ARRAY_SIZE(recs) - 1, i;
 	char *last = NULL;
 
 	for (i = 0; i < N; i++) {
 		struct strbuf refname = STRBUF_INIT;
-		strbuf_addf(&refname, "%02d", i);
+		strbuf_addf(&refname, "%02"PRIuMAX, (uintmax_t)i);
 
 		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
 		recs[i].u.ref.refname = strbuf_detach(&refname, NULL);
@@ -48,7 +41,6 @@ static void test_pq(void)
 
 		merged_iter_pqueue_add(&pq, &e);
 		merged_iter_pqueue_check(pq);
-
 		i = (i * 7) % N;
 	} while (i != 1);
 
@@ -56,9 +48,9 @@ static void test_pq(void)
 		struct pq_entry e = merged_iter_pqueue_remove(&pq);
 		merged_iter_pqueue_check(pq);
 
-		EXPECT(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
+		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
 		if (last)
-			EXPECT(strcmp(last, e.rec->u.ref.refname) < 0);
+			check_int(strcmp(last, e.rec->u.ref.refname), <, 0);
 		last = e.rec->u.ref.refname;
 	}
 
@@ -67,8 +59,9 @@ static void test_pq(void)
 	merged_iter_pqueue_release(&pq);
 }
 
-int pq_test_main(int argc, const char *argv[])
+int cmd_main(int argc, const char *argv[])
 {
-	RUN_TEST(test_pq);
-	return 0;
+	TEST(t_pq(), "pq works");
+
+	return test_done();
 }
-- 
2.45.GIT

