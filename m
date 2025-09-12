Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9E02AC17
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691942; cv=none; b=o3cFYMJ4ofx82HtpXMpWZ7+W0g27n5FUW34s2udAx8uN+0xrsfrjKwh5qU07oVws58DPtOxYtfVJq6Fb0PQ8YNbVyvVaOSFdxsACbIJVZ1eXrTAfydldtcOeo1YnsBqE6dY2+MqGOeIKYnMDeLWUwQKGRj38BmpPzPGhzq/jU0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691942; c=relaxed/simple;
	bh=X8hobMiivGD10p4lKtIbT3jYgrv+vunnDjhV1GtuLeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRxoU+/dcILe2nwgmTnFGOTkdGZ6fEoU6YdvWhHEFvz0DNdkApv5PZgfTYVn31BoecmXPyV4sLNmJx5Pn104X45/nkhQ1taSTzKnibILlM6QVYYw+1Rh/exYaVHRUYfqA9kRfCyfbHhxQLHTUgFeZ3dr7385GLViB5/ug4RBg8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLATzlIj; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLATzlIj"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b523fb676efso1620567a12.3
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 08:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757691940; x=1758296740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lIzDryCmUvZkhcdwR/HwSv/H9fp0uaRTiOze9c+Ne7Y=;
        b=DLATzlIjDs0exJcF9qgJTIC4tIkk5i1MG//4A8u9DnELmWRh1Kn+uGFxOVXbFzNo0o
         doQ9Kg0cC0td+TKuMK5kk2hDVKA5PSmo3cGMPvRdI+Ny493KUSuZi9tlvK61wMYdYhV3
         zQgWn9RZonhdLb5oUmMabAgZ/GfXuzOiWQfwX+4xYxz5QIBqu4Uek0nKvUmVdbLAd8fK
         vzjpfS44AHj+ClKydYJ6w2F3CGHEgf0kqp3QDaaovozy1jandejf8xcZcjwYyzadYnUV
         O6HAAORL8UXi6VLB4Sy3T6O6COyG8qOJ/dksql9YtruzXukZLZKL+mBaXdMiDwR40Beo
         tQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757691940; x=1758296740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIzDryCmUvZkhcdwR/HwSv/H9fp0uaRTiOze9c+Ne7Y=;
        b=RygIYHSUXQzo95XCtYUwfxa/G4jQ4PNU1678RNOwgmITkC9xFBNTtHqffBy8Ia9aoL
         Thp/vcqI1pt0HyXsU4lv+8M90mvLcTyxOFykWE5/PAxXXOO4Uu3hkmu60Yej2ZX+Vx2Y
         iTd9M4YkURjYw5cREySvgNDWxZmsofyjc5rl6T5pVe26R8xIzKBfMzEXOd70cYdvlltL
         o7QwSlsw7IR4hqaCTj4EyYABWLWO+QQJ61dNR55Q6EJvaAgFzmtauSLVZTQDm4jtOKLJ
         DmUuwBWmzSjyt1xbSopSForP7KF46UbBeMPBgrQeOxTt0jZmNeJbM8aXnAiHScivYfMn
         hv8g==
X-Gm-Message-State: AOJu0YzL24U3Qa6nGkup/V8NpbhfjPYfENTTll7o6iwcC5ms8Lv8BLyb
	qtlEACoFp7N92aEtGUvF9ZAUKzfL2tJ3d85af05Xfhm6edEn6WzsR1RJ
X-Gm-Gg: ASbGncv3coDAtm10W+ga7YCqBn5gH0i1ZqljJTAVj6jaPwELBKWqFsWX6qWTA2J8XYm
	6dUjnvwVgtpbrHwe79MgLkcAQ9UoAIyeEfPcw5OeiiL1iUIb/z7P9fyfgY8m1FvBEuUZFsXul4P
	ByKAAAEgin/uDTd3iJuCpNbzrT7hyWCVfmXGHt1X1fhuZGekU33j2du7ugsd1r/B5SlzZOnbhxr
	sRs6yehYNIyojWva209jwt29hubRgABV2Uk4ToUG9bTI9jpMR11BnDLgDW54OexSih93o+HhmNf
	/OWrqzLzmYHcDRcjGB1VHX8WL0rKnZc2G0edpKC6jOGAaWxDxPaSmUpx0YziOwqSUdm0o9iNUwa
	kJLFZIg6ZXoap3Fo45EGyItjOgKBQbEY6VcXxrN6elc5JxpvUvvLNQEs1juFlflOdIfP4L8nteI
	8fgjqoCNew
X-Google-Smtp-Source: AGHT+IHpgEfalb3hVvyHemhM4wLifcMSo5QhPMBNtG6B9MAWwyO+sO26Z3HKBAOHbD39bMJp06DA9Q==
X-Received: by 2002:a17:903:1b4c:b0:24c:b2a4:7089 with SMTP id d9443c01a7336-25d26077175mr44069745ad.31.1757691940328;
        Fri, 12 Sep 2025 08:45:40 -0700 (PDT)
Received: from localhost (20014C4D24C63F003E6BA6C1CC8ACD92.dsl.pool.telekom.hu. [2001:4c4d:24c6:3f00:3e6b:a6c1:cc8a:cd92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25d9c7e5b16sm22647365ad.87.2025.09.12.08.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:45:39 -0700 (PDT)
Date: Fri, 12 Sep 2025 17:45:16 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v4 0/9] Introduce Rust and announce that it will
 become mandatory
Message-ID: <aMRADFAoh68aWkdD@szeder.dev>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>

On Wed, Sep 10, 2025 at 05:35:46PM +0200, Patrick Steinhardt wrote:
> Hi,
> 
> this small patch series introduces Rust into the core of Git. This patch
> series is designed as a test balloon, similar to how we introduced test
> balloons for C99 features in the past. The goal is threefold:
> 
>   - Give us some time to experiment with Rust and introduce proper build
>     infrastructure.
> 
>   - Give distributors time to ease into the new toolchain requirements.
>     Introducing Rust is impossible for some platforms and hard for
>     others.
> 
>   - Announce that Git 3.0 will make Rust a mandatory part of our build
>     infrastructure.
> 
> The test balloon itself is quite uninteresting: I've chosen to convert
> the "varint.c" subsystem, mostly because it is trivial and does not have
> any dependencies. But it does allow us to verify that C to Rust interop
> works as expected, and to play around with tooling. All tests pass with
> the "varint.rs" implementation.
> 
> For now, the series only contains support for Meson. If we agree to go
> down this route I'll also introduce support for Rust into our Makefiles
> at a later point in time.
> 
> Furthermore missing is additional tooling:
> 
>   - At least one CI job to verify that Rust builds and works as
>     expected.
> 
>   - Tooling and CI jobs to ensure that we have consistent formatting via
>     `cargo format`.
> 
> And probably lots more. As said, the entire goal is for us to have an
> easy playground that we can experiment on and develop the infrastructure
> incrementally without yet having to commit to anything.
> 
> I'm mostly splitting out the topic of introducing Rust from the larger
> series that introduce it into xdiff so that we can focus more on the
> actual process of introducing Rust into Git and less on the potential
> features that we want to build on top of it.
> 
> Changes in v2:
>   - Introduce support for building the Rust library via our Makefile.
>   - Introduce a '-DWITH_RUST' define. This define is used to print
>     whether or not Git is built with Rust via `git version
>     --build-options`.
>   - Adjust Meson to not depend on v1.9.0 and newer anymore.
>   - Introduce a roadmap into our BreakingChanges document to explain how
>     we'll iterate towards mandatory Rust support.
>   - Rework the Fedora job to do a full compile-and-test run with Meson
>     and breaking changes enabled.
>   - Adapt our breaking-changes jobs to enable Rust support.
>   - Link to v1: https://lore.kernel.org/r/20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im
> 
> Changes in v3:
>   - Reorder all uses of `WITH_RUST` after the include of "config.mak".
>   - Add a test to verify overflow behaviour in Rust and explicitly use
>     `add_wrapping()`.
>   - Use explicit dependencies for the Rust library in our Makefile.
>   - Fix Alma Linux CI job.
>   - Stop tying maintenance of our LTS release to the availability of
>     gcc-rs.
>   - Add a fallback to Meson to use cargo directly.
>   - I've fixed the Rust edition to 2018 for now. This is intentionally
>     conservative so that we might be able to use Rust 1.49. For now, we
>     don't have any reason to use a newer edition, either. So let's take
>     the oldest version we can live with for now and then bump it as
>     required.
>   - Link to v2: https://lore.kernel.org/r/20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im
> 
> Changes in v4:
>   - Convert "varint.c" to use explicit integer width so that we don't
>     need to use C types in Rust.
>   - Adapt Meson to unconditionally use Cargo.
>   - Don't use the unstable `--out-dir` option in Cargo. Instead, we
>     resort to a wrapper script in Meson.
>   - Shorten the timeline a bit to drop the extra step that ties Rust
>     support to `-Dbreaking_changes=true`. This accelerates the timeline
>     until distros are made forcibly aware of the upcoming changes in
>     Rust.
>   - Link to v3: https://lore.kernel.org/r/20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im
> 
> Thanks!
> 
> Patrick
> 
> ---
> Patrick Steinhardt (9):
>       meson: add infrastructure to build internal Rust library
>       Makefile: reorder sources after includes
>       Makefile: introduce infrastructure to build internal Rust library
>       help: report on whether or not Rust is enabled
>       varint: use explicit width for integers
>       varint: reimplement as test balloon for Rust
>       BreakingChanges: announce Rust becoming mandatory
>       ci: convert "pedantic" job into full build with breaking changes
>       ci: enable Rust for breaking-changes jobs
> 
>  .github/workflows/main.yml         |   4 +-
>  .gitignore                         |   2 +
>  .gitlab-ci.yml                     |   4 +-
>  Cargo.toml                         |   9 ++
>  Documentation/BreakingChanges.adoc |  36 +++++++
>  Makefile                           | 214 ++++++++++++++++++++++---------------
>  ci/install-dependencies.sh         |   8 +-
>  ci/run-build-and-tests.sh          |  31 ++----
>  dir.c                              |  18 ++--
>  help.c                             |   6 ++
>  meson.build                        |  15 ++-
>  meson_options.txt                  |   2 +
>  read-cache.c                       |   6 +-
>  shared.mak                         |   1 +
>  src/cargo-meson.sh                 |  32 ++++++
>  src/lib.rs                         |   1 +
>  src/meson.build                    |  41 +++++++
>  src/varint.rs                      |  92 ++++++++++++++++
>  varint.c                           |   6 +-
>  varint.h                           |   4 +-
>  20 files changed, 401 insertions(+), 131 deletions(-)
> 
> Range-diff versus v3:
> 
>  1:  a25408af71 <  -:  ---------- meson: add infrastructure to build internal Rust library
>  -:  ---------- >  1:  ccdb7e264d meson: add infrastructure to build internal Rust library
>  2:  a9c639b0f3 =  2:  b88c80f7e9 Makefile: reorder sources after includes
>  3:  ccac54a247 !  3:  873f9d82f5 Makefile: introduce infrastructure to build internal Rust library
>     @@ .gitignore
>      @@
>       /fuzz_corpora
>      +/target/
>     ++/Cargo.lock

The Cargo.lock build artifact is back in .gitignore in this version of
the patch series, but the 'clean' target is not updated accordingly to
remove it.

>       /GIT-BUILD-DIR
>       /GIT-BUILD-OPTIONS
>       /GIT-CFLAGS
>  4:  b357ff9463 =  4:  4e70509175 help: report on whether or not Rust is enabled
