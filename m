Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF562582
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 06:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718002011; cv=none; b=mQN+7VrAz6u1otvuZIdOO/gV08SfzX0frcFqNVi8HwsyJd3IG7q62Nb206qIAmLXOw014fbAhNDj5+maLx91l9Re4yizxgHEVJOzK/K/tuBKsGxdhmVsrHdngV1FgjwYHqYxLLa7rIAGpXlutBhsaOEXaqN995aA+CzByoxZMl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718002011; c=relaxed/simple;
	bh=BgJpU8q4xK5zS+W+FxECBwBz/01qpPVIw61ZglnfOWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9f7x4mkil7WNRtjlYmpbLtD4wCtqupVmkhcBP+NtsWJuDkBs0QSZn6gKQjgdUBoYmX3Bb5SWwsGgj/TVCJH7tRlVdZ5iDxQB4jPz8NZRPqf/omT8S9xusvvS+4qtJI6mpn0GQtW0xDmrfol27wrRgrW1hYrFiYKW22F9QzRZgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OLEo7lii; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZZ6vO6PE; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OLEo7lii";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZZ6vO6PE"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 6B3601C000E0;
	Mon, 10 Jun 2024 02:46:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 10 Jun 2024 02:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718002008; x=1718088408; bh=BgJpU8q4xK
	5zS+W+FxECBwBz/01qpPVIw61ZglnfOWA=; b=OLEo7liirfUlTJwmqFubtZyff9
	yP4GKKmlPmD2HUAJOBWOeZdLyjsGCbJn9K+hKgYov4im+bq6S1KZsEvIo572zsuj
	86sxOmkpHQxTg3Hr/rh3M99FNO63ziOZz/o4BecMa4au02KLk8fZUv11otSop/m2
	rSAzpahVBh/UJDmvM9b0pNoKq7xXGKpp+km3lv9Ox6F2V41sPPkDq8yeUeU9ZirL
	EpS7vzqyqxoT1pY4WyVbnLoJBhrMJLnUu4dI3ZKdogm5To7ySptgWg9xTJOp95up
	dgxd9Xa0W1S0G1IWxiWCTjHAJdT98zO+oGkyJnRCxa7SJ6h85Hg6cO9kpwlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718002008; x=1718088408; bh=BgJpU8q4xK5zS+W+FxECBwBz/01q
	pPVIw61ZglnfOWA=; b=ZZ6vO6PEpRNfGXdJ0GVnNS2asOzlE7FKG0u9NfV4vxWq
	HLAsebba7c/S3dAXs/yMiK1Ib5DMSBmrTf2EIKnTMHTmGUOGYLHej0OUK2QBR+sQ
	qRhQtTOHolV/IDjxyfqm5Wn0xof/X9iS9fBT7CFEGyhacZ+ZoIC5QHCo3XTCuHxk
	PB1IYW7YZtJdYdKRrFzIj8t7OrrW0KvtzY9joxBzC4U3RtRBRt9LC/YYp19xSZ9Q
	TaLtafhc67GeJO32fXIj8YnYT7fsob3TosRutKz2MMPSBQEAWZcd375NMg92ELHd
	ro+7nLjDJ8J0fDcDlAbEcabP5IiUCIuRnBB0Ok9qAg==
X-ME-Sender: <xms:V6FmZopEgoNW_CB-W6JOKD6hA_xkVkbDkCfLUbbQDoUPWkvHOBZ54A>
    <xme:V6FmZupGOStZufYN_cSNQISOq5zIDXwGrKwRw8q82ZB3iGTNVhN-mc4Hh5U6Yya0C
    VnAyJBNwiqG5hyWWA>
X-ME-Received: <xmr:V6FmZtPFMSAt-pGrcCLIwLf8QpcChk35JTSkWEBwrEETO353VW9woyodcETNe4Khk2-PJXXGCarRPjF4sR7Ozw7GCBaJKI_voRLQ9RLr1BCnFw4s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtledgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:V6FmZv44VAoxi_NVYP_PeV6D7CQnzrMvMJ0itPyiOmB1jBAQ-2yBGg>
    <xmx:V6FmZn48fBt7HEWR4KDuURFxES7qSa1kK1zfxaK8axUxypy9HPtI4Q>
    <xmx:V6FmZviRTdtygX5i2Ii5yQWVrdPPvnJnmYQaRAASwfQtR3w_tyrSZQ>
    <xmx:V6FmZh6IaSTbhoCDTEVg0Rpk3ZEWfHGtIPFTuIXctcbyW3fuaVWnmg>
    <xmx:WKFmZq28bOBXGYPMozCfcWWNZZLcjZICe8rbIvisbFIhrwaqjK6ohuN0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Jun 2024 02:46:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e87631a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Jun 2024 06:46:38 +0000 (UTC)
Date: Mon, 10 Jun 2024 08:46:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: ellie <el@horse64.org>, rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
Message-ID: <ZmahU1Gv_abt5RGn@tanuki>
References: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org>
 <0be201dab933$17c02530$47406f90$@nexbridge.com>
 <fdb869ef-4ce9-4859-9e36-445fd9200776@horse64.org>
 <0beb01dab93b$c01dfa10$4059ee30$@nexbridge.com>
 <200c3bd2-6aa9-4bb2-8eda-881bb62cd064@horse64.org>
 <20240608084323.GB2390433@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qje5kEwrEZ5gnJr5"
Content-Disposition: inline
In-Reply-To: <20240608084323.GB2390433@coredump.intra.peff.net>


--Qje5kEwrEZ5gnJr5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 08, 2024 at 04:43:23AM -0400, Jeff King wrote:
> On Sat, Jun 08, 2024 at 02:46:38AM +0200, ellie wrote:
>=20
> > The deepening worked perfectly, thank you so much! I hope a resume will
> > still be considered however, if even just to help out newcomers.
>=20
> Because the packfile to send the user is created on the fly, making a
> clone fully resumable is tricky (a second clone may get an equivalent
> but slightly different pack due to new objects entering the repo, or
> even raciness between threads).
>=20
> One strategy people have worked on is for servers to point clients at
> static packfiles (which _do_ remain byte-for-byte identical, and can be
> resumed) to get some of the objects. But it requires some scheme on the
> server side to decide when and how to create those packfiles. So while
> there is support inside Git itself for this idea (both on the server and
> client side), I don't know of any servers where it is in active use.

At GitLab, we have started to roll out use of bundle URIs so that we can
pregenerate them and thus reduce load. The next step to evaluate in this
context is whether we can easily reuse that infrastructure to eventually
enable resumable clones via such bundle URIs. I assume that it cannot be
that hard to make this work.

That of course wouldn't be a perfect solution, as the clone can only be
resumed as long as such a pregenerated bundle continues to exist on the
server. But it should still be way better compared to the status quo.

Patrick

--Qje5kEwrEZ5gnJr5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZmoVIACgkQVbJhu7ck
PpQ9TxAAlYquWTeFIuPl8iybXm0ax5E/twjoxJbyZBGUMwefNg0e23JcQOx4CV95
l2pj9otUv9uaz7HixuzVYOxAZnfJS4GUGDcn+Um4VElCZa4mep88gs04qCZ9rx20
DlhSiNj3uaXhLBOOC6+YUbZjkutguiUEq+u409rH4vVVunXxdsYGOsyi5B9PUONJ
jHHm1NY4sdTAxUmtRnf0EldHtACcu0AUP5VUVQ65gbk8Lcznzq6nr/KAZqjwjmtF
uSnzWsh7UgPP6KpKCTAtofXj77Ha8SEVkpqIbvz/GfFFtYf7QEjwbKzySd5XRmci
2c67FHqdqavZOyEOLRqv82IMU86k+msIgq58gJcSBw5BY+ESwDQ5zxnU0Baq/rxD
z9Rq6mDKNili+QAHiaHDFuniNEPG6RDSATYh/dNTF/8xwbo2fwhhq6IJ7iUJE1y/
6XKvGKlGgWXA0c6V58++LDqBJjRzD/1OEVCmp71zZbkoNt4UuGjxm6bbR/sjbFNM
b/5KwQ85xzDDpydOLWhRsokXv9MVVxDbJnibl91CLN9ovYnfqr1umt4TCfmDE6Zt
fYl960uVpbvYlGcj9SzRuhRY/dGcSn+ismeNOdCYPZ1RzZelyieeUUJ/DLivrkKt
nVc4fSlth2xooho0PciAV6OHxsfpp2k+a+NswDy26KfdpP40e6k=
=K63b
-----END PGP SIGNATURE-----

--Qje5kEwrEZ5gnJr5--
