Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA6884A46
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407027; cv=none; b=AqCW9ugn05hIXQv9QyT3CX2So0p4XmH7PNzLqWisUz8XzJt2bkjPXSA1cZFXOk0O8WuNpm45CISLuipmjNeHPSqacbvuBibPU71GsDPHVz6QVVNT1QPlxtMG4KP5qDEl+PZB8IYNMzfP/suXV1BgDIZjpnvS/QLTWfp+8lbUdPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407027; c=relaxed/simple;
	bh=vZr9FW+2RtV9EAudWS76arFIqwIcw+p3c3Dj12uvrlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4u0OLJCF+QxOKu1Lj5JwDQ1WD9M3TIuWHCbloAAMkbeM/FH/R1big43EY1JoBuNA+84vrpCfFXL8LsXbGI/zYn+17KH3OUN2/5s/z+VwA6pnwDcsE1DigiMX0JBXh0WftfFG5i2oEn36efrS/PaBRtV9s20PgDU7wjphkUE7XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EK31Yb1t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nd6RBxae; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EK31Yb1t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nd6RBxae"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 162411C000E6;
	Mon,  3 Jun 2024 05:30:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 03 Jun 2024 05:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407024; x=1717493424; bh=rLwfBhzCYs
	71jUnih0dEOJgsfG91Q4I+a8+qzlSkMFQ=; b=EK31Yb1tJZzemMIwfqa3hc0jXR
	2ISepj8CcMNE8+XJpp0AwshN4CyWhoqijrd0ER5YWDjOB/TNxc4k2R/PdZxXI3XX
	qz/g/0nKNqAyhMGIf/qSef0C0YPKvzO8aSt4GRdQmY4ubwRokRyYB/HVCMibtz5f
	e1+pE21Wbg757RKjrrECrwMT5qrFgCwGrfGIe5XLxY5L5/tUdAJPE03XiqXnpjtG
	DkLNwtT+OzoiKKktsXyw/8e5uN+yLqspihSoAGVLAiyyU1U9sf5qNEFOJgE11IKG
	ogazsmRKaNmnCzoiNDq99Hg/aPPfNzMcRbkai9BVvakZxr9Kyjz8mSQ+m15Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407024; x=1717493424; bh=rLwfBhzCYs71jUnih0dEOJgsfG91
	Q4I+a8+qzlSkMFQ=; b=Nd6RBxaeuWH8HSURCeqiL56aVgpJMSyQzVCi8U7LKYvV
	4a02UdEFaqZ8j+U/BRVIMDyZTRF3YWjAebSohaC6b5GrNiMw/mMK2T0F5sbsDBDO
	YmqLfPUHTsb1Bp+IvDUQ0K1fR+u7tJhVTgw7HlgkEJRkxrlbY4aKSeqyOSq8o+3i
	xj6RHi3BQpl2bKHzmN8GSN6JC4QkN2MRHQSjFrSsbk7NdJ5P4qLs4NsIIMm6/gpU
	uuSjV6WE6MSvsfLaG6zMedrqEl5G8zIVqB7UxOZUTIqOaO6o0GHtJkcmS7sxnMgP
	vDQHKbWccfCp01CmaXDxN2/j/MAUOYitDL+qQye6Xg==
X-ME-Sender: <xms:MI1dZgqEVfWWEXAYkwgXEK4okq6CsjacK_l-IUN-dQTBic0ud5t_XA>
    <xme:MI1dZmpQOPciqWAtgaEbpdlL8y2W8o4Oe31EivlEW5coO6NEkJ7UKd9qeDMSt54AS
    cNt9_zANrfL2X7Q1Q>
X-ME-Received: <xmr:MI1dZlPRUeD7Ss-tsQhE6HPWefCNobUwTYLcKU7Bc_jiNFS1pNU8eTVw8xWqDH75qVdRChUdxT049nz4WtMlaWzR3IDRc8TmVmgKqkkp61aXgLbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:MI1dZn4eTjyCy0hPughWy7Z9lZJESklkAfflLKXxW63O8yVRiNzQOA>
    <xmx:MI1dZv7zE3nlom_Sv3K8WfrYA6Yv0278ou2zEXHML4zEla-obSuPkA>
    <xmx:MI1dZnizwy0sojjhajBFdbj1KGcQ6xTWFLOFIfPKIyjnMRO9CHYpog>
    <xmx:MI1dZp7LzkTQ70Y5qrxaOXiFMSBQh6OMpi1nr2Xn_pCMqLjTiWe0Aw>
    <xmx:MI1dZlSn4Tj2ez_a_59P78MUJMkww-7BR-p8RaypwqBf88PZ0KqR9TUo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:30:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f8bb14b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:29:58 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:30:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 03/12] refs: pass storage format to `ref_store_init()`
 explicitly
Message-ID: <7d1a86292c205bb47bffa93aa293a3575836f9fb.1717402363.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="znd/IBRIvwSQtv04"
Content-Disposition: inline
In-Reply-To: <cover.1717402363.git.ps@pks.im>


--znd/IBRIvwSQtv04
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
2.45.1.410.g58bac47f8e.dirty


--znd/IBRIvwSQtv04
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjSwACgkQVbJhu7ck
PpTEJg/+Ii/lvbpNIIB6mY4IapQfI2uk2jFto0tchtkLEAubo1bi+EkPvpnQjAsP
LhpryXjTFs+mtdsE1hbOVjviEwSaUyfHe2Zyn4gABPQxDfTvbtQAFE5B4u/d9+SD
p8uwMpSn6McEAH4pOV1lcXIfnuqXKgE5pGZq7kcKATBkQeZXc7d70ROBp8FJxjXU
lPofRYhWmiUGDUtPnW4yeY+lskjhNVhcR4CnvQseV9J5NU6NyLtO6vfjCfla5Pqt
/56aS4qYSWHsHvnGcjLLfxo3wVzVDE0lEKk3t7bpTEpBZxOEJ8RrXZHdAbcR8+GH
iMB30OWmVRRN8swdX/ibdlHPIOXhM6DH2rz0kNozqp4loLqst6BW2t6ohokbtlfT
5WpyjewUhTdbdnsGkY/LU1idwk7eweUJE0QhD2BglEBiFRrpFn453pzK0/VA8/6u
DpuoCfSuvPAjYnHMiOebEN3Rgt7AVWX7357xuuKzEqtBm8sDv9189+1zNZ8VnWyD
rJ4gHKyF4nh5BPeVOzwxS8KyfNjqkobTHwwNK8x3svAY4uE6b5z/RkWia2ZARMtt
3LoA01qwQ/g5QCc0/dLTyaV1wAcIDJ9ceQ4bjEeap06rAdSSpSMX7A+2ochE2mla
LNpNPVM9bxOrBQb3G+TessrYisTeRO4rEs+FnaZdcaIMInEaZbM=
=GTrA
-----END PGP SIGNATURE-----

--znd/IBRIvwSQtv04--
