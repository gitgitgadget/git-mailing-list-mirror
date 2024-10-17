Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344B712C484
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 04:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729140846; cv=none; b=c10R/yprma2yYrU2a/huZR2bO3Z24+pd96Fl9CCyFSe1+BYFTvaFFu+WNAcewZf1zRwaNeesZ7GXhESGeYQRSrWjxzHCr19hTmzbR12nyURrGqGY/XKyZjgIszs/qknlzwN/abnupEwTHkrkGPKZAX+FkmUreTomaM5sdMT0d6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729140846; c=relaxed/simple;
	bh=lmX7abqlt/ZiuABfKcqpD84EuKveuhMpdqhwXwFm0WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNvrG9XN68tSqEYJJXjMH40nw5or6kY6IkHDzhzicjA3Gp75F7a1Up9afx4BP8nI1jWqI1cYwQ1vFNHT0aq3IEen7dUZkwDU7XeEf/2zFlOy9WOshd9EGpyTBcahldc0GOiHOgOGxRGhbGPKpCZmVy4JkZTkFM+dEEFst3e0n3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dZhvFEeV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DZckaI/x; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dZhvFEeV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DZckaI/x"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5DD0D11400E5;
	Thu, 17 Oct 2024 00:54:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 17 Oct 2024 00:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729140842; x=1729227242; bh=cGB+p9Z0NE
	2tjPwsXfDbaAxyD+silNw9SyneMxJ1Ml8=; b=dZhvFEeVEgqhAtWYCM6jbLqyl5
	Xl0UaZttCIf/FbbNTTcXtZyErrtBLRa114Wbfer/+CcFS9uOW8MSt4cOX/d9+iJe
	lp9l5mQPC8rJQ/NPx4ov5sRbw12JSVSmle4L7qvyHvTkZXW5f8dquOTXKQvwW/GB
	XlvLXtTaYgehnTEcRTpuYn1H59w5BPRek0RVgPWLBWBNCez9f+y8wZP+MucP9/zm
	TXbdl/XPaRvrjfztGLNaN4Kjw8LF6gUoXSXbe+rB/ketjZp/NsgVYF8zQ3O2uXkU
	1oi4sl6k0r0Z+0P1U5r77QqIWmsd0ZCOsnzfCe/DMNxg5BVPlbYEtRJdCLeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729140842; x=1729227242; bh=cGB+p9Z0NE2tjPwsXfDbaAxyD+si
	lNw9SyneMxJ1Ml8=; b=DZckaI/xc3M327MVj6xwxEMexvrJDcKN7rs9aGEV6i7F
	cWH3QnmFnghpsj6uJ5v4/s78lL2TgoDW+FdsKr9OnNwhY1UI86ynkbxLLQ2nzIYl
	dijQEiejaHNv7Rt0tKPdMdn5O1tGhsN0NHDKVz8pUADXINMt9PynrLrWU4C8Rm3d
	wWgzDetua3m8IA3zA5dqIhFv8NKJKekO3Ai6BjjcSIM6T34ivS1IxT1/au4OsKL1
	Sd59dwxrqQRMAF+vTuIxWOsiWhmkDpPFlxso+V/j3v8c5GWPXV62lEZYsYa2RhAR
	WVaIytJ+Gi4TYp0IrIHcY6nOMKKT1RYb5loQoSD3Og==
X-ME-Sender: <xms:apgQZwOu6e2g0dVV5fqyAOgMZ9NxRndQXoTAzAtjcl4t8_O_zEEY9A>
    <xme:apgQZ2_lj4u9ISquu7_pgu9dR7WNJlBNSAJZiqZFGlc5NEsEeg7DU7UmHz23OZK-r
    mF5vo2p01FvNYLCqg>
X-ME-Received: <xmr:apgQZ3TCGnAAUFVVcbhuFhnP78XPGLR1Zkdq5Aojd6NiIYlegAOroxVk-zFQJmvVhqQogLFTvENW-V9UWerBoUU52-a9P24CIn2pr13FyUq-cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehtddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegvthhhohhmshhonhesvggufi
    grrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:apgQZ4tv7OVRMHvcwbv6HxwVaw93d57lQZ4o0rx84BmJM7lnAYI5yA>
    <xmx:apgQZ4ckSux-qwUc6ZDPN8mHHFEmAqfmYA6r9DeGoeiZk1ZSUCRQsA>
    <xmx:apgQZ81zvXf6PFo_1ZvCdebpKfN-jNITBCsTTp4Cj2-OIfGKcJv25Q>
    <xmx:apgQZ88NTit5cCQz0SvDTaA5IwkGaQYl9C1ZGeHKNDRf01crPm_AlA>
    <xmx:apgQZ9G64eSrjnWCflJAOZhDOH4wiPqzzEjzdXxl4WBimrCEsiHGJeQI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 00:54:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 56b93732 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 04:52:42 +0000 (UTC)
Date: Thu, 17 Oct 2024 06:53:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, shejialuo <shejialuo@gmail.com>
Subject: [PATCH v3 05/10] reftable/blocksource: adapt interface name
Message-ID: <f96328609331e48cee64c1268bc249d7cf2c7ecf.1729140565.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1729140565.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729140565.git.ps@pks.im>

Adapt the name of the `strbuf` block source to no longer relate to this
interface, but instead to the `reftable_buf` interface.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/blocksource.c              | 26 +++++++++++++-------------
 reftable/blocksource.h              |  4 ++--
 t/unit-tests/t-reftable-block.c     |  8 ++++----
 t/unit-tests/t-reftable-merged.c    |  6 +++---
 t/unit-tests/t-reftable-reader.c    |  4 ++--
 t/unit-tests/t-reftable-readwrite.c | 24 ++++++++++++------------
 6 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index d6242d67900..52e0915a67b 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -13,19 +13,19 @@ license that can be found in the LICENSE file or at
 #include "reftable-blocksource.h"
 #include "reftable-error.h"
 
-static void strbuf_return_block(void *b UNUSED, struct reftable_block *dest)
+static void reftable_buf_return_block(void *b UNUSED, struct reftable_block *dest)
 {
 	if (dest->len)
 		memset(dest->data, 0xff, dest->len);
 	reftable_free(dest->data);
 }
 
-static void strbuf_close(void *b UNUSED)
+static void reftable_buf_close(void *b UNUSED)
 {
 }
 
-static int strbuf_read_block(void *v, struct reftable_block *dest, uint64_t off,
-			     uint32_t size)
+static int reftable_buf_read_block(void *v, struct reftable_block *dest,
+				   uint64_t off, uint32_t size)
 {
 	struct reftable_buf *b = v;
 	assert(off + size <= b->len);
@@ -37,23 +37,23 @@ static int strbuf_read_block(void *v, struct reftable_block *dest, uint64_t off,
 	return size;
 }
 
-static uint64_t strbuf_size(void *b)
+static uint64_t reftable_buf_size(void *b)
 {
 	return ((struct reftable_buf *)b)->len;
 }
 
-static struct reftable_block_source_vtable strbuf_vtable = {
-	.size = &strbuf_size,
-	.read_block = &strbuf_read_block,
-	.return_block = &strbuf_return_block,
-	.close = &strbuf_close,
+static struct reftable_block_source_vtable reftable_buf_vtable = {
+	.size = &reftable_buf_size,
+	.read_block = &reftable_buf_read_block,
+	.return_block = &reftable_buf_return_block,
+	.close = &reftable_buf_close,
 };
 
-void block_source_from_strbuf(struct reftable_block_source *bs,
-			      struct reftable_buf *buf)
+void block_source_from_buf(struct reftable_block_source *bs,
+			   struct reftable_buf *buf)
 {
 	assert(!bs->ops);
-	bs->ops = &strbuf_vtable;
+	bs->ops = &reftable_buf_vtable;
 	bs->arg = buf;
 }
 
diff --git a/reftable/blocksource.h b/reftable/blocksource.h
index ee3647c6531..a84a3ccd891 100644
--- a/reftable/blocksource.h
+++ b/reftable/blocksource.h
@@ -15,7 +15,7 @@ struct reftable_block_source;
 struct reftable_buf;
 
 /* Create an in-memory block source for reading reftables */
-void block_source_from_strbuf(struct reftable_block_source *bs,
-			      struct reftable_buf *buf);
+void block_source_from_buf(struct reftable_block_source *bs,
+			   struct reftable_buf *buf);
 
 #endif
diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index 56514b43630..df1d45fe8e4 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -34,7 +34,7 @@ static void t_ref_block_read_write(void)
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
 	check(block.data != NULL);
 	block.len = block_size;
-	block_source_from_strbuf(&block.source ,&buf);
+	block_source_from_buf(&block.source ,&buf);
 	ret = block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
 				header_off, hash_size(GIT_SHA1_FORMAT_ID));
 	check(!ret);
@@ -128,7 +128,7 @@ static void t_log_block_read_write(void)
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
 	check(block.data != NULL);
 	block.len = block_size;
-	block_source_from_strbuf(&block.source ,&buf);
+	block_source_from_buf(&block.source ,&buf);
 	ret = block_writer_init(&bw, BLOCK_TYPE_LOG, block.data, block_size,
 				header_off, hash_size(GIT_SHA1_FORMAT_ID));
 	check(!ret);
@@ -218,7 +218,7 @@ static void t_obj_block_read_write(void)
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
 	check(block.data != NULL);
 	block.len = block_size;
-	block_source_from_strbuf(&block.source, &buf);
+	block_source_from_buf(&block.source, &buf);
 	ret = block_writer_init(&bw, BLOCK_TYPE_OBJ, block.data, block_size,
 				header_off, hash_size(GIT_SHA1_FORMAT_ID));
 	check(!ret);
@@ -302,7 +302,7 @@ static void t_index_block_read_write(void)
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
 	check(block.data != NULL);
 	block.len = block_size;
-	block_source_from_strbuf(&block.source, &buf);
+	block_source_from_buf(&block.source, &buf);
 	ret = block_writer_init(&bw, BLOCK_TYPE_INDEX, block.data, block_size,
 				header_off, hash_size(GIT_SHA1_FORMAT_ID));
 	check(!ret);
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 9b0162a4b32..484c18251f3 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -35,7 +35,7 @@ merged_table_from_records(struct reftable_ref_record **refs,
 
 	for (size_t i = 0; i < n; i++) {
 		t_reftable_write_to_buf(&buf[i], refs[i], sizes[i], NULL, 0, &opts);
-		block_source_from_strbuf(&(*source)[i], &buf[i]);
+		block_source_from_buf(&(*source)[i], &buf[i]);
 
 		err = reftable_reader_new(&(*readers)[i], &(*source)[i],
 					  "name");
@@ -293,7 +293,7 @@ merged_table_from_log_records(struct reftable_log_record **logs,
 
 	for (size_t i = 0; i < n; i++) {
 		t_reftable_write_to_buf(&buf[i], NULL, 0, logs[i], sizes[i], &opts);
-		block_source_from_strbuf(&(*source)[i], &buf[i]);
+		block_source_from_buf(&(*source)[i], &buf[i]);
 
 		err = reftable_reader_new(&(*readers)[i], &(*source)[i],
 					  "name");
@@ -442,7 +442,7 @@ static void t_default_write_opts(void)
 	check(!err);
 	reftable_writer_free(w);
 
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 
 	err = reftable_reader_new(&rd, &source, "filename");
 	check(!err);
diff --git a/t/unit-tests/t-reftable-reader.c b/t/unit-tests/t-reftable-reader.c
index 8a18d7f9be4..19cb53b6415 100644
--- a/t/unit-tests/t-reftable-reader.c
+++ b/t/unit-tests/t-reftable-reader.c
@@ -20,7 +20,7 @@ static int t_reader_seek_once(void)
 	int ret;
 
 	t_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 
 	ret = reftable_reader_new(&reader, &source, "name");
 	check(!ret);
@@ -61,7 +61,7 @@ static int t_reader_reseek(void)
 	int ret;
 
 	t_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 
 	ret = reftable_reader_new(&reader, &source, "name");
 	check(!ret);
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index c56a33f1a1e..7c7c72bb162 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -24,7 +24,7 @@ static void t_buffer(void)
 	int n;
 	uint8_t in[] = "hello";
 	reftable_buf_add(&buf, in, sizeof(in));
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 	check_int(block_source_size(&source), ==, 6);
 	n = block_source_read_block(&source, &out, 0, sizeof(in));
 	check_int(n, ==, sizeof(in));
@@ -207,7 +207,7 @@ static void t_log_write_read(void)
 	reftable_writer_free(w);
 	w = NULL;
 
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 
 	err = reftable_reader_new(&reader, &source, "file.log");
 	check(!err);
@@ -298,7 +298,7 @@ static void t_log_zlib_corruption(void)
 	/* corrupt the data. */
 	buf.buf[50] ^= 0x99;
 
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 
 	err = reftable_reader_new(&reader, &source, "file.log");
 	check(!err);
@@ -328,7 +328,7 @@ static void t_table_read_write_sequential(void)
 
 	write_table(&names, &buf, N, 256, GIT_SHA1_FORMAT_ID);
 
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 
 	err = reftable_reader_new(&reader, &source, "file.ref");
 	check(!err);
@@ -380,7 +380,7 @@ static void t_table_read_api(void)
 
 	write_table(&names, &buf, N, 256, GIT_SHA1_FORMAT_ID);
 
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 
 	err = reftable_reader_new(&reader, &source, "file.ref");
 	check(!err);
@@ -416,7 +416,7 @@ static void t_table_read_write_seek(int index, int hash_id)
 
 	write_table(&names, &buf, N, 256, hash_id);
 
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 
 	err = reftable_reader_new(&reader, &source, "file.ref");
 	check(!err);
@@ -538,7 +538,7 @@ static void t_table_refs_for(int indexed)
 	reftable_writer_free(w);
 	w = NULL;
 
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 
 	err = reftable_reader_new(&reader, &source, "file.ref");
 	check(!err);
@@ -600,7 +600,7 @@ static void t_write_empty_table(void)
 
 	check_int(buf.len, ==, header_size(1) + footer_size(1));
 
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 
 	err = reftable_reader_new(&rd, &source, "filename");
 	check(!err);
@@ -806,7 +806,7 @@ static void t_write_multiple_indices(void)
 	check_int(stats->obj_stats.index_offset, >, 0);
 	check_int(stats->log_stats.index_offset, >, 0);
 
-	block_source_from_strbuf(&source, &writer_buf);
+	block_source_from_buf(&source, &writer_buf);
 	err = reftable_reader_new(&reader, &source, "filename");
 	check(!err);
 
@@ -863,7 +863,7 @@ static void t_write_multi_level_index(void)
 	stats = reftable_writer_stats(writer);
 	check_int(stats->ref_stats.max_index_level, ==, 2);
 
-	block_source_from_strbuf(&source, &writer_buf);
+	block_source_from_buf(&source, &writer_buf);
 	err = reftable_reader_new(&reader, &source, "filename");
 	check(!err);
 
@@ -889,7 +889,7 @@ static void t_corrupt_table_empty(void)
 	struct reftable_reader *reader;
 	int err;
 
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 	err = reftable_reader_new(&reader, &source, "file.log");
 	check_int(err, ==, REFTABLE_FORMAT_ERROR);
 }
@@ -903,7 +903,7 @@ static void t_corrupt_table(void)
 	int err;
 	reftable_buf_add(&buf, zeros, sizeof(zeros));
 
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 	err = reftable_reader_new(&reader, &source, "file.log");
 	check_int(err, ==, REFTABLE_FORMAT_ERROR);
 
-- 
2.47.0.72.gef8ce8f3d4.dirty

