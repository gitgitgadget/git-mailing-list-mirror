Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374B3199A2
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 08:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662355; cv=none; b=ACWV9L//KiSoLFRSb8LA59sam6EE0zJ9hupctCrzflLpyDwFdozi/9lvs+kSrE4jFUZZVn1tRPgX2CzBwvOhWf2vOUPxdqUIAwCazZ5agvc4beoP6nuloD2i3ZPT8uqwz40zb1jWpM+Yara40CwmAmqqXFWOZD8SdHnD2N4bwLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662355; c=relaxed/simple;
	bh=fWUF1KBuwfAXd+ToMktcBFKt3SWi/PocxZYr6Rvt1G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D38rdLfwyt+VVV/tw1XYlFbpCLxsKBsGSD0eUQ7RbMKRjwgcnYgbQv94sCuxG5de/TAEUxJhM4TrYhlAXmENuXbXAwoycJ4YdSAoAJe7GrlpbNurHb4Zh8WPjdWvWuKA8z/1L+Pcc2S585S7wfLLKgzdJTy7EoBEaPjIHSZ1axc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OLgYmDes; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FfPPbYSc; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OLgYmDes";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FfPPbYSc"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4804711401E7;
	Thu,  6 Jun 2024 04:25:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 06 Jun 2024 04:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717662353; x=1717748753; bh=fWUF1KBuwf
	AXd+ToMktcBFKt3SWi/PocxZYr6Rvt1G4=; b=OLgYmDesVyVpOsH766yvQiKGU3
	NazaZYCSf1CUpJnNCv6z0MeBrg2kw8MBnT7AFMSa3e50Fvk3vJFJPvrQlxOTd055
	Jd+vTCSzwjYxM1yIqfqptCFj3cyu64VT1szY+wleS0i1iGCOYT6WaS+XDtWNm7K6
	2s3/QNO+W0XNhPREq2DS4MHiii33JAMwYJx88qIOjhGJt3QGuiKDUlYZqmLok/Eu
	8LXCf0r7V9JU7ECrni3IoACgQCJgLXRiuRUBqY/L3jtqvwBiK34vNLSSAAMFrZIE
	YrFUTyK6dRAmvhJR33hPzo0/saoDtc2ujgMIGg1LVFR50jqOYMOV4zTPa7jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717662353; x=1717748753; bh=fWUF1KBuwfAXd+ToMktcBFKt3SWi
	/PocxZYr6Rvt1G4=; b=FfPPbYSc5ROD5iUQXbvMgxCo4OFekEQWKLXhriyRw9qA
	AhEnEMbOxDp9raM9Yyw3gJf5ZcLiDgrmOLW9p0xmVVoT5GCi7AqqVwa3wwpVrc/j
	iK8zK0K+dMKXcmBedVbi/eVLL9wQKs+Mo27WXUBo146TOEA99KqQuLTuMKRnaUUt
	4xdDZ+inTu87e9HZNXXzxeONGLKw/bYuwkqgdbEjYkS3LZFwWhwiLtLC5Hyy4OaK
	5K2DrtkGNmEXR2E7jiA98abvMu1kuh7U4pHpsW+tC6QYoFPusKgrc+8xmseORyRr
	oj/Qk4lCCb/IuQEv0ZJfyDMoB2i5bOPs/Q25OW+DrA==
X-ME-Sender: <xms:kXJhZq8CsqyU-rK8Z1_pMUhIG05wbM-pdw3Py-9ZagcoJhNvTMM-gw>
    <xme:kXJhZqt6fvn5fAeF-5fmT-kfRor07IvorTkTdcnLxo3OTLZmM6ndznrtpE7nmtoie
    xYiLWnA4a7Ah95pKw>
X-ME-Received: <xmr:kXJhZgA1FDTRUZ7r9kwZ2ofSFZ3hL3fSKpAXppYwhaPqqP84J6J9R3hxvCmC0LdvwWoK8bTKIRdaCWYtlQSTzG3YgmsttHIHGijca0yV8bzjBZrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:kXJhZif9G3UnGF3UcJycKxjASvdX51RzqF5-wtFzZryB-jwPRZ1TMg>
    <xmx:kXJhZvOXk3CD2I40diHbkcem_UUdXWXLDGqLZnMVOwvC_qzlKpL4jg>
    <xmx:kXJhZsmgRtgpuS6Rkd0tTRQc_C5Gmd0bB0jO4aZRTFu1zWY1Yto2Cg>
    <xmx:kXJhZhudcIQmNwBTzZHz5eEdeSAYItLFMItM46YnyZl6PCS72qJCnA>
    <xmx:kXJhZor2rLgSJsOIdod-6W4iHSWaDXjSahalBtz9BG5NSVxsgAX5cDiw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 04:25:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bdd2a404 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 08:25:19 +0000 (UTC)
Date: Thu, 6 Jun 2024 10:25:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] ci: let pedantic job compile with -Og
Message-ID: <ZmFyi1fQ14tVy7Xg@tanuki>
References: <cover.1717655210.git.ps@pks.im>
 <351dec4a4d5a5619e7627e11a8e674e32125125e.1717655210.git.ps@pks.im>
 <20240606065236.GA646308@coredump.intra.peff.net>
 <ZmFoRPd52iqxbOTJ@tanuki>
 <20240606080552.GA658959@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NdgQobjzblnKbFxG"
Content-Disposition: inline
In-Reply-To: <20240606080552.GA658959@coredump.intra.peff.net>


--NdgQobjzblnKbFxG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 04:05:52AM -0400, Jeff King wrote:
> On Thu, Jun 06, 2024 at 09:41:56AM +0200, Patrick Steinhardt wrote:
> > I kind of wonder whether we should revamp this pedantic job in the first
> > place. The consequence of that job is that our codebase needs to be
> > compile cleanly with `-Wpedantic`. So if that is a requirement anyway,
> > why don't we run all jobs with `DEVOPTS=3Dpedantic` and just drop this =
job
> > altogether? This may surface some additional warnings on platforms where
> > we currently don't set that, but is that a bad thing?
>=20
> Yeah, if we always compile cleanly with pedantic, then I don't see why
> it wouldn't just be the default for DEVELOPER=3D1. The point of that flag
> is to be as picky as possible so that we catch things early. If some
> platform can't handle it (let's imagine Windows or something), then I
> think we should be explicitly _disabling_ pedantic there.
>=20
> > The only downside I can think of is that we stop compiling on Fedora,
> > which may have a more up-to-date GCC version than Ubuntu. But if the
> > goal of this job was to _really_ get an up-to-date compiler toolchain,
> > then we should rather pick a rolling release distro like Arch. Otherwise
> > I find this to be of dubious benefit.
>=20
> There may be some value in general in compiling on multiple distros, as
> a sort of "unknown unknowns" thing. We don't know what we might turn up,
> but exposing ourselves to more variables may lead to catching failures
> before users see them.
>=20
> I don't know if Fedora was specifically chosen for recent gcc there, or
> if it was simply for variety.

True enough. But even so, I think the better solution here would be to
drop one of the Ubuntu-based jobs and then convert the Fedora one into a
fully-fledged job that also runs tests.

That's something for a later iteration, though.

> Once again, these overlapping variables within various jobs make it hard
> to reason about (but I don't propose normalizing all of them; that would
> increase the amount of CPU work by a lot; I am just grumbling).

No arguing there, it certainly is hard to discover overall. I don't
really think there's a way around this if we want to have different
combinations while not running a full matrix of jobs, because the
combinations are always going to be arbitrary.

> But yeah, between Arch and Fedora, I don't have an opinion. Doing both
> might even be valuable, if we are shoving random variations into random
> jobs. ;)

True.

> > If we merge it into the other jobs, then I'd just pick any random job
> > that uses "ubuntu:latest" like "linux-gcc-default" to compile with
> > `-Og`.
>=20
> That would be OK with me. I also think it would be OK to do nothing for
> now. We saw one case where "-Og" found a warning that "-O2" didn't. We
> could wait to see if it happens twice before acting. I dunno.

I don't think it hurts to have a job with `-Og`, and if it detects some
corner cases that we otherwise don't I think there's a real benefit. In
the best case, I'd want to give everyone the tools to avoid sending
patch series to the mailing list which are broken and where that could
have been detected earlier. In the end, it saves everybody's time.

Patrick

--NdgQobjzblnKbFxG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhcooACgkQVbJhu7ck
PpSvRxAAjKSGEtDMwEYlh8tDRf+ngxRxeAm2cNF0iZHyTj3oO12V2D/oq16frOPh
Nh2v4pUiRQztstZq/Hp9bQZ0UEt4sx0DsVn7tiWy8gcj9kUBo8MqywXo+Mlj4lyF
JymJkARsbkfAI0Pf7kqCWfmPVAtuTYbvY87i+yldUMEbwh7xZEbzXFUU1fHiI2XF
yxtQlWxSMl77sDyrRi/MEyCj6sCJwm2w117rJszwHVLMXc4rrmpC9gu1kJUN3D2+
ZSjCuCPeum1ADxRQ08P6S4COgzcJMHo6BEfasNmGu4+sGjFDk3wfI47vW+EEXOE5
L33Wwkqv+7UKkcwLLaEr05ChCluRQ15yFrGtCaC++rQEA/hZk1C+VcOdCxG2tR2r
2gmPa3S6LouQU7i2OZKMVNOFYNiVrajefs0CDCcogCcHSM3O4MYwbNxBZNvOEUTQ
9z9l99CgulSIEsEoo3/xd09Z7qEJhnif2J00A6B4FuIpCpKz+dTKEpPYfkpVKEXm
qkxzZ0k4kqUl5faIrv4TWIhRSvZ/kMQcp0XCR+7EmO33cHV7xuDc1dQwphNTCcrz
rn4xJeOdkcNV/eXZLVvTtuq9yVN/qrpzrxSlT1wDUqkoNs+Cy4UX5KxU4tuwa701
BN8eD9ummDTDx8clWGFTPr4exHAGY+WOjDSiyM1xEbHkM/VdqVg=
=T8pR
-----END PGP SIGNATURE-----

--NdgQobjzblnKbFxG--
