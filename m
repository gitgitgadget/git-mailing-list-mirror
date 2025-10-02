Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A8F2D193B
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390236; cv=none; b=loSyX6Y4eW9RFKgvcuMvqiWYVK891qWXvo2Xbc5+6p6/1WI5oLu1cfN9SmCsLUcwf0rlC6SqzdDG1qv4DEtaH7rNAjczMCLIpWQdPvnkKkhGpaFx/ucTUARdAaFAx4VpFAR7d0bHyTGJZdxcU/RCTfsPhQT2Va+aXzXi1EyShx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390236; c=relaxed/simple;
	bh=4UIQ1TgDfGvW7FYwRb8/bHooS1Myn7l4OPwQMNxgBqs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Ir5dUrb2RzAFi5+soYbb2l4I/8pwrESofg7xJXcmWUKzsPLQjd1ayMlX6R0uIt6uVFlmVJ3tfREAecghfqv5Og2OUKzl9R+w5cgk08Lau9LySqNb3HoQebgkkALoZxe0MkbeCo4rWRWWWAmegqysCdu1LLrF6hsNEewlaj8ZUo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GG74PAiQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hv6A+GI1; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GG74PAiQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hv6A+GI1"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 46CDD7A0146;
	Thu,  2 Oct 2025 03:30:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 02 Oct 2025 03:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759390233;
	 x=1759476633; bh=BezQewBSTeAU0R132epSYnG8e3NVdJfsV08iK4zTigk=; b=
	GG74PAiQf0fbzqudY9lVWE/XGTdvAOMNOiyM4cI6IIQ21BTPKI8FMpEHcss0t6vl
	kIoG+4lkAhheoT71t1yIRiCWdBNniqOl2wbpefZiCmglwB6rvY0DbSXT8U+xx9me
	qWSsFTzJZNbvkHq/KOhuNjWVl5rmicI3B96zFAMgjRN/Za8dqY3uaCiRxPbn6rwy
	jaNGC2ViaTSHQKYhF1ZWhq8YSpxefJUF1SRk5eUd2J4yJS0o+IqjAoyHr7dkG3nY
	PmtA4A+xSHv79Zp0PF11KbO0VrBwbhMjo7CYZsf4Fc5S3Ywlt9qENspQzFWnCoby
	832W6ICeSTZ3Sf4WTEpuaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759390233; x=
	1759476633; bh=BezQewBSTeAU0R132epSYnG8e3NVdJfsV08iK4zTigk=; b=H
	v6A+GI1SQ9YofXaM97ZKLwxS7Zah9BQyvNUiUWdUYtaaroXukUnA46NMqRL+BBq1
	VxzQJQKgZ9t7+MqD0XYF/AM5C7/jO5eth1zFZqXGoacHZN9lF3+D2xsTwZZqie5g
	6qgTpyvAzpoj/HEXzTc/yxt6S184PXC4TS1E1oGXbIhNS8Xm+kodHp+UKlh51Tbe
	N50Uj0eUX8mY8G6FAgKHdVXbC5oWnXGrTBaqZvPjjDbEJrW+CUvWE1XaNmpBJ7Pv
	hocWAwSk5addStP7EI09aMzPRIfLJKfeRDiACpg6qkj3ibYPXWFg11U9c99oERY+
	Pj07B+MJO1Wi00+xYNTwg==
X-ME-Sender: <xms:GCreaJky4HAeEubgRjH--097ra7duEefnKLnlYBYZYUcOihaK174PQ>
    <xme:GCreaFR0oQPJo4jokBv77c9SwDpQph98HYRpEzHa76AyauNdWE9KnF22LXh3uqLUI
    rjzM4iWCLmo6BogzmSo0lHBy1irK9YdomCEEPtG_viJ0-d_gzxrhgI>
X-ME-Received: <xmr:GCreaPZvlRDynmIvELhcd6FCe9b4tGnvA9u9w8mlyFA5c7tlKTNKkNa7SRJGL2lsWczXRfehomRzktw_-ZdhfYgx_f6MlU96aKqjUJWhgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedu
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguud
    dvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegtsgesvdehiegsihht
    rdhorhhgpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomh
    dprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthho
    pehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhope
    hsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:GCreaF9_kTPxKHPzVxCvosbw3L5P71F_B1lIneYR8U9KYh0IIb5yfg>
    <xmx:GCreaBmgoZXgX8Cj7yl53TD3ICDrw-ZLNg1qXsvqe1zIr-FiIwWLEg>
    <xmx:GCreaCYAZ-TBRioYaG3VAAD-RDJkAJr1R3v8UYh8ADPKEs7ASING_w>
    <xmx:GCreaBO8VvUfFKexB09bJKF2odYBP7VwA6lBgH1hr5OCQWYiFtm-LA>
    <xmx:GSreaMefHiyJLsgyqT-HJG1TOtCOed2KuysLMQ1l-UV8vcpFTPhnJKtV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 03:30:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e15ba0d6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 07:30:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v8 0/9] Introduce Rust and announce that it will become
 mandatory
Date: Thu, 02 Oct 2025 09:29:25 +0200
Message-Id: <20251002-b4-pks-rust-breaking-change-v8-0-3a89fd5b1ce7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANYp3mgC/43RS2oDMQwG4KsEr+vi96Or3qN0YVtyYkKTYKdDS
 5i71xNK8WwmXf5CfJLQjTSsBRt52d1Ixam0cj714J52JB3CaY+0QM9EMKGZZ4pGRS/HRutnu9J
 YMRzLaU9/Wy03FjxIlBZIFy4Vc/m662/vPR9Ku57r933YxJfq/9yJU0ZlyByERhbRv/bW5/JBF
 nQSI6S3IdEh46VPMavAoltBcoTcNiQ7xBNY7nxGkHEFqQHibBtSHVLByJyMF9bBCtIj9OA03SF
 IMkiRYxTcrCAzQEJuQ6ZD2jNrMqJyJqwgO0IPNrLLaag8pNg/DPoPmuf5B08qyOp5AgAA
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

Changes in v8:
  - Some final typo fixes.
  - Link to v7: https://lore.kernel.org/r/20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im

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

Range-diff versus v7:

 1:  3f916bebd4 =  1:  bf7b33291d meson: add infrastructure to build internal Rust library
 2:  ed849dcfed =  2:  59e7879c63 Makefile: reorder sources after includes
 3:  955f262ef5 =  3:  635cebc0a6 Makefile: introduce infrastructure to build internal Rust library
 4:  7a90192b5a =  4:  43b50563cc help: report on whether or not Rust is enabled
 5:  9365a78efd !  5:  37d03d7774 varint: use explicit width for integers
    @@ Metadata
      ## Commit message ##
         varint: use explicit width for integers
     
    -    The varint subsystem currently uses implcit widths for integers. On the
    +    The varint subsystem currently uses implicit widths for integers. On the
         one hand we use `uintmax_t` for the actual value. On the other hand, we
         use `int` for the length of the encoded varint.
     
    -    Both of these have known maximum vaules, as we only support at most 16
    +    Both of these have known maximum values, as we only support at most 16
         bytes when encoding varints. Thus, we know that we won't ever exceed
         `uint64_t` for the actual value and `uint8_t` for the prefix length.
     
 6:  e7e0621b68 =  6:  0d265f9675 varint: reimplement as test balloon for Rust
 7:  8d8e9cb8a8 =  7:  a6e0d668f0 BreakingChanges: announce Rust becoming mandatory
 8:  07dc8171ac =  8:  79470835fd ci: convert "pedantic" job into full build with breaking changes
 9:  708a0d3c67 =  9:  67f8dea13f ci: enable Rust for breaking-changes jobs

---
base-commit: 2462961280690837670d997bde64bd4ebf8ae66d
change-id: 20250904-b4-pks-rust-breaking-change-7167d9d3e37d

