Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFEF1586E6
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781353; cv=none; b=XpHc48sfQcqQrNtcn1RtCC4eB5m8FlDmeiLr5qPIco+Dd4fBXVKEHbMRdz4zIdBTo8sUWqTfSVI2ErOvjtFZ23KEH3U3n0Px+7GnP4s2BMWH8Z8ioUPEk0q8pBmX59xbC9BRP87CknybS6uMdaIJhWzSdohRfUKbxrp7SFhRS6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781353; c=relaxed/simple;
	bh=9wlQ8c0dWWOPteb/1n+LHqj4R+tEOfN4ZJsmY3VQQVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksZG8Q+DjjKxZVZjfhpvIHNHLrjJliypTUz1LqHS0gjTKI0xNUyc9l7RkMMDSonTeDKxj62MVaZ2c2EhxpwRZxVgFtGdLed4lCS9vmeId41J9ogN+BuVXwBmRhV4o58/79jYZ3l8OPynxjjNIiktShUrKzywBlz1yDNPJkdfmJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oruZNM/R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o49HYt8P; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oruZNM/R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o49HYt8P"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 65C231800087;
	Thu,  1 Feb 2024 04:55:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 01 Feb 2024 04:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706781349; x=1706867749; bh=GYXd4lLflS
	uesLBYgKV3nPjazh01heV98IhXkYUYG2o=; b=oruZNM/R/SBr7i3sNX/5h9Dh/9
	hQR7r4UDNUeFT39qMK173MyrkiUp6SieC6AwUYzQhGSezklvE0AUcMf1P4Ym16n8
	50F2va26l+YJ1A1SRggfMk3Je1UlnCanTJPkJYlVRJ+kdjcb6RGMzA1ouKvGYhBF
	dc809xzxeZgMpYY8jZ09eTwE0cwqSxOYEF1XpcMcQtW1tdwVAgbo83mK8bQtaMss
	gvh/dO6e38S5Fcvxf0UkPe3R+mf2944nBTM10bMdDFuE/gu16qQhfF7PiDZz9512
	4zD/Zy65Z9eKF861Gz42tZDoa6D9Zbu/Wu8g36LqNIYFKwOPxd2B/p0s6xGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706781349; x=1706867749; bh=GYXd4lLflSuesLBYgKV3nPjazh01
	heV98IhXkYUYG2o=; b=o49HYt8PRwpJ6wecbLx1zvHmN0mRNy1UGi0e7W3q10hA
	en/xDi8IXAKavYnOdmb49yCDFHvB08xghfZiJwJZwWYMW8/XpTcl9P8s5XAZErlA
	91dfxVTYnws0MhDBRee8qDCxIIGsRhIrFtk/c94b5uDui9rnbbBIvByOnHkZSNiT
	bfB4mEMkzR9pD7BXVkwj43uhNTnfUqkraV82ahHdBuLBcDSAQleRhr0KrzKYnkrO
	t6ybJ17Q3Xh4KrbFjZShfYxJP2ByGEYfoTrQYzmC8ilLQdYapicBk3RDh+ChbIkf
	g/J7Pkq6GjAzhYhzKJt0Q2I39TOAkB/dNuIoKzZcVA==
X-ME-Sender: <xms:pWq7ZTcxhzn3_Itrk_k9fpiCU7UkUeVcMdsaKRD6dnmkY0re05Mgeg>
    <xme:pWq7ZZN6cU2-yjMOwYmJAj3IvwNwk6pfXgmSHtMWMNLsctdiste8fDUoaF2_pl-bS
    suEszU8VrajW7kmwQ>
X-ME-Received: <xmr:pWq7ZciaVV66uyYiv9-aRODd5uQF63Uc114ejKLqT_0BdTuEHAXC55Ga2SvNwojqTqXg27g5Elr69YzoUqpfK1JL0kBeeb4unswo5K4JC6eoLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:pWq7ZU8DxnhwaDRzhWCGCJEA7v_pqRSOkXlCDFE0HakAWoZ2nqPdkg>
    <xmx:pWq7ZfsmYB7HMoxL4PtHrKHnwDUVqZ3GVVR7nkCIolJgtp-Jd6vccQ>
    <xmx:pWq7ZTG3QGwon-YfRPaVL-ZFBd6PYaCIV5R5mZeUXlhJe6ohduRS2g>
    <xmx:pWq7ZfJx3PSZEp-u2d8bhHufYWkWVt3MpeOYxBzIIPt6RsZ6JWm5LohXU4A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 04:55:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 632ff9d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 09:52:25 +0000 (UTC)
Date: Thu, 1 Feb 2024 10:55:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Britton Leo Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 8/8] completion: add tests for git-bisect
Message-ID: <Zbtqomb-S270SMba@tanuki>
References: <20240118204323.1113859-1-britton.kerin@gmail.com>
 <20240128223447.342493-1-britton.kerin@gmail.com>
 <20240128223447.342493-9-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H9aU8C/ESaOywu7J"
Content-Disposition: inline
In-Reply-To: <20240128223447.342493-9-britton.kerin@gmail.com>


--H9aU8C/ESaOywu7J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 01:34:47PM -0900, Britton Leo Kerin wrote:
> There aren't any tests for completion of git bisect and it's
> subcommands.
>=20
> Add tests.

I think it would be nice if you added relevant tests directly in the
commits that introduce the new completions. E.g. add a test for the
bisect terms in the same commit where you introduce the completion for
it.

Like that you can easily add tests one by one, which decreases the
review load. Also, it serves to demonstrate both that the functionality
works and helps the reviewer to understand better what exactly you are
adding by having a nice example.

Patrick

> ---
>  t/t9902-completion.sh | 135 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 135 insertions(+)
>=20
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index aa9a614de3..698e278450 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1259,6 +1259,141 @@ test_expect_success 'git switch - with no options=
, complete local branches and u
>  	EOF
>  '
> =20
> +test_expect_success 'git bisect - when not bisecting, complete only repl=
ay and start subcommands' '
> +	test_completion "git bisect " <<-\EOF
> +	replay Z
> +	start Z
> +	EOF
> +'
> +
> +test_expect_success 'git bisect - complete options to start subcommand' '
> +	test_completion "git bisect start --" <<-\EOF
> +	--term-new Z
> +	--term-bad Z
> +	--term-old Z
> +	--term-good Z
> +	--no-checkout Z
> +	--first-parent Z
> +	EOF
> +'
> +
> +test_expect_success 'setup for git-bisect tests requiring a repo' '
> +	git init git-bisect &&
> +	(
> +		cd git-bisect &&
> +		echo "initial contents" >file &&
> +		git add file &&
> +		git commit -am "Initial commit" &&
> +		git tag initial &&
> +		echo "new line" >>file &&
> +		git commit -am "First change" &&
> +		echo "another new line" >>file &&
> +		git commit -am "Second change" &&
> +		git tag final
> +	)
> +'
> +
> +test_expect_success 'git bisect - start subcommand arguments before doub=
le-dash are completed as revs' '
> +	(
> +		cd git-bisect &&
> +		test_completion "git bisect start " <<-\EOF
> +		HEAD Z
> +		final Z
> +		initial Z
> +		master Z
> +		EOF
> +	)
> +'
> +
> +# Note that these arguments are <pathspec>s, which in practice the fallb=
ack
> +# completion (not the git completion) later ends up completing as paths.
> +test_expect_success 'git bisect - start subcommand arguments after doubl=
e-dash are not completed' '
> +	(
> +		cd git-bisect &&
> +		test_completion "git bisect start final initial -- " ""
> +	)
> +'
> +
> +test_expect_success 'setup for git-bisect tests requiring ongoing bisect=
ion' '
> +	(
> +		cd git-bisect &&
> +		git bisect start --term-new=3Dcustom_new --term-old=3Dcustom_old final=
 initial
> +	)
> +'
> +
> +test_expect_success 'git-bisect - when bisecting all subcommands are can=
didates' '
> +	(
> +		cd git-bisect &&
> +		test_completion "git bisect " <<-\EOF
> +		start Z
> +		bad Z
> +		custom_new Z
> +		custom_old Z
> +		new Z
> +		good Z
> +		old Z
> +		terms Z
> +		skip Z
> +		reset Z
> +		visualize Z
> +		replay Z
> +		log Z
> +		run Z
> +		help Z
> +		EOF
> +	)
> +'
> +test_expect_success 'git-bisect - options to terms subcommand are candid=
ates' '
> +	(
> +		cd git-bisect &&
> +		test_completion "git bisect terms --" <<-\EOF
> +		--term-bad Z
> +		--term-good Z
> +		--term-new Z
> +		--term-old Z
> +		EOF
> +	)
> +'
> +
> +test_expect_success 'git-bisect - git-log options to visualize subcomman=
d are candidates' '
> +	(
> +		cd git-bisect &&
> +		# The completion used for git-log and here does not complete
> +		# every git-log option, so rather than hope to stay in sync
> +		# with exactly what it does we will just spot-test here.
> +		test_completion "git bisect visualize --sta" <<-\EOF &&
> +		--stat Z
> +		EOF
> +		test_completion "git bisect visualize --summar" <<-\EOF
> +		--summary Z
> +		EOF
> +	)
> +'
> +
> +test_expect_success 'git-bisect - view subcommand is not a candidate' '
> +	(
> +		cd git-bisect &&
> +		test_completion "git bisect vi" <<-\EOF
> +		visualize Z
> +		EOF
> +	)
> +'
> +
> +test_expect_success 'git-bisect - existing view subcommand is recognized=
 and enables completion of git-log options' '
> +	(
> +		cd git-bisect &&
> +		# The completion used for git-log and here does not complete
> +		# every git-log option, so rather than hope to stay in sync
> +		# with exactly what it does we will just spot-test here.
> +		test_completion "git bisect view --sta" <<-\EOF &&
> +		--stat Z
> +		EOF
> +		test_completion "git bisect view --summar" <<-\EOF
> +		--summary Z
> +		EOF
> +	)
> +'
> +
>  test_expect_success 'git checkout - completes refs and unique remote bra=
nches for DWIM' '
>  	test_completion "git checkout " <<-\EOF
>  	HEAD Z
> --=20
> 2.43.0
>=20

--H9aU8C/ESaOywu7J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7aqEACgkQVbJhu7ck
PpQoQA/+JLr+bXtOPrBHJshjNRRRKc84vYyBItvuYCtlbpwnjcR+2SYrFA7c/xnp
EXnvFrcrnph2MJyU7g3rO/RuRyqkLw/OJN4TWYiMtKn6T2iqukV4wGB8jK79lKeE
GzXyyrhS24jHohCrkg6OwUTx0oKRkI6yEGpDXiHFMl7U2DP/RFfWKT/nrzSpJDDo
vAPbfLQu6jBbhoy2yW9vOIisOZFUPH4K4+Veb5WqF5KF59TIDRZ4umH6G/CjYc3S
yezgNQJQNYdPZrN0YoJX4d6+9bZpVT0JUMCCscl9NO4uiMZGs2D9p+Yg3r0Z3OFS
bWYkK0OAiWntWUToD2CYaJnUFyNJWsuyoBWW5n1HkI1lVN6pSHr3h0LgZM20NRj9
csxmcP87uyJArHDVNrS2IHgdKcf4376D0IEqe1i/iEpA2CFffrermgU1nsosFEOI
PJJ3bGrRRgWx5aLbHYFAFAasMS2KEEMGznGcTEnOCHIYNee+nih+MZTs8djAw42R
LNrV8XoEyCmp9y3rNAIPQvt3iIUtswqqtlhDrFwpHmjsvhQHcJI/zsWnCINGa42m
WOGUfK+5Wbgav+la1EZ1cEthL20oyIhIPGfw1MNczQ8Er7btDNm31wgSr4q0r4O1
GEeTVKCDmV+v3GImnVUkwcR+bIb7UfFBVskOX0qoUOlDtqGUfBI=
=1mj6
-----END PGP SIGNATURE-----

--H9aU8C/ESaOywu7J--
