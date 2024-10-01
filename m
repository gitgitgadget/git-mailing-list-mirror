Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B7F19F43D
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775778; cv=none; b=WZiv7WV3u8kRbrEvEbSCyPMKyQWfXzT6kyoOu+9rtl4iFvwBNGU0LhrkvXdlVWFbV1jEE7MkbgHZJ247wFaEBBhpatfxbZlgCmgnlGesac3cO7zx6CpMRQfR8oFftLcK6GcgP+cwidnWnVyqm7ZN/E64FN14A91YcNvxJEoe+xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775778; c=relaxed/simple;
	bh=Js7HP2OJiT05g4/v3YLHPMCkeBdIax6CCb6KII8RBSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8pugdb2QyiXaWoMzi9RzgLfNq3UMEqvGd0/av8MJDZuARTnFwu1kK7dUKjTIeZE0A9p+bTWJqn5JIU56uUfg/PnQ1wOReyIXx+sqk35pgGq1zPx69ksvmCmr4dFJgEoo2861/jFhyC/+xsMBv9Lls3xFIWqXcNj1rOXEXAKfvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q34BaTns; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BhJ0VeNy; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q34BaTns";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BhJ0VeNy"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B8CB1381735;
	Tue,  1 Oct 2024 05:42:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 01 Oct 2024 05:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775775; x=1727862175; bh=g2XDkTI66r
	qFIZj1IYO46FpbaUeqCOB59ukA85txfDA=; b=Q34BaTnsTMoX35I0TmLGx/rZX8
	5wvm079hJfkSSbxGrrd0vd19mBESzcbxGscdKf3wzHvL6xEZLBQ92r3dfUdk5XSu
	pVARTQAc51jR+HCGCM+VAHDLcQp2/uKvmFKg9szcfYVEGRD8qKd8BiolVA4DQtrt
	AnGNDXoxLuEMlPbHvcS0tyGs7Nc2X25/4bJNiBympcJH8BzCIMowSCG5E0dD9Gcs
	EZGUrbiI3snHliwK3QZC0wM9MP0yWNJ0as5rEp+L1cDPaA9Jxct+kWctOS6DAxrI
	4OuAxf1HmoaBRhbjsBMhiOicuye5d7UGk46/Zmat1Ju6XsdlVhv0TC65wxCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775775; x=1727862175; bh=g2XDkTI66rqFIZj1IYO46FpbaUeq
	COB59ukA85txfDA=; b=BhJ0VeNy+MxBDdOIFVgbgQonlAdpptLe7G4RlM4cnM5t
	afwQybjCVrCnOMTsfT8dZiiQDlc/E+t68OL05NDxWlPKFT29aMiGuJdb0+3RskKo
	S4h6rQRMwYTdsHmOwJ3bFqYpovT0sUbqmXVSCQTOaC8sFkR8ex3SsR+RyVwXlrhb
	HMyIhiOku4yrC2gRFsLjSv2WDsCuIJaPL2coKUDiPBcNEBstI7lEPrZQhxqA8C5a
	kys7+iCTUsPvc0kJ5AlieTWFKx9thftr7l4QxJK57ImP6wMPklKwnFvKaU94DrLf
	AqGf6wqymdP7mReYXFXoMrP+DT5KHr2urSedzfjT1Q==
X-ME-Sender: <xms:H8T7ZgW168YxmzlUkZi6t_w4yUi9enn8BEBKfWUDvPnW-_S_jmEQSg>
    <xme:H8T7ZkmtkPVHm1kxJxIf9DihKkAzsbbIcx201KW5UXATqdVgylPGz_ZEWqToo7h3L
    lp6PG7BAo0XD63eag>
X-ME-Received: <xmr:H8T7Zka29Y7fte323Q8pEE-NnqRG38FdXVuSx0ujY2qMm5-9G3Ra8LdiOH15EVVJW3Z-j2zdLsm3ZVVlB916qUAtatf9OxkzakybLlrVcthOHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepvg
    hthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:H8T7ZvXrzKEf_Na0OhAAzuZNH9QpisCIBedUIIMPdo44CNuvcE3FIQ>
    <xmx:H8T7ZqlZXjjwB2-9efJJthzSnBPKu_pDwZkbhdsz5VYFGIuRjDXxMA>
    <xmx:H8T7ZkefbHtTsIJWFsqQx7Gp6ZzP1a89Vk0Q2WPL_iYTTEx6Ru5SBQ>
    <xmx:H8T7ZsEsa_4FNRK4mm5_6vgntX9h3AMDbrmSwapHM4ivwwTIqQyMBA>
    <xmx:H8T7ZrAycwjKwVGpKmFkyGN2GfpP-QIwkUgNqTTpWf8rzDBXYsCwAfa1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:42:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 74ed9fee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:42:07 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:42:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 22/25] reftable: handle trivial allocation failures
Message-ID: <28661500ff1710e866966b93c1d7c7d820f4c511.1727774935.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727774935.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727774935.git.ps@pks.im>

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

