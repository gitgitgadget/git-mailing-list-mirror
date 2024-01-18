Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F1B224CD
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705573384; cv=none; b=j3aXfKxfMxCGZpWrGbnv2M1i7VZTG4j5LEbVTRy73lSlY6+oC2Vvd8kFu1gDlK0TTfw+AO39F6iQl+EEzs1yGml71Cg6pMcgp7QOwX+U+HP9MWlCfLRvAetifCsk7TokP3yzI20UVYTkn8sWPCoTaDORg6Vy5IfjYNDUK6ZRZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705573384; c=relaxed/simple;
	bh=jtEApcyCy4gWkc+H9OkINLjkLZiRO7wXKiK/9lZOL8s=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=ncL7L2TgiCpRtMdetOBue4T5iY3PdLCP9nbWiCpTp22TzLpV/Qpb8YgZmSXcrI/yU8J80TA9evmtZ9njWGoLHalbJHdfh81pezaHAK9yPS9H7G+yuzrETJsrPjST5vtsNmpn2/ylJS7CUWSvEbnixIFa31boGJJniZSHCBRnzTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CXbEk5/9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kAIN898d; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CXbEk5/9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kAIN898d"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id B6DBD3200BDB;
	Thu, 18 Jan 2024 05:23:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 18 Jan 2024 05:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705573381; x=1705659781; bh=0AazXY0eKQ
	7iE2j861NOgMBgbQCXbsFGrcf/v5ZaITA=; b=CXbEk5/9B558Fw541pylCpXYne
	6yqlVqqXX27Gbsyny0a8cLEnhfWGXT9NjXuu/zuAU3UzTDKZUQswHTd3e04TNUbC
	ik4+lXKEe11rBxQbewJNnSK7tBTLuREYMsE3A5ZV/WZSv1uu0SOPXho6dqiOJY0g
	8y3uoby1DYragdhE/i1Cssoj7TIqxESeJpH2KBpR5krPu4gWmApcNsNRnEDlKB8e
	+lueRxaO7BxFWQOFCot019imviabSb9quuuZGN4C74bo2T2++r9QliO2C5nX1flP
	IM782Kdp0U8WgL6rIHebFjqx/wMEmVRSLYvpnVkwI/Ol0BQ+wpX2VejZmNpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705573381; x=1705659781; bh=0AazXY0eKQ7iE2j861NOgMBgbQCX
	bsFGrcf/v5ZaITA=; b=kAIN898dFQT+jE8OWcaXo/Jk/tqkKH+CUOIGzLvCTuXV
	l1Ib5zXT9dSb/PAyTKsu2LIy/a5Hv42xkGOmbhG1y4xslUQlgG+IrQJk+9TokIVK
	dUrIKBNIOuj/aDdYcUYaJefZfNu4BHmzc//jc1AnlivcMpgBA37QdyNaK2SMOhUq
	SRXQoH3Lnub5oFAtaY/ytrgVLCodQgJdnrJwjhIDwiPtTtJzBfyGq/T3246oYgZT
	1TLluE3CdCu818/V/gWTKt9i3JmMs/JwtcPE6e6+y6Yz0SmUNsAEnfrRJZeJd1uZ
	H3bBXRzAi7o0WF0h4QdyOZ6QvSZg8Izh2kcZX5au6w==
X-ME-Sender: <xms:BfyoZbpgXn4u71iD9ta5VQ4yv06UAHiyVbMVnE8sb9eCVig-LuxYNQ>
    <xme:BfyoZVpnhFhPtzeTVFpQxVAsBKWtgxA-YswDPlziCgSakG0QClCELMHg7xO1jjLpD
    9hPZiYaI1V-qx7JWw>
X-ME-Received: <xmr:BfyoZYM1k-92EzFEHqvIjahwq3Iz-U2igPW_tcqZLXybMjqkMhIyUMWfeEr7lVYJt5CBKplfXD4tB9z5LtfoKFa4UhOnAb0JTyshiOyGpl_mDho>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejjedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:BfyoZe7maHcwV5FS_c7dgs-2SHPX6j-tsB3BjUc9nwTCe8EJYLlVvg>
    <xmx:BfyoZa7rz5qfi5V_UmM2AJa_oiw3NfcsTKaRbCeSVFO-auUhwozz3Q>
    <xmx:BfyoZWhJlGE0vvBziGJwo5iTESK9CjL_shACaL5yQed8yCzLMa1xEw>
    <xmx:BfyoZQSisNnZ95jQu3RJyOKK73tB6X4XgmEEMLy5dkoXRFDcp9-yjw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 05:23:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3bd009d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jan 2024 10:20:04 +0000 (UTC)
Date: Thu, 18 Jan 2024 11:22:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Matthias =?iso-8859-1?Q?A=DFhauer?= <mha1993@live.de>
Subject: [PATCH v2 4/5] ci: make p4 setup on macOS more robust
Message-ID: <1ed6e6865014b5f24aeadd14505b06a15ed20eb2.1705573336.git.ps@pks.im>
References: <cover.1705318985.git.ps@pks.im>
 <cover.1705573336.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+J1gk/Ooe/IqZOJD"
Content-Disposition: inline
In-Reply-To: <cover.1705573336.git.ps@pks.im>


--+J1gk/Ooe/IqZOJD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When setting up Perforce on macOS we put both `p4` and `p4d` into
"$HOME/bin". On GitHub CI this directory is indeed contained in the PATH
environment variable and thus there is no need for additional setup than
to put the binaries there. But GitLab CI does not do this, and thus our
Perforce-based tests would be skipped there even though we download the
binaries.

Refactor the setup code to become more robust by downloading binaries
into a separate directory which we then manually append to our PATH.
This matches what we do on Linux-based jobs.

Note that it may seem like we already did append "$HOME/bin" to PATH
because we're actually removing the lines that adapt PATH. But we only
ever adapted the PATH variable in "ci/install-dependencies.sh", and
didn't adapt it when running "ci/run-build-and-test.sh". Consequently,
the required binaries wouldn't be found during the test run unless the
CI platform already had the "$HOME/bin" in PATH right from the start.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 10 ++++------
 ci/lib.sh                  |  3 +++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 4f407530d3..b4e22de3cb 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -37,15 +37,13 @@ macos-*)
 	test -z "$BREW_INSTALL_PACKAGES" ||
 	brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
-	mkdir -p $HOME/bin
-	(
-		cd $HOME/bin
+
+	mkdir -p "$P4_PATH"
+	pushd "$P4_PATH"
 		wget -q "$P4WHENCE/bin.macosx1015x86_64/helix-core-server.tgz" &&
 		tar -xf helix-core-server.tgz &&
 		sudo xattr -d com.apple.quarantine p4 p4d 2>/dev/null || true
-	)
-	PATH=3D"$PATH:${HOME}/bin"
-	export PATH
+	popd
=20
 	if test -n "$CC_PACKAGE"
 	then
diff --git a/ci/lib.sh b/ci/lib.sh
index c749b21366..f631206a44 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -344,6 +344,9 @@ macos-*)
 	then
 		MAKEFLAGS=3D"$MAKEFLAGS APPLE_COMMON_CRYPTO_SHA1=3DYes"
 	fi
+
+	P4_PATH=3D"$HOME/custom/p4"
+	export PATH=3D"$P4_PATH:$PATH"
 	;;
 esac
=20
--=20
2.43.GIT


--+J1gk/Ooe/IqZOJD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWo/AEACgkQVbJhu7ck
PpSjAA//Q73F7ighq+fUzWDdioolDBXCA06eCNbC6yG9SR8BAECCVEtWaILPmzRr
awsGmTlpU42alS/I1cf+h3pwrC/UEFLhCgNalq2+D+OwVvWpRiJwtkSfiICQ3IZE
o9wFu+xV+3rajLQiQRaJcG7t2KQp4yjkxWab1+QVyo1jK4PtTmLsu3EllrUahHTz
PT13EYWe/v9m1BBoCtIrOerS6j7dwfajjhwWdJ93r1060jEhdOmkh3LftW4zKMon
TYzSVvgEWheKdHY/Qr+ZyNBe5O3ybv/PS2IXyTB2cen8eQWi05PuJvMcy1r4ogqo
ggJI8DdS+l7XYl2idBp0taxps3k+I9Wk7u/t5hsahCgBBVjbYLCTnVXUsmk4aiO5
dueBLBHVRO86dfJ30PC+0yAJbWL+KfKrL/wl1w4s4yPUWQ9U5svQFNSA0sKYyA7N
kQ1pF1v85U9pcdEVx7HQ3QXu1DOweWvP7e8oiVrQNz8kvRwinK8l7M3aVozi89JI
ITKIsDZqe8wXbabC/w8bnZ8dzK2tCSsBSni4NLYmro16G2f9rdHKKtVWd0BdsSGS
nDHKgbHoqkzeS7GbOSAJLZQriV66uKw6UXTNcXubz0MaGDlMwNQjjWOr7/QUFj9U
IOMSNVuZw4usxgCQAjTjLYGUdlQbGKcsvZvnCVDQWD6l90NMfKc=
=mCHq
-----END PGP SIGNATURE-----

--+J1gk/Ooe/IqZOJD--
