Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF93A6F07E
	for <git@vger.kernel.org>; Tue,  7 May 2024 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715063436; cv=none; b=VukaYAGcEpyJKAAwqC3Cd0r+9svxQKaJVglFCGTM7YCq8WU1OnH0mftA9Yhm0rUHc9FXDv6iUNadig1hZmighuc/nfzBp8sOkIS/yY5dFOOM6YDU7Kefv8kOHhtu0u0Y277nD/tKR0DmEFpTLVoBXWDRptwDQynKcv54T5JFHyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715063436; c=relaxed/simple;
	bh=/jXmeKtlsiyZQCnd/M5Ff03k8GLa+Obe7iwR3fJ81qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLuiAqx5wWi+TZ8PBYkpne4DTC1aLgfswIxfLLWkwsEHCQa6apjHjuQpl/YR7gLig127x/TTAwlVrsvjwqIIwALqwQuEPv4lc7Ci2+BN9HIDzomkdw31v+TISrc8dGyDw2PryFXCVEU+siC36tw3fEovv5bDoOZf1TDS3b1MGrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QjYyLuuQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RhE5IUNU; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QjYyLuuQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RhE5IUNU"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id BBB0618001A8;
	Tue,  7 May 2024 02:30:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 07 May 2024 02:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715063428; x=1715149828; bh=oepsyccwto
	aZem8poYywuEYMjSEfQ/vsMhQz9pbIXs4=; b=QjYyLuuQwKlk74Fq/F5wIgUfMz
	m3XtXyQmyGTjJHNbEYoXLYnr20VzK5nvaidbS0AG9xWQVlyEEJIJGW9tHRziAErh
	CuwqFV21BudhITFYUmmjeXcyOgppf6QHSZnjOcd1ckZw5hW49FixV15v3dOtTmFU
	IhqdeNoTnJ5lc9C9nt675ZU5B/zKvNZ3GKOhx3MBr1KkOt9imn6zLdpDUbjfJpLm
	cpg36i1n1c5gNSU51566eFdRHGwTN5/1J3B+tDuXsLaFGXb4FruUQuzAHYUtpqL1
	lOF7aJPZz62KKJ0Tz9eh1fblU6BdsBLEg4m2/hIlzoihmO16BSdl/g3b+5HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715063428; x=1715149828; bh=oepsyccwtoaZem8poYywuEYMjSEf
	Q/vsMhQz9pbIXs4=; b=RhE5IUNUdyblOVoColv9gTh6ddgKt2rwfAQ1SQdRfkMj
	kz8IkcoGDfdcgHbLkXqXHmdpz25tPKp3Ag2F4cBOD/zge2+vloCGrrIwitIm3BAK
	005KaQxL8g8tmfIgIns0DDKLxhyw/zbQaJuoNRiHM44pmnrmU9hGyUiNHX+wZ3BK
	gMFJ1NjDaYrzkGo/2S/bJ0b54b/2Ts2WxG3O/C72HVHh7PnKmbAqxJx7jEUBZ5+G
	KhuQ+EzA7zdWFsI76Qhm5jPDS7NjD0FDeJlePxgvZz++lmWEznSEGAEPkSSo9nz+
	J+5xsE2vfPbCU5XkNUTvlw4RaA0TRaganwQmuui/Kw==
X-ME-Sender: <xms:hMo5Zqx9f1EH10kuhdhPiPb0i_ju6-rKv-68FDQeDK0frwNDSxqNPA>
    <xme:hMo5ZmQmt4jI4BQI7sTrG_aUSFYBiazar0dfyBmU8mMPwk44zZ5gjHKcRfWwZ9mP8
    softI7oUl1YdtcF8g>
X-ME-Received: <xmr:hMo5ZsWICdYWl_8a-13SdNOpy-z-BShNtGdzwMvuw2mHtYJSw7HXrJ0nn9MwZrtmSICW2g0DlGtQmso5KgT_bhXIKYZ13xIxxIMtwW7gkajYCuf2UA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:hMo5Zgimb-NLLQWQzJMUP6MZ0NBpKIujWFQhXsk1FrBGq362rfetlA>
    <xmx:hMo5ZsClWGGpY-R7M59iifF4qiLIkgfHcPjvxOoYoi4aVvez_dkUsQ>
    <xmx:hMo5ZhKvj-WDTTZqzHcJelGSAgq1sFyLH7FcuraUMzfyOXywoazVPQ>
    <xmx:hMo5ZjBIrUg9IwKGIMpJrgFAkhVJI9lB_yf_85OE44j6xliWWtTa_w>
    <xmx:hMo5ZvMkhDbKlde_13Ohr2q2sVW1bwVlYODktPNORtnlEvmRgvcur2ff>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 02:30:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 524ba836 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 06:30:17 +0000 (UTC)
Date: Tue, 7 May 2024 08:30:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] refs: remove functions without ref store
Message-ID: <ZjnKfllMW9rGgWPL@tanuki>
References: <cover.1714717057.git.ps@pks.im>
 <xmqqikzu95cf.fsf@gitster.g>
 <20240503173553.GC3631237@coredump.intra.peff.net>
 <xmqq7cga7nzo.fsf@gitster.g>
 <Zjh8XWwJKp_I1dwE@tanuki>
 <xmqqseyu3ojk.fsf@gitster.g>
 <ZjnCoaVP9_wuYiHh@tanuki>
 <xmqqa5l2ta7e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OVW3zlRGmYA8JO+z"
Content-Disposition: inline
In-Reply-To: <xmqqa5l2ta7e.fsf@gitster.g>


--OVW3zlRGmYA8JO+z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024 at 11:20:05PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > message. The best I could come up with is the following:
> >
> >     #define REPLACED_REFS_FUNC(func) func ## was_replaced_by_refs_### f=
unc
> >
> > Which results in compiler errors like this:
> >
> >     bisect.c:712:6: error: use of undeclared identifier 'read_ref_was_r=
eplaced_by_refs_read_ref'
> >       712 |         if (read_ref("BISECT_EXPECTED_REV", &expected_oid))
> >
> > What is still missing is the bit of informatino that you need to pass in
> > `get_main_ref_store()`. But maybe this is good enough?
>=20
> What I had in mind was a lot more stupid like the attached.  For
> illustration purposes, I just did only one, but you got the idea.
> Thanks to "#if 0", the compilation will fail, the compiler telling
> the developer "resolve_ref_unsafe()? what are you talking about?",
> and the developer will grep for that name to find the hint at the
> end.

That works for me, too. Thanks!

Patrick

--OVW3zlRGmYA8JO+z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5yn0ACgkQVbJhu7ck
PpRCbw/9G0N4j45QWa1g3VOxPNvgXU1DMudKhKT26H6yFkWdZ4oznfa0MhBWh9MH
pBtzu+HI1txxRim63l3LeFoB/1RUcQXcAm9vPWQoL6hGE2o8WJQjr43oTI8SSBNb
wFoNN7cH9+wEKoCEgNvmLgkR1e+0AqVVIkxMWPax3wTF655TfWED78qiAdNZr9y/
Y/+MTor1L02+UZLxZX9ZUIFVxqmHX0Mm1X5uJ8SZdTMGTGzB0R76xgw6H7xJk7r0
eXrJV1nBQEq+Vf4cXt1sKAen54mjv3k5Ftjm1f7oWqe3Ici9xoEP2IPqpbd53+L9
h+VwxqsAZYTU/4MAehb/d2yPmw6DmGE50mkzIyvEbM0zaYRKM4OjI2PWzw4Cq/BF
QlbqgeRr28xKxWVm6+d884aD8OXJQ9QIA1UbcL/X/aSwIPwtTPunvgmogNaZuwzb
82ww2u9zXZsJIinCH+/K6aDA42moTXxOnWoWxYLZuPhioq2Ad5lAeX5GqXquojgX
TPb/v+Aw5SaM6wS3U4XP+42trLe6hmOd7CT01z5uE0PE6coI/CwZYElK2J27UDL0
4ZYSnQwicg94koag0QqlLA1kR8QdrYcdWAMe0okKzZvccLujPz4ECghvTP8LQZJE
iN1LQWRT2vLEYkAr6juOcCqe6pckhQEkA3CfrfoMd04vRGV5fjE=
=AV15
-----END PGP SIGNATURE-----

--OVW3zlRGmYA8JO+z--
