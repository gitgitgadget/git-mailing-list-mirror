Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D6B13F428
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054898; cv=none; b=PVUWZsyUrdTvskB/bjcki5zBY38GJZuQsCIABCje6LlkLeg2O4FsyhGyrxjDykTJ3IPJGY3ICwg4mxH+1WU+LT1e6jCLKR6x5Pkqzp22ixVVj2qp+Kh1VgS1SdcUnk7eMNX+TtytcJsqGKHlKrB47yBnvWx7i2mcTpdzIVDYb1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054898; c=relaxed/simple;
	bh=QQiV9FxHZrG3lPt6CNZLNyyNUd9Xr1cQOkdPRyCMoMw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tUtzwr6H871SsAZYGhj9CV5xhGWRe4GOlulu0rddmNlNHaZTGlMEvlpKtkItucGfCWzhGFBJet0Kdzq9I2AuKHVjl4/odlhsvFz/p5LTQ/l97VJpkCFeW6GwZraDjiT/vuaLUvaayuQAwD7rV4L7FGHqJkSLNSuCrJopp09OS+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CKq8LVRI; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CKq8LVRI"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-664b7a67ad4so2598597b3.2
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 11:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723054895; x=1723659695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pwxh12KBGqxD+9BL9EEEZpx24f4b2KvayvuNqrlkwBA=;
        b=CKq8LVRIvwjH1Cneq/GQJhKezkr73pgzH1GruYnSBakN25mvfKvXNbBxI+MZ7CBsC/
         AeQJOx4IzGrjrDKNlmN1UwnDOe6bWoKY4erMChNJlxgm5idiYYOWD1rSwVCIfF/yeRAw
         dPjiHUVuTqPFm8BleN4uv1JH6eP4OcG3oHF1X5fX8hw0W6WvSCCUzkyd6vyxVjxMFReS
         yRLnvtvt73iqT36K9ydeygcnQ9a/JSosKVG1groFZDFWi44jS6FJzsw8tuYVe8ZSQlkN
         oxXOfqzwFFYXcTYYRp+ZbSjtVuZYUQxFaYl80ZOlNcM5OGKvKe3e8/iW5WXLUo0WPRZp
         PgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054895; x=1723659695;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwxh12KBGqxD+9BL9EEEZpx24f4b2KvayvuNqrlkwBA=;
        b=C79e2RQx+FIsDGQclGdoC8cLO+jEcPJYbzfGXzVHPFanxnQMhU3FN9ln5NaJ9nFbe9
         tGyYpqCZBwuJm6ZzPJuvY8/NbPb6KIQAyyGPWcTzi1DdnWRCu9bCaVEm2tfSRTsnwI1V
         FYZUpKpwW5kiLUK039k9b8JsJtxp8QeeyxMGaaowg2EB+/lPlbJ9eUjTC8emqHInzfAq
         d4MFaqOra0JqUoaA0EjzVp5LnNjAf57RSWj6GAv8Lgr+lUIZFWJezjakMQgcjgXEHzNA
         NT1qr3sxv98AbOCLoOzgE0SHGoap81GzXDkbUkWKyPn4ufVQ7yRbqHBTXlKfwNkyIpXU
         ejRA==
X-Gm-Message-State: AOJu0YzLC0KDVL7pR7cegQ7xr84kkFwYKBe7JXniD8te0KHL3pFFVr/r
	o6O++Tg0Ciltpbi0lteUnk/kFH8bUPHGpElfyX8vBKtje5mIoFPbywNi2WLRV0a78LoR51Kzkxf
	ABQ84vDUo5bkEIHX8Dflm/rFOj4ptXvDNuFMcH4yscuQH97LNSrrs0DpcXUrdEPFvr/FIOwIz3k
	LQsR0jUPhiteTrTRhpOkza492WHBiRM1bb+FOD95Y=
X-Google-Smtp-Source: AGHT+IGB1UXSbrcx/Po+NSoSWvfyaISEQB+BrJ+eb2fZtcMVT2GtPjpdJyUje8kvVmyNwOF36o2MNHYdF2wlcg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:c023:b8:a8df:17c3])
 (user=steadmon job=sendgmr) by 2002:a05:690c:dd2:b0:62f:1f63:ae4f with SMTP
 id 00721157ae682-6895f60e18dmr2813227b3.1.1723054894765; Wed, 07 Aug 2024
 11:21:34 -0700 (PDT)
Date: Wed,  7 Aug 2024 11:21:25 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <cover.1723054623.git.steadmon@google.com>
Subject: [RFC PATCH 0/6] [RFC] Introduce cgit-rs, a Rust wrapper around libgit.a
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When we, the Git team at Google, first embarked on the libification
journey, we didn=E2=80=99t have a specific consumer to build a library for =
but
instead were interested in the various potential benefits of
libification for many use cases such as VFSes and submodules. Without a
specific consumer, it has been difficult to evaluate the scope of what
is necessary or not even for the first library, git-std-lib. Attempting
to solve problems such as error handling, symbol collisions, and
internal/external interfaces, in addition to separating out a library
turns out to be both too complex of a task to both develop and review
all at once. While we strive to eventually build an ideal library, we
have also realized in order to make meaningful and consistent progress,
we have to solve these problems iteratively in smaller pieces. That is
why over the last month, we have been working with the jj project [1] to
understand their current usage of libgit2-rs [2] and gitoxide [3] and
future library functionality they would be interested in. In doing so,
we have built cgit-rs, a Rust wrapper around libgit.a that allows Rust
code to call various basic Git functions.

[1] https://github.com/martinvonz/jj
[2] https://github.com/rust-lang/git2-rs
[3] https://github.com/Byron/gitoxide

This series provides a small Rust wrapper library around parts of
libgit.a, and a proof-of-concept Rust executable that uses the library
to interface with Git. Additionally, we have tested building JJ with our
library and used it to replace some of the libgit2-rs uses.

This exercise has clarified a lot of things for us, and we believe that
developing this wrapper further provides benefits both for downstream
consumers and the Git project itself:
* cgit-rs provides wrappers for Rust consumers of libraries (eg. jj)
* cgit-rs suggests focus areas for libification
  * shows us what potential challenges we face with library consumers
* Git libification improves git interfaces
* Libification improves cgit-rs FFI.

We are putting error handling on hold for now since it is too complex
and we intend other CLIs to be our first customers, in which case
printing out errors is not the worst.

While the wrapper itself lives in contrib/, there are a couple of
patches that touch git.git code. These patches are necessary for the
wrapper, but not for git.git itself, which may seem unnecessary to
merge. However, I would argue that other languages (not just limited to
Rust) have issues calling functions that require a pointer to
non-generic objects and essentially require a redefinition in their own
language.

We're sending this series as RFC because there is remaining work
we'd like to do, but we'd like to get early feedback on this approach,
and particularly to ask for advice on a few topics:

* alternative methods of exposing only a subset of symbols in our
  library

* bikeshedding on the name (yes, really). There is an active, unrelated
  CGit project [4] that we only recently became aware of. We originally
  took the name "cgit" because at $DAYJOB we sometimes refer to git.git
  as "cgit" to distinguish it from jgit [5].

* gauging the level of interest in calling Git code from Rust

[4] https://git.zx2c4.com/cgit
[5] https://www.eclipse.org/jgit

Remaining work includes:

* finding a better solution to the common-main split. We should probably
  have a separate initialization function including all of main() up to
  the call to cmd_main(), which can then be exposed in cgit-rs.

* adding unit and integration tests

* Makefile cleanup, particularly adding config.mak options that
  developers can set to run Rust builds and tests by default

* automating the process of exporting additional functions via cgit-rs
  (possibly with a wrapper script around bindgen [6])

[6] https://github.com/rust-lang/rust-bindgen

Finally, a quick discussion about symbol collisions: if functions are
not prepended with =E2=80=9Clibgit_=E2=80=9D or something similar, it leave=
s us open to
collision issues in the future =E2=80=93 so this probably would=E2=80=99ve =
happened with
libification in general to begin with. Therefore it seems necessary to
have to wrap all the symbols we are looking to expose. While this seem
non-ideal, we couldn=E2=80=99t come up with a better method. Our next best
alternative is to simply expose all symbols by default, but this leads
to symbol collisions when library users link both cgit-rs and
libgit2-rs.


Calvin Wan (2):
  contrib/cgit-rs: add repo initialization and config access
  contrib/cgit-rs: add a subset of configset wrappers

Josh Steadmon (4):
  common-main: split common_exit() into a new file
  repository: add initialize_repo wrapper without pointer
  contrib/cgit-rs: introduce Rust wrapper for libgit.a
  config: add git_configset_alloc

 .gitignore                             |  1 +
 Makefile                               | 14 ++++
 common-exit.c                          | 26 +++++++
 common-main.c                          | 24 -------
 config.c                               |  5 ++
 config.h                               |  5 ++
 contrib/cgit-rs/Cargo.lock             | 99 ++++++++++++++++++++++++++
 contrib/cgit-rs/Cargo.toml             | 17 +++++
 contrib/cgit-rs/README.md              | 15 ++++
 contrib/cgit-rs/build.rs               | 33 +++++++++
 contrib/cgit-rs/public_symbol_export.c | 72 +++++++++++++++++++
 contrib/cgit-rs/public_symbol_export.h | 26 +++++++
 contrib/cgit-rs/src/lib.rs             | 81 +++++++++++++++++++++
 contrib/cgit-rs/src/main.rs            | 44 ++++++++++++
 repository.c                           |  9 +++
 repository.h                           |  1 +
 16 files changed, 448 insertions(+), 24 deletions(-)
 create mode 100644 common-exit.c
 create mode 100644 contrib/cgit-rs/Cargo.lock
 create mode 100644 contrib/cgit-rs/Cargo.toml
 create mode 100644 contrib/cgit-rs/README.md
 create mode 100644 contrib/cgit-rs/build.rs
 create mode 100644 contrib/cgit-rs/public_symbol_export.c
 create mode 100644 contrib/cgit-rs/public_symbol_export.h
 create mode 100644 contrib/cgit-rs/src/lib.rs
 create mode 100644 contrib/cgit-rs/src/main.rs


base-commit: 557ae147e6cdc9db121269b058c757ac5092f9c9
--=20
2.46.0.rc2.264.g509ed76dc8-goog

