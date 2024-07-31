Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50462260C
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 04:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722401987; cv=none; b=r8chAYlZdr5beH4lFSsWbbbEq8t5B7a/NOCHxChcc6zFS7jLKxN4O8HtFe+E/CJZsRyOe+Ixzkg4P89u/1keRv3hC8XwUViev/IK2TThfPi+m0FgOG/dtrMBgTeISlKY1pLL5GiWpaXvyDvxbee/3rK6zIqrHpK77BOgbVpprr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722401987; c=relaxed/simple;
	bh=Ss/E93on7LZPMwTpFtyOUWUcwhRx337noHiQuGVzoWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/cJlr5a1I6cCFccHD2gDxM0ojjWjXIgRZChcSfb0KPzoEzOOe/UwBXaszN4+UN8sYdT2f+GX0RICfJGIQ14mzDJE4mQJMNnSUwaBulAPQAE219/9rsunOOTbmSj27f0rAFZpQZR+X39Y1LRWKe66C6yFtcLViEL9nP3UL7WAPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lN6pDBad; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IBc44tgS; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lN6pDBad";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IBc44tgS"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 92A811146DEC;
	Wed, 31 Jul 2024 00:59:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 31 Jul 2024 00:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722401983; x=1722488383; bh=Ss/E93on7L
	ZPMwTpFtyOUWUcwhRx337noHiQuGVzoWg=; b=lN6pDBadXqo7PcxNczrs61P9n5
	1cWqyUGQo1M+uzr/KXEqgQK4uaXa01G9jp4IXTQOjgU95Cc0izIQpwANHbe+5m4U
	wtRPzU2USFE5Twd7S9/auuTUZ+kko6AxZYSPdL2cd+SPn3zQpVWz3FpKcdUaTDHz
	1wiYs8S+LDQYzKJziggt3AX/vTUPbHALJmSGiDc/5dioouU2CkJ+if6DGEq/BhMT
	4+7QarRduMXSjs0ZLUjgNX8npjeGn9a2/amJfLZUs1p7r13qi38Ts1dx9dyg+CUs
	T1OE1M/FCn8u3YS66JTcSHB7/dGwXHdMJGWn+oEycM05VepD404dOBllkJpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722401983; x=1722488383; bh=Ss/E93on7LZPMwTpFtyOUWUcwhRx
	337noHiQuGVzoWg=; b=IBc44tgS2DFoIj5LbDRsGlXf1Q78C/taavTRfOy/Ehpb
	JjSvV3rBAeMjPaXOi6HeRYjcvjsgNOx1u532Jt+9R04lcBUflme0SUsb7xQQrx5q
	WLY1bQmffuZzuE29kp/STYqQySGOb0nW7afJD5G1ljUwF8Le9+BXLJSdF1QbTl8l
	9roMJ0hsb2uJYLBuNP0s0iWD5iFDtOvW03l4bEAwbbWxbEPL2cmeRyEdfqg9hJPi
	vtlVXauzIwnzaM9zbEcrw7U6ZWv0r0DR9vvlLyTdsiIQcFMUNAlwK3zoSXuFa2Pc
	etNV1yqF4Nj7wEt4q6VO/MBxVCuUg6B8RraDBdQBaA==
X-ME-Sender: <xms:v8SpZkOUkzbJaq82j-hVV-saOQyyQwgkSR05siQ6muO4IcAxCRWg4A>
    <xme:v8SpZq9uxOOBQ-OUF1rq277zPMonP8TyRnkwRXIxpdVa__OmI1GNDi5jSPd6WuNrN
    osCck3EX4VcWVqPGg>
X-ME-Received: <xmr:v8SpZrSyyDjee0-IlnaLbRXvIdqxiWSh_b--hx-YrWENFgCSq1a7WTksoQa6g8o6G_7PzslKx7i_r3feLhXIq-2AectqyJzdT3qM1O8wkAgW247T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeehgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:v8SpZss61ZhNdHPsXWgJlx8veyhDero5BCWNMcUjYILEK4HW6a46VA>
    <xmx:v8SpZscuBB9m0EHhcbsKxj2zSKOsP6bNlrl93Jd8Vriko6kf1keEzg>
    <xmx:v8SpZg1RKSnwVYaqKOw1JACwSx_MAy3oE9HIZ_raHoTJs-ti-u4ruw>
    <xmx:v8SpZg_CAhZ6jOk3stghaLQ2SbNyWEnloZAl4nZ4kKgQGTP82t__EQ>
    <xmx:v8SpZtqtJbH_b08xS9g4Y542owx0TlngZ4-NvLvCYAEmQPX8XegvuCmV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 00:59:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e9396aa0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 31 Jul 2024 04:58:12 +0000 (UTC)
Date: Wed, 31 Jul 2024 06:59:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] refs/packed: stop using `the_repository`
Message-ID: <ZqnEuz9uFgUwWKkc@tanuki>
References: <cover.1722316795.git.ps@pks.im>
 <d164cd3aa12b67ba98c9b878543497482441ba2c.1722316795.git.ps@pks.im>
 <CAOLa=ZQqh7x9xaZXenRoMM8+fE+c5jOG73J5hPg-q=b_s+vxXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yv64fObYMZBDOS5w"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQqh7x9xaZXenRoMM8+fE+c5jOG73J5hPg-q=b_s+vxXQ@mail.gmail.com>


--Yv64fObYMZBDOS5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 07:23:55AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Convert the packed ref backend to stop using `the_repository` in favor
> > of the repo that gets passed in via `struct ref_store`.
> >
>=20
> Nit: Might be nice to add that we move to using `get_oid_hex_algop` in
> this commit. Since it was also mentioned in a prev commit

Yeah, that'd make sense indeed. I'll refrain from sending out a new
version of this patch series just to amend the commit message, but have
queued the change locally and will send it out in case any other changes
are required for this patch series.

Thanks!

Patrick

--Yv64fObYMZBDOS5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmapxLUACgkQVbJhu7ck
PpRLXRAAjmihMgblzlVhW5IUqNgF/n4PdizJMy6WHoEk/LhpLq6uJp/OFCR+7mUM
/Hbl342Ghm+GyUf3JFonZ10ySZXlDZd7bLQ0qos8W0Wt7bW23VM8Os3A9UKYvRno
zKY06/Q9f91s5WoQAIHgWEIjNBy5y7/eG7Q3ps5DiSEYYeXEgNTV+ouMaXAxWmMF
BFqqea5OHpRq1Rb0sdKalFiTmCWGy4cb2afY98xwb3bqb9zbyYtsuDvE6M1e5FNw
pdOcCWAyf+ejbihSwKbTfuLE/tn6rbylo2XdM9OoH3RBrx+SgIR5TuocwYVyoIcZ
CZPB8aQGw/mUnFHpM6JZFhQgoorHYss/CnYV3RsncwQ+wdYjkICfSrbzxp8hm0x6
BrMoB7ssDdueqPYzO6M2P4yxUq3Nk8smTyFtRQEHFC9+pfoKbB4T9E3p0PHaMKgE
01EVUS5VftwSXj81/1dMdOMAo6g85Z3wAoGQeMki1QKifPoutxPSra6kNgMPwawI
HzBo38rF0BNPg7hPmol7pRmc/oqbwXVp0iZP6vXnmLoF7025aUkxr5cIOUUaBtSC
0tisj3eYFnt8w1nnvaWgNIkCh2DgIDP6g0gelRG/m8grlo6mSou2st3rdOsDdfJ1
RSAiK7KXnBBuEPbj32n2O98LtBA7uwFLmzDEfMJc5qkWUNm0JOI=
=X3dK
-----END PGP SIGNATURE-----

--Yv64fObYMZBDOS5w--
