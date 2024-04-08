Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8760328DD5
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 06:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558802; cv=none; b=AgqdV5464AoOYE5YcR2rcRI9CCvOdCxNlGajXUvr7CVnnmeTHJGjavQXSqA0gval0C7ntgdJznSRAAyzcSezCwB839fZ4FRGo05+/8UIzl0zMWJTk6bT3323O8O2A62MJyxHYtNN7qE7tz4ZmW5T6qUXLJJ11zDZjVhuW8eRVDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558802; c=relaxed/simple;
	bh=fM8Uktwcdv82QiLc5fngDGdwSfnwi+pN+zAooCRn1n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdKs8rfyYNVdI+ivDexPq8yvLelB6nITldsDTExiu1tEBLNiG++aEkpWhCF+2gddDEmBWYKRU/4he6dZu6bef2DqnRlE/PNSmi6YtpJrmj1kPgQcaU9f5vtRxLWGUl5u39QtO94bPERolE5UD6Y5qHngSct6JUABmbwhU6RRtzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IGP7Rges; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D+FdeeRM; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IGP7Rges";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D+FdeeRM"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id AD6F81380059;
	Mon,  8 Apr 2024 02:46:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 08 Apr 2024 02:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712558799; x=1712645199; bh=chTZxDSNeW
	nYeefDlJMPh+RGS1KmX9It8WS/bbf3UdE=; b=IGP7RgesMXSV5bHskcDqJXydor
	vzvJmMSbgIkBm3U03qOhiDnBeLvV7kJRRoYnd/b/9E3rQjPYd6ariP6xbEcaWMlf
	CB44U7HU23sagpCMCHfynbArM4ZRCAxvEGm8p8e9Hrl/WNsXNrQdbcrzWoZ44NOL
	ZmPtm4EGd4HRVkflDtQv13epeQsroILvQ6vUeq+ncbBT7arvdUPF6cSIvPFuMI32
	Ru0eGSNwYfEHQZ196ZscUV10OdVManBJgaC0t0VJR7iiHvg7AErnDNGe5txtmcFU
	lOLN3l2pXCJ8b7PPSwg2t2XCReI6NErrkSr/cIyZ7Mck/8wUpwvUoWMv8z1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712558799; x=1712645199; bh=chTZxDSNeWnYeefDlJMPh+RGS1Km
	X9It8WS/bbf3UdE=; b=D+FdeeRMOzlUpqu1WhkX/5hy76dpflUJX+izOjuia8tm
	mAsT6+CGl3J2mku2E2Hq12olumTNUg6sBoocCq9nWslhi/4/BotSs5UlzD3kcDpF
	g/OEybbLe/rygWKyP7hX87kXjBL/HuV3/5TRKtVRXB72gIUKr72jVtc2/9VtHy5Y
	WEAej03mnLkYvqZLLlwN5dSBP1ooDBJ+/p0yuZl4HgMFGpI1GOYUP+RqFksWpLaI
	LkpEjbrc52N6jXCb5w587LDxLqdedhqqz1TbMHgNBImZ/T4DNiFi4bPqXpKmwsvU
	Wrvptd9Q4EGiu51YRgDgM7pn2Q2AwzxD7PMUQYjggQ==
X-ME-Sender: <xms:z5ITZrJm4l03gWmuoTJWTkjYyAkCyZkFA9gntKFoyjglwa8NSaoA_g>
    <xme:z5ITZvLBt7HRot6W14I_zPVMmSLzkJS1ybxJKRr5OzSHQi5vDh8VaVHIYO6PBdhsK
    ag2Wl_wi75qF_89nw>
X-ME-Received: <xmr:z5ITZjtY9WFElOk8NUCdbMCcXnpSGuPe69nP28saGS1TUDlw10unX2Oqy6PTcEBlqr1gZ7o32B8qzzS5ZwjdytGxB4HMCA-zNB1a5T4UWtCTzYgqlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:z5ITZkb_AuiO3jElS8DvHiVyjDiT7u0fZViDnU-2t0vk8csaIQVT8w>
    <xmx:z5ITZiZZa7_jC7tHAk2KYiFVeFquHfdQWKcXH3sqNDGhxTv25eocOw>
    <xmx:z5ITZoC1u5akb_xHCxYuyi2z3HdEbmGWAXMCG_DCXdZGERx2sDxJTQ>
    <xmx:z5ITZgbZmpdjws9Ti5IQ5ENdiMPda1HSCpX2MUqFkCLFywjFAX-kdw>
    <xmx:z5ITZpwt4_jMX6XCwgpkUUg8g14Z0JHNYYkEhIMB89NYhWByNtKDyYci>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 02:46:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 59dddd31 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 06:46:33 +0000 (UTC)
Date: Mon, 8 Apr 2024 08:46:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 06/12] ci: merge custom PATH directories
Message-ID: <d9be4db56fa028c96fb316413e87d3c37c3ba602.1712555682.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HxFIwHGt62hX0uTX"
Content-Disposition: inline
In-Reply-To: <cover.1712555682.git.ps@pks.im>


--HxFIwHGt62hX0uTX
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
index 7bcccc96fd..46b9efb2d5 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -29,14 +29,13 @@ ubuntu-*)
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
-	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" -C "$GIT_LFS=
_PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
+	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" -C "$CUSTOM_=
PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
 	rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
 	;;
 macos-*)
@@ -47,10 +46,10 @@ macos-*)
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


--HxFIwHGt62hX0uTX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYTkssACgkQVbJhu7ck
PpREfA//Sm9CHcPwXDGHoVVlNCs20aFAsHhOrYBLwIT2c7vpHmExV6CvPITp6D6y
cNuqG+qYnVm3klTJ6NlgBYPh2STQqTaCRabCBUCdNIxbNqTLT3REDqEViBJ+T4HA
bSceWA0y1qCwqmpLymwxGU5FfdjBjnGKt/Rg4E3bskB60mAwcx/WNrIbD89Ql5yR
T7jr4X3e/n2V9HLGz5rVT3SvAqaDDJNPjRziW2X8XcNdffDElq/wi0E1juWJoupa
cXDljCAZ7DZ+b5ioViqIx6gigdI/Cz2dhRGZTS9d/DED+imAvyRR/OMSPo38tNSc
+CfhZ9M4QdNM75uwg5KwgJbGCKgojzOvmF6y41uOmcOJsY2/z/Qetj7k7y+K1qOX
DLqNDMQ2vlrgJtB/8Tr4I5UhwY0eqMvm8PMTQ4nsme6WxGr3jSrxljHWo1zD3Wz+
fzS7ULdDFPFwyhmsS3uLF1cu2emzX/GQtnBInCZKIezSQOD0844ZpL1JDiu9lxpW
ZyC+kN3AQQ3UoFcmkldW2qs6U0Cntt02dsDdSKgYWs25XVKyI8Si+dRoKrRGOsu4
p3G3eRYMqdvdiDCLDyjUMCilJgHtTVVAs7od6kQbm34bTm1mNz/ieT5h+lJh2x+N
OzHbvq6rtV+2Yi35c9mKn31s58JGytm4tXnnvSmBm2kPXp/EOIQ=
=QFKI
-----END PGP SIGNATURE-----

--HxFIwHGt62hX0uTX--
