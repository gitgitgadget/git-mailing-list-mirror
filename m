Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6095C37141
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353333; cv=none; b=fQHAkPQ5LYfNuJUxk6UhOtDHSlUMDrNkLFENQlYNZ3goF43x8K4aGZlWYm0miYd/Qxe9f06XcfQxab1h4GMuH1GJvXI31b2J5TylODfpWHiHafKxdpvFXzkBQ9v+y9Y9kFRTd5JfNhb9dwrcDcgFwGW56J6doziV+RLiQqiEVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353333; c=relaxed/simple;
	bh=orVAGsRNtB/2hkePHUD69LDhsbm4LNMt8RN8mdwV6Kg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiN/Kd+exSJH8iE3BQ3P8ChiMcSQTSVc50xwWFYn7SFJ8UZE+5awU6NJpqOfxDLS8tZGedQE4805sgCYqsNJeBP2KwRW36ouIBD9NXRbP2nYshzaaDIrOP9m4IQRaQiljM8GlqSjk8jCuaw/Gi87h8dPfHnwbbw+XHRjA3AOtFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XR86Xn9J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q0Mv3hhw; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XR86Xn9J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q0Mv3hhw"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 9FBE95C00B7
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 09:35:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 19 Feb 2024 09:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708353329; x=1708439729; bh=u6GXE0FFoC
	/lqicu3wBjRzx2P3HR3nKNGw0t+zCfOmI=; b=XR86Xn9JWm6/aHxJ63WsXjFBnb
	GfeYENv0XpSzfrV3bD0pFU0FIIMY9WpGne+mwB6i/ldSAHtDflz15VZdGAfd/vpL
	72vkLtQ7c60TIzLnCInsY2GBlaF7tgOW50gxooZBX+UisAmAVWsxKFQxqEfVno5K
	QzKgzS6cSLw18eARLgA52myCPgR1APRWulPIDh9xYnJ3XofNchRJB/KKc0bgsTmB
	nMCeCyC58TdYaGXTTR0RwyXULXy0Wpdh4sL791ETb/9e5ODaqaB/1UW63JjNnf4p
	DxP/TPxR4kvPllubaDQIH0Rg/gQfvPOYkAIM+HLkR0ZA69DQtb7FJBHTqJWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708353329; x=1708439729; bh=u6GXE0FFoC/lqicu3wBjRzx2P3HR
	3nKNGw0t+zCfOmI=; b=q0Mv3hhwPgFUGP4pslceC7oLPvIjnOj60vbjGqXo+Ltw
	5D1Re5EqMM8lhwKA/EUhYvoGnvxKPewsBsO1aEU2dRzS/h2yDO4m++ERmGTMveDp
	dFVFetf5o8x8z1XtAqIYSwq2XZo+f40MoHial/7LP+3wx1OlA9uZeoLZwGWFjuNv
	pdCbHGHhztQb1hDlBRDBWqvMdtvhv0EuTFlbYRgkfNvJX32c56gIW3DzC2gTWfIQ
	LOeWb/UG3w1/1Cwb/J310uU1ErMlF1044pY6IbVHjRi0sZKJnJcnKFcXDJjPdMNe
	VxMYk+q2FnD76p2DON2MqqnbS6aAa62c+IMYEfiqyQ==
X-ME-Sender: <xms:MWfTZYlpc7Xz2MHEZHLH_SXJfkbhAZaWsJi6b91LmlHXvjegWFvEqA>
    <xme:MWfTZX0hN1NuaPtr4K9PRkUDm2o5LGWPeHRocTx9pK-Ml4BZTNPqzUb_JunyKdd8u
    OpUv9f200fEqhiH1A>
X-ME-Received: <xmr:MWfTZWroKzPBMvloP1dFjBTpPsvchl-TEBZwhLl__aEV1ZkmpjKCzgMaM7tQeSQAU0O4b0kqFdlsN6vfB6q-iL96uZ6cTbssuCn1WrM3D2WmOQyF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:MWfTZUmdHK8GtnuzlWtJU-sVFS0X-cJmzaa1Ojiw5yRgyEpbOTbwhw>
    <xmx:MWfTZW1SDs7S5renU2aMpkSAnfLhGqpIARiBqeHP70i_fHt4b1RWqg>
    <xmx:MWfTZbuiiZ1-jQj9pq1fXQDD1oCJtPDFVII4UM1UQxKE3n3GQolVIA>
    <xmx:MWfTZb_ooXNjYP_T3BZawoG--lcYpENLh7o5UwhbehPQPoAgciLkYQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 19 Feb 2024 09:35:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e98cb71c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 19 Feb 2024 14:31:28 +0000 (UTC)
Date: Mon, 19 Feb 2024 15:35:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/6] refs/files: sort reflogs returned by the reflog iterator
Message-ID: <e4e4fac05c7f4bcac8ef96bdebb8a68eef40ead4.1708353264.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OqdV7cLGlPJHhGKK"
Content-Disposition: inline
In-Reply-To: <cover.1708353264.git.ps@pks.im>


--OqdV7cLGlPJHhGKK
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


--OqdV7cLGlPJHhGKK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXTZy0ACgkQVbJhu7ck
PpQNLw/+KV9ra1v4hUMsz1XQcktFfTiar1LM2pb90OEHfrwp4Lyl9MEf2APB2LXe
a5pjGZtM0JihKetMWMu6WOMIvph5Xl2qNSdqT9J2cAGqIlfySPhy5d+RU2uGonNm
yCZ3hvL1fRLdmdwG4x/PfcmJP2vUaCZoygOT7rxn1GfCYi3xxy69NVrh1S7A1B23
oYF7oXbe3U2zgbpd4Gc6b0ryvYuoEUA2s6DC0/xC5qlhraHElNhidbORjLNHMXzO
6j+CQs9l6FhTrsLPen78Q3d0KgltaofYEwVpe/5GlK/WZVhH0I6ca5nAgqxO7UvK
/l38Cuwoa7Tn5eGNAB1Jp3MrJ6KpDjm3yK2xfUdBBHelYd1z3jBecADq0ts33e1b
UrqCaXzmanLc0DV/GOvXJG5F7uqXPdrS8bkehG/KUQTm3Fxm4mG1nwSliPmZ6xMy
slnbircHVL1u5wWlUi2Mb2XXEs9AIytDp9yPrqSSjYhdYt1bJRHqd3NTekD99uGg
c69ODwrz0k6HBnJACTvpfMI54705CN2wTTTvc8Su7xrUmaGMgDTZocFI7foIKV8k
Bmm/7uniir6t+SUxqZ2Jfpj0kx5OsN7oV7dMNREP6GLY0oKbTAJLVRmZruCy/oJ+
tNd6fDFBtgnEWO4iDISY/EFGUikcrFUCMTalqEcrBkpOLaAMtuU=
=vnY2
-----END PGP SIGNATURE-----

--OqdV7cLGlPJHhGKK--
