Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484B380BE3
	for <git@vger.kernel.org>; Thu, 16 May 2024 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846667; cv=none; b=OHZvdD2xjHnMnUD/nDR0dqw6m0p04U0xoFYQfiE9Wc97HTb9KWgLX+hMT/a++be2EDSalSPrCg7B3bspxrs9a5d6+kD9LWvElK7hZ18zUXOtcuFymCz0ekZL6yskJjlT8tOQcLva+yLyb7UcZHnAcSl619/e3NML9iW5MaE+gPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846667; c=relaxed/simple;
	bh=orKg9vqr5WgZQGUWAyqAPIJuT35xbSidB8TxcIefYxU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSa/IPMwBTIS5oPLH18THU8ShxjxeKdqvPmKx/dM+OYxOqgrUbRV5Zt5E0HGG/7snW6sjlMNZVYKxaFf72lfohZTEd80gUQ1JEJefa+c7TpEiO3CYZzneTIPoPG3Rluq8aUAYnhVL+g8VABoFNYAstuJc7EKyrA07JhBo9KLaqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i8n6KBw+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B4zfqmIz; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i8n6KBw+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B4zfqmIz"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 577B41380E54
	for <git@vger.kernel.org>; Thu, 16 May 2024 04:04:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 16 May 2024 04:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715846664; x=1715933064; bh=tl16NLF/8J
	W6tXuBuqRq++KihhiGh68iNUgfO94ECIA=; b=i8n6KBw+5w+lHuazfaNwkxAH6k
	PN6gV3V+kt2Tq1d4pJLlF+X7Q126eNjjQsQ+xwO4HEi2gWdadrOeUTtZAxfRRpnG
	bW6pctB1D2ZxLc0PvQ6RO4A5nGIpNOoKJauW4wpDMLCWcVO0qrcl85cW6mw+O516
	dQ6rHht7QMNTVgGjz/vIS97/atJ18DK7Dp1cyLfhJl7AgqNesMJpcQUG4UMc+kX4
	UPHaWdJhPNvJEBtognSOnqnkg7+DyoEzHOvFYPf5ylV4Mlfmc5hDMYSUfN7YhRKb
	o7FNCrvG1VOoJ/MIzFihmT6gIGdRdlt52RxuYs13CYGk4ouJikKYu3O+IXZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715846664; x=1715933064; bh=tl16NLF/8JW6tXuBuqRq++KihhiG
	h68iNUgfO94ECIA=; b=B4zfqmIzBSlyJi8/5TNBVsAWcVi+6Wi/3QPgP0yg6vd6
	bvaPDllsJAhG6ihEsCTtHf9ceHO1bu1dkTnkvNTEXHLJZ3eQtsBOR1k8duQ/3jxR
	Suv6i2KzpG1WcJFHjlS8XRpNIwGDtFneGVN/u28SDd2ptPsxPyFwgB69f7mquWIh
	4fkv7cpKoazinC/hoRxR1RDm9ggSEl+YshNbZdbiI54KtOECGNcC/SL+S2ofn6xD
	o9IpKkZV8CZN8PGhGY6C5IhE7fJ1xX8RtUoXHPpMF0n7DznCK1q6//w+Vp98t3LY
	9NoBru+GKcQ/FgLJxRhJTWGWdjRnt20nh/7Z5uiBqQ==
X-ME-Sender: <xms:B75FZi331myymO2MCRVegFwQ4GEoVFSt8gCSF1ln-qwDgsq11YVXGg>
    <xme:B75FZlHIC6WNKPFByqdYGr3S5ijHauGQPVF-HNBWrx01iwNnpCa-Phlqul9PsmDjM
    jg7Nn-m__1k1e9DLQ>
X-ME-Received: <xmr:B75FZq5oCbx5BcD-szeX7ZNxmIaAe7o_pzIYGgqW2IUReFqNPEhp_0l_c-CxvD7p33B8ks2z6ubfDvkJxN3GO-VxaoIjtLm8nxTtpIQ948bLask>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehtddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:CL5FZj1SWS0qFYM-PG_RQi6zkZ_Jls4FMvt3vCYOQNzSiohrdHz0aA>
    <xmx:CL5FZlGWaoHW8r_TgCsjU4Rz0Lbp-raikTzSCQheAAeDa1Ur7qXbzQ>
    <xmx:CL5FZs9iAS-PVtpxzjF03PLcOBuULZmCLgo6ntoi0iEHMRHEHS61Fg>
    <xmx:CL5FZqmdzk1UAnRzc6Q4YtEa5Hyc5-YVhphjm2ccMR3O9fss8BzWZw>
    <xmx:CL5FZjOIvzM4S7849cdg_z_B18FiTSBlalAZtYb0rf2-yGtOq-iiWrPE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 May 2024 04:04:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 31e2a06c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 May 2024 08:03:51 +0000 (UTC)
Date: Thu, 16 May 2024 10:04:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 01/16] refs: adjust names for `init` and `init_db` callbacks
Message-ID: <360d03474635e36a80a3b720bf0f86ac272c618e.1715836916.git.ps@pks.im>
References: <cover.1715836916.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f2qObYoUftxApvHJ"
Content-Disposition: inline
In-Reply-To: <cover.1715836916.git.ps@pks.im>


--f2qObYoUftxApvHJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The names of the functions that implement the the `init` and `init_db`
callbacks in the "files" and "packed" backends do not match the names of
the callbacks, which is inconsistent. Rename them so that they match,
which makes it easier to discover their respective implementations.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c  | 10 +++++-----
 refs/packed-backend.c | 16 ++++++++--------
 refs/packed-backend.h |  6 +++---
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a098d14ea0..2c9d5e0747 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -89,9 +89,9 @@ static void clear_loose_ref_cache(struct files_ref_store =
*refs)
  * Create a new submodule ref cache and add it to the internal
  * set of caches.
  */
-static struct ref_store *files_ref_store_create(struct repository *repo,
-						const char *gitdir,
-						unsigned int flags)
+static struct ref_store *files_ref_store_init(struct repository *repo,
+					      const char *gitdir,
+					      unsigned int flags)
 {
 	struct files_ref_store *refs =3D xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store =3D (struct ref_store *)refs;
@@ -102,7 +102,7 @@ static struct ref_store *files_ref_store_create(struct =
repository *repo,
 	get_common_dir_noenv(&sb, gitdir);
 	refs->gitcommondir =3D strbuf_detach(&sb, NULL);
 	refs->packed_ref_store =3D
-		packed_ref_store_create(repo, refs->gitcommondir, flags);
+		packed_ref_store_init(repo, refs->gitcommondir, flags);
=20
 	chdir_notify_reparent("files-backend $GIT_DIR", &refs->base.gitdir);
 	chdir_notify_reparent("files-backend $GIT_COMMONDIR",
@@ -3283,7 +3283,7 @@ static int files_init_db(struct ref_store *ref_store,
=20
 struct ref_storage_be refs_be_files =3D {
 	.name =3D "files",
-	.init =3D files_ref_store_create,
+	.init =3D files_ref_store_init,
 	.init_db =3D files_init_db,
 	.transaction_prepare =3D files_transaction_prepare,
 	.transaction_finish =3D files_transaction_finish,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4e826c05ff..a3c5a75073 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -200,9 +200,9 @@ static int release_snapshot(struct snapshot *snapshot)
 	}
 }
=20
-struct ref_store *packed_ref_store_create(struct repository *repo,
-					  const char *gitdir,
-					  unsigned int store_flags)
+struct ref_store *packed_ref_store_init(struct repository *repo,
+					const char *gitdir,
+					unsigned int store_flags)
 {
 	struct packed_ref_store *refs =3D xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store =3D (struct ref_store *)refs;
@@ -1244,9 +1244,9 @@ int packed_refs_is_locked(struct ref_store *ref_store)
 static const char PACKED_REFS_HEADER[] =3D
 	"# pack-refs with: peeled fully-peeled sorted \n";
=20
-static int packed_init_db(struct ref_store *ref_store UNUSED,
-			  int flags UNUSED,
-			  struct strbuf *err UNUSED)
+static int packed_ref_store_init_db(struct ref_store *ref_store UNUSED,
+				    int flags UNUSED,
+				    struct strbuf *err UNUSED)
 {
 	/* Nothing to do. */
 	return 0;
@@ -1706,8 +1706,8 @@ static struct ref_iterator *packed_reflog_iterator_be=
gin(struct ref_store *ref_s
=20
 struct ref_storage_be refs_be_packed =3D {
 	.name =3D "packed",
-	.init =3D packed_ref_store_create,
-	.init_db =3D packed_init_db,
+	.init =3D packed_ref_store_init,
+	.init_db =3D packed_ref_store_init_db,
 	.transaction_prepare =3D packed_transaction_prepare,
 	.transaction_finish =3D packed_transaction_finish,
 	.transaction_abort =3D packed_transaction_abort,
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index 9dd8a344c3..09437ad13b 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -13,9 +13,9 @@ struct ref_transaction;
  * even among packed refs.
  */
=20
-struct ref_store *packed_ref_store_create(struct repository *repo,
-					  const char *gitdir,
-					  unsigned int store_flags);
+struct ref_store *packed_ref_store_init(struct repository *repo,
+					const char *gitdir,
+					unsigned int store_flags);
=20
 /*
  * Lock the packed-refs file for writing. Flags is passed to
--=20
2.45.1.190.g19fe900cfc.dirty


--f2qObYoUftxApvHJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZFvf0ACgkQVbJhu7ck
PpTp8Q//SmiIXgk0WGBTyeeJDvi5+tVJmQolTiDB5JNay8FaQycGqeI4KHAfu/hr
I+BmuVM4ajrp6ziAv15Sf5mrtTAJjrDouZPDoIk7BX75OiO2UHJhWw/JbUzu+AZ7
gdvQrBqq9WybalWy1Dh2ia9bxHPOzK/xwuJOf4Wp10Ek9RIwETxI9nmb6tAuVdOf
/3cK+3p4uiP6/QI2i4kQwoSqVb/Gt7UPhA+45Hb0/e2IRwXwRkKahkSBQufA19vL
FzsZyFfO7CSEHIi0OGNOEMlLnY93weuA9US0LKL6CGxadhAws0ikxtjDe5aLyViG
wHeXeAWY164vw46/FU9jhjxVINfhUgX1EmeKu+0p07Gnui9COWbaolGgyZCP0sXU
zkbm5VKqJxreVEnB7otkrHETJOjytAecb8f00bgH1XR/n2fmLOMKIqj6SfcdAUzM
Zyndo2VfDSVDMnoZOpGFqen3twyjmeBEuQjuZlnvxGe6YLaxJJyaQXARIBHtB1nx
TYUu0nMt2uraEBLGUnyLn/pskLchqVO7rzso1Na8nh21yWJ4UAUiykgnudwRqV4y
dPufjW02cAD96RM8fyfWvxdBCGikCjFqA4GZiRHtKm0iYQ1PPu0xnSG+M+DrFUjf
IHdbVJtnnCtTZ1iciGGI7KG7TvNh/iNW2kbG2MAWnsTy3awqZUI=
=aN28
-----END PGP SIGNATURE-----

--f2qObYoUftxApvHJ--
