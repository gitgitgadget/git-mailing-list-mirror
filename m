Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D9F14600E
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831214; cv=none; b=qIhL0QyDOquQ6zF4UG96nwPpFLxJmCtMRykTpcTMUuBKiG+BM4a0w/0FlGjWYMv6tP/adzTexjzuDsiL5yIDjkDArUnOhc34xf3eIDr2h48+FRrslYR9WOf3dFpZHoirhkRG49J0K4lzA8VrrOXIxuv2PySVM/PP9flMk1BYIpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831214; c=relaxed/simple;
	bh=eWc2pVTNHNpuBzZPgK0RDZB7b7ZxnPHer3fcrJ/6KYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYgHhD7pktyBBPjcDuXXyGe2s8r48el0aTU9KiC9855jUY7nhcPEskTf2ExkQj7srBie9FTfPYqcy8XPPsVpyqMG/NJ5hzTp2I3MBeE4EaYAXWRmC1gCyTdtGCKzZaCUA85qHc1MIFJFNsH7hI5VoBl8k3oeGvjbUFjhcxgWBP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mtgy1zBQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C+zXL/Q6; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mtgy1zBQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C+zXL/Q6"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id D523E1380246;
	Thu, 11 Apr 2024 06:26:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 11 Apr 2024 06:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712831210; x=1712917610; bh=eWc2pVTNHN
	puBzZPgK0RDZB7b7ZxnPHer3fcrJ/6KYQ=; b=mtgy1zBQEsOQVqwOeth91NMoN7
	prsSt7EynS9tdHqpQis3BVrpr9GDvRlbfvjGo18nejz1lXzRCUfY6IhwJ1yN9WjQ
	cN3WPXt0N+Lig69jRHmzRT5v8qShVP7eXT+b2rRvbjZ9gAIvD1xTlrwajZYcabj+
	QSfG1Nf9a6qKElrpDufhhSQTW1We5CGfYEeXDNm/v3glRitAPMAuDJEdICUg7tQl
	cx7dUN0k0StcJKgmJUw5dhEMcuJGnDUifdzhajwvz2IfwISv51RY9Zj6iM2T7QPx
	OAAzCWJbdsnI+AoggOXE6+FGzlfEBCuprfIvDPMZ4RiRCClIQJonDF6qM4TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712831210; x=1712917610; bh=eWc2pVTNHNpuBzZPgK0RDZB7b7Zx
	nPHer3fcrJ/6KYQ=; b=C+zXL/Q66c+2oswTgTnC97RU4lLBQfKE9bF6xkAvUdxM
	hi7FBE+bDFUQV4Tnfo3+5gvakkSj6fkpi2pwzPxg/gO23G51jwraBDeGNHlKN/Md
	WCQ6pjkhtGhrCRhvG9WLSgYVP9xfkZyPuovGSo1Tv3Ad3w4cAUZytVaJLPG/KYSZ
	s+EXEsDhdn58WqNYESqOAZ9CwlfSHITmFr1HZVoaL3GhNKZEBe4YxMjChOlGtl4T
	tjDL5LnNDlLqscdfDc4GLFGYwMnnqMYErD1/HnBStb8KaQm2gO9ZTRUpWcwN9jmB
	u4xIMQRi8HsobQWfkM/qAAwvaM6O2b8JkscUxVV+CA==
X-ME-Sender: <xms:6roXZkkxI5th3C8gPMbFVYi3wJlgxoTiOb8Xp8locRdzWVuhTx1tnA>
    <xme:6roXZj2uhbFaw4RcCmlPyc7JAYEiK6b7Vprv5fvXhNmTAU-O6bN0swme2FxT-HGBH
    uHKaeok6HJPdM_m6w>
X-ME-Received: <xmr:6roXZipWEi7jdkUeGYoIAHprVnjHpqLnMIjJFThbPLMQVUGPvyg-e3nufewJcTfGDdz-h2u8ig6Z5h8zxtmPnqhl9kPFRuZWCkOHqXL2_XYOG1Pl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:6roXZgnY0zaKGFqJFDFEfawadblv9_Gw3HvL1Wkez3kX2tMWn9rttw>
    <xmx:6roXZi3W2t4pybbED33pXRDzVGEQd2k44BkVuHf74jCRhQqBxmN-3w>
    <xmx:6roXZns7_Hd0wSQDw3HU4rqlWxxlPgfspJgWWvbp0D07041479ao_A>
    <xmx:6roXZuVm16X6SHuxS-jdZ-Mkn9uCTZIscNTmpw6OMEgBC3R-XfOxBw>
    <xmx:6roXZrlBW-RnS6ITn_KLYbz8SHSig-Ic03mtXPIvmOdvE23PLwzYd9-m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 06:26:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fc8c5677 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Apr 2024 10:26:34 +0000 (UTC)
Date: Thu, 11 Apr 2024 12:26:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 07/13] ci: fix setup of custom path for GitLab CI
Message-ID: <Zhe642d8hMr63H76@tanuki>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712825204.git.ps@pks.im>
 <ef61b578da84dbd8087bf22c43029acf6983e547.1712825204.git.ps@pks.im>
 <CAPig+cR19_xdKx84xQ+7c4Cp6GzeOeHSit7-ujJJQ6gE=q+f_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yIdTiHqa1ngv7IXl"
Content-Disposition: inline
In-Reply-To: <CAPig+cR19_xdKx84xQ+7c4Cp6GzeOeHSit7-ujJJQ6gE=q+f_w@mail.gmail.com>


--yIdTiHqa1ngv7IXl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 06:06:05AM -0400, Eric Sunshine wrote:
> On Thu, Apr 11, 2024 at 5:10=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> > Part of "install-dependencies.sh" is to install some binaries required
> > for tests into a custom directory that gets added to the PATH. This
> > directory is located at "$HOME/path" and thus depends on the current
> > user that the script executes as.
> >
> > This creates problems for GitLab CI, which installs dependencies as the
> > root user, but runs tests as a separate, unprivileged user. As their
> > respective home directories are different, we will end up using two
> > different custom path directories. Consequently, the unprivileged user
> > will not be able eto find the binaries that were setu up as root user.
>=20
> s/eto/to/
> s/setu/setup/

Ugh. Well, to my excuse, my keyboard is a bit wonky recently.

> > Fix this issue by allowing CI to override the custom path, which allows
> > GitLab to set up a constant value that isn't derived from "$HOME".
> > ---
>=20
> Missing sign-off.

Indeed. Sorry, I'm somewhat distracted today.

Patrick

--yIdTiHqa1ngv7IXl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYXuuMACgkQVbJhu7ck
PpSc3hAAl0UuU6x7yFiqWJOo4Nv1xhspMZyF591SLzfYWw3+4FvMnY+847iIEJz7
NMHvKLhS1nin1Aw1GoEcVr2x0+lmcW3Y1UQ2+RDXZ1YOegX2xI5eUltB6QTekb9H
e1oWxfRVyYyaTKM0J6YPG8Z9gZtP0fli27JH+kdvnsmDF/NXiFceugYjL9xz81wG
zG5B9PzXGEk+9unFWHf/tgq1jET/EUdQXmNfFEl1exCIpsrwCWrQFBAwQkn8KMxO
6HQbxnt6w8nN+EWhzn0lXylvvi9LWvne9+lrna60VzMdMryaL6I9NaQ4/kfnGxJp
QNXxlKGAUr9DVnQfMOW5rXgAS7LZAIG/dx/eVl+n6y8Jo/vJeu4IiwXDjKOwFt0Z
dMYin8m1mayBcDV1nGD6WnEN0RP8A4LzP2qmaOlgic1P2727vbqejRunmwz/34BK
Z6VDEAaBgfn6SROt8itblkIgov9XI201Bur9tfdUynlDJaMTalfxzjFYUpwknIEn
MCRr8UfDuSWOSydWiFQKM4rB2xr162rrUKNrWVzkqhyxChmQMojMvCyGtgTHCXYs
ytLcEiq6MJbp/FTV0wFLsmrcJZKNKOd88mJTfTMBU/8/BoHeygc8yfbClTUA/kIi
5f0pPPU3J48JTsoTkzi8PwbQamtMPWNGubR2WUBdFVjREXQZOmk=
=imc8
-----END PGP SIGNATURE-----

--yIdTiHqa1ngv7IXl--
