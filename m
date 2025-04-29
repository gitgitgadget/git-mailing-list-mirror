Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41DA253F21
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 17:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949235; cv=none; b=Bl+1qjszs4GzSthx94TvPnAu6BeDSDNPj870NlgU5xKP9DoGPrstLwQ2T4xWlPPXvIlSsjFudqsWxh6avF2N9t4P7mRMg/xUtuNmVLOTLxXD42kdkhY+/yupnbycRxaeWVE36hpGAc96r+lR8vqS6aRYrFjTYBvZ0Rz0qgAMKAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949235; c=relaxed/simple;
	bh=khiHCdD7fEI8unulLwxuQoymvk41Bda2dnJT336zHrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IK+7vvacT8yw+8DIRwEYxMHsooNWeRx3q8+MxvekeqGpE0bdhxzDuWSZFi7CPGmyWuRooywSQRgbbHkgu01QYKyz1/hT2QnMUDFWAJO7nURHTh4PRKUgzbHc19/vVmGYGqYIxSb3Csrctdi2RNYZi6jOvYWjUD+d18k64ocAV0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATJ3KZCC; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATJ3KZCC"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a07a7b4ac7so1990798f8f.2
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 10:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745949232; x=1746554032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCkGjKvl6SPV1FcpDjMBpqO5chPA0duiW+V4oKeVyHc=;
        b=ATJ3KZCC+KgPvjfDuYhZL8Dd0m4QHRq8WMS/y/rNL3bZKy22RTtF7kTXKeYugeS61V
         GOplT5XhAKUyGVSPNZNTkxHmwg2KU4l6lnc/5JLiC3E0xSlzLPj570c7B0h0mKsSVi1l
         SE4Rn1jmlkzNZg3I7FGvT1UGnVvYkvcKzhce8a4UrG/6SbMSxy9wxthXsdHdZI6O9Lke
         lSl4w0ks0wyrDt0WCbhmz23Zckq/ZFN7cthmHZ3oYnzLath5jUXIwC/ZPCDbKPDTNgXF
         XiVv3/kbkBEg073Isu/cvOKeEhfYiIBvp9SM9I9OMDVy0B6wBwoCzdZvE3nuvyX5VzJJ
         8QfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745949232; x=1746554032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCkGjKvl6SPV1FcpDjMBpqO5chPA0duiW+V4oKeVyHc=;
        b=KyiPkLQF4GzykHZYissfUgM2+fhCeRKVL/farQseJh6s70qc0xnCaqfN55D3bo9dHW
         oz030q/bUoTWzuiO5/OFByQA4fefW8qCwKcebdD6mlokBhoFD5OL1ZiVhWCdw/O6xoUK
         x9IQ0t3S/T7IwNbuVo8/s7NyGawN29A3VMNzsBQZupdt7/kgfnGmyy4GYbPGvhnXJLSm
         34K7jRMISzftHk+GZch0UKYEeokF5xBnxnX7cdc8kBp54ZuNDN/BiscieP3Td8O4ovha
         qqJJAQaaxALAO7HAqBcRZKUCKJvH54OhZTr72bH5tNLfVZ9c4Kr6ZLnRY4/wbH5s8T+n
         mAtA==
X-Gm-Message-State: AOJu0YyHMCa5bk0xRKqS6UmZtEBrqu+jhMw4YQ2Q/4TeWEaeiolekPLx
	q19ZKj63T3LJjMqbpEAgJCFeh8fEuWJ2769iZwEaLii/yMEAz+e+NKvE+Zb+Gih/tw==
X-Gm-Gg: ASbGncugpA4IPm28zVqgiCjR+wkPh76RhhQ2lVpkS1VIPqaRo8EVVg7VxQzj3UHSOv9
	f8oCvnNxE5L58AcxC5kFLlFbtES1KKIEizP36oP2sdNdWmIywQ1qT+p+LPJD4bH2pO48McR2ywh
	Jhn/xRfkMlOmwG/JJxwdN9hvGeBHBL2SIak70Q4jrWGPWZK/j8Srh9ANYLu2uezDCySthje9MZo
	g3y3NNxkbhp7iWyNuWLIPzL/WM598QeVDOJwU8zdMny9VmeE8hAL/7/SGbYCRotDl4wjeAGFHip
	0TZ2jNBqCyonulPPrGe1O6kHCcvDm2zWUnM=
X-Google-Smtp-Source: AGHT+IGbnixqKV60GCLotLmDC1dYhXpQoOlKUyBybcbW7Op+U8NlL0p6pXKXPDKnHD4d2j54VWQgNw==
X-Received: by 2002:a05:6000:188e:b0:391:29f:4f87 with SMTP id ffacd0b85a97d-3a08f7d199dmr219140f8f.49.1745949231639;
        Tue, 29 Apr 2025 10:53:51 -0700 (PDT)
Received: from localhost.localdomain ([105.113.85.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca511asm14261782f8f.26.2025.04.29.10.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 10:53:51 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 05/10] t/unit-tests: convert reftable pq test to use clar
Date: Tue, 29 Apr 2025 18:52:57 +0100
Message-ID: <20250429175302.23724-6-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429175302.23724-1-kuforiji98@gmail.com>
References: <20250429175302.23724-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt reftable priority queue test file to use clar by using clar
assertions where necessary.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                     |   2 +-
 t/meson.build                |   2 +-
 t/unit-tests/t-reftable-pq.c | 161 -----------------------------------
 t/unit-tests/u-reftable-pq.c | 152 +++++++++++++++++++++++++++++++++
 4 files changed, 154 insertions(+), 163 deletions(-)
 delete mode 100644 t/unit-tests/t-reftable-pq.c
 create mode 100644 t/unit-tests/u-reftable-pq.c

diff --git a/Makefile b/Makefile
index 2b1642465a..4142927d0a 100644
--- a/Makefile
+++ b/Makefile
@@ -1365,6 +1365,7 @@ CLAR_TEST_SUITES += u-prio-queue
 CLAR_TEST_SUITES += u-reftable-basics
 CLAR_TEST_SUITES += u-reftable-block
 CLAR_TEST_SUITES += u-reftable-merged
+CLAR_TEST_SUITES += u-reftable-pq
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
 CLAR_TEST_SUITES += u-strcmp-offset
@@ -1377,7 +1378,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 
-UNIT_TEST_PROGRAMS += t-reftable-pq
 UNIT_TEST_PROGRAMS += t-reftable-reader
 UNIT_TEST_PROGRAMS += t-reftable-readwrite
 UNIT_TEST_PROGRAMS += t-reftable-record
diff --git a/t/meson.build b/t/meson.build
index 70a783ba80..9bded2d15c 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -11,6 +11,7 @@ clar_test_suites = [
   'unit-tests/u-reftable-basics.c',
   'unit-tests/u-reftable-block.c',
   'unit-tests/u-reftable-merged.c',
+  'unit-tests/u-reftable-pq.c',
   'unit-tests/u-reftable-tree.c',
   'unit-tests/u-strbuf.c',
   'unit-tests/u-strcmp-offset.c',
@@ -57,7 +58,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-reftable-pq.c',
   'unit-tests/t-reftable-reader.c',
   'unit-tests/t-reftable-readwrite.c',
   'unit-tests/t-reftable-record.c',
diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
deleted file mode 100644
index c128fe8616..0000000000
--- a/t/unit-tests/t-reftable-pq.c
+++ /dev/null
@@ -1,161 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#include "test-lib.h"
-#include "reftable/constants.h"
-#include "reftable/pq.h"
-#include "strbuf.h"
-
-static void merged_iter_pqueue_check(const struct merged_iter_pqueue *pq)
-{
-	for (size_t i = 1; i < pq->len; i++) {
-		size_t parent = (i - 1) / 2;
-		check(pq_less(&pq->heap[parent], &pq->heap[i]));
-	}
-}
-
-static int pq_entry_equal(struct pq_entry *a, struct pq_entry *b)
-{
-	int cmp;
-	check(!reftable_record_cmp(a->rec, b->rec, &cmp));
-	return !cmp && (a->index == b->index);
-}
-
-static void t_pq_record(void)
-{
-	struct merged_iter_pqueue pq = { 0 };
-	struct reftable_record recs[54];
-	size_t N = ARRAY_SIZE(recs) - 1, i;
-	char *last = NULL;
-
-	for (i = 0; i < N; i++) {
-		check(!reftable_record_init(&recs[i], BLOCK_TYPE_REF));
-		recs[i].u.ref.refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
-	}
-
-	i = 1;
-	do {
-		struct pq_entry e = {
-			.rec = &recs[i],
-		};
-
-		merged_iter_pqueue_add(&pq, &e);
-		merged_iter_pqueue_check(&pq);
-		i = (i * 7) % N;
-	} while (i != 1);
-
-	while (!merged_iter_pqueue_is_empty(pq)) {
-		struct pq_entry top = merged_iter_pqueue_top(pq);
-		struct pq_entry e;
-
-		check(!merged_iter_pqueue_remove(&pq, &e));
-		merged_iter_pqueue_check(&pq);
-
-		check(pq_entry_equal(&top, &e));
-		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
-		if (last)
-			check_int(strcmp(last, e.rec->u.ref.refname), <, 0);
-		last = e.rec->u.ref.refname;
-	}
-
-	for (i = 0; i < N; i++)
-		reftable_record_release(&recs[i]);
-	merged_iter_pqueue_release(&pq);
-}
-
-static void t_pq_index(void)
-{
-	struct merged_iter_pqueue pq = { 0 };
-	struct reftable_record recs[13];
-	char *last = NULL;
-	size_t N = ARRAY_SIZE(recs), i;
-
-	for (i = 0; i < N; i++) {
-		check(!reftable_record_init(&recs[i], BLOCK_TYPE_REF));
-		recs[i].u.ref.refname = (char *) "refs/heads/master";
-	}
-
-	i = 1;
-	do {
-		struct pq_entry e = {
-			.rec = &recs[i],
-			.index = i,
-		};
-
-		merged_iter_pqueue_add(&pq, &e);
-		merged_iter_pqueue_check(&pq);
-		i = (i * 7) % N;
-	} while (i != 1);
-
-	for (i = N - 1; i > 0; i--) {
-		struct pq_entry top = merged_iter_pqueue_top(pq);
-		struct pq_entry e;
-
-		check(!merged_iter_pqueue_remove(&pq, &e));
-		merged_iter_pqueue_check(&pq);
-
-		check(pq_entry_equal(&top, &e));
-		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
-		check_int(e.index, ==, i);
-		if (last)
-			check_str(last, e.rec->u.ref.refname);
-		last = e.rec->u.ref.refname;
-	}
-
-	merged_iter_pqueue_release(&pq);
-}
-
-static void t_merged_iter_pqueue_top(void)
-{
-	struct merged_iter_pqueue pq = { 0 };
-	struct reftable_record recs[13];
-	size_t N = ARRAY_SIZE(recs), i;
-
-	for (i = 0; i < N; i++) {
-		check(!reftable_record_init(&recs[i], BLOCK_TYPE_REF));
-		recs[i].u.ref.refname = (char *) "refs/heads/master";
-	}
-
-	i = 1;
-	do {
-		struct pq_entry e = {
-			.rec = &recs[i],
-			.index = i,
-		};
-
-		merged_iter_pqueue_add(&pq, &e);
-		merged_iter_pqueue_check(&pq);
-		i = (i * 7) % N;
-	} while (i != 1);
-
-	for (i = N - 1; i > 0; i--) {
-		struct pq_entry top = merged_iter_pqueue_top(pq);
-		struct pq_entry e;
-
-		check(!merged_iter_pqueue_remove(&pq, &e));
-
-		merged_iter_pqueue_check(&pq);
-		check(pq_entry_equal(&top, &e));
-		check(reftable_record_equal(top.rec, &recs[i], REFTABLE_HASH_SIZE_SHA1));
-		for (size_t j = 0; i < pq.len; j++) {
-			check(pq_less(&top, &pq.heap[j]));
-			check_int(top.index, >, j);
-		}
-	}
-
-	merged_iter_pqueue_release(&pq);
-}
-
-int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
-{
-	TEST(t_pq_record(), "pq works with record-based comparison");
-	TEST(t_pq_index(), "pq works with index-based comparison");
-	TEST(t_merged_iter_pqueue_top(), "merged_iter_pqueue_top works");
-
-	return test_done();
-}
diff --git a/t/unit-tests/u-reftable-pq.c b/t/unit-tests/u-reftable-pq.c
new file mode 100644
index 0000000000..ecbf08586c
--- /dev/null
+++ b/t/unit-tests/u-reftable-pq.c
@@ -0,0 +1,152 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "unit-test.h"
+#include "reftable/constants.h"
+#include "reftable/pq.h"
+#include "strbuf.h"
+
+static void merged_iter_pqueue_check(const struct merged_iter_pqueue *pq)
+{
+	for (size_t i = 1; i < pq->len; i++) {
+		size_t parent = (i - 1) / 2;
+		cl_assert(pq_less(&pq->heap[parent], &pq->heap[i]) != 0);
+	}
+}
+
+static int pq_entry_equal(struct pq_entry *a, struct pq_entry *b)
+{
+	int cmp;
+	cl_assert(reftable_record_cmp(a->rec, b->rec, &cmp) == 0);
+	return !cmp && (a->index == b->index);
+}
+
+void test_reftable_pq__record(void)
+{
+	struct merged_iter_pqueue pq = { 0 };
+	struct reftable_record recs[54];
+	size_t N = ARRAY_SIZE(recs) - 1, i;
+	char *last = NULL;
+
+	for (i = 0; i < N; i++) {
+		cl_assert(reftable_record_init(&recs[i], BLOCK_TYPE_REF) == 0);
+		recs[i].u.ref.refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
+	}
+
+	i = 1;
+	do {
+		struct pq_entry e = {
+			.rec = &recs[i],
+		};
+
+		merged_iter_pqueue_add(&pq, &e);
+		merged_iter_pqueue_check(&pq);
+		i = (i * 7) % N;
+	} while (i != 1);
+
+	while (!merged_iter_pqueue_is_empty(pq)) {
+		struct pq_entry top = merged_iter_pqueue_top(pq);
+		struct pq_entry e;
+
+		cl_assert(merged_iter_pqueue_remove(&pq, &e) == 0);
+		merged_iter_pqueue_check(&pq);
+
+		cl_assert(pq_entry_equal(&top, &e) != 0);
+		cl_assert(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
+		if (last)
+			cl_assert(strcmp(last, e.rec->u.ref.refname) < 0);
+		last = e.rec->u.ref.refname;
+	}
+
+	for (i = 0; i < N; i++)
+		reftable_record_release(&recs[i]);
+	merged_iter_pqueue_release(&pq);
+}
+
+void test_reftable_pq__index(void)
+{
+	struct merged_iter_pqueue pq = { 0 };
+	struct reftable_record recs[13];
+	char *last = NULL;
+	size_t N = ARRAY_SIZE(recs), i;
+
+	for (i = 0; i < N; i++) {
+		cl_assert(reftable_record_init(&recs[i], BLOCK_TYPE_REF) == 0);
+		recs[i].u.ref.refname = (char *) "refs/heads/master";
+	}
+
+	i = 1;
+	do {
+		struct pq_entry e = {
+			.rec = &recs[i],
+			.index = i,
+		};
+
+		merged_iter_pqueue_add(&pq, &e);
+		merged_iter_pqueue_check(&pq);
+		i = (i * 7) % N;
+	} while (i != 1);
+
+	for (i = N - 1; i > 0; i--) {
+		struct pq_entry top = merged_iter_pqueue_top(pq);
+		struct pq_entry e;
+
+		cl_assert(merged_iter_pqueue_remove(&pq, &e) == 0);
+		merged_iter_pqueue_check(&pq);
+
+		cl_assert(pq_entry_equal(&top, &e) != 0);
+		cl_assert(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
+		cl_assert_equal_i(e.index, i);
+		if (last)
+			cl_assert_equal_s(last, e.rec->u.ref.refname);
+		last = e.rec->u.ref.refname;
+	}
+
+	merged_iter_pqueue_release(&pq);
+}
+
+void test_reftable_pq__merged_iter_pqueue_top(void)
+{
+	struct merged_iter_pqueue pq = { 0 };
+	struct reftable_record recs[13];
+	size_t N = ARRAY_SIZE(recs), i;
+
+	for (i = 0; i < N; i++) {
+		cl_assert(reftable_record_init(&recs[i], BLOCK_TYPE_REF) == 0);
+		recs[i].u.ref.refname = (char *) "refs/heads/master";
+	}
+
+	i = 1;
+	do {
+		struct pq_entry e = {
+			.rec = &recs[i],
+			.index = i,
+		};
+
+		merged_iter_pqueue_add(&pq, &e);
+		merged_iter_pqueue_check(&pq);
+		i = (i * 7) % N;
+	} while (i != 1);
+
+	for (i = N - 1; i > 0; i--) {
+		struct pq_entry top = merged_iter_pqueue_top(pq);
+		struct pq_entry e;
+
+		cl_assert(merged_iter_pqueue_remove(&pq, &e) == 0);
+
+		merged_iter_pqueue_check(&pq);
+		cl_assert(pq_entry_equal(&top, &e) != 0);
+		cl_assert(reftable_record_equal(top.rec, &recs[i], REFTABLE_HASH_SIZE_SHA1) != 0);
+		for (size_t j = 0; i < pq.len; j++) {
+			cl_assert(pq_less(&top, &pq.heap[j]) != 0);
+			cl_assert(top.index > j);
+		}
+	}
+
+	merged_iter_pqueue_release(&pq);
+}
-- 
2.43.0

