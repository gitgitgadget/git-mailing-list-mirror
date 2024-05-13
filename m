Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC23146D6B
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588281; cv=none; b=ha6Domux5obH3fOFkcOxQ/P2M460/j7DbpwHz4lyZt9cgHNz66qelBka08ApGE+wost7W8uSkK0InhxaZX930MJ8Q79BbLSb+PqnWzZnFFAWfugO6CWQtK2Eg4zki12Luo9JGl1PYTfAta2B/lkSBlWvaTMbiKEsS24eHE4mN2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588281; c=relaxed/simple;
	bh=vV+qWDOx/XpFE9wVIX94qQBHDwMyUGjSrprgEFpgueE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9Mp2B67jc2HfkgBgCwuHEdmPqqRoo6b2N1XM+Ux4kzCc08JZ9WTPAwqEsSRgelafkgdggMDsUlp6uUEo9rI3D4Z+rRLwOLkhgPSD+1T+LZsI9ZhqPgmakXy/UbaJFqiom0mhKIjZqw68vdIQYA3t0Fh6faWSBtoo00m0Bzyw1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AyMe2rA8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=etRKtyTn; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AyMe2rA8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="etRKtyTn"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id A00E51C00111;
	Mon, 13 May 2024 04:17:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 13 May 2024 04:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715588278; x=1715674678; bh=pfmSqCkthq
	8J6nonuCQmQQOrFuU4ZevyJT0SZsXIFzg=; b=AyMe2rA8ZtLO/IVwaJOKtRZqnT
	rm+5/5Kqn9D1mFPL1f5Rn1PFX0VtniiT9TkTlWIkYjb0qduws+lLuGSiiEXfKDxC
	D+fdsB3QERzQUEfNKSA1mBIDiSmRKOuNIQKJxpSZIyo4pT7qjlm3ibxpt8QQreJu
	NNKFNJDv/4Onk/nLAN138+rUvzAwJ7syKUsXv61izaBqeRwgniatWz0nPikDwsyD
	KShFm7k4sdO6gKK0ZIWHigDBTEQZC8lSy0YJUuY1JIajKqUvtUan1Ce0B0J4V9on
	EtsxFHIT4QMISkC9Ja7d7g6irhHNnM14RlBJAxFl2cWlLc9SlnpBtvcIkmsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715588278; x=1715674678; bh=pfmSqCkthq8J6nonuCQmQQOrFuU4
	ZevyJT0SZsXIFzg=; b=etRKtyTnM5X9gCgjtJe9BQ8I++lXdNDd/ZCErv8eBR8R
	VcxSFdfRPvpWqlDY3vqi5Dsty70ywwQmuH006YibLi9iIDlc2GFjOs/WH4zirhjQ
	xz/o/065vKgT826JUdVUSaWg4dnkqfr91M31jp1heYN+IojpHDvD7qUMxbdea8Sj
	WfI8Kn9x1EXY3Orwk9s+Ph6F/TQV+sKtX0n9DHg7oIsSWYy6+Qg+X34/30IDMwrC
	CThTNdReuCgtFlMAlbY660TLqRExyltUCCt4hHcSc4jdFVsMoodYy63s70Se4cj4
	yOnoNaLmKTuRI/a6n1fFr5gmhGI3Bszz04oGToixNg==
X-ME-Sender: <xms:tsxBZttS_TSa3c2YsQBqG9FyGt_OyxsC2qkdtrAeQDmqy_oWEtFUZA>
    <xme:tsxBZmclJ7xIwY_bubBs3IUftqsLshNaZ86GI_kFC7oCi0pOnTZJ8-Bei2lQi6opq
    DrVerQjJ4NnKgwNkg>
X-ME-Received: <xmr:tsxBZgzPmQxNqCkwQQVdkVDSvpJ0dewh0pXhOZrtwQSUQ4pZiBiUvqBxO3yhIxMUW3z6Fs64IZY6eL9bO7aGPORfiWailCrxOSmBFAamR6VUmlE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:tsxBZkNcdRnYKwS9c4UREIkHtJaxzcbsKlavad2-kjB5U_m0jgDr8w>
    <xmx:tsxBZt8-5KuXuK0IA3xx0DqA_LyOJmcyK2yqXrweEO8ToI9vBA0-mg>
    <xmx:tsxBZkW7JRlF3OOGhHMBPiPrmbK3QnFYin0i7jT3ssy1Lnwq3iTdGA>
    <xmx:tsxBZudLiofdJW3K7qoaJH6RodoRD2T1JKcvV733iRMNT-ybL2lAHg>
    <xmx:tsxBZpbQTCTLqj76PDHIuAdQ_83HqsuXPWz05M8n2D_F5xzn7q8Lj33S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:17:57 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6fe717c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:17:38 +0000 (UTC)
Date: Mon, 13 May 2024 10:17:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/11] reftable: consistently refer to
 `reftable_write_options` as `opts`
Message-ID: <71f4e31cf7c03b7679fc7d5c018063b938a6ee35.1715587849.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715587849.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V8a5hW/IDvTv9uSb"
Content-Disposition: inline
In-Reply-To: <cover.1715587849.git.ps@pks.im>


--V8a5hW/IDvTv9uSb
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
 reftable/stack.c          |  41 +++++++-------
 reftable/stack.h          |   2 +-
 reftable/stack_test.c     | 114 +++++++++++++++++---------------------
 5 files changed, 74 insertions(+), 89 deletions(-)

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
index a59ebe038d..54e7473f3a 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -54,15 +54,14 @@ static int reftable_fd_flush(void *arg)
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
@@ -73,7 +72,7 @@ int reftable_new_stack(struct reftable_stack **dest, cons=
t char *dir,
 	p->list_file =3D strbuf_detach(&list_file_name, NULL);
 	p->list_fd =3D -1;
 	p->reftable_dir =3D xstrdup(dir);
-	p->config =3D config;
+	p->opts =3D opts;
=20
 	err =3D reftable_stack_reload_maybe_reuse(p, 1);
 	if (err < 0) {
@@ -255,7 +254,7 @@ static int reftable_stack_reload_once(struct reftable_s=
tack *st, char **names,
=20
 	/* success! */
 	err =3D reftable_new_merged_table(&new_merged, new_tables,
-					new_readers_len, st->config.hash_id);
+					new_readers_len, st->opts.hash_id);
 	if (err < 0)
 		goto done;
=20
@@ -578,8 +577,8 @@ static int reftable_stack_init_addition(struct reftable=
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
@@ -678,7 +677,7 @@ int reftable_addition_commit(struct reftable_addition *=
add)
 	if (err)
 		goto done;
=20
-	if (!add->stack->config.disable_auto_compact) {
+	if (!add->stack->opts.disable_auto_compact) {
 		/*
 		 * Auto-compact the stack to keep the number of tables in
 		 * control. It is possible that a concurrent writer is already
@@ -756,9 +755,9 @@ int reftable_addition_add(struct reftable_addition *add,
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
@@ -766,7 +765,7 @@ int reftable_addition_add(struct reftable_addition *add,
 	tab_fd =3D get_tempfile_fd(tab_file);
=20
 	wr =3D reftable_new_writer(reftable_fd_write, reftable_fd_flush, &tab_fd,
-				 &add->stack->config);
+				 &add->stack->opts);
 	err =3D write_table(wr, arg);
 	if (err < 0)
 		goto done;
@@ -849,14 +848,14 @@ static int stack_compact_locked(struct reftable_stack=
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
@@ -904,7 +903,7 @@ static int stack_write_compact(struct reftable_stack *s=
t,
 				   st->readers[last]->max_update_index);
=20
 	err =3D reftable_new_merged_table(&mt, subtabs, subtabs_len,
-					st->config.hash_id);
+					st->opts.hash_id);
 	if (err < 0) {
 		reftable_free(subtabs);
 		goto done;
@@ -1094,9 +1093,9 @@ static int stack_compact_range(struct reftable_stack =
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
@@ -1286,7 +1285,7 @@ static uint64_t *stack_table_sizes_for_compaction(str=
uct reftable_stack *st)
 {
 	uint64_t *sizes =3D
 		reftable_calloc(st->merged->stack_len, sizeof(*sizes));
-	int version =3D (st->config.hash_id =3D=3D GIT_SHA1_FORMAT_ID) ? 1 : 2;
+	int version =3D (st->opts.hash_id =3D=3D GIT_SHA1_FORMAT_ID) ? 1 : 2;
 	int overhead =3D header_size(version) - 1;
 	int i =3D 0;
 	for (i =3D 0; i < st->merged->stack_len; i++) {
@@ -1435,11 +1434,11 @@ int reftable_stack_clean(struct reftable_stack *st)
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
index 7889f818d1..e17ad4dc62 100644
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
@@ -404,8 +402,7 @@ static int write_error(struct reftable_writer *wr, void=
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
@@ -421,7 +418,7 @@ static void test_reftable_stack_update_index_check(void)
 		.value.symref =3D "master",
 	};
=20
-	err =3D reftable_new_stack(&st, dir, cfg);
+	err =3D reftable_new_stack(&st, dir, opts);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_add(st, &write_test_ref, &ref1);
@@ -436,12 +433,11 @@ static void test_reftable_stack_update_index_check(vo=
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
@@ -456,7 +452,7 @@ static void test_reftable_stack_add(void)
 {
 	int i =3D 0;
 	int err =3D 0;
-	struct reftable_write_options cfg =3D {
+	struct reftable_write_options opts =3D {
 		.exact_log_message =3D 1,
 		.default_permissions =3D 0660,
 		.disable_auto_compact =3D 1,
@@ -469,7 +465,7 @@ static void test_reftable_stack_add(void)
 	struct stat stat_result;
 	int N =3D ARRAY_SIZE(refs);
=20
-	err =3D reftable_new_stack(&st, dir, cfg);
+	err =3D reftable_new_stack(&st, dir, opts);
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i < N; i++) {
@@ -528,7 +524,7 @@ static void test_reftable_stack_add(void)
 	strbuf_addstr(&path, "/tables.list");
 	err =3D stat(path.buf, &stat_result);
 	EXPECT(!err);
-	EXPECT((stat_result.st_mode & 0777) =3D=3D cfg.default_permissions);
+	EXPECT((stat_result.st_mode & 0777) =3D=3D opts.default_permissions);
=20
 	strbuf_reset(&path);
 	strbuf_addstr(&path, dir);
@@ -537,7 +533,7 @@ static void test_reftable_stack_add(void)
 	strbuf_addstr(&path, st->readers[0]->name);
 	err =3D stat(path.buf, &stat_result);
 	EXPECT(!err);
-	EXPECT((stat_result.st_mode & 0777) =3D=3D cfg.default_permissions);
+	EXPECT((stat_result.st_mode & 0777) =3D=3D opts.default_permissions);
 #else
 	(void) stat_result;
 #endif
@@ -555,7 +551,7 @@ static void test_reftable_stack_add(void)
 static void test_reftable_stack_log_normalize(void)
 {
 	int err =3D 0;
-	struct reftable_write_options cfg =3D {
+	struct reftable_write_options opts =3D {
 		0,
 	};
 	struct reftable_stack *st =3D NULL;
@@ -579,7 +575,7 @@ static void test_reftable_stack_log_normalize(void)
 		.update_index =3D 1,
 	};
=20
-	err =3D reftable_new_stack(&st, dir, cfg);
+	err =3D reftable_new_stack(&st, dir, opts);
 	EXPECT_ERR(err);
=20
 	input.value.update.message =3D "one\ntwo";
@@ -612,8 +608,7 @@ static void test_reftable_stack_tombstone(void)
 {
 	int i =3D 0;
 	char *dir =3D get_tmp_dir(__LINE__);
-
-	struct reftable_write_options cfg =3D { 0 };
+	struct reftable_write_options opts =3D { 0 };
 	struct reftable_stack *st =3D NULL;
 	int err;
 	struct reftable_ref_record refs[2] =3D { { NULL } };
@@ -622,8 +617,7 @@ static void test_reftable_stack_tombstone(void)
 	struct reftable_ref_record dest =3D { NULL };
 	struct reftable_log_record log_dest =3D { NULL };
=20
-
-	err =3D reftable_new_stack(&st, dir, cfg);
+	err =3D reftable_new_stack(&st, dir, opts);
 	EXPECT_ERR(err);
=20
 	/* even entries add the refs, odd entries delete them. */
@@ -691,8 +685,7 @@ static void test_reftable_stack_tombstone(void)
 static void test_reftable_stack_hash_id(void)
 {
 	char *dir =3D get_tmp_dir(__LINE__);
-
-	struct reftable_write_options cfg =3D { 0 };
+	struct reftable_write_options opts =3D { 0 };
 	struct reftable_stack *st =3D NULL;
 	int err;
=20
@@ -702,24 +695,24 @@ static void test_reftable_stack_hash_id(void)
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
@@ -752,8 +745,7 @@ static void test_suggest_compaction_segment_nothing(voi=
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
@@ -764,8 +756,7 @@ static void test_reflog_expire(void)
 	};
 	struct reftable_log_record log =3D { NULL };
=20
-
-	err =3D reftable_new_stack(&st, dir, cfg);
+	err =3D reftable_new_stack(&st, dir, opts);
 	EXPECT_ERR(err);
=20
 	for (i =3D 1; i <=3D N; i++) {
@@ -828,21 +819,19 @@ static int write_nothing(struct reftable_writer *wr, =
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
@@ -861,16 +850,15 @@ static int fastlog2(uint64_t sz)
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
@@ -900,13 +888,13 @@ static void test_reftable_stack_auto_compaction(void)
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
@@ -921,7 +909,7 @@ static void test_reftable_stack_add_performs_auto_compa=
ction(void)
 		 * we can ensure that we indeed honor this setting and have
 		 * better control over when exactly auto compaction runs.
 		 */
-		st->config.disable_auto_compact =3D i !=3D n;
+		st->opts.disable_auto_compact =3D i !=3D n;
=20
 		strbuf_reset(&refname);
 		strbuf_addf(&refname, "branch-%04d", i);
@@ -948,14 +936,13 @@ static void test_reftable_stack_add_performs_auto_com=
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
@@ -972,7 +959,7 @@ static void test_reftable_stack_compaction_concurrent(v=
oid)
 		EXPECT_ERR(err);
 	}
=20
-	err =3D reftable_new_stack(&st2, dir, cfg);
+	err =3D reftable_new_stack(&st2, dir, opts);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_compact_all(st1, NULL);
@@ -998,14 +985,13 @@ static void unclean_stack_close(struct reftable_stack=
 *st)
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
@@ -1022,7 +1008,7 @@ static void test_reftable_stack_compaction_concurrent=
_clean(void)
 		EXPECT_ERR(err);
 	}
=20
-	err =3D reftable_new_stack(&st2, dir, cfg);
+	err =3D reftable_new_stack(&st2, dir, opts);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_compact_all(st1, NULL);
@@ -1031,7 +1017,7 @@ static void test_reftable_stack_compaction_concurrent=
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
2.45.GIT


--V8a5hW/IDvTv9uSb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZBzLEACgkQVbJhu7ck
PpQ0fw/+MaNfLucR0v8rYESaHpmp/K4cWqwo0fjwKU1bw2DOMvgnQjziLei1z+UH
tBkj1kntsoTQRQjDKLKVCCFUt7HgcycQee+hNi7R7vHouDIP4psdEj/7Fz1CyrCo
7TNNT/wM4KASWeRU5afkB6BqoAJTEDP5OXYCJFhB+dFHrv0b6AgpUg0MyOc4b3h9
qYNns7gzWHHuA2u+uizyqLNqK9PQzHM+vqmTBNFtKFKlEm1DBU7dxkb+eFZYN4tl
3Zbmppfiovo3jqHQnzO5JcaV/WVcx4LYDoBaWvTpAzxZCMrFN/N9zNLJnJGbUBct
rUH4WV0yzzix/gU+NECLycP/lxQyiFN9a7+dr37zd8kvrAA+vA8+w54P2qyctO+y
0wt/NOeJ6+8g8Xjv0ppLgMnJ01grdI9v54swqBRuzmm36wSb//S3AFxLS6n6hNOe
4//g6aKJr3o9X3qXro25cnTdoQMr932qJtldY24khlb0c1/uxb7kenudJWQGGHlj
uHe8kdqm/BjlAsEXNPRNJznHwbKdOhS5frgeFYI1XFcY/8CtQSCMt6ZkrEn9J1GE
4BsXSzUxe5lkQKt9pzV7tfSTSe0qCn84v5o3YtqZj5+owpG7SW+xx1w21mMPg6o8
YnlqOt2hm/BPvKRqF4VIqAPVmIExGUc6x1Gtr/JwDlQdtoNlqug=
=TDj5
-----END PGP SIGNATURE-----

--V8a5hW/IDvTv9uSb--
