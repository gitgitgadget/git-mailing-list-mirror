Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4869135A6A
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139546; cv=none; b=WaGq2zpt1QYV0YbpjDKjnk2WNiLCTKz4BwDmbfL2Lr1+YAbGC5c6vFMD+E92o4Y2uHBsYL0cQteWU4piqYk3iXrsgTL9qTUzBFRbctyxj4TLShUUv6dkabYk6kphOKMWAlI+s8w9kGhgBJ+XwkUYvmZiYNfLFyfZCssxiHHUB78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139546; c=relaxed/simple;
	bh=AtDC9/pIkykvDRbfEeqK+kl98hw8A8E3whYJ8MqyoIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnIghb0UScQ8u6vvG3rFAGzao7EYmD4i4Ay8xgDZWDgtHn1uBfr6NfoxRLHnG4l81QplubLBoijxPg8UDtO5AquE0y0sOc2ygtQP3fwB6zoV0ep2zoEOk1Nx2TOw5d4mT6taeG21ijTtch8Y0cVGOlir33llUWQmtL5OrB/IMI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pbqkb2Lr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y2oIE5g/; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pbqkb2Lr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y2oIE5g/"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E489C1140143;
	Wed,  3 Apr 2024 06:19:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 03 Apr 2024 06:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712139542; x=1712225942; bh=AtDC9/pIky
	kvDRbfEeqK+kl98hw8A8E3whYJ8MqyoIA=; b=pbqkb2LrwtOKFXrZfsOrOn5SpC
	ZXOXp1YJAZlZ3wiGw/Pw3P7l3WmT9uib/hB6WDJhUWfWT4Zk6+6hpGdouky+Hx4e
	JTuJCFJvrDcdKX1CGuCI8CxEUX6EOQ48L1dntTlYJP0kUGr2D2tB2EWhwpBqFmYL
	9M61XnifcWk8CpX5CKtnyO6iphS5B75IQJJ4JyJhWXTVPD/v7zyUW7QCWnlfM3k9
	41m8gtlyMAUUT9RlwSP52Ahbc0GUBRU0O25KJV0smVyLe65bwKVz1FG5ZIIDeVwl
	u7cQUkBGC1etk9p3EC29KF6OCVpzRxj++wP9a14MuERhCn3NBc8q5katA8UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712139542; x=1712225942; bh=AtDC9/pIkykvDRbfEeqK+kl98hw8
	A8E3whYJ8MqyoIA=; b=Y2oIE5g/nTlARu6u3m2PrgEHzjJDzyQGwgyxYvdC3F6t
	ST5c26xYVrpKQvWob6E2M00w2yu8mOMucvRS2fJgYBUuHDftHrHca3wM9/Sh342G
	ECWnhmVeh97+iW2bciQGmwbE2Y4Opxh/c/yH73LbsB26h8SJSjTW6+GPuf4URCHC
	/QBImtVklHqBYQgNFcs9wd83Zp6ypBtv8j47S/diqBh8h2J4+Y8XjsTJ6ZoGkSLy
	mN1S6SIUC0wBwqYCb1j6Ga8M1DFqyWhb3Okx4bIk7cKha6n/EuzT2WtPbtVGLqpz
	2Z2BrLS2Ce6JxD+Z1ofCsCrpem3Ff3qCorG/htnRUA==
X-ME-Sender: <xms:Fi0NZvWuXjJ0814NbwN7s0oIqrdPtaMAYDUeWt1gzLXak1asNd5KIg>
    <xme:Fi0NZnm4UouuC1CrKMRfe9TqvFBX-rXo7dueMxvQFdNwwCwJrFqWH6dSJn4U1OnVk
    xUinFhOBVTYhnE1xw>
X-ME-Received: <xmr:Fi0NZraZ4Zg0HxG3K8RnEbvkKIQZovNwI_mEBqTSsv8fu0z-yKYXMJfTijEUy-ZtAfqUB_kQ0LAwXoFCszQPezWm84vglgxyc3SmGszZQEBLsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefgedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Fi0NZqVi05T_RZ77PdkVdDeEd9PPeI4JkFGvZ2rwgEu_NvSWm__33w>
    <xmx:Fi0NZpkCAYsgB_keMMgHLB_C-jFumrn-BOJlZ8J2mncEzBDTFeowtA>
    <xmx:Fi0NZncttqt4aiIwy1VbgWmTW6U5A0Ycz_go01nWYGZTg1zAsFCOag>
    <xmx:Fi0NZjHXu1dnwiugj8Dk5Jfh8l9Ikf1Bm1XFBPZm5DbdG3beKUh3KQ>
    <xmx:Fi0NZna72VkOpZkpZ3wAqWTMOUOGkMCciW56QafHqSrf07hsx0Ffwlkj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 06:19:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7962aa69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Apr 2024 10:18:49 +0000 (UTC)
Date: Wed, 3 Apr 2024 12:18:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v2 0/3] reftable/stack: use geometric table compaction
Message-ID: <Zg0tEa7DDEuub09Q@tanuki>
References: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>
 <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
 <Zfzd8YdAwzYRYkA3@tanuki>
 <CAOw_e7az+S4nkG1HKDcqXkK0BOhs6cBpkb=QEGBoZW8MSEEvGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sQa3Wsc1efedqHCX"
Content-Disposition: inline
In-Reply-To: <CAOw_e7az+S4nkG1HKDcqXkK0BOhs6cBpkb=QEGBoZW8MSEEvGg@mail.gmail.com>


--sQa3Wsc1efedqHCX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 12:13:42PM +0200, Han-Wen Nienhuys wrote:
> On Fri, Mar 22, 2024 at 10:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
> > > Thanks for taking a look!
> >
> > Cc'ing Han-Wen and Josh for additional input. From my point of view the
> > new algorithm is simpler to understand and less fragile, but I do wonder
> > whether there is anything that we're missing.
>=20
> Good spotting. I hadn't thought about alternating tables.
>=20
> I have one minor criticism:
>=20
> Environment variables are untyped global variables without any form of
> data protection, so I find them unsavoury, and have tried to avoid
> them throughout. (The whole reftable library only looks at $TMPDIR in
> tests). They're also accessible to end users, so it can become a
> feature that can inadvertently become a maintenance burden.
>=20
> For testing, there is a stack->disable_auto_compact.
>=20
> If you want to keep that style, I would elevate disable_auto_compact
> into reftable_write_options to make it API surface. This will let you
> use it in tests written in C, which can be unittests and therefore
> more precise and fine-grained. They also run more quickly, and are
> easier to instrument with asan/valgrind/etc. The test for tables with
> alternating sizes can be easily written in C.
>=20
> If you really need it, you could initialize disable_auto_compact from
> the environment, but I would suggest avoiding it if possible.

That's actually a good point. I think keeping this as an environment
variable isn't too bad as a stop-gap measure for now, and it should be
obvious to users that it's not for general use due to the `GIT_TEST`
prefix.

But I'm definitely supportive of lifting it out of the reftable library
and into the reftable backend so that it is specific to Git, not to the
reftable library.

Patrick

--sQa3Wsc1efedqHCX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYNLQwACgkQVbJhu7ck
PpTtMg//cDujSHlo0MZo9RS79EzZHo9dl/+xupIXTbNr66kTd9wxhK4a6a3j+pGv
szM6nIHqA+km/2e84qpDlYGkNo4FBPgCxm53lO+dPtsOGK7c0I8f6bLDL0gsxo+v
8033v+XQsKAZo50IdO9SjU9G3YAmzbaE6Q75oURzcvzEWxT8bxrGRmFp26MfE9S7
Bk0CESymr79M5FO7PUdc41qDdabMl8P3DlvDTvilLGtcBrSpeuh1uqkplxTOw6fz
IQd382mRdwIyveAEOaOGCY2b/h9v2eHqX/9mlK/Yk6X7u5Ghe4mzYSp8VlegoRSU
NMr4FxKXuAUFawW7Q5R1JQsMXfUfgfG4G9c+7tOFfTCyz5lj9MwHyZ0LBLGRpFVA
mCZm4RyXm7s7UvU+e+WvtTHLbKix8NTy7DRAXCtkJY96Ci6M94qHBZdydzPPBDbE
pFZEC10J4OBO0PJNFyqQmgwloIYdW3psiJtoVIQcAsNg30xuqFRCAyxORxCyPQxB
SUcxfBDJkGCyDKPQQKEnR2G+tuLyW+uhFZsg57J6jx3gsdfujrJBI/7UTRn/SiUa
f1Kj/O5cwGDOznSgBdMdjv6PEMPL5/n5TvPDhjS8Vt85PwOZCCw85CUz8canC5iR
UOMiBSiZSmHWQMenNufW9gi2RAlh9V4GLX9zhBhwyk0ncFvJcrk=
=s0F0
-----END PGP SIGNATURE-----

--sQa3Wsc1efedqHCX--
