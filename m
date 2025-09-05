Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D63634AAF4
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073090; cv=none; b=bkbxkgFUwDOUz+IiiEunmQFlzlOc2NxuMZdPxIMhEDhXwo1nRwLbH86DeWu1/28PV3y/rtNB7OgRlCz4TDD7RvlYfpqxtbyPwbGN18T7PJk5yx0Y5/aJN7TKy/6HVSbap3pL4eseJd2QL3lmHdSGBBtND/EGdabJqbJ+etTgvZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073090; c=relaxed/simple;
	bh=3EXTYAAi0zzZGWPCzPqBsykoEUuGTBbZh1Dg2zZnVJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IX/117fpMkTSsuGbmzbC+zS6L+1ZniVYQc/UszSc1i+xa7KWy0gADPMorwhXmMF+WUHdaAeG0FNKBtgaGK00msViA3e56LZGD3gY/T/0hmh39qxErOC2wdS0dX3EFLGoDglZOSYlhvH7m+tJILQ+J+rhclv75uIW7PgslsJ+NjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YCMDrAao; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jyBreCDv; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YCMDrAao";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jyBreCDv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D26D91D0008C;
	Fri,  5 Sep 2025 07:51:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 05 Sep 2025 07:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757073087;
	 x=1757159487; bh=asI5T3YeApJf7HOQKtMrX8WddvTdzjdv61Rly9uO9os=; b=
	YCMDrAaoMG8i0zcnjfd+UJIAOfl6qeaTVva/2J2DuChqfz4+30TgzVfWJQ+f0ghH
	N9Ag4rwSIiEBvTUepCWmaTL1Fk4G6zYWo3ja6NpLLq8RUoAJvWQ3USutXSxKSbSv
	/Q1aISXSXm0hqOtDi7iY4jJFDEwRvG6qqNdPl8NM7hAk//VrwwOoaWZY92pdjS4b
	lRFi5gna8uK3fZPoXtB1J9MxP0u4VDzJrB6NYUgFb+Jl3ltlptjI5wE2lLfd9sfB
	4XMzMgjdvhel0QKVXvx5GJuGIBfRHUMdF05tIIA4JqhWVi57a8f8g++tfFlvnKjT
	rd1mbDP86NlR79rtiRYUbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757073087; x=
	1757159487; bh=asI5T3YeApJf7HOQKtMrX8WddvTdzjdv61Rly9uO9os=; b=j
	yBreCDv4uC074T7oDUvckVTpsc5mA5C+zzP/X4DlV9tcEAXR8747KxIDssG0N63I
	pSFcDykAt9DFes03NQHg2jLt4KubXyE8QfyT7fHNr3LaP+oVcTSmoMGToYAoHml8
	9XvarU9sxs4xu2xBZPJX0DyK+yI5BYJv0o1BtxWaOTU1wXiIjdwoI6wDexgWhaH8
	6KL2XvBSK8daE/s1dsSXBRY1pVvdkOBWnjhSxUN3Z0ahN22JEs7FUKdhQm674vSP
	AoWcHqZRp1LJz6XKRfa0CR2tOjx1KYh71mUpLwHoz3uKceYpfXoCljh5CJEr+KUi
	GLsL0G85ATlussbPencpA==
X-ME-Sender: <xms:v866aJxs4SiHadS4JoxLN8R1hSF83sBQccWy17_OHEk9Y7ZtST7amg>
    <xme:v866aJb3GpoWGlTohrMgXbwa06vd5xUQgdBE_be568xvKg6hLR7RIKD5sVf5YSEdJ
    aSpiYf1dvEc8CCOJQ>
X-ME-Received: <xmr:v866aKxDabHZpIWxFiAM6nLp6sb_9lcTQ1q3bE5NkwflE8QOC1OUpth2aRGF1mprUhCUCSvaG9UzPhauv7V8tz8IzBVgJuiEzMk5586CKgis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphhivghrrhgvqdgvmhhmrghnuhgvlhdrphgr
    thhrhiesvghmsggvtghoshhmrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshgrmhesghgvnhht
    ohhordhorhhgpdhrtghpthhtoheptghonhhtrggttheshhgrtghkthhivhhishdrmhgv
X-ME-Proxy: <xmx:v866aCH49FOHvnTLjeFDfz53pIU-WrSzeVMFQDug_nnuRUJC_-Zp3w>
    <xmx:v866aCxwDk7Dr1YxMIzVBHkzbyLjgSggs9XOtSlC-GXGXrpnJE0byQ>
    <xmx:v866aNNPqFlifrRsz4wXIB-L7ib9WMCBJuxBvIRR50p8Y34NdxEEGQ>
    <xmx:v866aAYCkCgADGkmCGHp3jeAJtyTDT3LPWi9LpeilN7zS8Nyh2gDKg>
    <xmx:v866aNkoDTwNrJu7N947Py9pfZwVGLFURhGJEXpgqgvlVzzUn9SF_TmC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 07:51:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 73352213 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 11:51:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 05 Sep 2025 13:51:03 +0200
Subject: [PATCH RFC v2 7/7] ci: enable Rust for breaking-changes jobs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-b4-pks-rust-breaking-change-v2-7-6939cbf4a0b8@pks.im>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
In-Reply-To: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
To: git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

Enable Rust for our breaking-changes jobs so that we can verify that the
build infrastructure and the converted Rust subsystems work as expected.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 4 ++--
 ci/run-build-and-tests.sh  | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 4eaf3514d6..4c58c7238e 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -31,7 +31,7 @@ alpine-*)
 	;;
 fedora-*|almalinux-*)
 	dnf -yq update >/dev/null &&
-	dnf -yq install shadow-utils sudo meson ninja pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
+	dnf -yq install shadow-utils sudo meson ninja pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel rustc >/dev/null
 	;;
 ubuntu-*|i386/ubuntu-*|debian-*)
 	# Required so that apt doesn't wait for user input on certain packages.
@@ -58,7 +58,7 @@ ubuntu-*|i386/ubuntu-*|debian-*)
 		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
 		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
 		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
-		libsecret-1-dev libpcre2-dev meson ninja-build pkg-config \
+		libsecret-1-dev libpcre2-dev meson ninja-build pkg-config cargo \
 		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
 
 	case "$distro" in
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 3680446649..c718bd101a 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -9,7 +9,9 @@ case "$jobname" in
 fedora-breaking-changes-musl|linux-breaking-changes)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	export WITH_BREAKING_CHANGES=YesPlease
+	export WITH_RUST=YesPlease
 	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
+	MESONFLAGS="$MESONFLAGS -Drust=enabled"
 	;;
 linux-TEST-vars)
 	export OPENSSL_SHA1_UNSAFE=YesPlease

-- 
2.51.0.417.g1ba7204a04.dirty

