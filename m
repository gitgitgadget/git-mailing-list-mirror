Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93D63AC0D
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 06:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723530282; cv=none; b=dgqYKxTwWRxnePSXuqMZivGm3ziGsHO5x8g0KahNqL2DvtQbmrlm1pPJJs/UZyKXhIJGhozJH5d6Tkm7NfybzszqNNpOvDFHlWua11ecBgkouKczFgHsxjpRmujXVOkFo1ly3E4j7w589Lwo+IwqIwUAhku5RoJXr3fZLabl6r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723530282; c=relaxed/simple;
	bh=jkARksfYu/IXmrW/sTl+U6GM67f7miMGrL1AhOoL7y8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZITGAIld3+fun3oQHK/gBqyBaxaPFJa3R7nediUKzvXpyQuq8OHasTZnLaBakjl/wCAuHzaC6vLveFIHo7yvbP5FApc3DM+r7C02B4zAP7EkjOdmqEpti+4+NnzFTiQGhoNwbtnUv7JCyFernuf1WgVskDuuAsAv3llIXNaWPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g1gKTJ9Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ONhR16L8; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g1gKTJ9Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ONhR16L8"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id B3E8C138FD3B
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 02:24:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 02:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723530279; x=1723616679; bh=61OkuW5hQO
	oufv6pqEyV3z+wZObJ4PUfFQD5irt4KuA=; b=g1gKTJ9ZdelRB2wOeHxrKBwVWE
	3KB9vOioZKndt+2toUdOIL1qAWwk0O8kwiHXq6TZAezc3XwGcpK1aYMxIEcF/LsI
	a1MmUaklepl/1GcFZC+hMGrJZ3A0367pmZny2R0WuAyLUmInb77/kOBb3F/VzZtD
	5dtAp5wM45X6jVAcFTaIhYR4RcMkSvxo1YfB1NwCS0HFoDlXTUQ1zOcCKyrgHHYL
	oOP+4JErMdn+fPF1ty/YRhMJ1eiXUfY7Ub4bE5uSwExU8B6Wyx7/7mHxxnLsggH0
	s/+cXzful+I9Fe8WYx6zPz5ea1uWRMZkByOeaC4oyZ7MNU9aUlMia9UPGKJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723530279; x=1723616679; bh=61OkuW5hQOoufv6pqEyV3z+wZObJ
	4PUfFQD5irt4KuA=; b=ONhR16L8vCvsSCHE/9uZpYRUHrg26v4oP1HVBAqYcOoi
	M7DQm9t0oXV1CtO+wWIMNWuTXaYTh8LpVvmmW75/NJNWkEYBrXv/O9cMIR9yyR/z
	/bLUm9M9wXf1gxr36Ceoin5j1KKnACwdxCqEMbEltxX9HTwvgPt62moDhyBElGYt
	dV4jj53eo5EJ/H1oLD6t97sFIVaCPObU4u014NdHuI7SA0CsUAGXK6A9HF9r2VWh
	uiFqjgFEjZ1CHFIBkSI/dz+X/MZITJc732OmRq978b1L5FppcBkpXxRcaW1iKThr
	lBfQ6h/NKlpl5YMbrOgZcyovg7Q6hIH7w3ZBpxtFqg==
X-ME-Sender: <xms:J_y6ZohWA7mncDWI8QJxyEcnUI5fcLWhaUum3EqjBG7EmUrMpJOx3g>
    <xme:J_y6ZhAkgMP5NvgRRFHQ7icZ84CZdAQfYp7QM0KQH8vhwCjcnVpCxQuxI6tRG1zJy
    ELgBCPMIF7hHFWJkw>
X-ME-Received: <xmr:J_y6ZgETFnQSh5Hi3N80KbSqdT6I3jIJyyz2Cci6sLHd7mXOymAJzPLlgPzAm6QyvqbYWiu9x8lGVZM1MGAHTpi7tnbAwacL7hw7LmOI7TTvJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeekieekhfefge
    etfefgfeehheekveelgffgtdevleeihfeijeeffeehudehkedvteenucffohhmrghinhep
    ghhoohhglhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:J_y6ZpRpSOqypULeHlZ4DUr0mCAtUgM0wGJQuFqTHt3GeoqCYCIyMg>
    <xmx:J_y6ZlywY7j9v4nWLMyYLu51-dqDAV5VeaAX_85gQk_gGV_i1yMcEg>
    <xmx:J_y6Zn5bm_CTwzq55P_BTUQkcc9gaHI6e0qN8pnhKzgGkCQTSGkCyA>
    <xmx:J_y6Ziy6HhUvFEC0mvODQcZH6qeSFNkPJCpOgQcgU-fjWFKuCgwZMA>
    <xmx:J_y6ZmqTo3ZIH2oJLI3YDUoQFVurs3rpFZ2xPOnXySNd-AlouwcDphIe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 13 Aug 2024 02:24:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 668d41f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 13 Aug 2024 06:24:23 +0000 (UTC)
Date: Tue, 13 Aug 2024 08:24:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 09/10] reftable/dump: move code into
 "t/helper/test-reftable.c"
Message-ID: <4184f46f92c16654ebc2523028a203eb2e1e4f7a.1723528765.git.ps@pks.im>
References: <cover.1723528765.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723528765.git.ps@pks.im>

The code in "reftable/dump.c" is only ever used by our test-tool to
implement the "reftable" subcommand. It also feels very unlikely that it
will ever be useful to any other potential user of the reftable library,
which makes it a weird candidate to have in the library interface.

Inline the code into "t/helper/test-reftable.c".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                 |  1 -
 reftable/dump.c          | 73 ----------------------------------------
 t/helper/test-reftable.c | 47 +++++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 75 deletions(-)
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
index 35a1731da9..0000000000
--- a/reftable/dump.c
+++ /dev/null
@@ -1,73 +0,0 @@
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
-	printf("usage: dump [-cst] arg\n\n"
-	       "options: \n"
-	       "  -c compact\n"
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
-	const char *arg = NULL, *argv0 = argv[0];
-
-	for (; argc > 1; argv++, argc--)
-		if (*argv[1] != '-')
-			break;
-		else if (!strcmp("-b", argv[1]))
-			opt_dump_blocks = 1;
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
-	if (opt_dump_blocks)
-		err = reftable_reader_print_blocks(arg);
-
-	if (err < 0) {
-		fprintf(stderr, "%s: %s: %s\n", argv0, arg,
-			reftable_error_str(err));
-		return 1;
-	}
-	return 0;
-}
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 9d378427da..cf93d30910 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -1,4 +1,6 @@
 #include "reftable/system.h"
+#include "reftable/reftable-error.h"
+#include "reftable/reftable-reader.h"
 #include "reftable/reftable-tests.h"
 #include "test-tool.h"
 
@@ -13,7 +15,50 @@ int cmd__reftable(int argc, const char **argv)
 	return 0;
 }
 
+static void print_help(void)
+{
+	printf("usage: dump [-cst] arg\n\n"
+	       "options: \n"
+	       "  -c compact\n"
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
+	const char *arg = NULL, *argv0 = argv[0];
+
+	for (; argc > 1; argv++, argc--)
+		if (*argv[1] != '-')
+			break;
+		else if (!strcmp("-b", argv[1]))
+			opt_dump_blocks = 1;
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
+	if (opt_dump_blocks)
+		err = reftable_reader_print_blocks(arg);
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

