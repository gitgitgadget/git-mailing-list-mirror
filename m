Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D516BFA0
	for <git@vger.kernel.org>; Tue,  7 May 2024 04:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057606; cv=none; b=AWpkHVUw37MN9FB5tNhlyLIUQSr7DJP3DwtOAeofKexW5KxmfQG74jnwf7tBnA5/uKbnyDltJeM0XnOA2pAeXUymgcqKnfvOG+3hlJUArsUyvE++ADNW+HJv1PTM6E21s9NxzEZYUS3vzrn4v7yKhKhnBoEWal24otrALqiE5C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057606; c=relaxed/simple;
	bh=CSxceVs6ZOAx4ML0QqmsLp0B3wdboywMUpjfRnlCqlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQEw8d6nBm3k8onruWO8BlxrcCtDjcidFTYK3bMaK7bGedXGxbvvivCrM/1IwcQGdwaDdU46CZBCralequEPJhligvNgUEQSR+JMf7fYQjT/WLx2C8dAUaruimBbDI4gAMxyxUWRjbPjCkm0syVBjOacaUE5fy+wYugc7Gf3n0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vGvfJEhg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gE0LFL/D; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vGvfJEhg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gE0LFL/D"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A99961140166;
	Tue,  7 May 2024 00:53:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 07 May 2024 00:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715057603; x=1715144003; bh=QKtN/dQTo5
	KnjBmOWpBuzEnquFlfVByiSmpDqhMYVlo=; b=vGvfJEhgmQB4dSkCj3GCIGQe+N
	sL0s21edeKQHHusuZNmlHJKDQ/ASAoTsEoALHOyKIqXc5S8Lj9o/u0lk210vzDEt
	CbygXod8xX0+HSzoi3fBoe9i5xdjfFWC9AmrRUxxbbXp/dVNMMFBsul9rmnV9TBo
	7Ey/bT8bl5H2tB8Cq/n8Na6nwPaVstz8K3y2lroVwueLz5B66GgrUNGwM7afMqCF
	iPgMdJg+7W2FpomoNVkWlDyAiz57SADxhA8tumClvXYh5NKIraL67mKnPMhQ0nbo
	kjF64/NX9RcTz3oGs1uGhzn4nHHWuM1EKCm3ohNnOb63306KSgpNAv14tDDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715057603; x=1715144003; bh=QKtN/dQTo5KnjBmOWpBuzEnquFlf
	VByiSmpDqhMYVlo=; b=gE0LFL/DBsas678nI4TTW39QZTaKJkDEGJaJidFu94mD
	+BSvyCsgbaneBX9wN759qbVNxvUpgUiAtDMbFdAp6yMT/KeBhOkP64WAgMaiVot9
	o7kGKEBgjsVKjlWAeOBYjrVl8cxsjhLVrMESR8a3cbMU+CzTFgLTSr1gX/D6Np93
	4qAK/Xf3wRloMKDdaTBhSNaxHqMeLdGjK8hsHMoW3mY8i8ORRxUx8keCcwLUSBj2
	aHD9hNdx1dgKi2jQlELoReApAXrGEqDUL/sD6eZwv4ooD4Rrgdfh1T7UYw8D1T74
	Icy2qm9+6xwny07Lqejmw0csA12ZT6k2vWZYaaT0jg==
X-ME-Sender: <xms:w7M5ZvxJFbqupHQtVXKti6qZeCAffy_-U0upvogcOxN9HuVR3pYOOQ>
    <xme:w7M5ZnQEz1-o-qMkf2AfpPG39B2Eanxuwcjy5dydtt4xe7gGYZxaPsF_A_NF8Dkja
    U-tx3InbMnT_SbAYQ>
X-ME-Received: <xmr:w7M5ZpV1dXPkBTGZrx748tF523AkeLfGLaie88mQYB6rTpxMXhR1xoDqk9ZahALNM8UmyHFiK5YW_gn8YXqUGk1yswLftN2wcW_woOR85WE_w7gKMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:w7M5Zpha5pAL2wD_D_C-kDLeqpep4n5xJ6pAG2wZMlzgiZ7T0zVt-Q>
    <xmx:w7M5ZhDn3De4BWE9InZnoprRPXJm_D-r64mbB6pIMj4k_2H9-w7Dfg>
    <xmx:w7M5ZiJeTaSa-et_8h78fkOXoQHCZ8di1H3WvwkONS4nu9vDZnXPIg>
    <xmx:w7M5ZgAyeS1SK_lpH3UECXWsizgMZvV9UXHKb7p4iTNWZSLEqqofKg>
    <xmx:w7M5Zs8An7EvcI98PZE96t3nntYlFk9i2UC6s0jkaaxZMlXhxgYz5UIa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 00:53:22 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id afd65ab3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 04:53:15 +0000 (UTC)
Date: Tue, 7 May 2024 06:53:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 08/13] builtin/blame: don't access potentially unitialized
 `the_hash_algo`
Message-ID: <872ded113ef3cc97cfdaa7f199ffe6aca45c6067.1715057362.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1715057362.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VUR1LIB4SM0rQIBT"
Content-Disposition: inline
In-Reply-To: <cover.1715057362.git.ps@pks.im>


--VUR1LIB4SM0rQIBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We access `the_hash_algo` in git-blame(1) before we have executed
`parse_options_start()`, which may not be properly set up in case we
have no repository. This is fine for most of the part because all the
call paths that lead to it (git-blame(1), git-annotate(1) as well as
git-pick-axe(1)) specify `RUN_SETUP` and thus require a repository.

There is one exception though, namely when passing `-h` to print the
help. Here we will access `the_hash_algo` even if there is no repo.
This works fine right now because `the_hash_algo` gets sets up to point
to the SHA1 algorithm via `initialize_repository()`. But we're about to
stop doing this, and thus the code would lead to a `NULL` pointer
exception.

Prepare the code for this and only access `the_hash_algo` after we are
sure that there is a proper repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/blame.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 9aa74680a3..e325825936 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -914,9 +914,8 @@ int cmd_blame(int argc, const char **argv, const char *=
prefix)
 	int cmd_is_annotate =3D !strcmp(argv[0], "annotate");
 	struct range_set ranges;
 	unsigned int range_i;
 	long anchor;
-	const int hexsz =3D the_hash_algo->hexsz;
 	long num_lines =3D 0;
 	const char *str_usage =3D cmd_is_annotate ? annotate_usage : blame_usage;
 	const char **opt_usage =3D cmd_is_annotate ? annotate_opt_usage : blame_o=
pt_usage;
=20
@@ -972,13 +971,13 @@ int cmd_blame(int argc, const char **argv, const char=
 *prefix)
 		show_progress =3D 0;
 	} else if (show_progress < 0)
 		show_progress =3D isatty(2);
=20
-	if (0 < abbrev && abbrev < hexsz)
+	if (0 < abbrev && abbrev < (int)the_hash_algo->hexsz)
 		/* one more abbrev length is needed for the boundary commit */
 		abbrev++;
 	else if (!abbrev)
-		abbrev =3D hexsz;
+		abbrev =3D the_hash_algo->hexsz;
=20
 	if (revs_file && read_ancestry(revs_file))
 		die_errno("reading graft file '%s' failed", revs_file);
=20
--=20
2.45.0


--VUR1LIB4SM0rQIBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5s78ACgkQVbJhu7ck
PpT9EQ//WvNQuOc6m0n9CaEYWwaXv1Q8gEwloJaRqD5wHkSSd2Cur8AAHHxaC7zz
Wmu3fitLRtkS5lbJqtQkuaLZK8JXUuANnmYZDdItYxXz43957HqQD5tae1+IzWv+
Xp/mjpx77lSHYluY/qjlmpw8HuS7ieOO9W7IzSCtcAnMyePw7o/ZY6+m654p+9nA
ZtVurPSg/wZMmUmcoHwTheqZRJO0ODvdKVo7nM00tbEiffBxWFuHanW/dNqVPyoS
bEbChUAUrcUOSVvEghk5zhP6+WB8gWi6gNSbSBkjJGoz2d3u8145LcLjQbCDbQNd
AEDNuRiBbMPgYNV9j/c8paifr27fIc6l9yFTscd0G8Eo6hu7722TwmefpMnYEowQ
1lPa53Dh/YKQcelNmatGtYqNv5sW6/Y6gYpTuFvE4p99vzn6p03E9WG/CstHTL+e
7bOO3NEornE52+dygEDSvR8bATx/lk3BeA+p78VZbm+yfdWXU/SoWulUDWlfFBYk
CcZd4jCJIxfxr548d41+T6oadtcPcJQ6wzrWpNGqg/c08w16cwwoeKfZYGXAwhxF
wQCCprCOl8qj87g4SHRNBSWkXfrcgvRe0wzQXY+ZOZiXBRiC7WBA1bQsLMYAVAW9
bIHsC3UZ6e4GdMWqg8WURbpoMp0Q43dhlY2T7d8UCTaBCRDt2Oc=
=vOAv
-----END PGP SIGNATURE-----

--VUR1LIB4SM0rQIBT--
