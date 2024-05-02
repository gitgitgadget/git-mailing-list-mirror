Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813881527BD
	for <git@vger.kernel.org>; Thu,  2 May 2024 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637279; cv=none; b=Oj/49/lTKyd34FDi5Tpco8666oV1AydYjvwnXbsdxoNzRakHVqQR4kvHFOrruhJOcBOf33d6/92L7ZMvxmIAkKCajM/89AR5ymg7STS8Iapaf/Et1rP6broRvy60zlGMklnjYldNjq5dYOrpza33/qkPxEN92pJBzJSiVL1Ex3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637279; c=relaxed/simple;
	bh=yriuqfVq7Fmsbn0gYK+YwQ5q86UsH9k+zedn2GvGFDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2cxN1MQ6WDi9Z3DsXpQdqbZsy/o0k0a1TOOJc6FG5LRTeprDNpX0/waOn0ZB6olYg3WOCA0uYhjL/RZpdcPzZqsNv9KeEsCp06/ifCcl92kKAAnA0KokBcEQjhiZxQjK4Tq/Lhj/kFjJClAX6nPyOROSHZJ7ebKBUWrc6EQcsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G7bWeWnr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iej2HAS+; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G7bWeWnr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iej2HAS+"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 56E4E13805A3;
	Thu,  2 May 2024 04:07:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 02 May 2024 04:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714637276; x=1714723676; bh=Qep6Gf43+o
	2R7+pBsSIzXLYdx35hBemNnbcTCiJojhc=; b=G7bWeWnrwfN3YQHf+S8U6GyjX5
	dvJEcUJfMRjfRv4TXMJRU26McfZLYGx2VX6QgQ8TgqliFCRZQUQlinf3iUK02Zuc
	uvC5M74Cuo7gFQAhhiduVCSPrCAn7i/74i4qtHW+YCSOjyGrTq/u1vYQTaBdyX+v
	A4b3+GqjW4OaAP2kTDmOuWxhkLxNsXZBEoodrFwcUlpTdynoi6egVgdYrzSTWmiu
	eMqGM2k0aLMK1ACo3iVKvYnwpGnBpfyFbBv5xGr2kAMc9ojwGPlWrzw/FKErXYyW
	1nYuEd0r2XODzNOUm3gLLwgkdLDN3CCJdykwsdvP+kwWI8vmWl/Kkj0HimLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714637276; x=1714723676; bh=Qep6Gf43+o2R7+pBsSIzXLYdx35h
	BemNnbcTCiJojhc=; b=iej2HAS+tfpZyqPHpayl4Ufe/CpBhHTTyvpsXxRfEcCx
	WmlLDMEdma+Ik8JlTs2sXdaM4On88oZF2J/XrIkaye8CXwk4f3/WWop/a0GBNOb4
	PXCKces63ynkP8IrdyCRkHwcDZ6b3JD/5ybN6RCORw28vmjkXv4p9mHP796oxfgk
	u9eFOyhKDTgPpY0PGEQWCcB9diZ+pM0HtYShmuXzCG3pCDkY9PivB90VtSgbkt3F
	eM3UQLX2HhTSOAaMyrGL+OBK30WwDg94BLFkOR0rh+EZ+D8etQYMmQgxRc22KJtY
	K1h2eW70UTnECIwco9NOReAe0pzyXz7gEXFrrELI6Q==
X-ME-Sender: <xms:3EkzZkaHdlgN3oHHAwm4T261Xk6_MDE4X8D3HDOAsJ8cAPZuGWi7eg>
    <xme:3EkzZvaYftiUhNTb0c0dtHwa2MIKA9pJ94ik4UjmKcASHAQ8YTgYGDixOM1E9pHLZ
    HHoWTPiDAUKSmomZg>
X-ME-Received: <xmr:3EkzZu98fDlo3o4fnI9q7B9ZbjK6mSBSoSIswp8MYKfUNs0YGO66rdswIfqY1atRIf_BanPVsRiY8lxZvnMsd4iixcsrq9_uqRj3xWR7RlV1NT0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    eukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:3EkzZupXdwV1P9PJJVOp87P4S8TAgJEdwUaJFQZ-B9VuylCCFsSYAQ>
    <xmx:3EkzZvpuyMA5dv1CNJbrvdoisBt6CYcQ1bJseXHrikXrQfK-ha1zuA>
    <xmx:3EkzZsR4asQYy5Ztl959nnQPFozK-pQAWfDlzFHYFHWcyrkBAt6ZfA>
    <xmx:3EkzZvoUIwmdQ9lyyASY_ZKyR8YaFOMuBfwXrpdJJif8GqUYr4ZJ2A>
    <xmx:3EkzZgdKTJrdfrkwrRsCzXVjgVBon1838HRTxu3brU9anPY-elvBUmxG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 04:07:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a5c4fe79 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 08:07:28 +0000 (UTC)
Date: Thu, 2 May 2024 10:07:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 01/10] Documentation/glossary: redefine pseudorefs as
 special refs
Message-ID: <ZjNJ1w-hPyAxh2i9@tanuki>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714479928.git.ps@pks.im>
 <2489bb558543d66592fb0f3eb4d4696ba8e31fea.1714479928.git.ps@pks.im>
 <xmqqttjiy5hq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wfk1+pkiylKVWqHE"
Content-Disposition: inline
In-Reply-To: <xmqqttjiy5hq.fsf@gitster.g>


--wfk1+pkiylKVWqHE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 01:12:33PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Let's address this mess and return the pseudoref terminology back to its
> > original intent: a ref that sometimes behave like a ref, but which isn't
> > really a ref because it gets written to the filesystem directly. Or in
> > other words, let's redefine pseudorefs to match the current definition
> > of special refs. As special refs and pseudorefs are now the same per
> > definition, we can drop the "special refs" term again. It's not exposed
> > to our users and thus they wouldn't ever encounter that term anyway.
>=20
> Good intentions.
>=20
> I do not agree with "the ones at the root should not be special" at
> all, though.  We need to reject names like 'config' somehow, as long
> as there are users who use files backend.

Oh, yes, I totally agree and thought I'd mentioned this in the message.
But it seems like I only mention this in a subsequent message. Let me
add a hint to the commit message that mentions that a subsequent commit
will clearly define "root refs".

In any case, root refs should not be special regarding their behaviour,
but should have a strict naming schema:

    - Only uppercase letters or underscores.

    - Must end with "_HEAD" or be called "HEAD".

    - There is an exhaustive list of legacy root refs that don't conform
      to this naming schema, like "AUTO_MERGE". This list shall not be
      extended in the future.

This explanation is added in patch 3.

Patrick

--wfk1+pkiylKVWqHE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzSdYACgkQVbJhu7ck
PpThMQ//eFdF5hGPHzmFcntSrXpHjH1ufDgAQe74vm7R37mEVB3PYdm88H4t4H91
duA8O2a7OBtmGhbYx2kkdnTVeApuemQoiSDkkl2HOZTsRKNq0hcJ7FGu42JR0kaL
mcx53AY41nrsTiml6hG0y1HjxgSOPigzq+PHuk+YJjb9kEEEJQiMvcV0EBWRaZjc
LJQNPhTrZRVmCeWMVjPOI5t4YTflkwoQWz2cp2sGIak5dcAGtCM4yfGyJw9T79dt
kFyuT4WZD/4EMjLEDJVAS2EUVcIxOHO4JD6ZnLHGTprypxXTAXP7Npoh8X1MmB/S
zqZGmFSdcdgUo7rYmK6iPeTxB4Yd7EHSi7oNKb6RB/sBgcbPRhisceGE8xVKckog
qQbdDz0qTu/ml3ZCKuCUA0LLaYxGXRo+C90qd0rT2pIdEwt8MJ4GmZAQleyFkJKH
G5WForq7czJbj5/8WgqJuPR0d4IYPM86fgDnJmWtb9iG01o+zBID4po3JCD6jb49
wYHj1BW6277O0mpvtoLaH2+39WmBwD9/dHdDxupkv0tMdSicQGZQrEPXUBgrrGcB
a/JKLcZlIqE3Ml99OANpxXPpN/x/6y8bH8XBpxy6hRfChgDnGEhetCYXYLtPgpbo
c2SOO+8nezjKRpCe5YP42izVfmhAPyPUsPjaiU4T7SJC9a5BxJ4=
=ciub
-----END PGP SIGNATURE-----

--wfk1+pkiylKVWqHE--
