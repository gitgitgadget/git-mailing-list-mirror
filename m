Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9324F219FC
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 10:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705573379; cv=none; b=Evn9aFigc7Be1b3RpchGqwoRxyJxNvoeHAjXFYzOcTD0q2Dm6A/d+BKvsEcGrWSK5Byn+rryGtqJW0WRzHzjR/W8SXJAP0AL2ns8CWLUyfdEnnMxRR00zaclWrem35Jw9NKYVv7lj6wKLw5jtripQi/wuIB8zIQRwOA0HbkSgmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705573379; c=relaxed/simple;
	bh=dZAjkAUMwBoWGGV7FsLgpLqAFGHkgBsnB0MRMeWh8oU=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=kTZDmILkx1bO9rT802AX1xDGCJDBPt1V9HEPbnsF5e+nzGk7bGLGfCbiH4AGCi8u7ewDa0SaegcaLgaNQ8ScPWJ+eJ+tSJpYUXlF7nbuZjmiOS4InLddD9mTecwcl/PoUeNk6QgIorC6ymf4G+6kotSVvkFSIWnm0VSvMnDvHJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CX5sC8CL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JjTWcR6d; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CX5sC8CL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JjTWcR6d"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id B78963200BD7;
	Thu, 18 Jan 2024 05:22:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 18 Jan 2024 05:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705573376; x=1705659776; bh=dZAjkAUMwB
	oWGGV7FsLgpLqAFGHkgBsnB0MRMeWh8oU=; b=CX5sC8CL1VMAWl3bNqPDydDh1p
	/gpDTNP4cw9cVx4YVj52ijZarDS2dfyT/76Q3MFSfnf3LF23HH/TXEy8a0Dt9maF
	b+w/sowUZx9/ZR0Few9HB9IG8Y/D0Qk+uRhgjSziubzNUnxKIewfGS3Lkebmbdu+
	muZcFivWhwB3BHZbdCIqP/1SJ4bro5xd9KxHrd3xHMlN9ZgYWf28j2StHuDalaY0
	uHlB8nS+BTHcbCwIJIZaogAE62Po7lN8QmD63rRLYLnoBnmH2o94IEl2O4lTEYkd
	47AU7+ypWESvo0O1TkO7TAMfCVopIh4jUyB7jtyaws98z2GQuyfI6EZR5fkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705573376; x=1705659776; bh=dZAjkAUMwBoWGGV7FsLgpLqAFGHk
	gBsnB0MRMeWh8oU=; b=JjTWcR6d0MNdL9XVva8YOJemx68uA3gApOlh/bd/UaPk
	Tv2a6LBvyY0Mq+ghQgAXjfownXTlX0SFYQ6IMHnbMyVEveJB2PDsVlsMbvw8k/0w
	OPzIdtCv3x6NH50NyCewc7KIRyLYOTGimreE39rPNgfAowUsMWuLulNGHboBb8Ga
	Fj+suplQ1gUxNoF2u5c4WujGVg9D1pCx3tH4JNTOiyXk360ZdFkg68cZEPphqCWg
	BUr/QO9k669fJHFgtTgNINtOAsKHhSR0rWLneIemoBbbuKfC7nz4c0kUvgBpDGY+
	8l//xWtngWc9dwuRIQsqR2mrVARAdrCDRYdpyQRKkw==
X-ME-Sender: <xms:APyoZRXI5-MUTsv06Yr4dsXqjojk9XQr8WWaTK2FJAT8KiafY-DNVg>
    <xme:APyoZRkrxTiXNPDGhIWv9VAeWkUpBn2KNbsmCj8I-Mm7GsvhpgEeHO94wVXWRLppr
    QOqW-4ylzosmocDtQ>
X-ME-Received: <xmr:APyoZdYnGLFjYjGZcWU-9k3GQxrX6NXzf_slq_fnlpchm1dc_OFrsjJdZ5o5vyLhyxrJBKRq1lzg_L3s6nkNQ_pCdBI3I1KjJ6rATMG4cXPKjcI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejjedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:APyoZUWmPq2SFy76TOAFkiPP5m5YCoLLna4dExMj8iqibF1R3QlSSA>
    <xmx:APyoZbmN7mb8P3FaH8sZyce1pHpBzbxabkAUSR3g6czsZ0-2o0T02g>
    <xmx:APyoZRcqWbwpjFnJUm5PpC_W_g4UN6RzQMRvLHp8ADHYq7Ig68A-1A>
    <xmx:APyoZTtVqDza_dtdfwh8NlNY5LEHb3cQs1ECLhD7JvoA4h-EMdu6ig>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 05:22:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 65883b13 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jan 2024 10:20:00 +0000 (UTC)
Date: Thu, 18 Jan 2024 11:22:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Matthias =?iso-8859-1?Q?A=DFhauer?= <mha1993@live.de>
Subject: [PATCH v2 3/5] ci: handle TEST_OUTPUT_DIRECTORY when printing test
 failures
Message-ID: <d55da77747d71e6d300ecba5fb3709fb258ef29f.1705573336.git.ps@pks.im>
References: <cover.1705318985.git.ps@pks.im>
 <cover.1705573336.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6dwdMuNu8e6neZUw"
Content-Disposition: inline
In-Reply-To: <cover.1705573336.git.ps@pks.im>


--6dwdMuNu8e6neZUw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The TEST_OUTPUT_DIRECTORY environment variable can be used to instruct
the test suite to write test data and test results into a different
location than into "t/". The "ci/print-test-failures.sh" script does not
know to handle this environment variable though, which means that it
will search for test results in the wrong location if it was set.

Update the script to handle TEST_OUTPUT_DIRECTORY so that we can start
to set it in our CI.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/print-test-failures.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index c33ad4e3a2..b1f80aeac3 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -8,7 +8,7 @@
 # Tracing executed commands would produce too much noise in the loop below.
 set +x
=20
-cd t/
+cd "${TEST_OUTPUT_DIRECTORY:-t/}"
=20
 if ! ls test-results/*.exit >/dev/null 2>/dev/null
 then
--=20
2.43.GIT


--6dwdMuNu8e6neZUw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWo+/wACgkQVbJhu7ck
PpSPXBAAo4URrYsPABVlMTXCdksmYeYYXIbD4BT7mMOjQ2xgH61b7LvBJd4G/WMX
YM3mjrQB6530pY/G/dm3xzCCpba+eyJZFD1NNWlnPlFHFU3yrHZEjTGzXA1TCt0p
nvby+2op9OtfF3fKBTmObmXOTs0EiCo9StKUQh9PO8PLfiwE9LS8gE2wTvEOqiRi
YYt5iVv+5jHf/7UgTBGte10fUrf2U+WFoNQJ0f8iKJm6BvMdQ7yJKMtb7w4PeniM
dhKgJPTdHUkeO4It/A3+APCPv/Zj1Der5aliRGOrvrFj00ISti4YF4wrTn5FMczi
wuBO5ynSGg/h0gZMv0fM1nyWynSlTIM3LK/ac4FAqGbEhGk/CySnmZ3jIgp3wL+h
JyIdEFhCb+rwxB6H7EJNL4w1QvNGMZ6GNpVAHfyk5RK8Sn+atPres4T0dAHzkR6s
BbhJCYrvLt9/Eg24mHdUQ2G4WTuD7BMrERkJizbpE1/32lQgDyt/Q6X++Occto36
T8pwzpsjbM4z61NgsmVDn1G6k8IayVrv4BKJitK2Ii9Oxe5XDvp9ruvO9fqFlR13
DTX6dpZJ4++Xu5GFPyDdHx64agFdNAFgX0vmnkVlLetKYGcq+oB2baWJnnqpxWT6
pj7TesLlNLj4JMfh34yXDjQQ4ZO0QAfxYu3LCXCrFaE8kPefWUo=
=OECr
-----END PGP SIGNATURE-----

--6dwdMuNu8e6neZUw--
