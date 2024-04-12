Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F471BDDF
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 04:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897068; cv=none; b=pyR/ITBlcKlO6IbWn6DrvLZ5mnjuK8FODB4ON4osCdOQ8mbbku9Wqa2tAgLlDjr2e0qd8u1YZXqKt5Ts9tjaFOOmDPrvZKjBGzbEE1RvhJEW5ax5bL79a3E8hl3sMoEGrSjVS6mtwss5rAutm5QaoMx1I+xSJIAoDhwkaDIOaCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897068; c=relaxed/simple;
	bh=S/8Xtr2KskHdtdaZU265EFtbpjZdAU1EpuqZzAu0cE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gE+8KC65BOoH7LzoN2gihq0ZBAmddDxbWoNOeBE541XvLnXfQYwOxiqxYtSr9wo8WW9jwvIiJ7Tup2XxJCnlWL4A+SW6oLejAS+bBpjrhqde73DVndkWPvab7v3kKZyhWVFGwX1/V5IPpWUGg3GUpHz5yKdBEu+TdvA8FFRORvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PNL/ZaRZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RiBymUQ+; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PNL/ZaRZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RiBymUQ+"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 124D511401DC;
	Fri, 12 Apr 2024 00:44:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 12 Apr 2024 00:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712897066; x=1712983466; bh=D4Z1RNPwMt
	EIe75LBeFODaJyQ28maiABfI/8Z3OO9sQ=; b=PNL/ZaRZEArohT3g01/qkdfwZ/
	xdDOeoGvCR4Sbm2Q8O2bZjaLBJ6mKN1tl8XDvPVTWXe4R4LD9Ay9Y1WrzbANqFU+
	oGBL4EZjiCmWA0hxSpb+kUrDgdlv3M/8djVNOBoZgJBiNSpGVSKaKY+B8pKrX5du
	9/nzExR8tOOHnVi7XBxCcLJEPfcE5zXh18mWhmK/PEenGHLMriFhfRvGkhuSxlc/
	a+FO+ZCRi/gCeZBDo2RNGJSMfcm3zufZWrEZ4zqY9jI3SKCJqeZktUfkfygoTb1A
	AkuR3EV5x/V5brWcTcU3bhggKoaXWJpBn38aGHGfBIao98c0sAGMBqDi00qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712897066; x=1712983466; bh=D4Z1RNPwMtEIe75LBeFODaJyQ28m
	aiABfI/8Z3OO9sQ=; b=RiBymUQ+7PFS6d2jbuZVB870i8vM78fDmyAkW+JaFr2f
	hSwaJurlJuTn8WBqMeYNsVOMqzKEjd6F4WO9Ve7NANzoS2JNiQxWYVgaBkOZ0sNa
	sKgc1MKULMmcHD8hTDc2oSrwdqFIguxR2uYsag8pS0SYOZcr0V5wxMsrzMXqRMFX
	cNsCth1VN1/5I8yvM07gptorOYw2xkwD0QLv7KZDZBrIcwc3KB8KF1sWKCiLZOLv
	P/nlKh1AXn/9wGVzuZJlyuLpk1zLplBhO7Uj7bMGTlBnbacO/QrTIKdtYzXcfbSW
	XTuPPEnJsYLrz8ulUiHkRtjQXZ9DxEkQtaewkPA5Rw==
X-ME-Sender: <xms:KbwYZsHFPGDgEsXO3Jiv2ybQGELtUY-ZUBIGs2uBllZj0wHu68WmVQ>
    <xme:KbwYZlW1bYcL54h0NMdTJZCFY7o0Izf2TzxYXksS9dESy2CoVPe081xXJHCV7KjAL
    HVYwaiYjX0t-lTALQ>
X-ME-Received: <xmr:KbwYZmLrXBIZemnb7svPNLCWLg7zzFXD1BIXsjdxdbwzOCJ0iVoVHxvioXcz3ta0WVMi4DkXU-jfoOwaZacwEz2vNqVuLhtil9XpRz7rzmxqaY3epVc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeitddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:KbwYZuGwRYzgOtaLJcOr4oiClMYhnBFGpF2iDd__t9LrtjxUu4ijCA>
    <xmx:KbwYZiU6RsBQG-OKGyiIxZKcQQ8_z0Cqd4tqMwtPhXSWryBNJdcgvQ>
    <xmx:KbwYZhOcJifBQn4HKe1rguFEiRORp5LV_Cb7zHktpfVhBRE6FxG8aA>
    <xmx:KbwYZp0Xyyk4paZcayYjnB17YUUVr-NtMXonXXL4cfFgGmshaX_9ig>
    <xmx:KrwYZtE-MzvVPejlol_XGCML1WORypuevtCHxqu-nqEGMV3_KQ_jzF5F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Apr 2024 00:44:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 36a09873 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Apr 2024 04:44:10 +0000 (UTC)
Date: Fri, 12 Apr 2024 06:44:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 06/13] ci: merge custom PATH directories
Message-ID: <ce4f0c766c46d1d8f8ac3920e5efe832c5dd71fb.1712896869.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712896868.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N1DtTOcNR1Tbld6e"
Content-Disposition: inline
In-Reply-To: <cover.1712896868.git.ps@pks.im>


--N1DtTOcNR1Tbld6e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're downloading various executables required by our tests. Each of
these executables goes into its own directory, which is then appended to
the PATH variable. Consequently, whenever we add a new dependency and
thus a new directory, we would have to adapt to this change in several
places.

Refactor this to instead put all binaries into a single directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 15 +++++++--------
 ci/lib.sh                  | 10 +++-------
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 2d6af876d6..bafe37f2d1 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -29,15 +29,14 @@ ubuntu-*)
 		libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl \
 		$CC_PACKAGE $PYTHON_PACKAGE
=20
-	mkdir --parents "$P4_PATH"
-	wget --quiet --directory-prefix=3D"$P4_PATH" \
+	mkdir --parents "$CUSTOM_PATH"
+	wget --quiet --directory-prefix=3D"$CUSTOM_PATH" \
 		"$P4WHENCE/bin.linux26x86_64/p4d" "$P4WHENCE/bin.linux26x86_64/p4"
-	chmod u+x "$P4_PATH/p4d" "$P4_PATH/p4"
+	chmod u+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
=20
-	mkdir --parents "$GIT_LFS_PATH"
 	wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.g=
z"
 	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
-		-C "$GIT_LFS_PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VERSIO=
N/git-lfs"
+		-C "$CUSTOM_PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VERSION=
/git-lfs"
 	rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
 	;;
 macos-*)
@@ -48,10 +47,10 @@ macos-*)
 	brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
=20
-	mkdir -p "$P4_PATH"
+	mkdir -p "$CUSTOM_PATH"
 	wget -q "$P4WHENCE/bin.macosx1015x86_64/helix-core-server.tgz" &&
-	tar -xf helix-core-server.tgz -C "$P4_PATH" p4 p4d &&
-	sudo xattr -d com.apple.quarantine "$P4_PATH/p4" "$P4_PATH/p4d" 2>/dev/nu=
ll || true
+	tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d &&
+	sudo xattr -d com.apple.quarantine "$CUSTOM_PATH/p4" "$CUSTOM_PATH/p4d" 2=
>/dev/null || true
 	rm helix-core-server.tgz
=20
 	if test -n "$CC_PACKAGE"
diff --git a/ci/lib.sh b/ci/lib.sh
index d882250db5..4cce854bad 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -340,10 +340,6 @@ ubuntu-*)
 	# image.
 	# Keep that in mind when you encounter a broken OS X build!
 	export LINUX_GIT_LFS_VERSION=3D"1.5.2"
-
-	P4_PATH=3D"$HOME/custom/p4"
-	GIT_LFS_PATH=3D"$HOME/custom/git-lfs"
-	export PATH=3D"$GIT_LFS_PATH:$P4_PATH:$PATH"
 	;;
 macos-*)
 	MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python3)"
@@ -351,12 +347,12 @@ macos-*)
 	then
 		MAKEFLAGS=3D"$MAKEFLAGS APPLE_COMMON_CRYPTO_SHA1=3DYes"
 	fi
-
-	P4_PATH=3D"$HOME/custom/p4"
-	export PATH=3D"$P4_PATH:$PATH"
 	;;
 esac
=20
+CUSTOM_PATH=3D"$HOME/path"
+export PATH=3D"$CUSTOM_PATH:$PATH"
+
 case "$jobname" in
 linux32)
 	CC=3Dgcc
--=20
2.44.GIT


--N1DtTOcNR1Tbld6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYYvCUACgkQVbJhu7ck
PpTEAg//coukIdQzzpJjSas6M544eCrCI1iCPlivXqef9gp95LxPxoxOK7lzi3nb
j0RlNhSnoNAZRWKeRaa3kne4Th9mlz37tIPAdBqC4OxcyB2xCXrBWkrLNVVqQD1/
IazhKQvdTVP4pdKn9qKbYA6NxMc2Ne0U2tqtE9PP1nSiRR0Ofq+SjrwpXbM95OYD
mFs1pEcMdQ2OT+AOwo2mSEYH4CUQnIlEEl9WNaSoWVzDrj6VPre8FUxziHCczfQC
0oPYXhrsGQKO989yNOW/pqjJWehG37CeFQtKR6yGawVPUDjh8zVJRioIs2D68A9V
MNsvjcClUY8PyAYfLz+Nw+a8o9WT2SFk9/9I1jQMzsyi1nbRxAzLKXnmWgjT1q9R
A3+iGLiZQQR54TdFax9PN1IrrMKSvznEHtrOlpfKZd+GzXkxepYiDajlGxpMzvo6
5NrmJ5xDagwyG6C/3m6YZYDGvSjq8nEleDG7qlDJAoxdoFAg4kEdr91onZtyO3vJ
EYYHEX/K4Q/WoowycnKh8f2PphH2YD0GebCkNP72hCKkQ+J691ek+8U+nuHPCE2V
iSHv+Atrsps/yZuwuUb/ZArln8P/RfJmHnHDIOAuzwcoclVXLpsyCe+VN09PJ5ki
thbGF0oD0ot9gbphbdAEsj3/LThJ7OYkQH8IYR6stOU6PWQBo/k=
=wg5B
-----END PGP SIGNATURE-----

--N1DtTOcNR1Tbld6e--
