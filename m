Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316121EB198
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970851; cv=none; b=g1/nVaIUAOi3YaK2pdxoQCzNXEJF4l73lJxo0zCYnENNUtvmegxWvLzRDFYb1xE5NpD3TyrVq9Tu1tnB+rTB3+GIx0HqyUD6zbA1Ae3aYsg6Tw2fMpKieMAjhCLa3OqBvfFoTEL3C2+GpgZgLBZQ+QsvNUJupV6lV+bx6QmxGSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970851; c=relaxed/simple;
	bh=UCyGOLWcxEZz3FREqBU/HY4EuaOY6eUVKanqJx4P3LM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YMGCB3MgTJ3Pk7YisEt9Ww1d/bXkK5CLNLoJzvhGff/HLg/iRL10QB+RKGiML55eU59kcym/gJQeDZlpU0wrG376mIb8Ez9I9/4YCjzoDN1DqWNdzTaZPQgdU/exSNG+q1mEtzvPGvwpIXfWOQQEypAy87PucRlgFyqwwWLoZfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LpJgxW5K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KPj79u4q; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LpJgxW5K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KPj79u4q"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 831F42540113;
	Wed, 19 Feb 2025 08:14:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 19 Feb 2025 08:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739970849;
	 x=1740057249; bh=8qJVE1wuayywVks7MM9lL5vUp8HvipH4/qUnDTa5Js0=; b=
	LpJgxW5KRZQvYs1lliRck9eaexRITrSVz0UGTQNDyIplhFQF8fgFoyb6dmn4lezF
	UkYqW38XEQCdmXLtb66CeCIRI/3hsAdC4rmjg72OLT1i4oQB3KPr5Ueicp2iaG8s
	ChC1ppDsc3alVNPa2Ct3xANVWrxiEJKfVjKrGWE6g44aGeD5pl6KhtmXBNdrfmmw
	3Cno69iIaXtGAXu9DwCKdNTO4ImlabQn7zfrMry3Pd5/fTaQILP0ZKUaERVvDK7v
	zafDIM6NMG9KG1My9ClUyC9UdjOQcpqVCU49biDz1Ti0xPQnY5O8ilMWSweJWyca
	91Z+/LUmJsNqCVzq4fCBIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739970849; x=
	1740057249; bh=8qJVE1wuayywVks7MM9lL5vUp8HvipH4/qUnDTa5Js0=; b=K
	Pj79u4qMAW2EgxjGBQBMmmM41ECufVG/l9totFRkBjGHryK5mw4/TpaEEGeJ0i0v
	UwqSxTnGeiEmhV1vYbvh34CEKfJuVNia5V9LiT++UGZ8nuz0NLqjOPj9kSMZXgbO
	jOAhZm2jgOh00njG70hbPReR0RMYZAHnRbWJpIXizJURurhQ9st6E8q8hpbp0OKA
	ovk2rirbwUgACUgdG4n1UMt+e0+4vtbgLLRaTsoZDlrJHNiyR+1ZTI6CNQjZ8OYf
	n4rrwxMl99fSHZpk8lIh7d9lgPrv0/yRJpBV3g2RIWMfYmllUxPlkj/Q5zZ5VYbn
	kC8qUVcU7sgTJcRHFZBDg==
X-ME-Sender: <xms:Idm1Z4Qrms1_F0fheQ4epsetS1e9F9YApMsMNS_YnGJVegCMaFAqAg>
    <xme:Idm1Z1w7Y-t5IzGezchFxocJ6NIcTAgHzIs7Xh39b4Av8sOLecS0QjVvHa2GTZVCw
    bk19RAf9xQYteAlew>
X-ME-Received: <xmr:Idm1Z11GxdhschwM52wJSxz2kQQ0wuNye9RRNYUdaOTb-OwDsRNrJEAMHLfzZoMBf1F0l8ESVVlJ8KRcVeSf8CSPCFZFwJK5jseZukx4ELUlaOM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:Idm1Z8Dv1VHOTZNo1kL76bIpQKmNY8AKbjDf38FmHSMH60UFyPK9Vg>
    <xmx:Idm1ZxhZwc4mDCPu4lDZVYWMjOxLJGubLNhc3PKlOEGiBqvDGWGYaw>
    <xmx:Idm1Z4obZTE-BpH5Shx99m0ddSqZT2Lfv7vl8g48IOn0UXL7JvMwEQ>
    <xmx:Idm1Z0hHoGCQFvm_hrQ4v-uMyCMbHX650_zYDCaR2nGBqFFvbTS-dQ>
    <xmx:Idm1Zxd3SFt88umoTOFRAN--cZu-VdEW3myOp1IHWiSIW4ji2C6C-I60>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:14:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d36ea361 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:14:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:13:50 +0100
Subject: [PATCH v2 10/10] ci: exercise credential helpers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-b4-pks-meson-contrib-v2-10-1ba5d7fde0b9@pks.im>
References: <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
In-Reply-To: <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

Wire up credential helpers in our CI runs so that we can rest assured
that they compile and (if tests are available) function correctly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 2 +-
 .gitlab-ci.yml             | 2 +-
 ci/install-dependencies.sh | 2 +-
 ci/lib.sh                  | 6 ++++++
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 5f756dfc2e2..9959b61ece2 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -265,7 +265,7 @@ jobs:
       run: pip install meson ninja
     - name: Setup
       shell: pwsh
-      run: meson setup build -Dperl=disabled
+      run: meson setup build -Dperl=disabled -Dcredential_helpers=wincred
     - name: Compile
       shell: pwsh
       run: meson compile -C build
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3f29181708f..bb7d0c9ef1c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -164,7 +164,7 @@ build:msvc-meson:
   extends: .msvc-meson
   stage: build
   script:
-    - meson setup build -Dperl=disabled
+    - meson setup build -Dperl=disabled -Dcredential_helpers=wincred
     - meson compile -C build
   artifacts:
     paths:
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 332ba960039..0df74610d06 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -58,7 +58,7 @@ ubuntu-*|i386/ubuntu-*|debian-*)
 		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
 		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
 		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
-		libpcre2-dev meson ninja-build pkg-config \
+		libsecret-1-dev libpcre2-dev meson ninja-build pkg-config \
 		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
 
 	case "$distro" in
diff --git a/ci/lib.sh b/ci/lib.sh
index 84d11452650..f561884d401 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -348,6 +348,9 @@ case "$jobname" in
 linux32)
 	CC=gcc
 	;;
+linux-meson)
+	MESONFLAGS="$MESONFLAGS -Dcredential_helpers=libsecret,netrc"
+	;;
 linux-musl-meson)
 	MESONFLAGS="$MESONFLAGS -Dtest_utf8_locale=C.UTF-8"
 	;;
@@ -359,6 +362,9 @@ linux-asan-ubsan)
 	export NO_SVN_TESTS=LetsSaveSomeTime
 	MAKEFLAGS="$MAKEFLAGS NO_PYTHON=YepBecauseP4FlakesTooOften"
 	;;
+osx-meson)
+	MESONFLAGS="$MESONFLAGS -Dcredential_helpers=osxkeychain"
+	;;
 esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"

-- 
2.48.1.666.gff9fcf71b7.dirty

