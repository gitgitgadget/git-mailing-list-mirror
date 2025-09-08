Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4913081AC
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340807; cv=none; b=nvtiwAkT8B2MPNPVioQXLdVT8DkZKwfrGPH8SOqENZdAffSXKYk7Ym9LHs3iK5639E2Sz1CMDi5ZbjA8C/G+VWRe9sZfq5WjDSknyM0m0QIipLnIrqtEwM8/5ZWdLSAMNK98IHP8v6eVJf9+xfmCT3OzHZDLXnQ79FmlV+JwPJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340807; c=relaxed/simple;
	bh=vodaw92ibkK//QXrkDWIeaqxaogZdZIoRuPMthTvPcI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Z03QXaBFU9yE7p+kdmNthh05z47bGe2DbbYZ0JG6NinpTdYF4JKGApTXQpTpnrY8CZt7vHPcbjZEXWTOOWQXQJU4fFHlBXKfnl3cPlUKN17IYVFcPechnW2tspJqgv9lM7LDeg4BOO8K27qnKJqdJzBnfjvPveP8nJ/6PFD8eQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OrnCLEpm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XT7mnn1L; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OrnCLEpm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XT7mnn1L"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 09B5514000CE;
	Mon,  8 Sep 2025 10:13:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 08 Sep 2025 10:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757340803;
	 x=1757427203; bh=3jD8CeX/hOE4RohbSTwafbQB0SM0Tvr2u/Loz2gnOHE=; b=
	OrnCLEpmV/XubD72UPNE5G9zVpYLOBjiEPJ1pybZ+YjED+OjFz2r/sm5oGkGJheA
	RPy/RMbsWeVEde68KvcuUNfU7DD85ZuVbd078s4GaO1XALP3at4LiJRY/SVC97Dz
	I3GeGqsm1cs+T6OfThUHRqfwiQHfsQ+FJWlVxQ+KmUpftIhcinOSEWWqinYJYmAu
	QNH4DYj6C4vAePrlyDj90Q7gPSv1JEzo+uimLgOrNrxk1UCB21RrSd1ULdXSCKBY
	pmWd28HrowcxLvNZLDfgGPFavZEPnazd++uTalAvNcjoxxUt3JAaSJMk3mPWI8Ap
	382/ViSzcjZr6/oikjroRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757340803; x=
	1757427203; bh=3jD8CeX/hOE4RohbSTwafbQB0SM0Tvr2u/Loz2gnOHE=; b=X
	T7mnn1Ll/Qg51ySI0MEf/ipP2YgPczdoLQxcoKOIa2EB467AEqiMUqIhmtuiTLWG
	GXHhTvK/ZXW0mkQu40oPZFprKEdempXf6syjnTy0iprUW3US6znFfiIAklJJxQMv
	rI3+EahI+y58h3FyT4jY4/fIbGy7E6tTVzPRhZ0N7uqvFGpqkhM1uo2XMZfS24p4
	XibpamKeMhFsJmziGV0FhfF2MKPg8k7beJRd/x9rBlT7m/BrszQwqrEV/fxQmfm/
	Ry9y6Vkw/3awJnXffLIKPmGiB2c9rjVE+R6mjfFOqCEKboNFsLq8Ipsutj2ZpEyq
	JlTxF0joGlz0smPgvc0oA==
X-ME-Sender: <xms:geS-aCHeH7VGoBzwEuervUA7oi2v-ICjq7p-mY6Rvyo4c2Vl8wiN-g>
    <xme:geS-aNtOxKttnce668QNjF2_n5KMSZ9vC6VZb7Y2PAMeHC8eB9LYsWExWdqHnKBSM
    1aoa6iMdiODkFNRmA>
X-ME-Received: <xmr:geS-aCT1GMpcgybteQlVwbMIT-SGkIYPIZRebN2O_m4jVNThlTyyoWTFnaar08n277i8QmjGRSb1DIpQ4lS5A5SjTKj7_TVFk5EhM5l4StiCBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedu
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homhdprhgtphhtthhopehsrghmsehgvghnthhoohdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheptghonhhtrggttheshhgrtghkthhivhhishdrmhgvpdhrtg
    hpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghs
    tghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:guS-aHPcdclnvpseg__zuCHE2wlhble_2lgD1zsNlxp4fYDJjUhP8g>
    <xmx:guS-aA40bTMLyO4veJoiHgYuigs1qtBIrF0NPDRqKL1GIBsHKhzgfw>
    <xmx:guS-aCUx1lbtHws9fnQNPtaHNmVRM9lbs6aU3ZwDPGKZohG9pyyu3Q>
    <xmx:guS-aPOaWS6mPtB1oAMCvRTxZiJgPzr3IiZ93jsZCFwAp3tCCUlvMg>
    <xmx:guS-aN6x2jsFFfF_8pzK6QAxKOEwQKPaL76AI6lBKuVsMsvpQRS1BVhQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 10:13:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6eba1182 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 14:13:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH RFC v3 0/8] Introduce Rust and announce that it will become
 mandatorty
Date: Mon, 08 Sep 2025 16:13:07 +0200
Message-Id: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHPkvmgC/43NywrCMBAF0F8pWRvJow/jShD8ALfiImmm7VBsS
 1KDUvrvhiDiSlzeO5czC/HgEDzZZwtxENDjOMQgNxmpOz20QNHGTAQTBVMspyanU++pu/uZGge
 6x6Gl72nFy8oqK0FWlkRhctDgI+kXcj4dyTWWHfp5dM/0MfB0+gsPnDIqdcOtKIAZUIc43eIto
 UF8Q8VvSESoVFLVpsk1M7sPtK7rC2q8fK0RAQAA
X-Change-ID: 20250904-b4-pks-rust-breaking-change-7167d9d3e37d
In-Reply-To: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
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

Hi,

this small patch series introduces Rust into the core of Git. This patch
series is designed as a test balloon, similar to how we introduced test
balloons for C99 features in the past. The goal is threefold:

  - Give us some time to experiment with Rust and introduce proper build
    infrastructure.

  - Give distributors time to ease into the new toolchain requirements.
    Introducing Rust is impossible for some platforms and hard for
    others.

  - Announce that Git 3.0 will make Rust a mandatory part of our build
    infrastructure.

The test balloon itself is quite uninteresting: I've chosen to convert
the "varint.c" subsystem, mostly because it is trivial and does not have
any dependencies. But it does allow us to verify that C to Rust interop
works as expected, and to play around with tooling. All tests pass with
the "varint.rs" implementation.

For now, the series only contains support for Meson. If we agree to go
down this route I'll also introduce support for Rust into our Makefiles
at a later point in time.

Furthermore missing is additional tooling:

  - At least one CI job to verify that Rust builds and works as
    expected.

  - Tooling and CI jobs to ensure that we have consistent formatting via
    `cargo format`.

And probably lots more. As said, the entire goal is for us to have an
easy playground that we can experiment on and develop the infrastructure
incrementally without yet having to commit to anything.

I'm mostly splitting out the topic of introducing Rust from the larger
series that introduce it into xdiff so that we can focus more on the
actual process of introducing Rust into Git and less on the potential
features that we want to build on top of it.

Changes in v2:
  - Introduce support for building the Rust library via our Makefile.
  - Introduce a '-DWITH_RUST' define. This define is used to print
    whether or not Git is built with Rust via `git version
    --build-options`.
  - Adjust Meson to not depend on v1.9.0 and newer anymore.
  - Introduce a roadmap into our BreakingChanges document to explain how
    we'll iterate towards mandatory Rust support.
  - Rework the Fedora job to do a full compile-and-test run with Meson
    and breaking changes enabled.
  - Adapt our breaking-changes jobs to enable Rust support.
  - Link to v1: https://lore.kernel.org/r/20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im

Changes in v3:
  - Reorder all uses of `WITH_RUST` after the include of "config.mak".
  - Add a test to verify overflow behaviour in Rust and explicitly use
    `add_wrapping()`.
  - Use explicit dependencies for the Rust library in our Makefile.
  - Fix Alma Linux CI job.
  - Stop tying maintenance of our LTS release to the availability of
    gcc-rs.
  - Add a fallback to Meson to use cargo directly.
  - I've fixed the Rust edition to 2018 for now. This is intentionally
    conservative so that we might be able to use Rust 1.49. For now, we
    don't have any reason to use a newer edition, either. So let's take
    the oldest version we can live with for now and then bump it as
    required.
  - Link to v2: https://lore.kernel.org/r/20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (8):
      meson: add infrastructure to build internal Rust library
      Makefile: reorder sources after includes
      Makefile: introduce infrastructure to build internal Rust library
      help: report on whether or not Rust is enabled
      rust: implement a test balloon via the "varint" subsystem
      BreakingChanges: announce Rust becoming mandatory
      ci: convert "pedantic" job into full build with breaking changes
      ci: enable Rust for breaking-changes jobs

 .github/workflows/main.yml         |   4 +-
 .gitignore                         |   1 +
 .gitlab-ci.yml                     |   4 +-
 Cargo.lock                         |  22 ++++
 Cargo.toml                         |   9 ++
 Documentation/BreakingChanges.adoc |  41 +++++++
 Makefile                           | 214 ++++++++++++++++++++++---------------
 ci/install-dependencies.sh         |   8 +-
 ci/run-build-and-tests.sh          |  31 ++----
 help.c                             |   6 ++
 meson.build                        |  24 ++++-
 meson_options.txt                  |   2 +
 shared.mak                         |   1 +
 src/lib.rs                         |   1 +
 src/meson.build                    |  64 +++++++++++
 src/varint.rs                      |  95 ++++++++++++++++
 16 files changed, 411 insertions(+), 116 deletions(-)

Range-diff versus v2:

1:  3792d2518c < -:  ---------- meson: add infrastructure to build internal Rust library
-:  ---------- > 1:  d995aef28c meson: add infrastructure to build internal Rust library
-:  ---------- > 2:  610e97e435 Makefile: reorder sources after includes
2:  9c3a78cb1e ! 3:  8b6251d4d2 Makefile: introduce infrastructure to build internal Rust library
    @@ .gitignore
     @@
      /fuzz_corpora
     +/target/
    -+/Cargo.lock
      /GIT-BUILD-DIR
      /GIT-BUILD-OPTIONS
      /GIT-CFLAGS
     
    - ## Cargo.toml (new) ##
    -@@
    -+[package]
    -+name = "git"
    -+version = "0.1.0"
    -+edition = "2021"
    -+
    -+[lib]
    -+crate-type = ["staticlib"]
    -+
    -+[dependencies]
    -
      ## Makefile ##
     @@ Makefile: include shared.mak
      # Define LIBPCREDIR=/foo/bar if your PCRE header and library files are
    @@ Makefile: include shared.mak
      # == SHA-1 and SHA-256 defines ==
      #
      # === SHA-1 backend ===
    +@@ Makefile: OBJECTS =
    + OTHER_PROGRAMS =
    + PROGRAM_OBJS =
    + PROGRAMS =
    ++RUST_SOURCES =
    + EXCLUDED_PROGRAMS =
    + SCRIPT_PERL =
    + SCRIPT_PYTHON =
     @@ Makefile: TEST_SHELL_PATH = $(SHELL_PATH)
      LIB_FILE = libgit.a
      XDIFF_LIB = xdiff/lib.a
    @@ Makefile: TEST_SHELL_PATH = $(SHELL_PATH)
     +RUST_LIB = target/release/libgit.a
     +endif
      
    - GENERATED_H += command-list.h
    - GENERATED_H += config-list.h
    -@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    - 
    - UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
    - 
    --# xdiff and reftable libs may in turn depend on what is in libgit.a
    --GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
    -+GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
    -+ifdef WITH_RUST
    -+GITLIBS += $(RUST_LIB)
    -+endif
    -+# Other libs may in turn depend on what is in libgit.a.
    -+GITLIBS += $(LIB_FILE)
    - EXTLIBS =
    - 
    - GIT_USER_AGENT = git/$(GIT_VERSION)
    + # xdiff and reftable libs may in turn depend on what is in libgit.a
    + GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
     @@ Makefile: BASIC_LDFLAGS =
      ARFLAGS = rcs
      PTHREAD_CFLAGS =
    @@ Makefile: BASIC_LDFLAGS =
     +CARGO_ARGS += --release
     +endif
     +
    + # For the 'sparse' target
    + SPARSE_FLAGS ?= -std=gnu99 -D__STDC_NO_VLA__
    + SP_EXTRA_FLAGS =
    +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    + 
    + UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
    + 
    ++RUST_SOURCES += src/lib.rs
    ++
    + GIT-VERSION-FILE: FORCE
    + 	@OLD=$$(cat $@ 2>/dev/null || :) && \
    + 	$(call version_gen,"$(shell pwd)",GIT-VERSION-FILE.in,$@) && \
    +@@ Makefile: endif
    + ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS) $(CFLAGS_APPEND)
    + ALL_LDFLAGS = $(LDFLAGS) $(LDFLAGS_APPEND)
    + 
     +ifdef WITH_RUST
     +BASIC_CFLAGS += -DWITH_RUST
    ++GITLIBS += $(RUST_LIB)
     +endif
     +
    - # For the 'sparse' target
    - SPARSE_FLAGS ?= -std=gnu99 -D__STDC_NO_VLA__
    - SP_EXTRA_FLAGS =
    + ifdef SANITIZE
    + SANITIZERS := $(foreach flag,$(subst $(comma),$(space),$(SANITIZE)),$(flag))
    + BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
     @@ Makefile: scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
      $(LIB_FILE): $(LIB_OBJS)
      	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
      
    -+$(RUST_LIB): FORCE
    -+	@OLD_STAT="$$(stat $@ 2>/dev/null)"; \
    -+	    cargo build $(CARGO_ARGS); \
    -+	    if test $$? != 0 || test x"$$OLD_STAT" != x"$$(stat $@ 2>/dev/null)"; then \
    -+		echo '   ' CARGO $@; \
    -+	    fi
    ++$(RUST_LIB): Cargo.toml $(RUST_SOURCES)
    ++	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
     +
     +.PHONY: rust
     +rust: $(RUST_LIB)
    @@ Makefile: clean: profile-clean coverage-clean cocciclean
      	$(RM) $(FUZZ_PROGRAMS)
      	$(RM) $(SP_OBJ)
      	$(RM) $(HCC)
    -+	$(RM) -r target/ Cargo.lock
    ++	$(RM) -r target/
      	$(RM) version-def.h
      	$(RM) -r $(dep_dirs) $(compdb_dir) compile_commands.json
      	$(RM) $(test_bindir_programs)
    +
    + ## shared.mak ##
    +@@ shared.mak: ifndef V
    + 	QUIET_MKDIR_P_PARENT  = @echo '   ' MKDIR -p $(@D);
    + 
    + ## Used in "Makefile"
    ++	QUIET_CARGO    = @echo '   ' CARGO $@;
    + 	QUIET_CC       = @echo '   ' CC $@;
    + 	QUIET_AR       = @echo '   ' AR $@;
    + 	QUIET_LINK     = @echo '   ' LINK $@;
3:  d83c8c2b14 = 4:  0335ff2303 help: report on whether or not Rust is enabled
4:  f9dd2ecb73 ! 5:  318212c5c9 rust: implement a test balloon via the "varint" subsystem
    @@ Makefile: LIB_OBJS += urlmatch.o
      LIB_OBJS += version.o
      LIB_OBJS += versioncmp.o
      LIB_OBJS += walker.o
    +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    + UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
    + 
    + RUST_SOURCES += src/lib.rs
    ++RUST_SOURCES += src/varint.rs
    + 
    + GIT-VERSION-FILE: FORCE
    + 	@OLD=$$(cat $@ 2>/dev/null || :) && \
     
      ## meson.build ##
     @@ meson.build: libgit_sources = [
    @@ src/lib.rs
     
      ## src/meson.build ##
     @@
    - libgit_rs = static_library('git_rs',
    -   sources: [
    -     'lib.rs',
    -+    'varint.rs',
    -   ],
    -   rust_crate_type: 'staticlib',
    - )
    + libgit_rs_sources = [
    +   'lib.rs',
    ++  'varint.rs',
    + ]
    + 
    + if meson.version().version_compare('>=1.5.0')
     
      ## src/varint.rs (new) ##
     @@
    @@ src/varint.rs (new)
     +    buf = buf.add(1);
     +
     +    while (c & 128) != 0 {
    -+        val += 1;
    ++        val = val.wrapping_add(1);
     +        if val == 0 || val.leading_zeros() < 7 {
     +            return 0; // overflow
     +        }
    @@ src/varint.rs (new)
     +            assert_eq!(decode_varint(&mut [0x80, 0x00].as_slice().as_ptr()), 128);
     +            assert_eq!(decode_varint(&mut [0x80, 0x01].as_slice().as_ptr()), 129);
     +            assert_eq!(decode_varint(&mut [0x80, 0x7f].as_slice().as_ptr()), 255);
    ++
    ++            // Overflows are expected to return 0.
    ++            assert_eq!(decode_varint(&mut [0x88; 16].as_slice().as_ptr()), 0);
     +        }
     +    }
     +
5:  5d411a195f ! 6:  a540626932 BreakingChanges: announce Rust becoming mandatory
    @@ Commit message
         Rust is a major change though and has ramifications for the whole
         ecosystem:
     
    -      - Some platforms haven't yet been able to implement a Rust toolchain,
    -        even though it is possible in theory.
    +      - Some platforms have a Rust toolchain available, but have not yet
    +        integrated it into their build infrastructure.
     
           - Some platforms don't have any support for Rust at all.
     
    @@ Documentation/BreakingChanges.adoc: A prerequisite for this change is that the e
      JGit, libgit2 and Gitoxide need to support it.
      
     +* Git will require Rust as a mandatory part of the build process. While Git
    -+  already started to adopt Rust in the Git 2.52, all parts written in Rust are
    ++  already started to adopt Rust in Git 2.52, all parts written in Rust are
     +  optional for the time being. This includes:
     ++
     +  ** Subsystems that have an alternative implementation in Rust to test
    @@ Documentation/BreakingChanges.adoc: A prerequisite for this change is that the e
     +for Rust becoming a mandatory part of the build process. There will be multiple
     +milestones for the introduction of Rust:
     ++
    -+1. Initially, with Git 2.52, support for Rust will be auto-detected by Rust and
    ++1. Initially, with Git 2.52, support for Rust will be auto-detected by Meson and
     +   disabled in our Makefile so that the project can sort out the initial
     +   infrastructure.
    -+2. In Git 2.53, support for Rust will be made mandatory in case Git is compiled
    -+   with breaking changes. Breaking changes can be enabled for Meson by saying
    -+   `meson configure -Dbreaking_changes=true` and for Makefiles via `make
    -+   WITH_BREAKING_CHANGES=YesPlease`. It will still be possible to compile with
    -+   breaking changes, but explicitly disable Rust.
    -+3. In Git 2.54, both build systems will default-enable support for Rust so that
    -+   builds will break if Rust is not available on the build host. The use of Rust
    -+   can still be explicitly disabled via build flags.
    ++2. In Git 2.53, support for Rust will be enabled by default in case Git is
    ++   compiled with breaking changes. Breaking changes can be enabled for Meson by
    ++   saying `meson configure -Dbreaking_changes=true` and for Makefile-based
    ++   builds via `make WITH_BREAKING_CHANGES=YesPlease`. It will still be possible
    ++   to compile with breaking changes, but explicitly disable Rust.
    ++3. In Git 2.54, both build systems will default-enable support for Rust even
    ++   when breaking changes aren't enabled. Consequently, builds will break by
    ++   default if Rust is not available on the build host. The use of Rust can still
    ++   be explicitly disabled via build flags.
     +4. In Git 3.0, the build options will be removed and support for Rust is
     +   mandatory.
     ++
    @@ Documentation/BreakingChanges.adoc: A prerequisite for this change is that the e
     +respectively.
     ++
     +The Git project will declare the last version before Git 3.0 to be a long-term
    -+support release that is maintained until alternate Rust backends like gcc-rs are
    -+able to build Git. The Git project may need to rely on distributions to help
    -+with identifying and backporting important bugfixes.
    ++support release. This long-term release will receive important bug fixes for at
    ++least four release cycles and security fixes for six release cycles. The Git
    ++project will hand over maintainership of the long-term release to distributors
    ++in case they need to extend the life of that long-term release even further. In
    ++that case, the backporting process will be handled by these distributors, but
    ++the backported patches will be reviewed on the mailing list and pulled in by the
    ++Git maintainer.
     +
      === Removals
      
6:  210225628a ! 7:  d4459e0294 ci: convert "pedantic" job into full build with breaking changes
    @@ .gitlab-ci.yml: test:linux:
     
      ## ci/install-dependencies.sh ##
     @@ ci/install-dependencies.sh: alpine-*)
    + 		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty >/dev/null
      	;;
      fedora-*|almalinux-*)
    ++	case "$jobname" in
    ++	*-meson)
    ++		MESON_DEPS="meson ninja";;
    ++	esac
      	dnf -yq update >/dev/null &&
     -	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
    -+	dnf -yq install shadow-utils sudo meson ninja pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
    ++	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS >/dev/null
      	;;
      ubuntu-*|i386/ubuntu-*|debian-*)
      	# Required so that apt doesn't wait for user input on certain packages.
7:  e6cc22407f ! 8:  5893f85cee ci: enable Rust for breaking-changes jobs
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## ci/install-dependencies.sh ##
    -@@ ci/install-dependencies.sh: alpine-*)
    - 	;;
    - fedora-*|almalinux-*)
    +@@ ci/install-dependencies.sh: fedora-*|almalinux-*)
    + 		MESON_DEPS="meson ninja";;
    + 	esac
      	dnf -yq update >/dev/null &&
    --	dnf -yq install shadow-utils sudo meson ninja pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
    -+	dnf -yq install shadow-utils sudo meson ninja pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel rustc >/dev/null
    +-	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS >/dev/null
    ++	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS rustc >/dev/null
      	;;
      ubuntu-*|i386/ubuntu-*|debian-*)
      	# Required so that apt doesn't wait for user input on certain packages.

---
base-commit: 2462961280690837670d997bde64bd4ebf8ae66d
change-id: 20250904-b4-pks-rust-breaking-change-7167d9d3e37d

