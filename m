Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5B8255244
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031797; cv=none; b=CcYfcUPO78XOpxqbtAZndy2+93geReUzOuVmsxTAncXeVmaowzF5ebO96qnHtKHFOivf69SLEuzwTMCLIpOrQSSlM8TB2OgkYiPgXIJROVxYv8SOyzPbuz235ESHcVKgUIhZdfUhVGM8eDxGHjiuZk3RnS/lksgiD27vCWymTE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031797; c=relaxed/simple;
	bh=ka5i/d5p92Ar1syh3xWWJ548/SYGUxiOQytW1kxNRgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WmaeIEcmJ6IftkR3tCBWvqpuBTaR1NQAMJ+0JXwY5lt+T8MKy9leb1CHau84RQkLYN6pDqaTEEi07eObrGOEc6A23RhaCeju8Wf0fcFN0TWc0xjZnQkQNqKRzgHLUf83XhztXzkIIpW1v0/Do4kYuwTJ9tJ++uDTtd+6ORCrUUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nqWT1G8j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lQKDdGZP; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nqWT1G8j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lQKDdGZP"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id D0A7A1380228;
	Mon,  7 Apr 2025 09:16:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 07 Apr 2025 09:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744031794;
	 x=1744118194; bh=1rKZfBUcFZB2jL4FEPdoHeykQsUsGCiu+J7bJrelkTE=; b=
	nqWT1G8jkwstk8xcvSvJpOcRQNNaDN/5ZMUc0o6ymF9a2gx5LnB4nl3DvzstoGRD
	NdU3M2lDvlK5XH00zc6EDexbrFbM4o0z180+xrTXdFKYtxpfCBSrqt8zABDsGnXv
	ur+9NQZpQ5iNf5pj+Vlb3l0WAxj1x3X7kRhVONVnH/CIrnXwAL70nb+qlLKy5Ppn
	zuszNcd13tcmJ4sLYMB/N7xspJyMv/PUmB6tIqywtByDKBcbHpTtdnRVpVFedF6n
	rJYukfYxUQGekaEiuq3bLd8t/audzPnjhDYxfH17pzRBJ+HP1uLaPFjJnkGBS+7m
	0F+5+gMCfKwIlzYmlhdq1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744031794; x=
	1744118194; bh=1rKZfBUcFZB2jL4FEPdoHeykQsUsGCiu+J7bJrelkTE=; b=l
	QKDdGZPYA07PBjb4LwzjD/7ED+Wkz42jGEpKrSh2dKPsSTJ0Sdb7XOAmbonxH/JM
	GxmJj887kJQqHvqT2XI+OPCPrXm5xNdxm3mr38/14rg3U9QoPoZBlfUmqZZNFjez
	ZsJJSnAh3IY8envqSwsmH9/ppwIbzRpzZbxBYdzUkS/b/XIlJWds3KCOPWqRzJSP
	4dzjzSRJeU8HFZZXsQ8cah0TYEIPnWXlZa4oAMBusO78LK934O/80poKR3n5Wikh
	+q7+6GshQR6YtgK+IFotiPZxZUMBZ9Wf0HAG3ZFqq9w3R7/m8fmhYjACfhLQ88eD
	2C+R7uoTckeIyPgv883VA==
X-ME-Sender: <xms:MtDzZ4KZXxAThYQ9HzJFExNw9AP0It9JtjhhUxfqTkRTTjDXH7757w>
    <xme:MtDzZ4JEbWQWWBaC-XeIyWomNIK1y08QFPGgbQeL0luEFkHfCjrq28Yuff8aUHRgK
    OBWw7SWMTBvmZa6Fg>
X-ME-Received: <xmr:MtDzZ4tPS8mSKKtPSWBG0mrjkxlZ23pAEDzuA0SOswxP0nZRxiqQJgTnNrkR-khxfHNPWh8PNObJ_uyaljzrxbTbzrAgQyMjyZeUfQ7ftwJAAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:MtDzZ1Ysj4HS8Dj_bW3OhKfTbthzfVQLRC4ELu797cJldSxOVaJgnQ>
    <xmx:MtDzZ_boVntDPN-O5s6rkeYtx46lQC6-7lmdyHgVeqbMGf6k98LYpg>
    <xmx:MtDzZxDR_DD5yYFdUELruL21VO01wwfqfNT7sCCT-qfo9VUVS48THQ>
    <xmx:MtDzZ1b11gwYQtH2xtOwPc_ADOOoIiXxvpL_e5PYpRsk0NV4pLDaUQ>
    <xmx:MtDzZ54goj962oMiaFUT4QZAfjyfdXyqmpnPUzqigYr0PmwjyuJKUS1G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 09:16:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5f0fdae0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 13:16:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Apr 2025 15:16:24 +0200
Subject: [PATCH v2 12/16] reftable/block: expose a generic iterator over
 reftable records
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-pks-reftable-polishing-v2-12-316c4ff10571@pks.im>
References: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
In-Reply-To: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
index 20712be7eee..08e22170d56 100644
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
index 13bd68be8c5..04c3b518c87 100644
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
index 9f91d697f6d..5577a5769ed 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -372,12 +372,90 @@ static void t_index_block_read_write(void)
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

