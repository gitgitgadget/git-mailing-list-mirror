Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AAF15216E
	for <git@vger.kernel.org>; Thu, 30 May 2024 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717057190; cv=none; b=jZS3QV6G4+fnn3UL99OXfZ3+/7kcpg2IDgfaIATGDEJeWXWfLnNlwLzIW/dxeEJM7aCYdCBj5Z6x2nPqTeJ/HsRPZ8UrNkLe3qakLdM2wCp/YR6xaGKeKRxWl6k1sVE1uL/Fcag7PvK67Z/Ba4Pe+TQkc2ukzg+OinuTLsh59jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717057190; c=relaxed/simple;
	bh=EBomP6wgAyj0S72xNNtaWPuen6Rye+OpY5hh7madIMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g23CrDCs83594YCP21A1XYS9IEGCKYKuFt20O806cQN5LBjrOhzuKeynlBovwzoo+JkBNo8dODhAAHjJkP/O8oBXGVB3JNrHgR+5gKeGcmWJ2TJBpPgmZOvEDO8zaTTwqJZYVd3HbOU9d+X+fxCaYXK7bhN35rnQU2u1k15s/Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=euNmpUYA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B12Fbxf6; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="euNmpUYA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B12Fbxf6"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 28F1D1380180;
	Thu, 30 May 2024 04:19:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 30 May 2024 04:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717057187; x=1717143587; bh=EBomP6wgAy
	j0S72xNNtaWPuen6Rye+OpY5hh7madIMc=; b=euNmpUYAR/g4RcQaLdHvA5fab8
	DT7NHMk+OC/HQHIj/eb0fJQqut3JBEH+tL2jaGh6q9AS8xy64O/5yqcnDRYBF9Uy
	JzgWeMu5Nkc/eqAjqXW3zOi/h5a3jnppjRpianrvWDORoORZNMG3ty+BhAtVaoCR
	F/pXDB6c0yqGQcPf4PdMt6ZbwhigLNrrDu/i+aVXGOOrqFfjWVN/gkqPcNkQUC+A
	ki770fO7azN0oC+56ZjHad25QyD0QtxoXhImXQIrHcvCcjKJQErXSMUpZ5WX9aUo
	26MLsywGEZs0E2umqwV/BksF+9SPHvf7WyOkC2XBNRnmfDOGHCnSK7GzlfVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717057187; x=1717143587; bh=EBomP6wgAyj0S72xNNtaWPuen6Ry
	e+OpY5hh7madIMc=; b=B12Fbxf6H7Oz1idUn9S+fo1mzoHE+sQ/ak2U3hQn7Q0F
	ajmrfiQ5p2tg5O77vmyvAvA9376U1Ov95JTFq3o/bfRLxPqEO+HEvnscvFjHorp9
	kHvN6eASlZQgDKNfnyYrjm+goc1B37iFl7wO5FUfkt2M7Ev2nkjjAusxwIQFmead
	vNOb420wZ376MkMJ7yDzDpuh3iAHVGxj+fxhO67kAqFNUDDwmPFDX0PTicV19mvh
	aNZLQoQQCjFmALlRBipjpQ5bJ7GOGHdR9SyMAzRmUWfUVGxjxQCc6AuKsdCtKHZJ
	5TrDQljf6xLCU3olyxM4uXWhwQ3vnr+QS47zL8GOlw==
X-ME-Sender: <xms:ojZYZlH9aEjYdOCekyrQpJUE1kquwYAftziKyz0yQVqSYi3AB1jCjA>
    <xme:ojZYZqW97DSH0xv2RM3Joenx42P_eR4qavAfzJuNKOayeBOrJsxqywf5z7ZqRNTLm
    ODXn8MqSYptQJDMAA>
X-ME-Received: <xmr:ojZYZnJVqxy8USQNxcee84G2BMvMx4x0TSES9H-8INX8YQ7BEMr2mxyafTFVrRMV2JjwQo77H-pndIEKM9KJLJoLgfQy64r2gGp_NTiP_DOE_rrZQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ojZYZrE5swm2H3Uxo9_qE_EzCXWYDlNkothCgVVD9bHj7LTo91z0lw>
    <xmx:ojZYZrValBD2M9UhfqGaGPNVcfiLAXkGKZpWhvd_tgtmCXmvHE5sPg>
    <xmx:ojZYZmPZa27D6C2SqaancxCwDXlCJBO0558eYpn328rOvRxK0hQYWQ>
    <xmx:ojZYZq0SHJ3I2Sel3p1GKsEW2vIUJ65NyctKgRlqvWEl-2FSQUBD-w>
    <xmx:ozZYZhdMfcoUdAh5HZNkKijMk8XEuhUQ2OszPw9PmizRigZXsLtbl_wW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 04:19:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e755d69e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 08:19:27 +0000 (UTC)
Date: Thu, 30 May 2024 10:19:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 3/5] mv: move src_dir cleanup to end of cmd_mv()
Message-ID: <Zlg2nWhRaZxpO9fm@tanuki>
References: <20240530063857.GA1942535@coredump.intra.peff.net>
 <20240530064422.GC1949704@coredump.intra.peff.net>
 <Zlgk_MMDGlphfO9U@tanuki>
 <20240530072159.GF1949834@coredump.intra.peff.net>
 <ZlgpsrKN7N38V2GP@tanuki>
 <20240530081512.GG1949834@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5brAqSxT0R8WvAwZ"
Content-Disposition: inline
In-Reply-To: <20240530081512.GG1949834@coredump.intra.peff.net>


--5brAqSxT0R8WvAwZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 04:15:12AM -0400, Jeff King wrote:
> On Thu, May 30, 2024 at 09:24:34AM +0200, Patrick Steinhardt wrote:
>=20
> > > Looks like no. The obvious candidate would be t7002-mv-sparse-checkou=
t,
> > > but it looks like the sparse-checkout code has minor leaks itself.
> >=20
> > Okay, thanks for double checking! I was mostly asking because I plan to
> > send another leak fixes series to the mailing list later this week.
>=20
> OK, good news. t7002 _does_ trigger the leak fixed in my patch. You just
> can't tell because of all of the sparse-checkout leaks. ;)
>=20
> The (messy) patch below gets it to a leak-free state when applied on
> top. Do you want me to do another mini-series with it, or do you want to
> just roll it into what you're doing (I won't be surprised if you've
> already found some of these).

Well, with all the leaks that we have in our codebase it's not all that
likely that we actually work on the same ones :) For the record, my
patch series is 29 patches long by now and makes another 76 test suites
pass. But none of those fixes touch any of the code you touched.

So given that my patch series is already way too long, and given that
there shouldn't be any conflicts, I wouldn't mind if this was spun out
into a separate series.

Patrick

--5brAqSxT0R8WvAwZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYNpwACgkQVbJhu7ck
PpSJeBAAofvC7QTyAdFDriHMK14Lra2dKii6ElqYknE61tXuwszY96AL3YTVvqAE
Ze2NTNPVkLxZsePyMd8zT+YSdIcjtzsU/rE5wMWl2h6kv3wU7li0i1DB7Svh1bVK
YCwwn8gKa1fm1Fwj195sqonJbbnGn+mqNF18p+A43uqcHCETlQxDRu9VKfwWkDb8
E97EMxwZcZAk/xemVIL0gVHaCPl62NX66PPCmq9OJGeH3nsJgJufVJOhsgsWZIRE
bE2zL55KYRIrqJaesXdx/7hIL0ZRuxATPI0MsAJ+oJ4h0oyZkQNnMpiuFTUOwk+s
mxuOm63B+UdtZFg7rdDCeZr1YfNINekvhTTtKdNj+ahAOVKBjbaQP58RPphl2l32
TingxFtYAK9yA9nQ/PWczLa+Xj9P9Rh1PnG+/cImPxr+aSGU02/K82cgrX5rXUzc
aX6hsKn6ady1oQp6BlIDpbLfIF6+072BVJJTF8XWorbuhRkCp709XEBHAnepdONL
Pj5Bpp7PvSiMEANOsHsCssp66ynohVofrHFYR9CSiKVdK1Akcyv0e9KATm1yE8vB
iK+p21i0Wpvu6vcFQzoTuAeGd9qffVB6WILmsRcaudSzWC/f9uRmMzqGhOl0BFYl
9eL6pF9UqJEmNYwzis22mWuuy21PLSPaVJHyxKcW09YTBkXPjCQ=
=Az5O
-----END PGP SIGNATURE-----

--5brAqSxT0R8WvAwZ--
