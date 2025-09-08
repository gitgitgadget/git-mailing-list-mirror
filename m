Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7784A302CC2
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340829; cv=none; b=NmMcftdGMg997ylmBHk4AqoqM/8XuxCS2OkI3hgtPS4aDP/2o4NyZuVf3d6jQvm2V1cBNrmxcAkgoMnk6rn/3s2W1DdJcAxcUwUgWrRZFPgxsSuSjxTigkYSNjhti4hQjzrUj0SQFh2kZInv9kTVLcV+F+luNTDrFIQCstw6tU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340829; c=relaxed/simple;
	bh=KlYoj3+b10zAluf9cxWMzH0xGmg9yuOkl/avDYfpmpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CyUO6jZs7an19/A1oCsMa0OBkpG78WzaAdcgxmuQN4FLY7Dg6KKtfO69+AT8TZvA/zQC5/0iJqmttSZt7t/S2c7L2dlh70JFSaH1U+27Rdb6dQi79JBkPH8nw1L3FM+87MOC7t93dT97ieCwS/A834rhhqadt/5SM7fNpbFYJ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AKSvVmeU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MO8GLIGZ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AKSvVmeU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MO8GLIGZ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id AA337EC011A;
	Mon,  8 Sep 2025 10:13:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 08 Sep 2025 10:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757340826;
	 x=1757427226; bh=6jZcI5jgGZLwVVjeToEIhFmLXR5a2hF2CAzXjmSlFrM=; b=
	AKSvVmeURxk4dMD8poGJqwplpD++bZnW57nRLba4evJInL0Ej9hDQhuYujenH9qm
	UZHcaCsun+sqbJZWM/IiMs4be6l1+K+uuRVLNFgNewTJenvXYYGqV7xIjI+yKyXY
	fL5LvO/GPD1Mapn49FKw2BltUmdZtlp1aZH9jzjF614c7rZXKMCY+KwBcK0/lHYd
	TNr+KC0ph/NB9D1Fd/UUru5v0fFKGakhNf3uSD64RG9oUQy+1Bq0L3UV9M/npS/6
	S2a5Qj2CBO2q2p1c3/FYUUyYEbG/CdhBW5C5ouxNdR3s+yI1fp+9LSGKIG4l2Fti
	0BzXhvVkAYFmv6CadN8wkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757340826; x=
	1757427226; bh=6jZcI5jgGZLwVVjeToEIhFmLXR5a2hF2CAzXjmSlFrM=; b=M
	O8GLIGZAkmC6koczGzXhj1HGyZ8Iqxm6VczzsO72VVHCZi1rfWzgmPYtgdAqnl1k
	JStkwRSL6FMZJ3XzyEx3oxNbL+gAU3IgjryYYqub7q4IZ9Yx5irjoBtoZATL2XLP
	s/9+DR3Ay+Rzk0GOc/anLVHEnwyn2I1pEvRpsIklTphk9jUTNMNq1sPEoe14p32G
	BEX6Tlvkn1xfmJM9zqrumT1Cc2ZKkoe4jiTMSY7COomOHcX0eT1CUoypzsyONOyl
	SCBq7KHUzHwTvgNOyxovxmo41wUz5VxiHKHrT+y+fA022q8hrICQ5FbWjENjzH/U
	foOsAzUdYkub+pKl5kEfg==
X-ME-Sender: <xms:muS-aC7MMqoPv18I_Hs41UsiHNLnGbE83nOixk0gqr_sbrMjOt4uhw>
    <xme:muS-aMDUNXyfrO17EnKG4MvXroODNa50Ca1avgr49thfnQQHB7T_hN_8Ibtr_uOkw
    cyvIBCX_oOx8kwgOg>
X-ME-Received: <xmr:muS-aI4qRWi70yiKvzeHRvEQ-OMUv2G17qJ0DZ6IEwlNsGkGwZbDwNxC03RsYhPwi5WzstXSxmquoauoFdrrzXusj-N2Tud68Jjw3ab6cmm2Yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegtohhnthgrtghtsehhrggtkhhtihhvihhsrdhmvgdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhivghrrhgvqdgvmhhmrghn
    uhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtohhmpdhrtghpthhtohepjhhohhgrnh
    hnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepshgrmhesghgv
    nhhtohhordhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehs
    rghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhope
    gviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:muS-aFtSXZV_qVKgGxXB2I1Bcj4tQT7XZxh-15yaryedAo_Mht40dA>
    <xmx:muS-aN72BGJ2ncHoder3mRk5rxB9NORvI_WvUTFmHh61zQrB_M3GIQ>
    <xmx:muS-aJ2Vu96IU1KGLmWN3fXgctxjzjvRdZBKMvsPTte7KFV9D58slQ>
    <xmx:muS-aAg1sKTnPwuL8acCyLWMF0-eHOYpOQwuen3FC5bGYPTf8WggoA>
    <xmx:muS-aNM7fx8F3CU7Cm1hz93JrBHM9FHBAQAWW9_X_kWHAmkrWA613cOV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 10:13:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9cbee6df (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 14:13:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Sep 2025 16:13:15 +0200
Subject: [PATCH RFC v3 8/8] ci: enable Rust for breaking-changes jobs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-b4-pks-rust-breaking-change-v3-8-1cd7189fed3b@pks.im>
References: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
In-Reply-To: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
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
index 35bd05b85b..d377ea2b94 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -35,7 +35,7 @@ fedora-*|almalinux-*)
 		MESON_DEPS="meson ninja";;
 	esac
 	dnf -yq update >/dev/null &&
-	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS >/dev/null
+	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS rustc >/dev/null
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
2.51.0.417.g1ba7204a04.dirty

