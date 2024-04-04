Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB0076023
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237133; cv=none; b=RiduLjsUa9WvnFlirqhK+4paIWMw8SFWTCp9tScRcz39xs0IhmQ/DlmrmJd31QC3MlEKyK4xpAiwnCWPiL0XZdHUSB9KvFqldkUWUi7ncjm59gxU/II/JPxC7NwN3j+Xj/QSMUZ7h2eXhotD8n4ZPjNptoo+54YamnZsgdcduJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237133; c=relaxed/simple;
	bh=hRQHKud4/2C1rGQ/ZITVN5Pbq2KE1272nf1vDQ+3Hdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYVKpdG7hL9FLwrqnlhGBm0DjxRXP4Qmg2YGugIjzulsY5iO863OQrhIpDp/GzhVf38FJNLx7ev9jPZaB66he8T/0WJRWxBlIoSQ7u3xcd0cNIC8pkKThtr4Z3T3fTjjnyiZY+HYsecGF8Acfzul00Fd4e1/jaW4cNz37wM2cpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GDJicIh6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sH/mFJv5; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GDJicIh6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sH/mFJv5"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CEFB61140122;
	Thu,  4 Apr 2024 09:25:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 04 Apr 2024 09:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712237130; x=1712323530; bh=9Y1dwQj/4c
	50txMEhhYJlrw/r2NTXMpi0vHr7qjXHmY=; b=GDJicIh6RCWBhllOeusSmq+Yhl
	5oJIOrsQMgp1usU5FFGAa3VI8ENTaEqgekdGwQpGnBQSHxp4I7f0acu+F3a5eEZR
	0XGE6snKnQQEXOTrtvN79WYf/dHur66w00LnAkliLtXHz4RLQp5XomhSm2l1E1SX
	42MFsETbZT2J72Gt3lydYKmi+SDAG6eoQ4/sBB0aNwE8sxj2nHgs20N5Bhpzfs82
	zROIB8fLsMdUl/V/I0yu34T84C7/+OWwSPdmeAEVO9OfM52fOnGZNOUnxMTYtJnc
	eEcv0AOyx71uyEd93i5NMgLoObodW+ZW//WRTQ4+CIMNgIUWuN6yZcWugIoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712237130; x=1712323530; bh=9Y1dwQj/4c50txMEhhYJlrw/r2NT
	XMpi0vHr7qjXHmY=; b=sH/mFJv5ZVLGWF/OjIrnO58VVZ3kjRWH+oNybAlumAba
	fZBXtAYrdk2NWhDLmLKCQqETUxXshZNwUMch7YQuhiHyZGn8dRJ2gB0eMJpdVPYh
	c0bvHwwfsTKcjJIeW0BOXKOY9AeoBnVdRmmEuClWpcYW6daM4KhaOHryZAVSj5Ou
	HovwzjI0Tr22Y5XLIE0OLOrph3A/KXSZ5MoGBOjFmgaVHhYLqnXseymszIWm5pxn
	iMxybf+ZJttmQyl+aIRfs7XIsRwh9Z4zQNVO9MlbfOntf+FFJXCC53/Xho4QfoU+
	se3nlXpqmfrmLaEa3h/mmdtM8VjSe0eUWU1n7Bx3Uw==
X-ME-Sender: <xms:SqoOZhKFqU64Pffbqqyy5GzPgBofFkA85-oE7hnZjXOSNnILcE2P2A>
    <xme:SqoOZtLwSVx3PdPOr3AjBiUpjas9GFUuJ7-OSmgT8Zv3LI-IUXFGYNqnz-4bBhoss
    uBhe0c-pv4Fz6V7Uw>
X-ME-Received: <xmr:SqoOZpuN0M6hvgE9ShvtuOfrCmKRjtHtfdi8_qUK4tnk8_dpT-bC9XFcibnOQpusbR7FSessd_YpVpXN1wbNnRCsdtLbUEQIFaflpg3jWL2xefbT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:SqoOZib5zKd1GFser1CCY0bUQ-9sITSIjj2byZTttx2JNiSeiNu51g>
    <xmx:SqoOZob9aXmrf6ZdRVY3yifM7SYcfiRg5QOqgJCET09XJ5JOP0ZzeA>
    <xmx:SqoOZmDyVVhkHF18swDXwWTs_mWXeBPFqhYVddvWdxvHiG9FmmQO5Q>
    <xmx:SqoOZmYEePe6NtVx-NgvB9REKCyvQbT5nb6_CpEPPCU4fRwpggucGg>
    <xmx:SqoOZtNSqgOz-8hOQ8bf4zljJxZlVCfXYORIyIR5IPTaNAtFP0dSKmXW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 09:25:29 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 12269a99 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 13:25:26 +0000 (UTC)
Date: Thu, 4 Apr 2024 15:25:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
Subject: [PATCH 06/12] ci: merge custom PATH directories
Message-ID: <196dab460a3be1e028924a88dfa794547c082bb1.1712235356.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9NbgoxJMR/8+dDCp"
Content-Disposition: inline
In-Reply-To: <cover.1712235356.git.ps@pks.im>


--9NbgoxJMR/8+dDCp
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


--9NbgoxJMR/8+dDCp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOqkYACgkQVbJhu7ck
PpTW5Q/6A3Gh0NiNgCCpicWIZcKWNMSu77rSVj0725Z22EkbNQ39NmvLAA97/+uG
IgEc9D4SOWu/cUv91+s7YZICHj9K2FnVOFQi7VGvVl9Zxb3vk2mCEwM/sKp1AOb+
8JZDGLlZ8uMR2Hv1YSioTsFGAQxhQRpRCdzKdk2WtwfuQth9hu9HdZs7Qj85UDR5
ZV3CAK5YFBFGmFC9xsmTOgJscnd79hgFKqPa5likcqjjCIf0gotcjwt3qsHVgM6g
4a9CheWJh+qU2k3svwLRNFpTPpeI/mUb6R+NTF6Aei0yayxjMDzkwkth9cpS9OmQ
PFO5ojOja2VpnUUL25mrisPLPZ6CkbPtsyynsXjtBjJ4Evp/obStKjtzmc8BrxJs
j5GJi+Q5680/962Dx99iH+cK19Uw8YOhuA2sd6PVibHF6mlajeImwS33AS/hTa2V
AHiPjtLzKsEd1sJ3Ey9QlHTUICuoaDMjx6A5PPmlp2iVUamzSnGhhwQubj1whlNi
ckFO8IzZHtmjZ9GnBN2efSEo0BVlKvRxb0L1yQTiKbQsl05aB3gMN7OaWYjtH3BC
Z384LAtuYRGj+2e+jp3aU1z09p4gZKY2cvLazqkkFDd2xjGrdW/0dLfRNZjvWFEA
YD8bCGsYV7YjV1jqXmRExGXPsqwpDZSYDxqUi3oO9FxTkVXTQfk=
=DWd4
-----END PGP SIGNATURE-----

--9NbgoxJMR/8+dDCp--
