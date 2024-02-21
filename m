Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424E669971
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519053; cv=none; b=sXTpSF9i3FSfGTDN+U1GCA1r9JEoH+kLepc2iv3/EOIvAVIiJRVeIomk6FPNKuPDWmuHh3qDYbrWH2C3Xcfcp7FLEPcXDCXWy3EU+MwH4olMsSy7u6/RTHUQX/pHIdiSc6ITSezSQouODTADiHO4t8eXUJI0W1RshLSeDtOySLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519053; c=relaxed/simple;
	bh=lgisssvvaUjbj2bs98HIl2Bz/iC3yfZl5SQqez7b+4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCzRBAb59FjeaMLZoO5ikH+lupCb9bokDiXrL0Kv25dixrqz3EraZf6ySKPk2inPRALTRTd0YAaxhm+K4tyehB8kMyxIHqADDnc+aFln+LoQVR2D7+iZVLWuVUtaoZSsRngiOOcUNeRT7M4Ajd8BNtQXc4ZUZuXifnif8rdr1Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TkAtaKlp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dr3NXQ2v; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TkAtaKlp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dr3NXQ2v"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 41E241C000A9;
	Wed, 21 Feb 2024 07:37:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 21 Feb 2024 07:37:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708519050; x=1708605450; bh=tuwVlfJtEb
	lwqlT3SjBBj0z6rzmj55DeyfEOKkaRAko=; b=TkAtaKlpDJRi6mIMAoe0hrCi33
	QnsBhbVow9sVJSvmZxJ6Oj7hK3Zt60yjFFGrsl2wlubnzlSnROy9GasRBG+XoycG
	lliAiyDZmXT+9oAV3Jy/vKYlBLyi8fjvMQbiHOTjVEWbkQMLhEoqZKSzV0Lz5JWd
	LK96V8pkXNU3J91h+qOZB7HLk5cyxyAuCT7HZB2+N4riCMdcp7JxDlj/Vtw5+O00
	qKWBojiURJGqwfZ0kcz7opUy1CrtzESqRYGlk0IF9IlpPvOTyROK3565mPDSFrHP
	Pw1qRZ2MVfz43YCNWRZE8RDuMHZvJ5Fj26FNhqWUg81m8zXIr7a+xqPV16zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708519050; x=1708605450; bh=tuwVlfJtEblwqlT3SjBBj0z6rzmj
	55DeyfEOKkaRAko=; b=dr3NXQ2vhdz3N/Z7hUCHsrHFpGunl70otpiKoc4HfFng
	jEq/Jh1CIwxq2ihsdaulMpdoHlPUTVMH2MVCi+/qonGSZY0dYr8cEFwjfGsorGIZ
	3YgsebgLio2A+3y3ljCwZMbZlIvNWYwIn8iCDGbfIXpZ9Jj3FHk9xcyohiSyhDjp
	awE31+JSOeqr//7euYQNmIdxAJdTnD+h+tIRor94GX6oDQOHHZVKZvajSlR/94tA
	ympYOpFkTnNKovZSqFefnOZi95G4Wg2bsnBnR5P3741na6NPx7m9fJjqmOmt4NXJ
	pk+BPHXVwAO4V9DzFfK3kWdZpzEc8momjQO/vsSt4Q==
X-ME-Sender: <xms:iu7VZZ4_FMCEe579u6rIYA0zzZlOXEEET9sECP5LjKX5lebj6S_ASg>
    <xme:iu7VZW4mZetSNBTPncxXuZ4jKQjfTPTSBEBKm5HwV_RZq7Nndq3L1yFhiWUxmwxBB
    JVbg0le07E_NiNlOA>
X-ME-Received: <xmr:iu7VZQeJYOPha0relvYceMjxzvn1E1rI-Zsk5yrOY1CcjN5qZvezsFXJWspGuQwkiLV47N2zd2A8YAknKLuI3MWQ4Ms5BGWT_y66yVabw5n2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:iu7VZSIOjjS0GHaITNQyBvG4f2JgMatz88L_iNrJMLa3BxUBdwaTwQ>
    <xmx:iu7VZdJUysCFn2pwL644Oa-wNxKfVcmdNSaEhyqHZIa3u8dfG_2GRg>
    <xmx:iu7VZbxl2axzPk7XkIrkT80QCK1jHfEeKW6YOT8u4xvunMFOhQz45Q>
    <xmx:iu7VZUVq6PF0mSizeJPRk1fFa1nskgLK9H2OHNlndO--6HRA6Y-oNYmdUns>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 07:37:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4dddaf2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Feb 2024 12:33:25 +0000 (UTC)
Date: Wed, 21 Feb 2024 13:37:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/8] refs/files: sort reflogs returned by the reflog
 iterator
Message-ID: <8ad63eb3f6a9819db57cd4523297cda6e4ead341.1708518982.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
 <cover.1708518982.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v08557xVDH8w0LrF"
Content-Disposition: inline
In-Reply-To: <cover.1708518982.git.ps@pks.im>


--v08557xVDH8w0LrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We use a directory iterator to return reflogs via the reflog iterator.
This iterator returns entries in the same order as readdir(3P) would and
will thus yield reflogs with no discernible order.

Set the new `DIR_ITERATOR_SORTED` flag that was introduced in the
preceding commit so that the order is deterministic. While the effect of
this can only been observed in a test tool, a subsequent commit will
start to expose this functionality to users via a new `git reflog list`
subcommand.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c           | 4 ++--
 t/t0600-reffiles-backend.sh    | 4 ++--
 t/t1405-main-ref-store.sh      | 2 +-
 t/t1406-submodule-ref-store.sh | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 75dcc21ecb..2ffc63185f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2193,7 +2193,7 @@ static struct ref_iterator *reflog_iterator_begin(str=
uct ref_store *ref_store,
=20
 	strbuf_addf(&sb, "%s/logs", gitdir);
=20
-	diter =3D dir_iterator_begin(sb.buf, 0);
+	diter =3D dir_iterator_begin(sb.buf, DIR_ITERATOR_SORTED);
 	if (!diter) {
 		strbuf_release(&sb);
 		return empty_ref_iterator_begin();
@@ -2202,7 +2202,7 @@ static struct ref_iterator *reflog_iterator_begin(str=
uct ref_store *ref_store,
 	CALLOC_ARRAY(iter, 1);
 	ref_iterator =3D &iter->base;
=20
-	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable, 0);
+	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable, 1);
 	iter->dir_iterator =3D diter;
 	iter->ref_store =3D ref_store;
 	strbuf_release(&sb);
diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index e6a5f1868f..4f860285cc 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -287,7 +287,7 @@ test_expect_success 'for_each_reflog()' '
 	mkdir -p     .git/worktrees/wt/logs/refs/bisect &&
 	echo $ZERO_OID > .git/worktrees/wt/logs/refs/bisect/wt-random &&
=20
-	$RWT for-each-reflog | cut -d" " -f 2- | sort >actual &&
+	$RWT for-each-reflog | cut -d" " -f 2- >actual &&
 	cat >expected <<-\EOF &&
 	HEAD 0x1
 	PSEUDO-WT 0x0
@@ -297,7 +297,7 @@ test_expect_success 'for_each_reflog()' '
 	EOF
 	test_cmp expected actual &&
=20
-	$RMAIN for-each-reflog | cut -d" " -f 2- | sort >actual &&
+	$RMAIN for-each-reflog | cut -d" " -f 2- >actual &&
 	cat >expected <<-\EOF &&
 	HEAD 0x1
 	PSEUDO-MAIN 0x0
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 976bd71efb..cfb583f544 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -74,7 +74,7 @@ test_expect_success 'verify_ref(new-main)' '
 '
=20
 test_expect_success 'for_each_reflog()' '
-	$RUN for-each-reflog | sort -k2 | cut -d" " -f 2- >actual &&
+	$RUN for-each-reflog | cut -d" " -f 2- >actual &&
 	cat >expected <<-\EOF &&
 	HEAD 0x1
 	refs/heads/main 0x0
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index e6a7f7334b..40332e23cc 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -63,7 +63,7 @@ test_expect_success 'verify_ref(new-main)' '
 '
=20
 test_expect_success 'for_each_reflog()' '
-	$RUN for-each-reflog | sort | cut -d" " -f 2- >actual &&
+	$RUN for-each-reflog | cut -d" " -f 2- >actual &&
 	cat >expected <<-\EOF &&
 	HEAD 0x1
 	refs/heads/main 0x0
--=20
2.44.0-rc1


--v08557xVDH8w0LrF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXV7oYACgkQVbJhu7ck
PpSnqw//chMWkxSEcu5O3QEreNZd2jFqzqWa7Etr2wCpK2JWQmWmSuZ69/XbW/f0
gACnk4RkNqX/9PXfsNN6ICFDl4oUzZJpmB1+rHCXIHxt+1ig/U8hw3tiwrAdzrin
gb2VcpqNZ8NvkYQ9wYoHyC+HzpRIIgjacrLl2/OwitrwFh8Ten/Owry9MfPvP1ZY
eCLdqAIJzHPa4Eenks8zpJUq+Dy4i3WnlIkHW0ffsSO03THFz0cVcfj1JibZC5tZ
If6OdeJZwOzSmW5yz3VZAfeaQb/aTHQiYipc3Ih1hZmODxthX1iN1RwixQ08mADH
MUqymGzSMQ60bI5zLSigDyAMRhkA+NNYwI2vXUODfViAUoCUsxbikyB4A8Wfzw4L
J7ccgwYwMEgXtddD1/Yr7hdauD3/oKn7L96F+AVAcNtt1Usq1ed9A+E4A6o7mKJ/
flinPrDwvsrq9PF2SMxRnmZOA/hzIuxbSObfiJQ99igSwAvFHrFZRVLGmCeQJ/3+
XCdZCGkPjRyeDZSuQCZzKim+4rIEjSecpaKmoPMdKkNLwPYFu+OUoPrOps2QPg2I
+uflp9spG5IZtC5ymWJthzsioejcPZVEIzatYyldHkXbpGf3oierW/8TGtr0SFJd
WLlldrrx+vP4VJ30xxd3DxlM7TuTqClczmnuInSb2Egz8PBlzH4=
=A9LG
-----END PGP SIGNATURE-----

--v08557xVDH8w0LrF--
