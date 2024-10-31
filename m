Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911F71E2007
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730418943; cv=none; b=kEeA00xq4Quz1TSmSgPPH4QGoBDTJjXtuIIQAUqK9CNoRvvEw1syUj3CZy3noFKAbWh1Fav7Md2FWIOS+Ekm/rfQwAxTHVvLSIGHxHljoHMyJdgsNb0aNGlv3JlDMJkpXB+3W0/OEjXtYErWE49F2wG2NfJojodX8k+t/jEHtQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730418943; c=relaxed/simple;
	bh=PeGvng7K5VvLiqDYNMvtxJwPUuGzIl2i6ZzdySlWiYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skFY3r9DGa8pHFkWzGbVhWNc/5xCZwvfBzohTs1wYrI/RSXFbp06EaDorbMWe6mr1urlKY732y3mSnmWS+lloAews6Pg5apqbeews8xRMg+iXn0g/Cw/Hea/6q8TT1OnmsiRFPoV8weIaRtFbC5J/Oa9nGI9YmvrnE5qBdmzOSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ww5+mQiK; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ww5+mQiK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1730418580;
	bh=PeGvng7K5VvLiqDYNMvtxJwPUuGzIl2i6ZzdySlWiYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=ww5+mQiKihSEwUl98irr63Yw89trq6yvYlANEHL7kKoF58gv6leo8akIqQQdQD6o4
	 KO8ntt7pf3br4n1U16TSOm0ZRJzYSgUwjrsB+79gusZeHpgabR/Yjq+N+NMgj2gCzv
	 yRYBmvTiMf4cOeNBnueIGaF1MdeLw3OYIOFTKK9D3QyHLipJsxWxjSOaLOHEmCmGKb
	 EJZ+cObVPgq/oDSFnc3iTNhRlrctqwtFPpqdTdCYCFgmvFJXQ67wZjtfAv0czSCzKX
	 dBXqal7VJFSidtNGtaO4Z2E6cbJE5qKNR6QpVIRiUS2OySO8KsC0FE2liSuStkr18M
	 mWXPSNzO0DvDWxUvoWxWNxF6pVihuWWcfnz4qqNKztxLRDeoRWdom1QkoQwgtGU/yR
	 JG52xrxpxgRRybZQbSlB/BFGsbN+6iORCdKygebnuIVey0oNiMU+Ws75l/8fgQDqxG
	 mQquIMvM/atq9Xa9fdvkvDt1HTWoY0oIsj5AgHZ7hbTBjPs9Ln1
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1A981200C5;
	Thu, 31 Oct 2024 23:49:40 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/3] Add additional CI jobs to avoid accidental breakage
Date: Thu, 31 Oct 2024 23:49:34 +0000
Message-ID: <20241031234934.3451390-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20241031234934.3451390-1-sandals@crustytoothpaste.net>
References: <20241031234934.3451390-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In general, we'd like to make sure Git works on the LTS versions of
major Linux distributions.  To do that, let's add CI jobs for the oldest
regular (non-extended) LTS versions of the major distributions: Ubuntu
20.04, Debian 11, and RHEL 8.  Because RHEL isn't available to the
public at no charge, use AlmaLinux, which is binary compatible with it.

Note that Debian does not offer the language-pack packages, but suitable
locale support can be installed with the locales-all package.
Otherwise, use the set of installation instructions which exist and are
most similar to the existing supported distros.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 .github/workflows/main.yml |  9 +++++++++
 ci/install-dependencies.sh | 14 ++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 9301a1edd6..808ddc19b8 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -342,12 +342,21 @@ jobs:
         - jobname: linux-musl
           image: alpine
           distro: alpine-latest
+        # Supported until 2025-04-02.
         - jobname: linux32
           image: i386/ubuntu:focal
           distro: ubuntu32-20.04
         - jobname: pedantic
           image: fedora
           distro: fedora-latest
+        # A RHEL 8 compatible distro.  Supported until 2029-05-31.
+        - jobname: almalinux-8
+          image: almalinux:8
+          distro: almalinux-8
+        # Supported until 2026-08-31.
+        - jobname: debian-11
+          image: debian:11
+          distro: debian-11
     env:
       jobname: ${{matrix.vector.jobname}}
       distro: ${{matrix.vector.distro}}
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index d30ae53a18..d020cb7aa5 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -29,26 +29,32 @@ alpine-*)
 		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-dbd_sqlite3 \
 		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty >/dev/null
 	;;
-fedora-*)
+fedora-*|almalinux-*)
 	dnf -yq update >/dev/null &&
 	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
 	;;
-ubuntu-*|ubuntu32-*)
+ubuntu-*|ubuntu32-*|debian-*)
 	# Required so that apt doesn't wait for user input on certain packages.
 	export DEBIAN_FRONTEND=noninteractive
 
 	case "$distro" in
 	ubuntu-*)
 		SVN='libsvn-perl subversion'
+		LANGUAGES='language-pack-is'
+		;;
+	ubuntu32-*)
+		SVN=
+		LANGUAGES='language-pack-is'
 		;;
 	*)
-		SVN=
+		SVN='libsvn-perl subversion'
+		LANGUAGES='locales-all'
 		;;
 	esac
 
 	sudo apt-get -q update
 	sudo apt-get -q -y install \
-		language-pack-is apache2 cvs cvsps git gnupg $SVN \
+		$LANGUAGES apache2 cvs cvsps git gnupg $SVN \
 		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
 		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
 		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
