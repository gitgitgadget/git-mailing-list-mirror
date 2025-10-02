Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81FA2D4B5E
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390246; cv=none; b=oFQtLd+99XL6tfUn29ODukDGcdEWVcU0fwu0fyE+1MChWeSw6CHeRILXjHTwHCFGSFVyCZWaeACX82KqZfE49BiHO+2S5JU9/dGmFcCV3jRR4I62RUA7HWk+C88UhvZZOzvcRyHUXPKwlwmBlTPEE2bdPRMwhF/Lf94kiAGuwdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390246; c=relaxed/simple;
	bh=7OmDqq13sJtmMH4vaTxBAGGDNHkDMZsopEFxQ1bTGAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b4pznbtpYRApatOx/xrvO1ahuMoWcJrrVLf1HLh1RakdXA8ll51ps8NlM1aC1byde1dNzQm0vH1tzsWa67UDbOc0u9eyrmvO3kVeGZm/GrlvItlNtlBH9anBAYifbztcHsXdizZqSH6+ja7Ez5U3B2mxcqa4++RFK1hoGfNhF+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eiO23Ytt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xc12v5aU; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eiO23Ytt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xc12v5aU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D58AE7A0146;
	Thu,  2 Oct 2025 03:30:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 02 Oct 2025 03:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759390243;
	 x=1759476643; bh=wKtHmehtimNv6cWbY0PPQ4G9KiYsw6EF0/9hOx+GGLM=; b=
	eiO23YttTLfbnABpzBuz+E9paNJ1McYtXcmvQEROntCMWUkTQWWRC8TsBMlSq3Lb
	+ZZdtIFRQXUYV5CEmUu+Q8Fw3JMM6bjPlB0howY1H+3O+Ej8dPfEik6zWNj+1t7A
	oCoXe+2/jC3nE9ZpQc8dphVsIXLd7RDQb3YGQadCUHT3cc7xDiYYGIVHjHi80oZv
	gHVyuL3n+YRnEdcjN8gO/TYfOnLVIi8Kq4rqu2qEiGTnrKMaMIFw3bakXzXUDYvP
	yGBTb2OEXpIspZV3m57dbTQA7mom8WfhigXqGYTj+E0YSmzVswoV4DjJV+3Zc94y
	dG5U4lpUUgPS/0wfO8Nt2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759390243; x=
	1759476643; bh=wKtHmehtimNv6cWbY0PPQ4G9KiYsw6EF0/9hOx+GGLM=; b=x
	c12v5aUKNJh8mgu8/jJe9Md5r0LQQVbJSWVUuCbeBXXSwJDfZ4OHzMwYui26jIHd
	3u3gH5RmrHoZVQ6ydabh5T3eayc5XdIaL6C6oll8jEYgHqISiDfAbu6hJ6UeuTvb
	jk6ERpFR7CCdfR70t3hDFuC9PY7NZfQXLiDEVqn8viH68qxay2Xmmb0BycOycFSv
	tRz+nDq6Sh4yS83RRuXS/KI87P/pLXBu9fpgD3w3yNBiYRfQE9E4ysxWwf5yYrhG
	P2eedr6gMYpITNtcjSlzuVQEbl9EgAh+JIy06Y4lwKoKRaBC8FJbk7XziLOy6yGJ
	Ly2tseOoYYxO0qpq/5X5w==
X-ME-Sender: <xms:IyreaEvUYX2B7gn6aU9q8TdrVNaD5T-XhSCpiT_Xt78b3GIfc-PYjQ>
    <xme:IyreaB45MTraqAuUYMk5si7rvZUs88IuefpVsIgT7bS_--CpzhYf_52Ro4trWTf13
    DjWmNDZ7MCW7QQ-0IxZFhm1zy9mFNOhAwi0XV1ADLolBR-pAu6tBg>
X-ME-Received: <xmr:IyreaPi10QyFvh_y3WNM3BZj16LnTQdo2Bu7Noq9SnsHzhIB3-ZIqr7OQMjrO5KYo0lAVxZScqX3x-GyuBCWluHWyd96CgPOe9a4cZLtwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhi
    nhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphhivghrrhgvqdgvmhhmrghnuhgvlhdrphgrthhrhies
    vghmsggvtghoshhmrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghr
    uhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoheptgholhhlihhnrdhfuh
    hnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:IyreaDka-QXr2WorjpIVRvrIOSFlOO4TKBfDJ6Q_B7BCbD0yKqAxbg>
    <xmx:IyreaOtq1g2givkzcKTJOnQlf37D_y7ZSV5g6f0m0oPH-YuvlB-Q_w>
    <xmx:IyreaJAHspbztt-lezTJSbGpiEuHBXjbz-lSqmahXRPyGMfOEhEVew>
    <xmx:IyreaDUgqgl5TAyuuNrY5J6AsySwPeeyd0V5X4K5Y3F9xuN9WNJ2Ug>
    <xmx:IyreaNr7j98_7HUWZDgf85G7CoZKKmX_zZqPayGbQRPeIR_NOdTcwUst>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 03:30:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b41df6aa (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 07:30:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Oct 2025 09:29:28 +0200
Subject: [PATCH v8 3/9] Makefile: introduce infrastructure to build
 internal Rust library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-b4-pks-rust-breaking-change-v8-3-3a89fd5b1ce7@pks.im>
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

Introduce infrastructure to build the internal Rust library. This
mirrors the infrastructure we have added to Meson in the preceding
commit. Developers can enable the infrastructure by passing the new
`WITH_RUST` build toggle.

Inspired-by: Ezekiel Newren <ezekielnewren@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitignore |  2 ++
 Makefile   | 37 +++++++++++++++++++++++++++++++++++++
 shared.mak |  1 +
 3 files changed, 40 insertions(+)

diff --git a/.gitignore b/.gitignore
index 1803023427..0833453cf6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,4 +1,6 @@
 /fuzz_corpora
+/target/
+/Cargo.lock
 /GIT-BUILD-DIR
 /GIT-BUILD-OPTIONS
 /GIT-CFLAGS
diff --git a/Makefile b/Makefile
index 7e52625d75..31e79342e1 100644
--- a/Makefile
+++ b/Makefile
@@ -483,6 +483,14 @@ include shared.mak
 # Define LIBPCREDIR=/foo/bar if your PCRE header and library files are
 # in /foo/bar/include and /foo/bar/lib directories.
 #
+# == Optional Rust support ==
+#
+# Define WITH_RUST if you want to include features and subsystems written in
+# Rust into Git. For now, Rust is still an optional feature of the build
+# process. With Git 3.0 though, Rust will always be enabled.
+#
+# Building Rust code requires Cargo.
+#
 # == SHA-1 and SHA-256 defines ==
 #
 # === SHA-1 backend ===
@@ -683,6 +691,7 @@ OBJECTS =
 OTHER_PROGRAMS =
 PROGRAM_OBJS =
 PROGRAMS =
+RUST_SOURCES =
 EXCLUDED_PROGRAMS =
 SCRIPT_PERL =
 SCRIPT_PYTHON =
@@ -918,6 +927,11 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 REFTABLE_LIB = reftable/libreftable.a
+ifdef DEBUG
+RUST_LIB = target/debug/libgitcore.a
+else
+RUST_LIB = target/release/libgitcore.a
+endif
 
 # xdiff and reftable libs may in turn depend on what is in libgit.a
 GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
@@ -943,6 +957,15 @@ BASIC_LDFLAGS =
 ARFLAGS = rcs
 PTHREAD_CFLAGS =
 
+# Rust flags
+CARGO_ARGS =
+ifndef V
+CARGO_ARGS += --quiet
+endif
+ifndef DEBUG
+CARGO_ARGS += --release
+endif
+
 # For the 'sparse' target
 SPARSE_FLAGS ?= -std=gnu99 -D__STDC_NO_VLA__
 SP_EXTRA_FLAGS =
@@ -1475,6 +1498,8 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 
+RUST_SOURCES += src/lib.rs
+
 GIT-VERSION-FILE: FORCE
 	@OLD=$$(cat $@ 2>/dev/null || :) && \
 	$(call version_gen,"$(shell pwd)",GIT-VERSION-FILE.in,$@) && \
@@ -1504,6 +1529,11 @@ endif
 ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS) $(CFLAGS_APPEND)
 ALL_LDFLAGS = $(LDFLAGS) $(LDFLAGS_APPEND)
 
+ifdef WITH_RUST
+BASIC_CFLAGS += -DWITH_RUST
+GITLIBS += $(RUST_LIB)
+endif
+
 ifdef SANITIZE
 SANITIZERS := $(foreach flag,$(subst $(comma),$(space),$(SANITIZE)),$(flag))
 BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
@@ -2918,6 +2948,12 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
+$(RUST_LIB): Cargo.toml $(RUST_SOURCES)
+	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
+
+.PHONY: rust
+rust: $(RUST_LIB)
+
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
@@ -3768,6 +3804,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(FUZZ_PROGRAMS)
 	$(RM) $(SP_OBJ)
 	$(RM) $(HCC)
+	$(RM) -r Cargo.lock target/
 	$(RM) version-def.h
 	$(RM) -r $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) $(test_bindir_programs)
diff --git a/shared.mak b/shared.mak
index 5c7bc94785..0e7492076e 100644
--- a/shared.mak
+++ b/shared.mak
@@ -56,6 +56,7 @@ ifndef V
 	QUIET_MKDIR_P_PARENT  = @echo '   ' MKDIR -p $(@D);
 
 ## Used in "Makefile"
+	QUIET_CARGO    = @echo '   ' CARGO $@;
 	QUIET_CC       = @echo '   ' CC $@;
 	QUIET_AR       = @echo '   ' AR $@;
 	QUIET_LINK     = @echo '   ' LINK $@;

-- 
2.51.0.700.g236ee7b076.dirty

