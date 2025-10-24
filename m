Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52A730CDA1
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299521; cv=none; b=de5AQleSR3fazXC6BVMJOTPNMTvRVOQj+qUB+p38TRD7xsNdIGpI5ivlJxEqbFwXh+Hj7qffd8O05l4RIXCygcueTOEk9goniP4Ms5uoQzBAfSy+ueB370UuN2rbpE2BVBJcwWR4Gyz00wOFtKq9urPR+0f/NiL4635al4EuhTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299521; c=relaxed/simple;
	bh=nrKJb+emwIrXY3PQXv8QqGCqkBRKDqkI+6U1BTC7mMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mg1MaiLfGpvKNP9HR/M14+zrnMkjCY8KJCrT1k+TGS52wTLQDJoCzLBbFUmdTlEc/VROwICsZGPWMn2rt2TaJVgHv0CnH65wTPvZycAd3PlEiJ+e1uuy8jn91xwawXE3/ZbfpZPdxYt+RgUHIw6ur9djkTJHmP/p/3HlydmkWkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fIT6FBP9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ywYLq6nq; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fIT6FBP9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ywYLq6nq"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B303214001EE;
	Fri, 24 Oct 2025 05:51:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 24 Oct 2025 05:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761299518;
	 x=1761385918; bh=rlnqWbMSiPtm9Ei2a1p+47FueScK4Mldgkx40cfQHFU=; b=
	fIT6FBP9FbPwjR+ByNkLO9TfvdCzSoVk54TNlvFlxAGn5uJ7eP3jSLNX/RNXWyGd
	9CiKmZaPHnTYkch+HAiTdmrKeR/jxc6+S4a9FdDDmKWuqIsown15Vd/boeXvMHI/
	oTVs2p/cgPzzREt43f0qWFBdNcEyHWjFtVge70V0NFjinFXNsvX89oFEF+c94KY3
	swJMqqoxWrc2voWnRzTHqbTHFTJO5pzoMUYRjcZTp4bJmjyYn9TU94CKYhR6pIOW
	Q7x+QMV8rQOWV+RGM61pOnA4V3DBRUVeouuqH4QgJK1xC736iDOT/ONsl+vtaA1k
	pHOkkw+CYs0FvU1iLgwviQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761299518; x=
	1761385918; bh=rlnqWbMSiPtm9Ei2a1p+47FueScK4Mldgkx40cfQHFU=; b=y
	wYLq6nqWaTQ2uWLM3vMbuBXBp3xT3x6u3l0bfORHiK4m1wNQ8z50a9PBZWnlrDNe
	xL/YH4MgR+oEJNfBY7RZ2o8NG4LeySMHM1p+/VxV2F/Q10lnbDD1h9rIy2xGtjpE
	rjsy1jJLRisPVjpkT6tuVxR+inai4Csjqia1DF7S6Gl9mN7NUZEAsmPWzuSfeLJ1
	uaVLdVjfaCVn8qxQMKws8mcb2vYfgTiZBNRZlLPhJxr3u2GDEiFQz6ssCRe2w9Eq
	LuHHnKBTVW4Au5FbeTP+Oi7CPr/gSxB5igNSQZMX9z4gLogSh8HUTJRUMap2JWLY
	Xql499JwSg3GLu1T5uEhA==
X-ME-Sender: <xms:Pkz7aDsRGdas4dVmLE1Qiia7XIrgNBPQxgRUUxujmKHI5UjHzAPUow>
    <xme:Pkz7aLcYuh1sCYZXmEfjfPrIm20A8LVIYBvtJcJ0Sn3sNt58RPKL7PNn6_48rrJog
    Y7CsF_EEuFkCjnP2IzEx3qMqWgkMrylbVEUDnbOwJ7-6vdyxsgwCg>
X-ME-Received: <xmr:Pkz7aLz9DsOZQDKltImiWfNjaZG3yS0Zv-AWLRkOQ75vWYmpCjMXXSuFSPsb7Z2y-bcK_rX3JK0eU-rVHEMhsulniRkXr5aKtImSBnJS4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeltdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgiivghkih
    gvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegt
    rhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Pkz7aBH_yE9qRZaAT_HGYGDduKuG23TXCJwFoLUgQA9uBHobi9qptA>
    <xmx:Pkz7aPwVqxz0WlZOQ7nap4Q65PRVH1daWZaJQtq1ckjn-Hik-ydIew>
    <xmx:Pkz7aCsSfwXF5-VflZ-E_VR82YRQ6AgaG_pbpdvlgYc-B_fwka-2Ew>
    <xmx:Pkz7aM1x_BLG-XeEhPaQeBV9G9zpwQt8rOADXkS40ixGdVCst-Mlxg>
    <xmx:Pkz7aBh7B359u2C3FswaHNTcKycnp02jvFXRfNvb_uleCKUtoOkXPTd2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 05:51:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6d94f46a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 09:51:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 11:51:35 +0200
Subject: [PATCH v2 3/5] ci: use Debian instead of deprecated i386/ubuntu
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-b4-pks-rust-cbindgen-v2-3-4b4bd4f18490@pks.im>
References: <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im>
In-Reply-To: <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ezekiel Newren <ezekielnewren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Ubuntu has ended support for 32 bit platforms and is not maintaining any
release anymore that has 32 bit support. But we still use i386/ubuntu in
our CI pipeline to test for compatibility with 32 bit systems, even
though that specific image does not receive updates anymore.

Besides being end-of-life, this image also doesn't have all packages
available to it anymore. This creates problems with a subsequent patch,
where we're about to pull in cbindgen for generating Rust to C bindings.

Drop the Ubuntu image and use Debian instead, which continues to
maintain its 32 bit port.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 3 +--
 .gitlab-ci.yml             | 2 +-
 ci/install-dependencies.sh | 6 +++---
 ci/lib.sh                  | 2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index cc54824c388..0b16970cd7e 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -395,9 +395,8 @@ jobs:
           cc: gcc
         - jobname: linux-musl-meson
           image: alpine:latest
-        # Supported until 2025-04-02.
         - jobname: linux32
-          image: i386/ubuntu:focal
+          image: i386/debian:latest
         # A RHEL 8 compatible distro.  Supported until 2029-05-31.
         - jobname: almalinux-8
           image: almalinux:8
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f61ec2b6989..31d5e5a3e0d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -66,7 +66,7 @@ test:linux:
       - jobname: linux-musl-meson
         image: alpine:latest
       - jobname: linux32
-        image: i386/ubuntu:20.04
+        image: i386/debian:latest
       # A RHEL 8 compatible distro.  Supported until 2029-05-31.
       - jobname: almalinux-8
         image: almalinux:8
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 50628ee2dd6..b7b3cf35edf 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -39,7 +39,7 @@ fedora-*|almalinux-*)
 	dnf -yq update >/dev/null &&
 	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS cargo >/dev/null
 	;;
-ubuntu-*|i386/ubuntu-*|debian-*)
+ubuntu-*|i386/debian-*|debian-*)
 	# Required so that apt doesn't wait for user input on certain packages.
 	export DEBIAN_FRONTEND=noninteractive
 
@@ -48,9 +48,9 @@ ubuntu-*|i386/ubuntu-*|debian-*)
 		SVN='libsvn-perl subversion'
 		LANGUAGES='language-pack-is'
 		;;
-	i386/ubuntu-*)
+	i386/debian-*)
 		SVN=
-		LANGUAGES='language-pack-is'
+		LANGUAGES='locales-all'
 		;;
 	*)
 		SVN='libsvn-perl subversion'
diff --git a/ci/lib.sh b/ci/lib.sh
index a5c4eb40bea..fdfde612339 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -250,7 +250,7 @@ then
 		CI_OS_NAME=osx
 		JOBS=$(nproc)
 		;;
-	*,almalinux:*|*,alpine:*|*,debian:*|*,fedora:*|*,ubuntu:*|*,i386/ubuntu:*)
+	*,almalinux:*|*,alpine:*|*,debian:*|*,fedora:*|*,ubuntu:*|*,i386/debian:*)
 		CI_OS_NAME=linux
 		JOBS=$(nproc)
 		;;

-- 
2.51.1.930.gacf6e81ea2.dirty

