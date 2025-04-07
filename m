Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE08253F35
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031792; cv=none; b=GnbNGRzMhYZ1jcFw68QvW3ymeuV8ku/cGbNbWV+OMVHe/MVmycO2FB6NL01QCiZgxrL3n2vCn/yenB6VS/TNDhRpuUERnlPJNeyTIkYz5CQTSqPzVdAifD8IxOGgh81FFiWTzmXTGVmLRXvhq43XrxfMoBNOVYL5VlJCUCJWZ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031792; c=relaxed/simple;
	bh=CcmhgODBIe4wvYGMs84xTIC8Si2zeuB7pcKy/yggzcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f8uyyWk2Q2ibUyWoCKscHbAfGo/D0qG7kL7h6apaE0/ZdgY3mS8xJsanlhJN+JwC0KCD8pIhzrc2pVZBp92j7u55YT5RM/lay3h38Th5yoHpGWqfgGJBBvsHURjpMHz6gMjDEoXbfzh+ny+7Eljuf3/z0MyyDBZRmQcWlPmLSoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oCNkAqeU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NHh0yn2s; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oCNkAqeU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NHh0yn2s"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id B45121380228;
	Mon,  7 Apr 2025 09:16:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 07 Apr 2025 09:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744031788;
	 x=1744118188; bh=ILCfUbydOmeaODO47s+MHhpLAbhJRXBGoWr6DpnHIhM=; b=
	oCNkAqeUNa/fj6K2B1gR+1MCRRKO62Gci/dtYN+omAHoQD4R1ir4ynzPNu5HMuqm
	4yCI51us2JCDIM/FlM5XWSBhNbo6EWa6ILfQfzIjRYNvvFDswKOAHIWlAzlKOgI0
	JZZmEeGM0jTMR2Iny96Iwa7eJiVjUh4G17z8jk6tJO8WV/CWYZvxHLv2p8X3xt7w
	4EoG1PX0gvdgra6c5pNOC8PteU41IoT33+x/bWEIpTt75QXAAWjGSdZP+KCovsUE
	uANgWyvpg5njtLV+VeDFIXKR2g5oYwd8TwHOYCh5a6a6l7DUCwLcVSeoYGnPRqHN
	M3MuxWramGY3+Y1GmjFf9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744031788; x=
	1744118188; bh=ILCfUbydOmeaODO47s+MHhpLAbhJRXBGoWr6DpnHIhM=; b=N
	Hh0yn2s7wk3L3/2iIdJfh9+ZK5L8UdzErZjAO2neY25ZARVvVCmT1y8ncMKNoqbh
	jvwUttMFVCWLvOtm+WAJ9zcOc4lOcYAjaIqmPz77DwDtaJcbzzdk67No0P50/+3v
	EsFCBVI93pTrdXzk4gDAn9etkRPgdz3bWpP6Djs9PjWMjFL4w9ZswEppmZCER40J
	yjm+BRs4MLAldbIHKNw8A8i1QKOXXFmK03YMg2gGBbjFYf4f75lLZTELLBriJy1a
	53fpGPFlC8m/udl0hqpVfB1Kj7Jj+fyCD3pnfPo3UpOZtLWqzO64IfU24Qf2RL8L
	45/SMdzYN6XSlQ6BSzLlg==
X-ME-Sender: <xms:LNDzZ8i2hZ9fWnnnTsVTiMAfzpH2DhmX43ECs1WqjysZzat-BOLQdg>
    <xme:LNDzZ1CffEbi8nN2BOw53KtDy8R3AwCcs8aOIDBP2exYSS34TTQoRWPv28ezgXvvG
    KdcmiqedGqEngP26g>
X-ME-Received: <xmr:LNDzZ0ENUi-LioW8UBY7CvLSvnfvtTQw6xtGSCCkcS2ZkiBVbZWkU690dvPZEqC6HN74FYKvzk2WVY54URDfNVU3Qbs93iXe6JdpmctDQQdBDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:LNDzZ9R2p7imJnfUmdl2FF4cbufZaq7PsG1tPWNQ4rpvVT7YcypeyA>
    <xmx:LNDzZ5zUw7PiRz2f0ZmvcmbRyNfn0V4NEbMct-jyEiibh90a82Bv-A>
    <xmx:LNDzZ75KHESaDtk0nlurbTbJ25e7s-NDTUozjWMaGIzIRUXWH4asnA>
    <xmx:LNDzZ2wY-Ijg6nMRxLj7Bdp0lU2eBpoiO3vGMG2oguNkrF5SYWoWlg>
    <xmx:LNDzZz8paSZJfo1R2ayjyzGuKEzyFUJlE8Q5Cb3eAB4v72Ln_h-Hcm-5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 09:16:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b37429bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 13:16:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Apr 2025 15:16:19 +0200
Subject: [PATCH v2 07/16] reftable/block: rename `block_reader` to
 `reftable_block`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-pks-reftable-polishing-v2-7-316c4ff10571@pks.im>
References: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
In-Reply-To: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The `block_reader` structure is used to access parsed data of a reftable
block. The structure is currently treated as an internal implementation
detail and not exposed via our public interfaces. The functionality
provided by the structure is useful to external users of the reftable
library though, for example when implementing consistency checks that
need to scan through the blocks manually.

Rename the structure to `reftable_block` now that the name has been made
available in the preceding commit. This name is in line with the naming
schema used for other data structures like `reftable_table` in that it
describes the underlying entity that it provides access to.

The new data structure isn't yet exposed via the public interface, which
is left for a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c                | 142 ++++++++++++++++++++--------------------
 reftable/block.h                |  29 ++++----
 reftable/iter.c                 |   9 ++-
 reftable/iter.h                 |   2 +-
 reftable/table.c                |  46 ++++++-------
 reftable/table.h                |   8 ++-
 t/unit-tests/t-reftable-block.c | 102 ++++++++++++++---------------
 7 files changed, 172 insertions(+), 166 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index dca30b8527f..844da397833 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -222,10 +222,10 @@ static int read_block(struct reftable_block_source *source,
 	return block_source_read_data(source, dest, off, sz);
 }
 
-int block_reader_init(struct block_reader *br,
-		      struct reftable_block_source *source,
-		      uint32_t offset, uint32_t header_size,
-		      uint32_t table_block_size, uint32_t hash_size)
+int reftable_block_init(struct reftable_block *block,
+			struct reftable_block_source *source,
+			uint32_t offset, uint32_t header_size,
+			uint32_t table_block_size, uint32_t hash_size)
 {
 	uint32_t guess_block_size = table_block_size ?
 		table_block_size : DEFAULT_BLOCK_SIZE;
@@ -236,19 +236,19 @@ int block_reader_init(struct block_reader *br,
 	uint8_t block_type;
 	int err;
 
-	err = read_block(source, &br->block_data, offset, guess_block_size);
+	err = read_block(source, &block->block_data, offset, guess_block_size);
 	if (err < 0)
 		goto done;
 
-	block_type = br->block_data.data[header_size];
+	block_type = block->block_data.data[header_size];
 	if (!reftable_is_block_type(block_type)) {
 		err = REFTABLE_FORMAT_ERROR;
 		goto done;
 	}
 
-	block_size = reftable_get_be24(br->block_data.data + header_size + 1);
+	block_size = reftable_get_be24(block->block_data.data + header_size + 1);
 	if (block_size > guess_block_size) {
-		err = read_block(source, &br->block_data, offset, block_size);
+		err = read_block(source, &block->block_data, offset, block_size);
 		if (err < 0)
 			goto done;
 	}
@@ -256,39 +256,39 @@ int block_reader_init(struct block_reader *br,
 	if (block_type == BLOCK_TYPE_LOG) {
 		uint32_t block_header_skip = 4 + header_size;
 		uLong dst_len = block_size - block_header_skip;
-		uLong src_len = br->block_data.len - block_header_skip;
+		uLong src_len = block->block_data.len - block_header_skip;
 
 		/* Log blocks specify the *uncompressed* size in their header. */
-		REFTABLE_ALLOC_GROW_OR_NULL(br->uncompressed_data, block_size,
-					    br->uncompressed_cap);
-		if (!br->uncompressed_data) {
+		REFTABLE_ALLOC_GROW_OR_NULL(block->uncompressed_data, block_size,
+					    block->uncompressed_cap);
+		if (!block->uncompressed_data) {
 			err = REFTABLE_OUT_OF_MEMORY_ERROR;
 			goto done;
 		}
 
 		/* Copy over the block header verbatim. It's not compressed. */
-		memcpy(br->uncompressed_data, br->block_data.data, block_header_skip);
+		memcpy(block->uncompressed_data, block->block_data.data, block_header_skip);
 
-		if (!br->zstream) {
-			REFTABLE_CALLOC_ARRAY(br->zstream, 1);
-			if (!br->zstream) {
+		if (!block->zstream) {
+			REFTABLE_CALLOC_ARRAY(block->zstream, 1);
+			if (!block->zstream) {
 				err = REFTABLE_OUT_OF_MEMORY_ERROR;
 				goto done;
 			}
 
-			err = inflateInit(br->zstream);
+			err = inflateInit(block->zstream);
 		} else {
-			err = inflateReset(br->zstream);
+			err = inflateReset(block->zstream);
 		}
 		if (err != Z_OK) {
 			err = REFTABLE_ZLIB_ERROR;
 			goto done;
 		}
 
-		br->zstream->next_in = br->block_data.data + block_header_skip;
-		br->zstream->avail_in = src_len;
-		br->zstream->next_out = br->uncompressed_data + block_header_skip;
-		br->zstream->avail_out = dst_len;
+		block->zstream->next_in = block->block_data.data + block_header_skip;
+		block->zstream->avail_in = src_len;
+		block->zstream->next_out = block->uncompressed_data + block_header_skip;
+		block->zstream->avail_out = dst_len;
 
 		/*
 		 * We know both input as well as output size, and we know that
@@ -297,71 +297,71 @@ int block_reader_init(struct block_reader *br,
 		 * here to instruct zlib to inflate the data in one go, which
 		 * is more efficient than using `Z_NO_FLUSH`.
 		 */
-		err = inflate(br->zstream, Z_FINISH);
+		err = inflate(block->zstream, Z_FINISH);
 		if (err != Z_STREAM_END) {
 			err = REFTABLE_ZLIB_ERROR;
 			goto done;
 		}
 		err = 0;
 
-		if (br->zstream->total_out + block_header_skip != block_size) {
+		if (block->zstream->total_out + block_header_skip != block_size) {
 			err = REFTABLE_FORMAT_ERROR;
 			goto done;
 		}
 
 		/* We're done with the input data. */
-		block_source_release_data(&br->block_data);
-		br->block_data.data = br->uncompressed_data;
-		br->block_data.len = block_size;
-		full_block_size = src_len + block_header_skip - br->zstream->avail_in;
+		block_source_release_data(&block->block_data);
+		block->block_data.data = block->uncompressed_data;
+		block->block_data.len = block_size;
+		full_block_size = src_len + block_header_skip - block->zstream->avail_in;
 	} else if (full_block_size == 0) {
 		full_block_size = block_size;
-	} else if (block_size < full_block_size && block_size < br->block_data.len &&
-		   br->block_data.data[block_size] != 0) {
+	} else if (block_size < full_block_size && block_size < block->block_data.len &&
+		   block->block_data.data[block_size] != 0) {
 		/* If the block is smaller than the full block size, it is
 		   padded (data followed by '\0') or the next block is
 		   unaligned. */
 		full_block_size = block_size;
 	}
 
-	restart_count = reftable_get_be16(br->block_data.data + block_size - 2);
+	restart_count = reftable_get_be16(block->block_data.data + block_size - 2);
 	restart_off = block_size - 2 - 3 * restart_count;
 
-	br->block_type = block_type;
-	br->hash_size = hash_size;
-	br->restart_off = restart_off;
-	br->full_block_size = full_block_size;
-	br->header_off = header_size;
-	br->restart_count = restart_count;
+	block->block_type = block_type;
+	block->hash_size = hash_size;
+	block->restart_off = restart_off;
+	block->full_block_size = full_block_size;
+	block->header_off = header_size;
+	block->restart_count = restart_count;
 
 	err = 0;
 
 done:
 	if (err < 0)
-		block_reader_release(br);
+		reftable_block_release(block);
 	return err;
 }
 
-void block_reader_release(struct block_reader *br)
+void reftable_block_release(struct reftable_block *block)
 {
-	inflateEnd(br->zstream);
-	reftable_free(br->zstream);
-	reftable_free(br->uncompressed_data);
-	block_source_release_data(&br->block_data);
-	memset(br, 0, sizeof(*br));
+	inflateEnd(block->zstream);
+	reftable_free(block->zstream);
+	reftable_free(block->uncompressed_data);
+	block_source_release_data(&block->block_data);
+	memset(block, 0, sizeof(*block));
 }
 
-uint8_t block_reader_type(const struct block_reader *r)
+uint8_t reftable_block_type(const struct reftable_block *b)
 {
-	return r->block_data.data[r->header_off];
+	return b->block_data.data[b->header_off];
 }
 
-int block_reader_first_key(const struct block_reader *br, struct reftable_buf *key)
+int reftable_block_first_key(const struct reftable_block *block, struct reftable_buf *key)
 {
-	int off = br->header_off + 4, n;
+	int off = block->header_off + 4, n;
 	struct string_view in = {
-		.buf = br->block_data.data + off,
-		.len = br->restart_off - off,
+		.buf = block->block_data.data + off,
+		.len = block->restart_off - off,
 	};
 	uint8_t extra = 0;
 
@@ -376,33 +376,33 @@ int block_reader_first_key(const struct block_reader *br, struct reftable_buf *k
 	return 0;
 }
 
-static uint32_t block_reader_restart_offset(const struct block_reader *br, size_t idx)
+static uint32_t block_restart_offset(const struct reftable_block *b, size_t idx)
 {
-	return reftable_get_be24(br->block_data.data + br->restart_off + 3 * idx);
+	return reftable_get_be24(b->block_data.data + b->restart_off + 3 * idx);
 }
 
-void block_iter_seek_start(struct block_iter *it, const struct block_reader *br)
+void block_iter_seek_start(struct block_iter *it, const struct reftable_block *b)
 {
-	it->block = br->block_data.data;
-	it->block_len = br->restart_off;
-	it->hash_size = br->hash_size;
+	it->block = b->block_data.data;
+	it->block_len = b->restart_off;
+	it->hash_size = b->hash_size;
 	reftable_buf_reset(&it->last_key);
-	it->next_off = br->header_off + 4;
+	it->next_off = b->header_off + 4;
 }
 
 struct restart_needle_less_args {
 	int error;
 	struct reftable_buf needle;
-	const struct block_reader *reader;
+	const struct reftable_block *block;
 };
 
 static int restart_needle_less(size_t idx, void *_args)
 {
 	struct restart_needle_less_args *args = _args;
-	uint32_t off = block_reader_restart_offset(args->reader, idx);
+	uint32_t off = block_restart_offset(args->block, idx);
 	struct string_view in = {
-		.buf = args->reader->block_data.data + off,
-		.len = args->reader->restart_off - off,
+		.buf = args->block->block_data.data + off,
+		.len = args->block->restart_off - off,
 	};
 	uint64_t prefix_len, suffix_len;
 	uint8_t extra;
@@ -477,12 +477,12 @@ void block_iter_close(struct block_iter *it)
 	reftable_buf_release(&it->scratch);
 }
 
-int block_iter_seek_key(struct block_iter *it, const struct block_reader *br,
+int block_iter_seek_key(struct block_iter *it, const struct reftable_block *block,
 			struct reftable_buf *want)
 {
 	struct restart_needle_less_args args = {
 		.needle = *want,
-		.reader = br,
+		.block = block,
 	};
 	struct reftable_record rec;
 	int err = 0;
@@ -500,7 +500,7 @@ int block_iter_seek_key(struct block_iter *it, const struct block_reader *br,
 	 * restart point. While that works alright, we would end up scanning
 	 * too many record.
 	 */
-	i = binsearch(br->restart_count, &restart_needle_less, &args);
+	i = binsearch(block->restart_count, &restart_needle_less, &args);
 	if (args.error) {
 		err = REFTABLE_FORMAT_ERROR;
 		goto done;
@@ -525,21 +525,21 @@ int block_iter_seek_key(struct block_iter *it, const struct block_reader *br,
 	 *     starting from the preceding restart point.
 	 */
 	if (i > 0)
-		it->next_off = block_reader_restart_offset(br, i - 1);
+		it->next_off = block_restart_offset(block, i - 1);
 	else
-		it->next_off = br->header_off + 4;
-	it->block = br->block_data.data;
-	it->block_len = br->restart_off;
-	it->hash_size = br->hash_size;
+		it->next_off = block->header_off + 4;
+	it->block = block->block_data.data;
+	it->block_len = block->restart_off;
+	it->hash_size = block->hash_size;
 
-	err = reftable_record_init(&rec, block_reader_type(br));
+	err = reftable_record_init(&rec, reftable_block_type(block));
 	if (err < 0)
 		goto done;
 
 	/*
 	 * We're looking for the last entry less than the wanted key so that
 	 * the next call to `block_reader_next()` would yield the wanted
-	 * record. We thus don't want to position our reader at the sought
+	 * record. We thus don't want to position our iterator at the sought
 	 * after record, but one before. To do so, we have to go one entry too
 	 * far and then back up.
 	 */
diff --git a/reftable/block.h b/reftable/block.h
index 948b79e4614..3957aee4293 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -64,8 +64,11 @@ void block_writer_release(struct block_writer *bw);
 
 struct z_stream;
 
-/* Read a block. */
-struct block_reader {
+/*
+ * A block part of a reftable. Contains records as well as some metadata
+ * describing them.
+ */
+struct reftable_block {
 	/* offset of the block header; nonzero for the first block in a
 	 * reftable. */
 	uint32_t header_off;
@@ -92,19 +95,21 @@ struct block_reader {
 	uint8_t block_type;
 };
 
-/* initializes a block reader. */
-int block_reader_init(struct block_reader *br,
-		      struct reftable_block_source *source,
-		      uint32_t offset, uint32_t header_size,
-		      uint32_t table_block_size, uint32_t hash_size);
+/*
+ * Initialize a reftable block from the given block source.
+ */
+int reftable_block_init(struct reftable_block *b,
+			struct reftable_block_source *source,
+			uint32_t offset, uint32_t header_size,
+			uint32_t table_block_size, uint32_t hash_size);
 
-void block_reader_release(struct block_reader *br);
+void reftable_block_release(struct reftable_block *b);
 
 /* Returns the block type (eg. 'r' for refs) */
-uint8_t block_reader_type(const struct block_reader *r);
+uint8_t reftable_block_type(const struct reftable_block *b);
 
 /* Decodes the first key in the block */
-int block_reader_first_key(const struct block_reader *br, struct reftable_buf *key);
+int reftable_block_first_key(const struct reftable_block *b, struct reftable_buf *key);
 
 /* Iterate over entries in a block */
 struct block_iter {
@@ -125,10 +130,10 @@ struct block_iter {
 }
 
 /* Position `it` at start of the block */
-void block_iter_seek_start(struct block_iter *it, const struct block_reader *br);
+void block_iter_seek_start(struct block_iter *it, const struct reftable_block *block);
 
 /* Position `it` to the `want` key in the block */
-int block_iter_seek_key(struct block_iter *it, const struct block_reader *br,
+int block_iter_seek_key(struct block_iter *it, const struct reftable_block *block,
 			struct reftable_buf *want);
 
 /* return < 0 for error, 0 for OK, > 0 for EOF. */
diff --git a/reftable/iter.c b/reftable/iter.c
index c00ffc88577..9ce675510c9 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -114,7 +114,7 @@ static void indexed_table_ref_iter_close(void *p)
 {
 	struct indexed_table_ref_iter *it = p;
 	block_iter_close(&it->cur);
-	block_source_release_data(&it->block_reader.block_data);
+	block_source_release_data(&it->block.block_data);
 	reftable_free(it->offsets);
 	reftable_buf_release(&it->oid);
 }
@@ -128,11 +128,10 @@ static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
 		return 1;
 	}
 
-	block_source_release_data(&it->block_reader.block_data);
+	block_source_release_data(&it->block.block_data);
 
 	off = it->offsets[it->offset_idx++];
-	err = table_init_block_reader(it->table, &it->block_reader, off,
-				      BLOCK_TYPE_REF);
+	err = table_init_block(it->table, &it->block, off, BLOCK_TYPE_REF);
 	if (err < 0) {
 		return err;
 	}
@@ -140,7 +139,7 @@ static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
 		/* indexed block does not exist. */
 		return REFTABLE_FORMAT_ERROR;
 	}
-	block_iter_seek_start(&it->cur, &it->block_reader);
+	block_iter_seek_start(&it->cur, &it->block);
 	return 0;
 }
 
diff --git a/reftable/iter.h b/reftable/iter.h
index add5c9472fc..cc920970a57 100644
--- a/reftable/iter.h
+++ b/reftable/iter.h
@@ -68,7 +68,7 @@ struct indexed_table_ref_iter {
 	/* Points to the next offset to read. */
 	int offset_idx;
 	int offset_len;
-	struct block_reader block_reader;
+	struct reftable_block block;
 	struct block_iter cur;
 	int is_finished;
 };
diff --git a/reftable/table.c b/reftable/table.c
index c86b1d4c649..ef1f33c92fc 100644
--- a/reftable/table.c
+++ b/reftable/table.c
@@ -131,7 +131,7 @@ struct table_iter {
 	struct reftable_table *table;
 	uint8_t typ;
 	uint64_t block_off;
-	struct block_reader br;
+	struct reftable_block block;
 	struct block_iter bi;
 	int is_finished;
 };
@@ -159,12 +159,12 @@ static int table_iter_next_in_block(struct table_iter *ti,
 
 static void table_iter_block_done(struct table_iter *ti)
 {
-	block_reader_release(&ti->br);
+	reftable_block_release(&ti->block);
 	block_iter_reset(&ti->bi);
 }
 
-int table_init_block_reader(struct reftable_table *t, struct block_reader *br,
-			    uint64_t next_off, uint8_t want_typ)
+int table_init_block(struct reftable_table *t, struct reftable_block *block,
+		     uint64_t next_off, uint8_t want_typ)
 {
 	uint32_t header_off = next_off ? 0 : header_size(t->version);
 	int err;
@@ -172,19 +172,19 @@ int table_init_block_reader(struct reftable_table *t, struct block_reader *br,
 	if (next_off >= t->size)
 		return 1;
 
-	err = block_reader_init(br, &t->source, next_off, header_off,
-				t->block_size, hash_size(t->hash_id));
+	err = reftable_block_init(block, &t->source, next_off, header_off,
+				  t->block_size, hash_size(t->hash_id));
 	if (err < 0)
 		goto done;
 
-	if (want_typ != BLOCK_TYPE_ANY && br->block_type != want_typ) {
+	if (want_typ != BLOCK_TYPE_ANY && block->block_type != want_typ) {
 		err = 1;
 		goto done;
 	}
 
 done:
 	if (err)
-		block_reader_release(br);
+		reftable_block_release(block);
 	return err;
 }
 
@@ -197,10 +197,10 @@ static void table_iter_close(struct table_iter *ti)
 
 static int table_iter_next_block(struct table_iter *ti)
 {
-	uint64_t next_block_off = ti->block_off + ti->br.full_block_size;
+	uint64_t next_block_off = ti->block_off + ti->block.full_block_size;
 	int err;
 
-	err = table_init_block_reader(ti->table, &ti->br, next_block_off, ti->typ);
+	err = table_init_block(ti->table, &ti->block, next_block_off, ti->typ);
 	if (err > 0)
 		ti->is_finished = 1;
 	if (err)
@@ -208,7 +208,7 @@ static int table_iter_next_block(struct table_iter *ti)
 
 	ti->block_off = next_block_off;
 	ti->is_finished = 0;
-	block_iter_seek_start(&ti->bi, &ti->br);
+	block_iter_seek_start(&ti->bi, &ti->block);
 
 	return 0;
 }
@@ -250,13 +250,13 @@ static int table_iter_seek_to(struct table_iter *ti, uint64_t off, uint8_t typ)
 {
 	int err;
 
-	err = table_init_block_reader(ti->table, &ti->br, off, typ);
+	err = table_init_block(ti->table, &ti->block, off, typ);
 	if (err != 0)
 		return err;
 
-	ti->typ = block_reader_type(&ti->br);
+	ti->typ = reftable_block_type(&ti->block);
 	ti->block_off = off;
-	block_iter_seek_start(&ti->bi, &ti->br);
+	block_iter_seek_start(&ti->bi, &ti->block);
 	ti->is_finished = 0;
 	return 0;
 }
@@ -320,10 +320,10 @@ static int table_iter_seek_linear(struct table_iter *ti,
 		 * as we have more than three blocks we would have an index, so
 		 * we would not do a linear search there anymore.
 		 */
-		memset(&next.br.block_data, 0, sizeof(next.br.block_data));
-		next.br.zstream = NULL;
-		next.br.uncompressed_data = NULL;
-		next.br.uncompressed_cap = 0;
+		memset(&next.block.block_data, 0, sizeof(next.block.block_data));
+		next.block.zstream = NULL;
+		next.block.uncompressed_data = NULL;
+		next.block.uncompressed_cap = 0;
 
 		err = table_iter_next_block(&next);
 		if (err < 0)
@@ -331,7 +331,7 @@ static int table_iter_seek_linear(struct table_iter *ti,
 		if (err > 0)
 			break;
 
-		err = block_reader_first_key(&next.br, &got_key);
+		err = reftable_block_first_key(&next.block, &got_key);
 		if (err < 0)
 			goto done;
 
@@ -349,7 +349,7 @@ static int table_iter_seek_linear(struct table_iter *ti,
 	 * the wanted key inside of it. If the block does not contain our key
 	 * we know that the corresponding record does not exist.
 	 */
-	err = block_iter_seek_key(&ti->bi, &ti->br, &want_key);
+	err = block_iter_seek_key(&ti->bi, &ti->block, &want_key);
 	if (err < 0)
 		goto done;
 	err = 0;
@@ -417,7 +417,7 @@ static int table_iter_seek_indexed(struct table_iter *ti,
 		if (err != 0)
 			goto done;
 
-		err = block_iter_seek_key(&ti->bi, &ti->br, &want_index.u.idx.last_key);
+		err = block_iter_seek_key(&ti->bi, &ti->block, &want_index.u.idx.last_key);
 		if (err < 0)
 			goto done;
 
@@ -785,8 +785,8 @@ int reftable_table_print_blocks(const char *tablename)
 		printf("%s:\n", sections[i].name);
 
 		while (1) {
-			printf("  - length: %u\n", ti.br.restart_off);
-			printf("    restarts: %u\n", ti.br.restart_count);
+			printf("  - length: %u\n", ti.block.restart_off);
+			printf("    restarts: %u\n", ti.block.restart_count);
 
 			err = table_iter_next_block(&ti);
 			if (err < 0)
diff --git a/reftable/table.h b/reftable/table.h
index 8d8dd2b413d..e15d58d8e9e 100644
--- a/reftable/table.h
+++ b/reftable/table.h
@@ -53,8 +53,10 @@ int table_init_iter(struct reftable_table *t,
 		    struct reftable_iterator *it,
 		    uint8_t typ);
 
-/* initialize a block reader to read from `t` */
-int table_init_block_reader(struct reftable_table *t, struct block_reader *br,
-			    uint64_t next_off, uint8_t want_typ);
+/*
+ * Initialize a block by reading from the given table and offset.
+ */
+int table_init_block(struct reftable_table *t, struct reftable_block *block,
+		     uint64_t next_off, uint8_t want_typ);
 
 #endif
diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index dbec6a5d0d0..e36ed7ac576 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -28,16 +28,16 @@ static void t_ref_block_read_write(void)
 	};
 	size_t i = 0;
 	int ret;
-	struct block_reader br = { 0 };
+	struct reftable_block block = { 0 };
 	struct block_iter it = BLOCK_ITER_INIT;
 	struct reftable_buf want = REFTABLE_BUF_INIT;
-	struct reftable_buf block = REFTABLE_BUF_INIT;
+	struct reftable_buf block_data = REFTABLE_BUF_INIT;
 
-	REFTABLE_CALLOC_ARRAY(block.buf, block_size);
-	check(block.buf != NULL);
-	block.len = block_size;
+	REFTABLE_CALLOC_ARRAY(block_data.buf, block_size);
+	check(block_data.buf != NULL);
+	block_data.len = block_size;
 
-	ret = block_writer_init(&bw, BLOCK_TYPE_REF, (uint8_t *) block.buf, block_size,
+	ret = block_writer_init(&bw, BLOCK_TYPE_REF, (uint8_t *) block_data.buf, block_size,
 				header_off, hash_size(REFTABLE_HASH_SHA1));
 	check(!ret);
 
@@ -63,10 +63,10 @@ static void t_ref_block_read_write(void)
 
 	block_writer_release(&bw);
 
-	block_source_from_buf(&source ,&block);
-	block_reader_init(&br, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
+	block_source_from_buf(&source ,&block_data);
+	reftable_block_init(&block, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
 
-	block_iter_seek_start(&it, &br);
+	block_iter_seek_start(&it, &block);
 
 	for (i = 0; ; i++) {
 		ret = block_iter_next(&it, &rec);
@@ -82,7 +82,7 @@ static void t_ref_block_read_write(void)
 		block_iter_reset(&it);
 		reftable_record_key(&recs[i], &want);
 
-		ret = block_iter_seek_key(&it, &br, &want);
+		ret = block_iter_seek_key(&it, &block, &want);
 		check_int(ret, ==, 0);
 
 		ret = block_iter_next(&it, &rec);
@@ -91,7 +91,7 @@ static void t_ref_block_read_write(void)
 		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
 
 		want.len--;
-		ret = block_iter_seek_key(&it, &br, &want);
+		ret = block_iter_seek_key(&it, &block, &want);
 		check_int(ret, ==, 0);
 
 		ret = block_iter_next(&it, &rec);
@@ -99,11 +99,11 @@ static void t_ref_block_read_write(void)
 		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, REFTABLE_HASH_SIZE_SHA1));
 	}
 
-	block_reader_release(&br);
+	reftable_block_release(&block);
 	block_iter_close(&it);
 	reftable_record_release(&rec);
 	reftable_buf_release(&want);
-	reftable_buf_release(&block);
+	reftable_buf_release(&block_data);
 	for (i = 0; i < N; i++)
 		reftable_record_release(&recs[i]);
 }
@@ -123,16 +123,16 @@ static void t_log_block_read_write(void)
 	};
 	size_t i = 0;
 	int ret;
-	struct block_reader br = { 0 };
+	struct reftable_block block = { 0 };
 	struct block_iter it = BLOCK_ITER_INIT;
 	struct reftable_buf want = REFTABLE_BUF_INIT;
-	struct reftable_buf block = REFTABLE_BUF_INIT;
+	struct reftable_buf block_data = REFTABLE_BUF_INIT;
 
-	REFTABLE_CALLOC_ARRAY(block.buf, block_size);
-	check(block.buf != NULL);
-	block.len = block_size;
+	REFTABLE_CALLOC_ARRAY(block_data.buf, block_size);
+	check(block_data.buf != NULL);
+	block_data.len = block_size;
 
-	ret = block_writer_init(&bw, BLOCK_TYPE_LOG, (uint8_t *) block.buf, block_size,
+	ret = block_writer_init(&bw, BLOCK_TYPE_LOG, (uint8_t *) block_data.buf, block_size,
 				header_off, hash_size(REFTABLE_HASH_SHA1));
 	check(!ret);
 
@@ -153,10 +153,10 @@ static void t_log_block_read_write(void)
 
 	block_writer_release(&bw);
 
-	block_source_from_buf(&source, &block);
-	block_reader_init(&br, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
+	block_source_from_buf(&source, &block_data);
+	reftable_block_init(&block, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
 
-	block_iter_seek_start(&it, &br);
+	block_iter_seek_start(&it, &block);
 
 	for (i = 0; ; i++) {
 		ret = block_iter_next(&it, &rec);
@@ -173,7 +173,7 @@ static void t_log_block_read_write(void)
 		reftable_buf_reset(&want);
 		check(!reftable_buf_addstr(&want, recs[i].u.log.refname));
 
-		ret = block_iter_seek_key(&it, &br, &want);
+		ret = block_iter_seek_key(&it, &block, &want);
 		check_int(ret, ==, 0);
 
 		ret = block_iter_next(&it, &rec);
@@ -182,7 +182,7 @@ static void t_log_block_read_write(void)
 		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
 
 		want.len--;
-		ret = block_iter_seek_key(&it, &br, &want);
+		ret = block_iter_seek_key(&it, &block, &want);
 		check_int(ret, ==, 0);
 
 		ret = block_iter_next(&it, &rec);
@@ -190,11 +190,11 @@ static void t_log_block_read_write(void)
 		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, REFTABLE_HASH_SIZE_SHA1));
 	}
 
-	block_reader_release(&br);
+	reftable_block_release(&block);
 	block_iter_close(&it);
 	reftable_record_release(&rec);
 	reftable_buf_release(&want);
-	reftable_buf_release(&block);
+	reftable_buf_release(&block_data);
 	for (i = 0; i < N; i++)
 		reftable_record_release(&recs[i]);
 }
@@ -214,16 +214,16 @@ static void t_obj_block_read_write(void)
 	};
 	size_t i = 0;
 	int ret;
-	struct block_reader br = { 0 };
+	struct reftable_block block = { 0 };
 	struct block_iter it = BLOCK_ITER_INIT;
 	struct reftable_buf want = REFTABLE_BUF_INIT;
-	struct reftable_buf block = REFTABLE_BUF_INIT;
+	struct reftable_buf block_data = REFTABLE_BUF_INIT;
 
-	REFTABLE_CALLOC_ARRAY(block.buf, block_size);
-	check(block.buf != NULL);
-	block.len = block_size;
+	REFTABLE_CALLOC_ARRAY(block_data.buf, block_size);
+	check(block_data.buf != NULL);
+	block_data.len = block_size;
 
-	ret = block_writer_init(&bw, BLOCK_TYPE_OBJ, (uint8_t *) block.buf, block_size,
+	ret = block_writer_init(&bw, BLOCK_TYPE_OBJ, (uint8_t *) block_data.buf, block_size,
 				header_off, hash_size(REFTABLE_HASH_SHA1));
 	check(!ret);
 
@@ -246,10 +246,10 @@ static void t_obj_block_read_write(void)
 
 	block_writer_release(&bw);
 
-	block_source_from_buf(&source, &block);
-	block_reader_init(&br, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
+	block_source_from_buf(&source, &block_data);
+	reftable_block_init(&block, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
 
-	block_iter_seek_start(&it, &br);
+	block_iter_seek_start(&it, &block);
 
 	for (i = 0; ; i++) {
 		ret = block_iter_next(&it, &rec);
@@ -265,7 +265,7 @@ static void t_obj_block_read_write(void)
 		block_iter_reset(&it);
 		reftable_record_key(&recs[i], &want);
 
-		ret = block_iter_seek_key(&it, &br, &want);
+		ret = block_iter_seek_key(&it, &block, &want);
 		check_int(ret, ==, 0);
 
 		ret = block_iter_next(&it, &rec);
@@ -274,11 +274,11 @@ static void t_obj_block_read_write(void)
 		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
 	}
 
-	block_reader_release(&br);
+	reftable_block_release(&block);
 	block_iter_close(&it);
 	reftable_record_release(&rec);
 	reftable_buf_release(&want);
-	reftable_buf_release(&block);
+	reftable_buf_release(&block_data);
 	for (i = 0; i < N; i++)
 		reftable_record_release(&recs[i]);
 }
@@ -299,16 +299,16 @@ static void t_index_block_read_write(void)
 	};
 	size_t i = 0;
 	int ret;
-	struct block_reader br = { 0 };
+	struct reftable_block block = { 0 };
 	struct block_iter it = BLOCK_ITER_INIT;
 	struct reftable_buf want = REFTABLE_BUF_INIT;
-	struct reftable_buf block = REFTABLE_BUF_INIT;
+	struct reftable_buf block_data = REFTABLE_BUF_INIT;
 
-	REFTABLE_CALLOC_ARRAY(block.buf, block_size);
-	check(block.buf != NULL);
-	block.len = block_size;
+	REFTABLE_CALLOC_ARRAY(block_data.buf, block_size);
+	check(block_data.buf != NULL);
+	block_data.len = block_size;
 
-	ret = block_writer_init(&bw, BLOCK_TYPE_INDEX, (uint8_t *) block.buf, block_size,
+	ret = block_writer_init(&bw, BLOCK_TYPE_INDEX, (uint8_t *) block_data.buf, block_size,
 				header_off, hash_size(REFTABLE_HASH_SHA1));
 	check(!ret);
 
@@ -331,10 +331,10 @@ static void t_index_block_read_write(void)
 
 	block_writer_release(&bw);
 
-	block_source_from_buf(&source, &block);
-	block_reader_init(&br, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
+	block_source_from_buf(&source, &block_data);
+	reftable_block_init(&block, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
 
-	block_iter_seek_start(&it, &br);
+	block_iter_seek_start(&it, &block);
 
 	for (i = 0; ; i++) {
 		ret = block_iter_next(&it, &rec);
@@ -350,7 +350,7 @@ static void t_index_block_read_write(void)
 		block_iter_reset(&it);
 		reftable_record_key(&recs[i], &want);
 
-		ret = block_iter_seek_key(&it, &br, &want);
+		ret = block_iter_seek_key(&it, &block, &want);
 		check_int(ret, ==, 0);
 
 		ret = block_iter_next(&it, &rec);
@@ -359,7 +359,7 @@ static void t_index_block_read_write(void)
 		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
 
 		want.len--;
-		ret = block_iter_seek_key(&it, &br, &want);
+		ret = block_iter_seek_key(&it, &block, &want);
 		check_int(ret, ==, 0);
 
 		ret = block_iter_next(&it, &rec);
@@ -367,11 +367,11 @@ static void t_index_block_read_write(void)
 		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, REFTABLE_HASH_SIZE_SHA1));
 	}
 
-	block_reader_release(&br);
+	reftable_block_release(&block);
 	block_iter_close(&it);
 	reftable_record_release(&rec);
 	reftable_buf_release(&want);
-	reftable_buf_release(&block);
+	reftable_buf_release(&block_data);
 	for (i = 0; i < N; i++)
 		reftable_record_release(&recs[i]);
 }

-- 
2.49.0.604.gff1f9ca942.dirty

