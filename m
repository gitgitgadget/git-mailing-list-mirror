Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D732E041A
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367429; cv=none; b=aKz5wJ+Og0/YMN5/DdcpAL/GMV6rEdOpCNcldgwUY1JpbYLRQ9qvnhvi2bfcFRDoofec8PFORmvbegRM69+fZdLmgpAs1EeSR9MFTBKw62xga9RnN3b5lPCkqrTSHV30ZIFbhDQnKY4dTKYaaqkps1cj+dINEQGp/FtPhWq9ehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367429; c=relaxed/simple;
	bh=C+DuT42pItD+R5I9C407oDOI5Im8JWn+DH17krSEYHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLn5b4QTSe56JEkv99whiTcb79FapvkXobh8oT+coK9wu5oEgaV1rvL8x0s4/hcjC1IqTCGtFwhRMAYo2/H8KI4Sy10esr7bM9Zf45wfG5aGsegMZHm52gManOi2Ma9CWYjLGeG4yqrq+1oRlOqIL0rWcXTC3ZPA2OWMHl6/rak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMIQ7QHe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMIQ7QHe"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so10944485e9.3
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 07:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753367425; x=1753972225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZOeT0Oi/8nd5v3Gcr93q/I+egE8tou6RmQeLx72oEY=;
        b=TMIQ7QHemlIqStmQMQ/Lcfy5GatTIteM+WedEGV3Q+KjiUPpFba8wLKovjSJa2vDZ5
         m09jmREzzkF1RyMzXK3Ysr591rZFNnLhUJilJOuTVT2Kn3ivLxRl7GjMuVVb7TfpbMsX
         YIuVbsWzH5BN93eYjEKP2s5LoXhFff6SHYNzAvVoTVoOrEmyD1VXK7FV1saHxxN7Epdr
         xjHARK8bZNzBnLyrXUNJ0OIbm2yKduVkfkf5wGGDlx2i1yJgz85TS6G3Ri21w73ImVtS
         KXcfy5h3cc6X6CSWxNI24n28fVmOAjCJ5nFXvWYyXA3RAe7WNIzzuTsxlw8pHt3sxivI
         pIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753367425; x=1753972225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZOeT0Oi/8nd5v3Gcr93q/I+egE8tou6RmQeLx72oEY=;
        b=mb224pMrYD4RZ8Q7eG8HZ2rFZ0lrD+xWUq0QtScsVD+hZxGSuqJ/NELqChn4RUJwBV
         YBh7ZqixR9ZQ2tJoZaT8mNMYJ9e1XWku8RZ/EsZpxUcayjj4dyTFfblnKMP226W3HBV9
         Zrh5hKGrqIg2b3xiNW39WM2iF+Apq/xHUITSKyF9mg5HuGLfWiKXdyOqPLihTRammjJg
         AET52R+rJl8f7qMwZkcsw+1PeULabMXzXdDo5VLMetKwcm4AHCFPxYS0sgD6ErsusE0w
         Y02Bk30k0Ca1oufLCgiSry6+b6Aty9dmeY2mmKxpyyKzf9tp78B9m5Uwm9eqEEnh3nWt
         NWyQ==
X-Gm-Message-State: AOJu0YzHHYvC5WZIZ3llRhhquyWNOZKkrpQEWU6x82Xa388ub6yQAZJl
	86kxORKHHOg8QS1Mt01ym2LnfnbF7TMVtnQsLAAb7ndl/QW5dBt2/RAWSijJiUqDAizOrHjR
X-Gm-Gg: ASbGncsFJApqvm/JOkHnmgQTnO5284IK6bbFPgpf06KbMY9iIkqo8ULFwhOlvuivKRW
	PiQEHR+m7id2Dw5L5VJmcG/BZeUrcCTx2cvE1aUuZZwfMlRSk/T2jXac0fAAB2SZVseYH4P9kk3
	pbWsXGTvDJpZvaKBYoQyZrjTeM4ySp0chyUMNcRRka46cSWfNSHH2Xi4DQUbJdcjnyj++anzTWH
	6Rt3VhR+r6MwfgGqd5Z0urdS2ePAB5O0Yhsyc9WbEGCZjwFWXcnllaQbYP8X/LWWhCjD/e6BY7u
	bBweCdWOvcO2iDKwaiQ57u1XcS7cxhOathrYF1uHH/udryNw1QszUE0UG5UJn/XjyPycb850J8R
	qVmJx6c2DVlZ7mgBo
X-Google-Smtp-Source: AGHT+IHukWi+3GmLmgI1z9IOLGUEQ6mGJXG0kDLgpf+urq7AF6bIsu/EWI0MStKZilvMWbmIfIb69w==
X-Received: by 2002:a05:600c:5029:b0:456:11cc:360d with SMTP id 5b1f17b1804b1-4586ae36d06mr62546785e9.9.1753367424607;
        Thu, 24 Jul 2025 07:30:24 -0700 (PDT)
Received: from localhost.localdomain ([105.113.77.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586ec63d29sm22792135e9.1.2025.07.24.07.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 07:30:24 -0700 (PDT)
From: Seyi Kufoiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 05/10] t/unit-tests: convert reftable pq test to use clar
Date: Thu, 24 Jul 2025 15:28:32 +0100
Message-ID: <20250724142837.67149-6-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724142837.67149-1-kuforiji98@gmail.com>
References: <20250605140644.239199-1-kuforiji98@gmail.com>
 <20250724142837.67149-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seyi Kuforiji <kuforiji98@gmail.com>

Adapt reftable priority queue test file to use clar by using clar
assertions where necessary.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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

