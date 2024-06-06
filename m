Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00E437165
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 05:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717651754; cv=none; b=q0lW4Ue0uPrSbkdx1HfthsPiD+VC1PR3Vvm28kKUDHxiz4UVgTZSj26GvIovG5hvNehufSX2z5YtPEbRqMUfdA2EelSJgek6V9XZNQxbw2/hNIhaIG7004gQtXfGWO/QANn41GRdJO+andk/SJtO7tzaDh87yj2Qc+2zrYLlOlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717651754; c=relaxed/simple;
	bh=P396GJxafiCA4CB43/bFc3y+v3QTVlFda+K1xzNsxbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4N/eg7P3rxW5xoTbfYk4xBNNeIEjQL5T2OfwTKkhY8pc4jG7NmKaPSd5JixAat7Yq1U33rd9TuUTjqgYTlqOJQwFT2ktvrGWFIeUcXDFZ3GpI1ViYpPl7qvW+xcRWQ1yT7wYdZdAqikGZJZ3Rj0VEe4g1ZBNW5Z8CdI1+nAvoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Wz4APpTQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IPRf1WQl; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wz4APpTQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IPRf1WQl"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 820A11800199;
	Thu,  6 Jun 2024 01:29:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 06 Jun 2024 01:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717651751; x=1717738151; bh=pmBuIsPBzA
	UKvKNYkK6Q7y+9Uqyt1PlFgEzYDa+/Q/A=; b=Wz4APpTQKU94VbjeAiL2wZKfqT
	VIKMyWDsVdUfpMgztDXmQEVL/PjDmA2HUbUE4hjlMZ/Yc2IOMisd09nvdUDHFDRK
	+oQ215h3R8WZSWx+PSLdoZQSB08ugGGJ3D1XSwMAsN2cfcxHkj6M6qoSiyCV0Aeq
	epCGY0BbDua8KdJSIDRjpL4VjvXiqvDx7UV44hVtmbpU2jwwvx6k1Gn0wzvu4+nO
	CWdJBF7/l8c8n/BxOgzZMXx1C29C4vRcrqKff2Mp9Pnup65wlM6lyDF0MA7+DeKe
	tFwVizCMh5v95mkD2JW57tEi+M+qZNOjlGFB/2/mbAbodCoNwPgRNchwnurQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717651751; x=1717738151; bh=pmBuIsPBzAUKvKNYkK6Q7y+9Uqyt
	1PlFgEzYDa+/Q/A=; b=IPRf1WQlDkiCX97T6cFkejpKCGhpsZe1Co64aFl/jtys
	7AKzN0abUqUGNHaeH9B12oB/SkPmrl91rr9XnUu9MGMg2ax49lt8WepBAVQ16i+/
	d4Cq2kDEIgNSDxq6K5Z+ejveoi4bsUCx3zp5JV5RXn1ZMUbuCOmyRrjVFC5tGhz0
	73LSUpv27NPhXzh4sFUS8LMqbr1wVOOpR6sKVI9zeqMQhR+ZltoXDnyNrxv9fwLQ
	7yWflw2WKGTo0L5ak5MmXg+qQvNYnN4/sohLDnVTJDUzSigH3d/YR2MbXoUfh2Rg
	5yV+fH3Lz0ANciFNoVh1zcMSoa/F4e1i/DzKHfYrow==
X-ME-Sender: <xms:JklhZmRk4eCE2nkIo6RdedY8U5bJJ0Ljn12yNPECp9wpKX3BVtrWvw>
    <xme:JklhZryyT8zBuIr_tLcl3WPvUe8RT1mcKo-FFdvf5_0VSR4X5oq-BTElXJi3xzUCq
    vz_TqDqiX51R9GGew>
X-ME-Received: <xmr:JklhZj1aNF0HG8J2wnXYdU6IGEYn8XEhnQg814Bx6cZ3Lh2LzZ1XvdE2yC6pC33e58LvUQavu8cNj7QKMmxxLi_uQ9ppjisGpWN8UUMZFWHiCbWj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:J0lhZiCmfBMChtgwT0CvYVvKkKrUORjxsv2PDdQEsJ7uDSycrkIcwA>
    <xmx:J0lhZvg_F2sqian0NPcfK_sAgmW6NIFbpXVWRWSGgIejCYxMGFTo8g>
    <xmx:J0lhZuqo5QUUlDvc8PUE4m1tKQN4Fc0xguxvKMMoi2D_gLo5aoRRFw>
    <xmx:J0lhZii54O7R2lQHwIzSYQkgAG95UFNGAC8Z9TP8Sn4K3lDdHqZ6yA>
    <xmx:J0lhZvhjO-87DXDfBnKcOV22mNh5lY5M9MegmusvDtNWS8o-epgH1nGQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 01:29:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 05131f72 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 05:28:39 +0000 (UTC)
Date: Thu, 6 Jun 2024 07:29:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 03/12] refs: pass storage format to `ref_store_init()`
 explicitly
Message-ID: <26005abb280805eaced2ca146f004fe01ea039f5.1717649802.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717649802.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BLIIcOJ3abqG6Fj0"
Content-Disposition: inline
In-Reply-To: <cover.1717649802.git.ps@pks.im>


--BLIIcOJ3abqG6Fj0
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
 refs.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index e6db85a165..423684b8b8 100644
--- a/refs.c
+++ b/refs.c
@@ -1891,16 +1891,17 @@ static struct ref_store *lookup_ref_store_map(struc=
t strmap *map,
=20
 /*
  * Create, record, and return a ref_store instance for the specified
- * gitdir.
+ * gitdir using the given ref storage format.
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
2.45.2.409.g7b0defb391.dirty


--BLIIcOJ3abqG6Fj0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhSSEACgkQVbJhu7ck
PpQWYQ//QSIsFi8E5vVuPPXoUrQJySw3omZXEJt1FLart6Ojl4taeZbaIXuCBHZQ
6cBwLzn6AxEh2LOAx0YJ/YTKm68E3r7NOIwtbWOTUv4vyc8FyVYnuI6byAG6K+xR
7We6t7U3srooWK7xgrY0yowmKFH1HUZ6dsizXgRzvFejvdYUQbbVgGALfuT2+jxv
NyQkcedg4OF5V2DSEMoeMQ5JIGyYFBlofsyPITn6J3GbilT160q66WM7aoarNgQ5
xP011hdEJydhfU/FpIyXSBxlrKJ7BotLCVtc2jZhQ8PZyP7gm2IH8/4CVa1HI+hD
fI0RHOxKxophTvwzIz72XBfw9YyoQx9Pu12E+XqH4fFVo6rfheHh3ds0XjFJXT+W
Trv9xeOBDLbZ2uiKTCsa7MU2WI/cO7XBs+ijGV79jfWJjeT7gZvGVzvFxHuRyhDx
mzFX8hyTwtxCumAsCKVVKaZO6RlTIrhcg+gIlG1ntHszEQZppPwRZgvR87PlnFdx
llqFNhtoU2JGjog/QFlXDN/kUECBOLpiYuaVRbkTItUkCSacJO/E1ZQen0qNEVp4
K4Xxpm2AyHhcGGvhZXIuYSgFRKOi2njKiBoFHrZ3Zz9Rd2pvkFSwXPgFVJjW2aQQ
SaIwb6ES8gS30JRmgQ5t3jjlMM896T/UPD+gDX3t9a17Gzv9JMQ=
=Obbk
-----END PGP SIGNATURE-----

--BLIIcOJ3abqG6Fj0--
