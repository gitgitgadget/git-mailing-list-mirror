Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A1614A0AD
	for <git@vger.kernel.org>; Fri, 10 May 2024 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330897; cv=none; b=Rhbf2NMYDeNnNK21vAAPLYYUnHuBBroCZrWOKQm1zzITsoDzCZNlwyM2mqPJogXc0bdci5YyVigvg5AOHgpFYfi0waos7CNpPMXnBm8EBzdrCsDykPiOF5vRmmYQwafE9/piSEN2wmZyjyZwTJs/Ps6STvZWkIF8+kVJkwSPXvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330897; c=relaxed/simple;
	bh=9FaISbscAIsRhj0bfHbywBoMGlSE/hpXRHpgziYtfdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbbzjPGv7tRZFOxd6KDP3/Z5YIJpgMb5aeQ/i5yasODZeNDCw7KpBj36skLtIket2H3vJvPlNTZHhApjjwAireIpOyNfGC9ilqO1ahsozswF5FKcze0E8FSCpE6iO3ulJUqYtt8ZDWZN2OI+wwFiUoKW202q7UwdgNetswGdScg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=u33HMdH3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hg/HWYPN; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="u33HMdH3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hg/HWYPN"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 4BABC1C000F3;
	Fri, 10 May 2024 04:48:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 10 May 2024 04:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715330894; x=1715417294; bh=MEDK2w1aHL
	ihXx6ZtkNWIuk4veq4f7qX5JPAOQwQbbQ=; b=u33HMdH3loIsuLIBtSvZpqIvWI
	QXyfCLV1yj9yaZ4ctihWm3LcdbBMNaGzZnDuOmpD9elLVJZB4SdMRP5uwPzPzAIO
	exldb43eARbMHwmYIUNmJfzfr5ZD4eVFnDeImbf2RLTeOBLokJl1rDi+m+2juIbK
	xWilIWWE+rxjrsAqG/Nd8jKQzKpxOfYjtsEW3q4nWVK11sW6pVXhQ1b/Gpkhtssd
	Oo1qp48wFBMIfP0r5PhwOBjF7J/b0OhJuDXLQ5T24KJXDDNmqIsSq2mIbfVfkvYn
	ZAD1wS9lhqRckS8BZPVoW5wDOZJ6zEPGF38MOjfTpDN4fS77GMZ/uvtoIIgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715330894; x=1715417294; bh=MEDK2w1aHLihXx6ZtkNWIuk4veq4
	f7qX5JPAOQwQbbQ=; b=hg/HWYPNrtuLVDyL8xIo7rO1PUDJaypOxE2WE8IZSctQ
	bOOcyc7/HXv8amjhS9iq7llfduQbyFBirZutBUtDX5S7aotEPWYDnZ3iXERspleJ
	W1Gfmp/w6PtawJdU5ymD/lJYOIRc/cufbJo+2Lp1TPjc2tgG6ElLbd9J9uCQUlO2
	sjBiHOmVxVjaVWeQzlZwjimmuPMKIgIxUDiDLpfhsjkqjolPH7e/EQNHHK7ZCcfD
	0KNQqGbyljFN/UVUBkdeF5ZU2pBb0NIdSMMJHP1uG8Zie1Z/NfL16CCslbrqAhsP
	E7YekJl9M5wg/R4piXcw9rMT8pE8sl4iz0nx4k7xIw==
X-ME-Sender: <xms:Tt89ZrLCjX6i_BMkGrok6P3u-icvR4VYc6tfSvLqVwQYDye7RbC_iw>
    <xme:Tt89ZvLtVV_f64Rcpl1-Mk0NcnHbnwDE1NAGAXNGaR5qu44ayaZt7ZvCAkQ68fb_D
    LLPIl-JVJa1atrOhA>
X-ME-Received: <xmr:Tt89ZjsU1vlI9xHU_flw0_SBadvu6swsyuY4OpSTRobrngTIUJ6y-09889SSAwsq89Oath8K25P93_HAMPp97HzCJHOaMPNjwIFuVDWGzlPI0xb51Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Tt89ZkYLm8usMAEOrenWq0TuuUmtgWG1c36QxLvlOAL2hqTh0h3GOw>
    <xmx:Tt89ZiZ18FGawn-ChA8LRuMPzKjqbHhqi5eBUmWXymbN4r0XvZ-HNA>
    <xmx:Tt89ZoChkGDZIVrJJkUWNihLdSaR4vKbXEe5JAXHSsxtt01CSyG-QQ>
    <xmx:Tt89ZgZVS2MjKSmKWu9UiOV6mNFzaCyUW62Ee6ZFp9qH6bABKIumzg>
    <xmx:Tt89ZoOB7p3McOYv7jLZlxPF967b9po2JdOl3rUnB2uz0D-pnsMTI1eo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 04:48:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6224c8ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 08:48:01 +0000 (UTC)
Date: Fri, 10 May 2024 10:48:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH v4 02/10] Documentation/glossary: clarify limitations of
 pseudorefs
Message-ID: <dce3a0fa7e7b6ab822671d5c250e09ea482ab34d.1715330206.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715330206.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Dp61i9oINyu58ja0"
Content-Disposition: inline
In-Reply-To: <cover.1715330206.git.ps@pks.im>


--Dp61i9oINyu58ja0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Clarify limitations that pseudorefs have:

  - They can be read via git-rev-parse(1) and similar tools.

  - They are not surfaced when iterating through refs, like when using
    git-for-each-ref(1). They are not refs, so iterating through refs
    should not surface them.

  - They cannot be written via git-update-ref(1) and related commands.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/glossary-content.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-co=
ntent.txt
index e686c83026..d8c04b37be 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -498,8 +498,8 @@ exclude;;
=20
 [[def_pseudoref]]pseudoref::
 	A ref that has different semantics than normal refs. These refs can be
-	accessed via normal Git commands but may not behave the same as a
-	normal ref in some cases.
+	read via normal Git commands, but cannot be written to by commands like
+	linkgit:git-update-ref[1].
 +
 The following pseudorefs are known to Git:
=20
--=20
2.45.0


--Dp61i9oINyu58ja0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY930oACgkQVbJhu7ck
PpSy+xAAlIAsSESF8rhpAwTzu2ofV9bf/UW/4z+4kRxGJ8m8M3awdNV04JjWnIU8
Q2RXBs6EiBQ9fHT4PBCX0BbcxPiLoenrTzu+ofBAWU7ccoMK69UujdZM7iALh36u
02XQPxvugC7mfJO9Jo+c2xW0FADiRYID/NIAFaNHl6BQFGh//6EQMgog/Rq7NGAX
zzuj6veQ4Vq16MWT6EwIUs1Z1ZAZNoo+/l8LO3PR/FvLDOePPXXmhqo4l73CWqAs
kyGufPvKY/5pCel9pye3L7zqhiKUoirsy27X5v0Rge65/WSxVl9/7AF+ex/fmFuQ
0myyYwTNIB0URvF6gwZvYqB1fTabs6TElFGF/1MpDOMuMG58ZaEVowdJQMLMmMUF
ZI0L57oY26AOYRXpYkE77h49QEAoldCiqwCneg/BrFO44X7VW+NRlF8K3syJ0pv8
+aDDKPKUry83Y7nmEUpJp5mGZOQu9Kfd/ROx6bUcsjJgBeobvkLPwhOjHPcQrOAv
KGRFwla5eu/u+KzI2/j3AMJd7fKeGJDvlv09ysqV2fbFxwXAyIKZUjxZfz6qDhnG
BZpqajxykNjOJljezwat1Km8Xeu614FDE0JxdfeLTYDWDRfmLok7dbcY7rHcLJ0W
1WkaUoqzPCUb7lcivZmtJzlNZlT8UVZoQnnJSFzU3Hc9vrtpJsQ=
=bkoS
-----END PGP SIGNATURE-----

--Dp61i9oINyu58ja0--
