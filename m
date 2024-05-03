Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0F25103C
	for <git@vger.kernel.org>; Fri,  3 May 2024 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714762092; cv=none; b=ZLzHVx9igpNFJNlqRF+AebcEbH9mvV6L3NzX94fKFkcBjZcqv42uu5t+Q/sA3eVWfjzYrBoXdMnXtyRpov+1M2BvzwvfwBAekEXpWgxz5BRx2OgeO/3XjwKkrNkTeeGwb8HmFlX1qEg1ct/vgIJEPrc+IluILXwAgvf5v8CdVRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714762092; c=relaxed/simple;
	bh=CDlr9CVTrdnJVxKuJ59f88T2VAd+Pk831IYdtHK5s1M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxNbIie2f2b0NnVolVGUW/fmClU1nd7pUud5fv9PKlx4/pXkmXIz4EjhKhLTZL6UT2k5xE/EqCOWucwhS/2dhpgWerDXG5LxICgaxwLOhgGRPNkKywuH5kj8qLG249pZ7t83eCxpRW6/iVy3eO0SrDDj+YjIFq4azVrQ1vMIm4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KjhJmhcc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oui8UQf6; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KjhJmhcc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oui8UQf6"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6CF691800106;
	Fri,  3 May 2024 14:48:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 03 May 2024 14:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714762089; x=1714848489; bh=CDlr9CVTrd
	nJVxKuJ59f88T2VAd+Pk831IYdtHK5s1M=; b=KjhJmhccRGwgumiqiN6fIt8gng
	6vQ+CtJqmJmXbdvgxfsKJqiDssroXFKNCApYiBKJId5+f9CvdWemU74V2edvgkhl
	EfLA9V9D0ZgmvrWkwZxs86r1VxUEzjns6rcAzsQFqhAa3kK+ZIVkewQ86hYnEOcD
	N86jYVputps+ePw0yS03oZWFCXvatVyNhXe5rBFf3ocZY1LvH8mWllvoLIxBqYTW
	5z9Djygd/e/T5THzsXv04pPz53zdk5Suz0+Img6fvw6Tm3x2Y47fs0q+L+rvcyVY
	SmzXjWhiIyWQ2m9DP2uHQDb5XyeTF5iwq4pVc97e5MpeP9KFfrLqIXT+4PPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714762089; x=1714848489; bh=CDlr9CVTrdnJVxKuJ59f88T2VAd+
	Pk831IYdtHK5s1M=; b=Oui8UQf6VEOOFlG5Xp8MdCzujhGFl0M0uiqWCpoc6bMO
	gaFpVDxWRdhDlBCoWvT3XBDwe0Suym+/vMzHjYwLb1rBr//H+pPd0kJnHwpW2/Rs
	kyMonMAUMVmhjiAfNI9q5nEM9iWE7yBdbC6Y3DOj6BJ3MuuGsOx55knUedWuKvjl
	DedjYqbAUif45VsRiEndaKD63gDaH0SfZyEAjh4fBDD8RfGpqNuV6M2TDtdwCBps
	PSVobQr1uC3VRx4uRy17DnZSUxhWQaX+DWtVGISqE1yfZ7X2R+Uc+/GhhzfWEJvA
	AF7xcmazM4I301dNSx1pjCUd7fhpTzuCmk99cImtlg==
X-ME-Sender: <xms:aDE1Zp2QQ9yHn555ArVxWBfP4Th8MbJN2brIbt_ZETuBT2TSnAVDVQ>
    <xme:aDE1ZgG9YzsAjXeWw7Qo9yyAnew2Ry43wtLOHxMaTDjPeUJoYHno0AchC5qkYMS8y
    N0wZJSOtLoGxjI3JQ>
X-ME-Received: <xmr:aDE1Zp63kvfKdhABXBuGf7G2ubOGGGiMSRScHNLdKDXOZm6ALnP7ThfwWgPz9kdXPQnwnqIYqVEY1IVZW9nYvliyomXgrV88ml7stXuJccNp2kkE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepjeejtdeigfegkefgjeehveevjeejveeuvddtieekffevleeglefhgffgjeejfeef
    necuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:aDE1Zm2O-8gnDKSAiRenCyYjddvBtPdv71Q282P1F0cU_XN_7epPog>
    <xmx:aDE1ZsFW0aNrsPqSQvI9bkofYTnC740NhvasnW8B7K0tMBD24Rppaw>
    <xmx:aDE1Zn_y5az4tOOOdHzNXn0af21pUQG8leR72zg12exbGy6OWu0Z2Q>
    <xmx:aDE1Zpnrd1cLxpBUwOYR8SH9IszrouuLADJlLsFhrvq7GDqnmBQ0MA>
    <xmx:aTE1Zh5X2oZHFCck3JAVRECsl44hneuQxcoA2CUgkf_fmAsYJFoJQX_G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 14:48:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 51596c41 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 May 2024 18:47:37 +0000 (UTC)
Date: Fri, 3 May 2024 20:48:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v4 00/13] t: exercise Git/JGit reftable compatibility
Message-ID: <ZjUxY7kqgy-iLIzG@ncase>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712896868.git.ps@pks.im>
 <x7v4d4siixs3wllzycibxtgsqipnwohhyxg72zvcxboucshd2t@won3yobvixbu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vEXnl14MGDIi3zd4"
Content-Disposition: inline
In-Reply-To: <x7v4d4siixs3wllzycibxtgsqipnwohhyxg72zvcxboucshd2t@won3yobvixbu>


--vEXnl14MGDIi3zd4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 01:42:32PM -0500, Justin Tobler wrote:
> On 24/04/12 06:43AM, Patrick Steinhardt wrote:
> > Hi,
> >=20
> > here's the (hopefully last) version of my patch series that introduces
> > Git/JGit compatibility tests for the reftable format. Only a single
> > commit changed, where I fixed two typos and added a missing signoff.
>=20
> With 35e293e6 (Merge branch 'ps/ci-test-with-jgit' into next,
> 2024-05-01), I've noticed that a subset of the `test:linux` GitLab CI
> jobs have started failing on next.
>=20
> https://gitlab.com/gitlab-org/git/-/pipelines/1277877090
>=20
> I'll take a look.

Are you sure it's related to this merge? All failures are on
"ubuntu:latest", and the complaints are about the "python2" package
being missing. Given the recent release of Ubuntu 24.04, maybe the root
cause is that "python2" does not exist there anymore?

Patrick

--vEXnl14MGDIi3zd4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY1MWMACgkQVbJhu7ck
PpRwRw//ZmPgSfUNb5qe8OeOHc98p+eRg91rUHtgpYBwgA8byigbXB1XF48Y5pUk
o/jM6KtQTRVRNOhM/sfhYlGd2NEE7h1IO2gsnOYOWiNu0Lm3khkQ8sdDl8uH7XHQ
Na8chpA9Q5UQlfxT29IpFi7bNRkG3omBpMwO6zceJUvSiAM/Ivu2kpL14/Z+hr0w
il7sa22bbdSOsNFk0C8N4IN88fjIfqOqRAHWwjJwwFunJOL2f+c8jIdRFjmnm7Ia
S+4DP1klc/+/N9q9s3zk5+gGSJwyayXLoWx6i6p6biogj9Gmx1LIAz3Su4pPJv2c
MC/zBS0LLsMQrqYbFMEHMHNlvMVbwVXuSh0mD7A+6RoW5QEXkWQ8uAs06JSj5tuC
fnlKQ4kNitoy808k3tICioe0ZSFWs0qoC0pq0+SY5Y8vzfNU858FNPzXRZvkswEB
LCY5DCeh3fKJDOsNNqCqAUgvCBSZ5x5Oo2v1bttVZ82n/axic/XGuFXrS6VWHA+h
smTWj0hyjRxrvgDQrQrv9asILr4lRt9Tr1DgWVJxoOsI/JHnjV9WK/AD0urBm7ac
+Uvw3HSrSaGQ/bbrKY9qeYOqhaaCu7mW7dvDR9Q/q+RRRQ5uSp6S3y71kWJK+rnb
INQta2NVZlPBdvxDPlYkUSXoCuuudBY85fLinao7aa36OHMZ5iY=
=DT6C
-----END PGP SIGNATURE-----

--vEXnl14MGDIi3zd4--
