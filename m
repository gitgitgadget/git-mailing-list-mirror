Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F17212CDAE
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159545; cv=none; b=flLxjKyBApTCXKcdw8eW4F55fXkrJWNna66za63Lm1BvMvY4P4RtdyFlFebZGJbAP1xO64hUfuoRMfZ9pA1DXuvppDdg3KORcqNxjghBueuDhQHHOFZHF4UhjzHN2LbxXWreM+ILvss1M5fWa711O142i4hmMJPyQ/5GiQJ6QmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159545; c=relaxed/simple;
	bh=asR9DIhRclPDjxu03h1VXEejtBtWwpC+4Wvy9fMWRsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0d4LbtLOIAld5zIqLwY7UTeCqAEHdLOvNV9ldDRIdmo6IgoqvHc+nOLlDkZ4YfKt3sMXRFPDi5FQGejFokjBLlT9qBcKmCM4V4+LtXzeV9ozqESdcVXJFkEz7PH8F5/YQ6BmbXjqCbuh0mPGrhoS9PdlZEfZuNU9zVtwgql3B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N2k6OSvY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IOP+CKtz; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N2k6OSvY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IOP+CKtz"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3F2391140311;
	Tue, 24 Sep 2024 02:32:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 24 Sep 2024 02:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727159543; x=1727245943; bh=2ciicpUSfA
	Hvsuvck/rV1Ntdeg7Sc/pF2LGnDsEh4ec=; b=N2k6OSvYjUwKVWcsK6C6c7/FhY
	APTM/WL4lYCUGWkWcphBZP8laI7kRjUjewMBXL1oEPwGInLI8X1FzXWlhrt/2guA
	S8LsgcIcHiKUZdo/2ZnWmSw/JXG4hcC5QSpLIZBFoSo0EXUWaQrJnUwqDkNcO8RH
	xQmgmYWjp6Cb//tqIKiWpJXSPU5tFCCJYlhXkNg9TI4xUsqotLikfpH3i8+4V7AZ
	Oeuy9yckRNcEQBr0+69Y6veImaNVHHcpAclCu1APVZftwl2cS6VGW2O07so5xexm
	k7si+smzNN3b+fktp9q8NKWy8DEz6C+/VKLg33eigTQtKQEX5Z96NwDZY4+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727159543; x=1727245943; bh=2ciicpUSfAHvsuvck/rV1Ntdeg7S
	c/pF2LGnDsEh4ec=; b=IOP+CKtz8upcm9Xm23fskB4h8ptvD7dyRuO8PMKe3R9V
	R/LI7onfGjScN4vuwiMSeJl0R6ebWkQAoR8y1dqA5CXd2ZwhsGAvMLDfQUWJ7Q4O
	xP+22aJL3rxLDCFm9W5gRAWiZdg9I61C20Kq2gXiQl4Gg1dA25daBzrnGBr0OQ1/
	QYqp0hHZ7XVLE3LlKtj9+iHMB8pHUn5IpEmm/HZgyzPcAqPao307YVHw/ZVBRBv5
	U2/BSrkzQAu0DAoK/PwaG1hRaR/yEdgzgPpK7mPo1sM2XvjrjjEeuRIqmJ6TlvwN
	5JZJp2OpnUmq+TrxO1XmzZjXFMNUTie1gLCKib4W3A==
X-ME-Sender: <xms:91zyZjCuAEv68bS9BV4bDigM3djC5DKsfsMNltb4HiLFgRDDWLy03Q>
    <xme:91zyZphm_wfHMFO0omB7SNvCAgThRS7uhSw69DLs67AWFFFUAzvdIIjBtPhWwaH6Y
    tICrWygktyqX7pw2A>
X-ME-Received: <xmr:91zyZumWazmgFEuHF5M1HGSX4t7a78_MlfS_gmlqyMunBQ26T-n3ReCkWygYQ-4WF5fu2wiCfMDjNKtJGy5noTm6mQYkheqcSeA03iqoA6Yl4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghthhho
    mhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:91zyZlwDFI4edvtE85It_pDLtC_HDSr0VOXmmM0SKrxD1z9q2iF_lA>
    <xmx:91zyZoTanZY6IsqatAu0w69MEOGr4ufeb8ygLXnyUG6_CvHKua1K2Q>
    <xmx:91zyZoY-H14Jo3reAZVITLukg88GiX4VyJOIgxHfFJwq60iKWw4lIA>
    <xmx:91zyZpSUn2-ocBvpF9USsF_hRw8mVg7-aPUoHJuUtL1alrbilDkttg>
    <xmx:91zyZueu4rISbgFCwldf0mA8Iw21c1ddvWf4Knw5yyBrLULewLmU7imd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:32:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f70691c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 06:31:48 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:32:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/22] reftable/writer: handle allocation failures in
 `reftable_new_writer()`
Message-ID: <caa71f0a775698872ae855381851121f1796f290.1727158127.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727158127.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727158127.git.ps@pks.im>

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
index 189b1f4144f..43623dc7c30 100644
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
index 498fae846d7..ea21ca6e5f5 100644
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
index ed61aaf59c5..54ec822e1cd 100644
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
+		free(wp);
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
index ab1fa44a282..54c26c43e77 100644
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
2.46.0.551.gc5ee8f2d1c.dirty

