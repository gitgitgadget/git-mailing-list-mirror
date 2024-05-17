Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA1828DA4
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933901; cv=none; b=WUZnl61neAiaW6MwVoxCwgTbjbLYFLehYOmXFCXP+0GGIhJZOd2l2AQAW9hpW1PTZyaUYQFRHYivNtq2gDf3UiLKQhgMMjMn+qkLQ0yJ5HW3AK3J+rvSOUUFnJAAJZJ6v1gE8QqyKc86z0BpWzUUFBs+Wk+WgkoiTa0Iz3FRvwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933901; c=relaxed/simple;
	bh=cd3a/e/2IvQrPxoQzoiUes2ue/5iUr8vYcDzxnDzayo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlKWcBfI5QT9zvZnuPeFSFoTFPZ+LuTqqmeMQBLiqYD2vUJs8pIbULFMSkEPqU5LTb8HpE8V2gRe/hqDJIJrL8779KzMs9P7z6kYPt1gNJw3vHwMNLm0eQo26VQPuEOJIHXpBX6lF4CJvQ9OahNc1kFacLlc4G6/si8F3j/6wpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U6C1nXAG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RoFs2OIV; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U6C1nXAG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RoFs2OIV"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 822EE1800179;
	Fri, 17 May 2024 04:18:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 17 May 2024 04:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715933898; x=1716020298; bh=i7wtN5R4+L
	2WH9hapT4WQvXFg3BZ2UravvdMW5QAYhM=; b=U6C1nXAGbVdvBxes4gwVMBTjqY
	9Msps5oELFP+6qP+1h+Sj/3i3og2xSYuSBWGs91E5gnD/yPrBqhL1aqgJmA3TEr5
	Z3DI6HUvKvPgE9pGt9kloFStee0D6b0IpmI3AT/cOgwJNyYptND5ep4mf+QSQ9xM
	Og6QhhW/50Dv+EK1Q8YMDiMpblRM/u+arsWzhIeuGGypUSaytDJx99EohbzXuMjn
	vqkDZlaEK5HH+3wZKRzetP7PjjaaDyNdp1Xg0evj9HUZZRbTec0LGH0EFPxSC8c6
	BlrQjGcBULRLYTqmylmor21WlmLayZ1ebUlsYedWSf1bSgWsijT5AIERvt9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715933898; x=1716020298; bh=i7wtN5R4+L2WH9hapT4WQvXFg3BZ
	2UravvdMW5QAYhM=; b=RoFs2OIVZSovaT6Qwdra1a+dv7ZULN/2ymlGfq0wt9rs
	LaRQscM2r1ADLgDRg+pM7yVVT1fO3D99FGiQ+XZ+8GUmVyi1yOqCLImcamnhJM64
	PAHnsxyZgyTPiStBBrrNpKxsFgesyckCsI3MgS/rnD/cCEX/wbpeq1dzb21Uj5xI
	wj5SXl7Qfq+FkVo+z5RSD7ENtEMQK+9hxtmzZO0A32h9wwWf5PHzm4xPTpIfGx9E
	fJdV8KPpa/d6ju5hz2ItlqXXafcMPfSkKPKHlmIUDMZ9YK3JxIJOJa/4jUw4zCbu
	jrFti6ox2tdSx9qVHwtto0k7bNNEH+cPjAHNQK3Lcg==
X-ME-Sender: <xms:yRJHZvP4zySRyRtkheYtVY3u4ERGO92VGHDD3ViC4l_crAIEuhcgvw>
    <xme:yRJHZp9tMQgdXBM26zX6kPl9L0B8vDgTs7OZOFZa5atNHsDOnF4Cwc2HPEMOZYklW
    JtG0U-CyyeDpKtjaA>
X-ME-Received: <xmr:yRJHZuTefM1-fWzrr0CePpw3VJNPl0p3zEQtow_opIl8-9E4U2OYKeSFZPGb2jenQSAV7135IV1FgWM5d0yVuLEvrHDUBhbDZhZTwvM4OMynHUvSuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:yhJHZjsrfyUyU6gWRV_yaLygeq3OfGDJCEyqrKcftXvZ2nuf_xVa5w>
    <xmx:yhJHZncupHi5uR4BS7HJEJ0iDEX0U9glYjIaWihUgtPvfASjbpJQ-w>
    <xmx:yhJHZv1OQWj8msy9aH-FmIuJWPdYcmCsZ5o5z_aN9EFOsaInnremXA>
    <xmx:yhJHZj-Bn7p8UlMnvcJeLiGWHebnZJ-U2zcN7LSCMt3TBIC308p9-Q>
    <xmx:yhJHZj63s3PbaeX137gGKGkMXYpNbeXY6lQWpJdkVmHeKiwNwuJ2kmcu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 04:18:17 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2988987e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 08:17:50 +0000 (UTC)
Date: Fri, 17 May 2024 10:18:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/16] refs: adjust names for `init` and `init_db`
 callbacks
Message-ID: <4225a6928ab5119d8d6844c6a7a13f1975137767.1715929858.git.ps@pks.im>
References: <cover.1715929858.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uZHOCLho7G/voC1P"
Content-Disposition: inline
In-Reply-To: <cover.1715929858.git.ps@pks.im>


--uZHOCLho7G/voC1P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The names of the functions that implement the `init` and `init_db`
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


--uZHOCLho7G/voC1P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHEsUACgkQVbJhu7ck
PpTyww//bt1WZ2U310rngyLZVIK6wRIx9uYkWWRY1b6nV5B+Q3husZgAkFRFaEn0
HWZsPIWNefPIjbE8/BUaWJy5pgL3bpnnhG81Qs04yhalyjuoAwrFrpDJWeddsogv
XH9pxL/Amg0VXCVZ1KZMmk1MS4eTpgKjE+/9AAfsCbuAaE/GPhNH2g/K9cFLD3XF
ay8H6DC82WNDcReNjpnwxTwQck77AbID91VfN96bCP6rg0FIJyoU/VntmI3HoyRi
R/ZF0+TYiqGoNOelwkhYcjM8x/1qMw1tioGYVM3hGlJoE0ZvY25UhyXFN+zvD9A/
gUELbPToQEil7M1hQGXbBs6MP37GOCXPgDHel2bRf5SPnN2dhzD4T8K6TMr//d0B
AFJxWrsVyU5rxTz70aKLFdxV3sDFp4N7PYQd2vVAdcdIaWLYPiAx/Kad/dUhwF2a
c6isJARLqMmGscbVK16OcjZMj/LsGNJt/pO2OyBBXJUbOPyHO3tcvjT8e8pcpNfm
Y1uI4ge1VC9Dh5niojWxWylno0hBXYekBTRgkaKI9GyiY+ht9Pg9YWVnlVQaeymN
JyUsjhrKxAutz8N9loEoAtWFayLYO0OvpO5TPS86qMxwD9+PwfvnZMAvp+wjojmt
N8VOahUF7Vj1Yn7C615LNEyls2wl8C2v5ko6JDWTizFQG/nhn6E=
=ZSXS
-----END PGP SIGNATURE-----

--uZHOCLho7G/voC1P--
