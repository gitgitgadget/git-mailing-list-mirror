Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2260A2C11D1
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 06:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760508278; cv=none; b=PNboNg5fFNfxOhz20k+M06t4NxKl5yur1+yK+6lV6gpJDVZOMJtKg8alFtfoKXIVs6USgQWeH04VsVeMJjP73uRMAnlm7Ue1VpMiTDE348FlV85cDxx9FDjcQWOCZJGX8ROi1h2QCy/Nwo9raCcv40cOVAyJ3ZiZ5LsO9qOTpMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760508278; c=relaxed/simple;
	bh=AkdgGpeR4b352COsamkXOY+njg5DHkxSGeDi8eXsk6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aIVuXTbZJMFE/Ddxkkkj+boSGrmV4Thtz3VRp2SXGminbsOrWorI/4Qo6XKWnDM9nvhwpCAndImd/3rrO8oiX8WvIwBO5kYjLkhqvnStMxk7R0ioOfg+Pdo3bc87zPjyWnsYR4LDIN19WYQMSEM3jWALDOvH3dg56sCYnxNSqG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bkwpQev2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TzeHJYo4; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bkwpQev2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TzeHJYo4"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 404167A01AD;
	Wed, 15 Oct 2025 02:04:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 15 Oct 2025 02:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760508275;
	 x=1760594675; bh=Brw/j4qbMEYFdnrJiw5/P0q16GEqDxmRwaqIQ6n+QQQ=; b=
	bkwpQev2nZaK5Sun0+wHNejRhfTHx5rUf57QSxAj8nHTYqtkZzyIjvJabcvPvRxq
	rLlY02APPH5IJauWz4stA9pG64+NWIYLfD7AaegLFYObADH8yZm6g5+gUErK2Mae
	ImaGsoBpYnb/6riyMFAgtB6ufWgpEs7MMP3iGp5qPoS1QOsd6U+TVDDTqY1zmWmS
	LkWilLKWUWoy7nVKlN4HLs83Gn2rVAWzwcEcTjc6WDqx8mTbSTDkEXLliIV+mCMx
	VJA1gVJrF7Hw+gs4JTwubmYSWlC6AAw8Ar3+a5M3nx0Uaq4qQDWBdb77xIXNs2nw
	VnBc0cd3z2l+Op2QUUlUig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760508275; x=
	1760594675; bh=Brw/j4qbMEYFdnrJiw5/P0q16GEqDxmRwaqIQ6n+QQQ=; b=T
	zeHJYo4gPRDUbPnm5/jeIfZ86iJmp/c5HiRsCK5g7Q+tbSHlxWoz77AqrN2sWqDR
	MDhHr1rcUgayn/i4GZrTsPyIl0JUfrEJI0x28PNS9iLnSda5Wwslnz6OtiFBbAyp
	3VvI/GXyXpACiL6UGsvOXx06fXzpPFJScFy/XCpB/yaNl8kNl2j3rhONyNHNTmiy
	zcnMEFCIbpppzboA2dIuFfOZM4+3rFkREnHlGDnuPbuL72ZEoIsw8VX4n4id4Y8+
	uUcibwoz5w2eUOtaNXsqpM4SZOwM3uKyiEN32m70XhFdD4imKeAzwI4sruHz3LN4
	1gYbLWm/nsQdIpOQxetNw==
X-ME-Sender: <xms:cjnvaNhJqdwJ_U7Sx2SCN36v2rdq-sLHNv5xMXd0ur6CpIcicPGVAg>
    <xme:cjnvaBF89f03u6oL-oy9gcOSsKal2tSxbwr2NOJ9tj5QXX4_G8stNo-TY3HDp-G9b
    DR_Fj4p4pkZBCf9jiBC2WeFPA1Oz-MZ5MUB9NBti_6ovsMeODSNXA>
X-ME-Received: <xmr:cjnvaDTXNWBUR5THMVgaHw_tj3rYUrrdZ7Q3Ia59Xc9CT7X8f6vyEbv8krTnb6vjVXo56-wezn4XhkEHocquuw9F2GCJWLUEShdTgvNeRZXh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvrhhitghsuhhnshhh
    ihhnvgesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsrdhtohhrvghksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
    dprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgv
    thdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:cjnvaOx2HkcV65yAXaqxg4RYyx5h_7RQl_WvkZvp6tGxNL_SeYVORQ>
    <xmx:cjnvaPc4nxhbqUFgfHYsfmPXT8MjwziVcZvkYE5Eg8NW-hj6jXN7lw>
    <xmx:cjnvaBMpZR9H8hIoswHWlgrlgIjiTNg8NTwx1I_6WFHKKFCOwGjHRA>
    <xmx:cjnvaKvfQBtsWBmP553fifsERra4c-YVFPVXN9A9Lvs5OIczgspqEg>
    <xmx:cznvaLP0MuONDYFDN1woRYBQa5LsQGXUvkI6IWf8wW0lHkn4aOq3OeLe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 02:04:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a70d1ecb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 15 Oct 2025 06:04:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Oct 2025 08:04:10 +0200
Subject: [PATCH v3 6/6] rust: support for Windows
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-b4-pks-ci-rust-v3-6-13810af33bd5@pks.im>
References: <20251015-b4-pks-ci-rust-v3-0-13810af33bd5@pks.im>
In-Reply-To: <20251015-b4-pks-ci-rust-v3-0-13810af33bd5@pks.im>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Eric Sunshine <ericsunshine@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Chris Torek <chris.torek@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.3

The initial patch series that introduced Rust into the core of Git only
cared about macOS and Linux. This specifically leaves out Windows, which
indeed fails to build right now due to two issues:

  - The Rust runtime requires `GetUserProfileDirectoryW()`, but we don't
    link against "userenv.dll".

  - The path of the Rust library built on Windows is different than on
    most other systems systems.

Fix both of these issues to support Windows.

Note that this commit fixes the Meson-based job in GitHub's CI. Meson
auto-detects the availability of Rust, and as the Windows runner has
Rust installed by default it already enabled Rust support there. But due
to the above issues that job fails consistently.

Install Rust on GitLab CI, as well, to improve test coverage there.

Based-on-patch-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Based-on-patch-by: Ezekiel Newren <ezekielnewren@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml     |  2 +-
 Makefile           | 14 ++++++++++++--
 meson.build        |  4 ++++
 src/cargo-meson.sh | 11 +++++++++--
 4 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a47d839e39..b419a84e2c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -161,7 +161,7 @@ test:mingw64:
     - saas-windows-medium-amd64
   before_script:
     - *windows_before_script
-    - choco install -y git meson ninja
+    - choco install -y git meson ninja rust-ms
     - Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
     - refreshenv
 
diff --git a/Makefile b/Makefile
index 7ea149598d..366fd173e7 100644
--- a/Makefile
+++ b/Makefile
@@ -929,10 +929,17 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 REFTABLE_LIB = reftable/libreftable.a
+
 ifdef DEBUG
-RUST_LIB = target/debug/libgitcore.a
+RUST_TARGET_DIR = target/debug
 else
-RUST_LIB = target/release/libgitcore.a
+RUST_TARGET_DIR = target/release
+endif
+
+ifeq ($(uname_S),Windows)
+RUST_LIB = $(RUST_TARGET_DIR)/gitcore.lib
+else
+RUST_LIB = $(RUST_TARGET_DIR)/libgitcore.a
 endif
 
 # xdiff and reftable libs may in turn depend on what is in libgit.a
@@ -1538,6 +1545,9 @@ ALL_LDFLAGS = $(LDFLAGS) $(LDFLAGS_APPEND)
 ifdef WITH_RUST
 BASIC_CFLAGS += -DWITH_RUST
 GITLIBS += $(RUST_LIB)
+ifeq ($(uname_S),Windows)
+EXTLIBS += -luserenv
+endif
 endif
 
 ifdef SANITIZE
diff --git a/meson.build b/meson.build
index ec55d6a5fd..a9c865b2af 100644
--- a/meson.build
+++ b/meson.build
@@ -1707,6 +1707,10 @@ rust_option = get_option('rust').disable_auto_if(not cargo.found())
 if rust_option.allowed()
   subdir('src')
   libgit_c_args += '-DWITH_RUST'
+
+  if host_machine.system() == 'windows'
+    libgit_dependencies += compiler.find_library('userenv')
+  endif
 else
   libgit_sources += [
     'varint.c',
diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
index 99400986d9..3998db0435 100755
--- a/src/cargo-meson.sh
+++ b/src/cargo-meson.sh
@@ -26,7 +26,14 @@ then
 	exit $RET
 fi
 
-if ! cmp "$BUILD_DIR/$BUILD_TYPE/libgitcore.a" "$BUILD_DIR/libgitcore.a" >/dev/null 2>&1
+case "$(cargo -vV | sed -s 's/^host: \(.*\)$/\1/')" in
+	*-windows-*)
+		LIBNAME=gitcore.lib;;
+	*)
+		LIBNAME=libgitcore.a;;
+esac
+
+if ! cmp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a" >/dev/null 2>&1
 then
-	cp "$BUILD_DIR/$BUILD_TYPE/libgitcore.a" "$BUILD_DIR/libgitcore.a"
+	cp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a"
 fi

-- 
2.51.0.869.ge66316f041.dirty

