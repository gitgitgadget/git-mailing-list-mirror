Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6A7193413
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422377; cv=none; b=pply4za8wAApPsXIT/xcp1cntjvrd2oJZcuUj3NyIS2teGxC/WgRG/q9dTWvDewHVXUhQ79jHAJIJzZuVapo0PYb84IOz1DgsDitOPIb20p/kMxaepEaWBCvvDlKQURRV9F/Yr1aLw3L6k07fYqGtxLGqIdFqV/7SH7cVi2u2pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422377; c=relaxed/simple;
	bh=sFdVDPk55EoeYZDxdtgVnP3DOVZcLom3kSAVezWQ59U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3oWXNaarjmwtwanNGg1i7/zpsZ04Kg2EAsKoFGT9sqvNmWZxzAOHLjhuFGvlXcSqoQZ/QhOmXRTU3h2jLQsmR7FPv3qPZ87LsceAz/xEnAY0juxtfRIw/mGrK8rqRx3ncbvngUBvXKUcUTK0EraxeDu2NUCAU4Xg7uCdwPsFs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nfdIwrFd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cUsVMdUe; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nfdIwrFd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cUsVMdUe"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A7C2D1151A25;
	Fri, 23 Aug 2024 10:12:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 23 Aug 2024 10:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724422374; x=1724508774; bh=eN7XuBg+Tg
	1Nwuk2CcYL4Uv7dt+00TnZkTfhdWKT56k=; b=nfdIwrFdO2tyOFhN1MgP9hxNMZ
	DPdrCdzSpNhlA/Y8o8nqkCFP7OFi4A5R47C/swlYdWvbIdDisSJvaGexczNG3KQ8
	4GiSl21usEOBOXoJdmhQQCT+ifvJaYYkxaGy5KoBlMmkdQe+AjtBza7AH4q3HGgb
	h4C99POURrgGYqO6S4ys/Hd38Oi4m08kCS0dK/ghFaJH0/b1n6OGCjtSHpB0DB2Q
	zyqg3m2p4fKslMF1Aet454vocW12A7kIA3NfWnJInKxg9P20fdjabYS8SLcdr6nh
	W6tvQ1YEJQPach32zmzHrWcGsOEV+IaqOwru3s4rp/enDTG021qz8jg1YhKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724422374; x=1724508774; bh=eN7XuBg+Tg1Nwuk2CcYL4Uv7dt+0
	0TnZkTfhdWKT56k=; b=cUsVMdUe6LH2+44PrXx64fJeqB+kNwn4mPrBoBH5Ck+v
	CC4BMkNjuz10rsiD7qvFuXy9xAgZOM0xpFY+edMtEjH07d4ea/WiUIwTviL8O4yG
	RPX/QV7IR30A4TcmjafZ8rvRYdoiaxAo1imv6L5zMt+idU041hpOGa63xH0IWv8a
	7TKU7VBaGKhC4lAYRxGeq2g6/vbJ9KxELVLwgkJs9XAbkm2dEyPB7WOXnQmJ6Y10
	agBuIzQOITJh+YlNAR0zKJvgCxFBy+AuxUR/5/t0LbPOGGI7eKggMmGk241p8shV
	orrGfAMY4QAVTNVo4do/bWC6ZsVHUPnK0XR7+NkoTQ==
X-ME-Sender: <xms:5pjIZlVTgoBgGvaSI55HJh7en0ltSwsQicygs_F9l4SHZI4X7Z6YCA>
    <xme:5pjIZln1rZ4f0iLqJ72henD3nwI0wwPyFksEH27nTYnyCz9LQWspAXQy1x3GGjdbJ
    nfj3ljUeM7X6ruC5g>
X-ME-Received: <xmr:5pjIZhbF6y0MZq8LoXun42Gl9nKe-xONL8WcAvQBxm2x0X8rOsDpN-CxQpn3dNsUEqnZ_pemOEVoRd8szXWlkvJHU5oWZkmQmZa8shMQh5oD1yYRSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvvddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:5pjIZoUaoGkMO-GuGhh1yydcVihiV-TxXRa2PgWtFuI913TytjTJjw>
    <xmx:5pjIZvmM3tW0oDsfhpQWfTviDFHg-g_4u_fnypVWq1NXykJQZxR_vg>
    <xmx:5pjIZldY3GahxSw5o3CiEHPovnMPiKOEKudnzTgdP2lY1VX4NHV64w>
    <xmx:5pjIZpFYARgPnmqOh6Vvf0u1Ronc4KHPzYGni4Tjwgdks-xkVglkMw>
    <xmx:5pjIZoAIFR_-at3LtQ1NBCp8vzWkhoMEpJIW1M9yMQu5vilZYWY7cT5y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Aug 2024 10:12:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 30781810 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Aug 2024 14:12:16 +0000 (UTC)
Date: Fri, 23 Aug 2024 16:12:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, karthik nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/10] reftable/reader: keep readers alive during iteration
Message-ID: <8d08c3bc515db8a3d7fc0a617a2cf1025164f472.1724420744.git.ps@pks.im>
References: <cover.1724080006.git.ps@pks.im>
 <cover.1724420744.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724420744.git.ps@pks.im>

The lifetime of a table iterator may survive the lifetime of a reader
when the stack gets reloaded. Keep the reader from being released by
increasing its refcount while the iterator is still being used.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c     |  2 ++
 reftable/stack_test.c | 50 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/reftable/reader.c b/reftable/reader.c
index 64a0953e687..f8770990876 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -175,6 +175,7 @@ static int table_iter_init(struct table_iter *ti, struct reftable_reader *r)
 {
 	struct block_iter bi = BLOCK_ITER_INIT;
 	memset(ti, 0, sizeof(*ti));
+	reftable_reader_incref(r);
 	ti->r = r;
 	ti->bi = bi;
 	return 0;
@@ -262,6 +263,7 @@ static void table_iter_close(struct table_iter *ti)
 {
 	table_iter_block_done(ti);
 	block_iter_close(&ti->bi);
+	reftable_reader_decref(ti->r);
 }
 
 static int table_iter_next_block(struct table_iter *ti)
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index bc3bf772749..7fb5beb7c94 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -1076,6 +1076,55 @@ static void test_reftable_stack_compaction_concurrent_clean(void)
 	clear_dir(dir);
 }
 
+static void test_reftable_stack_read_across_reload(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct reftable_stack *st1 = NULL, *st2 = NULL;
+	struct reftable_ref_record rec = { 0 };
+	struct reftable_iterator it = { 0 };
+	char *dir = get_tmp_dir(__LINE__);
+	int err;
+
+	/* Create a first stack and set up an iterator for it. */
+	err = reftable_new_stack(&st1, dir, &opts);
+	EXPECT_ERR(err);
+	write_n_ref_tables(st1, 2);
+	EXPECT(st1->merged->readers_len == 2);
+	reftable_stack_init_ref_iterator(st1, &it);
+	err = reftable_iterator_seek_ref(&it, "");
+	EXPECT_ERR(err);
+
+	/* Set up a second stack for the same directory and compact it. */
+	err = reftable_new_stack(&st2, dir, &opts);
+	EXPECT_ERR(err);
+	EXPECT(st2->merged->readers_len == 2);
+	err = reftable_stack_compact_all(st2, NULL);
+	EXPECT_ERR(err);
+	EXPECT(st2->merged->readers_len == 1);
+
+	/*
+	 * Verify that we can continue to use the old iterator even after we
+	 * have reloaded its stack.
+	 */
+	err = reftable_stack_reload(st1);
+	EXPECT_ERR(err);
+	EXPECT(st1->merged->readers_len == 1);
+	err = reftable_iterator_next_ref(&it, &rec);
+	EXPECT_ERR(err);
+	EXPECT(!strcmp(rec.refname, "refs/heads/branch-0000"));
+	err = reftable_iterator_next_ref(&it, &rec);
+	EXPECT_ERR(err);
+	EXPECT(!strcmp(rec.refname, "refs/heads/branch-0001"));
+	err = reftable_iterator_next_ref(&it, &rec);
+	EXPECT(err > 0);
+
+	reftable_ref_record_release(&rec);
+	reftable_iterator_destroy(&it);
+	reftable_stack_destroy(st1);
+	reftable_stack_destroy(st2);
+	clear_dir(dir);
+}
+
 int stack_test_main(int argc, const char *argv[])
 {
 	RUN_TEST(test_empty_add);
@@ -1098,6 +1147,7 @@ int stack_test_main(int argc, const char *argv[])
 	RUN_TEST(test_reftable_stack_auto_compaction_fails_gracefully);
 	RUN_TEST(test_reftable_stack_update_index_check);
 	RUN_TEST(test_reftable_stack_uptodate);
+	RUN_TEST(test_reftable_stack_read_across_reload);
 	RUN_TEST(test_suggest_compaction_segment);
 	RUN_TEST(test_suggest_compaction_segment_nothing);
 	return 0;
-- 
2.46.0.164.g477ce5ccd6.dirty

