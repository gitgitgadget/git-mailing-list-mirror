Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670FDC148
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 06:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707115637; cv=none; b=OK7XeD6+bEAkL9Onb7qjTRmx+akhK9YUk4peeak/rM1IyyXOVepogsMH/crX2SfVRA4mm2MSmxqbkJiwiFLcujbv18azcezYKnVv06gY2WT2VtmykqyguKnJqcAHzi7vX7b0C6rTVYh+b6bHOGR/A3F4RgAjyrm0k1Gtf+VOmuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707115637; c=relaxed/simple;
	bh=ac63gte2fDiauO6aSB70P7LEtcX72XQXGwQlrdBH4IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feTtYPP87R4iqoeoHM6iVysLme3I0n8SsoKlhY9/svrH3EtMTaAF8DCVMxzS8zu5s7U64f4u27+UqrD2BlVy781ijo2vX57Ziu+4NiiV8cMmneogOm6W6sVLATxLMmYp563gGzGK3Unftw2D7fLGNi9EN1inJOeQzEt+eWJFVn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NezXRM9C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nZu0xLSz; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NezXRM9C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nZu0xLSz"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 399AF180006E;
	Mon,  5 Feb 2024 01:47:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 05 Feb 2024 01:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707115633; x=1707202033; bh=ac63gte2fD
	iauO6aSB70P7LEtcX72XQXGwQlrdBH4IQ=; b=NezXRM9CN5caaWJjFdpvUgYlVK
	XBz1zNo1QlJaqDKGg+RdWMbsme19isSH4CpUD2ldD1i/c3sf/2o3GxdxAjWlcaVR
	5XjeiMqOZ0dM3cMoHqO8p15kTJT8Lig9nyjczZKMerKh1rPbO4SmDoRD5p+Q/WOa
	1kf5dPhGxZ990gEz8r5mBz64pQfgG9pSANmxym2EQ8eq8WTiWMDXJVtkv/Y4ptYE
	tT4ZP36SDPtk33lEWUFATPSKoJ75ZS1N3KWDwKR8tUhiLY7i+Ilga7Dq2ez5Qesq
	JDj0LXGHDOQWj4KnkU/xE8pOV/LFmYmvotB1+p6dumGelf80kuHa9fop2LqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707115633; x=1707202033; bh=ac63gte2fDiauO6aSB70P7LEtcX7
	2XQXGwQlrdBH4IQ=; b=nZu0xLSzhkyZP7UBVtQCqZgtuCP5PoYdxoTVTxOvCGA+
	OLETFOH40nwNshnDY8r5+phHQ7SfRDF4lHx2C5wAR4l7IYubzd0oD87boAbQxmI2
	W8sODV9JOe8GGVomnVr7pFc7H+MQ7CPChyh0KJDFnTUO2/MzByH5HxDZ6WWx7eWW
	JwPmrIHkhNU11/72AH9RDoGJHLqHLTCIWI8r4yLvQ9Fzl1q24HkygMcCjFRXZa1/
	9Q2xzgsXnOXKAvGtPTzGe7l8Jt+MqrKxpQillOWL5KVmKmGfnRwIJ0nkio0oT1Q/
	C2qS7dDo3YQHrsKgQ9ungfsfIfQdKUbbLaNYnVmJmw==
X-ME-Sender: <xms:cYTAZcZnQ0g2XUgdJKgjsZ7hdzsY-HNGVrm6XVo0ECZZH1A3vPhZ7Q>
    <xme:cYTAZXYvbfo1ZLQJiUbDm615aIBhxpbybvXlVhxhbPdmZHrDSN61DAog0w-H9eIwQ
    -YZbGUay9o7FDrWFg>
X-ME-Received: <xmr:cYTAZW-RScWRKCFoKn9AhwcnEJm7PVS5WzyE_yObgCeWyMKJ9wucep3mDPoGFtk2CQEvz-RWbMZDQZxNlHwSObiOod16MIQGWUQvkmghh8MlR1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduledguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:cYTAZWoSNLKf6Mz8IvQC_Wu_KTsBBtQYxYFVX5I0KZ6SqXkIeke0-g>
    <xmx:cYTAZXrXssptXmPknHD4fzKEq_V2Nb3wsQCUOCHOAQ2TFk-FMCsbOQ>
    <xmx:cYTAZUT3G-0mmuM4k-uOCVUc6-qLln8UY04eD9SQzFf0zNEnHX0PoQ>
    <xmx:cYTAZe2ZT9xi2oPRUzeeyrrrpn_Job6wpS-gmTMwBjic8AI-xyvbgvy1nn0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Feb 2024 01:47:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 600fdf3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Feb 2024 06:43:43 +0000 (UTC)
Date: Mon, 5 Feb 2024 07:47:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: moti sd <motisd8@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git bug
Message-ID: <ZcCEbaId0HL4Briz@tanuki>
References: <CAPvDF0P7_s-iy_V7FNSHtXXc9v5E3Fm=AdgduDDsd0rM-zNg-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3n1ALN441OZUC0Ft"
Content-Disposition: inline
In-Reply-To: <CAPvDF0P7_s-iy_V7FNSHtXXc9v5E3Fm=AdgduDDsd0rM-zNg-g@mail.gmail.com>


--3n1ALN441OZUC0Ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 12:42:03AM +0100, moti sd wrote:
> Dear Git Team,
>=20
> I am writing to report a potential bug encountered while using the "git
> stash" command. The issue was observed during a troubleshooting. Please
> find the details below:
>=20
> *Problem Description:*
>=20
> The "git stash" command is not providing any feedback or indication of
> execution, even though modifications are present and the stash operation =
is
> attempted.
> *Steps to Reproduce:*
>=20
> Make modifications to a file.
> Execute "git stash" to stash changes.
> *Expected Behavior:*
>=20
> The "git stash" command should provide feedback on the stash operation,
> confirming whether it was successful or if there were any errors.
> *Additional Information:*
> The issue was initially observed when executing "git commit -a --amend" a=
nd
> pressing Ctrl+Z to exit. Subsequent attempts to use "git stash" resulted =
in
> an error.
> Testing with a provided ZIP file containing a problematic repository
> confirmed the issue's recurrence.
> *Investigation and Findings:*
>=20
> Upon investigation, it was discovered that the use of Ctrl+Z after "git
> commit -a --amend" might be the root cause.
> Deleting a lock file left behind by the incomplete git command resolved t=
he
> issue, indicating a potential bug in how "git stash" handles incomplete
> commands.
> *Recommendation:*

This is indeed it. The problem is that the index will be locked while
git-commit(1) is active, and thus git-stash(1) cannot write to it at the
same time. So this is working as designed. What's not though is the fact
that we don't print an error message.

I'll send a patch in reply to this message to fix this bug. Thanks for
your report!

Patrick

--3n1ALN441OZUC0Ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXAhGwACgkQVbJhu7ck
PpQ8bw//bGpzKkjlGfhT/kaShzb2ct9+N9Tq29b8J4NgCu7smx2uP73vJk3R7uFd
84h+fjozRRxXTiWFOHzrx+8ZU8bnhC+fDXzL3jjbXGYEXDkAMkxF1UXpHc8KEBNo
AmXTtXg9HgNlQ5nBuzWd1JEwPHZ0drUQ797b3EsVXrwfMeODgxXkwH6k7EaUEeUu
tQhCrPZw/YcsmMYhkeWN++7t8OuUnxUuD5qQqXXlKngCihaGxO3FV2Hhsy6+wSsy
YTInexQDKw3HkfqibZZlt9E0hX/uJzGVMav63zPl4SPiCMS4Ds6ns3FJmnzrE+yk
H2zwcLtAQr3NQbcQI+W5k588NcwGjs22yuqKP0bq+PlzASg5zXcQ5UK7LHFS/GN0
z0vNHwXu1G4Vp21+l9mp93DjEe9moRUCzDEHxXpV1Z9zNxdp+4f/+33uh8cF3tYN
1OEekBjl1IR+gvf10jTLWt9wFGLC00hWrHg3zH2VJkrTko9hP8ZGi5CnN33P1Urx
Kh3DfkQComAb2cCDO2dCYgKuJTi+QdxiRLSylBtLqiwhL7tjULYdpsB89rCbll55
x89rdPCOy4BGdJjSyBKmzgyddKEzES2cT1YOCDkZCFN6uwI0fok3u0MObMHZuPll
9VekNvo8CmLCVkdvEqX0NYXYvKDbfhfvCzhq5rwGqf+E6ZLk2l8=
=E3er
-----END PGP SIGNATURE-----

--3n1ALN441OZUC0Ft--
