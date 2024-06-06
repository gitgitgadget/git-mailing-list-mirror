Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12831327E5
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660640; cv=none; b=nixd0YznyxEfmT/XIqyJmzYDoSOt+ACiFrRpiOFGfZTPrw3/b0ahjaTx/ODx21lOT7gr1NbQcLobxZpJrr9BVvAX314c1w9N5yHsL6lkGNx0BUW6fVAeVlH74i8IAPpLRO++08ipkGg+lYZSLyDDBb7JOVrIYqVdxpAE8u+6FcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660640; c=relaxed/simple;
	bh=7gNQeDRx585ssQgwNsS3J+aNzCltHbCwite7rn5dUtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJ2WnGzFdTnJGil93ENVkqVsCWicmeBv35GCrWlAncfe2yBVDWHH/Cj3TV8BBsVhfV60qTJXKWRX5VqeDOpRd1CRl8eqK3vhNuqy0YxDijvi1gwLIWv2Medqu8O8QtYjDiDYDJH8Tko+6QCcdIaa5KuPFef9loRqgUb4RQObHqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGU6A9La; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGU6A9La"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6bfd4b88608so526184a12.1
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 00:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717660638; x=1718265438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNhe0chjIYZVnz9qUIX1qeU5XaAjNa4Ck7uEoliYLk0=;
        b=NGU6A9LaEh/y3DmMop8WYjHj+R17zFVp7U/N0SH4XVhFy95wYe5nQ8xGVbXUw0Lya9
         veh/3zI+FbO7FMwiYEXl946myrVKACkgAPEuLSZKYsq3Yw2QNKG6nh1WvcI95C0JH4V/
         eimSwEzxz2BIpodMs7LW5ahUpf25joOWa3nGRNWqJR3QF6rk92JmnwEWsqxH3ibtC/W/
         yO48LHgcK5q4dvtpmAJ28tXGzMdfe01KrCilEMcIdDGrFyWnCNQ21fcanvtcKF/mjpn4
         1PK8ECTmoEv9IwtzQkuD8lzfxXGbmpmzc3zK1sNUACP4sRCwLcQa3ck488U48kvNM2dm
         CJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717660638; x=1718265438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNhe0chjIYZVnz9qUIX1qeU5XaAjNa4Ck7uEoliYLk0=;
        b=E8SkM7M7wkDA49WQHuhpSs75/slSziwQWHCRUXUy5xUVF3LmgYY7DGBGnnlMozzIe2
         B4gD9q2ptd/g92cbbOgcUbqDzisl4PsKneeGEu/5b9C8hDkYrWAWdrSZ0flX7GJKk1s8
         pXl2BeK1bIg9uE6sFi6OxoXQDmC5fhIfxV/K+b9yMZiGDXDzuuoLWA45Yd0er41VmUgZ
         9W7LYK4Ldcqe9n/GZNqu4jpBbNwe2fWMQBVmYea9mjJ1zUeseTVgU/oMPAaR4UqpW3jq
         p0FQzQhUXD5kUg/jvtG5OdlUOU6pgE900z9xS91ZItbzSoL03vBi21t6Hf+33AwL7KcC
         68ow==
X-Gm-Message-State: AOJu0YzljGpUrLl4atRhYAjtGthzzGdFWnACS1OJijxlBKEQy4iXptT4
	lDA5qgilgXh5L2tCUO6FSIhy+8EHd78QA+9vVLFLuIZsQmf2uuTtvtFCPhXo
X-Google-Smtp-Source: AGHT+IEx82UML/mplxex8UxrMFCw47bW2xNjk0NZKL2hKBPM0ZFw2iFj6/iB8OO3VB7wYLcBJLTrcg==
X-Received: by 2002:a05:6a21:186:b0:1b2:5931:574f with SMTP id adf61e73a8af0-1b2b712df57mr6205050637.40.1717660637657;
        Thu, 06 Jun 2024 00:57:17 -0700 (PDT)
Received: from Ubuntu.. ([27.61.69.112])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6bd7ed6b2sm8192415ad.246.2024.06.06.00.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 00:57:17 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [GSoC][PATCH 2/6] t: move reftable/pq_test.c to the unit testing framework
Date: Thu,  6 Jun 2024 13:10:46 +0530
Message-ID: <20240606075601.6989-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240606075601.6989-1-chandrapratap3519@gmail.com>
References: <20240606075601.6989-1-chandrapratap3519@gmail.com>
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
 .../pq_test.c => t/unit-tests/t-reftable-pq.c | 35 ++++++++-----------
 3 files changed, 15 insertions(+), 23 deletions(-)
 rename reftable/pq_test.c => t/unit-tests/t-reftable-pq.c (64%)

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
similarity index 64%
rename from reftable/pq_test.c
rename to t/unit-tests/t-reftable-pq.c
index b7d3c80cc7..dcde73de66 100644
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
+	for (int i = 1; i < pq.len; i++) {
 		int parent = (i - 1) / 2;
-
-		EXPECT(pq_less(&pq.heap[parent], &pq.heap[i]));
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
+		strbuf_addf(&refname, "%02ld", (long)i);
 
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

