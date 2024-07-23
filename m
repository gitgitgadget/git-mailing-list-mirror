Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984FD139D1A
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745199; cv=none; b=SbzUfGsUIeCIx7h9733mxjXuUS2GIXaC/C5qa2uADDbHXCvIYHEynn6eG+iEXWR9j5fLO7o3KvGNEU2TyiTaEAFet1SN3ZqRSGjH0MJFBt/+qLYht1equRXRWIXRgAzKlGHrj55FCQ4l6Lg5vkgDqfv7IZrnIQtRr8Cf7C8M9WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745199; c=relaxed/simple;
	bh=3maJGZLQFy6uzTGwfimpdYlYH7mPuIRSv6/kGJ2VmP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYftAFCdnhsJhp74qK7QyWOtiRDphcbiOUS9vj7t88wPs5e/kaQgcCFsb97Nbu/TMc/OQCufTNyP7tfCjVovPG6ehPu/jxrDpFL6Tom0Lyv3Ajv7VO5GRL1LG5Db2PydzQ/TmDp+fBx+IGxSXtT45rw8H7GwHyghiObC3sQxavY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aorehlh8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aorehlh8"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc4fcbb131so6029745ad.3
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 07:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721745196; x=1722349996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWFYUT0nNbkUmcoynWmQbbaLqTcO6uJXhtAvh7Z3QKs=;
        b=Aorehlh818ZYBpE7CPZ8DsY67g4A7/8Y8upcWUk1IDKPsD2nWG2il/cOm6F314MU+I
         mU1/73zqU3bgmnqdzyhvlfxai8vamaaTM5tOh5TAmV12UVdStV1gdjiVwM7jd1BSAInD
         5XMiUyJCNu0QddXPzD425i7YbsC0dMkF6YxYCYDT9MPPuIeZpu8nMeTEcSJ6hNA4h2eB
         aoLfU3fDTWSEJqeVBTsqJttFsjkyN40WLz8cn2t8lN5+JbWWRf8X7dNftvrsi+FjRNCb
         vV6TgXsLJDNBvjXItPHzN8AloZZVXaS3UhzZhfoFIpzCrlptqYt3a5eRa8b0DpaBt0/4
         GsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745196; x=1722349996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWFYUT0nNbkUmcoynWmQbbaLqTcO6uJXhtAvh7Z3QKs=;
        b=jr3uZx5WSo/vak0CdbIe8EAhLRckTrTg5ncMgUKJGnrfir3Pvin5oNpb58hsMPlfeP
         XMtV/CKkK1f1YQFXLKKmISR+q4FKyOuh/bEoFNEnJhSGH2v3wsn69MTJanHZjxQp5/7A
         M9ufYXukUBcfKg17dKmqfbI1otHE/k9KzbTLjcgdxIDvZBYOhK/pcyRwrTshZK7xxxKj
         8PZwQlrWm1JntFobZCNJjVz5m83SADCIyUjqwAGZwweikqSnMYlyC351RNLYPq09ZO29
         QG8UONjKSF6icalei0Hb2LksyfGxzBqUU4e+DSwPL0ybVyLV1+Uw3VbNqi2spSeBbZm/
         EmkQ==
X-Gm-Message-State: AOJu0YzPUkEhXhIM411VVKWXItjNsJvtog99Dij5GEiazbLgW3CORRmM
	0uVfuq4FFR9jZH8wR8QvyD9bN1xILu+PLz4sL5O0sNZgAkxJZNyPhSUKlMnPpZE=
X-Google-Smtp-Source: AGHT+IHVQgHK4nYSKAwTKFnE/j5GCdAfaSfwjZtmf32o5H2vwguHvcqnZ2Ucb4PEclIqmIHTXBj/gg==
X-Received: by 2002:a17:902:ecd0:b0:1fc:3daa:52 with SMTP id d9443c01a7336-1fd74532fd5mr105513815ad.11.1721745196425;
        Tue, 23 Jul 2024 07:33:16 -0700 (PDT)
Received: from Ubuntu.. ([223.176.63.81])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fd6f256c09sm75301305ad.2.2024.07.23.07.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:33:15 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 3/7] t: move reftable/pq_test.c to the unit testing framework
Date: Tue, 23 Jul 2024 19:47:13 +0530
Message-ID: <20240723143032.4261-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240723143032.4261-1-chandrapratap3519@gmail.com>
References: <20240614095136.12052-1-chandrapratap3519@gmail.com>
 <20240723143032.4261-1-chandrapratap3519@gmail.com>
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

