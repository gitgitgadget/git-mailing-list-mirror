Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A132320CBA
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620743; cv=none; b=hsDoXEj3UtnIJ7hVH0khros2NIOx6AFzxfYrs/fQd74sGImUjj0sloJyza69kPGXcwq8SyiiBHNnqDYwIc4XS7KIj+G5fa0Vrv/DIjdhfwunfJ8iwVrZi4CGeKMqziEp5+OVvwqzJ0bZEf7tmvsWnCnvTvGQ7UWlLC4rthbWOQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620743; c=relaxed/simple;
	bh=/+MhOpT4f28spew1T57jnD1B19oxPQulhyTGHteFDtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bBUB9hS87zeM84eD94gcV/R2wuVAj8t23V3ceCjtIPCHwSu15dU1DAmsvGcCPtO5oEIEeVf7dQWWez3F8d9fVRIEQSdl17yAL844Z9/E3+fYEieey69td63PbGvqdSznk0LlInZEtQA45TODY8VAVbIEMMjVaqWGFqEhZ3JfGJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BWhgLZYV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JeAOkhUE; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BWhgLZYV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JeAOkhUE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 29FD87A02C3;
	Tue, 23 Sep 2025 05:45:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 23 Sep 2025 05:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758620740;
	 x=1758707140; bh=oqQOiEKt+VR0fYpZCrxlAjYm11ucPOmBv/1t9qRkOpI=; b=
	BWhgLZYV5+2RpwdfUj8YhfiztO/t3+HwEseGXQHOW/Sy7M/T9aBIW/GoFLCJSRNb
	YlLzykwhyLJ5oNRG+fgoEI1Wc5Mfa/qb74r18tikzhSVMIRjl+iWyf33frdtTwJl
	9E1AqrWV9Q6Ep+MR4qG7KKyLMNMlahfqLWiZt7kDqtTdkyHK20DUP8kKggk6879n
	YrExhrC7GCVlNd45uNJOR7b1NxaisZSUmcCRnGkivSBzyF50cNU8p2gbC8XYUVhJ
	lWr7sIaMTie/82b7fGFSYkzsLz5LMmictoAnq4Pf5Nc2WXrXdG0J/YqGu0RGoy0v
	E0bS4Hm4LQDddKjQMUctdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758620740; x=
	1758707140; bh=oqQOiEKt+VR0fYpZCrxlAjYm11ucPOmBv/1t9qRkOpI=; b=J
	eAOkhUEoiIrirfY1DDejfljWlJkZRRgVLSyCyXLkBeg4VL+YVNBlbcACZIleJoRK
	E+wGhAUmN9lUhn3YnoGYpKdGM4CbolgCG5W3KY4rORwuw5AuM/n9YOriVNEZC5Ln
	aXAsLOt9uu6cy32QmbIX5xa91YebCy9LAiwRLXwRIRn3UAhnj0Ha6Cm9Y11p3Oj0
	TbZpzT9rv1ouu2KZs2Mz9H3CTZ3HxAj+MuttsoTCDc7Vc8szXf4TwURRgHiOP7CL
	px64t9jYm0ZNogOBJDWmRLK/Vkzxck4fLYR29REPnjZlhQgGpneto0oDi6vNjHTy
	AsYVXE6LPWVn4hG+mKbYw==
X-ME-Sender: <xms:Q2zSaH5NpMEfrjie2Ct18-YSvriAcaOJ3Q_7ddcxo2qmiCNfqgo4Ww>
    <xme:Q2zSaNWlZvhusJX674LzgMCZCmZ1jSGGesxDTPn7MjR-WGqJ6Dfqi2r0z0a3FYB6A
    h2urN1C3h4xlcMxfHbo5vDeT4dEwCLxb3TKs8F6GcGavEpMI_UR>
X-ME-Received: <xmr:Q2zSaONp8fOZIXDq7_G30PDpyrG0zAZrIf4WmbYv3SU8vO6RvEufBSco6zmHld3LdI_EPvFcrZo9ck1kwDL59MkjvP5fuILkBwPZ6q2AEeaj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegtohhnthgrtghtsehhrggtkhhtihhvihhsrdhmvgdprhgtphhtthhopegtsgesvd
    ehiegsihhtrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdgu
    vgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsh
    grnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohep
    vghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepshgrmhesghgvnh
    htohhordhorhhg
X-ME-Proxy: <xmx:Q2zSaEjXwZCqQ54Jn4FAefOTjXBS12YKHv48YxP3JLArhZXAIy8C9w>
    <xmx:Q2zSaE5k_sqPk4v--ec357WKc59GLWoawKWKPfNnMLxR3Mk8ZFJpSw>
    <xmx:Q2zSaLcoCsxInEQBaewPBaQSthv0yCaTCvNkm4VlrjtL00KkEYahRg>
    <xmx:Q2zSaNBH7U989D56t4LOt2HEA4sd_ERKrMU3YLXUbO1Jrz8UCwapug>
    <xmx:Q2zSaFxdGWEkEqfVoDV_KQRn4CCvn5dkYl63wlYeTjlspzPppxnzFASs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 05:45:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f18d6872 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 09:45:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 23 Sep 2025 11:45:22 +0200
Subject: [PATCH v6 3/9] Makefile: introduce infrastructure to build
 internal Rust library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-b4-pks-rust-breaking-change-v6-3-59076fee486a@pks.im>
References: <20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im>
In-Reply-To: <20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im>
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
index 7e52625d75..e8518198fc 100644
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
2.51.0.536.g15c5d4f767.dirty

