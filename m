Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413F21773A
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 06:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558797; cv=none; b=YlWhCCw0/Z7JzDzy8qtdBsC3yU1FV0+5zT6xHXQxjX2R8uAuB6ecklEGk8ovygAzf3VndipMl3owjKYXenCJS3IVuvkyXPkV/kwVowF/oRoHFPwYqQY+v68vbZkLPaAYaYnomEo4RovyRH/eqU+rLtqhaeJ+y6tvMiOhZ0+TlV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558797; c=relaxed/simple;
	bh=i6Fptd2okvUmdXYWADhIoDu+gLEimpu3r4x5uZC7K8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFa+zoNLjR2UIzxY7tMG+28YPSecQkoHEGwPJsu+VPyZQoRgKZmDUPEOmQpGeJzZUk3FAUIyWLPl9axfFJlexE6OA1feBSnmrW9KfOb7apzadqICHbjSpfvp/VIUyhWFTcmvV1uhY0XpmCWdX1eWG68unwGT7Ma+I0AJ06nBgE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H/QRfxUH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TuvyywYV; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H/QRfxUH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TuvyywYV"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 568021380059;
	Mon,  8 Apr 2024 02:46:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 08 Apr 2024 02:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712558795; x=1712645195; bh=S2GikXBjJ0
	6VrzQwCNzilQ8rcbZnqL8jFqOtoFBoB6Q=; b=H/QRfxUH/vZMumB1QGLzCG8Zug
	+qB0GDXYcJIRu7cOpoAi/XLycYaasakokVyKjeaSuUlpTEvJLS3EyVZgj3oO3j6i
	zhQiLNyYCehbaK5pMIXtGWYOwxqgack/CGxEVVn07/pDVaFLZb3t7ITPj3g+r1QY
	IQu1AAo/edjmurKXBKgNlwqlt33LXexCScK64scrAwT3gNQfkquJ2pNMq0RTOBbM
	cjwJiSEoQH7q0ou3busY+zO8VS6p8YIteldF4UWi7CVtUbj7ABzj7ZHVROi/OndS
	ITRssdCHfk8HJj+Fe9A5nFQ1+iipn3S6PfCCUIesKmaKSI3tpJ2iCrisNpLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712558795; x=1712645195; bh=S2GikXBjJ06VrzQwCNzilQ8rcbZn
	qL8jFqOtoFBoB6Q=; b=TuvyywYVnmLgEUndTMvMZBI/4IpM3Og1sN0lV7dQRcsu
	zU0iMy0draI/pIhIpzl2oaFefp1UT/b/0HPtE7MHGfHO9/zRwehetmcQpUzEyPST
	nghNbawZjjG8MKajS9F0uf5uvP/I8//olHOWtlpE0TXc6+cuB6zTsn2KPRdbWTde
	veYFDKTr56ozukwZBKXwYbU2rv3ihxc/5m0SRD5nqPQzEDn+aFKHI67bPTkNA/ip
	dO2Fgsu5x4owhSOepzDZ+0IvQTOSaaIWDRE6+6nVP2rVpErfCjm+gqEIjN43iCpS
	EQg1+KHWrxMGpME0SnqAlz/PaxtkS61KSw7Bpb/88w==
X-ME-Sender: <xms:y5ITZlMOsWQ03lYuQ2F8Ekk0g8zW63d9fIxyKbUbPTEud57AcKij8Q>
    <xme:y5ITZn_Hu2jWlgTpasDvJVJ5Xyf1DbdvAsB0jQ4HfLmme_XwhCVGCfCBseeAgPnj5
    aPDmgOnEIjlE4FnAw>
X-ME-Received: <xmr:y5ITZkRjpE8fO89QnvxF3UYEnSBdDcyS1NsIWEKPhc7-e-gpsqtf_cBk-6xaOTo67mIfHNBMHdTE8qgrCRKCzSG0lEoqS37C-9SHDe-HKdM9FlvvFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:y5ITZhvIwFlQwV-NFMCCLcntwNRAff1goCLRxLfIowyusYsbfmlaYg>
    <xmx:y5ITZtc5BYqUPqW4-ulJU13TKTGiNYptm8oSenmB3_ol4Mp4PFCmpA>
    <xmx:y5ITZt1mS7u6KoXYMlua76zBztuT8bU9iWQpKbQh1k_O1He9d5ekzQ>
    <xmx:y5ITZp_r3mlHcFXumdt8cuh-XN5C1OkPBmZ4tqbHr-gbIH6XgIqbmQ>
    <xmx:y5ITZmGu-3c0Be5y3BPdjXfb7An4qsu8exYSnzlVv2noEnhKw5lXTPAN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 02:46:34 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ef9896ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 06:46:28 +0000 (UTC)
Date: Mon, 8 Apr 2024 08:46:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 05/12] ci: convert "install-dependencies.sh" to use
 "/bin/sh"
Message-ID: <6abc53bf5173e7de3fa271d175145c1672f17a88.1712555682.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WjvCW5WJ1mnAo3sL"
Content-Disposition: inline
In-Reply-To: <cover.1712555682.git.ps@pks.im>


--WjvCW5WJ1mnAo3sL
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
 ci/install-dependencies.sh | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index fad53aac96..7bcccc96fd 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -1,4 +1,4 @@
-#!/usr/bin/env bash
+#!/bin/sh
 #
 # Install dependencies required to build and test Git on Linux and macOS
 #
@@ -30,19 +30,14 @@ ubuntu-*)
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
+	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" -C "$GIT_LFS=
_PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
+	rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
 	;;
 macos-*)
 	export HOMEBREW_NO_AUTO_UPDATE=3D1 HOMEBREW_NO_INSTALL_CLEANUP=3D1
@@ -53,11 +48,10 @@ macos-*)
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


--WjvCW5WJ1mnAo3sL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYTksYACgkQVbJhu7ck
PpTebg//T0T3wxyJgs1+6cg/JLjwyo1vt/wdZgvzvGiy82cG3FRK+kqJhvr62E2W
ai+Yn5n/WTGxl0P9kVofNdB2iTrCkAX0owZ0vkZbCZ7n8BCmgBgeOHc6qdjFZzpL
GAb3zBMywsXaWRHN+ISyEYQLNEv1R0B2Cg/KLHe+9vB9bOSChGZ4xVpI5ZePQAel
WoN3HwIaCh3lxiU0Skc8z1sn5Pz04+qaiplhKTk/gLyscEqqSJ/75pdp8e4Lc5cJ
gigTq15ZAFN6EN2uwhhsnAmSk7B7/zfA3NjCvekd6NCfQbCl9PGLZJp8P5ASAB2R
QIkCnvzA1THzlXnhtiW/WdtHtvkOk1PzkDPLyw4UIIf+tlw8u8q1n8fv9TEyYeUD
/92zwFEhR2bZunVj2FNHBalgUCd8d/Jw94raIXVEZ4iE6pm7Vf5Ypvo/gGPr58pG
FqeCIHwmSfBmJDAr+EhjAEnM/j7Qw9F05Oouy1aG+4YmpxP4gQpVIp4YCuDhbrO7
xrD2IpWvkMY5Lj+eUsLigsKaMKZCfrFRMkCRyF9dgn0eBQVt1OD7FJK7tS+mK+lE
s7Ur7oJUkgX219JYyfXfyc8wpbU/RFhwSbIQWstpwNCyhNeNPWQXWAYTn/72sbzm
PbC2czBN09ZyNArJPbam+k6U8udn2bqIRjDdM1rVfDvr4lLNxnw=
=VL/F
-----END PGP SIGNATURE-----

--WjvCW5WJ1mnAo3sL--
