Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B470118F2E7
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 06:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321832; cv=none; b=LZVnggIyffq0kuuDyLV9zSIwvuk5cAWBk0pkT+TsLhn21P7nsvsvWPfdfXA3i1EQ36mgLmkO7JvCyt/xZ3DZwjF2+8WsrO0gPoXgZ4oazS9zvD/aLjTbRa6gzBsVilvyg2Plg3RK2LCbdfo+nEr/8xFd2VwGLn2tD48RvwZjrhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321832; c=relaxed/simple;
	bh=Xmp2HvPh8C1/N5KtP8WHV0rRCzEPWeZe0SFXMb6HviI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siFPDgnLXMcDQUvs8gqxlnn7QmdjxbusrHZlqqBsbTzUqxgH7YbIKJN2BWFcMeqvY10oQ8KsDy5kYDCEEegOSWIMcWRWnuBoLT/c9jQVl5WHK6lT/nQpGuQ16DzXPUATIDnH2XTYiqIIIBFYLI4IW+d3IiecWR/kvbyMFjYuAK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KagLJJ/v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pBEUpu6u; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KagLJJ/v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pBEUpu6u"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8317C11405AE;
	Tue, 30 Jul 2024 02:43:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 30 Jul 2024 02:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722321829; x=1722408229; bh=7lBrlFQNxD
	t3OAdMoTRvt4J8ZvKeDSaR5SQmNXF3jqc=; b=KagLJJ/vKSyiqbqGnpMNIsIVv9
	nnwqMoyMAD7im2pt2zPXILXts0kvO8A4wAn71DeN/GC02+HOEK9LUTKF6MLWTB1w
	6nYeEAusd3uxrNmwokd3FzCnGDuykX/T3qp/7IHHGKBCZ4UUa0Usx/zlo3wLH9B6
	SrCzUbzBJMr9dsbm3X1Pf6szMCUYRthuzsgIEwFB2F3uQ02dBtR+1LKBUrwTIuzK
	xvEJyFdPYrTnGgnd42fWo9qI9Nh2i3+hlYZfYgN9tsDFtifEkejbcayoJOsEZ4Oh
	sLVdENPlA10zjwpBrKAVZddqMwhyNd0fQ7EvIpKsdmaxSSBszs94L79FObRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722321829; x=1722408229; bh=7lBrlFQNxDt3OAdMoTRvt4J8ZvKe
	DSaR5SQmNXF3jqc=; b=pBEUpu6uaSCHgAE9Y8aYVkbclzxRTL/yKx0UQX4/m2xY
	tqfJC90QweXaiRSchs9QigJ3FqeFqYnluTVu89mcBFDaCSqtJZNhaH3oKW7IoJLQ
	SbsLaVUbMqNCj/fIiQelnBgAUcnM7vV7RML/8eCgP8s9QRsqEE2d85Nsi/7HWetY
	SzNHdfgrK0RGngyyhtvW+LXrGy+P/pdT8g5g5dffqglYZ5w96IckT6ie3bu96qGP
	Ah51JD4FaTj1Tk1yRCIPX3RSB7WioNdcKnSxKW3dUV+s0kVFHpg+frICPfXU/Nai
	q5enpYEs6TZnefKmOkM5MY9PBTRB23Z1OM95J8BVuA==
X-ME-Sender: <xms:pYuoZh64COpvPj1kapYMQV7eq6n_bqQu8FQlXjeXNFr3ezt6D55KqA>
    <xme:pYuoZu50v4L2pGkQPJSb2MfsgcEfJ0tlA01elnGyFqbpD8keO2M4x1j58jXwuKsD7
    3qHiJyCo-XID34nPg>
X-ME-Received: <xmr:pYuoZof1WtVutycudFRu2A7LkIhHhijKeCrggkH6jcG-jejm7u_shpMvvm1IQzQBaLAa1llpkOiCH9yafU8_06YaCVTbjFwQo54PVErXHMqywY4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:pYuoZqJAqT_4amta5e5EdtWljGTIKka2E8RwGZZdlXwK4qcUizDZgA>
    <xmx:pYuoZlLVvXiQBtLYA_TQ13sNZ_TeeMjDFQcGGj85n7QOIM_21dxKEQ>
    <xmx:pYuoZjwc-jpnIkm-NbhpealH9sAsgUprLuY6cAV0a3B_-AHspBL3qg>
    <xmx:pYuoZhJ_yVO5K2JVV1JQCmXf31iXt0A-9XxC_Tr9h9PfWpKf17xhgw>
    <xmx:pYuoZl1NGzDZOECHVl8zMPc4VSSd-3cAED_u7S5hQReBmSn7xo1B0BYn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 02:43:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5a03eaea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 06:42:18 +0000 (UTC)
Date: Tue, 30 Jul 2024 08:43:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 3/3] Documentation: document difference between release
 and free
Message-ID: <ZqiLn6JR5BBf9sJU@tanuki>
References: <cover.1721818488.git.ps@pks.im>
 <5e1de3c3159968e897a83c05dae5e8504d37a16c.1721818488.git.ps@pks.im>
 <xmqqed7iwx4r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Sd5mBDzZtJCnzzQ3"
Content-Disposition: inline
In-Reply-To: <xmqqed7iwx4r.fsf@gitster.g>


--Sd5mBDzZtJCnzzQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 09:52:20AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > We semi-regularly have discussions around whether a function shall be
> > named `release()` or `free()`. For most of the part we use these two
> > terminologies quite consistently though:
> >
> >   - `release()` only frees internal state of a structure, whereas the
> >     structure itself is not free'd.
> >
> >   - `free()` frees both internal state and the structure itself.
> >
> > Carve out a space where we can add idiomatic names for common functions
> > in our coding guidelines. This space can get extended in the future when
> > we feel the need to document more idiomatic names.
>=20
> We have _clear() in some subsystem/API.  Are we sure the listed two
> are sufficient and _clear() can be replaced with one of them
> (perhaps _release())?

I'd think that `clear()` can be replaced by `release()`, yes. But in
another branch I heard the argument that `clear()` is equivalent to
`release()` followed by `init()`, which I do like. The only downside is
that `init()` must not allocate memory in this case, as otherwise the
`clear()` function would lose the ability to release all resources
associated with its structure.

Patrick

--Sd5mBDzZtJCnzzQ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaoi54ACgkQVbJhu7ck
PpS3lg/8DOwlc+D3d1tqbTix2oGE7YQyImIb1s/yXRsg0bAj0monE30BmCRCo44g
UlN+i3YaOxwYvAhrvcTn73qxp/QCngLXrx3pTmJWVO/98SZfCZRX5CtIadlpVdWB
xxQs6Ohl0+igWNOpSWoHhbhH/S2wJCtw9q1JLehAlxdeK3MtCiJbBkGg1y3asCcx
lmLf9KXusLUcs8tGKCZtzg8MBwBG1jAsC5XVUZsIpmQ+Ui4/Rw5advrIvJ1KH7vA
pSf9qaynwQ59XTjffgqUeJNVZeTD4C+qXFzx3WzRwBOPSI1D+RMbZ8kw0jk95x2Y
y5NgcnNcpMf+jlw9TI9DyHdkL6FCDZCuHrzrK0kbPN5CyEBrL9OWq9XSN1bgujsD
fUMcVFWMSFxDYd6Xp+BO82K6khg5tHnLILylXDm5Xstfl6C3eXnINGCOfjucPDNL
eflZ3wNfI75KZ4Ti+99JHZBL5Mt2wbCt25ugJaNcx+A8yFn6Q3CwyuG+rr/n2U7m
8KK2J4jGqaTG7gFis4l0N2b1KCv4IsIxY6341gaEoucTXTTg8LDbthbl6ZzEu07a
OiPsq5MqxUUQZzOqY3ZLhd+AAyZRGeK1RZd5d0spFgZOgE988YSv+8s4Q639xLE1
SLcp9TiIRATp0w27kQayHQwLoDiYSA78i8CO8CpxRuhVw4+gm8g=
=vydk
-----END PGP SIGNATURE-----

--Sd5mBDzZtJCnzzQ3--
