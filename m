Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5808B1D7999
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410488; cv=none; b=WkYPeqFkL9mzZM6Nwo3PXMHoZUURIsMJBSQno5U6WjMJ7q/1h2oj1KwWdmwW9ue1Q2D2jhyJ1iB3ODkS+v0VwrtNMW9bqn0G71dE56ctSaxLHlcubhMtL/iyLyK7Ewb87KAoxRgsDEBvzaoUAy5DyTfPTu01HPui8ZRrp+MUP3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410488; c=relaxed/simple;
	bh=6x5mYVMLEya5JSz4KAAqsz3ECJpxFnF9BVSkCiGCEKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HMgwKYfPEZxkIjGxRSXZxDzx7sInBu6zollrlrVUaLrsROJfQfq8rH1jwe1EFUS0QW/j6q6itmlPftkIaIJObHhzfLPsWfZ/2LpVO1GiNMvbh2OPI5GfdWOPEcybGqKFB/LbjNXQSI4YjU9FCKhz4kjCpW9HPaY62MCH+HPh/JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oMV5nnaC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a3V054ob; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oMV5nnaC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a3V054ob"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 54C041140122
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 31 Mar 2025 04:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743410485;
	 x=1743496885; bh=ZI6FiSZfZ0zhnKBmcBnkcxUkwBZ5KltkGcmKB53J7EM=; b=
	oMV5nnaCx04ES0X+TuZ+c1OP6A3YnntQ/kySBACVRN1wQy1pucKJvHWe09NSXXkc
	uFY31UbTautVhsMGChev3ak4qBhYs66ZHuZNomk35SVHkIp0/CwIj4ECg7ji87CF
	r/pKr6tKM0Zmb49Tb9RCqcDkUQXy/Vmp2H9Aj7+hUzcJLRv0KRHrYy60KrBksVJu
	wC1DsXsVfO0ucW+H+iXT2o9kwJaul9FWlT3bB0LoS9rS8auaAPUN8IIDiTgQvpCS
	Aa+g/9NPibPn+4kyJyGcjO9sW349vhOSpdz+xINWofAOBJfhvIJj1EWSuaMR5Zfs
	rJEjHYsvp52TGlrPB9PHqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743410485; x=
	1743496885; bh=ZI6FiSZfZ0zhnKBmcBnkcxUkwBZ5KltkGcmKB53J7EM=; b=a
	3V054obsfRC7eGj6/Yj+oB6rFVjXPvyochVYCW/74u5cQoT2oWuAX64z+d6lp/9+
	/jrcetQbAugja1bHWw3OkG5R8oBYkYdJQ3QbQVw/e4XrsMq2mNv/T1pgBdDkxrkZ
	ZXe59+vSTmhSEXj2worHTi2qyVx7GDgUK5GJC3bCz04CRqc7bZcswYDffw+D9d8N
	OYmkRkm3kfggmZq/cVoAZncRQ/yrxNc0SGQm4zLUrNESVdh+luHclIdVtW9kxfXb
	Oo3T7a684jCpGPFnfNbKIb6u8ddNpVHphFpLm8OVOChg1sHyIZVS1E8zW1eFDt6k
	8KuoOkAxViV4/vprIB+Vw==
X-ME-Sender: <xms:NVXqZy1micaOElYBSh7BYSrbyOT0iNh9IgtYt6c7nvnao9ZMaLuQVg>
    <xme:NVXqZ1ELv3kUIGRjcvdgqvXs3_X547u2oNT0gNoMkCMJr0syATp6UJWnc4a25ct0M
    wspx5OuaYGDDPpeHw>
X-ME-Received: <xmr:NVXqZ67vjh5JB-y6ThN_qBOg81nr96ek8DtAxKn05r76n38AjquZmemAVDNJD7L_e6J9WdVq12VJJemtd4hn_cKL7igeEXgIdHEowe7-2n6aZclp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NVXqZz3NfYsCsoNrUgENOhoS3JlaWNTUPwZbA5oDCr480IPDW4wrcw>
    <xmx:NVXqZ1H1dME-98h8QJeaEdiNXF6eGE-U3wU_-foEb0g8fbNBHorcEQ>
    <xmx:NVXqZ8_VxViZ4kwmhK1t_EM5VB8IEnrqv7hYa3LBTSrP-oMX5uzJqA>
    <xmx:NVXqZ6mUxZlZPTrithYv37Dy1O5x5M90Q_f7TG9Woc1Onv-PDUVkxQ>
    <xmx:NVXqZzNj2MX0Na6qzNMQeh-UnBSEjIZIXyNmSV9sb4xtC7m2_3I2qU1P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4eeb76f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 31 Mar 2025 08:41:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Mar 2025 10:41:21 +0200
Subject: [PATCH 03/16] reftable/blocksource: consolidate code into a single
 file
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-pks-reftable-polishing-v1-3-ebed5247434c@pks.im>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
In-Reply-To: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The code that implements block sources is distributed across a couple of
files even though. Consolidate all of it into "reftable/blocksource.c"
and its accompanying header so that it is easier to locate and more self
contained.

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

