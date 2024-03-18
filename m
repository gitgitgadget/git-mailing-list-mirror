Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93A1381A4
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759208; cv=none; b=iG8kKegQYflBwNYqku3NTxAVBiIDuH1k1L+MJc9hT/59f47XLlFoOhOVJi1HLd8X8ledEsiSpow/werhJ+8sRol4nAXUzYnkA0JhUezCGX0FSrzdQptSm9bXcHqPVmztOF0B+b+OT1cpoA+ozVLIhQNC+aXivWb4XXR3rJLzf+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759208; c=relaxed/simple;
	bh=KyPvVSJIncliUNEsdSMnhy1RivlojMLRXZ8lgmC/CgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iserblQIywGD9P7x1zNUYqsbZjzM6TT30OP3/rwlI3D0ufI40LbpOHo9NWDkmA9u/wL4/hKYSrcbyqCfKPrYbsq5avM3R0HW4kmeGK0vAFCH5PRH3fi5OOSZ8aDHpuOpvbvJK9d1obqRFyuQ0po0S7pQ+C2wCiNpRn7PzMZIXXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RvzQ12o/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WQ70OVyQ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RvzQ12o/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WQ70OVyQ"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id E444A13800B8;
	Mon, 18 Mar 2024 06:53:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 18 Mar 2024 06:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710759205; x=1710845605; bh=PQOo5aifmg
	NDdsxHz7CMh7vVnHPe/r07M0VgP5TwfjQ=; b=RvzQ12o/BE6hiJFacytYtD2BwD
	FjGb1K02jDpbPu2q70chQVcOgfxT3RR4zJjV8RHdF5R8JV0W7rQr2GnjtlsmYuXS
	XtDPNUlfjayKB0WUBB9nVxKZiL6itpt3c5gB+2yQQ/yc77V1K5DyTBPTwx6V6gpv
	Eu32JGlAG6W4yK76vtYzJjk2vlVxTOmdpA9oFKzquOIQePqA7OkyIM47lZscP9Ra
	VhPcCJghXkUJbQwhTdeQgQToPvNrl1+XJBc/8fsOGHVUuGA1FUslxLDPtIhuSVJL
	Mmm4NY7JIZs/FqAQ2LqONFcV/5zxUb4yx2JufmoBkgv5reU6PQZnIusOfblg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710759205; x=1710845605; bh=PQOo5aifmgNDdsxHz7CMh7vVnHPe
	/r07M0VgP5TwfjQ=; b=WQ70OVyQv+mPO/BRKcs7cRMzjn3YJ0r5UxXnYJ7K0ZkX
	x+reNOFJe7CX1HZwbG4H3D4m1Mswrh91osGlso6Z/ua/LJV8+CSORUI/k9HsOaN6
	xFdEaEddj3qZzI03b37PxMH4OKFPz498fNv/21HwqtEi6+zqMUAL38kmwvsnXSk2
	GIkUh08TN/t8qqNgKaGw+wEHqwkfk7ZLTMYXit9wjoXwsoxHtKK21JRKFqdcrkKm
	Ekn/heHHtQBKBp1bLmmDvytmGVZR8d3sX1rn4+6DMwaOGESGZ4xp0DnTN/2aP0fd
	d585xR3+RldptRJAFPx7dYHhFk73fR1hf8xs6GqCQA==
X-ME-Sender: <xms:JR34ZWwR740A1tqpJ92d6GMWroypzBL6BfnLgaiytbB9MuPdCJVVUw>
    <xme:JR34ZSSP9zd8iz8ub3SP1qnK1I59lXlISmeDUEj9zy4D15HCt1CRZ_sSstyTfJALO
    mIoocQAQd0s8NCRBQ>
X-ME-Received: <xmr:JR34ZYWikmPQURGPTWv_YPBLrjYBilPeWJ2MDIi6wQpc5xWIoRIKx2NgXmyWeXASSt2d1D87odd5NcT3Y8-6ofnacu8nOu36_qQUaabppqYkvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:JR34Zcgc8pBHgFHPUrGiNxOZJiBT_gerQCvwFKfc19NO4Ka6dumNSA>
    <xmx:JR34ZYC1lXEKgHLcOAz5Ge2jFItN1TBfi6rIOu-dFol-BF1JcO4btw>
    <xmx:JR34ZdLjtbCP7Brxwldz048XpD-VXN9M9xPnEOaMeox5SuwD5AAXLQ>
    <xmx:JR34ZfA9Vjy8VdaM7VYifhZSOLt5d7ATDPf4_GuNLwjn-BelKWzwTw>
    <xmx:JR34ZbMx9AC5R878c9_Wz5-GKJwoFmLz2ycI2h_yWuFHT_GAsj3OdA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 06:53:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e4755ce4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Mar 2024 10:48:34 +0000 (UTC)
Date: Mon, 18 Mar 2024 11:53:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 13/15] t6500: extract objects with "17" prefix
Message-ID: <817de1a88f2fc5edd8c113da2c49636a12ce0725.1710706119.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LSac9+pYrVco+Ut6"
Content-Disposition: inline
In-Reply-To: <cover.1710706118.git.ps@pks.im>


--LSac9+pYrVco+Ut6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ".git/obects/17/" shard is somewhat special because it is used by
git-gc(1) to estimate how many objects there are by extrapolating the
number of objects in that shard, only. In t6500 we thus have a hard
coded set of data that, when written to the object database, result in
blobs starting with that prefix.

We are about to need such "17"-prefixed objects in another test suite.
Extract them into "t/oid-info/hash-info" so that they can be reused by
other tests.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/oid-info/hash-info | 12 ++++++++++++
 t/t6500-gc.sh        | 30 +++++++-----------------------
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/t/oid-info/hash-info b/t/oid-info/hash-info
index d0736dd1a0..b8a5bcb187 100644
--- a/t/oid-info/hash-info
+++ b/t/oid-info/hash-info
@@ -15,3 +15,15 @@ empty_blob sha256:473a0f4c3be8a93681a267e3b1e9a7dcda1185=
436fe141f7749120a3037218
=20
 empty_tree sha1:4b825dc642cb6eb9a060e54bf8d69288fbee4904
 empty_tree sha256:6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74=
decc5321
+
+blob17_1 sha1:263
+blob17_1 sha256:34
+
+blob17_2 sha1:410
+blob17_2 sha256:174
+
+blob17_3 sha1:523
+blob17_3 sha256:313
+
+blob17_4 sha1:790
+blob17_4 sha256:481
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 18fe1c25e6..43d40175f8 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -11,23 +11,7 @@ test_expect_success 'setup' '
 	# behavior, make sure we always pack everything to one pack by
 	# default
 	git config gc.bigPackThreshold 2g &&
-
-	# These are simply values which, when hashed as a blob with a newline,
-	# produce a hash where the first byte is 0x17 in their respective
-	# algorithms.
-	test_oid_cache <<-EOF
-	obj1 sha1:263
-	obj1 sha256:34
-
-	obj2 sha1:410
-	obj2 sha256:174
-
-	obj3 sha1:523
-	obj3 sha256:313
-
-	obj4 sha1:790
-	obj4 sha256:481
-	EOF
+	test_oid_init
 '
=20
 test_expect_success 'gc empty repository' '
@@ -114,8 +98,8 @@ test_expect_success 'pre-auto-gc hook can stop auto gc' '
 		# We need to create two object whose sha1s start with 17
 		# since this is what git gc counts.  As it happens, these
 		# two blobs will do so.
-		test_commit "$(test_oid obj1)" &&
-		test_commit "$(test_oid obj2)" &&
+		test_commit "$(test_oid blob17_1)" &&
+		test_commit "$(test_oid blob17_2)" &&
=20
 		git gc --auto >../out.actual 2>../err.actual
 	) &&
@@ -146,13 +130,13 @@ test_expect_success 'auto gc with too many loose obje=
cts does not attempt to cre
 	# We need to create two object whose sha1s start with 17
 	# since this is what git gc counts.  As it happens, these
 	# two blobs will do so.
-	test_commit "$(test_oid obj1)" &&
-	test_commit "$(test_oid obj2)" &&
+	test_commit "$(test_oid blob17_1)" &&
+	test_commit "$(test_oid blob17_2)" &&
 	# Our first gc will create a pack; our second will create a second pack
 	git gc --auto &&
 	ls .git/objects/pack/pack-*.pack | sort >existing_packs &&
-	test_commit "$(test_oid obj3)" &&
-	test_commit "$(test_oid obj4)" &&
+	test_commit "$(test_oid blob17_3)" &&
+	test_commit "$(test_oid blob17_4)" &&
=20
 	git gc --auto 2>err &&
 	test_grep ! "^warning:" err &&
--=20
2.44.0


--LSac9+pYrVco+Ut6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX4HSEACgkQVbJhu7ck
PpSVkw/+Kaym1mEnsFz5OwMqMqNLnMBy4sdQlIN24+OZ/t8C8U7o9T7NLf9y2PeW
notvYx2B6iN6QXdqZAQoMYeobWeatVcFwVHuefzsUj/7lcKmbW57KyKQHEEnvFtW
li5LfMo12IEH90wQolqR0VTHvmcRY63COFB0Z8GSvUHu6aZoL1vOjqGVFr6T9Q4u
JHybA05IjZiYR6/66xxRArtZPHuh2zC2kN5EmWhNFgRPTXzoQt7qySOKfPpYTnf/
NKYsXyMo7ByDUI4Q2OCcNyMwP5LcM/7S6Lz4a1oL1Xxt/LVmgo8Pm7Cx+Xvdy8E0
whXYyLOnfsEsMlRpeAuhobgUljX8AuOEiBDjuYjT43PYKtifyV/3loucu8Lbv6A4
gMjF/mVi0Ua20BlakdtuX+gwQQop1nIf49BYxKcNOpI8zcCXOV36RB0uhqOskkGN
qlAafwH8kT3GdwLySa2J0JCQAlSsRAmTJB9PXnvlDTfPfgVtuu+w0yx4dVdl2np8
gKOMt0gXctPE/4mRHda1NFK5AOf7GQ5GCo1e59RJM3uRzeXtJiVVI79L2HTDq5ew
4sYDj3RLM0mlbKFzDsa97FfglyJbifgX2alMxfQkXYJR9ZnsLczoeVIFoKj5KOlf
dJHOOvZl8hM18lAue4wDdTYwy7+MmPL5g/mnu8O4o4Yb0nnc68k=
=gH8l
-----END PGP SIGNATURE-----

--LSac9+pYrVco+Ut6--
