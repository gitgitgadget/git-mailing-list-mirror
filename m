Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14AE86ADC
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237157; cv=none; b=Y+73qXoLXVOQ+gCiDu7kpOMExBUiQ9ax65Y/Gr675y0PA8ueDfG4Q65DqYy2rR7xEkvT/JW1VHA7s/X7ZtB2eo2tzgQ8Qarw+b1Uri2OBleSAkWqQSMmJeIXfak4F3tb3aZQF2dKLOe1iWqFLl7eYflcDyiqz+8YIMX6KgxE0Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237157; c=relaxed/simple;
	bh=fDH8UT0DRuLK2G5FGB8JAfWiC0Apij3O534qrY2nC7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMpGFZ8R9ME4UApnFV7F0VZwkAHG6kWLBk9/3tL6rI0Ko+NoQO1sTjdk/NqaNF+yfqe0h6a/vEBzv3Rk+W18vaxc/0eFgIK3UU58S7F9EOjdg2O4buU+P4Do5S2ctKzDYWN+mLLPw4GDESd7cW/3LDijpIS0nRSNdtWP9X6VgwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ArUokfWu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p8pXpkoJ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ArUokfWu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p8pXpkoJ"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2B8C0138017A;
	Thu,  4 Apr 2024 09:25:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 04 Apr 2024 09:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712237155; x=1712323555; bh=g8Uq2iySiT
	ayAJDrN02XmrhmyXS+1Zyhhw8WH3N2K+4=; b=ArUokfWuFBSGLDM/UiAIHz4RVR
	cHnlfq38g677osuLqW1e5oip16PrnnUtK22J3QBq6O0FCE0JBof6ElHLpaval2xi
	5MEiY7DPdutdCi7Lh43dJayRx/7A4+qEPz2xejaLKlbSlR0mmurOvMIbRCAwfJ2n
	wmEgGepVRJ51T38rQMtVlCWBz5+QHwbEooznVZzR2gY4apF3ePPt9EO0tlAp+ITA
	vDNor4lD5ge9nL1mDGF+MTjlTZqLUIyZi4vPkJgSYwZ864T2e1dPnVfkyvdQPoS3
	wvuM3Wv7kh7vRHGrsTYWRIR3KDs/8oIP4JzD8p/ZLMwXBTY8C7R6xGqEgqYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712237155; x=1712323555; bh=g8Uq2iySiTayAJDrN02XmrhmyXS+
	1Zyhhw8WH3N2K+4=; b=p8pXpkoJuDP15DeABnJsXRkpzO4bXTh+xAWnU4S2lypl
	XYguTbKxl7VGuU8YYIn5+S7CwE1NyvAqRhKvTIJUwY6URZnnd1X0jLzo6WFt2DOE
	YzoVMThH2L/QdeojlzA06RRDX6shLFrBfb7Ub96BGLKZS9/Lk5lQlrpUAWqNsCt1
	tDZFTcdMTPmUcOAcbl9Yh2XROeQbrW9GB7sloxnzTfzNrXfRBEDcirw9NkXq/paJ
	GN7k8XJYK7GzKZ548jTXn0SwM95WmOfXtiaI3Rf4jGV87s09/ezu4XG8na1i1BIi
	qwGwBrJIE5YoiLqH3cs04XDk2w+rTXPS9MgBakcfgA==
X-ME-Sender: <xms:YqoOZh-BbCLgS8ArjFUPag6_YaygVTRpYYSu7C1wqqwF3X4j0N5OOQ>
    <xme:YqoOZlvwvlZxU__fOcmc_s0s7I94kGkONwa3jdCkryFmNleM8AO2gPLHgEXjv9vnm
    8p7kgQyb1WWaQh80A>
X-ME-Received: <xmr:YqoOZvBwgvB6xxX_EX_zPxl_ZYdtQeWg6AIwTld5pEEw842-inIJfW87HN9qxuEVgkPdCBGglx_C1Jcyb9LwjEVpLMNY0soI-xf3JEC20IrtZri9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:YqoOZlciJRv2EebuRTpcsei3Vrj_qyQSqvbPYYMS43SYRYpN1MISIg>
    <xmx:YqoOZmONIUJQI4lti0voFhQRxmPGKIxlFyxwXaCZ33UjIXiPNxSVeA>
    <xmx:YqoOZnnBev_3s8_dKyzuop06ogNVY3lG7N3n8dgetjIRlD6TbIYxNw>
    <xmx:YqoOZguoQM1KrlciTnp_lTs1xsn_DbPnUCMKf3ZXwXp6ZpWxlHCk_w>
    <xmx:Y6oOZiBsCGTZlB4-4nK6VrHbaFplLF3zLFx_Sfq55MFG9BMyMEQIKPMj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 09:25:53 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8ba7a779 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 13:25:50 +0000 (UTC)
Date: Thu, 4 Apr 2024 15:25:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
Subject: [PATCH 12/12] t0612: add tests to exercise Git/JGit reftable
 compatibility
Message-ID: <db66dd4155d80b714719e80ff90f64c1d36b97d0.1712235356.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IHmXcdSaUrFh99bN"
Content-Disposition: inline
In-Reply-To: <cover.1712235356.git.ps@pks.im>


--IHmXcdSaUrFh99bN
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
 t/t0612-reftable-jgit-compatibility.sh | 115 +++++++++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100755 t/t0612-reftable-jgit-compatibility.sh

diff --git a/t/t0612-reftable-jgit-compatibility.sh b/t/t0612-reftable-jgit=
-compatibility.sh
new file mode 100755
index 0000000000..f25ea880a0
--- /dev/null
+++ b/t/t0612-reftable-jgit-compatibility.sh
@@ -0,0 +1,115 @@
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
+		test_same_reflog HEAD
+	)
+'
+
+test_expect_success 'JGit repository can be read by CGit' '
+	test_when_finished "rm -rf repo" &&
+	# JGit does not provide a way to create a reftable-enabled repository.
+	git init repo &&
+	(
+		cd repo &&
+		touch file &&
+		jgit add file &&
+		jgit commit -m "initial commit" &&
+
+		test_same_refs &&
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
+		test_same_refs
+	)
+'
+
+test_done
--=20
2.44.GIT


--IHmXcdSaUrFh99bN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOql8ACgkQVbJhu7ck
PpRKXA/8D8Mt2T4n25oVTDao4ejxOSvIdlKUauGgi3GrX3hS+AUmsde3l8E7vvVA
+6rIeP6mxcdHrJg4TARy1syD8oLRxLr2sTYH1izoFkTYWSYCpz8oMBSeMyadtMua
u9LUkfaSQ+5LlnBLTZiYxIbZY9RXE+ssYSh5fkGrC3ro3GZGGLgDQxfObeJ1tsEO
htiAggT26K5WLD9D1FqV+yQmZU+hURlAEavoD+y9ZqKUIwv65TRD1XSRmjCz2SxQ
S2kjTT+l9eus4ym8yHVBvQXqVBK0gtlZ1gBiSEplgLEs3hyiYXMjEFI2Xja5bJdG
yBhv7j3M4XQLyWKgV7witmRn3iE276YLoxxEeew0R2tTVRduhBxCAOaAcUn+7VAQ
nzA4kKDMQodcfMhEbPO4xSOSD/9iu6FlIj1a2FgSRnz+tr2F9ce08taeV+g3+XAC
ZL+tigANIVcC3PosaHjdxh9ihcOYSE2sGwAHloCnTS31TMJjcqHxNkpeHpiDP3UZ
aP11VjI8t+x0VoSPir9UdNt38eHzkSN6RsxbdBfXgv6YxZ1qQDUt5au/xNcli+jW
jyZGiIi31mEMDLZyvVS5VrYgCabIEViCWQ+bDZwsgGO6QGYFN2HiUOiaRYpcRLte
Jn0/gR4HrFBWQsDwz9j0eFdzPSoyIY6oRX8HBnQBoCDA0EnlrW0=
=3cw5
-----END PGP SIGNATURE-----

--IHmXcdSaUrFh99bN--
