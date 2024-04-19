Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7C5745D6
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519656; cv=none; b=Dp2DeisvQpU1O+hQVN2kQYa9+OyKhDA3qBe1y8uIUmTIzt2vLu7D+m4PNShSwoTzCqZ2emsUfFNBtc9dcW1Mj/GCX1eJ5OGHH7QcXHiWoMFn2tmCkVLbSKmsYSfwLmDET2nnBQyL3pI9M60lJXC1iB+cQTpWXSyXpPvN4GwDFAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519656; c=relaxed/simple;
	bh=OSCEZX0geOu854XOBtJ1aXWYFUZwk4wurp5iik7L+Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miteoB/W9QbJL4k7pq20J8aspb5QYvRq3CZydUcPvdeS2Qvb8x6S3iWV4aepQahjCEjm1W1UjWslmLjJ3NJlz8O5Uu5BeQwQcdudQPY5EO7hZHwPtOcTWu/5GYu73dBvh4Ur5Moh9DyjSZf7Dz8395ESgp1q8+W5yvSSf5wjbNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KlEMlBiy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kpxbx9Db; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KlEMlBiy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kpxbx9Db"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 9BAE71C00114;
	Fri, 19 Apr 2024 05:40:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 19 Apr 2024 05:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713519652; x=1713606052; bh=KHqKaA8qvK
	ZE1LLt+WtP9HRzkcIFfwiltxyUzyDoO6A=; b=KlEMlBiyl1OLlFJMUcIbMuhRmY
	N89XGBf/6eLjA9Z/X6SJeYkJT9xcxLQpeJqGOiNdWcY4767ashnMA1kJg0XUFX1I
	tOUbjB/OGR2Rtlv0XcqscWTFItGkUaWrHbFgO4/81h0wwrTqVy+uR9EZFb3wOHsi
	fP/TR5gMyQZJ10J8LPf9IUnJ3Duw0ehnIubFo1Iv8P1mDGnY/OrWHjmYFptzII+y
	Xt4Vgcomr/hgXPuHV8Szj6xfx2o1Q2ZNFHh8u56Sg5r6zxBsxuu39GrV9Kq/hzkZ
	n7/aMwpYjjhHPyx/s7adyDNG2xCT4e5Gej2c5TrnrzTfIY54LTlt7Zo3Nnvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713519652; x=1713606052; bh=KHqKaA8qvKZE1LLt+WtP9HRzkcIF
	fwiltxyUzyDoO6A=; b=kpxbx9DbCeGE8mXEK/QehxAg4MKvWoVnMiVkLMhunnu0
	f1/hMhKHsHAsXO1uRJ23oIFusVAfR0YD3zWcw3TO0TXtpst1VW5nwtQNCJ90IkRN
	ABd0S3D+RkYGKwzZRWKSL6KhRKUifyB4XZo2IWogvJHVjEbCzugzwpUQ+FFRdLVa
	R1YYYnMpyizISQy9yWKdEd+Yq3gk9om8PrKoYAim/T30bVvq+d3jMmKejHqGkZUz
	PSwUMD4fblKnoTazFbsgz2bovoVkY2dwfZM5skP7EsSbrxkdsF1Yy2IJ3gA5HIuc
	UXdzLOmknMIqLBh1FQDEPECG/kzdR1e53kjcT8MujQ==
X-ME-Sender: <xms:IzwiZpl4m-yx5e6O8y7JVgVslTaWCUNfQUkNvxXPw55u1zua-TrgRQ>
    <xme:IzwiZk3rjY_m160v7SthZfyaivVf1htQg86fM4jQEYsmihccjllvlm9jhjmB1gctA
    u7VadM1hYLoNEbEgQ>
X-ME-Received: <xmr:IzwiZvq1MEnxKfJba-jeeyPOpueQizxyr4lvrEcj_W2Ihbzk11d8Bdqi028Vn2aPHZ7d8uty9F2TNhNfPZNWXvgiVTYn8jeYTQwVlo_G-OAq1uve1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:IzwiZpmDl8DsdMH3f-fzfBe-CZdE0zbioPx1_zhlU1DS4u0Pr9ottw>
    <xmx:IzwiZn1CDlz6sLjmJgFl7v0hyVxhpFWxjgZun4cHybnUrvZZA63y8Q>
    <xmx:IzwiZos58TMiDdCiqjihfRdodULU113E3eranBxFKsYu5DQjUaqCkw>
    <xmx:IzwiZrXzKeB6yVGetIfNeopWxDqbQLXOSVnBgoPl30vn7vjJhmzx8w>
    <xmx:JDwiZiRk4OxPu-vbaJ4Ulz4ikG4L_repR-9ZSBiGu1uOdVPOEWjeCJgj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Apr 2024 05:40:51 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 64ce13a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Apr 2024 09:40:24 +0000 (UTC)
Date: Fri, 19 Apr 2024 11:40:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 6/7] update-ref: add support for symref-update
Message-ID: <ZiI8IFdfBHEqr02C@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-7-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AjbMZRvjwP696MYi"
Content-Disposition: inline
In-Reply-To: <20240412095908.1134387-7-knayak@gitlab.com>


--AjbMZRvjwP696MYi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 11:59:07AM +0200, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>=20
> Add 'symref-update' to allow updates of symbolic refs in a transaction
> via the 'git-update-ref' command. The 'symref-update' command takes in a
> <new-ref>, which the <ref> will be updated to. If the <ref> doesn't
> exist it will be created.
>=20
> It also optionally takes either an <old-ref> or <old-oid>. If the
> <old-ref> is provided, it checks to see if the <ref> ponints to the
> <old-ref> before the update. If <old-oid> is provided it checks <ref> to
> ensure that it is a regular ref and <old-oid> is the OID before the
> update. This by extension also means that this when a zero <old-oid> is
> provided, it ensures that the ref didn't exist before.
>=20
> This command will also support deref mode, to ensure that we can update
> dereferenced regular refs to symrefs.
>=20
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-update-ref.txt |   6 ++
>  builtin/update-ref.c             |  49 +++++++++++
>  refs.c                           |  24 ++----
>  refs/files-backend.c             |  15 ++--
>  refs/reftable-backend.c          |   7 +-
>  t/t1400-update-ref.sh            | 143 +++++++++++++++++++++++++++++++
>  6 files changed, 220 insertions(+), 24 deletions(-)
>=20
> diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-=
ref.txt
> index a5b1f42728..9710c9bc78 100644
> --- a/Documentation/git-update-ref.txt
> +++ b/Documentation/git-update-ref.txt
> @@ -65,6 +65,7 @@ performs all modifications together.  Specify commands =
of the form:
>  	create SP <ref> SP <new-oid> LF
>  	delete SP <ref> [SP <old-oid>] LF
>  	verify SP <ref> [SP <old-oid>] LF
> +	symref-update SP <ref> SP <new-ref> [SP (<old-ref> | <old-oid>)] LF
>  	symref-create SP <ref> SP <new-ref> LF
>  	symref-delete SP <ref> [SP <old-ref>] LF
>  	symref-verify SP <ref> [SP <old-ref>] LF
> @@ -89,6 +90,7 @@ quoting:
>  	create SP <ref> NUL <new-oid> NUL
>  	delete SP <ref> NUL [<old-oid>] NUL
>  	verify SP <ref> NUL [<old-oid>] NUL
> +	symref-update SP <ref> NUL <new-ref> [NUL (<old-ref> | <old-oid>)] NUL
>  	symref-create SP <ref> NUL <new-ref> NUL
>  	symref-delete SP <ref> [NUL <old-ref>] NUL
>  	symref-verify SP <ref> [NUL <old-ref>] NUL
> @@ -123,6 +125,10 @@ verify::
>  	Verify <ref> against <old-oid> but do not change it.  If
>  	<old-oid> is zero or missing, the ref must not exist.
> =20
> +symref-update::
> +	Set <ref> to <new-ref> after verifying <old-ref> or <old-oid>,
> +	if given. Can be used to delete or create symrefs too.
> +
>  symref-create::
>  	Create symbolic ref <ref> with <new-ref> after verifying
>  	it does not exist.  Can only be used in `no-deref` mode.
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 24556a28a8..809c1c7a76 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -238,6 +238,54 @@ static void parse_cmd_update(struct ref_transaction =
*transaction,
>  	strbuf_release(&err);
>  }
> =20
> +static void parse_cmd_symref_update(struct ref_transaction *transaction,
> +				    const char *next, const char *end)
> +{
> +	struct strbuf err =3D STRBUF_INIT;
> +	char *refname, *new_ref, *old_ref;
> +	struct object_id old_oid;
> +	int have_old =3D 0;
> +
> +	refname =3D parse_refname(&next);
> +	if (!refname)
> +		die("symref-update: missing <ref>");
> +
> +	new_ref =3D parse_next_refname(&next);
> +	if (!new_ref)
> +		die("symref-update %s: missing <new-ref>", refname);
> +	if (read_ref(new_ref, NULL))
> +		die("symref-update %s: invalid <new-ref>", refname);
> +
> +	old_ref =3D parse_next_refname(&next);
> +	/*
> +	 * Since the user can also send in an old-oid, we try to parse
> +	 * it as such too.
> +	 */
> +	if (old_ref && read_ref(old_ref, NULL)) {
> +		if (!repo_get_oid(the_repository, old_ref, &old_oid)) {
> +			old_ref =3D NULL;
> +			have_old =3D 1;
> +		} else
> +			die("symref-update %s: invalid <old-ref> or <old-oid>", refname);
> +	}

So we first try to parse it as a ref, and then as an object ID? Wouldn't
it preferable to try it the other way round and first check whether it
is a valid object ID? That would likely be cheaper, even though it may
be premature optimization.

Patrick

--AjbMZRvjwP696MYi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYiPB8ACgkQVbJhu7ck
PpQkKw//SIkO8mF06WUvt2cqNld8wPYQxm4eFa6XSYJeGY6oUrffHPFvBOvp3hg3
h1Yyyqj34DUayKsuq5HONNXm0pB7fqmuBNG6fCn9jmNsNwgz+ZhOnDqWD2u6SGJD
PQJD53oTlkSEMQmQInQLdb5YfcoNd+tKJJgkBQTX6N8LitwuQiRIAcM7lRbjRveR
1E7rOGz6xwYdCc1XBdK0hng340gPJJ1idzA0QeyZBHwlkH/rDGynT9p7VnH64Gi+
uqx9h9ynzXDGcgCn2c9eAyDSBgKQ+4w0QIF/k+RqklpZKLhmZmiRblgDGo3zmypD
W4rZuN+gWiGFmoykpn9bktF6l+71UYLHJuNIbsr05pSJ+1wl5+0mAOrht4Cim41Y
ij0OQ0iJigM7EWcFD41fsVacw/2EIrPBidIvYcty99LILJlgfAGsQe7a1Mjs5a59
2KeFIpoHwX1Y5v6gokVJ0lZ5A7OGz8ap0eAUSNfHJvlps4YmlcD4I56jJFB4B0aj
T9vI4qyjb0QG1SRK7oDRk0NqMt/jtDz7L1s7wgOFiZ0pXJLXYvSbs9RzXGwpO3EU
2nAvonZrVVdUX0wqwXB2rnR1wtt3VieFBfBXNwNjyV6OvHyX1Dm8xcCmBN7L1JFE
uX70EE8lW6retAo8b9wRNO6KFXKB2/P/Q8zTXMs/m9DN/1p5MoM=
=CQSU
-----END PGP SIGNATURE-----

--AjbMZRvjwP696MYi--
