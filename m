Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A07D32142E
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518590; cv=none; b=rY8oJRCVTESdGVV/Z7gMUWTtwbgHzE4I+PQ2e0IaU6sUCben4nBfmwesKdaaLSgL5F32tPv0fJOAEv3QXCk52WDmjW1EGcv7Ys4U+tpR18xJi1tXCT5BhJb3IcWg03IbliwXEVrdwW+AsJzcmTPwxo2hFSyBYeWaMYQnfUoDIXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518590; c=relaxed/simple;
	bh=LAgPZoIiJz4grd/OO7JP6NsGSP+5U2M55dYiQ7qPAPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HWUftZwOTtkqxTEkCzxS8LAauUPCnGVq9ZO7LpqeflbIWBH5KTXuoGvYRCkFtVyU5PsVQlzEhw1/xrRmu63afNqJVFH0TVM1EJFKfzrbpauB8Xm21g/XFwhEo8pdvAkMH5lQSAPh61Ogzx9rxd4LP6iVUsxSK2Dnqnxk1RObtUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a2tRFe/5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h4KeEPvH; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a2tRFe/5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h4KeEPvH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C48C3140035F;
	Wed, 10 Sep 2025 11:36:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 10 Sep 2025 11:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757518587;
	 x=1757604987; bh=eu/nra9pCErKYja5+y76cmBI+DO0Qhl4T4ZCwg0aGF0=; b=
	a2tRFe/50Gu9Q0VbJrKLss6y4VXVX6JLw95K5AhdYgJ9Kgbj3cH97hCgO4bN4Tqm
	PJEGdkaGPmytdzUW7sqOebpUHkIZ8sAAmgypt7ZheT0H/HxdJJDm0JJ/Is/ham6l
	Q2ujhXdGsP+eyiSYM+AI2kZAjG1THdd4XFZisAEBX7+IxY4RFLbxcyPK7VFm86O1
	fGZL7w3OdFbhcLqg/VbHP8EPe3hfX6eKn/JIKG1CommwevvvkqO4mMdOtkW1mytr
	dbbwULiu3X+UJVOaVJdbC7x0IP+/7eWMI02MMm4BJYvczs7DhSTZxgGOGidj26oZ
	FrfOWbbSE+Z+3MyDpZ6aNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757518587; x=
	1757604987; bh=eu/nra9pCErKYja5+y76cmBI+DO0Qhl4T4ZCwg0aGF0=; b=h
	4KeEPvHcn6ZDmXgeaAlZ91gzqFg+OKUfQxiwN//Qgh5ZTCbJ8o2blHPHbGtCiEi/
	JQgX4FYNpkMBZqWKQ3j2G8Ei4uH/iTZyqiTc1gFaf7l/f/VWbljjuON9j7fClff0
	UTdSVi8p4V5P8F4PaauoDYj60JLHMBasDm1qAKCUveYzVMnxtpURMYe5RJB6olkh
	0PQF58C/9aftMoCwFlICyDXlk1WV5OYeUgqY68fOYjwdNEULPLu/9YMUSK9HuJ1n
	3ccVNP3HDSWyT0uYw03vR0JluphG76TDno7W5+dbJBeRfBQRcEqIC3icYBTGLuY7
	jgavdP4QvssPHZAj96EUg==
X-ME-Sender: <xms:-5rBaJ4qaebN_YHIyJPPWHJHL5gkIW4H9GF4qCCLQbYABkT2KLzA0g>
    <xme:-5rBaHCqdCePo1R-z22cHA-dwraGowHvncnYcssMtJ16tt81GAiItuMW3OUlq6wHA
    eLwcjxgItlozhPAUA>
X-ME-Received: <xmr:-5rBaH5GQmSMhv2O6GD7eN-JlQlrq5kKzxDQrHUy0dI_pPD_BnO_pL1bb2ZTSCEWRnkXAi2APlxHlo67xakZDIBCj0XmeLF_objA9Ns0MZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghp
    thhtohepphhivghrrhgvqdgvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrd
    gtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidr
    uggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegtohhnthgrtghtsehhrggtkhhtihhvihhsrdhmvg
X-ME-Proxy: <xmx:-5rBaIvXeyhQjTuoVRHriqWgmLDuOwjE57upukiFy07-2Cra1m08pA>
    <xmx:-5rBaE7M7Nm7AM8Hal2YKI6veqrNEInBxpUB_hTN6sZkrwbUgJz_UA>
    <xmx:-5rBaE0WdBl8UsrfrihIfwlwvrB30si0TgDLB9uE_6HRNEMyP1S4kA>
    <xmx:-5rBaPgfHavfaA-0ExOlzyJk27SU2Kf2gmJu6R9gYSagHCD0LG0K7w>
    <xmx:-5rBaAMbpXXXVPaxqI-JK1qcavoV2grF_ZYFYLt4SlYH9X7dO27qdmMJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 11:36:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f8ef45cc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 10 Sep 2025 15:36:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Sep 2025 17:35:55 +0200
Subject: [PATCH RFC v4 9/9] ci: enable Rust for breaking-changes jobs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-b4-pks-rust-breaking-change-v4-9-4a63fc69278d@pks.im>
References: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
In-Reply-To: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
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

