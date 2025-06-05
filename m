Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1652AD13
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749132501; cv=none; b=qScIH/8mBrCbzJHDmIgOwlFEq5VJ3w4hEFQNO4cdvHCYIQ9C0FO31Nu/EOLP6PVIVAag1g1OmxKngjARz7BezYI2eiz3/m6/dSewpdRL4B9VsRLsuFI8wHs/qDpsTn+8w9v1IcSlosxZmuMPmAr/2uH53+tUs9lp3vCXmuXJ2PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749132501; c=relaxed/simple;
	bh=9Co+v01fL5GKrjuBX10t/lqe5sHoB4+3Kp4sY9PBBR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTJMoFutcdrNleKFUdmmnFwCkfNCteF8zGtFPMdXgPTcdtiolsklKLmlPplp+xY5UZdBU6AlqewFuu5zUMpaFUf3IDk9Cl5X3zSHr00CWByxOjnfrqkTZbh+7GsOpByrxe+hSu0nZujNeOQ/E75PJZuf6059LU0PfVdfIlWDpA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmmPSBoi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmmPSBoi"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-441ab63a415so10024275e9.3
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 07:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749132497; x=1749737297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0jgjxuUBmx8bS9g/x0VRfZRInrbGJSKWXxLdCfNuxk=;
        b=LmmPSBoiGuwNt2r+0m/wwsHcPppiA0VBXlkTjPoyRQggVvY/ioWP6qJ1APmNrsm7fR
         YJs6re6VzfowWSc4LAstIQ8Nwxuz+NaGzVXHZGpwRIlcbuqkEiSeAifBZu8OFceBxUFf
         YSQDeBLMgK7OaoS/QRwK+9V2GCNwYRdiNorYq3HxUSkLudWejE+Qs/+aZck82afetMPP
         Ad/h06SMNbZzsZIHQt75gZCn+dvcKJMq/AH2StLqq3jfWV3SwDLfboUhghYP83wyhO14
         dfwKfk25xs3Vz0Llsidy9Q2wWOMRe7lt0aO9Z2h/5ghjC4Bi18qECNuHp3GUH1h25FwK
         8Utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749132497; x=1749737297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0jgjxuUBmx8bS9g/x0VRfZRInrbGJSKWXxLdCfNuxk=;
        b=rkQ6X85Anx45hC6zaoyEPHgOG6YoKkNROeMCHBxw34vjYM0HhzMtABvyBGjA9k0+Hn
         /LmVA9ME+5ypz4yHrP6YVQF/OIPbaKtVP97UQy/LLDPRcRY9C+dnvOXfedf3G1TOUXAa
         iCD9vkMWHWS//3Ala2dUIH16jStzKy6nrnq1OqVlQ0VwWm3VF85nWTj7w7a7OC5FWMOD
         FLvRoJyPumtg8pCNUT3V7cDEHYN6hatOfg6WolErIUSwnLNHm3tQ3nGPin7ZJEcEpJsh
         YEgxeIlZR3eztorW5yxyDdpJkXBmW+U4TSAtWg74XaQ/2TGOk6dd/HbTwG/60qBsCf7L
         xg7A==
X-Gm-Message-State: AOJu0Yzmz+6u5Rq5UP/6i7tac5h+9V6ESMI5y8cSdHeZ0QJkHyv2mLr5
	e3kfaYHA2VLiyPcXZp3CL0GnOKx/4KJi4f32Vml9OhKzuNK2Bt+NCSj7C332/o2ZWsg=
X-Gm-Gg: ASbGncv1mL/Di7qE0Qa/u8bTu9B4UwQ7GmsT4u8jFRRy3rYK+lsSK10+h3mYszYrOXo
	swAZU7rc+zIuyL2/1KCNT9E2WiVm6QZcXLWjuYxPjRWSDaiPLdp/p+1N104cJXKoCXVNXMo5CO+
	LHenequ/LCCjdETiivsGZ90wsLMR9yJcYcAOkoHYB+mx8zBlhGjAMk8vT7gA2CsMBpbqi2+/vIW
	0U2rUQ/WSWzHHPzhWWfWE/PkzNabtV311GeL0ahj+B00BJ8fSS+4d1YXiiQeJ4TuhD6KUHNV4ed
	YP99qFbPQBL5K+ttALbl2WjzaHBBXdYq3d+RXvDGgh7m2WmcZ7yyBkdx
X-Google-Smtp-Source: AGHT+IE1coY605ulcv6J8o14RRiAjGyVSeoSb+Pke4jTxsHQUR5fbBCnQDUxu4DAkGF5gqzgCwM3uQ==
X-Received: by 2002:a05:600c:45cf:b0:441:b00d:e9d1 with SMTP id 5b1f17b1804b1-451f0a649b7mr70274295e9.2.1749132494913;
        Thu, 05 Jun 2025 07:08:14 -0700 (PDT)
Received: from localhost.localdomain ([105.113.85.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451fe39fc52sm8827305e9.27.2025.06.05.07.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 07:08:14 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v4 05/10] t/unit-tests: convert reftable pq test to use clar
Date: Thu,  5 Jun 2025 15:06:39 +0100
Message-ID: <20250605140644.239199-6-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250605140644.239199-1-kuforiji98@gmail.com>
References: <20250605140644.239199-1-kuforiji98@gmail.com>
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
 Makefile                                      |  2 +-
 t/meson.build                                 |  3 +-
 .../{t-reftable-pq.c => u-reftable-pq.c}      | 59 +++++++++----------
 3 files changed, 30 insertions(+), 34 deletions(-)
 rename t/unit-tests/{t-reftable-pq.c => u-reftable-pq.c} (64%)

diff --git a/Makefile b/Makefile
index fb0ef10ff2..3cccc73073 100644
--- a/Makefile
+++ b/Makefile
@@ -1367,6 +1367,7 @@ CLAR_TEST_SUITES += u-prio-queue
 CLAR_TEST_SUITES += u-reftable-basics
 CLAR_TEST_SUITES += u-reftable-block
 CLAR_TEST_SUITES += u-reftable-merged
+CLAR_TEST_SUITES += u-reftable-pq
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
 CLAR_TEST_SUITES += u-strcmp-offset
@@ -1380,7 +1381,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
 
-UNIT_TEST_PROGRAMS += t-reftable-pq
 UNIT_TEST_PROGRAMS += t-reftable-readwrite
 UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-reftable-stack
diff --git a/t/meson.build b/t/meson.build
index d25dfb0c92..ac4394b7a2 100644
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
@@ -58,7 +59,7 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-reftable-pq.c',
+  'unit-tests/t-reftable-reader.c',
   'unit-tests/t-reftable-readwrite.c',
   'unit-tests/t-reftable-record.c',
   'unit-tests/t-reftable-stack.c',
diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/u-reftable-pq.c
similarity index 64%
rename from t/unit-tests/t-reftable-pq.c
rename to t/unit-tests/u-reftable-pq.c
index fb5a4eb187..d55792ca6f 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/u-reftable-pq.c
@@ -6,7 +6,8 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
-#include "test-lib.h"
+#include "unit-test.h"
+#include "lib-reftable-clar.h"
 #include "reftable/constants.h"
 #include "reftable/pq.h"
 #include "strbuf.h"
@@ -15,18 +16,18 @@ static void merged_iter_pqueue_check(const struct merged_iter_pqueue *pq)
 {
 	for (size_t i = 1; i < pq->len; i++) {
 		size_t parent = (i - 1) / 2;
-		check(pq_less(&pq->heap[parent], &pq->heap[i]));
+		cl_assert(pq_less(&pq->heap[parent], &pq->heap[i]) != 0);
 	}
 }
 
 static int pq_entry_equal(struct pq_entry *a, struct pq_entry *b)
 {
 	int cmp;
-	check(!reftable_record_cmp(a->rec, b->rec, &cmp));
+	cl_assert_equal_i(reftable_record_cmp(a->rec, b->rec, &cmp), 0);
 	return !cmp && (a->index == b->index);
 }
 
-static void t_pq_record(void)
+void test_reftable_pq__record(void)
 {
 	struct merged_iter_pqueue pq = { 0 };
 	struct reftable_record recs[54];
@@ -34,7 +35,8 @@ static void t_pq_record(void)
 	char *last = NULL;
 
 	for (i = 0; i < N; i++) {
-		check(!reftable_record_init(&recs[i], REFTABLE_BLOCK_TYPE_REF));
+		cl_assert(!reftable_record_init(&recs[i],
+						REFTABLE_BLOCK_TYPE_REF));
 		recs[i].u.ref.refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
 	}
 
@@ -53,13 +55,13 @@ static void t_pq_record(void)
 		struct pq_entry top = merged_iter_pqueue_top(pq);
 		struct pq_entry e;
 
-		check(!merged_iter_pqueue_remove(&pq, &e));
+		cl_assert_equal_i(merged_iter_pqueue_remove(&pq, &e), 0);
 		merged_iter_pqueue_check(&pq);
 
-		check(pq_entry_equal(&top, &e));
-		check(reftable_record_type(e.rec) == REFTABLE_BLOCK_TYPE_REF);
+		cl_assert(pq_entry_equal(&top, &e));
+		cl_assert(reftable_record_type(e.rec) == REFTABLE_BLOCK_TYPE_REF);
 		if (last)
-			check_int(strcmp(last, e.rec->u.ref.refname), <, 0);
+			cl_assert(strcmp(last, e.rec->u.ref.refname) < 0);
 		last = e.rec->u.ref.refname;
 	}
 
@@ -68,7 +70,7 @@ static void t_pq_record(void)
 	merged_iter_pqueue_release(&pq);
 }
 
-static void t_pq_index(void)
+void test_reftable_pq__index(void)
 {
 	struct merged_iter_pqueue pq = { 0 };
 	struct reftable_record recs[13];
@@ -76,7 +78,8 @@ static void t_pq_index(void)
 	size_t N = ARRAY_SIZE(recs), i;
 
 	for (i = 0; i < N; i++) {
-		check(!reftable_record_init(&recs[i], REFTABLE_BLOCK_TYPE_REF));
+		cl_assert(!reftable_record_init(&recs[i],
+						REFTABLE_BLOCK_TYPE_REF));
 		recs[i].u.ref.refname = (char *) "refs/heads/master";
 	}
 
@@ -96,28 +99,29 @@ static void t_pq_index(void)
 		struct pq_entry top = merged_iter_pqueue_top(pq);
 		struct pq_entry e;
 
-		check(!merged_iter_pqueue_remove(&pq, &e));
+		cl_assert_equal_i(merged_iter_pqueue_remove(&pq, &e), 0);
 		merged_iter_pqueue_check(&pq);
 
-		check(pq_entry_equal(&top, &e));
-		check(reftable_record_type(e.rec) == REFTABLE_BLOCK_TYPE_REF);
-		check_int(e.index, ==, i);
+		cl_assert(pq_entry_equal(&top, &e));
+		cl_assert(reftable_record_type(e.rec) == REFTABLE_BLOCK_TYPE_REF);
+		cl_assert_equal_i(e.index, i);
 		if (last)
-			check_str(last, e.rec->u.ref.refname);
+			cl_assert_equal_s(last, e.rec->u.ref.refname);
 		last = e.rec->u.ref.refname;
 	}
 
 	merged_iter_pqueue_release(&pq);
 }
 
-static void t_merged_iter_pqueue_top(void)
+void test_reftable_pq__merged_iter_pqueue_top(void)
 {
 	struct merged_iter_pqueue pq = { 0 };
 	struct reftable_record recs[13];
 	size_t N = ARRAY_SIZE(recs), i;
 
 	for (i = 0; i < N; i++) {
-		check(!reftable_record_init(&recs[i], REFTABLE_BLOCK_TYPE_REF));
+		cl_assert(!reftable_record_init(&recs[i],
+						REFTABLE_BLOCK_TYPE_REF));
 		recs[i].u.ref.refname = (char *) "refs/heads/master";
 	}
 
@@ -137,25 +141,16 @@ static void t_merged_iter_pqueue_top(void)
 		struct pq_entry top = merged_iter_pqueue_top(pq);
 		struct pq_entry e;
 
-		check(!merged_iter_pqueue_remove(&pq, &e));
+		cl_assert_equal_i(merged_iter_pqueue_remove(&pq, &e), 0);
 
 		merged_iter_pqueue_check(&pq);
-		check(pq_entry_equal(&top, &e));
-		check(reftable_record_equal(top.rec, &recs[i], REFTABLE_HASH_SIZE_SHA1));
+		cl_assert(pq_entry_equal(&top, &e) != 0);
+		cl_assert(reftable_record_equal(top.rec, &recs[i], REFTABLE_HASH_SIZE_SHA1) != 0);
 		for (size_t j = 0; i < pq.len; j++) {
-			check(pq_less(&top, &pq.heap[j]));
-			check_int(top.index, >, j);
+			cl_assert(pq_less(&top, &pq.heap[j]) != 0);
+			cl_assert(top.index > j);
 		}
 	}
 
 	merged_iter_pqueue_release(&pq);
 }
-
-int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
-{
-	TEST(t_pq_record(), "pq works with record-based comparison");
-	TEST(t_pq_index(), "pq works with index-based comparison");
-	TEST(t_merged_iter_pqueue_top(), "merged_iter_pqueue_top works");
-
-	return test_done();
-}
-- 
2.43.0

