Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EE41803D
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 06:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721629186; cv=none; b=WqbBfrqENnJkY5QemDZbyJWOhtG9SknQ0uVCZFtJwUra6r+qtkY46dqPOZjeNmZH9QlJyNiiuFvHPwwvNlW/d+HpLyDfTIWng8ZXqmHl3nA2674jCk9b6IwUDHnhDRXn8RN8AhTqEkw8aM+U5hh9rwAdC/ziHFgrUIe6GvIfC8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721629186; c=relaxed/simple;
	bh=GUly1VZkQGe0cw4YB77AS8wApfqn6CPBiLJEpl/kArY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+YN+xyL6u3y8zQVAi0zHz6AhIxnAVWsEAdpV+8Yx3ooKob1ZJsDe6AIGqBPjl+/yCzLIE/zgj7Q8EDE0JY4e4Tam/Bn86TZUO7FcpP0D7nEWNlZT7HAwmKqyMtVHEl9Srjwtc1aZghPEBL550qPS6I7dEg08dkdYno2MdRty2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUhpR+2x; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUhpR+2x"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d1d818c42so392655b3a.1
        for <git@vger.kernel.org>; Sun, 21 Jul 2024 23:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721629184; x=1722233984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHM1L31DQScWXJMa3zRlE+YntQH8KZ8OkTFwiO2vZFE=;
        b=bUhpR+2x7rwrYcUNFminOxO2Z1cLCyGYJoBAoR1/+Lr2yONBl54sb8cvM7m7SqQeSi
         ncgFJaPLZnAIweQLWVLtMpEtwus+gyAhwAZC1jjX4EIgFH2OsDr3XCgTcfEcnbO9I7Rv
         o4DpXYCy1U4eirugPHQH6aO5FUQvcD9R734YbYLQk/SNxfMbGt+t8KTlGNSVD7Yl0EVX
         a9YamRAtDhUkscdzqzmOF4U8R9r05+Blro4jD5hGs443w4NPGNW8etgxEpZmDFmZZh+2
         tdKPq9E2FEFAcaqY8mjtFc+kdkT3dTDfykR7QXVw8sZ0LOuEKvhUOFMyoCTSJ6bAI1pc
         o5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721629184; x=1722233984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHM1L31DQScWXJMa3zRlE+YntQH8KZ8OkTFwiO2vZFE=;
        b=YO2JsAKyUcuYy/VFb7BuwWhWDWIXPklqW2ZnEYawdxnsDS9CLJFAe7BFovbq7WTdRt
         IjtP7Z/UNmcIbLWWKIw+H2NGXG6zQju+ii2tG1tYpWSuxAq1buYaZj8WBhXW5mga+aB6
         Ww53w9jdNIy0UxHDZQM2Mf4p3n6kizvnjZZaLaJuN81KoN6aL/WIS/x697EGxnQb1OKG
         GMgQQkjdQLhv5Nc/LdKYF4Rcd6/3rS36nZT4IuDoQ2Mi/1SjEIQ5S9yL8EJLUTfRefG6
         htx2sEdnp2q/5V/hVRb9R7Z5GEFroaCktc3hzm5+A9dWpH003V5OkOCnjM7T7PknU5HX
         VN2A==
X-Gm-Message-State: AOJu0Yx/BzuHzsc0nYvOUXfCAAe+yIh8mxoUmHRFOiiq1YgS9Cd6GazQ
	H8+x9cu8pJRAhyko54M55juH0Em0/ZL8up14DloTVvfSLEm/dLurI2cjMFt5sKE=
X-Google-Smtp-Source: AGHT+IErPnyfX6OpZIEDYgmawqxBAXy9onjA/nreHcxRnvn8J8413c/75tWmdQG6N3DE9TQANqlcnQ==
X-Received: by 2002:a05:6a20:7489:b0:1c2:93eb:c178 with SMTP id adf61e73a8af0-1c4286194e6mr3746673637.51.1721629183955;
        Sun, 21 Jul 2024 23:19:43 -0700 (PDT)
Received: from Ubuntu.. ([106.220.63.154])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fd6f31a73csm46362885ad.143.2024.07.21.23.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 23:19:43 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v5 2/5] t: move reftable/tree_test.c to the unit testing framework
Date: Mon, 22 Jul 2024 11:27:55 +0530
Message-ID: <20240722061836.4176-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240722061836.4176-1-chandrapratap3519@gmail.com>
References: <20240716075641.4264-1-chandrapratap3519@gmail.com>
 <20240722061836.4176-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable/tree_test.c exercises the functions defined in
reftable/tree.{c, h}. Migrate reftable/tree_test.c to the unit
testing framework. Migration involves refactoring the tests to use
the unit testing framework instead of reftable's test framework and
renaming the tests to align with unit-tests' standards.

Also add a comment to help understand the test routine.

Note that this commit mostly moves the test from reftable/ to
t/unit-tests/ and most of the refactoring is performed by the
trailing commits.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 Makefile                       |  2 +-
 reftable/reftable-tests.h      |  1 -
 reftable/tree_test.c           | 60 ----------------------------------
 t/helper/test-reftable.c       |  1 -
 t/unit-tests/t-reftable-tree.c | 59 +++++++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+), 63 deletions(-)
 delete mode 100644 reftable/tree_test.c
 create mode 100644 t/unit-tests/t-reftable-tree.c

diff --git a/Makefile b/Makefile
index d6479092a0..6f423a2a1e 100644
--- a/Makefile
+++ b/Makefile
@@ -1341,6 +1341,7 @@ UNIT_TEST_PROGRAMS += t-oidtree
 UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-reftable-basics
 UNIT_TEST_PROGRAMS += t-reftable-record
+UNIT_TEST_PROGRAMS += t-reftable-tree
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-strcmp-offset
 UNIT_TEST_PROGRAMS += t-strvec
@@ -2685,7 +2686,6 @@ REFTABLE_TEST_OBJS += reftable/pq_test.o
 REFTABLE_TEST_OBJS += reftable/readwrite_test.o
 REFTABLE_TEST_OBJS += reftable/stack_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
-REFTABLE_TEST_OBJS += reftable/tree_test.o
 
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
index 114cc3d053..d0abcc51e2 100644
--- a/reftable/reftable-tests.h
+++ b/reftable/reftable-tests.h
@@ -16,7 +16,6 @@ int pq_test_main(int argc, const char **argv);
 int record_test_main(int argc, const char **argv);
 int readwrite_test_main(int argc, const char **argv);
 int stack_test_main(int argc, const char **argv);
-int tree_test_main(int argc, const char **argv);
 int reftable_dump_main(int argc, char *const *argv);
 
 #endif
diff --git a/reftable/tree_test.c b/reftable/tree_test.c
deleted file mode 100644
index 6961a657ad..0000000000
--- a/reftable/tree_test.c
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#include "system.h"
-#include "tree.h"
-
-#include "test_framework.h"
-#include "reftable-tests.h"
-
-static int test_compare(const void *a, const void *b)
-{
-	return (char *)a - (char *)b;
-}
-
-struct curry {
-	void *last;
-};
-
-static void check_increasing(void *arg, void *key)
-{
-	struct curry *c = arg;
-	if (c->last) {
-		EXPECT(test_compare(c->last, key) < 0);
-	}
-	c->last = key;
-}
-
-static void test_tree(void)
-{
-	struct tree_node *root = NULL;
-
-	void *values[11] = { NULL };
-	struct tree_node *nodes[11] = { NULL };
-	int i = 1;
-	struct curry c = { NULL };
-	do {
-		nodes[i] = tree_search(values + i, &root, &test_compare, 1);
-		i = (i * 7) % 11;
-	} while (i != 1);
-
-	for (i = 1; i < ARRAY_SIZE(nodes); i++) {
-		EXPECT(values + i == nodes[i]->key);
-		EXPECT(nodes[i] ==
-		       tree_search(values + i, &root, &test_compare, 0));
-	}
-
-	infix_walk(root, check_increasing, &c);
-	tree_free(root);
-}
-
-int tree_test_main(int argc, const char *argv[])
-{
-	RUN_TEST(test_tree);
-	return 0;
-}
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index aa6538a8da..8c41ef7c9d 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -6,7 +6,6 @@ int cmd__reftable(int argc, const char **argv)
 {
 	/* test from simple to complex. */
 	block_test_main(argc, argv);
-	tree_test_main(argc, argv);
 	pq_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
 	merged_test_main(argc, argv);
diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tree.c
new file mode 100644
index 0000000000..08f1873ad3
--- /dev/null
+++ b/t/unit-tests/t-reftable-tree.c
@@ -0,0 +1,59 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "test-lib.h"
+#include "reftable/tree.h"
+
+static int t_compare(const void *a, const void *b)
+{
+	return (char *)a - (char *)b;
+}
+
+struct curry {
+	void *last;
+};
+
+static void check_increasing(void *arg, void *key)
+{
+	struct curry *c = arg;
+	if (c->last)
+		check_int(t_compare(c->last, key), <, 0);
+	c->last = key;
+}
+
+static void t_tree(void)
+{
+	struct tree_node *root = NULL;
+	void *values[11] = { 0 };
+	struct tree_node *nodes[11] = { 0 };
+	size_t i = 1;
+	struct curry c = { 0 };
+
+	/* pseudo-randomly insert the pointers for elements between
+	 * values[1] and values[10] (included) in the tree.
+	 */
+	do {
+		nodes[i] = tree_search(&values[i], &root, &t_compare, 1);
+		i = (i * 7) % 11;
+	} while (i != 1);
+
+	for (i = 1; i < ARRAY_SIZE(nodes); i++) {
+		check_pointer_eq(&values[i], nodes[i]->key);
+		check_pointer_eq(nodes[i], tree_search(&values[i], &root, &t_compare, 0));
+	}
+
+	infix_walk(root, check_increasing, &c);
+	tree_free(root);
+}
+
+int cmd_main(int argc, const char *argv[])
+{
+	TEST(t_tree(), "tree_search and infix_walk work");
+
+	return test_done();
+}
-- 
2.45.GIT

