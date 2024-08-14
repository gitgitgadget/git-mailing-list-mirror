Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FC51B1507
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641798; cv=none; b=p6zMMQpekg7QwY3Qye0EfE8xyrpK7jzCYmNpuGFIZA2w5fGd9bKVgvU1IVvgEezxdXhgnLw/bMP0JrQ+xD5n/FKK54JdRn1Iw6oy/SsACwyOPfck75wTdsVUL5r45JCwiK74EQkMJAvrdDIjINpfGF0p6k0KiQ62ciKx1DhhxJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641798; c=relaxed/simple;
	bh=r6WSev8e7HNQ/3wW0GIlcfdQVRrs4yNWR8YcHOBzegQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuA4fb2oiLAYxsowlt/wA+MpDCGTmWkh0M09ixouqd6AV0AlKIjEOcAkJh+rHBO1tgbTKw5VrskUnDiqaNERYig8eDMV2igccIb9Gs2cnR9PL1OzopBcbu9aPbicL3VgZjG3HBB2Rkvj4fT+rIwEXtS74BJG7FzkiHgKjDnigv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ouerd9cs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kaE4r5Q4; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ouerd9cs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kaE4r5Q4"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7C397138FC93;
	Wed, 14 Aug 2024 09:23:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 14 Aug 2024 09:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723641795; x=1723728195; bh=CMjv4E7ZP7
	vC8xi4dZN6TyvThAwwLPPyO9Kal7vx/50=; b=Ouerd9csMehg4nl+eum1Amnnwf
	+ZcYDd4cl419wMf3cEBLFFtMC6xAscQbwiGH+4ggFioWIfQYGzQCgC93FOuY7xHn
	cXvEqVX7pdnxHwzlMy8fT1a134nOeFWqTwQXqUl8a6dDd26KeGCHAUoNYUJKqk3Q
	e/lOuvdA8aDJJokMdhKTKMiiU9Q0l1/TbGM4FYcvqJ2bSA+iJA2pSa/BF+XY1Uyh
	8957jrXTL/AwraUq7BHBvITsc2bCkh/8OA9Tg70u15Wdi8ObsjORgtN8K3niJwv2
	rWB7L5GAr93Mo66SUikd+oJshve4s9mktZ7ZG0LlKMlQTdKaL+RCQ9mIZiMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723641795; x=1723728195; bh=CMjv4E7ZP7vC8xi4dZN6TyvThAww
	LPPyO9Kal7vx/50=; b=kaE4r5Q4IiFtSwOxQsse3s57CJ39eYADzl1cXUlhnTDR
	YFuAMZS4YEuG4CD3KutJ9XrPlMqSRC12/Sn8d3dcL3jMuEBo+kob1eWZUWjxDfw0
	iXS/X01cxJVQc610N/wg7ywSsFv4Xgh5rtUP3pQYDDPjIGOiEPHjQgJDRD+7kick
	IUW9UAWewsNyWaqKW6DSatR62xk6Ja1kIfJXduvlOMVF/cbQYLUulNgvSMEJKoZ8
	x1DhCbibToxiRDAjf3DHlqq8dULPmrReLLh5vU96pa6Hk1/3BWrUziFcxZBz0TfU
	ueruQDbm31bw9702iP0LoFOmVmlEAF2CdjE3uxvxCQ==
X-ME-Sender: <xms:w6-8ZsulLsR_6-l3XWMcgKdYMhZJiMOJr17voA1hGQwrMsOp2aMsRw>
    <xme:w6-8ZpcV65lIEFFHGD84SNDADtC62MRbv83BiZ9fMQN7zY8ZaWe77lbMiRh8rtXo9
    VEW3eOlBb_YH_ZPfA>
X-ME-Received: <xmr:w6-8ZnwzEo9ZrPJTvSgyv0iKLsu3TBM4UBQTSxFBUDPIev4-NiqW2H7PgflJopWEQq29UOaL620OO90MYR7OxlJDwE-g89-gKKZfCcNK8Eu_jQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepueeiueduhfevhfekiefgkefggeeljedtffetheehtefh
    hfdvledukeekfffhffdvnecuffhomhgrihhnpehgohhoghhlvgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:w6-8ZvO_NIhTN600B_05bfhVRVZiYAoh4G6GBe43DdFe-F8wH76QKg>
    <xmx:w6-8Zs_QMU1a5ucEDVEUdOOHf_4ghiz5gWpBx8vF2I6eq8AiIi7eDg>
    <xmx:w6-8ZnV-iiFcV1xIZzQFiQc7NwEEs6xXLBJKGzySmJg2v9bBRo22zQ>
    <xmx:w6-8ZleHDjL_4Ej8Ncvb2hamMCMAlzHd8yNWihW1WctBqmOVe9ccyQ>
    <xmx:w6-8ZuKI0l9mprrDWQAdoKpnAi0APYg2LydNHOZmjrkMDazNYu_HM5q7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 09:23:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 81c419f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 13:22:55 +0000 (UTC)
Date: Wed, 14 Aug 2024 15:23:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 08/15] t/helper: inline `reftable_dump_main()`
Message-ID: <ceaa296bfd48f11e636150900a4fe6243f10f1a4.1723640107.git.ps@pks.im>
References: <cover.1723640107.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723640107.git.ps@pks.im>

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
index 3863e60b66..343f19a488 100644
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
index 391d93de6a..0000000000
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
index d5e03dcc1b..d005a8bb9e 100644
--- a/reftable/reftable-tests.h
+++ b/reftable/reftable-tests.h
@@ -16,6 +16,5 @@ int record_test_main(int argc, const char **argv);
 int readwrite_test_main(int argc, const char **argv);
 int stack_test_main(int argc, const char **argv);
 int tree_test_main(int argc, const char **argv);
-int reftable_dump_main(int argc, char *const *argv);
 
 #endif
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 9d378427da..7f37d0cd34 100644
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
2.46.0.46.g406f326d27.dirty

