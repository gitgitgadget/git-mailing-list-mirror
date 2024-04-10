Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1A98F44
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 04:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712722822; cv=none; b=DCVnmSN0zJAQbfilY3IygIKANAcyTM/5q5q30/06WCBVPGjzk7WONnPDb6X5EMrsbSGQuO2YjMiNSfmR/EwSL4AmXMcCIMxXR+zJQCrmaLxB8pASevyqzw7JnsScyWJJ6ZPMnZc9iaJGp4Grbyn+iClkXdfQPTvPcPC+tMdC/WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712722822; c=relaxed/simple;
	bh=iBLUFr5pMps5gZMwUykC+OEdNkuqyGVkKJcrxRvtj0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRcqDZsJ/qe6LmWfp8bwkZ55Ipk3517YoVylsmkABON4+Jo+i3VDxoFoet9edmnrs3LrYC6ofvXkIr3Pt1ioRsEew8p6TO206tM3pql3P5uwnlSS56n55vXh/UCifgiZ++zshW07Prhg1f3OPthVfJQsqGoHBmQZg8N/r2EoZk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KZ1CIJ+W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X0gt3rDz; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KZ1CIJ+W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X0gt3rDz"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 7A39C18000BE;
	Wed, 10 Apr 2024 00:20:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 10 Apr 2024 00:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712722817; x=1712809217; bh=jLAR1ipnUM
	o5oxkK2qsVs2Ie5dHWB8VUYTAFPqjQU04=; b=KZ1CIJ+WLKunciIIXmDNjN21cn
	EoGPFPWWc7YT/lTit2SDYxvLOvGyXK0Qe53IHeIm8Mt6PjOeAcaPbfcIUkm+R7QW
	rRGxKiza6Klt7N5sfX272+b8YX8LbexhNVd9DDxYEwcCfq43MV4cp+LUo4AsGENL
	33gF5VetwwuqXniKiHliwHB6n50coIt7Bp6o3MAeQRKfoWn3ILfrgyZzWv4KfhuP
	86oYASyW86O9jnixscIW6KImwOVr5g/8utLjVT9aZG528K2of5vk1/HNpbs83VB1
	NQXgEg9JJHv2cpjuqPI31fihBWi/W5rlLUygHPzgiDBffKBuKtjA6cWHG8bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712722817; x=1712809217; bh=jLAR1ipnUMo5oxkK2qsVs2Ie5dHW
	B8VUYTAFPqjQU04=; b=X0gt3rDzAO3TY5OP4CrTMUqPDfx8sU0ziEh3062A/zRY
	pecQcgBK2D3acl1AIQpomXbef6XkFVCR/+HXt7Q1oVj+9ou9LhHf1D2ouNGc0sGJ
	uZQr/aBEgb33MM6/SKAviLdmd9mCLEu119+9iD0F5eymS9fgXNRcJQTobqndZrxl
	3kLZVNhREREbmvCG6wrgX0PSDLD04y8bNnj5L6JjdW4Dzwxm088EJX0MXP7bWEhI
	gHJqGfXXBXzGjph0Ebspt/hHneg/HKUXTHr7imE+UbpIp5pri8kKwAeJ5IxtoBMT
	SetylkCf8o/KqYlOOzmYrCTah3Dn50qyUHclaqc2lQ==
X-ME-Sender: <xms:gRMWZnjMXY1xt4JqcVAAviONH_5EAUlp55_Qi2b2aICkSb5YIp1DzQ>
    <xme:gRMWZkD7OU3DNhWQbVAJJUAiCwKlCLt5TpYzN2owRANjUcCCId5j0KhOkUMOWdQWs
    5vqyTl8s7tyypnUFA>
X-ME-Received: <xmr:gRMWZnHSyw-ior2ehGOnpYTPbgs8pRB-AKr3Eg0_7se23Z-NqCAi_L8r51aLnjEGrpYBVvym7chv0jur5AUrx2kXKDDsQoFRgBHDVXir2IAEDfs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehhedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:gRMWZkSM6RuSeMXci1ttjIkHFqgUdku8pYaandjfdmXRAQCAuPSlXw>
    <xmx:gRMWZkyVaTlKLueenTSAA5QQ5GL_KKSCbSbsODHC6hVsl4y0oo0qBQ>
    <xmx:gRMWZq51DVm1WACV-sRt-1--i8Kcerv8fUIxx7ME5nFGppJN9jqEWw>
    <xmx:gRMWZpwAe9W7lPchE-oinDnVC44feiejWiRNFQ4jb31f7mdaDlRy-g>
    <xmx:gRMWZuuGuTlxIdz_HVNHjEra6QUzTd4I0wU8IR5PWhPrsKacfmaD16nh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Apr 2024 00:20:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 620697aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Apr 2024 04:20:04 +0000 (UTC)
Date: Wed, 10 Apr 2024 06:20:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Chris Torek <chris.torek@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 7/8] refs: add 'update-symref' command to 'update-ref'
Message-ID: <ZhYTe2zpJyHJ8iIT@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240330224623.579457-8-knayak@gitlab.com>
 <xmqqy19yf40l.fsf@gitster.g>
 <CAPx1GvdXdH3OdY1nC2ijVSdpWfg8jn5=j0KB+Wgv70wWeCNH5g@mail.gmail.com>
 <xmqqplvadmeq.fsf@gitster.g>
 <xmqqle5xeun1.fsf@gitster.g>
 <Zgv4H66NmLZ_o1IC@tanuki>
 <xmqqil0z7m5y.fsf@gitster.g>
 <ZhUsrolJ0_HOH1eU@tanuki>
 <CAOLa=ZSmDZcM473c2dNB0FTv79Vrh92YRTnVR74jOfzX1naNRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XGrc6gmcbYouLMGJ"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSmDZcM473c2dNB0FTv79Vrh92YRTnVR74jOfzX1naNRA@mail.gmail.com>


--XGrc6gmcbYouLMGJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024 at 09:15:59AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > On Tue, Apr 02, 2024 at 09:40:41AM -0700, Junio C Hamano wrote:
> >> Patrick Steinhardt <ps@pks.im> writes:
> >>
> >> > because they have been supported by Git all along. It simply makes o=
ur
> >> > lifes easier when we don't have to special-case creations and deleti=
ons
> >> > in any way.
> >> >
> >> > So I'd really not want those to go away or become deprecated.
> >>
> >> That is a good input.
> >>
> >> Do you have anything to add as a counter-proposal?  The "I do not
> >> care what was there before" update mode does make it necessary to
> >> have a "zero" value for symrefs that can be distinguishable from
> >> not having a value at all.
> >>
> >> Thanks.
> >
> > Sorry for taking this long to answer your question.
> >
> > I might have missed it while scanning through this thread, but why
> > exactly is the zero OID not a good enough placeholder here to say that
> > the ref must not exist? A symref cannot point to a ref named after the
> > zero OID anyway.
> >
> > In my opinion, "update-symref" with an old-value must be able to accept
> > both object IDs and symrefs as old value. Like this it would be possible
> > to update a proper ref to a symref in a race-free way. So you can say:
> >
> >     git update-ref SYMREF refs/heads/main 19981daefd7c14744446273937546=
2b49412ce33
> >
> > To update "SYRMEF" to "refs/heads/main", but only in case it currently
> > is a proper ref that points to 19981daefd7c147444462739375462b49412ce33.
> > Similarly...
> >
> >     git update-ref SYMREF refs/heads/main refs/heads/master
> >
> > would update "SYMREF" to "refs/heads/main", but only if it currently
> > points to the symref "refs/heads/master". And by extension I think that
> > the zero OID should retain its established meaning of "This ref must not
> > exist":
> >
> >     git update-ref SYMREF refs/heads/main 00000000000000000000000000000=
00000000000
> >
> > This would only update "SYMREF" to "refs/heads/main" if it does not yet
> > exist.
> >
>=20
> This is definitely nicer experience for the user. From looking at the
> other commands, {verify, create, delete} I can only see this applying to
> `symref-update`. Making the syntax for update something like:
>=20
>     symref-update SP <ref> SP <new-ref> [SP (<old-oid> | <old-rev>)] LF
>=20
> I think this makes sense to me, will incorporate this and send the next
> version in the next few days.
>=20
> On a side-note: This would also mean that we should somehow support
> moving from symrefs to a regular ref via a transaction, so that means we
> should allow
>=20
>     update SP <ref> SP <new-oid> [SP (<old-oid> | <old-rev>)] LF
>=20
> too, but I'm not going to tackle that in my patches.

Yes, I think that would be a sensible idea, even though we have to be
careful with backwards compatibility here. In any case, I think it makes
sense to not extend the scope of your patch series and leave this for
the future.

Patrick

--XGrc6gmcbYouLMGJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYWE3YACgkQVbJhu7ck
PpScbBAAjHKFT8fqb4Sz95GtU2MBZiaLETK0pbtxyyy0PHL1aX+GSqhEWBEZgWGR
5ntf9B1kUKYnYnG7G0qOIIbpZJkmXF1YJ0Edxx18dNCTz3664pK/Lncc9H7mrmUT
0GcyuCSleugysNUAmxtn+VLOtdV6aE/n/XBnlLN3Cw/ca0Cyuvfsr5kLyKuefv2t
84/8sMsCAIZxj0gVpjyEOVuGI3C61VxZEZexNwrzTk4hKgP/DBzwURwRBc2mTcXq
oHtdlJiV/xIPE82VGFvmQpTnfb6YU1RPm96e8tdmAQGQddAgidF3TCBluFhLB9Q6
/jmbhnBFzCiKOCK3lg+jtVR1y7wOiGL6OqDkETPvNs8LczBwCnEWnNTJhHmvg5C8
OPmIlOJIy24Yw9i5Vwfc/tjmEvEj5D22+7V1N5TUMQIUU3uWc5KK120BIhcWHXM7
uvccemb4ZIEezXnMN/1lLTV0omizd1IVOEM6CCKY89PLA/XjUBP+Odwn081/qr0k
uYH4Hc7WgSPloZuYBz5C+NkWmAx9AvXRBIthLHbA1bjTg1SKbSadyMCkm5rLwnZq
54Qf2dOT9TcCdcPmspMwGzI9l8PVlZZuwZhlCtHPM8x2kZZh1H9+vBrkaGQQ0Xtc
jpNLJs0WrQj4JwPcrWhaU9uavkBxdSQedJRRhz0eZzxPcLPGu9s=
=e7q0
-----END PGP SIGNATURE-----

--XGrc6gmcbYouLMGJ--
