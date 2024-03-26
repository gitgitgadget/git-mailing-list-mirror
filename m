Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD6152F67
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452159; cv=none; b=YRuDqkXLBGsXIiHmgUOaSuZVNU8YXxT92AhufAahiWhX6/H8tKOVxF/50q1Usc6rE4qKzv1wMtTEuYhdxFuYR1Y2b0P+a5wI4Nvi0fUxlhAMAeev5itd4tGW8zKLR+csct0+DCcgTSJyBPbrmBANgn3U8kXfyk8GO5n3lWpad0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452159; c=relaxed/simple;
	bh=HdvMaytKHTNPJj4+Eqqc3qPyXp8jLi1QGuZ+icfqV5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zzze9YdEelC8+U7ramCkwHuGaAfL1jfLPu/f4uA01F0F6xWs9kC2fJ6lk1cBrEw0eymGH+TIRf+4ym1JV4Os4ioqPz0UffrLqgZqAmkk5pFH+ZqdoAXhRqQhsIZ4QA7T6pVS112JSuSGyq9i/6TTbOZF+35++HCShwkwEMn7ifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WeUtrI3v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vUi90kkh; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WeUtrI3v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vUi90kkh"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 93CD413800C9;
	Tue, 26 Mar 2024 07:22:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 26 Mar 2024 07:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711452154; x=1711538554; bh=HdvMaytKHT
	NPJj4+Eqqc3qPyXp8jLi1QGuZ+icfqV5s=; b=WeUtrI3vw9kzPv266QU8vwE7vL
	h2AXpPWkjaxCqs6jrVhUKthyDEA4IUboKbwwqSo13o9ArONRNnwVdS1tfIOMWCYj
	7KRtOdDb9AH98INWYGU1a3z94SWu0rWbgpmJAYGm/c1lrbCk6BwCk1DHHu/20nHc
	9wP3EzISNuKC3UlsMuv3OYx3Y/QIvTHK7JD9jx0nwwWsCSwFqCiA4d/49Sq8TUri
	yR7rALJ0MSm/TXBA+eoBX9v3I9pdCCr9DB6ptjsz+FM8gXVbn7aVLWuyIZdge7A7
	5vtXPc9JVg0VdEVzWBh3uivt8J81/uRFJgiy0O5CHaQhfhh8XFC1KeKm5Gqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711452154; x=1711538554; bh=HdvMaytKHTNPJj4+Eqqc3qPyXp8j
	Li1QGuZ+icfqV5s=; b=vUi90kkhbTDhYmIQtllEI1UAERphOKpxfaGTHQD+LbWl
	ekM4M8jVqcgtuoD+3X/oMP4lyT/uE2OhedG/Jx00EseugYb4j7v4l3IPZQ2Jevxz
	/Ghx4EkGR9QLRTYP9VazJwWNbM6qXHI5MSgysQJv6ra0jkBr4I/dgttECl9i0kpt
	lGxPw9PsElTYiD/8QTTfoB3vw0gDbtr/DviDl1Kn8WBy+M8w7gbgQsivmPnLh1pC
	NWw+LzfHutNNdPQzB+CGOfRXR1vdwjot3Ib7Sc9r+NKJ+cOqsKsrdGDsD63Lft0o
	Ae0w9DqLFAxq1KpC0UA9OBiYVOK1tSOS82BGcDkCuA==
X-ME-Sender: <xms:-q8CZsZ_oti5vJ__xzFIdEbtah-9tzxVYAQD3fAh8yeXypetG1pO-A>
    <xme:-q8CZnZnegKYewEoHSHNc-U59mFKP8pIzG0Xvy6yI5GFCVJKC01aR6NNaMdJLBjrW
    sLZ2_hD6s2yQWoLbw>
X-ME-Received: <xmr:-q8CZm9pOrMQEgpp5CgsbOT9a9JvZPout0utiZ7Ib_RHaOQEGs2urkfeb7KT1aF6HvikTc77tdVdoNW_EIilHGXtqIymEqz0a89jb4ClH1oH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvfevuffkfhggtggu
    jgesghdtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuc
    eophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepjeefhfegkeffuedvjedvudeu
    jedtgfefveehgeetfeetkefgudduudejvdekudetnecuffhomhgrihhnpehmvgguihgrfi
    hikhhirdhorhhgpdhgihhthhhusgdrihhonecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:-q8CZmoK0IMUJ1K5N7UVTEeJw_sia91J8vXurCzKjh4-RyWIapw8pg>
    <xmx:-q8CZnpv68q5sEbpA2fiJSf5ktE5S-H-s9jZszRwF-ChVRWOKYkv3w>
    <xmx:-q8CZkSvxP1RaaFvszYzFcj3UzW5CErOAJPHeDhBPbxI2ejXSzN9gA>
    <xmx:-q8CZnpJg7-2btYa2sHR34ZGphtMZj0axtNOkCOyahJ462i6BO_-GA>
    <xmx:-q8CZonNIvRZn17N5TrnX3HomrFqpTMD1j-OSsWN69IdZsf9wFT5hw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 07:22:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7f28ee7a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Mar 2024 11:22:20 +0000 (UTC)
Date: Tue, 26 Mar 2024 12:22:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Aishwarya Narayanan <aishnana.03@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: GSoC 2024
Message-ID: <ZgKv9sZ6shfqym2P@tanuki>
References: <CAHCXyj3U69qyhYewOLY9hN2rvi_5ZuSxQEBJbDxrKefm9MzVWg@mail.gmail.com>
 <CAOLa=ZRqkKhqUPjrYQWmLnLAf6Cmt17ZSMJja0rYLNWifUG+og@mail.gmail.com>
 <CAHCXyj2a5QFO+fDekR0sQuyFLocucMQeuABxG=6g1X92_cEkpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wuDKkEXWtsLoPqNW"
Content-Disposition: inline
In-Reply-To: <CAHCXyj2a5QFO+fDekR0sQuyFLocucMQeuABxG=6g1X92_cEkpA@mail.gmail.com>


--wuDKkEXWtsLoPqNW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 02:33:59PM +0530, Aishwarya Narayanan wrote:
> Dear Git Project Maintainers,
>=20
> Assistance Needed: Locating Test Script for Addressing Git's Exit Code
> Suppression. I hope this email finds you well. My name is Aishwarya,
> and I am reaching out to seek assistance with a microproject I am
> working on within the Git project.

Please not that top-posting is discouraged on the Git mailing list [1].

> As part of my efforts to contribute to the Git project, I am currently
> focusing on addressing the suppression of Git's exit code in test
> scripts, as outlined in the project's microproject ideas.
> Specifically, I aim to identify a test script within the t directory
> where Git's exit code may be inadvertently suppressed.
>=20
> While I have attempted to locate such a test script independently, I
> have encountered challenges in identifying a suitable candidate.
> Therefore, I am reaching out to request guidance from the project
> maintainers in locating a test script where this issue needs to be
> addressed.
> I tried commands that included:
> grep -Er "git .* \|" t/, grep -R "git .* |" t/, findstr /s /i /p "git .* =
|" *.sh
>=20
> Could you please provide any insights or guidance on identifying a
> test script within the t directory that exhibits the suppression of
> Git's exit code? Any pointers or suggestions would be greatly
> appreciated.
>=20
> Additionally, if there are specific criteria or patterns that I should
> look for when identifying such test scripts, please let me know, and I
> will ensure to align my search accordingly.

The command proposed by Karthik (which is also part of your pipeline
above) does result in several matches in "t/", some of which are actual
good candidates for a micro project. Did you scan through these matches?
The microprojects page at [2] should give you a good idea for what to be
on the lookout for as it explains the issue as well as highlighting some
patterns to watch out for.

Patrick

[1]: https://www.mediawiki.org/wiki/Mailing_list_etiquette
[2]: https://git.github.io/SoC-2024-Microprojects/

--wuDKkEXWtsLoPqNW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYCr/UACgkQVbJhu7ck
PpQ/tRAAnFFplyb0jXWXD633koBuahSAA6t/+gxo0IJXiJG7M3xkJYueC9qhzlTH
tRxGAKEsNhc3Ete8cXvivT545x+FR6b/Hrfvph8H198KcsmMBRhiuzVGxJNq/Mce
3pic39HY1Eyr453C1zvVxVyWvOe7RCPkUMIh2yRG0VX1CcDrmrKWV9WRfa0BuwyI
g61D75bvp6hL6hWc/3cgjr37bGIAp5AkblK9ILZkjazYuUHP3PF+vLRl6zuF5okM
f7iPYtpdmWC3ZoAQKhot+mRtqm1JaxcVwnJayx9JoRVP4ASL6dP2z5WnCSG1Lgjx
xcrbRMSMACZtut9vrU32zOrDXcJp9XHI+gCabdxD/AYe74EqM/N0xjAn1UmErv9Q
M5B0BFCBfJjR9sD4os2MMcGHIkcJxqcADIpnmTSlGxq83zaNtvnSGit1eiVNU/DP
v84QN883oSCJpzw4H2ATaaM7D7q5pgKQyZx+prYgmB++XN0Qx8VttcezkP+ZmpdT
LJJkeErUwWT13OZuH11P4+YbyltunnC24rh7aF7aCKOPdKe6+a66Nl17XYMWz07e
tBA6KB8B+5vbkuTCJr98k6dkF7i05oGb4oiYtqqOjFtKCShkotBHDDh/8HwP3NaW
BtTtVPX3DNMnfJZhk8h+FEvAeeWzGVE2udPmeFHwmyA2Y/uO6M0=
=s3hu
-----END PGP SIGNATURE-----

--wuDKkEXWtsLoPqNW--
