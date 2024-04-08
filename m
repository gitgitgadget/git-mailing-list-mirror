Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F150E2555B
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558831; cv=none; b=U9cdLZhhMcoMq+v3FupfT2dt2e5yydoCYOwrcyu7YB+1BmaT/xuRQc9vxnBlGbgyI9jMXGauyaYl8JWCrIo3U/HY8jj3YohCN7b0uYOI3RbKq5PMlJY/Zjh52Sqd00miV4Nbah/uNbKoTIZZ1N/TEXLWSqKGTG/GAA93hGwWuoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558831; c=relaxed/simple;
	bh=j3RT6X7wqpcSfzUooWb+J15O7+q+WlgU9bYTnq3qI+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPU6Qt+ya4ME4mhMzb9e6aZcrm31MFcKV3Fq6OpcdJWMrAAGDy69ymaoO6mVXbA2+gAEnz9H1A4ohk5zMNirqueyIpMibXbxFy9yIHi3URYG2ft6XkleOq7U1JcGQAaOgLIctWXxSOmnrlYLmt5tL0SLgt3+nOegmh7bJus3+u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JJh3m5Io; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nUrTPJCL; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JJh3m5Io";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nUrTPJCL"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0BE2C114008D;
	Mon,  8 Apr 2024 02:47:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Apr 2024 02:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712558829; x=1712645229; bh=cCJgX/2PTr
	sENvU1E5Ppq3bOkhjGaOOPTRV9dXyMUTA=; b=JJh3m5IosqkEC1O0vGNaUZ1uFR
	JTCR2jq/1Xo4lN1tKQDaxGD2k4VomZpAfFSvDUg5eVryB9G4ND5zoiN0W3PS8ZZN
	/W068XWWb0hzECqskzph6Pa1XovTICKVTpX5BXDfqCpnv38p5JVvVpk/dvfAIAH3
	PT12Xegte9UzOWwfFryKB87T2q1aYE1/Nl4xXGrj0jhL62yMe4dFyLUH4J8OzpXt
	VXOqd+ngoeFbYsp4VoybBFKIs+IT+s6tTkwc6jwxCPIP8va+BZD3DIkYgTi6lANZ
	Tlt+ITyuDw6QRxZnGkR5MVFLsHw56GCJN2ucTYzIOfHoVyDwWPtpPkjkFweA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712558829; x=1712645229; bh=cCJgX/2PTrsENvU1E5Ppq3bOkhjG
	aOOPTRV9dXyMUTA=; b=nUrTPJCL/T7QQ/oJLEJlHG39vDzkbP/wDZ8VXYthe3ox
	ckJBET4KC5z/Cm4EKssO4HAiuabDRj7kc2OVtNgK60fD9BqQn+Fm54w76+57KTju
	9CnHtFA9oYt1zE4jvv4XqheT00xySntNiCJpIULhDI4EltPo4MkYyagTQJAP0+HX
	+mXrr1z9Cx0HjitA7bjcc0rNPYvDuNWwKm1/K3TKv9MKKVhwLa88EP5puisxA6v6
	OAn6OzZIXKP0uZwwhYhwIpeM/FKUSP/mRN1oSHSB2Y/B4P3eUxx9+kdY2nt8/eYT
	TJmoxzOLJuPdBexg07KRxda0PA3jeecSp/uV884lPw==
X-ME-Sender: <xms:7JITZgNi7aX-yZoH6l-jdAvKUvgAKNGht6MUXkkdwe2MiU6pjD-IKg>
    <xme:7JITZm-J2yhvHwSGWlJ0ZHStmN9T3U5VD7EKqpf1ZcYRhP4kgj7gh-R-NWfHeOFpO
    3Z3Apcd2VXvJJvHLA>
X-ME-Received: <xmr:7JITZnSWp46xq48J1-nY8VMW4hrK5eXjHnqRIti6Py1xQZjdVn6Hcc1WbzNsUPi75e4oaL8z-ZI982NDof8FXWe85l7Zqtw4-fcqBq9jhcYmoUY6Vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:7JITZouzWt4D__DCA5xKHmJvmzH9-QcQNm7DLEbV46ZPQ00zWskKNg>
    <xmx:7JITZocYVXSm4lmEA9p8Kw2mmQc7pADoKLpHu0VprvCUbGpGd3j6Pg>
    <xmx:7JITZs1XnysWzi8OhD8LDjdYm2Sh6hu7hbdkPdrAPxTD-LGfFjXIoQ>
    <xmx:7JITZs8hVOWkxDFmgwU8pV6bFauzmDLEW8Sg6BOjyZsILTjZzZOVDQ>
    <xmx:7ZITZtG-POmcqdIZjS8C2d8I0JXOYMj7YDw6nGbFvLmJc72bVgXORGKP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 02:47:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c6147270 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 06:47:01 +0000 (UTC)
Date: Mon, 8 Apr 2024 08:47:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 12/12] t0612: add tests to exercise Git/JGit reftable
 compatibility
Message-ID: <160b026e69547739a526fb6276a895904a4d33a8.1712555682.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="El6ukuDtK3DBWjHL"
Content-Disposition: inline
In-Reply-To: <cover.1712555682.git.ps@pks.im>


--El6ukuDtK3DBWjHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While the reftable format is a recent introduction in Git, JGit already
knows to read and write reftables since 2017. Given the complexity of
the format there is a very real risk of incompatibilities between those
two implementations, which is something that we really want to avoid.

Add some basic tests that verify that reftables written by Git and JGit
can be read by the respective other implementation. For now this test
suite is rather small, only covering basic functionality. But it serves
as a good starting point and can be extended over time.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0612-reftable-jgit-compatibility.sh | 132 +++++++++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100755 t/t0612-reftable-jgit-compatibility.sh

diff --git a/t/t0612-reftable-jgit-compatibility.sh b/t/t0612-reftable-jgit=
-compatibility.sh
new file mode 100755
index 0000000000..222464e360
--- /dev/null
+++ b/t/t0612-reftable-jgit-compatibility.sh
@@ -0,0 +1,132 @@
+#!/bin/sh
+
+test_description=3D'reftables are compatible with JGit'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+GIT_TEST_DEFAULT_REF_FORMAT=3Dreftable
+export GIT_TEST_DEFAULT_REF_FORMAT
+
+# JGit does not support the 'link' DIRC extension.
+GIT_TEST_SPLIT_INDEX=3D0
+export GIT_TEST_SPLIT_INDEX
+
+. ./test-lib.sh
+
+if ! test_have_prereq JGIT
+then
+	skip_all=3D'skipping reftable JGit tests'
+	test_done
+fi
+
+if ! test_have_prereq SHA1
+then
+	skip_all=3D'skipping reftable JGit tests; JGit does not support SHA256 re=
ftables'
+	test_done
+fi
+
+test_commit_jgit () {
+	touch "$1" &&
+	jgit add "$1" &&
+	jgit commit -m "$1"
+}
+
+test_same_refs () {
+	git show-ref --head >cgit.actual &&
+	jgit show-ref >jgit-tabs.actual &&
+	tr "\t" " " <jgit-tabs.actual >jgit.actual &&
+	test_cmp cgit.actual jgit.actual
+}
+
+test_same_ref () {
+	git rev-parse "$1" >cgit.actual &&
+	jgit rev-parse "$1" >jgit.actual &&
+	test_cmp cgit.actual jgit.actual
+}
+
+test_same_reflog () {
+	git reflog "$*" >cgit.actual &&
+	jgit reflog "$*" >jgit-newline.actual &&
+	sed '/^$/d' <jgit-newline.actual >jgit.actual &&
+	test_cmp cgit.actual jgit.actual
+}
+
+test_expect_success 'CGit repository can be read by JGit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		test_same_refs &&
+		test_same_ref HEAD &&
+		test_same_reflog HEAD
+	)
+'
+
+test_expect_success 'JGit repository can be read by CGit' '
+	test_when_finished "rm -rf repo" &&
+	jgit init repo &&
+	(
+		cd repo &&
+
+		touch file &&
+		jgit add file &&
+		jgit commit -m "initial commit" &&
+
+		# Note that we must convert the ref storage after we have
+		# written the default branch. Otherwise JGit will end up with
+		# no HEAD at all.
+		jgit convert-ref-storage --format=3Dreftable &&
+
+		test_same_refs &&
+		test_same_ref HEAD &&
+		# Interestingly, JGit cannot read its own reflog here. CGit can
+		# though.
+		printf "%s HEAD@{0}: commit (initial): initial commit" "$(git rev-parse =
--short HEAD)" >expect &&
+		git reflog HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'mixed writes from JGit and CGit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit A &&
+		test_commit_jgit B &&
+		test_commit C &&
+		test_commit_jgit D &&
+
+		test_same_refs &&
+		test_same_ref HEAD &&
+		test_same_reflog HEAD
+	)
+'
+
+test_expect_success 'JGit can read multi-level index' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit A &&
+		awk "
+		    BEGIN {
+			print \"start\";
+			for (i =3D 0; i < 10000; i++)
+			    printf \"create refs/heads/branch-%d HEAD\n\", i;
+			print \"commit\";
+		    }
+		" >input &&
+		git update-ref --stdin <input &&
+
+		test_same_refs &&
+		test_same_ref refs/heads/branch-1 &&
+		test_same_ref refs/heads/branch-5738 &&
+		test_same_ref refs/heads/branch-9999
+	)
+'
+
+test_done
--=20
2.44.GIT


--El6ukuDtK3DBWjHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYTkugACgkQVbJhu7ck
PpRTBxAAm6zsU21Jodq8aX7iM+673KBvaObmTXI+aMfElRgX6597QqwrkMycerUF
fPRtOaWKHzebBYqzJuHPh9nP/ujKqE3cCqfaPZZi27ND3sKBEvH/iYgaqgcidbjP
ogopvW3neL1HtHlSolK2F9yOj8Ib+zxLJJpIiq8evsgYlsDZd3IVTnKM7qHuzjTD
wqBLDvT7ObOsjLPRl12vxVE8Q1qe3Pa1vuuqPBEc3FDJdzilt0PB6HACcsYyFDKc
NUgsdetGO4vyW8wYxe3TP+YVUUQ9K3yXB3R0kb/5rtfdtyoMIOxX5roDznSmWdL7
GZwwCV/yNtviLa5R2gHZ6ILoz1ef4huabNflkQg0YIKDf2+Gda0FOf9Ib/xZSXRC
uxx72DFR+z0Os/PHGxshEachLP4Q8+5n8QacJqBwu1e/VcmvKteQSx41S/FMVBWx
kLsdY4WTjUZ4/N4vaFpgx7q1NqcQ28rc326hoHChpG2SbxzoNuxO3CQLSBlTpmCl
VccRSfzxtP858wjzSN3Qq/A3kBII4HlcHe9mq+ro1dflNIGJErPEliIpM4sIWRZF
g4HQO5zVxxriqzZj2m6YqhClo1dvtrWqtAmIZM+GbBQkXOYsPR1I1IZVDO1/m+vF
C4elqNv1NZA3K1DuktKPiliRihPGuaGXcbXFsM+Uzgp2zFyyt1Y=
=6418
-----END PGP SIGNATURE-----

--El6ukuDtK3DBWjHL--
