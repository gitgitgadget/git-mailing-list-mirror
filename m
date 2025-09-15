Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C32309B2
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935389; cv=none; b=tDvGV5Khmsljpjyt+r0EScXvN7MAj4piq4BxT5IGm4iapbfuF1yEnid0pyC96z34cWpZ4rxutyYeoU1ppWqQvaO6NGHK3hqnRmUXCwhm3XuFAgf8A6osZOI30/03cjXhtGkW0NXs54noyg6FejWU6np1fggVicmKuIwHGJfdfC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935389; c=relaxed/simple;
	bh=yZ577CnLMLfRSIk7oeKGY7jSrZHvXA6fVsS0278jGJA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=M878/uBxGZD+DjvW5+2JbTjz0ZZ3lDOyJDobMEli5QY5TavvthQ7StsX6mAJZgWfzMBYVT8xh2AvlWTXHFCVZQitCItVmT7lMoD140wMnYrUQsp11JaNmYFF1fWNZO2Hm/EsA6hXhXv/40ojuQBXIz61Tmxe3jBmkkIf1u8yJCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CryJSDnP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xej5vrC8; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CryJSDnP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xej5vrC8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 32831EC0254;
	Mon, 15 Sep 2025 07:23:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 15 Sep 2025 07:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757935387;
	 x=1758021787; bh=iiS3nDEJXuByqww1vYe411E7U9RMpaT7luBQEkHLywc=; b=
	CryJSDnPjMgmFY6qGrevQuU3zxXsl4F4pMlUepcAg9S9kTaU/Z08ZiYDkIfdXndG
	Y1aKPOcZ894dFAGjoo7meO8lTZ1cNwkvmT8GCFrbD2/oLUxNiwVpN8ifndbWJ90c
	RV9QMFoGZMcw6eevMsCGzkESYJEyAbfrbGVQ1m8/fMqfDOOMPah7J0Kok7YPEKFX
	TTKVNRXM3gw125+CK7jeiFs0lsH8Nz6GIpMvOiYSiQLRa60hYvPoCY9QhLEhJLL3
	F6hLhv2NZ8uXgSOr051mgaBbaBlUI8ZSEmUyku49Q/doHwdM15wydnUPQSZcrF7G
	/zrfrk4ke7D2g/hBcrzzIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757935387; x=
	1758021787; bh=iiS3nDEJXuByqww1vYe411E7U9RMpaT7luBQEkHLywc=; b=X
	ej5vrC8i4dPgnGld7+I0FwTAo4FHDJaWzaS3KvUABOQHf3lIqeKgwSA6ZfSccw1q
	qU3bt2BiDUhEPB1NcUZpHUT9ix7dUW9c5XpQNsFkVlO4HT75Mv/ZbnL1E+8xA+Qe
	qVA5TDRhilVGAnA+GSQzaW9mKwTD58a6zNI0SG0eNmT4W+Yxidluo+FCbTPWh5kx
	zYeEY7ICmBw1fQWRf/07B/aOAfPKB+lp/75E/8rRRD6NSNS+Cee2q7NO7skLh3Ne
	v/YrGS/YRTfjj4g0inwmUdF9OU/6AOyhd8kUcsuuZ6H9bJY8bVSwBkrUT+B12kYd
	yjSlVc4BXJxXyX8X5YoeQ==
X-ME-Sender: <xms:GvfHaDVcEd5A-brHY77NDi0SMBMOkDioZhByy-NpBnM4IEEF5M-QrQ>
    <xme:GvfHaMNQ-31Xn5N0OIgTsYxwxtFKCPyqkT1x85nxcmY28yAqUkGoG4NmOBfGgPiZO
    kCUyP6c8Y4xDhZypg>
X-ME-Received: <xmr:GvfHaKhk5lLgN4k21-Ci5pnQG26KAbCRQeCIjDI52g5FnzT00Zjp3-ggIKV_pe6aIzDH2_rLYt-eLZc-zuE6Svji8GizuNhikQNGNerBVsE0BQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedu
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegv
    shgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehsrghmsehgvghnth
    hoohdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheptg
    gssedvheeisghithdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdef
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:GvfHaC7WEuAMfjHTfBvCQ2P1dXgAA6Q3i-y_oKKopTKfMJjn0i4LDA>
    <xmx:GvfHaBfljV67aITj5nDJEBRwpgqwWBju1HWxsEKt9z6XlwRcwaTpJA>
    <xmx:GvfHaLC8wvX4YplJ1m72CcZAh7LMKifN1Fn4RZqLFZ2wzUE6hD3uGg>
    <xmx:GvfHaAC1NgursTE_3PXGFArsbOKxNKQ7zzZFV6dpOp54Y-zSfhl8ig>
    <xmx:G_fHaBgqnJo4A8EsnnxLZzyGNRNc29x_W0V8-JaGkvMwyeTyeW_AZNHt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 07:23:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3dd9978e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 11:23:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 0/9] Introduce Rust and announce that it will become
 mandatory
Date: Mon, 15 Sep 2025 13:22:47 +0200
Message-Id: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAf3x2gC/43NSwrCMBSF4a1IxkbyfjhyH+IgaW7aILaSaFGke
 zeKSJ0Uh//l8N0HKpATFLRdPVCGMZU09DXkeoWazvUt4BRqI0aYJJYI7AU+HwvO13LBPoM7pr7
 Fn6mmSgcbOHAdUBXOGWK6vfX9oXaXymXI9/ezkb6u/7kjxQRzF2lgEogHu6vTTTqhFzqyOSSXI
 VYhZbltfBSOePMD8TlkliFeIdoETY2NELj/gcQMomQZEhUSTvHYKMu0CV9omqYnS8eWJ54BAAA
 =
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
 Documentation/BreakingChanges.adoc |  38 +++++++
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
 20 files changed, 403 insertions(+), 131 deletions(-)

Range-diff versus v4:

 1:  8e009fe5c3 =  1:  fae7d374da meson: add infrastructure to build internal Rust library
 2:  ad75e8afe1 =  2:  6202951039 Makefile: reorder sources after includes
 3:  9f182beba6 !  3:  a8ee5c33b5 Makefile: introduce infrastructure to build internal Rust library
    @@ Makefile: clean: profile-clean coverage-clean cocciclean
      	$(RM) $(FUZZ_PROGRAMS)
      	$(RM) $(SP_OBJ)
      	$(RM) $(HCC)
    -+	$(RM) -r target/
    ++	$(RM) -r Cargo.lock target/
      	$(RM) version-def.h
      	$(RM) -r $(dep_dirs) $(compdb_dir) compile_commands.json
      	$(RM) $(test_bindir_programs)
 4:  06cfc7ae33 =  4:  484c5a984f help: report on whether or not Rust is enabled
 5:  882d1e1f25 =  5:  c366ddd005 varint: use explicit width for integers
 6:  01405d242e =  6:  bb3f7b2606 varint: reimplement as test balloon for Rust
 7:  2e5e1ff9a1 !  7:  a96e89b4c4 BreakingChanges: announce Rust becoming mandatory
    @@ Metadata
      ## Commit message ##
         BreakingChanges: announce Rust becoming mandatory
     
    -    Over the last couple of years the appetite for bringin Rust into the
    +    Over the last couple of years the appetite for bringing Rust into the
         codebase has grown significantly across the developer base. Introducing
         Rust is a major change though and has ramifications for the whole
         ecosystem:
    @@ Documentation/BreakingChanges.adoc: A prerequisite for this change is that the e
     +for Rust becoming a mandatory part of the build process. There will be multiple
     +milestones for the introduction of Rust:
     ++
    ++--
     +1. Initially, with Git 2.52, support for Rust will be auto-detected by Meson and
     +   disabled in our Makefile so that the project can sort out the initial
     +   infrastructure.
    @@ Documentation/BreakingChanges.adoc: A prerequisite for this change is that the e
     +   flags.
     +3. In Git 3.0, the build options will be removed and support for Rust is
     +   mandatory.
    ++--
     ++
     +You can explicitly ask both Meson and our Makefile-based system to enable Rust
     +by saying `meson configure -Drust=enabled` and `make WITH_RUST=YesPlease`,
 8:  bd7170e906 =  8:  403731a732 ci: convert "pedantic" job into full build with breaking changes
 9:  f922a60198 =  9:  606786ce90 ci: enable Rust for breaking-changes jobs

---
base-commit: 2462961280690837670d997bde64bd4ebf8ae66d
change-id: 20250904-b4-pks-rust-breaking-change-7167d9d3e37d

