Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0491C11
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 06:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705473046; cv=none; b=XH6LGjQUCCaIYXxCQt+Iq4++qPOL5IPeDLQL2fBGvme9t8SxLD/xmLqqbncHhsmu15oZ3TuOoJ+yuwuF5Zmb7G2FMJAIhgKJLNSG1fnWUGxq9NFq0sLRLNWdLpDTMcqc7GA/b5mi2CAKe6yV1mE4LT2Z+PIhkwQ1nHd+7Aao+1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705473046; c=relaxed/simple;
	bh=7GsGFacQ7z2VRHHwEWpV/yfWF+u94I2RXrhiipc7JrU=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=r7WiNtE/DGaTVowNFvaMFs/kDoPPt4USuLaGFnQ6+6ltOwR0et4B07eWXPQQ0HQBPq//tbUiSH1/kXW1iWGvD8bduKVfvuvyp9JeUFJ9vq89esRo5M6xuVB4i3DwEpiSgevOfoRs7zkNhxXf+KzmKe7h+lO61SEcSlL7mRdqwaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oxEEceOg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ULLfAKNp; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oxEEceOg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ULLfAKNp"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id B2D413200B3C;
	Wed, 17 Jan 2024 01:30:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 17 Jan 2024 01:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705473041; x=1705559441; bh=7GsGFacQ7z
	2VRHHwEWpV/yfWF+u94I2RXrhiipc7JrU=; b=oxEEceOgoSENevAcbNXL/EINkR
	zd2vQf+ZUt1c1vUPqE8UhxVDYnran4KxfRekWcC6Pd6KFOs0DZ7qn8qn6mbxbpP5
	jFB9JysLN+5a3biu/xRdw27elcdJFJfLKQWPmzBjAt/epHDlsqT05kS0XIE+zTSB
	6nE82+e+VygY0wBxiJ0DcgpkzZRMUbXUdjFaJ4V/G9h0h5J1uYrXrQDZ6M9172WZ
	xTbZxsVs+kNhEL+jVysPfv4MbB7uY9ImQn/evGJwGFVZ54USf3exyca3//5MBXVP
	CO55dNfs8GUZ8JJwQKjS8LGztJIpTsad+ITsQhokEZ9ahaT3uIkijh1xpuXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705473041; x=1705559441; bh=7GsGFacQ7z2VRHHwEWpV/yfWF+u9
	4I2RXrhiipc7JrU=; b=ULLfAKNpHsjD1BwYprv2XLuOJZKVvvA00V0werk/zG1Y
	PeyLtxIilHhZ3vl0cynNa2yIw17Ii1tRzrexELpnvZ8okLZbOnlq0MxFnZUJjR23
	46XH4nKnKDOVt/46MdN0iY9BosEZeWtSsa3ViPUqui1eJsdkrvs8nQWLcuOl4rvc
	eoQaR5sW5EG1cGuatcC1rw0VuvFJRevjqImj2Aj8LKZo5b/gdqLOJMF7393DIV9d
	hgRksJXkzhGfbp8Rg89LZYWJ3ZNM/v1iKwCkRsPnILgRfQgrh5bvul1GNmvgxSJV
	EQAH5OY8YIo7HR6DCwkgtDrMnCDt1g5WdFTfu4CdjA==
X-ME-Sender: <xms:EHSnZSvT7o4HwXLHoSSzif3dEnUcgHVtWckqZH3aThYN6Xe_yxQqrA>
    <xme:EHSnZXenAqvGOpEKgPng4fklBjC8TwVhKM8zcgvbBwXvnS0SPmfoHmqPCJnxQPeLI
    9Jy3xU9Q0pwNzqElw>
X-ME-Received: <xmr:EHSnZdyPqr3x1sOC0YCetjmPsX1j475VtN8Ov1lODUZidlA2Pwp20RudJ6gL7yswOyW9NTNmmPathNYt8eiXp471Wnvbkk84tCJawVHQAKvQessZog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejgedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:EHSnZdNUkqp218I9vE413rBGDAoSMqOctlEfjO327YfHr8Qiw6JoDg>
    <xmx:EHSnZS90S4FH9CyjRiN5fxgLDCN448_yiJkr5f5jKCt8NnV16pccgQ>
    <xmx:EHSnZVVOvTX1n18T2OH1wMLdwl8CP-FmTz7IimhaGKXdqVdjCK7PrQ>
    <xmx:EXSnZYkHYkqCh6pDo6bn_6Cwh6HRAkRE46sPAa2jJbS7flI-FsAHJg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jan 2024 01:30:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ba3c0af8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jan 2024 06:26:29 +0000 (UTC)
Date: Wed, 17 Jan 2024 07:29:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] builtin/show-ref: treat directory directory as
 non-existing in --exists
Message-ID: <ZadzwA6vNnRPbKYh@tanuki>
References: <20240110141559.387815-1-toon@iotcl.com>
 <20240110141559.387815-2-toon@iotcl.com>
 <CAPig+cTRHHJ3pzWJtVJf8rKhvAJFYqrO0JsyTRTi6T5s+gznDg@mail.gmail.com>
 <874jflfc26.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cQ+i0fHxjQ1OWXM4"
Content-Disposition: inline
In-Reply-To: <874jflfc26.fsf@iotcl.com>


--cQ+i0fHxjQ1OWXM4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 04:20:41PM +0100, Toon Claes wrote:
>=20
> Eric Sunshine <sunshine@sunshineco.com> writes:
>=20
> > It may not be worth a reroll, but I found the explanation you gave in
> > the cover letter more illuminating than what is written above for
> > explaining why this change is desirable. In particular, the discussion
> > of the reftable backend was very helpful.
>=20
> Well, I wasn't sure the explanation would be relevant in the present,
> because the reftable backend might happen relatively far into the
> future.

I think it's not _that_ far in the future anymore. All prerequisite
topics are in flight already, so I expect that I can send the reftable
backend's implementation upstream around the end of January or start of
February. It will surely require several iterations, but we might be
able to land it in v2.44 (very optimistic) or v2.45 (more reasonable).

With that in mind I think it is okay to already mention the new backend
in commit messages -- at least I have been doing that, as well. Also,
the tree already knows about the reftable backend because we have both
the library and technical documentation in it for quite some time
already.

The patch itself looks good to me, thanks! Whether we want to reroll
just to amend the commit message I'll leave to you and others to decide.

Patrick

--cQ+i0fHxjQ1OWXM4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWnc78ACgkQVbJhu7ck
PpSscA//fim1NiCjlkDLYv0Ui2Oa0zHPqyJbk9nLFwr1qkYSXNWeZjtiL1KxwzFi
R5pq0vmi0qmygFCvRwfgGDHPUyocZexoK98nqoE5YGuIdKeAgD/WHrmXVCkr3wvM
vqJTmwMYmR2KeMBuleIy+Fls9Dkd0HpsKPQjwx3zlBp4ianARuaDG11Iw9VcD6st
XuT7QsEBGVCzu8vRVWeitPxA+j+k5n1JJudHRv9IS0exxUazeZoimr5NlvP2dIZN
e0wVy667BTDMkAW4brsOy3pnYjRVl0UgW7cM5YPr4Y7B/0nmcY2EwCTGiLNZcMHi
Fuk/v86m+YZTKibTSt9JDrXP51Wc9xZOE21cZVgz9QgS2GMWcFEqXX1m7D8ubN9O
FYGiUB+Bmo3J2Lhqi1ReTq3lAhdntOvTIVAq2pZPX4AkGfLcw0bUn5xoIj/mhn84
Na4BO8zvCdw0OdT//PfNqweW0IsX55kywaOTVzNSBbSlrYeThQzINLtdaa/eKioA
aGSVVF49I/N4LPDYp/Sss0A4B/C4excT4UyKHhZUy4ES56c0ZAzzJUOrYFMf4MmL
SNoyniKEpvravq3ezm5hUIAVT0YTo5kNzMcX25qlKcgBYGnYuNpN/71QirGfMsHS
OKm8n/ys0cn5/3SN7XPsXcnmzynawdvMDh2pf/0ftCvcrV7k+aI=
=CaiN
-----END PGP SIGNATURE-----

--cQ+i0fHxjQ1OWXM4--
