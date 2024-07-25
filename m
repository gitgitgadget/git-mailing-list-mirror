Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952C9198822
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900378; cv=none; b=SZTYhWrg7rsGau4KcaExjpomDv431oDF7OrlcnmRWZ6P94/motmLWsk7I48hGSHAO/yNQRGOdhQkf2zM9bI7QOkuDyGr1e39tqPNc6Zms++80eCNmw4YAJl1TApJRUfsSGCQCdMOs46edCZyF0K+kv1vTG53n7hSIIlwNHJM/KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900378; c=relaxed/simple;
	bh=3maJGZLQFy6uzTGwfimpdYlYH7mPuIRSv6/kGJ2VmP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLUPvV2lhBwKLDJKd9pYVY7Hut8sqplYt0T1lAP5bbp/0DSQc1Egkif1xXyX9PYJl+2K2eCyfl3zX0t3owwIC2vDx9wTCStmr4HxvAiMnYTZR6HuwMccaVBzJGxN8crp8Fy/BCvS2GRsDEMVHhSEMR6VSOI+brjZUXsBkuRUOMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk86kS9x; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk86kS9x"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd9e70b592so5357795ad.3
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 02:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721900375; x=1722505175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWFYUT0nNbkUmcoynWmQbbaLqTcO6uJXhtAvh7Z3QKs=;
        b=Vk86kS9xRMHpqBlWz6whP951vGOPvUZG0pL4XFxX8aZ/S62MuYNspG6wua7tvDj56v
         HNyEiO6Kdmp0LJjvx6lyB0SMMGz/WQuBxy8HquCdyldstgeE7zWP0Ou2pppXXF4QltKE
         TFIf8PGWCgDugntVL4SlVd9cHu2Ulz+dMzskLD2y39pFA8bekKzvTkBQgdIQ7KfC+PIN
         0xAkHgc6UTRKNJ7rN1l3FUAzdpXgfl9sipBEj2eK2cACuIL5k0rji3E/AjkC4aFrVGu7
         DLbaX5FAMwHVE2VyQX5CCLa9cEJS9miy3KY8h6kwohlMdz2bEqqZZT+tKJDcZQlS/rF5
         uZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721900375; x=1722505175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWFYUT0nNbkUmcoynWmQbbaLqTcO6uJXhtAvh7Z3QKs=;
        b=r6Ygj7/nXribepQlcAdw/QMWSs+Jh8wD3mPr4AQsghZAJ4y2EvoaUb7KbkISX6LTsq
         VjDNWckSot9OoLXp2aiy5l6UtVyYAamM0bAwc14K2hq80BxmpraASiNqoD6BatklnVm7
         p/oofs0vi3i3OprOeKT6WRmgfYXKyOQpQIbLXjmYUMIb+Iz8b3denXEtytO6n43OL+Qk
         20vmQN3bG0NXzMhbyWPIAFJQwDgHikqXreFhYBLF9hf7lr9fESRJ+3HXAoiWDSjow4QD
         zqnLS1xpRQDy51AGnU+JPPIGxwgyUvfLfv6MVBVkuSflY25lOVhIxfMR93ME7xNEGpKh
         LrZA==
X-Gm-Message-State: AOJu0Yy3fk6sSDuqmHtf34xqcCJ5ieEi81Gu2hfy/xoMsfsuIvmX3s9T
	EKwuL5idxXr5S3lkh0Fit2y7QMBglxCdVl78J9RZTLzBxkNe/IbNXQ1BrQ==
X-Google-Smtp-Source: AGHT+IHHuA6hQ1g4T3tjdgh16azTuGZaJq95yDrJYb/v16u7AxHj6nvsmF13vljiJP20GrjZwsAbvQ==
X-Received: by 2002:a17:903:22cd:b0:1fc:560b:1456 with SMTP id d9443c01a7336-1fed3860054mr24384235ad.15.1721900375373;
        Thu, 25 Jul 2024 02:39:35 -0700 (PDT)
Received: from Ubuntu.. ([117.96.151.20])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7cf1db4sm9950895ad.87.2024.07.25.02.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:39:34 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 3/7] t: move reftable/pq_test.c to the unit testing framework
Date: Thu, 25 Jul 2024 14:55:55 +0530
Message-ID: <20240725093855.4201-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240725093855.4201-1-chandrapratap3519@gmail.com>
References: <20240723143032.4261-1-chandrapratap3519@gmail.com>
 <20240725093855.4201-1-chandrapratap3519@gmail.com>
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

