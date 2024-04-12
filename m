Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64649171A7
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 04:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897064; cv=none; b=RU1QLyun1OPZ/nS9jY6zEgAP7cewBtty31++UgbBU2hcmfk3uYWIv6DIlF11J9Dune1j02k60HQ3uA/qZN9AfS3xzkF6ZuACyAez+gQnJFzIuvM4R4kOZJZ3gIf07psxGj7Fj4RnFzLyzSZmjzHGnMpSnsoND3f11lhYbdYxUqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897064; c=relaxed/simple;
	bh=vC4++A7jEZqKU2WtEUpW29k3PSOM+rm1oGDQcBqGOls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTUoEPWlCAgJKKSYjH7OOCpoCb04HRcNnKmiuzPNEiFfAps2WWfumD6gV4zqInqxU9ziQB7c4ec+HE/yFIm8EF03zr/vfynLDRBIaZegCWcOB2Ov3tqt6fhYxKyVO9xdKFJq7tAwuWUzMWsEEroPbCRHEVaUyG5RBZY211XBHf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dC8PKmkO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FlcyeVu+; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dC8PKmkO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FlcyeVu+"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6B65613802C7;
	Fri, 12 Apr 2024 00:44:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 12 Apr 2024 00:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712897061; x=1712983461; bh=izbZvmkmR8
	5zHHWTj+d+j0a27rjfATGifY+2is3D6QE=; b=dC8PKmkOFB/DxWPZRMDylQai1U
	efW3o5Sd46ACu6mdghsYZAh1pXuiRpXqF1G9v50mo5FaC6uZSm+iBsJzauxIqsf9
	6hsrgDXagQQMoMWeVj9nmYspiuSnLp3tDDXXY43TY6hEBfBucCq7eeniOfee8eqz
	o4FXpfErKn22WWTUI1w8YQz9BawuBC0Vw9lORInGJI1t+WzROd5hPQ7bbwkwYh+C
	Igv3LT1Tui8sBsW7Q69ZqXUPAX2lRdn5hpKQEdyCcDPi4sFpdgtTNakWpUH2RKJz
	BF5lnCRUzTUJZ0cDf9oYQZY9mlIsrXIuH3+kPl1GFyRAZtbzrBSBAy/+aCJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712897061; x=1712983461; bh=izbZvmkmR85zHHWTj+d+j0a27rjf
	ATGifY+2is3D6QE=; b=FlcyeVu+lRIYnXLElbFQF5IhCQex4VOAZhk6w1SFK5cd
	XUZ4bpvPhDvmUI9VodBIKn3hFn8+pbwHOpir0EyA1hsl1eNrbJlwR92Axi147vN5
	KQxS8ZHmWUxAscJxGTR+3UI9Bm429EKitfiAumM/kLP+46sPYqTn0+LEJh+CBj3Q
	TuPlKqXzdhVrJIFHhqSI/XCwXOC6mLGXigZH3qWZxIcBnq2XExD3md1Odh7/2z+w
	UIpw2vNkB4gj8GUWdiJsU00HFV6KwokcoE2cDNxSUm/LyAgqBEH59spq7kyc6/6y
	cypRCaeNwcvQqLbvIPWg263LzoZliNqKgAMFCDGVRA==
X-ME-Sender: <xms:JbwYZj-TOpmuUaHToY7h87HhCO36jYqEQt3BVr13UFfvtscf1UZ2Ew>
    <xme:JbwYZvtnRYbCwbXsIUEBLK2KoPUqkGNrVVCjU7rpz6qyjSIPirzlN45gauFHJFI_T
    t_yx3iYyrFaqZ7W6w>
X-ME-Received: <xmr:JbwYZhAgvQM9Qx6AUg9pvOJ-d-Ida8OrA3Ax8YSaxU02ZiEumTtwTWHBRevB5LYqSwEj_hsz7j4S2FegVVzHPNzZGLulnE2QJX9dfXFqKFZAcSNkSEs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeitddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:JbwYZvdy-DWoAMQxNwudKVKUnhzyecR6MRRNgsruIjrfHnJJ5DZO-Q>
    <xmx:JbwYZoOhCpynYqwrIza_21ARyfc9mhrvfTNzWNgu5Q4GpdMBCHQSZw>
    <xmx:JbwYZhkTTf0g639VrETipwnfLIb3uYXWKvI86WOeB1FapT8Lmi0-Fw>
    <xmx:JbwYZispo9R37yKeKZ1jN2M2mZkvj4l44vEo0-TwotJQwg15lTstxw>
    <xmx:JbwYZvfmlNKDCO0Zyx3Ke--XZgIndprSEJWoCzBaw_Mo_ex_mx4koWTG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Apr 2024 00:44:19 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1778a7d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Apr 2024 04:44:06 +0000 (UTC)
Date: Fri, 12 Apr 2024 06:44:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 05/13] ci: convert "install-dependencies.sh" to use
 "/bin/sh"
Message-ID: <b8f56a5e67495f4f2efe6ee991eeac386f600dc2.1712896869.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712896868.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X9CFuNAH3R725rVP"
Content-Disposition: inline
In-Reply-To: <cover.1712896868.git.ps@pks.im>


--X9CFuNAH3R725rVP
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


--X9CFuNAH3R725rVP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYYvCAACgkQVbJhu7ck
PpRTHA//ZEJ++J0l4FXq4/nnwebM7aIj/uBCRYIvDXqAX5yu+gI6/05zHKL8kia2
X4NLsEMgsfsl2r/4/qKzlTeB95n2YxJRWgyMpFpAJxxh6jzafpVKm7lLHHdDmOkO
tj2d20EF6s/btuK9eQyV7JT13JIJgzs2MMe21rrNVAu816mn4vZxjpsyyykHSguo
PwLUMnCLy0iMwn9j+UrcigR+YUah6hVo9Hhv+4JGFQzK6AaEykULstkR7YUo0Nre
x9kJzTob8rm9KdOOsdtrL5rBo3Ml3kpMr2nnqh6Y9VINQprtBGqWe/+vW8D8bb+P
ChcRje5PtRHqlVRDSf3j4C26d8JxOa+SH204w5nEAiWKFkrxmAXA2UyDVVii0bCp
WX6GAGxY/0mDyFxYx17uK48+UPLtuF+1E5btsF4g/aaYSZ/1LfFC+/lA0OQKZqng
urNpNXDbPRmLhX+uCGRkDbIY/yiYwa39n9JGFOpxhWmX4yJk5pd8ZEdhpVATcT/s
JnaSoaaKR/y6Nq6rorGp/ghP+M/hLjQGYjc6I7CSsky328clGAfT4OY5w0Jeh5gO
pBh3HwhoxDeN/ml+8JJlS5r7tKkTR9PciZJIUU9xenMwXsZQtgXhME6EYdz+0zvE
aCZ8Snjsf8wBUNCejSncM4+Ylw/3u2cOJs7QIAk9wdA4yY+OG4w=
=c1Ir
-----END PGP SIGNATURE-----

--X9CFuNAH3R725rVP--
