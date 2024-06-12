Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29FE17837E
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197373; cv=none; b=pdjKBJBsgiJ0vXZbB1FRJ354k744tAbfJAgI54uoIuLSvO0OmiPPs+VtNSKj4MZYlqM4TaHgCOf5hzJmGJR9SwOIfSQypQhWhYYs/R3xxN2tLAwrZHn+AB+IeThqY75gYeQtTbXSjWDhX12WRXA+92titHrO4XymgWbgZT8DM9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197373; c=relaxed/simple;
	bh=Pq6fvH6see6NZIBIFeB7IaN4Jg8NcBtFIkuTYeLePQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rP2ZVrmwf/GOoght7iwgBHOu5OUZWPoWhD0Hqm5gN0i686gf7NanGHUEiasVU86rgWjtlNmm6qa4MrpDPU/SPHp809NA+FeAXSpoNR2qFK9SndwqlReO1NlbtPqBTMY/4r5Y1c1QX4tyERTW4FFn7UQQYHWjGdGGec6H6U+uO88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1qbUZ+q; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1qbUZ+q"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f717608231so23393525ad.2
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 06:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718197370; x=1718802170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDFXxri1fS73+VNmjcNGWp15A/C0f4gErIv+95CXRHo=;
        b=J1qbUZ+q7Aa+dLa04RxeZ5hbiru31F33q29+lIbAX2/9s1I+I/zYd3P4CBMV9GPzKS
         lQxuRje27lKE/B8IW22ZrsHzO1QrGQqaV16yRiBkGfGADHqMPpYS6bQt4XrLaQMQp0oL
         dGIIg3Pxct3UMonZfG65tUwJk3b97CU4v7uDtMqokK+r1gSBM4suIGcdCUi/9drEDzFd
         IObJnf/YOX+DD39mlQD+V5n1S5N8G/nw9a0Qvd8vJ2QGcT303MNBwVR511DlJax8wWj2
         QAFwQmdwwNiDqunZ4cZ2Za4XrmbW8Zy2uKHsR4rpj5DHvd1+uvZrDH4pniLEOWwAjGsI
         Py6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718197370; x=1718802170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDFXxri1fS73+VNmjcNGWp15A/C0f4gErIv+95CXRHo=;
        b=AlezdwAo5mGN9ehYFgSu5Tk+UN4xNf3tkEgHzCoDB6Hi+WFQimKMAVBV84QsLhdJfN
         pdJ1IDbbP9l2WLO6GZ/vHywQtJ1+9bvgjJjYT01H+k+4CDg8vg7w+O0gnNTPJF3/2c1W
         I37apW0780VmcYhRwUs8wIAMv/Emm30Fi6iG2doSxZ4Fio7dqej/Zyq0g44Tbv7UHRc3
         dKfOV20AWKS2+pWyQqp/ugQzbbWoeQRuGwi8ElaDlNyYcSSiltY8fPBZvqswtRx0ZR/x
         jOp0fgTULfuNlhkkqti97eSl7i2omrKZkwzuFqEiBPKMuC22EvIx5weOc+DLljrmOcXG
         OxXA==
X-Gm-Message-State: AOJu0YwOWWJYyIBRahTYAquRUljgKZzyh8GpYdL+U6gy59VJu+Q6k7a8
	cEROwSMjwJPl1DoaxsrF86F/dINkPicYCJNFMg6n3NCA37vp4eolw6pCoTKdDp4=
X-Google-Smtp-Source: AGHT+IHIvOaY8t0+IZ5vf3pSEE2Wi8GmclRn6a1RHbavMEw0Qf01BkrlMwYRx3WnYT4JQRMTRotQdg==
X-Received: by 2002:a17:902:ed15:b0:1f8:393e:8b88 with SMTP id d9443c01a7336-1f83b74fb9fmr19456625ad.67.1718197370326;
        Wed, 12 Jun 2024 06:02:50 -0700 (PDT)
Received: from Ubuntu.. ([106.206.196.39])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6bd7fd25fsm123942325ad.280.2024.06.12.06.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:02:49 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 2/5] t: move reftable/tree_test.c to the unit testing framework
Date: Wed, 12 Jun 2024 18:23:00 +0530
Message-ID: <20240612130217.8877-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240612130217.8877-1-chandrapratap3519@gmail.com>
References: <20240612055031.3607-1-chandrapratap3519@gmail.com>
 <20240612130217.8877-1-chandrapratap3519@gmail.com>
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

