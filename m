Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6C8320A22
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620761; cv=none; b=eu21L+JyqgvX4V+XsYHmv45n4XXEmqKF0EsDM20AonueXIwfqDkZa8JiSWWCk2e3oF17GjSyaot3t1xrFsZjdgKSxb41M+I5TG4hN11qAMUnwyhvCzRps3vGWWRVkMrHzGUNUIOWxUfRv1KS9JAkSBoCuJkZ4DVQVI6lC7IDVyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620761; c=relaxed/simple;
	bh=tAZ4hGqWi6stKfb3AFRYZVll2LP6EEuyImS2VAfZS1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sUO3qiq/Xy02rdW15xrEolNzMdbSBXENnR/r2d2mpy7wH4rNi0G84Xc/bd1nQMzbIXIJdrbqpUHEkEvgHo14PhNfrG3hez7MGVqvlVogKYFJwdATJF8Q6KNo83KRlxsWa1FD6prJmAFOmv4otCTSWBnihwHaFvLjepd+zIFlrtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E20JWY8s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QZ2h2F/9; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E20JWY8s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QZ2h2F/9"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 8BE1A1D0029F;
	Tue, 23 Sep 2025 05:45:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 23 Sep 2025 05:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758620758;
	 x=1758707158; bh=ge4ao4Vrn0qWCZ/p+j2sNXvW6v91YXHQufvIky2JHI0=; b=
	E20JWY8s1CSE37vN0a3EWeEGklURrHv7CS7XVcyQJaeALOfQJqI4W7KXfJHs9/tA
	cSMvyEPGPj0crLKDTB9H5CgatRS3UiJffg5zKxBIm1zKH+7DzYwXUFFt8ezjv1TU
	T6Nev4BvtjJaKeLJ5meQgpgHfXZpHNdGB2RZGvCO4HmKWe1pblDcXXhojL/GwiRF
	7l6YS8DzmIRx5T9MwHebdd0ERyjFA0VmdznTJkUGho9MaMpQ25MtoUAHodPYjzEV
	ECMZ51jvQ1svj27GR+LMZd+CTEBDcaHtGrWr3m03UzbS+GgOG+KrlWpkAArvhqQq
	b8HlKRWGGad4m8tLsNF5bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758620758; x=
	1758707158; bh=ge4ao4Vrn0qWCZ/p+j2sNXvW6v91YXHQufvIky2JHI0=; b=Q
	Z2h2F/9Iz8BinD/QfrL9lTDHb4ViseBKrDRE6Uqrx4UYzqJnhiCqtW7KPuEfqF5v
	mGqAK4y8z8PasfuRU0yn9n6Xq7fRerBIbIwmo1u758YlRxgRxIKJVDJTFsPSuZ6F
	bDgr1lhiYHTwN9XBAgmylxjpObhV6DUVQHxGLMbCuStW3vQLEBHKKqjRlwvZerAA
	8scHBRmpn4lVEATO4E9UWjDMrVMpgWL43tVQRyUzyUbUAmI2y9w7yWSasJ9U92mA
	aiGg/BQ5cPaF395SsXrot+VZbvWOLwEpM7LTjv/KBmOXiC6Gk2JZxP8PX1bQMr/K
	AclvDSOp86OybPlnCqS9w==
X-ME-Sender: <xms:VmzSaM7-tWO_ou0DL-XHysBYnWfl-5H2OEIFM9W11-m8omUnIJDLrg>
    <xme:VmzSaOUE_bRcRWzwb4urefS7yHBUz1oOdXaKWAypcXyLxeRuyhPyABuzgLuKM-jZJ
    xCXIgXbdpv6IPYCN8sBGWxsQFS9SC8fF_K2mbAuK3zZIJ0fCkpkI2g>
X-ME-Received: <xmr:VmzSaLNDINxrpvfNIl6Qe_6JYvz5Q7cB41v8uYzHE4H1CjnxIlPAAb_9mfL2PXOnEl9nEFy9V-hWNo_jTypjXxHXOdBNXu6PXDQt6Vh4NKVU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopehphh
    hilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrmhes
    ghgvnhhtohhordhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoheptghonhhtrggttheshhgrtghk
    thhivhhishdrmhgvpdhrtghpthhtoheptggssedvheeisghithdrohhrghdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepsggvnhdrkhhnoh
    gslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:VmzSaNh0JbCdAxIV36qBp29Oam2GxXkfj7fTIVE5T3_-GBiLu9Ro7Q>
    <xmx:VmzSaJ7at8iSoESTRDIA4XLyx_6fIfMzY9KaWS8NWh9DXh7APo2qIQ>
    <xmx:VmzSaMdoDebundEAvkSLltYRsL09ZeedP1sMAxhXRuldQ74q4DmbhA>
    <xmx:VmzSaKDunT3OFOBnrrew1zcJ2ibbXVptI79-AQZ6iLe2Map0UPLwow>
    <xmx:VmzSaKwJjLh4JJROh6oaGsVwUURxC2ZGyjrj6bcRNyl3ro6NBBUnS4aE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 05:45:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cef187d5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 09:45:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 23 Sep 2025 11:45:28 +0200
Subject: [PATCH v6 9/9] ci: enable Rust for breaking-changes jobs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-b4-pks-rust-breaking-change-v6-9-59076fee486a@pks.im>
References: <20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im>
In-Reply-To: <20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im>
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
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

Enable Rust for our breaking-changes jobs so that we can verify that the
build infrastructure and the converted Rust subsystems work as expected.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 4 ++--
 ci/run-build-and-tests.sh  | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 35bd05b85b..0d3aa496fc 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -35,7 +35,7 @@ fedora-*|almalinux-*)
 		MESON_DEPS="meson ninja";;
 	esac
 	dnf -yq update >/dev/null &&
-	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS >/dev/null
+	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS cargo >/dev/null
 	;;
 ubuntu-*|i386/ubuntu-*|debian-*)
 	# Required so that apt doesn't wait for user input on certain packages.
@@ -62,7 +62,7 @@ ubuntu-*|i386/ubuntu-*|debian-*)
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
2.51.0.536.g15c5d4f767.dirty

