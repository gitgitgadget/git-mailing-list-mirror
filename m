Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29A845012
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 06:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706595017; cv=none; b=Inik/KNByuaneFjy5wr48HdQRfm4kpCDmIo9lPkMlMNoLIcJVNNX7M0n5ksCUIKnvL0Gzsh/brlO8zscXEc08NEk+61R128U1Dxsy8sUeWY4qlKnctVSRq7vbrVekoR3+z2ZfnCjlHlO44lpAkM7CZzuLWuLy1tuoyo8DGUUeJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706595017; c=relaxed/simple;
	bh=+AEr/QaihzfxHf/s3Q1eGqZulaWrtqZuFp2QddFS7kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvM0Y1/EHpRCZgX7fdmgLfCe1kAdu0RUtGJGUqxCIxcU9q6YWD+ShdjI7Sjm2ug7+CUmIF7OKDhBCAJo7mQMGZWCNe50jGrnGgFpctOiS0tStk40tiTCIEdiQ9Bixv6jtEpcQatXYxhD6pD3qZtIeIYLZV14lsd3tlNxY8Jli7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NR1OwQ2R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vsd6GCfB; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NR1OwQ2R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vsd6GCfB"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6F3791800099;
	Tue, 30 Jan 2024 01:10:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 30 Jan 2024 01:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706595012; x=1706681412; bh=+Hg2jptizA
	XMTl/B9+zxMnsXiokGqj4hs+Q0FQfO9r4=; b=NR1OwQ2RM9YlLy6QHY7TPp5gW0
	oI+/wpgQsju/4ccnxTp8ltgcesKqlMf8DPzKKhatjDaAQdx0orRSRYmBFZaozqAY
	A05uAbfCWMaVSwmtIu/cUdEq+LflcfPxKfqLal5MlhzLTsqspWqyUDdvtaH7xAqp
	vSgsN72PVbxHbVkdGb8VG4KqG9ivhZJGHYD8belfEnnnkgTFIg3fKUFRs2jl+n26
	fi+bREhZHPBaIAzd4x7jFXOoM/Ii0jjVw7Lr01Rk/aiRTmbTvXBqBXnxSJd4PMnb
	tCDxdp4rXfZQygYuALvAQe40AYDQbLoN1CU2fg6grSBT+Rhh9j/vV5ETa56A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706595012; x=1706681412; bh=+Hg2jptizAXMTl/B9+zxMnsXiokG
	qj4hs+Q0FQfO9r4=; b=Vsd6GCfBuqTiJAqE0WyO5YrA9oBAI+B6PJ3l3DJuXm1e
	0Zs628JWIs+Ip9MBF8i24qq44qNWGrFu06aQ6CO3YGvb0z+QJWHOy+TwBy/kU5UA
	ZgovUcDY3gB1A9enZCcmEyQ1/i/JnDu/gJUpWNBqTbnTDzdinjdmPc4Gh/JE9ApL
	VSo4asfdL0HRT2nFCMzit88ArE1Ac9zhkPboyAzh0D3wW6kHZzPkBZBZjEx80efO
	i6WDo5ryNPEo/5Pbr+GOfiCFuZ1bX+Ikm4T+9qsz9RLAHvnB874u21X339zPu0wX
	hFeKwBxhrSMYq6Z3xEF8bdVLT85JKgLwnNCCxnaKHQ==
X-ME-Sender: <xms:xJK4ZS-WW057LUcGUlmyJmvLAQVMKC84VodQRMC_9kCdO9Nxfht2nA>
    <xme:xJK4ZStINyN5FCmfYrvPzHBMKAUsTDqdKerNvOYPv4fGr8o1v4JAlabYWDF8EaU5t
    l113Zk-Z8tNol8w_A>
X-ME-Received: <xmr:xJK4ZYC0ZHLST-6YPKQlaNbH0QbzdG8AT45_UIMDJs9EY-Gr-8yJrXFUpPh_9Xcg7eUZASOM-joShqcruucWIm4y_6qK9GcOnP_PFxM-zxrgQ5c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    orredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehfefhuedtvedtfeeiteeugefgfeelge
    elveehffeukeelfefhieekteevudfhffenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:xJK4ZadG79kE950yFeCnrEjcIEUKnzVm3QdmQe8LEu6-QcZNvuVfwg>
    <xmx:xJK4ZXPjkvSReSXdLQ_u5TpnbNM5-MmlI6Z20Eo0VFIZ7yZXBRbv-g>
    <xmx:xJK4ZUnGzgMPD_XsnAcjrRAl3cHV-LbZ6qoLMgWirfFJfrXgK6yh-Q>
    <xmx:xJK4ZQbMnctcqTiSFnQpSsumc3CGcMAncjGfHi5BWdjiCx8iU2kBwsKpSW8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jan 2024 01:10:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 97f91920 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jan 2024 06:06:53 +0000 (UTC)
Date: Tue, 30 Jan 2024 07:10:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] Comment style fixes
Message-ID: <ZbiSwAbRaxXXfLMk@tanuki>
References: <20240129202839.2234084-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Kbbx7L1IEHwZ7S/i"
Content-Disposition: inline
In-Reply-To: <20240129202839.2234084-1-gitster@pobox.com>


--Kbbx7L1IEHwZ7S/i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 12:28:36PM -0800, Junio C Hamano wrote:
> Among comments in the traditional /* single liner */ ones, our
> reviews seem to have missed a few // comments.  While they are not
> illegal per-se, they look out of place mixed with the /* ... */
> style comments, which is the prevailing style used in this project.
>=20
> Fix those small number of style violations in our own code; files
> with borrowed code that have // comments as the prevalent style are
> left untouched.

These changes look obviously good to me, thanks!

Patrick

--Kbbx7L1IEHwZ7S/i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW4kr8ACgkQVbJhu7ck
PpRPRBAAj7Za7TgfTqvX6ITfW3276SyBmHcbCU8tsjJG//V5brVQN7XTjGGpY4rQ
ePR61u3iJMOw1zlQPrH3R3X9bf5PwY6koQue83s5u4EuuT6j8RUy7Nzvt90I/GkB
6uBlHeu3LiqRUnK4ao8v2MfByYBkJ3awEhk+xLUUAVkCf4E/m8AfWmDF06XKz/yy
DDKJCBXgl3Ehs/JdCVgLy9gAC7pV94AwgSENJvsxMypLFIGpUVIdudVBfjW9imhN
IbehBfCSV6ARE3flj3GqPj2YtxNumOIeZq51rXvOIyzOHB1+bxGr5vGulC1ZU6et
LAkHw16NsCICZ4lgRuW3fQlCi178GFPn5Ti9Sb9PeAK41AZAYO5Mm7Q38hC51RBS
VqpMUBoFqRZiD0KmnSUXR90TAWTTn/wpGk53j4YBLyytKGyOMyQbjq0GxNJGsgHc
APKcueI1uCKtrmYLxmNW83hWDTS6NgU4po0Ef+K8vSMlG5zBKe6xQirIhU1Y2obn
otsPRl58qMtAxp/F0q8n85yrZYvkojmbU2aTQwO2CHIR0WVAw3oz1/vT/f7gbs8J
1R5nNiurRuUFvy5srYWd5h3kylD6DbPlEa3AMF5WxuYmQ0nBhBNux8plSzSq4GtH
t2ssdZViKP6aTO0etVIcqwE7KfcOkLvH/tQB16gUSdgBrW1xP9s=
=qYnB
-----END PGP SIGNATURE-----

--Kbbx7L1IEHwZ7S/i--
