Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B31514BF98
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 06:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308507; cv=none; b=HNFXl63mCh6S6VMBhjbNEvisC6FNDDn/B1F047dxIT5yzjyMi8CFSE9UdrUnLXQuxQBluFi0LJBMQtAA40XMezw9jpMIy8pKZIZPWy06YIWIHIPLatPa5ZpI2M4B7G3QgF4uAfC0fkvI4Uu3MKGT7aYhRHVZuxyMdCVg5ggCGnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308507; c=relaxed/simple;
	bh=9KT4AzA9oraOcRLcRyYD1j8e9cdbJLhiLFjYm8CF7hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLD6Q+q6b/eA0BqkkjMMnFZkKduNJNcB9/usxz+y9x7vfJWsnTUWsIlOdf8zvuzUUfazqsotYQCltycPS/fTtZiteBhg1q/155YxtDQ3uuBfMASlpYp4IQHfmOpG/AP2sxvHy3/bO9MFCzTfe3NSM8cWoZNgTAZV0sUhkZAuaCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gq4Fo9Ps; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jCZBNtkp; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gq4Fo9Ps";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jCZBNtkp"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6FE6C138592E;
	Thu, 22 Aug 2024 02:35:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 22 Aug 2024 02:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724308505; x=1724394905; bh=o72FovIsJO
	d+87xrR3CrsPz8nNj3nDgqpbLM4Gy40eo=; b=Gq4Fo9Pscp5LmcW8ZO/IORhKyj
	OJg+D9c6EVeHIrZlSnqpsAxVxk6ZD0bNvzxW69qyRDLxKoy1XcEOPCLe7u1+b1JD
	zuMLrN6yLQBVB6dItIlNs1AWdphRP+ykJAH3aj06unbziUS0klFxFIeWVIiu8qCq
	+kw6ysRTPCZclzMmPtNqNLxWHs17NXRWC3PfjoYyaHBJfqb4wamO23jfteihWc8N
	l0cghn5ik09Q2sh+eu35uRxleaACDop3hqolp58AX2zY31NVCaPXg7fl1Uwwcw59
	GB2wgsb7MV83+2pmzFUzGUE6uDR2h6CHdAMveYkiXdmDTGaYoJhn2rOseEYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724308505; x=1724394905; bh=o72FovIsJOd+87xrR3CrsPz8nNj3
	nDgqpbLM4Gy40eo=; b=jCZBNtkpSoeYWBJdoiG7TE0fp9zfk46u0YCXcVnkmteF
	shkr/wPHYI6vPwOODVklZy78A+uQJa4d9xhdSv9X58mlvKZ6iw8UPQtcnartGeA8
	iVmMXJ2/X7Og+pCjT0WrAh41RvKq/sfMsV6QduFpJLrUY8YQVbOoKM8Z488JKUe3
	dBp1A39iug0GHEbkBPvoIROqQoV/MxWNzw5WbsBWCANaZMLqsRkkyE8l1Oyja8ei
	FpUbqY/ZX5IM9KkF9g8gide8PL5yrrg9qydHrK+ROK2bPnUYZ1FrCmfSu8LfdCQ7
	GohLOhP8ZG43Ru2BxwK9976I/f8Veef1QunSX2hjXQ==
X-ME-Sender: <xms:GdzGZrL8r4cG8uX1RPtn5ddUVglyzFAqWWFA2vDlQJnr1CxJxm0Xkg>
    <xme:GdzGZvKfBHspBBK71LToLdyttw4ToOTO_VdtlIeaXIxfmhwbKo5-QFYzZteylit-q
    NUDVUwmXE3pzxAAJg>
X-ME-Received: <xmr:GdzGZjveI8-ouyy1svinFisWD4BtddzUbEyBG3V-_vi1ZzGsPwRdfwyug2Fald5TrIDFaD2kBJHwdwhgj6kWhSWXyq5QFiR5X6xPHJSgEe2raWs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeeuieeuudfhvefhkeeigfekgfegleejtdffteehheet
    hffhvdeludekkeffhfffvdenucffohhmrghinhepghhoohhglhgvrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:GdzGZkYNNrkSFKgYL6FQSTenASvD-r-5tPb5yTEx1S15hXIG2asPXA>
    <xmx:GdzGZiZPvJhwEhS4s3JqQt0Sz0GudyfDgAKds-ps9fD02_g011zXHw>
    <xmx:GdzGZoBzOKOBVVYK_wGNv1XuEHUg9zC75LVzC3SVBSIKPqi5GqHFfA>
    <xmx:GdzGZga_ayNvp5nVONze0PHG0gQqR3U7eo1Jv_ND_KaJNCLPUJhKYw>
    <xmx:GdzGZiHJKzEN3-5nNHcONGiwnzPJeONtG_7X-BEoVN4z3AypJ4d53yZb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 02:35:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id be3f7ba0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 06:34:30 +0000 (UTC)
Date: Thu, 22 Aug 2024 08:35:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 08/15] t/helper: inline `reftable_dump_main()`
Message-ID: <ceaa296bfd48f11e636150900a4fe6243f10f1a4.1724308389.git.ps@pks.im>
References: <cover.1723640107.git.ps@pks.im>
 <cover.1724308389.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724308389.git.ps@pks.im>

The printing functionality part of `reftable/dump.c` is really only used
by our "dump-reftable" test helper. It is certainly not generic logic
that is useful to anybody outside of Git, and the format it generates is
quite specific. Still, parts of it are used in our test suite and the
output may be useful to take a peek into reftable stacks, tables and
blocks. So while it does not make sense to expose this as part of the
reftable library, it does make sense to keep it around.

Inline the `reftable_dump_main()` function into the "dump-reftable" test
helper. This clarifies that its format is subject to change and not part
of our public interface. Furthermore, this allows us to iterate on the
implementation in subsequent patches.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                  |  1 -
 reftable/dump.c           | 86 ---------------------------------------
 reftable/reftable-tests.h |  1 -
 t/helper/test-reftable.c  | 61 ++++++++++++++++++++++++++-
 4 files changed, 60 insertions(+), 89 deletions(-)
 delete mode 100644 reftable/dump.c

diff --git a/Makefile b/Makefile
index 3863e60b664..343f19a488b 100644
--- a/Makefile
+++ b/Makefile
@@ -2680,7 +2680,6 @@ REFTABLE_OBJS += reftable/tree.o
 REFTABLE_OBJS += reftable/writer.o
 
 REFTABLE_TEST_OBJS += reftable/block_test.o
-REFTABLE_TEST_OBJS += reftable/dump.o
 REFTABLE_TEST_OBJS += reftable/pq_test.o
 REFTABLE_TEST_OBJS += reftable/readwrite_test.o
 REFTABLE_TEST_OBJS += reftable/stack_test.o
diff --git a/reftable/dump.c b/reftable/dump.c
deleted file mode 100644
index 391d93de6a4..00000000000
--- a/reftable/dump.c
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
-#include "git-compat-util.h"
-#include "hash.h"
-
-#include "reftable-blocksource.h"
-#include "reftable-error.h"
-#include "reftable-record.h"
-#include "reftable-tests.h"
-#include "reftable-writer.h"
-#include "reftable-iterator.h"
-#include "reftable-reader.h"
-#include "reftable-stack.h"
-
-#include <stddef.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-
-static void print_help(void)
-{
-	printf("usage: dump [-st] arg\n\n"
-	       "options: \n"
-	       "  -b dump blocks\n"
-	       "  -t dump table\n"
-	       "  -s dump stack\n"
-	       "  -6 sha256 hash format\n"
-	       "  -h this help\n"
-	       "\n");
-}
-
-int reftable_dump_main(int argc, char *const *argv)
-{
-	int err = 0;
-	int opt_dump_blocks = 0;
-	int opt_dump_table = 0;
-	int opt_dump_stack = 0;
-	uint32_t opt_hash_id = GIT_SHA1_FORMAT_ID;
-	const char *arg = NULL, *argv0 = argv[0];
-
-	for (; argc > 1; argv++, argc--)
-		if (*argv[1] != '-')
-			break;
-		else if (!strcmp("-b", argv[1]))
-			opt_dump_blocks = 1;
-		else if (!strcmp("-t", argv[1]))
-			opt_dump_table = 1;
-		else if (!strcmp("-6", argv[1]))
-			opt_hash_id = GIT_SHA256_FORMAT_ID;
-		else if (!strcmp("-s", argv[1]))
-			opt_dump_stack = 1;
-		else if (!strcmp("-?", argv[1]) || !strcmp("-h", argv[1])) {
-			print_help();
-			return 2;
-		}
-
-	if (argc != 2) {
-		fprintf(stderr, "need argument\n");
-		print_help();
-		return 2;
-	}
-
-	arg = argv[1];
-
-	if (opt_dump_blocks) {
-		err = reftable_reader_print_blocks(arg);
-	} else if (opt_dump_table) {
-		err = reftable_reader_print_file(arg);
-	} else if (opt_dump_stack) {
-		err = reftable_stack_print_directory(arg, opt_hash_id);
-	}
-
-	if (err < 0) {
-		fprintf(stderr, "%s: %s: %s\n", argv0, arg,
-			reftable_error_str(err));
-		return 1;
-	}
-	return 0;
-}
diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
index d5e03dcc1b6..d005a8bb9e1 100644
--- a/reftable/reftable-tests.h
+++ b/reftable/reftable-tests.h
@@ -16,6 +16,5 @@ int record_test_main(int argc, const char **argv);
 int readwrite_test_main(int argc, const char **argv);
 int stack_test_main(int argc, const char **argv);
 int tree_test_main(int argc, const char **argv);
-int reftable_dump_main(int argc, char *const *argv);
 
 #endif
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 9d378427da9..7f37d0cd34b 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -1,4 +1,7 @@
 #include "reftable/system.h"
+#include "reftable/reftable-error.h"
+#include "reftable/reftable-reader.h"
+#include "reftable/reftable-stack.h"
 #include "reftable/reftable-tests.h"
 #include "test-tool.h"
 
@@ -13,7 +16,63 @@ int cmd__reftable(int argc, const char **argv)
 	return 0;
 }
 
+static void print_help(void)
+{
+	printf("usage: dump [-st] arg\n\n"
+	       "options: \n"
+	       "  -b dump blocks\n"
+	       "  -t dump table\n"
+	       "  -s dump stack\n"
+	       "  -6 sha256 hash format\n"
+	       "  -h this help\n"
+	       "\n");
+}
+
 int cmd__dump_reftable(int argc, const char **argv)
 {
-	return reftable_dump_main(argc, (char *const *)argv);
+	int err = 0;
+	int opt_dump_blocks = 0;
+	int opt_dump_table = 0;
+	int opt_dump_stack = 0;
+	uint32_t opt_hash_id = GIT_SHA1_FORMAT_ID;
+	const char *arg = NULL, *argv0 = argv[0];
+
+	for (; argc > 1; argv++, argc--)
+		if (*argv[1] != '-')
+			break;
+		else if (!strcmp("-b", argv[1]))
+			opt_dump_blocks = 1;
+		else if (!strcmp("-t", argv[1]))
+			opt_dump_table = 1;
+		else if (!strcmp("-6", argv[1]))
+			opt_hash_id = GIT_SHA256_FORMAT_ID;
+		else if (!strcmp("-s", argv[1]))
+			opt_dump_stack = 1;
+		else if (!strcmp("-?", argv[1]) || !strcmp("-h", argv[1])) {
+			print_help();
+			return 2;
+		}
+
+	if (argc != 2) {
+		fprintf(stderr, "need argument\n");
+		print_help();
+		return 2;
+	}
+
+	arg = argv[1];
+
+	if (opt_dump_blocks) {
+		err = reftable_reader_print_blocks(arg);
+	} else if (opt_dump_table) {
+		err = reftable_reader_print_file(arg);
+	} else if (opt_dump_stack) {
+		err = reftable_stack_print_directory(arg, opt_hash_id);
+	}
+
+	if (err < 0) {
+		fprintf(stderr, "%s: %s: %s\n", argv0, arg,
+			reftable_error_str(err));
+		return 1;
+	}
+	return 0;
 }
-- 
2.46.0.164.g477ce5ccd6.dirty

