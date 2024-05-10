Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6AF1635A9
	for <git@vger.kernel.org>; Fri, 10 May 2024 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336048; cv=none; b=QXg7OLTQTw3p0Avs8uVCdgocbwTD1Wv2aJNFzfajbypdvPAKVGJQW/E4l+kIvc7wT0fL+MKc0fwiJ2SS19fXPv2MlnSIcW8tEC6Sqe27JTX+v4RwC4PZGs5G2aw6NG/u5Q5v8o5gSxE5Jmwa3WwiA0q6eqyce80UVJrhsorJjp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336048; c=relaxed/simple;
	bh=vfa6KzG7C/fkGRKxRVSy5Yn68aVIsMw5rNwL1hMD11U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWIZG1WwW0uJ41H/bFtJaNyQxDcPW/9jb0cQqw5q4oxGD78ji5OKjY11cAGK6I1zDG37xhDZqH9PTdaxaJUUX0XSkUwZHYbXdvB1W5reZD5kfctnUM3DcKRNDiZUSLNv7Pr3tT27HnSc90KlyO6CGmMccil9+DMhrd3lZKhrwCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ObfMV34n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KTqjgSut; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ObfMV34n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KTqjgSut"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2806E180010E;
	Fri, 10 May 2024 06:14:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 10 May 2024 06:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715336045; x=1715422445; bh=vfa6KzG7C/
	fkGRKxRVSy5Yn68aVIsMw5rNwL1hMD11U=; b=ObfMV34n4ZZw8uSt5GrCglxGyz
	8ApdHhEOPYcacPe0lsZZvv7ihLzEPplDagbJmK+XjuRSGqkXHxlIwSrMS/yOkHjN
	xPviAZRhXtliFL3J0P6m8qwqzKgpuC3RB6zvm1VX75UID/GEiA/wghAq8kuxmzRp
	/5goActspUzE0tvEbw2caHN/hqgPZKNyVACcpqBnNuz0QtP7ZOFXp8JZs14aiRXG
	WeZGWwrThI5cH8qW8z/LTnbkolVchgguhCFkLFwYkGj8E90eHz8Ae4mzENag9c1i
	KnfBHZbftML1n8s1Fm0exqT1fR0vB7OwXIfe1ZzSgVJP1+jRxKveSV07XeOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715336045; x=1715422445; bh=vfa6KzG7C/fkGRKxRVSy5Yn68aVI
	sMw5rNwL1hMD11U=; b=KTqjgSutsEnpoVK4kAIjVAKK0Inbhg4Zf9WD4lMA6Rgz
	2+uSRVs8sPgT+7xueEmY+RXUPWj81djWkBqwnFkQQqeLA1yBhsHHF5HfTDAJ9wl3
	ImofNpCDvIUoDtrhmRZAkZZ6xkwUmd3sd+8AdUg0JPTUWr802TGPNPOT8g7JKQUt
	wDu/BVxnBlYaW5IvOCYmz9OsOyYnFMsdxU9+SWaQpUtIp5RUMlyAz5nKe2Hs+k/W
	Nd+vLkeDqdV/drPZMPesFozIxaSszuYJBkrVql9p7V6SBHfvnKWYYISB5OOvEm5j
	9sUBE4wa3/avSMb527bs1owMmUFDKqVAIkQcN5wwOQ==
X-ME-Sender: <xms:bfM9ZhNQ7YGebwIatLQ5Nzdqw2v7sJPCFdcqJKYd6oBdYgrkZh-lcg>
    <xme:bfM9Zj9GdhvbT6mzYjSHY14r3vkHPNFmByC8uwicbREta4wkPmyqOSGqyejrzm5Xi
    EtZS5dLjX3o3R8zHg>
X-ME-Received: <xmr:bfM9ZgTb7E8yOVVoDnx9cZ8wT3hrE_VNeAPuEx5De8F35EzVH08cnbei7xA-S_J5GkxtOezicOpeU8OCnz6YMMvUk_PlzN8v42hQnLixMnNvUUeC6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:bfM9ZttEMnlvqkvabiYtzM3U8RoGZFU3xDznROeMRuIa6JgAcuufiQ>
    <xmx:bfM9ZpfXa2RUTkVctZoeQUGJIVpEsEIF58WbnFTELNx0D27QnyCDBg>
    <xmx:bfM9Zp0Rt9eXpWOw7ZcSxb1O6dYc01F9R96qqaYDjR_IzPXGhNjrGg>
    <xmx:bfM9Zl8fHyivR5RImzr5aTBWjuqNcEVpbG7FIKFMIN7D3ALlaHtuGQ>
    <xmx:bfM9Zqqga5uH-tfpdR-YlRowOZJ49DlbTB4OEsjpfJ4wdIcEa9sliTPi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 06:14:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0c996bc7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 10:13:52 +0000 (UTC)
Date: Fri, 10 May 2024 12:14:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/11] reftable: expose write options as config
Message-ID: <Zj3zapDuams3DlxO@tanuki>
References: <cover.1714630191.git.ps@pks.im>
 <CAOLa=ZTz5k8Ge8Ba1f0AUXE1NRE1sO_g5zrtTeYcthKP9VVeCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="autBnr7jsl8Xr6nK"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTz5k8Ge8Ba1f0AUXE1NRE1sO_g5zrtTeYcthKP9VVeCw@mail.gmail.com>


--autBnr7jsl8Xr6nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 03:00:41AM -0700, Karthik Nayak wrote:
> I'v gone through the commits and apart from a few small comments, I
> think it looks great already.
>=20
> Thanks,
> Karthik

Thanks for your review!

Patrick

--autBnr7jsl8Xr6nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY982oACgkQVbJhu7ck
PpQo6RAAgWNsbGQG2PWRakxfsMPV0qQII1x1KaQYeQqADMsmD6YC63DJwVunR34Q
E+syan+ZyjBoH2IX1mrlESflcsLet5paeqWo4ecS1S2NAPJNH1DnJVLtob+3j60n
CIhNX76IjLPX52Y21RZWpUkv0Ly76OhajZqkQ/rXxUgumY8w6/40tdGxMgc4hUnM
KjDflMEhatUGkJUsYW0kgLM6I9Jero2SG2GVlICm7czxfDEIHLcfffV9U30oo2Pr
zXs4qMW3aeqPN1XYimDpAag7LgA1Z4pmgIFqM+I3vJPxuB4u+T7Mc1UGAuspwnnn
+aGHRI6tdVMv8M7bmOnZ3mNvZsvxgqHqPj2FgBXO3gNkBxmO2WSYfn/aJvzJvVs0
/8bwz1WDqMz+UvqEZT5tYfYzcJSaugjmiNFqbtrN5CrZu8O8wSDAWqW5FRleNeth
ft/vUR3i1hxEFdEozf6c6dvlW41qCwEhcoeGcNtZ/H2HNkfIY2ztjmA2aopMut+g
32Sb0gTq+l2wNpOG286lS11+1VBRUhhqYXBKdJCI/DRGmiAjjH33YCHAg1nkdoQO
R+oujWZI9aLJmU6yqKcr/ja5jp/xocRLe3KvRhh9cq8fraOAOqYc/QB6l4x3WyWy
PmF9a+E51d4nS0QAc+8cOjNq9sdegykpNbGzjJpp1kRiFLzpASQ=
=0X1f
-----END PGP SIGNATURE-----

--autBnr7jsl8Xr6nK--
