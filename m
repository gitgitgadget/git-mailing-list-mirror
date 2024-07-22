Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECDB17BC9
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721638955; cv=none; b=G7BN35uCGCi+3Nt8JPKWM1h09sn8HUv2DJMjvVeBF7hRdE8RpAT05lxmfftza/79+7GqIWTYjmJ5MWLOjMul286ZJ9bYM350kd0LZssrT/v0pGyBRfFA8rKXblQsTBbsmZUKVe4NmP/6tsVuVx8Qr8dUeRSqQSgxH/zov8Vi66o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721638955; c=relaxed/simple;
	bh=jOIxsZ8tvXi30VDBaqeR07e5G37a5KCxSD8xdK4vqqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yn04k0yJZFcM4l6YeDcTBvZyU5D1RqNO9FyU86rGwtFbKtM4tnKy07kID+YBnlObMWdWQp0hIVqmpRKfWnGvQ75Gx7+gEo8rVN6qSBBAX1iC63c1cp9S8g724azHYMIZ9kbT7to1Mk8pjfLyslN5ajGDdbGpAaG4mJ0qDyfZpyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MjGXhxbl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PjSh2/JC; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MjGXhxbl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PjSh2/JC"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id EA5021380071;
	Mon, 22 Jul 2024 05:02:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 22 Jul 2024 05:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721638950; x=1721725350; bh=jOIxsZ8tvX
	i30VDBaqeR07e5G37a5KCxSD8xdK4vqqc=; b=MjGXhxbltWwhi4FYugMgq1DUjK
	hjph217ZmGSDv4wqybOlm1sGcidCX2mIWNvRlp/o4KAc//JuaZ4BTR7HUEawhBbu
	miaMarFL7uUDN2GuFN8ZRh9sD7teVUGtURK+DiYKPdyHn1Wem2iouUy4d6XGsB8n
	vREhH+FYEAXQIh32P47eNvCiy6mEPepoYK7mr58UhBpJZFgfgw7WQiNM/XUPj4st
	CnaLzwncBSxU9camaYiJ7ZQlPHbH/8uPyCs6AKaEEU6P6pK3wf/JF+pA1jpVLs03
	rkdM2BCSfzSclMBmgWu7FmIA55Af0UZRqvz0knGiBPw0vWDHNx0usavoFIeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721638950; x=1721725350; bh=jOIxsZ8tvXi30VDBaqeR07e5G37a
	5KCxSD8xdK4vqqc=; b=PjSh2/JCUIJth2sNGBTqQISicfx9BGaaT0FT9MON6viy
	TiZQIj6mSdkWp4sBOis+4RKLYQuJI/JV5jCVhswUJi9tG/Yb5cGu8A57U2Iu9o51
	3lcGLEPuRxb4WN8hRRrk4bIjeFUnNtGm+74P9jQe1kEMnwvAcyzeSbGQBZg5Hj0O
	zSNlBSqydjjUa8nzrNmzZgugLXuFhyu5Rak5x6s6lKDx8GVeVs4O0X5a/Av5GYUE
	jKJ0ZNdiJgzLVtwsgdBLkJTYJ5bVV93C23ijbt/GBe28ZhWMBaJsuc3WVZHFIIAP
	E+M3dmOGgEUGAuF59BmxHlbiHOvJvCrfaMtfz4vifQ==
X-ME-Sender: <xms:JiCeZjnMuWKe9OnkY-UkMUXUY-eB-i4qn6Ea5uNdL_S3LGovNaD4Dw>
    <xme:JiCeZm1GGfELZsLIWpQHy1eQjnfAqRZynK3YN1JyuXXs72RNWu8ZYLtpFN0fS2-J0
    6qd2mFZfQxO_a2ApQ>
X-ME-Received: <xmr:JiCeZppC5cZqjErQb_nbxuVeEOSb1o6sw8761v-gQPhIfHcrK9XTP7jcYzGHLqgVUhE6SpV5aWVFJ1gCDnCGFVxzeLXMw56n7pmFqKOqPAw6NXbFEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheejgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:JiCeZrkjT-CMENKzm9GITN899X0YKLPBdnE1BjqvNd9MfruMOFJISw>
    <xmx:JiCeZh0wmjTeLBf6y2c4pkJa1lRAA3WL-ldHTm5Bv-ldru3BiVITiw>
    <xmx:JiCeZqsmg-5ehTbtI1Vh4lGqSsKtmIFuKIdXOUTzIgrSgM_Ahe5w2A>
    <xmx:JiCeZlWq1sTNntJkInuk2Sw5H2sCtZkIhLHHmlkWT--tVoHUm1jZzQ>
    <xmx:JiCeZqyWS-VC5hV8CZk32YilHpZO2rs2MYBYKepEqwKrM8h2WKCjYUSU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jul 2024 05:02:29 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fe0febf5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jul 2024 09:01:15 +0000 (UTC)
Date: Mon, 22 Jul 2024 11:02:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] t0613: mark as leak-free
Message-ID: <Zp4gILfskdpc6RUk@tanuki>
References: <23d41343-54fd-46c6-9d78-369e8009fa0b@gmail.com>
 <20240701035759.GF610406@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sozoOBhy4hoHZqNj"
Content-Disposition: inline
In-Reply-To: <20240701035759.GF610406@coredump.intra.peff.net>


--sozoOBhy4hoHZqNj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2024 at 11:57:59PM -0400, Jeff King wrote:
> On Sun, Jun 30, 2024 at 08:46:38AM +0200, Rub=C3=A9n Justo wrote:
>=20
> > We can mark t0613 as leak-free:
> > [...]
> > I'm not sure why this simple change has fallen through the cracks.
> > Therefore, it's possible that I'm missing something.
> >=20
> > I'd appreciate if someone could double-check.
>=20
> I'd noticed it, too, while doing recent leak fixes. But since Patrick
> has been working on leaks and is the go-to person for reftables, I
> assumed he had already seen it and there was something clever going on. ;)

Nah, you assumed too much :) I just forgot to mark this as leak-free and
the topic crossed with my memory-leak-fix topics, so I didn't yet find
the time to fix it.

It does highlight an issue though: I think memory leak checks should be
opt-out rather than opt-in by now. Most of our tests run just fine with
the memory leak checker enabled, and that's also where we want to be
headed. So making tests opt-out would likely raise more eyebrows when
new tests are being added that explicitly opt out.

The only reason I didn't send a patch like this yet is that it would of
course create quite a bit of churn in our tests. I'm not sure whether
that churn is really worth it, or whether we should instead just
continue fixing tests until we can get rid of this marking altogether
because all of our tests pass.

Patrick

--sozoOBhy4hoHZqNj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaeIB8ACgkQVbJhu7ck
PpSnJBAAnqGJf3oHx2bLy5T2hlJnihV5SrV+NlUpuUehXyJDbr7uktOsbezFr+gR
5qTPWs5zBm+fd7YoRGs5VqHA7DxRPxPQi4WALqO/xyxiM2J2vDI8Y7ala5Odxqms
FmrD9Du3Ga6OqKbAZU5jGojcDy1UBs8JNstXmoVe7Pe5KrmF7YnH2CCgqlqOt3it
ak6v47uaro8YOJuwI1TzD19eFYF37JnbQR0aAt+9O/57iR/kjDHt0p4txzxinhwd
MzW6vJ1q0j90Te+uq5L8bPPyeFz7k4o3H/N1IZE1a7IdQTmcCeKd5idDCyPLcpO4
nI5MwgQbuehrcEeWZMTmTDYvrvmdQtRU7+EpQKV4/cnP4fFUVOwX234LwbhQa8zZ
bnZLzVNcq71u7PTwJaTBKtJyhH56kX74kLvSrXr/JrS02x73n4o9ZQEuhSlq77kv
jWlW4//fM1FLHBEQeyFsxqPTFpGRPFnt88xktjaAA9KHnBDFWKgpEo7FGyZ46OOy
jCGRHlVWoEhxgr/TfAjRLP1AnJ153JieqE/o0V5hbr05V4nG91TT6chZ0b9f0MRU
5tbLMQy5AuEI8tQr6Z9A2tRpgWpFQ2clY6GeO2Leon7qveUgomVBXW48zJFQKW7R
k3tBlGMnh1qkpvrP+Fm3hxCspzaCETVWpkTIWWWwZssGMwqxqRA=
=wjpA
-----END PGP SIGNATURE-----

--sozoOBhy4hoHZqNj--
