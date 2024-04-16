Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E20A1CD06
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 05:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713244449; cv=none; b=BvRWh2xnOb0ltdiezDztEVKr5rSs7lJYekVwoVqORGi88RLSvG8HTRyewmuBeB8HlD6A1WJZITfy/dIQ5IXYx7O7L7Mg0+2jgmb1w3NWmTA+uOhZDyVxrOzzl6Ic1wKNOouIKY9ZcQVjwFmnZx2FeSJYD1jmvUmQIV9bj3K9X7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713244449; c=relaxed/simple;
	bh=C1Np+8lbK6A2W/nN2+4GQOKceRJLsppgZmT9WvfTWi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/v+V0OKTOcJsjkcrUY41nL557z8dBK9ZgQqqDO2LZusxWtEwW+Kp7dUGHwbk0ONZn739OjiDEzIeO+oieIHUKpwfVynPF5OXp3EUVVzhQMfOJlwKdjvcFsY4ojAtmrOImOpsStTVYNCvGuiyo2ZQOOWvnmaY6HViD0adYvf0SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dYm5PbX6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RD1ijscv; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dYm5PbX6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RD1ijscv"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id F3B961C00085;
	Tue, 16 Apr 2024 01:14:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 16 Apr 2024 01:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713244445; x=1713330845; bh=92wR1qP2al
	qmmoejL9k4lPrDKAdINhJY3vpWygjSc+Q=; b=dYm5PbX6ZiI1J3FSgP4KMBoJan
	pSEai/uspiTKGZq55BHQhrzqGBMnnKKyyQ6i2OPPOTQweYmcxsr+Z34fN7HMQWgA
	4CzhX0jM059fhEWiw12JbMS6vTtr847oDfCTyjgs48vAY6BxtYTJ5z7bnwN1OokB
	vBiyEXPR2LenTAaTuPYPkvV6DCLVydYdMnQutoJF4iJXMoSwDsv3d8c54WMJGjSW
	bkhqtiRTkjni8X0cJop9GLctETqc+LOiT9Z4N1lxex+WD9kNtZgRhWICHSZ7kUJT
	sChnwCYvJlAkNFN+fjS1HgzO+VTDCiwQHWAPiXbykmZw4BXiw3Kb5bcNEF2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713244445; x=1713330845; bh=92wR1qP2alqmmoejL9k4lPrDKAdI
	NhJY3vpWygjSc+Q=; b=RD1ijscvl8O2b82IAtx1GELCenDpyTiWCAG79xGX1C92
	R/0Y7BZlWkpmx+qaLqvSpJYOK43+wF2WvY/LzZKtFFDUwsTrW39fohNzW8o9kENG
	XU2t6xNkoRZBv4C6TxWKNzlL+k+HY9Lw0fAGpN2hRgKYHewPwf5LsnQulMVCJU6n
	f0ie53NvUSek4k3DqEOX3VSmmgW0EPSmoXxQy2VQmvDnpnn42kd4DOhDx17kbNec
	daPjt6wD47vndyfNcU4XweSDa995zOGt8WQxxxn0nH6dAJnDBTzxXAoDp8hZWn3s
	9L0WtSSOey3zbBfsoju7W0kjTgb7Sh7uRyy+2VlUAg==
X-ME-Sender: <xms:HQkeZn7IUE9hEwCXSfe2prLqxc7dyntRUIhjMYyynL7-jMFk0W-aWw>
    <xme:HQkeZs6tpLku6cCE8FPCj2wHyLII88-TNgufHzD1DpR3TInpMzAWaqljmlecrkbbQ
    WP8kFnsvGooz5if3g>
X-ME-Received: <xmr:HQkeZudsjdQt0r3Sw92cGLTZNTyD84iZSqZHucjnHCb1BtOjJcI1PfW6-eadhZz1_eQWrIxoYL2EQH1WFN8UgJF8Rtp7J1sP5MCYFjZxkyQVZsvOlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejfedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:HQkeZoJU5otzx1o__NDU_QOR3StHiJEjlWJE50dm8KweQmbXci_NCQ>
    <xmx:HQkeZrKLGmHXhSHUSMA6iu0nXlp5bVZowWOv8ocadG_Gjm5dTEi1Tg>
    <xmx:HQkeZhwDztYZp7T4qg4ta0DE6Fr9jBZmAHzz_gBDeafL23VwB96Kxg>
    <xmx:HQkeZnIM8CTLmlJgUgH5veMcbSOoFrFFofAMaxBHgUKSmaBFZH-ApA>
    <xmx:HQkeZj0wMWFxxVYx1K5YnQD4Cu__1evq4yStaELve011uDAX_eVg8Rp->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Apr 2024 01:14:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 31394d4a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Apr 2024 05:13:40 +0000 (UTC)
Date: Tue, 16 Apr 2024 07:14:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] pack-bitmap: gracefully handle missing BTMP chunks
Message-ID: <Zh4JGJm6cYFjk4x_@tanuki>
References: <5933a302b581670183a6f3c881f62e96f61ff192.1712642313.git.ps@pks.im>
 <a8251f8278ba9a3b41a8e299cb4918a62df6d1c7.1713163238.git.ps@pks.im>
 <Zh2vZB/60QlLYjUZ@nand.local>
 <Zh4C9xhOC4BVslyX@tanuki>
 <20240416051232.GA1745631@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1Z9jNBtMQetyTREw"
Content-Disposition: inline
In-Reply-To: <20240416051232.GA1745631@coredump.intra.peff.net>


--1Z9jNBtMQetyTREw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 01:12:32AM -0400, Jeff King wrote:
> On Tue, Apr 16, 2024 at 06:47:51AM +0200, Patrick Steinhardt wrote:
>=20
> > > > +			GIT_TEST_MIDX_READ_BTMP=3Dfalse git -c pack.allowPackReuse=3D$a=
llow_pack_reuse \
> > > > +				pack-objects --all --use-bitmap-index --stdout </dev/null >/de=
v/null 2>err &&
> > >=20
> > > A small note here, but setting stdin to read from /dev/null is
> > > unnecessary with `--all.`
> >=20
> > Is it really? Executing `git pack-objects --all --stdout` on my system
> > blocks until stdin is closed. It _seems_ to work in the tests alright,
> > but doesn't work outside of them. Which is puzzling on its own.
>=20
> Inside a test_expect block, stdin is already redirected from /dev/null.
> See 781f76b158 (test-lib: redirect stdin of tests, 2011-12-15).
>=20
> I do think it's still good practice to redirect from /dev/null
> explicitly to indicate the intent.

Ah, that explains. Thanks!

Patrick

--1Z9jNBtMQetyTREw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYeCRcACgkQVbJhu7ck
PpSeLQ/7BZ38m8FLKbWvH+If6nognyAoTDB3mfZdu50O9QeTbB5GYA69tAKdcSoi
CNCNPIyLmfCns6PxYwYVGdpoZO6is5j292xSQzn9qLr88y2iLOqguCwv00agx83m
1cS8wyHxq0Zvv3NkuYE4TX8zldsF/LwEQBF+BUOu3g2u4sghHZVO8U7ZYXlxJ6jF
Pu/IgEND+xJ8iuf23fS4XKTSoDirIoczptBMLcFIvxQmAQXdDM9zP3mxsAYNQWVh
aAJQ7hLVurkw9TNPZQkU5UPe60gpICMQIe5FIDxAc6hb32/rcMWkdD4wNW3wBQN9
UQ7IBONI8jl9RcvHXaP+gmMeSHE2d/48AXwfXM1KmgcOodiOF7riA/LlTcWCu86N
HpFSAJh1QsMniG8s3gfCsOKKA56i7X/X0TIC34RNemKBfuokvezSsp15XxhJTTqo
3X/zhz0jmZCC2KTBbKwSSpVIOLm4YdcscvRBQ9594qKBq5CJM3FJZXYRJhCwW1ZP
5ehOA6KajuMYkAxxcM+xkw4uxcFdAGEkkSYXOQ3HPJ6zRqb0I9mN3qRDQoMSfblY
tYC8m9VMKPMYcPE218w59gZqUHAHhFVsFl55ZUmsPbi3G9eHohDTtiHXcg6Zclhw
5X6jjR223ZRd0PPd15TgHYSmqxYFy6xfzsUBfteSSAZD4jXBrUY=
=VTMx
-----END PGP SIGNATURE-----

--1Z9jNBtMQetyTREw--
