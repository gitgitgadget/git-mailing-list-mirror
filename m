Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2951D2C84F
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933911; cv=none; b=JJpLwi3ertWMAtyIna4dVOA9RslwlaswLYSaY4cAVMwcJe0IaH/K1EPahbfJYA7spK8FfSAR02ewMgM5UmZ8RjDnxj6yuQu+v/tIJ9ONpY1rMrWDExiqvycuSFZHZ8mXkHlyf7LSMbmQiyHvcxhn9L8ZGf0sgvNLr5BObAs8Wbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933911; c=relaxed/simple;
	bh=RtPTLJCIVWZtes3eionGmcAAfVUM2XEHosvS4hhvj9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHuHtq3VkGxyy7vZ0YpaH/HJoCscwItDIgLeqpWeykCfCGVsRCfT3EZADPFxa8HiSyJo1SVI19aHtEICz+y1RLVh4YGUul9PR8zRI+sI5RjuTrXGFYOGe8Q/TAzeypXoCb4mwgmlC2rlCgvT6vbadSmWb0BT8wskpdqOzhJ7pIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=owzS2xem; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bJ8+nY/Y; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="owzS2xem";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bJ8+nY/Y"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5E3111800178;
	Fri, 17 May 2024 04:18:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 17 May 2024 04:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715933908; x=1716020308; bh=sX2dim/a+y
	0HOVdN4fZsXDC7reBXDxl30hFATI6Ei+k=; b=owzS2xemZymX3++kmGUVmx9VnR
	AK8H3wFn01SjZHwSIsp1+XMiDHD+HBh24JFJKqsI5x7bLCd8U0YCMAsUJQMFpJn4
	H5ZKAQSSp6rynryhz1WgpgyXf4waMnxCIh6uLp/gmpHvyykopkT1BWDn0ZO/Lq/c
	dyLn8Mqd0h9Nqhmf5ttym9Gx7Qelz/SK2DyCmJ9PlmnSlofUhe+hK2rAIW4D2A0P
	4Yt0/tvNn7nR0mAl/a/P/LHTfHVoCDHSr6HBhS2lvkNzIEUkyZFr7lxUOjQoqngj
	pqDXsJcm85/frhS2qoND9DEhVBGpfPBAKaOtiyIiZNaQcZWj13SGK+DmllJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715933908; x=1716020308; bh=sX2dim/a+y0HOVdN4fZsXDC7reBX
	Dxl30hFATI6Ei+k=; b=bJ8+nY/YBvVpCssyzA9uMwdw5kNVc6q1455uZz6gkc2V
	YivTmpUuQ8+3LLVHTUEnGkVLdTEpbNI/rSK65Qrregx1l3O1y0VHc9zp8pF6bYpx
	dy4jrOolt0Ua1D/k92oDuSMiHy+EZWCcTNImxFh74gCOvTNpQCX+2XGn3pL2dL4E
	n9G7K7/0og+ppynDgLuPGxHbrESG3duHJfGnZfT0AiV9d0f/2Cc9DG8YEY4VXSEP
	cemKcHXE0wgR6gbVSBF5UX19fL3eG5Zqvq35Femip0/hSXmrDzHAkmwPA6UwrMZ1
	6cNPi7R7FSpRq+6OGN2kBNQF4OZK3hSMBI46zxq+6w==
X-ME-Sender: <xms:0xJHZr_i6aKaIBnohtKBdbERqd2XRJCSJVxb95NCdt78hTKwa4pN_w>
    <xme:0xJHZntBV3HYe86lfbLNIZVu-Zj33FD7VUOO9ScjFPh2XuVYw9_IuXaoaHqpTF7Yy
    X6JIlKDuR5acrqooA>
X-ME-Received: <xmr:0xJHZpC7v6WeawaxCg8crwQ1jB4ddCsUHf4qIHJFqbvN745XLs82Fk2xyJPso3BELoV9JhUz88N03Fhu1kIvbhSHpaKnjUDgkzhXhRgEe3Fk5oBxWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:0xJHZneoyeJuTMV_YZEfrTLmPAJm3D6SXMsa_GvN8RLX-17263iImQ>
    <xmx:0xJHZgNpL3lZRuqx2q_wKz4F1zHOw61wXrhtfJftgv85ZOked0n32A>
    <xmx:0xJHZpkEMxsf2_pZ5HGVB9p5YHr5qhNPzewSFUVr0Zi9ahPbAlq1cQ>
    <xmx:0xJHZqv8g8iEtHQNOjB4XY-4HjmnxsSedbZ3SlrLnwlotwN2zvFh_A>
    <xmx:0xJHZloENMhMmN2JMHW1RP_uTqGFN5PVs60owR42_wORkoMLSYZPNkLn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 04:18:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9fbe0f9b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 08:17:59 +0000 (UTC)
Date: Fri, 17 May 2024 10:18:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/16] refs: implement releasing ref storages
Message-ID: <4beecb09445f050eecaff079d7cc873ddce62706.1715929858.git.ps@pks.im>
References: <cover.1715929858.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FGjpBPKCnGD7tKyB"
Content-Disposition: inline
In-Reply-To: <cover.1715929858.git.ps@pks.im>


--FGjpBPKCnGD7tKyB
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
 refs/debug.c            |  8 ++++++++
 refs/files-backend.c    | 10 ++++++++++
 refs/packed-backend.c   | 11 +++++++++++
 refs/refs-internal.h    |  5 +++++
 refs/reftable-backend.c | 23 +++++++++++++++++++++++
 7 files changed, 68 insertions(+)

diff --git a/refs.c b/refs.c
index ebc6de81e9..0f4d327c47 100644
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
index 421ff9fdb7..b11c250e8a 100644
--- a/refs.h
+++ b/refs.h
@@ -118,6 +118,11 @@ int is_branch(const char *refname);
=20
 int ref_store_create_on_disk(struct ref_store *refs, int flags, struct str=
buf *err);
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
index 4cc4910974..3a063077ba 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -33,6 +33,13 @@ struct ref_store *maybe_debug_wrap_ref_store(const char =
*gitdir, struct ref_stor
 	return (struct ref_store *)res;
 }
=20
+static void debug_release(struct ref_store *refs)
+{
+	struct debug_ref_store *drefs =3D (struct debug_ref_store *)refs;
+	drefs->refs->be->release(drefs->refs);
+	trace_printf_key(&trace_refs, "release\n");
+}
+
 static int debug_create_on_disk(struct ref_store *refs, int flags, struct =
strbuf *err)
 {
 	struct debug_ref_store *drefs =3D (struct debug_ref_store *)refs;
@@ -427,6 +434,7 @@ static int debug_reflog_expire(struct ref_store *ref_st=
ore, const char *refname,
 struct ref_storage_be refs_be_debug =3D {
 	.name =3D "debug",
 	.init =3D NULL,
+	.release =3D debug_release,
 	.create_on_disk =3D debug_create_on_disk,
=20
 	/*
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f9f15d1f76..62acd2721d 100644
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
@@ -3284,7 +3292,9 @@ static int files_ref_store_create_on_disk(struct ref_=
store *ref_store,
 struct ref_storage_be refs_be_files =3D {
 	.name =3D "files",
 	.init =3D files_ref_store_init,
+	.release =3D files_ref_store_release,
 	.create_on_disk =3D files_ref_store_create_on_disk,
+
 	.transaction_prepare =3D files_transaction_prepare,
 	.transaction_finish =3D files_transaction_finish,
 	.transaction_abort =3D files_transaction_abort,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index b94183034e..9c98e6295f 100644
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
@@ -1707,7 +1716,9 @@ static struct ref_iterator *packed_reflog_iterator_be=
gin(struct ref_store *ref_s
 struct ref_storage_be refs_be_packed =3D {
 	.name =3D "packed",
 	.init =3D packed_ref_store_init,
+	.release =3D packed_ref_store_release,
 	.create_on_disk =3D packed_ref_store_create_on_disk,
+
 	.transaction_prepare =3D packed_transaction_prepare,
 	.transaction_finish =3D packed_transaction_finish,
 	.transaction_abort =3D packed_transaction_abort,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c3d5f0a6cd..8624477e19 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -529,6 +529,10 @@ struct ref_store;
 typedef struct ref_store *ref_store_init_fn(struct repository *repo,
 					    const char *gitdir,
 					    unsigned int flags);
+/*
+ * Release all memory and resources associated with the ref store.
+ */
+typedef void ref_store_release_fn(struct ref_store *refs);
=20
 typedef int ref_store_create_on_disk_fn(struct ref_store *refs,
 					int flags,
@@ -668,6 +672,7 @@ typedef int read_symbolic_ref_fn(struct ref_store *ref_=
store, const char *refnam
 struct ref_storage_be {
 	const char *name;
 	ref_store_init_fn *init;
+	ref_store_release_fn *release;
 	ref_store_create_on_disk_fn *create_on_disk;
=20
 	ref_transaction_prepare_fn *transaction_prepare;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 8583a0cdba..7b73f73f59 100644
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
+		refs->worktree_stack =3D NULL;
+	}
+
+	strmap_for_each_entry(&refs->worktree_stacks, &iter, entry)
+		reftable_stack_destroy(entry->value);
+	strmap_clear(&refs->worktree_stacks, 0);
+}
+
 static int reftable_be_create_on_disk(struct ref_store *ref_store,
 				      int flags UNUSED,
 				      struct strbuf *err UNUSED)
@@ -2248,7 +2269,9 @@ static int reftable_be_reflog_expire(struct ref_store=
 *ref_store,
 struct ref_storage_be refs_be_reftable =3D {
 	.name =3D "reftable",
 	.init =3D reftable_be_init,
+	.release =3D reftable_be_release,
 	.create_on_disk =3D reftable_be_create_on_disk,
+
 	.transaction_prepare =3D reftable_be_transaction_prepare,
 	.transaction_finish =3D reftable_be_transaction_finish,
 	.transaction_abort =3D reftable_be_transaction_abort,
--=20
2.45.1.190.g19fe900cfc.dirty


--FGjpBPKCnGD7tKyB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHEs8ACgkQVbJhu7ck
PpSpkQ//Q5wI6SG4287KzkxjpCsg9YFw6+OOK4xd/ds0OxJfgfmH4Eof5v4MhnzF
fISNJgox9gAQxJabmF2M3f+7wEcMIcNktlxDHkJhyo28/ieaaNp8s1CLdgyANoUB
yAwpO6uhZtr7SupYKi692BJCLv1cyXXoq0waUEoT94zXc4Byc/olSr2st3ncnVPJ
J0kSiGbhbmmmaSo8JtN8BjkvFgoNrFQN21y8mE1mtkA3QQ8caJMw4jLfZbRNVdfA
+pZ35NHcIAikKGIDd43647cIMSy+BokvQ72mi9vbaR2yl3lh+EccsaQfpZ0upcNa
RqUcFSMpCEsZT0gQHvtiuBXSs6UIkrT+G8oS62gQ2xrJQRt0LTh9qkS9sQricQW3
7TGRZZsPMLDuVX3LzjKvxVMvgpn0YYPj8MkkksWFPG7gUaVa+ROHGdd5dfMbMlmA
qlgvw6++n1g+mxrvUwbZBWQEbmuMu4o6VJGH2bHLQx/G/47e/Ndy18eQW9Pt4OLa
MgVh7/RUIeoIzZqxuuA+Va9iLmhszWJ6Arv80dTrFPSulyjW9i2tGtXnAgykTyX0
/JRNe2YYz6V9AIQQ9mvhzG/HtT+cW9da4zejQrAvY7UPyTe9FS/A9SKqL5MYJ8nA
jHyRvTGfxIm1G17e139516+a2jn3Vb8WfpWBl6VjfIAq9yklwK0=
=7F0W
-----END PGP SIGNATURE-----

--FGjpBPKCnGD7tKyB--
