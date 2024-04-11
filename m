Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0207713C3CA
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826642; cv=none; b=Ct1rTt8hGEYVbyduNhjrJmCgeA0qX3rrEtiC9+L3Bxlqanz4BSpfVFAixIWpX9xCqtccGY+5us3bfZZPDi11U39otVNSCdNIiEi+Q8YfQrhuc/q8sBDkZkVqhWUhveZnIo/daHjsk989s21niX5yTOrCSWi1BSr3i28br4RMlKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826642; c=relaxed/simple;
	bh=gWkHATY15jAUbxA5GiraQ0katyXl3CmLz8sS+ojbshg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWfyZEjoXqWfHnq06u8sNMLRUOmx+iPyUZFmPAOQPecwF67HjUeNg9G04P6fD0kScxdUPOcIfCGDD6RxgkPzfD/NG1o+Lnw+Va091RJ4/urXv0yGpSJPBxwX59ZDQSw7NOLkn+AE1wx6LhWyXh7JR2SsDYYa9w5VAObF4bVmLkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bfJZ7lJp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e+JSryma; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bfJZ7lJp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e+JSryma"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 184E61380130;
	Thu, 11 Apr 2024 05:10:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 11 Apr 2024 05:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712826640; x=1712913040; bh=ymqQBVdg1E
	OLIjEYQ3NUwTkZ8QiWPAiZQd1ldmcSQKE=; b=bfJZ7lJpn6nELpo4KhHrtESLLP
	BMx6dgdrEaRW0akSOtPLYA7aXemLg6EVvcBz4kXExuJ3dlkoujTMB5E75YaJRE4J
	CxE/qyMYGgh6n3CxK3Atlyfukdd8tzsPcnU4MyaFBaqBMmipYMH4l8l9AYwF0TKL
	P9SH0FZIbU6wG1KwtQxLKNRIYn68WccdZkZPl0CRfy8B29Zz7Vv4HGGSzm3ePH8k
	q9uXsjOqV9ZszoReOeGYk+eEJod5UHSNWTRdXlW6UxcgI0OciulNgDfAOvUDj78N
	Di/BdI0rJvMclyaqtaWpMiBQd3fN7hnKeohxtPwE7+qb0eSN+BjMCop51qog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712826640; x=1712913040; bh=ymqQBVdg1EOLIjEYQ3NUwTkZ8QiW
	PAiZQd1ldmcSQKE=; b=e+JSrymaB1xsExXydd4RiqhxBdDDeQb7EfuPHBbkRWzz
	aE3F9A5sCTS+jS7U/Xs7RGEjrLhjyAWw6aitXOnLNSveIcV7uH1CEJMi0Q4pzWJX
	5XYEWzuMIpO6hPxlSRP1Syjbgae1VjhKkEJDbkNBmp6e1eEr6HM3rhusxKRnzB84
	jPLLY5ejpSS2qYSBfn2RWOHR8Qsez8JU4BaSO2dCFJPzXLjBIrtTQ2FF9plHLL9y
	LS62tiFXxxZ7UZySH6QTjEC+EesB2UFaJ3cqOuepIwc/nBqK5GBWU7O2aq47yQh+
	uVgr5bGmvp26dow2FKDz9/aA+39sASAoL9foU/UUSg==
X-ME-Sender: <xms:D6kXZlKXJ57kXSVBX_OE4HpISj6C77s8Ktieb6owaMoaozkT1tJBvw>
    <xme:D6kXZhI2XcyStN0g66-x231nLh4XSA3KCQXV7g9ddbpV9qb1xk1G4OXRVB5Po_7Ak
    5V-90ffbH3LN55djg>
X-ME-Received: <xmr:D6kXZtuJPC4SIcDmg7y0gDroMRsaOno80kMz4lioqancMN94ufBPlCbcFf4dQpfYWCiMnDWTb2d0Ih9rSe8BJTmSOt3Yek1kxIF9-HYLgzNBxNhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepveeuvdeujeehueeutdetkefffedtueetudefieeiieekudevudffffekheejfeeu
    necuffhomhgrihhnpehshhdqrdgtihdpihhnshhtrghllhdquggvphgvnhguvghntghivg
    hsrdhshhdpphgvrhhfohhrtggvrdgtohhmpdhgihhthhhusgdrtghomhenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:D6kXZmbgaFgHxDI7HuJyCY7hdkXUAjpIp6uhK9GTZsUQuoo8a7oUdg>
    <xmx:D6kXZsbzjmyyzjkKA0ROs2LnuA1C7TdCY1pEXI21IijFKZnLw9YhpQ>
    <xmx:D6kXZqBLUJdCrTxSaAQCAy3qTqJPCKDJ4unTheH53cF5EuGr07JWuA>
    <xmx:D6kXZqaEP3sl-FUUbNcctT52LSN4LvTW1QG-9XJhU9t4yPB_I6prAg>
    <xmx:EKkXZs5oqNBW95TsflwUlBwGAvxXy3NV9JX6APz8D1klrJAYNKgYHrPC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 05:10:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9caa5cef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Apr 2024 09:10:26 +0000 (UTC)
Date: Thu, 11 Apr 2024 11:10:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 08/13] ci: merge scripts which install dependencies
Message-ID: <7748f87f8cd23826adbbfbaa7616d8b5be346c42.1712825204.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712825204.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m4od9SFW788q8uNy"
Content-Disposition: inline
In-Reply-To: <cover.1712825204.git.ps@pks.im>


--m4od9SFW788q8uNy
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


--m4od9SFW788q8uNy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYXqQsACgkQVbJhu7ck
PpTBsQ/+JhLqYrkXmxfAeWRvCWOU2bajy0Xn+EqLEbBkaBPcDQFgkNLCum8TXSPT
P0FjLNTsC9tFmhRCet17yUnrvB6dvZbswaUAf058kYbHpn6eeLgJOHA7MmW5CirZ
Dyq7wVbe2cgJpI3N8hYhp0nGRQ6eLxBQ79pRdb9104tGBJui0fV2GnxjNqMB+4+9
DZDVdglHMeEtvkNiYvKlVYypjBVPRhBj4OZW0qmVYUTxLgl0mr34ko8c9LKUjJVn
5Nh6zbYJE7KSvmI1pVmffeWmLxwXYHZLaBxWZUc7mmwADFq0ultWNnjwNbom7YQd
178YtT12c4inktBp2Dxmz0rGOsY66WmvuQQmXCOwBUB2d2T805b5WkjIvfnVOvxt
STDByi17lZZj/TyhnZga5SSLHCchJY4eKRxbTdJeRJj5Y++csyaLySUpTSSi/ghw
UQg8pBzc/S9pOFQoQqIPHeH1PVwO5RPdGgcjxO+mtJL5yro2Q0VeRTd7NDlqXZqC
sZ+dwmgV+RXuUfpQsXXtARoSdNQuGxlLbSiWv4730zgZd5Zj28sxxwdFdVgQYd15
nF9n9wtKthC0QIvbmMq58CLlJD2FHtGs05N69sJX3pJYTFOhNGIIhGKqxZ+DDg4B
kMRYu7+crOaUX91qHvstYBF+BYSgdwZkzf0+6uq//xBVtseH/cU=
=HYbI
-----END PGP SIGNATURE-----

--m4od9SFW788q8uNy--
