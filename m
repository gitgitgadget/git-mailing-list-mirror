Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11D51DE2DE
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024579; cv=none; b=dy86Ys25nSjqWGPAPzMi/EYCvW+VnAtwzFL/mGZAnTnYehk17r5dmWMgBTJkWINVyFWraEd3jNVMTuxSwZZFfjR9qa/o3rJwuozkZMAkqOFOnvvDAT6fIgER5A2BiN5CZgyJ3D+9QRHxHEvboOnNlXwNKz5F94ax3CI4JXhEYPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024579; c=relaxed/simple;
	bh=xZ7b30CTc5gSlyMKbvXC/YmtPa0PJEiX26wFnnXp8pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mG5Y6b3KevhVVznPU8RTLWyGvC6ILDAipird4GR13WdVgMbGGQyBRyO+7AayhvAl85jGwoA5aoN64++G3h+mKtnXF3NX0nBloSv6Ukm9pAABnN/W4FWPR8ceK9WXxci1eRCO0y8OJ2+hFBqOPlHnskX2uef3MZeFCGvAiezsuV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUbKsTbU; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUbKsTbU"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa6c0d1833eso163773566b.1
        for <git@vger.kernel.org>; Thu, 16 Jan 2025 02:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737024576; x=1737629376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJHH7GrYBFM889FNKVErs4HRkv8yDSCyGi+3QA7/UeE=;
        b=gUbKsTbUj9OutcIDfYN/jvLjke9U38NBF3fqN6/uHgi/CDzKidjACYypbS42sinC+D
         QXhuxvoFWSOCw5FdqsA7K5hwFGkAdc4BtN3WUdQafdZizlaO9yfGMF0hW8yXuoN8iFLx
         a8jACIQuShU1831nvvwL1VKrCN6AkmeILwqaUoGcX+c2qeQJewMwXm6NoL+Yhggc8NV4
         Wr8qLtmpx+LdUs2ls2WXQqBIGbRhFU0xr1DLb8T09o4Bed38CYzL1Dp66tGllKplRNsI
         fF5XFSdFEN/XS3OXy0pnnMHa7UzstzfNp7hYNYhX209t6Ryaf0KZw1oBrZdvXkie2LVg
         SItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737024576; x=1737629376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJHH7GrYBFM889FNKVErs4HRkv8yDSCyGi+3QA7/UeE=;
        b=kJlgohRGRY0+a87OwBL+8ssR1q3ErT8c/bd99emC/cCzPyjsyEDdjIC9f6HhiHfZ7i
         n+QaShX/dwz1vLBah47A2yNcx12I1Uh3e9ip6pDaRX0KGVLfEKKeXmFeL4jH11UyePtr
         3Y7mqEyi6rMU8QCqzyUgkcnvX1amYGClWEQ95tAamXYQLtyUMVV1uPaL7w4qR+/URPTC
         sWcN3uCBjgJrm96sQVvFXbjxPRMbJCK2aMlXCbkW7g6BpKcaZXUP1RRZ3pzPrNTPIcz9
         noSa5iQRwqpKaDHoFvfJa+ho9t1O8hf0Yy2Z9ATf/d4qUTOSlVnY8VmW38DKud9ykf+h
         WEhA==
X-Gm-Message-State: AOJu0YxAUhIDYnW/G85n//6tmBHA0E7txoW2Uu4u6sBSwxMdMQgDj9vG
	jUTEdJwYXJ9ye1LuylMHrQOz9k+khqNWHatAEZBzl1GoDX4rxTF6zHTtua/pLVFzRw==
X-Gm-Gg: ASbGncsOATas3h8udrQq/HEIJoOngRkw106RgmonJ7tvnXDW5/WfHFJDG9T/oXZp9of
	ne3eb1XdLQA6f/8l9YO/W7cBL2Z7awC5K+2f2tZm3KvVlJ11Tg0+V/62ZZCL0H0DbBWdfeDdUba
	jBgriCRtn1NZyb8JdXjGiCgVDpGBjnHegbP32rLN2y80X8PoqqXbyCDuvYT0lXfZ4kLnBsp3xEc
	J4YuReJqCqui2xvZOp8ha7HDYouzd0tj057+gKGu3hCycufeSa4yqP3npv/UusbNnvY4g==
X-Google-Smtp-Source: AGHT+IFpR+OvWl+h/tMQT7FB2Cl/wcaAyal/19BLclg3dmZC4r5Rb+2FWXM56/A5OKHxuy8yENrBxw==
X-Received: by 2002:a17:907:2ce3:b0:ab2:f937:b3aa with SMTP id a640c23a62f3a-ab2f937b97emr1942593466b.56.1737024575595;
        Thu, 16 Jan 2025 02:49:35 -0800 (PST)
Received: from localhost.localdomain ([154.118.34.84])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c9646be5sm901203966b.174.2025.01.16.02.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 02:49:35 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 4/4] t/unit-tests: convert reftable tree test to use clar test framework
Date: Thu, 16 Jan 2025 11:49:11 +0100
Message-ID: <20250116104911.77405-5-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250116104911.77405-1-kuforiji98@gmail.com>
References: <20250116104911.77405-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapts reftable tree test script to clar framework by using clar
assertions where necessary. Following the consensus to convert the
unit-tests scripts found in the t/unit-tests folder to clar driven by
Patrick Steinhardt.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                       |  2 +-
 t/meson.build                  |  2 +-
 t/unit-tests/t-reftable-tree.c | 86 ----------------------------------
 t/unit-tests/u-reftable-tree.c | 78 ++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 88 deletions(-)
 delete mode 100644 t/unit-tests/t-reftable-tree.c
 create mode 100644 t/unit-tests/u-reftable-tree.c

diff --git a/Makefile b/Makefile
index 049f857512..75dbb8e25f 100644
--- a/Makefile
+++ b/Makefile
@@ -1340,6 +1340,7 @@ THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
 CLAR_TEST_SUITES += u-ctype
 CLAR_TEST_SUITES += u-mem-pool
 CLAR_TEST_SUITES += u-prio-queue
+CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strvec
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
@@ -1360,7 +1361,6 @@ UNIT_TEST_PROGRAMS += t-reftable-reader
 UNIT_TEST_PROGRAMS += t-reftable-readwrite
 UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-reftable-stack
-UNIT_TEST_PROGRAMS += t-reftable-tree
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-strcmp-offset
 UNIT_TEST_PROGRAMS += t-trailer
diff --git a/t/meson.build b/t/meson.build
index 09232967cd..6dd41216ef 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -2,6 +2,7 @@ clar_test_suites = [
   'unit-tests/u-ctype.c',
   'unit-tests/u-mem-pool.c',
   'unit-tests/u-prio-queue.c',
+  'unit-tests/u-reftable-tree.c',
   'unit-tests/u-strvec.c',
 ]
 
@@ -56,7 +57,6 @@ unit_test_programs = [
   'unit-tests/t-reftable-readwrite.c',
   'unit-tests/t-reftable-record.c',
   'unit-tests/t-reftable-stack.c',
-  'unit-tests/t-reftable-tree.c',
   'unit-tests/t-strbuf.c',
   'unit-tests/t-strcmp-offset.c',
   'unit-tests/t-trailer.c',
diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tree.c
deleted file mode 100644
index 79b175a45a..0000000000
--- a/t/unit-tests/t-reftable-tree.c
+++ /dev/null
@@ -1,86 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#include "test-lib.h"
-#include "reftable/tree.h"
-
-static int t_compare(const void *a, const void *b)
-{
-	return (char *)a - (char *)b;
-}
-
-struct curry {
-	void **arr;
-	size_t len;
-};
-
-static void store(void *arg, void *key)
-{
-	struct curry *c = arg;
-	c->arr[c->len++] = key;
-}
-
-static void t_tree_search(void)
-{
-	struct tree_node *root = NULL;
-	void *values[11] = { 0 };
-	struct tree_node *nodes[11] = { 0 };
-	size_t i = 1;
-
-	/*
-	 * Pseudo-randomly insert the pointers for elements between
-	 * values[1] and values[10] (inclusive) in the tree.
-	 */
-	do {
-		nodes[i] = tree_insert(&root, &values[i], &t_compare);
-		check(nodes[i] != NULL);
-		i = (i * 7) % 11;
-	} while (i != 1);
-
-	for (i = 1; i < ARRAY_SIZE(nodes); i++) {
-		check_pointer_eq(&values[i], nodes[i]->key);
-		check_pointer_eq(nodes[i], tree_search(root, &values[i], &t_compare));
-	}
-
-	check(!tree_search(root, values, t_compare));
-	tree_free(root);
-}
-
-static void t_infix_walk(void)
-{
-	struct tree_node *root = NULL;
-	void *values[11] = { 0 };
-	void *out[11] = { 0 };
-	struct curry c = {
-		.arr = (void **) &out,
-	};
-	size_t i = 1;
-	size_t count = 0;
-
-	do {
-		struct tree_node *node = tree_insert(&root, &values[i], t_compare);
-		check(node != NULL);
-		i = (i * 7) % 11;
-		count++;
-	} while (i != 1);
-
-	infix_walk(root, &store, &c);
-	for (i = 1; i < ARRAY_SIZE(values); i++)
-		check_pointer_eq(&values[i], out[i - 1]);
-	check(!out[i - 1]);
-	check_int(c.len, ==, count);
-	tree_free(root);
-}
-
-int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
-{
-	TEST(t_tree_search(), "tree_search works");
-	TEST(t_infix_walk(), "infix_walk works");
-
-	return test_done();
-}
diff --git a/t/unit-tests/u-reftable-tree.c b/t/unit-tests/u-reftable-tree.c
new file mode 100644
index 0000000000..bcf9061071
--- /dev/null
+++ b/t/unit-tests/u-reftable-tree.c
@@ -0,0 +1,78 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "unit-test.h"
+#include "reftable/tree.h"
+
+static int t_compare(const void *a, const void *b)
+{
+	return (char *)a - (char *)b;
+}
+
+struct curry {
+	void **arr;
+	size_t len;
+};
+
+static void store(void *arg, void *key)
+{
+	struct curry *c = arg;
+	c->arr[c->len++] = key;
+}
+
+void test_reftable_tree__tree_search(void)
+{
+	struct tree_node *root = NULL;
+	void *values[11] = { 0 };
+	struct tree_node *nodes[11] = { 0 };
+	size_t i = 1;
+
+	/*
+	 * Pseudo-randomly insert the pointers for elements between
+	 * values[1] and values[10] (inclusive) in the tree.
+	 */
+	do {
+		nodes[i] = tree_insert(&root, &values[i], &t_compare);
+		cl_assert(nodes[i] != NULL);
+		i = (i * 7) % 11;
+	} while (i != 1);
+
+	for (i = 1; i < ARRAY_SIZE(nodes); i++) {
+		cl_assert_equal_p(&values[i], nodes[i]->key);
+		cl_assert_equal_p(nodes[i], tree_search(root, &values[i], &t_compare));
+	}
+
+	cl_assert(tree_search(root, values, t_compare) == NULL);
+	tree_free(root);
+}
+
+void test_reftable_tree__infix_walk(void)
+{
+	struct tree_node *root = NULL;
+	void *values[11] = { 0 };
+	void *out[11] = { 0 };
+	struct curry c = {
+		.arr = (void **) &out,
+	};
+	size_t i = 1;
+	size_t count = 0;
+
+	do {
+		struct tree_node *node = tree_insert(&root, &values[i], t_compare);
+		cl_assert(node != NULL);
+		i = (i * 7) % 11;
+		count++;
+	} while (i != 1);
+
+	infix_walk(root, &store, &c);
+	for (i = 1; i < ARRAY_SIZE(values); i++)
+		cl_assert_equal_p(&values[i], out[i - 1]);
+	cl_assert(out[i - 1] == NULL);
+	cl_assert_equal_i(c.len, count);
+	tree_free(root);
+}
-- 
2.34.1

