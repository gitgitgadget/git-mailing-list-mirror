Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F172BD1C
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933906; cv=none; b=e5qcJq2yEPEOt2GgfkRw05np6jhtDPWNHjysH0h5/akS4SQov4ywf14uFkkyIy7fSuOaAbmyFac7kkS0S8iu8XSgFz9HY992rfsUIFuV32NOYzGXbxt78+GD38Fo3krG2LtDnwH5YUpGBdgNTG/mRTprtSPDdv8qjqkiplk0uok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933906; c=relaxed/simple;
	bh=5w0/pkr0yOKgbWw0zI2tvvwWZ42CQ0Qmy7l8gqBoNc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bv+n6pqmQw6O4hD2lVZnMZN8etNMM+GVjGDpGLOqn6PmTW+Gmogd73s9h+fPaDS3WwYn7wytfmxo+rstSJITlwCfMESg+8Lj7jt7SK3pMt9M5WyC3YXiPiGCAKMbHGXfqJChorcFBf9n+EiD172gX+i6Jdv9he5E0yddblC20Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BDnK0zcL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jQqroHwb; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BDnK0zcL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jQqroHwb"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6D6641800178;
	Fri, 17 May 2024 04:18:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 17 May 2024 04:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715933903; x=1716020303; bh=36wH8ZnUMq
	iK0+55f0rY4Das5t2yq0K1AlLX0RfWCMo=; b=BDnK0zcLMGdfex8eU8rDp2xquq
	wQbduGcHSyqiU/OGfXVZHaVxMDTcTgI2bHORYdCY68p8oKNLSWnlWwp1j40ygM3c
	njZBWXI1Y1gqCy8AWKHjgI0RJimhKGYYQkRrIjnM0DUNcG3TwIInE0JfK6X3Cth5
	289Gz+fDbdDEjxSNxd2Wtx/4ETJc6/hCHWqv17PwgNtiNYZhBmZT7lyu3K0DqOgg
	Vfn85Bn3ub26XMblAJzTd1GciMT7Rz7wGbO/iC30O9W/cd6spcmyD4TR2Kx5yDDf
	QhGkMH2HAzH15SDJVKXXUredYrKUMXpFIVmavtxsvpLpzf7/cE2UkDA72saw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715933903; x=1716020303; bh=36wH8ZnUMqiK0+55f0rY4Das5t2y
	q0K1AlLX0RfWCMo=; b=jQqroHwboY0tH1P6ZKbR0fI4ZuEJM5vNjcuhYrS6YMJk
	3KATR7JyJ5PwBbTvGFgUMkxgvSIF8StGd0lSCWNkt3+R6gZNe3xuuA1wyqH80vj+
	1c0xGLNg7V0ISRQYbqj2/Mz8f7jZn5zGgw0rBT9/GPg6XuYdOAWZ/3XxWrcp19h+
	YUGp9xag2KilFpe+YzqtZRezv5OmTIAcAdUe0uWBTBdzlIkLcmLLr1N+XqnEXBYk
	OhlbnAt28Mmyt41kUpNZImx+Pl0uq48YetOx4ZL0le0CDzq0FWeb3P3QUxKFTOL+
	W995RA5NkwFZ1sDGa8Q8bD9axxJnZenkU6GKwcUd+g==
X-ME-Sender: <xms:zhJHZvrHUcQrHHDjsJd4SL2ERSV749xzv2wx2oAoA7ILbJG90BfXYA>
    <xme:zhJHZprd6n4GMzw-Ly03C8Potizq0mbiU_Y2mfseaog1rFz3V4BU-BvGhshZeGnuo
    SUyr7Sdgn3ciX0kGg>
X-ME-Received: <xmr:zhJHZsMOcdqvHfPbivHCw5KtPEg7Jz87Y6FntJ0hX7FSc4rf8LaLsPIA3gzRkVo6o0MQ0cs2p2bKu5AErqztxS60nWv6A6NaOow_4SeCTD9HMgAImg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:zhJHZi7nDZB2U5Ke8Dw5mTzgr5XQbQ70B5BA96weMg3oxeqj9UZ_dQ>
    <xmx:zhJHZu6GShLEqLAFey2UM393YmY9hWRUAECHP_tv6XNK0RvTznECGg>
    <xmx:zhJHZqjjQwepKWwfA_e-00vlo0Mjir7JxILgYsf6bh7FcTYBNbqxGw>
    <xmx:zhJHZg5w7hcbzNCOtM5LyJwygZFmYcpduW4vOEbONtuhzxjcz5jqng>
    <xmx:zxJHZkkWFj_LxymT9xj7ub58bKvieBzvaStu0RlOcJKoVd6s32PWxDbg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 04:18:22 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d9a6f5be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 08:17:55 +0000 (UTC)
Date: Fri, 17 May 2024 10:18:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/16] refs: rename `init_db` callback to avoid confusion
Message-ID: <050fb24e5834fab6e42ed7deda1e9380701db118.1715929858.git.ps@pks.im>
References: <cover.1715929858.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4xN+W5vWIrWTCMef"
Content-Disposition: inline
In-Reply-To: <cover.1715929858.git.ps@pks.im>


--4xN+W5vWIrWTCMef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reference backends have two callbacks `init` and `init_db`. The
similarity of these two callbacks has repeatedly confused me whenever I
was looking at them, where I always had to look up which of them does
what.

Rename the `init_db` callback to `create_on_disk`, which should
hopefully be clearer.

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
index 108cfa156a..49d9632aa8 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -509,7 +509,7 @@ static int add_worktree(const char *path, const char *r=
efname,
 	}
 	wt_refs =3D get_worktree_ref_store(wt);
=20
-	ret =3D refs_init_db(wt_refs, REFS_INIT_DB_IS_WORKTREE, &sb);
+	ret =3D ref_store_create_on_disk(wt_refs, REF_STORE_CREATE_ON_DISK_IS_WOR=
KTREE, &sb);
 	if (ret)
 		goto done;
=20
diff --git a/refs.c b/refs.c
index a26c50a401..ebc6de81e9 100644
--- a/refs.c
+++ b/refs.c
@@ -1938,9 +1938,9 @@ const char *refs_resolve_ref_unsafe(struct ref_store =
*refs,
 }
=20
 /* backend functions */
-int refs_init_db(struct ref_store *refs, int flags, struct strbuf *err)
+int ref_store_create_on_disk(struct ref_store *refs, int flags, struct str=
buf *err)
 {
-	return refs->be->init_db(refs, flags, err);
+	return refs->be->create_on_disk(refs, flags, err);
 }
=20
 int resolve_gitlink_ref(const char *submodule, const char *refname,
diff --git a/refs.h b/refs.h
index d02dd79ca6..421ff9fdb7 100644
--- a/refs.h
+++ b/refs.h
@@ -114,9 +114,9 @@ int should_autocreate_reflog(const char *refname);
=20
 int is_branch(const char *refname);
=20
-#define REFS_INIT_DB_IS_WORKTREE (1 << 0)
+#define REF_STORE_CREATE_ON_DISK_IS_WORKTREE (1 << 0)
=20
-int refs_init_db(struct ref_store *refs, int flags, struct strbuf *err);
+int ref_store_create_on_disk(struct ref_store *refs, int flags, struct str=
buf *err);
=20
 /*
  * Return the peeled value of the oid currently being iterated via
diff --git a/refs/debug.c b/refs/debug.c
index c7531b17f0..4cc4910974 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -33,11 +33,11 @@ struct ref_store *maybe_debug_wrap_ref_store(const char=
 *gitdir, struct ref_stor
 	return (struct ref_store *)res;
 }
=20
-static int debug_init_db(struct ref_store *refs, int flags, struct strbuf =
*err)
+static int debug_create_on_disk(struct ref_store *refs, int flags, struct =
strbuf *err)
 {
 	struct debug_ref_store *drefs =3D (struct debug_ref_store *)refs;
-	int res =3D drefs->refs->be->init_db(drefs->refs, flags, err);
-	trace_printf_key(&trace_refs, "init_db: %d\n", res);
+	int res =3D drefs->refs->be->create_on_disk(drefs->refs, flags, err);
+	trace_printf_key(&trace_refs, "create_on_disk: %d\n", res);
 	return res;
 }
=20
@@ -427,7 +427,7 @@ static int debug_reflog_expire(struct ref_store *ref_st=
ore, const char *refname,
 struct ref_storage_be refs_be_debug =3D {
 	.name =3D "debug",
 	.init =3D NULL,
-	.init_db =3D debug_init_db,
+	.create_on_disk =3D debug_create_on_disk,
=20
 	/*
 	 * None of these should be NULL. If the "files" backend (in
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2c9d5e0747..f9f15d1f76 100644
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
+static int files_ref_store_create_on_disk(struct ref_store *ref_store,
+					  int flags,
+					  struct strbuf *err UNUSED)
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
+	if (!(flags & REF_STORE_CREATE_ON_DISK_IS_WORKTREE)) {
 		/*
 		 * Create .git/refs/{heads,tags}
 		 */
@@ -3284,7 +3284,7 @@ static int files_init_db(struct ref_store *ref_store,
 struct ref_storage_be refs_be_files =3D {
 	.name =3D "files",
 	.init =3D files_ref_store_init,
-	.init_db =3D files_init_db,
+	.create_on_disk =3D files_ref_store_create_on_disk,
 	.transaction_prepare =3D files_transaction_prepare,
 	.transaction_finish =3D files_transaction_finish,
 	.transaction_abort =3D files_transaction_abort,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a3c5a75073..b94183034e 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1244,9 +1244,9 @@ int packed_refs_is_locked(struct ref_store *ref_store)
 static const char PACKED_REFS_HEADER[] =3D
 	"# pack-refs with: peeled fully-peeled sorted \n";
=20
-static int packed_ref_store_init_db(struct ref_store *ref_store UNUSED,
-				    int flags UNUSED,
-				    struct strbuf *err UNUSED)
+static int packed_ref_store_create_on_disk(struct ref_store *ref_store UNU=
SED,
+					   int flags UNUSED,
+					   struct strbuf *err UNUSED)
 {
 	/* Nothing to do. */
 	return 0;
@@ -1707,7 +1707,7 @@ static struct ref_iterator *packed_reflog_iterator_be=
gin(struct ref_store *ref_s
 struct ref_storage_be refs_be_packed =3D {
 	.name =3D "packed",
 	.init =3D packed_ref_store_init,
-	.init_db =3D packed_ref_store_init_db,
+	.create_on_disk =3D packed_ref_store_create_on_disk,
 	.transaction_prepare =3D packed_transaction_prepare,
 	.transaction_finish =3D packed_transaction_finish,
 	.transaction_abort =3D packed_transaction_abort,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 56641aa57a..c3d5f0a6cd 100644
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
+typedef int ref_store_create_on_disk_fn(struct ref_store *refs,
+					int flags,
+					struct strbuf *err);
=20
 typedef int ref_transaction_prepare_fn(struct ref_store *refs,
 				       struct ref_transaction *transaction,
@@ -668,7 +668,7 @@ typedef int read_symbolic_ref_fn(struct ref_store *ref_=
store, const char *refnam
 struct ref_storage_be {
 	const char *name;
 	ref_store_init_fn *init;
-	ref_init_db_fn *init_db;
+	ref_store_create_on_disk_fn *create_on_disk;
=20
 	ref_transaction_prepare_fn *transaction_prepare;
 	ref_transaction_finish_fn *transaction_finish;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 010ef811b6..8583a0cdba 100644
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
+static int reftable_be_create_on_disk(struct ref_store *ref_store,
+				      int flags UNUSED,
+				      struct strbuf *err UNUSED)
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
+	.create_on_disk =3D reftable_be_create_on_disk,
 	.transaction_prepare =3D reftable_be_transaction_prepare,
 	.transaction_finish =3D reftable_be_transaction_finish,
 	.transaction_abort =3D reftable_be_transaction_abort,
diff --git a/setup.c b/setup.c
index c7d3375645..fec6bfd5fa 100644
--- a/setup.c
+++ b/setup.c
@@ -2049,7 +2049,7 @@ void create_reference_database(unsigned int ref_stora=
ge_format,
 	int reinit =3D is_reinit();
=20
 	repo_set_ref_storage_format(the_repository, ref_storage_format);
-	if (refs_init_db(get_main_ref_store(the_repository), 0, &err))
+	if (ref_store_create_on_disk(get_main_ref_store(the_repository), 0, &err))
 		die("failed to set up refs db: %s", err.buf);
=20
 	/*
--=20
2.45.1.190.g19fe900cfc.dirty


--4xN+W5vWIrWTCMef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHEsoACgkQVbJhu7ck
PpQtqRAAlZ+jT8CypAS4AurqnrLj7Z5/L0JEdrgvZJQY+O4ZKym+46RBO2ySs+es
rwl9H33o6K1f3zfKEb8lr0ZCv30akpjhy0O5TyqqU3Q32lYx7zHOYJ0EhLgxskF7
mmGVusT0ivAaAqqM5l3yGPyNomONGmyZH/wN3V8B5T3amFbmgCxX90yyZwYw9HWj
MDRGOvMr+8WMvwJbh3LdPyRjXyJ5+t346c9wkDFz/reQ2VO5SW3NR9S6vYXoywAs
yRtXw/QNeosQwk7MSeUu4L3JeHgTQuepQ72uSUtTjD8v8AqutkiFo7ePSjA2V9WA
yXG7vtDiSTq5KbuZtYSKkB6XNEDlh81zaKoU3QejCHwG7ztyUS7YIBWqjuGcrzbi
uax3D8Ilgb+08LWFviEJAucVSMuTqvGa4TYep1N7xUeuzK5vlEnIjGG9hS6J+8LT
6x4BDWaqi2VR0HUo3uQjZl3UHnSm9tKzrJAj7TMNjqWZqDV0kkjhrOoCqnQDYi7B
B0RFwsoS0KHj05yTdHA+NjHr6z5mMmpHlEesAq1AcBfO4xPiOROmqDF1difpOaau
7OHmgcFF1EmcYCtnAO5duRq8WjlzQjVmkb/zB+i9Pjf7qn6TzKMU8W+z/EVhhmYi
8+Gj8fZJWaEJEJWfIqOKqON97Z3Cvl1/xjcbAC7sjoU+L7Sm+e8=
=ypig
-----END PGP SIGNATURE-----

--4xN+W5vWIrWTCMef--
