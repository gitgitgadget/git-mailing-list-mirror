Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390B2F4EE
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714371263; cv=none; b=JvFftVhjjDvsUx7akyRKp1XloHDftjuAux/sCwuJcCrsLgRNJCDByKKYPg3oI1CrtpR4QSTMhhhQG+wx6FflqX03UiDJdjUlh2mZrsgk/31rVypTgcvDgPIBtZVBfk6ZcHQGh0k+KLVSA4BtWAwBcUJv/jth6IPYYAlMSHiSaoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714371263; c=relaxed/simple;
	bh=guW4lB3AFtOCyY4JFLo0TFz0yO2ZFKsxawIf3bJ3oKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKcwi/eIgMKv76f0LaNd0IVJYrN7Khn77lvb/w+0kQ3Tg0XKc6vrxe0sj4K4Gv7ssbNXy4fHT1/xWt4gYDIFXYrBYK1Bqc66iiwsbRggRnl8OM/dfJOKHbvrCsnn3adIq4aomlCWL9+FfqKSd/tq/I3yXwMX0jnvYzlAnY2y4X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n74sleq3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wm2Wa1ug; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n74sleq3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wm2Wa1ug"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id DA3EA1140101;
	Mon, 29 Apr 2024 02:14:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 29 Apr 2024 02:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714371259; x=1714457659; bh=guW4lB3AFt
	OCyY4JFLo0TFz0yO2ZFKsxawIf3bJ3oKo=; b=n74sleq3xOqInCUogI/NeUkF7n
	4m7XPH5g5tcNHkOHe+5+O2FqBqWbDES7sdl2/u1Rxba5OBR8KxMrleI+xKB/CTiR
	6iDxT2YUYCUdQk8a3RY89KbaQkpqh/yTM12Bf9d2e3ANwdWeJUKESk5bVgZCkVg0
	oFbzmCUYic/w5HJWY8QF6oyikaotaVQG/WZzJUHff6rhSNDBUfsDQZf85ZpSw8Cn
	Ols163Z3MMPVsCZp6IX85/iclM1xMIiOFg5t/JJ11gWjxO7v/nz+osysE8Z7H3jh
	vIMF72n65GrQIc38VWWPiNT5QEItrFj/dluGMdOvjZAT0KDd7A0yAncuVtCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714371259; x=1714457659; bh=guW4lB3AFtOCyY4JFLo0TFz0yO2Z
	FKsxawIf3bJ3oKo=; b=Wm2Wa1uginsaI4vzpozNhO05cKSiBBCGa3/scW1jvezU
	vR3KRctVzeupEkhH3RdZsDY0vwPso3zTG3t92d47Xa2UU0bpmjHFJptEWzEC9ezI
	NGftLqno1TuOU/D+jrf5Sf7uC5D1xoc3KBu2c/Y2AWHR2nKnjD/trSj3JY7v22a6
	j987oFxGjH+3sgaZ/dAooZC/1qXG3BcHMDvss+WE3s3g5gbJQrCb5iYkLdbea9Dl
	QZ14GaXG51863C9ojrVlm3/my2PC582uSI10qycI3jNIGnsA0XmCg3COZwFuYvSJ
	AULadXB3l05U5VXuPCshRxQCWtYM3dWsSCUbcTVjmw==
X-ME-Sender: <xms:uzovZrUogcKVda7a-Apo7GEYzXZaWfUXm7xSlAWrANphHhF24KRZrA>
    <xme:uzovZjkPY6Cd7-brdlF4CzK9i4oMans5P6LQUqcpHl5KFRIpLhMxkU0MDXFOK1Y8P
    Xe9oDSm9QcN34-A0Q>
X-ME-Received: <xmr:uzovZnYJx7d5cBg0VyH7eC2h2pOsAuL3IYEo8AXWKfPEQVsqgUTVK9ByGn_WW79hWiPfANHmXcU7kJmGCyBhBJVo8BiQS0_D9Vu8bZa1v4Wp2VhG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddutdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnheplefgiedtffekvdetffegudeuvdfftdffheetfe
    elffevvdffhedvffegleeggeeinecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:uzovZmV36mMW0Ga7dzA8cLGDluA_XuuZemi-RPBuzrYMLdkn0qDYUA>
    <xmx:uzovZllYeRW_j3LNceBq0Ki_SJHv65UkrYN3kv84H8ccB2L0iID2kA>
    <xmx:uzovZjcw_UqgwV2_2oAPD9p7vBfP0-3cgT7gafKUBkK6U9bNa-4Yvw>
    <xmx:uzovZvGCcP7Q7VO6vsvdXGizJfJhSPPvE1r-HbhCWNqHbhdguVyKSg>
    <xmx:uzovZqy3K-uSKb0V_rXrm-RzHaSd6G9INMf2WdmBUh7NRsKL6yZtNfXv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 02:14:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 615349bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 06:13:59 +0000 (UTC)
Date: Mon, 29 Apr 2024 08:14:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitlab-ci: add smoke test for fuzzers
Message-ID: <Zi86uFE5RlDG2RFN@tanuki>
References: <01fb94999f8e2014ba4d09ce7451a4f5d315ee72.1714371146.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yyogRkXHJdUz4pbo"
Content-Disposition: inline
In-Reply-To: <01fb94999f8e2014ba4d09ce7451a4f5d315ee72.1714371146.git.ps@pks.im>


--yyogRkXHJdUz4pbo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 08:13:23AM +0200, Patrick Steinhardt wrote:
> Our GitLab CI setup has a test gap where the fuzzers aren't exercised at
> all. Add a smoke test, similar to the one we have in GitHub Workflows.
>=20
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>=20
> As identified by Junio in <xmqqwmoi31aw.fsf@gitster.g>.
>=20
> Patrick

I forgot to add the link to a successful run of this job:
https://gitlab.com/gitlab-org/git/-/jobs/6735705569

Patrick

--yyogRkXHJdUz4pbo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvOrcACgkQVbJhu7ck
PpRdHg//WtLC59R9/3NfdcFCH6V3XwMuhXakddLm0cvjJT/XbDyQFlRxI9iVr4XC
a+oAfORW10dbHds5bnY7+OB0L5TeeB4hiPkX7JK2RLYMzuJY/7sW4Yd2Ep52Fky5
axJDWajyMPDxgpxixoID5Z2oHVxQvgSBmPgBCc3WHij8hlIMFXh5q6+hlrtYtR2x
2mKRLtA9WJcw+m1H5j2PVPuZBHYAnzhMVMJoLGa8SJT6dsW4iJ3VJwCxMv1gj+jc
m8ph3oVyuv5qzwvB3XJ84lrTlhTh/HkzeiKvmsfW/Jc7rONk3fIO1iYWF8JPUbmu
pFY8vd1iIjzTeotp3UmKpVBvtJ1ULym4pM3RMF8b/PwBUxMyY6t1RVsmrRbof1T5
wEReT8rmw4keGh3UE/79OMwOyOQ7Y/NmlGTOYcI31kyRGvp1UbzZCEM6v8LNkDnw
C171aX2JPCsbmmEXypNts5RO0GUoNW8GFYDcNcgDlUBAeRu2FRBqY1WZ2KxGhOfA
7nziOl4YIB9F8zoVDz6to68/sh1n3+w28o8O3qGLD/EP8JPbNa6dNwNIu8gzgyAd
n7FuSv5psIfJy9GeYViNFLmTr8IqPfkKklf1z5Ql8cS4GcT5vb5yfM1hsonXeT2B
Uq4ZS3+f0LbWzq+LE8EwCr/FIVtPKWQAlKnB5wzY6egeoKO9jmc=
=krAX
-----END PGP SIGNATURE-----

--yyogRkXHJdUz4pbo--
