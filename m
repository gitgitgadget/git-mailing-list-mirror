Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F9D1C68F
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718000722; cv=none; b=IwoYZ3NbKe+sZv6L+2aU2F6CanF9KToF+ZG+R4OgIUFxzWHJEZopOri7d9sM7QyyJjGAF85RsPSojRwm6fL/1ePg7eLgHIDfDWO6EzWeG1Z4DWmM4Bmp04tJ+OiUPfHRNZiyiikutf0byDo9AEQqZ9/VZ2a4rvPtem62ywJRhrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718000722; c=relaxed/simple;
	bh=Z0steIfFrn1+EE/mD//jyZGJ27+ToW/R9rMergLDzNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bf6mmQ6yiDfKoAyqKEyZOeiv9Rkjr7ji/CEqI/8KRJyxNxNYhgUBbtdPk5sHz4RNeNH0k26yZPl9JbTcC9eaXcfQget1awrAIVFNjZnseyZVB0eVbddWPVyBwYmzRpqSKuzARn73vdT0/CqJ9k2m7AL85NVfMWIRD/P8X42PTjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KTEVrzDj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H1ywQBGC; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KTEVrzDj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H1ywQBGC"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 204BC1C00124;
	Mon, 10 Jun 2024 02:25:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 10 Jun 2024 02:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718000718; x=1718087118; bh=VhHvOBLCK6
	Ofm4/vLTiLIkx/y7EmMpx52VbYnDjHFSY=; b=KTEVrzDjk5zQ3QO3cxAtcI7OgH
	rfTNoq6RCATfyp3UNb0uWUQQ+YUB0NP7ilSRM7kDpun6XHgLlZYOBHXu41uuSm1g
	kTNbjFsw+G9wpVg8E8ENzUYUmAiaefxuLOofIlooaiqR0FIjNm/fqLR06Ur8KFvA
	ya+39vxdrPnwSgsCCRof+S8s5KdNSMCNdhPnRrGeWbvvAY1BH7xcsqAcNfzzNlum
	ILYztkopRRKkyjB41SobgCx4PNmpdmE910y4PntkOZ9SxJ6jxaPxecr1RxPA4mfr
	vnJ1Lhppl/q55/bOL7qUyvmgAoSQMZ7ZsbMG/Q96h5vJ/SJ98+EoNXph5iIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718000718; x=1718087118; bh=VhHvOBLCK6Ofm4/vLTiLIkx/y7Em
	Mpx52VbYnDjHFSY=; b=H1ywQBGC062f7RhILCKNt1Xevuk94jzh7gMhXcScSmW2
	JdN5ky0nKGRxmIGd7kjCbhgCCtFkAkE0xgi999k1OvxURH/xy0YN6FqVwmLpiBAT
	ggoft8ZpWmoFmPGq19Rx3Rpul9F/BVWlf4ca5xSwztZmEg1yM8TcqCvk39qzCGoR
	g8mfc3LMSRoa418qlhDOKPwElFCkswRG1xqLGfl0Nj113sSa5DV0xc3avj86UpQB
	t9NKG3NbXEwAvWbWAMkKodQV583QYb3lg5cLGs0XUWy7DFOc2CJBkXVvzlolshp2
	FkF4O7UjSPaN6hqSAou+m5hNT0ml6H0QsnlrZUKl3w==
X-ME-Sender: <xms:TpxmZlewN2qcIf_A0s8sjvuOZn_Nt8j9XDwawpJmrUsxIOKKrE6NcQ>
    <xme:TpxmZjNbToyoD10UhsUB0IeFG8lFb86BY4_gsA1SAYRnrDBcxz9yVr_vVId9T515t
    YEAE64exSTIbCgy4g>
X-ME-Received: <xmr:TpxmZuj-sGef-ywzXxwGJCyhrG-fXgZtzdJfwJM3PpOZQ5YvZsD2JdmXM19ck--psP8k9WvG0ofa9MupCNhtZO69SZYF_1feE_c0d83MEpu3BvMZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtledgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeljeetffevheeggeetkeetieduieeiie
    egieegtdffheegkefhjeehfeekhfevleenucffohhmrghinhepghhithhhuhgsrdgtohhm
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:TpxmZu9kJJ6t9cDRhaIlJoaCVBz6d9inb1aW0oDx0xg0iHIt3TqzSw>
    <xmx:TpxmZht4xZKyHb2GJsWFeiHZlU8GVbfH-HcOJr_X53ePNGMee8ph3w>
    <xmx:TpxmZtEBx4uk4rnPO-YJ9la9Ja4d9KDJkk612SdWAaD-a9sFIKWZ7g>
    <xmx:TpxmZoMdp6z1piwss1cw_I4L_zGTwYTigfeqKIFtafzwgPpWa7GNvA>
    <xmx:TpxmZpJwpZbJzyT4uifwXxR5Tvd5MAt93K8mK4ZB7Ic2HD3UNXYQpp4R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Jun 2024 02:25:17 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5e19eacf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Jun 2024 06:25:08 +0000 (UTC)
Date: Mon, 10 Jun 2024 08:25:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] ci: detect more warnings via `-Og`
Message-ID: <ZmacSUI3d1nbx_F9@tanuki>
References: <20240606080552.GA658959@coredump.intra.peff.net>
 <cover.1717742752.git.ps@pks.im>
 <xmqqwmn0eazm.fsf@gitster.g>
 <20240608092855.GE2390433@coredump.intra.peff.net>
 <xmqqsexnav1s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NjW4A7pGKpJyGYsN"
Content-Disposition: inline
In-Reply-To: <xmqqsexnav1s.fsf@gitster.g>


--NjW4A7pGKpJyGYsN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 08, 2024 at 04:12:15PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > On Fri, Jun 07, 2024 at 01:47:25PM -0700, Junio C Hamano wrote:
> >
> >> I am not sure how annoying people will find the V=3D1 output.  It is
> >> irrelevant that it is in a collapsible section.  What matters is if
> >> it helps those who *need* to expand that collapsible section to take
> >> a look, or if it clutteres what they have to wade through.
> >>=20
> >> When studying a build failure, I rarely found the exact command line
> >> given by V=3D1 helpful, but YMMV---while I am not 100% convinced, let's
> >> take the series as-is, because not losing information may sometimes
> >> help even when we need to visually filter out extra clutter.
> >
> > I had the same thought. I have used V=3D1 for debugging, but usually
> > debugging Makefile changes locally (i.e., why is my option not being
> > passed correctly). I don't think I've ever wanted it for a CI run.
> >
> > And I do think people see the output. It may be in a collapsible section
> > on the site, but:
> >
> >   - you'd uncollapse that section if there is a build failure, and now
> >     your error messages are that much harder to find
> >
> >   - if you look at the output outside of the site, you'll see the
> >     uncollapsed sections. And I usually view them in a local pager using
> >     curl[1].
> >
> > I guess I won't know until I see it in action, but I have a pretty
> > strong suspicion that it will be annoying.
>=20
> https://github.com/git/git/actions/runs/9424299208/job/25964282150#step:6=
:573
>=20
> I _knew_ that this run will fail compiling the updated timestamp
> parsing logic in date.c but it still took me a while to find the
> exact error.
>=20
> I typed "date.o" in the search box, which showed 5 hits (first two
> are false hits to fuzz-date.o and test-date.o), with
>=20
>     3rd hit on l.566 "gcc -o date.o ... long long command line"
>     4th hit on l.594 "Makefile:2758: recipe for target 'date.o' failed"
>     5th hit on l.595 "make: *** [date.o] Error 1"
>=20
> Nitice that the error message with "date.c" is on 571 but with each
> line being very bloated to around 10 physical lines on screen, it is
> very far from either 3rd or 4th hit.
>=20
> So, this time it was annoying.  But I suspect I'd be praising the
> wisdom of using V=3D1 if I were hunting for some breakage caused by
> tweaks in command line generation that broke the build or something,
> so I dunno.

I'll just drop this patch for now.

Patrick

--NjW4A7pGKpJyGYsN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZmnEgACgkQVbJhu7ck
PpQwYg//eYsPI7a6IIpRHRTBrqyRGrtLQVRwaA+iZldYiIpSYpE654ZDF0dBxm22
YToCza4G6uyWRo4HQI6prr7wUWj1PKy8oF2F4P1b8LBkIcRE0MKYfnQtds76USbA
vmwRuWZvfBNCHJJr6np2euNr2WKTJBPCG2xRcjYOVLH35t5YiYLMC/rGRsBq1ZBP
cTr820jbrAvJFzrZUZzM3oDCLS7w7b3rxVY3VgeT3AKp3FMKzhg4XSPJtji8gMEJ
dBX+2h0dauf7w9sD/oPeERjiQXUz8WKeGcnGWcSpeUjp+Hfm9V205jkTD2r1+m97
LpfCsosFKSA+daHiRq1egxWt5NjsGZjaQbmo6iMVHcckaiMoGWmiLrdFdpybce08
JRSCxSnE9MHcVpNYZnm6Clk3LL6eLWFe3u2OytwF42V4I8o/14XO1SuGztdsMFh2
Vk7RtCST2HXaow64B8dUEvpfJgVpNCaRNq+Zm1r83r2Q7b3r2A3GZK8qkf5w6X9X
0x7rx07m4QYpYFNPKThPhec1vL8DrpAsAI1vlH7he5JHTHrZtsaml59e9yNjVZXB
ApdbsvdUKM6jOGFv1NXBXR5wbaDXvbQnwCiJX9G5lpIZ+7AmHpV7M8CJ8vfkdJYO
iFzum4jR5si8czw0rkHJEa4CxonhCQS8Zfh06QA8MIJFsIlFiDw=
=KRKE
-----END PGP SIGNATURE-----

--NjW4A7pGKpJyGYsN--
