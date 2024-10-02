Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D716A1EBFEC
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866558; cv=none; b=k3auW4s2Rgyj9+4VMcyS6V+Wpls7Np+a/3VWfh2CD8j6XVJrb55hxdVxMh0PQJuIzbLEFZL+xoXMw+gOU3BkFgdymPSOag4L1RGpCaoC3rwtLYAo2oIfK6S96Jy6JWFBWZCJri3ljyg4740eXVnKryQXe45ZbWGEaaBMOFNwgrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866558; c=relaxed/simple;
	bh=GMJ2R7EhbZ26MLb5z+CojS8kmfNu9cVTUleCA0frbBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7gBzxJo/SLfihD5Ms4TX/XHQa/L9wu9vKOuWthtG+eEoZ6Ikwc05JpVo6gqkCnWX78f2ZXh7Fn2jV6KdjK/Ac17VtGcxfB07z2bM56kmXpigSTEX80yaLxJA/I6qq2ovXLTi2EQ0N0ZQx7VoisqUFQTQ80oRCtPNYnc5l6bHEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cBEuhX8H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ndhzBlJZ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cBEuhX8H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ndhzBlJZ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E5EA41140239;
	Wed,  2 Oct 2024 06:55:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 02 Oct 2024 06:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866555; x=1727952955; bh=aht2XUEGSS
	gPFBhLVI+VpgVavEh2Ds/RKUhJijGak4U=; b=cBEuhX8H2hbFsLPAMoJT5dwfbJ
	/jLP3114mlVishbCXbxr2GGxwI5yYaTtIZmZ4fuKJeAqS5b1q1V1f7Ug3Nko1xHU
	ATImu3RvITuRCOHGJlC1fq0H35QN9epeG6781AbfPrtufJu2RJJszdSXQGe1ECk+
	w3Ltb9ii6l/Cv+7RI2h+WIrtGi1ieetFmB4ZIT6q02QG/Mh1pfBei3zXSlt+JSt5
	QvjqDdZX75KYb7XERw2p+PehSaoZGmHd2nfn6sMpFFJV/ITk4CqBcS9WWYPl9Pay
	ed2xS7G/bJnfxvLjmUbhJWWTF+UCGyYEBH5HiCY0ssMv8Mpy7G411FUPeflA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866555; x=1727952955; bh=aht2XUEGSSgPFBhLVI+VpgVavEh2
	Ds/RKUhJijGak4U=; b=ndhzBlJZPqymV/IAOGl1L96Ii826twn6r8RKwHXTx/Br
	vTxvjtCttHteReu6nnmecxCvBx4wZfssknVmJisa9MBWGw5NCFaO/s4Seow3xgca
	0/4//hTaOCaTN8sZ+uEdA/nJN8Q2Uk9cdzDWqCgQU6Iz94SwxjQ1D1uYDx1zBVg+
	1CMt6ObVHgb9qoBOX2JPsG8UBJXV8ky+ZmwZ5Wj5KlS57dnETMsqDBGDQIY6ij2t
	W4SapTP/Er2SdAbqCcn1US/gAVI96d7mpAyLKK7BGXZdL/aiTD+9dHyyPYok2NDW
	6GQh74HggrKQ5xYCDW4qpUKfukjBhDqil1XMHsWdCg==
X-ME-Sender: <xms:uyb9Zv9FS2gpVDvu7jC0wkc---goBZGuVTmc4GHuhJT1JcC1pOYhMA>
    <xme:uyb9ZrsD-vlWMjZyNYJvSL2Hqej-0Jeqn2lZsG736gtNfTY5CLi6y2Qa2g4xefN0-
    drAk9KoZ0F9y8KoOA>
X-ME-Received: <xmr:uyb9ZtDwkaCUhQqeVuHjUA47ha6AQP7DJ9qXp_a4nvL3TRlwaJdCjC32FOodZ4S60HQin7tbgQa-bgWCUoHxLRJDo_kgj6vB7JwI4_HLD3SVJUG8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:uyb9ZrfUISHMnuHhCuAgJLMQXeQCWJzM5XEdZk8BOeJTgo7QBRguBg>
    <xmx:uyb9ZkPAe4fFILHvD5_q7Vxeadzw2-IIaVnURJEyF4TWojgr63Bi1Q>
    <xmx:uyb9ZtmqF7c8uHOHQ1qrEJtk7lRjOdaIMRupZmfBl-BH7WCEZnZw2Q>
    <xmx:uyb9ZutFPFkzoPyb6zqyl1tEYhIibC7DCmsubtkaopB_szp_sHcfTA>
    <xmx:uyb9ZhqHGlWA1hFSfiEuKH5hoz_uzqLyGVZQ0yiMBIFCjp6jKD-C9175>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:55:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8c5e2610 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:55:04 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:55:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 09/25] reftable/writer: handle allocation failures in
 `reftable_new_writer()`
Message-ID: <0ed99e0bdf19fa1e396312b79acf47e9ba8e6ae5.1727866394.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727866394.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727866394.git.ps@pks.im>

Handle allocation failures in `reftable_new_writer()`. Adapt the
function to return an error code to return such failures. While at it,
rename it to match our code style as we have to touch up every callsite
anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-writer.h  | 12 +++++++-----
 reftable/stack.c            | 14 ++++++++++----
 reftable/writer.c           | 22 ++++++++++++++++------
 t/unit-tests/lib-reftable.c |  8 +++++---
 4 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 189b1f4144..43623dc7c3 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -90,11 +90,13 @@ struct reftable_stats {
 	int object_id_len;
 };
 
-/* reftable_new_writer creates a new writer */
-struct reftable_writer *
-reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
-		    int (*flush_func)(void *),
-		    void *writer_arg, const struct reftable_write_options *opts);
+struct reftable_writer;
+
+/* Create a new writer. */
+int reftable_writer_new(struct reftable_writer **out,
+			ssize_t (*writer_func)(void *, const void *, size_t),
+			int (*flush_func)(void *),
+			void *writer_arg, const struct reftable_write_options *opts);
 
 /* Set the range of update indices for the records we will add. When writing a
    table into a stack, the min should be at least
diff --git a/reftable/stack.c b/reftable/stack.c
index 498fae846d..ea21ca6e5f 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -808,8 +808,11 @@ int reftable_addition_add(struct reftable_addition *add,
 	}
 	tab_fd = get_tempfile_fd(tab_file);
 
-	wr = reftable_new_writer(reftable_fd_write, reftable_fd_flush, &tab_fd,
-				 &add->stack->opts);
+	err = reftable_writer_new(&wr, reftable_fd_write, reftable_fd_flush,
+				  &tab_fd, &add->stack->opts);
+	if (err < 0)
+		goto done;
+
 	err = write_table(wr, arg);
 	if (err < 0)
 		goto done;
@@ -898,8 +901,11 @@ static int stack_compact_locked(struct reftable_stack *st,
 		goto done;
 	}
 
-	wr = reftable_new_writer(reftable_fd_write, reftable_fd_flush,
-				 &tab_fd, &st->opts);
+	err = reftable_writer_new(&wr, reftable_fd_write, reftable_fd_flush,
+				  &tab_fd, &st->opts);
+	if (err < 0)
+		goto done;
+
 	err = stack_write_compact(st, wr, first, last, config);
 	if (err < 0)
 		goto done;
diff --git a/reftable/writer.c b/reftable/writer.c
index ed61aaf59c..8ab2e916d3 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -117,13 +117,17 @@ static void writer_reinit_block_writer(struct reftable_writer *w, uint8_t typ)
 	w->block_writer->restart_interval = w->opts.restart_interval;
 }
 
-struct reftable_writer *
-reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
-		    int (*flush_func)(void *),
-		    void *writer_arg, const struct reftable_write_options *_opts)
+int reftable_writer_new(struct reftable_writer **out,
+			ssize_t (*writer_func)(void *, const void *, size_t),
+			int (*flush_func)(void *),
+			void *writer_arg, const struct reftable_write_options *_opts)
 {
-	struct reftable_writer *wp = reftable_calloc(1, sizeof(*wp));
 	struct reftable_write_options opts = {0};
+	struct reftable_writer *wp;
+
+	wp = reftable_calloc(1, sizeof(*wp));
+	if (!wp)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
 
 	if (_opts)
 		opts = *_opts;
@@ -134,13 +138,19 @@ reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
 	strbuf_init(&wp->block_writer_data.last_key, 0);
 	strbuf_init(&wp->last_key, 0);
 	REFTABLE_CALLOC_ARRAY(wp->block, opts.block_size);
+	if (!wp->block) {
+		reftable_free(wp);
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
+	}
 	wp->write = writer_func;
 	wp->write_arg = writer_arg;
 	wp->opts = opts;
 	wp->flush = flush_func;
 	writer_reinit_block_writer(wp, BLOCK_TYPE_REF);
 
-	return wp;
+	*out = wp;
+
+	return 0;
 }
 
 void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
diff --git a/t/unit-tests/lib-reftable.c b/t/unit-tests/lib-reftable.c
index ab1fa44a28..54c26c43e7 100644
--- a/t/unit-tests/lib-reftable.c
+++ b/t/unit-tests/lib-reftable.c
@@ -22,9 +22,11 @@ static int strbuf_writer_flush(void *arg UNUSED)
 struct reftable_writer *t_reftable_strbuf_writer(struct strbuf *buf,
 						 struct reftable_write_options *opts)
 {
-	return reftable_new_writer(&strbuf_writer_write,
-				   &strbuf_writer_flush,
-				   buf, opts);
+	struct reftable_writer *writer;
+	int ret = reftable_writer_new(&writer, &strbuf_writer_write, &strbuf_writer_flush,
+				      buf, opts);
+	check(!ret);
+	return writer;
 }
 
 void t_reftable_write_to_buf(struct strbuf *buf,
-- 
2.47.0.rc0.dirty

