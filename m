Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DE216133E
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310085; cv=none; b=q5t6dXBNzfFFVQy/Y/+FKTq6QCsRD7uEZp6CZIBJHqNPbhF3m5ImVxLw2hHOPzeX0BUgwJrjXJL7vRtr1Hz68b2w5yHj87Nh1/KqxP56GysUDXM/tgUXlDzp5ODz1qVgOSjNx4wICyZlgFFzPrRTa+nkANk7b/daXhj1jFZFvpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310085; c=relaxed/simple;
	bh=Uz0Sdur1D0en0azuUvTTuzCSrrCXNh7WMAXFgkHfYu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vECTXNTzq9c8sGAEzf6A/zP9PpiuHcZPkmkjQoRFyE12RaHIr/O2WUmkycQO7dtFZWfhrhrlMHrZe0EhfgvpKn5nT2/MK7xGbfs9Co8qXEgGiJVYdGHmO5c4PslvxIdmzoykfRl394ZwGYife/bNM1U1upSFqiwt1/8cz2uZ3Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UFvLAFHX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SpY0AeWi; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UFvLAFHX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SpY0AeWi"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id C6130180008C;
	Fri,  5 Apr 2024 05:41:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 05 Apr 2024 05:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712310081; x=1712396481; bh=LfwAahq6r9
	mRXP1R0x/V0thPEU0jIMuZPgJPZnbG1oM=; b=UFvLAFHXEPB6E+6z5kC1nAyk9n
	b3+jX8+evPBT0FM8sBlfzW6M2KE3VjYfNquDa00/AcAQu1Rk/hb0tIT35kJOtFUd
	ibTtKkInksvDogTZSygRXP/0Q8bCqEn7LS6UEdwZBeVdpNr/FpSf6tleEiku3muY
	mfQNZW5D9gsSBLHCJ7W8gGUN4Y+4xJy6Iwe3RKqzKoCIuyo5QynQul/+5r0tWpnU
	XvKG05kBdjCTIe0mQZKvWgOfNVM6Uj6j939CJ2vndcejykDSmMdjeWB/VYvvG/8Z
	Fwn9C4cuUEQ9bP7IdHnzs7v0JTR2T7RshQmHX0mwnWrBD32as87in8HfKMyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712310081; x=1712396481; bh=LfwAahq6r9mRXP1R0x/V0thPEU0j
	IMuZPgJPZnbG1oM=; b=SpY0AeWiGReh/7wIH9fmb5r4FLr7wmQS4S4II66PbDj0
	LRE1DREOvjIMnAZQ59o0xowpvJgVCFRPqf3PEWLv4jhB7EsHig467IwYvCtEHx0A
	FCi3gkd0vS6lLZkvrr19wcdMKa1yflBlLkwzuffsqTkQnf5fqz4Mq2ysc4EgAMOP
	b2uPVGa08rxsfGQLn8QxAudbFPOv51I64S6dBV4mP+n4IjolqI4/0PgiJwDTZr04
	BuhsmfWCBukEQKetyAvRP5iamye97u5F1Ym9Qp25VnwW+mdR9d5KFZGQAWWnVbTs
	XI8bsiw6iDYmg1HicqqGHyme99VGBYnC5IXevp4w5Q==
X-ME-Sender: <xms:QccPZrw-cs5aEjes-2-fZUaxKdb1_S1RZsyYS-SzyUIFCKVPyBamew>
    <xme:QccPZjS6R7ALrWmCxK8ynwZ7hE24U_xOvY0_NXe4F2VQk01rJYu3-0JVWSsMekGCn
    tGAhg8Ox_zAfkSlfw>
X-ME-Received: <xmr:QccPZlVYJTeT4jGYa5EJslDR9a7awL0oYAgQUce_mHu4V80Vl4nFjwEC2z-PjzPkw-ph2ELvXZA5RIW1kfprz7jITfPCnMynQJX3CFNkfyAiubb5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegtddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:QccPZlhmgnHTwN63Lw7zci0ctXBIi8PHLkclGUe0SIAhKEJf5Tslhw>
    <xmx:QccPZtBn3GFN4CyeTN440vleK6utBzLFL78bUpo6BfnLkCdWN79uiA>
    <xmx:QccPZuKvw0Tfq8zhiLp-CVEOlQ0-huqesscU5p90tylcmGLcdoKcmw>
    <xmx:QccPZsCATKrqd86RcQAz7tXZVQRdjcG8SLOhRM13hTVSwr8h-w_3bw>
    <xmx:QccPZv3KHOjm1PCtEGBcx0n2oGZ6aoeH0BQFaA3QBdSWz8lwGWCcgLsR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Apr 2024 05:41:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c09cc0eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Apr 2024 09:41:15 +0000 (UTC)
Date: Fri, 5 Apr 2024 11:41:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
Subject: Re: [PATCH 12/12] t0612: add tests to exercise Git/JGit reftable
 compatibility
Message-ID: <Zg_HPQFlNazTlDRa@ncase>
References: <cover.1712235356.git.ps@pks.im>
 <db66dd4155d80b714719e80ff90f64c1d36b97d0.1712235356.git.ps@pks.im>
 <CAOw_e7b5wDKOcY9hSty+c+z-NWVUgri3h3ScF0qd1Y6cmfsyVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1m4GD+kuZfTVr4r1"
Content-Disposition: inline
In-Reply-To: <CAOw_e7b5wDKOcY9hSty+c+z-NWVUgri3h3ScF0qd1Y6cmfsyVA@mail.gmail.com>


--1m4GD+kuZfTVr4r1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 11:40:29PM +0200, Han-Wen Nienhuys wrote:
> On Thu, Apr 4, 2024 at 5:01=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
> > +
> > +test_same_refs () {
> > +       git show-ref --head >cgit.actual &&
> > +       jgit show-ref >jgit-tabs.actual &&
>=20
> This seeks to the start and then iterates to the end, likely skipping
> indexes. If you want to test for indexes etc. you should also sample
> random refs from the namespace and see if they are returned correctly.

True, I'll add that.

> > +test_expect_success 'JGit repository can be read by CGit' '
> > +       test_when_finished "rm -rf repo" &&
> > +       # JGit does not provide a way to create a reftable-enabled repo=
sitory.
>=20
> You can do "jgit init && jgit convert-refstorage --format=3Dreftable"

Perfect, thanks for this hint!

Patrick

--1m4GD+kuZfTVr4r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYPxzwACgkQVbJhu7ck
PpQFvw/9HjUsnFSulsMsK8rEm2MsnRedgHLyhwtRBadzmnHoKZ3Os5l/qButLys6
MpWdgGvvLXOr2Ck82aLY4HXQsRtnqN5SFWty2mhLhQb0zYkKvpSmdMr5Nln5udQ9
04d/0VBqFdBYvIilCIxt7JwocMj8rxBPsR5W1GkR/YUa3PR1GjogRTBJtUd22Gxa
v9lOHTIfzp3iJ8hUKTvc4Zgff1UIFywbBLaTjFJyKOUE277m8MVPLGIFG+2Vq9SB
IrCI1KiJIXnhAkxO97h9U+jWUYBT6LNxse7J1aU1JY95tSZfndThS5LSg39s2w4T
1WdMpB2rRtNTcseNc4f4CGwiByxRzIhFAo2h810l/YOkEokxUntb4uKVed/7m4ZP
S++614E/JthsGUjgyCuS75FL7ZRZ/uEe1FaEyA6a8NwqMqXMWPKe+xHD6+Syl3pP
IFhf/JXsd0SM9eEYthWRSuAaVCP4xzz/ZXmiyuS4P87w19peiIjTmq52NsTGva9m
iW8+yFc3Ecr+bX2kXKOiZYMzkNfnlGA2ex0s1bwQev0IzcU+rG02ZxGK6p6HHh7+
1zjqr0rmY2/YlgVXZoy0olFW1dP+vTy9Z4pxQSo5785SokBdngPrKdXn6jQTI1r+
IZI8FsVSZMCp231YRnKte+ESFuX9IMkl8tH77aHoOJpTIGCC5gU=
=/MGz
-----END PGP SIGNATURE-----

--1m4GD+kuZfTVr4r1--
