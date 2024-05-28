Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7483C8F48
	for <git@vger.kernel.org>; Tue, 28 May 2024 06:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877891; cv=none; b=GhFs7yRPGG2FctMaQUVc6nf7fVukjLlY1OpGLyHJWY8yhJ0fUAPgUCnb/IWZ5dZSE+fyV6D3NF2k4V079DwVa/fWVh0BMzfrtdV7Yq5gdQTfRSO8fK9ATNqbOPekIvNfcyadxXJ+A7UUta9wCxdZt+d+kRfw8lLgokSkI11R/tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877891; c=relaxed/simple;
	bh=ncJi5SG/hCtAMgfh3v0Hi9ICYgr0SMqJtEVtPUQzRHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chMHB/6nhWJmViTjVPaTnBKUTHYBydSrQcqhvD6LkHHVvlkQmV2QWj+hdj5T3X4ynomzVno77Y5Axs0s6PtFkr4rTgAmRPMgLWd6T/v4i4F0rNyycfExSf59tRJ2A6swNliS85Xzct+FzvnY7MmMYQaIEgmCkH+qYmQ++2xeT6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mLvCfnlT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KWOVlINX; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mLvCfnlT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KWOVlINX"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 70C571140097;
	Tue, 28 May 2024 02:31:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 28 May 2024 02:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716877888; x=1716964288; bh=9zit0z297j
	uSdpm+9/RhIkMiNGITMBZBn2guNDJtXxM=; b=mLvCfnlTfRk5EQZ5cApm4fgoiq
	dfL1DzyChgaWWd7GgufR1GjHIHNwI9/f6J5G5t1Br2j7Lwmhmrmut3crFqv3JYm1
	zItCQFgtHdVAxJZY6GwkIYHZ6FmNV6kMNttwf6zmkS8bJ5IlWbXVqTX5S8TKX6zI
	TcfZEkoWVLaFR9t7SwSDnO8K/dK4S9XhNbzwC2Yfgj0ZJ83F0EHmOcSQcY3E1ymz
	M0wHRchOFCtsBs9NOYRqwczXcsFUoLi9AtRdJ/lvw/NvkM09aUq9701eGMt6dlcz
	IHTXw9pHwZRzrFi1Eo165McPNE1I2SboYJhhdoYDPDBjTZ/PWTFKHy3pd3lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716877888; x=1716964288; bh=9zit0z297juSdpm+9/RhIkMiNGIT
	MBZBn2guNDJtXxM=; b=KWOVlINXV1nvrwb6UPI18Hukc4RrV4t9CIjnD+Eq/EV4
	Yjta42S8xjwg23bVkdBBUQjsCXVIrHHCkwBh0IEvoiPqc3MM7eBTuynGDeVpXeoj
	JkPDXAcZ2KAjW70u8wve7hMQGCXPoi+Fe63A6VvAlOFwlrBoQVNyoGNlp2DPXq0q
	rXnTfr0r/vLvVGp+74cJgGQr0CZeUGMpbYoSSTR5fMCkCQ9hbJrCdGx56a65lY8K
	8S4oWQ3Nzh/1i4E0VEkgxEoq3iKSngpfIFcJsav4ErkSO/ROTcXBATcxi1b+amnm
	Ny2PV9U5xOuhIoWuQzMjbZxWcFdD3GMoJ1zrYAPzFQ==
X-ME-Sender: <xms:QHpVZl97ZaBjkwS9VZkzN_nXzrSBRK7KhdEtgf_wZV3v3UovPjpf1A>
    <xme:QHpVZpv9lt3Z2enUWfxTExsIOYD1KaZ89FzGyhgBRso_VLnGFxEEeQzTWU-tiZdDY
    Fm72JG17thnlBXcDQ>
X-ME-Received: <xmr:QHpVZjCVZy2noz5-eWHS0jEclP2YHB6k1KNudg3FFtNfc8azVzgPa7X8ODo5fFUWv5-mn_QvQ9L_e3Q_NxV4taAp2SXArSpetFHr7bU7avEVg6HB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:QHpVZpcRR9L-VOkzWoVnbXQ0IBtQ4c9ippcvx1CaNSLkqP1_Er7TYQ>
    <xmx:QHpVZqPrh8eND3FnoM2tPLsWl_BU4Ve0Ene8ctQ2qws_2SgzofJcaw>
    <xmx:QHpVZrlivif9ZnHDFD0FmQHqzdeEypTLSRi0CXc_mEhG9iQabc5sJg>
    <xmx:QHpVZkvQ69ueXFGH39vvJhNLQg2w2WQWdXBxZhvoLlJKMvlCtu1HTQ>
    <xmx:QHpVZh1_hNhDckAPx7J0smGw7B9Bgp13wr2KbTE5STvvRlc5b8e8w2vu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 02:31:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 81d258d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 06:31:15 +0000 (UTC)
Date: Tue, 28 May 2024 08:31:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 03/12] refs: pass storage format to `ref_store_init()`
 explicitly
Message-ID: <7d1a86292c205bb47bffa93aa293a3575836f9fb.1716877224.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716877224.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2//rEO1L43UKHar0"
Content-Disposition: inline
In-Reply-To: <cover.1716877224.git.ps@pks.im>


--2//rEO1L43UKHar0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to introduce logic to migrate refs from one storage format
to another one. This will require us to initialize a ref store with a
different format than the one used by the passed-in repository.

Prepare for this by accepting the desired ref storage format as
parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index e6db85a165..7c3f4df457 100644
--- a/refs.c
+++ b/refs.c
@@ -1894,13 +1894,14 @@ static struct ref_store *lookup_ref_store_map(struc=
t strmap *map,
  * gitdir.
  */
 static struct ref_store *ref_store_init(struct repository *repo,
+					enum ref_storage_format format,
 					const char *gitdir,
 					unsigned int flags)
 {
 	const struct ref_storage_be *be;
 	struct ref_store *refs;
=20
-	be =3D find_ref_storage_backend(repo->ref_storage_format);
+	be =3D find_ref_storage_backend(format);
 	if (!be)
 		BUG("reference backend is unknown");
=20
@@ -1922,7 +1923,8 @@ struct ref_store *get_main_ref_store(struct repositor=
y *r)
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
=20
-	r->refs_private =3D ref_store_init(r, r->gitdir, REF_STORE_ALL_CAPS);
+	r->refs_private =3D ref_store_init(r, r->ref_storage_format,
+					 r->gitdir, REF_STORE_ALL_CAPS);
 	r->refs_private =3D maybe_debug_wrap_ref_store(r->gitdir, r->refs_private=
);
 	return r->refs_private;
 }
@@ -1982,7 +1984,8 @@ struct ref_store *repo_get_submodule_ref_store(struct=
 repository *repo,
 		free(subrepo);
 		goto done;
 	}
-	refs =3D ref_store_init(subrepo, submodule_sb.buf,
+	refs =3D ref_store_init(subrepo, the_repository->ref_storage_format,
+			      submodule_sb.buf,
 			      REF_STORE_READ | REF_STORE_ODB);
 	register_ref_store_map(&repo->submodule_ref_stores, "submodule",
 			       refs, submodule);
@@ -2011,12 +2014,12 @@ struct ref_store *get_worktree_ref_store(const stru=
ct worktree *wt)
 		struct strbuf common_path =3D STRBUF_INIT;
 		strbuf_git_common_path(&common_path, wt->repo,
 				      "worktrees/%s", wt->id);
-		refs =3D ref_store_init(wt->repo, common_path.buf,
-				      REF_STORE_ALL_CAPS);
+		refs =3D ref_store_init(wt->repo, wt->repo->ref_storage_format,
+				      common_path.buf, REF_STORE_ALL_CAPS);
 		strbuf_release(&common_path);
 	} else {
-		refs =3D ref_store_init(wt->repo, wt->repo->commondir,
-				      REF_STORE_ALL_CAPS);
+		refs =3D ref_store_init(wt->repo, the_repository->ref_storage_format,
+				      wt->repo->commondir, REF_STORE_ALL_CAPS);
 	}
=20
 	if (refs)
--=20
2.45.1.246.gb9cfe4845c.dirty


--2//rEO1L43UKHar0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVejsACgkQVbJhu7ck
PpSvcw/+KHBkKm/pUe+T6x4re8t0hO8bqiEhPiTEL/FLnsuxLT472xZEgGlQ19jT
EYbcZV3NBHjaisFiPSdJK308p1tF5ZjSPHz90x1WEbl44lKPOdLM/G8tawF4yyN4
s0uIzKtoRCAi5JTuCe1kOpeTvA1A87sevBaX7IZCfIB88lE1D2yJXUVQUQvmWAua
UCnP9q7dvlwVx6a/GSI5QYhPjnBcXVZhbB7CXv+RYk0bBnlA60vpNpCRQgHl4WYj
0pMEt/cLZBRzZ3xq3lnD0VzScv59UP4DKG9I+Jow3/iT9SLtfyc1oYXHAFXEqZrE
6Arbcn3nh8yyjHEvRgvODQrbsRUH8un18JS91u5zW1z+5aSCqxjyk3iiQHCPpicS
FVn6iWuWVPB0U9H5X2W9aV9SV+z3Le4Equaj7AODCQJ5RpLA9FPgQwNXfnN/yw+b
jXad5iYVWAuuwDGyTqE6/RAb9PWRN8onxvXDB0rNV8ReHVeBySUu0VQn0BXk2t33
tbTXHXITEv5tGyd3Oj4kNnamkGc8eFhNorEtBxlgNdy6CmR+oTNm8rjVWYTU3s/d
bdiTLVQnSVcIgGpgKB/EEoo8RZQ+eSii1ZPTwCkB8QnofUjND5KZy0iy3L5CNVzL
INCo+ubWQwU6yjvXEVbbGi1mbn/vIGqpD7mQprASuIMk1HaEuM8=
=rk2j
-----END PGP SIGNATURE-----

--2//rEO1L43UKHar0--
