Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE22168C3D
	for <git@vger.kernel.org>; Wed, 29 May 2024 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968890; cv=none; b=KPcUJcHTypB++oAw5UC98s+XePGbmnmwe9NXRpKbc4CRThh8S1eF5Ncv7zLSYsJn0iJxQIzYVbkuj0m2nUVKWbUsZMl6hMoXGH6oW4Xk9ngM1NnnnE9VIzT8tDgaWsiuNlCpvRJ1Q6S5svWG7MZ9h2Cnuc8qmWAfd3Xf//LdJso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968890; c=relaxed/simple;
	bh=bIwTe49GfSUIA/wBkvxcN7KwGEZ1eNEAvUbY5jD9Ick=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eagvg6EZ24jpVLIEXBjJS8qH7Y4TBixoqwsd9a3IZmdhWGxGxEKHXC2MvWNkRj/4O6mZmGnYtV4HvBKZngjVFcGSqF9T0bELTcgdvbjhPUJKmNkY8VuRsPQuUI6IxNsk0KuSzxDSRpXb6o5jfXrSQ5Xfs8OWVW0Tkw/ZiJk1nAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FcxnCWwe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jw+2s26o; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FcxnCWwe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jw+2s26o"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 864CF1C001A5;
	Wed, 29 May 2024 03:48:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 29 May 2024 03:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716968886; x=1717055286; bh=bIwTe49GfS
	UIA/wBkvxcN7KwGEZ1eNEAvUbY5jD9Ick=; b=FcxnCWwep9np/J8ylt3JQwIc6C
	yMF3UtVwzuF6kgyF30gLdxIRd37+L5kskwppWE2cK2+SWq4YnJZ9FaKOBlDvxU7O
	Yv7roZf71BEWXCtiyAuOxMQxrjuQX0d4cW+1lnmAjv0zeJ6F2Cqm+JbLVNaKxbAk
	VpjDeX1bkSSZtWlfEUe/gy5emsQtXSHP92T8UZ5JdMqA0wY24IwTHR0L4eW/IE6f
	t8HekXWhdv0ba3Cj66q5BDvdUFMZ4LlhNu0jtpWI+cl16JfKGqLXKG3GAlMN2dcI
	ivJpdN7Zb0r8oRxGhXOTe5JCZ1GQnMYBdvUQ05pqxXz+rw4QVkUMrEZrlUTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716968886; x=1717055286; bh=bIwTe49GfSUIA/wBkvxcN7KwGEZ1
	eNEAvUbY5jD9Ick=; b=Jw+2s26o7k9z1tU0Za17EwPIDEqn7f0nQurR0NtkKF+M
	oAbrHymUWNB/LJf14k4pQhTtHo7wAyGCRV08fHvMnq3c65Pb1sypFJyseWA9Nz7I
	O8khBfkCPQqFrW+J3frE58w89s35cDqGufv/GDMuFwmJCUluvmfPHdoqT2n1ZfnI
	44GzifhXHtX/hS7D1d22W3+ojsgQ4we7R2K77xZVO2sD9BY8FiYsVz9XFDuTj0RC
	mCGACcURUzKFykfeO2Z8xaZLMR+YW19krezcFvcS+OFeIOvLy4jBKJs92HNfYgSs
	YfUcctQlY77QvEu1AAxKZgH4w0YCZ3eS4supzEAMYw==
X-ME-Sender: <xms:tt1WZkvxYrTapAbEKJoY8SCaZLWRoutoPjbhLrxmypsue2HPEFF-mA>
    <xme:tt1WZhc7BHbzR9qbL0o-ISjQtA7mE3S18RKf9f7BRx_n5GVnSKXIY2RXomRDwvtTq
    8qEk_Dss7gCxdaAfw>
X-ME-Received: <xmr:tt1WZvwqeG9XUsNN4X2sdBuDCLXs_HZx-PWZtMWAmcIcSyFUnw_fdqfmbgTkbndSIm--lVVnE3sYVdM2azUSWvdfKOp608mQjHWRgQQeLCtnLPAm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdektddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:tt1WZnMh_NnjfAGTkdqi8NzduSqhpzNJt9ueb-aTmUy1MYt4AzRHsw>
    <xmx:tt1WZk9UryJe9SNVZxoiL5iLJYRo_HVZliGfuKv_KPmiuxr9j-Mg7g>
    <xmx:tt1WZvV7IAZcAT973mXzVynNxEIpFpMJoOs8-NkHLdRBbwA2QVDB9Q>
    <xmx:tt1WZtd2rPkbdzlnXVoJI_avKVGxZsN-HpKqrA2tGu9IlMa1Bt6ycA>
    <xmx:tt1WZmL8LFsq1z5tpmmLNbJhzyrEt08fNJ2ZvlfoZa8utce1Ue_jw_4y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 03:48:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a924caea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 07:47:51 +0000 (UTC)
Date: Wed, 29 May 2024 09:48:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/8] midx-write.c: pass `start_pack` to
 `get_sorted_entries()`
Message-ID: <Zlbdsz5VSlX89HfH@tanuki>
References: <cover.1716482279.git.me@ttaylorr.com>
 <7acf4557dcb2240cb43eadebfd21b5c37515ba7f.1716482279.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B2jXDqSxkONN0yF1"
Content-Disposition: inline
In-Reply-To: <7acf4557dcb2240cb43eadebfd21b5c37515ba7f.1716482279.git.me@ttaylorr.com>


--B2jXDqSxkONN0yF1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 12:38:09PM -0400, Taylor Blau wrote:
> The function `get_sorted_entries()` is broadly responsible for
> building an array of the objects to be written into a MIDX based on the
> provided list of packs.
>=20
> If we have loaded an existing MIDX, however, we may not use all of its
> packs, despite loading them into the ctx->info array.
>=20
> The existing implementation simply skips past the first
> ctx->m->num_packs (if ctx->m is non-NULL, indicating that we loaded an
> existing MIDX). Future changes (outside the scope of this patch series)
> to the MIDX code will require us to skip *at most* that number[^1].
>=20
> We could tag each pack with a bit that indicates the pack's contents
> should be included in the MIDX. But we can just as easily determine the
> number of packs to skip by passing in the number of packs we learned
> about after processing an existing MIDX.

Will we always want to skip packs from the start of the array? Or may it
happen that we want to skip packs in the middle of it? It's a bit hard
to judge because there isn't a ton of context when exactly we'll want to
skip, and why.

Patrick

--B2jXDqSxkONN0yF1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZW3bIACgkQVbJhu7ck
PpQBbRAAiK2CfRMX1IEUtCcvoBHpzDHhXFaWFChdsBMOh8IsRpia/lPGoWXFRn9K
1b5idpVpP1XW6JPu6oI++HZnIgHVjEZUn3IwsQYdDOLNIsZSVQXeVzi2+fL9/aCJ
HO25NR+BOVF32rjBvGQkLbR4uUlQh3oiRszOwaZEPBnjm1epzANIC7Jed8C2Oi4r
W7Z4Vv69MhrZSAvqgN/Bx4k5WWyKHn3iso6P6mDNYeiP+SXBlexPHzf/EAvP4GOM
1IySrfch+QPxAkjOF671GDDmXEnqLoV9JPUQ/S2EwFbdxMTyAZy7sEZRg01iDqL0
6psU+CPxhnnEVwyLDWYt8c2yts8Vat0I/5LVs9ukdenRX6pjBBZn4cARUU2ndROR
QbNsjv5tMzkQoFgpZUE+liIfrXFNzGYul6g1v4dTKhzYSeMWoe8kkj25xLiGbCb8
o8GlAEUtcZhci1Oy3mwFhpdyR3vg7CLc0yPijtBoO+3NPaAaGPM8ABPGVKcgi6q7
nALFOZxk2P4KHZ8AccWBfCYFIlwAArJath3kmYTJPmQiwfGfXcHH2lWPX/fNcRP1
XkV00H+ApkiOVfhNwkFw7b8+zHGiBRbWSk+NIQc5pyZfHzxlvpcl3s3hoZlZahql
do73fvAjWx49HPakFbpubY6BvRfwOXkgPiWx4nLSgbzg+z7ADWk=
=sjoh
-----END PGP SIGNATURE-----

--B2jXDqSxkONN0yF1--
