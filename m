Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8989B208A0
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 05:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713848897; cv=none; b=Gkkt9UaHM0eYKtlXoQ32sglM32ryXN/Ll0cq54INCf4Fw5BDv7j7CJUK+pYqrX5AvqcCC+0YTR8uDQOMLxWQPSmGXZxgJrcfBqDpMvHfEkqAgi5ctpxX6Ixn6+mP89qhr9C86B7odEsGXTdUxRWuciOavFto17tdt/dbbUI1g+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713848897; c=relaxed/simple;
	bh=e4J8zUysxNyUCW68YU1kTKiHcbNYIfz2tshcxJqJq/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXpwt2JJv5rVX8OzudvQntzg4WxKyrE0fiEtl0BgB2pn/0DskaopjIeRLh/dANOaTnSxgjNAAXzHKFeArU1WJ/5EXNu4oAzhEKlB2txeTQxk5v2cHTz/OIuCO5mOzYrvXx+Bi9mJvYLA3NMMjYQKO7NAFJNDWA++yCVgxIR7D3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lTexjO3H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WSTEJhPX; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lTexjO3H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WSTEJhPX"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A134A114017C;
	Tue, 23 Apr 2024 01:08:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 23 Apr 2024 01:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713848895; x=1713935295; bh=jRRx9mCtVN
	0flKOebi2Q5/wwTwYAcXmngOCpuNLbOV4=; b=lTexjO3HAwex7Ig9jRmNOcqCZc
	bU6C7lt4qN5jiXr/zR8KSSBBkJ1v9K7QauH0R0+sGPmm2/tjBxVM5m8PI9U5qNfj
	YK6WVcDurh5pujIq568/yT7tJDnd+5cJE/GN+kvPzb0USKROAWwUWPBR7R59LhZA
	ztvXzG9AoNKvUebOUSERrgGkhggAIrQEIu0i5XMkMM8+0MIkAex5liSIEeKEpzzT
	CKoloRoUkFXi/dzcvPK8lOnjm2QAmoAAumHDBKbcmTLQCk0c7+JQcJoWdUF4CBpP
	jfCMJL50rExP48fcqKeFstqs3WvjDglwf6LzBzZWTmz0wyar5FJVX/5bUimQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713848895; x=1713935295; bh=jRRx9mCtVN0flKOebi2Q5/wwTwYA
	cXmngOCpuNLbOV4=; b=WSTEJhPXGL4g3IEsl4QX7Us9es2YKbhsCFqCtScKSPQ5
	cBy4HMbNhUCRCCpwZartu/avfZNVAd/xaoDI0xKObE3/2oIZGhsRPF/m2IWuECMw
	VSieN+lHQeJ2lLrC9ZT6bO3OHAL4V6iRFKqGJFU2hIhC3j5vpZNlT5JNIwnddMwH
	2uQYdFfLZcCTpvXMQT0ZCCebpNqy7Ht/bToB8m6nF4afTfs09kwxRY5wmcDHcAFm
	CYmFUnxS6n4jEy1bO38AHsV9BizN52mriOGTgEMPOaREX4oI7u12yqj9CqnfoFMj
	xujcNfmbbiJRIwBNJasm1uubidsLD5pp8S/broSTkw==
X-ME-Sender: <xms:P0InZiR29Ocuhn_7yyQyZaUbhjQNhyToiiblX3dKf7Zm2CVTyjHDEg>
    <xme:P0InZnzBYM4SR1R2j41r0jNgZI-n5fCLQRAR485mSFg5hH42M-W8WRRddCwGs3MtI
    aynXrz3AzKQejwKMA>
X-ME-Received: <xmr:P0InZv0huKoI1d0JX8fJVAVVek-tt-fwNBZae0AUsmDG1VQRjjXt0OuxKZ7LboPIeWTAz3C5vlrwfq_tSa0LU_6bRHMdxzP4oZ3Yfiy4Q8SdOVYb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeltddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:P0InZuAyDx-DmwUsIq8BagvZvKKoAKeCc2c0bDdLJHhAnFKyT6gEKw>
    <xmx:P0InZrit8UPh7rwSxjZzvST8mw04-iGl_bOVluKGqavOUu08ngq5FQ>
    <xmx:P0InZqrjgEZ3F3UO1_FcNZbC9EXwViCkEJ4k9DkYPuHDXyx_p9jj7w>
    <xmx:P0InZug8wZDEch34s657RCy2Egdn2r424YsmaOrsXrbsrtZsrI0BQg>
    <xmx:P0InZreANujnaMjZi_HFXvplmSUDfAnyNlYToGkCe9vIU3aFs2ItdX4Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 01:08:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cc316a7e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Apr 2024 05:08:07 +0000 (UTC)
Date: Tue, 23 Apr 2024 07:08:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 10/12] builtin/diff: explicitly set hash algo when there
 is no repo
Message-ID: <78e19d0a1b09ed36bfd73fe128d2f78addcd1134.1713848619.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1713848619.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LxOADrY5GT7AJt2o"
Content-Disposition: inline
In-Reply-To: <cover.1713848619.git.ps@pks.im>


--LxOADrY5GT7AJt2o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git-diff(1) command can be used outside repositories to diff two
files with each other. But even if there is no repository we will end up
hashing the files that we are diffing so that we can print the "index"
line:

    ```
    diff --git a/a b/b
    index 7898192..6178079 100644
    --- a/a
    +++ b/b
    @@ -1 +1 @@
    -a
    +b
    ```

We implicitly use SHA1 to calculate the hash here, which is because
`the_repository` gets initialized with SHA1 during the startup routine.
We are about to stop doing this though such that `the_repository` only
ever has a hash function when it was properly initialized via a repo's
configuration.

To give full control to our users, we would ideally add a new switch to
git-diff(1) that allows them to specify the hash function when executed
outside of a repository. But for now, we only convert the code to make
this explicit such that we can stop setting the default hash algorithm
for `the_repository`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/diff.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/diff.c b/builtin/diff.c
index 6e196e0c7d..58ec7e5da2 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -465,6 +465,15 @@ int cmd_diff(int argc, const char **argv, const char *=
prefix)
 			no_index =3D DIFF_NO_INDEX_IMPLICIT;
 	}
=20
+	/*
+	 * When operating outside of a Git repository we need to have a hash
+	 * algorithm at hand so that we can generate the blob hashes. We
+	 * default to SHA1 here, but may eventually want to change this to be
+	 * configurable via a command line option.
+	 */
+	if (nongit)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	init_diff_ui_defaults();
 	git_config(git_diff_ui_config, NULL);
 	prefix =3D precompose_argv_prefix(argc, argv, prefix);
--=20
2.45.0-rc0


--LxOADrY5GT7AJt2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYnQjsACgkQVbJhu7ck
PpR6Qg//bnQQeflnfYZsTxhCKgACKJEaYivqVaHg+FIBnOo/wN0Ee5w1GBH/YsNV
PCyad99DHHwHrZeCtXCVyYbMbX+GW96an+D75NtuQEjt4RFRfF3ad6t8ez8hEe6z
ryiJabgVuOYjnJelDjUe/eXdLNr9N22O0QAnYEfsVJ/xMNmnXYGFyqsICLWD2e7j
J6Dq8q7TWTp5h6DPvVseX/YlPkDWG42wf7P5A/nqD3/7vPrfdHA8VoYzfBeuG0Nm
yhvm/EuNQA7RaN1jOGB4Vybm2gtWjFpBJsTvtlZkS6a9CKcBHG+FcDeN80jOZMvv
X1L8aP547l02RNVTf7sROptUyOdNo9GJA9ojwmEKJGlc9SRuEzW2vaigyXcLywR6
QSXDhrx3EUtpSArsiipkPmCAFYl88sRMhxapIkMlzcRKAREQMyqt43YrBxiJcV6K
PsIfe3bIOHeWMytLoMMBDWwhK/mZuNHZrw+DjB2xOT3ouT3L+Dg8NubiAnpXohml
vKaUAAUiVpvz38cSQCknRhrzp6Jl0Bs4o86Ao+3V6Uxnwb+5Zg+z3Nrp4yE/3D+b
Hf7C522Z7W9c5xOHZRB7o8Oaz9oJFnThybuU47CAX+mu2LubSUDqxd3sV2sIAjqf
o1DmBjGD+lh1mmNxwfFh0b4qY/6a/2wKLBFDsH07UzjROUhCJZg=
=kAZV
-----END PGP SIGNATURE-----

--LxOADrY5GT7AJt2o--
