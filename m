Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3935718786A
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361013; cv=none; b=nTt1Qh/JH1sL2MS7ke6Xjl/x+VoWAElVj+5hzGRIS2iUaRIfw17w6MeUgoSrM2VLBmD6wAaQKMCAHAu2QESyUMOedqPB69eUxRpxhFtjKzmhwpz0kVlOmB/p/EVUT3+ZUHzQ0ahfi/Ty2FZ2ZiueYAH+iHSVbwo0mHvwZKCMQQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361013; c=relaxed/simple;
	bh=OYiRtAflB5iadWfTLCmpZHC8Ib7HMdltVJvtsAodO6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pT8rxKcsenTsFj1hgigkzdITwCQ+AeVr7UNijw2V0jQbP7ivfl9kYDYGL9HfOWnsVQEGPyyp/X/fYuo3lAijCx4LBwO4VL5yHNGPw9g34zVrJMEO0hbQFOY/J9Ml20m1ugt1Ua0NnPXC4oyvUq2aSP52h4ua2/6Xdoi+NO9tz/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=doZZ5pk3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Th2kucyT; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="doZZ5pk3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Th2kucyT"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 83ECE13800AD;
	Mon, 25 Mar 2024 06:03:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 25 Mar 2024 06:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711361011; x=1711447411; bh=NxvyvfX12a
	EIroMEWyoMiEmdt8+96uXWqX5LCxzg2FI=; b=doZZ5pk3Z80Dn4ch5Q7mOcb+rk
	6sWfOiJ+uiqCVBjfSc1eNmag0+GPum4bpm2XeCQcM3WlATMLcJuialit3chJ8s3M
	K5L2ZCSiepdZ3Gk08kRV6IzOmf/WEbyTTixxllmhqbziTMST8X9oClMd/zA8Gdmq
	hIszDVv7AkaHpNfCb9z19/RGEpU08J3XQ/VCbawl0+unKjW1ZZgp9NYEYwryV9l2
	iqZNg5B+fiuFDoVdPDd+4E7wxXjxkVPXw3Q9CofRya8PQ3lNam42DrsxBEnzNdU4
	0Qr+GS9Jc/vAxHZv2TkAwSgYB0ea+q1F4dg2sqJfexWPcqtJoSb80kkrBqZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711361011; x=1711447411; bh=NxvyvfX12aEIroMEWyoMiEmdt8+9
	6uXWqX5LCxzg2FI=; b=Th2kucyT7+CAL8P2x7ZYKu/D3MTlIkk915HPNyvp2L/P
	P76F15d+l22qvU/PW+8DKvaPi+Mn+TvjZowuJqSYmKJjaeFceSN+85TCosY0+YSr
	/Vj+T+XD69T2874ESJPeJGEPKXk34dASWdafTFT4OFVDL6CTukbHwGtmAG2CYY61
	I+onqnxJrT2fXdfnY/iiDwZWKYB4z9SgsQuDj8tPrPmM9i41PQzkNVu0UVWg9r63
	FeIg3RO2/PBfyqQH22YYtpAgrfRQIxLbALSTRlM5wq71+zIYr4/qKQ+w1JA+gayG
	SsIqaDozhde2fVPY74apfU8sdxCcSCnviTSdnclOgg==
X-ME-Sender: <xms:80sBZpXGKWDYIVHHsg9GGXDCTv95X-B6mB7rNTaOsJkUYkrMwEBrkA>
    <xme:80sBZpmHhQnW4djkodgEo5qifE4dSgUJHvSKt6wSXVRPhIWdcg-xiVksbWzo9iF_Q
    IBejJtzVavp6BHDsw>
X-ME-Received: <xmr:80sBZlaKGqw0Op--oK_AFIMjryVddvHsisjvydxVAt03kPDQm19O8wKwpL5UWFS3-yDawMXBkJq-BjkereJ7J4jycYHKcfL1lB_HJVmTxG4iZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:80sBZsWWwX-hDPqln9ysijvw9pGjHjE5h-VikL95k0xHZ2z1fnKA3Q>
    <xmx:80sBZjn0wWKHy-UUmimVtQ62vamrYWstbW00LxpQ0H1yiE5B55CG3A>
    <xmx:80sBZpfOcmELU6D42X8Zept9480bMQ8e_O2OMmPA7uXXzWORPWbxIw>
    <xmx:80sBZtExT3sfLESGc98qsrbpDsoJqAzwrnBKWNzWXkaUllhF_39j6g>
    <xmx:80sBZsDJTGxv2FKMEXXVPIGOBDpSIv84_UVw6OJXpQUIZIFCs1Gtcg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:03:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dac07008 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:03:20 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:03:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 13/15] t6500: extract objects with "17" prefix
Message-ID: <9657c67b3b9136be27e469da40ef0520bea6598d.1711360631.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
 <cover.1711360631.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wk6Eh6cbuIuTEDf1"
Content-Disposition: inline
In-Reply-To: <cover.1711360631.git.ps@pks.im>


--Wk6Eh6cbuIuTEDf1
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
2.44.GIT


--Wk6Eh6cbuIuTEDf1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBS+8ACgkQVbJhu7ck
PpR2nA//fU6Kib30UpQ/Ypocvdj2syjNPbx5ryLaExE6kfFuuZVF0QMuxubcQYc4
6LMTyC+W5MjqrqGDwvu8hKURivW/z/TqBpUSJGXAxEk3pGd5tzW38mUqvWr9Nx5K
vjYbhDE8ORVuZW7WRAOVQjek52dyoQRec231Ni7hNhijg+Rv5bktBy4MbDo9r//j
npFEMGIU5fSkFKVp1qedMV7I2hoNIuMdBAd000/76nLxWLmHVr3tLbypVCWI53wF
Tj5mEVole015agO3mI6OJhfBjCDaTIAnmYJYRtRdbtxvyPQy/isFYQTL133E1JVO
qeNQHywz4RZasrDjb+VeGovbQJxhUcYMrocDxTFJTFFVo2PEdZEZTm5fGQ9zOkgM
+drSMLC2OWLI3XqUpodduEJCMNwiurueBdbmY3XebX/3UulqA7lXAaBFYjs9zsqa
Q8/dZf6zKxttk3Ua0TefMd0gPWyvUXglVdR08E4vYMyVI2e3LJXJ67NEpzJhoDM+
TBWjg6J2bd4C+tGFaIy9bJme5TTPjtYmZrK/IR4PzbztcvnU+MEM+Yv2Jdut3E1p
QNjalrLbHggW3452ro6VbenE/p/ZMCa3jQv4mWsc2LNa5UBe9CELVtkgTIgBPtvg
rATimEdGSQYtpfcSOxBJo2b55p465ORO40oD4hMQR+JsNu7hZv4=
=dtX2
-----END PGP SIGNATURE-----

--Wk6Eh6cbuIuTEDf1--
