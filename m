Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E022D63EF
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390266; cv=none; b=ctV9JHshmaawxQpvg5LwjOPGWNw18Lv1KKbMrhhXCN0PShdpUqe10/bQ5D8DECbyyvL19o7/tN5zQigZ0ARlkHQenIVZbdXZ135KZjpskWWZijgcFXimmpNhDpr+yyZJjoZ4ljHT/RDRQJ96u1oCA3tku605mq891YuGkfz6/5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390266; c=relaxed/simple;
	bh=SuZVgq9qD+BayU5dL+3cgpt8sK0aDj6oKCp5bW2UO6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F3SoadGLgcbr6VlKcMsnyg+SpbKWJM3XZPoeI80O0aVF/pVttnZRAU5tK+1MBGYQaSQ7JjivG0Y7tKd+Zw1F0305d93gVjsyhCIFGBzNjQWmWi/YtpdCbAwpwnghRKUTG4o/6W/83HTbDbSr82eg12tnl2icMy5YTnLSQp7umRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CYETS1mB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lURD62Ta; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CYETS1mB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lURD62Ta"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E35357A0152;
	Thu,  2 Oct 2025 03:31:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 02 Oct 2025 03:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759390263;
	 x=1759476663; bh=Dn/AQdJxPgy2annwTvqpS8+K5V7vUklF7BEi+TzAUic=; b=
	CYETS1mBZBoQyde8ufOua9Emyt9ERTfqIjVkvZWaskZaY5R4ZR59Ktc5vcS4dUd4
	NFGNAyI6uUCtex6v/sP3CLxzZVQmRxphhNC5OLKachQaWUHqe0ybXYDklcMjYEVN
	UhrA7T4IyFEcLP/QWlH50ylZW/aLBEnU6rZw/RMkhMqLCnvd0MsreNLB8OooqPCy
	rbOwTnawWEPMTDSHhT/kQn46rGes5o0wNSDt3m/AVyBdbBygpZklXvA0l/izNpSh
	sZq26zjZ/eZCOFixxRuXsjKS3DCzuSiz7elZcZSlFUrXycN0crao6Oj1RCmQntlo
	w7vRsyhB1C5jaPTvoAugKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759390263; x=
	1759476663; bh=Dn/AQdJxPgy2annwTvqpS8+K5V7vUklF7BEi+TzAUic=; b=l
	URD62TaMQhWEUhXAmf4zbYavbVULFHY8uwYcYX4s0sDPSKMxNi0CRW4B9gkonBDu
	8AzYahHmBXSUBjuNs91+5q/ERe3AErwZZF/gBDsIle3k2d3tFmgpd/mTnyjtWE6M
	oKXLm3FsHOcNv16SHwxE5gMcCwb5IM3sNmwG/7kwHdINCORgBMa+1/GbJLVzhL/N
	zlDXKBWASI3geZ6PZekngmCKm9eNI5rz1leKt1CJIJHiDDJtSpoiv99q79QD2liB
	o9ttWNA1hQM/U5WEuXYbbNPFH29RkhqTKGiQbfJtjMEz5Tg3vl67+28PrUvoqoqh
	HsQP9IV0qxQJc1BfyjTVQ==
X-ME-Sender: <xms:NyreaI-eWWsNxn_ANUtdCmRMYlUSHXYKi0xFbmm_0LY2jTGaBMW7Ug>
    <xme:NyreaBJwG5sTrLTNUeFUC38QiIeoQOKh1tNIGxnRLrCOuATWLVP_Em-Za9jYj-W8_
    JEPVqeMD7Q70nPaXnbHIiTWTvhW0IvvAV_j9uJq8qevJcoleNmp>
X-ME-Received: <xmr:NyreaNxT2v7h8oPMchd-hUfZVUabJn719CofeBAp3ZLjQC6E_D7vTUReajlvKTo3MhFs3ecydUqjLbt1myTSGUCm0tzz4TYsqAluyAE8sQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpihgvrhhrvgdqvghmmhgrnhhuvghlrdhprghtrhihsegvmhgsvggtohhsmhdrtg
    homhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheptggssedvheeisghithdrohhrghdprhgtphhtthhopegviigvkhhivg
    hlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhs
    tghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthi
    htohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:NyreaE0srxdtBo8V6qhy3wy4ko6XDE7-z_8Y34S5ii-Xzb8tUL8kHw>
    <xmx:NyreaG8VCi-FQDs90Rr7l5GKXuLkVGsVIRXDY-Bnl6aNHE3qcK2TcQ>
    <xmx:NyreaMQ5lM4AaWEe_hyVcPqCHDROxkxQhDSCtqO4oFHWZG3lhEMXdA>
    <xmx:NyreaFk4BG5n6ClNj5T8x7rm3StLpJangM2m4p3ITzz-j_gxhPvdzQ>
    <xmx:NyreaF1q691HaJV0h6AvQeVYlON96GmMnT_o0GJanQtFhutpkZvfopDY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 03:31:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 737e21b6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 07:30:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Oct 2025 09:29:34 +0200
Subject: [PATCH v8 9/9] ci: enable Rust for breaking-changes jobs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-b4-pks-rust-breaking-change-v8-9-3a89fd5b1ce7@pks.im>
References: <20251002-b4-pks-rust-breaking-change-v8-0-3a89fd5b1ce7@pks.im>
In-Reply-To: <20251002-b4-pks-rust-breaking-change-v8-0-3a89fd5b1ce7@pks.im>
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
2.51.0.700.g236ee7b076.dirty

