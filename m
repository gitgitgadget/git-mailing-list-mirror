Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ED81C6AE
	for <git@vger.kernel.org>; Thu,  2 May 2024 06:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714631244; cv=none; b=GOvQkAemRt0SXUf5Dl3zKLZJZLehMtXzGiJfs4BdsvSrrUc0jIdLBzLq362MbnEmoEL9RdA5Ulk1YQY3hJQno97o+n+JKHlqQQtkr/ql6vykcaGr9oXjY8aFrdt+80PU7u8bXCdHWXtJly2pvViwNBxCLpzqhFy1JPG2/JwPUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714631244; c=relaxed/simple;
	bh=tf8X5vPH0WFiR1j8B0pClUyBXjZoCsgPStNYLtjw2/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gwf10x2tzAZsAhUZgTdm/QTLtrptvyefBQXeVFUEKKuDMbbI28ZvsSRCEQSQQ+VszyWAz++Ffu9u4tI5m3x4dXsL33o6groujWWNLHH1o/MPxti4l5lflMA/5zLSdsowl5btqw+uBgnqB8f/sXmS3lbSc3gCZbnms5lk7sibOq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DeTlunzo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W2g1Tz0x; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DeTlunzo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W2g1Tz0x"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2939F1380379;
	Thu,  2 May 2024 02:27:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 02 May 2024 02:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714631241; x=1714717641; bh=H4qASKTWP2
	0/hRV4M6AjfzRaP3Chz4Bx5qbEeDq2o0g=; b=DeTlunzoRLyvfIvEZaGJZW1c3W
	TxT7cVdVDK3f+MUt0jGpMqzrs6MZio0K54+vz9tOdjU3j9jT5xIOCHgvvNt85uRG
	rNlPm+U9QmKLqHx1m06rdzNsB30Dfy1XgmX1REdUY+wX7++y6FMCfdI1PMasVubX
	uFvL73dB5ZoQhz2z2upsCxj63LsuMbxdjojckCsBdxRizzlB483SUTlEcdRNgoi5
	rw/JnaQESYxiAQgsMG+eSku9QDrU187Gm8Jxx1AlicKmj0sHojE6Z1LRaOuKa1If
	gIKAgXxUK17NVpsKHd9QatImwuXDk23g0rwjXUnina15Un+d0OJ26dK5dySQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714631241; x=1714717641; bh=H4qASKTWP20/hRV4M6AjfzRaP3Ch
	z4Bx5qbEeDq2o0g=; b=W2g1Tz0xLiYHWk7sByNbvM3/JjUGdUkxHtmJO+9FML2V
	PoMQ3IswLdwjMkGdPjnOGAM3+DZo80PJL3nk5etPZlBhOu9DFIuKqHNmdEFxi3ci
	l58+56Mih9ZXK2R8tiO8JgXGA98+O6GPq7oI2UT/QQHcXFBLO39zx1+jg+1XvMEJ
	im17KrjWpVX9DHzy918DIT4EMWh9JPUbk0Q/ss5VaqD6hYthRPDa3FigX1Jfawyw
	lqYk5iBQVWwBKKWIjjOF1Os+NeE104DYO1ObGlaqTWa7jUVOF8w5OHoqC7lNYfob
	Li1AsO4K+Qerf+ntv2dluiduAovggObLC7G0LdA7xw==
X-ME-Sender: <xms:SDIzZlg80TndtH-CrkDb2lCPPdDmVaTU-H7jaggracdsLOajN1313Q>
    <xme:SDIzZqDdY9MovECuiWC3R8-1IWl1N8kj9fChIplRQKUVKB2ptGGsjaiZLWi-KLYED
    MDwaW7uj_HPb_r8UA>
X-ME-Received: <xmr:SDIzZlF1g8Fk7TRq-mBDHljm-LlHNvPwSs49g-wYzi4WKcBwVHLC2H-KGCogM2jE3r_em1TXULeYcJeWUGZr1Tb3zso2R89uG_nx8wrpXXKLGos>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:SDIzZqQl7ym_0JigFRjbugqX6SmtQeGvqwITiuag79Fjm9ujaP4jIw>
    <xmx:SDIzZiwjGN4HvQI2qz-_x7KGNur5ND_r1eMLg5EjUGXLjjUcgyP7eQ>
    <xmx:SDIzZg4eV1W5ecaoCOLJ_gE4LNuGCERSjipy3A1ZVGSC-ev6GEqMqw>
    <xmx:SDIzZnzxneZJM41ERzSPY8jCtq2d8CZ430qu1ViMP-yOVmu9xQR3nA>
    <xmx:STIzZsuzNROOlwwMFFWEcPbsybf4byuc0XokzYruMLF34yYsRQWxguPS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 02:27:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 06400a24 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 06:26:53 +0000 (UTC)
Date: Thu, 2 May 2024 08:27:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: John Passaro via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Passaro <john.a.passaro@gmail.com>
Subject: Re: [PATCH v4 1/3] builtin/commit.c: remove bespoke option callback
Message-ID: <ZjMyRDDQ-uIx03H8@tanuki>
References: <pull.1723.v3.git.1714416863.gitgitgadget@gmail.com>
 <pull.1723.v4.git.1714488111.gitgitgadget@gmail.com>
 <ce047c58aa81cc5228ae9068d790585e012491c5.1714488111.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bcl71wobQNKlIGoQ"
Content-Disposition: inline
In-Reply-To: <ce047c58aa81cc5228ae9068d790585e012491c5.1714488111.git.gitgitgadget@gmail.com>


--Bcl71wobQNKlIGoQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 02:41:49PM +0000, John Passaro via GitGitGadget wro=
te:
> From: John Passaro <john.a.passaro@gmail.com>
>=20
> Replace git-commit's bespoke callback for --trailer with the standard
> OPT_PASSTHRU_ARGV macro. The bespoke callback was only adding its values
> to a strvec and sanity-checking that `unset` is always false; both of
> these are already implemented in the parse-option API.

Nit: I feel like saying "bespoke" is a bit vague. I would have said
something like the following:

    builtin/commit: use ARGV option to collect custom trailers

In any case, I don't think this is a huge deal and not worth a reroll on
its own.

Patrick

--Bcl71wobQNKlIGoQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzMkMACgkQVbJhu7ck
PpRN5g/+Lts4hKJ4GvWTfxJi/V6zkBCMPdYyXnWMMTYQgauApfiOJNBZXXuxgB6G
UPyHZnqx+IamZsySFRIsqRyVZ54SAfWAK+W62nSntRYYgIJwpRhCuzORdlI+mg76
d81/oxHSvBep7VjCUWscCuQpS2E2ZCMZwB5WM87Pq9zyvJNsbGbLbBBG0E3dTuHs
yb31qw022vQcXB4ULKcKy8fZxCmouqtEWVyJpKQ3TJad1k+fNNCWYcQljSkHkaFZ
p71qs73THXb+0cF6vhaGprEC6GimF+Ly3ax7QjIpPZ5/d4UUAqIZwbJodA2s9hqd
9U2pj8OBLYdnwlWPY2BgoLFiAl27skXcf3viT93oC8ActrDzuTrScXayLvI8thRP
Gcv+b8ckjvrLcVJIWzFdeirZvbMMBLG/DdQsv1F2iysx6leGzxJ4Ok46yvb8aWG5
WRxGwmAEj2VLZfR2TG6PvPEkuVxUjPSIFCIIj0MOwXGC4cuQl3IO8T2mR/NIj3sL
GGQtOMuElDWOjEQOQ7lFcvEgD+P7w9p8CNTVFQZdcLfYnfKjlbtx7wX4cSqRNYVe
tKpVK5/CtQghHr21yN+33njOt/1+VzoADWUF4bI+bDikwBST6+BuFnORs8YchbBP
Iaq8neqYq09pNSdkoNGqapp4wAj5E/Tg8eSmD5ATblpoDDAfBg8=
=9La+
-----END PGP SIGNATURE-----

--Bcl71wobQNKlIGoQ--
