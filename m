Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CD814D452
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721810170; cv=none; b=T11IqCH3HFzxlYUCn7iQF1UjrIW3maerspSzgZk+onVQQBrvLgnwcM8Rt/1/jAU4q2aHLfGv+OuD6AfCe3VMV6j5i1tm3PJ0d4zinUNdMkQiwbn3qkG2UQZTCxa4gzt0pBWmud8bPTNnNXhtlfupUI5KJdFkDD2UaLbRTepaPg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721810170; c=relaxed/simple;
	bh=9KI2xhzBHPYk/gUEwWMUo0YEa1Ah617aurZn4664dsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bd4rp/OpoTRfk1GBfUx+Za8UaL/xEvh7dT4NvV/fmpKEalO5fxAJw5+w8jGOLvR6a9FtwlCulNrbw+sOGVE9cP9PRFuOm3/P/A96s36S2oxuEgjmVvXtQtetNbaM6o/CG5q0o3LTT5nvcwmsCIJgRzOAoYnbzS6s1sBwbe25SWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZSEyLlFX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bRK4kRQg; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZSEyLlFX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bRK4kRQg"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 957B01140287;
	Wed, 24 Jul 2024 04:36:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 24 Jul 2024 04:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721810167; x=1721896567; bh=GR/Ri9Aegq
	QIi5fKAxleE+aobYOetxCS4Jpq44OqIdM=; b=ZSEyLlFX3h/g97laMXiTUYpCHR
	mLCdeywYnNqFF0R2pgC4FiHFaPkBNTlBiWa8qTTILDfRpKtbRrMp8xKKOYpA4EM7
	Etbx3/b/aHLm0hQhE5c2YtAgJdJxQJ4WwuKNqa64/I5GQCAFNCv3lM6HavvBFvbO
	vosqUAtsZt5GKvnVTcNuBLP6+/xMXa1Sfsb3REqZjasPPN4blDkMGXPiLeaDechO
	h7K4/g0IlPdL6ferQFNG+PXVE0qoT7YuGrCjLgP7qtzPlmDwlZpfA/XV/LSvybyC
	HolhUFNLxLuCextG1V7ELahOlNg2A5wrA3ZKnlABMqmYxdYtjiJiR5NSFzPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721810167; x=1721896567; bh=GR/Ri9AegqQIi5fKAxleE+aobYOe
	txCS4Jpq44OqIdM=; b=bRK4kRQgc0VsSywa2KiVTWMIVRxLbpQuIKGcgP2Qv0qF
	q++CiATuJsjiRKQO5R6PBRiK5hAtl0Ff4K75/ibbM0cSLZ/p9IgOGfTpDzTngGxN
	+I+hu7q62saqt7SIUZwtTtuAKiZ9qPQWX/+9Us2Y4b573oMgL1lsqJxqjiGpf86/
	H3aUcc4vTxxWbaRsEVdNpJ23R9WiuQc28AC26d6dPVg9Ev0/HlJumZ/tr093QDtI
	4oZknWQwdNlPIMA8SXYLqiXS0pE5rcN5qZcM3ARJdbKPcVb9PzsY63PLuoLtvC5s
	ZCJXDkGHbCkfhqckj3I7aVmYVDT7VeOpHI3fk+Q1qA==
X-ME-Sender: <xms:97ygZhJ193sqkkznQZXm2uLVSQoVOQ3SCu1AcifvAvmc1xShk8iKdQ>
    <xme:97ygZtIgGexci_zikDk7aD7LPTPTAIvotLK40bFj4JER1YlwrnWSuHP9AUeL9BCYG
    Gacd-Ll8_wQRU6PpQ>
X-ME-Received: <xmr:97ygZpv9J28iAV7Q6LkVSrEMnSPEEsaK7gvtXFu3HJGrlwZDVuTe9rE2HVxUqsOUyJ55y_puEbwGzGacGCu-0BvwfSglEv9l2PerS6Vq-Vj6cUSv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:97ygZiapp7upmlWruscPIdvuLFddXkoP6unZXnqnzDbOMXae1Q25bw>
    <xmx:97ygZobtpqdg5PdkpnDutLKQm-ERupNaPjx_mJqWl8VzLvXE19tCEA>
    <xmx:97ygZmAi6AdhKh2n3YU4qeILftYacrmwvGAR0g_A3Aea44Z2uCsfhA>
    <xmx:97ygZmZ01k9AatgIV4vxvx09-zENggmVx8m372RVQ5U58TeXg4CyiA>
    <xmx:97ygZgF0zq-5g7YvoDPbe9fOrDuPR89K7jjFMIRs_ThewAfdqZd8IkED>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 04:36:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id da812c1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jul 2024 08:34:50 +0000 (UTC)
Date: Wed, 24 Jul 2024 10:36:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 06/10] packfile: packed_object_info avoids
 packed_to_object_type
Message-ID: <ZqC89ArZWgaZWY7a@tanuki>
References: <20240715003519.2671385-1-e@80x24.org>
 <20240715003519.2671385-7-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2V7GbWq3GXFRe95X"
Content-Disposition: inline
In-Reply-To: <20240715003519.2671385-7-e@80x24.org>


--2V7GbWq3GXFRe95X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 12:35:15AM +0000, Eric Wong wrote:
> For calls the delta base cache, packed_to_object_type calls
> can be omitted.  This prepares us to bypass content_limit for
> non-blob types in the following commit.
>=20
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  packfile.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/packfile.c b/packfile.c
> index b2660e14f9..c2ba6ab203 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1522,7 +1522,7 @@ int packed_object_info(struct repository *r, struct=
 packed_git *p,
>  {
>  	struct pack_window *w_curs =3D NULL;
>  	off_t curpos =3D obj_offset;
> -	enum object_type type;
> +	enum object_type type, final_type =3D OBJ_BAD;
>  	struct delta_base_cache_entry *ent;

I think it might help this patch to move `type` to the scopes where it's
used to demonstrate that all code paths set `final_type` as expected.

>  	/*
> @@ -1534,7 +1534,7 @@ int packed_object_info(struct repository *r, struct=
 packed_git *p,
>  	ent =3D get_delta_base_cache_entry(p, obj_offset);
>  	if (ent) {
>  		oi->whence =3D OI_DBCACHED;
> -		type =3D ent->type;
> +		final_type =3D type =3D ent->type;
>  		if (oi->sizep)
>  			*oi->sizep =3D ent->size;
>  		if (oi->contentp) {
> @@ -1552,6 +1552,7 @@ int packed_object_info(struct repository *r, struct=
 packed_git *p,
>  	} else if (oi->contentp && !oi->content_limit) {
>  		*oi->contentp =3D unpack_entry(r, p, obj_offset, &type,
>  						oi->sizep);
> +		final_type =3D type;
>  		if (!*oi->contentp)
>  			type =3D OBJ_BAD;
>  	} else {
> @@ -1581,6 +1582,7 @@ int packed_object_info(struct repository *r, struct=
 packed_git *p,
>  			if (oi->sizep && *oi->sizep <=3D oi->content_limit) {
>  				*oi->contentp =3D unpack_entry(r, p, obj_offset,
>  							&type, oi->sizep);
> +				final_type =3D type;
>  				if (!*oi->contentp)
>  					type =3D OBJ_BAD;
>  			} else {
> @@ -1602,17 +1604,17 @@ int packed_object_info(struct repository *r, stru=
ct packed_git *p,
>  	}
> =20
>  	if (oi->typep || oi->type_name) {
> -		enum object_type ptot;
> -		ptot =3D packed_to_object_type(r, p, obj_offset,
> -					     type, &w_curs, curpos);
> +		if (final_type < 0)
> +			final_type =3D packed_to_object_type(r, p, obj_offset,
> +						     type, &w_curs, curpos);

So this is the actual change we're interested in, right? Instead of
unconditionally calling `packed_to_object_type()`, we skip that call in
case we know that we have already figured out the correct object type.

Wouldn't it be easier to manage this with a single `type` variable,
only, and then conditionally call `packed_to_object_type()` only in the
cases where `type !=3D OBJ_OFS_DELTA && type !=3D OBJ_REF_DELTA`? Not sure
whether that would be all that useful though given that the function
already knows to exit without doing anything in case the type is already
properly resolved. So maybe the next patch will enlighten me.

Patrick

>  		if (oi->typep)
> -			*oi->typep =3D ptot;
> +			*oi->typep =3D final_type;
>  		if (oi->type_name) {
> -			const char *tn =3D type_name(ptot);
> +			const char *tn =3D type_name(final_type);
>  			if (tn)
>  				strbuf_addstr(oi->type_name, tn);
>  		}
> -		if (ptot < 0) {
> +		if (final_type < 0) {
>  			type =3D OBJ_BAD;
>  			goto out;
>  		}
>=20

--2V7GbWq3GXFRe95X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmagvPMACgkQVbJhu7ck
PpSQCQ/9ErCvZ1T19Pk+gza2PRLQFDRLsl7YRp07rwBmPwjOAljAMWYS1r3q2ZiH
oZ847XQfoPZUjvEHA/U5P15xK7l6QqfFDhzNtH2JRfF/YVaf+lPC9/DLYDAOT3xO
gSYv02uBrW7tXEEyPitYgq3gs/a7SSzuO1U+KhfppeMtAaDS/bh797bpPE6oGDVi
MTdD8J1UuMzjmZEDPEOhf6s6yRsXqapcjdx00oD/Pn/DZl4whhsSvjRam6mss7gx
GLnHNdPh7Fh4GiCW4+Fm9x0+gfbLgpeyuE3IYGBah8MuVHJ813zw6O4gHXTsYPZ+
KXxHoTPcEm3SrhKfNgIOR4jGzjDVf4BC4AllxGXxcHqFh2mI66aQ9d42vPgbHvGT
AdVz7p1FBrZCaVKz6sKxKW6c+v+3WNCPNYBUZKS0EAfoi2A+KdJyhyhCRl033bpd
shKfW6C9VGtOCSbqIvLgtqF9nW+YkEynfDtjrH2B4/JfEsMYQq9OAWzRV6S5Yr3a
JC8qbnhbHf3s1TgAcYtzXDE9kLlgwbaxy3XklwmRhA+D3EfkkN898uD3ZGe1rBco
JfMsK3ST/svzJ7A6irPQfcynr5OH/M+yrnGJ1oiZAJxWscQcdgggkZj4zxGm/qZ5
rMH4FYtrhypK6/zXHOKoyMhbSmpXKl+pzwc2bKDah98XhMbcnJc=
=gW4f
-----END PGP SIGNATURE-----

--2V7GbWq3GXFRe95X--
