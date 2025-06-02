Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1875B21ABC3
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748867244; cv=none; b=Fe8lUhNCC8UUGO1OhVo9FkmBir4Acrm+BfiKHMavJXa183ZxzG9IHrDkOA/5IShh3hnYkS5Xd5DQQADCZPIgpEXyi1c/+NQt9f4OJtQM3i9MVQk2dp8Uvc4oy2JIXPeGrMVMlaeHnO05nZz53p3f1Jez94VBEc1PXiacFTk22ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748867244; c=relaxed/simple;
	bh=RIqIMojYWZ7O1LLACOgzlZx01IBspFbUOEqLL8jWH4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYVcu1UHEM2aKbMMkNuH5gLXUVBcTy4b7J5R7HZ/X35QGKiPdm/p+sQJJx1sQvSy3tlJwIUBBwvf3o1LqPBmwvXW6PwaYl61jDitFylpvl5RAWbtqVV4XjQFmA9JfFaMPXtWjcmNzWlofbjAeZRArvRIYys8ttUiJwVxFShA7MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhQ1x9Lq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhQ1x9Lq"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450df5d7b9fso14597545e9.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 05:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748867239; x=1749472039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Y+VYArlY0V4cWmBdlChoheUnwSdUqWNktNm9sa9LMk=;
        b=JhQ1x9LqUKcaj8ApEzQy3TKavMYLqWTvIM/6/k6E1exQ4MMWj9S51kpCpRo7t3I/Hc
         vMSuyPqibr5lEAOU1QQk6lRZWBfLPHH+oVlZ1Hg3cvFTUGVuudWU297jSNM/XQYVyUa4
         F2Rjx46d+UDTAtEzRHWIlqqshmQTYHkBnNe+pTnyRWGB5RdIGQjm27++p+t17o3aHFT9
         YR+OO25fFIu9NGWLjg9aE3hkgBB2DfBemTPU02h+qrE6ucx6/iQDR1DGrkAbPNPjWzbw
         QP8ZTT4WTNg+EoZQ072t/2sRBMtmS8s0Bp5yrV2b1PCso/4t5uqC04wMqJdYKY8cm51g
         75Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748867239; x=1749472039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Y+VYArlY0V4cWmBdlChoheUnwSdUqWNktNm9sa9LMk=;
        b=PPDf8oOW0q56UttQ72bq+sUQNGM7AXhGBY7IARxHF9MZ+RQPtoqM9XlegwYMic3NTc
         LLfEPqD/wJq0ZlpkGUJlBffP2Da7/jpjh86GeMDTqgNP27qrAxu9rM5LYe2XO8y2wjBR
         inbWLD00kZns9vs2UUGIL75BF2apKUwMDwhfihU7dtcGCgod/Hta8uzLkwsv+lLcPbkH
         QFA9/e1iq92JMMeCGoaEDnkqQ9rwagud10ydvzapeCxO1ZwoG9mta9+OY5mQyv/OHcW/
         0pq76m4uiY3EKfGbxhSmb0nUVr2hKP+4POyG3wh1wrvnmKoKDgEfSoTxXAwCB4C1f4HW
         Nndw==
X-Gm-Message-State: AOJu0YwLDQ5FKcBljg/ft6dV5D9G7pNysGaqY4o6ZZ++Vg9YrNZKSi+c
	NjAPuEVm9mKKT+/L9E8QGtTH/d47nphACkdFtRKctDlykKsGqwHiIEFB4ZTFD3HYPTY=
X-Gm-Gg: ASbGncs/wfjl3Db0ntPA3iNwWSoOQMVsNly2+ZLaPtlEBkAnn4F8qSm7CaGkonFrPY0
	MBwdPfjPRvOo1QcdgdDWj/W9qK2IdWJ2nhv57E5r962Mise5jxo2OWErZUm3iXuDkb6P1pmzcih
	6QVRyTdRu0Bgxv9pNWoCU45BFbIRwxDetoyWhQgSXGo7Rz1Y0IXeTE3PcZuJRFy4+RzXXDlUgJy
	K7op5Nd1lrPT5ajB1Bg9+o0kxdHLmjThHyZctW7Sk0RUGJC+od6AGzHIyI4M1di3NT0Hux0L8ej
	mPUP8oY2oteIWcURX2H7qGBuuIXf+EHPr/vW+piOoT237y6kzo0rf2mSb5Hr/G+Now==
X-Google-Smtp-Source: AGHT+IHJXAzYC6PRAAoAjzOVP8+178PR/hYhU25OnYR2eUTlhzeTdOifYFVj7hRW/xUjyyhKf/hGrw==
X-Received: by 2002:a05:600c:1f95:b0:451:e260:353d with SMTP id 5b1f17b1804b1-451e26036c0mr1938315e9.8.1748867238833;
        Mon, 02 Jun 2025 05:27:18 -0700 (PDT)
Received: from localhost.localdomain ([105.113.90.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451d30a227csm51034145e9.0.2025.06.02.05.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 05:27:18 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v3 05/10] t/unit-tests: convert reftable pq test to use clar
Date: Mon,  2 Jun 2025 13:25:53 +0100
Message-ID: <20250602122559.208780-6-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250602122559.208780-1-kuforiji98@gmail.com>
References: <20250602122559.208780-1-kuforiji98@gmail.com>
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
index fb5a4eb187..b3d64f55de 100644
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
+	cl_assert(reftable_record_cmp(a->rec, b->rec, &cmp) == 0);
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
+		cl_assert(merged_iter_pqueue_remove(&pq, &e) == 0);
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
+		cl_assert(merged_iter_pqueue_remove(&pq, &e) == 0);
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
+		cl_assert(merged_iter_pqueue_remove(&pq, &e) == 0);
 
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

