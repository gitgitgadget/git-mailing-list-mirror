Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEBA3AC15
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620733; cv=none; b=GjHZttUA9dVoCSfBV0La6LOFJ4QzenaX2j38Xr+EtwEbFtwMQ05D0zAkF5FNozFevC9/DmErllwdZgIxvmsC1qqo1rs33KeWqGf2pBHxdjRqWddtk8Z0KyGsYcwBxIHorn0I2gDhL6rkCZ3LIINYD5vsmZHMAg/e3uAgE5yrFXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620733; c=relaxed/simple;
	bh=wnWUnXJlgORmZhBsfZ6JDzLlvWfd+ilKIO9Kqv/8eqc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=HNXPtnIfqs4oIcL2wIDhI/1Od9Xl5Ljpi36Kn3glWws6YIwsd5qj9OgmnZmmPbF5NHfU34erFjgJpr/gHMW8M96W3ZMuNai1fWaus+4sK60pLKYflbq7DLyz9z3wefc9hXJxK72mbrBEdMjvttUxild2OYNmzslQiSzvlAYpVgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vfv7dnKX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bL9dDso/; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vfv7dnKX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bL9dDso/"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 436AC7A02C3;
	Tue, 23 Sep 2025 05:45:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 23 Sep 2025 05:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758620730;
	 x=1758707130; bh=HJ/kKfCcWgKp7B3DRDyG4uaqccLRATs7EFx3u0wUwqo=; b=
	Vfv7dnKXW2gHepcygZiNjn5SldPU+1Cq6wtwaG8Bn59+wxUwyD7qvxhePSbD/zeO
	7R2JUhCz+g45fE1LrFafZ3ogohhTEkjA9MA9K4VlppRD7EAR1Bbwi0zFpzZXkYZo
	+EN4KJEeyjG9UDQDpiX2z3mbDWPCS4S2+GYVWjyz87iLeysDwXuzw7cfW5mvKikD
	9iuB6aj8ux9iDWZDaXtmhf7K4CsN2yewshrYoTNzh9URHAvVkhULOH4ABYK2Kjfd
	WXy0PxfdDNB841/dR1VSi1plSxbIChm0RltG6Zqo1psGlpVXFyJWKGFnqcjtEAnW
	tlQjwPIWbG4v0EKhICvGnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758620730; x=
	1758707130; bh=HJ/kKfCcWgKp7B3DRDyG4uaqccLRATs7EFx3u0wUwqo=; b=b
	L9dDso/+wHIGeaXCRXeTYC6x47FVAS3kJs+J4+Il+EpL8YxoCBZ+cgJYnaSPBrST
	yvvB6bqUaaazjU+IB54nCrHb3/uw6cRiowWfYcSsUcTQIx0PmFbPSHjYfsEwKf6t
	kThxLlTQvmULQhvtLxiby1SchijUp3o+ziW8bQeBPN9PQ+CceIdRyONP9DlRHAW6
	ccgsgzpvDuh3rls8pqENWM7Ze6BTwhbdpj/NxMi/2+hL8UmG7UC9irlH8nzTRpb/
	pSMT4x3vZn6EWCukIOjlcm/fm75P/fvCcdPqEi6fin3jIHaChnRuNPiuJn27ulge
	jv8z41tHFtWcf7CPqlcig==
X-ME-Sender: <xms:OWzSaLGZdi92UGIwPL27eW9Up5yLb8D6KFechnkKFSrfEYq7EySd7g>
    <xme:OWzSaIzpaiQH8lLWPyC2EmXrWvBPl_y5mLLRX2O8QKyR9NdmnJTCmLzxNeA1SzSDs
    uxbH-4eZHO_j8BRtqhlWjvCO-WeKSOFr_8ER0z88KPAcB4wGeMwcqA>
X-ME-Received: <xmr:OWzSaM6oTKXVpXl6ipvH5QIJeu5HgATi0vQlaSDHtZR9zEgl1HkFbtmqLKQT2FeH4Jf4M3nAuJ7Aqv8ZBTBDOfNFgvWxis6WLciCggj1Rn4C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedu
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorh
    hgpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpth
    htohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknh
    hosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghn
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghonhhtrggttheshhgrtghkthhivhhish
    drmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OWzSaFfDxtkH_Nga54Q2zXeDvIWjHhVyVuMtXUbES_sB5yXq9lhX3g>
    <xmx:OWzSaLFgAO5Sa3JG57YBzS8u1XpOXzSV_6t4XysXkAElvp8VLndDAg>
    <xmx:OWzSaN6Q5wEVvSD5Dr2-qb7Bi2AF08nHXqhj-pcpOdZYGbx0ZdTivQ>
    <xmx:OWzSaGuquQCLof-aYUD-Phn2saU3-saUXr0c9QEJouD5HVJydkH_qg>
    <xmx:OmzSaHlMKEEbdnnKWK5VQT74rEmqVYlhWXhUUJsE4V02bbYA7xfHrmBV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 05:45:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fd9b041e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 09:45:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 0/9] Introduce Rust and announce that it will become
 mandatory
Date: Tue, 23 Sep 2025 11:45:19 +0200
Message-Id: <20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC9s0mgC/43PTWrDMBAF4KsErasiafRjZdV7lC4kzSgRoU6QU
 tMSfPcqoRR743b5hsf3mBtrVAs1tt/dWKWptHIee7BPO5aOYTwQL9gzU0IZ4YXmUfPLqfH60a4
 8VgqnMh74T9VJ69AjEDhkXbhUyuXzob++9Xws7XquX4+xSd6v/3MnyQWHkCUqQyKSf+nV5/LO7
 uiklpDZhlSHrAefYtZBxGEFwRIatiHokEzo5OAzIcQVpBeQFNuQ7pAOFnKyXrkBV5BZQn+8Zjq
 ECQKoHKOS9hea5/kbzzO1GecBAAA=
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

Range-diff versus v5:

 1:  22925bf016 !  1:  06872fe524 meson: add infrastructure to build internal Rust library
    @@ Commit message
         want to introduce features that were added in more recent editions of
         Rust though we should reevaluate that choice.
     
    +    Inspired-by: Ezekiel Newren <ezekielnewren@gmail.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## Cargo.toml (new) ##
 2:  bcd30c4e0f =  2:  0f243f137e Makefile: reorder sources after includes
 3:  45663309c3 !  3:  cb078bdffc Makefile: introduce infrastructure to build internal Rust library
    @@ Commit message
         commit. Developers can enable the infrastructure by passing the new
         `WITH_RUST` build toggle.
     
    +    Inspired-by: Ezekiel Newren <ezekielnewren@gmail.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## .gitignore ##
 4:  1eec68d6a3 =  4:  b043011938 help: report on whether or not Rust is enabled
 5:  95f705fc07 =  5:  b3b415b277 varint: use explicit width for integers
 6:  2d36e3bb54 !  6:  435e5c3ae5 varint: reimplement as test balloon for Rust
    @@ src/meson.build
      ## src/varint.rs (new) ##
     @@
     +#[no_mangle]
    -+pub unsafe extern "C" fn decode_varint(bufp: *mut *const u8) -> usize {
    ++pub unsafe extern "C" fn decode_varint(bufp: *mut *const u8) -> u64 {
     +    let mut buf = *bufp;
     +    let mut c = *buf;
    -+    let mut val = usize::from(c & 127);
    ++    let mut val = u64::from(c & 127);
     +
     +    buf = buf.add(1);
     +
    @@ src/varint.rs (new)
     +        c = *buf;
     +        buf = buf.add(1);
     +
    -+        val = (val << 7) + usize::from(c & 127);
    ++        val = (val << 7) + u64::from(c & 127);
     +    }
     +
     +    *bufp = buf;
    @@ src/varint.rs (new)
     +}
     +
     +#[no_mangle]
    -+pub unsafe extern "C" fn encode_varint(value: usize, buf: *mut u8) -> u8 {
    ++pub unsafe extern "C" fn encode_varint(value: u64, buf: *mut u8) -> u8 {
     +    let mut varint: [u8; 16] = [0; 16];
     +    let mut pos = varint.len() - 1;
     +
 7:  92590e9f87 !  7:  3f0cb3550a BreakingChanges: announce Rust becoming mandatory
    @@ Documentation/BreakingChanges.adoc: A prerequisite for this change is that the e
      JGit, libgit2 and Gitoxide need to support it.
      
     +* Git will require Rust as a mandatory part of the build process. While Git
    -+  already started to adopt Rust in Git 2.52, all parts written in Rust are
    ++  already started to adopt Rust in Git 2.49, all parts written in Rust are
     +  optional for the time being. This includes:
     ++
    ++  ** The Rust wrapper around libgit.a that is part of "contrib/" and which has
    ++     been introduced in Git 2.49.
     +  ** Subsystems that have an alternative implementation in Rust to test
     +     interoperability between our C and Rust codebase.
     +  ** Newly written features that are not mission critical for a fully functional
    @@ Documentation/BreakingChanges.adoc: A prerequisite for this change is that the e
     +project will hand over maintainership of the long-term release to distributors
     +in case they need to extend the life of that long-term release even further. In
     +that case, the backporting process will be handled by these distributors, but
    -+the backported patches will be reviewed on the mailing list and pulled in by the
    -+Git maintainer.
    ++the long-term release tags will be created in the canonical Git repository.
    +++
    ++We will evaluate the impact on downstream distributions before making Rust
    ++mandatory in Git 3.0. If we see that the impact on downstream distributions
    ++would be significant, we may decide to defer this breaking change to a
    ++subsequent minor release. This evaluation will also take into account our own
    ++learnings with how painful it is to keep Rust an optional component.
     +
      === Removals
      
 8:  3c7b2edeb4 =  8:  e5dc29bc1c ci: convert "pedantic" job into full build with breaking changes
 9:  c3803ab47b =  9:  9fcaa8c540 ci: enable Rust for breaking-changes jobs

---
base-commit: 2462961280690837670d997bde64bd4ebf8ae66d
change-id: 20250904-b4-pks-rust-breaking-change-7167d9d3e37d

