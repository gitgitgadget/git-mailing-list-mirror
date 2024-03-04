Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E9922EEB
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544251; cv=none; b=GENf6gH/naI7yA3u/qC7ixx03C65/MpVxSR8nYwp/8su2I1GWjLPyKl4Za8Q7YA9aImn2gbZzX9P6QXsH8pkwK4SPso+UKu0JP9XZumRPY8FiT5ln99EcsHi1n8AfvurL4hfVJURpgGbJdlekyXi1rW8kx8Ql3yecZeHAu2le0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544251; c=relaxed/simple;
	bh=hCGUvHbDz5C0EvZR0J8GIrsqnjt44YzfM3A3Ec6bIPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvqgN7cn1KSfGYPh/9OtjdXn7XkYtSGzwBw9/FeVpk7MyDyi/3/+vfexvfEMaXSOtZGB/zdLlwgDBKBTXUOA/e0Xal2NbqliDmYwiC5cfMHyQx4QUKYyBkTO0QCvY2nO/BgJUWJxzoTUTV+f41FmuY5dMrIqu+BNHjkgEna3r2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tC7yPPeS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BUxcshdP; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tC7yPPeS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BUxcshdP"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 3F0121C00090;
	Mon,  4 Mar 2024 04:24:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 04 Mar 2024 04:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709544247; x=1709630647; bh=iE/WXmGUMJ
	ihkAcenxiU1ytySMBC5Dv+SpzNRz9VTRM=; b=tC7yPPeSGsvBIJAz0VwMxzuPQM
	o+1wJ5DnvoDeXB1dn/xiUhDceWD9ITSED0xuqO0ShUP9s54KlYEg/HH2vb8RLN0v
	ggDQx/B6UdEUpCrm/vLuQIuSHRsTGQihRyfOX8S1FaPt5SnJFFRK+yUc2sFYiv6n
	c5ahtGrLkmM5sIB+uXlSQ+mo0vXetn3EB+HUp9z4MiFAzs6+q3KDtGaYfK9Lx6HO
	XyCClNuN4v/IOmp7cWp4wGvK4m9G0R7UgmBZSDeRryRGHH6nGH8Ls3SVQdcfsS41
	ddQohu5fByknuJboW+KXqVoHNqlMXKzwdQfe+dESrdj2fycuM/R2W3Uqpg5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709544247; x=1709630647; bh=iE/WXmGUMJihkAcenxiU1ytySMBC
	5Dv+SpzNRz9VTRM=; b=BUxcshdPZz3UymB4zOvwSL7vRNO1cFovqwU6X5vcGwkN
	C+0IzaNTaRqs4bCP79qB6mQr6+kDRqguCntugyi2XBvGB4MZgxO5x0tALminZyo1
	iHBLWhub9pM9DZshVtIwwTugVa1rN9upgbedTzTBlaGl9hSbe6/cL3ITpcb79bgj
	idF9eCnYHY/2q3UjQz215zGUa1VygvPrUjnFtueoWerMHTeiE4gvYw3pTWGGlcaP
	QaJxKISw5Bbxb8WXNIdRdc2idJuaBZyDG5eOka+Kx/nnstgBpK1wzWIAJ4tH2cp0
	+HPLoOnOjmIKd8Zpc/d8C1FVfQvprSPYAzDWo0GHpw==
X-ME-Sender: <xms:N5PlZeys7rBEvwzdgMbgIabKGemESivZWMh-kBrIdtjje7_3bXdLIQ>
    <xme:N5PlZaTEgR6AkpdDiS4_f5XLMjPx9s8yG-2FU5uj5Dx4LkXEookbSLVkAv0R8guSf
    R1xXxjmtjwaUcCXiQ>
X-ME-Received: <xmr:N5PlZQVqfApuntlilNO7bDwodMukHW-fQR2j1Q7ixKCbMMu8-h78pCv5Yn8aFPl7TIo7ePjol1egQwwViIcvnfPLqqHsJ6XaywHHreQ7svFiejM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:N5PlZUgOuZV8QPipRlJaGIMdntzl8fiw8fQgGRZsik-nhn6OFN0FpA>
    <xmx:N5PlZQCJQ9n_ojScufkka1nq5fC3-zVNPLomxnr1zjkdX2Qb9erTAA>
    <xmx:N5PlZVLxvfv5fUSgqyDmQ3r0qL1AVU6yKHobFWUmYPYism_709Awiw>
    <xmx:N5PlZT_KDjmteFk2abYnzPgZqi3PdTtCLjlreBh5eKTR9g0j1qvlm5JEL-c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 04:24:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4ba7cd3e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 09:19:40 +0000 (UTC)
Date: Mon, 4 Mar 2024 10:24:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] [PATCH] t9117: prefer test_path_* helper functions
Message-ID: <ZeWTM3biKg_bsGaj@tanuki>
References: <20240301034606.69673-1-shejialuo@gmail.com>
 <20240301130334.135773-1-shejialuo@gmail.com>
 <20240301130334.135773-2-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PLKIA+69EkcRexCx"
Content-Disposition: inline
In-Reply-To: <20240301130334.135773-2-shejialuo@gmail.com>


--PLKIA+69EkcRexCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 09:03:34PM +0800, shejialuo wrote:
> test -(e|f) does not provide a nice error message when we hit test
> failures, so use test_path_exists, test_path_is_dir instead.

Nit: you mention `test -e` and `test -f`, but then talk about
`test_path_exists` (correct) and `test_path_is_dir` (wrong). You
probably meant to write `test -(e|d)`.

Other than that all the conversions look correct to me. Thanks!

Patrick

>=20
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  t/t9117-git-svn-init-clone.sh | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.sh
> index 62de819a44..3b038c338f 100755
> --- a/t/t9117-git-svn-init-clone.sh
> +++ b/t/t9117-git-svn-init-clone.sh
> @@ -17,32 +17,32 @@ test_expect_success 'setup svnrepo' '
>  test_expect_success 'basic clone' '
>  	test ! -d trunk &&
>  	git svn clone "$svnrepo"/project/trunk &&
> -	test -d trunk/.git/svn &&
> -	test -e trunk/foo &&
> +	test_path_is_dir trunk/.git/svn &&
> +	test_path_exists trunk/foo &&
>  	rm -rf trunk
>  	'
> =20
>  test_expect_success 'clone to target directory' '
>  	test ! -d target &&
>  	git svn clone "$svnrepo"/project/trunk target &&
> -	test -d target/.git/svn &&
> -	test -e target/foo &&
> +	test_path_is_dir target/.git/svn &&
> +	test_path_exists target/foo &&
>  	rm -rf target
>  	'
> =20
>  test_expect_success 'clone with --stdlayout' '
>  	test ! -d project &&
>  	git svn clone -s "$svnrepo"/project &&
> -	test -d project/.git/svn &&
> -	test -e project/foo &&
> +	test_path_is_dir project/.git/svn &&
> +	test_path_exists project/foo &&
>  	rm -rf project
>  	'
> =20
>  test_expect_success 'clone to target directory with --stdlayout' '
>  	test ! -d target &&
>  	git svn clone -s "$svnrepo"/project target &&
> -	test -d target/.git/svn &&
> -	test -e target/foo &&
> +	test_path_is_dir target/.git/svn &&
> +	test_path_exists target/foo &&
>  	rm -rf target
>  	'
> =20
> --=20
> 2.44.0
>=20
>=20

--PLKIA+69EkcRexCx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlkzIACgkQVbJhu7ck
PpTGBg//T20tItoPwCkH6UsiliS8HOBOA6ps6c7UbLrst3ifX/8tlnhbfUrdhedD
De6ljOASFJHCDmVwUi1x6Thk6auqfWq08W3+sg3aJ2ZbknlpmJQFVXWmVvU+Ag3U
kSuvEm1/I62l9XxzeIddNAc6EuncCbYCuQ9nKi+vT0VpLmR8W8pjujN+Qs102GAZ
w/4NmaeyX+4BT1Dur4211FBQqQWj5UPCWyvvuUrBKXbobuSnJPzySqWTDWfAuH67
Slm9d6fCLSMpA1S5nIw/YusB6dB5gtw/QRalLgNi6TToCYibXx/hzuw7V/6dOFiE
9ccMeh2JxMZdAK9FdRa/ddlOLKrWFVvAdtmO9pLujdVbPUEt+MoInUxiJLmHK3dY
L9MllyRmDpzwbeQFb2N59iGN88Ta/NRpNhCcqpyjBBZ4mzCo1WTL99mQeAq4L8dj
cHBmH3TIXjaGlVIQpPMqY4v45USo8B8Ru0zZPrKf2CiHy2PN/0ph6XVte1TSxn12
0KEyXu4Gw7Lr7SW0A/XZXCPPIIm2vQcJCIetIj+eD7zBFK0hLzmw9YB2ZqHSuflP
YnsCxbiVuLOrnQQrJPwHCVeN36Vo8N3cqSHc06WrRBe+jCoOWvkr/nys2Txnb0L4
7iPz6BJBl0r2EMaZ+3RReIOCV64/oaS76eYVsVLgAVQMzLb5cA0=
=8HXK
-----END PGP SIGNATURE-----

--PLKIA+69EkcRexCx--
