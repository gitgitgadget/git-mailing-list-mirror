Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBA42E639
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669728; cv=none; b=KEe/wMzNIp2q9JGVcoOhI7b1Ss8T9p0qxbOH3nJA9a3lCfaO/rSAvya5Ex871Ghttj0vpZM2FZ56gBb7WjNBSZ99qB8vUJhf2B73yLPg8P9K1CXZh5B/DxHrod6ZUOp7hjXAh3QBRrRS+kcXTwZrGIcUIiVZpJaT9iehsEoKWAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669728; c=relaxed/simple;
	bh=2Lt+rbiFO/tcKIyI+uVBiFMTTcW2r2yhmKFxnum3UPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSmVJZJVWBDmW2rG8RmAFDdbV3zPJbwlzxDbMpgCrCxp++kgFvRNHklg/r8MMkmFlnQevvwJwx2GFKDeuCykl0oS4nlLnQ+2ZjODf7UMO8flegKmM72KoDXedn3sungxDWoIHrV02bmxR4kXvhQ1nTEbZ+3QIhU+akOWmouPB18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CdkGLmNr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jzgrPaJN; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CdkGLmNr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jzgrPaJN"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id D78DE138014F;
	Thu,  6 Jun 2024 06:28:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 06 Jun 2024 06:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669725; x=1717756125; bh=jHSS9MXVTn
	VzYskIe3vCOI77kMRSOs/D/5SvkYBKsIE=; b=CdkGLmNr94aKyLZBzbr/hFRySg
	HRhfCrxioXN3LIollYr7doKG7zp4FOURDD9lnmmd5Rg6D9BKMB0eKZGUrH4WMGm9
	MaJRa6gNE4Qiqx306/SxYjSwuuGnbtGisX2j7HBXF6mRbNO33FT/LJTgFPCz+a1k
	8wLessHdFcB8VGB5rimLXHNeL7qlEzRMHK/g0dczgulf14VGeZzairI8oaRNQVoq
	7GUT/ImHg/WkJmUVkvaqam20Ty/9LjsksQ21xY25rli/R1bGpeqrwHTl62svrjuM
	JFB4XebTJuxAX+Fmeam15PnHFnoOKIkON+DmZLEqt1kTq+/VxVZgIcJqh/EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669725; x=1717756125; bh=jHSS9MXVTnVzYskIe3vCOI77kMRS
	Os/D/5SvkYBKsIE=; b=jzgrPaJNAe6p6oIDg+4yBKUOG58FADqyPHe6XJQAox0t
	ai0fVCVVLs3c3tFz+0H7OubrFXn9NoMQlz5Rjh17I6jVKr8W9Ze42OZkMBKv6UXy
	3bJJr8OvidFdumdzIrmyAiRes82JXlfUNs4f2pHbMNP6V+lC+CI9WQEpDor7J/IO
	ORy0yQrzFNwG1R+rVcbQ0Ina30VH2mbhW2XB8D/TlHWDWwRoHjY68Innd+UG3zey
	Rrf/KmHRKCiXSu1VU/UjrLQu/uyRm2skPRsjvYSblcBlBkYIxlvq/bX8YxDoyGJl
	Qs6tP19wvth2ImgCprxRU+axChRmln1hiJIHHZhbww==
X-ME-Sender: <xms:XY9hZp_pIonkydEZoPE2n8Dk5dE4uWOIbVrMVucmiYAq3aD-BJnYUg>
    <xme:XY9hZttuTErLnNlqii74TdRLPWBNsqZGkZe7Jq69c-wG_XQWCWBu8VM5P0g4bREWG
    4qO0osZZ1JOzIKTXg>
X-ME-Received: <xmr:XY9hZnBNaGFgNjuAuriK2vNsS8Fgm5MiPQwd-XnfNuvsWvPQ-Rii7MTsnaP9245pC9Y5lupMmiGg6V0vCaqFLo6YRh6O5IRx9aJCe6bO5iL9KDWb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:XY9hZtcEH_daN4FAkQoI6DQFaXnhpTdwiVYzqR-WoQrBfFaet_aAwg>
    <xmx:XY9hZuP9BTvP6TLY7P89CHe_UGnWLaBE1irem3zim_TIXvlpwL_peQ>
    <xmx:XY9hZvmn0euHiO2kqER2LgcaSLWiwRUlB7PJJnQL6GLq_WeQtfsfpQ>
    <xmx:XY9hZovMV_93AQP_ylr5mAqIxsAyQYjCPWdmcJjx6_3j5mPQ0LQFQA>
    <xmx:XY9hZrpBZKxtj3B1d8Fg_gB0epS8ugyaza9NgUmGx9M6feVsy7Kwwv9D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:28:44 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0f30e96e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:28:13 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:28:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 12/27] object-file: mark cached object buffers as const
Message-ID: <5cd014c22cb2fc7e34666aa6bd036d3cc4ce9039.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4xP8bO2zK+Teeu3v"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--4xP8bO2zK+Teeu3v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The buffers of cached objects are never modified, but are still stored
as a non-constant pointer. This will cause a compiler warning once we
enable the `-Wwrite-strings` compiler warning as we assign an empty
constant string when initializing the static `empty_tree` cached object.

Convert the field to be constant. This requires us to shuffle around
the code a bit because we memcpy(3P) into the allocated buffer in
`pretend_object_file()`. This is easily fixed though by allocating the
buffer into a temporary variable first.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index 610b1f465c..6309b24387 100644
--- a/object-file.c
+++ b/object-file.c
@@ -277,7 +277,7 @@ int hash_algo_by_length(int len)
 static struct cached_object {
 	struct object_id oid;
 	enum object_type type;
-	void *buf;
+	const void *buf;
 	unsigned long size;
 } *cached_objects;
 static int cached_object_nr, cached_object_alloc;
@@ -1778,17 +1778,22 @@ int pretend_object_file(void *buf, unsigned long le=
n, enum object_type type,
 			struct object_id *oid)
 {
 	struct cached_object *co;
+	char *co_buf;
+
+	co_buf =3D xmalloc(len);
+	memcpy(co_buf, buf, len);
=20
 	hash_object_file(the_hash_algo, buf, len, type, oid);
 	if (repo_has_object_file_with_flags(the_repository, oid, OBJECT_INFO_QUIC=
K | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
-	    find_cached_object(oid))
+	    find_cached_object(oid)) {
+		free(co_buf);
 		return 0;
+	}
 	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc);
 	co =3D &cached_objects[cached_object_nr++];
 	co->size =3D len;
 	co->type =3D type;
-	co->buf =3D xmalloc(len);
-	memcpy(co->buf, buf, len);
+	co->buf =3D co_buf;
 	oidcpy(&co->oid, oid);
 	return 0;
 }
--=20
2.45.2.409.g7b0defb391.dirty


--4xP8bO2zK+Teeu3v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhj1gACgkQVbJhu7ck
PpR2eQ/+Kkaz9W6veKNu73KSmyFjTAaR8xN1bL7T72vC8DfrE+Q0Hfhysc8XFwAx
iXhbsexq5mAdt9oNBMOjqcU626kr/sZYNs7XDnwWJGxsfbGFSMaDYc7BOHZHcHYn
O+qkLJh2oEZsZthmZQT7aCiPvouG2ySB4qRZYgLTfKxF2B5+tnefM/NpJ1twmvmH
z0dlA6WrcHoS9bRw4cN3wyEB5lg+Bk/klyZjActg+EpndHq6mV1UrQ3HrJaCnt0v
f9KjouiXYJwIoO5L5Z+9Ar1ar/IQAajFFjkOI+Xxc9vJQWWKVNsU4CG8PrABjBfv
aU/tB/OJWxz7av8AyjoVS77xLttfT7KfnK2dFo0yGqEmHjWEom2G1nOKiIHvHU+g
ISnTn6btvKOFA8wRV1BuDCcM4WpO8zCRbE5BJtiEBvBooCsTkwh0WQAkvnplEZje
ScYB0cR4w/lxmXFNxBRq7EvhqajGXZ7YgRbMgf8SU8VDmcGHCz2XS+H63wnHmieC
EIz3vEdeAAGx1Jm+1FG20OshUTwYaaPJCS8AH3ZZ805UHIF0JVLtU1yRdJsXmKhv
4UUzoLfjRKfrLcH+knfxaSG4dzYKZpQnjTxeRWgIChL4sYEAByfyugQd35Q5M+qW
BNvtdxXyso7iviozkrij2NXzyx8Yj9hswoGmvVU1yc4Zl6OkzFo=
=bFXp
-----END PGP SIGNATURE-----

--4xP8bO2zK+Teeu3v--
