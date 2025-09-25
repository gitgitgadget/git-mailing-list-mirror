Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEE52EA48D
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 06:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781821; cv=none; b=BQajJAboQ7QK+gNrpapIX+SiDlifFWysmhCzFGenloyMDyphcXHM7I0X3E1RdrA5+nrG7kAqBCmnyeGdqWtPv9WDudyhNbTIp2P7o4ZIRCHPufZ/xzpBD9WCgUbn+H4ekmupkzmBXTXsOSwx7qNfZm1JGadTzHytonvg2rTrL4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781821; c=relaxed/simple;
	bh=34L7j1PjV8J37ogGzIFDH+XtQ28o7YbKGiR1PGJUpbM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=bFhVW/y0wI4fzI1GKHz4Aqk9IB+hiD/DjjLKCeu8BHUx8P9xWYUk0Xdl2Febk5pCvfXcsNRvHz2gVuyPlWf247ImUnz/Y+ZM/ZNZ5VBLDi2m5bYFygz5dD+W4bNaU/UfohmZR9sM6rbaoFzqXCxjQhzSAmlMUgAUOpRXVUeoATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FTtlSQcp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ItjBPj3z; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FTtlSQcp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ItjBPj3z"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C412EC0227;
	Thu, 25 Sep 2025 02:30:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 25 Sep 2025 02:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758781818;
	 x=1758868218; bh=wq+y1prPzgXZ25sFNjLmP7x0XJ2GK9e7p4HgJBSYIC0=; b=
	FTtlSQcp5ZOkHpBbOahGzFkKOywQCk00XuBP8buHga9cEqqzJO+CwCpw0EmoQ3Cu
	iQ6vj4ary4PD5idqC6DsuOycSpJMKHK/EPnYDt/VPCPccmBv7XjKTzUIEpVkmUIF
	zTr6DrhuMofosZ2G0qujvsk883sXFTZSPjcWzX+z8SCE1fABBtZdD3kGYT6DGzQt
	gjeNNBcfj3A+ngMTPkQVrXosHzNHqEthU8rwKQMyzc2eCGRHyCEOyC+7dWG4CEf8
	D3/LWG4BdpW8KHKWhCZkruaMpQcWVJgxRwYtMGceHrOYx3sKV4emUteIKPAqnCPH
	oRtehLbJFN+CHNWC2JJACw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758781818; x=
	1758868218; bh=wq+y1prPzgXZ25sFNjLmP7x0XJ2GK9e7p4HgJBSYIC0=; b=I
	tjBPj3z+LBqARw9P+uahV48wXyh5OXyKTl09AJo07VW+/5uUwFMy3HJ/kgCd5SXO
	UoH68ZDQjFQQ2Ai/GJ19fqnRtduNSKZjaE5JF2YCfIEYIvdfPGREL5iE+U+FBD1B
	BnvV3Ah825XSd9juQbuXZWZnxz11j1D8Fyj4UBxxSK+UX/QVii90+Q1kYtg9R41X
	6Fp02VFOFCbCleCz+Ppt3M2kU4lAwFYd2YAquXQxN/74v31SIXEIzxwZ/nzWQHRL
	BIFicwVpgANlGQqvNOwSbX0C/DbUidamiWHc54tolE3ROEu2DTggl+dD+QnRVUaf
	eC9bDPm2XyP/faBvEPHBA==
X-ME-Sender: <xms:eOHUaPGb4qO-PB9J2bSDe3cOatMrbXFm8XncKnDKfz7qUbsDRUFTkA>
    <xme:eOHUaMxebVPm44KZppCp8cM3zkfaN-hKhYZN4bAokXpLleWjc9_u_I_iQcrpDhGOw
    _YqjoZUWDc7kUROG5_p6H08E_7IoLeuQ5PpVuKHxzwBhWLnEoms4wI>
X-ME-Received: <xmr:eOHUaA4VsHXgm-JOfwG-aFMrT89CLIdKJBB5z5w8Osr3ECAoXE5Eni0yY7h8LL9BFFzzBd4c5beEhe_LoiEAi7VhzQ-XCO2BIICrgfmZ1gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedu
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    tggssedvheeisghithdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvd
    efsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:eOHUaJdaXTLHOZQMPyCd__HCZafRJoKUlAA1HmHBOsh-e4u43CZWdA>
    <xmx:eOHUaPFGAuGTblg3dWB9M6QOp-tbxveUq128-dGHpbCFUXEnvlbk9A>
    <xmx:eOHUaB4alPFu2la9mb-1lSYBhdm2fnlXCQA4El3-rKTisKcXsoxdwg>
    <xmx:eOHUaKuafxcGBYEHn1CqmdnNYIo3RD18EwtdIEt-5HAMOIZQszswsg>
    <xmx:euHUaFDfHjAw7ercjN3zkivO82Sc0XGW-LI_D8S7FOFHb_nyWHLLMEhP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 02:30:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 231fedc2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 25 Sep 2025 06:30:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v7 0/9] Introduce Rust and announce that it will become
 mandatory
Date: Thu, 25 Sep 2025 08:30:02 +0200
Message-Id: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGrh1GgC/43PzUoDMRQF4FcpWRtJcvPble8hLvJz04bitCR1U
 Mq8u2kRyWxGl+dy+A73RhrWgo3sdzdScS6tnKcezNOOxKOfDkhL6pkIJhRzTNIg6eXUaP1oVxo
 q+lOZDvSnarg2ySVAMIl04VIxl8+H/vrW87G067l+PcZmfr/+z505ZRR85kkoZAHdS68+l3dyR
 2cxQmobEh3SDlwMWXoW7AqCEbLbEHSIx2S4dRkThBUkB4izbUh2SHoNOWonjE0rSI3QH6+pDqU
 IHkQOQXC9gvQACdiGdIeUY0ZnRGm1/4WWZfkG5hrRUjACAAA=
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
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
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

Changes in v5:
  - Fix indentation in the BreakingChanges document.
  - Fix a commit message typo.
  - Include "Cargo.lock" in the `make clean` target again.
  - Link to v4: https://lore.kernel.org/r/20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im

Changes in v6:
  - Give attribution to Ezekiel for kickstarting the Rust adoption
    again. I'm happy to change how I do the attribution.
  - Fix "varint.rs" to use `u64` instead of `usize`. Issues like these
    will eventually be catched by cbindgen.
  - Adapt the breaking changes document to mention that we already have
    Rust in our tree starting with Git 2.49.
  - Mention that we won't blindly make Rust mandatory, but consider the
    impact on downstream distributions.
  - Slightly reword how we'll handle LTS maintainership. This probably
    still is an ongoing discussion.
  - Link to v5: https://lore.kernel.org/r/20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im

Changes in v7:
  - Rename "git" crate to "gitcore".
  - Some word smithing for the breaking changes doc.
  - Punt on the exact details of how we hand over maintenance of the LTS
    release to the community. This is something we can decide on in the
    future.
  - Link to v6: https://lore.kernel.org/r/20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im

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
 Documentation/BreakingChanges.adoc |  45 ++++++++
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
 20 files changed, 410 insertions(+), 131 deletions(-)

Range-diff versus v6:

 1:  bb793b71e3 !  1:  4c4b07ed93 meson: add infrastructure to build internal Rust library
    @@ Commit message
      ## Cargo.toml (new) ##
     @@
     +[package]
    -+name = "git"
    ++name = "gitcore"
     +version = "0.1.0"
     +edition = "2018"
     +
    @@ src/cargo-meson.sh (new)
     +	exit $RET
     +fi
     +
    -+if ! cmp "$BUILD_DIR/$BUILD_TYPE/libgit.a" "$BUILD_DIR/libgit.a" >/dev/null 2>&1
    ++if ! cmp "$BUILD_DIR/$BUILD_TYPE/libgitcore.a" "$BUILD_DIR/libgitcore.a" >/dev/null 2>&1
     +then
    -+	cp "$BUILD_DIR/$BUILD_TYPE/libgit.a" "$BUILD_DIR/libgit.a"
    ++	cp "$BUILD_DIR/$BUILD_TYPE/libgitcore.a" "$BUILD_DIR/libgitcore.a"
     +fi
     
      ## src/lib.rs (new) ##
    @@ src/meson.build (new)
     +  input: libgit_rs_sources + [
     +    meson.project_source_root() / 'Cargo.toml',
     +  ],
    -+  output: 'libgit.a',
    ++  output: 'libgitcore.a',
     +  command: cargo_command,
     +)
     +libgit_dependencies += declare_dependency(link_with: libgit_rs)
 2:  e3f8101578 =  2:  58633be050 Makefile: reorder sources after includes
 3:  66673f7ce5 !  3:  16300fbeba Makefile: introduce infrastructure to build internal Rust library
    @@ Makefile: TEST_SHELL_PATH = $(SHELL_PATH)
      XDIFF_LIB = xdiff/lib.a
      REFTABLE_LIB = reftable/libreftable.a
     +ifdef DEBUG
    -+RUST_LIB = target/debug/libgit.a
    ++RUST_LIB = target/debug/libgitcore.a
     +else
    -+RUST_LIB = target/release/libgit.a
    ++RUST_LIB = target/release/libgitcore.a
     +endif
      
      # xdiff and reftable libs may in turn depend on what is in libgit.a
 4:  65bcb1233d =  4:  240bc33e56 help: report on whether or not Rust is enabled
 5:  908150d3ea =  5:  43e1f96e06 varint: use explicit width for integers
 6:  8f92ff1e13 =  6:  e9f421bfb6 varint: reimplement as test balloon for Rust
 7:  5e88d4d553 !  7:  73f4a8e639 BreakingChanges: announce Rust becoming mandatory
    @@ Documentation/BreakingChanges.adoc: A prerequisite for this change is that the e
     +support release. This long-term release will receive important bug fixes for at
     +least four release cycles and security fixes for six release cycles. The Git
     +project will hand over maintainership of the long-term release to distributors
    -+in case they need to extend the life of that long-term release even further. In
    -+that case, the backporting process will be handled by these distributors, but
    -+the long-term release tags will be created in the canonical Git repository.
    ++in case they need to extend the life of that long-term release even further.
    ++Details of how this long-term release will be handed over to the community will
    ++be discussed once the Git project decides to stop officially supporting it.
     ++
     +We will evaluate the impact on downstream distributions before making Rust
     +mandatory in Git 3.0. If we see that the impact on downstream distributions
    -+would be significant, we may decide to defer this breaking change to a
    -+subsequent minor release. This evaluation will also take into account our own
    -+learnings with how painful it is to keep Rust an optional component.
    ++would be significant, we may decide to defer this change to a subsequent minor
    ++release. This evaluation will also take into account our own experience with
    ++how painful it is to keep Rust an optional component.
     +
      === Removals
      
 8:  d7d7256a48 =  8:  c1d3c3fcab ci: convert "pedantic" job into full build with breaking changes
 9:  a38eec0af9 =  9:  14271538e3 ci: enable Rust for breaking-changes jobs

---
base-commit: 2462961280690837670d997bde64bd4ebf8ae66d
change-id: 20250904-b4-pks-rust-breaking-change-7167d9d3e37d

