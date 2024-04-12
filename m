Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6421E491
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 04:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897078; cv=none; b=SjIyc3oeD8LJWd7U2URYXLiWUoetriU7c5DptHF3cnTznLPRcalqEF2LEXE/gB6FgSCOuDH9p2KidMAl0mD0iQ92nS7Yk6UBvX+P5SHB3YUnOsCsRDXy2yjBHW1l4KIsFPRVhO6klpMPHwA5iGKmPGYBdRsKasPyJX3Ls80lrq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897078; c=relaxed/simple;
	bh=ZQwfrGygsWfUhffsHxN9TbJ5epiuIsVNcxs2cw0ZAcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8RAz1bDMVFk7iI2jaE+h67k93fcD1WXl68B8Pu/7m5fU0Q7iWqjW2rYjwYNejbxa67phYRd2jFD5J5wFuKjHGKiLLQR6Yy+bT9jUFwwTab+QDiDiS5z4hoerXFk3mnyTsmrzj9Kcw1r4QbBPkJSS+szS6lHM6AJt9msJOOrZl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kXbwdEpB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cetoBLoZ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kXbwdEpB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cetoBLoZ"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4B5AB11401D7;
	Fri, 12 Apr 2024 00:44:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 12 Apr 2024 00:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712897076; x=1712983476; bh=z0UVGeyYsF
	0BalnhQyzcU3MztgbMquzGlCI10w4i/0A=; b=kXbwdEpB1zU67twTtqsprhlT64
	6CLvYxIhij9h73FBKj+B9EgaxqaKRQWRbGKZkDBMBtrp5FPwAAKcrDLU1hKMq+FQ
	62B3RLS2fOAWcvQdxiMvl8pAZ3xz18FQuhAJfcBRyTplHcIKqXwws3gljATZecfl
	US3HY4CBSWTtJDBsY5E5hXXAncCw2pALz39Ag/rBl3Dm/Z7dhk3s33iPHph5EFEh
	wtm5rCI67U9fbploHyWUjDDiN8m7NOp6bAInvBGmj8dInsyp2ydAAnwaQi4a4Hjt
	ovyuJL0Y0sh+nyTPS8ECW7pWzqbL52LE07ypUnsnY9UbkHeZ98S+uvqD95fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712897076; x=1712983476; bh=z0UVGeyYsF0BalnhQyzcU3MztgbM
	quzGlCI10w4i/0A=; b=cetoBLoZOK/lFBKzhMRM6uQUcxA5Qqy0nAZDfy83Kf9W
	u/UKtqF+aDQLVEDXwWOr1Oss4Ayrj4fTPo36V+xnzdts8lCDdtjkyHiVRMV8UkmB
	4VXrvQj7jtMJwrLy3CMMJMnr9x2S7T3f7RrKFKd6MIXS/hxaxBY9/x24ch2jxfDY
	L3otNL198SIEPqECA0F8jL3jNgOf4AhhJLz81r5RplkzSKVsBtlsYQzCnLpzhd06
	COa8WTwfr1pwmOYAXvIbdX7OxesUwNlT2CFzJDI8vd9kSPkhV+uY9Yv+f8xMkBWH
	NCP2W1cKtEEVhf+vMqSDey37AJVuOmUYXxPZr8C3/g==
X-ME-Sender: <xms:NLwYZlxNEvHJVWsMQc5sEN5sdPRH_bXeNJnyp6bnDvB33Ffcq4v7bA>
    <xme:NLwYZlS0EXeBUQkUTgGLwJLXkxHgZT3or9IDxr287uT_iaokbR-LmkgSHGkO_Uvvv
    7BC_jQjF8_1xR30EA>
X-ME-Received: <xmr:NLwYZvWXXafiYTfu_8grSwg8qIW0UUCckMwoaS43kkbmldPDoIpGRiWsWOdNHVgHKt6ol4JHSJMf-kafXlQqsyn7YKBenlM5ZnRZvl2c6hcpqKTmy-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeitddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepveeuvdeujeehueeutdetkefffedtueetudefieeiieekudevudffffekheejfeeu
    necuffhomhgrihhnpehshhdqrdgtihdpihhnshhtrghllhdquggvphgvnhguvghntghivg
    hsrdhshhdpphgvrhhfohhrtggvrdgtohhmpdhgihhthhhusgdrtghomhenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:NLwYZng9Hyr3CJ3rhS8P02xddYsEvi09ddqCyqfSV5Fr9CgqL5hLbg>
    <xmx:NLwYZnDAavdHdGPaMkETH5HXIwGxwI8f2mTYo6KycOu9QXRV0rKoHw>
    <xmx:NLwYZgIsf0kPqdcPATCATwmzJwE0e3lcENrCQQeSMmpWi2J3r7jVmg>
    <xmx:NLwYZmAaJU06Z3vcaDW57807ALS7VjtnQx9Nff1FR3khDpy0vVypWw>
    <xmx:NLwYZpD7YIf5ItnvJ_3uB5UNoYxVGUvk6jcQo3uhvNW-gXyZ-6ui-rEz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Apr 2024 00:44:34 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id dfb5dd78 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Apr 2024 04:44:21 +0000 (UTC)
Date: Fri, 12 Apr 2024 06:44:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 08/13] ci: merge scripts which install dependencies
Message-ID: <e7a17d57e7013a5aab27045c26d48260256ba9a0.1712896869.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712896868.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fnJCA6jv4eelpZqZ"
Content-Disposition: inline
In-Reply-To: <cover.1712896868.git.ps@pks.im>


--fnJCA6jv4eelpZqZ
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
index 3a0ef4d4d4..ba65f50aac 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -12,7 +12,7 @@ test:linux:
   variables:
     CUSTOM_PATH: "/custom"
   before_script:
-    - ./ci/install-docker-dependencies.sh
+    - ./ci/install-dependencies.sh
   script:
     - useradd builder --create-home
     - chown -R builder "${CI_PROJECT_DIR}"
@@ -100,7 +100,7 @@ static-analysis:
   variables:
     jobname: StaticAnalysis
   before_script:
-    - ./ci/install-docker-dependencies.sh
+    - ./ci/install-dependencies.sh
   script:
     - ./ci/run-static-analysis.sh
     - ./ci/check-directional-formatting.bash
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index bafe37f2d1..e673797115 100755
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
@@ -39,6 +54,13 @@ ubuntu-*)
 		-C "$CUSTOM_PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VERSION=
/git-lfs"
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
@@ -98,3 +120,5 @@ then
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


--fnJCA6jv4eelpZqZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYYvC8ACgkQVbJhu7ck
PpSHBw/+KJntbqT84+B67Wy4SRE2nULZgvTN+k/xi2hmVjqN1YPiucXdpX9sl0y2
fxeImEbT7L4tQ8ctkV+ZoWLehWWA6NawkgqSpJy9bo7i2r0GANAqIziOPrIJH+ua
8W0oKN7LsbIDNCEnUpSPUzLS8F9T3jRqHdxG8jzfMtv4GnHYzDgPOFcJpUTGUkn3
Yc7ovnT25bHOiRz8WTyl25EVu22tnOtZH/8YMz/9xS6kMhZRsQtSGTI7xGatA9Ew
h9iG3qg6NsVpGnTKRcf0aIxpu9gqdTqMauJC/sZ2vb8xJtiZC9WyeeJTzs/KW2Xw
y8tFlrn6QhGwDTFzOxsFryzmY/++ENWkY9bnpy6clmTHPX8f5YuaxNdloCDs2TIS
1u0pkOhn+E9K+cilOjqCrECfzqqZ00NC70sJQhEIYqpWURZjIwnk5vX0YWSbxijJ
JryEMG+0Ntr4mINBUzgm08bSBnNZpReskCi3DqJqX920yVPk1UZnD70xZF7KimFT
p5QKi5XOFRNeWMGKCiYAJL0B7l2FtKNDKaDhMCUgp40+OnHe9ZXDfwxUxyfa2bNy
9h+R8qHIj31tQ6R7DB/iX5erAlELMgd2bd0L+DiqfnfXbDI60HlBdWcj9XYj8sI0
9hF74M2hsfW3nR5hY5OQP44vlqdrK/9SnMCaqacktpyr0dcNbg0=
=OBjv
-----END PGP SIGNATURE-----

--fnJCA6jv4eelpZqZ--
