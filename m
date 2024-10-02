Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E55205E22
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866596; cv=none; b=KBkoAVu/FULmND1SPi0o4DTPzZGqnl7ECav+8qjXPoGnaBEe6MmzCbqDELKkC+x+KBmcLctXTgnd1hT7xqX2zj6oSZMY3rUCOFJ2ZnQUhythaJjGZCqIo1hGlBxAmkPluSqqj4fR1r0dh/55LdkvG3JtkiDPQ4DmrIOCmyCR9zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866596; c=relaxed/simple;
	bh=Js7HP2OJiT05g4/v3YLHPMCkeBdIax6CCb6KII8RBSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeOGyIm1fIBeBXvgc9cw+GpIjxfhtFDx8/IxjOhvlA7ZZQxbeazBtZ3JQHbvU0uHt62Ap37c2Lvq5LonDb9MjgbRAWI9jlQvadfsCFVaamR5R1TYSq5+nB4LO56ziK0mG+vE75bOJGCgsctCkfiw+eiqkoF/B2qLGHTisezX+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pgzo/aNy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T/eRxuk7; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pgzo/aNy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T/eRxuk7"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 716011380253;
	Wed,  2 Oct 2024 06:56:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 02 Oct 2024 06:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866594; x=1727952994; bh=g2XDkTI66r
	qFIZj1IYO46FpbaUeqCOB59ukA85txfDA=; b=pgzo/aNynl1dbKKQnQbRRyywOm
	5yJiYCr97gJmAN5WH2ErvrvH4l/V/Nxp18ScCynghT6fq3bvj/cndIACsbe6RzVc
	1ujx/tAwBzYHgWm+kniOGXUoobVTiGzHZyCbViw6NzjhjbHiK2yteqOU09uN2cOb
	ZxcepXSGgk1u0FQR93xDGPoB9Tl46HWn/VRLbFiXaPznz3hJCbvo0pr1q1JfZeWJ
	Wrz0T/9I5I9K5AL2jBlHSyS4ymzmDVXdCLRdvnZDnx4Tj3COXzXq0ml3GSdelQF3
	4tkdL/pFAXYq7NPce89edEz8bPj82fOke7+bWy0OclQ4sOGth5GjWDaErHug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866594; x=1727952994; bh=g2XDkTI66rqFIZj1IYO46FpbaUeq
	COB59ukA85txfDA=; b=T/eRxuk7l+QeyKVz6GXo5EQCljo0jvPWenHZjP9MMF1p
	H7m/p0F/+cC+61l5OxV9l/KMjS1aO98lyGmuUnS5txcNfXoZsJvN8ZcAPqae2w7b
	818CcMttj4lCxxRcFd1nI3+2XvRqM/MmQKvhEovc4xiftEvh4wrvLJ4fy9IrG26I
	Xiz1zXmtV0Q8sHstu/EZw8GOTzVQfqfGdc3BVldtxSDY/YE4t66JF32Y6CV+PzfE
	/CJ2+MZPqLUrrBMMWjXkh0dFTUwP4It6AAJPaTbodrvKi+9TV/B1LIXk+PWLWFe/
	r4BRL2hK3s3J50vHgI34bin1i8XPJwEmGb1F+t7sKg==
X-ME-Sender: <xms:4ib9ZpVvo2h4gg4gE1RdAObWqtCbfov7jKro3vMVLKBlelIGbCS-6A>
    <xme:4ib9Zpl8KL8iIeiEVd3lMNszyTQ9PFGXXvjEP0iggR31qMVnE1SiaQyEYRo0rTYOl
    CsnHFKX3mNw3Psbqw>
X-ME-Received: <xmr:4ib9ZlbbmkahvyokotinGRSIS9xGB-tJfCYxSY2FoKTCetyKQ-W1jp6YQ9GZQrAPtSZHnRU661vdwFBdsKliUEAhs6ZMYy_HvZ9p-RzSA6N4ntRX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheplhdrshdrrh
    esfigvsgdruggv
X-ME-Proxy: <xmx:4ib9ZsUTKj3WM3uxN2GpsefIhgeatxC8qUU2P-S0BeAZYtCnmYTNfw>
    <xmx:4ib9ZjktjSQ6YPOHrzBidiv1Qk8nEQ5ebpa-qGGUeoF1ygLefIdUww>
    <xmx:4ib9ZpcTMAbhyhjb0WgleJyD74DWT2m2y95OzUBDSCuVBTPIx5fuTw>
    <xmx:4ib9ZtGS40fm-7iDRkmAgGYm7jzDcdCtzPnZeUDIFS2W634EuE0f7w>
    <xmx:4ib9ZsBKrPioek22W-jQ-kpx12E8yxQ8-zub3EbLeEsZ-F2QoIr4ZNOx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:56:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fb1a65d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:55:43 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:56:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 22/25] reftable: handle trivial allocation failures
Message-ID: <28661500ff1710e866966b93c1d7c7d820f4c511.1727866394.git.ps@pks.im>
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

Handle trivial allocation failures in the reftable library and its unit
tests.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c                   |  3 +++
 reftable/reader.c                   | 10 +++++++++-
 reftable/stack.c                    | 20 ++++++++++++++++++++
 reftable/writer.c                   | 13 +++++++++++--
 t/unit-tests/t-reftable-block.c     |  4 ++++
 t/unit-tests/t-reftable-merged.c    |  4 ++++
 t/unit-tests/t-reftable-readwrite.c | 27 ++++++++++++++++-----------
 7 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 8e202a8efd..514d6facf4 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -203,6 +203,9 @@ int reftable_merged_table_new(struct reftable_merged_table **dest,
 	}
 
 	REFTABLE_CALLOC_ARRAY(m, 1);
+	if (!m)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
+
 	m->readers = readers;
 	m->readers_len = n;
 	m->min = first_min;
diff --git a/reftable/reader.c b/reftable/reader.c
index 0179e4e73d..98e7aa2637 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -598,6 +598,10 @@ int reftable_reader_new(struct reftable_reader **out,
 	int err;
 
 	REFTABLE_CALLOC_ARRAY(r, 1);
+	if (!r) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
 
 	/*
 	 * We need one extra byte to read the type of first block. We also
@@ -627,7 +631,11 @@ int reftable_reader_new(struct reftable_reader **out,
 
 	r->size = file_size - footer_size(r->version);
 	r->source = *source;
-	r->name = xstrdup(name);
+	r->name = reftable_strdup(name);
+	if (!r->name) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
 	r->hash_id = 0;
 	r->refcount = 1;
 
diff --git a/reftable/stack.c b/reftable/stack.c
index 990784d9d2..7df28ab343 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -116,6 +116,11 @@ static int fd_read_lines(int fd, char ***namesp)
 	}
 
 	REFTABLE_ALLOC_ARRAY(buf, size + 1);
+	if (!buf) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
+
 	if (read_in_full(fd, buf, size) != size) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
@@ -140,6 +145,8 @@ int read_lines(const char *filename, char ***namesp)
 	if (fd < 0) {
 		if (errno == ENOENT) {
 			REFTABLE_CALLOC_ARRAY(*namesp, 1);
+			if (!*namesp)
+				return REFTABLE_OUT_OF_MEMORY_ERROR;
 			return 0;
 		}
 
@@ -420,6 +427,10 @@ static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
 			}
 
 			REFTABLE_CALLOC_ARRAY(names, 1);
+			if (!names) {
+				err = REFTABLE_OUT_OF_MEMORY_ERROR;
+				goto out;
+			}
 		} else {
 			err = fd_read_lines(fd, &names);
 			if (err < 0)
@@ -779,7 +790,11 @@ int reftable_stack_new_addition(struct reftable_addition **dest,
 {
 	int err = 0;
 	struct reftable_addition empty = REFTABLE_ADDITION_INIT;
+
 	REFTABLE_CALLOC_ARRAY(*dest, 1);
+	if (!*dest)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
+
 	**dest = empty;
 	err = reftable_stack_init_addition(*dest, st);
 	if (err) {
@@ -886,7 +901,12 @@ int reftable_addition_add(struct reftable_addition *add,
 
 	REFTABLE_ALLOC_GROW(add->new_tables, add->new_tables_len + 1,
 			    add->new_tables_cap);
+	if (!add->new_tables) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
 	add->new_tables[add->new_tables_len++] = strbuf_detach(&next_name, NULL);
+
 done:
 	delete_tempfile(&tab_file);
 	strbuf_release(&temp_tab_file_name);
diff --git a/reftable/writer.c b/reftable/writer.c
index e180c10840..550172e65c 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -49,8 +49,14 @@ static int padded_write(struct reftable_writer *w, uint8_t *data, size_t len,
 {
 	int n = 0;
 	if (w->pending_padding > 0) {
-		uint8_t *zeroed = reftable_calloc(w->pending_padding, sizeof(*zeroed));
-		int n = w->write(w->write_arg, zeroed, w->pending_padding);
+		uint8_t *zeroed;
+		int n;
+
+		zeroed = reftable_calloc(w->pending_padding, sizeof(*zeroed));
+		if (!zeroed)
+			return -1;
+
+		n = w->write(w->write_arg, zeroed, w->pending_padding);
 		if (n < 0)
 			return n;
 
@@ -767,6 +773,9 @@ static int writer_flush_nonempty_block(struct reftable_writer *w)
 	 * case we will end up with a multi-level index.
 	 */
 	REFTABLE_ALLOC_GROW(w->index, w->index_len + 1, w->index_cap);
+	if (!w->index)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
+
 	index_record.offset = w->next;
 	strbuf_reset(&index_record.last_key);
 	strbuf_addbuf(&index_record.last_key, &w->block_writer->last_key);
diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index e52a612e85..d470060e8b 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -32,6 +32,7 @@ static void t_ref_block_read_write(void)
 	struct strbuf want = STRBUF_INIT, buf = STRBUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
+	check(block.data != NULL);
 	block.len = block_size;
 	block_source_from_strbuf(&block.source ,&buf);
 	ret = block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
@@ -125,6 +126,7 @@ static void t_log_block_read_write(void)
 	struct strbuf want = STRBUF_INIT, buf = STRBUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
+	check(block.data != NULL);
 	block.len = block_size;
 	block_source_from_strbuf(&block.source ,&buf);
 	ret = block_writer_init(&bw, BLOCK_TYPE_LOG, block.data, block_size,
@@ -214,6 +216,7 @@ static void t_obj_block_read_write(void)
 	struct strbuf want = STRBUF_INIT, buf = STRBUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
+	check(block.data != NULL);
 	block.len = block_size;
 	block_source_from_strbuf(&block.source, &buf);
 	ret = block_writer_init(&bw, BLOCK_TYPE_OBJ, block.data, block_size,
@@ -297,6 +300,7 @@ static void t_index_block_read_write(void)
 	struct strbuf want = STRBUF_INIT, buf = STRBUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
+	check(block.data != NULL);
 	block.len = block_size;
 	block_source_from_strbuf(&block.source, &buf);
 	ret = block_writer_init(&bw, BLOCK_TYPE_INDEX, block.data, block_size,
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 3d2848632d..3c84363e98 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -29,7 +29,9 @@ merged_table_from_records(struct reftable_ref_record **refs,
 	int err;
 
 	REFTABLE_CALLOC_ARRAY(*readers, n);
+	check(*readers != NULL);
 	REFTABLE_CALLOC_ARRAY(*source, n);
+	check(*source != NULL);
 
 	for (size_t i = 0; i < n; i++) {
 		t_reftable_write_to_buf(&buf[i], refs[i], sizes[i], NULL, 0, &opts);
@@ -285,7 +287,9 @@ merged_table_from_log_records(struct reftable_log_record **logs,
 	int err;
 
 	REFTABLE_CALLOC_ARRAY(*readers, n);
+	check(*readers != NULL);
 	REFTABLE_CALLOC_ARRAY(*source, n);
+	check(*source != NULL);
 
 	for (size_t i = 0; i < n; i++) {
 		t_reftable_write_to_buf(&buf[i], NULL, 0, logs[i], sizes[i], &opts);
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index acca927a2c..bfa069caff 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -52,8 +52,11 @@ static void write_table(char ***names, struct strbuf *buf, int N,
 	int i;
 
 	REFTABLE_CALLOC_ARRAY(*names, N + 1);
+	check(*names != NULL);
 	REFTABLE_CALLOC_ARRAY(refs, N);
+	check(refs != NULL);
 	REFTABLE_CALLOC_ARRAY(logs, N);
+	check(logs != NULL);
 
 	for (i = 0; i < N; i++) {
 		refs[i].refname = (*names)[i] = xstrfmt("refs/heads/branch%02d", i);
@@ -150,23 +153,25 @@ static void t_log_overflow(void)
 
 static void t_log_write_read(void)
 {
-	int N = 2;
-	char **names = reftable_calloc(N + 1, sizeof(*names));
-	int err;
 	struct reftable_write_options opts = {
 		.block_size = 256,
 	};
 	struct reftable_ref_record ref = { 0 };
-	int i = 0;
 	struct reftable_log_record log = { 0 };
-	int n;
 	struct reftable_iterator it = { 0 };
 	struct reftable_reader *reader;
 	struct reftable_block_source source = { 0 };
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	const struct reftable_stats *stats = NULL;
+	int N = 2, err, i, n;
+	char **names;
+
+	names = reftable_calloc(N + 1, sizeof(*names));
+	check(names != NULL);
+
 	reftable_writer_set_limits(w, 0, N);
+
 	for (i = 0; i < N; i++) {
 		char name[256];
 		struct reftable_ref_record ref = { 0 };
@@ -178,6 +183,7 @@ static void t_log_write_read(void)
 		err = reftable_writer_add_ref(w, &ref);
 		check(!err);
 	}
+
 	for (i = 0; i < N; i++) {
 		struct reftable_log_record log = { 0 };
 
@@ -476,8 +482,7 @@ static void t_table_read_write_seek_index(void)
 
 static void t_table_refs_for(int indexed)
 {
-	int N = 50;
-	char **want_names = reftable_calloc(N + 1, sizeof(*want_names));
+	char **want_names;
 	int want_names_len = 0;
 	uint8_t want_hash[GIT_SHA1_RAWSZ];
 
@@ -485,15 +490,15 @@ static void t_table_refs_for(int indexed)
 		.block_size = 256,
 	};
 	struct reftable_ref_record ref = { 0 };
-	int i = 0;
-	int n;
-	int err;
 	struct reftable_reader *reader;
 	struct reftable_block_source source = { 0 };
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_iterator it = { 0 };
-	int j;
+	int N = 50, n, j, err, i;
+
+	want_names = reftable_calloc(N + 1, sizeof(*want_names));
+	check(want_names != NULL);
 
 	t_reftable_set_hash(want_hash, 4, GIT_SHA1_FORMAT_ID);
 
-- 
2.47.0.rc0.dirty

