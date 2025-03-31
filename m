Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06981DF247
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410496; cv=none; b=KfKtUwDCxHaLu8LgOkvEhMW12AnzlGohTBDELF4GL6DK8KzkrtPefQoMh4zMndOKAWex6mPY8ygxKWS49xO03BTJmpMnze6T36DQbx/dOw0ZSnXY8va20HXt4cBmxqR0EmQG8r2CAnJ7C3zxywwBvZ9GWl9bvFrMZk//mzWlbMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410496; c=relaxed/simple;
	bh=v8g9rW49YfpswlkdXbSNxQB0HqyzvwWp58E/HVHNDzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M4YnTVn5jOmNMRbk7vtI5hB5+3QAWJ2iMwaY2ABGNqK5QWwhIPbytPcIiRD7/ek51gXSQgDIVOoO+QRxIpB8CgAkvp02SXWI/bitcHbtHc/jpRvwP2hY84ubesKc1zfJWphD3ardKt2Hngy2sBnVzRukQCKFoXZg+AyS5v0pz3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dMRA0ur3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FMA3i2Lg; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dMRA0ur3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FMA3i2Lg"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D255B11400D4
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 31 Mar 2025 04:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743410493;
	 x=1743496893; bh=NsTWpRmeqRQ2r7bNt07bFQv2sErTEnKzM6CdlrUkZoU=; b=
	dMRA0ur3jm0IaV153KiNcGQnZun+bt09xgsVnEfg/zLVxBxK1nrNkIVD/XpTizzW
	3wVcbr3XZOP3uhbq9btaSxqfLT+pRGZo5JF0GxsN5wJboVkc6l+RD1MBiJS61NKY
	DcpJXBqcIn1bKdaF7mt926wA4upbMF4AbBDlE87KA0BgTrlN99nAVxmuq46UVViU
	YxCr8I3ctSF17yAXvhQXwi8l+f1FvbdMxHCjcHjtwqWeEFuqeCjxLKxUySBzvgFM
	xVa0gS7oUkt3fDYIl5U/nEcqMdSx2H2J/9rwhxXN15rWC4+dgbk1HoN4SoRGmEcB
	d6JvQOA0BYDCAD1JtI0xWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743410493; x=
	1743496893; bh=NsTWpRmeqRQ2r7bNt07bFQv2sErTEnKzM6CdlrUkZoU=; b=F
	MA3i2LgNjDEPi9gvtzIMCcEq8EDnxw4GKPJLwqMUO/DlbXP/m1hjKrQnrJ8NeEPU
	cMdZ4LZ8VZJwwWe1Q0StKoiUFiw7vRzoKAgzqceb4F3tC0u2iiRIeI+zTslha+GI
	tY3gVIlZy+OfIuyxdXklyIfdtKJzGuR315GDTx+mJ6UaSfGyRcr3a/kSqTWMuiYe
	N0JdSDamePeffJWslKtr1p9SIHAVN18kI1gwAHD1gxOW0lIVHqI/fr3Spnuz5LqS
	I9oVNZVFK2J51ghJdM053OGieXSwBuiVBABqCI7eAbqEjWpV5Hq6gVMjiVgGctLJ
	3yJPnSteICNN9LagrF1hw==
X-ME-Sender: <xms:PVXqZ3vEsbZ5izPcruJUIsJXdBmsigjkTl3A2-pJWQU4F0-vaUDpHg>
    <xme:PVXqZ4dGkZMPKc1ezjKeF_qAfnXU9zwF5j6DPR1SrY5FxfyCCPWJgOr2qxiVv6aH5
    F1roHIKJmqJx7xnKg>
X-ME-Received: <xmr:PVXqZ6ypDGjvP9bhzLNJOIQjYynJ628SRu9vkRG9ID6EDYa9QBNQ2fVQjxWsn-XV7291c4MgSv-w11KdSYwMcExNdW2qkGB6VHHpDT5a9OCFjDhM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PVXqZ2MySIVuzt0vK6vmaKEdP-SOc1RBbWo7BY88LaYW_kvyVuraIg>
    <xmx:PVXqZ38qiia_zoRQg6Imhdgum9R69v75n1C-xO-yCNB-PPWOMQ-q5w>
    <xmx:PVXqZ2XO_FqSFKF0Kvza-dMgBhT02DmzfV3q6RJO9465x2d0rmCDTw>
    <xmx:PVXqZ4cwzCyuAQ-nzhxLsivw9MUJ1Mh7QVZSt1m4S6HkkfY6XeaYcg>
    <xmx:PVXqZxkHQOYeROLMODgSXM5KLF9SENrdaHYnOMtqh82ZgJF-L2vh920z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c128e83f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 31 Mar 2025 08:41:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Mar 2025 10:41:30 +0200
Subject: [PATCH 12/16] reftable/block: expose a generic iterator over
 reftable records
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-pks-reftable-polishing-v1-12-ebed5247434c@pks.im>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
In-Reply-To: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Expose a generic iterator over reftable records and expose it via the
public interface. Together with an upcoming iterator for reftable blocks
contained in a table this will allow users to trivially iterate through
blocks and their respective records individually.

This functionality will be used to implement consistency checks for the
reftable backend, which requires more fine-grained control over how we
read data.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c                | 56 +++++++++++++++++++++++++++++
 reftable/block.h                |  2 +-
 reftable/reftable-block.h       |  5 +++
 t/unit-tests/t-reftable-block.c | 78 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/reftable/block.c b/reftable/block.c
index 6e5c1191f5f..fb91090079b 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -10,6 +10,7 @@
 
 #include "blocksource.h"
 #include "constants.h"
+#include "iter.h"
 #include "record.h"
 #include "reftable-error.h"
 #include "system.h"
@@ -581,6 +582,61 @@ int block_iter_seek_key(struct block_iter *it, struct reftable_buf *want)
 	return err;
 }
 
+static int block_iter_seek_void(void *it, struct reftable_record *want)
+{
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	struct block_iter *bi = it;
+	int err;
+
+	if (bi->block->block_type != want->type)
+		return REFTABLE_API_ERROR;
+
+	err = reftable_record_key(want, &buf);
+	if (err < 0)
+		goto out;
+
+	err = block_iter_seek_key(it, &buf);
+	if (err < 0)
+		goto out;
+
+	err = 0;
+
+out:
+	reftable_buf_release(&buf);
+	return err;
+}
+
+static int block_iter_next_void(void *it, struct reftable_record *rec)
+{
+	return block_iter_next(it, rec);
+}
+
+static void block_iter_close_void(void *it)
+{
+	block_iter_close(it);
+}
+
+static struct reftable_iterator_vtable block_iter_vtable = {
+	.seek = &block_iter_seek_void,
+	.next = &block_iter_next_void,
+	.close = &block_iter_close_void,
+};
+
+int reftable_block_init_iterator(const struct reftable_block *b,
+				 struct reftable_iterator *it)
+{
+	struct block_iter *bi;
+
+	REFTABLE_CALLOC_ARRAY(bi, 1);
+	block_iter_init(bi, b);
+
+	assert(!it->ops);
+	it->iter_arg = bi;
+	it->ops = &block_iter_vtable;
+
+	return 0;
+}
+
 void block_writer_release(struct block_writer *bw)
 {
 	deflateEnd(bw->zstream);
diff --git a/reftable/block.h b/reftable/block.h
index 1bfd44f56aa..3d069393922 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -63,7 +63,7 @@ int block_writer_finish(struct block_writer *w);
 /* clears out internally allocated block_writer members. */
 void block_writer_release(struct block_writer *bw);
 
-/* Iterate over entries in a block */
+/* Iterator for records contained in a single block. */
 struct block_iter {
 	/* offset within the block of the next entry to read. */
 	uint32_t next_off;
diff --git a/reftable/reftable-block.h b/reftable/reftable-block.h
index ce1d9d3ce79..ca13e5dd9c3 100644
--- a/reftable/reftable-block.h
+++ b/reftable/reftable-block.h
@@ -13,6 +13,7 @@
 
 #include "reftable-basics.h"
 #include "reftable-blocksource.h"
+#include "reftable-iterator.h"
 
 struct z_stream_s;
 
@@ -60,6 +61,10 @@ int reftable_block_init(struct reftable_block *b,
 /* Release resources allocated by the block. */
 void reftable_block_release(struct reftable_block *b);
 
+/* Initialize a generic record iterator from the given block. */
+int reftable_block_init_iterator(const struct reftable_block *b,
+				 struct reftable_iterator *it);
+
 /* Returns the block type (eg. 'r' for refs). */
 uint8_t reftable_block_type(const struct reftable_block *b);
 
diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index c4ced39a73b..e092d0bb8f8 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -376,12 +376,90 @@ static void t_index_block_read_write(void)
 		reftable_record_release(&recs[i]);
 }
 
+static void t_block_iterator(void)
+{
+	struct reftable_block_source source = { 0 };
+	struct block_writer writer = {
+		.last_key = REFTABLE_BUF_INIT,
+	};
+	struct reftable_record expected_refs[20];
+	struct reftable_ref_record ref = { 0 };
+	struct reftable_iterator it = { 0 };
+	struct reftable_block block = { 0 };
+	struct reftable_buf data;
+	int err;
+
+	data.len = 1024;
+	REFTABLE_CALLOC_ARRAY(data.buf, data.len);
+	check(data.buf != NULL);
+
+	err = block_writer_init(&writer, BLOCK_TYPE_REF, (uint8_t *) data.buf, data.len,
+				0, hash_size(REFTABLE_HASH_SHA1));
+	check(!err);
+
+	for (size_t i = 0; i < ARRAY_SIZE(expected_refs); i++) {
+		expected_refs[i] = (struct reftable_record) {
+			.type = BLOCK_TYPE_REF,
+			.u.ref = {
+				.value_type = REFTABLE_REF_VAL1,
+				.refname = xstrfmt("refs/heads/branch-%02"PRIuMAX, (uintmax_t)i),
+			},
+		};
+		memset(expected_refs[i].u.ref.value.val1, i, REFTABLE_HASH_SIZE_SHA1);
+
+		err = block_writer_add(&writer, &expected_refs[i]);
+		check_int(err, ==, 0);
+	}
+
+	err = block_writer_finish(&writer);
+	check_int(err, >, 0);
+
+	block_source_from_buf(&source, &data);
+	reftable_block_init(&block, &source, 0, 0, data.len, REFTABLE_HASH_SIZE_SHA1);
+
+	err = reftable_block_init_iterator(&block, &it);
+	check_int(err, ==, 0);
+
+	for (size_t i = 0; ; i++) {
+		err = reftable_iterator_next_ref(&it, &ref);
+		if (err > 0) {
+			check_int(i, ==, ARRAY_SIZE(expected_refs));
+			break;
+		}
+		check_int(err, ==, 0);
+
+		check(reftable_ref_record_equal(&ref, &expected_refs[i].u.ref,
+						REFTABLE_HASH_SIZE_SHA1));
+	}
+
+	err = reftable_iterator_seek_ref(&it, "refs/heads/does-not-exist");
+	check_int(err, ==, 0);
+	err = reftable_iterator_next_ref(&it, &ref);
+	check_int(err, ==, 1);
+
+	err = reftable_iterator_seek_ref(&it, "refs/heads/branch-13");
+	check_int(err, ==, 0);
+	err = reftable_iterator_next_ref(&it, &ref);
+	check_int(err, ==, 0);
+	check(reftable_ref_record_equal(&ref, &expected_refs[13].u.ref,
+					REFTABLE_HASH_SIZE_SHA1));
+
+	for (size_t i = 0; i < ARRAY_SIZE(expected_refs); i++)
+		reftable_free(expected_refs[i].u.ref.refname);
+	reftable_ref_record_release(&ref);
+	reftable_iterator_destroy(&it);
+	reftable_block_release(&block);
+	block_writer_release(&writer);
+	reftable_buf_release(&data);
+}
+
 int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 {
 	TEST(t_index_block_read_write(), "read-write operations on index blocks work");
 	TEST(t_log_block_read_write(), "read-write operations on log blocks work");
 	TEST(t_obj_block_read_write(), "read-write operations on obj blocks work");
 	TEST(t_ref_block_read_write(), "read-write operations on ref blocks work");
+	TEST(t_block_iterator(), "block iterator works");
 
 	return test_done();
 }

-- 
2.49.0.604.gff1f9ca942.dirty

