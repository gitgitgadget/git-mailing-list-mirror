Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CB26FB5
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826624; cv=none; b=c4o+QZ1QNUc0OCLiY1p2n08lNVUvdTSgN7eYiD49ODHNcYDJA6pzL6wvD5hbcm/codN8lsm5E7a80g0ySdNhKtLIafSwje/0MvAEmcum4kJpp8ct98lkZ6asuTHTHbdI2oKvWf8JAflbNxNp7etIPwJsOKjNaIoVDzeWK40OsFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826624; c=relaxed/simple;
	bh=EhJehMy4v/JcBG6bPzCDdLb6/iitYNTgethpzXmJsOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnYof+NhluKCdy1qS0Yftl/lZuAl+fi/qJFQPKSxozQnkkSgtSHeYvlqsDWA24nDyd/aayXYxdJ+8q4yd6OqoFkLcBq4kZ3Uphh8gi+CEMyKI3f3M+eKcanTjrhks2dS8pebuB5rQkUX4/o6aRs9aJFh/P16WSTtGldncnleTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dGFI3ai/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FP5sLoLe; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dGFI3ai/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FP5sLoLe"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5D05C1380222;
	Thu, 11 Apr 2024 05:10:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 11 Apr 2024 05:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712826622; x=1712913022; bh=hSjMHjZqGv
	cL0fgEMEdT1ZJb3eMDkdcteTRcrBxkoEY=; b=dGFI3ai/fX4CrJ+vk8Tihvd/Ns
	n63F5afyFayk+HnS3GdY8IUrxd+e9bduC55Qal8SV1R0vAWlVzCn80N+oocTMVW5
	SW0ipfpj8M27CL6AAGf1XLJo0xvxw5xXZsKtX5cCqx/UmVHlZ9Y5nZODDmk7Ryw7
	NPSg5XEtTDggQocz7R/ILayADQw5t5rlhpfTsIb2w18lQqkZXKZydSK9gTe2K6lu
	b57Tvq5khpE5QdqcudhM7bMuRrCusV3qXz+mP8qzGlMAhqqppoABGHsnASrKSyrP
	mY8kolv63V42mDgao0UUxQFdr+0w5EU1KL/bkRs7h0mbFE8pWzPLl2ZzpLEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712826622; x=1712913022; bh=hSjMHjZqGvcL0fgEMEdT1ZJb3eMD
	kdcteTRcrBxkoEY=; b=FP5sLoLebOYpShc5M512Ne9hvV+3w25+vk+41pXUvUc9
	o5aUAzeyYFZNO7TsuYqwLAC3DlHvcPDEve9HMTjEBopiVRgEBxfEog8BiFxEGc7J
	26YkM5FnwSLh0RrQ5cWDrNWPS1E/CH5CRdEISEmuEh6epnkqqjLUKBFtXULTF9Q3
	xWsUi9XVWbAssyUhtFZj9K5bdX4J8HPy6t0PYptN3tI5AOqQjLYMV8k+DxmjkMio
	GDhakSSxfPDVLOwZH4kEwbiZICv+sfh0QnbQXqHMA7VCXvWlz9pwG7rJfK+tOi87
	8+sxzQhbHAS60epiEpIT08ug8jOi3b/stb0txjpmOA==
X-ME-Sender: <xms:_qgXZt49HUPAba5b7UGaXMTGKjWL7Uxg1jnRv1ele_FeP0GOHU6IXg>
    <xme:_qgXZq7npq3-f-vHU7VFTt36MeFCa6yWddbGfFNQyUatc5Sqrv-JActAZFOWCUSCK
    ZgmY69-XjxHzUyaLg>
X-ME-Received: <xmr:_qgXZkdR_1MzybyvzaFGd_Q3yxUS3L0U46vZvXPjgk_CkV34e3KUsmfL72f_QMd-mtJh8gg0sP1ddwW6GcyaCeX_nH37E3-q-tlmL2u0ATOf7jsZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:_qgXZmLREusTAQJ6GIRZMJb8gIl-FfCXbyJRykKDooFLDQNNy8jC3g>
    <xmx:_qgXZhL3vD2SsTJMnAadXDH-2-kAjNI4eDL_FGpJ_tlsb-QJInovAQ>
    <xmx:_qgXZvz67fCKNQtAx8C7AeMcPBDj_0EHQ-bZzh9W3yX8Ou_An_db8g>
    <xmx:_qgXZtLWv798XJdi5JdT236DgEKQJvskzCGkNu4GbH3o6KMFNpHMvQ>
    <xmx:_qgXZmq5cZK0pm1yUZr7HLzH78MdJQ0ijPebFbV37ePIsynOH-p9ELYq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 05:10:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ab2d78c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Apr 2024 09:10:08 +0000 (UTC)
Date: Thu, 11 Apr 2024 11:10:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 05/13] ci: convert "install-dependencies.sh" to use
 "/bin/sh"
Message-ID: <d2745e9438199217c1097406102a84ed021e4d2a.1712825204.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712825204.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VQoShP+UJyBeq/Du"
Content-Disposition: inline
In-Reply-To: <cover.1712825204.git.ps@pks.im>


--VQoShP+UJyBeq/Du
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to merge the "install-docker-dependencies.sh" script into
"install-dependencies.sh". This will also move our Alpine-based jobs
over to use the latter script. This script uses the Bash shell though,
which is not available by default on Alpine Linux.

Refactor "install-dependencies.sh" to use "/bin/sh" instead of Bash.
This requires us to get rid of the pushd/popd invocations, which are
replaced by some more elaborate commands that download or extract
executables right to where they are needed.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index fad53aac96..2d6af876d6 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -1,4 +1,4 @@
-#!/usr/bin/env bash
+#!/bin/sh
 #
 # Install dependencies required to build and test Git on Linux and macOS
 #
@@ -30,19 +30,15 @@ ubuntu-*)
 		$CC_PACKAGE $PYTHON_PACKAGE
=20
 	mkdir --parents "$P4_PATH"
-	pushd "$P4_PATH"
-		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
-		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4"
-		chmod u+x p4d
-		chmod u+x p4
-	popd
+	wget --quiet --directory-prefix=3D"$P4_PATH" \
+		"$P4WHENCE/bin.linux26x86_64/p4d" "$P4WHENCE/bin.linux26x86_64/p4"
+	chmod u+x "$P4_PATH/p4d" "$P4_PATH/p4"
=20
 	mkdir --parents "$GIT_LFS_PATH"
-	pushd "$GIT_LFS_PATH"
-		wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.=
gz"
-		tar --extract --gunzip --file "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSIO=
N.tar.gz"
-		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
-	popd
+	wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.g=
z"
+	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
+		-C "$GIT_LFS_PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VERSIO=
N/git-lfs"
+	rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
 	;;
 macos-*)
 	export HOMEBREW_NO_AUTO_UPDATE=3D1 HOMEBREW_NO_INSTALL_CLEANUP=3D1
@@ -53,11 +49,10 @@ macos-*)
 	brew link --force gettext
=20
 	mkdir -p "$P4_PATH"
-	pushd "$P4_PATH"
-		wget -q "$P4WHENCE/bin.macosx1015x86_64/helix-core-server.tgz" &&
-		tar -xf helix-core-server.tgz &&
-		sudo xattr -d com.apple.quarantine p4 p4d 2>/dev/null || true
-	popd
+	wget -q "$P4WHENCE/bin.macosx1015x86_64/helix-core-server.tgz" &&
+	tar -xf helix-core-server.tgz -C "$P4_PATH" p4 p4d &&
+	sudo xattr -d com.apple.quarantine "$P4_PATH/p4" "$P4_PATH/p4d" 2>/dev/nu=
ll || true
+	rm helix-core-server.tgz
=20
 	if test -n "$CC_PACKAGE"
 	then
--=20
2.44.GIT


--VQoShP+UJyBeq/Du
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYXqPkACgkQVbJhu7ck
PpR/7hAAlBcOCDbwap8g2zlcEtPE+sqURPVnLRQnvLxECdDyH108rsg8QVoIJnNt
vHRlYt9H0txlujLvtkaqhaAVg4Rga7Y1rqsYL537MQCGDCz9LV9gab3Lq7FI49Pc
0OKvBokG01wgwe4PqCDncLC0hQ5JhYppFDw6LnHGneQnbkrcuIey+/SmBb0YoMJ3
S8Hr/MN4KXGSgeOHSIPdchSpD9vBjDGBqLp4ZNIFZVwH65IJpCeFMtvn3sMjSgnG
jEVZsG8R543goeFzTsoITWXLqY3ylGV6i2Fn710JR8RF6UKLIOcJ0Jz1MJ48jff+
VrBhcGVHwVeg7Cwy8r2GZtFZq28CgrooyE183MlPiZr5xlKAd6EBuXR3zgRgMNg6
EiE1uybkAIt1DAKG/IXy68qaX+xkpb9/v3JT6V8fwQIBh5mhZV6rQEcE+GyVTEMv
hjx3DsFmqjWkwr8tz5yNSF3xvHqXDmRLQCemdx1ADidZMjzdIYSuNckweWQ/KjRl
A2SNoNRShpx3CWQKiEwS1aoHKGETTQ/NLwysJmDhq0UzrAJ2ZGfe3ASxStKBWcKq
uVZ820oVC+6i7hn46eUE1DG32d6ct1kdC0fIoQTNdWxyKEUa/HVSxsWH1rB1Zj39
8CrcubZbyhEn0KfwAq3u1xiXjHXI09+4QhzxfgtD2UxpMVnRXBI=
=PcQo
-----END PGP SIGNATURE-----

--VQoShP+UJyBeq/Du--
