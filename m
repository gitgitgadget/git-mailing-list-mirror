Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34D51552FC
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 05:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713936551; cv=none; b=O9OHAUbVYOxS0wNUtDsIiWzGK6VkWkMR45NZWOLwyCeeYw0GC/g067bFQx/w2BDUGZrWh183tmDZgrGVGyP/wDARfGk1ho/KPOGqQwcNa+EM/2R2gAl6XeF3s/ZuwvbfhLey11EYBQdIUQughWPLxxSTmtpd95Pcc68L6ONr9Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713936551; c=relaxed/simple;
	bh=Dkz9nC4zuxIubOLVqdudMA4kWAdFwASXj/lwn7+ZAkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/NYr5TpPrLLBlqxCG4F8xN7MTs2Ut+aLkfSrmQhTprC0rkAb24pXvhu5/rGi1tvEraAJZWqGBTzrLTqJKDs5DfMcvjaEWtW9YHqvSIvzrj8QfngfMHmUSD9s4EpreKH7zITDBdR13XZi1JnhfegDKm9qH/9Gd1KApInKWh6bbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VvBRqUwf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=facoa3sB; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VvBRqUwf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="facoa3sB"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C6A671140097;
	Wed, 24 Apr 2024 01:29:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 24 Apr 2024 01:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713936547; x=1714022947; bh=mgZv9Ej5s9
	2Y16+UF7YmDPyYVW5kcMtXXdNySNBAXdo=; b=VvBRqUwffmn70Jcb0upTtBHr80
	0sgRKrijACJ5eIvVwJVpUpRpblUjItUjjSMyqEVsq3bL7F4IrXe84Okp3rDg5ds9
	lx1obVp5wDmTC8elp6n53//YtxVb35DfOYkMAnuHIOG49XWNtGTSf4ufr9O/rRNN
	kB5lHhMF9m4bJ8MAQaFfp4B4yzIc1DabVGb1r2NlQTCxZ0GNP/zmcZzI3Thc2tkz
	JxfKtHStYZPazy/8/KDsbCppUDnQj/nuOe4DvWU0xlzUv5WDKn9eoNDVaAxbDYSc
	idl/VjTPz4yqjePEYP7+Gzgc5d1hdemqPJQ1euNBuDDKB23nZW89HLZtQurA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713936547; x=1714022947; bh=mgZv9Ej5s92Y16+UF7YmDPyYVW5k
	cMtXXdNySNBAXdo=; b=facoa3sBYloMeeOLUtClcwIxJIK6e2i+ew/ho8Y3fmXk
	f4ZEYtw0YR71DbtrUMKaRGbOzkH6Dz7lyg0EkKijAEo6ShGspC/t0613OYhORRnl
	HuS5qSf4wmU6c5e9QqZ9BUJN8l2OEFXNMLHgdXQY4R+65YPQxu1MP0JTAk2gZOfD
	2j6Drun+94rzfcuj8MGmqc4ETQ/GBgsi03KgtV011fiL4U/STo3XwyzUwRe1KmoJ
	gRyEKpkgT8S5m5454EuYS+N5qFVz4e7/clNVX1DH0WUI2UVd9G5GdaRPKZHNnTOo
	8A1zMLTS6PNeDaGwl744qA8vzEGnX3BnKAHcc3jTbg==
X-ME-Sender: <xms:o5goZp_5xvio768E-QbwV7RBn6I8i3WfRHf7Jkv-LU4NtZzmQLQggA>
    <xme:o5goZts-h_kb1cc6qfCF6_TMVfZzcMZg-R4ZAD8lrevQaA7XrlNlmLp1m6hg8zWtr
    mb0wRIh6VikYVmAxg>
X-ME-Received: <xmr:o5goZnDdUpRrv8kmwUFeZNvwaa6ES61yKigVtjcKfuZ9UhDgVfVt_WmANnXa-AUsZzf93djR0_ynI7FsWnX0eYxrttaJWD9RchO7FM4lU4-OAjo4QA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelvddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:o5goZtdUXiKJ7ttEt9XXrvYJQQJaAbQZ6u9itro7ybas8Ht6zIkUQQ>
    <xmx:o5goZuMN20Zlv2SpEbfpqtYn_PJxbkUR24IK078rCQi4-Glz97oLvg>
    <xmx:o5goZvl36SG5JZYu2LBidzC3ccmDiXeAW09cw-9v4BVL5csElFHLRw>
    <xmx:o5goZotcWyy6byEfXSuqwP19gQ1c-zXQQ5v6xZKiPH469d5kkSJ6lg>
    <xmx:o5goZnbUduvYGTTg9yZboDKJ5wD3CPKmki8UvWZck-cWOx9nxrbQNYiD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Apr 2024 01:29:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 31b563a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Apr 2024 05:28:58 +0000 (UTC)
Date: Wed, 24 Apr 2024 07:29:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] advice: add "all" option to disable all hints
Message-ID: <ZiiYoOKJpqq4XWq-@tanuki>
References: <20240424035857.84583-1-james@jamesliu.io>
 <20240424035857.84583-3-james@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jw3uWKYqQyAMPwV/"
Content-Disposition: inline
In-Reply-To: <20240424035857.84583-3-james@jamesliu.io>


--jw3uWKYqQyAMPwV/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 01:58:57PM +1000, James Liu wrote:
[snip]
> --- a/advice.c
> +++ b/advice.c
> @@ -43,6 +43,7 @@ static struct {
>  	const char *key;
>  	enum advice_level level;
>  } advice_setting[] =3D {
> +	[ADVICE_ALL]					=3D { "all" },
>  	[ADVICE_ADD_EMBEDDED_REPO]			=3D { "addEmbeddedRepo" },
>  	[ADVICE_ADD_EMPTY_PATHSPEC]			=3D { "addEmptyPathspec" },
>  	[ADVICE_ADD_IGNORED_FILE]			=3D { "addIgnoredFile" },
> @@ -132,6 +133,13 @@ int advice_enabled(enum advice_type type)
>  		return enabled &&
>  		       advice_enabled(ADVICE_PUSH_UPDATE_REJECTED_ALIAS);
> =20
> +	/*
> +	 * We still allow for specific advice hints to be enabled if
> +	 * advice.all =3D=3D false.
> +	 */
> +	if (advice_setting[ADVICE_ALL].level =3D=3D ADVICE_LEVEL_DISABLED)
> +		return advice_setting[type].level =3D=3D ADVICE_LEVEL_ENABLED;

Makes sense. When the advice is unset we don't need to handle it at all,
and if it is enabled we basically want to behave the same as before.

>  	return enabled;
>  }
> =20
> diff --git a/advice.h b/advice.h
> index c8d29f97f3..b5ac99a645 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -11,6 +11,7 @@ struct string_list;
>   * Call advise_if_enabled to print your advice.
>   */
>  enum advice_type {
> +	ADVICE_ALL,
>  	ADVICE_ADD_EMBEDDED_REPO,
>  	ADVICE_ADD_EMPTY_PATHSPEC,
>  	ADVICE_ADD_IGNORED_FILE,
> diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
> index 8010796e1f..19318cc9bb 100755
> --- a/t/t0018-advice.sh
> +++ b/t/t0018-advice.sh
> @@ -53,4 +53,37 @@ test_expect_success 'advice should be printed when adv=
ice.pushUpdateRejected is
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success 'advice should not be printed when advice.all is set=
 to false' '
> +	test_config advice.all false &&
> +	test-tool advise nestedTag "This is a piece of advice" 2>actual &&
> +	test_must_be_empty actual
> +'
> +
> +test_expect_success 'advice should not be printed for pushUpdateRejected=
 when advice.all is set to false' '
> +	test_config advice.all false &&
> +	test-tool advise pushUpdateRejected "This is a piece of advice" 2>actua=
l &&
> +	test_must_be_empty actual
> +'
> +
> +test_expect_success 'advice should be printed when advice.all is set to =
false, but specific advice is set to true' '
> +	cat >expect <<-\EOF &&
> +	hint: This is a piece of advice
> +	EOF
> +	test_config advice.all false &&
> +	test_config advice.nestedTag true &&
> +	test-tool advise nestedTag "This is a piece of advice" 2>actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'advice should be printed when advice.all is set to =
false, but advice.pushUpdateRejected and its alias are set to true' '
> +	cat >expect <<-\EOF &&
> +	hint: This is a piece of advice
> +	EOF
> +	test_config advice.all false &&
> +	test_config advice.pushUpdateRejected true &&
> +	test_config advice.pushNonFastForward true &&
> +	test-tool advise pushUpdateRejected "This is a piece of advice" 2>actua=
l &&
> +	test_cmp expect actual
> +'
>  test_done

Do we actually have to enable both advices here? If not, then this
should probably be two separate tests that check whether each of the
keys does its thing.

Patrick

--jw3uWKYqQyAMPwV/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYomKAACgkQVbJhu7ck
PpRx1g//YUfwNTxknTjHS89YL+Y9Jv4l1NDOtbeMy+2SM11SgFbR67QIHCEHzozf
ZkJpUuNgC6mS1tx0bdXgmtMXbSlwf2h9iAZNCGnmCOuN/X+bNBP3NJVGiVJd8/U/
NDb6+Xa9xY6JujX/CdiGH0piZbKuCEql7IUZD2YzbaOA5cibNyRT7sVt7Lf91qbC
qXl0Xpa0wbz0ykg0oE8saxMUKtuCw+XhovrioUwwYuV8D4BzEykHolVXoo/aV6Sn
Cl6Gs0SvKYfh4JZ42o70k6zfkTENgakM5BbzNm+9GLWphliTEQnwLMc3O8lzOGxj
EdrZO8hQ5xASTqYyua7b+ZECQBn+Iw68xTzZV5ZqtB5jCCz8vCXZ7ZucjmvhjNDU
q0y2dUxEIZ9aq2JAPIvg7u/Qci3Z/54on3CnGAuLzKWWi8uhJ57Vb94luakumMBw
Mcf2AWvUhE98RrfNp8OP0slety4hBUMj4LB+m30Yxv0+Tsv2tX4t8DrMv3MnWwKf
cLAuwoswOdr3aHsdBGYR5T2l2uMtMnYJoVvNnEnikThkcevsjkdHLwn/5GWmR9h+
xRkpoAsYIqaV7tKo1B2wp7l+rBuaVuVkZAc4riv6aFWlG23yLyn8cnbLJzyaHP7i
w7Ek0AxAK455wclMKb+4AqFzDOBOkPrY7BiiALfKwA6lqiyM1jo=
=btdh
-----END PGP SIGNATURE-----

--jw3uWKYqQyAMPwV/--
