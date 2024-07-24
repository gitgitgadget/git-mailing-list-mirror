Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F78811E0
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721810146; cv=none; b=Zk1SwOuaml7BZCR13yvLOXKHb2IQCceiQPi7kMvhooGeBa4ccuFKnF7NHKUStoW5oiD5Qru6uolK/zBMypFxjqUlDh6FsC7g2nPpEATZp8ej2frEKsZ+iq5Kl9ne57Q7+w/+sRD3lTc6TIhGujXROxJChh3ZMOEg/6ZQ4D7ElB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721810146; c=relaxed/simple;
	bh=MStuJ6d2IuRNuKReNhnAmJ1Ccc4cgxk1tMpei6vUBUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeTq9ZkmxDUg5BfWkgPLPkPl+z95hdPZasKebXhfo4DkuGMOQkdGupJHFsMGA7UyQLHJSSgi4sFfc4GLxiS9CwnvhyL9/HpScD/rSL8SZ4vt+m7TVW67qde7mRQJlvm5wJAikdJTinKgCP4OJk0NFYpI4z7tbwUVzqscH5AKzBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=boFJZVSO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=syJjmRVf; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="boFJZVSO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="syJjmRVf"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 974CA11402C8;
	Wed, 24 Jul 2024 04:35:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 24 Jul 2024 04:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721810143; x=1721896543; bh=VHpM1nFfaC
	BaTjzWTQIrV0njfAFuA3Wkk2DBRbulJNk=; b=boFJZVSOKmurYK38gW4W7hlxyn
	XzuEfhyF3BDDToCxDtu3KUJi2EjW0RxSyM7VMNfADoD1Uxn5QwQKz77SPq/JtY4d
	gRDIuDsRVyf0YrXBi1IDelWGqOD9iAf3QhtzMpTrz5F3DiuM3KGoSZWcgiRQ0ToJ
	aU8AeaxLoJml6pyqJTYIWCkIKidQVN+hDZ65AQMI/iig03pwDZOvWRZmAuP6XbMF
	NzfUgp4gepSdBiYdyDkQYZTBBUTZFt79D374wHwbWBauR/8v3z59wpKmkFNERvdB
	7LwVlqKdEZfWGElQVWcRTXk88+PWOfCLz7YN6go6tHHRS8FU7Iv8YxT7vx8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721810143; x=1721896543; bh=VHpM1nFfaCBaTjzWTQIrV0njfAFu
	A3Wkk2DBRbulJNk=; b=syJjmRVf/Fi9y11qpD/XKyna71eElFeFUmLuu1zECbZD
	i/JMIPiZ8/a5stO6gnF2T70womjR3brOxWa84UMf8k6KF4JDyjPOXa3po+iu5wO2
	qYGGfYK0IUky9IO3IRMErvvGEDF+nNznXaYeVUJf8QHHx3GJ0lMfunPBq7ZDLXFG
	Wo8Hx+6R7f89FN5t4wCRkMy3H8pFSFHNOdBeb09d+KbsZPkQMhQm6jUjhRtGIhEP
	LUS9eFuq9TR9eYpugZ4WHvdoAFvdxYbckJmoUEA6nBJVPJxD70C5xiiAMe5jyAGs
	oc2YchXO+aFt8C5KshapbkEKjTfEK+KwnNJp6e5Drg==
X-ME-Sender: <xms:37ygZkSYmzRpiP8Iyc7NSLyNAnS9-w0dIHbG4ZSlun84pvscoFE3QQ>
    <xme:37ygZhwJs89X_IJC2_sefluL1pu3AqeAUKa-DxWKyCTKHldqwE1EpLM5Xs4foIkTB
    t-UDg9GEMz-VLXMkw>
X-ME-Received: <xmr:37ygZh1hmu6hlrXfjx877UrSzIYvdKhU3bcVE8kFpk8wEVPSGLyeblWuPKY_76jnlhrnQdkwdJxxJstAoqqcm69pt7liZB9sLTkEpePBnrCikRKD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnheptdevveehheekhfehteeltdfggeegveehie
    ehfeeggefhteeuuedvffffueetfedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdp
    kedtgidvgedrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:37ygZoDTmjzacTV0gnYexQmcrA9qBACB6Ba2vE3Kzvk85Zn2ehioFw>
    <xmx:37ygZtjRNB7tx8TuWQeLxhdbB8MSN5jmNgGHX01goUe_TQ38KSkWuw>
    <xmx:37ygZkoFDJUqXlNq-shXjUJtMsOERg6hrtDwQ2TRQmAonyavcEEZRQ>
    <xmx:37ygZghOtMH4Ef37bU5qfQ8jGtUbY0Tf1C538u_A03wnH0ws-UeyZg>
    <xmx:37ygZisKME3h2gkcV68F1RhILuDahUV3mpMKoNQEmyRaVuoz6Ejy5LMI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 04:35:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bc6566b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jul 2024 08:34:24 +0000 (UTC)
Date: Wed, 24 Jul 2024 10:35:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 00/10] cat-file speedups
Message-ID: <ZqC82sDnj7Se_aVB@tanuki>
References: <20240715003519.2671385-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cH9BLjoZIeqiQWpC"
Content-Disposition: inline
In-Reply-To: <20240715003519.2671385-1-e@80x24.org>


--cH9BLjoZIeqiQWpC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 12:35:09AM +0000, Eric Wong wrote:
> This continues the work of Jeff King and my initial work to
> speed up cat-file --batch(-contents)? users in
> https://lore.kernel.org/git/20240621062915.GA2105230@coredump.intra.peff.=
net/T/
>=20
> There's more speedups I'm working on, but this series touches
> on the work Jeff and I have already published.
>=20
> I've started putting some Perl5 + Inline::C benchmarks with
> several knobs up at: git clone https://80x24.org/misc-git-benchmarks.git
>=20
> I've found it necessary to use schedtool(1) on Linux to pin all
> processes to a single CPU on multicore systems.
>=20
> Some patches make more sense for largish objects, some for
> smaller objects.  Small objects (several KB) were my main focus,
> but I figure 5/10 could help with some pathological big cases
> and also open the door to expanding the use of caching down the
> line.
>=20
> 10/10 actually ended up being more significant than I originally
> anticipated for repeat lookups of the same objects (common for
> web frontends getting hammered).
>=20
> Jeff: I started writing commit messages for your patches (1 and
> 2), but there's probably better explanations you could do :>

I definitely think that most of the commit messages could use some
deeper explanations. I had quite a hard time to figure out the idea
behind the commits because the messages only really talk about what they
are doing, but don't mention why they are doing it or why the
transformations are safe.

It might also help with attracting more folks to review this patch
series if things have better explanations :)

Patrick

--cH9BLjoZIeqiQWpC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmagvNkACgkQVbJhu7ck
PpStqw/+KMMR3WP5mPln9/urzeboCAq1T/Rzb/Fy8fIguzZoFMhzd8x+nntVfpXg
/deEyYbznIods1hIGIMnfz6C/RR6Y1dL2Ln37tAp27d+4gVjiPd4UkAzQ60Dkvco
fetjrXg+h8sxKnz4uNqbahIgYbbDVYAFr4JYgey5yCXtttbFKJNFVqoY2a1MdEm4
qU8JMf9AKfH+wsanFHMPdfI514bBjd+0PIbjSk/Z8sVkbzPUwCIdGGLZahNoObuU
7BX/MIMLrebstAGexCTH/dmB6bkGvWU5tLaSQP713ezoDXWn8tnOtAxUhph3MqNg
ENpRyNsNMEcl60K2OdF8y3nisYT6ZABn1uFRI7Hh5tkCv+0R2ALNCgTbQHABXN9t
OGsxzLE3mvCbzuMqIm116GQI7WHFlV9nGdF6gHpNzwNivLeih3Lwr9wsLKyC0Grx
7LEoBSol8KlCJl51L2DMPyQJTZZBi4NsPSyV8RXClrFgAAK/gWYmf3mS5Z0vPinI
xyUlNI92RXPc4c44Tp5CwUneS6Xhj8qYeBY3rS6WzVXQIp9uJk8kWDyNkyAEsWC6
3HUnQ83BSLvibX94XVNpKyQpQzwjnkZdQ+vDR2F2vL0Ag9w1ylc8Bv4ClFOmFZX5
zwNiNjl/WcLWUoWd6XTpAuVqvy1xROC4kNyKSfuBIibPMBcQErM=
=D7GF
-----END PGP SIGNATURE-----

--cH9BLjoZIeqiQWpC--
