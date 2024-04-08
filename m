Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE102BAE1
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 06:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558807; cv=none; b=PwM192COrix09eCuOhd5NWMRE4K2MLw3+O087ifvbhJ1lfRKi1f5HDMsGIKBehKhEBVxU00W+ksaZbYTU1O/oXr8/QPwbT4Tf0O2GmHTk8BbtM1jaetu/UTPmZPQxUdlu8jIHuJEB3BpKAB29uBDYXZsRNBzSKkatUBdXS0GSuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558807; c=relaxed/simple;
	bh=ys/Dzq9cdwdsRy64f+2Ocu161rwyowM/yTnYp8DYTyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIK/t4R/afPBFM/43iLi7oklwTVVXcNgJ8gxDD89A+N4v+iNxPbCkIn27PgunPx8RfM2JQyG15kezxq/7d3sHe8VnfNZR/gkV1CamcvmrQ2efL4+MckaxgsW24RzVxO8f4zRwdIKlvsE86rk11+fsD/KddG9SGM+YCeXw6iwLCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Cl8UAhiv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EzEi/i5J; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cl8UAhiv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EzEi/i5J"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 13D9611400CD;
	Mon,  8 Apr 2024 02:46:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 08 Apr 2024 02:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712558805; x=1712645205; bh=3dfRJXK48z
	79mbOfImFYAPZmX00osM8gmkmHoWdEINg=; b=Cl8UAhivttwPyOuO160QUToL3P
	M3QWJxZ2yFibmAW7mlrHf1fxX/+Hl8zi30hfL24JlGioRT/1wA8czWkOC2lMT8lF
	s24IcceRYi9VgdTRJGkeFwA3n7vMD/1gpO3ZMacy2AlZGFxwknwn26gcc15cNSof
	+m5hCs9VO0D4GNJEojsO/VmX7sTYnERsuDQtEP97/Jc63CKF8H/hwiS2ebEvgBn5
	qr7RgaX5JIqN73HxLYFR6X024xQERGAGk6CII4O5iWZOwrXZbRnPr4JVlqRfk0aE
	4NDRxVPVFzsm+NzJjFlcy3IDzvkAFdIjvI+D9UuEdNbrFskkgVozl+8i+DUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712558805; x=1712645205; bh=3dfRJXK48z79mbOfImFYAPZmX00o
	sM8gmkmHoWdEINg=; b=EzEi/i5JbQ8Xj7Jo2kqFlcBEsM/3mZmhE04TCe311eZt
	vg5GohGwg21EMirv3lVrPsHA/nuL15whpXTG4P2xKvDhq4zd+7o8ZixAaXNhp+ah
	jCgaz0esCbOx2oKHbUIuQi7XpPEG+BdP2J512ccN7rTbFrHy+9pYYQHkC0Ai9DTm
	fIlKQIRLCbvyPQqZ6yNm2mI9/Tv/7mDXbaRcFcUGU74XmJo7HR6+V+xFspzex1lw
	1h2tapNG4D1XHKraA4bG8gyUJm8jw7wVgeISYexwaSkR/DXL3Y9Y3NaHgwtk9SeQ
	tDay4vYhTClgtSzaSvzorm08bclGlef8yR8qVFrGBQ==
X-ME-Sender: <xms:1JITZtQEDg177rL-7NMxzy-lxqk1Z2eHhhgQ6F0ZfTohnBKLALpbcA>
    <xme:1JITZmyitLpYGtEHoiItXsLV6e2VT0IIOFsA1ZZccXVjDqm3gWwkJVZ9XaD30o-ya
    S-IykXqW1t42CoE-Q>
X-ME-Received: <xmr:1JITZi2IxiOoarr5rjrLliAhyhPUIB_Kn4VDH_G5uzQ7IJ2EKGfpDGBJEj31kGldW67dsQ5GYKNKu86pe2gWHYY6zkeL-1hhWiUFlL1PgiA7pZ4j9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeevuedvueejheeuuedtteekffeftdeutedufeeiieeikeduveduffffkeehjeef
    ueenucffohhmrghinhepshhhqddrtghipdhinhhsthgrlhhlqdguvghpvghnuggvnhgtih
    gvshdrshhhpdhpvghrfhhorhgtvgdrtghomhdpghhithhhuhgsrdgtohhmnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:1JITZlDVP259TZV1pjI_cpLadl-8KF8RAZozjBnIoFgYsAIGk9bmyw>
    <xmx:1JITZmh314xTda1jTK91Q07HmkQEvd6zBu1FQt0qNKvGM0mZ2616rw>
    <xmx:1JITZprjy1FlaM24cZcXdpawN9swH3b2Gh2fOhM5SEXAIQSihAb5Qg>
    <xmx:1JITZhjW4dKJ5AqvdmPJdPWKBU1gPkBEOL44OcvJComgFyP2OPoSkA>
    <xmx:1ZITZoZFoBrXsfKdXhm8WHCsl-5zJDypj14r0E6-ERzERlY7ZXD8caBX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 02:46:43 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id df05c5c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 06:46:38 +0000 (UTC)
Date: Mon, 8 Apr 2024 08:46:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 07/12] ci: merge scripts which install dependencies
Message-ID: <4a90c003d1cdbf1e38efe5f7b78badf96a61b8d7.1712555682.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FO6A8oW7iFV4wtW+"
Content-Disposition: inline
In-Reply-To: <cover.1712555682.git.ps@pks.im>


--FO6A8oW7iFV4wtW+
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


--FO6A8oW7iFV4wtW+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYTktAACgkQVbJhu7ck
PpRrxA/+LUfgYf76/NDILdfKORuaoxf/7WQYZ0fNAJGIKOmPeJJE7bF1bdgIjfsl
gdFp9pnaTCrsfpL0sGV6LFE/0/cWMoXQ4DYX2Bv6xLW8h16KmiS/uNZZGy+gBGBn
raDH2z+IlYejlFkuxQvzdmE86HyQ7G3R+2i74m9fdgRYiLHgyPVDrXVjdbc+tVNb
Jsfql1d+6QQ4E/DHlFcRXoaUyJWvwooEUqxHPK/CWBtgjBCUvcoqol5Dk7a3K3kv
soCAqlop7ku+ww7+o8dM2SUeRoVN0R4DabdnjkrvB2hIdDX8v98702KmqfyOo93V
+oiqmRpUOTU2dWVphhguU+sRltBGKVXK0iSBHD5yjisE3aW1vpooWKhW8cVXQek1
MlgBrFR19sS/7Tgsy6EMX8NLNbLwLvUB7Cw93nTCgud28ptmFHU0FT9Wspoahg5f
JNjqYWIhLRUPXeGYj8vKU4rs/YbObw0/26lBCY9pt2MklvNrUFpxRN7wRoZi3wXY
EwZVoGr/M7Edx0lKAuJi1L2HtQhNbBN0YJ4tnmZXCwJCfnmZTDdSaIJK1Zni6RjZ
1bbn5RH71zxR2E4x6DGW1eluug6EEMFIIz8ebALTC+i6uYJyD/xa8a4cZoHHn7lp
dhIDNRQdQ8xkmoj4Bsf30BRIQjaRELzW5q/FMfm16R/E1yfgAnM=
=Fwd7
-----END PGP SIGNATURE-----

--FO6A8oW7iFV4wtW+--
