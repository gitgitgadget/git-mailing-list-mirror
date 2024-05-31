Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CF31E488
	for <git@vger.kernel.org>; Fri, 31 May 2024 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154162; cv=none; b=Bh6JemL/dCIM4KEKYKoNg6gtsC3M0rS3nnNxWWQ60x7VR1hmEldZnpS6uXX9/ZpQbxAGQm9eHVTcSG0Oy4idZCq2uFzqUnBosmdtAZmNBNVYmeyVG0ZOIiFOxtSGTDC0FPomq9paE9Rxz3Kesl8W3aJuN7sNeX7MEZjCeXXrNNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154162; c=relaxed/simple;
	bh=D9MQHaCt0Lk4vPBQoHYIl+p0IgizAYEwztb1zHWXoEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyGcVV+wSxefhd1ox++ZhJMfIhCi4s0GIT5EABmVpjlI0Q7EOt5eKggCB21MskZ8MhrAV5n2T21bNqKhNLxD8mVJgHT5hbpHWDhhqoFzkHg5DXwWhthmiF+CNoQ06DjaafXOOCeIjT+1nncOBiCqFcKrfaPQHoleoEKvxCHljwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W8eoXCx0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a5EMQ1sb; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W8eoXCx0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a5EMQ1sb"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id D13CF13801A4;
	Fri, 31 May 2024 07:15:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 31 May 2024 07:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717154159; x=1717240559; bh=49Kp+wuBuN
	tyAIKsVnLaGS81UxO81qfu6p+xPL/8XuU=; b=W8eoXCx0cw7bUXP8FFwawKbiqT
	SGqy8A98rOOyBWUxUh/6AjSc4ifNRPILSz+qCrOL1wTm/eIA3PpEgmSbrDyXF0FV
	/vGkjaR8nRlzvjzvMWr9xpMjhne7Lkn3EbMcOuLLat2OsmLLqNiXCunwUXP1DONG
	qt+QawFcHGrHZcjriQZyY+4iDT3GHL7j8zeS2PRkBK9rr5ezv75kj4ObkNO+ZHAn
	KdOEuzDNHZYpwa/DaMsNsI7faEXgX5nnMYiGFcBK/Eq5eJTD517lj1wZX3dflXOw
	tvL5vPsOY/lkK0knYk4RuIpRp/eqth6dmfXrBig7c6v46tHWxFz6oJomm9gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717154159; x=1717240559; bh=49Kp+wuBuNtyAIKsVnLaGS81UxO8
	1qfu6p+xPL/8XuU=; b=a5EMQ1sbiDumnjB3hWdvUQfaYeEBD5MscqfULCrYoX7b
	BVRDUiDYpgB0GJ/6xgJpRUqSq0pu4roQhpqPhog1bu1xGvz1ihuH2nwCo7p/L6Yr
	PGae1Lk/KsIQ9m5MmaBQP1FRjAygJNNBNiqJ0ky1ogpTO+rhVW1u2KycKidmurHy
	rS2zBFJCJO2Nvdge988Sfmjjk8kV1z+fOcGscCNonSVvoYiynBWJU0qJrrCXVA8H
	LJwnGNWSXb663yhZ/3twW8vKJ9m7KNPyLuX8+bt2ydb1HT7FL3lJ8x5c3grIjTlR
	0A2xmdu/cTvrcbZ4MSKey1AzbqyOYfqc8xE4BY/Ajg==
X-ME-Sender: <xms:b7FZZlISbGEtLy7QvA7JHWQuXav05Ar66ql66v3glqYAtFHLji1PRw>
    <xme:b7FZZhKVB9u4jyfIG5AmLINQ1UG-eD-90_LLnMPHJLb5GAAneI0wcg1xOM5WNz1XX
    8K69dDQ8SfjSEksYQ>
X-ME-Received: <xmr:b7FZZtv8IBIoBUn0ueFj1IuPrxap7YUf1LLejqz4OLXDRrlRXDGVHlbrcxJmMm63hUYvUQwgH-XjrV-G8mFcweeGC1FhJ-Yh3CkIb2bgnuWGySQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekiedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:b7FZZmbX_6N5MJo2yUHyAGMRkKpTxC15zMnw6CC647a_QE-eos7Cig>
    <xmx:b7FZZsYewPEzOaNg5w1wn_L31UGyxPpaX55X8k_jWdZsYzIEWwGqFg>
    <xmx:b7FZZqCa4R0dWHlvVZXodbpl7M7fsqfJgljtit5dArPOP1JmSEUlSA>
    <xmx:b7FZZqYnGCiiprsvdXbwJ0ntXaSt94JdMA9INby6wFIIAc1YUhWMiw>
    <xmx:b7FZZs6HqOpU59RSwYGdk1OV-YlT5Y3k_Qu-xSbbXQOvu98HaXEfCI9v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 May 2024 07:15:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ff96c796 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 May 2024 11:15:36 +0000 (UTC)
Date: Fri, 31 May 2024 13:15:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 0/4] docs: document upcoming breaking changes
Message-ID: <ZlmxaNF94XbaTxxY@tanuki>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717141598.git.ps@pks.im>
 <xmqqr0dijrrh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aj7DNaHuDRqlM1yM"
Content-Disposition: inline
In-Reply-To: <xmqqr0dijrrh.fsf@gitster.g>


--aj7DNaHuDRqlM1yM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 01:43:30AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > You may have noticed that I dropped the "Upcoming" prefix from
> > "UpcomingBreakingChanges.md". This is supposed to reflect the fact that
> > we also have a section that point out features that we are _not_
> > deprecating. Those aren't upcoming, so I thought a rename makes sense.
>=20
> I do not mind missing upcoming, but why markdown?  The mark-up we as
> the project chose is AsciiDoc and unless there is a compelling reason
> to use something else, we should stick to it.
>=20
> Yes, README.md is not AsciiDoc but that is primarily because what
> GitHub does on the project page.

Oh well, fair enough. I'll convert it to AsciiDoc in the next version,
but will wait a bit longer for feedback.

Thanks!

Patrick

--aj7DNaHuDRqlM1yM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZZsWcACgkQVbJhu7ck
PpQfwg/+MX6ZrhJ1qelHHxVCEZVNnAht9uMDs4LOzaL8z40nSrTqvdGA93atvruL
jA0BrjZntX81LdL3hHuJaEx4glMWgmvIRx8quR0BSyxAguckNaJWmUX8oJRdXZQ1
J8SBnLHBrmVRLcq7Zvj56JFLXPiJ3ndPwsXWyPFbwydiBQwvFj02lpzvCGbEcUyQ
UJAt6GMOFL/6PeTidSx9aZ/zcvyobB8LTq3RX36ftPGXTnRW500A21UUxgYtjLW/
Q+hBE+ckvtwNOk9/6fKvHHHZhk33tZR5oNTQ0bTTYufG+bUXmiDy2zpT9cyV6UOE
H9mYvECn4DSb3x74WYoDrpU80rOyhxZCFhlETirQ5QiXv8FxOILy8+I4ta33TwsE
vqdLbGqdRLCaYEspOVmD78PcnhmpUm9qmHV2FQep618R176RVP/dvmJf6yorjzw6
w/NoPmjqUFVQtuEC2p5K7+Z0ASNx26ol30nMxN2dQvhAgQ0NZPLljIcocovzQDMv
OdwLPVpiBWEHpV4P/O7/aye1UUJvDEuFkjmFxGy+iiLqZk39oUn3sx+J/Y+BcKnO
zhpBJm7dcSL7hBTrgfn4RHOj/zi3W5G9/meYWFu7Ns8IoGJ/jV5pUc53u1bkORXU
kBPviFlrhMhsbuSR5aRFU5osLi2UQ+Bd7ZUC3uu6NlfH74zxJtg=
=OOWK
-----END PGP SIGNATURE-----

--aj7DNaHuDRqlM1yM--
