Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A20E16A390
	for <git@vger.kernel.org>; Wed, 29 May 2024 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716975004; cv=none; b=JP3unbwjwN5G9VyM0mTOc0bSd8XrvXsHHp7VboZHqRKKHWWETZOzkhmxcMj2SWKc3c3azVPRcXVP0Qm6vZKsCkcnbDRuSNC0OQDKpVAMR07ayrQp4ogWXuYrcbFgNb6DPADgL+Pxlj/XkNHc6+upn9OTFk8cthb3fpamxvfzWaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716975004; c=relaxed/simple;
	bh=4EMpQ1jZ55AUIQJTh8U/XXqdg6M49SiHgB5GYmlK3lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rtvv0ec5GiEIN7MDExZp3x6qsPrt7p9IPUw9ngem15sdsJ/gh7aJe5bbaFA8T9oehFLCLPTgHL2Z3slSRPwW+E2l6dqnKd9JX/c7RINktpbiTtGdeowsIFjhPXysWenIjm+yc/KNa87ZgQx8rJHGnb+mwydIlSZ5pG26m9HCnPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gO1GAXpm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oJHh5vVJ; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gO1GAXpm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oJHh5vVJ"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id A0D1E1800117;
	Wed, 29 May 2024 05:30:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 29 May 2024 05:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716975001; x=1717061401; bh=4EMpQ1jZ55
	AUIQJTh8U/XXqdg6M49SiHgB5GYmlK3lQ=; b=gO1GAXpmauAuZ+lvX9mckZMZIq
	33x7Kqn85uL12u/ylL8yPNRiM9GdSB8XPlpvSxtuX7oSLYb0hBw9jXT4IZD5hZ6f
	m5nEthhwcQjl/UHkbQDhCBtIJjii6eTPq3cB13i4rBiwBt6KKRWqkHRcx2AbP90I
	72ne+ZRg3PayGXcx5QIXND5+y4saTnqyLAAqH/exiohtacR5UBAbKeee6L3dXB0m
	LUu9arysIa8EB2vScDuQTbVLmdyL48XSF4FLSzUUdxVtHTT43JlsqZTJU/WiGF4C
	6Ju+wvyY2jbJLMCpF7TmAS7gcxKCa6kYw4q/dA1ZHvRuMVU8bGDeuVyMdjgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716975001; x=1717061401; bh=4EMpQ1jZ55AUIQJTh8U/XXqdg6M4
	9SiHgB5GYmlK3lQ=; b=oJHh5vVJ9f3IQIo3oQgibgzZTJDsWGv6PrZ+NxLwe//T
	otC+M4kXR0WOxx3v9Cb5pVv7TwxLe8SendcMYDtJRB05C6e4QSXXyQBcZMM2kVqb
	srQIpfuo4Aho+r36pgm9yqc4hyWyqKNJHhUe2X8qaEDkjX/KckKC/2e3/TD0byka
	WX+EvJncl04tTQWOtYXUPl6SByFMkPLu0sKIVnH7whWdPe1mWbJ1PYpRM1mS5+Yu
	mO/ykZyeJ2Bz9yvrIN6GgNjJ5tcM0dBq6qPJcC/zoV96YxGop41ElHtw6yLRm8Kt
	BCWzT3e6+Fx/a/N9jjjGGtE8hWE/fkPTONr9kJmXrg==
X-ME-Sender: <xms:mfVWZsZhZ8Dn4Zec0p8761wbPofLIePyIvpbNBsuRxw2LLKjjl8k4g>
    <xme:mfVWZnahWuyK7MK-0tu9D2das2GRWUkK_CK5v3E79ivjMv0KMiyOt9ChX1ssjP3e1
    T4pnRb2Ps_Rk2okag>
X-ME-Received: <xmr:mfVWZm8bzzMQ6pc6tzpyEaMc7dNupEmYl6xQfZEkNu5cTv2IvNpwwGrMjV_vGAsgoAzY_niWsxKU62UeKHi_dmUr_V_FTLo_M7Prnw2CNT8HrBxq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:mfVWZmrUC_MnSTB1fNOgYmqaLOJSmMfVt1x8F8V54Q7OwOPybCcvKQ>
    <xmx:mfVWZnpx3BapXUchYR4P_EnQEmbRAKOaG2Sq65lHR5msPGg42MeBaQ>
    <xmx:mfVWZkSJLrO1ALrijjrRVzdeLlXej5KW4jtjtFDBJX3GDWnDkL4M0g>
    <xmx:mfVWZnobcQ-xkLoZJiAjnuuj5Qern3JnGVhjyp-McJnwlMUNKr7fbg>
    <xmx:mfVWZmVTvfiCMkcDTpxrg5XP0DdwktnJHteNJq7OgZo3xMeDgyDQFxHs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 05:30:00 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0eddf363 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 09:29:44 +0000 (UTC)
Date: Wed, 29 May 2024 11:29:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v2 0/4] t: port reftable/basics_test.c to the unit
 testing
Message-ID: <Zlb1lLh-DcsOO2La@tanuki>
References: <--in-reply-to=20240528113856.8348-1-chandrapratap3519@gmail.com>
 <20240529070341.4248-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E5hr9poiVsP+HNEQ"
Content-Disposition: inline
In-Reply-To: <20240529070341.4248-1-chandrapratap3519@gmail.com>


--E5hr9poiVsP+HNEQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 12:25:08PM +0530, Chandra Pratap wrote:
> In the recent codebase update (commit 8bf6fbd, 2023-12-09), a new unit
> testing framework written entirely in C was introduced to the Git project
> aimed at simplifying testing and reducing test run times.
> Currently, tests for the reftable refs-backend are performed by a custom
> testing framework defined by reftable/test_framework.{c, h}. Port
> reftable/basics_test.c to the unit testing framework and improve upon
> the ported test.
>=20
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

The evolution of a patch series can be followed a bit easier if
subsequent versions are attached to the initial thread. You can do this
by passing e.g. `--in-reply-to=3D<message-id>` to git-format-patch(1),
where the message ID is the one of the cover letter of the first
version.

I'd also recommend to attach a range diff to your cover letter via the
`--range-diff=3D` parameter. This range diff helps the reviewer to spot
what has changed between your preceding version and this one.

Patrick

--E5hr9poiVsP+HNEQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZW9ZMACgkQVbJhu7ck
PpRG6w/8CH3hw4SN2qS0yKz2IVbX9MDGnIKHCiIUMGhai3WSTc+ulOWip/rG9hDY
NFJRlDgybTwRW9Qw8JUWh+ANqkKAmk8o7bxOMhvyyRvFRFMmDqO6UIGacEpbnmXQ
hCH8LlgP7UxFQz/ONrb+XvM+c1NWxwvLe74/te+o3+fnxpaGmsOmkyhijWokk0u5
lKq1z2sRa2rPYYySRQNtMWOg3mWaYuowbzNXv+8vG3hNbYX/Vb22/HCgzgTUQ6WV
a2xY3z1xdy8kmvlmDgLySiAHeuEIahwJO0aeKtHoXQdx9GLAWx00A3iXF63dS9M0
2hHAyICX7kjrOnTAfgP+bvpy7LofiTsCFp+Mjbuo3zh9josTt7WVsF+QtMxrVLSP
UG75AU1zT3kPBK8QIATLzVE9G5wZTUVhQd7mvl44tfHc03xqvasEaQ2OLiETm/MD
7EhFdIFJRbyVo9temRdKkX2bSZJDvzTsIuwQ6HnDVAWHXj9aKDJMVi0JxiNNBom2
WprkOjcW8SNk6lmdW+Veh3/X1PxFuaSWePXTDMP6rrub33Zx2peaMnK9KhQI2eVU
Fg2LWLl8KP/4642+WL+ct/wGBMTaiuL0L5/H7oe8UYTPvQvChaObLsgvibdwmsQO
uVFDRwsrxE+WEFoOGf2i5P+eA9SsiOb8IIxDIjECKBKooMCS0zQ=
=YrDo
-----END PGP SIGNATURE-----

--E5hr9poiVsP+HNEQ--
