Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91B32E400
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 04:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723092759; cv=none; b=H78+uS2akamKVUCg4TuatC+U/il7lbTJ57nPrksx1mZC3YSwr/BK0voUokqmJSmyAzT/He/VukL6gEqf28sRqueBiujqohlVv00H9P1u4dNBv3BbDZOcC26O6sqN91DnR5lVkMZsiwiIMJH2YtMmRQez3sqs5RZI+XZN8byNX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723092759; c=relaxed/simple;
	bh=TD/Msu+5urklWFw5Q+m5u0RvlRWd5sWJEdky+cfVlLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KV8Cmf01+FPgGdmi5/46JtV0jAweOh1BuOxvfenyWn24G7p42/BbcCxrjgQtvmJr+UtfhL7MT7s40qfgqFtfi7f+HSzoqQpGc28pQiFWUjXqNDIlKFolHMpO+NUcKfBYTL9jyO1t/EMHMvyM3B7V/Bd0oNvJTjl277Qm2j+3aTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DIDrTunj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HsdNZ839; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DIDrTunj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HsdNZ839"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id D3AAE138FDA9;
	Thu,  8 Aug 2024 00:52:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 00:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723092755; x=1723179155; bh=TD/Msu+5ur
	klWFw5Q+m5u0RvlRWd5sWJEdky+cfVlLM=; b=DIDrTunjUIKkZtZcqNRNlj3t8W
	6rAzY2dDgIdArKTKf/pMYdDITsaPbiPnXtCHrmtuH5/2/746ZVzFeQlGDG/GfZLF
	oNGOAKOdLNDECubySsVyIcckOdWh+d91xohJIYK1G7ghauY0FfnJNwrr4bXBYmdi
	2uXp9ADp579X71RRGeQyPbCZrPq9w/J8k11AHrQqOlAj7ZEkDvzBlCSFLDix96kE
	I4ewbOiVe0i/7jL+au7XBSKu7+9vHmN9/9DbUm84QV6nB2hBNrSXmaxcaT5V3LRF
	K/6qGr8d6s+q+ho11VDKvFV9VaeBdOQmnjty+KyvLOxV+8HuM4er09EWRmOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723092755; x=1723179155; bh=TD/Msu+5urklWFw5Q+m5u0RvlRWd
	5sWJEdky+cfVlLM=; b=HsdNZ839Uf/ZJkg6BW4ukJTvjkhxdPD7ZuO+8ETiq/co
	WB5cWbaAZvs1x3v3hFCDCix1HohxR7v8LRH2chYOa2qcIWFrHQdrUxH5e6SYXdSf
	riaGaUInA0jL3aEyzwzFuSw9zPwRxTr/yuXVLMdi/iscA1zkquW1kLeCUlOx3FCa
	HcOkRHJtR6DYIRn+l1cUUr70YQxKNp0rV9wT7hlBWUPs2cFtia8URwlM+K4hOv+d
	Z5S/FPwGTgekCYeq10zVdCiFHXv1umfTjnZfqEeVWapgJa1Y031o/c/F3d4wTCjm
	lszYNx8+tuq0Xa8Pkz4023v/v/OmU5ByAexEpnKw9g==
X-ME-Sender: <xms:E0-0ZvC8u7hfREnAs9Gu_p2-zpcPM__q1xFFfq_5P1_vzQv8xdXRTQ>
    <xme:E0-0Zlgu5egXnrsnMzUCRpYQ6cm7NrKktHZUGJe3HH6o17pyijcKdsfTF2Qrv6C8Q
    3M8aeVHWH4vYkSdnA>
X-ME-Received: <xmr:E0-0ZqkjuBH-ZAzoBa-pFuMc3AkbgK_IL9hVnD5t0RAInSixnZw7JQAl0HOXr9yZHeeR-8H24R0_cvH1SHXv1DOMpIyPhNO1ExkIPclfYtdr74Rm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffve
    eljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:E0-0ZhxxIK5159GIn2J8tj0beCPlX9L6m8E4523-H5cZVXpHQNZbZg>
    <xmx:E0-0ZkQVgxNnIJFo2Oahgmew_sXGaiqp_UkJzStafZ2tMQOA1XB6qA>
    <xmx:E0-0ZkbCgSdvvZpWHeLtlZ0L30yPanQ9IpG9PCCoKeJK9mZx3JMF3w>
    <xmx:E0-0ZlQt8KXRNjZlKxIRvUsFTt8cLPjnJTAo4LGWcohfKSJgAmvgWA>
    <xmx:E0-0ZvcGuvkysU_CGeX4F_gABOx__UkeSBlrnxT-bGn0sP4rOLBho5wy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 00:52:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 58e54ac3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 04:52:27 +0000 (UTC)
Date: Thu, 8 Aug 2024 06:52:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] transport: fix leak with transport helper URLs
Message-ID: <ZrRPD0ggZapZym7E@tanuki>
References: <xmqq34nfn7ip.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xza64GVeAQznFwhb"
Content-Disposition: inline
In-Reply-To: <xmqq34nfn7ip.fsf@gitster.g>


--xza64GVeAQznFwhb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 06:11:10PM -0700, Junio C Hamano wrote:
> Transport URLs can be prefixed with "foo::", which would tell us that
> the transport uses a remote helper called "foo". We extract the helper
> name by `xstrndup()`ing the prefix before the double-colons, but never
> free that string.
>=20
> Fix this leak by assigning the result to a separate local variable that
> we can then free upon returning.
>=20
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

I saw that you've merged this to `next` already, but: this looks good to
me, thanks!

Patrick

--xza64GVeAQznFwhb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0Tw4ACgkQVbJhu7ck
PpSyERAAqM9s0awnlQoeQZugaXL60QrqpO105422fc3FU2xYFGh+wQUVF7Es6BC6
Bm214rax2LjP/9v4n7RiiVPB7aqCMyj5fxCzfZGtYUazec3Qh7g4sUE/8WSHIfGo
kbquBTNFum61os/d0QY/kym5IAWb760j2w26nJIYC3HzyTS5ZTIIklFUMetB9eT8
xx3ueKXAYHR9zHYkmeLkamIzGcqxC7CQ4Pynmp6cSCqjKmX7GxKNgemDoCN6MYtK
UmmvnANnDe52s3aw46J8MNmD75WQENR6/YXYAVEXF1xL2bdqbMvIyNGXn+qJcLXc
ybmlBe0nil+2aYCTb/ZpkB7KqmJBkMc230BB7y+4F67Nio/8RRzw0deUEyQY46we
cn7R8ypYOVMKi3iBpzsbzWWH0iB8+w03WTSzPJL/se8w4HtfuWP3ETCr0vs2Owkv
G2BdXbMui+m7TGZ9K39n/YXo07M8yLMh2Y7sjHzHXij2KmeKEsTxsXK0fpSyj79+
3NLYEIJNTZv49cuAYF14Wk3OD8zHyy86nr3BGHeMe5QlogOUNfeIE10ChVV0+zf2
nhPi2NL3WJAFHz0Ki42ZW+esT42ITfEFY+6GKr5mLc1/I2y8Jv/Xw/ZQN2czv357
DqmBCk+eVmqacLCyXNut8DLy/YzC7P8EUXokqT240ZpVlAWO1ko=
=cVq7
-----END PGP SIGNATURE-----

--xza64GVeAQznFwhb--
