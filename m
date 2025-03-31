Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4871DF269
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410499; cv=none; b=mLTN292KcAXo00SXnZymeM40zKeOZqbjX93liPH8J2AOA3l7MpKFVAZ59inUUyz3ImrRqwKvQGY6O8mvS0Z6bbbYUlafmhSIR5F0n5guUFUJh6oKqG1501X7O+HFCBeGvNWA3L0LCkzXgn5LwcZ33gziy2QuFk+bJlCy4e46JHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410499; c=relaxed/simple;
	bh=dJoFtTphK01ZORRXzYWS73OOp7yckFDkiFv9ds4C+wY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ESibSmATNkK5OAcXN1tuTvvQs1caB9BOYRx5WA3/8zhbcF+vWpRPbTnRAtidiobXLn8GkPXygF4pbj5YuiSh0EkXp8UMdKC8QjhipP8l140UT+yj9nifKiz+PgR9zDuXdatlWoxckhnv2VIVGX/8SpnCSnYFkJsJ3w9qYkCAx1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BpIwYU0p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HU0P3FO0; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BpIwYU0p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HU0P3FO0"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id DFFB41382D80
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 31 Mar 2025 04:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743410496;
	 x=1743496896; bh=rH6su4Nb6KFM29xpOoeYk+/rUYH+vvTAdXEIkczyeBs=; b=
	BpIwYU0pKEDPr65mJvc9tbjBVlJQg4ku1Xk0AcCfHdZ9Tgxl4PioR4gYwi9nLM58
	4QrvLmu7l6+R4EZsEfTfoLdINz8euIRfRjkSME/Ed9tRIgtO67V5topNCmk3PK6D
	7fARVjPqlz41Ix78PwtskkOFhvQY4IDT68tStV3yaSkYYxXgURIFaPMUx4INAbCX
	fuOskwBIR+usfQ37QYCAv0a2Y6VL+pfPTnGE7Kxvk7y80pdQJIHgzvpgi2sJUxjg
	COYTghUFHCGVrYUWWOFIsW7T1Fdmbfrsp6Ck2gLIJF929PeH5wsH36+eBUoaFOBD
	KcB7c+jIo1fgUn0yfP1SfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743410496; x=
	1743496896; bh=rH6su4Nb6KFM29xpOoeYk+/rUYH+vvTAdXEIkczyeBs=; b=H
	U0P3FO0KIv2HQunusxF3iiMrHpnRCt73pSJftC5pESfd7G6qQx5pH8MnHnzzS9jq
	9MxJMS/Gr+6HDsF2XCjHTxoKEaZhTcGPdqiAf7OJsbM4QpTEQ05oYylfLIZMpamg
	46zQm3Iiiqn17yKAdDiLevwheDqZsiMXJyeX7mXPeB2Z8DNHphCH1jd+XbHfqdfH
	9hiOTmzz3OVxENm6rPHbn3/tm0YWTl/WBgA4ZnibyAWP1JwIW8ATM/2rFJv497lW
	bgkxAOlmLfR7ZzS/HSbCUwR6DOgZbjLg+py5C0NvsMQhBfOLlN7XK+UZdJRB94Cr
	SJezNzrPZGN5lip6zysbQ==
X-ME-Sender: <xms:QFXqZ_ak3nJh2KoYHBGSm9KlUAIJMlwqgj_XxLhuIaR5B3haMeFSXQ>
    <xme:QFXqZ-Zcv5_3-Kw6gzk6mHqZgy5kTD58xVc2D7qkt_48T43oRJRADrPQUByfQA1f1
    bC3AOFtvZFvc6kQLQ>
X-ME-Received: <xmr:QFXqZx-KWQGrNJxBtgoa2nFlUp1VOb54pJXr_bACt8cy7I2FV4vCjlNFDSYgMNjr2wE7lPRd73DBberuml0F8ukr_E3lyt29Yd7JNnL5DgPU4gXO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QFXqZ1oVr4DF-v3eDNAa5ACGSH8dPN55iUpg3PkxXNK9GwslJnAiTg>
    <xmx:QFXqZ6q39g7ztJSfDP8qLgyxf9P6OeOVkSr2Ly9zljIjgcnZuQukbA>
    <xmx:QFXqZ7SLrUWhU7OgWy2ENDPw0N9h5liChRxVW24SgJyzDgQ_iuvg-Q>
    <xmx:QFXqZyrF9epeYoDUnTKrV7B5T6vThkNHwWXnq2p0dQ_p9mnQr3IIGg>
    <xmx:QFXqZ_CxLWxxemzh0J0vezlK53lBEssiEa_lzbvFkSkA-vAUOJqF7hDZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 08bd77fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 31 Mar 2025 08:41:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Mar 2025 10:41:34 +0200
Subject: [PATCH 16/16] reftable/table: move printing logic into test helper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-pks-reftable-polishing-v1-16-ebed5247434c@pks.im>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
In-Reply-To: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The logic to print individual blocks in a table is hosted in the
reftable library. This is only the case due to historical reasons though
because users of the library had no interfaces to read blocks one by
one. Otherwise, printing individual blocks has no place in the reftable
library given that the format will not be generic in the first place.

We have now grown a public interface to iterate through blocks contained
in a table, and thus we can finally move the logic to print them into
the test helper.

Move over the logic and refactor it accordingly. Note that the iterator
also trivially allows us to access index sections, which we previously
didn't print at all. This omission wasn't intentional though, so start
dumping those sections as well so that we can assert that indices are
written as expected.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-table.h         |  3 --
 reftable/table.c                  | 65 ------------------------------------
 t/helper/test-reftable.c          | 69 ++++++++++++++++++++++++++++++++++++++-
 t/t0613-reftable-write-options.sh |  9 +++++
 4 files changed, 77 insertions(+), 69 deletions(-)

diff --git a/reftable/reftable-table.h b/reftable/reftable-table.h
index f0f1784c664..293fffbddc6 100644
--- a/reftable/reftable-table.h
+++ b/reftable/reftable-table.h
@@ -97,9 +97,6 @@ uint64_t reftable_table_max_update_index(struct reftable_table *t);
 /* return the min_update_index for a table */
 uint64_t reftable_table_min_update_index(struct reftable_table *t);
 
-/* print blocks onto stdout for debugging. */
-int reftable_table_print_blocks(const char *tablename);
-
 /*
  * An iterator that iterates through the blocks contained in a given table.
  */
diff --git a/reftable/table.c b/reftable/table.c
index 48f0cdfd42b..8a7581b9800 100644
--- a/reftable/table.c
+++ b/reftable/table.c
@@ -740,71 +740,6 @@ uint64_t reftable_table_min_update_index(struct reftable_table *t)
 	return t->min_update_index;
 }
 
-int reftable_table_print_blocks(const char *tablename)
-{
-	struct {
-		const char *name;
-		int type;
-	} sections[] = {
-		{
-			.name = "ref",
-			.type = REFTABLE_BLOCK_TYPE_REF,
-		},
-		{
-			.name = "obj",
-			.type = REFTABLE_BLOCK_TYPE_OBJ,
-		},
-		{
-			.name = "log",
-			.type = REFTABLE_BLOCK_TYPE_LOG,
-		},
-	};
-	struct reftable_block_source src = { 0 };
-	struct reftable_table *table = NULL;
-	struct table_iter ti = { 0 };
-	size_t i;
-	int err;
-
-	err = reftable_block_source_from_file(&src, tablename);
-	if (err < 0)
-		goto done;
-
-	err = reftable_table_new(&table, &src, tablename);
-	if (err < 0)
-		goto done;
-
-	table_iter_init(&ti, table);
-
-	printf("header:\n");
-	printf("  block_size: %d\n", table->block_size);
-
-	for (i = 0; i < sizeof(sections) / sizeof(*sections); i++) {
-		err = table_iter_seek_start(&ti, sections[i].type, 0);
-		if (err < 0)
-			goto done;
-		if (err > 0)
-			continue;
-
-		printf("%s:\n", sections[i].name);
-
-		while (1) {
-			printf("  - length: %u\n", ti.block.restart_off);
-			printf("    restarts: %u\n", ti.block.restart_count);
-
-			err = table_iter_next_block(&ti);
-			if (err < 0)
-				goto done;
-			if (err > 0)
-				break;
-		}
-	}
-
-done:
-	reftable_table_decref(table);
-	table_iter_close(&ti);
-	return err;
-}
-
 int reftable_table_init_table_iterator(struct reftable_table *t,
 				       struct reftable_table_iterator *it)
 {
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index f8f1956f4f3..c465137826c 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -2,6 +2,7 @@
 #include "hash.h"
 #include "hex.h"
 #include "reftable/system.h"
+#include "reftable/reftable-constants.h"
 #include "reftable/reftable-error.h"
 #include "reftable/reftable-merged.h"
 #include "reftable/reftable-stack.h"
@@ -20,6 +21,72 @@ static void print_help(void)
 	       "\n");
 }
 
+static int dump_blocks(const char *tablename)
+{
+	struct reftable_table_iterator ti = { 0 };
+	struct reftable_block_source src = { 0 };
+	struct reftable_table *table = NULL;
+	uint8_t section_type = 0;
+	int err;
+
+	err = reftable_block_source_from_file(&src, tablename);
+	if (err < 0)
+		goto done;
+
+	err = reftable_table_new(&table, &src, tablename);
+	if (err < 0)
+		goto done;
+
+	err = reftable_table_init_table_iterator(table, &ti);
+	if (err < 0)
+		goto done;
+
+	printf("header:\n");
+	printf("  block_size: %d\n", table->block_size);
+
+	while (1) {
+		const struct reftable_block *block;
+
+		err = reftable_table_iterator_next(&ti, &block);
+		if (err < 0)
+			goto done;
+		if (err > 0)
+			break;
+
+		if (block->block_type != section_type) {
+			const char *section;
+			switch (block->block_type) {
+			case REFTABLE_BLOCK_TYPE_LOG:
+				section = "log";
+				break;
+			case REFTABLE_BLOCK_TYPE_REF:
+				section = "ref";
+				break;
+			case REFTABLE_BLOCK_TYPE_OBJ:
+				section = "obj";
+				break;
+			case REFTABLE_BLOCK_TYPE_INDEX:
+				section = "idx";
+				break;
+			default:
+				err = -1;
+				goto done;
+			}
+
+			section_type = block->block_type;
+			printf("%s:\n", section);
+		}
+
+		printf("  - length: %u\n", block->restart_off);
+		printf("    restarts: %u\n", block->restart_count);
+	}
+
+done:
+	reftable_table_iterator_release(&ti);
+	reftable_table_decref(table);
+	return err;
+}
+
 static int dump_table(struct reftable_merged_table *mt)
 {
 	struct reftable_iterator it = { NULL };
@@ -184,7 +251,7 @@ int cmd__dump_reftable(int argc, const char **argv)
 	arg = argv[1];
 
 	if (opt_dump_blocks) {
-		err = reftable_table_print_blocks(arg);
+		err = dump_blocks(arg);
 	} else if (opt_dump_table) {
 		err = dump_reftable(arg);
 	} else if (opt_dump_stack) {
diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
index e2708e11d5b..e4c7461ce9e 100755
--- a/t/t0613-reftable-write-options.sh
+++ b/t/t0613-reftable-write-options.sh
@@ -93,6 +93,9 @@ test_expect_success 'many refs results in multiple blocks' '
 		    restarts: 3
 		  - length: 3289
 		    restarts: 3
+		idx:
+		  - length: 103
+		    restarts: 1
 		EOF
 		test-tool dump-reftable -b .git/reftable/*.ref >actual &&
 		test_cmp expect actual
@@ -241,6 +244,9 @@ test_expect_success 'object index gets written by default with ref index' '
 		    restarts: 1
 		  - length: 80
 		    restarts: 1
+		idx:
+		  - length: 55
+		    restarts: 2
 		obj:
 		  - length: 11
 		    restarts: 1
@@ -277,6 +283,9 @@ test_expect_success 'object index can be disabled' '
 		    restarts: 1
 		  - length: 80
 		    restarts: 1
+		idx:
+		  - length: 55
+		    restarts: 2
 		EOF
 		test-tool dump-reftable -b .git/reftable/*.ref >actual &&
 		test_cmp expect actual

-- 
2.49.0.604.gff1f9ca942.dirty

