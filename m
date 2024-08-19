Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD86612EBD6
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082012; cv=none; b=to9aMkVfDfDgVaWwiUTROM/rowp+mHs2jIsrLyuAGIPbrKzsu3FX4qf5JwnVR3RkxJEZBUiuI4a/9NLJnCJpVs3f/YYF6klu42QfRbLupJp8D5iu5xZx/JStpgeI0AooHfNH8mzGBUch2XGtGrVtBna6AAI6dExLXIH4W10n4Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082012; c=relaxed/simple;
	bh=sTp6cTGyLPzok3ZHNT73VgVsFAYASJpIUVLd8ZaXJYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfHg8MpvsRnnw5FDRKJQ//12ZIerVGoEkqw2Y+9rGLIz6Uk8KTG+F/TUPGWSqHXWFilOBoqJUf2eclyZFV6Z7ELJWDi2/WSlE4T5OUUADsPh18XJsF27GqaesKJKD91dcUiLAnvRhcSlGOMyDljk5mPMTFqYAzdXMunY0ge9mRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DSrkifLn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M4xn3YqO; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DSrkifLn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M4xn3YqO"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id D91C6138FC65;
	Mon, 19 Aug 2024 11:40:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 19 Aug 2024 11:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724082009; x=1724168409; bh=ZEEsth5dCw
	BA5u8Df3iVvEetdfgzg770syaXj96zqM8=; b=DSrkifLn7Pf25RJt2pug5v7fy5
	T0vHphQHdZA6LT7am5+KCmPwWUTX4l0OAvzojPxuFBWdiQoIm1/UNTpqg7XNn7oo
	oV9J0zWaFAPd6QTR/Ccb3omPBYGHqaTupJyVSOSRiA35BtbReAKc+YsC4lL4nrhK
	2kIGtxqDtCFnniqwjsfPZY7cIHLpqK1EJTgyf+R3TXKUEoFirIJkvZ59qO4kCgLL
	753AxhWpj3zIfvBZDlp/EeHpJu3KNMuIVhz1DvcpjdGPXn5EvXpYUYMQI2hxc+a6
	gktk1am8Kf2KAMgVWdAxfh3lBSUq2GHzgsTXRhkb0p1eKQJDgTJJBA5rgbVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724082009; x=1724168409; bh=ZEEsth5dCwBA5u8Df3iVvEetdfgz
	g770syaXj96zqM8=; b=M4xn3YqOdrGh0raD/XQ9vauf14KlySJV0N/TgA7jWZDg
	u+PLa6SqOT1MBnsZ5N5J3/b8nMl/bn0vrZ8oNqTdipXOJf0Whx96FxGREUzE+HEO
	DRJ9z4sj4/FeHtxodD9WA1qIH1lW9f8kQQq+3/kb99D7pM5W6Lzt7rwVkbiwEY/V
	Hmr8a07GRLOzHe9Gj/YolCjwRLLJRkkKt4SdnKflsd5998tQlF83jUM2rwm6WpdI
	Zi2z9gSOhWDgBZnIqJHcXAa2ShC6/B5Sc36IPpQhhy6ScowVk9ZTYhBWQ31eefsp
	4g6h+q6u7U0D9ihaBediGv+es5nGaPXoaI995win9Q==
X-ME-Sender: <xms:WWfDZmBW9Ksm14NFGfJ5B5N8KCDPPwOCMNQIaPE4c_wy36zsp2gtUQ>
    <xme:WWfDZggjGeVmTDyYiig_6xOuadrRQABloNTB571BkMlWkdqTH8jZ-moJQgbXnOB_f
    jejy5n6RztKNGKU7A>
X-ME-Received: <xmr:WWfDZply7VN_BhoFMYzbd413B8r-mua2zUxCTWT7LUVwWMK2zDBBdW6WShiU7O1mM3PVE6r-VkgAZbbbEKIXlW5GTzbv-mnDEAzzDxHyF-tZqPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WWfDZkyt_qjIAZzxPNz7qvamzkaAUTKakScF0xMfa3JbCC2XFOVNpw>
    <xmx:WWfDZrTVdaoDkw8ZhrdVGfvW3koXqOvGsUm00TRh1zjsgeNFLL-8yw>
    <xmx:WWfDZvZRAg25YRShs1UjdjI57EJ3WfypOi2Bl6UZl3d68pXEN_C3JA>
    <xmx:WWfDZkR7BfUVDFE1frjnKols6APh-xZY-CjVZvTPIBT4l-yNjl-8kA>
    <xmx:WWfDZmdlupQc8oO1EB4jZ9SksFK-tTnVkFY71Zd9snu13Ht1PcAzMPPk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 11:40:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a4a70f46 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 15:39:39 +0000 (UTC)
Date: Mon, 19 Aug 2024 17:40:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 08/10] reftable/reader: keep readers alive during iteration
Message-ID: <026820562882afb31d7224c90722e09bef835340.1724080006.git.ps@pks.im>
References: <cover.1724080006.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724080006.git.ps@pks.im>

The lifetime of a table iterator may surive the lifetime of a reader
when the stack gets reloaded. Keep the reader from being released by
increasing its refcount while the iterator is still being used.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c     |  2 ++
 reftable/stack_test.c | 49 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/reftable/reader.c b/reftable/reader.c
index 64a0953e68..f877099087 100644
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
index bc3bf77274..91e716dc0a 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -1076,6 +1076,54 @@ static void test_reftable_stack_compaction_concurrent_clean(void)
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
+
+	/*
+	 * Verify that we can continue to use the old iterator even after we
+	 * have reloaded its stack.
+	 */
+	err = reftable_stack_reload(st1);
+	EXPECT_ERR(err);
+	EXPECT(st2->merged->readers_len == 1);
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
@@ -1098,6 +1146,7 @@ int stack_test_main(int argc, const char *argv[])
 	RUN_TEST(test_reftable_stack_auto_compaction_fails_gracefully);
 	RUN_TEST(test_reftable_stack_update_index_check);
 	RUN_TEST(test_reftable_stack_uptodate);
+	RUN_TEST(test_reftable_stack_read_across_reload);
 	RUN_TEST(test_suggest_compaction_segment);
 	RUN_TEST(test_suggest_compaction_segment_nothing);
 	return 0;
-- 
2.46.0.164.g477ce5ccd6.dirty

