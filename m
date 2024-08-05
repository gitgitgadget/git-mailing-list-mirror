Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8C154BF8
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850614; cv=none; b=PqiCdVlbWd7LdDcRU4AyNrpHD9MZ4/1Ku6wMeci/Zw7bSJPiGxmuMhm2Cb2qTmSAjB1oqFsZE0P+EUyoL7TnBH05wav6Y9PfHLyRC8TRejR8KfcmVFRySvRegxQwDBTfsZedbCca6Hfrt0v3CuNLRxyxqY3gtoKc4a0eLsR+lv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850614; c=relaxed/simple;
	bh=OCkHe8jODPiMAssn5xfFaVkCH2uKc0G/53K/QcyxreA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StF3aBFwBkpT2fzOyJhDUV1I+YTUIGWiEUuUo8QTeZE4t5pigRT0IT/P/Nlo1n1TlkO2bibM30MCnlWHllzv74QvFhYY1TMRtT4BapygOMLknaSY4oCaqoVcOfxlFJrgawPmqTHmno9iAOta8Fbt6FuaTHwttF7BQWsP62y6Ekc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xxk/JhgZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KLcWyoAk; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xxk/JhgZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KLcWyoAk"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 98AFA1151C6B;
	Mon,  5 Aug 2024 05:36:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 05 Aug 2024 05:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722850611; x=1722937011; bh=PetEWW1gY4
	voEkSWz3gflZk3FWcLhlfK0SzUEFlm2SE=; b=Xxk/JhgZr7OScVUJyUE+nqIZ9I
	rM3vuztIg3Et9gb7R1YyKklmkdat8mMCVNhJPVT4tbUOO/vltCRH4wE0VRq2Mkkd
	wuT1PYxA4OUcKcUX7M25rl5x/qejK9sj+JTB8FZz6/mxz6KW9TqxhhkPDoFpq4Vk
	WNRqXeNqp8HjksHBLh8hqEVRmOKRyrLzGEhYsvMJ6HJbULLfAX1t7HOftH2aDdR+
	pbBNOjkDneaUQpZQqhqXLl8M/6YJGpelBPGV1ad3rhBbnoGun4yBZIfpdEET7i+z
	bbz4LFrqvAGKJWsvKdYMx/0bpxJbi2PNM8YPAyVvCOhHaNGzfr8e6wLSvo4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722850611; x=1722937011; bh=PetEWW1gY4voEkSWz3gflZk3FWcL
	hlfK0SzUEFlm2SE=; b=KLcWyoAkMal8+EcPcRO89Bln3ARLMFSyTmXz8qSwyH/m
	OhnCxQL1vYu+2mWuTGrS++Hkm6PIg7sMCJHMOkclrZEQqaK/gnPmmOoZ6aiD9dIY
	ILGuU8ZoEneYBMhBxzYhpzuXF0v3hm2qO/gxVC0GuXRaiBOL7TagBKTp8sCYv/qr
	b6HPKv/V4brbsdj2Hn8upNtxRrfVyWu/+qyjJWR5KJu5scNquovv59mLf+qTTM+s
	UDGyRTKZZzbAVcS3RbBrC/TU69tAq/hsamKohBIx5xs0+xi1JcPKJKywoDIQaZBe
	S7UfVoFRgKgpqg2CM15KKmIzH2+VCQSahSM87R5Wkw==
X-ME-Sender: <xms:M52wZqbgGDmqwza__Axlaemw9eR-lQiLneW_iXibVUuZQAoHVAxB6Q>
    <xme:M52wZtbmav6LpGd6pXz3yvI2SHiChkow623E2BPU_-r1rgscJeN_jkB1hrTd9VWMK
    ks0fxhrgmJuhPxLjw>
X-ME-Received: <xmr:M52wZk_lkLc_YYxADjtXDz9YyMai6n0dITSRf0-LuHvtTeQOXXYS99vTUj3SaHVdwqkQldJzSBiTz2pdFjD9kBDNbQ3BghBlqgfyo9wmiRasvVQJCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:M52wZsoIboJP5FAc_38sy7L0rWYvtrMzdAPWrz5nr4rHynVmP23NZQ>
    <xmx:M52wZlr-OufCa_my_nB9661003GfuSVg-hFXt-hNnQAoXsCHVNdO5g>
    <xmx:M52wZqTEgXywxFSQHOB45o2MOgdQyi4Cxtp_ZLc-W7PUb3sLGqfD6Q>
    <xmx:M52wZlqjuYsTpnPnNlADekoQLEHIwGLcVZe9XKPVz28XqnODEF0_Gg>
    <xmx:M52wZs28YdidlBAKzyrUvjKQ90CZiiu_YZr1oKe0qrHHM6M4_K8aWB6v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 05:36:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 81e3976b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 09:36:50 +0000 (UTC)
Date: Mon, 5 Aug 2024 11:36:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: AbdAlRahman Gad <abdobngad@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 3/6] [Newcomer] t7004-tag: one command per line
Message-ID: <ZrCdME2Q7gT0KDrr@tanuki>
References: <20240804071137.30326-1-abdobngad@gmail.com>
 <20240804071137.30326-4-abdobngad@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="swe6cEP2G1AKcpgM"
Content-Disposition: inline
In-Reply-To: <20240804071137.30326-4-abdobngad@gmail.com>


--swe6cEP2G1AKcpgM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 04, 2024 at 10:11:34AM +0300, AbdAlRahman Gad wrote:
> fix lines like these:
>=20
> git tag -l >actual && test_cmp expect actual &&
>=20
> to
>=20
> git tag -l >actual &&
> test_cmp expect actual &&

Same remark here regarding the style of this commit message. I also
think that the message is both overly verbose and not telling enough at
the same point in time, because you require the reader to implicitly
derive what the change is that you are doing. Proposal:

    One of the tests in t7004 has multiple commands on a single line,
    which is discouraged. Adapt these by splitting up these into one
    line per command.

Patrick

--swe6cEP2G1AKcpgM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawnS8ACgkQVbJhu7ck
PpT4WA/9GNcpm3j2mb5QhcGRppmWuckioLv52USupOOGfZYh8z2LMY+s+NCJ4aem
P9sU0xBhMtTAaFPJeeFWzGK1HkAlZdt2Cs8S6bRs0fAU3amRicJaA8ivnIBhgnsj
WCokftZG4haJjwZY1Mds3iFjqU4S3TlRTy1PPJ3Riheru4y5sxOXxfxZTZ9UUaR9
l26WTiSC+CscUbCfpQMnPzIOc3Iky3MrvIV4nxfOR0Hn5UhhSEoghBfaQzIiuvVj
gWahx+V/fLQJQyjDd9sngIy2nXxobto7DvwDhPHCl8lrSo86GsIdrQJpKXKeoWmm
p5/pr0qXo2fJhAJwd5K8tdtRAklEOr1ICCs+NK+8PVgtYdN4SAhaM0NFUPFoMZwn
crJNGKZPbQtDgE1TrXHpukdUx7Hb1YpqHyAoy8BfBpGGeiYJ/7p267NgOZRpD3I/
xGHM6dTy68fzprVF51myqsQchOhQdqRAqW57BxefJWXJ4E1P5oSem4fDZM1QIQ+v
VqL1Za8QKxwHI8MXUpC3tV5Z5/f1qpqzubPwpmHlbZ7d31s3KkWgEthKvqwPNh6G
ZGJeqG3l8TQziBM9Ql3256cTQgHo26bgqWUmFrpvXUOHjS0IOFEStGMTX7eY2Wtk
ViY0JZYKNm/Btn3ToVoZDqIgQWvCfqWNkXvkwQjpjxJHkikRgE4=
=hXGJ
-----END PGP SIGNATURE-----

--swe6cEP2G1AKcpgM--
