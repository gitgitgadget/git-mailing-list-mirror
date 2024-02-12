Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C69112B81
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726778; cv=none; b=JfGxeJ6aydjRw9JS5gGR/NFxyDniX4BlCY0eKSce9ibHqLhf+BKxkZbCvXdNgKpm6yLnbp8DB45gMB+jaqSZpgmPoqbYIlRLkGnXBgRWK68zZPs4vugZQ2m438Hs2cGU8CkDXXO4fKM8v/sYZQNLC4zVo3KwZB4TN+OZexOg/yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726778; c=relaxed/simple;
	bh=aiQn5198zMQXbcbtBwh+KZT12MqHW3jKcIQ7U7tHsfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f457xdPuSS4LuSNCk/pGzeMh/U0gHHwIBCT8aQAuwm1S77hm/s7zfWax9SxEQWOyDTdZHlBA1YuxgczTJd8JS0yNbYZy9VL+bxvfXsTUnmoiM8t6IxYZcypWsgGRQMBs+pgwaXiWbkJjOMYYy0uj0jAklYAtNN8T+8EEs9RaA2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gZ3syMPi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dnwv1y3l; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gZ3syMPi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dnwv1y3l"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 8A0085C0091;
	Mon, 12 Feb 2024 03:32:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 12 Feb 2024 03:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707726775; x=1707813175; bh=0nPAyquOxv
	0qb5AJNxVdLotcWcQPSDmvSVu9DN36bV0=; b=gZ3syMPiQmORvajvfHKXbAOFAW
	R6lC2D+c0gA1gUz9rx1IsE/uMdHu37U7doazAycH3vWR/yEnaGsWWxuhpqM36n4Y
	NyTCcrZjFnQXdL79IYcgnyWGQmp9ja+13oU7zUpC9JBiNyNdOEb/w54AmI3lJFaR
	SZKXIu9OJXSZEbwuD9dZ6T+F5ia9f5IjjwdJjhHvsNUzW4BNHb7CGESoydEUCw56
	FxxZK3tPTXgRpLjmHkUWCDj9hqKRrJPYMQRbALzMGFj+4hImK1s0w6LIcf5SMGof
	wnZRndMup1mu4cQHtSr++FOrSMAdhziuE5TT5Mnujd1D5UN5febiXsJs0tUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707726775; x=1707813175; bh=0nPAyquOxv0qb5AJNxVdLotcWcQP
	SDmvSVu9DN36bV0=; b=dnwv1y3llAqC2aQJucOqHQNMKpnKDtBElfbDbsm4Y6Vk
	OGHgKxHLUy00CiYNldgcjwoN+lKEwiz6LX8AKHeLDFzfYFCqATTOtB9hnt9eyJ0V
	gFTYXsoMxbgFXVju6lucSWneG698FUyHL+pszCrrG2lMKi+4NtjFkYa0fBdUqBK2
	wY5A9y85rZ64lxIjljmzwC0/eKwm45UK8BKBmINaz3aDC7xVcNuQcUwzJlu1FWSk
	m/RqRwc2qJZC5rOknGThS0BwPRi4ZGrpAq7Av/gRNSbMHmatxrVaxYz230Xo9LLl
	CqE15uGUHV4kaxk49tywTnVU48GI+qO0zjZswjUVWA==
X-ME-Sender: <xms:t9fJZXIdp1pg82SrydFt0dr2tAz3ro656qo0gc-nCJMY-rbI08VjRA>
    <xme:t9fJZbIRqgapj3xId2jrqDZ3mE87maJhc-FB43Rz27ICnkUf3781QKwG7PbG1vUql
    UEnpo-cIGmxGtuY3Q>
X-ME-Received: <xmr:t9fJZfvMx0XZNZ10-U-eI0z3lwrivfszPuy88Yw4d3pGa_sIz5GWxzAaNxOQAR9aFvrZ1_emxSWwE5VbzUBdp9c9npkFaBVH76r74JfmZBPD0w4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:t9fJZQY1gx4EcFELOXTSZOrc_zMFIkand-WyzEAz1rH2Ptfotb1jrQ>
    <xmx:t9fJZea7TDGBMEFBvvTJN9j-Y0Ysk1EfpOMgHMletfhfYpugdNMHyg>
    <xmx:t9fJZUBBaxv1-58vkY2cBeGQlE_qrgvFD1mSEICWXqMf0stvLIHhmw>
    <xmx:t9fJZdkfocJ-2-KAVpF-ytvNtfh5icgeuGVE4YhzXeeWpyXAtJfbqw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 03:32:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cd974518 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Feb 2024 08:29:08 +0000 (UTC)
Date: Mon, 12 Feb 2024 09:32:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, John Cai <johncai86@gmail.com>
Subject: [PATCH v2 6/7] reftable/record: don't try to reallocate ref record
 name
Message-ID: <8c674915044c47c46c8e4efcb4d914fdd26e5c55.1707726654.git.ps@pks.im>
References: <cover.1706782841.git.ps@pks.im>
 <cover.1707726654.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Rb37tixYEYRTinwP"
Content-Disposition: inline
In-Reply-To: <cover.1707726654.git.ps@pks.im>


--Rb37tixYEYRTinwP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When decoding reftable ref records we first release the pointer to the
record passed to us and then use realloc(3P) to allocate the refname
array. This is a bit misleading though as we know at that point that the
refname will always be `NULL`, so we would always end up allocating a
new char array anyway.

Refactor the code to use `REFTABLE_ALLOC_ARRAY()` instead. As the
following benchmark demonstrates this is a tiny bit more efficient. But
the bigger selling point really is the gained clarity.

  Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
    Time (mean =C2=B1 =CF=83):     150.1 ms =C2=B1   4.1 ms    [User: 146.6=
 ms, System: 3.3 ms]
    Range (min =E2=80=A6 max):   144.5 ms =E2=80=A6 180.5 ms    1000 runs

  Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
    Time (mean =C2=B1 =CF=83):     148.9 ms =C2=B1   4.5 ms    [User: 145.2=
 ms, System: 3.4 ms]
    Range (min =E2=80=A6 max):   143.0 ms =E2=80=A6 185.4 ms    1000 runs

  Summary
    show-ref: single matching ref (revision =3D HEAD) ran
      1.01 =C2=B1 0.04 times faster than show-ref: single matching ref (rev=
ision =3D HEAD~)

Ideally, we should try and reuse the memory of the old record instead of
first freeing and then immediately reallocating it. This requires some
more surgery though and is thus left for a future iteration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index f1b6a5eac9..6465a7b8f4 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -377,10 +377,11 @@ static int reftable_ref_record_decode(void *rec, stru=
ct strbuf key,
=20
 	assert(hash_size > 0);
=20
-	r->refname =3D reftable_realloc(r->refname, key.len + 1);
+	r->refname =3D reftable_malloc(key.len + 1);
 	memcpy(r->refname, key.buf, key.len);
-	r->update_index =3D update_index;
 	r->refname[key.len] =3D 0;
+
+	r->update_index =3D update_index;
 	r->value_type =3D val_type;
 	switch (val_type) {
 	case REFTABLE_REF_VAL1:
--=20
2.43.GIT


--Rb37tixYEYRTinwP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXJ17QACgkQVbJhu7ck
PpTtqQ//Tpbki4LTOHlMOJwAtNYzjDAYKsQ5PUMHwHu4J7CJfAhiUWjgzLGpcMOj
Zc2lKTEfBwpWe+YxrGkAlRxiMStgSgmvEAzYsUYaYMJuyurUHjPJNtCWPppAICbf
5B/Z/dk5hcQMR5eZqhu8JKNk2qvtctGgTZYDnmwk81ZgLbB2gPZBGcvhkAvhm/IX
6s1bDc4WRBGy0QoBHdQ2vKvmO5A5aWdU7I1tZ0Falk3vw1Rls+dCgryStKzQ8reG
BaG0iDVIe6/TIiZ0aWnZbGjTECVwnt5pqZQGr4tCAX0rcuWC1UUKfs3g1RWUoPmK
ZmdXGCqgfCr9ZeykhOfYCrLNaefvuvtUCiwRuYgK6SSFD+Pjy2UjilzPBtSOwYS4
KAnr+RZ4PdoZVsmtETD71Oy58IGXUw4Qrj+EcbcylN/RBuiU8W47WCcyXJevHIIx
jn0Q9+nvC++PUvzlbhAoyA5MQP9WoMGxPe+3zFPt4pAWmFBGOJHJ++dxyS60/mqU
nQyumddVEzUGG+LZ7DCIcDKBgDo3Bn044DgMbJCe5G03zxFfwaFoVwdJ2BvCYuIf
A+QsLSr8SDbyEmDFZSX19U2WGBQ+j78Npm8Se9053WfC7gfld90FkgDoVEUhL6hd
dW6ptQChwTNl/jFGFKYVY9cU1GaLxgo1Irl0Gp172BNrsrHJ0Pc=
=Ymz2
-----END PGP SIGNATURE-----

--Rb37tixYEYRTinwP--
