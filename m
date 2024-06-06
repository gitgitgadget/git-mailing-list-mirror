Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E575E8821
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 04:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717648550; cv=none; b=iCfXA7jv7jP96Tt3J7hPQKTeimjso2bCXkMELxP7qitkeoil0qK++WwKNgHg4xCBCEOKGhspIAoFMN5J1850+A0uu/mpEMxepqD1zB0FqFTOFJHKEnVikaKYB0KpJdFeArm6cCbnGJEtB5Cj9loKwAYU2eDp5qMQgrtxnzAbnNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717648550; c=relaxed/simple;
	bh=ZaFXPCezpjxe/fy6ZajabxPcU7xDNW8x+/tXQfO6SYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skeGlE71bkAYJ9SvYbM7WX14iV+Mdd0HnCMRstY8bZVPHmzcumqco/1r/4orl4+Dhw8NXF6PoCGAUoQGDm6t+wn7/sE0EWU0XndAcsWj7thZyeW4jrQNVE2vFZQx90mNcbpW8gSRNo8ccVl5Vd6pPKK7Rg8IuPBlxZCGIAbkKPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gvvDrXuG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V062GmvB; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gvvDrXuG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V062GmvB"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4754A18001D5;
	Thu,  6 Jun 2024 00:35:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 06 Jun 2024 00:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717648545; x=1717734945; bh=ZaFXPCezpj
	xe/fy6ZajabxPcU7xDNW8x+/tXQfO6SYE=; b=gvvDrXuGn7wRPTt0nPUbvv2So+
	q+DGUNccjI9L73e1r38KuVRfB+z6kEmiT+/QkQ/sncrKk0SvU2n4wJrUxJjEYhQv
	/X+rL9kE1t46Hm3fF9/jxJw9Q+n8uhdbANzN3y9iQaNOlMZHCpKNHYlTC+i5StOr
	fv4D6u9fSxNVDEXX41jjc3jFLsKXer6rnxgWkbDJsMJb8/vNYBp/guiuW153heMn
	gwSVFfe1bVHO2mPW4GgSMUdtAssdHEHUrV9XOmR40QYuA2lE5vV2Ql1raA4oaM1s
	FBC86YMYHxf1ss+3EaRlmYqhWzChqEhSXiH7j8k/xTfoN6ecbZmjPv0jB5FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717648545; x=1717734945; bh=ZaFXPCezpjxe/fy6ZajabxPcU7xD
	NW8x+/tXQfO6SYE=; b=V062GmvB0uEeFDcnl9LtpMsmhGl2PEy78cNWW+TlwR7O
	t04nPphdbdRzMnDmfCAXg2Lfwb5WDCsfqCKmYS8JWjM0axbc4KFO3ij5HBSwc7mI
	F7ppRiU9yiiy0SqRcMrQU3FX8QT5CIq31FLIaKW4lFJulzY7A2v1zyzWfl5XlBpo
	IyeGfCJqL8ZX4UmYHABxwSbL8spVPbdy5Pl5QSd4i9kKesIk86ybr8TvPx7up/T2
	h0EjG37xGFZcmNf/e9rxp21hOuRIvJyBZXTcyizhlVYVBQxLhLREVd5PvppQhrKu
	j/aV3eN94uY509mYg1h4EXqRr2UjfLnzdVn+eJyLDg==
X-ME-Sender: <xms:oTxhZmSyksAtJwFinr2TjdMwFX9-qqgAGF3f4ed3KzE0EDGanvnyZg>
    <xme:oTxhZrzo4T7tauVhOOfbS93-14cc9DXke7l4FFpCoh0H48H81gCQcggQr4FpB-NJM
    mjTmX_4MvmFUdvAdg>
X-ME-Received: <xmr:oTxhZj1Y-UnuwBj8VKmH_ol8jKDBF2dUCskVEYJhC0_Nfn2hnEcSYgiNoXgIyi9AKfTNtyvhWLYBFsl-efuepjAy60qpiHd-xcUJtJWyFw1-YPMv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:oTxhZiDMkAewPkQ8QcW3-L54l7al5qL7-rSZqPmRCM9W3GxX81tUfg>
    <xmx:oTxhZvhtz3kPIHDfc4tvHS5tsanVs-27-YxM94_HK_1s257UyKnGfg>
    <xmx:oTxhZuo-pStBMiic3LphF3Ej0YAEim9rtD0SyjAucZ21scQbXetA_Q>
    <xmx:oTxhZiiXN2qVFiem3PtruDFvyK38Pn6m19xFHjf_nYzMVc3blafxCg>
    <xmx:oTxhZgXKUs7uy3VOOS58WeOi56AB46CnyqF8Xk3FMdNM4pSxKyb6mAan>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 00:35:43 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 97377335 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 04:35:11 +0000 (UTC)
Date: Thu, 6 Jun 2024 06:35:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v6 1/4] docs: introduce document to announce breaking
 changes
Message-ID: <ZmE8myG5c99UJeCA@tanuki>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717504292.git.ps@pks.im>
 <a260bbf281d2975562a042a71ca0dd7f88f03da4.1717504292.git.ps@pks.im>
 <xmqqsexsvbaf.fsf@gitster.g>
 <Zl_4IIqFmoPhx1Gc@tanuki>
 <xmqqjzj3wf4m.fsf@gitster.g>
 <xmqqplsvs2et.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t5kxysbYttm9x9ua"
Content-Disposition: inline
In-Reply-To: <xmqqplsvs2et.fsf@gitster.g>


--t5kxysbYttm9x9ua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 10:52:10AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > But "in retrospect we should have called it 2.0" is patently false;
> > switching from 3-tuple version numbers to 2-tuple version numbers
> > has nothing to do with introducing breaking changes.
>=20
> I tried to make it concise, and came up with the following on top of
> tweaked [v6 1/4] on 'seen'.

That is a good addition indeed and nicely explains what was going on
back then, and how we handle it today. Thanks!

Patrick

--t5kxysbYttm9x9ua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhPJUACgkQVbJhu7ck
PpTikRAAoF8zM1yHlyjBZ5IB0QxQmc3oVipKQl/l9DQSE7Wrx4Pd4fMPXOaj6YLZ
hVPm6+DbVEShwHn2rb6tOVlkITlE+WYDvdBpxGazcsoO1elkixCoXrsVyyueIt2X
03rLXrSjbapu/zaJWFqd4XYuRTl8HSUQ9ruc7xQG92DU9FA/OJkAmFT0hg8zC7ru
hfrOkjke4w6z0jd6sKAvGkXMZB6JfSMDa2+REk6usPhhebgd+DwZuH5n9KsqTQ+N
Yd/lPnfC6LBm4Nxi1EX7VHpPhJ+WVL4+FPUvshco04wcvgXWtAehubmFSne8dkIx
YKXD/IGDfTHz3P/kbQhZfOnKzOPIt7gWYtHp3WOLJSC76JJ5ZzyWN4NjMBrJsWLC
MakYhK+B3Sv4zx1Jxu0LUz3M/jxdDZ6vKGCBZsg6ZXAhyQ0+Qqw7OHUEJNqg87eI
WmvzCxUfTV7t/cbVwyhlpjprr9DloVIW4k67yIhHwW23iqEY2KkFOmZG1Ll/610x
gJlGUNDz35JT7qrhFvJHcJm8h1yWml5F0KjNd/RNlSpVkfXfh5ca8tvkSNjRHhv+
x544G6sd4Ob8Qs+IfgAMkxNCesY2c7r4vtbhVpNNQ7/Eh+5nQFgro9d7F3AiRYxW
2uGD8uMUsP8conVtugzAVZPbko6wrBuR51T3bfwxwGC4rKZB27Y=
=pW81
-----END PGP SIGNATURE-----

--t5kxysbYttm9x9ua--
