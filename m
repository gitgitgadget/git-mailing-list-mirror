Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249FF253B6E
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031790; cv=none; b=NTcczn9vyWuU7yUuYbhFpKQfFLxN7GUtg+kjpxhwJN2C1eI/mM0NnINHYenTj4YcRlkS6psYRYZr9/9JEkAmLLZSxlXz9g2yGqedfWOHSkWsCdxXRZFrYMQzTJ3mJR7g+gt8hgOMgLJzAD3N89Wqn8xNv/JzVjbQf0qDQoprv+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031790; c=relaxed/simple;
	bh=/UFJcpSnVrSJbIZFgn+VeYQi9GkR+eYqYE+Zggt+hZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R8ZhkBXyJYiw0ITt5jDS/nA9CuKSEc2W9hBnhYE7+GesvavIWsD7qb/tlM4a6MDQRH5xKBMuCzx0qYFZYtL4eAL5yzzR7K4KDVYPQVIK+jsOCQfknen9qtlIAi0Rj7h0WvDAxwwyxK6z6vGwBWZE6myQ2q/wheLfYZRmmhiNBDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lhLYrUpB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s+GIFaZs; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lhLYrUpB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s+GIFaZs"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 45D4E114020A;
	Mon,  7 Apr 2025 09:16:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 07 Apr 2025 09:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744031786;
	 x=1744118186; bh=OFPL7tTwSeOdxD4koHsxZBUp4E8lC8vMlwcKnvxIW1w=; b=
	lhLYrUpBk8Ujh/qoZuyorDNYqHuDmey1FMYn2SW5Y056DchYFMi8WgctmGbiJ/tu
	CI1XnsaNktUQfsi9Vsfvpet57stYH+PhmyBNeFSO/2nBYTb5ua4nxo1/PZRz+cmf
	cDvMk1ID8xeKWYV3E+lijH/skrb6IeKmf27fjEVp3jNAlgaXsxk3KdVceFWa2S7Y
	whcrNF5rczb1EFuCLjcmYBSZq6CorNbN88sI2QsWZ86y7YoLxwkECrVdPbNAbv65
	M+oWXWyKpBaWEgOmaUKsZpRRJwZ9mpGLjgTtAG0c01KerPysQlmCzJaASw9pD7oq
	pi4xXclTxbqkoyeZWLAgRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744031786; x=
	1744118186; bh=OFPL7tTwSeOdxD4koHsxZBUp4E8lC8vMlwcKnvxIW1w=; b=s
	+GIFaZsg/YGfINGlIYWxnNl7jLdYLz/q5LOIqq/AFRJeVuYSvvNl0hxGv+P3CpUU
	5s/JE7okJ+YtZRSX7hV76J3esj4znTc7Lx3M9Or/sXjD0jaoR1gxWWhquSVKc4/+
	rJkjDA1gg+NJF7bb4lM54FkJgEgjL8dVysWgoKVsaYwFuo45t5ljYDhhdaNby5tU
	mHi1TScqaRD2jIX9IYJnLFb+rabWxk/7mumWpXxRK5WZVQp45ocNvp809fZykAID
	rVa1wPSJAF7UqpDlgxPHjn3MR2upTl3eqNm+bJKJpfZo0ebds4WwP6oILu8M/QNv
	dsJI61qX4aWBovVJ3jJtA==
X-ME-Sender: <xms:KtDzZ6td6RSrnFij5hfu8Ly8Epl0biMgV9SPTWfaTUAlkDsQIRVFrQ>
    <xme:KtDzZ_efHn1DT1bP5Xbm-1K8m7gFMrBQbVemaeS6Q2kjaVxUT5_rGZ2dGDQ912zQ6
    b7uKX1wNZueKvld4g>
X-ME-Received: <xmr:KtDzZ1xe1mqJuIuk8f53m4LvTwqgP2gE3Lxvmj7d0yU4X2YPEE7QIEFvKW1YIKdw7yFxWt8L43K1I-xyj8VF-suuLbIcmMsmSTdasEAAcCQp_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KtDzZ1NBwB8CK--6OXbQ119QgZSPmvjUn6WRQypxBuqaMeHJX6HxMA>
    <xmx:KtDzZ68mVK4pP8ktYt-Ep3fpGkcFYBcrhRUphNwf-UWkEvqv5BOjjQ>
    <xmx:KtDzZ9VO0MC805LDlANgMCCFWi3VzyblhpFWT1vwY2GrVU3rEMr9Zg>
    <xmx:KtDzZzeAfhRGtdLG2cAVLfGRpsE2gMCH11tUZMolwleUhVNVfpe0og>
    <xmx:KtDzZxrKGPy_66RJfpl-ipXP7Ho0gzPE9vAumu-9VSFSf7Od99EWhuXK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 09:16:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5f1c24af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 13:16:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Apr 2025 15:16:15 +0200
Subject: [PATCH v2 03/16] reftable/blocksource: consolidate code into a
 single file
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-pks-reftable-polishing-v2-3-316c4ff10571@pks.im>
References: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
In-Reply-To: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The code that implements block sources is distributed across a couple of
files. Consolidate all of it into "reftable/blocksource.c" and its
accompanying header so that it is easier to locate and more self
contained.

While at it, rename some of the functions to have properly scoped names.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c                    | 17 +++--------------
 reftable/block.h                    |  3 ---
 reftable/blocksource.c              | 35 +++++++++++++++++++++++++++++++++++
 reftable/blocksource.h              | 27 ++++++++++++++++++++++++++-
 reftable/iter.c                     |  5 +++--
 reftable/reftable-blocksource.h     |  3 ++-
 reftable/table.c                    | 33 +++++----------------------------
 reftable/table.h                    |  7 -------
 t/unit-tests/t-reftable-block.c     |  8 ++++----
 t/unit-tests/t-reftable-readwrite.c |  4 ++--
 10 files changed, 80 insertions(+), 62 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index a5734d44415..97740187259 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -221,7 +221,7 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 	uint32_t restart_start = 0;
 	uint8_t *restart_bytes = NULL;
 
-	reftable_block_done(&br->block);
+	block_source_return_block(&br->block);
 
 	if (!reftable_is_block_type(typ)) {
 		err =  REFTABLE_FORMAT_ERROR;
@@ -285,7 +285,7 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 		}
 
 		/* We're done with the input data. */
-		reftable_block_done(block);
+		block_source_return_block(block);
 		block->data = br->uncompressed_data;
 		block->len = sz;
 		full_block_size = src_len + block_header_skip - br->zstream->avail_in;
@@ -324,7 +324,7 @@ void block_reader_release(struct block_reader *br)
 	inflateEnd(br->zstream);
 	reftable_free(br->zstream);
 	reftable_free(br->uncompressed_data);
-	reftable_block_done(&br->block);
+	block_source_return_block(&br->block);
 }
 
 uint8_t block_reader_type(const struct block_reader *r)
@@ -570,14 +570,3 @@ void block_writer_release(struct block_writer *bw)
 	reftable_buf_release(&bw->last_key);
 	/* the block is not owned. */
 }
-
-void reftable_block_done(struct reftable_block *blockp)
-{
-	struct reftable_block_source source = blockp->source;
-	if (blockp && source.ops)
-		source.ops->return_block(source.arg, blockp);
-	blockp->data = NULL;
-	blockp->len = 0;
-	blockp->source.ops = NULL;
-	blockp->source.arg = NULL;
-}
diff --git a/reftable/block.h b/reftable/block.h
index eaeffdffc90..203b07d9a44 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -142,7 +142,4 @@ size_t header_size(int version);
 /* size of file footer, depending on format version */
 size_t footer_size(int version);
 
-/* returns a block to its source. */
-void reftable_block_done(struct reftable_block *ret);
-
 #endif
diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 1397cbe7800..bc785506fb1 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -13,6 +13,41 @@
 #include "reftable-blocksource.h"
 #include "reftable-error.h"
 
+void block_source_return_block(struct reftable_block *block)
+{
+	struct reftable_block_source source = block->source;
+	if (block && source.ops)
+		source.ops->return_block(source.arg, block);
+	block->data = NULL;
+	block->len = 0;
+	block->source.ops = NULL;
+	block->source.arg = NULL;
+}
+
+void block_source_close(struct reftable_block_source *source)
+{
+	if (!source->ops) {
+		return;
+	}
+
+	source->ops->close(source->arg);
+	source->ops = NULL;
+}
+
+ssize_t block_source_read_block(struct reftable_block_source *source,
+				struct reftable_block *dest, uint64_t off,
+				uint32_t size)
+{
+	ssize_t result = source->ops->read_block(source->arg, dest, off, size);
+	dest->source = *source;
+	return result;
+}
+
+uint64_t block_source_size(struct reftable_block_source *source)
+{
+	return source->ops->size(source->arg);
+}
+
 static void reftable_buf_return_block(void *b REFTABLE_UNUSED, struct reftable_block *dest)
 {
 	if (dest->len)
diff --git a/reftable/blocksource.h b/reftable/blocksource.h
index 7b67898ae22..639b9a1a3c5 100644
--- a/reftable/blocksource.h
+++ b/reftable/blocksource.h
@@ -12,9 +12,34 @@
 #include "system.h"
 
 struct reftable_block_source;
+struct reftable_block;
 struct reftable_buf;
 
-/* Create an in-memory block source for reading reftables */
+/*
+ * Close the block source and the underlying resource. This is a no-op in case
+ * the block source is zero-initialized.
+ */
+void block_source_close(struct reftable_block_source *source);
+
+/*
+ * Read a block of length `size` from the source at the given `off`.
+ */
+ssize_t block_source_read_block(struct reftable_block_source *source,
+				struct reftable_block *dest, uint64_t off,
+				uint32_t size);
+
+/*
+ * Return the total length of the underlying resource.
+ */
+uint64_t block_source_size(struct reftable_block_source *source);
+
+/*
+ * Return a block to its original source, releasing any resources associated
+ * with it.
+ */
+void block_source_return_block(struct reftable_block *block);
+
+/* Create an in-memory block source for reading reftables. */
 void block_source_from_buf(struct reftable_block_source *bs,
 			   struct reftable_buf *buf);
 
diff --git a/reftable/iter.c b/reftable/iter.c
index 7376f263c99..6af6eb49396 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -11,6 +11,7 @@
 #include "system.h"
 
 #include "block.h"
+#include "blocksource.h"
 #include "constants.h"
 #include "reftable-error.h"
 #include "table.h"
@@ -113,7 +114,7 @@ static void indexed_table_ref_iter_close(void *p)
 {
 	struct indexed_table_ref_iter *it = p;
 	block_iter_close(&it->cur);
-	reftable_block_done(&it->block_reader.block);
+	block_source_return_block(&it->block_reader.block);
 	reftable_free(it->offsets);
 	reftable_buf_release(&it->oid);
 }
@@ -127,7 +128,7 @@ static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
 		return 1;
 	}
 
-	reftable_block_done(&it->block_reader.block);
+	block_source_return_block(&it->block_reader.block);
 
 	off = it->offsets[it->offset_idx++];
 	err = table_init_block_reader(it->table, &it->block_reader, off,
diff --git a/reftable/reftable-blocksource.h b/reftable/reftable-blocksource.h
index 8692cd017e9..96430b629e4 100644
--- a/reftable/reftable-blocksource.h
+++ b/reftable/reftable-blocksource.h
@@ -11,7 +11,8 @@
 
 #include <stdint.h>
 
-/* block_source is a generic wrapper for a seekable readable file.
+/*
+ * Generic wrapper for a seekable readable file.
  */
 struct reftable_block_source {
 	struct reftable_block_source_vtable *ops;
diff --git a/reftable/table.c b/reftable/table.c
index 440fb559ad1..d18e17b0d44 100644
--- a/reftable/table.c
+++ b/reftable/table.c
@@ -10,35 +10,12 @@
 
 #include "system.h"
 #include "block.h"
+#include "blocksource.h"
 #include "constants.h"
 #include "iter.h"
 #include "record.h"
 #include "reftable-error.h"
 
-uint64_t block_source_size(struct reftable_block_source *source)
-{
-	return source->ops->size(source->arg);
-}
-
-ssize_t block_source_read_block(struct reftable_block_source *source,
-				struct reftable_block *dest, uint64_t off,
-				uint32_t size)
-{
-	ssize_t result = source->ops->read_block(source->arg, dest, off, size);
-	dest->source = *source;
-	return result;
-}
-
-void block_source_close(struct reftable_block_source *source)
-{
-	if (!source->ops) {
-		return;
-	}
-
-	source->ops->close(source->arg);
-	source->ops = NULL;
-}
-
 static struct reftable_table_offsets *
 table_offsets_for(struct reftable_table *t, uint8_t typ)
 {
@@ -249,7 +226,7 @@ int table_init_block_reader(struct reftable_table *t, struct block_reader *br,
 	}
 
 	if (block_size > guess_block_size) {
-		reftable_block_done(&block);
+		block_source_return_block(&block);
 		err = table_get_block(t, &block, next_off, block_size);
 		if (err < 0) {
 			goto done;
@@ -259,7 +236,7 @@ int table_init_block_reader(struct reftable_table *t, struct block_reader *br,
 	err = block_reader_init(br, &block, header_off, t->block_size,
 				hash_size(t->hash_id));
 done:
-	reftable_block_done(&block);
+	block_source_return_block(&block);
 
 	return err;
 }
@@ -666,8 +643,8 @@ int reftable_table_new(struct reftable_table **out,
 	*out = t;
 
 done:
-	reftable_block_done(&footer);
-	reftable_block_done(&header);
+	block_source_return_block(&footer);
+	block_source_return_block(&header);
 	if (err) {
 		if (t)
 			reftable_free(t->name);
diff --git a/reftable/table.h b/reftable/table.h
index 9cd8f80a207..8d8dd2b413d 100644
--- a/reftable/table.h
+++ b/reftable/table.h
@@ -14,13 +14,6 @@
 #include "reftable-iterator.h"
 #include "reftable-table.h"
 
-uint64_t block_source_size(struct reftable_block_source *source);
-
-ssize_t block_source_read_block(struct reftable_block_source *source,
-				struct reftable_block *dest, uint64_t off,
-				uint32_t size);
-void block_source_close(struct reftable_block_source *source);
-
 /* metadata for a block type */
 struct reftable_table_offsets {
 	int is_present;
diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index 22040aeefa5..8bb40482347 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -100,7 +100,7 @@ static void t_ref_block_read_write(void)
 	block_reader_release(&br);
 	block_iter_close(&it);
 	reftable_record_release(&rec);
-	reftable_block_done(&br.block);
+	block_source_return_block(&br.block);
 	reftable_buf_release(&want);
 	reftable_buf_release(&buf);
 	for (i = 0; i < N; i++)
@@ -190,7 +190,7 @@ static void t_log_block_read_write(void)
 	block_reader_release(&br);
 	block_iter_close(&it);
 	reftable_record_release(&rec);
-	reftable_block_done(&br.block);
+	block_source_return_block(&br.block);
 	reftable_buf_release(&want);
 	reftable_buf_release(&buf);
 	for (i = 0; i < N; i++)
@@ -273,7 +273,7 @@ static void t_obj_block_read_write(void)
 	block_reader_release(&br);
 	block_iter_close(&it);
 	reftable_record_release(&rec);
-	reftable_block_done(&br.block);
+	block_source_return_block(&br.block);
 	reftable_buf_release(&want);
 	reftable_buf_release(&buf);
 	for (i = 0; i < N; i++)
@@ -365,7 +365,7 @@ static void t_index_block_read_write(void)
 	block_reader_release(&br);
 	block_iter_close(&it);
 	reftable_record_release(&rec);
-	reftable_block_done(&br.block);
+	block_source_return_block(&br.block);
 	reftable_buf_release(&want);
 	reftable_buf_release(&buf);
 	for (i = 0; i < N; i++)
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index c4c27242ba9..3fba888cdaa 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -32,13 +32,13 @@ static void t_buffer(void)
 	n = block_source_read_block(&source, &out, 0, sizeof(in));
 	check_int(n, ==, sizeof(in));
 	check(!memcmp(in, out.data, n));
-	reftable_block_done(&out);
+	block_source_return_block(&out);
 
 	n = block_source_read_block(&source, &out, 1, 2);
 	check_int(n, ==, 2);
 	check(!memcmp(out.data, "el", 2));
 
-	reftable_block_done(&out);
+	block_source_return_block(&out);
 	block_source_close(&source);
 	reftable_buf_release(&buf);
 }

-- 
2.49.0.604.gff1f9ca942.dirty

