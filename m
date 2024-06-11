Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86763175549
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094777; cv=none; b=jwSPHs7hlSF8TMv/AIjT02R7PezIeW2899LrmNB2SOeE5BinFqmecYTE+xzrPduVDh3AbfllFnFbyFTMDXwH2LzJ7t305X6t3WSEkI0c4CxQvJuQiIuItrCpPVX6h/aN0ClVLm4hvXSr3E+E7Bet/5oiUpesa2ffVGoE3eiXULc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094777; c=relaxed/simple;
	bh=lDezlVhbx4xsaZZRDTavwaiORNa5S6p3fLN6vjDPF2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jls1hMTJ4+ZgzJ/64oZbHnRTqPWzpSKfw0ru0WdZ8LWmsNF0a36vl1p31RTiJX1lA5Ac0da+M0FiUJS6hYU+8R6cYSPv6tqWdQ0lBHBDnn0mf3hw7R75nH57EtNh8uYzM1RA2gjzARkT8oVaUB6hM25ByzMU+CsZnLcc6FJqQ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oawnktpf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oawnktpf"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70436ac872aso800858b3a.1
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 01:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718094774; x=1718699574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJRxUKvgzPgiuPQGG7wF/Iiv7ARwpsrNISAnWEDh/wg=;
        b=OawnktpfHySZ/TcQueG94pGrYhxg6COo1OctKS0vLuoOUD1D3AWzCBrUXXTKDjNtrV
         y0sC8yNNwLWeztWQjMNNti9uPUjdKicn3GF4A1sT+cs3IxoIpsVhWX4/JuvL/CUVFDFp
         /lON7RA9erDK3vzldUWnKTzXbcTNeNPqgJ7JXu3qSz9cCX+4qBt5SaHMsVqNzwngML1n
         Ehc2lXFezSYTMcBbpNhiEtfrN+ktre/SCtYl57GhMQSrOoO3ilIXjzATuJXhqozUaQ0J
         /IliO27PumNKj55L7MM/83ILRD5zzczT5p5I6dC5SRVzhYi3rNs1xjdSh3PGnFYe4vOY
         SowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718094774; x=1718699574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJRxUKvgzPgiuPQGG7wF/Iiv7ARwpsrNISAnWEDh/wg=;
        b=Dp1gbYU++n+cKVmreDUS05ht9AqASnRYIdd2bXIkyuAsaGz5EuLbCrYK98ZSJINc2R
         Lay8UdXJq3P3FvbRxJNA7IQFd5bqeQjIKU6O+BQHSmJtUwYt5XHMb/WKrINqepmx6kc+
         ZnInrxUVQB7eOIfs5Lw9eUAHellRcrI7gVaRpxivMGVnEL4+k/668SorQX/Y9PkEWKbO
         f3QGBwZ7XZlRuWfoy1tbR2r6vxNG6upCaeYUsSTiLCAchIlN3tV26uCrsWoe9ucmYd93
         uAs7wIV4MNLAQCkzZMSGWzndw1e3dPaiwErPjIzDC+WFtly52kYUh3dIWmZX0+O73FGE
         BvqA==
X-Gm-Message-State: AOJu0YxOgosBf9W5NTG4EO25xZeLSMa1bCGKgpdQIMMjaSYXfvwQ4eoF
	ufAUmxumLuikjthAzIYjxDuBQw3se4supogXtn6xOucnXSelbsqVAF9HtA==
X-Google-Smtp-Source: AGHT+IFq1Ss1Yz98LYRSKnpo5edHcNWEksSkznvoo5DvzA612LBQWZuqzmtwWxwqL/5W2qRI1zrjGA==
X-Received: by 2002:a05:6a00:983:b0:704:6ea0:2bba with SMTP id d2e1a72fcca58-7046ea05ad1mr9351326b3a.4.1718094774304;
        Tue, 11 Jun 2024 01:32:54 -0700 (PDT)
Received: from Ubuntu.. ([106.206.199.126])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7041cff68d0sm5776170b3a.185.2024.06.11.01.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 01:32:53 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 3/7] t: move reftable/pq_test.c to the unit testing framework
Date: Tue, 11 Jun 2024 13:49:20 +0530
Message-ID: <20240611083157.9876-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240611083157.9876-1-chandrapratap3519@gmail.com>
References: <20240606154712.15935-1-chandrapratap3519@gmail.com>
 <20240611083157.9876-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable/pq_test.c exercises a priority queue defined by
reftable/pq.{c, h}. Migrate reftable/pq_test.c to the unit
testing framework. Migration involves refactoring the tests
to use the unit testing framework instead of reftable's test
framework.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 Makefile                                      |  2 +-
 t/helper/test-reftable.c                      |  1 -
 .../pq_test.c => t/unit-tests/t-reftable-pq.c | 37 ++++++++-----------
 3 files changed, 16 insertions(+), 24 deletions(-)
 rename reftable/pq_test.c => t/unit-tests/t-reftable-pq.c (62%)

diff --git a/Makefile b/Makefile
index 59d98ba688..1cabe4cc69 100644
--- a/Makefile
+++ b/Makefile
@@ -1336,6 +1336,7 @@ THIRD_PARTY_SOURCES += sha1dc/%
 UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-prio-queue
+UNIT_TEST_PROGRAMS += t-reftable-pq
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-strcmp-offset
 UNIT_TEST_PROGRAMS += t-trailer
@@ -2675,7 +2676,6 @@ REFTABLE_TEST_OBJS += reftable/basics_test.o
 REFTABLE_TEST_OBJS += reftable/block_test.o
 REFTABLE_TEST_OBJS += reftable/dump.o
 REFTABLE_TEST_OBJS += reftable/merged_test.o
-REFTABLE_TEST_OBJS += reftable/pq_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/readwrite_test.o
 REFTABLE_TEST_OBJS += reftable/stack_test.o
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index bae731669c..86a2b0f91a 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -9,7 +9,6 @@ int cmd__reftable(int argc, const char **argv)
 	record_test_main(argc, argv);
 	block_test_main(argc, argv);
 	tree_test_main(argc, argv);
-	pq_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
 	merged_test_main(argc, argv);
 	stack_test_main(argc, argv);
diff --git a/reftable/pq_test.c b/t/unit-tests/t-reftable-pq.c
similarity index 62%
rename from reftable/pq_test.c
rename to t/unit-tests/t-reftable-pq.c
index b7d3c80cc7..a47a9473f3 100644
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
 
 static void test_pq(void)
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
+	TEST(test_pq(), "pq works");
+
+	return test_done();
 }
-- 
2.45.2.404.g9eaef5822c

