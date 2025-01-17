Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA641FECD8
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117004; cv=none; b=jwShA+mCFSzrXeb4B6jH+Q0V4fjjo1UfipXihsvHcFxtNUq8rPF1onj32hZDTyCK3xAzK9Ws0BtK2b8/9a0Tjg5Vo6Za92+wasNo2b0sMRl/IXlIHwI+zFTfYF8ZgM9C4AKdGAwSDjVqzZNIE627sdIqQ3L4S7hIqhYlCfoJB38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117004; c=relaxed/simple;
	bh=hMuLxxnRyZACqRSR7y7hec5PqrUH+3FgmDqAhpXq0Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isSaDaa1r9QuKmu7al1RjIpOSLeoZ808IxlcMFhbxqike5qtSAmkFKQDbnpK/NEGyKiF213GUZf62dAV5RPmD56AMDwBPwQImoDo+A7YFYK5N6t5/oadrUo3toncfKn5CLrXU3j6EEjDyFnQ0iHuSlmw9SywTfwcw+cYfohy1xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxEzVOBx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxEzVOBx"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa6a92f863cso385835666b.1
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 04:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737117000; x=1737721800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F90VIJ7J6doYK5Te5Ja/fbNBxHBFIjMxoM8CsXFtbEQ=;
        b=QxEzVOBxwjqQAe22XccFMfpiDty+xqpdxSMwLZvAtgvrnvLpYs32MXIMDeJGHz/u48
         EYXUxLM+mDpIlkZBMESWcMprYbjj3B5of44K5Gp/k1+iBz6WWX5cwtX4W3kmYCGiGR8l
         qwQw0SxWd8Uq5K7XXa1oqgnzGwt61vVs1oPZe9I//Ruc/tSrsoqy51Wzv54NzRXtmRr6
         JcWPEe64aUytbWlz2kMvr2Wr5EHHEynqDsw++he0M6iDHwNb5GR055QjP6SJq1gSgWxT
         NRcbB3LLYbOt3lYALECHG/BkUsWWJCHCSFfkbsnqRtXmqF5im7UCjuXxvSSDtcqsUmiB
         32RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737117000; x=1737721800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F90VIJ7J6doYK5Te5Ja/fbNBxHBFIjMxoM8CsXFtbEQ=;
        b=C8BpIR7DCKbOl9GaoBRM+fdcZGmLBoYwtjs30vp+yIIEKrdnylWODqsWLBDgsxEdpc
         xOQ5Mdm8cdwmqxc1ljfN8U/WHcDlnLhYwVZjs7X2QUZUh/WmbaDovuzUM2gAu8RuMyg1
         HLOYlsL1bqLH/5kSN6+Zi8VgkPxhQ5fEmvJTP5gWT0c+JqGEtwijG2y+eTtJzE+yYY9z
         42kbLoh3tW4JzqfVMzrpuwtWhOUWQjXMVzx+yWG4Tw559V5FMortJWL92u40jaeIUawo
         WwomtuKI0DTjgK89QkLrSgPxSi/zQ/5MJZEUwE65kwohNFE5NNubFRSmznI6SBH+OqUs
         Nqvg==
X-Gm-Message-State: AOJu0Yw4E/MMFq7J8EcHFfgW3l2SwvOnxlwCUACVYKCAbHQnqvi6uNX5
	O4D8Ww2AcnwfqLKBmkRUqxjPCIjjIx5iu+sB9x8LfztNEr6vuhd2y1Ct93VM0AfBWQ==
X-Gm-Gg: ASbGnctOm5N+0svlkAsKVrRdxH4vjhnaQqfuktZdNuIFChau4mZt4XpU1cSyrLPm6KJ
	8Z7tBJeWqG+UlCYqDN8vIeREz1SBA13xXtJSxE1JrrOqUGpleetAzpoqH1GxK25pf87xQTcy1jt
	dAwysBTLWUcDQ+IECh/SczWN6Ghx7joG2egEfceyvbQ+rQF9JaNNCOdT65AQhXKQC8+GP24ovtf
	XCjMMS7570ICmU/iq20AlibGhsCcqMqa1z+zzzBIOAWMU0fRl/AIdueg7jpRfB4jj40Aw==
X-Google-Smtp-Source: AGHT+IHfeQtVWjKLFaouo4bAgwoWnWdId4tvfmnwfAn3vn/r8EihgRlodHyXSNjc/bUFNyJu52zrsg==
X-Received: by 2002:a17:907:1c24:b0:ab3:4c36:7d31 with SMTP id a640c23a62f3a-ab38b24bf02mr204382166b.22.1737117000032;
        Fri, 17 Jan 2025 04:30:00 -0800 (PST)
Received: from localhost.localdomain ([154.118.34.84])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384f23007sm164362166b.96.2025.01.17.04.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:29:59 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v3 4/4] t/unit-tests: convert reftable tree test to use clar test framework
Date: Fri, 17 Jan 2025 13:29:26 +0100
Message-ID: <20250117122926.101749-5-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250117122926.101749-1-kuforiji98@gmail.com>
References: <20250116161559.91038-1-kuforiji98@gmail.com>
 <20250117122926.101749-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapts reftable tree test script to clar framework by using clar
assertions where necessary.

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

