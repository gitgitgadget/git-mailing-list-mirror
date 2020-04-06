Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C09C2BA80
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECC820780
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXDSgnyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbgDFRAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:00:03 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:34284 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729534AbgDFRAB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 13:00:01 -0400
Received: by mail-ed1-f50.google.com with SMTP id o1so412660edv.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 09:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=RQ13dTRqXt/tBsLYEWoAP2r9PckPNmWwxMgCAFExKr0=;
        b=tXDSgnyoORwFcBmjaKKfAoL/mfaGszAEnXbdj095GhWuM6U19gEi8bPMvZo47PkZ/M
         D0hzNsgDDe+jCRlxu7ikyKJI+i19eRgqmg6mEZoDlqia/M6WVjd746pGX7jt997RzRWa
         lZsNARt5D4vMGRv2zqhCLduW3L2BR48J2Ufu2WxBo/m9gr0fHw2oGp1KFz9rv6jqHfsH
         LGRvwhBUqz9SwhBJUtVA4RNOfgN/aitA0DHISOwPdp2siLCxQemQ0OCvIATlNgyVe9ac
         n1nQNlnlHdNCuJ1bchJDAGp/kYXXh1F8c9T8lygq6/k7CxVZ193EYttqNRUfbDEjt727
         RYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=RQ13dTRqXt/tBsLYEWoAP2r9PckPNmWwxMgCAFExKr0=;
        b=IpxZM0bCllrxJwp/b9LLKa4r285CZujHJCV5v+8bS8qjyNNbn8++zR8aGDrVgRYIZ3
         A8UH8S6moSw4PgWz77LdHZwKzMifFqykWC68Nq47Gfu/tpkLri76b3xZPwy+yxbFnbsQ
         qy63p+4SVM658pb6zSkdx3ge9dNKDJUXkZlJ24ZViz+0BsV6JTDXjOV4JxCDm2RLHJmx
         HTPMu3ZBTyCadUCUzblW7yLgrOTKymyHh9LzhdAy5dCawUtayHjRvrB0x7roE7QUeBsR
         e2QohvE+gkfXbVTTHH2ftv8Iw+jSOFrmhN6g85qgclIv7nO1OZbZZVdG8ZBTzHYObRBD
         PVPQ==
X-Gm-Message-State: AGi0PuZR0eo+pPq7g+jH931Y3lBwzwjUVmIsOJCTP8DrJYLC+baGAAnI
        R9hErBagNN+4PmDhWUR0FzbHn6OJ
X-Google-Smtp-Source: APiQypKHcvlDzeTNur9kbSikslo4ws1TCk5fQO2/BVD1qhbSukOZA5gc1zRDLo9lBxoH0Jz6LoROTA==
X-Received: by 2002:a50:8ad2:: with SMTP id k18mr20756791edk.354.1586192398207;
        Mon, 06 Apr 2020 09:59:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i19sm3020089ejh.58.2020.04.06.09.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 09:59:57 -0700 (PDT)
Message-Id: <a5aa3415c05ee9bc67a9471445a20c71a9834673.1586192395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
        <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Apr 2020 16:59:42 +0000
Subject: [PATCH v4 02/15] bloom.c: add the murmur3 hash implementation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

In preparation for computing changed paths Bloom filters,
implement the Murmur3 hash algorithm as described in [1].
It hashes the given data using the given seed and produces
a uniformly distributed hash value.

[1] https://en.wikipedia.org/wiki/MurmurHash#Algorithm

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Helped-by: Szeder Gábor <szeder.dev@gmail.com>
Reviewed-by: Jakub Narębski <jnareb@gmail.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 Makefile              |  2 ++
 bloom.c               | 73 +++++++++++++++++++++++++++++++++++++++++++
 bloom.h               | 13 ++++++++
 t/helper/test-bloom.c | 13 ++++++++
 t/helper/test-tool.c  |  1 +
 t/helper/test-tool.h  |  1 +
 t/t0095-bloom.sh      | 30 ++++++++++++++++++
 7 files changed, 133 insertions(+)
 create mode 100644 bloom.c
 create mode 100644 bloom.h
 create mode 100644 t/helper/test-bloom.c
 create mode 100755 t/t0095-bloom.sh

diff --git a/Makefile b/Makefile
index ef1ff2228f0..491f75e68c5 100644
--- a/Makefile
+++ b/Makefile
@@ -695,6 +695,7 @@ X =
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
 TEST_BUILTINS_OBJS += test-advise.o
+TEST_BUILTINS_OBJS += test-bloom.o
 TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-ctype.o
@@ -840,6 +841,7 @@ LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
 LIB_OBJS += blame.o
 LIB_OBJS += blob.o
+LIB_OBJS += bloom.o
 LIB_OBJS += branch.o
 LIB_OBJS += bulk-checkin.o
 LIB_OBJS += bundle.o
diff --git a/bloom.c b/bloom.c
new file mode 100644
index 00000000000..40e87632aeb
--- /dev/null
+++ b/bloom.c
@@ -0,0 +1,73 @@
+#include "git-compat-util.h"
+#include "bloom.h"
+
+static uint32_t rotate_left(uint32_t value, int32_t count)
+{
+	uint32_t mask = 8 * sizeof(uint32_t) - 1;
+	count &= mask;
+	return ((value << count) | (value >> ((-count) & mask)));
+}
+
+/*
+ * Calculate the murmur3 32-bit hash value for the given data
+ * using the given seed.
+ * Produces a uniformly distributed hash value.
+ * Not considered to be cryptographically secure.
+ * Implemented as described in https://en.wikipedia.org/wiki/MurmurHash#Algorithm
+ */
+uint32_t murmur3_seeded(uint32_t seed, const char *data, size_t len)
+{
+	const uint32_t c1 = 0xcc9e2d51;
+	const uint32_t c2 = 0x1b873593;
+	const uint32_t r1 = 15;
+	const uint32_t r2 = 13;
+	const uint32_t m = 5;
+	const uint32_t n = 0xe6546b64;
+	int i;
+	uint32_t k1 = 0;
+	const char *tail;
+
+	int len4 = len / sizeof(uint32_t);
+
+	uint32_t k;
+	for (i = 0; i < len4; i++) {
+		uint32_t byte1 = (uint32_t)data[4*i];
+		uint32_t byte2 = ((uint32_t)data[4*i + 1]) << 8;
+		uint32_t byte3 = ((uint32_t)data[4*i + 2]) << 16;
+		uint32_t byte4 = ((uint32_t)data[4*i + 3]) << 24;
+		k = byte1 | byte2 | byte3 | byte4;
+		k *= c1;
+		k = rotate_left(k, r1);
+		k *= c2;
+
+		seed ^= k;
+		seed = rotate_left(seed, r2) * m + n;
+	}
+
+	tail = (data + len4 * sizeof(uint32_t));
+
+	switch (len & (sizeof(uint32_t) - 1)) {
+	case 3:
+		k1 ^= ((uint32_t)tail[2]) << 16;
+		/*-fallthrough*/
+	case 2:
+		k1 ^= ((uint32_t)tail[1]) << 8;
+		/*-fallthrough*/
+	case 1:
+		k1 ^= ((uint32_t)tail[0]) << 0;
+		k1 *= c1;
+		k1 = rotate_left(k1, r1);
+		k1 *= c2;
+		seed ^= k1;
+		break;
+	}
+
+	seed ^= (uint32_t)len;
+	seed ^= (seed >> 16);
+	seed *= 0x85ebca6b;
+	seed ^= (seed >> 13);
+	seed *= 0xc2b2ae35;
+	seed ^= (seed >> 16);
+
+	return seed;
+}
\ No newline at end of file
diff --git a/bloom.h b/bloom.h
new file mode 100644
index 00000000000..d0fcc5f0aa6
--- /dev/null
+++ b/bloom.h
@@ -0,0 +1,13 @@
+#ifndef BLOOM_H
+#define BLOOM_H
+
+/*
+ * Calculate the murmur3 32-bit hash value for the given data
+ * using the given seed.
+ * Produces a uniformly distributed hash value.
+ * Not considered to be cryptographically secure.
+ * Implemented as described in https://en.wikipedia.org/wiki/MurmurHash#Algorithm
+ */
+uint32_t murmur3_seeded(uint32_t seed, const char *data, size_t len);
+
+#endif
\ No newline at end of file
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
new file mode 100644
index 00000000000..60ee2043689
--- /dev/null
+++ b/t/helper/test-bloom.c
@@ -0,0 +1,13 @@
+#include "git-compat-util.h"
+#include "bloom.h"
+#include "test-tool.h"
+
+int cmd__bloom(int argc, const char **argv)
+{
+	if (!strcmp(argv[1], "get_murmur3")) {
+		uint32_t hashed = murmur3_seeded(0, argv[2], strlen(argv[2]));
+		printf("Murmur3 Hash with seed=0:0x%08x\n", hashed);
+	}
+
+	return 0;
+}
\ No newline at end of file
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 31eedcd241f..6e26bd65c97 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -15,6 +15,7 @@ struct test_cmd {
 
 static struct test_cmd cmds[] = {
 	{ "advise", cmd__advise_if_enabled },
+	{ "bloom", cmd__bloom },
 	{ "chmtime", cmd__chmtime },
 	{ "config", cmd__config },
 	{ "ctype", cmd__ctype },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 4eb5e6609e1..dceeef1d5c2 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -5,6 +5,7 @@
 #include "git-compat-util.h"
 
 int cmd__advise_if_enabled(int argc, const char **argv);
+int cmd__bloom(int argc, const char **argv);
 int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
 int cmd__ctype(int argc, const char **argv);
diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
new file mode 100755
index 00000000000..2dad8c4a94e
--- /dev/null
+++ b/t/t0095-bloom.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='Testing the various Bloom filter computations in bloom.c'
+. ./test-lib.sh
+
+test_expect_success 'compute unseeded murmur3 hash for empty string' '
+	cat >expect <<-\EOF &&
+	Murmur3 Hash with seed=0:0x00000000
+	EOF
+	test-tool bloom get_murmur3 "" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'compute unseeded murmur3 hash for test string 1' '
+	cat >expect <<-\EOF &&
+	Murmur3 Hash with seed=0:0x627b0c2c
+	EOF
+	test-tool bloom get_murmur3 "Hello world!" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'compute unseeded murmur3 hash for test string 2' '
+	cat >expect <<-\EOF &&
+	Murmur3 Hash with seed=0:0x2e4ff723
+	EOF
+	test-tool bloom get_murmur3 "The quick brown fox jumps over the lazy dog" >actual &&
+	test_cmp expect actual
+'
+
+test_done
\ No newline at end of file
-- 
gitgitgadget

