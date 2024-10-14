Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD2F19CD0E
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910948; cv=none; b=miDX7QbfAelxvOHs33BsyRTqluC/Uw7BgDa4np8tfbWRdwd7Nb7Ba0o64PgqT43THY8+Hnh0QPzXJlnfFMwZctAv528fFEWz1HS5BDAuWvD7OUAlfCEtJcFb/sIOphHFDxszTZ0AIqCjge5bisZG4JfsF/z4uomnVILVR0/U524=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910948; c=relaxed/simple;
	bh=kXF/FwzQ0IS7Ah0rggR2CiA7VwfM9920n6uFpnnq0xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emjP8TMI/cFS2m4FR386VQVhbyus8nnZOOlsxwWAb+gApDkflNoLIbGVA+lGEnwrc4xrPhUH7KTfN0ac8k//9lcmtlKvu2qZW/bRPLn4TFwYG8ARp9/x80fGPnIEm2yll12KE1H+416bdXo8/klBcreQHVnLRUkMG7kMrC7EEVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W8Dmmdbs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AI9RExlR; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W8Dmmdbs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AI9RExlR"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 73BED13800C9;
	Mon, 14 Oct 2024 09:02:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 14 Oct 2024 09:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728910945; x=1728997345; bh=TVzQAW++oG
	8X7i2gvp92hwSk3kQdvSbObLteEqeh3t8=; b=W8DmmdbsCTqMgyChTU0UQbTx5R
	9WS/veVxw7Y6DyoaSingbkPqcpzwqY2FjrNOKPMbvDw2NniACMuK6nV6UvTjH0Rf
	BhokJcyteHSpphOQ8uAeUXbZ8CBll6l5RoULRDAD1dzU2qD/YFqetskziQ2EKZrn
	j/J29vJ4Xw5VG6yXEKfE+tMUA9dqnbvs0WCT8pv8lJaPlEQfT0Ks0gb5ZYDMbifi
	a6oiQ/V2oxEyn2AKYL58WQzRyGyhFUe0hs2vD8AuT+Rd87o0Hsvme8+SglfXR8Zr
	EgmIVZ7196/nLQjNzQzdxjEKzi/B3kukzOp44WmwkqocJLpNL5tXvbbpIEsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728910945; x=1728997345; bh=TVzQAW++oG8X7i2gvp92hwSk3kQd
	vSbObLteEqeh3t8=; b=AI9RExlRg3QgoSjy5vvfE5zdjql2ZC7jVAECmFa/UqIv
	uXX3huaid92ltzXJ89UlfS0qbUJQHbACDsYz4q6Vp/tdIFJRWppxllycCzsey2ic
	13/qdQbL6kVryiq9nsfdYFbeqIT4KF/CqVeURmMnUCe6rvIhFl6KdAxITGTurcmr
	zTUZk+2m7WZkS2viPxQGPVzUWJiXYfJBKBbvjjzD8921sHXcys0wWHQKUkxq4SSa
	kpfK1RvM3UxSW5W1rDWaorPrhUVMpqV7SbQZ+7FkfmdFhHLh/vlIVCkOmvmnKqpM
	aFrhcbKGPoFJuBquPrYM6ccaxVmVkRwvoTGvNiQ5eA==
X-ME-Sender: <xms:YRYNZ4CLm1gvLtXZhouVpmKpNPjBo9Fpm07tlI6PGTeMAXfIp5lziw>
    <xme:YRYNZ6iBhVspAE9ZDadxx-6uFTYp7KgldB3im7o2Hk6O0nM9emeh_GCfSv_3vTjj0
    JFwk0_529dOeqZG4A>
X-ME-Received: <xmr:YRYNZ7l8lRjzmcJueZ4mGU_fxT-LOvyZ0jjT5XvgzxzZat6kAW26w-Eb7OM2G79sI9TWrINfTOoQ4sElG_JlahkSmqyl7DGxLWvVQFWXlEmKCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YRYNZ-y8I3M8i5c7Tis2IkemAb0JJswT4t3VpSgPB2uqMTHUIYH5XQ>
    <xmx:YRYNZ9Q8xy8yY8UHYuuX1jcj3LsdsDVXxpk0qpXA2q_94NC7uc330w>
    <xmx:YRYNZ5b60cQv9nmlrpCbyAoxLGNrH5ostLhoZNpRfmmTdRygdHKSZQ>
    <xmx:YRYNZ2QHcP3K2-Ur3YnVSBRuEezjMpGuniq05bs_L8zCD3vrARm-8g>
    <xmx:YRYNZ_fcChFI36qLoJ1uw7ct65rwKRJOjCdncyEJgTg493CvWpgqlDsV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 09:02:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7dd62596 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 13:01:10 +0000 (UTC)
Date: Mon, 14 Oct 2024 15:02:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 02/10] reftable: stop using `strbuf_addf()`
Message-ID: <6a7333b275e9f7eab81568a8de939011d292a31a.1728910727.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728910726.git.ps@pks.im>

We're about to introduce our own `reftable_buf` type to replace
`strbuf`. Get rid of the seldomly-used `strbuf_addf()` function such
that we have to reimplement one less function.

While at it, remove a useless call to `strbuf_reset()` in
`t_reftable_stack_auto_compaction_with_locked_tables()`. We don't write
to the buffer before this and initialize it with `STRBUF_INIT`, so there
is no need to reset anything.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c                    | 18 ++++++++-----
 t/unit-tests/t-reftable-block.c     |  7 +++--
 t/unit-tests/t-reftable-readwrite.c | 20 +++++++-------
 t/unit-tests/t-reftable-stack.c     | 42 ++++++++++++++++-------------
 4 files changed, 50 insertions(+), 37 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 7e617c25914..d7bc1187dfb 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1387,12 +1387,18 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * have just written. In case the compacted table became empty we
 	 * simply skip writing it.
 	 */
-	for (i = 0; i < first_to_replace; i++)
-		strbuf_addf(&tables_list_buf, "%s\n", names[i]);
-	if (!is_empty_table)
-		strbuf_addf(&tables_list_buf, "%s\n", new_table_name.buf);
-	for (i = last_to_replace + 1; names[i]; i++)
-		strbuf_addf(&tables_list_buf, "%s\n", names[i]);
+	for (i = 0; i < first_to_replace; i++) {
+		strbuf_addstr(&tables_list_buf, names[i]);
+		strbuf_addstr(&tables_list_buf, "\n");
+	}
+	if (!is_empty_table) {
+		strbuf_addstr(&tables_list_buf, new_table_name.buf);
+		strbuf_addstr(&tables_list_buf, "\n");
+	}
+	for (i = last_to_replace + 1; names[i]; i++) {
+		strbuf_addstr(&tables_list_buf, names[i]);
+		strbuf_addstr(&tables_list_buf, "\n");
+	}
 
 	err = write_in_full(get_lock_file_fd(&tables_list_lock),
 			    tables_list_buf.buf, tables_list_buf.len);
diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index d470060e8be..8077bbc5e7a 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -308,10 +308,13 @@ static void t_index_block_read_write(void)
 	check(!ret);
 
 	for (i = 0; i < N; i++) {
-		strbuf_init(&recs[i].u.idx.last_key, 9);
+		char buf[128];
+
+		snprintf(buf, sizeof(buf), "branch%02"PRIuMAX, (uintmax_t)i);
 
+		strbuf_init(&recs[i].u.idx.last_key, 9);
 		recs[i].type = BLOCK_TYPE_INDEX;
-		strbuf_addf(&recs[i].u.idx.last_key, "branch%02"PRIuMAX, (uintmax_t)i);
+		strbuf_addstr(&recs[i].u.idx.last_key, buf);
 		recs[i].u.idx.offset = i;
 
 		ret = block_writer_add(&bw, &recs[i]);
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index 27ce84445e8..5f59b0ad6ad 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -753,12 +753,13 @@ static void t_write_multiple_indices(void)
 	struct reftable_write_options opts = {
 		.block_size = 100,
 	};
-	struct strbuf writer_buf = STRBUF_INIT, buf = STRBUF_INIT;
+	struct strbuf writer_buf = STRBUF_INIT;
 	struct reftable_block_source source = { 0 };
 	struct reftable_iterator it = { 0 };
 	const struct reftable_stats *stats;
 	struct reftable_writer *writer;
 	struct reftable_reader *reader;
+	char buf[128];
 	int err, i;
 
 	writer = t_reftable_strbuf_writer(&writer_buf, &opts);
@@ -770,9 +771,8 @@ static void t_write_multiple_indices(void)
 			.value.val1 = {i},
 		};
 
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "refs/heads/%04d", i);
-		ref.refname = buf.buf,
+		snprintf(buf, sizeof(buf), "refs/heads/%04d", i);
+		ref.refname = buf;
 
 		err = reftable_writer_add_ref(writer, &ref);
 		check(!err);
@@ -788,9 +788,8 @@ static void t_write_multiple_indices(void)
 			},
 		};
 
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "refs/heads/%04d", i);
-		log.refname = buf.buf,
+		snprintf(buf, sizeof(buf), "refs/heads/%04d", i);
+		log.refname = buf;
 
 		err = reftable_writer_add_log(writer, &log);
 		check(!err);
@@ -824,7 +823,6 @@ static void t_write_multiple_indices(void)
 	reftable_writer_free(writer);
 	reftable_reader_decref(reader);
 	strbuf_release(&writer_buf);
-	strbuf_release(&buf);
 }
 
 static void t_write_multi_level_index(void)
@@ -848,10 +846,10 @@ static void t_write_multi_level_index(void)
 			.value_type = REFTABLE_REF_VAL1,
 			.value.val1 = {i},
 		};
+		char buf[128];
 
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "refs/heads/%03" PRIuMAX, (uintmax_t)i);
-		ref.refname = buf.buf,
+		snprintf(buf, sizeof(buf), "refs/heads/%03" PRIuMAX, (uintmax_t)i);
+		ref.refname = buf;
 
 		err = reftable_writer_add_ref(writer, &ref);
 		check(!err);
diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 874095b9ee2..b56ea774312 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -105,7 +105,6 @@ static int write_test_ref(struct reftable_writer *wr, void *arg)
 static void write_n_ref_tables(struct reftable_stack *st,
 			       size_t n)
 {
-	struct strbuf buf = STRBUF_INIT;
 	int disable_auto_compact;
 	int err;
 
@@ -117,10 +116,10 @@ static void write_n_ref_tables(struct reftable_stack *st,
 			.update_index = reftable_stack_next_update_index(st),
 			.value_type = REFTABLE_REF_VAL1,
 		};
+		char buf[128];
 
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "refs/heads/branch-%04"PRIuMAX, (uintmax_t)i);
-		ref.refname = buf.buf;
+		snprintf(buf, sizeof(buf), "refs/heads/branch-%04"PRIuMAX, (uintmax_t)i);
+		ref.refname = buf;
 		t_reftable_set_hash(ref.value.val1, i, GIT_SHA1_FORMAT_ID);
 
 		err = reftable_stack_add(st, &write_test_ref, &ref);
@@ -128,7 +127,6 @@ static void write_n_ref_tables(struct reftable_stack *st,
 	}
 
 	st->opts.disable_auto_compact = disable_auto_compact;
-	strbuf_release(&buf);
 }
 
 struct write_log_arg {
@@ -434,7 +432,10 @@ static void t_reftable_stack_auto_compaction_fails_gracefully(void)
 	 * Adding a new table to the stack should not be impacted by this, even
 	 * though auto-compaction will now fail.
 	 */
-	strbuf_addf(&table_path, "%s/%s.lock", dir, st->readers[0]->name);
+	strbuf_addstr(&table_path, dir);
+	strbuf_addstr(&table_path, "/");
+	strbuf_addstr(&table_path, st->readers[0]->name);
+	strbuf_addstr(&table_path, ".lock");
 	write_file_buf(table_path.buf, "", 0);
 
 	ref.update_index = 2;
@@ -1077,8 +1078,10 @@ static void t_reftable_stack_auto_compaction_with_locked_tables(void)
 	 * size, we expect that auto-compaction will want to compact all of the
 	 * tables. Locking any of the tables will keep it from doing so.
 	 */
-	strbuf_reset(&buf);
-	strbuf_addf(&buf, "%s/%s.lock", dir, st->readers[2]->name);
+	strbuf_addstr(&buf, dir);
+	strbuf_addstr(&buf, "/");
+	strbuf_addstr(&buf, st->readers[2]->name);
+	strbuf_addstr(&buf, ".lock");
 	write_file_buf(buf.buf, "", 0);
 
 	/*
@@ -1101,7 +1104,6 @@ static void t_reftable_stack_add_performs_auto_compaction(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
-	struct strbuf refname = STRBUF_INIT;
 	char *dir = get_tmp_dir(__LINE__);
 	int err;
 	size_t i, n = 20;
@@ -1115,6 +1117,7 @@ static void t_reftable_stack_add_performs_auto_compaction(void)
 			.value_type = REFTABLE_REF_SYMREF,
 			.value.symref = (char *) "master",
 		};
+		char buf[128];
 
 		/*
 		 * Disable auto-compaction for all but the last runs. Like this
@@ -1123,9 +1126,8 @@ static void t_reftable_stack_add_performs_auto_compaction(void)
 		 */
 		st->opts.disable_auto_compact = i != n;
 
-		strbuf_reset(&refname);
-		strbuf_addf(&refname, "branch-%04"PRIuMAX, (uintmax_t)i);
-		ref.refname = refname.buf;
+		snprintf(buf, sizeof(buf), "branch-%04"PRIuMAX, (uintmax_t)i);
+		ref.refname = buf;
 
 		err = reftable_stack_add(st, write_test_ref, &ref);
 		check(!err);
@@ -1142,7 +1144,6 @@ static void t_reftable_stack_add_performs_auto_compaction(void)
 	}
 
 	reftable_stack_destroy(st);
-	strbuf_release(&refname);
 	clear_dir(dir);
 }
 
@@ -1163,8 +1164,10 @@ static void t_reftable_stack_compaction_with_locked_tables(void)
 	check_int(st->merged->readers_len, ==, 3);
 
 	/* Lock one of the tables that we're about to compact. */
-	strbuf_reset(&buf);
-	strbuf_addf(&buf, "%s/%s.lock", dir, st->readers[1]->name);
+	strbuf_addstr(&buf, dir);
+	strbuf_addstr(&buf, "/");
+	strbuf_addstr(&buf, st->readers[1]->name);
+	strbuf_addstr(&buf, ".lock");
 	write_file_buf(buf.buf, "", 0);
 
 	/*
@@ -1321,10 +1324,13 @@ static void t_reftable_stack_reload_with_missing_table(void)
 	 * our old readers. This should trigger a partial reload of the stack,
 	 * where we try to reuse our old readers.
 	*/
-	strbuf_addf(&content, "%s\n", st->readers[0]->name);
-	strbuf_addf(&content, "%s\n", st->readers[1]->name);
+	strbuf_addstr(&content, st->readers[0]->name);
+	strbuf_addstr(&content, "\n");
+	strbuf_addstr(&content, st->readers[1]->name);
+	strbuf_addstr(&content, "\n");
 	strbuf_addstr(&content, "garbage\n");
-	strbuf_addf(&table_path, "%s.lock", st->list_file);
+	strbuf_addstr(&table_path, st->list_file);
+	strbuf_addstr(&table_path, ".lock");
 	write_file_buf(table_path.buf, content.buf, content.len);
 	err = rename(table_path.buf, st->list_file);
 	check(!err);
-- 
2.47.0.dirty

