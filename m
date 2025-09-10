Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9991255F5E
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518571; cv=none; b=SEdkCqFG+B4Z4/I7HuBYdgREmYEm78cY34cAX0avQSseL7Tqof94mpTGBpsMlOHjrxcmiuZ+f7iGNR5ulNaYrS/i1yvtwJf9Oap7gFxFccd7EBMRdlB7BuQiq74giJioCSF4QpnGMTAxhxFcE6Q4hCJtXlLUXi0ejOdKoswVvqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518571; c=relaxed/simple;
	bh=Fh4LCjfrW6SzpP8ckv6nvXx5MXqrIYKb8BQYtrsvJFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTx0tV8j9y+Bxy2DiO/XtYI5zKCydh96XM6KLnp89DLReTwXlykFkxsMtl5zfadHOpEzxP6r7lq3JVTkI1GA8UJShN4dXOmGSvESmd0uW4Zbg4/hMzYhbiAkxW4n8PfwuEJWcoGZ/DPgW2OhHjbU0R8vZR2uySLXX7Xh1RP63Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T3NYkT/N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jnOvRkGp; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T3NYkT/N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jnOvRkGp"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id CE7F8EC0457;
	Wed, 10 Sep 2025 11:36:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 10 Sep 2025 11:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757518568;
	 x=1757604968; bh=QAY/BcgDUgPV+9C3o3OFVMs4jKy3Mlq/dJLo6fuE2Z8=; b=
	T3NYkT/N07YsNTGWaKVZ3sQ25UkaJk3lUiPcWP6IoKsB4TwI3VW39wIBIKGw1fIf
	jVuRCAT2x1vdiIb4oZdwtUAXLK9OZ+aEvnoLUbEuazrXqnK4UsU94+0UWFUwgKQg
	HuFJ0wGezqG5jW7249vd3f6XlB3zBzzXAw5PIZ5EgxNXtPMjRg+VZfjFg37roIVF
	zPrej0AyWBIMviMGuv3fYi7vF3DgftpFImk/Y358EuQXufbHnZh7t292rpP5HCH4
	CMBtbaUupamUSEWY+BU5o1sbNx08KKEQN/IfCU3Es9x5GgN/PgZwJdQ5hx7YrGuB
	ihhd6ZbHlZDAymgl2YVIbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757518568; x=
	1757604968; bh=QAY/BcgDUgPV+9C3o3OFVMs4jKy3Mlq/dJLo6fuE2Z8=; b=j
	nOvRkGpNglrw52u0Q4MObZ1STul8uu/LGwwga3bhxSsLDl4o7e1noUzwfF3MD6FW
	GsLiF8wjB5HKNyHioRq41FtNtZoEZ/N96wOOcfFa9hOOFHnp/03jJXzfSyP7iaZJ
	0mYtJTQLm+tBmdAMHvQJ4jyeUC8VxAsC6pHsv1VDPUkAxrMW1FIWutc1+JD6l+21
	2AH/RdASbPlGsMh0i6ERwb/HnBNfpiwUboqJChBvl32yHOBdsKSP/E/QFrwTe7OQ
	4HMB8wVdstlGnDKVA+3B9AIGam6IU8eaLMNt0MF+T/5hM3IomWFBMRf37/9zIfz3
	1XOyQVXW4AkpoUvQ+hOyQ==
X-ME-Sender: <xms:6JrBaIGQuxzkI2DWRgr9Z2Y5nKpSHxVqR16UHSkt20ShFTtq5aAX8Q>
    <xme:6JrBaBf-VxdrG_wausNTeGMSVXY3p0PLl4sGuJ5FTqb_gRpZGOssPftIxh7aO6Z4l
    uZ4hI0_6qRCc7iNoQ>
X-ME-Received: <xmr:6JrBaJnuKLU8d0URWQROOEYh-l1b2pszZMTinEyRB9t3XjoXsLEo96fZLOeo5ZPwFQA5PsriT0ATcEHLMQaV6F0GeJlIzin65FpdBeR_I2M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopegtsgesvdeh
    iegsihhtrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehpihgvrhhrvgdqvghmmhgrnhhuvghlrdhprghtrhihsegvmhgsvggtohhs
    mhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopegtohhnthgrtghtsehhrggtkhhtihhvihhsrdhmvgdprhgtphhtthhopehmvgesthht
    rgihlhhorhhrrdgtohhmpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:6JrBaAqtnTj1XFbZvXZyr_qjghXOBMmY3k0aPlxevmIbe9i391C_dw>
    <xmx:6JrBaGHNOBGYQiOb0YrcFeMccTd8VWJU9IRSJTeqz5OmHNE427XSuQ>
    <xmx:6JrBaGSdS2WftOZiX-Pe7RYg3O0jE50kH0CoHZM1gqgNTl7CXBKO6A>
    <xmx:6JrBaMNOdBTsZEFA1TrAitbVvfHX-U02hBoAA6QhHLuI5gi38hhbWA>
    <xmx:6JrBaKLAH843j6zOAWe1MjxzvRfx8OtCfhCUbDC_VuZqISMvG3gdSzT_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 11:36:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e860b619 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 10 Sep 2025 15:36:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Sep 2025 17:35:49 +0200
Subject: [PATCH RFC v4 3/9] Makefile: introduce infrastructure to build
 internal Rust library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-b4-pks-rust-breaking-change-v4-3-4a63fc69278d@pks.im>
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

Introduce infrastructure to build the internal Rust library. This
mirrors the infrastructure we have added to Meson in the preceding
commit. Developers can enable the infrastructure by passing the new
`WITH_RUST` build toggle.

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
index 7e52625d75..94950a0ffe 100644
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
+RUST_LIB = target/debug/libgit.a
+else
+RUST_LIB = target/release/libgit.a
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
+	$(RM) -r target/
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
2.51.0.450.g87641ccf93.dirty

