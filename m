Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A10255259
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031799; cv=none; b=QwgpbZD12JDkZRsoG2EJpdD8FCRh3ntAqOtCjwESPOINm6OtQlubxv917Yll2i/2dV92Rc7NLrXnT88p4x8+LEK87CZCrwOlLKQb4Wy5HG0dLys8lSzE7pCiRGuW36XDaOQHOW8XeQ9GOAjjgilszUe5ATde6Dsx+03VwJwNHRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031799; c=relaxed/simple;
	bh=IOIqBBW4tLu63BUvggvZJe8cQW9+9RnwA8bzlcFeW9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sMxvEg602zTI2ryvj6dMRe9ValAWuIHDBU0pqZ5OeM13BiHBua6xf0TeAG55DvenR3QbbnZ7PE+UHJwFP21tjRKgk87fz+38zVweHA1C9+RDenhS4/QMr9WTwnbXb9RIjPFD2pGwgQ97+WxSvJ6/xp3UXUFE8xWpqBQFXX2fVAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mxhhMlkm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ePKhUnqW; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mxhhMlkm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ePKhUnqW"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 35C99114021F;
	Mon,  7 Apr 2025 09:16:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 07 Apr 2025 09:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744031797;
	 x=1744118197; bh=xIXToqpfHdZqMhx9+OhI5WhlGTDm87psX3u4TMU4iSk=; b=
	mxhhMlkm8eWaB30B7dhMqlPJLEXUgOoZfZ6SeAlxEUyVXWjGA9RNGVq8igB9Z+c6
	cKEya0KEqtWznmm7MZP269cJB3vY56o9eM5UrkJAtZaEfsicJ8S1hlELTJ7U5wdW
	Ny3lOvURY8dMYq18JFz+9Cj6zmadmcnz1dg9pKu7W1t6tiZ576/aXGgfhPSkJMES
	uRNqt83uwU9xppy14sQsX2LEcL392V+KnjIpuSGM2m9ebjqul0z6xNrWle9KzY1o
	RFZDFEgsYvmaJHFRvPgLZViuWYoO0uaikj2e/a5RcN6sK8wow9N1ewEdMD9CJt+H
	0IN66qYcy1OhuHVZBDz30g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744031797; x=
	1744118197; bh=xIXToqpfHdZqMhx9+OhI5WhlGTDm87psX3u4TMU4iSk=; b=e
	PKhUnqWLXgOFfEdFZImgB7YGzsETv6rbQKTP6ht3+DV+cy3bG7n17tU2zlTX2j1M
	2UYjp6S3OB267cF6clFxa4m4vILSjPcUo3NcgzEmvDw6fdF6jNqi0IvQXaNXT5g+
	HQgVvYol+25HViW8QNjVo/UgxM8SRRZz4w5VMDQjPQQ3EMKMz2mjCZBkexcfUkEl
	blvF2bFbJuN12DPixNdi1hOdhKsUEwpsLjXd6HNYGXgaTPSDvqI57XqPI7sl4Zqm
	LNzrs8HrFP8EH73uaTObX4eRKA6goLETgn7lsmHfi6F0682d9aBoGuH5/TKXF8oD
	G4U84qW9bLQ1fPpb6XZFw==
X-ME-Sender: <xms:NdDzZ00wc37AD3SrFBpDhIvRXyyWm-Dgni9xVCjhZo__AxzxUXzPpA>
    <xme:NdDzZ_HaYunHLlP7DdcdpppZQSJpWFWdpABoTba3dUu0y99MynGn1oSoGX6SueVK3
    lfvXqY6WHh9Nl6jyQ>
X-ME-Received: <xmr:NdDzZ84WWPtlwwwiNZLXdUqbdpGWtUH4zJ7xt2qZ5-S4CjfKk8CdJyaHERXUbAHmKNi1M-PQswbnXd2MA8d5Im72pGlGVDwyuM9KndtvmfLZ7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NdDzZ901yhcn8TiCic0F-P2abSgcxmHKcqAWYbe_Yitujj6qOQP4NQ>
    <xmx:NdDzZ3FBfVdznXGLFlrlM9z6uML4A85xVEHTWrw9Rg-Ad2Ka7YuOvg>
    <xmx:NdDzZ2__MpwrRHlM1uaPoE56VQWtGQKXjbweuoMk8ZaVL8CZbLA2gg>
    <xmx:NdDzZ8kNJoIeR0Epl4DhANaNDHAY_usmUYOPdJXYdP2gAs6nbb9CjA>
    <xmx:NdDzZwzFGPcMRa0Fy3OB6L5DREwNgvIVxlWzSvDCbwye7r3owvAslvmg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 09:16:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 12f7b3eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 13:16:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Apr 2025 15:16:26 +0200
Subject: [PATCH v2 14/16] reftable/table: introduce iterator for table
 blocks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-pks-reftable-polishing-v2-14-316c4ff10571@pks.im>
References: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
In-Reply-To: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Introduce a new iterator that allows the caller to iterate through all
blocks contained in a table. This gives users more fine-grained control
over how exactly those blocks are being read and exposes information to
callers that was previously inaccessible.

This iterator will be required by a future patch series that adds
consistency checks for the reftable backend. In addition to that though
we will also reimplement `reftable_table_print_blocks()` on top of this
new iterator in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-table.h       |  16 ++++++
 reftable/table.c                |  47 +++++++++++++++++
 t/unit-tests/t-reftable-table.c | 110 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+)

diff --git a/reftable/reftable-table.h b/reftable/reftable-table.h
index a78db9eea7e..4d61ce6cf77 100644
--- a/reftable/reftable-table.h
+++ b/reftable/reftable-table.h
@@ -10,6 +10,7 @@
 #define REFTABLE_TABLE_H
 
 #include "reftable-iterator.h"
+#include "reftable-block.h"
 #include "reftable-blocksource.h"
 
 /*
@@ -99,4 +100,19 @@ uint64_t reftable_table_min_update_index(struct reftable_table *t);
 /* print blocks onto stdout for debugging. */
 int reftable_table_print_blocks(const char *tablename);
 
+/*
+ * An iterator that iterates through the blocks contained in a given table.
+ */
+struct reftable_table_iterator {
+	void *iter_arg;
+};
+
+int reftable_table_iterator_init(struct reftable_table_iterator *it,
+				 struct reftable_table *t);
+
+void reftable_table_iterator_release(struct reftable_table_iterator *it);
+
+int reftable_table_iterator_next(struct reftable_table_iterator *it,
+				 const struct reftable_block **out);
+
 #endif
diff --git a/reftable/table.c b/reftable/table.c
index 50ffad7edcb..a2a0c7a1d2f 100644
--- a/reftable/table.c
+++ b/reftable/table.c
@@ -804,3 +804,50 @@ int reftable_table_print_blocks(const char *tablename)
 	table_iter_close(&ti);
 	return err;
 }
+
+int reftable_table_iterator_init(struct reftable_table_iterator *it,
+				 struct reftable_table *t)
+{
+	struct table_iter *ti;
+	int err;
+
+	REFTABLE_ALLOC_ARRAY(ti, 1);
+	if (!ti)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
+
+	err = table_iter_init(ti, t);
+	if (err < 0)
+		goto out;
+
+	it->iter_arg = ti;
+	err = 0;
+
+out:
+	if (err < 0)
+		reftable_free(ti);
+	return err;
+}
+
+void reftable_table_iterator_release(struct reftable_table_iterator *it)
+{
+	if (!it->iter_arg)
+		return;
+	table_iter_close(it->iter_arg);
+	reftable_free(it->iter_arg);
+	it->iter_arg = NULL;
+}
+
+int reftable_table_iterator_next(struct reftable_table_iterator *it,
+				 const struct reftable_block **out)
+{
+	struct table_iter *ti = it->iter_arg;
+	int err;
+
+	err = table_iter_next_block(ti);
+	if (err)
+		return err;
+
+	*out = &ti->block;
+
+	return 0;
+}
diff --git a/t/unit-tests/t-reftable-table.c b/t/unit-tests/t-reftable-table.c
index 77c59dbf46d..ba39cdf9a76 100644
--- a/t/unit-tests/t-reftable-table.c
+++ b/t/unit-tests/t-reftable-table.c
@@ -1,7 +1,10 @@
 #include "test-lib.h"
 #include "lib-reftable.h"
 #include "reftable/blocksource.h"
+#include "reftable/constants.h"
+#include "reftable/iter.h"
 #include "reftable/table.h"
+#include "strbuf.h"
 
 static int t_table_seek_once(void)
 {
@@ -88,9 +91,116 @@ static int t_table_reseek(void)
 	return 0;
 }
 
+static int t_table_block_iterator(void)
+{
+	struct reftable_block_source source = { 0 };
+	struct reftable_table_iterator it = { 0 };
+	struct reftable_ref_record *records;
+	const struct reftable_block *block;
+	struct reftable_table *table;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	struct {
+		uint8_t block_type;
+		uint16_t header_off;
+		uint16_t restart_count;
+		uint16_t record_count;
+	} expected_blocks[] = {
+		{
+			.block_type = BLOCK_TYPE_REF,
+			.header_off = 24,
+			.restart_count = 10,
+			.record_count = 158,
+		},
+		{
+			.block_type = BLOCK_TYPE_REF,
+			.restart_count = 10,
+			.record_count = 159,
+		},
+		{
+			.block_type = BLOCK_TYPE_REF,
+			.restart_count = 10,
+			.record_count = 159,
+		},
+		{
+			.block_type = BLOCK_TYPE_REF,
+			.restart_count = 2,
+			.record_count = 24,
+		},
+		{
+			.block_type = BLOCK_TYPE_INDEX,
+			.restart_count = 1,
+			.record_count = 4,
+		},
+		{
+			.block_type = BLOCK_TYPE_OBJ,
+			.restart_count = 1,
+			.record_count = 1,
+		},
+	};
+	const size_t nrecords = 500;
+	int ret;
+
+	REFTABLE_CALLOC_ARRAY(records, nrecords);
+	for (size_t i = 0; i < nrecords; i++) {
+		records[i].value_type = REFTABLE_REF_VAL1;
+		records[i].refname = xstrfmt("refs/heads/branch-%03"PRIuMAX,
+					     (uintmax_t) i);
+	}
+
+	t_reftable_write_to_buf(&buf, records, nrecords, NULL, 0, NULL);
+	block_source_from_buf(&source, &buf);
+
+	ret = reftable_table_new(&table, &source, "name");
+	check(!ret);
+
+	ret = reftable_table_iterator_init(&it, table);
+	check(!ret);
+
+	for (size_t i = 0; i < ARRAY_SIZE(expected_blocks); i++) {
+		struct reftable_iterator record_it = { 0 };
+		struct reftable_record record = {
+			.type = expected_blocks[i].block_type,
+		};
+
+		ret = reftable_table_iterator_next(&it, &block);
+		check(!ret);
+
+		check_int(block->block_type, ==, expected_blocks[i].block_type);
+		check_int(block->header_off, ==, expected_blocks[i].header_off);
+		check_int(block->restart_count, ==, expected_blocks[i].restart_count);
+
+		ret = reftable_block_init_iterator(block, &record_it);
+		check(!ret);
+
+		for (size_t j = 0; ; j++) {
+			ret = iterator_next(&record_it, &record);
+			if (ret > 0) {
+				check_int(j, ==, expected_blocks[i].record_count);
+				break;
+			}
+			check(!ret);
+		}
+
+		reftable_iterator_destroy(&record_it);
+		reftable_record_release(&record);
+	}
+
+	ret = reftable_table_iterator_next(&it, &block);
+	check_int(ret, ==, 1);
+
+	for (size_t i = 0; i < nrecords; i++)
+		reftable_free(records[i].refname);
+	reftable_table_iterator_release(&it);
+	reftable_table_decref(table);
+	reftable_buf_release(&buf);
+	reftable_free(records);
+	return 0;
+}
+
 int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 {
 	TEST(t_table_seek_once(), "table can seek once");
 	TEST(t_table_reseek(), "table can reseek multiple times");
+	TEST(t_table_block_iterator(), "table can iterate through blocks");
 	return test_done();
 }

-- 
2.49.0.604.gff1f9ca942.dirty

