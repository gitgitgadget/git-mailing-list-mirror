Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADEF137C22
	for <git@vger.kernel.org>; Thu, 16 May 2024 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846669; cv=none; b=hjY/wfkJtw55xwAK4bA2PGrbD2yX5bfafJtwFs4eSro/0tWilE8sixN34NdeB02BHgkjxDLMmhkbdsi5EF76PSX+3gDzWl0LB2S6/aRbCvxRnnUHh4uBBjo0uYTi6EGaIyExaFzNS+RgteaZYGog9iaUcbLbRNtYvHAXYindOTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846669; c=relaxed/simple;
	bh=TqqSIqXyF/Y9JAq9HHjC2U5yKIL3QXqzt5Ea8YAaVkU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7syrjPbjiBGYbq9pP86+LqWSjaJ+wGXX7MW82+hv35XncWwlJpbO+k24tVEXHddh2ERKKAcgTu1yKEhxlYcDoyMJMAWfkwyAF5GOGk8D6STfhp1NpHrln1xmnmGhxzfmoYSWuAic65slkyDYTXppSt8R5S88jDD3MBJHYbTX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BtlSferJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O5Kp2LYY; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BtlSferJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O5Kp2LYY"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3C50411400C3
	for <git@vger.kernel.org>; Thu, 16 May 2024 04:04:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 16 May 2024 04:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715846667; x=1715933067; bh=dAl/1qfoYT
	z9UBAhXaSj+QsGNh2/ov575pC+22gcKC8=; b=BtlSferJ5mtVUqPfb9evJUTPGE
	K1wDlYqAHAbAoZAEFmqg7s+FL3NcJBvAw4Aeo2AMoyhVvbPRfAI6pX4Z1F9LMIEt
	4CRHplTwDe5MCfZ9IoHXlCNNKllZLcOievRYyW36H7PamnPxNViG05N83TqBBzMv
	0HRFUUK/G/SC27vd7FsZ3tNPXxHtDbMk6rmVArEicDNTr0q3d+PeV5D1xIV0atUm
	N1t6GvA4c9avEGeXwOVVA5O7fJ9ZFeW7aUgakwYGYiWsnzBHZp+no3CvNKxDMkhx
	+0ol74ugRIn7EzUEYF67HSXO4UPnOqOLIWbXlf17k+OifvFySMPUv71sadbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715846667; x=1715933067; bh=dAl/1qfoYTz9UBAhXaSj+QsGNh2/
	ov575pC+22gcKC8=; b=O5Kp2LYYmuhMl7I6xT2HXOPNacXYqkvBVUh5kEVW3Ltq
	u6eEiCV8LaYAiIDemTDVKbzmBQyRuMX8oKU80kALEVJNcu0cCHAYtN1ZtRZY1C+L
	243SnTLquNv6JImEoZFs9OQFuffvgN+YlkoodTnA5fbqJmzRsPBZLyGFY/PwNGgA
	o64WzExzNUGfLRmmbh09Ua7eu+L8kbnUBV6xN6Uwck4DuLYeNuaG3WQByihtD60w
	j7C4C/nTDBrg/fDnP94dkbsFdedcLNKrOp3PSnlyKYA78QFmMDuuDs1QKQ4ZUibu
	H5xl2CxHK29tNShOCa0g9MulhInAkPE27lzfFcPNpw==
X-ME-Sender: <xms:C75FZsTcVtUCYBWprtamTDMB2OySjrXw4GSZaips90zb9yvGvcU9Lg>
    <xme:C75FZpwz-qQQfW1hPf9Mh9ePoSr7HiHoT4px7-fvcJJYn7x2-3siXX2WED3Z0fP73
    5_KlxtmH0I02iyxQA>
X-ME-Received: <xmr:C75FZp15FtxFrpdtv8Djx42477FfWT5d9rAL49fW9kwC5h2CDIc3U9CVyHS_PZqLr1XfcPEhr99pYRK34-rABM2jWemeohVXMP9CZK4rLcipTl0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehtddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:C75FZgBCdG45rV7cqiI62TaddsukSTi6boYcop-2G-n_Z2EQcvnv-A>
    <xmx:C75FZljeD4-V08b_CeXO_dVDmysOjBlmYXvgWAe0_LVAe72NElb4VQ>
    <xmx:C75FZspXi_WzQeEMmRzIWWkMYunpKoPU9NOWK1FrA1M1T6YxDKWMBA>
    <xmx:C75FZohuCUqEp3k5OHxt5A25R-5GM46DwMH0MFCD-XNQKamR4FTGCA>
    <xmx:C75FZlaNURcOPlYhxqeZbft3Fx63uO4o1u8EMonhLuCYKxFex6uLi02n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 May 2024 04:04:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5faf3c65 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 May 2024 08:04:01 +0000 (UTC)
Date: Thu, 16 May 2024 10:04:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 03/16] refs: implement releasing ref storages
Message-ID: <282fbe35a7c9db715a8a805f93f9b465d42885a5.1715836916.git.ps@pks.im>
References: <cover.1715836916.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bsqC+rgGDMZ8rieL"
Content-Disposition: inline
In-Reply-To: <cover.1715836916.git.ps@pks.im>


--bsqC+rgGDMZ8rieL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ref storages are typically only initialized once for `the_repository`
and then never released. Until now we got away with that without causing
memory leaks because `the_repository` stays reachable, and because the
ref backend is reachable via `the_repository` its memory basically never
leaks.

This is about to change though because of the upcoming migration logic,
which will create a secondary ref storage. In that case, we will either
have to release the old or new ref storage to avoid leaks.

Implement a new `release` callback and expose it via a new
`ref_storage_release()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                  |  6 ++++++
 refs.h                  |  5 +++++
 refs/debug.c            |  7 +++++++
 refs/files-backend.c    |  9 +++++++++
 refs/packed-backend.c   | 10 ++++++++++
 refs/refs-internal.h    |  6 ++++++
 refs/reftable-backend.c | 22 ++++++++++++++++++++++
 7 files changed, 65 insertions(+)

diff --git a/refs.c b/refs.c
index ad7987efab..edb0a633d1 100644
--- a/refs.c
+++ b/refs.c
@@ -2041,6 +2041,12 @@ static struct ref_store *ref_store_init(struct repos=
itory *repo,
 	return refs;
 }
=20
+void ref_store_release(struct ref_store *ref_store)
+{
+	ref_store->be->release(ref_store);
+	free(ref_store->gitdir);
+}
+
 struct ref_store *get_main_ref_store(struct repository *r)
 {
 	if (r->refs_private)
diff --git a/refs.h b/refs.h
index e9804e4c22..5ecdfb16dc 100644
--- a/refs.h
+++ b/refs.h
@@ -118,6 +118,11 @@ int is_branch(const char *refname);
=20
 int ref_store_create(struct ref_store *refs, int flags, struct strbuf *err=
);
=20
+/*
+ * Release all memory and resources associated with the ref store.
+ */
+void ref_store_release(struct ref_store *ref_store);
+
 /*
  * Return the peeled value of the oid currently being iterated via
  * for_each_ref(), etc. This is equivalent to calling:
diff --git a/refs/debug.c b/refs/debug.c
index 58fb4557ed..27aae42134 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -33,6 +33,12 @@ struct ref_store *maybe_debug_wrap_ref_store(const char =
*gitdir, struct ref_stor
 	return (struct ref_store *)res;
 }
=20
+static void debug_release(struct ref_store *refs)
+{
+	struct debug_ref_store *drefs =3D (struct debug_ref_store *)refs;
+	drefs->refs->be->release(drefs->refs);
+}
+
 static int debug_create(struct ref_store *refs, int flags, struct strbuf *=
err)
 {
 	struct debug_ref_store *drefs =3D (struct debug_ref_store *)refs;
@@ -427,6 +433,7 @@ static int debug_reflog_expire(struct ref_store *ref_st=
ore, const char *refname,
 struct ref_storage_be refs_be_debug =3D {
 	.name =3D "debug",
 	.init =3D NULL,
+	.release =3D debug_release,
 	.create =3D debug_create,
=20
 	/*
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f766d18d5a..368df075c1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -149,6 +149,14 @@ static struct files_ref_store *files_downcast(struct r=
ef_store *ref_store,
 	return refs;
 }
=20
+static void files_ref_store_release(struct ref_store *ref_store)
+{
+	struct files_ref_store *refs =3D files_downcast(ref_store, 0, "release");
+	free_ref_cache(refs->loose);
+	free(refs->gitcommondir);
+	ref_store_release(refs->packed_ref_store);
+}
+
 static void files_reflog_path(struct files_ref_store *refs,
 			      struct strbuf *sb,
 			      const char *refname)
@@ -3284,6 +3292,7 @@ static int files_ref_store_create(struct ref_store *r=
ef_store,
 struct ref_storage_be refs_be_files =3D {
 	.name =3D "files",
 	.init =3D files_ref_store_init,
+	.release =3D files_ref_store_release,
 	.create =3D files_ref_store_create,
 	.transaction_prepare =3D files_transaction_prepare,
 	.transaction_finish =3D files_transaction_finish,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 716513efed..bebceb4aa7 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -252,6 +252,15 @@ static void clear_snapshot(struct packed_ref_store *re=
fs)
 	}
 }
=20
+static void packed_ref_store_release(struct ref_store *ref_store)
+{
+	struct packed_ref_store *refs =3D packed_downcast(ref_store, 0, "release"=
);
+	clear_snapshot(refs);
+	rollback_lock_file(&refs->lock);
+	delete_tempfile(&refs->tempfile);
+	free(refs->path);
+}
+
 static NORETURN void die_unterminated_line(const char *path,
 					   const char *p, size_t len)
 {
@@ -1707,6 +1716,7 @@ static struct ref_iterator *packed_reflog_iterator_be=
gin(struct ref_store *ref_s
 struct ref_storage_be refs_be_packed =3D {
 	.name =3D "packed",
 	.init =3D packed_ref_store_init,
+	.release =3D packed_ref_store_release,
 	.create =3D packed_ref_store_create,
 	.transaction_prepare =3D packed_transaction_prepare,
 	.transaction_finish =3D packed_transaction_finish,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index eb42212764..cc1fe6e633 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -530,6 +530,11 @@ typedef struct ref_store *ref_store_init_fn(struct rep=
ository *repo,
 					    const char *gitdir,
 					    unsigned int flags);
=20
+/*
+ * Release all memory and resources associated with the ref store.
+ */
+typedef void ref_store_release_fn(struct ref_store *refs);
+
 typedef int ref_store_create_fn(struct ref_store *refs,
 				int flags,
 				struct strbuf *err);
@@ -668,6 +673,7 @@ typedef int read_symbolic_ref_fn(struct ref_store *ref_=
store, const char *refnam
 struct ref_storage_be {
 	const char *name;
 	ref_store_init_fn *init;
+	ref_store_release_fn *release;
 	ref_store_create_fn *create;
=20
 	ref_transaction_prepare_fn *transaction_prepare;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index a4bb71cd76..6c262c2193 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -293,6 +293,27 @@ static struct ref_store *reftable_be_init(struct repos=
itory *repo,
 	return &refs->base;
 }
=20
+static void reftable_be_release(struct ref_store *ref_store)
+{
+	struct reftable_ref_store *refs =3D reftable_be_downcast(ref_store, 0, "r=
elease");
+	struct strmap_entry *entry;
+	struct hashmap_iter iter;
+
+	if (refs->main_stack) {
+		reftable_stack_destroy(refs->main_stack);
+		refs->main_stack =3D NULL;
+	}
+
+	if (refs->worktree_stack) {
+		reftable_stack_destroy(refs->worktree_stack);
+		refs->main_stack =3D NULL;
+	}
+
+	strmap_for_each_entry(&refs->worktree_stacks, &iter, entry)
+		reftable_stack_destroy(entry->value);
+	strmap_clear(&refs->worktree_stacks, 0);
+}
+
 static int reftable_be_create(struct ref_store *ref_store,
 			      int flags UNUSED,
 			      struct strbuf *err UNUSED)
@@ -2248,6 +2269,7 @@ static int reftable_be_reflog_expire(struct ref_store=
 *ref_store,
 struct ref_storage_be refs_be_reftable =3D {
 	.name =3D "reftable",
 	.init =3D reftable_be_init,
+	.release =3D reftable_be_release,
 	.create =3D reftable_be_create,
 	.transaction_prepare =3D reftable_be_transaction_prepare,
 	.transaction_finish =3D reftable_be_transaction_finish,
--=20
2.45.1.190.g19fe900cfc.dirty


--bsqC+rgGDMZ8rieL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZFvgYACgkQVbJhu7ck
PpTcXQ/+ON2aJb/X1Xsnmuq1YnnpUcqPTkVBDRXyFUX8L38lj6GbitMsiVs+6Ws1
XZOCpLDyj389g95LoljymcAfhK0ojsPFa3KBggjGyWKl2jvqFnZzA+1jfUGyRkDn
i9hg9nEHnM7S8QeIx40IWFCZFrYyg8/1Hzq/ZvpalSK2k6CM2wYAWdS52KALTL4U
4gu7gu4lqpXtoodxeMOjYdtTNzkSQ7EnXwcnkunw3UX8AQSQFf4bYUD7CDi8t6xy
1TXFEGQacH4oQucdLy2i4ibZmWHxcOskZ5FjP4tf++HKQCOkfhuhh6BZWdTe1aiV
k0+1DOwa78yrqLXfV1jQoWGu6ys19Nqwrnjd4C9wvmeJezqdzbBIpcfrd67qy7DV
aBYkoVDfE9F06fSbEDtYpP4P0ggHbBeSfV+HDkeZiOeSb5vdKD779q5USBwbJSgd
qUXN0abiq8TnKM/OHfQylKXLLPiDx8xiaHTCg+n8aGJID77S/YtBA+HsCtJz9SA+
8crD4dF5LF3N8ARmFauSUmqNrvOy0gDZNrsEyQyhVM9x065+ygoIGmSuQxpDrzUF
AtkCL8GX+HIds+ZMtivaHOusUQX9EXxLOFo/5XpWwHCt48UnpNP3IJnmdtdbk3RD
7hsMVQxADZtlDoajGQK+0NBkMt2no5xTNwAflanUb7Qh84MsbsU=
=PXo7
-----END PGP SIGNATURE-----

--bsqC+rgGDMZ8rieL--
