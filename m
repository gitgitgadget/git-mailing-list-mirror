Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBBA6A8C1
	for <git@vger.kernel.org>; Tue,  7 May 2024 04:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057620; cv=none; b=rIdVrhcH9UML4J6kj33lS743dhsISLEKA5n3/Gw0rahUWDqXjruXBgY0tjtlLg8s8BrGAyDje8r+LoPDYkk8vXqCooGfwrSAT4rmE0KZziM1yclHfb5FaHhOR/soTBzQcmQEiFvR4HzR2YeQLsjI9bmqMJvdm70hi/dNAQgXnW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057620; c=relaxed/simple;
	bh=um/ZiYIjRyHmiatTbwJwRJ62jGVzBwK3/FD+Bf+i6Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sigArcvRelliaCIPJ8GQ33mlHf2TOl8gZnBsjpH8rQmEL3BXn7JaJNUyyeddj81Rgr30jsAmNoTW/hGqg7e5BC6DAElT5oanl2f6XpSw4PojZTOikUrhHV179H5J7yJSICsZ6SUWn6/hoAjKBFmEMGbW65muG2bCtahhpn2lNsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tO993VDF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D28jrKob; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tO993VDF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D28jrKob"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D2A8311400BC;
	Tue,  7 May 2024 00:53:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 07 May 2024 00:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715057618; x=1715144018; bh=YxvvcvgkVU
	OqrSf9YV8Wf5dWTkAsYFc8yeRTzteR+GU=; b=tO993VDF2f/v4jHJd/5NsM0IFD
	TRZlnzreFrLL6lCG+u8DyXcTj4mVSpzAzFHEbr2eSXCrWqC49AH0BHqRdtJZLpds
	d7ojjzccWchR4Y9Ff2ZjxtubshdHSAnDsfwz/JLoeWMBuW1XudxDPKUCjZjN8BBE
	rgBfXQZg92YV/icYMKpZ63szziN1pEZtKV5lnwi+aUauPEcNff9ACA20TJePDyRx
	v1Lt9vp0cmAr3jxbG944WgeHwbls1eeWIsRQvSOV4Wm9LW3SCLxUhOQ3N7fg8iLH
	eSbwEuw08sqUmwWGZQV6EqPtXB30V2dmSH5NX+MypZbNvR0R9GmLRN/XY+gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715057618; x=1715144018; bh=YxvvcvgkVUOqrSf9YV8Wf5dWTkAs
	YFc8yeRTzteR+GU=; b=D28jrKobbnXb/2nI6IsfyUCjXeVssrQDlcwkP60vs3bd
	oDA+aJrAvC7z22NBwQc2AGNq6VXCKdpJutWUtF6T5jfVcz6hKsdAnsP6C9rOiF1p
	Yb9qPPxP5ESvorzzGq8179Dk27NWn2fgtCOEl1zl98wf0sAKSvf3jAO5ld+dwmoP
	q26XJGHqypgT29/infp7cG9mgVgQgIPAsnw1GYLrAt+a4bs57I5qycIzT5MY5N/C
	Xwshfs0tXrSUyCHFDh1Ehbkji1jLxvbCjMtwmJl0LPPFw88R1VAsgomXaYc+I1F4
	FehgEyou9ao8qUNyUg8xsv0rnqCgs7ZpDFK2D4N1pw==
X-ME-Sender: <xms:0rM5ZqIDK-Gd5M1PW2F9BfNoQYEFFdD6-8ALd6I2SjZo0QWmDGqh3w>
    <xme:0rM5ZiI04qG72r3yMESbDrr81kTE9-69dikiveHmVhG6yLjVOxQmYY7cwR-0E3tf9
    MRO8vuh_VTv1I_DZQ>
X-ME-Received: <xmr:0rM5ZqsW36r9YbddMcji63n03ZTxIMdR5Pd003-UVVtjmG7PmmziCFFJ_1BzoILGgxkJqj6-_8XvLaBQYnlVLGZT5IjXSGUDQh7YjeZ1XgXvAa0QSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:0rM5Zva04aPNVoe1ffmWVKTpo6UejX-Ry0X9cHRvJw7dWzzyiGg6fA>
    <xmx:0rM5ZhbVuvJuIM7x0uyDZgGaGzEkaHxrcMafvkxwbAEjM5XX5D0J7A>
    <xmx:0rM5ZrAaLToBbYxKrcAfrcF19CZ9w0Cs_jBWMZYwsRLlzKNtpmGm_w>
    <xmx:0rM5ZnYODPgsvjjniC4izh9EjjvWx_Xv2OXgkeFF_OmagZDt4-pugA>
    <xmx:0rM5ZgW2iCzx_T7egH8RkWor0frEwIk21ffrU2jriigLBsoqpz52ViE_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 00:53:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 009af09f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 04:53:30 +0000 (UTC)
Date: Tue, 7 May 2024 06:53:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 11/13] builtin/shortlog: don't set up revisions without
 repo
Message-ID: <c21b15ba1759a9dde7ba1d50817bcb44fe1c66da.1715057362.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1715057362.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xvF2M0qzy3u+SEzn"
Content-Disposition: inline
In-Reply-To: <cover.1715057362.git.ps@pks.im>


--xvF2M0qzy3u+SEzn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It is possible to run git-shortlog(1) outside of a repository by passing
it output from git-log(1) via standard input. Obviously, as there is no
repository in that context, it is thus unsupported to pass any revisions
as arguments.

Regardless of that we still end up calling `setup_revisions()`. While
that works alright, it is somewhat strange. Furthermore, this is about
to cause problems when we unset the default object hash.

Refactor the code to only call `setup_revisions()` when we have a
repository. This is safe to do as we already verify that there are no
arguments when running outside of a repository anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/shortlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 3c7cd2d6ef..d4daf31e22 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -434,9 +434,9 @@ int cmd_shortlog(int argc, const char **argv, const cha=
r *prefix)
 		error(_("too many arguments given outside repository"));
 		usage_with_options(shortlog_usage, options);
 	}
=20
-	if (setup_revisions(argc, argv, &rev, NULL) !=3D 1) {
+	if (!nongit && setup_revisions(argc, argv, &rev, NULL) !=3D 1) {
 		error(_("unrecognized argument: %s"), argv[1]);
 		usage_with_options(shortlog_usage, options);
 	}
=20
--=20
2.45.0


--xvF2M0qzy3u+SEzn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5s84ACgkQVbJhu7ck
PpSvMQ//fsl7Bhxj1yHtc092eR0PxG/JY7yMIvKxJIvlfDe76PGTyazN7pqfdG+B
MxGxERrK0BoVTvSuCQI63Uqb+/vmhNXYzuMDB8lkBzy1fOSKqp7Kc/W8Ja3zzV8f
QAW841SndeMrDj+GqAD0NPAa/kDNjcJuOLahFZGa0u0doZAWWLEt3SrXiKLKup4A
EWxn8rDk42/+c9sYcb4oZChV2OM2lQSxX67LDuGezrl7M7+siNaBOYMtxJqKLlOG
J52ihWaR8fNVSqubPGBeX5c2R8OoooOlRWYA83TqEY6Wvj315bkQgu44I8UyQBB2
Q2SrSxUt6T/N4GbgaailM0Efcs7442vjiDtdevfAoXNdh0ZM7rg8IVKYoIsEqusn
DQGhAu6EZGkPJZEEHMBZGrggQuj/kNTzlGT91qSodorRvXLI99RpSf7PabTrtroV
dzXuqlBZlZflhrhpK2Q5QEdn8axr5BgdLTnj7hqnQ0hIHSAlCji2z68Rhdoexu81
3u70Jc+cfUa1uo3g7CDa83oBGgmRMuEw6Sjl/JQSAnCatHY0TnEx2ylaBQW8O+yM
xPzEGLZfHJyvhzhtLnvxHHV2Ej38RidqeR2y7wOU7ktGOQGimvDTlYFCpFFstxSg
xUIEtfkQRDq5XsgeXtNYrFbr8X5Dkukwi6RuSM0N00ipCwCYEZk=
=skrZ
-----END PGP SIGNATURE-----

--xvF2M0qzy3u+SEzn--
