Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCFB7AE75
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706646; cv=none; b=qvDviOapj/6VxUG09rqfjBRd1gi2JAx6OYTavnQ/c5L9HVA9lvazHpuqMmhPqZDGS3ScouOwwX7Od5oKZaWybcGK3RBk+8C9RFbfimt6Ldak/Wdd/jhIE9N9ak7j0Z1lt6/ymaAUAuj0LV0mhicN00w6N3Y/zJNCa5q5vHI1I2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706646; c=relaxed/simple;
	bh=GE/hxK5IbfPfwGKlCR9ZN7hbYkFHP3u0pDDAXYq06Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHutXHk9OCupKCB5Ft3cf0Fy8pvwk3VZ5ZqPhjUdeF/3iW5Ra/UiXZPV/tvRGdwfuAuyJp0FJ4MixcUK+IwFK0chlF1GD/SBPG/zMGiwuA3+U51AhMnPS7LufQDksHWMMypgvQiWC7qIWMCE7ZwZRyzio4uGr1URW2Uw9Z78YI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e+rPZIxL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WZ/eIqc3; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e+rPZIxL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WZ/eIqc3"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 80A4A1C00073;
	Wed, 31 Jan 2024 08:10:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 31 Jan 2024 08:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706706639; x=1706793039; bh=GE/hxK5Ibf
	PfwGKlCR9ZN7hbYkFHP3u0pDDAXYq06Qs=; b=e+rPZIxLLgiHfjAMjERar9vN1q
	O+Vty1OqY3aVZpPTFeASYx/Q1km0dziQC6K0YeDyOeyf+Xw3TeRBOxkjnNK1zWib
	Y0WHcvFjw2pjtRFsXq4zBEP+kXZIcSIeca19+t/5srMLw51tPGfFvap7+muXdJeM
	bOzu/9jF9ZDXIZzW042CJ77ZZiQkE501xywMil/XmY1qDriUPQuuMjTh2/CpD89l
	aMGmzjKFRgIZtywWRO413nlhok0DZZi4yNBIHFBqJKIcZLRh/VDp2cr/aQvLrVPi
	siqEjc5il3GxL1UHS9Q4xR0o9WglVn5WgV0z696GG9tUH9pjA6KRAlrqwO8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706706639; x=1706793039; bh=GE/hxK5IbfPfwGKlCR9ZN7hbYkFH
	P3u0pDDAXYq06Qs=; b=WZ/eIqc3RurwQwxGiDBwpTgtNa1Fn6YvSV59Mo19S9OC
	hDF+ahmZiI1GkzIbQXmL41mD13N2ndx8hDlNeNo/ZgFLs2GYC+ZP7OCEDl2ErkRq
	VvILF9yyEpKWoZng6f7lNaNYIq5dUVoU9UqWWZIu9XmvGXWnU0YjudtW3DsPoEYY
	6khvZTDDkwHP7HT9Pgix4l7ysx2HvA9Ox0xYyrP4o3uxAB+sWNXPZJ0b0TyrULyI
	BT3Hqqd8KGnC6Yb7ri7lOJ2lXn/+tEhAsQpBd50utZw4yzyfe0jEfO6IEzBGLXPw
	CWlBn24J9xCaevyjzIYUKI5DCMBsegnHEiAmp2d6pA==
X-ME-Sender: <xms:z0a6ZdLS4IFE2iTxtjus6qBb1h6NydDqGbXekAdpJCqvpmXpLnIT0g>
    <xme:z0a6ZZKLsAccaSm67Q3M97GIPoX19L41BI6Fw2DaH9Qnq5_4qEgWuesIrFYCNdPBy
    heNSnm1BD2-J9ggaw>
X-ME-Received: <xmr:z0a6ZVvxiCGfpj1XzgMznkBWelVDov4Hwc1feJ3Zj3DlJVPKpyINv6RpaBi0TjeiSscjdKeLZ9OyROhZQEoEa1toe0wnvfjtL_oOsguWtGouLmY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtledggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvfevuffkfhggtggu
    jgesghdtreertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuc
    eophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnheptdefledvkeelueefveffjeei
    jeefheeijeekfedtleejhfetvedugfefjefgjeehnecuffhomhgrihhnpehgihhthhhusg
    drihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    phhssehpkhhsrdhimh
X-ME-Proxy: <xmx:z0a6Zebx7f4ouEu0ZyW1O_KTX-OKJqDIUGsfB0xE0tKc5Lrq07qI1Q>
    <xmx:z0a6ZUZn8AJ1RbgY6oXYjd5VfsovfJGFbuAHXA6EyD8ouQS8PUVU7g>
    <xmx:z0a6ZSB5k6ZUQHkrFwFKK7jvGJraIB6mOB6EhT9Uzh_JmUkF8H7A4w>
    <xmx:z0a6ZZOQUK7INnYKB3I-4pGx4HhDco62mqg6jB32pAABbKbI1ZV5OwRAdK0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jan 2024 08:10:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d575ea47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 31 Jan 2024 13:07:18 +0000 (UTC)
Date: Wed, 31 Jan 2024 14:10:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>
Subject: Re: Git in GSoC 2024
Message-ID: <ZbpGzAd6FGEeTdrh@tanuki>
References: <1de82b27-116a-450e-98c0-52eb65a8f608@gmail.com>
 <CAP8UFD1VAvnkM6afZvtpdXhA4csDBDwMnF9yUzSx_ut-Ypf+eA@mail.gmail.com>
 <Zbi8pfvGpYrlZXAu@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yf8Smmy+/++9RGAV"
Content-Disposition: inline
In-Reply-To: <Zbi8pfvGpYrlZXAu@tanuki>


--yf8Smmy+/++9RGAV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 10:08:53AM +0100, Patrick Steinhardt wrote:
> On Tue, Jan 30, 2024 at 09:38:48AM +0100, Christian Couder wrote:
> > On Mon, Jan 29, 2024 at 7:16=E2=80=AFPM Kaartic Sivaraam
> > <kaartic.sivaraam@gmail.com> wrote:
> [snip]
> > > The GSoC contributor application deadline is April 2 - 18:00 UTC, so
> > > (co-)mentors and org admins are already welcome to volunteer. As usua=
l,
> > > we also need project ideas to refresh our idea page from last year
> > > (https://git.github.io/SoC-2023-Ideas/). Feel free to share your
> > > thoughts and discuss.
> >=20
> > I am volunteering as both an Org Admin and a mentor too.
> >=20
> > I am not sure how many tests there are left to be ported to the new
> > unit test framework. Patrick told me about porting some reftable unit
> > tests to the new unit test framework though. So it might still work as
> > a GSoC project.
>=20
> Yes, the tests in t0032-reftable-unittest.sh should be ported over to
> the new unit test framework eventually, and I think that this might be a
> good GSoC project indeed.
>=20
> If there is interest I'd also be happy to draft up some more topics in
> the context of refs and the reftable backend. I'm sure there should be
> some topics here that would be a good fit for the GSoC project, and I'd
> be happy to mentor any such project in this context.

I noticed that the starting period falls right into my honeymoon from
June 17th until July 19th. This unfortunately makes it quite a lot
harder for me to mentor projects alone. Still, I'd be happy to co-mentor
or help out in other ways.

Patrick

--yf8Smmy+/++9RGAV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW6RssACgkQVbJhu7ck
PpTkPQ//Zdkq2YyItibehB+90lXRFN5ef/1aA7cVxc2V8DQkwItVuNB4JgcKVDJv
K3zugg7xDt7xIpNcd5hB71vRBvXLE5X2HDQFZHd2Z4cW2n9COQAS/g3SZ15TdF1Y
WpRyCwOMV/yyTd9AEW8glooULgZXaBPR5XDNkvgMWWXhBhzP1XKKhQ/tHnXMk7Cc
fUv/l8vwTAllf/uk9dnPEs/rfq2NaOjR6wLxyHX8t79UiyGRxawXV+4DVcZkRYCv
WM6H4BFpUbZt4IgIPplfrLClqlekRMaTiRWPwzvStynAN0fHukP+FXsNWUI7pUmV
5MCB+DAM9XruIyDAlD03lI5652cSsHdcYEHRe8J3vZkBRZwUNFPP/7Enb+siL6Oj
93evKU9L/BIQD/hFmzVOzwNNuN6v2gBXtpMZ7GEqWAYXBQeN5zTRdQfwrXpde0o7
N00XXS/1iVTZajvjsGGhBbKtHexDT4qC966O7ImfnmEoBtU9fQezxjWtp1zUYKBh
QdeLUXjEz0l6xdWLzOY/rhPPZ5z6sT516sCBjOb6P3UQXon2s0jShvml7XpFffCb
2V+aPitsyuLQN02EUeYdPhdYTW2y5vCD3o51wWMdMyQFubsTnTbfK9+fpV/H+2IR
m7aom6TxI5XXXwAF7bl7pNg9NxNH1lw5XLhnDdxnC+4sNSl/8x8=
=ql3y
-----END PGP SIGNATURE-----

--yf8Smmy+/++9RGAV--
