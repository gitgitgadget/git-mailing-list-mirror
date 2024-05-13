Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5D6146D5D
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588286; cv=none; b=hHnmZU3LsCS8xLEjDKhMJrYA0oQDmIgh8PEwUgCLDxl4TXxI4Cmw/M/DkBxqxxxOw3rdaBsmdtlbNZz90LHdqvBnWk6DLH+55mk7cO6hBYZVw0ljIyq6YhcfFUBMB1+ki7aphXrctiAoqaL8aZZtu/4+IVyO4O8xF3zFU9W50w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588286; c=relaxed/simple;
	bh=tFfHR21NRcDmKzyptCPdQG8VDMMBi2RaMn8yh2J9Avk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naVODy9wUWtKFL3PkhHGIzaTVKsZG5MMdagDM2xZ8RVbruAhV/REYg3rKrz+vYV8OmrbCaWc+hI/cfTKt66h2Zh8TXV5xD5z4doeZECKxQ02eOO9FuHoKG8AYE5rOVaoe0LSBa/czfnxcTCkkpstOjgSssxh4MZWqZEeHOibXAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hmGSdqgE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UhLJiVMy; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hmGSdqgE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UhLJiVMy"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id BFBA81C000E5;
	Mon, 13 May 2024 04:18:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 13 May 2024 04:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715588283; x=1715674683; bh=T8bkwO9wPg
	UsRV5Jrf5E1hzcW3zYfh4ZIbltPC3tN/4=; b=hmGSdqgERskBjwPAjN3HUcCkU5
	n1FlDMvzmhVPStu1curx/oHNJSLWlQCcaturtFqX7L48ml7qngOWs5lKi5aMhelb
	9zj6R7enqvhA/1R0Zi8xGWdR9AOheiKjbAsRzi+i8PHRIcXjzfYZD+EM4Sjfet+9
	INwDhsqcs4t7R9cKHcJ32uP4G6miFSMhR67bTYEyJuqroIDcRefSjmZxeDhDktFe
	NYKYoClCrJV1eMU+l2HpI7BdsZ922cGQTvMCEgLqNvxc3qKqCknH0YhsMMiUxUQv
	7AF0QHRO8qoxP0kOfjdEToQQbddQ9eukX0vr+lOaqx2a9HeYwgb3ouet2Bfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715588283; x=1715674683; bh=T8bkwO9wPgUsRV5Jrf5E1hzcW3zY
	fh4ZIbltPC3tN/4=; b=UhLJiVMycoMEFuHbi7dfgFDCs8MEpFfF4c+wTcfPNACf
	iAdmT/2ORH6Be3XzmeLXt4kNYw65+pwAeCZdayvCWhb0QVtGTB/ns2BrYF8pG4J1
	PJHvizGcfGxV3IQoKWTUHwOBCUTKavxBFcqAQ+NomRhVq0DOtSu2g0HA/hR5TzkV
	UNyFhltcEveBppHvE2Dc5f5H9AXo28QjMLo5wB0Oxb1pc/65JWRxpC4Je6s+/G8j
	Rx14gw0O0POlBVAI01kV2dEkYfJUQvxtkNXwIjKbv8/BOvmZKrY/JzQkHuRacn6i
	Ji2mignnondnBoat8jf+p1EoGQn7t0CNnLjhIOBrmw==
X-ME-Sender: <xms:u8xBZvcvY_0PPX9-P1YAj5WJaIFPMYGgutBE1Ln4_hG4DGM2HeOr7A>
    <xme:u8xBZlNy_bHUHkxpF1QH91pJPRvK8_tL3L8feK-jK2Y-SjTbPsPtRK9nMFEXJ8KlK
    nJIi8O-oyfmUj4vsw>
X-ME-Received: <xmr:u8xBZoiXhNMj6XjngSzyE-cq6m_0ajTaALSej2dCihvOaNW4Zy1D_MNxiyMI4jRukjiBti2jJ-GPb1kk8jGwk7EZestQ-iwCz1QQue7rd9xL_wU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:u8xBZg8h3BUAojzpUcoYUzd5hAqF4xngx9rFuCdU32dluv8ttlY-pw>
    <xmx:u8xBZrtRhcwhPGKK0qPhFcsAyJSmORLFNKUEYH04RCXwVgWXxk8LRQ>
    <xmx:u8xBZvFqfN-onMPMH5Ic8mmJNQ_W4claKgMhWIw1hj62i71TcNmvyw>
    <xmx:u8xBZiOg1_bBvHHxIkJYW48b-oRLlKjfkq31y1P1fZJrnLtpw57zwg>
    <xmx:u8xBZlLwQfVemwbDxVQ1Zvj_1kBm1FTZB1UbqRNXOL-n43NnYeRIkkGs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:18:02 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b4d9c65e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:17:43 +0000 (UTC)
Date: Mon, 13 May 2024 10:17:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 02/11] reftable: pass opts as constant pointer
Message-ID: <f1c9914a77ab9bfe27a62e324cc3eb388f4118d9.1715587849.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715587849.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0A2S/AlExYzz6xgg"
Content-Disposition: inline
In-Reply-To: <cover.1715587849.git.ps@pks.im>


--0A2S/AlExYzz6xgg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We sometimes pass the refatble write options as value and sometimes as a
pointer. This is quite confusing and makes the reader wonder whether the
options get modified sometimes.

In fact, `reftable_new_writer()` does cause the caller-provided options
to get updated when some values aren't set up. This is quite unexpected,
but didn't cause any harm until now.

Adapt the code so that we do not modify the caller-provided values
anymore. While at it, refactor the code to code to consistently pass the
options as a constant pointer to clarify that the caller-provided opts
will not ever get modified.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c    |  6 ++---
 reftable/dump.c            |  2 +-
 reftable/reftable-stack.h  |  2 +-
 reftable/reftable-writer.h |  2 +-
 reftable/stack.c           |  7 ++++--
 reftable/stack_test.c      | 48 +++++++++++++++++++-------------------
 reftable/writer.c          | 17 +++++++++-----
 7 files changed, 46 insertions(+), 38 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 010ef811b6..f8f930380d 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -129,7 +129,7 @@ static struct reftable_stack *stack_for(struct reftable=
_ref_store *store,
 				    store->base.repo->commondir, wtname_buf.buf);
=20
 			store->err =3D reftable_new_stack(&stack, wt_dir.buf,
-							store->write_options);
+							&store->write_options);
 			assert(store->err !=3D REFTABLE_API_ERROR);
 			strmap_put(&store->worktree_stacks, wtname_buf.buf, stack);
 		}
@@ -263,7 +263,7 @@ static struct ref_store *reftable_be_init(struct reposi=
tory *repo,
 	}
 	strbuf_addstr(&path, "/reftable");
 	refs->err =3D reftable_new_stack(&refs->main_stack, path.buf,
-				       refs->write_options);
+				       &refs->write_options);
 	if (refs->err)
 		goto done;
=20
@@ -280,7 +280,7 @@ static struct ref_store *reftable_be_init(struct reposi=
tory *repo,
 		strbuf_addf(&path, "%s/reftable", gitdir);
=20
 		refs->err =3D reftable_new_stack(&refs->worktree_stack, path.buf,
-					       refs->write_options);
+					       &refs->write_options);
 		if (refs->err)
 			goto done;
 	}
diff --git a/reftable/dump.c b/reftable/dump.c
index 9c770a10cc..586f3eb288 100644
--- a/reftable/dump.c
+++ b/reftable/dump.c
@@ -29,7 +29,7 @@ static int compact_stack(const char *stackdir)
 	struct reftable_stack *stack =3D NULL;
 	struct reftable_write_options opts =3D { 0 };
=20
-	int err =3D reftable_new_stack(&stack, stackdir, opts);
+	int err =3D reftable_new_stack(&stack, stackdir, &opts);
 	if (err < 0)
 		goto done;
=20
diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
index 9c8e4eef49..c15632c401 100644
--- a/reftable/reftable-stack.h
+++ b/reftable/reftable-stack.h
@@ -29,7 +29,7 @@ struct reftable_stack;
  *  stored in 'dir'. Typically, this should be .git/reftables.
  */
 int reftable_new_stack(struct reftable_stack **dest, const char *dir,
-		       struct reftable_write_options opts);
+		       const struct reftable_write_options *opts);
=20
 /* returns the update_index at which a next table should be written. */
 uint64_t reftable_stack_next_update_index(struct reftable_stack *st);
diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index b601a69a40..03df3a4963 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -88,7 +88,7 @@ struct reftable_stats {
 struct reftable_writer *
 reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
 		    int (*flush_func)(void *),
-		    void *writer_arg, struct reftable_write_options *opts);
+		    void *writer_arg, const struct reftable_write_options *opts);
=20
 /* Set the range of update indices for the records we will add. When writi=
ng a
    table into a stack, the min should be at least
diff --git a/reftable/stack.c b/reftable/stack.c
index 54e7473f3a..d2e68be7e8 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -54,12 +54,15 @@ static int reftable_fd_flush(void *arg)
 }
=20
 int reftable_new_stack(struct reftable_stack **dest, const char *dir,
-		       struct reftable_write_options opts)
+		       const struct reftable_write_options *_opts)
 {
 	struct reftable_stack *p =3D reftable_calloc(1, sizeof(*p));
 	struct strbuf list_file_name =3D STRBUF_INIT;
+	struct reftable_write_options opts =3D {0};
 	int err =3D 0;
=20
+	if (_opts)
+		opts =3D *_opts;
 	if (opts.hash_id =3D=3D 0)
 		opts.hash_id =3D GIT_SHA1_FORMAT_ID;
=20
@@ -1438,7 +1441,7 @@ int reftable_stack_print_directory(const char *stackd=
ir, uint32_t hash_id)
 	struct reftable_merged_table *merged =3D NULL;
 	struct reftable_table table =3D { NULL };
=20
-	int err =3D reftable_new_stack(&stack, stackdir, opts);
+	int err =3D reftable_new_stack(&stack, stackdir, &opts);
 	if (err < 0)
 		goto done;
=20
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index e17ad4dc62..d15f11d712 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -163,7 +163,7 @@ static void test_reftable_stack_add_one(void)
 	};
 	struct reftable_ref_record dest =3D { NULL };
 	struct stat stat_result =3D { 0 };
-	err =3D reftable_new_stack(&st, dir, opts);
+	err =3D reftable_new_stack(&st, dir, &opts);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_add(st, &write_test_ref, &ref);
@@ -232,10 +232,10 @@ static void test_reftable_stack_uptodate(void)
 	/* simulate multi-process access to the same stack
 	   by creating two stacks for the same directory.
 	 */
-	err =3D reftable_new_stack(&st1, dir, opts);
+	err =3D reftable_new_stack(&st1, dir, &opts);
 	EXPECT_ERR(err);
=20
-	err =3D reftable_new_stack(&st2, dir, opts);
+	err =3D reftable_new_stack(&st2, dir, &opts);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_add(st1, &write_test_ref, &ref1);
@@ -270,7 +270,7 @@ static void test_reftable_stack_transaction_api(void)
 	};
 	struct reftable_ref_record dest =3D { NULL };
=20
-	err =3D reftable_new_stack(&st, dir, opts);
+	err =3D reftable_new_stack(&st, dir, &opts);
 	EXPECT_ERR(err);
=20
 	reftable_addition_destroy(add);
@@ -304,7 +304,7 @@ static void test_reftable_stack_transaction_api_perform=
s_auto_compaction(void)
 	struct reftable_stack *st =3D NULL;
 	int i, n =3D 20, err;
=20
-	err =3D reftable_new_stack(&st, dir, opts);
+	err =3D reftable_new_stack(&st, dir, &opts);
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i <=3D n; i++) {
@@ -365,7 +365,7 @@ static void test_reftable_stack_auto_compaction_fails_g=
racefully(void)
 	char *dir =3D get_tmp_dir(__LINE__);
 	int err;
=20
-	err =3D reftable_new_stack(&st, dir, opts);
+	err =3D reftable_new_stack(&st, dir, &opts);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_add(st, write_test_ref, &ref);
@@ -418,7 +418,7 @@ static void test_reftable_stack_update_index_check(void)
 		.value.symref =3D "master",
 	};
=20
-	err =3D reftable_new_stack(&st, dir, opts);
+	err =3D reftable_new_stack(&st, dir, &opts);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_add(st, &write_test_ref, &ref1);
@@ -437,7 +437,7 @@ static void test_reftable_stack_lock_failure(void)
 	struct reftable_stack *st =3D NULL;
 	int err, i;
=20
-	err =3D reftable_new_stack(&st, dir, opts);
+	err =3D reftable_new_stack(&st, dir, &opts);
 	EXPECT_ERR(err);
 	for (i =3D -1; i !=3D REFTABLE_EMPTY_TABLE_ERROR; i--) {
 		err =3D reftable_stack_add(st, &write_error, &i);
@@ -465,7 +465,7 @@ static void test_reftable_stack_add(void)
 	struct stat stat_result;
 	int N =3D ARRAY_SIZE(refs);
=20
-	err =3D reftable_new_stack(&st, dir, opts);
+	err =3D reftable_new_stack(&st, dir, &opts);
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i < N; i++) {
@@ -575,7 +575,7 @@ static void test_reftable_stack_log_normalize(void)
 		.update_index =3D 1,
 	};
=20
-	err =3D reftable_new_stack(&st, dir, opts);
+	err =3D reftable_new_stack(&st, dir, &opts);
 	EXPECT_ERR(err);
=20
 	input.value.update.message =3D "one\ntwo";
@@ -617,7 +617,7 @@ static void test_reftable_stack_tombstone(void)
 	struct reftable_ref_record dest =3D { NULL };
 	struct reftable_log_record log_dest =3D { NULL };
=20
-	err =3D reftable_new_stack(&st, dir, opts);
+	err =3D reftable_new_stack(&st, dir, &opts);
 	EXPECT_ERR(err);
=20
 	/* even entries add the refs, odd entries delete them. */
@@ -701,18 +701,18 @@ static void test_reftable_stack_hash_id(void)
 	struct reftable_stack *st_default =3D NULL;
 	struct reftable_ref_record dest =3D { NULL };
=20
-	err =3D reftable_new_stack(&st, dir, opts);
+	err =3D reftable_new_stack(&st, dir, &opts);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_add(st, &write_test_ref, &ref);
 	EXPECT_ERR(err);
=20
 	/* can't read it with the wrong hash ID. */
-	err =3D reftable_new_stack(&st32, dir, opts32);
+	err =3D reftable_new_stack(&st32, dir, &opts32);
 	EXPECT(err =3D=3D REFTABLE_FORMAT_ERROR);
=20
 	/* check that we can read it back with default opts too. */
-	err =3D reftable_new_stack(&st_default, dir, opts_default);
+	err =3D reftable_new_stack(&st_default, dir, &opts_default);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_read_ref(st_default, "master", &dest);
@@ -756,7 +756,7 @@ static void test_reflog_expire(void)
 	};
 	struct reftable_log_record log =3D { NULL };
=20
-	err =3D reftable_new_stack(&st, dir, opts);
+	err =3D reftable_new_stack(&st, dir, &opts);
 	EXPECT_ERR(err);
=20
 	for (i =3D 1; i <=3D N; i++) {
@@ -825,13 +825,13 @@ static void test_empty_add(void)
 	char *dir =3D get_tmp_dir(__LINE__);
 	struct reftable_stack *st2 =3D NULL;
=20
-	err =3D reftable_new_stack(&st, dir, opts);
+	err =3D reftable_new_stack(&st, dir, &opts);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_add(st, &write_nothing, NULL);
 	EXPECT_ERR(err);
=20
-	err =3D reftable_new_stack(&st2, dir, opts);
+	err =3D reftable_new_stack(&st2, dir, &opts);
 	EXPECT_ERR(err);
 	clear_dir(dir);
 	reftable_stack_destroy(st);
@@ -858,7 +858,7 @@ static void test_reftable_stack_auto_compaction(void)
 	int err, i;
 	int N =3D 100;
=20
-	err =3D reftable_new_stack(&st, dir, opts);
+	err =3D reftable_new_stack(&st, dir, &opts);
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i < N; i++) {
@@ -894,7 +894,7 @@ static void test_reftable_stack_add_performs_auto_compa=
ction(void)
 	char *dir =3D get_tmp_dir(__LINE__);
 	int err, i, n =3D 20;
=20
-	err =3D reftable_new_stack(&st, dir, opts);
+	err =3D reftable_new_stack(&st, dir, &opts);
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i <=3D n; i++) {
@@ -942,7 +942,7 @@ static void test_reftable_stack_compaction_concurrent(v=
oid)
 	int err, i;
 	int N =3D 3;
=20
-	err =3D reftable_new_stack(&st1, dir, opts);
+	err =3D reftable_new_stack(&st1, dir, &opts);
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i < N; i++) {
@@ -959,7 +959,7 @@ static void test_reftable_stack_compaction_concurrent(v=
oid)
 		EXPECT_ERR(err);
 	}
=20
-	err =3D reftable_new_stack(&st2, dir, opts);
+	err =3D reftable_new_stack(&st2, dir, &opts);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_compact_all(st1, NULL);
@@ -991,7 +991,7 @@ static void test_reftable_stack_compaction_concurrent_c=
lean(void)
 	int err, i;
 	int N =3D 3;
=20
-	err =3D reftable_new_stack(&st1, dir, opts);
+	err =3D reftable_new_stack(&st1, dir, &opts);
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i < N; i++) {
@@ -1008,7 +1008,7 @@ static void test_reftable_stack_compaction_concurrent=
_clean(void)
 		EXPECT_ERR(err);
 	}
=20
-	err =3D reftable_new_stack(&st2, dir, opts);
+	err =3D reftable_new_stack(&st2, dir, &opts);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_compact_all(st1, NULL);
@@ -1017,7 +1017,7 @@ static void test_reftable_stack_compaction_concurrent=
_clean(void)
 	unclean_stack_close(st1);
 	unclean_stack_close(st2);
=20
-	err =3D reftable_new_stack(&st3, dir, opts);
+	err =3D reftable_new_stack(&st3, dir, &opts);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_clean(st3);
diff --git a/reftable/writer.c b/reftable/writer.c
index 10eccaaa07..4cc6e2ebd8 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -122,20 +122,25 @@ static struct strbuf reftable_empty_strbuf =3D STRBUF=
_INIT;
 struct reftable_writer *
 reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
 		    int (*flush_func)(void *),
-		    void *writer_arg, struct reftable_write_options *opts)
+		    void *writer_arg, const struct reftable_write_options *_opts)
 {
 	struct reftable_writer *wp =3D reftable_calloc(1, sizeof(*wp));
-	strbuf_init(&wp->block_writer_data.last_key, 0);
-	options_set_defaults(opts);
-	if (opts->block_size >=3D (1 << 24)) {
+	struct reftable_write_options opts =3D {0};
+
+	if (_opts)
+		opts =3D *_opts;
+	options_set_defaults(&opts);
+	if (opts.block_size >=3D (1 << 24)) {
 		/* TODO - error return? */
 		abort();
 	}
+
+	strbuf_init(&wp->block_writer_data.last_key, 0);
 	wp->last_key =3D reftable_empty_strbuf;
-	REFTABLE_CALLOC_ARRAY(wp->block, opts->block_size);
+	REFTABLE_CALLOC_ARRAY(wp->block, opts.block_size);
 	wp->write =3D writer_func;
 	wp->write_arg =3D writer_arg;
-	wp->opts =3D *opts;
+	wp->opts =3D opts;
 	wp->flush =3D flush_func;
 	writer_reinit_block_writer(wp, BLOCK_TYPE_REF);
=20
--=20
2.45.GIT


--0A2S/AlExYzz6xgg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZBzLYACgkQVbJhu7ck
PpTptg//d5ofBMXZeBPqMyIl5B7xaiMAk73E5IFmYRhyQY0HEOLE+M80IG/OpKXG
wdiQjv1X5ty8yTkb7JITkSSCvyj1xfdkuJGCLxcvMzvHetCAsgDEnrWgo3aGDCnh
VO4Wy+N+HDtownu1GkY5L2QuoWD6FSrdUw3eMGT1VCClwyJWPiXdal4R3HQs5AZN
sPdxnfSqpQqfigcV9MgkUgMPb5GfAHRw3zfZ+M0SvjbBlY9LtvWCtGXso13dPbIF
tcL0fUZ7RhGr0CmlBQcZXQVVeZ20t4gcD0wXWgBmOI2QwuXy+AaGqi2rrCQ8YCYt
wbQcroYjCY6ZIkokn8LxVPsTwvUo54heN0FayhxJEPVQyiQvuJ6CXwxOdR7bfQmo
3FeKF5p3Dds/ypBUJO5hPJgw8cu9tvJInRlsZtJMII6CYhbHhlftXpoRdas49QNU
jpiC2WYTljoezetEy6GbKUqFm+HmqXX0mzi++3t+21AhwLfuUgq5YDNNdLwq4P1H
9LgCTPCO5BW74r7z6kd2DQbrV5Jhx1dhWvIyqVuCjviMdjBTjgAu0TF59WrBtvvK
foRwjhhWFpVqQwk4aNMr95n4hMGgZQWZAnr6AYefgPatYS2s1rOCkGCasaA1QrOz
BCD6ifbcekhvzH+IjONGyvm3CiG7mWfHDJXYJ9KE7+33BxZRXbw=
=FlZe
-----END PGP SIGNATURE-----

--0A2S/AlExYzz6xgg--
