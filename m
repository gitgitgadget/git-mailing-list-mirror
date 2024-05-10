Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE8168B01
	for <git@vger.kernel.org>; Fri, 10 May 2024 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336967; cv=none; b=s3bgSYudkZ3IFsfVvxA4mMHqFe+/gU0zYXVV5wfmP48Pi+VPel/RR5DVorVE41IVW8Z6C8GoGR51ax4vhhByOJhBhtzuiIdIHX/zCB0kuC0ygWBXsF3Ok+ykpKYthjiG4a4T1ZFcGGvRmcVxCZj0QFgf/nPMW62JpHD50abN3I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336967; c=relaxed/simple;
	bh=4XKN8aafEheiMk7IJ0N51EU+SS+IcyoXCdEtIBcocec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjUfUZ5zOuw1SgWC4ulYVFLKrtcbcjVhaPvgATKFa5txkaft/dfruQ14eikwPb5q1QAla+69aM3pH2SSEf6DfreYfpchK/YT8tJ5b0HQYgi4i0+CmomCZP78BpqAbO1qDToEfEJ3K6F/DIr5vWPKQS4RgdFdLIkj8Tg32NJGkg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cUQdfwZA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wzu9pnex; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cUQdfwZA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wzu9pnex"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 418911800080;
	Fri, 10 May 2024 06:29:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 May 2024 06:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715336963; x=1715423363; bh=Z9RfCj6Tfz
	SgUWUmUzb5BAsuT0PD4K4xHiQiKh3dYVI=; b=cUQdfwZAelTF5SKJUV8bXcsB0g
	/cmx2cb355TxiXKbCXIkU3ZyBis0EyAle7g4Vs13Or4QMGUQ1CA02tgfCWUCq8B2
	ATz1JBWBVNcYGEEn/6r+OuCK2mDgLHd7vCvSx5VKQJuHhO61H0FEu9MSxe2ZXpvT
	IdnZjsA4xHh+2Tl7CYCTTqwPj/oa0dXk5RmULXig0/uI4lsnoJKyyMhT++rck1MW
	CPbc6G/0BmzZn5MIL5cXVx4HwH0bICWC00qUVI9u7MrLM1qmzhNBp7+6EA5eDzva
	HFfIfURacH2IqdN252bJDg09Wrdzvci8RgYq6YCCJQmw2jvLDIZBwqE8/9og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715336963; x=1715423363; bh=Z9RfCj6TfzSgUWUmUzb5BAsuT0PD
	4K4xHiQiKh3dYVI=; b=Wzu9pnexk1hFSosPAhanjn7qU6WrvrecNTAMCIerXQCk
	QgcYZdI7hYKOwfUiXao9zIR/1UFyvH6ThT7cmy3AENvWrWkK1BvEOQmvV64WhOsh
	siJqQdX8SZ08oPQCfR+XedvL30Har7oBzHjP6Teu20VrJiofRckuVh/E3+I7MmG1
	w+v9YPjTdqJqxH3CWeGULL2h/KP20WoCUiwfQP8J3fL8SHBVz+XYdvBu9RwDCw8y
	44LYRKIAy1syvVbIvx9tO0X1pGWkKYagsy/kOFAubJuBvErxZz2GmiknaHe4p+gT
	67lWOibeGu2RJtnZeF22kxsYx/+2/o2yrmJw5vqCKg==
X-ME-Sender: <xms:A_c9Zg10MaJ7_ainThK_AHUf62V-1m9CChDEdHYq4Gj0GwMJkmkPyA>
    <xme:A_c9ZrEzRAeYemmKw1MrmeQJzxzOXLTzzOnnJq-4zz7UF2lGU7-UOdDEj6DtT4Su_
    DSSt2QPoGpgFgI3uw>
X-ME-Received: <xmr:A_c9Zo5gB3t8PLmFcwCaHsptj7DQr5dSB1XNcwWlKls6lCbAv7ZqYk7cB2aZnvgcbdmofHkPgzhVBaSg7_O9TWAcU2t2bMiTWme-aDo27mWytu0sEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:A_c9Zp0cr25Rmpp9p9nF36uxuPcGgGXu_Xn2McYDzGBl7aJJ_iFLCQ>
    <xmx:A_c9ZjEBRDdmS2wozDcMZ7uv0EbCZJQuJCu18x11vKUGXIhosVmLew>
    <xmx:A_c9Zi8kGblOZ-hTLa3jiNlVV_n58Ep6lqRs4PB7GdshGK2bZFSzLA>
    <xmx:A_c9ZokzKPZIKCNCL4vLPpVex7uZ2uPvjYsY5PlaY9mVJIjf9svt_A>
    <xmx:A_c9ZrBAKsvsyITYLq5f_Y0wHvCcHbCKqkcQglAVz6LbIP-NZbHGzDP5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 06:29:22 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6c905aba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 10:29:10 +0000 (UTC)
Date: Fri, 10 May 2024 12:29:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 01/11] reftable: consistently refer to
 `reftable_write_options` as `opts`
Message-ID: <7efa56630681b6aca64c04fd19fb020ffbb76152.1715336798.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715336797.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ckjLLEYmDVZFrA3O"
Content-Disposition: inline
In-Reply-To: <cover.1715336797.git.ps@pks.im>


--ckjLLEYmDVZFrA3O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Throughout the reftable library the `reftable_write_options` are
sometimes referred to as `cfg` and sometimes as `opts`. Unify these to
consistently use `opts` to avoid confusion.

While at it, touch up the coding style a bit by removing unneeded braces
around one-line statements and newlines between variable declarations.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/dump.c           |   4 +-
 reftable/reftable-stack.h |   2 +-
 reftable/stack.c          |  43 +++++++-------
 reftable/stack.h          |   2 +-
 reftable/stack_test.c     | 114 +++++++++++++++++---------------------
 5 files changed, 75 insertions(+), 90 deletions(-)

diff --git a/reftable/dump.c b/reftable/dump.c
index 26e0393c7d..9c770a10cc 100644
--- a/reftable/dump.c
+++ b/reftable/dump.c
@@ -27,9 +27,9 @@ license that can be found in the LICENSE file or at
 static int compact_stack(const char *stackdir)
 {
 	struct reftable_stack *stack =3D NULL;
-	struct reftable_write_options cfg =3D { 0 };
+	struct reftable_write_options opts =3D { 0 };
=20
-	int err =3D reftable_new_stack(&stack, stackdir, cfg);
+	int err =3D reftable_new_stack(&stack, stackdir, opts);
 	if (err < 0)
 		goto done;
=20
diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
index 1b602dda58..9c8e4eef49 100644
--- a/reftable/reftable-stack.h
+++ b/reftable/reftable-stack.h
@@ -29,7 +29,7 @@ struct reftable_stack;
  *  stored in 'dir'. Typically, this should be .git/reftables.
  */
 int reftable_new_stack(struct reftable_stack **dest, const char *dir,
-		       struct reftable_write_options config);
+		       struct reftable_write_options opts);
=20
 /* returns the update_index at which a next table should be written. */
 uint64_t reftable_stack_next_update_index(struct reftable_stack *st);
diff --git a/reftable/stack.c b/reftable/stack.c
index 80266bcbab..3979657793 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -56,15 +56,14 @@ static int reftable_fd_flush(void *arg)
 }
=20
 int reftable_new_stack(struct reftable_stack **dest, const char *dir,
-		       struct reftable_write_options config)
+		       struct reftable_write_options opts)
 {
 	struct reftable_stack *p =3D reftable_calloc(1, sizeof(*p));
 	struct strbuf list_file_name =3D STRBUF_INIT;
 	int err =3D 0;
=20
-	if (config.hash_id =3D=3D 0) {
-		config.hash_id =3D GIT_SHA1_FORMAT_ID;
-	}
+	if (opts.hash_id =3D=3D 0)
+		opts.hash_id =3D GIT_SHA1_FORMAT_ID;
=20
 	*dest =3D NULL;
=20
@@ -75,7 +74,7 @@ int reftable_new_stack(struct reftable_stack **dest, cons=
t char *dir,
 	p->list_file =3D strbuf_detach(&list_file_name, NULL);
 	p->list_fd =3D -1;
 	p->reftable_dir =3D xstrdup(dir);
-	p->config =3D config;
+	p->opts =3D opts;
=20
 	err =3D reftable_stack_reload_maybe_reuse(p, 1);
 	if (err < 0) {
@@ -257,7 +256,7 @@ static int reftable_stack_reload_once(struct reftable_s=
tack *st, char **names,
=20
 	/* success! */
 	err =3D reftable_new_merged_table(&new_merged, new_tables,
-					new_readers_len, st->config.hash_id);
+					new_readers_len, st->opts.hash_id);
 	if (err < 0)
 		goto done;
=20
@@ -580,8 +579,8 @@ static int reftable_stack_init_addition(struct reftable=
_addition *add,
 		}
 		goto done;
 	}
-	if (st->config.default_permissions) {
-		if (chmod(add->lock_file->filename.buf, st->config.default_permissions) =
< 0) {
+	if (st->opts.default_permissions) {
+		if (chmod(add->lock_file->filename.buf, st->opts.default_permissions) < =
0) {
 			err =3D REFTABLE_IO_ERROR;
 			goto done;
 		}
@@ -680,7 +679,7 @@ int reftable_addition_commit(struct reftable_addition *=
add)
 	if (err)
 		goto done;
=20
-	if (!add->stack->config.disable_auto_compact) {
+	if (!add->stack->opts.disable_auto_compact) {
 		/*
 		 * Auto-compact the stack to keep the number of tables in
 		 * control. It is possible that a concurrent writer is already
@@ -758,9 +757,9 @@ int reftable_addition_add(struct reftable_addition *add,
 		err =3D REFTABLE_IO_ERROR;
 		goto done;
 	}
-	if (add->stack->config.default_permissions) {
+	if (add->stack->opts.default_permissions) {
 		if (chmod(get_tempfile_path(tab_file),
-			  add->stack->config.default_permissions)) {
+			  add->stack->opts.default_permissions)) {
 			err =3D REFTABLE_IO_ERROR;
 			goto done;
 		}
@@ -768,7 +767,7 @@ int reftable_addition_add(struct reftable_addition *add,
 	tab_fd =3D get_tempfile_fd(tab_file);
=20
 	wr =3D reftable_new_writer(reftable_fd_write, reftable_fd_flush, &tab_fd,
-				 &add->stack->config);
+				 &add->stack->opts);
 	err =3D write_table(wr, arg);
 	if (err < 0)
 		goto done;
@@ -855,14 +854,14 @@ static int stack_compact_locked(struct reftable_stack=
 *st,
 	}
 	tab_fd =3D get_tempfile_fd(tab_file);
=20
-	if (st->config.default_permissions &&
-	    chmod(get_tempfile_path(tab_file), st->config.default_permissions) < =
0) {
+	if (st->opts.default_permissions &&
+	    chmod(get_tempfile_path(tab_file), st->opts.default_permissions) < 0)=
 {
 		err =3D REFTABLE_IO_ERROR;
 		goto done;
 	}
=20
 	wr =3D reftable_new_writer(reftable_fd_write, reftable_fd_flush,
-				 &tab_fd, &st->config);
+				 &tab_fd, &st->opts);
 	err =3D stack_write_compact(st, wr, first, last, config);
 	if (err < 0)
 		goto done;
@@ -910,7 +909,7 @@ static int stack_write_compact(struct reftable_stack *s=
t,
 				   st->readers[last]->max_update_index);
=20
 	err =3D reftable_new_merged_table(&mt, subtabs, subtabs_len,
-					st->config.hash_id);
+					st->opts.hash_id);
 	if (err < 0) {
 		reftable_free(subtabs);
 		goto done;
@@ -1100,9 +1099,9 @@ static int stack_compact_range(struct reftable_stack =
*st,
 		goto done;
 	}
=20
-	if (st->config.default_permissions) {
+	if (st->opts.default_permissions) {
 		if (chmod(get_lock_file_path(&tables_list_lock),
-			  st->config.default_permissions) < 0) {
+			  st->opts.default_permissions) < 0) {
 			err =3D REFTABLE_IO_ERROR;
 			goto done;
 		}
@@ -1292,7 +1291,7 @@ static uint64_t *stack_table_sizes_for_compaction(str=
uct reftable_stack *st)
 {
 	uint64_t *sizes =3D
 		reftable_calloc(st->merged->stack_len, sizeof(*sizes));
-	int version =3D (st->config.hash_id =3D=3D GIT_SHA1_FORMAT_ID) ? 1 : 2;
+	int version =3D (st->opts.hash_id =3D=3D GIT_SHA1_FORMAT_ID) ? 1 : 2;
 	int overhead =3D header_size(version) - 1;
 	int i =3D 0;
 	for (i =3D 0; i < st->merged->stack_len; i++) {
@@ -1368,7 +1367,7 @@ static int stack_check_addition(struct reftable_stack=
 *st,
 	int len =3D 0;
 	int i =3D 0;
=20
-	if (st->config.skip_name_check)
+	if (st->opts.skip_name_check)
 		return 0;
=20
 	err =3D reftable_block_source_from_file(&src, new_tab_name);
@@ -1500,11 +1499,11 @@ int reftable_stack_clean(struct reftable_stack *st)
 int reftable_stack_print_directory(const char *stackdir, uint32_t hash_id)
 {
 	struct reftable_stack *stack =3D NULL;
-	struct reftable_write_options cfg =3D { .hash_id =3D hash_id };
+	struct reftable_write_options opts =3D { .hash_id =3D hash_id };
 	struct reftable_merged_table *merged =3D NULL;
 	struct reftable_table table =3D { NULL };
=20
-	int err =3D reftable_new_stack(&stack, stackdir, cfg);
+	int err =3D reftable_new_stack(&stack, stackdir, opts);
 	if (err < 0)
 		goto done;
=20
diff --git a/reftable/stack.h b/reftable/stack.h
index d43efa4760..97d7ebc043 100644
--- a/reftable/stack.h
+++ b/reftable/stack.h
@@ -20,7 +20,7 @@ struct reftable_stack {
=20
 	char *reftable_dir;
=20
-	struct reftable_write_options config;
+	struct reftable_write_options opts;
=20
 	struct reftable_reader **readers;
 	size_t readers_len;
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 1df3ffce52..3316d55f19 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -150,7 +150,7 @@ static void test_reftable_stack_add_one(void)
 	char *dir =3D get_tmp_dir(__LINE__);
 	struct strbuf scratch =3D STRBUF_INIT;
 	int mask =3D umask(002);
-	struct reftable_write_options cfg =3D {
+	struct reftable_write_options opts =3D {
 		.default_permissions =3D 0660,
 	};
 	struct reftable_stack *st =3D NULL;
@@ -163,7 +163,7 @@ static void test_reftable_stack_add_one(void)
 	};
 	struct reftable_ref_record dest =3D { NULL };
 	struct stat stat_result =3D { 0 };
-	err =3D reftable_new_stack(&st, dir, cfg);
+	err =3D reftable_new_stack(&st, dir, opts);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_add(st, &write_test_ref, &ref);
@@ -186,7 +186,7 @@ static void test_reftable_stack_add_one(void)
 	strbuf_addstr(&scratch, "/tables.list");
 	err =3D stat(scratch.buf, &stat_result);
 	EXPECT(!err);
-	EXPECT((stat_result.st_mode & 0777) =3D=3D cfg.default_permissions);
+	EXPECT((stat_result.st_mode & 0777) =3D=3D opts.default_permissions);
=20
 	strbuf_reset(&scratch);
 	strbuf_addstr(&scratch, dir);
@@ -195,7 +195,7 @@ static void test_reftable_stack_add_one(void)
 	strbuf_addstr(&scratch, st->readers[0]->name);
 	err =3D stat(scratch.buf, &stat_result);
 	EXPECT(!err);
-	EXPECT((stat_result.st_mode & 0777) =3D=3D cfg.default_permissions);
+	EXPECT((stat_result.st_mode & 0777) =3D=3D opts.default_permissions);
 #else
 	(void) stat_result;
 #endif
@@ -209,7 +209,7 @@ static void test_reftable_stack_add_one(void)
=20
 static void test_reftable_stack_uptodate(void)
 {
-	struct reftable_write_options cfg =3D { 0 };
+	struct reftable_write_options opts =3D { 0 };
 	struct reftable_stack *st1 =3D NULL;
 	struct reftable_stack *st2 =3D NULL;
 	char *dir =3D get_tmp_dir(__LINE__);
@@ -232,10 +232,10 @@ static void test_reftable_stack_uptodate(void)
 	/* simulate multi-process access to the same stack
 	   by creating two stacks for the same directory.
 	 */
-	err =3D reftable_new_stack(&st1, dir, cfg);
+	err =3D reftable_new_stack(&st1, dir, opts);
 	EXPECT_ERR(err);
=20
-	err =3D reftable_new_stack(&st2, dir, cfg);
+	err =3D reftable_new_stack(&st2, dir, opts);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_add(st1, &write_test_ref, &ref1);
@@ -257,8 +257,7 @@ static void test_reftable_stack_uptodate(void)
 static void test_reftable_stack_transaction_api(void)
 {
 	char *dir =3D get_tmp_dir(__LINE__);
-
-	struct reftable_write_options cfg =3D { 0 };
+	struct reftable_write_options opts =3D { 0 };
 	struct reftable_stack *st =3D NULL;
 	int err;
 	struct reftable_addition *add =3D NULL;
@@ -271,8 +270,7 @@ static void test_reftable_stack_transaction_api(void)
 	};
 	struct reftable_ref_record dest =3D { NULL };
=20
-
-	err =3D reftable_new_stack(&st, dir, cfg);
+	err =3D reftable_new_stack(&st, dir, opts);
 	EXPECT_ERR(err);
=20
 	reftable_addition_destroy(add);
@@ -301,12 +299,12 @@ static void test_reftable_stack_transaction_api(void)
 static void test_reftable_stack_transaction_api_performs_auto_compaction(v=
oid)
 {
 	char *dir =3D get_tmp_dir(__LINE__);
-	struct reftable_write_options cfg =3D {0};
+	struct reftable_write_options opts =3D {0};
 	struct reftable_addition *add =3D NULL;
 	struct reftable_stack *st =3D NULL;
 	int i, n =3D 20, err;
=20
-	err =3D reftable_new_stack(&st, dir, cfg);
+	err =3D reftable_new_stack(&st, dir, opts);
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i <=3D n; i++) {
@@ -325,7 +323,7 @@ static void test_reftable_stack_transaction_api_perform=
s_auto_compaction(void)
 		 * we can ensure that we indeed honor this setting and have
 		 * better control over when exactly auto compaction runs.
 		 */
-		st->config.disable_auto_compact =3D i !=3D n;
+		st->opts.disable_auto_compact =3D i !=3D n;
=20
 		err =3D reftable_stack_new_addition(&add, st);
 		EXPECT_ERR(err);
@@ -361,13 +359,13 @@ static void test_reftable_stack_auto_compaction_fails=
_gracefully(void)
 		.value_type =3D REFTABLE_REF_VAL1,
 		.value.val1 =3D {0x01},
 	};
-	struct reftable_write_options cfg =3D {0};
+	struct reftable_write_options opts =3D {0};
 	struct reftable_stack *st;
 	struct strbuf table_path =3D STRBUF_INIT;
 	char *dir =3D get_tmp_dir(__LINE__);
 	int err;
=20
-	err =3D reftable_new_stack(&st, dir, cfg);
+	err =3D reftable_new_stack(&st, dir, opts);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_add(st, write_test_ref, &ref);
@@ -442,8 +440,7 @@ static int write_error(struct reftable_writer *wr, void=
 *arg)
 static void test_reftable_stack_update_index_check(void)
 {
 	char *dir =3D get_tmp_dir(__LINE__);
-
-	struct reftable_write_options cfg =3D { 0 };
+	struct reftable_write_options opts =3D { 0 };
 	struct reftable_stack *st =3D NULL;
 	int err;
 	struct reftable_ref_record ref1 =3D {
@@ -459,7 +456,7 @@ static void test_reftable_stack_update_index_check(void)
 		.value.symref =3D "master",
 	};
=20
-	err =3D reftable_new_stack(&st, dir, cfg);
+	err =3D reftable_new_stack(&st, dir, opts);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_add(st, &write_test_ref, &ref1);
@@ -474,12 +471,11 @@ static void test_reftable_stack_update_index_check(vo=
id)
 static void test_reftable_stack_lock_failure(void)
 {
 	char *dir =3D get_tmp_dir(__LINE__);
-
-	struct reftable_write_options cfg =3D { 0 };
+	struct reftable_write_options opts =3D { 0 };
 	struct reftable_stack *st =3D NULL;
 	int err, i;
=20
-	err =3D reftable_new_stack(&st, dir, cfg);
+	err =3D reftable_new_stack(&st, dir, opts);
 	EXPECT_ERR(err);
 	for (i =3D -1; i !=3D REFTABLE_EMPTY_TABLE_ERROR; i--) {
 		err =3D reftable_stack_add(st, &write_error, &i);
@@ -494,7 +490,7 @@ static void test_reftable_stack_add(void)
 {
 	int i =3D 0;
 	int err =3D 0;
-	struct reftable_write_options cfg =3D {
+	struct reftable_write_options opts =3D {
 		.exact_log_message =3D 1,
 		.default_permissions =3D 0660,
 		.disable_auto_compact =3D 1,
@@ -507,7 +503,7 @@ static void test_reftable_stack_add(void)
 	struct stat stat_result;
 	int N =3D ARRAY_SIZE(refs);
=20
-	err =3D reftable_new_stack(&st, dir, cfg);
+	err =3D reftable_new_stack(&st, dir, opts);
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i < N; i++) {
@@ -566,7 +562,7 @@ static void test_reftable_stack_add(void)
 	strbuf_addstr(&path, "/tables.list");
 	err =3D stat(path.buf, &stat_result);
 	EXPECT(!err);
-	EXPECT((stat_result.st_mode & 0777) =3D=3D cfg.default_permissions);
+	EXPECT((stat_result.st_mode & 0777) =3D=3D opts.default_permissions);
=20
 	strbuf_reset(&path);
 	strbuf_addstr(&path, dir);
@@ -575,7 +571,7 @@ static void test_reftable_stack_add(void)
 	strbuf_addstr(&path, st->readers[0]->name);
 	err =3D stat(path.buf, &stat_result);
 	EXPECT(!err);
-	EXPECT((stat_result.st_mode & 0777) =3D=3D cfg.default_permissions);
+	EXPECT((stat_result.st_mode & 0777) =3D=3D opts.default_permissions);
 #else
 	(void) stat_result;
 #endif
@@ -593,7 +589,7 @@ static void test_reftable_stack_add(void)
 static void test_reftable_stack_log_normalize(void)
 {
 	int err =3D 0;
-	struct reftable_write_options cfg =3D {
+	struct reftable_write_options opts =3D {
 		0,
 	};
 	struct reftable_stack *st =3D NULL;
@@ -617,7 +613,7 @@ static void test_reftable_stack_log_normalize(void)
 		.update_index =3D 1,
 	};
=20
-	err =3D reftable_new_stack(&st, dir, cfg);
+	err =3D reftable_new_stack(&st, dir, opts);
 	EXPECT_ERR(err);
=20
 	input.value.update.message =3D "one\ntwo";
@@ -650,8 +646,7 @@ static void test_reftable_stack_tombstone(void)
 {
 	int i =3D 0;
 	char *dir =3D get_tmp_dir(__LINE__);
-
-	struct reftable_write_options cfg =3D { 0 };
+	struct reftable_write_options opts =3D { 0 };
 	struct reftable_stack *st =3D NULL;
 	int err;
 	struct reftable_ref_record refs[2] =3D { { NULL } };
@@ -660,8 +655,7 @@ static void test_reftable_stack_tombstone(void)
 	struct reftable_ref_record dest =3D { NULL };
 	struct reftable_log_record log_dest =3D { NULL };
=20
-
-	err =3D reftable_new_stack(&st, dir, cfg);
+	err =3D reftable_new_stack(&st, dir, opts);
 	EXPECT_ERR(err);
=20
 	/* even entries add the refs, odd entries delete them. */
@@ -729,8 +723,7 @@ static void test_reftable_stack_tombstone(void)
 static void test_reftable_stack_hash_id(void)
 {
 	char *dir =3D get_tmp_dir(__LINE__);
-
-	struct reftable_write_options cfg =3D { 0 };
+	struct reftable_write_options opts =3D { 0 };
 	struct reftable_stack *st =3D NULL;
 	int err;
=20
@@ -740,24 +733,24 @@ static void test_reftable_stack_hash_id(void)
 		.value.symref =3D "target",
 		.update_index =3D 1,
 	};
-	struct reftable_write_options cfg32 =3D { .hash_id =3D GIT_SHA256_FORMAT_=
ID };
+	struct reftable_write_options opts32 =3D { .hash_id =3D GIT_SHA256_FORMAT=
_ID };
 	struct reftable_stack *st32 =3D NULL;
-	struct reftable_write_options cfg_default =3D { 0 };
+	struct reftable_write_options opts_default =3D { 0 };
 	struct reftable_stack *st_default =3D NULL;
 	struct reftable_ref_record dest =3D { NULL };
=20
-	err =3D reftable_new_stack(&st, dir, cfg);
+	err =3D reftable_new_stack(&st, dir, opts);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_add(st, &write_test_ref, &ref);
 	EXPECT_ERR(err);
=20
 	/* can't read it with the wrong hash ID. */
-	err =3D reftable_new_stack(&st32, dir, cfg32);
+	err =3D reftable_new_stack(&st32, dir, opts32);
 	EXPECT(err =3D=3D REFTABLE_FORMAT_ERROR);
=20
-	/* check that we can read it back with default config too. */
-	err =3D reftable_new_stack(&st_default, dir, cfg_default);
+	/* check that we can read it back with default opts too. */
+	err =3D reftable_new_stack(&st_default, dir, opts_default);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_read_ref(st_default, "master", &dest);
@@ -790,8 +783,7 @@ static void test_suggest_compaction_segment_nothing(voi=
d)
 static void test_reflog_expire(void)
 {
 	char *dir =3D get_tmp_dir(__LINE__);
-
-	struct reftable_write_options cfg =3D { 0 };
+	struct reftable_write_options opts =3D { 0 };
 	struct reftable_stack *st =3D NULL;
 	struct reftable_log_record logs[20] =3D { { NULL } };
 	int N =3D ARRAY_SIZE(logs) - 1;
@@ -802,8 +794,7 @@ static void test_reflog_expire(void)
 	};
 	struct reftable_log_record log =3D { NULL };
=20
-
-	err =3D reftable_new_stack(&st, dir, cfg);
+	err =3D reftable_new_stack(&st, dir, opts);
 	EXPECT_ERR(err);
=20
 	for (i =3D 1; i <=3D N; i++) {
@@ -866,21 +857,19 @@ static int write_nothing(struct reftable_writer *wr, =
void *arg)
=20
 static void test_empty_add(void)
 {
-	struct reftable_write_options cfg =3D { 0 };
+	struct reftable_write_options opts =3D { 0 };
 	struct reftable_stack *st =3D NULL;
 	int err;
 	char *dir =3D get_tmp_dir(__LINE__);
-
 	struct reftable_stack *st2 =3D NULL;
=20
-
-	err =3D reftable_new_stack(&st, dir, cfg);
+	err =3D reftable_new_stack(&st, dir, opts);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_add(st, &write_nothing, NULL);
 	EXPECT_ERR(err);
=20
-	err =3D reftable_new_stack(&st2, dir, cfg);
+	err =3D reftable_new_stack(&st2, dir, opts);
 	EXPECT_ERR(err);
 	clear_dir(dir);
 	reftable_stack_destroy(st);
@@ -899,16 +888,15 @@ static int fastlog2(uint64_t sz)
=20
 static void test_reftable_stack_auto_compaction(void)
 {
-	struct reftable_write_options cfg =3D {
+	struct reftable_write_options opts =3D {
 		.disable_auto_compact =3D 1,
 	};
 	struct reftable_stack *st =3D NULL;
 	char *dir =3D get_tmp_dir(__LINE__);
-
 	int err, i;
 	int N =3D 100;
=20
-	err =3D reftable_new_stack(&st, dir, cfg);
+	err =3D reftable_new_stack(&st, dir, opts);
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i < N; i++) {
@@ -938,13 +926,13 @@ static void test_reftable_stack_auto_compaction(void)
=20
 static void test_reftable_stack_add_performs_auto_compaction(void)
 {
-	struct reftable_write_options cfg =3D { 0 };
+	struct reftable_write_options opts =3D { 0 };
 	struct reftable_stack *st =3D NULL;
 	struct strbuf refname =3D STRBUF_INIT;
 	char *dir =3D get_tmp_dir(__LINE__);
 	int err, i, n =3D 20;
=20
-	err =3D reftable_new_stack(&st, dir, cfg);
+	err =3D reftable_new_stack(&st, dir, opts);
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i <=3D n; i++) {
@@ -959,7 +947,7 @@ static void test_reftable_stack_add_performs_auto_compa=
ction(void)
 		 * we can ensure that we indeed honor this setting and have
 		 * better control over when exactly auto compaction runs.
 		 */
-		st->config.disable_auto_compact =3D i !=3D n;
+		st->opts.disable_auto_compact =3D i !=3D n;
=20
 		strbuf_reset(&refname);
 		strbuf_addf(&refname, "branch-%04d", i);
@@ -986,14 +974,13 @@ static void test_reftable_stack_add_performs_auto_com=
paction(void)
=20
 static void test_reftable_stack_compaction_concurrent(void)
 {
-	struct reftable_write_options cfg =3D { 0 };
+	struct reftable_write_options opts =3D { 0 };
 	struct reftable_stack *st1 =3D NULL, *st2 =3D NULL;
 	char *dir =3D get_tmp_dir(__LINE__);
-
 	int err, i;
 	int N =3D 3;
=20
-	err =3D reftable_new_stack(&st1, dir, cfg);
+	err =3D reftable_new_stack(&st1, dir, opts);
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i < N; i++) {
@@ -1010,7 +997,7 @@ static void test_reftable_stack_compaction_concurrent(=
void)
 		EXPECT_ERR(err);
 	}
=20
-	err =3D reftable_new_stack(&st2, dir, cfg);
+	err =3D reftable_new_stack(&st2, dir, opts);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_compact_all(st1, NULL);
@@ -1036,14 +1023,13 @@ static void unclean_stack_close(struct reftable_sta=
ck *st)
=20
 static void test_reftable_stack_compaction_concurrent_clean(void)
 {
-	struct reftable_write_options cfg =3D { 0 };
+	struct reftable_write_options opts =3D { 0 };
 	struct reftable_stack *st1 =3D NULL, *st2 =3D NULL, *st3 =3D NULL;
 	char *dir =3D get_tmp_dir(__LINE__);
-
 	int err, i;
 	int N =3D 3;
=20
-	err =3D reftable_new_stack(&st1, dir, cfg);
+	err =3D reftable_new_stack(&st1, dir, opts);
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i < N; i++) {
@@ -1060,7 +1046,7 @@ static void test_reftable_stack_compaction_concurrent=
_clean(void)
 		EXPECT_ERR(err);
 	}
=20
-	err =3D reftable_new_stack(&st2, dir, cfg);
+	err =3D reftable_new_stack(&st2, dir, opts);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_compact_all(st1, NULL);
@@ -1069,7 +1055,7 @@ static void test_reftable_stack_compaction_concurrent=
_clean(void)
 	unclean_stack_close(st1);
 	unclean_stack_close(st2);
=20
-	err =3D reftable_new_stack(&st3, dir, cfg);
+	err =3D reftable_new_stack(&st3, dir, opts);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_clean(st3);
--=20
2.45.0


--ckjLLEYmDVZFrA3O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY99wAACgkQVbJhu7ck
PpS5TA//SOwTULJneQK3F0S0Ip8/s9yHvV7LmnM35V3wjvBjT0Ee7EPEBH14mPv6
9vaiSedBbMs0GRrTm/JoQMSFu0hi0HPhsCzn2TjKMItt/x0gQLYr81FBUywI9xxp
j5989nHpQq3GUbtMD+uRk4xluhUki2kgR1Ac+qoRUcwafPa/a1ExDN6UFgLcQsYg
gqBJ3Ec5tlYoPEPW8OkflmO7TipjOxOL9Uko20RIc7ShdUyPg6tXiTwrrdDyh4GK
kpLSbTGEKrivHjEDg/GAjZlVmiv8ahYnE6yZK5GO7G6NvviOQlrGFJjGA110R8GK
QwLFJ/JqsrKBTCnQ6AftgCjT9eXej+sSCjIlk7bKUzGzdcoV+cyKWCMC3KuUIR0/
4mNyKt0oP0+nXhlv2I/mhR1HbQRulLv4r86JnIc6irwujOUvhEfZ3g1aGDxflYD4
ySz+XzwwcW7pW76lIEU8ZKC9WI0kdTQw4mtyy+VhitUK/s0yRhDzK9tjbSJ5j5Ss
4SPZ3wiG2BDjZQ4hwhKKaCrHse7ddXr0i+qQwEE8iIQha4ZjxZ4Y5esztWdpY/jr
Mn+d82EOqEoXrpAWNj1Boc7IbvhXOgGRfk+OWQkVTgNePjW3N/YeS14q2y5z5DhV
H0F1ZDJVGJzAiNDJeLzCfANPQnsI3OEvS3IYUZwGvV2aMSzdDik=
=Ze4p
-----END PGP SIGNATURE-----

--ckjLLEYmDVZFrA3O--
