Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E671C2EA732
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 06:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781830; cv=none; b=NcrkYm46JMAFf1d3h3mtqOzoIaNnNIedNnd1COvC3FnIeHT64Q1y8BVL1G+z6zQGLSZj4xPXHjNtHFhNvsBDJZ3kSlnv2ZQ2EwBEhQIGuj5Cpxj5oy9naPWx2Sz3DXEasekcuIJy95ej2GML2oeLs8T/gQImxLRLKZwnW4LuXhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781830; c=relaxed/simple;
	bh=Mt2Gb5Ynk69rISfjn5L4Fm2Pr1u6lmkZo1WAQnjFZyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ee+AEs8Vd6aWeTj5ckUctNRbYh/bkxz+UAiugMbu8bn6eiEe00n+Zjyg1HuWPGCzAZmtmiP4dAvZCvKtojzcm3YWhhF3v8tKAQdhG95R/OOwXDnArh9ZgWaUEqezT/Rhhkgw4AEeA3KR3nsjN5AnTl7uVhNIcK8dgBpv4ka55IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EPnqPqkt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TddXs8t3; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EPnqPqkt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TddXs8t3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B951A1D001A3;
	Thu, 25 Sep 2025 02:30:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 25 Sep 2025 02:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758781827;
	 x=1758868227; bh=BsR+UBoKKyK68uZP97lDZH6Li53ud+gsvLdfQ5PH7kk=; b=
	EPnqPqktY2ZIEmzNZqjxGFW920NS5l3hMK/bMM66LliXSsrc1uff8Bo6xLaCxkRE
	w+q3geUacMtia+nW1rINGQSf24sMAdQY/PxTW3VNarv+rLrMgtDwhk9XEBWo/HNJ
	xFJjGgbRSRCTdTjjXfNF0LPN89fTTO30Egl+Dy0yeCuJuUJMpdaUUyCgn+TiDBwf
	x+OWy/IUjKCKDfNFPYLcJrx0T/Xjt+kBzDOUtJP4nNho8UA6wU7b8C9OqfAFQZoT
	PiNNW5+2wgcjtdAJEw1OONfxg+HsNRT8jyczesMbzqqGjlWqnRtID/9iOLiMSepH
	J1aCOlvUt4HOwkY/e2PW2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758781827; x=
	1758868227; bh=BsR+UBoKKyK68uZP97lDZH6Li53ud+gsvLdfQ5PH7kk=; b=T
	ddXs8t374I/C/VyBQR950AIFfezBnz8CNHNxNRqWm0zIqRSN61aBRh7FZ4yq2smH
	tOuBMcJF/B/uCrqxmxMr0muteOHEIO1z6FbfReOIuCjgeqZSb5/8J6rVIK/uk26K
	BVYHDJS6CmSsfap7VDx99LygOlpW/tTtDcL6MyurVlzty5TNKDM2iQclJWW2nCf5
	WYe0yX8Ra1WdSX5PJKrpHwpT0qyKI8/1uqcMzMD2Gdd+XGaCgW9CM8FDW/s+ozqg
	TDOOEXY+1OfNjLl45uLh+UFALK9EXLYEc7loMtH4KPQZ09XTaD+8wOvh2/ahk5Dv
	b05BkA9Brwvf7UVVJmfsA==
X-ME-Sender: <xms:g-HUaBUM4H6-RIyku2r9DC5pvFzotNCIRchSMvNrlFJLjyyeWl95Fg>
    <xme:g-HUaCB2Rt3FNJtAhpMdscxwoUaVr6uuU9LJd9mC9ptbqRo66BKi-uh_1jqE-DN_A
    l0AjWYJlyuoADH0mXbr9tg3wWjXMSYrbOZcou8_JnLEdPbHmiavCg>
X-ME-Received: <xmr:g-HUaNJ7hItRw1eHBVnYypDokc38ERj8Ih6Tg2g9nQiBx1vjhtcQz1OI8n0g7DHJ8ddxuKUNpOqCOUnbrFEMqKZnsPgkz8sHKlSwOH1DSEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopegsvghnrd
    hknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehpihgvrhhrvgdqvghmmhgr
    nhhuvghlrdhprghtrhihsegvmhgsvggtohhsmhdrtghomhdprhgtphhtthhopehphhhilh
    hlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggssedvheei
    sghithdrohhrghdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtg
    homhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshgr
    mhesghgvnhhtohhordhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnug
    gvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:g-HUaAs00QYqOvixsBMLn8M-QbeoqCKg7DMnxDnWLo5AAEVt8a4qhw>
    <xmx:g-HUaFUVpHovsmVViosqIEJogSJgQHYeJd4iwaKn_vlfjfqTTXIn7w>
    <xmx:g-HUaLLSFrfyHTPsHFpcDcCdICDo-moLddSAfYaLyiLgQJm32k5xNw>
    <xmx:g-HUaK8pbSJ85zDaD6zFqHXyYhbrMcMn-_WIrVpQtq-9WLixPn97Hw>
    <xmx:g-HUaINtwJGY_rrXUn_C3dDadRoXNeY26hoDpifF4SAf6yJmY_Js9sQN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 02:30:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e2e03ca4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 25 Sep 2025 06:30:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Sep 2025 08:30:05 +0200
Subject: [PATCH v7 3/9] Makefile: introduce infrastructure to build
 internal Rust library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-b4-pks-rust-breaking-change-v7-3-4e49dcb904d5@pks.im>
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
2.51.0.618.g983fd99d29.dirty

