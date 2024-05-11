Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09191B7F7
	for <git@vger.kernel.org>; Sat, 11 May 2024 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715448098; cv=none; b=MUd7i54kLhcKkJ+OTqmYY1fyY2cqIEdC1smhq90TZou2cnMwYJUDUXZcezEzj8Ss14v4bIBztcRS50YaN7Eu94iXt/SaYF5UT478VAxxdg8gFTlsrPwaa41e3m4MXlAv31/kXPB2WKBEaxl+4uGesFSxgkal11YH1kpdsOL54Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715448098; c=relaxed/simple;
	bh=1xLcauc2qBF3SQa3BU8xLCmeP9/hh71tP0ozLWIu8+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUyXD7KiFVudQgVESX/boHMlE+kbbMCaxVAIaxC6v3+WEOsK5jlZMdq0Iflb5KdiC+MoCyG7E/g+bpKwow4tyBnP1rlsScbop3ul+Vw6iYpGqj/RIu2ze3sC3Peo36rDrj5waMSEE5Ko22TZQaKe6+Fzxa9jFcfmQyewk8iSo6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mzcyGXHi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U8UwUnAz; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mzcyGXHi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U8UwUnAz"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E2DB111400B1;
	Sat, 11 May 2024 13:21:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 11 May 2024 13:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715448094; x=1715534494; bh=wzbQUVOyQS
	1sh09j1QA0RL2Ki2D4xPJ3agYsMzPV2eU=; b=mzcyGXHi0Q+pvjMlxxT++sMAVg
	3lYO2dguXkVjMudH0UoTEo7clPUcrV4zdAIipt96ScB0DTejeP7OanH7hcaWncUD
	8A4bOLpgtJQVYyqYmrWh+pv5HtrWMgA/ZAEcXQlN+9VYhLwrjseDYhP/KlUdRMCQ
	B0GDfVuM4KjNmgAmZ3kHp7NOrPR+VI6MWq9dP1ce7tNR6yaUQOAXq5sFt6zQV1bw
	alsQfdlWflH/HfJrVHKtVUXyw1XVRVdxfxG11DbvUed0pY6tQvkxQlV15qzUlOP1
	G6v5V7MdnOAxHJkiCxoe9sfQjsxoeou3t8GnQ49/6N/5cX6j5zu6HiZH3PZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715448094; x=1715534494; bh=wzbQUVOyQS1sh09j1QA0RL2Ki2D4
	xPJ3agYsMzPV2eU=; b=U8UwUnAzPrIQT7+R+hBov1aGoEGXMOt3kYPFwAfTF5Fe
	xrBWZiFQaFu0267MwblAAneMI8vWottBfhsZITq13N8XaTRm+rfB6dCh0RqOrl5s
	4EiSu6QOhQm1tAeTs3TX6hDNSl/puAivtnuUm+Tm1y6rApgpE3nu+gkwnB4uxwfS
	8haikYHcmZwBwNoeLK/NKEu/PFxKjARoVLFhrnYLXCzmRd01wJIynds00kCRtBPZ
	ywtphZemIYaMKnOuxtr3E9WzxhpDXmYI9W/WpXZC96vRdiiL+VyKTKlYwUuVPLis
	l6E+xgY40xCTKrIRWKeHP7MK9ZhEsMO+mEJr8itAHQ==
X-ME-Sender: <xms:Hqk_Zpb53tPTks4Qu-ix789yGY0_0m189ExUqmx6DVEwsSh2jAG4pA>
    <xme:Hqk_ZgYla_yMqDXmocexvBQJtUWcwqG89RPfbMKs2kmwNZyWB_WBsK_SLJ2Oucere
    cuXFEALkE7GeCgVMw>
X-ME-Received: <xmr:Hqk_Zr9_ygn9AO1Ijv8OKOA1VH_Iq6EINrX2_TlrgaSGyebZEhEJS-Ed4cYh_Ejp2mXrItP3EJmUY3Dw-R_ObuAgnIXyeuLcqZTEukJi5oPp7HLajw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegtddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Hqk_Znpq9cT5e1TZuE3py3yOoIj-iF42fMsIbCJ8dWldOzicgDDPww>
    <xmx:Hqk_Zkq244rLM4f9Y-WQUC5Zjsb5lQ19gHGDyEEg7bnGNMQElqWvkA>
    <xmx:Hqk_ZtS12XHaF8f3DPbeb1udioJRbb1XrpJLPIHYN7MeGbCklFdpNQ>
    <xmx:Hqk_Zsp0HP1OqmJCcb49dE3n5WbS34WPCoNdqFjI7MgkL652kpDQNQ>
    <xmx:Hqk_ZtkSWPmmeNKk-NnIR-MUXe7Mo43K_flWWaMc2TRxdEJfhn0W9WEf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 May 2024 13:21:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 76dad8e5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 11 May 2024 17:21:15 +0000 (UTC)
Date: Sat, 11 May 2024 19:21:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Kyle Lippincott <spectral@google.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/3] ci: avoid bare "gcc" for osx-gcc job
Message-ID: <Zj-pGGGJEXlH02nR@framework>
References: <20240509162219.GA1707955@coredump.intra.peff.net>
 <20240509162415.GB1708042@coredump.intra.peff.net>
 <CAO_smVhE25ZQqc1f_fx9oPX-kH8SHxwEc=mqOAi-xQ91+pF1CA@mail.gmail.com>
 <20240510220228.GA1962678@coredump.intra.peff.net>
 <xmqqseyp1dys.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K1g1Hu1M2Vhj1Hbo"
Content-Disposition: inline
In-Reply-To: <xmqqseyp1dys.fsf@gitster.g>


--K1g1Hu1M2Vhj1Hbo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 03:47:39PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
[snip]
> > [1] Another quirk is that we run the whole test suite for both
> >     compilers, which is probably overkill. The main value in comparing
> >     gcc vs clang is that we don't use any constructs that the compiler
> >     complains about. It's _possible_ for there to be a construct that
> >     the compiler does not notice but which causes a runtime difference
> >     (say, undefined behavior which happens to work out on one compiler),
> >     but I think we're again hitting diminishing returns.
>=20
> Yeah, that is a very good point.

On Linux, we have the "pedantic" job that runs Fedora and only compiles
the sources with DEVOPTS=3Dpedantic without running any of the tests. We
could do the same on macOS.

Patrick

--K1g1Hu1M2Vhj1Hbo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY/qRMACgkQVbJhu7ck
PpTbnBAAnKdWkKdcJjouIve3u5FNUvqaPYjelseVFBBb7j6QFGHzosg6x+DUmBga
WRxiBZkOccSAWrwMY4RR3j2LfIBJZP9WpACxuB0MD/CGiHm0vj11YPZyp1XPE9Ci
o3haqPHdaYea/k7DolIoqwoJCOieB1WTouiRWE8GQLytXazYr7BDxX7KiuQz4gVA
M1kyVVRngv2zU7Jz0+11SB+s/SDkMW9mUAo6V64jl7EnlBXvnZ0WzBCp8/WCJ8wh
RFFsE4z4rYOJXiM45Do/R2lW/QThb8HWWeQd/2RdUayg21wrmF4B5hPoeXPydd5H
KMQQSUBdND8n7m7UZHHAQPpgyuZbRIKS8+9UCvMBXeUQBwGgpXQAPPfHAqCWYslK
fEJq8ouBILglo/XnvomSyLzSobd8LWF+9YI3ye5Ea9J2p6qi2Cq6DBnqhLVItWKR
fxUSsME5HdkGM1ITjjyOVTtHJ/OUVeVU540naPY5wwUEoPATEdTbfMB5XVRmAsN/
t+jeyTPIr1bVwFu+m9ncHfyNbQNmDTrXRni/CSY3qdCkeIYuw+YQ1nqZ9k9ozoah
XPbwJrBPYnGfM2WIbK9gType78bUwf4iDLYV+uvsriygJakGhK+BjA2yp4HNhXPi
Zb1nALqChShZq3+4ShDLEmmCGjU140M18JIA4n2fhMBFupU7AWw=
=O1wP
-----END PGP SIGNATURE-----

--K1g1Hu1M2Vhj1Hbo--
