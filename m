Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE1051C52
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051535; cv=none; b=Z/sbnMbLfHmrHELcOfIm8PhwAl91FfgqfOfxcc7sqol2Pv2rKDqZtK39JHtaBhq5vyTCJaWUuQ2zCryleLS0r/28Tufkui7F80ct41GIxmL3EuWkiscKflpiuVREMWEwXmCBxQRvgJsSpXJ0nAuMF5QfS9GE1IqGtTusOMu33CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051535; c=relaxed/simple;
	bh=GG1y4RWI4VarZhsUhVs6Fx+X45Ooh/RGXJnSTEUEyG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsFb32GdBl47+wL45XxVYQ/3Ro5DPozFjD7J9VmdmFFNE2BiY3o/3qt241+2YM9PAUG9qZhQMPxcSm1IhD60jnqCVlcn2OD34OTlS2hnalYO8wyWBB8BBxAqDzlkAF3/LaKZ2xW0SBdDKm78sDEBVslTzDZHPldc4MrV8aFhTLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=COTSrpZ/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jV7Q5cDl; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="COTSrpZ/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jV7Q5cDl"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id D2A3A1C00081;
	Tue,  2 Apr 2024 05:52:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 02 Apr 2024 05:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712051530; x=1712137930; bh=GG1y4RWI4V
	arZhsUhVs6Fx+X45Ooh/RGXJnSTEUEyG0=; b=COTSrpZ/r4crkNUmJrHAwGGBmZ
	WN9gHSiLrIl7y2Z5bBtrWnK6cTKVNlCP1zZBrTKFK7MgFw+JHBZCfqd4UJs6ZKVC
	yTuzbWxFUnqDYbqKC6ADz4uN0i4UUayAF9HGsMxZZ1Utqqy++IJ4mk9C9tayPj2S
	fpe4qk/2K1z3B1NwQJXwG6EnnJ/z2/96ce6BeJ/CJes9yvFn+4npEAs+wfNmN9b7
	uXknW8wHqJjb1n2FHw5IN82fYszWDD42RMbQOYdPAkbLOypwIXe2/PGbdGIUvmtG
	eprr2lxAe21blrt/+5Vw4E85nZ81V6nA3ASOHF29fk8eP2mrAcJqhsaMfV+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712051530; x=1712137930; bh=GG1y4RWI4VarZhsUhVs6Fx+X45Oo
	h/RGXJnSTEUEyG0=; b=jV7Q5cDlRd7MvLIbcMyk9qiOoU3F7orhKHekRWOdKXAJ
	1AIEpHlT96AFDxFjm7R/NoqgbRfxOaloOaOJBs015FEIdDsh/j77tRxzerVsHAos
	UjF34LSabvndQ6xWwXv6KsIT8m0LV93IcX2EoJYmUHmeCz0Kc1CyBNDdj+vHAYR2
	5CQXZLJTTpanPFT44IKQVgCWR2ecmQjMeuxMF2N+taAkz6pzB4Jb+gbkhGD11sEG
	Ezs5GDB2CMz8sBPmztAHyTYXleORajJQrRybMOwot3AW4yBzbg+Ix5/ssUY87mcF
	A4r4XHDFi34NMxoUHzHWe6Cu+1UWZd+NtSf7jZJx3Q==
X-ME-Sender: <xms:SdULZl5aI_i2_hIhVaoSDrXM3jPL3lm9ivHUnLuBoVAQ7ieT-u8IbQ>
    <xme:SdULZi4K3IQ0HkfUxj3wEFgM6RsT36wiAP8WkJccMXtBmBf70biyrQdSChik7Aa_0
    hc86npqluaGWHt1wA>
X-ME-Received: <xmr:SdULZscBnoCpOmFoxDpWfULCrG-aBl0siLmGWMJWLOx8SlF4IVGnSnn3xu_cdTV3v4_J0UbAmcxSb2ihlZCD6opSEv1OzJFaE1nNi3YRRSrHzLU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:StULZuL3NjME_LTrJsDoSbd1i3xfPeyYyCXnCSML00Mnmn31q0mHRw>
    <xmx:StULZpJbuO1qcdHF459vuMVwtPMUznauSwE4YELPgb9-7QQvN_lbWQ>
    <xmx:StULZnzFQmE9jPKi8D8hWmWQO4xbmbDSCjuqjpu-2Pu0ukSRR1U2zQ>
    <xmx:StULZlIPyW_zwUPcrEvgZuJ-psErRQipWqv5nc7NqVrVAYfmjf5uzQ>
    <xmx:StULZniD9Bkntfh7JQLR5ZgKSNYqI9HCA-9yl6G0r0qZ0gfuyudYNFjB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 05:52:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 58267886 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 09:51:58 +0000 (UTC)
Date: Tue, 2 Apr 2024 11:52:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: vk <g@vkabc.me>, Karthik Nayak <karthik.188@gmail.com>,
	git@vger.kernel.org
Subject: Re: [GSoC] Microproject help
Message-ID: <ZgvVRK8VH2F9YKd1@tanuki>
References: <51647635a10e31e800f87e8bd4a2e62c@vkabc.me>
 <CAOLa=ZRrmyZ48C5r8MWioyjySWdKtLxhtDBg5F2tRsExHaR-fg@mail.gmail.com>
 <a344deea98bdd2daa7671fae45c0bf11@vkabc.me>
 <ZgO-W3E-CeT3n7vl@tanuki>
 <xmqqo7axvbd0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DYLlew+/ihnl2Wgs"
Content-Disposition: inline
In-Reply-To: <xmqqo7axvbd0.fsf@gitster.g>


--DYLlew+/ihnl2Wgs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 10:46:35PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Hint: the `maintenance_task_pack_refs()` can in fact be converted to use
> > `refs_pack_refs()` instead. I was briefly considering doing that in [1],
> > but then didn't want to do such an unrelated refactoring in an already
> > long patch series.
> >
> > So if you decide to do that you should probably build on top of my patch
> > series to avoid conflicts.
>=20
> As the microproject is a learning experience for skills to work well
> with others, we may want to suggest an area where there won't be
> much conflicts, i.e. skill to find an area that are relatively
> quiescent to avoid stepping each other's toes.
>=20
> To be quite honest, I'd rather not to see a task that uses
> run_command() API and gets done in safe process isolation turned
> into an internal call by pure amateurs, unless competent mentors
> go through the change with fine toothed comb and make sure there are
> no unintended consequences and side effects of doing it in process.
> This is especially true for microprojects, where the primary focus
> is about learning the process of contribution and working with the
> community, and not about learning the existing codebase and API.

That's a fair remark indeed. I wonder whether we should remove this
microproject altogether.

Patrick

--DYLlew+/ihnl2Wgs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYL1T8ACgkQVbJhu7ck
PpQo3hAAgs535JDXw7BO/IJL8L0HD4CQWsvYLZZ/pFzwE/TP/93fhrsAv6d//LWo
+oqYr5eKjn1OnmXj17XxIAipKxgbXbOkVPo9+884Zy4PmfE5COI5ANhM2zbC3jsS
UUzdzoRTWEveq5RC+rn8accseO94kzxEOalxqa1yGMlSCv+AthQkAqWCkveKpoep
WoT5d0PsdFkiSQKFjArtGZ5VFvLAF+H/tVGWCbkuaz4N/ET2xlFSnk/+2FFPmXYM
3Urm4elSejtS46Zw597ncMsN0PVRM1ni+PJprqqS0LvAK+3k7TJTszvm5xlSDQR8
IuDWYG9lsixYIeAzTzJq12Mpt+7ht+AbTlc3mdGOJXy7zCBiUrSuE4ZJpgPSE3gz
Nfk62eUglB+Z4TQ+WlOoZUhfIzGDlUZcuhla7YbkvqvWJqQuEmmYfT9q9b+51t+C
tjqWirGhnnBaW9rqcZfTCRZzMXqgipNpDb3FTX+xeYO5jH8G6hDHxcC5z1BMpt+M
E/2aW0fYUwsIk6+B7jpNja0aZd4RX+CRzE76mNZTWbiAV2wMSinB68/2IfvTp0ad
3kFHBnxoqCBTG6HKhYjE3z9OxSs0Euxpi/KpVJGTSa23VD7So6GoMOpB2J2x5dQu
wpS7cOtNYVUGvQa2nNWAizXoK4aPs9F439qhi704B5WagY3sQSQ=
=G9g2
-----END PGP SIGNATURE-----

--DYLlew+/ihnl2Wgs--
