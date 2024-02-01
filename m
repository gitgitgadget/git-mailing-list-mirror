Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44A74D9E0
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781312; cv=none; b=NC8CIV8NQQ0wIoqvwMRbWQ0xaINtRU30awcA9z7dE3Mo0Kl7FGSIXRKvXUrBRI/XXQWn5nnibtszuJW/4vTBsMUURKOJO0nvrlQyxIfMl/TMbuTMj1EnAEK7A5Tx7zZ+MZdMIyprUWXtoRJ21YyPWaeZx5cRMa0h58fgHdrWN1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781312; c=relaxed/simple;
	bh=c7ht4/QonN43k8O31eP/Ol+F3Y5IHGU3gHWcRYztKW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCcLnPwxk93b0V8nUeQvAAT011LyCr3UpMkZWs6dJ3N/Nox00h4M0wpiDQftzOcbFxAHatzaT/57qSBEfDPQ/hZZAU1fMNrSOwRXjSDmPiVo+VDuKjPmQm5Q+RTDyQ2bk8y+M8VbnF3oXBgpbmr6CC2+rtW5eDHUIQqpih4MpiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OdQ2YF4k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N3ULUeFJ; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OdQ2YF4k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N3ULUeFJ"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id B5B063200B81;
	Thu,  1 Feb 2024 04:55:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 01 Feb 2024 04:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706781308; x=1706867708; bh=c7ht4/QonN
	43k8O31eP/Ol+F3Y5IHGU3gHWcRYztKW0=; b=OdQ2YF4k/TVNGoF4HucfI2I7R3
	jHc4E0bcsXfDCsfeaz7+Tr6tPNvENgLgqFrQkuq1zXcyjCsaRkMOemgAX6VglKpe
	yMzJ/dJ+M48zxFFzT/0EPfmcjZeVnvaZfRqW2LZUFrJHjg7ygDP0RKHQB2VcXKA5
	pMqa4iAq4lh+2awckzq4iv5wblqulqRzTR4TUlIwFfKmJH/tM4NREzBEJ5qFY8dI
	tda7jUywkvr0KAXO9qzXf0oDTPsBusFskog0q7HoWK3HL9JJqq4zMbLWh71dnoW4
	m2Xgjf10qGIAiz3VsEp1n1urTOm9Bw8waJMwAyFdYT+T+F/me/yLraqTzb+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706781308; x=1706867708; bh=c7ht4/QonN43k8O31eP/Ol+F3Y5I
	HGU3gHWcRYztKW0=; b=N3ULUeFJkhpdTb6v76zmUjOor+NoDWZ1cHgRE5+16Zv7
	7WdPA4BgV/UStXXQf0pnxPSKWi5/AHKxtfIKCfOSg+7vU4tElfHyglqNubRpPSuO
	2/15T95frvgYIIMxwwC89lLkUOpS9YfajyYhPsbAHKakoPnivzUvLJIdlFcBoJFY
	a7N5gnmBnOaRQUjyf8I3eF/RGCkMyzO4w+gmhTKtJS4VMmc+ng/gU9XvuwJTo2Ll
	mU9PXW5UvlpPod9YGVGkAo78Pf1IF+IY87Ln62FJyvaSltrQPmiMpbuLO4sQIJc1
	ojLIUeKfo+/ppsXgSjivB7ga8yybtVx2kJSYKvsVnw==
X-ME-Sender: <xms:e2q7ZeUiFMruKhbg4WluzcetchOKZh_npG17fp8b_mJjfj02qGNFeQ>
    <xme:e2q7Zam1_ir88q4xqIGoeqQd0RbXsLF4NtchcpvKE9VmPOhfkQ6G9HcUWRAft-XSz
    whR7T50KHSEuqKr8A>
X-ME-Received: <xmr:e2q7ZSaH1SLqyfGCywVFAD0Lk0rKO6GEu2-pqbr7TjTOjXveuBjhfssgDX3iuAsS1_MmrEsnuFevzNxC_wjTLpRG_H24hLv2c1-5KGSTt5b4EQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:fGq7ZVUbQnw9EWHnNlrzz4w3UcQb5pPLynm-vcFeBLApjQIOaV3A7w>
    <xmx:fGq7ZYnFU3E37RW8nu62TI_6ItTGJWU72lQg3tKt6Nnb4p4l_DsHkw>
    <xmx:fGq7ZafNVu1r4ZFl6DbD0eDDxFWA01okunLt41_ZinuAVyGtZcIQRg>
    <xmx:fGq7ZdyaFASxQtFGSTKYHE9x3K4KSvF_jcih09M4Z0u9WK2LKBP-0Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 04:55:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cf01d0d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 09:51:41 +0000 (UTC)
Date: Thu, 1 Feb 2024 10:55:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Britton Leo Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/8] completion: improvements for git-bisect
Message-ID: <Zbtqdr3ycxd-Khyr@tanuki>
References: <20240118204323.1113859-1-britton.kerin@gmail.com>
 <20240128223447.342493-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="swlMGCwzt3PaVCth"
Content-Disposition: inline
In-Reply-To: <20240128223447.342493-1-britton.kerin@gmail.com>


--swlMGCwzt3PaVCth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 28, 2024 at 01:34:39PM -0900, Britton Leo Kerin wrote:
> Relative to v3 this reworks the commit contents and descriptions
> according to review suggestions, removes unnecessary case statements and
> precondition, adds option completion for the terms subcommand, and adds
> tests.

Thanks for this new version! I've got a few more comments, but overall I
really like what I see here and think that this is getting close.

Patrick

--swlMGCwzt3PaVCth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7anUACgkQVbJhu7ck
PpQRhg/8CYeVkOk5qaXQWJsVxFQmlzsePfbM2FBCbaedIKcDWgRTD8BuAu7o7Ki/
pHD3MGvaNZgC7BT3UZqKQGzcVmHmqYRGk4q9MYBKll8I29toCauAMsHh2JZhUTOz
eciXKondPj22JQZj2y9fZ/dDWw4fhNMNtf3Usr3nN9GnjDrrc1AraWf7xu74AvWQ
38T41jdF5SJ43E3MMU9N3/0GvkLj3hONkjp46xzCaBtqEpoXy3KommcL/O0S5Ols
vwRYAGMIPWYkNZoPHXFKcKkzZhmqU53G1S9JAOJm1cOTJIuHXZIc6PUVnmarX148
via8I6EzW201oyeIXZHalXKeJopXDLd7hOlGgSQmsursvrXURdKKC41MHsbkKp7U
FMCzpKOZoZ8Uuk3JQGYNNV36cHoVAkbzFw/ZX4ib1BcES8xj/4K6hYdmz2E62s3b
k0wDNUd6UW7IloDGKFQbu3hrn5DNRYEia9KWd4tV04okgzBALaoF4et0S2Fv04dk
dzAJWcDaGvMusmxZROp8Ux+GIuZoIRLfKKH4xTUsSnxd4RdxeiDRTzyYnTKnzyia
nSCvf11qgYxWd8/1rBslNrXefvSsGaXTv5HuzO5HXdumFqDEC/N7Yp311SmPFKet
x9RLUDTFiciUDws5w11jI6BLilnzn62vLBw/GmnfssiFqDyW2tE=
=cOPf
-----END PGP SIGNATURE-----

--swlMGCwzt3PaVCth--
