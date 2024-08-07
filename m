Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C4413A3F0
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723036707; cv=none; b=KGESLG/OLKAY3kUYz5cxYs/Z+s7DSjwPxmvd6qQ2n8xXqq5Q9kZ+vSkxVm07/xdOsr1Q+1KEAvHX/jCmi7tYcw4UhhoYMci9yvDEh+5Qm+cxeyTjxcS7jIsyex4FpS+zqQDPRSRN6CSHA4T3gV9Lg3GZpawPCVODimwH9BnfWXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723036707; c=relaxed/simple;
	bh=XG+VFwpd83BqHpN7v0XxBWvlssER8auzv8hxz33tObM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/AhfsJKZNJH0y6sggy/PDsYJj7rPyp8IgBqHfMiTZvFgK/OEhNJBGroUYNts2Ncl8THwxIxLs15jqTN4H8t6fxfF5K+Q0YR0epkJ3k3Tv+dfIjCPDBsMP/gXeCxf1w4SJZBOnNaKV2c8HXK4+QY2RQOVKZtGmTu/sx7MWPZPxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jgx6+rUZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LlRDEC8X; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jgx6+rUZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LlRDEC8X"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id C2DF8138FB4D;
	Wed,  7 Aug 2024 09:18:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 07 Aug 2024 09:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723036704; x=1723123104; bh=WXM+6iMiBC
	/bOWdCSDYq80sbcddNt473oqSTki5QEQg=; b=jgx6+rUZKPK1rqbSwnfVsZYYSt
	QaXdObh+DAwrktc/xI/KXOr7riR3xjC68/mWuIoGFMAUDVyIWOTAMXH0m7lyieSs
	L7zjb08Yd4t037pwutZrCMpbg10ddPjFiONoBb6S5nTETPIGYttmnpeD+bgDTXtw
	hkLrCPppvogmCh7akGwqAd3mBJ12UKGrSYe9rfOFrFDGDv7uSE+pSpwkoB/FmZld
	59a4r+m5HccL6QrE4FlfB476exbuOkecSZSKCZHRuVNWfU7U9BCgLiirObfT1o5/
	Pv/Wn1nDLrkTdFHfYH5l3s0ZuhyL+8AFDX+BuFHCUvw1iVx+Ksensf1liZaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723036704; x=1723123104; bh=WXM+6iMiBC/bOWdCSDYq80sbcddN
	t473oqSTki5QEQg=; b=LlRDEC8XssXKCGR7Ulj6H/b9D4uVMJiC9ue+YjHndxCb
	AbcNnGeOy+Dd5qcl+KWLUB91Mt0crH4bMX837RU+gN9C/mJ6H+34uw5pw7DwSMhJ
	0cXhtdWIhlNXKec0LCjkYXNoQrzdsCBuhgG+gzUajF9q2uG/O3E7fjX3oV0tivvf
	4Bt2jXVzVBlS7Gyu0hpsXsQDasoLsb1oHdxOUMMs/qAQDRNHolQ9qqNUlU1igSLH
	7VRbWs0q88FtdGa1dYKL7sUPqt15t7JCuIkiT4UEbC2kmsU1t0I6K016U3hFHjH0
	+RwfiCmU9u21LCNkFUfe6oOyWK8ohJ/YnxznZSlqGA==
X-ME-Sender: <xms:IHSzZj_4oLL77UaAw3BMOdC5HrHxY2HAp16jBP7Ww3ZgMgLw0LOkzA>
    <xme:IHSzZvtonHGafXs1y1REOrzJYuJGeS21MSrXGEEErhwk0xSiJ2gCaCAQU9OzPq7jX
    4fICxIzdQOowhVK2w>
X-ME-Received: <xmr:IHSzZhCNrk7dExbzIDI-3nKU34giKHcQ9C44NNUtjGto3-spWs85dLkWpQkrlwcBqHIyJmZIGDcVnDdqxd_wKNQaP5jx0x2SMa0wqlP7S0pYKNaX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:IHSzZvfbsYIAX_D8mma_tBzPYX_AAjLH2WhzhPB2S3TrMXC3JzQ1Iw>
    <xmx:IHSzZoNWUqeBMpunZ32YxlQPDy9BLFeO9Veup83AQkdTRsNx1rMb0A>
    <xmx:IHSzZhkkcxPqHqDrc62iVX9kwHySfsiIdLqAvApyzPG2-W0c1CHYkQ>
    <xmx:IHSzZitmHiKoaRduZSdh_S3obNul160ZCWB8a-ySBRkq85mw3K-xiQ>
    <xmx:IHSzZtqTiKkVngvs-MKTbt5agT_mfTPuF7OPUeyvwG-5yR6Y-_YjRNO8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 09:18:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a2ff3e65 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Aug 2024 13:18:18 +0000 (UTC)
Date: Wed, 7 Aug 2024 15:18:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jeppe =?utf-8?B?w5hsYW5k?= <joland@gmail.com>
Subject: Re: [PATCH 0/6] Improvements for ref storage formats with submodules
Message-ID: <ZrN0HNGLtFMhVp-c@tanuki>
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
 <cover.1723032100.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pJb9bv5oKmI7gN7/"
Content-Disposition: inline
In-Reply-To: <cover.1723032100.git.ps@pks.im>


--pJb9bv5oKmI7gN7/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 02:43:44PM +0200, Patrick Steinhardt wrote:
> Hi,
>=20
> this small patch series contains some improvements for ref storage
> formats and their interaction with submodules. Notably:
>=20
>   - Use the correct format for submodules in situations where the parent
>     repository uses a different ref storage format than the submodule.
>=20
>   - Wire up `--ref-format=3D` for git-submodule(1), such that users can
>     explicitly use a different ref format for their submodules.
>=20
>   - Propagate the `--ref-format=3D` flag of git-clone(1) into submodules
>     when using `--recursive`.
>=20
> The first three patches implement improvements for the above three
> issues and introduce tests. The test did hit some memory leaks, which
> get fixed by patches 3 to 6 such that the new test can be marked as leak
> free.

Just got a shower thought that this isn't quite there yet. Most
importantly, I think we should default to the ref storage format of the
parent submodule both when adding submodules and when cloning a
submodule into a preexisting repository.

I'll wait until tomorrow before addressing this though to ideally get
some feedback until then.

Patrick

--pJb9bv5oKmI7gN7/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazdBsACgkQVbJhu7ck
PpT0KA/9EeA7ZOGadrnwYA078s7jE70W4lSFHoNuxU7+C4xT1LqiJto6FExTkMPO
ftJCB24xPmJ1eD7uNwdWT+Hc98URiVG7VKgb+dO06tu2wYieQTAWtfCLUp8UVUsz
XXo771LfluJZV5NZjK8K9Yh8xSBb+ryX61faYGmwUDPZPtL+48xsIHobsez3g96Z
9OS26M9l67EwiEc2xh4shodPjgEzRhOM2GYEN3Zx0hIHmS3DNDY75vUs0siM32ay
jIubja/lSkEyAlVulc0iHcjgpuRVp5YEjkqse1k0vWsolpiafG/+oGH44cSnNY6/
Knjrx0PdewUzNvMzDLXIQfL4dGbwRXc0u9JBz9fhej0px2Mlc8CwWqivcSA3rcBx
jyvQcvgsBNh685JiMMTHvTeDAr1m4uwO5KPdkaaVrkmzHhvTnTvENHcQJfe9lJTO
ny7PQYGQTg8BFgRO7wKV1wGZWHGHhPVwgsiZac6FOLRYv82NaJIdoDdhHPVGIt2K
HGUBYE1xZ4eCNS/ZImionImGd6RDohdTiBMleSwM2on2lsV1/a7ny70P6C7/U8Kx
8nLAg0rZCo4K9Y2U9j12cKB9Na8hbjQHLnoDfUl7dAYLIexpavmF+3noD64Ms9CN
JgH056qJSvewgPkGMWpB7/cq61S+DpIgt8l1ITRX/2qXA3aAMX8=
=621C
-----END PGP SIGNATURE-----

--pJb9bv5oKmI7gN7/--
