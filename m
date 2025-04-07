Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95360253F15
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031790; cv=none; b=dKmQjbiNexB79p48pRlmBtOzOEpCOFVBQoKEoCZfvP1gsypN+cUOzYivnMJT/IxsD7Iw0ULWWJdc9kY10Vx0ynG6jR1Mgc+lXZD5R4ewTED1dqZSRutrTM3j5ayHgDN3vjFQcc2sAvhIKVSGiFFkgNLvIEjhVWMua90b6lYofvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031790; c=relaxed/simple;
	bh=rgOGgvWFYy69jPgXLtyh00EttxvyvT9oQbFrByOa5as=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t3D6wJ5nw39BpQlDVdpFoI6kXVbGWxEi9jklaaJOse0mOSsMQf3s81fNBjDgON207uYcR+nKDYFRDXgAAnwaHoOBiVedmdNls/ZAuFy1DxjXOr+Nwta3axt+R7JCa0DaMYObuC7He2pYfOpUHXHZA0YOvBJ2PBhDaO13qraSrsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OJ3Fg0bz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kcYfTurD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OJ3Fg0bz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kcYfTurD"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id B38AA1380357;
	Mon,  7 Apr 2025 09:16:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 07 Apr 2025 09:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744031787;
	 x=1744118187; bh=7US3qxaqfJEPhsEx422DMdfZ29dQb2BsQZxDFy+1z6Q=; b=
	OJ3Fg0bzibocU3JXFrVCj3+AzOueT3XFt5Qoi+xVRfL29hUI3gB5FWgvWZUrBydU
	ScGO0H42bLpr+knQ9t98gtZre6okgIoFQ3TzPNNuyOXb3rGngItU3FVdL53ajKDj
	8XrCOr4HMuDNraSKu8vM1zPD4/CaLXkCzArIoEdZv45KUGXhdX84LKX7M7H/Pt27
	7DB81dxkQqLTcI+td7/Ks1TSuuMs8SbYTYW8QHtZXyYIfscDIl5DiN5KKJFT1gdh
	NiO5MRsifyGcrFy2b63IzOAbnbxnUPa596Q12x8N8ZX2vuugNVlICQraiddz8wrY
	EqhbPy5QcbE+e3D6we6/pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744031787; x=
	1744118187; bh=7US3qxaqfJEPhsEx422DMdfZ29dQb2BsQZxDFy+1z6Q=; b=k
	cYfTurDfSc3ty0QTddCEdDo9eMMgzzJm+dCqxD9FWjRRdAbZ5tAnhUnaGwmU30r+
	xdkEd1I12h48N2PyXK/aTxUTvFMzOkV8hgZTzbnKHp7Q0sXviqGAEdCxhzB96eXB
	yWKnSPjewEQ1+gZU5bXGAHzh2OeN6e87UWgyVt45bb9C3Jm66h1yel7+S6Qog5y8
	tabh0LENAD8ljSn/fUeq+oot9zsfcEhEOgJHdBNra2c+hYRRknmxow8dYG5n0Nf/
	osS7fXjfL6/YrBoDWtnBZGjCN8hNa5xGHz7T2QB0FjmK568wJXmx7aeOAxd8sOeI
	IL+P4UbQid+wi0mH5P9gQ==
X-ME-Sender: <xms:K9DzZ_W2Kc2oaPJ6A7iAsUaVZV-CbuL2kD9KhpmSQzG5FJH4EqX23g>
    <xme:K9DzZ3kg9Ty4yJV2RnazoU-U7kS4eTQ59phwr8CNr7yHF8nEhIJNOSOr_3sQftIWq
    WNL5BuuF7mjLrvsCg>
X-ME-Received: <xmr:K9DzZ7bhdwQ9xVaXBxcBuFcoyBpcqDl4RZeNVVfEozHZ_AQo5vB7U7xGYO1T3Dc6ZXOt0hMz3VQ73vqPDoS5f2Sf9L9Q7sGtzwJVKn2baWxYEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:K9DzZ6UKgMgy00jI8OTw9rKp2E_NHUGbRWujCG9VQ5DKhk8CR0WFqQ>
    <xmx:K9DzZ5mKdIoisz-LxBO3NvmKJiJ1vmBbkiTvp00xpgtydH53BhxSMA>
    <xmx:K9DzZ3cVF5z35r5-QE7GvS7p84d0pOW0-s8XBfdwE-td6U3qVIIezQ>
    <xmx:K9DzZzGfbqElSElbqrGV7eh4B3vWg1O_bJOudClJavlk0YOSAuZqYg>
    <xmx:K9DzZ_RB5E14rqGcaGG9rL6Gq7L1pTTPiuOwc9PTDh6ragINkL2HqyET>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 09:16:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3a69f448 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 13:16:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Apr 2025 15:16:18 +0200
Subject: [PATCH v2 06/16] reftable/block: rename `block` to `block_data`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-pks-reftable-polishing-v2-6-316c4ff10571@pks.im>
References: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
In-Reply-To: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The `reftable_block` structure associates a byte slice with a block
source. As such it only holds the data of a reftable block without
actually encoding any of the details for how to access that data.

Rename the structure to instead be called `reftable_block_data`. Besides
clarifying that this really only holds data, it also allows us to rename
the `reftable_block_reader` to `reftable_block` in the next commit, as
this is the structure that actually encapsulates access to the reftable
blocks.

Rename the `struct reftable_block_reader::block` member accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c                    | 46 ++++++++++++++++++-------------------
 reftable/block.h                    |  2 +-
 reftable/blocksource.c              | 44 +++++++++++++++++------------------
 reftable/blocksource.h              | 10 ++++----
 reftable/iter.c                     |  4 ++--
 reftable/reftable-blocksource.h     | 14 +++++------
 reftable/table.c                    | 16 ++++++-------
 t/unit-tests/t-reftable-readwrite.c | 10 ++++----
 8 files changed, 73 insertions(+), 73 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 2517108b8ef..dca30b8527f 100644
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
@@ -236,19 +236,19 @@ int block_reader_init(struct block_reader *br,
 	uint8_t block_type;
 	int err;
 
-	err = read_block(source, &br->block, offset, guess_block_size);
+	err = read_block(source, &br->block_data, offset, guess_block_size);
 	if (err < 0)
 		goto done;
 
-	block_type = br->block.data[header_size];
+	block_type = br->block_data.data[header_size];
 	if (!reftable_is_block_type(block_type)) {
 		err = REFTABLE_FORMAT_ERROR;
 		goto done;
 	}
 
-	block_size = reftable_get_be24(br->block.data + header_size + 1);
+	block_size = reftable_get_be24(br->block_data.data + header_size + 1);
 	if (block_size > guess_block_size) {
-		err = read_block(source, &br->block, offset, block_size);
+		err = read_block(source, &br->block_data, offset, block_size);
 		if (err < 0)
 			goto done;
 	}
@@ -256,7 +256,7 @@ int block_reader_init(struct block_reader *br,
 	if (block_type == BLOCK_TYPE_LOG) {
 		uint32_t block_header_skip = 4 + header_size;
 		uLong dst_len = block_size - block_header_skip;
-		uLong src_len = br->block.len - block_header_skip;
+		uLong src_len = br->block_data.len - block_header_skip;
 
 		/* Log blocks specify the *uncompressed* size in their header. */
 		REFTABLE_ALLOC_GROW_OR_NULL(br->uncompressed_data, block_size,
@@ -267,7 +267,7 @@ int block_reader_init(struct block_reader *br,
 		}
 
 		/* Copy over the block header verbatim. It's not compressed. */
-		memcpy(br->uncompressed_data, br->block.data, block_header_skip);
+		memcpy(br->uncompressed_data, br->block_data.data, block_header_skip);
 
 		if (!br->zstream) {
 			REFTABLE_CALLOC_ARRAY(br->zstream, 1);
@@ -285,7 +285,7 @@ int block_reader_init(struct block_reader *br,
 			goto done;
 		}
 
-		br->zstream->next_in = br->block.data + block_header_skip;
+		br->zstream->next_in = br->block_data.data + block_header_skip;
 		br->zstream->avail_in = src_len;
 		br->zstream->next_out = br->uncompressed_data + block_header_skip;
 		br->zstream->avail_out = dst_len;
@@ -310,21 +310,21 @@ int block_reader_init(struct block_reader *br,
 		}
 
 		/* We're done with the input data. */
-		block_source_return_block(&br->block);
-		br->block.data = br->uncompressed_data;
-		br->block.len = block_size;
+		block_source_release_data(&br->block_data);
+		br->block_data.data = br->uncompressed_data;
+		br->block_data.len = block_size;
 		full_block_size = src_len + block_header_skip - br->zstream->avail_in;
 	} else if (full_block_size == 0) {
 		full_block_size = block_size;
-	} else if (block_size < full_block_size && block_size < br->block.len &&
-		   br->block.data[block_size] != 0) {
+	} else if (block_size < full_block_size && block_size < br->block_data.len &&
+		   br->block_data.data[block_size] != 0) {
 		/* If the block is smaller than the full block size, it is
 		   padded (data followed by '\0') or the next block is
 		   unaligned. */
 		full_block_size = block_size;
 	}
 
-	restart_count = reftable_get_be16(br->block.data + block_size - 2);
+	restart_count = reftable_get_be16(br->block_data.data + block_size - 2);
 	restart_off = block_size - 2 - 3 * restart_count;
 
 	br->block_type = block_type;
@@ -347,20 +347,20 @@ void block_reader_release(struct block_reader *br)
 	inflateEnd(br->zstream);
 	reftable_free(br->zstream);
 	reftable_free(br->uncompressed_data);
-	block_source_return_block(&br->block);
+	block_source_release_data(&br->block_data);
 	memset(br, 0, sizeof(*br));
 }
 
 uint8_t block_reader_type(const struct block_reader *r)
 {
-	return r->block.data[r->header_off];
+	return r->block_data.data[r->header_off];
 }
 
 int block_reader_first_key(const struct block_reader *br, struct reftable_buf *key)
 {
 	int off = br->header_off + 4, n;
 	struct string_view in = {
-		.buf = br->block.data + off,
+		.buf = br->block_data.data + off,
 		.len = br->restart_off - off,
 	};
 	uint8_t extra = 0;
@@ -378,12 +378,12 @@ int block_reader_first_key(const struct block_reader *br, struct reftable_buf *k
 
 static uint32_t block_reader_restart_offset(const struct block_reader *br, size_t idx)
 {
-	return reftable_get_be24(br->block.data + br->restart_off + 3 * idx);
+	return reftable_get_be24(br->block_data.data + br->restart_off + 3 * idx);
 }
 
 void block_iter_seek_start(struct block_iter *it, const struct block_reader *br)
 {
-	it->block = br->block.data;
+	it->block = br->block_data.data;
 	it->block_len = br->restart_off;
 	it->hash_size = br->hash_size;
 	reftable_buf_reset(&it->last_key);
@@ -401,7 +401,7 @@ static int restart_needle_less(size_t idx, void *_args)
 	struct restart_needle_less_args *args = _args;
 	uint32_t off = block_reader_restart_offset(args->reader, idx);
 	struct string_view in = {
-		.buf = args->reader->block.data + off,
+		.buf = args->reader->block_data.data + off,
 		.len = args->reader->restart_off - off,
 	};
 	uint64_t prefix_len, suffix_len;
@@ -528,7 +528,7 @@ int block_iter_seek_key(struct block_iter *it, const struct block_reader *br,
 		it->next_off = block_reader_restart_offset(br, i - 1);
 	else
 		it->next_off = br->header_off + 4;
-	it->block = br->block.data;
+	it->block = br->block_data.data;
 	it->block_len = br->restart_off;
 	it->hash_size = br->hash_size;
 
diff --git a/reftable/block.h b/reftable/block.h
index 6afb1b2952a..948b79e4614 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -71,7 +71,7 @@ struct block_reader {
 	uint32_t header_off;
 
 	/* the memory block */
-	struct reftable_block block;
+	struct reftable_block_data block_data;
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
index 6af6eb49396..c00ffc88577 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -114,7 +114,7 @@ static void indexed_table_ref_iter_close(void *p)
 {
 	struct indexed_table_ref_iter *it = p;
 	block_iter_close(&it->cur);
-	block_source_return_block(&it->block_reader.block);
+	block_source_release_data(&it->block_reader.block_data);
 	reftable_free(it->offsets);
 	reftable_buf_release(&it->oid);
 }
@@ -128,7 +128,7 @@ static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
 		return 1;
 	}
 
-	block_source_return_block(&it->block_reader.block);
+	block_source_release_data(&it->block_reader.block_data);
 
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
index 7c0f1c9e6e3..c86b1d4c649 100644
--- a/reftable/table.c
+++ b/reftable/table.c
@@ -320,7 +320,7 @@ static int table_iter_seek_linear(struct table_iter *ti,
 		 * as we have more than three blocks we would have an index, so
 		 * we would not do a linear search there anymore.
 		 */
-		memset(&next.br.block, 0, sizeof(next.br.block));
+		memset(&next.br.block_data, 0, sizeof(next.br.block_data));
 		next.br.zstream = NULL;
 		next.br.uncompressed_data = NULL;
 		next.br.uncompressed_cap = 0;
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

