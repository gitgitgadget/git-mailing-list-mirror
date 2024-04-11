Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7086FB5
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826633; cv=none; b=JRfbH9r1WK4TwQzfNtNW4z7mPjqbxm1IoTSEHQelVn1u1BGzrQRuQZdCMz0gSVmsBDAcn2CVRcGBx6+NzLxCCjjVai+0aJFuHiZ8gpTvKRRvMeel/N26CNAhwj6IziCwK2TtZnWfvBwPm9HQY8o+E0HOO3wbMvnDrwRkNDcfK0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826633; c=relaxed/simple;
	bh=o07hlBR34doZ58FGQCHU5vvc/lDxMkeTagg0+WkE75U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S709oSUM4C7uSoU6999XaLHkLMl1OWqXVl0sVC75AxMg9+NcqyOZMoiNApYqweamFBYxk+gUR+8Z+mUFj1QOFAQs5CjguKApB3JWVZqzaBuIN9Ck+mOMPDFwsoj40SON/PELKK8exl7c1QPpl8DJ7FPIE13neojGcEh/XEu4B6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W0+kIkFU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rcZcEdlh; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W0+kIkFU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rcZcEdlh"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 674DD1140152;
	Thu, 11 Apr 2024 05:10:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 Apr 2024 05:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712826630; x=1712913030; bh=/Wjh96nBV1
	QyjAWT6NqfSNlHTEyrDyUMxIAWUSFuRYw=; b=W0+kIkFU5ugViLUJ418jOroHfL
	CxCetK+WZ4DuVX8WWWKRH8zguHfMwTeqYkqgQRhVG9ijJqB7+Ci7i8WaTRP/3aIc
	qb7QfNQy3A1zfStGjDV6bJrZsZ2qimy37ysxtlKP2FkWPcyCKdgKLPM85WaPM0w8
	0IOO3mnadlyg54d03qSHbZ1chU0PIXYRsiUIcErgyRIRCNyLJLbW2+Q+6YDwlmAp
	sIA9j8hO5RxvjHuDGDOBX0WQSkVh3KIef/zQurixSRwo3NpC+2znpEFKNbnyPq52
	ArLtvw7PJ40at1Qk0Hb1XWkjwEzJLdMbe0E0wUm1eYxuElUesbKrWdQwB3YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712826630; x=1712913030; bh=/Wjh96nBV1QyjAWT6NqfSNlHTEyr
	DyUMxIAWUSFuRYw=; b=rcZcEdlhJUFdeO4+2Bz+9ZMeniNEsd7A/oDx1oluhj8M
	Ao9Hk061Zxid1//YvVKoiVbWBF5TKNauwkwB+zKg5hfnWjBEMEfP0JGRv42PDb/L
	ZxzaarBKW/j+RZ7EweeBqllRCJEvFKWn1OA+mwwyjDGJtkmO4qi3tLNgovpnNL9t
	7tF3PqdrU6MxlqM1s9vjsv2XL2UV/JkhDa9PyQS/TmWmoQUkiqR5FGmuQo8kRdpb
	7Mfu0rOp+G6Q2Pr6MUYzDIbxPVqxF9CuxJlquZ/P//y/+fexpt0ST7qNYyELO4zc
	iGelqZHW/GMWp4/YcTtPyzkNwH8cpRzFLuz/dKzgtg==
X-ME-Sender: <xms:BqkXZjbX12W7aqGXufAHIozx7jqt8KxT1oFYr1IczvgjIIhNAKsmFg>
    <xme:BqkXZiZC_8lGcYWCf6zn6qZfjaPIJKioE-Zb8-p9x-A87usVFsNpsNvAb2R0enrZO
    FehTH7DumgYmt2g0A>
X-ME-Received: <xmr:BqkXZl-mhT0XD2p3IWzgTqCGLW4vqaWPT_Vo5ya2v-h3vgywz8ou8QfTSWLWXRVoJbKOdxRm9yQtbnHXadB13z4e-5-Zvb3uu56YmcPZP86IcI0L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:BqkXZpqc2Eudm8Hz-rVeZ2kz7tkpGHG4VrHDcxie8-iF3pOuG1zIYQ>
    <xmx:BqkXZurNKA6gfKE8ifZ7gxJoJjBmQFDvHkKc9TUe1tdqObYGqY82aw>
    <xmx:BqkXZvSE_vAjmZPybu_ZWscfZQRJc_VwSOgcMuRazH_GstXclTigBA>
    <xmx:BqkXZmplX-OzWFD5evvVi1Xf2MvnsVYTAIsG67GFroAQdGiS4eySPA>
    <xmx:BqkXZuKh9XPMG_C0VMem-Xm-TslvfKix8nElACxQoDGVHZjMTVv_XsQi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 05:10:28 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6cf832b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Apr 2024 09:10:17 +0000 (UTC)
Date: Thu, 11 Apr 2024 11:10:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 06/13] ci: merge custom PATH directories
Message-ID: <61f108d95463f94b3921669a276472bd01fdc606.1712825204.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712825204.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HKYE5NrFoB6nOCeF"
Content-Disposition: inline
In-Reply-To: <cover.1712825204.git.ps@pks.im>


--HKYE5NrFoB6nOCeF
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


--HKYE5NrFoB6nOCeF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYXqQEACgkQVbJhu7ck
PpQAWg/9E+wRbg1FXkfjhZm8ST6A0rNn3xABAAcwktGU7NxgM9lNGk7slcG1YWGi
rIfPnWi+gaP0bYvZ1Wn7ZA6dUzyTXeBGYQ4/5uQKApbT3xMj5UMqOP/4VbxppYjF
ZMuPk6e+hMOkU9iwKF1laoIOX/+9UKyuQ16Y2f4Gs4shkLk959UcMjZrojRcWAJa
9vgI6WhI1r5Ac/PP1p2WXelyRq9IDqQX5hWTHrVwy+R+X6Z34blM3bva9XTeEQnW
JoaAWwheu5g1I8ygqngJLnT0L8jV9TFdNnCV5Bmn+D3OwgCDgVdSnQGwNdVZG5l+
L4azkk1Ui6C4YmcK1ZNeKWVDrCNs/QxhJjZGWjMzll6UnZEcrDACVUKAInSotEQ3
660sYxJKSR+Y62IuPYIO7rpmONrgMEEgUzwikkSHgBsgTDxxIAd2L3p5jL8ep4xq
BlYfBggovlnqVBor0dbpXyr1z6eHVBxI2DDU3Ur0cyJerk/2OSmsWMLFb9VIbyb3
nKQw1vuat0WUjXf9tvypv5VBAOO/RNatc1iYu6rU+c8hHl5h7npvrndfCGk0lpAz
f6H6X/iyRt7l6dfrMX9u+UkuXqQ96PDxA3zgk3plHkQanM+rt0SLN9fPUbHLvSFb
XbhPJVs6Vn+rsC5uVH6vLQxC4LUBDPXshvOh00Dyf/N21slQJQs=
=8kfr
-----END PGP SIGNATURE-----

--HKYE5NrFoB6nOCeF--
