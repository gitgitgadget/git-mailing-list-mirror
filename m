Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393D514F9E2
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489725; cv=none; b=WwYzeLEJ1dYg3ZALzUrquB3aafPQuGFOMrbSKi2LzVkcJW3LawDSkwxHvK9a+l1+08tdggQUqTBvTKovRm+3yDOyO0GjZT7/watm7OgiPVpUqSELcq8+cWqtZgp2CApd3Eme1JO3PfhCP82oGrjqgvZbOfUp6zFbyQ38tfQttEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489725; c=relaxed/simple;
	bh=asR9DIhRclPDjxu03h1VXEejtBtWwpC+4Wvy9fMWRsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cl1S5+2ukNTf4GanOKSdiwzXO2IDtvTNCMHFF2/rYeEuwaMZNUuNpYQQXN4SEdO12LCOrdwq0Q0IjFJL9txs2vKMCYND69T/pPH5RRAQVK2pV6cihjLf8wiNtHt4FKkGuH6OX/UQmDOKvzWnfhj93ZEEaVRDcqkdDmdzZqvHS7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AOxQCwW8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l1RhEtrO; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AOxQCwW8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l1RhEtrO"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 97E6511401A9;
	Mon, 16 Sep 2024 08:28:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 16 Sep 2024 08:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726489723; x=1726576123; bh=2ciicpUSfA
	Hvsuvck/rV1Ntdeg7Sc/pF2LGnDsEh4ec=; b=AOxQCwW8WFPIpx3F8ZRyu0BKr/
	QB00irjC30eBbCFIwRDuiXmu3nJCdcmR9M5Y7ySR5Mx1hkOaAB7nq0T5qInL8Sm1
	9WWz4fqMiTACBhTGsXkc6+dvpwBR+qKYsttgfCilMbrMT5DbsmlQPLJK5Z3BOk9m
	B9D25hAiohqFZv9BfoCoe+sWH5F292A22FLSoqkMkR3UbSmTFYkE6KR6aeySuwnw
	5CZ5kyavsYZn1eV40y4XSSY+T5vRGHAOkzZLRkIGzqVPOf+Zof36N7Xaip37udRU
	iiChU4YZTzO967Wkp9mdJjlEIpR88NPItqe/xSUFipMnylrr+HPL4/XXJgPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726489723; x=1726576123; bh=2ciicpUSfAHvsuvck/rV1Ntdeg7S
	c/pF2LGnDsEh4ec=; b=l1RhEtrOO4lfGwpg2n3Pc0GKAJTfLZNkr0Vp/LpMxvam
	/r4QE32NLIRoS8NxfYkzTRfJJ7ZelXjhg6NQegeol/HtsBxdcgpTUWPzcOM6Cwgc
	bbtR48lhRCZP5VQZQwYXU5IL+tTLdVMwBmTmdt+2VaUMz6wK2+17tJ7JJoW3a0a4
	5XyJRtfUK0kYyvutDbX2r3sMwIEnE5Trtjuy7obVWifMddutB5/6e9tMkFwYZCWS
	DJJVPrgruS33vrQ1yi3rVbahLovWMsfSPL7mP+MFmbTfxyyIdGvnjNLjxthsNHF/
	qPsaCWA0+2kLIhN/zR0eIWfwqf8wc3MmrXlh6iYOSQ==
X-ME-Sender: <xms:eyToZvUWyjmgcMpGFmBUaBV6sMV_mproplZF9vgtiETbjJqITboGAQ>
    <xme:eyToZnkAfhMrpDOHTxjkiSufopWA0XFltVcOv9HwCp1PP3P52igVkZSgyrp-qviO-
    8bsZaIxxG8SV5T5fA>
X-ME-Received: <xmr:eyToZrZB_9V3CEKN4Wd3ycNgvM3ZmzrLYUpFjPB5LZRmzAyVqJEl2e3XGYnJEe8DmOrLH3cWYIzGZxpYF01VK3wcPhPQAm6zUkla7Zktup2sbLJU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:eyToZqXqYx_DbivUb5nl9fBVZp3K7E3SHwfkok0wFFrmtW6_G_ophQ>
    <xmx:eyToZpnqusQayMG7epOFgIcrtiuNVS0K38rj7JkMwpdNxc3T42M9kQ>
    <xmx:eyToZnf1TSZ1FB0QTitBajWwqRZhltv7K18MvmBZX1C8H1QMIJ3-ug>
    <xmx:eyToZjH_C0hVG__e4z2yDFP4l6w1MXhOtPN2ulNkWAiGM8fKrCr7ag>
    <xmx:eyToZuxRtR8cT9mNlH9XsXLET4fDUgXTD0TmVGoJrDklQPkGyZZdNwXP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 08:28:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0b9e596e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:28:26 +0000 (UTC)
Date: Mon, 16 Sep 2024 14:28:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 09/22] reftable/writer: handle allocation failures in
 `reftable_new_writer()`
Message-ID: <d6afb30221e8faf878126f61a149d002ce5ffc3c.1726489647.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726489647.git.ps@pks.im>

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

