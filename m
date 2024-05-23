Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9BBEC5
	for <git@vger.kernel.org>; Thu, 23 May 2024 05:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716441982; cv=none; b=F1XKqkbNGlwqPlc7gX+lCIbpWmFcQTyEX0T53iA/4qXQR785Plv0/GGNUi+8YkFYnOWE79ocfx4rsMvoK5CWvOhdRve1g6v7fDg+3ZpLeTc5b7LZYbJ2CC9nvcJ2NUP7B9p+6vQt7FxWvwpz6xhM2N9QkfG1OiDdl+S+m24ywVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716441982; c=relaxed/simple;
	bh=9YlMEJQayX2OOJwmjtrNlXreZCBJytOOtsVVy6LG/Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx9BsvUQoaBWuGTrL/knpPezIcS7h+RRDUzzpBH8/gkJMtlPjFzvjMYbChMRatmSCF5sDzOuDp7ijArkpDq/YPQ6ntx4qPaAnetyciJaraZn5uOrbKNVKzoyPj3Qer/C9y/WQsHLrvttsvjVI4gCek83UqktK9YR6OPsthXuXIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F0p1k4Mq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EewmdlF+; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F0p1k4Mq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EewmdlF+"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id EA1621C00180;
	Thu, 23 May 2024 01:26:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 23 May 2024 01:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716441978; x=1716528378; bh=/Zf48ewyTD
	3BrzmpDwgetke+mXVPKyyj1i+biY3Gw10=; b=F0p1k4Mq0CzZm+4KD8QavZbkVm
	cHOeHKjztFQAHJh+tjcd/60QIS2cMQK2C2IHW0rUctUeW97ydC+VDPTiCTXHOJ7S
	aPQ1+rUj2dRTJU9fuc4so0vcP+n88GeC9AekVYsJmlrrqjHSb/VR0RzyWMBV23De
	UvXZDXEl210cDo9RFvikzKCHDT68miTbdiVKkDJzQXrVhqY7qOwPZt9bHXQQchdD
	0W+gq0YJFIGFglWt+8voTJjZkxiVmwUw2Gp3CKn3QBUlhPssYWP2uWQABjOYDw6M
	KJHhZw9x0udqXT5E6yQG+cn4uY4KZ5aJsYe3p5D3LmnyT3rwFc6sdVkXxg2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716441978; x=1716528378; bh=/Zf48ewyTD3BrzmpDwgetke+mXVP
	Kyyj1i+biY3Gw10=; b=EewmdlF+X1f66Nd6SCZiZebNbH1EVRBjti9Pr4WNZhRD
	XEKpGQQSUyhwW9EnerR+9gwG8y7Q3BwlTzthmckEyx1HSkuF9lt5fgftVslS/rl7
	u1Z2r1k1EwUQtjLNdD8gpN+rrb7RinayfbPNc+ZIbZ5jB1p7WV9tditFSXXw0Bto
	FQOEsy3/2H2pNrJxxTuL32X3Y3kOBL9dsiOjGN5/PVB/dDiO14NoaqJA1zcnRYLV
	68f9gseK60kHehoeKxGLZMr/kl25yrk1lRKCCqNx9gg7oNV4/iZNkUolyWnrAX3d
	1qtN3iXWcTM73Wxv6n1qankA/c9YEsf0iceQ3jznKw==
X-ME-Sender: <xms:etNOZtmRMsrw5CHpu8_LFN4dlf-UNuqaovZUGKyIveSprWzevLlvcg>
    <xme:etNOZo0rk3C2THAxLahL_m3CDCXbwyA2szY42ebjZhYbrwjcFrRi_Cfjn_UBXvYRs
    FXgmSamgU610HpFmA>
X-ME-Received: <xmr:etNOZjqRJos3pjdSip4yHeajLdmP6Sh18MGXBt9kXucWqo1IzBwcAcfhlP23z1stta6pOr7GgO7e00v1FDAiaOPr3YXD3-IAAYRY5JfNJZeo_00dYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeihedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:etNOZtldQVgSzkRFX36-8YEaaVpt0-uBygbFc_8HcpcPuOYEY1wOlw>
    <xmx:etNOZr2vdTwDt8B3XmwDYIdLXBagV8ZtQ1kkyYXheAUmYK5IZX682Q>
    <xmx:etNOZss9IuOUwKKSbH4tbN-2FXgPvrjLNEAhowBUH8u9k1W5WoBXWg>
    <xmx:etNOZvVC2uzx3Dg0xSZsykE5lXqPFAJyK2HzHEaWJDaoezJFP4fHIA>
    <xmx:etNOZsxxynT8-4zdnRpfoZZ3CWweNWwezjQK6_6-jZupKSNBlQlVSS0t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 May 2024 01:26:17 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 23179cb0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 23 May 2024 05:26:09 +0000 (UTC)
Date: Thu, 23 May 2024 07:26:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Heghedus Razvan <heghedus.razvan@protonmail.com>
Subject: Re: [PATCH v2] setup: fix bug with "includeIf.onbranch" when
 initializing dir
Message-ID: <Zk7TdDRFAuwQMBHy@tanuki>
References: <D1F5SJ52H4Z0.1NR7M8APRFTOB@protonmail.com>
 <cf182bb9ee7d4a7eb46e5dbf4f3ef5deb198d823.1716374321.git.ps@pks.im>
 <xmqqwmnlz7bf.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uW4lOSD5/Dcw5rBf"
Content-Disposition: inline
In-Reply-To: <xmqqwmnlz7bf.fsf_-_@gitster.g>


--uW4lOSD5/Dcw5rBf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 05:43:32PM -0700, Junio C Hamano wrote:
[snip]
> diff --git a/setup.c b/setup.c
> index b69b1cbc2a..c6fffa0164 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2224,6 +2213,21 @@ int init_db(const char *git_dir, const char *real_=
git_dir,
>  	repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
>  	repo_set_ref_storage_format(the_repository, repo_fmt.ref_storage_format=
);
> =20
> +	/*
> +	 * Ensure `core.hidedotfiles` is processed. This must happen after we
> +	 * have set up the repository format such that we can evaluate
> +	 * includeIf conditions correctly in the case of re-initialization.
> +	 */
> +	git_config(platform_core_config, NULL);
> +
> +	safe_create_dir(git_dir, 0);
> +
> +	prev_bare_repository =3D is_bare_repository();

Okay, `prev_bare_repository` is another difference between v2.44 and
master.

> +	reinit =3D create_default_files(template_dir, original_git_dir,
> +				      &repo_fmt, prev_bare_repository,
> +				      init_shared_repository);
> +
>  	if (!(flags & INIT_DB_SKIP_REFDB))
>  		create_reference_database(repo_fmt.ref_storage_format,
>  					  initial_branch, flags & INIT_DB_QUIET);
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index b131d665db..319ed81631 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -584,14 +584,39 @@ test_expect_success 'init with --ref-format=3Dfiles=
' '
>  	test_cmp expect actual
>  '
> =20
> -test_expect_success 're-init with same format' '
> -	test_when_finished "rm -rf refformat" &&
> -	git init --ref-format=3Dfiles refformat &&
> -	git init --ref-format=3Dfiles refformat &&
> -	echo files >expect &&
> -	git -C refformat rev-parse --show-ref-format >actual &&
> -	test_cmp expect actual
> -'
> +backends=3D"files"
> +for from_format in $backends
> +do
> +	test_expect_success "re-init with same format ($from_format)" '
> +		test_when_finished "rm -rf refformat" &&
> +		git init --ref-format=3D$from_format refformat &&
> +		git init --ref-format=3D$from_format refformat &&
> +		echo $from_format >expect &&
> +		git -C refformat rev-parse --show-ref-format >actual &&
> +		test_cmp expect actual
> +	'

And this here is the change to the test setup, which makes sense.

Looks sensible, thanks!

Patrick

--uW4lOSD5/Dcw5rBf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZO024ACgkQVbJhu7ck
PpQ1Tw//eZF4h74LLPtMtVNRuMGt+iwNQifBDlCy6/uVnwsqEm8K7+Cwpje83h1b
i6Z60Hu8dyr5wxGtb47Ms+7nIvfkfVfU67glCIncURqrnlgcehMWLdA6wSOSI4tF
8Rr1Sz2p5XaJZAMxezHZ1y02LDGfSC0r0WOCnz/onfskV8HMhmxLFQ6Cw62Hjk4F
p/EHPXXKvBt+Yrumhb/f8giL/GQZtkvMzJyut/MnWnePnl2J8AFYuU0axfDqkSQb
zA+DLBgBqYiZTHqXgrUoo/5Lzbu3m9kMnILfgSghHdq/Vnn0YLH+yWwu4kOkqbEJ
ZTRUAo6fzuQXHcDJNuZRWLFIvcrBU3z/hHuOPJOaaF05aEC5PH7gWYDHhEIuzXKP
MrVWHtOUc+2tHRfiu2GxWE9Pg/MhLf97OPgaZTqY55FdsOpPAVV7CDMbCrg4qw3e
U1Uzfgw+XWkPIvviFm5rKZzCgNr+m5Ur3QfHfVBKYSJgZZbRFGQmrcEkOR0jChPP
PDtOctETKrqpHdXeKrY7zA1pasBNXMwEpdlOKUeJEhAxN6+Ct5sA5Tx0VBN0zjmb
EAgVOckN/u/MFBWm7+25eL/y51fhz9h3vhULpIXJvB96ZRBEnOXYE7mqxZ+K5k7C
x/s+RsjEYHCmWMMRJ6dAb9tQrIstaQdL3B08RCiqJ5DP9YSJTbQ=
=iqgh
-----END PGP SIGNATURE-----

--uW4lOSD5/Dcw5rBf--
