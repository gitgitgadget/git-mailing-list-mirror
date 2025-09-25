Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C132F6184
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 06:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781851; cv=none; b=qp3EGJNjmjc37n01cCLDmYk6IQ9rZXRY5u2z0ilJSqFgcMBCKN1s6inXiHIISThDTyNTivuInTp83aHhKRktI8B8ECKEzBNlBB67qmAtOJKvxBqxTvUbxw0bb+z+lY+3BxcU2p7M3pWGo3WM09m5MJMfCmGEuzJ4xJqJ5oDGsQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781851; c=relaxed/simple;
	bh=G2+bXFinkgZzbFugE8U05wp5gaKa47xBfDYPIYFFk6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xac3RvDUUJNJHUtLpdQVXg7Q6f5PMGBAKa8n52XZyvzMFgJRhkbbj/MYxa5c51wrNX4V6uwJDgfSOhK05/Yta41Suifg9LZLhdL/ZO0+r7p9i6pnxGDxLduTVtdWMmUr5HcZ8ZaxneLYbEdDJDgSOiW0b618tq7F8JHsHfAjhb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KLOsrZqI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BhwLggIb; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KLOsrZqI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BhwLggIb"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7FA057A013F;
	Thu, 25 Sep 2025 02:30:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 25 Sep 2025 02:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758781847;
	 x=1758868247; bh=QGYnUXHt6lNVnX+kmsTRtKJvg9TNrgrUtU0WWYNRDYk=; b=
	KLOsrZqIClEmzljMmy33hbHqh62aR9qTL2M5TiFUcYYEkCFhLxPAGlht1T+HA9iq
	0Y2MJUgvtzPIA/7Y4KVA1KjuPXHXmZDEhIOP++iXAYwU4fr1mteAWR6IANlUWjTS
	12T4Xx4iBgyD1igUliXqbbKuXLaQv8/4OfQVoo3JBWC1mKXKoj8HyjZUKtA0agd/
	ivAsm4cAxnfzMMUXfL3C5PgzZZhrrxYpxq4oqX2S7EcFswbztn6ibpEIy6kFUFww
	ORNH46mp3JRldR4QlJGZAeazCnlo7dqCHoTVVLROrMZ3QPxtKZ5vjawLvNqe3rXz
	68alM8HFxo+bfduZQJcN5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758781847; x=
	1758868247; bh=QGYnUXHt6lNVnX+kmsTRtKJvg9TNrgrUtU0WWYNRDYk=; b=B
	hwLggIbGnaC5NguxIatBQ6WuY/J6QbO8T37n7emmNhfHtoQkxof0YgQyjI9oAaXM
	szGpEEeob7yLH+WqwgkUyT2GR3J6QLS907cTxPFqdU6LcugGb+ygTeBPTBUdXgbT
	CLjxysgVLQ6bO9VIzphCnSlu1PeVyE+KB3CB3EdsA/LSFO2f6NU39k3lTwqS+xLC
	fmlfBo2ZFGJfWSnPFjPTlZvDHxJAdvF8x+Yp9uiFOnF+66tjceVcpXl/YUoaGsM6
	2sRWPCcaJ5SyGjrUx9zhRMxJZOa9MuTZt7xUT27dlKjIOVD0w85cG2HZ6mOY+nwz
	kGoOE4yGlyGX46CGC7fWA==
X-ME-Sender: <xms:l-HUaHDFeJpSZOy-u9avrgpTftbXe0hM0Sgd4oUTCJBU4gU-SmMHoQ>
    <xme:l-HUaN8juZ1GTnk_sJei1Uhdl2vvQH_oVnzU56V0JROBApcX2L802cV37TkWqtjk4
    9Gh8baPLoCnFN9RmWcvmZSbIOFt32nNJNfLNywE-OdDRv7DPm6Sig>
X-ME-Received: <xmr:l-HUaCUQhlJ913BLqb2PD_R137jMCwlxX-afViuO_SDDB4Nm2eB6ToIjoOnukCV-nnyTmgGpQafBPE28H8gunKuEsW8aG111yWvpRnZ7g-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopehj
    ohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehsrg
    hmsehgvghnthhoohdrohhrghdprhgtphhtthhopegtohhnthgrtghtsehhrggtkhhtihhv
    ihhsrdhmvgdprhgtphhtthhopehpihgvrhhrvgdqvghmmhgrnhhuvghlrdhprghtrhihse
    gvmhgsvggtohhsmhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
    pdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:l-HUaGLtQ-Q2CV-FxE-7CaTO8MPJoTKN9pfdz5Qlr_tHxrjvH3D4Sw>
    <xmx:l-HUaGApNSU6UtDzoUJbTcf0Mq3KubpqOvYPv39VD1VrtZaJjXT8xg>
    <xmx:l-HUaGE9ArMdN3oLZacShiiNiwGnzlZK37xliw7yLtfxbJNvO5r4kg>
    <xmx:l-HUaDLQ1gKCnsxRveMQHLjmo991k3HpE39oHYDSJvPJgHGZhaKVRg>
    <xmx:l-HUaC6AGFa2vRvD_AYXjIEnxOrc1IbGuJeQVM4ukW_VCCY4kuPLgOCR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 02:30:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba598422 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 25 Sep 2025 06:30:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Sep 2025 08:30:11 +0200
Subject: [PATCH v7 9/9] ci: enable Rust for breaking-changes jobs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-b4-pks-rust-breaking-change-v7-9-4e49dcb904d5@pks.im>
References: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
In-Reply-To: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
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
2.51.0.618.g983fd99d29.dirty

