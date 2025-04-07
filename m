Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A982925484D
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031802; cv=none; b=i2ioSsEhrpO02G4+hcE29UycukrCD7NJwUzC1kZ+qUzATvvp/+R/J/tBTL7GgLDYhH346DXq16J4wVs4eV6DJPqHvwJXBBad0LVZjWq1MfASIqGr3nID4zvw2DU6xHB2jToHk7lrk+n2x93i0scWCWRTOTK0NV8VscH444lM9R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031802; c=relaxed/simple;
	bh=bzCWlFd2s/LUmF7lBtVwOJGAJJCMnFYDfj4EAZkvquA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i2s9Ab4ymGyoJC66JEWn9onQ2SFStiHnrJeenbWz/Xb6piSrF59QCINj7wM8U/0FVvOJk92Z5zAyEDuRaud7knx8FJPf/Bzv/JutnK+77Rnx8JqmtZsVAKaA/dL9nutyD0yfegE4Nq92b6C6iak4WTPxwWfM7pCNda9CoZnif38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KysmMecE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eHgD7ug+; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KysmMecE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eHgD7ug+"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA5F71140211;
	Mon,  7 Apr 2025 09:16:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 07 Apr 2025 09:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744031799;
	 x=1744118199; bh=4n/cd+DqreR51D681/y80p4utDzYHkLdUoq2LwrHbQs=; b=
	KysmMecExUTKyXQW6Sb/B3ySIaVVv+W9oqO2+M6HDofsYM831UtRicmR0yoPcscG
	qhpS1/q3ninTY6A8jtl5/YCskV9FzsTG9kpcW67JBC7L9dJRYQzc/4kwEilBGsYA
	WD0jn5yWsTmpGbdOhUQ9gZWwuPmfotlR5COzF0YtM620VjjXLEXyIZzcbGzoLSNu
	miymL0cA35pbUMO70gS86PZ/QoybP1gLPpa3I+OXxHE9v3FJF3WOwzlnO4J128yY
	L5YpkxrxZSWOze1loihl32DHOFLoV3NKIdbwU9M46HDEHtyXI4KfcfOf2oTTSMY1
	qf+DwuJUwh/AqYiSDIgHww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744031799; x=
	1744118199; bh=4n/cd+DqreR51D681/y80p4utDzYHkLdUoq2LwrHbQs=; b=e
	HgD7ug+oyRT4g1ra5qYgiVdMHscYfkB4T7rQhXpPfBE0NZ8dY/riYbSr3uj2OYTZ
	XH4LRe0i4D+/6tetpkSq5CtMmQNlwK5+ALSK0LVSmQwdotIUtPy2eICojZ3/69jl
	YbT/ujc8DNsuF0hIRgyp8EnukVpVk4Z2TquwGdkJExhkXnesz/bdL1Ty3WvKaLCZ
	En5/e0B1mPwhJzJErrSxpRJY4QIygIzgyAfcUEKNI/isKcTXGdfmG6Xps/LrBKKN
	VIsCr3i4mGkjqMk95wOvCwJFC3jbPzKETlIeAyvUeTOH750bPZJYeZ2a3YYI3m3B
	om2uBqJ51YKYALi7LW3Dg==
X-ME-Sender: <xms:N9DzZ2IwjC2VOAJkdXgfWXFXfcKw_yxmjLDFa6ijndUDfmr3QpGutw>
    <xme:N9DzZ-LBdjZdfFvzBOy_rHA4NVGRV0HGnn6_SUGCcAodYILRRxDD83ZdOQ4epzE-k
    QRjiksALjOs0jHwRA>
X-ME-Received: <xmr:N9DzZ2vxeZKmgQsTUMm0XuprukyxxThbRAgjuZ4YI_87cTaAaOt9Qo9vXZ981q-Mr7sK3ukLl4DKTSuPhGmNRHPU2_se2rv18tvjpuB8HH1kNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:N9DzZ7ZYWYr8au0i7JS1fX0ewB7G6JxfAkEIIzTJkt0CqKgzVC6TQw>
    <xmx:N9DzZ9YNygWhCcVSFDPA0s2hGfiutRwFrF3xk4Mh8wBGgGAlb0aWzA>
    <xmx:N9DzZ3DEpNUaGxv-F_LfyxihaOHB99anyBgJHP8UyjXWI2WXDTxjiw>
    <xmx:N9DzZzbVganDkeN3Knf5w8zFcmPvHHCfgGySJcbw0rDVhgAdcqPb9Q>
    <xmx:N9DzZ-klXoKDUt91PdeVL8MyrULYT116Ta4dGzFYbpwjxhzKfSjBykD6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 09:16:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b7e6cf39 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 13:16:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Apr 2025 15:16:28 +0200
Subject: [PATCH v2 16/16] reftable/table: move printing logic into test
 helper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-pks-reftable-polishing-v2-16-316c4ff10571@pks.im>
References: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
In-Reply-To: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
index 4d61ce6cf77..5f935d02e3b 100644
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
index 1af39423224..ee831276158 100644
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
 int reftable_table_iterator_init(struct reftable_table_iterator *it,
 				 struct reftable_table *t)
 {
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index f8f1956f4f3..b16c0722c84 100644
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
+	err = reftable_table_iterator_init(&ti, table);
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

