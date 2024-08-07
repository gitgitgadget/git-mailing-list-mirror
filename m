Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9413944366
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034633; cv=none; b=ZckO4n7AXCZfX5T4IWHxeOllleT1ArzXaoC+ZvheGmgbBeIw4ToaTP4LDnSdNnD5er8w6kNZewgvGLvLvAtpGkcCwi8lTOaejd3xACdNCK3K8ywcSU8k7f8kKn1jIXx2mp+Gb2XqcqTD6gvI9vVRSoKsxe12OhVBDQE1gjgGiCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034633; c=relaxed/simple;
	bh=iBT1uSooj3COzQCi/dLRpnDOgpCeq7rwTKaRcdRhGWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6LIZ8o3GPcP9PKHgU9Ljj+i6aHNSnz+2+51UFiZW2FkK+QXm244cle3oqqwK+U2J0+Aiihma0XsEqJENAZ/AKKcn1M8pANw1jh0xwoqSEgkcfutURzPmeXEfN2wl7tBa6oIdv1zNuOGDTFCnmB+9dWWkk+wdcURzQ7COBo8cU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KDU0b13j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d5UoYPd3; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KDU0b13j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d5UoYPd3"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9A20F114FFD9;
	Wed,  7 Aug 2024 08:43:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 07 Aug 2024 08:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723034629; x=1723121029; bh=7HN/8PZcW8
	k6p+drTN1OG5xBhZjOrv1gguuErlcCuAk=; b=KDU0b13j3fRO3Wic55B2K8lYv4
	kpy1RPyTmgoHq8ldHrAKF1mzvNXEE0SGBA+5SUTUfHD+luqHua1GwMq1iYEydsyK
	KDcxAQo2X5O0bAlkQsp9oOyGOFmwO6ps1NLomGsS74DFOvQMe9qWJXpYXuv07Qk+
	LXWACjtH/flyaT/NXsCXmoKJdwITSOosp84i7zHBMcDCDCkenYV7G0EUNg5ePRqx
	ioR5kg72Wf3MwViz0EX84ov3maFGO0d6R0y8DnzpIWd29a/dH2F9Fjhi5GNvTdot
	Idvoh6HAuZEV0XZBHB80ekG8IFdVlszjZJna4nZjEGH0glKU0BJNz8aIfO2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723034629; x=1723121029; bh=7HN/8PZcW8k6p+drTN1OG5xBhZjO
	rv1gguuErlcCuAk=; b=d5UoYPd38sd7TCtQzD5Q7gawhKqaRMzI45MSKaXn9yJW
	zZiwRYSxb+G9BJzw3i7ETdLbbF5RZmWLhN3PDys1/7zDX/osZgjOIgdJ/qgMz7r1
	1Q29xHDXp2mzeiIKtcmnrArIdUiLNPuatwk2guGFRUfAfBjqxXAmnqVBUHDE7wny
	HsAZ0dWax1l0y50aDsU1Rc8/BCGSEyUNO+M5mU8UgdHN+Z3Foia3waswTFR8uHlB
	RSddDUSVEqEfaJKZ03/9Cht5DJG7zZVF6lt+FFVVhfbhH2b2zvnXS/ei3uEMsuPK
	Nf7SiC9u4nYUtG521r5SgQUheYsXi1ToSAU1rCdc/w==
X-ME-Sender: <xms:BWyzZqREixbPrJLhCrsJi89imKJcUz-DvdlsWG-aFkQvDaGX5xtu1A>
    <xme:BWyzZvytHYDk4Pux40ysv00SZY1i3Et7Xmk2TAUDFjuqEJIKdITPEuImKlfDVn5ye
    ZQbbkJUSuvzbeshGw>
X-ME-Received: <xmr:BWyzZn3Uoxqkna0KfWULIt02YX2eoFhKJjqmgfe8-tBkBn3o3qeEEjOrbkE7ryNQcoqZG14A3JinzBcpHMcb4RJNw9aRJWupRSTbbtHg7uvUobLt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:BWyzZmAzyRZCw_bAW4adNTUt-wlDUq5CTk4ZK46d03lRCTgctBJ_Mw>
    <xmx:BWyzZjjkllC2MkiPIHGRKOWKr-0RcylkEEBs0eM2Krops7RA1z7Yxg>
    <xmx:BWyzZioY0FWqUc5_MfbmJeUZRFykKCKctY10b319uMRJho_DMl_cew>
    <xmx:BWyzZmiXpaR3SpS-7CoslEJykivaCFrtfDyQcIHzOqwt6G3tAq8YXA>
    <xmx:BWyzZguZj8jdacsngJ0BVD5rX4Y7lW1UXIQ4JtiOkSuB-of34pqY57u0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 08:43:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5d0e83e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Aug 2024 12:43:41 +0000 (UTC)
Date: Wed, 7 Aug 2024 14:43:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jeppe =?utf-8?B?w5hsYW5k?= <joland@gmail.com>
Subject: [PATCH 0/6] Improvements for ref storage formats with submodules
Message-ID: <cover.1723032100.git.ps@pks.im>
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iAFUIyP0Ynzed1BQ"
Content-Disposition: inline
In-Reply-To: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>


--iAFUIyP0Ynzed1BQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this small patch series contains some improvements for ref storage
formats and their interaction with submodules. Notably:

  - Use the correct format for submodules in situations where the parent
    repository uses a different ref storage format than the submodule.

  - Wire up `--ref-format=3D` for git-submodule(1), such that users can
    explicitly use a different ref format for their submodules.

  - Propagate the `--ref-format=3D` flag of git-clone(1) into submodules
    when using `--recursive`.

The first three patches implement improvements for the above three
issues and introduce tests. The test did hit some memory leaks, which
get fixed by patches 3 to 6 such that the new test can be marked as leak
free.

Thanks!

Patrick

Patrick Steinhardt (6):
  builtin/submodule: allow cloning with different ref storage format
  builtin/clone: propagate ref storage format to submodules
  refs: fix ref storage format for submodule ref stores
  submodule: fix leaking fetch tasks
  submodule: fix leaking seen submodule names
  object: fix leaking packfiles when closing object store

 Documentation/git-submodule.txt        |   5 +-
 builtin/clone.c                        |  10 ++-
 builtin/submodule--helper.c            |  30 +++++++
 git-submodule.sh                       |   9 ++
 object.c                               |   9 ++
 refs.c                                 |   2 +-
 submodule.c                            |  18 ++--
 t/t5572-pull-submodule.sh              |   1 +
 t/t7418-submodule-sparse-gitmodules.sh |   1 +
 t/t7424-submodule-mixed-ref-formats.sh | 120 +++++++++++++++++++++++++
 10 files changed, 191 insertions(+), 14 deletions(-)
 create mode 100755 t/t7424-submodule-mixed-ref-formats.sh

--=20
2.46.0.dirty


--iAFUIyP0Ynzed1BQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaza/8ACgkQVbJhu7ck
PpRD1Q/8DxPstkjj1pkDcCJ2Y2oOsmgG4BFZqMNAsIvK3IfeyOqjder6609Uo9cN
hyndJ9U0EifoMsJ5phEOm4mh2BRGPvie/5GrM7aegZXOJg299roUWf3bbSicLbRi
YO/rm5P7VOOqDNjPPSa/SpNFu+mv1PFV5+H02p+bdMC6phC/aONir1jJz5G292Og
iIrI1YMq7b/jzTRgDNG2dzMzE1oVjZ54YmyHHq+VQlJ4ljERdjP6a9Qsi+0FgV5u
KawF1Ahe1Q1WCZoLv8cb9rrTJYPh+oHTFiR4yCbeLDgm2uF9GzyjVTcSdq8Vnn2a
84kfbd4q+02orMY0r73AtZfmL0QDhZ0SonPSMdTqyNvHRQ6OZMzzSb6C2r54noS6
3vBx+5a8abCB1rifRtfF4/r+nMrNDQ66e/sgpQKhugT2rMFLXeqXAbi6TCaCMTmP
fwXJCII+/UPXN5yrOb/OvRjH/Slc8/6AyMqlJ+Bn87pqJdF9il0n4fpRRvx1OxH7
KKI0QOpb/9vQp2K2BE1xygsAy8+tBYrGTqqQ1ZW/nbZN4P54PSTRfWN4Zsh7KjuH
KQ1XevrGoU00nOtvjTKZZGGL8unXXJ/SDb7sNI8HqwUHdiEh3jHz9AoTMAorKq5z
rjGD0rC45SOWgY2JLP6mPFPSbc58ripRzQ4pA9i3JDSoz8iajao=
=kDKi
-----END PGP SIGNATURE-----

--iAFUIyP0Ynzed1BQ--
