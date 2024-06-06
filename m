Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5965F197A7A
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688904; cv=none; b=Ir1UtJEq6RGb6NzW1hq+zAaap+oVaGEDoR5C3beq817KZ5xZCmClIUZzwPBQiqwoHfQ5W8EyED0205uzDfThmI8HlAiw/GQHu0/FppwKQd1dAuutNLFLwdYKOUurdBXlW06fbXAPsdWGFvWaoIu5JTxaLjMas9mwBRn33LUiFlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688904; c=relaxed/simple;
	bh=lDezlVhbx4xsaZZRDTavwaiORNa5S6p3fLN6vjDPF2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlWC3NX2gEG1J80TXvvkmGzhVK+nfu4Qsd1O1wtLpSnaeQg9rLoCA5ZVf6FarqpbcE73zjlCo0jNpoaVQGvCFEQY/ci2mGNjpVJoxMFkMbhS171c2nzK8d0O0yCQP5LddEn7aYvnFVyUTsCt171UmzL1U4UmyA1l7MVCTFK64eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NngYZKK1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NngYZKK1"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f62217f806so10815195ad.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717688902; x=1718293702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJRxUKvgzPgiuPQGG7wF/Iiv7ARwpsrNISAnWEDh/wg=;
        b=NngYZKK1zzgf6LcY6Zid1JYrwtWpiKZ6M47FWiRxVq7jy3B+zjxvq0s2MhK+yw188d
         IDYWyZFULqlZ0K6ZLn4VsRKlYzZAuaXd/Yuz5x8UMc3T2HFN3bAqVtFQYIzhhwjR63Tf
         oVqS6cyjy5t9VvtoX4JRzcj/dsF4p+vlzV4Sf4vWDPANO3IA0w8xctIaKLvnEnFvDfED
         OIG51l0OGfKhxh92mZfGxrU8HUoYwKQzAMJwXj7QZcOs/BxAuTet3F8vsDjE/h2unoVS
         n2vjW/wxKS3Py64MM0KGSiaFNmZxpxabJToo/hShz/17zIBQ8YAKGJn9plK3VaabkmaD
         iIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717688902; x=1718293702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJRxUKvgzPgiuPQGG7wF/Iiv7ARwpsrNISAnWEDh/wg=;
        b=YdYOHSS43TJGwsaS2W8koCJiajis4U3lwzhhZtaHa8yl4nee84cdvrdxMLyc6ICYHp
         nGfnyttvYkqCbmCZh3jIqkO9wyWVg7M46zGbPVSI903Ivb3h9bKES3TCykfBkihyGsL6
         38Fnio0b2vtuxRClQTqIIkXZOmkGvul9y/IPb51HhlIw1OI8F4E5C6YbH/LjMdhigbWF
         6J6m5ToedUM2nrNEBAzRKxWIZnM6wEYH7rsbcjDxJz9653Sa5E5mp+AnZz56r38EGAx3
         11Lv/QTFWh0wl2e5N2GoCK+eM0Qd58xWVyPkn/0QfRaEv/3tXQheTVJST2caM7a/IzU4
         2xdg==
X-Gm-Message-State: AOJu0Yys5Vn2SGftISBYuOfur7nGDAQ/qxox0sPGHMgfjmo7ODJ4lLKq
	viqHJJHXBDviBC1pX7+8LTq6PzfTRxoO+lislbD3ZKkNI1HM1Yxurkx2piWJX/g=
X-Google-Smtp-Source: AGHT+IEz3d6OSPqogRBcL/GJ90KT0/UbAdQUeQBfKxCNCRC97vqrYVYOKQgPM83WhxPhhZEkbFur3w==
X-Received: by 2002:a17:902:d504:b0:1f6:80e2:e423 with SMTP id d9443c01a7336-1f6a5a849fcmr71247375ad.68.1717688902123;
        Thu, 06 Jun 2024 08:48:22 -0700 (PDT)
Received: from Ubuntu.. ([223.176.20.76])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6bd76fa8fsm16937405ad.100.2024.06.06.08.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 08:48:21 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [GSoC][PATCH v2 2/6] t: move reftable/pq_test.c to the unit testing framework
Date: Thu,  6 Jun 2024 20:53:38 +0530
Message-ID: <20240606154712.15935-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240606154712.15935-1-chandrapratap3519@gmail.com>
References: <20240606075601.6989-1-chandrapratap3519@gmail.com>
 <20240606154712.15935-1-chandrapratap3519@gmail.com>
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

