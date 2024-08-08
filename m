Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943B2187854
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 11:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723118103; cv=none; b=CugbmX2CIq3FTKW7mm+tnoKqmTQF5PVRpiLN2ksCQu6+p0s0H1Mdkz9+wjfq0MztukkcyWdegVwexM0Ay3RFpPgXHFLYtOz/IdGI9FX0QMNkXW3J+eGQ7+l9e5lY49tx2mXFtz6EyX39tSt4LlK55OYTxK80kT/wyYW5cEvHVBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723118103; c=relaxed/simple;
	bh=1lrbImn3o+FazI9EFkPCn4d5VOJCE1DAZjCJW5awG90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmrv8FyL/+nvJsiAGQy4q5/T9utjQCDnmE8lHPJjSD09YXaJJltBxkFyKhhSLZRmuYZgOaUtVtr2J5NtwIjO8qSiR0usdKVvsHNUaW6Qbx+tqSA1WkoU0Ll1PRwYNgOwynLbdyvZrNzGVinadNIKAGiD2p8ca/IT/WZe72lwH88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AeSGGgcS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oL6DzCyU; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AeSGGgcS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oL6DzCyU"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 966F5138FD33;
	Thu,  8 Aug 2024 07:54:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 08 Aug 2024 07:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723118099; x=1723204499; bh=1lrbImn3o+
	FazI9EFkPCn4d5VOJCE1DAZjCJW5awG90=; b=AeSGGgcS1s7xCdn38ZEas/OzsV
	ilVC/T0vWee1455b/heTm3qnt+vqy6zZZ4arVJXciQNfCytXRnjZnabf4/6A75Y0
	SVBy/l1Di4b+qoepNPGIq5CZ5XUsf5eZWwn0q0GJIObWi9EnNKUMxPGgtV4g5331
	c99zcfUfMPmZEscaSHbg98S3yMSoM7SI0JDfyQsa95yjYwRqHhBZUHrlC7NDdUib
	rVe411qd7G2CEf9F65IW3rG/6557ZYj7bxaI73cfGq6QpZ7KLsTghH5sDBduyAOQ
	FqaGUbrp3aEX3bUi7OZ0CunpGm0qHWI87C4yd3KN/CVY+4pMIpQ2SJONo1bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723118099; x=1723204499; bh=1lrbImn3o+FazI9EFkPCn4d5VOJC
	E1DAZjCJW5awG90=; b=oL6DzCyUPcImiyuCk/b754VMFYfnV4BZ2LrxgnEr7wwh
	NNMQNGHqt1FSeqSzc0cl21h4f+0DYRhJ5UwvQveK8d8/yR+KphV5+fKUdOJ/6HEp
	EKZDd6XeAwhAe0sxxDHT1ZRW+Ng3efQ1w8J7s8ygSloXUo9/C8ts2Lwbx1HI1Ged
	+OOFxVovugn8A/TT/REWbOMIUDSPpDI1HEqjaSypemmn5mhy4BBPUt03nlIL50GN
	PEilXpZh1ymh8xKlGerHsz/tmAvjQgEliCXGwd4Oc5PkyQRMMiJTu8aOESubeXwo
	EaW0UxbSxXj4U4l92+dZZXb1/+H0tV/iS/YafbqthQ==
X-ME-Sender: <xms:E7K0Zj2EVQ3MXA67TBjnQvvd8PMb3nrZKYAtWwETzr7SVkFiSaoJ1A>
    <xme:E7K0ZiE4apg3jTGE3owtCpEj4AP1wXbVJMVWbrpAvFAG6JGQfU6ofHPFQeQ9A1RZC
    Mf3Z0UuhQFYv6H0YQ>
X-ME-Received: <xmr:E7K0Zj7kc6dHZZPDb0VjRuQ2hSH0hdFjS5zYWzsq2E5Hm6sozd3sxXUXq1tO4brAtcDmXTG83ZpSp-nGREjop3yeAsqEBLkxyPIKK_dm5Z2_0GPs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdr
    tghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:E7K0Zo1Oc90XqG7nSSL24PeP5ipeR3bDym7ZBSoO5XmhwD9RtDc6JQ>
    <xmx:E7K0ZmHk6s5UU-DkRPHUpcRPX61ZRPBFFGGDMf5LqFPfCwMfw2qcow>
    <xmx:E7K0Zp__hEsFDUzP3_H-VKAT-J2H79CkUqyPBHHVu2v3J04qN_Yp2Q>
    <xmx:E7K0ZjlCe6DsfRmGtMiOmAvSRum_VKXah2ygWOLZBWK0zwVyMcgA4w>
    <xmx:E7K0Zr5y0IRlQIDJI8kfadEwrvXx6I6tBt0v7wLkA3_WfyJ6Iahk-XWq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 07:54:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 192e8c7b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 11:54:49 +0000 (UTC)
Date: Thu, 8 Aug 2024 13:54:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v16 0/9] ref consistency check infra setup
Message-ID: <ZrSyDi9tD1wtZm-F@tanuki>
References: <ZrEBKjzbyxtMdCCx@ArchLinux>
 <ZrSqMmD-quQ18a9F@ArchLinux.localdomain>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n+WWVyMVJv6aH5tZ"
Content-Disposition: inline
In-Reply-To: <ZrSqMmD-quQ18a9F@ArchLinux.localdomain>


--n+WWVyMVJv6aH5tZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024 at 07:21:22PM +0800, shejialuo wrote:
> Hi All, this version handles some minor changes:
>=20
> 1. Remove redundant newlines.
> 2. Fix typo in commit message.
>=20
> At last, I wanna thank every reviewer. As we can see, this series starts
> from 5.27, it's a very long journey. I have learned a lot.
>=20
> Thanks
> Jialuo

The range diff looks as expected to me, so this series is ready
to be merged from my point of view. Thanks!

Patrick

--n+WWVyMVJv6aH5tZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0sg0ACgkQVbJhu7ck
PpTtag/8DmmbtXXEjQiyRhHjKQa1vyUCGiKXnd1nIcU26OBkOcbu3+JFn1+TOsXX
XzroYyc/9GoCCkVIjtekiDr4vGoRYt8mjRxVidpiG6BIY538ARqzPqlbK1++nJi9
qJZBZ+Y8uwv6H16LFD6JiRP5qWR2C6R1+UBZDK76iDD27ba0nUC8TNBxvBylcKgo
P8l9NrA/+heqIUJfmmoyrGjq5SoMXcjxrz80uEAmaY1y8ZSjdSIHxmNThhou9wds
fWc84a/8w5+Po1BBTlRTWgZ3sAMLofOKKgeycDRaylgdsBLG6Kbgnbz2oYwjlDaQ
UO8MUXNn0B+k39KLGgrOIGYyM7qIa4/+ZKzdxEK7cyKbauXC3+xSb5ovEMpaqyP/
Ray1MeSWVJoTn4idlZq0FuIFCunQQz9JCuIYvgjv6XZZgZB5UsNPFQbcnwZ2Tdv8
+nNd5Gt4zwUgSPZc/gBjx9MxM/d7kFd5VshbU8nfijT0J+ONMr1Kc8TB3lyx4faU
6afScNKHBvtaj76uZeXRQNX0UQ8Kjg7WDU8Hr58yWigtFlrBGU688N8ZF6qCRCG1
iw3pDJorK6Pc/08r3772i2D00rr7vOH2sMY6LLMUpj4By7SKsKhyTb09+E4um7i3
VMToUhFEU5IT3GzsgdZMkKCaV4/qTq2Mj0hv3wyv3Nq9Zibicm8=
=tijH
-----END PGP SIGNATURE-----

--n+WWVyMVJv6aH5tZ--
