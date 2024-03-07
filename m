Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDC264CEC
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843762; cv=none; b=uvZXm8SBKzu4BBvHF5IVc4JvODBruxjbP+eBYpWxdFziUQ+RUFFEcJKmkKLt3CPYE2zYm+F+sSk9wv6Gagr+9jg51yEjKG7EP4iaBys20TvriQkQ+dWOHpauBXKCdOGr0mFBtt3GFMpsTaMJ4Pmm6NLKFSupL2zYqNwUWdOOsIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843762; c=relaxed/simple;
	bh=+9CKVPlJKABgEHaPhADX6OqZNCd2jPcLiF68Tg8ackY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZjaLLfgf5oXPNi6XYoVU75UHxPFvDKl+uI7s6X+PZtDCvWi0sIo/4Vugu/y9BvvBMKvk1Jtxz4t2ngg9SRxxt/4KZcqYI4r0bdcIPz9dcC4ZGfRLR7sVts7p/rCpf2w9qnwzXxM0e6CP4QPyzqzCvqAIDxjmFmaxWWbiV0WDlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sVEqVJrJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oHHn960I; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sVEqVJrJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oHHn960I"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id D02791C000A6
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 15:35:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 07 Mar 2024 15:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709843758; x=1709930158; bh=KSqpsWoZuV
	bUreMAxkdwfVGag8hj4TBGmys47lv72fA=; b=sVEqVJrJa49bo2Fy4b4jAGZtQ5
	/ZMKoToWTGi+mhEsxQJ8RVYwVWb3HHEBAOEurxXeLhGIt4OsTiedNMLhhYSofOpD
	hyzxh8E1sxwIsWAuwOb02HCmlpmRPNpv1o3g8wDnOMS7Dz3LrskNzDOD/u+gE87j
	CWfu/EiFxhixggQnFdimzPek36oRqRWxPDbYkWtJ0dx3cz0FB2U4orQ526AoxAxH
	lePVMhkwq0/GUDDvUMXvzQcS4r5EF3nDEy49KFCexwNpk6VSzDfTO0XrM3wgF0eg
	XDyoAT825aykrLBbC2TDLjrgzndE20tRe9WrccgbYWVRY/DimsVmiB7Trh3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709843758; x=1709930158; bh=KSqpsWoZuVbUreMAxkdwfVGag8hj
	4TBGmys47lv72fA=; b=oHHn960IzDGQnpWybUDEnnMvWKHXTTKPJoOgtqhoq7Yv
	NwVhwlBxU7mek6Zg60Jy4IKNUpYCVls5exBuBcL29B35FkqqUHQhPfd67S91wBuI
	xudXBk5Z2F9RUzt4Bs3wF17s+C3zKkPsGbc56eCn4bgLv4sRRjeLedDY5ejebhUM
	H+eFxcoHy+41u6YKXEPIIX7b6X9EgxZha0kMh1RymaIsQhoVkBn/1ot+XcgpurRJ
	xPqxLQ+dTi1H0xXfOMVzsf8DtlnNQtkZQnjk5D99WUXEFiJxJC8LLoN30J5mCWvw
	YUKBdIsMOFvvNo1uC+bP8KlVcVLNuBn5EuXp5TzEEg==
X-ME-Sender: <xms:LiXqZcuOAlLJFrZPIjH8teEq0GXiRYTGR8IExLfz3E2JzR77TP_ajQ>
    <xme:LiXqZZdKeyyzT7lHGhdzqGZAW5BZSlL2WDiQ4g3ZiH_JfwN-azQhUR8h99qXB6X0c
    1cVoGn2HOAIk21Bnw>
X-ME-Received: <xmr:LiXqZXzEFmIm7tG2N6Uo6psnV_IyOO_K38a-h7MKHtZv89FEfbQtYzPj-5hKFQAbyJ5kb5rHqa3Qrfx6IZWEa33hN9JzO_tgMdmrQdq9xe9epQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgddufeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:LiXqZfN8bCdwp_akHbN1SEdixtaRK9ufuDxHXfmA48AWVoiPae8Xfw>
    <xmx:LiXqZc9Ju2eHL_NPfwFKnItC1OFQCUHG0zy-fqUqKukiWZLH8QfpDg>
    <xmx:LiXqZXUDyXxi8aPE3P9CmiTR7h9DJJUtuOmb-oRAAT4eOLGdqnjPaQ>
    <xmx:LiXqZakTDY7YB_kQDpXh9pXe7fWzJuRnKOvIUmji7dNCLXFNjFQiCcge7-E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 7 Mar 2024 15:35:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e820c5b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 7 Mar 2024 20:31:22 +0000 (UTC)
Date: Thu, 7 Mar 2024 21:35:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH v2 0/2] reftable/block: fix binary search over restart counter
Message-ID: <cover.1709843663.git.ps@pks.im>
References: <a4312698cceab5f2438c9dd34465da21d719e256.1709825186.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kG8hWa620AjztLHf"
Content-Disposition: inline
In-Reply-To: <a4312698cceab5f2438c9dd34465da21d719e256.1709825186.git.ps@pks.im>


--kG8hWa620AjztLHf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that fixes the binary
search over block restart counters. I've add another commit on top that
fixes a memory leak that was uncovered by the fix.

Patrick

Patrick Steinhardt (2):
  reftable/record: fix memory leak when decoding object records
  reftable/block: fix binary search over restart counter

 reftable/block.c  | 2 +-
 reftable/record.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)


base-commit: 43072b4ca132437f21975ac6acc6b72dc22fd398
--=20
2.43.1


--kG8hWa620AjztLHf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXqJSMACgkQVbJhu7ck
PpRcuQ/+M6sbB/xgoantlQVGZF6+roZm4QWIZ7S2pE3qcyI+pD6608BeSaB71VkN
fdW/GuaeFFwD9Vc5o43K8bIEVTJ40wZcGa9xWOTcKInS0eNmJ1gQIL4PhA5TNvra
62UclB90wZWHoAVMf09twNdoCY12wv/w1zhpPq216VsYc4TNFqbASueuCW3BudpL
e/kmpelH8yM6mFOwVNivIAHPkyVm08eYRF+f0jn6YmGm8J/Mnfv86Q9O+jnBfimK
c4c+ybreBU2T+O+RtjQ84+YxKzo4oWbTlHvHyEsKvC/VR33oMBmtwL2narIonvRO
svWCPX2p0JcVrOLJ8RHp1TLC9Y5rwxxS+Ww54ts14IoAk5Amafit192vGwOn0+0x
x1bRjy17+exULPlNp4O9CQIGFxClSYxvf27X/hY5DiWaIMuTd3UNGin6sUYIO/Px
NSWLD9cyvUw8mVVfGS3EOtsv+FSIuU5KvTHNDD9f66rKxhxSjQG3ijE+Ylkjkn8D
WoypR4X1e+r6cpQT6rUyBPCdXFDgMNbAu+4N6pVq2EAAy7vRy5WoqID9NTN6NlpN
uxGB2Ci3sMmrQ426A0djet+CuSZSV+g2//UdFY6A9tCfjQ1i9nUimYh/TrEx8jqh
xZLBGJv5GqSyLgYzQxUW3HQgLxrt267mUlmGfDNt8ePq8TdkCMo=
=Ine5
-----END PGP SIGNATURE-----

--kG8hWa620AjztLHf--
