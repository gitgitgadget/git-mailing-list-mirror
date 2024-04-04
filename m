Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01421B810
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712211812; cv=none; b=fLOZhJol/TlKSwPTjksv5XCC8ghUrdgWI0jNQpYpksolgCQ3tEyDaSLX+KxYqEPnD9uOv5Cj7kyPj0whgR4Ta70u/7TTFwWE85Vqo3nqPCVqLsBtEV/lSyEnwt2Qhr4L9UzApVmdgPvlx8OeyfsAyQhFbyFn3+lguB77W2X0UQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712211812; c=relaxed/simple;
	bh=boMklrdq44ZHiXpS95DT19g36/K8vTgm0ZQ306unTaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxsqsnIC0r5l1Kp+92u7DHgLjmDgFfZ4SfkFvHlmxMtXgsf5cxoYy+u2VDvEDIW+1ZtE7CGyVU5LLlDWqqfF4AtHr0v8tEjneAiWhumUZAJuehQiNhLKYx1CHwO71BM8G6ANbr714930x8zyasOUAhMaznBr9mCSulFcPk8jaGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nh5yg5oI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=COEPnphY; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nh5yg5oI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="COEPnphY"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id EDB8413800F3;
	Thu,  4 Apr 2024 02:23:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 04 Apr 2024 02:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712211809; x=1712298209; bh=HNgg9Bxf6Y
	BcUWsTlWj9wz4JidUX0G4SQsNpg4UbX+g=; b=nh5yg5oIiyJQOs1pkJHfrSV1rS
	8CRn2Ho3FHPZmPgBUJSDyI16N9Mb+HpQ7bGJ/lx/jlUYmvRQV6oizvJlJWrfovlY
	6aH92lZk2+/ZvBAYezfCVy5hwDLI6eDV1Pnp+VzFC3z5gPgQ1cwPsB1H8xuY0EaI
	EmmLkRY/N8G9426GkIM9d4G6JbbPIkr8IhdSlbBaILRNtTWhSqGPFR/DOWzR7+PP
	B7y0VlCbtHKylXzQjBSJQHYp2gJgU6H8Epnn73JEoe6rdpIxx/jLrsEzr+Ly4LEM
	ZioYQDwXj1RhXb7zTaLh0Och0o00p7EPfd/APjf5en6XF09u87bEJxunBRJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712211809; x=1712298209; bh=HNgg9Bxf6YBcUWsTlWj9wz4JidUX
	0G4SQsNpg4UbX+g=; b=COEPnphYq3fa67lS+Rg1vqE5aaEksS0LmMzt6Qpf80QA
	kvi4NQawLtjAUckbJ4lsqqNytYXdFWgS39fYyac9bTK/tIb4BxpF6MHpmBQubQuJ
	Iy9s6795UlOpiM44+X1IF4qHpa4ftc7mtuQ+EPq+LJ/j59K+k1L5tHGfo7i5O/+w
	2AhmsIp0fqVzZq7MYPEtkOEJ9eCR82cOISdaC6ato3WZohfa5xpeFCLADMtQiwLf
	ygnGaiGc7D6JKZCxAmgKUt1rvplgyiyy66aMShbch0KpUGRFrBbaRpA0DK1NM8MB
	vv8P6AzakpEzjUbSnisTJhMEcLNJRLt4uzl+zG/GEg==
X-ME-Sender: <xms:YUcOZptdTBzIBAu6JvJFT1k2zSecplo6Y5kcM5oXQPmb43IDqcdVig>
    <xme:YUcOZic5d6WB7gZVmFTnL72ZBDFjOa0aAB294ZvtLbzOCm7PmKM4vlvhoDQEy27XC
    w9zBIC6qSOTYSXskw>
X-ME-Received: <xmr:YUcOZsy3cAqHn2AOLqFnI9LGulnoZYhSCEloRL9nUHXpzcYqfbOyM4PI0w6K85kQokaSxoPXpCnGKGcD5w8gIlyvg-PL5dDq4K9bnPDFlTh35rtk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:YUcOZgP2ElRfV2cNQulmb-DccQ5FpOrr_gsJ-syBMf1AM0EcXYL05A>
    <xmx:YUcOZp81IXbUfhfQGJBOiMt1pSWH5UZCeE9woJLVR9lCIYZfTpgRyQ>
    <xmx:YUcOZgVLy_PUWofZ4cLCUIBe1-voIA02V-KjMwv9FCBvIVsfKtGpQQ>
    <xmx:YUcOZqcAL2SykQfsN76UM0S6af_FGGl0waRal4_uSk156oiauNd8XA>
    <xmx:YUcOZlZdi0HXg85Tc9D5AmUlgwO65C0bHvZtyrudDAnZvwsKE8X8K_o->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 02:23:28 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 584a1a1e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 06:23:24 +0000 (UTC)
Date: Thu, 4 Apr 2024 08:23:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: git <git@vger.kernel.org>, Josh Steadmon <steadmon@google.com>
Subject: Re: reftable & jgit compatibility
Message-ID: <Zg5HXZrL_4BsyzfG@tanuki>
References: <CAOw_e7Z_10b73n91ihsaao_S-XPkNqvY7gTcHvqUODKD-SwPSA@mail.gmail.com>
 <Zg0zs2_QLpXv2PwT@tanuki>
 <CAOw_e7Y_MwgrrJzuHk7tzBR9a2kDfTnwCzC-7_rgj8UJPKqp9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JNev/HY7S1/YY/r8"
Content-Disposition: inline
In-Reply-To: <CAOw_e7Y_MwgrrJzuHk7tzBR9a2kDfTnwCzC-7_rgj8UJPKqp9g@mail.gmail.com>


--JNev/HY7S1/YY/r8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 05:57:19PM +0200, Han-Wen Nienhuys wrote:
> On Wed, Apr 3, 2024 at 4:41=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
> >
> > On Wed, Apr 03, 2024 at 12:36:04PM +0200, Han-Wen Nienhuys wrote:
> > > Thanks again for taking up this work.
> > >
> > > As I'm browsing over your patches (and realizing how much of the
> > > arcana of the format I've forgotten), I hope that I did not make any
> > > errors in implementing the spec (and/or that Shawn didn't deviate his
> > > implementation from the spec). It would be extremely unfortunate if an
> > > incompatibility between CGit and JGit were discovered after it is
> > > released.
> > >
> > > So far I have always been able to read JGit reftables using the C / Go
> > > code, but it would be good to systematically test this, ie. generate a
> > >  bunch of tables using JGit and check that passing them through the C
> > > code (read & write) leaves them unchanged. Or perhaps check in some
> > > tables as golden reference data.
> > >
> > > Josh can probably connect you to the right folks to help with this on
> > > the JGit side.
> >
> > I very much agree, this thought has crossed my mind multiple times while
> > working on the whole reftable saga. Ideally, we would have integration
> > tests that write reftables with one of the implementations and then read
> > them with the respective other implementation. I wouldn't really know
> > where to put those though. CGit is very unlikely to pull in JGit as a
> > test dependency. Does JGit have any tests that already use CGit?
>=20
> Yes, but not many (eg. CGitIgnoreTest.java).
>=20
> I think the easiest way to make this happen is if CGit would ship a
> command to dump a raw reftable in a release soonish. Then JGit could
> use that command to cross-check that a JGit-written reftable can be
> read correctly by the CGit code.  By shipping just the dumper you
> avoid having to wait for proper reftable support to land in git.

You do realize that "proper reftable support" has already landed, right?
So you can just use Git to create a reftable-enabled repository, write
commits and then use JGit to access the whole repository instead of only
checking a single table.

Might be I'm missing your point though, not sure.

Patrick

> Probably the dumper should be extended to also support seeks, so you
> can also exercise the indexing/searching code.



--JNev/HY7S1/YY/r8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOR1wACgkQVbJhu7ck
PpTyzw/+I+C2kqxYoK8VnKz7qzKM1IAExPRKtEUg28djzvqG0NI18t0lCo+Bz1T9
y9HxIADxs9WddPTbbrPD1cuoXpnV6zqOuwLWtlFd9d1sQsjRBYqbiLUA8Rg28m2Y
esqchokDArGb2fFdUqJHJOcQinD6X4Y8Ubj2GsYSwp8LZ4nfURPlMbF8mA7ArTLq
OCBO05ivCgs7+NMjwrGmRhqAf4QE6k0kEhsuHSGhtaQwRSqPDp5w9uErzVrL5Njm
Q/g0VjL4F/emWDLJ7pcK+tQVt+0k89c/x21Yy+qzLo7AlHWOqK7mbMOYyoWjsioG
3t2TA/5i2W/gYjC1pm+YqJalzwC3xjxBsChi5PJHop5qp5+KskfrjWXCkTdKYP7U
JM9A+oJXkJzk6zvc7DhFRHbicM+9q4JQdCJCdbCeshGVPpmRB6ngPXs++5TvPpLB
A+fkgEncVF9hsZ64F6P79XbnAKqm2nfLExEAFhm5kCEp+AC39Tn02O5EpzXrklP3
/QU52k/SDeIk0I6mYzy6QFi0YFx9wGZm1GNPUL9q6hq/Od4kD/whsPqHUdKNUYrR
6bCbcKiUOGuBB7cxJFR6tP+Ed8gUbVKdBTizfLenR0cgSNzjZUV6O/VQRTgJUFHu
qcqTLiW2fcbdU7VwQ7K0wsdXpuTtlRYUOMixghiN7HSv/VlcgT4=
=zicN
-----END PGP SIGNATURE-----

--JNev/HY7S1/YY/r8--
