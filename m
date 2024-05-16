Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E0A14293
	for <git@vger.kernel.org>; Thu, 16 May 2024 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715853293; cv=none; b=lzNJnvKPKdSqBgRvNXm6NYHc+tFb9mb3ftSwjJxBGfCxom98Tb95dd2poB9fY1k038nAB6RstIKtPd8AUp+oToA9W4c+Xq713SZTBizOEnWcd0Hr6MtzKRP4iWiWmbjL59vJ4u0rHmOuQOiHUjBudBoQ6dELw9dt91TEcWVEmtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715853293; c=relaxed/simple;
	bh=Jtza3S8f+DByHwi0gDzea/L23dl8mi4e5BfHlAQBwRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKnk600TtogvbnvSNojSpR4tWEe8Pzuz59z+xhbDX0EX/hj0fDnsa/6TMvdc80HW8Nb/4v/pU13ybwCC4dYR2FaA/K1QR1n/RG7AJj5/ED858IMJGxlDFnr3BytTya1ffyiZ6KmpV+bc6vfg7ugC/Igz+i2WHUVP/9ZRTeIPdcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lR6k5Jaz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FhJJDXsP; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lR6k5Jaz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FhJJDXsP"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3B6A611400CF;
	Thu, 16 May 2024 05:54:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 16 May 2024 05:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715853290; x=1715939690; bh=pvx6D9evXy
	3ObJRWmw0CbXHA046WL44sFhdUk+9sq6A=; b=lR6k5JaztrTcCEzavZKMEvFLGe
	5hdTAtgrHNlrmuGI24sJNCCNokyGGxYIDKpaU9o8htDAyCI5qGBbjtGz0nqKa0jg
	IzjQMdDKrUcMzQ+3QJw5PLGTTGmV4y+1bwKykxPHc2h2Q6ROFrDZOgsdnNvqCuH/
	BgNF6FfJv3JbkEUbMlbSa78eXtd3tRWUdyjlyvvaUoigjOtSrXXENP/cG37fwOJ7
	UGgEhr2CtY90MVZ8LUZHXoFMuvD5GB7a7KasfBuukFK1i55Cam0YMCwMYliYOcKx
	l/VHFJJKsuuYShpW3fv8ScSy0rZFqf3nUZPWhGZpmjUMzy/XDwdvmYbZlrDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715853290; x=1715939690; bh=pvx6D9evXy3ObJRWmw0CbXHA046W
	L44sFhdUk+9sq6A=; b=FhJJDXsPTfSm4v1hvcJUcOX/Hro1QFAN+LFTwscdSLZg
	+/bUC4nEoQJPYNiIpz738QwHZA2WxAHgobhUHGAoiGL5XG8bmBIL0/ywcOlVG9JB
	lFt4h+QIycHkY0ClNBsUhpWnLZ3I/rYycFSxNdQO+anwbUhK3crerfFeTIlVLT7c
	gexAKw6xkZ2u6C/v7zL71HkinBv3W+QSTf7StcHa0hWCyvBNFGCH0WnKEYSusr1M
	pGTAhDqoueBPqeM6JxXD6f4+pKm0F1uv89lQxZ5URyXV/UIJXjELPIMBs3UIdqjh
	skZ9wa3A6uQ3f6qAdFMqPax3TYhid4bp/6hA3IJptA==
X-ME-Sender: <xms:6tdFZkoAHuxcYvF7PpDnBbSuZ3_EKLDBsS1Y1Mmbv-G4cO0OP4_4CQ>
    <xme:6tdFZqq3NjXlMk6eEnUHZfdtwHBzi_UbqrD1UbMWPpxsat8X7xXuavhi8XZ3yHVNI
    vdOsvC49UTO1BMgAg>
X-ME-Received: <xmr:6tdFZpNHZ4W-gTlCuYkAZJU9ide05MrS9Zuc4-a7XM-PS5eAfZJzq3RT4dGRXL9Bs04pdis9y8qLCxGnXyAHGND0aTacrRRpGQDe_yF3F7UILwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeiveektdfggfeluefgvdelvdeftdfhge
    eugeefveejleeufeekgeefffehgfelgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:6tdFZr73rlFsRY289nqFGJ6g3FAYJS0mrWchZoGRQpWWpPuGZdi6FQ>
    <xmx:6tdFZj70f11MWDt24yaAcZrk8-dsjwJJYddKcEG_WFdE_QYm5vEoQg>
    <xmx:6tdFZrhO-TI_B0_otqcUKkn4IEMkcSd-vTyiTW1wsznJWfZFm1P3jQ>
    <xmx:6tdFZt5lHUVJLUO3JBGnwg5lFztPcCoQ1zC2n9gKuio_pCAXf7CWeA>
    <xmx:6tdFZm2SFhsM1bftMws6rNaPwk9vg8JSoojkGIEAqfA2HH61Ehre9x5g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 05:54:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ddd6eaea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 May 2024 09:54:21 +0000 (UTC)
Date: Thu, 16 May 2024 11:54:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] ci: avoid bare "gcc" for osx-gcc job
Message-ID: <ZkXX5MlN3EbaMhNG@tanuki>
References: <20240509162219.GA1707955@coredump.intra.peff.net>
 <20240509162415.GB1708042@coredump.intra.peff.net>
 <CAO_smVhE25ZQqc1f_fx9oPX-kH8SHxwEc=mqOAi-xQ91+pF1CA@mail.gmail.com>
 <20240510220228.GA1962678@coredump.intra.peff.net>
 <xmqqseyp1dys.fsf@gitster.g>
 <Zj-pGGGJEXlH02nR@framework>
 <20240516071930.GB83658@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4HaCDIPuHYcaaS1i"
Content-Disposition: inline
In-Reply-To: <20240516071930.GB83658@coredump.intra.peff.net>


--4HaCDIPuHYcaaS1i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 03:19:30AM -0400, Jeff King wrote:
> On Sat, May 11, 2024 at 07:21:28PM +0200, Patrick Steinhardt wrote:
>=20
> > On Fri, May 10, 2024 at 03:47:39PM -0700, Junio C Hamano wrote:
> > > Jeff King <peff@peff.net> writes:
> > [snip]
> > > > [1] Another quirk is that we run the whole test suite for both
> > > >     compilers, which is probably overkill. The main value in compar=
ing
> > > >     gcc vs clang is that we don't use any constructs that the compi=
ler
> > > >     complains about. It's _possible_ for there to be a construct th=
at
> > > >     the compiler does not notice but which causes a runtime differe=
nce
> > > >     (say, undefined behavior which happens to work out on one compi=
ler),
> > > >     but I think we're again hitting diminishing returns.
> > >=20
> > > Yeah, that is a very good point.
> >=20
> > On Linux, we have the "pedantic" job that runs Fedora and only compiles
> > the sources with DEVOPTS=3Dpedantic without running any of the tests. We
> > could do the same on macOS.
>=20
> Yeah, I think the infrastructure is there (looks like just resetting
> $run_tests). We probably could stand to use it in more places. E.g., is
> there even value in running the tests for linux-gcc and linux-clang?
> It's _possible_ for there to be a run-time difference in the compiler
> outputs, but we may be hitting diminishing returns. The main value I
> think is just seeing what the compilers complain about.

That's certainly the biggest part, yeah. But I have been hitting lots of
compiler-dependent behaviour. This is mostly in the area of bugs though,
where for example toolchain A may initialize variables on the stack to
all zeroes while toolchain B does not.

I guess this is mostly a question of defaults though, and I think it is
partially influenced by the overall toolchain environment as configured
by my distro. Especially hardening options are for example quite likely
to lead to different behaviour.

I'm not sure whether this is sufficient reason on its own to warrant
testing with several toolchains. But we can easily combine this with
additional tuning knobs. Two separate test jobs with GCC and Clang are
comparatively boring. But if we make it GCC+SHA1 and Clang+SHA256 then
it becomes more interesting.

So I think dropping the compiler coverage completely is rather pointless
because we already run multiple different jobs per platform anyway. But
we should investigate whether we can cleverly combine those so that we
do not need a separate jobs just to test a specific compiler.

Patrick

> But I dunno. This thread argues there is value in running the tests with
> the separate compiler:
>=20
>   https://lore.kernel.org/git/pull.266.git.gitgitgadget@gmail.com/
>=20
> which I guess would argue for doing the same for osx-clang and osx-gcc
> (if the latter continues to exist).
>=20
> -Peff

--4HaCDIPuHYcaaS1i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZF1+MACgkQVbJhu7ck
PpRxdg/+OluHtJom5wZl1djo+HXjiN8s+NIClqSdnqBVNVqMrefKTsYR9o4JFt5V
F9Gpsx66gx6N3GbgHgOkpwuaWNd4BsUUYz4CHbDVf0Rg3XyD8/TphPpmyzI75cpc
kNCRYK49uEPnm1SGJW96fAzXGfgQi2Hhlin2SYMrUDD8CvpbRrcnEhawX7XrVCD4
Z5YcgN9hl+oKCG4iof+KYdNc++bISEwkD8yLMQ9ylZ8pNGf8o8rraaYH5VLDUsXK
UwglWIY/zW/gBRgY5ndwzjWHaAcQPf+YAiaAfaBSFh8kqpE57n/0ZKX5++hyWD6W
XgNK66UqgRtljfIsInybSSnODSWx2mA2yk66EpQ3feiCRut7WAeS0lob5NPDtm9Z
Wy6Cd5chOHvV5p5WHOm7MUvZhXv0F/VAr9V9zWU0tWHBszetDXzVgzmnBS2q3B08
AUZIyOhkHKr765Pw3+C0kWuCu+Jt5pMw8KoinuoRdTFGKz9zKjz2mhWp8gOnN2QY
FqSPws0MzTDwCn+HAKRWOZ78cmGkCfHCIEIZ/j1oJXud+kU/X1tm+L5QQ3VUdzt9
vQ/E40DWJW+e1bh+pYGL4zaoM2XGxCVv2EVi0i9892UDHNtlVS/TZFDc2vuOoxbo
9Xh0fMT2wiBJ4ZTKns3CMYcBJUR3tez8jGEkJHM76S8h+T0gANA=
=zIDi
-----END PGP SIGNATURE-----

--4HaCDIPuHYcaaS1i--
