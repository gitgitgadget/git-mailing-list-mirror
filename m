Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD145427E
	for <git@vger.kernel.org>; Tue, 14 May 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715698364; cv=none; b=hbCaWNO/mzGznkCLjjOtq0HAnizsSwkLtRPNlu27dXHXoqczJhtH1L1GcIUb8Ke2NvvlRd2cSmlVXkhvO957j22KBGxCUXIdfXESPAzzjTsUXTkavnqkHj/dthccidP2bzhtbqWaVzL2Y3/JQqS8RurmNAp+Yi3k4kU1uWcwwow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715698364; c=relaxed/simple;
	bh=ndMapiWftcDWMX4WLkgqb/Gfw26Jr8l0MDHxdvQCapI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRCPD3o3Gw3l6j8MXBIT+UKCo2sayQJQFSSTRM7dQz+gr8N/SVu3bSiNCddSKkMl0v4vVOQmdaXDc6L/V0ntIrOrvxnl2gnZULbA65jC62Nu6pNQwU3/7yDjlLB3/D7LFs/Wfh19s4LNVnMc/TQbr0WEPaqV79N5aTv3gmIk+dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lNmlHghw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rr/U3rK+; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lNmlHghw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rr/U3rK+"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 052181800117;
	Tue, 14 May 2024 10:52:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 14 May 2024 10:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715698360; x=1715784760; bh=Zjrxs3DsDC
	7RIijcjxvmUdkOJgssWkiC9XI6P8FtORo=; b=lNmlHghwxng8lgMMR+Y2BVG8Xy
	+kLlrjZMW21qaPYHF+dQClBoJYSTZ7d0vI1TDAThhodSmfwmS/Va3bMaTrqzid6/
	5BVg+bFObbmBjaKjaNMdhOqq6aB6iAfZczAxAS7joZDXyHlmJDoVIGAutK0pxua4
	Riw+cCKPXXenY/o24qgg1y7iLHyig2tHp+/ZftsK0jk/5mkGWCtNypWSki2uL6r0
	0hy8gPmEb8h7H36DXxAksi0C2kaI8wGd85pLuYrdgptzrnco5gzkVpEtSt6GyJUr
	GbKwfAd0Dl0MZb9B5V71NQXYn81R1LBzVqiPP2aUmnn/5OiUl0LYx2HE7BfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715698360; x=1715784760; bh=Zjrxs3DsDC7RIijcjxvmUdkOJgss
	WkiC9XI6P8FtORo=; b=Rr/U3rK+gHORPoq/WxC8tEHM8Ty+GkIoLXO1JiPT11RM
	1cPTiF/V/rqwVX4H34n0R3gqEgN6HOKdp80m4oIM0H10jffN3od3DgKeYEfX4Oh0
	PhYbIi5WM8M/ZrQYESIEtxs90HP904cmKYtMdLSL92g1JxYKPOCrAx+r6Apk/6Oy
	HNhhcl4tB3EFdCjJ7Ll9KPDx1gamq7KxGlTCBh0UvZefrglbAggMK/BmEKQAH3FQ
	AFsXkAAgpztS1xZkd2jeikebY76daKMYqiOYLZBBs47XF2MXUa0h4DdQOuXgjTzP
	lxuD5jycYxTXZW0hYVwqNwQGsX+cu9ZHVB9YFAOVoA==
X-ME-Sender: <xms:uHpDZuHNXEnedqTNEsCN-KHrJLEGfk_RHpxyQqx6pb-1keDj2ZUsNA>
    <xme:uHpDZvXq3c4OSnWem4-jTRglnDS1-Q1rbwGL-cG_ArQruwqRC4sgZ9oqc3C6jK37X
    0dEe_9Y47gqJz_qlQ>
X-ME-Received: <xmr:uHpDZoKA0XzAzQ8ajNPzgrkEcQUAsvsRf6_sVKbgQ7PwZFcnb9pL2AqUdwmQrdisL4gkhj9Wnr4s-09bPw-W7gfekbaQoPUiyRuMx6fdhjlAPo2py8Je>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegiedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:uHpDZoHvY9cU1V0vVOsUB46FlQKICLSQAA1n6pwqRPXlYD3o2wCndA>
    <xmx:uHpDZkWk6mNCfh8vbk7oSbAi49h6inbdqjHEFjJDg3qoalV1ARhtOA>
    <xmx:uHpDZrOLACGKgk_2EiwiYQEI0UUJjiE8P0qW0JO_25cxviruV2trTg>
    <xmx:uHpDZr3eXwCRi9fXCrxdlJvj-Z3vydplmKonPLG144pS7xCJU9TmpA>
    <xmx:uHpDZiyo9YD9n8jz4gmkOzot6bOM-VVUt_ov3FfykVICrHBARRRmcwC1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 May 2024 10:52:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d6fbd163 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 May 2024 14:52:16 +0000 (UTC)
Date: Tue, 14 May 2024 16:52:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/21] builtin/config: remove global state
Message-ID: <ZkN6s1OYfJOpy7x3@tanuki>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
 <xmqqzfss78kw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p4BGGEt3p1yn7J3A"
Content-Disposition: inline
In-Reply-To: <xmqqzfss78kw.fsf@gitster.g>


--p4BGGEt3p1yn7J3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 07:48:47AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > this is the second version of my patch series that removes global state
> > from "builtin/config.c". Changes compared to v1:
> >
> >   - Reinstated a comment in patch 5.
> >
> >   - Fixed a memory leak in patch 9.
> >
> >   - A couple of commit message fixes.
> >
> > The series continues to build on top of ps/config-subcommands.
>=20
> I do not offhand know if this iteration has already been seen by me,
> but a few recent CI runs of 'seen' did break with *-leaks jobs in
> t13XX series around "config".  Hopefully with the fix in "patch 9"
> listed above the problem has gone away?  We'll know soon enough when
> I push out the integration result.

I think so, yes. v1 also broke pipelines at GitLab -- I didn't notice
though because pipelines had already been broken due to the Python 2
deprecation in Ubuntu 24.04, so I missed that there were in fact
multiple issues. The GitLab pipeline now passes with v2, so I assume
that it would also pass in GitHub now.

Patrick

--p4BGGEt3p1yn7J3A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZDerIACgkQVbJhu7ck
PpQH9A//SijuXktYmuMCXLE/s+anZdkJSRZeKKljcGRPwkCzbLMGoY1hL25rbfhz
nAYPByv9vLjThik7JX6rBSwP15UTOBDT10lzjSNhLXGu1YqAipY3gG7pGFbfvmRR
mdUu9WV5AzucCMOg1eIgKpZEgcn0ECu902y1bn5akgiZFpQbRSBTn12sKjWRFpZy
Odf9dw8O87guAN4XbaqFUKWBN1aiPCKbnyoht4KWRbRBB6V4YRdMI3jmdDg9yvOD
VTzFbKsDXVu6AUz6iuEG34qP+zC0LQhbQDAqDL/YzVaF/IbiRBM4GNXHSvIH3up2
d5bg/l2CLx/TjLUU4sRPewYAr23lLKEKHfQVwdHU/R2IAg1nTFYu67CY3wPGC++B
ReawE3n8hMhhvbxcyHbEFun4JTy7hDEEgByQ1YXU9d7ZdvSo0/KJde+I/MuZmos/
PP/qn4Za9z8lc4Itx/fAnfGJoM/uYKLStWDOD7TdPYbkKBx2BmB9LfJcObc56m2X
cJj/b4ISVNjYpSchoYepy9hJgRa0c9gX/cHsAWGXh2z18iaUCitCIcombLMP6q0Q
Fwqz5IaPAxHPc6D1IG7n3ryxKWiW1n2eziSn+yeb0V5RXQKOFXKwUmfxNYH9WjaK
vj3wwNmc7eUFvtA6ni6Zfrs8L9Hpp8tT1rZBpsiCU6DZqvG0StE=
=4aZY
-----END PGP SIGNATURE-----

--p4BGGEt3p1yn7J3A--
