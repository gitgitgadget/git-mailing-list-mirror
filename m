Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C6B1D6AA
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 05:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712899656; cv=none; b=i/HdbuWKsZc0lp79eFe+QwZn4vdpOt36zB1OFfgElN66NZvEQjMoETc90nS2H9sV6PZfYZsBIgB3U4suCOQIlNE1GTNRkv0AgqPKSgiXmOa4q7okcCTuwuW3h9Z5U8OrFO8KaVhpZ+0fh74211kP4+bG98eGqg9QMABEC2xa09I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712899656; c=relaxed/simple;
	bh=CegrTLbURdGgJBK9fNMI0wGBzJvAPFXWmr5u8+f5xZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pH0utK8rZENHxklwHaDWk6xSwFI51/RnxNRKrt5pUWrqcZdOxyCQpbk7HcOjvVlJ3rP/7vAVVB30NkEmMuDZyw9fKBTPMRiPLSi9SHP6D8PtnZur5y3M7b6NgmhPziZ9qUZW6gICXGRJWtIVrF+yuxMVxLCqyCY1j8Ihl61OPag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TQyqaF2U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iRAxolKg; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TQyqaF2U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iRAxolKg"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2FE8913800CB;
	Fri, 12 Apr 2024 01:27:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 12 Apr 2024 01:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712899653; x=1712986053; bh=ARMvT7tZ7q
	9imDXA/ehfstPE2RtnuKa3W5zZGsZflCE=; b=TQyqaF2U1c2Kfc8uazditH5zJ9
	bI3N05IHAdfc0JRNBOK8aBQt9B5Zf4nzOyskLAv5HoQYPo6gloSeMy9C7j2rzCWF
	vcM7/KSBb0eQfFTs9nQTRP/vUF8+sCTv3GpI6OE70cGGjFQhkXgHDCDa5GH2RsWw
	50USpyBDU1905ukWAlqQrC4ySkNq96vRp/7y5mZtziYaQ9VwOMtDcYiDbSgyx/aC
	/xF7qub9a1DMcOta3qE+WpmKqrZWhLy9UlAhiR12+SnlEiL7H4lV0bTY0yAQv+na
	3IyvUppimL6A38QwWT7rkVppolVpZqQcI083Mhzbm5g7phEA2XPnnRE5JIag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712899653; x=1712986053; bh=ARMvT7tZ7q9imDXA/ehfstPE2Rtn
	uKa3W5zZGsZflCE=; b=iRAxolKgY8Hd1c/uy7AJ2ABEbhklkkUS3fJ1ikeqcRGz
	CiSLT2TvKsxUEEk5EW8+Z1v1aiLBG7WXQd9JWquNaNzrWLYKGcZ7DDQVmgavO69/
	dy4cWaErYpNygWjdWnhQF0cEVXwiuAGlj8+xF/HDE+mhpkPYdKIXdMAUajVQJH4E
	4itVy54CVuPpDhmkO6m/LHYlTNoI3p7cYGgJc+ERlaePy3TaYEcZys7mRcCEd2G9
	WNw4KrxX1VH036xvgsSumANrqenbS8QZIgiwX0MulTUQ7ES3WGjPn+LP+G1XvW92
	qUw96TjSViP4Kv7vgXn7qPZVRGErolUNb6TVD2OVww==
X-ME-Sender: <xms:RMYYZgQ88qjQEFQuD4aYqCIvr0Zr6eeRT7OS1u8HayBIP2AhcEhW6A>
    <xme:RMYYZtxBtaQWT_teHQJ334kbZAJtXPxQ9G0OSv7hlMD7sBQtJbdSV-sRo1_rpgdGR
    1LsLR5hhZoISE8OHA>
X-ME-Received: <xmr:RMYYZt0KiXDTQBpy6CTRMVrQJpZSunuuubatrcAYLZmnKKHTBM8xHzXep7RM2pXkT54L1sXzfIT8ME98g2R3FGrnD0CnDMl_8UohehjYHJ4sxTeaJHM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeitddgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvfevuffkfhggtggu
    jgesghdtreertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuc
    eophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdfgtdeuffehteevhfefjedv
    geefheevveehfefhfedutddtffdujeeutdettefhnecuffhomhgrihhnpehmrghrtgdrih
    hnfhhopdhfohhrmhhsrdhglhgvpdifhhgvnhdvmhgvvghtrdgtohhmpdgsihhtrdhlhidp
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:RcYYZkCau_jGLF7AvbFHbRqSMSWkuRvC0SRPrGshsBf5U35yqLCsUg>
    <xmx:RcYYZpjxuWNvSG5l7Iyxl4kQShXaYWQaXUUhHg9qu16btd73UFlv2Q>
    <xmx:RcYYZgoKQY54x4HmcOru6PPLRCMfNMajXS3DqWopNfzADYhp5MmiMQ>
    <xmx:RcYYZsjTi2DllRSc_4XUbPZ1CsMwS0kz1kPsEKBJXxEXMWWCfECczA>
    <xmx:RcYYZpcTaXP2aYWOoNLk7xEL93KuTYtwX8jbjhL4bVMcFp-dtNDyPqPh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Apr 2024 01:27:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6457a14c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Apr 2024 05:27:16 +0000 (UTC)
Date: Fri, 12 Apr 2024 07:27:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Scott Chacon <schacon@gmail.com>
Cc: John Cai <johncai86@gmail.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [ANNOUNCE] Virtual Contributor's Summit 2024
Message-ID: <ZhjGQDJSxcxf3mIr@tanuki>
References: <ZhcBJSP4MxX0AMFM@nand.local>
 <A7406B15-8DF1-4B3E-80F3-BC56A9AC4D85@gmail.com>
 <CAP2yMaLpJqZ+aC=rNPjkw2ybW7PjfbW5QuHnZ9mYs1NhJ1L5mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cal27hwMCyEtfx+k"
Content-Disposition: inline
In-Reply-To: <CAP2yMaLpJqZ+aC=rNPjkw2ybW7PjfbW5QuHnZ9mYs1NhJ1L5mw@mail.gmail.com>


--Cal27hwMCyEtfx+k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 05:37:52PM +0200, Scott Chacon wrote:
> Heya,
>=20
> I was about to come in and say roughly the same thing. GitButler /
> myself personally would be happy to help organize an in-person,
> recorded talks Git Merge style shindig in the fall. I'm also happy to
> help with some of the core team / speakers with travel costs if
> needed.
>=20
> I helped organize the first Git Merge in 2013 in Berlin [1] and would
> love to do the same thing again this year (my my, have 10 years gone
> by since then?)
>=20
> If everyone would prefer Chicago again, then I'm happy to just attend
> and help out however I can. If we think it might be nice to bring it
> back to Europe this year, I would love to take care of it.
>=20
> What does everyone think?

Given that I am based in Berlin myself I would certainly be happy to
see a summit in Europe once again. I would be glad to help out with
organizing things.

Patrick

> Scott
>=20
> [1]: https://marc.info/?l=3Dgit&m=3D135896927120693&w=3D2
>=20
> On Thu, Apr 11, 2024 at 5:18=E2=80=AFPM John Cai <johncai86@gmail.com> wr=
ote:
> >
> > Hi everyone,
> >
> > I'm grateful for the chance to gather virtually like this, and for Tayl=
or's
> > willingness to host these each time!
> >
> > I also wanted to throw out the possibility of an __in person__ Git cont=
ributor's
> > summit in the Fall!
> >
> > GitLab might be able to host this, which would be an awesome chance to =
get together
> > in person like we did in Chicago a couple of years ago. That was a valu=
able time
> > to talk about cool topics, but an invaluable chance to get to connect w=
ith each
> > other personally.
> >
> > It will likely be a two day conference in October of 2024. Location is =
TBD, and
> > depends on the level of interest and location of those interested. Requ=
irements
> > for attendance will be the same as for the Virtual Contributor's Summit.
> >
> > We wanted to first gather interest before determining more details. Ple=
ase fill
> > out this form to express your interest: https://forms.gle/hTcsYM4fomEqa=
KU59
> >
> > Feel free to also email me off list with any questions
> >
> > Thanks!
> > John
> >
> > On 10 Apr 2024, at 17:14, Taylor Blau wrote:
> >
> > > Hi everybody,
> > >
> > > I've been thinking that it would be a good time to gather informally =
via
> > > another Virtual Contributor's Summit.
> > >
> > > I had been waiting to see whether GitHub was going to host a Git Merge
> > > event in person this year, but it looks like the answer to that is
> > > "probably not" (though I am hopeful for next year[^1]).
> > >
> > > In lieu of meeting in person, I think it might make sense to meet
> > > sometime in either this upcoming May or June (though we could extend
> > > further depending on folks' availability) in the same style/format as
> > > our last Summit [2], the details were as follows:
> > >
> > >   - We'll host the Contributor's Summit on either Zoom or any other
> > >     conferencing platform that works for folks. (I spoke with Emily
> > >     Shaffer off-list and they mentioned that some Google folks were
> > >     interested in Discord for a few reasons, so we could do that, too=
).
> > >
> > >   - The schedule/duration is not fixed, and there are options to vote=
 on
> > >     preferred days, length, and timezones in the form(s) below. Last
> > >     year we did two four-hour days, so we could do that again (or
> > >     anything else that works better).
> > >
> > >   - Like last time, in order to participate, you must be either (a) an
> > >     active Git contributor, (b) planning on contributing soon, or (c)
> > >     working on a Git-related project that has interest in Git's
> > >     internals. If you aren't sure whether or not you are welcome, ple=
ase
> > >     ask!
> > >
> > > Participants should fill out the following forms:
> > >
> > >   - https://forms.gle/VVrJ7RbHVxurxZH99 (participants)
> > >   - https://forms.gle/iGnfexF4hDuK6MQe9 (topics)
> > >   - https://www.when2meet.com/?24557185-cHKWv (When2meet)
> > >
> > > New this year is the When2meet, since this seems like a more efficient
> > > way to collect which dates are open for folks within the next couple =
of
> > > months.
> > >
> > > The participants and topics lists are being recorded in the
> > > spreadsheet below, and this is also the place to record your vote(s)
> > > on topic selection.
> > >
> > >   https://bit.ly/git-contributors-summit-2024
> > >
> > > Please feel free to send any feedback or suggestions you have for this
> > > year's Contributor's Summit to me on- or off-list. Like last year, my
> > > hope is to have a small, remote-friendly, diverse, and efficient
> > > discussion.
> > >
> > > As we get closer to the date, we'll finalize the schedule, make sure
> > > we have volunteers to take notes, etc.
> > >
> > > I'm looking forward to seeing everybody (virtually) soon :-).
> > >
> > > Thanks,
> > > Taylor
> > >
> > > [^1]: Coinciding with the project's 20th anniversary!
> > > [2]: https://lore.kernel.org/git/ZMATKIaU1A1D0wJg@nand.local/
> >
>=20

--Cal27hwMCyEtfx+k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYYxj8ACgkQVbJhu7ck
PpSTxA//czMPeh+ruhW2ucmix6WmRz1AVndzSy4tMla/s+74XMJ8nXkCjFnd61o2
RoBsoaQi5XhWfwVn79b/KyYOVxas0OxCGZzLbjJ8Q4Hq78+6i8B61aHB1LVcV/tt
DVh5LZrdNdQw4b5Y2YRafGK8otIAkEvLwJeTLN5qjQb/H0/zcx7sB+Z29bgvzLSX
cClY2HeCW3z6E+YUeqIO8ymfAwPyAqmsQh/KGSvSC4WVQc5unPxvjz3DsVYizTr+
0acVyh5z2wjzdb03Ax9Uid+DIOIDI9s0y/n7dHaiTAfXITIczfE3X2TqT4ZqDny/
nGJKWLdbopDMuHydidGJ0yc2zML8avQj9Uiqw56mwY99C5rD67swQgU/xyv6+i3y
6Zl56CUfE66M5uDc59aTov/C2hGnLCES/nsCtXyv8hu8+uPEgKVwMkjBuY00/RpG
lDPsBPvDrIAHKEPBPrP1+R7eoPrvvyCruCT2nioElMJ70K7YX6t1pZE6ANOYKcxa
DuaI78+XyO5lukfzQkqhnv1Wgk+EnpNRvw1SeKJcpNRs1Jqg42NNB1ty/C1ctIaq
Syh317qkhTgslmbEKnQz246qpwMLbXoq7b0dzYBET5olK1Oajdb9Xkcjne+Nvrvw
bVofHnQzarTBrvmTg1Z64/FI1Ljy0iy1+ORz7+cQUGJri+BEN2E=
=hVld
-----END PGP SIGNATURE-----

--Cal27hwMCyEtfx+k--
