Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ACC82499
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025081; cv=none; b=dlwJm8eoQMqvvY+IeJ+9gBFy16RDV624abkAY2PJQM0uy8aDLPwV3ZGTK8exKSX66tsC2scIKiJ3iR9kWXau1r78V+GkYJPd11eg9v/C5gfzYcTB5J+Y1ZlxpS7HmKphp2afGsL5iFqKyd+y/9EsfMQP1PDfxDj08nGmcxS06mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025081; c=relaxed/simple;
	bh=Pq6fvH6see6NZIBIFeB7IaN4Jg8NcBtFIkuTYeLePQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgrBTO2OyACL6PraDvsFjXdy9ttwbKWctu8CLr/keP9JhIYNnZ3z9yrIsyiCabgDnC1boCmIw/gHc6S9fNnQyY+UrKRvzz3rojmAgWt1R3NazNaD+2gtf+IxcOUIeuToNyp9NnYXHXL8AVrCZW4K6c1UjqWjU5POaZkQn913bxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HE8zZ6hr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HE8zZ6hr"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7042cb2abc8so1090691b3a.0
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 06:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718025079; x=1718629879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDFXxri1fS73+VNmjcNGWp15A/C0f4gErIv+95CXRHo=;
        b=HE8zZ6hrZMtwxOBXCPm6Ub83gfOaK0RfrcOPeNnigfLqMltNGCWsBW6TAz3K+tResM
         xZAKF8IT7GKhVlKAqOWIWVk7SOuo5ujCQVyH3Oa7WqiwWkzyN1a+CHHs4Jqjr9KxcnRf
         o57rwp9KWiGmM1uutFDX6qS3wPxIUEmavBbJFphCCuxr4aUDMigpvZ2oGEDPoL0obvA4
         jEDoZDTCurGlb083dqD5z/UUTzBEpdJdRU0f+9Nu0ZOKJ565GUk0HgmE/DSq6FdF2edZ
         sq9t3BQ9xI0BcbZZEbEhzoVx3bmg+5mWIzfsz5DC1BU7aYAyRaiiPPXnCY4e38pVyt3N
         QUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718025079; x=1718629879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDFXxri1fS73+VNmjcNGWp15A/C0f4gErIv+95CXRHo=;
        b=pW6e3OVeHZqBmL87edxyevUqbfw5nJwLv0mTcIrplvyVaDmhEtwVw3vp3H5RnLntma
         MUy4y3payqyC70wKqYc+pKo5Kg89BoSZ27g6HA61vUhxkOz3ajppkOYbaJgKYjDHHdiX
         0G7P4NnxHRsOug1ePW5+gR9qPk2qZXhoYxl3dy9Rf8fWWzyIQQr84swP6EX7ATBBB5RT
         8y5QrAVGsQGs56Mnfazlz+oPGqTB/Y6w8IdRQ+5V8ibbMb8XtoaUN+eO1tP+6Zv6r/nO
         mTBKLMHZzg+xf1SfjKRAWv7lqVHT3P7k0wTzwD7nj9wayrhImrzCVG971dtzH6AUt7fI
         EA+Q==
X-Gm-Message-State: AOJu0YwEwHYuVmuo5LSGNBhXhFw6r0P1tPDrDfoqlsXp3+9xKAv2z2mR
	YrIRLU9++fG8+wgZu3JSLIFweq9mPZqW6MERJumo8vMRIBHdFSnFIV3aejIW
X-Google-Smtp-Source: AGHT+IFkBiZ1l6yM41AsCLKheWUixem0AsQQXq67CAgwV83RtW/Dqx8YoFsVUmd39rNMiOyASDS8tA==
X-Received: by 2002:a05:6a00:8c8:b0:704:32dc:c4e4 with SMTP id d2e1a72fcca58-70432dcdefdmr4018736b3a.1.1718025078600;
        Mon, 10 Jun 2024 06:11:18 -0700 (PDT)
Received: from Ubuntu.. ([106.206.194.184])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70599bcac14sm1378516b3a.1.2024.06.10.06.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 06:11:18 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/4] t: move reftable/tree_test.c to the unit testing framework
Date: Mon, 10 Jun 2024 18:31:29 +0530
Message-ID: <20240610131017.8321-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240610131017.8321-1-chandrapratap3519@gmail.com>
References: <20240610131017.8321-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable/tree_test.c exercises the functions defined in
reftable/tree.{c, h}. Migrate reftable/tree_test.c to the
unit testing framework. Migration involves refactoring the tests
to use the unit testing framework instead of reftable's test
framework.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 Makefile                                      |  2 +-
 t/helper/test-reftable.c                      |  1 -
 .../unit-tests/t-reftable-tree.c              | 32 ++++++++-----------
 3 files changed, 15 insertions(+), 20 deletions(-)
 rename reftable/tree_test.c => t/unit-tests/t-reftable-tree.c (59%)

diff --git a/Makefile b/Makefile
index 2f5f16847a..d736b2f8bd 100644
--- a/Makefile
+++ b/Makefile
@@ -1336,6 +1336,7 @@ THIRD_PARTY_SOURCES += sha1dc/%
 UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-prio-queue
+UNIT_TEST_PROGRAMS += t-reftable-tree
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-strcmp-offset
 UNIT_TEST_PROGRAMS += t-strvec
@@ -2681,7 +2682,6 @@ REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/readwrite_test.o
 REFTABLE_TEST_OBJS += reftable/stack_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
-REFTABLE_TEST_OBJS += reftable/tree_test.o
 
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index bae731669c..9475db2f76 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -8,7 +8,6 @@ int cmd__reftable(int argc, const char **argv)
 	basics_test_main(argc, argv);
 	record_test_main(argc, argv);
 	block_test_main(argc, argv);
-	tree_test_main(argc, argv);
 	pq_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
 	merged_test_main(argc, argv);
diff --git a/reftable/tree_test.c b/t/unit-tests/t-reftable-tree.c
similarity index 59%
rename from reftable/tree_test.c
rename to t/unit-tests/t-reftable-tree.c
index 6961a657ad..208e7b7874 100644
--- a/reftable/tree_test.c
+++ b/t/unit-tests/t-reftable-tree.c
@@ -6,11 +6,8 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
-#include "system.h"
-#include "tree.h"
-
-#include "test_framework.h"
-#include "reftable-tests.h"
+#include "test-lib.h"
+#include "reftable/tree.h"
 
 static int test_compare(const void *a, const void *b)
 {
@@ -24,37 +21,36 @@ struct curry {
 static void check_increasing(void *arg, void *key)
 {
 	struct curry *c = arg;
-	if (c->last) {
-		EXPECT(test_compare(c->last, key) < 0);
-	}
+	if (c->last)
+		check_int(test_compare(c->last, key), <, 0);
 	c->last = key;
 }
 
 static void test_tree(void)
 {
 	struct tree_node *root = NULL;
+	void *values[11] = { 0 };
+	struct tree_node *nodes[11] = { 0 };
+	size_t i = 1;
+	struct curry c = { 0 };
 
-	void *values[11] = { NULL };
-	struct tree_node *nodes[11] = { NULL };
-	int i = 1;
-	struct curry c = { NULL };
 	do {
 		nodes[i] = tree_search(values + i, &root, &test_compare, 1);
 		i = (i * 7) % 11;
 	} while (i != 1);
 
 	for (i = 1; i < ARRAY_SIZE(nodes); i++) {
-		EXPECT(values + i == nodes[i]->key);
-		EXPECT(nodes[i] ==
-		       tree_search(values + i, &root, &test_compare, 0));
+		check_pointer_eq(values + i, nodes[i]->key);
+		check_pointer_eq(nodes[i], tree_search(values + i, &root, &test_compare, 0));
 	}
 
 	infix_walk(root, check_increasing, &c);
 	tree_free(root);
 }
 
-int tree_test_main(int argc, const char *argv[])
+int cmd_main(int argc, const char *argv[])
 {
-	RUN_TEST(test_tree);
-	return 0;
+	TEST(test_tree(), "tree_search and infix_walk work");
+
+	return test_done();
 }
-- 
2.45.2.404.g9eaef5822c

