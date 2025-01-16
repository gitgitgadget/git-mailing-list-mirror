Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE0922BAC6
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044194; cv=none; b=up3c/SBKirivIgl+L1/M6n8VN2DOUJghiNrBlk7YX5Pa2mUn/tUNfii7kA9apE+9qoUI+jLcryusP8J6HTeJt7c4bDlPoxCAMMgR6Em1zqKF/laI6XAI/MUtpZ6dfXPYVbiw3uJGooxYRGEacu7+LlDX0lX2QKti/u76AnLL8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044194; c=relaxed/simple;
	bh=hMuLxxnRyZACqRSR7y7hec5PqrUH+3FgmDqAhpXq0Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/wIFHdkeL9DHEHtzAd85Id+pr/Oemqcq+WsCxk8CCbXt0BjVj/JuMxNP2gFUrPr3hqBW35scyz444RBlfVkLVNHv0i656+bnvjVkGa6eXPyE4CkTLTbIXQ6tNaFkhT7/QFPxaPeq+3yHY7QUNe8DemxThZpv5uwAAu8vXvhY/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ixo7cjyC; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ixo7cjyC"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so641911f8f.0
        for <git@vger.kernel.org>; Thu, 16 Jan 2025 08:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737044190; x=1737648990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F90VIJ7J6doYK5Te5Ja/fbNBxHBFIjMxoM8CsXFtbEQ=;
        b=Ixo7cjyC4/5opgrY/8C3IRhyoOm6M/Z57EJHu3DtmWXwMvOK7bGk2fabvtxQ3ioGzv
         eAgHQOZk0sIwzCGOkqQPBXZZ+FU96mkz3eirh3VT83s7r1rUMrLQ8HUF1ggMX7RtXf3s
         e2rvKrPuavW6EfbZTaG1Oz8VtgumnESsHuD+QWtR+xNuPT240R5F8DZdylkRIid1tl4I
         LrdbbAxb1evGa0D5B5cTcDiPx8y0zKxZkDHiJRfVY50lkSg0Gj/88SR34VoX63/8qe9f
         QPlA1BQ52R7aCwNNfsrxyaehrgJPvyx7GXNK9bKPkUZjIiyVIqQXhNI7nX+6CiuM+WaL
         9NJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737044190; x=1737648990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F90VIJ7J6doYK5Te5Ja/fbNBxHBFIjMxoM8CsXFtbEQ=;
        b=CK4L1RcSrz7ZIcnEnBHBXn7bVOrhuoksgbh2p66lFybO3BmgGAXdViQjvlaE3WhrEX
         3kd3+9VOuH2x3A32DPpKyVP3sprnnixDZg7AGwIZ47K48P7sG/IAd3+h7Nskbk1Z8g6s
         Rz+xgnooPkEtfz11sGJth2QoGuD2L5B2CY3/b1bvjAsRiIyUplPcj6iaPHeya+UI4IXn
         mz0C1j+WUWwTqeQSipkBZnA853O9PDUbPeGvU+FTwA+H8dpThwlJqqOXyyGUFARfkD8k
         oMeuTDbCp2ILCDXqWoMWfcPj8lG5kMFOEYrfrlg8fGmTwRlANnBGHlxLxTpNecU57Qsx
         hbtQ==
X-Gm-Message-State: AOJu0YwobGxbLbUgoLKRfrKqAru5G6ZZ9frRRw73ElU+gfM6Q2k330SN
	GljHmMaWW/zXgFHj8DOED7g0rzKMS7km7JyXrTnYsXg0iTDD+RIHg+k0unQCny1Oag==
X-Gm-Gg: ASbGncvY4U8C+L/KLIuCUEnZGPZbKvSl5dxCIa26pMMeHgf02swFRLcsRhVK/KGtXc8
	24si48+14RD451PhhOnv/UbRmA7YMVXLWRY6K1fbUz1XlStANptc2RNO8eMPNsuYmnI1Aa1c7TB
	YQQSOdjeHMMemmZVRbIumDYIsAYR6OWuLSVgTdNhFurgDpZpvkkolTHR4ewaacacIWtcrIGQJps
	liAplvWXiU3Jl7Re/Gonyu/tFDNRnrwdjuo6a/7O7zdSUyplk9sQMuaaa0FDsfrGh5rKg==
X-Google-Smtp-Source: AGHT+IHAO5Mpn5U5grfoAqoH55s5Yjq+LwZSvjNT3Pa2R6aJKGmgBjyNvnQ7WsPcfjvOmDfUhLlpSA==
X-Received: by 2002:a5d:64e7:0:b0:385:df2c:91aa with SMTP id ffacd0b85a97d-38a872c8882mr27891149f8f.7.1737044190471;
        Thu, 16 Jan 2025 08:16:30 -0800 (PST)
Received: from localhost.localdomain ([154.118.34.84])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-437c752935csm63177025e9.26.2025.01.16.08.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 08:16:30 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 4/4] t/unit-tests: convert reftable tree test to use clar test framework
Date: Thu, 16 Jan 2025 17:15:59 +0100
Message-ID: <20250116161559.91038-5-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250116161559.91038-1-kuforiji98@gmail.com>
References: <20250116104911.77405-1-kuforiji98@gmail.com>
 <20250116161559.91038-1-kuforiji98@gmail.com>
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

