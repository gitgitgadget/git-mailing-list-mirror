Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5A91DB377
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410491; cv=none; b=TdVbbcGA1Nsa7+Wrz6gghSMVtBnTvFtJ4Qduvl82plewOZq0pOwofcBD+hjG+akr950nJfFYqogxRXhOf/T91+tTVA4ZHiYsoMOZpyz0YEi+FQVxWY1W6SqvOVHH/unH9wOE/mkuObU1/m/Vy3hP3i1ZREy3kTgmS/6PMWVPn+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410491; c=relaxed/simple;
	bh=e+9gYWpEJ9Rdj8xarIOnVt2vf9si//7hSLsmlGeqLXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OMlM3kAlPXac5oJN3MldkeDDHkVbsvom7diCVtqprPcqO83lQ8R5OqH8JARaeuLwF5etlXBwuLcHihe4QxDwIVIREIxZoEcIQPP6ZoxLy+BzCyz7No4du7S9fgX2SyZlz9VjPBS7dxVN6vfjCQYfRFbZFf3MRZnO5m7sw8WvzN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dhQGF/qZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ptLFxabf; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dhQGF/qZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ptLFxabf"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3BFBF114013B
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 31 Mar 2025 04:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743410488;
	 x=1743496888; bh=tcNgDueaTGLgELTrO2SaMjzP+BxT8NwwyDyF8XUj1X8=; b=
	dhQGF/qZKVl3K0pBqrJao82T6LnYrO0SnZn1psJsM1zE8ZSRkwu1UqjEn6ykqPMc
	rXSM/5zWPmgn/tQ0fXV68jsKhBrYZZdeNEugmkE6mNQlvSFc/vuTgdDLIXO//VDh
	eBlAiMZBxvxBrA2bRRobLOW5kPzep8DSiN6pmyD80NwqssaaALIiiz1pBvVOEurD
	KuYkHrQZ9OikpUivAoVEldopz1l4w4UjvFP/lsx+GSU1tIpLsedJ1FM8Z5xf2gqL
	XuGZXxLU7XGcGszOgIQPWhqWAsbSRJO4AubvUj0IPv6c9J8BcH6A1aCXgjM0X5sd
	F20YurGCNNhE99xvZvRoyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743410488; x=
	1743496888; bh=tcNgDueaTGLgELTrO2SaMjzP+BxT8NwwyDyF8XUj1X8=; b=p
	tLFxabf9yCksrmqVQNTwFRNQ+UlTp2JtZJ/cHvgIEWq/5MJDl3ZwZmpfuQ9+rwIp
	DaijeyvImOyNeTn2yXRS3otUYYd2w2itMNe1IhG/81V/qlrpV+e6gUzLuAjMGpKO
	ujXNPQ/IrE6vg58Anh+Enl31bgGizY6FOnW5zM2blrg8peb879tLUdTqhTqyw0iQ
	kH5B3lNagyOm+CX/ja0uLd6gYO7a+TmXbSBgSOhwxRri7YfVLf8zlErLYlNG0qpe
	ii5K9UDzvi9xKdg9WxYtE7SS1L0PXypQhrHbbDHWrIwJFVhagNdTPqsTT7DRP9al
	ZyzVJKt7aMpwYiBivBmEw==
X-ME-Sender: <xms:OFXqZwMjFKifKeVtZwzQjGe99r2x651mN9H6gQLPuAc4HQoQZaEhTQ>
    <xme:OFXqZ2-2wdBaQDeI6lZWRmX0H9J2BL_Ay3G5S9VgmS6nGQ0hzs4B50S5DxKF9ECl1
    7StVorp9tlz3PyPTA>
X-ME-Received: <xmr:OFXqZ3S_FlQ9se13LwxNsgAvYLqFItMRynFDLxw-nEqxCNc-d5wE_1qvjVIj_plYCJDL480mmBPi36JFBbeMvrFCiz6nyaYvRbZ8jU2ZTcUvhDIO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OFXqZ4sohZm93mXEP8AdGxGO3YCic6hdMdRXNYX_WWAA065BC7X1kw>
    <xmx:OFXqZ4fphiZdyXkXPk7mOO6Y1IsT11bjYeamzcw1WddTBFB0kozwPA>
    <xmx:OFXqZ81Um3hOZo6IkL4iUVecP8bFwBhPI430wxN0n1FiwMkgWR-0fw>
    <xmx:OFXqZ8_a7E2AHwYT7VgJODLh3Qaoka00ZrSoLIRLwV7Kyv4jtjL-fw>
    <xmx:OFXqZ0Gaxsr5YgYaExCNu0gA_4hlEbXHxNgdUStr5fuS54tSUjl-Qefq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f2b0dfcc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 31 Mar 2025 08:41:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Mar 2025 10:41:24 +0200
Subject: [PATCH 06/16] reftable/block: rename `block` to `block_data`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-pks-reftable-polishing-v1-6-ebed5247434c@pks.im>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
In-Reply-To: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The `reftable_block` structure associates a byte slice with a block
source. As such it only holds the data of a reftable block without
actually encoding any of the details for how to access that data.

Rename the structure to instead be called `reftable_block_data`. Besides
clarifying that this really only holds data, it also allows us to rename
the `reftable_block_reader` to `reftable_block` in the next commit, as
this is the structure that actually encapsulates access to the reftable
blocks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c                    | 10 ++++-----
 reftable/block.h                    |  2 +-
 reftable/blocksource.c              | 44 ++++++++++++++++++-------------------
 reftable/blocksource.h              | 10 ++++-----
 reftable/iter.c                     |  4 ++--
 reftable/reftable-blocksource.h     | 14 ++++++------
 reftable/table.c                    | 14 ++++++------
 t/unit-tests/t-reftable-readwrite.c | 10 ++++-----
 8 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 2517108b8ef..ad162ecdbf6 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -210,16 +210,16 @@ int block_writer_finish(struct block_writer *w)
 }
 
 static int read_block(struct reftable_block_source *source,
-		      struct reftable_block *dest, uint64_t off,
+		      struct reftable_block_data *dest, uint64_t off,
 		      uint32_t sz)
 {
 	size_t size = block_source_size(source);
-	block_source_return_block(dest);
+	block_source_release_data(dest);
 	if (off >= size)
 		return 0;
 	if (off + sz > size)
 		sz = size - off;
-	return block_source_read_block(source, dest, off, sz);
+	return block_source_read_data(source, dest, off, sz);
 }
 
 int block_reader_init(struct block_reader *br,
@@ -310,7 +310,7 @@ int block_reader_init(struct block_reader *br,
 		}
 
 		/* We're done with the input data. */
-		block_source_return_block(&br->block);
+		block_source_release_data(&br->block);
 		br->block.data = br->uncompressed_data;
 		br->block.len = block_size;
 		full_block_size = src_len + block_header_skip - br->zstream->avail_in;
@@ -347,7 +347,7 @@ void block_reader_release(struct block_reader *br)
 	inflateEnd(br->zstream);
 	reftable_free(br->zstream);
 	reftable_free(br->uncompressed_data);
-	block_source_return_block(&br->block);
+	block_source_release_data(&br->block);
 	memset(br, 0, sizeof(*br));
 }
 
diff --git a/reftable/block.h b/reftable/block.h
index 6afb1b2952a..c55d47c3c52 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -71,7 +71,7 @@ struct block_reader {
 	uint32_t header_off;
 
 	/* the memory block */
-	struct reftable_block block;
+	struct reftable_block_data block;
 	uint32_t hash_size;
 
 	/* Uncompressed data for log entries. */
diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index bc785506fb1..573c81287fe 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -13,15 +13,15 @@
 #include "reftable-blocksource.h"
 #include "reftable-error.h"
 
-void block_source_return_block(struct reftable_block *block)
+void block_source_release_data(struct reftable_block_data *data)
 {
-	struct reftable_block_source source = block->source;
-	if (block && source.ops)
-		source.ops->return_block(source.arg, block);
-	block->data = NULL;
-	block->len = 0;
-	block->source.ops = NULL;
-	block->source.arg = NULL;
+	struct reftable_block_source source = data->source;
+	if (data && source.ops)
+		source.ops->release_data(source.arg, data);
+	data->data = NULL;
+	data->len = 0;
+	data->source.ops = NULL;
+	data->source.arg = NULL;
 }
 
 void block_source_close(struct reftable_block_source *source)
@@ -34,11 +34,11 @@ void block_source_close(struct reftable_block_source *source)
 	source->ops = NULL;
 }
 
-ssize_t block_source_read_block(struct reftable_block_source *source,
-				struct reftable_block *dest, uint64_t off,
-				uint32_t size)
+ssize_t block_source_read_data(struct reftable_block_source *source,
+			       struct reftable_block_data *dest, uint64_t off,
+			       uint32_t size)
 {
-	ssize_t result = source->ops->read_block(source->arg, dest, off, size);
+	ssize_t result = source->ops->read_data(source->arg, dest, off, size);
 	dest->source = *source;
 	return result;
 }
@@ -48,7 +48,7 @@ uint64_t block_source_size(struct reftable_block_source *source)
 	return source->ops->size(source->arg);
 }
 
-static void reftable_buf_return_block(void *b REFTABLE_UNUSED, struct reftable_block *dest)
+static void reftable_buf_release_data(void *b REFTABLE_UNUSED, struct reftable_block_data *dest)
 {
 	if (dest->len)
 		memset(dest->data, 0xff, dest->len);
@@ -59,8 +59,8 @@ static void reftable_buf_close(void *b REFTABLE_UNUSED)
 {
 }
 
-static ssize_t reftable_buf_read_block(void *v, struct reftable_block *dest,
-				       uint64_t off, uint32_t size)
+static ssize_t reftable_buf_read_data(void *v, struct reftable_block_data *dest,
+				      uint64_t off, uint32_t size)
 {
 	struct reftable_buf *b = v;
 	assert(off + size <= b->len);
@@ -79,8 +79,8 @@ static uint64_t reftable_buf_size(void *b)
 
 static struct reftable_block_source_vtable reftable_buf_vtable = {
 	.size = &reftable_buf_size,
-	.read_block = &reftable_buf_read_block,
-	.return_block = &reftable_buf_return_block,
+	.read_data = &reftable_buf_read_data,
+	.release_data = &reftable_buf_release_data,
 	.close = &reftable_buf_close,
 };
 
@@ -102,7 +102,7 @@ static uint64_t file_size(void *b)
 	return ((struct file_block_source *)b)->size;
 }
 
-static void file_return_block(void *b REFTABLE_UNUSED, struct reftable_block *dest REFTABLE_UNUSED)
+static void file_release_data(void *b REFTABLE_UNUSED, struct reftable_block_data *dest REFTABLE_UNUSED)
 {
 }
 
@@ -113,8 +113,8 @@ static void file_close(void *v)
 	reftable_free(b);
 }
 
-static ssize_t file_read_block(void *v, struct reftable_block *dest, uint64_t off,
-			       uint32_t size)
+static ssize_t file_read_data(void *v, struct reftable_block_data *dest, uint64_t off,
+			      uint32_t size)
 {
 	struct file_block_source *b = v;
 	assert(off + size <= b->size);
@@ -125,8 +125,8 @@ static ssize_t file_read_block(void *v, struct reftable_block *dest, uint64_t of
 
 static struct reftable_block_source_vtable file_vtable = {
 	.size = &file_size,
-	.read_block = &file_read_block,
-	.return_block = &file_return_block,
+	.read_data = &file_read_data,
+	.release_data = &file_release_data,
 	.close = &file_close,
 };
 
diff --git a/reftable/blocksource.h b/reftable/blocksource.h
index 639b9a1a3c5..a110e059580 100644
--- a/reftable/blocksource.h
+++ b/reftable/blocksource.h
@@ -12,7 +12,7 @@
 #include "system.h"
 
 struct reftable_block_source;
-struct reftable_block;
+struct reftable_block_data;
 struct reftable_buf;
 
 /*
@@ -24,9 +24,9 @@ void block_source_close(struct reftable_block_source *source);
 /*
  * Read a block of length `size` from the source at the given `off`.
  */
-ssize_t block_source_read_block(struct reftable_block_source *source,
-				struct reftable_block *dest, uint64_t off,
-				uint32_t size);
+ssize_t block_source_read_data(struct reftable_block_source *source,
+			       struct reftable_block_data *dest, uint64_t off,
+			       uint32_t size);
 
 /*
  * Return the total length of the underlying resource.
@@ -37,7 +37,7 @@ uint64_t block_source_size(struct reftable_block_source *source);
  * Return a block to its original source, releasing any resources associated
  * with it.
  */
-void block_source_return_block(struct reftable_block *block);
+void block_source_release_data(struct reftable_block_data *data);
 
 /* Create an in-memory block source for reading reftables. */
 void block_source_from_buf(struct reftable_block_source *bs,
diff --git a/reftable/iter.c b/reftable/iter.c
index 6af6eb49396..37b354a6fb9 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -114,7 +114,7 @@ static void indexed_table_ref_iter_close(void *p)
 {
 	struct indexed_table_ref_iter *it = p;
 	block_iter_close(&it->cur);
-	block_source_return_block(&it->block_reader.block);
+	block_source_release_data(&it->block_reader.block);
 	reftable_free(it->offsets);
 	reftable_buf_release(&it->oid);
 }
@@ -128,7 +128,7 @@ static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
 		return 1;
 	}
 
-	block_source_return_block(&it->block_reader.block);
+	block_source_release_data(&it->block_reader.block);
 
 	off = it->offsets[it->offset_idx++];
 	err = table_init_block_reader(it->table, &it->block_reader, off,
diff --git a/reftable/reftable-blocksource.h b/reftable/reftable-blocksource.h
index 96430b629e4..f5ba867bd60 100644
--- a/reftable/reftable-blocksource.h
+++ b/reftable/reftable-blocksource.h
@@ -21,7 +21,7 @@ struct reftable_block_source {
 
 /* a contiguous segment of bytes. It keeps track of its generating block_source
  * so it can return itself into the pool. */
-struct reftable_block {
+struct reftable_block_data {
 	uint8_t *data;
 	size_t len;
 	struct reftable_block_source source;
@@ -29,20 +29,20 @@ struct reftable_block {
 
 /* block_source_vtable are the operations that make up block_source */
 struct reftable_block_source_vtable {
-	/* returns the size of a block source */
+	/* Returns the size of a block source. */
 	uint64_t (*size)(void *source);
 
 	/*
 	 * Reads a segment from the block source. It is an error to read beyond
 	 * the end of the block.
 	 */
-	ssize_t (*read_block)(void *source, struct reftable_block *dest,
-			     uint64_t off, uint32_t size);
+	ssize_t (*read_data)(void *source, struct reftable_block_data *dest,
+			uint64_t off, uint32_t size);
 
-	/* mark the block as read; may return the data back to malloc */
-	void (*return_block)(void *source, struct reftable_block *blockp);
+	/* Mark the block as read; may release the data. */
+	void (*release_data)(void *source, struct reftable_block_data *data);
 
-	/* release all resources associated with the block source */
+	/* Release all resources associated with the block source. */
 	void (*close)(void *source);
 };
 
diff --git a/reftable/table.c b/reftable/table.c
index 7c0f1c9e6e3..a5ce96fa51c 100644
--- a/reftable/table.c
+++ b/reftable/table.c
@@ -526,8 +526,8 @@ int reftable_table_init_log_iterator(struct reftable_table *t,
 int reftable_table_new(struct reftable_table **out,
 		       struct reftable_block_source *source, char const *name)
 {
-	struct reftable_block footer = { 0 };
-	struct reftable_block header = { 0 };
+	struct reftable_block_data footer = { 0 };
+	struct reftable_block_data header = { 0 };
 	struct reftable_table *t;
 	uint64_t file_size = block_source_size(source);
 	uint32_t read_size;
@@ -550,7 +550,7 @@ int reftable_table_new(struct reftable_table **out,
 		goto done;
 	}
 
-	bytes_read = block_source_read_block(source, &header, 0, read_size);
+	bytes_read = block_source_read_data(source, &header, 0, read_size);
 	if (bytes_read < 0 || (size_t)bytes_read != read_size) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
@@ -576,8 +576,8 @@ int reftable_table_new(struct reftable_table **out,
 	t->hash_id = 0;
 	t->refcount = 1;
 
-	bytes_read = block_source_read_block(source, &footer, t->size,
-					     footer_size(t->version));
+	bytes_read = block_source_read_data(source, &footer, t->size,
+					    footer_size(t->version));
 	if (bytes_read < 0 || (size_t)bytes_read != footer_size(t->version)) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
@@ -590,8 +590,8 @@ int reftable_table_new(struct reftable_table **out,
 	*out = t;
 
 done:
-	block_source_return_block(&footer);
-	block_source_return_block(&header);
+	block_source_release_data(&footer);
+	block_source_release_data(&header);
 	if (err) {
 		if (t)
 			reftable_free(t->name);
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index 3fba888cdaa..4c49129439e 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -23,22 +23,22 @@ static void t_buffer(void)
 {
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_block_source source = { 0 };
-	struct reftable_block out = { 0 };
+	struct reftable_block_data out = { 0 };
 	int n;
 	uint8_t in[] = "hello";
 	check(!reftable_buf_add(&buf, in, sizeof(in)));
 	block_source_from_buf(&source, &buf);
 	check_int(block_source_size(&source), ==, 6);
-	n = block_source_read_block(&source, &out, 0, sizeof(in));
+	n = block_source_read_data(&source, &out, 0, sizeof(in));
 	check_int(n, ==, sizeof(in));
 	check(!memcmp(in, out.data, n));
-	block_source_return_block(&out);
+	block_source_release_data(&out);
 
-	n = block_source_read_block(&source, &out, 1, 2);
+	n = block_source_read_data(&source, &out, 1, 2);
 	check_int(n, ==, 2);
 	check(!memcmp(out.data, "el", 2));
 
-	block_source_return_block(&out);
+	block_source_release_data(&out);
 	block_source_close(&source);
 	reftable_buf_release(&buf);
 }

-- 
2.49.0.604.gff1f9ca942.dirty

