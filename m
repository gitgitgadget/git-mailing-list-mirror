Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AE025763
	for <git@vger.kernel.org>; Thu, 30 May 2024 04:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717043766; cv=none; b=DQ+WkSm/HcHd/ZkkuAkvKJvqBAAVsM7Tq3YdAtU83KINdUtGqoyCxoN8rw0JC4sT/mQ7pT2pRDFHElKRKycNhSlm1WczQuZTrgRfKZWj4Tp9Xcbl7UAMV6dSFsLmPRtvy4n/+NKquINy9sZUM9nmagexgUOrItRD/AKGCTPa9r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717043766; c=relaxed/simple;
	bh=cKZ8V3lLRqaSXJwnGKVHE5uqtsgQz/rAg25ZcYZDnS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rluFMrQVVDWUDba5zUACDQM1SNO2x2kG1Fik8AkoP8WdD7ktMhgpAICxAWP5cz3COwHAJKP/l3uTW1FBDVIHvWLoogV6MAlQaSXdalGzAPQxXLEA+nVZapq3VFMDoAywwQTAY+cFTjnv5I54gccDCtNMpKzZXS9QlwxuS8xHS7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S0I4gh9J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bmMhnsS6; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S0I4gh9J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bmMhnsS6"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 525161C00111;
	Thu, 30 May 2024 00:36:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 30 May 2024 00:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717043759; x=1717130159; bh=cKZ8V3lLRq
	aSXJwnGKVHE5uqtsgQz/rAg25ZcYZDnS8=; b=S0I4gh9Jgc38E+T9G0HEfr1Rkc
	ia7SPchatxZXMr5eZkZmWWteTMJcPU+cqRnRk6rJmlMFspM/pzbd7fn3EJV+jzQN
	mleSc5GYoJknWu0+MD3CBb+963qJnIyKoSC0W/Y7bToeNfkEbUWqpd5ODhIxnqF/
	5epyd+YiA7rtSUsUe1Giegxc6OC6NpfyVSj/hPa9KMAit9Djop7JFGpKDlgQxIxP
	ebQefGXisrzzI8bEb/FhfSmLQ2653BYr7mbbfvROn/eZDuG+EC+Pq0pKaRGrveJ/
	8KHjNIC0/AmmytX2LaYYpagDmvbum9EXnDTA27qzYrrvYpp4qDlHPiWtigiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717043759; x=1717130159; bh=cKZ8V3lLRqaSXJwnGKVHE5uqtsgQ
	z/rAg25ZcYZDnS8=; b=bmMhnsS67wEb7s7lI2DT6aA8YWGRlMHBgBBIDLc2wrRE
	pE5joOtJ9JyO5uECtNyKIatyZsNJyIdKlLtkcV2uHZ0iEvAdMVrKwe0D/vJi+Xcm
	rU+RYuckdU2CicfgaPDK9SfykKb3JW6mgkUsmKd9dkCxQX5p+Ke2/DMyCxIQ2ROW
	oM/8JTtciG82koO6Mfb4Gv26AfYITc9JkWGYPJ/qXWMyY3awj4Q5Tx3KiJ+AmWbL
	MH9KOUsTDptUTJJQ4j9hNIwUNRbqdUGhdvr4n/owkjmanSr1n5CZXjzJso3s6Qi3
	GqIZU9iZgpGHqIlLYRSoofEqykl7zLpxBHFul5N08w==
X-ME-Sender: <xms:LwJYZjO8Cmd9JNd_HL4oirHc2_vqXdlPLyu5yu7Aw3rxFQX4HAFM1Q>
    <xme:LwJYZt8PooU9FQAWR-bUDTTfmQXgHgzcrgrXmCobas3SruG0nUAidc_rlJ2jPBk2Y
    kDDiCdB0-CwbBYflg>
X-ME-Received: <xmr:LwJYZiR0N3taB_6RZhvPHcXrCI5vq4W7jGRnet3vOf3vm02WYdtTZ6_aLz_VEHiM6_EeZpbf6czF-ysvSpprBTZZPH5sCr3zUL4pBfv9CwdOQm7rng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekfedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:LwJYZns3CNfa7UDOtEkX0P05Umuh7wdOFKuf8cOOvHiQmoHTqvP-dw>
    <xmx:LwJYZrfl__sGWzHcAxlaQ520X-kDCp9kbUe5Ixyy_VTjgslveveBNg>
    <xmx:LwJYZj3V8Ss2m7cq9q5r8JNmtCTwBOdLOmceyzYKgPlXIaHkrHjUfQ>
    <xmx:LwJYZn8qZuiakSuLynqzHCqoNW-NItzcJRbx8gzm-ccK4ayph6l7Sg>
    <xmx:LwJYZn7FFngHr21Rv2aZZ6ZppaZ8eoCEl-lm6at6Guev1lwNe127OXiy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 00:35:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bc0d18a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 04:35:40 +0000 (UTC)
Date: Thu, 30 May 2024 06:35:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v3 0/4] t: port reftable/basics_test.c to the unit
 testing
Message-ID: <ZlgCKsawq54QNe6h@tanuki>
References: <20240529070341.4248-1-chandrapratap3519@gmail.com>
 <20240529171439.18271-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yxj/6urM/Z3lj8pY"
Content-Disposition: inline
In-Reply-To: <20240529171439.18271-1-chandrapratap3519@gmail.com>


--yxj/6urM/Z3lj8pY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 10:29:26PM +0530, Chandra Pratap wrote:
> In the recent codebase update (commit 8bf6fbd, 2023-12-09), a new unit
> testing framework written entirely in C was introduced to the Git project
> aimed at simplifying testing and reducing test run times.
> Currently, tests for the reftable refs-backend are performed by a custom
> testing framework defined by reftable/test_framework.{c, h}. Port
> reftable/basics_test.c to the unit testing framework and improve upon
> the ported test.
>=20
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

This version looks good to me, thanks!

Patrick

--yxj/6urM/Z3lj8pY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYAiUACgkQVbJhu7ck
PpT21w/+IFyNfF32fIjpNsajfAVQzSbMVUxkh5s0BAUICZIAYerd6ASYSpmcEaNS
prTICVeImxGyynhGFLM6C43oQpLRr+YPujrQDqKPhwKVc6V/mgfnpiFrHz3EeiMm
edeLas7a1VdYKsGi/++J2tny5IoirsPr1en3jRtVOmcBM4H/4BANB+HgrkJtYkRN
VV8jE3/uCgi6G3NquV2WrStpvEAGH3uxLs/aJCTACDwERGmFYG77/s4aCAAi/eTD
oYwRoQQ5OnVnZ2gBp5PuWbljlf7HB4pvpkHYip0tpy5EXhiFTKTkyXPSe4r8x7mK
asqemp/dSBe2InIZLffGSjaPPYIh/FOaEpBC+myVvdVkgfpTR7yboC1hH+owgx9C
lLoM+XYA456S5nETHWRIjjGcp2UjTgfr9Teyb1Oao6U6YAYE5ymcXpw0WmsVEEFn
rL6Ghl1CGRjqwVH/WI9JC8mlip9frKKap5y/Ne+dmHSvImxJC/14rUMNHZZuPyKZ
N6T5vubxmgJmQThf09zK/nB5BFh4Cx/Mqh7neMnEQJj0k8+Ki5Vxxv7n3UHoPYMv
1rt8CBc7a7qRyuJAbwHtZs/qcO8M4vjt4X2YvgjX10pISgUd4QeUG/+RtDNN8vdQ
mDuzoK1ywoLsUl9hqMb2I+A2l2ZeejIHzhcvhrE7qEG3OAEfOoo=
=11jG
-----END PGP SIGNATURE-----

--yxj/6urM/Z3lj8pY--
