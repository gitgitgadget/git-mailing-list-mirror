Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D2541A92
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722780698; cv=none; b=q0zgLWR+ESm4chMKa/D97WdJmhCXRe42XBo7kHXIZdLkkd/wzY36EwRdA6Zd8gCOgAGSacWl4zfuODKXCNKVWtLJ7lPYbc5tAheNDPyyedol5msHFEkHe6FC/RTCwh6CpkvaeJrK0uEpbaYqoW3nyDoCNq+D4xjejlWldR/KYzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722780698; c=relaxed/simple;
	bh=RAKSU9kduzL06rcjoz3mIoEnrGGsM/eS3Np1xn60mx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WiCIAxrxp3UA14oyNYPhTbfStOBWwWEdNqzf+2DH1Rl7gnozGL8QcuRs9+q4ue4CmAdZQZTwp56fK1dIHayuDHC+m37Sc7k11n9iL4IR+QCRXms3AGMnK8Rx9PxHc07DqX6vOtlaRzl3FmpuVL9xI5SKxhl7vgH8CyfJ58NkYPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4W8nW8t; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4W8nW8t"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-267b7ef154aso6269510fac.0
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 07:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722780695; x=1723385495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53vD0V3zYrdWvpy4M6dnjXGn/EwOET+r+23g2ixiD2U=;
        b=j4W8nW8tzgwVEkUkPWtIA4tvVdTODb8t1gSGpi46QsKytPwucON8jdB0w/SKCGBVR6
         YkFmloiCXGchT99niL4CVLrOHJLaygp0wocrmCO64W3WH3gsOxZSvJ8fIVaymUQpVm5/
         tzf8hfMBaxsKbA/dKPsy+aqd7AY0gpg/VvNyaKuKNI9dH/1VlywpsSHj3gXQWpzdgrlE
         zcSVy4m323SGNmUt1ZkW6pcKs0r/JAbGRVmqigime73auOVFM2wSN6Fm8W8/QR5z+C25
         vZYwvimssyo64q9STcebAQygZssR7fC9IlgBUE06++ZGxFvl2nt3F41HIJB7YlMWdQIK
         PCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722780695; x=1723385495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53vD0V3zYrdWvpy4M6dnjXGn/EwOET+r+23g2ixiD2U=;
        b=RucU5/GDj9lLgaThVqpFoxz2SxH1/dassBBEsuwBNIi61XFA67DFXdmnDBKHwzle+9
         FENWbkDHR8P4VqQJeQYcPa5O8SCdSFfF2G1S0uZfXl1QzM836Ua5QHnWU+hQJ+olaCB7
         U+6b7+Mvts1SLASiTfnfo9l4nZxCzwDdIOK+22QuSL8KWGBcf9dVpYg13A538XYg2Qho
         /9Wid2m6zbf0nKMBhazuqW+4IKrULjQax9SXCmQWPLeAY7erXdOZadT71aB5yNhJ2YHJ
         zLwsKEHDTLCumWv5OP1IhZJq9MvGMhvEGXUNBu5pB3uzKDMuzcP/jqCNow9ywk1tVDWm
         Ackg==
X-Gm-Message-State: AOJu0Yy9kSqrd6sYk8wBLrHaxbUznrrVofkWxV0ZYPtd8gEPChPY9JOs
	FDHAn25N5oURJV1riEvpdGjrkd7P1mRCZOspIr7icSsR0hnHJs1W1ky5DTxl
X-Google-Smtp-Source: AGHT+IH5fu3xao1CzQGkPyzofgkM01EHjcAEirXmk2W5jmJOouNP86V23mqevXcMZCu+UvsuBOF2fw==
X-Received: by 2002:a05:6870:b4a1:b0:25e:b683:75d0 with SMTP id 586e51a60fabf-26891ee164dmr10861181fac.49.1722780695184;
        Sun, 04 Aug 2024 07:11:35 -0700 (PDT)
Received: from Ubuntu.. ([27.59.94.183])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7106ec269d2sm4125047b3a.17.2024.08.04.07.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 07:11:34 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 2/5] t: move reftable/tree_test.c to the unit testing framework
Date: Sun,  4 Aug 2024 19:36:46 +0530
Message-ID: <20240804141105.4268-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240804141105.4268-1-chandrapratap3519@gmail.com>
References: <20240802121318.4583-1-chandrapratap3519@gmail.com>
 <20240804141105.4268-1-chandrapratap3519@gmail.com>
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
 t/unit-tests/t-reftable-tree.c | 60 ++++++++++++++++++++++++++++++++++
 5 files changed, 61 insertions(+), 63 deletions(-)
 delete mode 100644 reftable/tree_test.c
 create mode 100644 t/unit-tests/t-reftable-tree.c

diff --git a/Makefile b/Makefile
index 3863e60b66..5499f7bcbd 100644
--- a/Makefile
+++ b/Makefile
@@ -1342,6 +1342,7 @@ UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-reftable-basics
 UNIT_TEST_PROGRAMS += t-reftable-merged
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
index d5e03dcc1b..8516b1f923 100644
--- a/reftable/reftable-tests.h
+++ b/reftable/reftable-tests.h
@@ -15,7 +15,6 @@ int pq_test_main(int argc, const char **argv);
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
index 9d378427da..0acaf85494 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -6,7 +6,6 @@ int cmd__reftable(int argc, const char **argv)
 {
 	/* test from simple to complex. */
 	block_test_main(argc, argv);
-	tree_test_main(argc, argv);
 	pq_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
 	stack_test_main(argc, argv);
diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tree.c
new file mode 100644
index 0000000000..8b1f9a66a0
--- /dev/null
+++ b/t/unit-tests/t-reftable-tree.c
@@ -0,0 +1,60 @@
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
+	/*
+	 * Pseudo-randomly insert the pointers for elements between
+	 * values[1] and values[10] (inclusive) in the tree.
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

