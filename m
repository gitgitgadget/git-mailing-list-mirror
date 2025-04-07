Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A86F253F14
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031791; cv=none; b=I0g4jE6hbgMUqUTzvToLnqNEadjg3ifAZSant/SgvetV8NkL9sRarxVfZym0tqlAQHgN37stWn+PB26eFTRvkAfU0dDP/uPY6SiolVvmRifauL1LrxXjGkkNaLup2qxmaF8N7uT5ld1eJRBB7xx3hcCK5X4knSvyPX/vZDFYc24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031791; c=relaxed/simple;
	bh=R4eJ+5MgZWRjklULR+2jKqkoW0093oP4ZS/hCQgydcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=chr9H9tXETfeua+kdhEOCI/JygNejkHIasw3ip8EsB1tWZxaFKSaP91RDcs+SC6vJJIq/0jLg9HT0ff3J9Moyl+1Et7c7mHPCw6ykC0qJNEqRjcaWf96DZE5kFi6NBNaJ+44hUIcOSVi8uvRLV3NBsi61HAH1u1x4VUiGbIXndE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n0mJgUUn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=frkuakgE; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n0mJgUUn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="frkuakgE"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 7B0AB1380345;
	Mon,  7 Apr 2025 09:16:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 07 Apr 2025 09:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744031787;
	 x=1744118187; bh=ijaAP/+yRVFoMgyN09Wfbpy6m6vGiQkOisFcpDZaSVU=; b=
	n0mJgUUnjkR8wq+4OCsxodUk5NB/Oi21kFq1zTyCDX0bJ1eljrp/ZNc82tr1Y447
	QNmBrMAytiqcgHlMVK2Yy48Z7GXdhzoQQVd1LMsuwDgO+1DSWDqtrXgV9O47F63m
	5ULDBF8eHtDWWNo7LL979Fsqz0Ge16iSbyml/76sTM7WBQLlu+NRZG/pjSrzvZ4t
	lgiyyPEmyePD+P0TqOS+kBcbVpwtwz1t4utWqRjmDGpRBq0wIKpOhmUQK2Q1Xros
	TR8dEvqPfyHXVFR025aeA1sDCZFoXUVyHf30N0/CA1p6AuX/cyiNhwMB0/nW/5EM
	4RaQM2ZOs6CAwxanEMwG8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744031787; x=
	1744118187; bh=ijaAP/+yRVFoMgyN09Wfbpy6m6vGiQkOisFcpDZaSVU=; b=f
	rkuakgEIId6JbZYajXLPFxAaU1RmfnnmjpZ2iYSKIJMuIRWEuwfDtG0WwT/UfYS6
	PjGA0kqLBY9x/sc7B0ZMs3xXm9XTKLqNu2sXBMfdSRILDfnGzzUb3LIRwMCRlZ17
	+0Iv7JaaFvcQkOYHIw5dHiLIvs5pYEK6UV4keLE6KeoL5pFsR+lJSRAuUDChOxVe
	Ba3V45r/NxlDP5fBo7GXLUmi0rPo13VIuoYvKQRd39C0tn92kzZ1u2x0wYr96i3C
	u6swYwZBzgDaDugR2sQj5mec3OoemR4U2ItmK+uJR//zLTeXJmFcExACo4Y6rU0u
	6JbIwK35mB4k26NdaWLcw==
X-ME-Sender: <xms:K9DzZyCUkYcp4oUlHEi6oKTzPbxJWh-kKDRuVVwsZ5E6DAOq0aUNdw>
    <xme:K9DzZ8jthhlMPBOdrZllgwd85rC7HpywY8e8k-UT5hVAjba-0zwoR3-Spjy85vD91
    yq1p9lQlLsqA-Tt8w>
X-ME-Received: <xmr:K9DzZ1lG1bM-Tbt04cGY4AqQxUY1lX4Csak81N_-wFRu85k_-wI4BCmKokngHM9x_uH82gNxtX_huRbvKFwmncgp_rCtvH9H7hgZOURaDLCo0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:K9DzZwxW8ns17JgqwE8uO9FOMYZ1i511v3tPeT9hnFmXRKw6T0S32g>
    <xmx:K9DzZ3Qv0XY8HhvaWrmbhM3omVRIfo1H83pR_7-mPJ0wJiEwnBz-LQ>
    <xmx:K9DzZ7YIil-Ycfp_hZdZv47IJr_Cqup1FFJpWBgl8b16YXvesqTvzw>
    <xmx:K9DzZwTL_v-kzptUYr50EzXEJjKRVyII6MulbI6qYTQs39rjddZpJQ>
    <xmx:K9DzZ1ewrSEsqCHiB7XFVBMe2Nr5AkuMRamNOJ9y6NrnvrtjfmeU2CSH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 09:16:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5ee1c0f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 13:16:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Apr 2025 15:16:17 +0200
Subject: [PATCH v2 05/16] reftable/table: move reading block into block
 reader
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-pks-reftable-polishing-v2-5-316c4ff10571@pks.im>
References: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
In-Reply-To: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The logic to read blocks from a reftable is scattered across both the
table and the block subsystems. Besides causing somewhat fuzzy
responsibilities, it also means that we have to awkwardly pass around
the ownership of blocks between the subsystems.

Refactor the code so that we stop passing the block when initializing a
reader, but instead by passing in the block source plus the offset at
which we're supposed to read a block. Like this, the ownership of the
block itself doesn't need to get handed over as the block reader is the
one owning the block right from the start.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c                | 87 ++++++++++++++++++++++++++---------------
 reftable/block.h                |  8 ++--
 reftable/table.c                | 65 +++---------------------------
 t/unit-tests/t-reftable-block.c | 76 ++++++++++++++++++-----------------
 4 files changed, 107 insertions(+), 129 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index f2567a8f0fd..2517108b8ef 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -209,31 +209,57 @@ int block_writer_finish(struct block_writer *w)
 	return w->next;
 }
 
-int block_reader_init(struct block_reader *br, struct reftable_block *block,
-		      uint32_t header_off, uint32_t table_block_size,
-		      uint32_t hash_size)
+static int read_block(struct reftable_block_source *source,
+		      struct reftable_block *dest, uint64_t off,
+		      uint32_t sz)
 {
+	size_t size = block_source_size(source);
+	block_source_return_block(dest);
+	if (off >= size)
+		return 0;
+	if (off + sz > size)
+		sz = size - off;
+	return block_source_read_block(source, dest, off, sz);
+}
+
+int block_reader_init(struct block_reader *br,
+		      struct reftable_block_source *source,
+		      uint32_t offset, uint32_t header_size,
+		      uint32_t table_block_size, uint32_t hash_size)
+{
+	uint32_t guess_block_size = table_block_size ?
+		table_block_size : DEFAULT_BLOCK_SIZE;
 	uint32_t full_block_size = table_block_size;
-	uint8_t typ = block->data[header_off];
-	uint32_t sz = reftable_get_be24(block->data + header_off + 1);
 	uint16_t restart_count;
 	uint32_t restart_off;
+	uint32_t block_size;
+	uint8_t block_type;
 	int err;
 
-	block_source_return_block(&br->block);
+	err = read_block(source, &br->block, offset, guess_block_size);
+	if (err < 0)
+		goto done;
 
-	if (!reftable_is_block_type(typ)) {
-		err =  REFTABLE_FORMAT_ERROR;
+	block_type = br->block.data[header_size];
+	if (!reftable_is_block_type(block_type)) {
+		err = REFTABLE_FORMAT_ERROR;
 		goto done;
 	}
 
-	if (typ == BLOCK_TYPE_LOG) {
-		uint32_t block_header_skip = 4 + header_off;
-		uLong dst_len = sz - block_header_skip;
-		uLong src_len = block->len - block_header_skip;
+	block_size = reftable_get_be24(br->block.data + header_size + 1);
+	if (block_size > guess_block_size) {
+		err = read_block(source, &br->block, offset, block_size);
+		if (err < 0)
+			goto done;
+	}
+
+	if (block_type == BLOCK_TYPE_LOG) {
+		uint32_t block_header_skip = 4 + header_size;
+		uLong dst_len = block_size - block_header_skip;
+		uLong src_len = br->block.len - block_header_skip;
 
 		/* Log blocks specify the *uncompressed* size in their header. */
-		REFTABLE_ALLOC_GROW_OR_NULL(br->uncompressed_data, sz,
+		REFTABLE_ALLOC_GROW_OR_NULL(br->uncompressed_data, block_size,
 					    br->uncompressed_cap);
 		if (!br->uncompressed_data) {
 			err = REFTABLE_OUT_OF_MEMORY_ERROR;
@@ -241,7 +267,7 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 		}
 
 		/* Copy over the block header verbatim. It's not compressed. */
-		memcpy(br->uncompressed_data, block->data, block_header_skip);
+		memcpy(br->uncompressed_data, br->block.data, block_header_skip);
 
 		if (!br->zstream) {
 			REFTABLE_CALLOC_ARRAY(br->zstream, 1);
@@ -259,7 +285,7 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 			goto done;
 		}
 
-		br->zstream->next_in = block->data + block_header_skip;
+		br->zstream->next_in = br->block.data + block_header_skip;
 		br->zstream->avail_in = src_len;
 		br->zstream->next_out = br->uncompressed_data + block_header_skip;
 		br->zstream->avail_out = dst_len;
@@ -278,43 +304,41 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 		}
 		err = 0;
 
-		if (br->zstream->total_out + block_header_skip != sz) {
+		if (br->zstream->total_out + block_header_skip != block_size) {
 			err = REFTABLE_FORMAT_ERROR;
 			goto done;
 		}
 
 		/* We're done with the input data. */
-		block_source_return_block(block);
-		block->data = br->uncompressed_data;
-		block->len = sz;
+		block_source_return_block(&br->block);
+		br->block.data = br->uncompressed_data;
+		br->block.len = block_size;
 		full_block_size = src_len + block_header_skip - br->zstream->avail_in;
 	} else if (full_block_size == 0) {
-		full_block_size = sz;
-	} else if (sz < full_block_size && sz < block->len &&
-		   block->data[sz] != 0) {
+		full_block_size = block_size;
+	} else if (block_size < full_block_size && block_size < br->block.len &&
+		   br->block.data[block_size] != 0) {
 		/* If the block is smaller than the full block size, it is
 		   padded (data followed by '\0') or the next block is
 		   unaligned. */
-		full_block_size = sz;
+		full_block_size = block_size;
 	}
 
-	restart_count = reftable_get_be16(block->data + sz - 2);
-	restart_off = sz - 2 - 3 * restart_count;
-
-	/* transfer ownership. */
-	br->block = *block;
-	block->data = NULL;
-	block->len = 0;
+	restart_count = reftable_get_be16(br->block.data + block_size - 2);
+	restart_off = block_size - 2 - 3 * restart_count;
 
+	br->block_type = block_type;
 	br->hash_size = hash_size;
 	br->restart_off = restart_off;
 	br->full_block_size = full_block_size;
-	br->header_off = header_off;
+	br->header_off = header_size;
 	br->restart_count = restart_count;
 
 	err = 0;
 
 done:
+	if (err < 0)
+		block_reader_release(br);
 	return err;
 }
 
@@ -324,6 +348,7 @@ void block_reader_release(struct block_reader *br)
 	reftable_free(br->zstream);
 	reftable_free(br->uncompressed_data);
 	block_source_return_block(&br->block);
+	memset(br, 0, sizeof(*br));
 }
 
 uint8_t block_reader_type(const struct block_reader *r)
diff --git a/reftable/block.h b/reftable/block.h
index b78f322e646..6afb1b2952a 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -89,12 +89,14 @@ struct block_reader {
 	/* size of the data in the file. For log blocks, this is the compressed
 	 * size. */
 	uint32_t full_block_size;
+	uint8_t block_type;
 };
 
 /* initializes a block reader. */
-int block_reader_init(struct block_reader *br, struct reftable_block *bl,
-		      uint32_t header_off, uint32_t table_block_size,
-		      uint32_t hash_size);
+int block_reader_init(struct block_reader *br,
+		      struct reftable_block_source *source,
+		      uint32_t offset, uint32_t header_size,
+		      uint32_t table_block_size, uint32_t hash_size);
 
 void block_reader_release(struct block_reader *br);
 
diff --git a/reftable/table.c b/reftable/table.c
index ec84545707c..7c0f1c9e6e3 100644
--- a/reftable/table.c
+++ b/reftable/table.c
@@ -30,23 +30,6 @@ table_offsets_for(struct reftable_table *t, uint8_t typ)
 	abort();
 }
 
-static int table_get_block(struct reftable_table *t,
-			   struct reftable_block *dest, uint64_t off,
-			   uint32_t sz)
-{
-	ssize_t bytes_read;
-	if (off >= t->size)
-		return 0;
-	if (off + sz > t->size)
-		sz = t->size - off;
-
-	bytes_read = block_source_read_block(&t->source, dest, off, sz);
-	if (bytes_read < 0)
-		return (int)bytes_read;
-
-	return 0;
-}
-
 enum reftable_hash reftable_table_hash_id(struct reftable_table *t)
 {
 	return t->hash_id;
@@ -180,64 +163,28 @@ static void table_iter_block_done(struct table_iter *ti)
 	block_iter_reset(&ti->bi);
 }
 
-static int32_t extract_block_size(uint8_t *data, uint8_t *typ, uint64_t off,
-				  int version)
-{
-	int32_t result = 0;
-
-	if (off == 0) {
-		data += header_size(version);
-	}
-
-	*typ = data[0];
-	if (reftable_is_block_type(*typ)) {
-		result = reftable_get_be24(data + 1);
-	}
-	return result;
-}
-
 int table_init_block_reader(struct reftable_table *t, struct block_reader *br,
 			    uint64_t next_off, uint8_t want_typ)
 {
-	int32_t guess_block_size = t->block_size ? t->block_size :
-							 DEFAULT_BLOCK_SIZE;
-	struct reftable_block block = { NULL };
-	uint8_t block_typ = 0;
-	int err = 0;
 	uint32_t header_off = next_off ? 0 : header_size(t->version);
-	int32_t block_size = 0;
+	int err;
 
 	if (next_off >= t->size)
 		return 1;
 
-	err = table_get_block(t, &block, next_off, guess_block_size);
+	err = block_reader_init(br, &t->source, next_off, header_off,
+				t->block_size, hash_size(t->hash_id));
 	if (err < 0)
 		goto done;
 
-	block_size = extract_block_size(block.data, &block_typ, next_off,
-					t->version);
-	if (block_size < 0) {
-		err = block_size;
-		goto done;
-	}
-	if (want_typ != BLOCK_TYPE_ANY && block_typ != want_typ) {
+	if (want_typ != BLOCK_TYPE_ANY && br->block_type != want_typ) {
 		err = 1;
 		goto done;
 	}
 
-	if (block_size > guess_block_size) {
-		block_source_return_block(&block);
-		err = table_get_block(t, &block, next_off, block_size);
-		if (err < 0) {
-			goto done;
-		}
-	}
-
-	err = block_reader_init(br, &block, header_off, t->block_size,
-				hash_size(t->hash_id));
 done:
-	block_source_return_block(&block);
-
+	if (err)
+		block_reader_release(br);
 	return err;
 }
 
diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index 8bb40482347..dbec6a5d0d0 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -19,7 +19,7 @@ static void t_ref_block_read_write(void)
 	struct reftable_record recs[30];
 	const size_t N = ARRAY_SIZE(recs);
 	const size_t block_size = 1024;
-	struct reftable_block block = { 0 };
+	struct reftable_block_source source = { 0 };
 	struct block_writer bw = {
 		.last_key = REFTABLE_BUF_INIT,
 	};
@@ -30,13 +30,14 @@ static void t_ref_block_read_write(void)
 	int ret;
 	struct block_reader br = { 0 };
 	struct block_iter it = BLOCK_ITER_INIT;
-	struct reftable_buf want = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
+	struct reftable_buf want = REFTABLE_BUF_INIT;
+	struct reftable_buf block = REFTABLE_BUF_INIT;
 
-	REFTABLE_CALLOC_ARRAY(block.data, block_size);
-	check(block.data != NULL);
+	REFTABLE_CALLOC_ARRAY(block.buf, block_size);
+	check(block.buf != NULL);
 	block.len = block_size;
-	block_source_from_buf(&block.source ,&buf);
-	ret = block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
+
+	ret = block_writer_init(&bw, BLOCK_TYPE_REF, (uint8_t *) block.buf, block_size,
 				header_off, hash_size(REFTABLE_HASH_SHA1));
 	check(!ret);
 
@@ -62,7 +63,8 @@ static void t_ref_block_read_write(void)
 
 	block_writer_release(&bw);
 
-	block_reader_init(&br, &block, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
+	block_source_from_buf(&source ,&block);
+	block_reader_init(&br, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
 
 	block_iter_seek_start(&it, &br);
 
@@ -100,9 +102,8 @@ static void t_ref_block_read_write(void)
 	block_reader_release(&br);
 	block_iter_close(&it);
 	reftable_record_release(&rec);
-	block_source_return_block(&br.block);
 	reftable_buf_release(&want);
-	reftable_buf_release(&buf);
+	reftable_buf_release(&block);
 	for (i = 0; i < N; i++)
 		reftable_record_release(&recs[i]);
 }
@@ -113,7 +114,7 @@ static void t_log_block_read_write(void)
 	struct reftable_record recs[30];
 	const size_t N = ARRAY_SIZE(recs);
 	const size_t block_size = 2048;
-	struct reftable_block block = { 0 };
+	struct reftable_block_source source = { 0 };
 	struct block_writer bw = {
 		.last_key = REFTABLE_BUF_INIT,
 	};
@@ -124,13 +125,14 @@ static void t_log_block_read_write(void)
 	int ret;
 	struct block_reader br = { 0 };
 	struct block_iter it = BLOCK_ITER_INIT;
-	struct reftable_buf want = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
+	struct reftable_buf want = REFTABLE_BUF_INIT;
+	struct reftable_buf block = REFTABLE_BUF_INIT;
 
-	REFTABLE_CALLOC_ARRAY(block.data, block_size);
-	check(block.data != NULL);
+	REFTABLE_CALLOC_ARRAY(block.buf, block_size);
+	check(block.buf != NULL);
 	block.len = block_size;
-	block_source_from_buf(&block.source ,&buf);
-	ret = block_writer_init(&bw, BLOCK_TYPE_LOG, block.data, block_size,
+
+	ret = block_writer_init(&bw, BLOCK_TYPE_LOG, (uint8_t *) block.buf, block_size,
 				header_off, hash_size(REFTABLE_HASH_SHA1));
 	check(!ret);
 
@@ -151,7 +153,8 @@ static void t_log_block_read_write(void)
 
 	block_writer_release(&bw);
 
-	block_reader_init(&br, &block, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
+	block_source_from_buf(&source, &block);
+	block_reader_init(&br, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
 
 	block_iter_seek_start(&it, &br);
 
@@ -190,9 +193,8 @@ static void t_log_block_read_write(void)
 	block_reader_release(&br);
 	block_iter_close(&it);
 	reftable_record_release(&rec);
-	block_source_return_block(&br.block);
 	reftable_buf_release(&want);
-	reftable_buf_release(&buf);
+	reftable_buf_release(&block);
 	for (i = 0; i < N; i++)
 		reftable_record_release(&recs[i]);
 }
@@ -203,7 +205,7 @@ static void t_obj_block_read_write(void)
 	struct reftable_record recs[30];
 	const size_t N = ARRAY_SIZE(recs);
 	const size_t block_size = 1024;
-	struct reftable_block block = { 0 };
+	struct reftable_block_source source = { 0 };
 	struct block_writer bw = {
 		.last_key = REFTABLE_BUF_INIT,
 	};
@@ -214,13 +216,14 @@ static void t_obj_block_read_write(void)
 	int ret;
 	struct block_reader br = { 0 };
 	struct block_iter it = BLOCK_ITER_INIT;
-	struct reftable_buf want = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
+	struct reftable_buf want = REFTABLE_BUF_INIT;
+	struct reftable_buf block = REFTABLE_BUF_INIT;
 
-	REFTABLE_CALLOC_ARRAY(block.data, block_size);
-	check(block.data != NULL);
+	REFTABLE_CALLOC_ARRAY(block.buf, block_size);
+	check(block.buf != NULL);
 	block.len = block_size;
-	block_source_from_buf(&block.source, &buf);
-	ret = block_writer_init(&bw, BLOCK_TYPE_OBJ, block.data, block_size,
+
+	ret = block_writer_init(&bw, BLOCK_TYPE_OBJ, (uint8_t *) block.buf, block_size,
 				header_off, hash_size(REFTABLE_HASH_SHA1));
 	check(!ret);
 
@@ -243,7 +246,8 @@ static void t_obj_block_read_write(void)
 
 	block_writer_release(&bw);
 
-	block_reader_init(&br, &block, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
+	block_source_from_buf(&source, &block);
+	block_reader_init(&br, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
 
 	block_iter_seek_start(&it, &br);
 
@@ -273,9 +277,8 @@ static void t_obj_block_read_write(void)
 	block_reader_release(&br);
 	block_iter_close(&it);
 	reftable_record_release(&rec);
-	block_source_return_block(&br.block);
 	reftable_buf_release(&want);
-	reftable_buf_release(&buf);
+	reftable_buf_release(&block);
 	for (i = 0; i < N; i++)
 		reftable_record_release(&recs[i]);
 }
@@ -286,7 +289,7 @@ static void t_index_block_read_write(void)
 	struct reftable_record recs[30];
 	const size_t N = ARRAY_SIZE(recs);
 	const size_t block_size = 1024;
-	struct reftable_block block = { 0 };
+	struct reftable_block_source source = { 0 };
 	struct block_writer bw = {
 		.last_key = REFTABLE_BUF_INIT,
 	};
@@ -298,13 +301,14 @@ static void t_index_block_read_write(void)
 	int ret;
 	struct block_reader br = { 0 };
 	struct block_iter it = BLOCK_ITER_INIT;
-	struct reftable_buf want = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
+	struct reftable_buf want = REFTABLE_BUF_INIT;
+	struct reftable_buf block = REFTABLE_BUF_INIT;
 
-	REFTABLE_CALLOC_ARRAY(block.data, block_size);
-	check(block.data != NULL);
+	REFTABLE_CALLOC_ARRAY(block.buf, block_size);
+	check(block.buf != NULL);
 	block.len = block_size;
-	block_source_from_buf(&block.source, &buf);
-	ret = block_writer_init(&bw, BLOCK_TYPE_INDEX, block.data, block_size,
+
+	ret = block_writer_init(&bw, BLOCK_TYPE_INDEX, (uint8_t *) block.buf, block_size,
 				header_off, hash_size(REFTABLE_HASH_SHA1));
 	check(!ret);
 
@@ -327,7 +331,8 @@ static void t_index_block_read_write(void)
 
 	block_writer_release(&bw);
 
-	block_reader_init(&br, &block, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
+	block_source_from_buf(&source, &block);
+	block_reader_init(&br, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
 
 	block_iter_seek_start(&it, &br);
 
@@ -365,9 +370,8 @@ static void t_index_block_read_write(void)
 	block_reader_release(&br);
 	block_iter_close(&it);
 	reftable_record_release(&rec);
-	block_source_return_block(&br.block);
 	reftable_buf_release(&want);
-	reftable_buf_release(&buf);
+	reftable_buf_release(&block);
 	for (i = 0; i < N; i++)
 		reftable_record_release(&recs[i]);
 }

-- 
2.49.0.604.gff1f9ca942.dirty

