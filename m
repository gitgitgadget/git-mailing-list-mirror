Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DAA1591E3
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489770; cv=none; b=nCKMRj5E/C3B1+KlvrNLXYitav1rdQT4YZ1gPvNHgF/cv6EieuLUc99SquVTOYYw/3Nyi6lj+24le4uk2pCzrVcrRYtA+/VRj9J04CCwP+XGjhWrzztYivyrNhAlu9ZLowbCK7JU5uHb44cOQZkbejfgA7xBXP9557/WL486I8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489770; c=relaxed/simple;
	bh=7AeQaaHsClVpe0KEPoavxjpVBE6YNXUCn4Vj33CEd18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pq/afcmcTBRhLTxgmDE9SKlmPLo6y0W3zlkLDF9sRf7vdpbywGLVZxPHhc1+RS/hM9CSsQQ9v9pnTG6WxztjYtsjjPXW32GLrg2Fo607rvC5/7MdghLWefZoTu8N8C5QgPwKHdNByqEopDjUeNgBrYbIq0+QDpiQKXdECWgD2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fOsMj2AV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p/Kk0sLY; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fOsMj2AV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p/Kk0sLY"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B5D031380267;
	Mon, 16 Sep 2024 08:29:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 16 Sep 2024 08:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726489767; x=1726576167; bh=kqJbu8RSS5
	FyPOe6noronqgaPdqL6YhdYmocVj/xqhU=; b=fOsMj2AVOd4K9ZrDzPrTcbndw+
	pXoARzCAIdzdmXPxEnzxeHwuUqNPnumMmraFVQ1QJPGH7ElduiebA5W2DPCPlRyp
	LNWlwVnSNcNZ5kjzusik6pWTv6totd4hB+UiP7kExpKSGv6FKV2YnDr85ch+mwW3
	i2ClnKarrOy7ODXQ/TuGmBggVEvXk/Kg4w1+u9Jehf0HoJHm77rkQOD8jOrs5McM
	59L8FdSjBQ+ro3FNekWsNd2Irkg2jV+XmD9kUOFMPBi2X2Et1s68VM+aRO/7U/pl
	WJaNBU5a//8tvADoHe07D595PKBMseXqdEWS4D2An/5Ayw8oLRJLM9eFme0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726489767; x=1726576167; bh=kqJbu8RSS5FyPOe6noronqgaPdqL
	6YhdYmocVj/xqhU=; b=p/Kk0sLYwZ87tHJWoC0GP5Dke/sdHa0a8Op0Z0LpE73D
	95p2V8NINOMcTTBXt/jhbpICR0WPmuXVtRHFwp2dN0CwHpFHkE4p3wWQxgibdbyg
	kFNwXRc1fQbVuKcTv0OhmOYUi41f6GXJw39UTpR6/c689NRvZdepoerZVXnQhh1r
	6y2+F3iLlsOpQIW+xlJbUTBe7Cm/5HmnoPTlciCWN6rcaDZ+1KVxdfcH6GF73jLf
	1Hkh8X7aIXamR6ZYXRvXSC3dWZ68BqmFDsqTDMNPMcPw3FU11qfmnYLtrObWnWX+
	fWFqhoEKNYhEprkv+u3DYMWKsofzBw2xzoZI5u+tOA==
X-ME-Sender: <xms:pyToZmGYflOtu5xQw1nbvF4jdffZZFzneIfNkqWJKIBFg_SD3QypEg>
    <xme:pyToZnUjMClD5gghT4gia47djROXLaS0cRFIzN4jGdwunhVNStdrpFOWlhtQitFlq
    pBzPXLgR3YNeWUvrA>
X-ME-Received: <xmr:pyToZgKPlubCNo_o5kseIQJcFQPSGAqIMMYG6sNB3IQGfs1rlCHud7vxxaSbU2gsuczToIf_CfdfDV6fICJ-e1YlU2WGEU4Rc9LKY4YsWP2VLZE8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pyToZgEcUkmhaah-MMd1TljKQYfsdhpYpYET4zNRh2IHexNzoOb4Lg>
    <xmx:pyToZsWWTug8PWQOkO6qpWewOcgVTvI-RMx8b61uZtj9Z0spmIPPFg>
    <xmx:pyToZjPMbdlLGiOOOEQjJVjh0LrWz323UYMhoUbK8jqLu0lnO9hl6g>
    <xmx:pyToZj1V1yRu3vBishZ6DbF2EzVhW_3fOOImZ8oSzvAOhVCbhDlGug>
    <xmx:pyToZpjXCaQOfmFTz-snHNKobvqwjQj3-dGEsVTuCpOTIShsVa3DybFy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 08:29:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 65d4f158 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:29:09 +0000 (UTC)
Date: Mon, 16 Sep 2024 14:29:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 22/22] reftable: handle trivial allocation failures
Message-ID: <02073dafb96d58b76d37f2dad5efe9807634dc82.1726489647.git.ps@pks.im>
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
index 2c20845d624..52bc66c5273 100644
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
index 0179e4e73dd..98e7aa26373 100644
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
index 990784d9d2f..7df28ab3438 100644
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
index 44bed92f467..ad4718edecb 100644
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
index e52a612e852..d470060e8be 100644
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
index 3d2848632db..3c84363e980 100644
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
index acca927a2cf..bfa069caff7 100644
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
2.46.0.551.gc5ee8f2d1c.dirty

