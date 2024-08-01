Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7739C163A9B
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504742; cv=none; b=tfGnNSpNZET/gppOUKcAfmIrXFLBsvtVX85qxBv9+Clv9cnx0ICRp52TAPItCef3mcier/tzuf8jgi2ku/BUhnLioWh5nKrLIrf56nYJuoHV1WvU5oB0J9DmgOJWzptoQZKBEFMwUxabVD+E2PBcydqY6LArwRrQ7+B5C/dBOqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504742; c=relaxed/simple;
	bh=3IvLHVt2aCsy15XS8cqE7eb0c7TaP1T9R9jfGP82wvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5AXHIEKu0Mxfk/w7xx2V62P7SlAyEWAIfxQbuQ+lXqzoNgtHe79uXYsBtWDdJZN5asNOQPv8viimoLoQlGF+IhY0Uri69I/LYjrkPYYeIImG6msV4BCMkxQMXik1SxVhhc2xUCqqy845ZEf4MgftmmJNXARdID7YsfIquyjV9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZhcwLR+c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ic1N/Jn8; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZhcwLR+c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ic1N/Jn8"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8B54011482E8;
	Thu,  1 Aug 2024 05:32:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 01 Aug 2024 05:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722504739; x=1722591139; bh=3IvLHVt2aC
	sy15XS8cqE7eb0c7TaP1T9R9jfGP82wvs=; b=ZhcwLR+cySVQw3pHj+0R9Cj6V0
	nezGlQIlgMPJltKboifa4jkYwjauA9k56g1FJ1MaUF5r6ZJkevtI9iIzwUehQri0
	DqhnqBSzt8o/YUxls0DksN72emEx9j92w8ticr+zRkGz2WRLKudgdRU2Jnb+Ah2G
	sixIFytYHpyctUb9ROn03SjCLpq8V0778r2kc3FUj+Y7YmTNKHyhwrwu+W0SUxCN
	IMenD+Y/9NWc+9AYCXSe3SrmkF5CUg6mJctZKmidPmIMArHS2lgljcndVst5noW+
	0jHqcqISrRJU34rHNOAYpZBV+5gtXxtJqPSz7Ta/MmzxUWC2HwE8gY0/LuOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722504739; x=1722591139; bh=3IvLHVt2aCsy15XS8cqE7eb0c7Ta
	P1T9R9jfGP82wvs=; b=Ic1N/Jn85SA0nkjSuUNEgkmLVYPvfh7TXcmZTeInposg
	hvoEhgIleDurzXUxonTA5uXWIBtnOyug8IX0vrLnwFvHOqiNFDumfqzIpEUsWI5h
	Se5IQvcQ2arylQDSh79iLVGb5ZsmwBV7bl35olm74q6afSNKipBw4u3ATTy+JRpq
	08mxIKYrJR6UlL596iMVc41HHAKXN+mXzMiLX7bD2o5LKeKDSHSftVjHFtd2Yo8d
	LE9peP6WVYS5s64pgrSje7BrZ+2TFqg7IEgqb95ZsUHPiFuIyDwDEEJAlys/hJgW
	R1Rrsapv9g0dU7Ds93Zsr2B6tY/zgvmEg+rPzbibTQ==
X-ME-Sender: <xms:I1arZhcDb8GiZUI3MWiKEblBU9n4j50GVBwQqj5Al6JwJ-NQXqS-Tg>
    <xme:I1arZvMWNSx8zo04Y7hHl_FHFMpevxA3ce8_qlt8CxuTl9xSMzry8vNc7SpNDfCJ6
    3kQFIWT6vJPzpJZIQ>
X-ME-Received: <xmr:I1arZqhvnV6lnh10HFhSPvHpnCc7yhnxs68a8p1tBj9TeKrO16Zfq5wWh9v7DD66dlq6H7hlKfg0uzelOk3UhlOWTnC6kKlEmPoxvmszSL2Bw-I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:I1arZq_mHJ_JLQWUmTgWOiHrkO4FbQ4vfQLx_nZE57Ofh-lBFPvplQ>
    <xmx:I1arZts2J17OT3W37KHLh1aJlEKKcaBK3cztcKcoxpSHNtWn5aaj8g>
    <xmx:I1arZpG5xU7J3z-ufeZ6_fo9GTMXp56qohZecPx0onwsmm7yAO0c8Q>
    <xmx:I1arZkPaMXFPlLCjK3sqEfPBz4TqwLwuSqfSFk57OOS2pmaLTvjPUg>
    <xmx:I1arZhhcD63-NyzjJmedqDDFNpycRIZVCFv3onQF-SXHvWGVe9Zdjoxv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 05:32:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a47ae975 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 09:30:46 +0000 (UTC)
Date: Thu, 1 Aug 2024 11:32:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [RFC PATCH 2/3] Makefile: wire up the clar unit testing framework
Message-ID: <ZqtWHx_qIuDeFC8z@tanuki>
References: <cover.1722415748.git.ps@pks.im>
 <5195d084d3c1bee76e7e424afec2c09bff8f5dde.1722415748.git.ps@pks.im>
 <xmqqbk2d7ax9.fsf@gitster.g>
 <xmqqmslx1bsu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kDNI2VbMP/qf/uNa"
Content-Disposition: inline
In-Reply-To: <xmqqmslx1bsu.fsf@gitster.g>


--kDNI2VbMP/qf/uNa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 02:39:13PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > A trivial fix-up to be squashed into this step.
>=20
> I won't be able to address this today, but "make sparse" and other
> auxiliary targets also seem to break, due to their lack of
> dependence on the generated clar.suite file.

Yeah, as said in the cover letter, this was in quite an unpolished
state, so it is not surprising at all that things break. I just wanted
to provide an unfinished PoC to demonstrate how things would roughly
look like so that we have something to discuss. Definitely not material
for `seen` yet.

Given that initial feedback didn't seem to be all that negative I'm
happy to polish things a bit more.

Patrick

--kDNI2VbMP/qf/uNa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarVh4ACgkQVbJhu7ck
PpTUYA/8C4GDXYwfp6Sr5NZRupSK1ge2iNE7oQ+WxnRBYJU9VEYFbxPXKMk6vOLQ
BLwHoOjkiISjFrWLF7DbYdeKPaH2kPsBTR7j7froGJYL37/XB9rtmaO9UXh6ktlB
hM28EESsRaRZDgCJxAAbfCZTivez69I7nPCYaKs93/q6dkQk8ZSbR1H88/tonFzO
1R/3RMDr3+01WgbQhuSlW6hApnav5tZhpT44U1eB3YwRizIt+MQ1G2M1wpk2CH0D
YPEnFxXe6akSnc47iwkddJMhcsT0YPuiaBXoj1ZehVIuj/qGz9iWjzGdo5bkL6Bm
qbJCxHYsLg/B2bjH4BAQrIA/jKpbn9v6qqrVuFopCZiIKYexSP2LmJKuUMWnGC3H
mC4QaWaiyd0fDqEEsVRLnvTe6Wzy12uP7tPOLLSSEOrRdDkYwZIpzl4HjWXxnHtd
cPdQ5Gt59URgWZiQ3mP4sxVbxc9Z6vpI+VdjewiEoabJg/f+oYXRuVyCx1Vzy+MV
RleoRICkVI/jGmrfygL4cEH4h5YaQ9LMaq8iLcDJFa4itgx6rh4DumPMLJyg1eNh
tzzFafxhkrICVmPEyajYYynFQpYzvPFWDYsSMmqOlshSSiaMAl3lH5GIocU5vEkI
o2pBuZODnboiOiFqGDv5HcY1rtoil5hNup8axJhUbIybaOPU+pE=
=nYsR
-----END PGP SIGNATURE-----

--kDNI2VbMP/qf/uNa--
