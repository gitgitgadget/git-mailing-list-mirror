Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B741D7E57
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410488; cv=none; b=oyVvXi/0ZBuECv1XJQRkv4y0XXlY7tTRJ29iSb6EZ2+Na9VyFjCIkzs6oy5xLXop2IujPUKkflm+yWSgxR4MBSqHAMNH51JpwcTg9k5tcdyIG3HrDiCXpwEUZjaQcuMrfHz66DMLbPTX6Nh5ng73sRMC9BKT70qexinaF21tIVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410488; c=relaxed/simple;
	bh=wkYSel6L9yDN/33WiGeQXqO7Xhw56pNgmyEftp9rQJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r3JHwNYzZ0OHth9NqibzWovOCS5RAnRoV4chUhJvA/lW+6g+lGD+wt6p1XpoqoKczmILEfpPzUWSyvbTjNqlbUP/N7zh5WV9Q/sR56h1i/28u++y6m9Esc7JE/K/Mym/LBGp+I7DqQ4nePU//C1noEMpChnpJUz6P9lfr2AdA14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ByuumsYs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a6n8rNyC; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ByuumsYs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a6n8rNyC"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B6EA1382D37
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 31 Mar 2025 04:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743410485;
	 x=1743496885; bh=T1xrQEvCmA3pvSu+/Dj7GAutcWCh7MZvFpACgM0P9II=; b=
	ByuumsYsl3d5h8aRdICe4xB5sInY1a7mHgR4VJ754yy3dXuYfMs1FXDdgAL3vOqt
	rle7KPXw2hgz4BGLUzyfze0KCHGYJwB3+oqRZWQZrvS6NrBInAso+nb/vPvcHtPh
	6+oSDq/JudzHW3DHwAAacNv9u347TRLfDJyAtRG3zEtgw8AwunN0OKKUVTXFj/r8
	THqL7I0nL1WrAm1VLCz4wgdeW3IGtjXMd4djNw8EOMkPDOtQBcoENySK0x0VQ4hc
	3Icx640bnKB6YnBW4zwzq37/ySM4iWx/srafCiQRyi4ki5M/I6tj59TAz7xDZ6dr
	O/cFIJZqM8xTdaGOxD+/cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743410485; x=
	1743496885; bh=T1xrQEvCmA3pvSu+/Dj7GAutcWCh7MZvFpACgM0P9II=; b=a
	6n8rNyCKP6GTayQ+HJxEtesMwbFfpayYHoEIDIndbhQCFGPmVTEG81l1JhZduJWJ
	zBFfQTCkJQCpGJO9w7eXVAdNedR5nTEn1o+LpkDXHRubT/i+eaM1glp6Wg9pqUhg
	Kdh2bUJzm8IJj7MyycyifI70bnq/t1qO9DW1YzFvM6iSe3QoGhWalB6812ZdC3Jz
	vTDTAgSxDcmbYfq9qJ0LT6t1mBQxnJ3ew1TfNoa7cdXv01JJ3ZUVP8TRDFQdmobQ
	vvSOoWyBb6TuFg2FdXAKwr0SM328Y5u0PfBT/B7RVVn3wJpWlwCwWul/LkRgFDGh
	YTQ/SDrQglGUmRWvW7ucA==
X-ME-Sender: <xms:NVXqZ1GXmW8oFJ25TPEnzg2Whld62K-bMfphFOluNbnUkosWD1-rGw>
    <xme:NVXqZ6VP-oYYF0GgHmWw60x5-ExF8igDXIiueDOomci2DwiPJcjia7ebS9B8q-tQP
    EvrhlHYScAShItpJA>
X-ME-Received: <xmr:NVXqZ3J_ntXqRBcXH9iTmZ8Rjlsq5VVwM1ET7jIzNixyqxNpBAaHj6VtC5fGzv7z69adEZNyLFX1_ijkRVmhEoxvt0a_542qK0zodZyWqufN4JKq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NVXqZ7Eb-PgnClbS_5Y7gQEas5ZsgcJbadhFMk65QAT2xxgcYNYRkw>
    <xmx:NVXqZ7WU9CuM_4qErR5B-nP_9AKivJtnp-6DWI-UAzK96nyFbjL1ew>
    <xmx:NVXqZ2OLgAKxoLSe-wLdFrnc2C2Gt2edJbr19ZloplJ14M-mxZwbqg>
    <xmx:NVXqZ63c11kdJETSt-6xBo8ugAzYSWIyjcGugcr_ZDzQdTNjzbVR5w>
    <xmx:NVXqZyeMGjxUOPzY8VreJINJQ4C0kMtx4cIFT5rwKebxKuf6VgMItaf_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 64fb993d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 31 Mar 2025 08:41:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Mar 2025 10:41:22 +0200
Subject: [PATCH 04/16] reftable/block: simplify how we track restart points
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-pks-reftable-polishing-v1-4-ebed5247434c@pks.im>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
In-Reply-To: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
To: git@vger.kernel.org
Cc: 
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

