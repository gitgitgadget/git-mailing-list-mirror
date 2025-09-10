Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CB5255F5E
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518567; cv=none; b=VvKoZsP9GwU7Uh3s6lY+iNtfpDBdTP4YAoTDEzz4ZFNm8p3+MZjhnRjgDv4lDy0b3Pl34hByu11grCcgqUMPoJZCu+b11n0wNYD23BpBm1adwprOKEXsZSPqj87uLbIcPwn8C/sXvGNTD23nrRI1iui4dWi7QcPN0PVfuS/RVzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518567; c=relaxed/simple;
	bh=t4Wc6cWduBuYVOS70k7KFNdeQGTd4EYjfHq5sM5s7Do=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=cEwrINHvu4KQ0rYPE4VXngjWDiblU+VU/TOp50CztJMEE/SyrgO4vd6MU0FLFgsxcaSDHxTUsvLH0ftk3C/e+kTRlwitj9BYHjoASQF8NnENaQypV5Qa/18EeGrNmYiwGkLZn3W2pSleDgCHKLQxsdl0vbylS9lXvH/PfEqNTgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pd8bQQ4b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mtxkKcmt; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pd8bQQ4b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mtxkKcmt"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 20B9AEC0444;
	Wed, 10 Sep 2025 11:36:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 10 Sep 2025 11:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757518561;
	 x=1757604961; bh=7IUijls5NBEOlbDMmfJFl6iktaQg5g2d+CxmHDNJeww=; b=
	Pd8bQQ4baDrVvUURe6qqXCoDGd6U88ccRTQwE3Qrk8zjj5N04XzI17Ze7azH0BiV
	bBp3Vai9QX8fxGYhu7LHPjlWo+N8I0iqWpZIKIXCI75H25SbhJgKOsnTNStUR/Zw
	2asee6tfZtwXYmbS0Nhrsbnhzy/+lHdNuz/WNsOBf/4+aqxCXtTfeOZQ0wHKph0E
	p5gCe7fBA5Z+DPOBfNW2qLKt7vommffgK8YawShPWIxA/MHqMYzodtO4eeJ/Po6O
	AFu6ytJfYgYQKz7sGG8jdhex53FcRfiF5ihxvwyC/rzwXwMJSzABdrUjRP2k3TJJ
	mLFwUPvN3wFcMDmOZKfGdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757518561; x=
	1757604961; bh=7IUijls5NBEOlbDMmfJFl6iktaQg5g2d+CxmHDNJeww=; b=m
	txkKcmtYzteJ9PIOOGFAQTrbPafY/uhL5CAefylllMQcwinpik9SxFZwiMK6sT3p
	bidpLyEhDxvov0MpQqY2Tkr+ETugjO/ox0pU4J2y6EVJV0gr4ppmopFYg40jkEqa
	QjwZoWKsrSxxwMT2b9s2Pv289evNeoj28UnwbE2LQ5E4o0XbAFNUmqP9vW15cAqA
	hxjYWy26ODNjfVHnYAXYZpPT2rZGOqYpNJPsIQdsUi0t2Gz3aH+z1PVagRvLSY4n
	M879Vk6UYGB+C6hSllNHYw2W4UdHVUc+/Np+Tcc6WMDI0bgf0Q9ibIh1fHun7/4d
	ehGhSFPbBO0WKJquAIydA==
X-ME-Sender: <xms:4JrBaKKW5S55wE34h1bnjP6iEN2sbPGcUaSUJyUcwN3mcYkUpIAmbA>
    <xme:4JrBaCRAKtlViD_eVy-ZJ_8PmQ7F68FJ5j9vbf1_26Un8YGOx3_cb6JpK_Omg7PLh
    8NIhPwVh8Xi46WZ2w>
X-ME-Received: <xmr:4JrBaCK8Ak3VDjHpKRV6xth2oidoU-Sn_CXV5EWO1Q55MrDS4eJaysqnQuWPuKHwYPilN2eIYRaBFO2E-YahzqLlPcn7H-02YxK-rf0Ws7k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedu
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhes
    ghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegt
    rhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegvshgthhifrghrth
    iisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprh
    gtphhtthhopehsrghmsehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:4JrBaF9GT9ceyU_Kqn4vUyw1nLkIMuXa--kCKK6ilHjltS6yO_8Nyw>
    <xmx:4JrBaJJ09ULd0t6kmnII227ubH1NfNyhe0kzHUnNXBS_Wblm1xCNNA>
    <xmx:4JrBaEHTALB0ikem3y4RwFuha_uE8EvjS1dt72loCIrjodQaw2bCuA>
    <xmx:4JrBaNzLvP_0fHC0XSxKRwgf5KPOkHKDcpRorhu0-UwFt6FOBJifsw>
    <xmx:4ZrBaFev5E2o38psOZj1lsVu3JF7U9_GCp92-3NykYlMFUxHZyCnbDTk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 11:35:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eac20b40 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 10 Sep 2025 15:35:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH RFC v4 0/9] Introduce Rust and announce that it will become
 mandatory
Date: Wed, 10 Sep 2025 17:35:46 +0200
Message-Id: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANKawWgC/43NywrCMBAF0F8pWRvJo6+4EgQ/wK24SJppG4ptS
 WpQSv/dEETqpri8dy5nZuTAGnDokMzIgjfODH0I6S5BVSv7BrDRISNGWEYESbFK8dg5bB9uwsq
 C7Ezf4M+0oHmhhebAC42CMFqozTPqV3Q5n9AtlK1x02Bf8aOn8fQX7ikmmMuaapYBUSCOYbo39
 4h6toaybYgFKBdcVKpOJVHlD8TXULkN8QDRShe0FDVorr7QsixvG7+M8FoBAAA=
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

Changes in v4:
  - Convert "varint.c" to use explicit integer width so that we don't
    need to use C types in Rust.
  - Adapt Meson to unconditionally use Cargo.
  - Don't use the unstable `--out-dir` option in Cargo. Instead, we
    resort to a wrapper script in Meson.
  - Shorten the timeline a bit to drop the extra step that ties Rust
    support to `-Dbreaking_changes=true`. This accelerates the timeline
    until distros are made forcibly aware of the upcoming changes in
    Rust.
  - Link to v3: https://lore.kernel.org/r/20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (9):
      meson: add infrastructure to build internal Rust library
      Makefile: reorder sources after includes
      Makefile: introduce infrastructure to build internal Rust library
      help: report on whether or not Rust is enabled
      varint: use explicit width for integers
      varint: reimplement as test balloon for Rust
      BreakingChanges: announce Rust becoming mandatory
      ci: convert "pedantic" job into full build with breaking changes
      ci: enable Rust for breaking-changes jobs

 .github/workflows/main.yml         |   4 +-
 .gitignore                         |   2 +
 .gitlab-ci.yml                     |   4 +-
 Cargo.toml                         |   9 ++
 Documentation/BreakingChanges.adoc |  36 +++++++
 Makefile                           | 214 ++++++++++++++++++++++---------------
 ci/install-dependencies.sh         |   8 +-
 ci/run-build-and-tests.sh          |  31 ++----
 dir.c                              |  18 ++--
 help.c                             |   6 ++
 meson.build                        |  15 ++-
 meson_options.txt                  |   2 +
 read-cache.c                       |   6 +-
 shared.mak                         |   1 +
 src/cargo-meson.sh                 |  32 ++++++
 src/lib.rs                         |   1 +
 src/meson.build                    |  41 +++++++
 src/varint.rs                      |  92 ++++++++++++++++
 varint.c                           |   6 +-
 varint.h                           |   4 +-
 20 files changed, 401 insertions(+), 131 deletions(-)

Range-diff versus v3:

 1:  a25408af71 <  -:  ---------- meson: add infrastructure to build internal Rust library
 -:  ---------- >  1:  ccdb7e264d meson: add infrastructure to build internal Rust library
 2:  a9c639b0f3 =  2:  b88c80f7e9 Makefile: reorder sources after includes
 3:  ccac54a247 !  3:  873f9d82f5 Makefile: introduce infrastructure to build internal Rust library
    @@ .gitignore
     @@
      /fuzz_corpora
     +/target/
    ++/Cargo.lock
      /GIT-BUILD-DIR
      /GIT-BUILD-OPTIONS
      /GIT-CFLAGS
 4:  b357ff9463 =  4:  4e70509175 help: report on whether or not Rust is enabled
 -:  ---------- >  5:  bb4cf7cc82 varint: use explicit width for integers
 5:  03a5e2ff68 !  6:  ef7b522b32 rust: implement a test balloon via the "varint" subsystem
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    rust: implement a test balloon via the "varint" subsystem
    +    varint: reimplement as test balloon for Rust
     
         Implement a trivial test balloon for our Rust build infrastructure by
         reimplementing the "varint.c" subsystem in Rust. This subsystem is
    @@ meson.build: libgit_sources = [
        'version.c',
        'versioncmp.c',
        'walker.c',
    -@@ meson.build: rust_option = get_option('rust').disable_auto_if(not rust_available)
    +@@ meson.build: rust_option = get_option('rust').disable_auto_if(not cargo.found())
      if rust_option.allowed()
        subdir('src')
        libgit_c_args += '-DWITH_RUST'
    @@ src/meson.build
     +  'varint.rs',
      ]
      
    - if meson.version().version_compare('>=1.5.0')
    + # Unfortunately we must use a wrapper command to move the output file into the
     
      ## src/varint.rs (new) ##
     @@
    -+use std::os::raw::c_int;
    -+use std::os::raw::c_uchar;
    -+
     +#[no_mangle]
    -+pub unsafe extern "C" fn decode_varint(bufp: *mut *const c_uchar) -> usize {
    ++pub unsafe extern "C" fn decode_varint(bufp: *mut *const u8) -> usize {
     +    let mut buf = *bufp;
     +    let mut c = *buf;
     +    let mut val = usize::from(c & 127);
    @@ src/varint.rs (new)
     +}
     +
     +#[no_mangle]
    -+pub unsafe extern "C" fn encode_varint(value: usize, buf: *mut c_uchar) -> c_int {
    ++pub unsafe extern "C" fn encode_varint(value: usize, buf: *mut u8) -> u8 {
     +    let mut varint: [u8; 16] = [0; 16];
     +    let mut pos = varint.len() - 1;
     +
    @@ src/varint.rs (new)
     +        std::ptr::copy_nonoverlapping(varint.as_ptr().add(pos), buf, varint.len() - pos);
     +    }
     +
    -+    (varint.len() - pos) as c_int
    ++    (varint.len() - pos) as u8
     +}
     +
     +#[cfg(test)]
 6:  c88c614031 !  7:  55ce2bd5b2 BreakingChanges: announce Rust becoming mandatory
    @@ Documentation/BreakingChanges.adoc: A prerequisite for this change is that the e
     +1. Initially, with Git 2.52, support for Rust will be auto-detected by Meson and
     +   disabled in our Makefile so that the project can sort out the initial
     +   infrastructure.
    -+2. In Git 2.53, support for Rust will be enabled by default in case Git is
    -+   compiled with breaking changes. Breaking changes can be enabled for Meson by
    -+   saying `meson configure -Dbreaking_changes=true` and for Makefile-based
    -+   builds via `make WITH_BREAKING_CHANGES=YesPlease`. It will still be possible
    -+   to compile with breaking changes, but explicitly disable Rust.
    -+3. In Git 2.54, both build systems will default-enable support for Rust even
    -+   when breaking changes aren't enabled. Consequently, builds will break by
    -+   default if Rust is not available on the build host. The use of Rust can still
    -+   be explicitly disabled via build flags.
    -+4. In Git 3.0, the build options will be removed and support for Rust is
    ++2. In Git 2.53, both build systems will default-enable support for Rust.
    ++   Consequently, builds will break by default if Rust is not available on the
    ++   build host. The use of Rust can still be explicitly disabled via build
    ++   flags.
    ++3. In Git 3.0, the build options will be removed and support for Rust is
     +   mandatory.
     ++
     +You can explicitly ask both Meson and our Makefile-based system to enable Rust
 7:  d4ef0c752e =  8:  16c5158046 ci: convert "pedantic" job into full build with breaking changes
 8:  d6df25d0c1 !  9:  1831fce645 ci: enable Rust for breaking-changes jobs
    @@ ci/install-dependencies.sh: fedora-*|almalinux-*)
      	esac
      	dnf -yq update >/dev/null &&
     -	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS >/dev/null
    -+	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS rustc >/dev/null
    ++	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS cargo >/dev/null
      	;;
      ubuntu-*|i386/ubuntu-*|debian-*)
      	# Required so that apt doesn't wait for user input on certain packages.

---
base-commit: 2462961280690837670d997bde64bd4ebf8ae66d
change-id: 20250904-b4-pks-rust-breaking-change-7167d9d3e37d

