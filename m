Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428E776023
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237137; cv=none; b=FcKAJJuaDPFGdKj+g0qwLBRLezkLMjetKEjRE1+WGc4wlOLW8AZS/cJaqpREVy40zN7FTZ8Uv/qQSvV1yz9DkX9XI3naCi64Losy304zJjPrSBXMPMMe5Q2DoztVH/8ZCSkJQd5IwJi8u7UrVkHMqK1uvfqjALLq3xNzSzSjIss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237137; c=relaxed/simple;
	bh=KrOsr+lGWpYIhQH/Z5QT3C14C5MLKQ2TV4QHT3mFDmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8yViK4b/8At40ie54qv8Km1WlRjDforBMXfPd3mvsAaes/lOUigA8plvtdt2j5EZiXJjPxE8+gFNgkZ4LjwTgJDwDNpvILgdxo2K8e8qgyCqSb+R2dx3dRGYXpOz60p6b+l+Hn0XrsFSNP/pzueYCCicDviD4BMjCjAnAFrRS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nGlKru0L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wxbJ4lWX; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nGlKru0L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wxbJ4lWX"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6A35A1140130;
	Thu,  4 Apr 2024 09:25:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 04 Apr 2024 09:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712237134; x=1712323534; bh=pR0cpUk4i3
	j7zMXGcKYbTtm8CGubZV5HR6ddgNdJoO0=; b=nGlKru0Ltw09I/QSXw9PVkPgl2
	2MIdSkCk6jpOsz6E0FtNQN8xFCSfF+LnudV7y8HIeAAMO2aU1qTs9qrd87Cbvuq9
	BW2ch2fkXMVt9NwbtMRUqp4oHuaa72VydOe9lJRWKFugySA8SWJfPVHtbytzA0hE
	Vu+G032/CtJqY4Fhmpn87kdtpbLe5ioG8x9P2ndJPiGe+4vA6WZlrNMl2jirT4qg
	t3gMqh1YfO49YbPxX+j97qb+bAiTo/3rQYMRa2diqcMOIwbCJGp2oeggQ2oCzsbE
	LNJ8xy3kLq67B4M8m1Pgp3PA2rmU8J26ODAzTdDUqGidRcek0D33iqeBUkgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712237134; x=1712323534; bh=pR0cpUk4i3j7zMXGcKYbTtm8CGub
	ZV5HR6ddgNdJoO0=; b=wxbJ4lWXB8GFV5eaNUoPpOH6gMdkv0leWyx1SHH8mFi6
	xoRICa6YPMaMM0qQwPeETA5pO3wgJapynjCC6xPUWMRrM/N67SbKarRFzKHxNFHZ
	SSE/JLWm4IyhN9xrgjiyuMu/9XHYIjE7Ba/ivUwOqgIQHk5NLN4B1svOVLs7yIPO
	gI4v0LKY6jk5yPZXTyt0sB6RR+30xuM5fBAkLB8mNscCPSjLQOo94Rh7yH75e9Fs
	tPvHGQMDB7DgS/C2c2zuqCifBvbbRu7ZtSX1s0HpoWrTvZTujb9Jkt+0nlip3PyJ
	nQx+sC/ftkPZwI6ZWgNI/4EtHwTw9ih0aOz4ZnvAyw==
X-ME-Sender: <xms:TqoOZtK2QVfMp3hdOBcrpwL3_dMenuyB7dlNHYElMlYZo964bb9nHQ>
    <xme:TqoOZpKfyR5goAVqg81el2yukrHTSy5kSK4tnropvFti0mTnVCoFVAIhnGFTCnFK8
    pfWfbwZnUcsAYf8ZA>
X-ME-Received: <xmr:TqoOZlt1Lu_79KlonnQMh2EusL0UprhwVL4iZuFtE3xGOKDKpb7YxSVHMeaOwrU7CVFKdmVS2I8brP1oALqDsK_IKv0SX3CaYAe9e3KIvf07meC2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepveeuvdeujeehueeutdetkefffedtueetudefieeiieekudevudffffekheejfeeu
    necuffhomhgrihhnpehshhdqrdgtihdpihhnshhtrghllhdquggvphgvnhguvghntghivg
    hsrdhshhdpphgvrhhfohhrtggvrdgtohhmpdhgihhthhhusgdrtghomhenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:TqoOZuYl__L25Dor-TjP2wtjgtqvHxlnEolbNYY5Nycht4jAhXC5Rw>
    <xmx:TqoOZkaL-1JCHjhSX5BB0OkTp7eXISNeCxqEuTr2rtiI5S2P7UL-Vg>
    <xmx:TqoOZiDNqe39ehESzEO_K_6Kl2wqUCLHMUMV2Sgcd3MKzklPIXubkA>
    <xmx:TqoOZiaotAuUNlVVeLbmcPa9FgnBE5ryGc_MXm3-Gljl0ESTILfoJg>
    <xmx:TqoOZpN0su3e4OtSS4wduPckycvTmm4EPR_Z2sWoHaB57BzKKmxMq0B4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 09:25:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 10098f88 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 13:25:30 +0000 (UTC)
Date: Thu, 4 Apr 2024 15:25:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
Subject: [PATCH 07/12] ci: merge scripts which install dependencies
Message-ID: <668553e18f59dea04b734f931e5b48d5d35c247d.1712235356.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jGFxZ7kzjEjnpGki"
Content-Disposition: inline
In-Reply-To: <cover.1712235356.git.ps@pks.im>


--jGFxZ7kzjEjnpGki
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have two different scripts which install dependencies, one for
dockerized jobs and one for non-dockerized ones. Naturally, these
scripts have quite some duplication. Furthermore, either of these
scripts is missing some test dependencies that the respective other
script has, thus reducing test coverage.

Merge those two scripts such that there is a single source of truth for
test dependencies, only.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml        |  2 +-
 .gitlab-ci.yml                    |  4 +--
 ci/install-dependencies.sh        | 32 ++++++++++++++++++---
 ci/install-docker-dependencies.sh | 46 -------------------------------
 4 files changed, 31 insertions(+), 53 deletions(-)
 delete mode 100755 ci/install-docker-dependencies.sh

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 71cd4e5486..5838986895 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -359,7 +359,7 @@ jobs:
       if: matrix.vector.jobname !=3D 'linux32'
     - uses: actions/checkout@v1 # cannot be upgraded because Node.js Actio=
ns aren't supported in this container
       if: matrix.vector.jobname =3D=3D 'linux32'
-    - run: ci/install-docker-dependencies.sh
+    - run: ci/install-dependencies.sh
     - run: ci/run-build-and-tests.sh
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c0fa2fe90b..8ce0e1b4bd 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -10,7 +10,7 @@ workflow:
 test:linux:
   image: $image
   before_script:
-    - ./ci/install-docker-dependencies.sh
+    - ./ci/install-dependencies.sh
   script:
     - useradd builder --create-home
     - chown -R builder "${CI_PROJECT_DIR}"
@@ -98,7 +98,7 @@ static-analysis:
   variables:
     jobname: StaticAnalysis
   before_script:
-    - ./ci/install-docker-dependencies.sh
+    - ./ci/install-dependencies.sh
   script:
     - ./ci/run-static-analysis.sh
     - ./ci/check-directional-formatting.bash
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 46b9efb2d5..f4eb125fd2 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -5,6 +5,8 @@
=20
 . ${0%/*}/lib.sh
=20
+begin_group "Install dependencies"
+
 P4WHENCE=3Dhttps://cdist2.perforce.com/perforce/r21.2
 LFSWHENCE=3Dhttps://github.com/github/git-lfs/releases/download/v$LINUX_GI=
T_LFS_VERSION
=20
@@ -20,14 +22,27 @@ then
 fi
=20
 case "$distro" in
+alpine-*)
+	apk add --update shadow sudo build-base curl-dev openssl-dev expat-dev ge=
ttext \
+		pcre2-dev python3 musl-libintl perl-utils ncurses \
+		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-=
dbd_sqlite3 \
+		bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
+	;;
+fedora-*)
+	dnf -yq update >/dev/null &&
+	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-de=
vel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
+	;;
 ubuntu-*)
+	# Required so that apt doesn't wait for user input on certain packages.
+	export DEBIAN_FRONTEND=3Dnoninteractive
+
 	sudo apt-get -q update
 	sudo apt-get -q -y install \
-		language-pack-is libsvn-perl apache2 \
-		make libssl-dev libcurl4-openssl-dev libexpat-dev \
+		language-pack-is libsvn-perl apache2 cvs cvsps git gnupg subversion \
+		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo \
 		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl=
 \
-		libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl \
-		$CC_PACKAGE $PYTHON_PACKAGE
+		libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sq=
lite3-perl libcgi-pm-perl \
+		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
=20
 	mkdir --parents "$CUSTOM_PATH"
 	wget --quiet --directory-prefix=3D"$CUSTOM_PATH" \
@@ -38,6 +53,13 @@ ubuntu-*)
 	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" -C "$CUSTOM_=
PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
 	rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
 	;;
+ubuntu32-*)
+	sudo linux32 --32bit i386 sh -c '
+		apt update >/dev/null &&
+		apt install -y build-essential libcurl4-openssl-dev \
+			libssl-dev libexpat-dev gettext python >/dev/null
+	'
+	;;
 macos-*)
 	export HOMEBREW_NO_AUTO_UPDATE=3D1 HOMEBREW_NO_INSTALL_CLEANUP=3D1
 	# Uncomment this if you want to run perf tests:
@@ -97,3 +119,5 @@ then
 else
 	echo >&2 "WARNING: git-lfs wasn't installed, see above for clues why"
 fi
+
+end_group "Install dependencies"
diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependen=
cies.sh
deleted file mode 100755
index eb2c9e1eca..0000000000
--- a/ci/install-docker-dependencies.sh
+++ /dev/null
@@ -1,46 +0,0 @@
-#!/bin/sh
-#
-# Install dependencies required to build and test Git inside container
-#
-
-. ${0%/*}/lib.sh
-
-begin_group "Install dependencies"
-
-case "$jobname" in
-linux32)
-	linux32 --32bit i386 sh -c '
-		apt update >/dev/null &&
-		apt install -y build-essential libcurl4-openssl-dev \
-			libssl-dev libexpat-dev gettext python >/dev/null
-	'
-	;;
-linux-musl)
-	apk add --update shadow sudo build-base curl-dev openssl-dev expat-dev ge=
ttext \
-		pcre2-dev python3 musl-libintl perl-utils ncurses \
-		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-=
dbd_sqlite3 \
-		bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
-	;;
-linux-*|StaticAnalysis)
-	# Required so that apt doesn't wait for user input on certain packages.
-	export DEBIAN_FRONTEND=3Dnoninteractive
-
-	apt update -q &&
-	apt install -q -y sudo git make language-pack-is libsvn-perl apache2 libs=
sl-dev \
-		libcurl4-openssl-dev libexpat-dev tcl tk gettext zlib1g-dev \
-		perl-modules liberror-perl libauthen-sasl-perl libemail-valid-perl \
-		libdbd-sqlite3-perl libio-socket-ssl-perl libnet-smtp-ssl-perl ${CC_PACK=
AGE:-${CC:-gcc}} \
-		apache2 cvs cvsps gnupg libcgi-pm-perl subversion
-
-	if test "$jobname" =3D StaticAnalysis
-	then
-		apt install -q -y coccinelle
-	fi
-	;;
-pedantic)
-	dnf -yq update >/dev/null &&
-	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-de=
vel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
-	;;
-esac
-
-end_group "Install dependencies"
--=20
2.44.GIT


--jGFxZ7kzjEjnpGki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOqkoACgkQVbJhu7ck
PpTYGg/9HaITKDRdk3+d77XblXF/zmdvEoe4/7ADgXO+72AnRcimp30fx6dJxcY8
s7wpje8QILt9q0y5kD89rS4eC17w9FjAy9vVTE/u5ejfzabGS9xQ0KY5aAsOQUBn
Qmr11IxYj7gkeWiGVXPT9mZvGnbQbP062Hgsb/djvlgxUIBF1nuaCi0/vE09xN9+
XNWXtecCwaanm3u2WqN1RTKqKJV3eHPsGvvfkDSzX8pFpeQ4Kr+QglAzS04cP4Qk
BGuEztBRki6YVFCnFjt5TSSGM+WQ0yKuHqD4Gb9b8EW+4E8FcK8MzFWDEMQkaZt+
2YVbLyZOMMkZUbOE+hrP5DHdS9RnrZ8jnPc4R25IDfW3vnZI3zzU8SbbfG9Ytzk6
/wTP9NNpDBQ8dZ+Hxt7XuEGNFTgbWBx4E+PxvqdIyYNSTkosjFwFalRNwQ8YZGjj
Caju4Eo+sh9cPUzvCKN5ZxocgI1Ml1hnEhgmGUZlD3soDAtvRHZK92WevWYeNpC5
lWJOJ2VQLC8WaH8MIgTbmUZdcbcHUcFAIB2PZ9SwGDQZPuIsHSxxlsIRfTKZbqdE
cDxxMW8HlV2MA0yFN61Wp7Wm9txOjsjPm4lwWSF3ErURG6AG5Ku1K+A8F8KoRJ11
V+t0vRw6/rirk5P5l0Q2+6cgWNmEANTNqavtlGkPVrnGUg3dysg=
=y8yS
-----END PGP SIGNATURE-----

--jGFxZ7kzjEjnpGki--
