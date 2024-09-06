Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20EC1CC89C
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623121; cv=none; b=b1o6w7U+XBnuzYmeJ4wK8H6hUPAosBLHsYxbUmeyJQoSeUrBB588GQv6m/c3pnMhOllKqxHiZcAPl8WLJLrmHQmBv3NDYXY0i9X5ehlX5icyzCTK5otKRRFCIk0i4vVPCnS6Y5oqznijcGa1mIUwSeROqMaa+VSY5v4Jgjdaaaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623121; c=relaxed/simple;
	bh=KGGDPoyO7UbZZs3aZp8z4pfa2hpOxuCUePPcHsw7Uoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvC/upzRGekbN4FIVUAGEsBZXQM4LyPrrWUuLgCO4CN9vIOxr+vdWaRM5GAhovb4Piqc0x3WJSCv2knUUMz40pfidBwG3q5czpMCj8zDRxAqFGmq67Hsdvt0UnWDtRqINGsN2L5cNoHa9oMNyDssSJgzk+oSLT9EOOj8MaqJrQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khwpCARr; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khwpCARr"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7d7a1b066d7so253124a12.3
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 04:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725623119; x=1726227919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLK8NNFPUCOhKTY/huzaskKlu70IsV4yhh0FlIx5NXg=;
        b=khwpCARrHi5h5pFBWavw/32TEZLlRAhgl8K6lCDuOL3w8Ts1H2bTMLD5bnv/ZjfiAl
         DQpopL82IjwRMxtVjFw8iSdxoRYK2Lwx7DYu1lR/GSSMnzvZjrw1BxpiHT1ZdN4HuhXL
         QsN7LwdZGWvAus6QzkVO3x4GUdZj6cMlMW6dEJAyd4UtLYQAzrQmn5P9rse2GWqPXCE4
         heUBwHMEkLXGWWsa+44FJtg49MxVYWXXnQV9qKSpdTWqNs1oRszcrQimiN2eEeG1xxw6
         IXzr/NMTId68B+CS8Vh0O6mt9dG4trLqJjaQv7cVXc9Zn40RCiccA4DkIVPq14X+OFc8
         Z98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725623119; x=1726227919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLK8NNFPUCOhKTY/huzaskKlu70IsV4yhh0FlIx5NXg=;
        b=gzL6ePyKvkNf+de2k1tPgZlW0ETby6nCjQF8QGiOHE20PwBVoiQ1VrZCuVpIP3l5n/
         QnzrbM0ae0volRJSBk0ZNea+IXB8dnMXC2qZC2QH/54WkUDpeRD6RNcnWdVpSdlrcrh7
         drgYOzqe7b+Ebul9n7kop4XtDhtjbONV8eF26C4PXh7TyH0UH2ETbEWdVgOTQu+anhaq
         ca8ErEMWMaaFZgahH9ax3+AMQYvBmXipQ+24woerPKEfgEHD1haKD7YLVJtdb1iqW1mV
         RRpwYyyuffI3YorzBU8GfV4Ewv1hx63WAszyGbVE40uXhZoV/9DU57NPLt6NbFbV9WOt
         70EA==
X-Gm-Message-State: AOJu0YzGtGxoqPy6j5Ai6aw4tvQYi7CNIc9xaq8hlq7bfEipE4kC9MeG
	DerTc7OO10z3wRAwM2/+z+H2iHqEvbvkYVLGYB3hE0s2E137rYHAV5QRztgF
X-Google-Smtp-Source: AGHT+IEqKROJfl/lsIipnia1WpckQOBo649h0ID4fif40JqiAMmyZHvO9C5H+QxAV6IxSq/9zYH2cQ==
X-Received: by 2002:a05:6a21:386:b0:1c4:98f8:9ccb with SMTP id adf61e73a8af0-1cf1d1ad75bmr1938581637.34.1725623118705;
        Fri, 06 Sep 2024 04:45:18 -0700 (PDT)
Received: from Ubuntu.. ([106.221.74.130])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206ae91371bsm41903685ad.26.2024.09.06.04.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:45:18 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [PATCH v5 7/7] t: clean up leftover reftable test cruft
Date: Fri,  6 Sep 2024 16:59:16 +0530
Message-ID: <20240906113746.8903-8-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240906113746.8903-1-chandrapratap3519@gmail.com>
References: <20240904150132.11567-1-chandrapratap3519@gmail.com>
 <20240906113746.8903-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junio C Hamano <gitster@pobox.com>

With the migration of reftable tests to the unit-tests framework,
"test-tool reftable" becomes a no-op.

Get rid of everything that uses "test-tool reftable" alongside
everything that is used to implement it.

While at it, alphabetically sort the cmds[] list in
helper/test-tool.c by moving the entry for "dump-reftable".

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 Makefile                     |  2 --
 reftable/reftable-tests.h    | 13 --------
 reftable/test_framework.c    | 27 ----------------
 reftable/test_framework.h    | 61 ------------------------------------
 t/helper/test-reftable.c     |  7 -----
 t/helper/test-tool.c         |  3 +-
 t/helper/test-tool.h         |  1 -
 t/t0032-reftable-unittest.sh | 16 ----------
 8 files changed, 1 insertion(+), 129 deletions(-)
 delete mode 100644 reftable/reftable-tests.h
 delete mode 100644 reftable/test_framework.c
 delete mode 100644 reftable/test_framework.h
 delete mode 100755 t/t0032-reftable-unittest.sh

diff --git a/Makefile b/Makefile
index 1cbc2d61ae..64ccb1433f 100644
--- a/Makefile
+++ b/Makefile
@@ -2692,8 +2692,6 @@ REFTABLE_OBJS += reftable/stack.o
 REFTABLE_OBJS += reftable/tree.o
 REFTABLE_OBJS += reftable/writer.o
 
-REFTABLE_TEST_OBJS += reftable/test_framework.o
-
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
 .PHONY: test-objs
diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
deleted file mode 100644
index 05f8d2d5bc..0000000000
--- a/reftable/reftable-tests.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#ifndef REFTABLE_TESTS_H
-#define REFTABLE_TESTS_H
-
-
-#endif
diff --git a/reftable/test_framework.c b/reftable/test_framework.c
deleted file mode 100644
index a07fec5d84..0000000000
--- a/reftable/test_framework.c
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#include "system.h"
-#include "test_framework.h"
-
-
-void set_test_hash(uint8_t *p, int i)
-{
-	memset(p, (uint8_t)i, hash_size(GIT_SHA1_FORMAT_ID));
-}
-
-ssize_t strbuf_add_void(void *b, const void *data, size_t sz)
-{
-	strbuf_add(b, data, sz);
-	return sz;
-}
-
-int noop_flush(void *arg UNUSED)
-{
-	return 0;
-}
diff --git a/reftable/test_framework.h b/reftable/test_framework.h
deleted file mode 100644
index 687390f9c2..0000000000
--- a/reftable/test_framework.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#ifndef TEST_FRAMEWORK_H
-#define TEST_FRAMEWORK_H
-
-#include "system.h"
-#include "reftable-error.h"
-
-#define EXPECT_ERR(c)                                                          \
-	do {                                                                   \
-		if (c != 0) {                                                  \
-			fflush(stderr);                                        \
-			fflush(stdout);                                        \
-			fprintf(stderr, "%s: %d: error == %d (%s), want 0\n",  \
-				__FILE__, __LINE__, c, reftable_error_str(c)); \
-			abort();                                               \
-		}                                                              \
-	} while (0)
-
-#define EXPECT_STREQ(a, b)                                                       \
-	do {                                                                     \
-		if (strcmp(a, b)) {                                              \
-			fflush(stderr);                                          \
-			fflush(stdout);                                          \
-			fprintf(stderr, "%s:%d: %s (%s) != %s (%s)\n", __FILE__, \
-				__LINE__, #a, a, #b, b);                         \
-			abort();                                                 \
-		}                                                                \
-	} while (0)
-
-#define EXPECT(c)                                                                  \
-	do {                                                                       \
-		if (!(c)) {                                                        \
-			fflush(stderr);                                            \
-			fflush(stdout);                                            \
-			fprintf(stderr, "%s: %d: failed assertion %s\n", __FILE__, \
-				__LINE__, #c);                                     \
-			abort();                                                   \
-		}                                                                  \
-	} while (0)
-
-#define RUN_TEST(f)                          \
-	fprintf(stderr, "running %s\n", #f); \
-	fflush(stderr);                      \
-	f();
-
-void set_test_hash(uint8_t *p, int i);
-
-/* Like strbuf_add, but suitable for passing to reftable_new_writer
- */
-ssize_t strbuf_add_void(void *b, const void *data, size_t sz);
-
-int noop_flush(void *);
-
-#endif
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index d27d7ee798..29d4e9a755 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -6,15 +6,8 @@
 #include "reftable/reftable-merged.h"
 #include "reftable/reftable-reader.h"
 #include "reftable/reftable-stack.h"
-#include "reftable/reftable-tests.h"
 #include "test-tool.h"
 
-int cmd__reftable(int argc, const char **argv)
-{
-	/* test from simple to complex. */
-	return 0;
-}
-
 static void print_help(void)
 {
 	printf("usage: dump [-st] arg\n\n"
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index f8a67df7de..252fa5de63 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -26,6 +26,7 @@ static struct test_cmd cmds[] = {
 	{ "drop-caches", cmd__drop_caches },
 	{ "dump-cache-tree", cmd__dump_cache_tree },
 	{ "dump-fsmonitor", cmd__dump_fsmonitor },
+	{ "dump-reftable", cmd__dump_reftable },
 	{ "dump-split-index", cmd__dump_split_index },
 	{ "dump-untracked-cache", cmd__dump_untracked_cache },
 	{ "env-helper", cmd__env_helper },
@@ -61,9 +62,7 @@ static struct test_cmd cmds[] = {
 	{ "read-graph", cmd__read_graph },
 	{ "read-midx", cmd__read_midx },
 	{ "ref-store", cmd__ref_store },
-	{ "reftable", cmd__reftable },
 	{ "rot13-filter", cmd__rot13_filter },
-	{ "dump-reftable", cmd__dump_reftable },
 	{ "regex", cmd__regex },
 	{ "repository", cmd__repository },
 	{ "revision-walking", cmd__revision_walking },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index e74bc0ffd4..84291318cb 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -55,7 +55,6 @@ int cmd__read_graph(int argc, const char **argv);
 int cmd__read_midx(int argc, const char **argv);
 int cmd__ref_store(int argc, const char **argv);
 int cmd__rot13_filter(int argc, const char **argv);
-int cmd__reftable(int argc, const char **argv);
 int cmd__regex(int argc, const char **argv);
 int cmd__repository(int argc, const char **argv);
 int cmd__revision_walking(int argc, const char **argv);
diff --git a/t/t0032-reftable-unittest.sh b/t/t0032-reftable-unittest.sh
deleted file mode 100755
index 471cb37ac2..0000000000
--- a/t/t0032-reftable-unittest.sh
+++ /dev/null
@@ -1,16 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2020 Google LLC
-#
-
-test_description='reftable unittests'
-
-TEST_PASSES_SANITIZE_LEAK=true
-. ./test-lib.sh
-
-test_expect_success 'unittests' '
-	TMPDIR=$(pwd) && export TMPDIR &&
-	test-tool reftable
-'
-
-test_done
-- 
2.45.GIT

