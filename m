Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4390D54BFE
	for <git@vger.kernel.org>; Wed, 15 May 2024 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715763930; cv=none; b=MTTQge/csIZerk8eYiBrKrtTBgyAXd1MaSpzmi8lWlZcYUEmAcuTUqUDq65oJkt2g9FRWtkGB3qX1xVwg64lbfmryidGMAZNKLjq/lxEcK0rerXScpylblPRNsqLNcL9XZlk0vcpg4UFtG0bZFvbLrZiWAW2IXb2GSz6SuC8WVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715763930; c=relaxed/simple;
	bh=PwDgQkiDOx1KivmbfmS+XkQ8xz/jGKnG+VQzRev4ctU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCKTxGyF3X69SPP1fnAi9PAzFKF2Do20CJn9vuwaIoyCObA0/UF+AstSt2XtQrVtGOJfjBVkdF4U1mjQ0uce3HjrXNfyMY52HMBhu9MlGnICwDvFcKxfps/8USek40iX/iwZakPaKfzSvII9wQlS+Xht7RQx8cc0n2ZNXli/QgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I433xs7L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LpGjEdzX; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I433xs7L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LpGjEdzX"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 35FDB1381487;
	Wed, 15 May 2024 05:05:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 15 May 2024 05:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715763928; x=1715850328; bh=PwDgQkiDOx
	1KivmbfmS+XkQ8xz/jGKnG+VQzRev4ctU=; b=I433xs7LOgh6p1NbX/e4r6RfW/
	IxJeXC3y9PPYrCzuuzmEbyB6tqh0fs42iGho/B8+rqJ1W101Gwhf5r8g6Xpjc3yZ
	eTU/eYs6Qh0Ek/L1Zopjka97QG85KiDcLwdnpzxxk2nPIWE3Hsy7FkQvguz+ESpz
	QHDdG9ISwlmUPWjHc3SbJVgM5FcktMK6DepkkQ4jb3anL6FY+zrp2+OCVquqfvT2
	w/x93g9PcvHdFKJvIKtQ18imZziEQOQb/5LVD8Udsmb8qe04LagVgMJOxXM/KYP9
	PAz9UKRMGQDMPROvWf+MTdy4a08bxi/bbw1Qjmughw0vcsCsXkUjHTG9J12g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715763928; x=1715850328; bh=PwDgQkiDOx1KivmbfmS+XkQ8xz/j
	GKnG+VQzRev4ctU=; b=LpGjEdzXptO2MubbOQ2tCG9IoYFyBNuR1I5j/FW5Xyg2
	AEzUVauTO8AGL6XO5COuhwWtUkg+KEAXbxyIrr0ShFCvHDXSLE5QyRLjmcfMoqB/
	++4VmoHpju+fOrv65aPLvuDGvFHcVJ6vUDIBBRXNVefMOSCJvxzgDQ82U7Mc+MCq
	AwdCsqCXTulvA6TGPiFjBMtYnGgOFK8eGQnuPmsXK3575IJ/YHe8ecCFW5NZ44dK
	pp5G7DwqhwCrX45faK+LSDpGxr/315hBq/SppTVpnjH8IwbpiAnRa5Z4p9XQLZfi
	hUFQyI6IHNPMucVJ3YawS5I9/KUm6rqX4opcpFt2bw==
X-ME-Sender: <xms:2HpEZuC1dDaDO-uSGJZzs2AGY0_ZIQwwKBJA2qTag7fk7admavx2-g>
    <xme:2HpEZojMjj0Q7d_zftYQ10nW_f6U9T-WUDyAToyuqImolFrAit1n1KKYaQOaiKFso
    SD77cIAVoz3gdKNjw>
X-ME-Received: <xmr:2HpEZhmeT_YA3EoHyDClqGnNdE9rRj10ZSxsJ-69HrJfKjEgoRzchdh564ByQsPjykYpMNaueRU68SijWp6bZwY5wB15fqNU9heDQF4gTduT5K2V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegkedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:2HpEZswy4BmxpvI4mhNyprgm_yZYgI5S9ic1Cs0UBX96jZePyOALPg>
    <xmx:2HpEZjStbGrfz0IxCqNB2h52_IO2SpdU2qIS8ii9SXOkCL7rQd1ASA>
    <xmx:2HpEZnYTuTgXkI_B53TRoLPAvY7js2iZXQS66_GInDrI16LSexr2kA>
    <xmx:2HpEZsTeriXmnpRMINhsmpQhg_B1nX8-Yne6scpHgAKkyCzkJI51uA>
    <xmx:2HpEZhMCLLvSAlj6Xaqp1OAWoEUG5t7WoReUsyEdlGIyGlipvoNHxEy9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 05:05:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1163564a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 09:05:04 +0000 (UTC)
Date: Wed, 15 May 2024 11:05:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] pack-bitmap: various pack-bitmap-write cleanups
Message-ID: <ZkR61b5fWoRCv18D@tanuki>
References: <cover.1715716605.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A1jZ9xZOFsiOwc5k"
Content-Disposition: inline
In-Reply-To: <cover.1715716605.git.me@ttaylorr.com>


--A1jZ9xZOFsiOwc5k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 03:56:46PM -0400, Taylor Blau wrote:
> This topic was born out of tb/pseudo-merge-bitmaps, which has a few
> quality-of-life improvements in the pack-bitmap machinery.
>=20
> The main changes are to remove the static 'struct bitmap_writer', drop
> one unused fields, and start using another unused one (see "move
> commit_positions into commit_pos fields").
>=20
> There are other smaller changes, too, like cleaning up the flag
> allocation table in object.h, as well as introducing a new
> bitmap_writer_free() function.
>=20
> The next round of tb/pseudo-merge-bitmaps will be based on this branch.
>=20
> Thanks in advance for your review!

I've got some tiny nits, but overall this series looks good to me
already. I don't mind if it's merged in the current state if you don't
think any of the nits are worthy to be addressed.

Thanks for this cleanup!

Patrick

--A1jZ9xZOFsiOwc5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEetQACgkQVbJhu7ck
PpRqCBAApYZi8dnLj63E6Mz0Jp07jwHTZpSGt9NjgamxrcPoUFqGZ7o4/VBbk3fe
mWfawXak9qCBDA+OM4B/iMTuuw+byHcn+EZPrk5nazv4k7bu9sZ0OrNadclW+U6s
7oLz9FuupZHDKpzW6mg92UnbNrNyLHSgRo4MDj6Z/K/Veg5DvcU1on6FFe1uAW4s
g0mYzS5uwTOF/f/4I4CA+GSAVjCJsW/C9T7lzfsXrZ0GEO3sPnEH3tr3F27cgdrf
kq0i2G3SPGK/6X0mgw5WR5/WZ8Kb47jrzMcjLR0efYn9K4l2+swgaM2W77Lok6R4
pLKC3n+tPHo3i9cibj+NNgULkTR8avWNj3Ew+zM3GQLGK38yD0zGyFyyWbBrfTys
i0815fSoQLqGTU5JS6qSZqRjC27mLa2qXNvTTjZTGk54kKGEfZ2t860GBKcvwcbn
fzzUjO5HvegmOz+b7CYg74xHammbc2NYAuaPz5U1yE228006QwjvO8sPtaYJNBBV
EFJ1z0S8Q97lAWHFO/nlP19lGjQVz8hG9TxSRQ4mdc7OJ0ZuYjKEzSWuHJVZc+wv
PFXDA4ccXUjapf5ZSx5zQ9DiDwrugQYhhbuRWpLDblHCCCdtipIox9fg9SU7I8mQ
ABje62qyLpXOl9CewKQwq+NNsWC60JmCda9u4aMz7mkzfe2zCU0=
=JuwV
-----END PGP SIGNATURE-----

--A1jZ9xZOFsiOwc5k--
