Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A65F1531D8
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 04:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729140834; cv=none; b=m0kKmcW5+J5OZgFNS0OgVx/UQbkjQX1xbM0SFHc0dzdJLRI/t3puA3k6gyXyZCRZjJQ5pCOKCkCJe43MwZlw/DAZcI2wlDN6UHO4xS+ShBLeKRTvORNdnsETP+INgOnHog2idlASMefn3jh/Vysgeh+B23lIddUdxKLZgTpyNT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729140834; c=relaxed/simple;
	bh=3IC8IvBQ/WO/2PNSiTHyry8UPrgpBtDvlMq9m76bbms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOzhKtdHbgxQDCTyp+MgrRcQk5Nx0/1xChkpmQiwVhgp5UXMejWmpOBInw6qYD8eXxmt827HPYGQCDMTtu6ea35B6hIG6mW7bxi5ysObMSe7X+VyTmmq722ca9UcYWWwXDA3Cr6DZFqjTkMHPDmXyyBlH0wwQFwWSJocpa34O/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JgnaaiR9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XcqLuvYw; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JgnaaiR9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XcqLuvYw"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 64BE411400A6;
	Thu, 17 Oct 2024 00:53:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 17 Oct 2024 00:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729140830; x=1729227230; bh=/bNVzBSijE
	IK8nCo913Y+3jcI9Efm0YGi7/5Tc/NFVU=; b=JgnaaiR9FYa6uibOYIuCWNGa7h
	hSrfaoh20fuN/DRRXkBmGw/WfV1rFbrjfO9CacmnlZpMFwdocy/q5Gpn8pCRjZWC
	YmQFINro3NTYM6dC04GMyoOCOFLZfzxD8OEswdbikAYWPsbl+oo4LVer161a/gXj
	MLKo962o2ZkZIxlwJb8pDfNwN3CTRZ+HAyLlD1uHnjpmzF+ihT5C74rDFAlZsemn
	OWfUmF+fuXx5NbnxX2q7L+Ari/uHcyNP030Ogp7rK00Jrai81/8yQ61fn+pz61IY
	EtYu/ECvqu21D4Gt2hMH8q4N0gzcOLONa97FwOLLD0XAtzPTaKyKP7zy601Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729140830; x=1729227230; bh=/bNVzBSijEIK8nCo913Y+3jcI9Ef
	m0YGi7/5Tc/NFVU=; b=XcqLuvYwqtqso78DrV0kmP42eHQQZulIgeTsRByT+Qhw
	Xl8EGmj62VuVDx9HFBkGwt3i+bgarE/2RsZ+WZj9b+RJR3szOdUfV3pKIxjCTWKj
	yGM/gUaLiKF5UiachsXyoXxI9IYlaAjnegXPRPk/m1xzuOJcR3fUiZBV2JVmm8yL
	0FnQQoWrNKMfq0tU3Ol/AgsSHoAhrpgZTp66IhJjPl9avAINxcvNMrzndUq/0Cnm
	cIU1DhtOsxwkQiLIFnN0y1iYUkklLu3/VH3Y3Vy7mugJYLmdAWVfzmwS2iJgOP3P
	q6YdD4NQ5AQjKyvWoPrQKliNIzsytDnJrpkj70jLMg==
X-ME-Sender: <xms:XpgQZ5Q8eyB2XqP5ubsefXjjqS-_G3Ld3M8-BS1r8oNo7jt48Fom-Q>
    <xme:XpgQZyzfSwXq68xicv54Gs8aoLbwozCcHaF3qed-lveec8u3PXypPyO2rwl0fwAxB
    GSm2wuLoY9H5mieBg>
X-ME-Received: <xmr:XpgQZ-3lv0cDJezX6EA2XLO2osacPehZI15dv-u4q8mhAoaWbIlDN1P6gWsy6CuJSg-g6d641qFspdvtDz88mz2iJk5AMW_W-Ol2oHlR7N1fjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehtddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:XpgQZxBAp7YbOCOgZQxRVzSQn5nf0tHewqEn9zOGVZI1WM3uiTgC9w>
    <xmx:XpgQZyhryDPi89Ou7ijdZ-RRdMkZRL2oVum0xRHCenXsxiUFhOip-w>
    <xmx:XpgQZ1osYhZqiM_p7WTn6BU--nNv_ve4igYTj02CNGbO3Y-UXbI8bw>
    <xmx:XpgQZ9hPOx1fEDMdGhM2L1IktwA6Tu3O1iEWRtcJseAn4R_5E8r6xA>
    <xmx:XpgQZ0a0J1cnsgP7DksLEBNv8ASAEurpHhjx-uRux5KNW9Tnp7ZGOaH3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 00:53:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b30a5309 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 04:52:30 +0000 (UTC)
Date: Thu, 17 Oct 2024 06:53:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, shejialuo <shejialuo@gmail.com>
Subject: [PATCH v3 02/10] reftable: stop using `strbuf_addf()`
Message-ID: <634fd3c35f5b314093db613d71c83f06bcae0443.1729140565.git.ps@pks.im>
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

We're about to introduce our own `reftable_buf` type to replace
`strbuf`. One function we'll have to convert is `strbuf_addf()`, which
is used in a handful of places. This function uses `snprintf()`
internally, which makes porting it a bit more involved:

  - It is not available on all platforms.

  - Some platforms like Windows have broken implementations.

So by using `snprintf()` we'd also push the burden on downstream users
of the reftable library to make available a properly working version of
it.

Most callsites of `strbuf_addf()` are trivial to convert to not using
it. We do end up using `snprintf()` in our unit tests, but that isn't
much of a problem for downstream users of the reftable library.

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
2.47.0.72.gef8ce8f3d4.dirty

