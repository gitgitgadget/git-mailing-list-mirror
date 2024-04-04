Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B71F76023
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237129; cv=none; b=EthoBVePhb9utMZ5wKWypNd5jeaXVh8BkGR56q2FdvHZbhOwJqohe9+4fZZ1LcbmPVQp+9JkkJ8mxQNEbfS/rPLhYut1yp+JzCG+4J4VxA6zZpniCqQ7WBrGKhfqrLbuVkC8AcF84AnLeem/PFpOjJfWReAfT5idZTrYLo1HCts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237129; c=relaxed/simple;
	bh=flqSBn6e1ww9DNYCcaXHtPDFTalpBc0qU5fPZLEIWVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vi9wCwf/p+e86uTOPlqlEvJBiutorX7oP+mzYV2UrCWg9mxrsoZtbLxR+YWm3Nt+uz+qQmBLs8WwjhvicVUxAcnnlVhSt23X8zGBCcp6d5gkf+T944mSCAzPJw9EVTaOTN3maqr2YQ6mL90t20lO4gYunhQkb/CvsgZty16SROQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IseYMUK/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LtQrmZo5; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IseYMUK/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LtQrmZo5"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 47B03114012F;
	Thu,  4 Apr 2024 09:25:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 04 Apr 2024 09:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712237126; x=1712323526; bh=aLmerbpV+v
	Vg008I3XD2KVw1Aft+SvKDiVCO+GY+FF0=; b=IseYMUK/4mI8FmYc6o/hHRsIJA
	RZJnwb8WHkVha5hfGXLwqYkM9GUJjYAgS+DvRyM+z7d8M8rDcHtuE6MvTxY8YdI6
	CxJHB2xxfo+SJukx+T9iYsnShW+35dfiHhOASgGVnFkURHT4YIWk2FdPWMJ6gndh
	XVntziQes/CgespoVfDjenKSzHxVs8h9iB4nNsTlpAlauVB7jFUGptlC+kZYAYrL
	atFdYWOhHlOwbPr/MtCiRoi0N8px3uxly1KlWhlorG4xCqSf81jdriemETsK44Y+
	h+a05P1E6bzg6dlATu5MseqchZV5VEqRYvxVRXkH5PfGkjyQrZA3wYrGf3yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712237126; x=1712323526; bh=aLmerbpV+vVg008I3XD2KVw1Aft+
	SvKDiVCO+GY+FF0=; b=LtQrmZo5EZzpWyWdj+HvK4IB2t2kVVTRc0pkWmX+3N35
	UVwc+Rzk1iJIVPIzGvGA+0J2GQYJPbiofpQFYp8Es5f2RZVfVjYjzVHl16u5luSR
	L8CljnzsWcM+OANrefZUf4cHLRFpYEZlfX57P4X1BqLJagZUZpB9g9eP0NQ3VXUX
	fPX0J7lo6AEuQEQQV2s9iReS7UcA7opJlhw0bagvTqm00ghIMqkUHHGAI/0phcHj
	d88Xd1tDndIh3xtJhZfx5l4CvIr7rDgICqwBUrx1V3KbfrVvqUHBk5eBEpbt7Sdt
	60qGvdDEh9d0U+BP5StBGKO9aFGiuEiOil/7BvIrOg==
X-ME-Sender: <xms:RqoOZsUw1qvLWyKF42l2b_pfsBMQTEuGsH8cwY82zFarUurpUPrdGw>
    <xme:RqoOZgnela0GhZz_Wd3QfDHjVhazlZS_09jpX1I0ZW4xnRz4CWZV20wmfHb7_cuCu
    gOSUZtRPPDmYQVfiQ>
X-ME-Received: <xmr:RqoOZgb49wOfkW5a8nVan7u6VgpvdiAaIIo8ErcxO9FY4SIDo0A08lcCHMGw_YSYahTJbxpW1p2NgrqzYbfD_m3vg4X71uBZeU90cLBVBGKnhx6D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:RqoOZrVq1Ze9O38A8U9sM1YbF_ILIFuEvV202g-odRvBbaRIvv6rtQ>
    <xmx:RqoOZmnR3PTOf0orMFqP4hdRApNG5sEs-RtdsZWjbA2MlMlH-FFUSg>
    <xmx:RqoOZgcc3EEikYdRgNaaCqC9nVE6bCSKNIez1kw3PbvYknQUIa1xGg>
    <xmx:RqoOZoHK9yaPx-yuYbmCkdbMbAE5b4jAK_PZAQ5JwFZDV5gnBVR2Kw>
    <xmx:RqoOZkZRdfK42ZIRaAKzIe0ztnJzLTnNxkto25nuTgrFB9BPkceC9pqQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 09:25:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f6dce664 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 13:25:21 +0000 (UTC)
Date: Thu, 4 Apr 2024 15:25:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
Subject: [PATCH 05/12] ci: convert "install-dependencies.sh" to use "/bin/sh"
Message-ID: <38e64224e2f0aa4d777308050ed8d513ae162607.1712235356.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8f0yRU5KBuj2TO+a"
Content-Disposition: inline
In-Reply-To: <cover.1712235356.git.ps@pks.im>


--8f0yRU5KBuj2TO+a
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


--8f0yRU5KBuj2TO+a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOqkIACgkQVbJhu7ck
PpTNjg/9GX8B7FvMwkPS/4ahmH2qIM5gMqXUZJ/eMK2AvCmH/5jhyNme5LJAql5B
9OCWFjO/1xKiB2CbPlS0mJPOvJCUBBkhfjZYHojr0PiZmxQTuqQ9EuRNm2iK6h1g
quyEucEEu06an6PPCcQhZS4Rk54JrvpR0RBEy0OUTEVuqM4sQ32DxrLTZM14r0iH
kY1kF05LabqqTyh8nZEHeRCNT4XYfHLUSWvv6yZscG6wXztSSwIEPb/iDAtZzL2O
xxvJX/AQUTPRtAa6KH+o0DoTdwe2nrCIT9RwFbBsgwOEHllNF82yfZzPuq/ggcor
RAVGeLaOLTMsbbELdkvqL2nMDWpceKrpwLZzQ0fX7DgLpsr2ohhNyhR5e1MyS21/
5hE/tDub+RfkrjukFp70WskZWSNIQzX8YvOJEZIi6IoepdkkbNk8CQiB8UMyjboe
IJfX6OKqGrw9//nO3VnsxGiWZgEk1JK2Crhg+tPz4qePsSUVqGYE0klV03V9x9pQ
SgggNrQXs674yjoBBQNf+7qRvUOYD5X8RQYT8m6LvwOpYeDJoHjTCA5iqyrRaKKF
ag+uQMA19NlaReBSzRrxTUQ46xV2ZALdaL8drfURKrzlVyWQzYV3uH6UJRs7tFSd
N8qRBIUbLU3xo1edHQ/I/G/kZvngaXRf7149d/peLGg2qDQe5BM=
=xSmN
-----END PGP SIGNATURE-----

--8f0yRU5KBuj2TO+a--
