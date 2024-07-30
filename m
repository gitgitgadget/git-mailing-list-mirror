Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA311494B5
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722322193; cv=none; b=OuBDSGBuvpFaBEhn8yjScxbMMnjIk2Xd4chmZDVLx+5MSNJ9flqco4N2bfIWLR8ov+XyqT7l8Yg7NZGy1au6Q09lpLdufbMoP9LAWJjXejYji7QZrvXHVVTX96es6uesDhcRd9fuL0aMMNLOp/rSjJUtgqLxlGTZRAoVqG2sGzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722322193; c=relaxed/simple;
	bh=5dNLbeCBJuxksa8c6DbdDQvpBKkVADD8bDp0Loxhg+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sp5sYCKOTLViMC0siJbQ6c42xGEOVU576hS9jSeTvdeDP/IvID5lDqaWR7K724XWR27AYKFpT/NSFMkV13vx++8R+n6D9Z7KGNLSwRTd9+ZtSsEmLSZ5AbIqZqDmCtslhCKs4E9m76MOGQBq/M0cVQg7gAd7W239U1H9scMjNWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a8oRXmHA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nkaFRc9f; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a8oRXmHA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nkaFRc9f"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B46E0114047C;
	Tue, 30 Jul 2024 02:49:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 Jul 2024 02:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722322190; x=1722408590; bh=6COG8fAGdR
	cSNGjXYoEP6Pq7+mfaxOfzvjDICPAvyYc=; b=a8oRXmHAbDSnH+qucbIVBUyxtq
	/sMe2my0EcKLyJdzxbbyS/uRPWdZoEpskH1jBgmSTJVKKw0phYqj2EIKruJIGLU3
	v9cobsTXCHXJUJomgVZSS7kt8nVXylPo6XaE9KhEOvrcxFaL8W7Nojt1RefiMUKO
	bI//PO6Kl7LXH/RHHAdAxSYZ2+o5CwKmH/kMpUQ6TfykRK/MlRX2x/E/wrkkf2DH
	0b0LFfrwxny0fqgUiKAkYSg3jTTsa/Nx4faHz7b5xqVvu5QH+/MoijYN2gg1TSid
	OhHLXF7FXiZtHaJiLWxYpsvsW1/mbgKXAgummM5WRa+AT23vbOGJbvaMOp0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722322190; x=1722408590; bh=6COG8fAGdRcSNGjXYoEP6Pq7+mfa
	xOfzvjDICPAvyYc=; b=nkaFRc9fsGxyE1kW90aqPve5BSvgSw12Bl1a8+H08Xvk
	+QkMMoqilaB7rAyzzL6RQRkqnHegtIMpWGEk0V/7iOkp3OHVM9iV0oFC/ImF1qIF
	TH8a3926qrkBRB9LPJQbyZKuULW3kS4yEuEOT/VFHm05icBJbDT7XpnmVJwQ9JPh
	RKWGEf0p4XoF7Ys/bAXaidx5Mr5FhAt6MSpMmAelVVwjvMNnfO1/CdFvm5YtwsOf
	WE5erv2VgEbJ+h6/UNZT6VE8cMQkfV3aOz+6z3wV4c1066ZIZJdT2BLOxYePp5x1
	HiaJNpJikySRkCNqYlSYqFaRInlnIVWt8jgApR+ODg==
X-ME-Sender: <xms:Do2oZsfB5yDpyyXBGVO7q3d0DZJO5JF5P5OMekvehb4bqsyNpxi-jA>
    <xme:Do2oZuNnMLigKdpynJoMvLTMG5WdppjOayLzBG6kLBrfVZ0YioV03VDpFjKJ5ve8i
    jgBWTzfYsbGHKkZ8A>
X-ME-Received: <xmr:Do2oZtiFloCrNGcArrWxQUxWLwwjAYXNZaLFQ4LAjcLhF01yVZhb1-jGUQO90e_zqDU0vUpAo0GXQhHSFy6DBAVBUvEqkQNrn4punNkIkS0SVMk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:Do2oZh95WvTolK0LOC9M8CJ-nArkP9eOREiS8bVTDoQjgMPCml3gLw>
    <xmx:Do2oZoswLxrWsGxoqqW2M5dFdvZSDH1CD_tClggp3gdyYfnH8Ntrtw>
    <xmx:Do2oZoEpv1Z_-6Y43QBLetTcUT-JxPuFgSCTGxXdz0k2n8KetLBsOA>
    <xmx:Do2oZnMjOEJJhdWFHM6szl4hgDHT-RwwdGW6BeGdxXFbbxdX9rdeew>
    <xmx:Do2oZqKN0Uh8_C6T-3WKxpxaanZG38Q09_wAOXU50nNDc53isclMONO6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 02:49:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id dda80845 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 06:48:20 +0000 (UTC)
Date: Tue, 30 Jul 2024 08:49:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] Documentation: document difference between release
 and free
Message-ID: <ZqiNCdI_ls6NE6iM@tanuki>
References: <cover.1721818488.git.ps@pks.im>
 <5e1de3c3159968e897a83c05dae5e8504d37a16c.1721818488.git.ps@pks.im>
 <CAOLa=ZScBn+sMB7BWMpsS=Ld0sUW14Li5JVuKPGKtY91hVo4jA@mail.gmail.com>
 <ZqD9keTtimiqJnJP@tanuki>
 <1841a256-5c01-4892-99c7-ad7df14e6e0e@gmail.com>
 <xmqqed7iu0qt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c1UZGnMfUn6lebK3"
Content-Disposition: inline
In-Reply-To: <xmqqed7iu0qt.fsf@gitster.g>


--c1UZGnMfUn6lebK3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 11:02:34AM -0700, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>=20
> >>> I noticed there is also `clear()` used in some places. Should we also
> >>> mention that we don't recommend using `clear()` WRT freeing memory?
> >> In any case I think we should decide on eithe using `clear()` or
> >> using
> >> `release()` for consistency's sake. Which of both  we use I don't quite
> >> care, but the following very shoddy analysis clearly favors `release()=
`:
> >>      $ git grep '_clear(' | wc -l
> >>      844
> >>      $ git grep '_release(' | wc -l
> >>      2126
> >
> > I think a fairer comparison would be to look at function declarations,
> > not all the call sites.
> >
> > $ { git grep 'void [a-z_]*_release(' '*.h'
> >     git grep 'static void [a-z_]*_release(' '*.c'
> >   } | wc -l
> > 47
> > $ { git grep 'void [a-z_]*_clear(' '*.h'
> >     git grep 'static void [a-z_]*_clear(' '*.c'
> >   } | wc -l
> > 58
> >
> > So we have more _clear() functions than _release() functions. I think
> > there may sometimes be a semantic difference between _clear() and
> > _release() as well where some _clear() functions zero out the struct
> > after freeing the members.
> >
> > Thanks for working on this it will be a useful addition to our coding
> > guidelines
>=20
> Thanks for doing a more thorough study of the current codebase.  I
> tend to agree that the number of actual _clear() functions matter a
> lot more than how many callsites call _clear(), and it would make
> sense to standardise on it.  If everything else being equal, it does
> not matter which one we pick, but it rarely happens that everything
> else is equal.

I'm not quite sure that I agree with this. I think coding style is most
heavily influenced by what you see most in a codebase. So I'd argue that
it is both declarations/definitions and callsites that influence the
general shape.

This of course means that interfaces like `struct strbuf` have way more
impact on our coding style than others, simply because it is being used
all over the place. But in my opinion that follows naturally, because
the coding style that we use should work best for what is being used
most often.

But anyway, this is splitting hairs :)

>  - "release" is a bit more cumbersome to type and read than "clear".
>=20
>  - "clear" at least to me says more about the state of the thing
>    after it got cleared (e.g., I would expect it would be filled
>    with NUL bytes)
>=20
>  - "release" places a lot more stress on what happens to the things
>    that were contained before the release takes place.
>=20
> For example, upon either "clear" or "release", I would expect
> everything pointed by elements in an array member of the struct, and
> the array pointed at by the member, are free'd when we are
> "clearing/releasing" a strvec.  But I may not care what is left in
> it after "release".  It can be left to hold all the bytes the struct
> had before "release" got called, as anybody who called the function
> are not supposed to look at the struct again anyway.  But we may
> choose not to have such a variant and always clear the struct after
> releasing resources it held, just for good hygiene.
>=20
> So in short, I would consider that "clear =3D release + init".  If we
> want to have both "clear" and "release" and have them distinct
> meaning, that is fine.  If we want to simplify and do without "just
> release and leave them dirty" variant, then we need only one name
> for it, and I do not mind if we called it "release", even though
> I would think "clear" is a better name for the action that behaves
> as if "init" was done at the end to make it reusable.

I actually like this definition. The only downside I see of defining
`clear =3D release + init` is that `init()` probably shouldn't be allowed
to allocate any memory in this case. Otherwise, calling `clear()` on a
structure would not cause us to free all resources associated with it,
which would be unexpected to me.

Patrick

--c1UZGnMfUn6lebK3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaojQgACgkQVbJhu7ck
PpSawBAAp3CbHhtn106dZM/ineWkA1XOfT9+yV8digJXLNqTZAxpKoa8E9hXtR8M
/G6P7JuJCFSmcsBA3CxwnHFNGzHu4IaZtuQgNxNaBQvqBkQlDa9Mf/lxKjHSdT8y
lZtnqhDRkYSE6Vvr2hMPg8QCAZbxhNxzRftA/CfjSVXuBPvGGEck3rKypJe6x1Y8
CU7xa2oONsAxtEN6pglf9S9gog5Jf95lCB6vyTDJYCSucQUIW7dSDRiuwhlmxfpg
lVijBv9VPwqIVMJaookq6JGPFIKiZ2w88+RKHeRvklF9F4uTvMZ7sAIG8L/FCw7n
7IMT6VmgN5kGjWKdwUyI0sIg0D/1i43DH4wFm0zWi3jJTDm8qJqu50Q2VyM5Nw2B
P/LXI+nHRFFU31JDoe9MTFrjc8rPIjMIBMUbOJ5tGcGn+sPWXgbERAlZggK3tMwc
i9rhGUAB5AmdZnWmXQ+gUuhWyVBFUjd3Gu6v6sBRELiQr3N7YXRDiOjEIavZRYHR
t5sE2yJYgHgWfNPgNF/6ARRJiHcwggeZbhJruA5NoqGaBozHdAuZIuMW1rEW04Va
8/Y48XaaS3Bh7lJdLnhWK2x0ZuiV8XCTP4g4Sh3oV3bolp5mocswmhe20bmStImz
wxJUdQ0ZKujSQrx82ClUqUrHTKDAcEh980TgezdOSIkNtJsoT1c=
=nSwe
-----END PGP SIGNATURE-----

--c1UZGnMfUn6lebK3--
