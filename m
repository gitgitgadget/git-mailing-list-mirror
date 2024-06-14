Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A24E1474C4
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347371; cv=none; b=O70JwaFSJrqOAKAdOWQgBFWz6ts5ZgFEIE9gYRxAVajNKZWOj87HAl8Pte6hWzfprzqGlQMyO8rwpVkrUdFkF+Cno5dBGjKIWcpmQBG4FtYqnlfkhVNBbG/rSpAfc2IF4mcr3dm4svPu0hHgk2enMRNyKGBuDIbYMembBFSz9YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347371; c=relaxed/simple;
	bh=x9ROFbzDXc1cZlx2TNR80vtJOy2nxHb/Bhm+XDR+voo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xq58aKumUMq4+5p3ZUZU6bWtsKBzZRD7gDACfzGqCVwU6A64QdNKhKXfGAJnayShARZFdhkydVqjn2cBWgII3bMSzMDz5eRx4b0lcMFI2FR9IyE8wdD/x1vw+v8HywVZdb4GNP4MGvAWKFNIjAf3Fdwso7siCs9azxZLZ7G2PzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M2I6VJK1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gr9oT5kI; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M2I6VJK1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gr9oT5kI"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6EB821140107;
	Fri, 14 Jun 2024 02:42:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 14 Jun 2024 02:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347368; x=1718433768; bh=3dXeY6mywi
	idKtz+qRQW4Vbi8kalkIpabji1dfEyP6g=; b=M2I6VJK1ZT/xALWbgZzOpR88Xl
	o7TmVY1CLc09taaClMrodRqqG5s6iaqe1HB5tZle4/kdepoLA53OINJCTgdONmfD
	BLqABu0nzrIaCHf1o15XFzNa+DMHQqLoT4fY+XbGpXxAhzUXAZPKNgN78y/y8Jrz
	UpYM6aIE+PQHfrjufN8Qkq8UIV/lC0yesJmRX/Nc9X6dXuLHBIsIh3BmOyFiEqz8
	ndv4gZs/kCAAoiWrllOfrRoc2pH6IAzSAjSF58DEPDMo6DFi6mkp/q8h8IQ61yK3
	fsyIXVAQdwqGZHJHpLecQMllne9vm0nIk1TIc3g+x8wqzvgiz46QGxCM/DiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347368; x=1718433768; bh=3dXeY6mywiidKtz+qRQW4Vbi8kal
	kIpabji1dfEyP6g=; b=gr9oT5kIVAs0UPpqrVTmWOjFJUlT0SCa7M4wioOV5lyz
	AKuBIqbGFXWdGvTpKGBU59f8yO7RveSE4zD4ecRR/euv8StrklkjtzNKE8cCLrDO
	RsEe2X9kRWCwmx3cwHN7POZav4KDd27MHJRYEOR0BwNS6OLJFd1Kjmu1zTWHokLQ
	E6xVdVf9TkyI1sm44BfPfKVyrSTQZe5Dy6rYPXq6MYdDbbS59wn6H0yRMp427njs
	2SWcqSaPjg719MuGxbcaOw1xyRKTpd+PlIzuovTLU0UZC3mdvgJKeoLPCImwBiLs
	dHtM5pPYUxvfQgMQV2eAJb1tvN++ky4FiO+MV7VR7g==
X-ME-Sender: <xms:aOZrZvr1lBGLePYJEcD7a_fjfW4LxVdk6TgeKK-cgTRQBd8HzGA-4g>
    <xme:aOZrZppz2SdI1fER14tIHpFurk4lyaHhUIka22WVLDCwIsAAsDzOEmZ--WLtUnBDG
    gH1tH9JHPEugTP6sA>
X-ME-Received: <xmr:aOZrZsPsymrnpCkT9-5y5JBuBKZi16oHEF_3M1JUm55c_hASaZSrvj-1wyI6svQhuljM_SBHolKlh9hD04OI2FudkyQu6wKrol3iGKDhImxv2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:aOZrZi5txWu1-vED61X-IJkeEuabOSjEV7-p75GX-z4nOeWcycBJCg>
    <xmx:aOZrZu6U0gm7kbf4L3XrRiq5CPTNJBBiN1bki7yFLaSTunk8GEIGdA>
    <xmx:aOZrZqjZxZCy3fg0jsfJ878OixRrqhoJdEU6uuH5mOFlUx1OWhCWWQ>
    <xmx:aOZrZg4uSC-0UvbyT9TATJXQtUfML4e2s8cHzca5imQ1R4mXbgdrzg>
    <xmx:aOZrZguMalPqKu-FCoXLLUHfDu6qJRr4GCnWXl1TZpjF807qwYT4AgBW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:42:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f632ce35 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:42:31 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:42:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v7 3/4] BreakingChanges: document removal of grafting
Message-ID: <deee0bbf667892141b2c79567d946521517fe943.1718345026.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1718345026.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HGcDKk5CMPC2cZO5"
Content-Disposition: inline
In-Reply-To: <cover.1718345026.git.ps@pks.im>


--HGcDKk5CMPC2cZO5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The grafting mechanism for objects has been deprecated in e650d0643b
(docs: mark info/grafts as outdated, 2014-03-05), which is more than a
decade ago. The mechanism can lead to hard-to-debug issues and has a
superior replacement with replace refs.

Follow through with the deprecation and mark grafts for removal in Git
3.0.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/BreakingChanges.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChan=
ges.txt
index 68ad42d805..62695ec2e1 100644
--- a/Documentation/BreakingChanges.txt
+++ b/Documentation/BreakingChanges.txt
@@ -102,6 +102,19 @@ Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
=20
 =3D=3D=3D Removals
=20
+* Support for grafting commits has long been superseded by git-replace(1).
+  Grafts are inferior to replacement refs:
++
+  ** Grafts are a local-only mechanism and cannot be shared across
+     repositories.
+  ** Grafts can lead to hard-to-diagnose problems when transferring objects
+     between repositories.
++
+The grafting mechanism has been marked as outdated since e650d0643b (docs:=
 mark
+info/grafts as outdated, 2014-03-05) and will be removed.
++
+Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
+
 =3D=3D Superseded features that will not be deprecated
=20
 Some features have gained newer replacements that aim to improve the desig=
n in
--=20
2.45.2.457.g8d94cfb545.dirty


--HGcDKk5CMPC2cZO5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr5mMACgkQVbJhu7ck
PpReiA//Yw20RXbjhFg5VoIAlIr8pcOcNEjvoNb7SwJ54S1q2PUSTiyYXH3LymrK
G5W5KAPRni+mKliOKEavuXj19nEc792zw/dj2zgfCGrVMeaEpAxv1hs/4CVQdMAn
6qWegHC9fidv2L8F50esDKk2MeZJSNLoHv6bO2h4pPd7jMiwttOEQT43BuOx92xk
ozwpTsvUFWc8SpJ0t0IrXS0H07/Y4718+/nDsfEBOTtKFT1mPesRVsMup3YjSvhK
IgpKYSODF4mU5Nd4W1UuBvCC5Gfoi7ckNlMqDWrULm9QkDyl0pWDEo8B47s1PbqT
ScPTEZDtJ8tK1BwDz4DaZ4El974ZFJVOLs3ud0EXhd0w9SaGPfHOmayccArOMIpq
8AxaB2Ka85TE3OM2L1bycNT/bSBueDfqchlvU2GXOrPU3PG1r54eOzztMjZaGywx
/gtKY9xQ6ZRaGVhsb9kKFI1JN+eBeYY9eCBif1UmTH+4v59jn6HV66N8VAGd0lz1
MbwZVIP+ATDjWNeIZzJIvT6fqLxGdaSmyBa58Vh20NPQQ6FthnvFNqzBTf+OJba2
nTTC3tBGC2HwYdI9L+UMhn/04myROtTAL3toBaydH4v+REAwQuWhe0sW96YYIkmp
iozxamNFFx3eeNLM8EtTmvaukoeQA/v+xMhJe3/vQiCoUK/Gvu4=
=rkZ+
-----END PGP SIGNATURE-----

--HGcDKk5CMPC2cZO5--
