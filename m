Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E682FE59E
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935417; cv=none; b=WvERtIgpFRFjFjuVHFC5z2ll6nCMQAEes+ttWolQ0xcFxnh0ZcG2fWGGYRx45h+2PBdmcdz/BMETtBGCdy8Bif6WTBv4ksV9h1mwIV001Qq32wCdFVwNKGrwtfKc8IJtH0/cxGz5q/BU1pbEoJ68br6Pl9gXs3HEwaHjzuuEQtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935417; c=relaxed/simple;
	bh=LAgPZoIiJz4grd/OO7JP6NsGSP+5U2M55dYiQ7qPAPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QRIxfzb0xTSg4D+CcNXCfkfKYX4brpgYiPxzGshVxqoEceLoCgUyUsdRs+XAuUpBYM8iza+brM8Tm8e3Jh2w4EwjZ70n5wywz3IwRYvmB4Z2ZqmiIziiI8BYqtmDf1iOnvNE+aWOZPt6ekqfuMryyMeRVjW3gfV+WodJii0QGBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lOjkkoIg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jo0U7SqU; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lOjkkoIg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jo0U7SqU"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 48D92EC02D3;
	Mon, 15 Sep 2025 07:23:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 15 Sep 2025 07:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757935415;
	 x=1758021815; bh=eu/nra9pCErKYja5+y76cmBI+DO0Qhl4T4ZCwg0aGF0=; b=
	lOjkkoIgcOLkOCphcE58H7n6YTcdDcIubxZmjRWbCMEQdd0v4R2g/D/Gi3ebD44C
	QFVdJibjBAmMKbOWmMYJmTrAHkbsE8THys8SdsgjQt2UuvYWXRDz+frbuqoBJ126
	NLH0uWq4Pd/t9Z9BNbQTdXSVpS1nZcT3cQ/DJI5WxBC7DDK5t7jV1lTvaq74RY8S
	WwNVCJV/v99rBSNaBD3Oad+9XSUzeCAcdHeTPeQ1uJrxokVc2KmRbmJMc5WoFpUP
	1wqLTP74MHvYqw6gHK9dTaKidlBnHG7nNk7xbByX+DaJZSZSoOgRgJ/sf8v+bkiv
	g15OE1jnueiqr8mYj4xbAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757935415; x=
	1758021815; bh=eu/nra9pCErKYja5+y76cmBI+DO0Qhl4T4ZCwg0aGF0=; b=j
	o0U7SqUT2jMYXGXjux7Gvf3qa0vxttzJ+wcXTLnaEVsI4ZjK8WmFiYsyrOukunQW
	xBnJDF953FcY4+0hURt3Yqt+WNtOLxUnAEBKsmX9C/PD1096OGKCJOB7Ruh7pNhC
	C2ZGu8k33KrurgGcSJqrz6bwPtsG++/a/cBdL1yYvb+/gqkk7rTmPWqekvWE9O2O
	XSrPlLO6kWMbV7oECb4JwVITdRwHI7syrphXgu/RWy4o2ixkBf4XSVwU2lbty8ms
	/VN4UjM9Jb/7aj/UtafVvIZDysCFLjOEGqqVt/9fzc8Vx4Uqn92rDwYzndQbf2Db
	Cf/Cgg2o2yJcO8InDxaGA==
X-ME-Sender: <xms:N_fHaCIiqsMxqdUEdZiyoaaLNMolCUEiBzGZ8s0niBlY-P__YZRTtw>
    <xme:N_fHaKyEVn6rNQ5J6TOCJJ1RttYNGjG8Jc9VYSdcK-IyNrrxWrdhI8s8ALSn3A0Ib
    O-SVgLqDSDItqQiMw>
X-ME-Received: <xmr:N_fHaN3UKlOfhnIaCM4lB3QP3npqno5wzx47Ko4PbC7w-BKd8b9ZvLHL30M6n29k93H3aYRmgNd5PjX6hkShiaXoprBIWO7kl-cjCywsDeBo1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghmsehgvghnthhoohdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehpihgvrhhrvgdqvghmmhgrnhhuvghlrdhprghtrhihsegvmhgsvg
    gtohhsmhdrtghomhdprhgtphhtthhopegtohhnthgrtghtsehhrggtkhhtihhvihhsrdhm
    vgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvg
    hstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtoheptgholhhlihhnrdhf
    uhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:N_fHaL864uAbvCdDG6g0On__akLOj01bROFNgPSBu9DGoGSCZxm9pA>
    <xmx:N_fHaNT84X4DjLggzPOOcymRBxAAqnjH17E-zlso3PEL2Bh3-bcL4w>
    <xmx:N_fHaCmmIA-NwX4UU4V_AAbRxczqc3fWrpL8jmKFQeqNOKYsOQwrSw>
    <xmx:N_fHaIXTgWFp1aXwwVD8MPCC1W-HgvaallGZCYZCcJ5TCkiTMBZwGA>
    <xmx:N_fHaHFkxW1QRuJ86GhqSbN-Pq6HLTcwUJT5-bTOiwzzO43FZbyT3bOo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 07:23:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0d25a882 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 11:23:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 13:22:56 +0200
Subject: [PATCH v5 9/9] ci: enable Rust for breaking-changes jobs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-b4-pks-rust-breaking-change-v5-9-dc3a32fbb216@pks.im>
References: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
In-Reply-To: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
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
2.51.0.450.g87641ccf93.dirty

