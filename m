Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A443253B70
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031789; cv=none; b=K5tHSAI9d9/q0bBVV/A1/dMcQbkU9TUMgieRpo7v/8TDHmR3qNXL71Un+zysCJliVm9BVTRt3ExCm5wW7fX1akgMPVBOXx36TM99hWTh5aSm9PpweiY1tdq1se7y9/dtF79t67VXBlErqib83P5bppqPsxyh5/mm0z2IvPzfO2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031789; c=relaxed/simple;
	bh=wkYSel6L9yDN/33WiGeQXqO7Xhw56pNgmyEftp9rQJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o8y9ACrmQ39/uoP9pXspAQ8bYBgvErTqO0MoEre72+n0YzH23XEIBMFseyXeZ11f4h5d0vmxXt+8n974jbgciBCZhfMQRe+Gzr8jRkxVNWMrSJvKiqzLzPTsf2Q1TxWK7HrRqxpv3Ij7P9VlnwxnvuzwK94wLe1I1irWcadUxkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AjBI2Bdo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bbWUrkxE; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AjBI2Bdo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bbWUrkxE"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 86EC71380355;
	Mon,  7 Apr 2025 09:16:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 07 Apr 2025 09:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744031786;
	 x=1744118186; bh=T1xrQEvCmA3pvSu+/Dj7GAutcWCh7MZvFpACgM0P9II=; b=
	AjBI2Bdoi1Xff4jF+xmGgPxxClfk8VEOIZj2MKCF53wqarkEWvXok2JiltdlLdFe
	UpIIuqoAiEfIfYpKSO86+wI/l9qQuMgqX9Ei3i/h1veQzGP1I5ZOHBtOmAibivMw
	FPy8xU8Zv91+Bg2dYaJGhgdLncrwycRqTiA8XJIbFQZjFoagBPXJb6XHsfuLW59a
	GFKWzMsIyplECDi41sA3PT8CkZXeflkUkueY/UKbqVYPzus11Y7T1S8vt+9Am17t
	k/pIr2Zgf9/+jS4eqhnhx6NND0ZA1opY96umaU6mYj6IZ4ued9x77UKcs1emfJjD
	IYVuNgvP4Z+YumAj8HlvpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744031786; x=
	1744118186; bh=T1xrQEvCmA3pvSu+/Dj7GAutcWCh7MZvFpACgM0P9II=; b=b
	bWUrkxEBf2G26f6V9WiJEiYxYNDAFFG5idxHTqwRHVrdESGpqvIqArqnx/z2kvJJ
	5tn2FptO5NoiELU/w8amRGk5E6tKdNsga1cqacyFO+jkmA7Cw6D4ZLJ5LgpZZ5Ah
	k0swEPyULhQmAG5a2IRrpy/eEzt6bR7dXY2Tfma4fOrnavLl5tyi/EKJRLbagQQL
	U0n5F3ns4GFH0P0VCBHn69NU7i4J5Q5dZy/ZYdjxkzWG6dkErJ7thSls10VA0bve
	jREMbsHu4XKFsJSjJnG+WA8+A2zdaCtA6NMvox93JyM0VZGSZfQsqhg1jGP8DuRm
	sh10u4m0TJcEfAEQ1pm0Q==
X-ME-Sender: <xms:KtDzZ71VgaAwvC_dV8vZyZCWetDUhQD2yhUSWX2ZRdIrtRQUS-UIlA>
    <xme:KtDzZ6FrS8IOs4lq_Q5o-F0yVjE8b54bSn3y9tJqUfgeCXf0nzKieSA8uvw35syst
    y0Xc6JltDsq9TDsqQ>
X-ME-Received: <xmr:KtDzZ77Rm0raPed46MTjwHeWI9JebtYsmQa4tYSTPDDlK9sZiBnyM2SEKNM8lc9JS6ochGvtzG76t9WGkiHzleOH8VqnyrZNG2f0e8UBvAA6Rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KtDzZw1u1CYwxQ89wlFqFkmv9s8nfk28R9ebQZWQ4ITK7Ec6Mm3Chg>
    <xmx:KtDzZ-FNklm8xqWQcWKFcM2gFvcAkFHSxSrpiqK-SY4CYog629w37g>
    <xmx:KtDzZx_rlf8YNOIrV4N-O-E-yRWJ-3terVjivS7dD3YM1OUV7ngzxg>
    <xmx:KtDzZ7mHRJn8RmHIfZ__C8mg4lvRfKPAiO02jKneDEeeIdMr4TZoYg>
    <xmx:KtDzZ_yLSSmoePJi-IJJBqNX5e-FBOdKu6qpSqeVPi9u5ouKdl8zFE13>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 09:16:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1752124a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 13:16:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Apr 2025 15:16:16 +0200
Subject: [PATCH v2 04/16] reftable/block: simplify how we track restart
 points
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-pks-reftable-polishing-v2-4-316c4ff10571@pks.im>
References: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
In-Reply-To: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Restart points record the location of reftable records that do not use
prefix compression and are used to perform a binary search inside of a
block. These restart points are encoded at the end of a block, between
the record data and the footer of a table.

The block structure contains three different variables related to these
restart points:

  - The block length contains the length of the reftable block up to the
    restart points.

  - The restart count contains the number of restart points contained in
    the block.

  - The restart bytes variable tracks where the restart point data
    begins.

Tracking all three of these variables is unnecessary though as the data
can be derived from one another: the block length without restart points
is the exact same as the offset of the restart count data, which we
already track via the `restart_bytes` data.

Refactor the code so that we track the location of restart bytes not as
a pointer, but instead as an offset. This allows us to trivially get rid
of the `block_len` variable as described above. This avoids having the
confusing `block_len` variable and allows us to do less bookkeeping
overall.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 25 ++++++++++++-------------
 reftable/block.h |  8 +++++---
 reftable/table.c |  2 +-
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 97740187259..f2567a8f0fd 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -216,10 +216,9 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 	uint32_t full_block_size = table_block_size;
 	uint8_t typ = block->data[header_off];
 	uint32_t sz = reftable_get_be24(block->data + header_off + 1);
-	int err = 0;
-	uint16_t restart_count = 0;
-	uint32_t restart_start = 0;
-	uint8_t *restart_bytes = NULL;
+	uint16_t restart_count;
+	uint32_t restart_off;
+	int err;
 
 	block_source_return_block(&br->block);
 
@@ -300,8 +299,7 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 	}
 
 	restart_count = reftable_get_be16(block->data + sz - 2);
-	restart_start = sz - 2 - 3 * restart_count;
-	restart_bytes = block->data + restart_start;
+	restart_off = sz - 2 - 3 * restart_count;
 
 	/* transfer ownership. */
 	br->block = *block;
@@ -309,11 +307,12 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 	block->len = 0;
 
 	br->hash_size = hash_size;
-	br->block_len = restart_start;
+	br->restart_off = restart_off;
 	br->full_block_size = full_block_size;
 	br->header_off = header_off;
 	br->restart_count = restart_count;
-	br->restart_bytes = restart_bytes;
+
+	err = 0;
 
 done:
 	return err;
@@ -337,7 +336,7 @@ int block_reader_first_key(const struct block_reader *br, struct reftable_buf *k
 	int off = br->header_off + 4, n;
 	struct string_view in = {
 		.buf = br->block.data + off,
-		.len = br->block_len - off,
+		.len = br->restart_off - off,
 	};
 	uint8_t extra = 0;
 
@@ -354,13 +353,13 @@ int block_reader_first_key(const struct block_reader *br, struct reftable_buf *k
 
 static uint32_t block_reader_restart_offset(const struct block_reader *br, size_t idx)
 {
-	return reftable_get_be24(br->restart_bytes + 3 * idx);
+	return reftable_get_be24(br->block.data + br->restart_off + 3 * idx);
 }
 
 void block_iter_seek_start(struct block_iter *it, const struct block_reader *br)
 {
 	it->block = br->block.data;
-	it->block_len = br->block_len;
+	it->block_len = br->restart_off;
 	it->hash_size = br->hash_size;
 	reftable_buf_reset(&it->last_key);
 	it->next_off = br->header_off + 4;
@@ -378,7 +377,7 @@ static int restart_needle_less(size_t idx, void *_args)
 	uint32_t off = block_reader_restart_offset(args->reader, idx);
 	struct string_view in = {
 		.buf = args->reader->block.data + off,
-		.len = args->reader->block_len - off,
+		.len = args->reader->restart_off - off,
 	};
 	uint64_t prefix_len, suffix_len;
 	uint8_t extra;
@@ -505,7 +504,7 @@ int block_iter_seek_key(struct block_iter *it, const struct block_reader *br,
 	else
 		it->next_off = br->header_off + 4;
 	it->block = br->block.data;
-	it->block_len = br->block_len;
+	it->block_len = br->restart_off;
 	it->hash_size = br->hash_size;
 
 	err = reftable_record_init(&rec, block_reader_type(br));
diff --git a/reftable/block.h b/reftable/block.h
index 203b07d9a44..b78f322e646 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -79,10 +79,12 @@ struct block_reader {
 	unsigned char *uncompressed_data;
 	size_t uncompressed_cap;
 
-	/* size of the data, excluding restart data. */
-	uint32_t block_len;
-	uint8_t *restart_bytes;
+	/*
+	 * Restart point data. Restart points are located after the block's
+	 * record data.
+	 */
 	uint16_t restart_count;
+	uint32_t restart_off;
 
 	/* size of the data in the file. For log blocks, this is the compressed
 	 * size. */
diff --git a/reftable/table.c b/reftable/table.c
index d18e17b0d44..ec84545707c 100644
--- a/reftable/table.c
+++ b/reftable/table.c
@@ -838,7 +838,7 @@ int reftable_table_print_blocks(const char *tablename)
 		printf("%s:\n", sections[i].name);
 
 		while (1) {
-			printf("  - length: %u\n", ti.br.block_len);
+			printf("  - length: %u\n", ti.br.restart_off);
 			printf("    restarts: %u\n", ti.br.restart_count);
 
 			err = table_iter_next_block(&ti);

-- 
2.49.0.604.gff1f9ca942.dirty

