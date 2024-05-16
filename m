Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EBB80C03
	for <git@vger.kernel.org>; Thu, 16 May 2024 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846668; cv=none; b=HRDjZizYPkukbEcOkd10yDbbUBNd3MAii2Jl2aDqiWlkSLiy3GClJ40qCf12KbINEpVRHSgJtGN2bL3Spow/V15AZePLP9v8DO1+riVEZET0jBfsZ8Z1fhEYg+niH/Aln9nLxRyw9VfoUmgMjER+GMp3zj5GPOISvia0Uluo9no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846668; c=relaxed/simple;
	bh=GWv+nOXvyUyF95YszbTV6myFSEN2RYFkJKJJF6f1i2M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVepCoto5raEIkipVd/EUi4G7se4IJNmU+ZLRvvSzwwFQJlA73VKb1s1b6C1xr7LIytZBBqWq2gjz/eMDkLWTj+jrpJMBBDKj0a7a2TG+3dxKr3WsiZwyL222qIxcFjidOxm8sO+8P0cN5UJmn45oMe51yExJIEAx+Tyt5Vws6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GwB7wsNN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bl8VFuDv; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GwB7wsNN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bl8VFuDv"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4803611400C2
	for <git@vger.kernel.org>; Thu, 16 May 2024 04:04:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 16 May 2024 04:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715846665; x=1715933065; bh=juApgQzabH
	5CnpaEIyPEWZ8HYzy2a/hU3BgL7o9TsrM=; b=GwB7wsNNmfaq0G/0yT+6eX+s07
	fQbxc8DtT8eeoErUtnLrHoaPv8B3dqeszxvMdT3KLhNUeeHMckzwmj87XxMByDW5
	fV27kN+g4CZdP9aEoD8Z98YLFk0QGndtE39W7GDewNz1releSgwmB9atDYjDXzHa
	jrD+a2Jo0joDDj/qdCmVy+VV7k/I/CJ41Ihxa4/x26U1RzX6geGwSIoGfPqhAnzV
	1RiHNUzzUU1sAdr4qs1BjqUTAA6NdC0sl+sWzA2HQb6d8kNT1sVoUFMER2vVbETG
	PcHAbpZyx60ErVMUJZiF8wc+phzqwpo4ZngzZhcgP8mokAGT0h2Wki72wJDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715846665; x=1715933065; bh=juApgQzabH5CnpaEIyPEWZ8HYzy2
	a/hU3BgL7o9TsrM=; b=bl8VFuDvxwNsWnyi5GslpGQAOm0SxOJ4G+UR31ts8Equ
	ktcTvynH7s6nDmGJOH4nhqxlp98jHcygDtbgENQHL2KbAU0Y4crDjbwrxNK7ZaH0
	ztT4zk655w9BXHC8GwZfHQJJIyksXOeZqE1JnoyE8ziEwiToi8v/TIQyiafUxf3Z
	ODTF9J0IxEvs1kRG5jGI7oPaEffwHbIYi6WG6/pu7GwIvEeddXcM0m8kDV3eVzKU
	Fx7Yg/2SwUZkRC8svrtChXWDOmXj4E5eR1BtWvIqdEhVINZPehtH8mN/yvsHwSCo
	eYoOFBH+F8Yo5LGNzyvUbONToeRuWHzQBmv1CLRUdg==
X-ME-Sender: <xms:Cb5FZpGP15mJdxk-ipQ4Mqxw3bLtS0M7hOeqdLbRFqR0C1fYsOpMdg>
    <xme:Cb5FZuWCZot3944kEiLt3aRG2XNgorWYFKQKUC7oxl5uVzgD60CkO-EPpisIz8xB4
    YXAMvFEO7s4U9TMfQ>
X-ME-Received: <xmr:Cb5FZrLRu6yNdivhzKDU6QENJ3YiqxkBK8RVHWjH2GIZn8zP7l0tboW-CYL7CRc4UXCi5YZwyOJsBiRx53aNdcgRi-qi6ged9h_gQ0AhZ3GPJYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehtddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Cb5FZvGgWTuTe3SXfJcEyGEZQDdquiseyA0SW3W7n4hGTAaMtYyC9w>
    <xmx:Cb5FZvXQMWTtXX4CfQNTq-JmTJg13InZKMrV8wc0krMWv-muv-5VGg>
    <xmx:Cb5FZqOytAMDvIIR5O7w9uGcbtf8wVcnzwCON5e9qJTpzJoJqTHNow>
    <xmx:Cb5FZu0SUGfpsSFbYT_nQY74k5_DKm1qPmwivADhCOvuxwUHFiZTEQ>
    <xmx:Cb5FZmd5r15G1YYGGLICp8jV8Hwc0o7msdsME32GdIOuQTAEUxz7kl4t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 May 2024 04:04:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8e795fa7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 May 2024 08:03:56 +0000 (UTC)
Date: Thu, 16 May 2024 10:04:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 02/16] refs: rename `init_db` callback to avoid confusion
Message-ID: <3cc2b4e5501ebe1464a6d75b7aea9f2ad6030c4a.1715836916.git.ps@pks.im>
References: <cover.1715836916.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mId3/7sGFOgJThtl"
Content-Disposition: inline
In-Reply-To: <cover.1715836916.git.ps@pks.im>


--mId3/7sGFOgJThtl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reference backends have two callbacks `init` and `init_db`. The
similarity of these two callbacks has repeatedly tripped myself whenever
I was looking at those, where I always had to look up which of them does
what.

Rename the `init_db` callback to `create`, which should hopefully be
clearer.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/worktree.c      |  2 +-
 refs.c                  |  4 ++--
 refs.h                  |  4 ++--
 refs/debug.c            |  8 ++++----
 refs/files-backend.c    | 12 ++++++------
 refs/packed-backend.c   |  8 ++++----
 refs/refs-internal.h    |  8 ++++----
 refs/reftable-backend.c | 10 +++++-----
 setup.c                 |  2 +-
 9 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 108cfa156a..cce083d409 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -509,7 +509,7 @@ static int add_worktree(const char *path, const char *r=
efname,
 	}
 	wt_refs =3D get_worktree_ref_store(wt);
=20
-	ret =3D refs_init_db(wt_refs, REFS_INIT_DB_IS_WORKTREE, &sb);
+	ret =3D ref_store_create(wt_refs, REF_STORE_CREATE_IS_WORKTREE, &sb);
 	if (ret)
 		goto done;
=20
diff --git a/refs.c b/refs.c
index a26c50a401..ad7987efab 100644
--- a/refs.c
+++ b/refs.c
@@ -1938,9 +1938,9 @@ const char *refs_resolve_ref_unsafe(struct ref_store =
*refs,
 }
=20
 /* backend functions */
-int refs_init_db(struct ref_store *refs, int flags, struct strbuf *err)
+int ref_store_create(struct ref_store *refs, int flags, struct strbuf *err)
 {
-	return refs->be->init_db(refs, flags, err);
+	return refs->be->create(refs, flags, err);
 }
=20
 int resolve_gitlink_ref(const char *submodule, const char *refname,
diff --git a/refs.h b/refs.h
index d02dd79ca6..e9804e4c22 100644
--- a/refs.h
+++ b/refs.h
@@ -114,9 +114,9 @@ int should_autocreate_reflog(const char *refname);
=20
 int is_branch(const char *refname);
=20
-#define REFS_INIT_DB_IS_WORKTREE (1 << 0)
+#define REF_STORE_CREATE_IS_WORKTREE (1 << 0)
=20
-int refs_init_db(struct ref_store *refs, int flags, struct strbuf *err);
+int ref_store_create(struct ref_store *refs, int flags, struct strbuf *err=
);
=20
 /*
  * Return the peeled value of the oid currently being iterated via
diff --git a/refs/debug.c b/refs/debug.c
index c7531b17f0..58fb4557ed 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -33,11 +33,11 @@ struct ref_store *maybe_debug_wrap_ref_store(const char=
 *gitdir, struct ref_stor
 	return (struct ref_store *)res;
 }
=20
-static int debug_init_db(struct ref_store *refs, int flags, struct strbuf =
*err)
+static int debug_create(struct ref_store *refs, int flags, struct strbuf *=
err)
 {
 	struct debug_ref_store *drefs =3D (struct debug_ref_store *)refs;
-	int res =3D drefs->refs->be->init_db(drefs->refs, flags, err);
-	trace_printf_key(&trace_refs, "init_db: %d\n", res);
+	int res =3D drefs->refs->be->create(drefs->refs, flags, err);
+	trace_printf_key(&trace_refs, "create: %d\n", res);
 	return res;
 }
=20
@@ -427,7 +427,7 @@ static int debug_reflog_expire(struct ref_store *ref_st=
ore, const char *refname,
 struct ref_storage_be refs_be_debug =3D {
 	.name =3D "debug",
 	.init =3D NULL,
-	.init_db =3D debug_init_db,
+	.create =3D debug_create,
=20
 	/*
 	 * None of these should be NULL. If the "files" backend (in
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2c9d5e0747..f766d18d5a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3236,12 +3236,12 @@ static int files_reflog_expire(struct ref_store *re=
f_store,
 	return -1;
 }
=20
-static int files_init_db(struct ref_store *ref_store,
-			 int flags,
-			 struct strbuf *err UNUSED)
+static int files_ref_store_create(struct ref_store *ref_store,
+				  int flags,
+				  struct strbuf *err UNUSED)
 {
 	struct files_ref_store *refs =3D
-		files_downcast(ref_store, REF_STORE_WRITE, "init_db");
+		files_downcast(ref_store, REF_STORE_WRITE, "create");
 	struct strbuf sb =3D STRBUF_INIT;
=20
 	/*
@@ -3264,7 +3264,7 @@ static int files_init_db(struct ref_store *ref_store,
 	 * There is no need to create directories for common refs when creating
 	 * a worktree ref store.
 	 */
-	if (!(flags & REFS_INIT_DB_IS_WORKTREE)) {
+	if (!(flags & REF_STORE_CREATE_IS_WORKTREE)) {
 		/*
 		 * Create .git/refs/{heads,tags}
 		 */
@@ -3284,7 +3284,7 @@ static int files_init_db(struct ref_store *ref_store,
 struct ref_storage_be refs_be_files =3D {
 	.name =3D "files",
 	.init =3D files_ref_store_init,
-	.init_db =3D files_init_db,
+	.create =3D files_ref_store_create,
 	.transaction_prepare =3D files_transaction_prepare,
 	.transaction_finish =3D files_transaction_finish,
 	.transaction_abort =3D files_transaction_abort,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a3c5a75073..716513efed 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1244,9 +1244,9 @@ int packed_refs_is_locked(struct ref_store *ref_store)
 static const char PACKED_REFS_HEADER[] =3D
 	"# pack-refs with: peeled fully-peeled sorted \n";
=20
-static int packed_ref_store_init_db(struct ref_store *ref_store UNUSED,
-				    int flags UNUSED,
-				    struct strbuf *err UNUSED)
+static int packed_ref_store_create(struct ref_store *ref_store UNUSED,
+				   int flags UNUSED,
+				   struct strbuf *err UNUSED)
 {
 	/* Nothing to do. */
 	return 0;
@@ -1707,7 +1707,7 @@ static struct ref_iterator *packed_reflog_iterator_be=
gin(struct ref_store *ref_s
 struct ref_storage_be refs_be_packed =3D {
 	.name =3D "packed",
 	.init =3D packed_ref_store_init,
-	.init_db =3D packed_ref_store_init_db,
+	.create =3D packed_ref_store_create,
 	.transaction_prepare =3D packed_transaction_prepare,
 	.transaction_finish =3D packed_transaction_finish,
 	.transaction_abort =3D packed_transaction_abort,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 56641aa57a..eb42212764 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -530,9 +530,9 @@ typedef struct ref_store *ref_store_init_fn(struct repo=
sitory *repo,
 					    const char *gitdir,
 					    unsigned int flags);
=20
-typedef int ref_init_db_fn(struct ref_store *refs,
-			   int flags,
-			   struct strbuf *err);
+typedef int ref_store_create_fn(struct ref_store *refs,
+				int flags,
+				struct strbuf *err);
=20
 typedef int ref_transaction_prepare_fn(struct ref_store *refs,
 				       struct ref_transaction *transaction,
@@ -668,7 +668,7 @@ typedef int read_symbolic_ref_fn(struct ref_store *ref_=
store, const char *refnam
 struct ref_storage_be {
 	const char *name;
 	ref_store_init_fn *init;
-	ref_init_db_fn *init_db;
+	ref_store_create_fn *create;
=20
 	ref_transaction_prepare_fn *transaction_prepare;
 	ref_transaction_finish_fn *transaction_finish;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 010ef811b6..a4bb71cd76 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -293,12 +293,12 @@ static struct ref_store *reftable_be_init(struct repo=
sitory *repo,
 	return &refs->base;
 }
=20
-static int reftable_be_init_db(struct ref_store *ref_store,
-			       int flags UNUSED,
-			       struct strbuf *err UNUSED)
+static int reftable_be_create(struct ref_store *ref_store,
+			      int flags UNUSED,
+			      struct strbuf *err UNUSED)
 {
 	struct reftable_ref_store *refs =3D
-		reftable_be_downcast(ref_store, REF_STORE_WRITE, "init_db");
+		reftable_be_downcast(ref_store, REF_STORE_WRITE, "create");
 	struct strbuf sb =3D STRBUF_INIT;
=20
 	strbuf_addf(&sb, "%s/reftable", refs->base.gitdir);
@@ -2248,7 +2248,7 @@ static int reftable_be_reflog_expire(struct ref_store=
 *ref_store,
 struct ref_storage_be refs_be_reftable =3D {
 	.name =3D "reftable",
 	.init =3D reftable_be_init,
-	.init_db =3D reftable_be_init_db,
+	.create =3D reftable_be_create,
 	.transaction_prepare =3D reftable_be_transaction_prepare,
 	.transaction_finish =3D reftable_be_transaction_finish,
 	.transaction_abort =3D reftable_be_transaction_abort,
diff --git a/setup.c b/setup.c
index c7d3375645..4a738f4c90 100644
--- a/setup.c
+++ b/setup.c
@@ -2049,7 +2049,7 @@ void create_reference_database(unsigned int ref_stora=
ge_format,
 	int reinit =3D is_reinit();
=20
 	repo_set_ref_storage_format(the_repository, ref_storage_format);
-	if (refs_init_db(get_main_ref_store(the_repository), 0, &err))
+	if (ref_store_create(get_main_ref_store(the_repository), 0, &err))
 		die("failed to set up refs db: %s", err.buf);
=20
 	/*
--=20
2.45.1.190.g19fe900cfc.dirty


--mId3/7sGFOgJThtl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZFvgEACgkQVbJhu7ck
PpR5kxAAoIa18o0r3K7/AFNoTLPkM9yNDqJUqBOtscR3JQ+jltc8Drwoq+Vre41O
FmyqnPhV4LYzFmhHZQMMi1EArUe+nNXYKtm6+D9sG7/umI1pIxFQd4eJSMoIsIGp
xLJgES0OdpnhKNgwVjytQlcoMUZx4CcgTwpk3tTECdAeZbasZLDclMuU5eavWOO8
GceSR81GKxtuhUF0eN9bqKscOTecgAjazHPdHZ4Y4fKy05GieCVbr3f2e8Un5wM2
VNT7ROs3peEZ+ZonZsOAbp4Nci0OcuP+GWqimkcIUB8alvrDagFiE5OHw8AY4fCr
uZbg9b9JicKy8xIAnKctXkRalujayxjHpuDJSS+yI9+HaUfaMdj6Janw3hR4uJYw
vEIRN1CSBQuJNgeYKcC7/H/5uuuTr9Wenilw4gAQ45tbMM4P/3bC2RcLgIGMbU1/
Ud8vSnofR0yUxqFKOD2tPWc7HfkyeBjybH+YMQ4rbAJNE+pOrE5zDnsAbKV5MJB8
SmqR+Xjf6OQ+WywDKJd27bOd+CByLl8IV0uA3AcvLTd+4ydCwKko2+NjvJyfARLc
SkHMZWC6pqsYDEVkt3+zGiuvTncAXLg6+qu8Xjgy8TRghHpFqbhhLUmTuQhgz3rs
WSGJibF9ijDTvR4dsD+SyCe5Nl3v1feFJ0hSAHLo3g8urQvFcrI=
=gQa7
-----END PGP SIGNATURE-----

--mId3/7sGFOgJThtl--
