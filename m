Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D4273451
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757081671; cv=none; b=PAggP8H4wvwysZx70fJTTK4H6eVglAD7OvORlZSxRwLGKYWtjZBCRW3d1l3JO/Dx1cHVP2A2PLpYaR3GILsTInGIjz6xb7SX3bkbdg/TDBN1L73Shmfem0QXCjHZ4un0W6olEy3YBQQOgqbF5a5PIdVzOi1zgl6iJU9MbGZ+TFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757081671; c=relaxed/simple;
	bh=NoRcvLBmcloFw9g/545HPrTfhCtpj62i7+qWg3Pk+hE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eR9tMY4IfS1Rae4FT7gbkM0p98eC2dvsi165wR6YQKlCY4t4i5UWqGr0SVGjXWImHrL5zSLUm3iOwSlkx4mHWqEv102pQHDgWL+Sv601+GyCN9lcJtmL20JRbLOgOlnRzvvfARAWkXa8QDHgkupr76cuzzv3qjac9iijjGUVrys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/aHg8XP; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/aHg8XP"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3df15fdf0caso1790812f8f.0
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 07:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757081667; x=1757686467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WLoWHd0zUjQ4qs6Dbkyavz1LP26EH8gNuk2GslpZcdE=;
        b=e/aHg8XPX3C9PJW0a1VSXOJsgvBfmP7++4ww+aRD9IV671zB9di4DhsT919OjupnBA
         xKVX9LFaHy0mOAsKLrsXpq/HaX/cV7q5TrvCq7yiQgb6lUewkxz2IJ20eqroEbfLT8TR
         pRngGWgY0Uzgw+uwEZY+Tlp2tn7n1AmEyplWfIdzPRF6ZHfqvLhoXYWk4+d1siYU6r//
         UxRIZnVDHBm2daIseffW7FyPb8kU6zBJ361F6/bTQK7zpxoIzz7pk8ypLYoB3VQ54XIP
         UVgJF2TgJroUMq8e2W6iiteQVZ675z0VgscpnGWatvWdC6JFjjx72wnpgYtyb4uavSqQ
         3f1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757081667; x=1757686467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLoWHd0zUjQ4qs6Dbkyavz1LP26EH8gNuk2GslpZcdE=;
        b=uPguGFeC4UMARA8FirEZzhSdYusf8/UGZSi/WkG/6Y5S2LKyCSm3uQi0r1dCueCrug
         bL+c9fOw6ARiycykDIF1sLjfolIDzCMDIqMSa8M83X4rJ1BF92LFN78SGzBaCwY1YqYo
         +6eENdUGE5dCk8v1A1DDVvX21x0R09SRLXkli5WaqFHEhjdD5nM7oYHN+NnEx3KKmXnK
         xXkuCDtGjNqhNpFCer+XupXQjhGbF0bn6e/S1G4vwAn1lEavSVijzICOBNi698b3DKB0
         Vc+TWOpO41gTvVThL0SMiK2iBHhGQIXtX6EBqKJLUId1eDNd+SGR+aiFCl5cDiH93aAa
         Vn5g==
X-Forwarded-Encrypted: i=1; AJvYcCWrxAIc1ciDtfziVpJZumkCGCJcAOXvyBZOGIq6B/K9PwYq9S6YpYqrB91iXGiIBYT1CQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI8C0BGRxwOnvOWg8X5ITsuNry0AafsaPLvYHd+5iyoF/JLziG
	ApVFZHRHoAx3laOG2AzE7XlpWkHETWKk1xDED25lx4DCMHr6xWDlllUY
X-Gm-Gg: ASbGnct6b4c39TS1NFnOUpwbzSsKI+XEAYIve9Bje10fTVIeIOZq8uODl8YbFRGrx7P
	eQ3QcfEapcBFCSEQkbUIlUXNZC6Xog8/QqNZLaFF0yaToIk5AM5XDP4Z3gAM5Xc71XiADGJKWf0
	mmCaYpk7SIWXy0AvERc2mlKJOip3B+gQ8kORr2gVm857pTOza+DTiawZ8tEb4VAy174gqZiI7dZ
	uCJdSTsuBiG8vkhIf3OpK2R902+sE5ypMuhniUqcGNCanBzFG7BBo3mWS4uW6kSdvqC546R6kAG
	b16rqE5xUSyH9o5O4Yt2C0GA8fybaOeM63DaCowFM6rGZTpQpHRxg2E/pumjWgJjM1D6Z1qc2Ze
	6QvI8F0QNd1CUO5Hnga9Nvv5FOk8iPNHOnWqHCeNypnTCVmDPLJhXOHSMHf+E0BOa7s1zN51dMe
	ruLO8mdl1j/2ZQxUY=
X-Google-Smtp-Source: AGHT+IGQOGuBi90JBDtFRKYwkgy24p//QUE/mLEKxauHOWGYZWMpPyUJs+GewRz5E6bWFe3JLPsSww==
X-Received: by 2002:a5d:588c:0:b0:3e3:f332:73f0 with SMTP id ffacd0b85a97d-3e3f3328143mr1518449f8f.49.1757081667189;
        Fri, 05 Sep 2025 07:14:27 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc? ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d6376546c6sm23254558f8f.60.2025.09.05.07.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 07:14:26 -0700 (PDT)
Message-ID: <8a5394eb-bad4-42e0-82a8-fa73123e205a@gmail.com>
Date: Fri, 5 Sep 2025 15:14:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC v2 0/7] Introduce Rust and announce that it will
 become mandatorty
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>,
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>,
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 05/09/2025 12:50, Patrick Steinhardt wrote:
> Hi,
> 
> this small patch series introduces Rust into the core of Git. This patch
> series is designed as a test balloon, similar to how we introduced test
> balloons for C99 features in the past. The goal is threefold:
> 
>    - Give us some time to experiment with Rust and introduce proper build
>      infrastructure.
> 
>    - Give distributors time to ease into the new toolchain requirements.
>      Introducing Rust is impossible for some platforms and hard for
>      others.

These sound good

>    - Announce that Git 3.0 will make Rust a mandatory part of our build
>      infrastructure.

I'm not sure if we really want to wait that long. So far Git 3.0 has 
been about user facing changes rather than build requirements. In [1] I 
suggested a period of six months from the initial announcement to making 
rust mandatory to allow distributors time to either adjust their build 
procedures or notify their users that they will only be offering 
security updates in the future.
> The test balloon itself is quite uninteresting: I've chosen to convert
> the "varint.c" subsystem, mostly because it is trivial and does not have
> any dependencies. But it does allow us to verify that C to Rust interop
> works as expected, and to play around with tooling. All tests pass with
> the "varint.rs" implementation.
> 
> For now, the series only contains support for Meson. If we agree to go
> down this route I'll also introduce support for Rust into our Makefiles
> at a later point in time.

It looks like this version does include the necessary Makefile changes 
which is great. I do think though, that for the test balloon to be 
valuable, we need make building with rust the default with an error 
message that tells people how to build without rust if that fails. 
Otherwise it is easy for people building on platforms without rust 
support to miss that we're going to be making it mandatory soon.

Thanks

Phillip

[1] 
https://lore.kernel.org/git/ba386547-10e0-45e2-95ad-c47e84919abf@gmail.com

> Furthermore missing is additional tooling:
> 
>    - At least one CI job to verify that Rust builds and works as
>      expected.
> 
>    - Tooling and CI jobs to ensure that we have consistent formatting via
>      `cargo format`.
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
>    - Introduce support for building the Rust library via our Makefile.
>    - Introduce a '-DWITH_RUST' define. This define is used to print
>      whether or not Git is built with Rust via `git version
>      --build-options`.
>    - Adjust Meson to not depend on v1.9.0 and newer anymore.
>    - Introduce a roadmap into our BreakingChanges document to explain how
>      we'll iterate towards mandatory Rust support.
>    - Rework the Fedora job to do a full compile-and-test run with Meson
>      and breaking changes enabled.
>    - Adapt our breaking-changes jobs to enable Rust support.
>    - Link to v1: https://lore.kernel.org/r/20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im
> 
> Thanks!
> 
> Patrick
> 
> ---
> Patrick Steinhardt (7):
>        meson: add infrastructure to build internal Rust library
>        Makefile: introduce infrastructure to build internal Rust library
>        help: report on whether or not Rust is enabled
>        rust: implement a test balloon via the "varint" subsystem
>        BreakingChanges: announce Rust becoming mandatory
>        ci: convert "pedantic" job into full build with breaking changes
>        ci: enable Rust for breaking-changes jobs
> 
>   .github/workflows/main.yml         |  4 +-
>   .gitignore                         |  2 +
>   .gitlab-ci.yml                     |  4 +-
>   Cargo.toml                         |  9 ++++
>   Documentation/BreakingChanges.adoc | 36 +++++++++++++++
>   Makefile                           | 47 ++++++++++++++++++-
>   ci/install-dependencies.sh         |  4 +-
>   ci/run-build-and-tests.sh          | 31 +++++--------
>   help.c                             |  6 +++
>   meson.build                        | 17 ++++++-
>   meson_options.txt                  |  2 +
>   src/lib.rs                         |  1 +
>   src/meson.build                    | 16 +++++++
>   src/varint.rs                      | 92 ++++++++++++++++++++++++++++++++++++++
>   14 files changed, 240 insertions(+), 31 deletions(-)
> 
> Range-diff versus v1:
> 
> 1:  4df400823c ! 1:  8f6e89bc7d meson: add infrastructure to build internal Rust library
>      @@ meson.build: version_def_h = custom_target(
>        
>       +libgit_libraries = [ ]
>       +
>      -+if meson.version().version_compare('>=1.9.0')
>      -+  rust_available = add_languages('rust', native: false, required: get_option('rust'))
>      -+else
>      -+  rust_available = false
>      -+endif
>      ++rust_available = add_languages('rust', native: false, required: get_option('rust'))
>       +rust_option = get_option('rust').disable_auto_if(not rust_available)
>      -+
>      -+if rust_option.allowed() and meson.version().version_compare('>=1.9.0')
>      ++if rust_option.allowed()
>       +  subdir('src')
>      ++  libgit_c_args += '-DWITH_RUST'
>       +endif
>       +
>        libgit = declare_dependency(
>      @@ src/lib.rs (new)
>       
>        ## src/meson.build (new) ##
>       @@
>      -+rustmod = import('rust')
>      -+
>       +libgit_rs = static_library('git_rs',
>       +  sources: [
>       +    'lib.rs',
>       +  ],
>      -+  rust_abi: 'c',
>      ++  rust_crate_type: 'staticlib',
>       +)
>      -+
>      -+rustmod.test('git-rs', libgit_rs)
>      -+
>       +libgit_libraries += libgit_rs
>      ++
>      ++# The 'rust' module was only introduced in Meson 1.0. Furthermore, the module
>      ++# does not seem to work on macOS as expected right now. As such, we only
>      ++# conditionally enable tests.
>      ++if meson.version().version_compare('>=1.0.0') and host_machine.system() != 'darwin'
>      ++  rustmod = import('rust')
>      ++  rustmod.test('rust', libgit_rs)
>      ++endif
> -:  ---------- > 2:  cd1d642d04 Makefile: introduce infrastructure to build internal Rust library
> -:  ---------- > 3:  e60a8353a4 help: report on whether or not Rust is enabled
> 2:  575f6de44d ! 4:  b27811aea4 rust: implement a test balloon via the "varint" subsystem
>      @@ Commit message
>       
>           Signed-off-by: Patrick Steinhardt <ps@pks.im>
>       
>      + ## Makefile ##
>      +@@ Makefile: LIB_OBJS += urlmatch.o
>      + LIB_OBJS += usage.o
>      + LIB_OBJS += userdiff.o
>      + LIB_OBJS += utf8.o
>      ++ifndef WITH_RUST
>      + LIB_OBJS += varint.o
>      ++endif
>      + LIB_OBJS += version.o
>      + LIB_OBJS += versioncmp.o
>      + LIB_OBJS += walker.o
>      +
>        ## meson.build ##
>       @@ meson.build: libgit_sources = [
>          'usage.c',
>      @@ meson.build: libgit_sources = [
>          'versioncmp.c',
>          'walker.c',
>       @@ meson.build: rust_option = get_option('rust').disable_auto_if(not rust_available)
>      -
>      - if rust_option.allowed() and meson.version().version_compare('>=1.9.0')
>      + if rust_option.allowed()
>          subdir('src')
>      +   libgit_c_args += '-DWITH_RUST'
>       +else
>       +  libgit_sources += [
>       +    'varint.c',
>      @@ src/lib.rs
>       +pub mod varint;
>       
>        ## src/meson.build ##
>      -@@ src/meson.build: rustmod = import('rust')
>      +@@
>        libgit_rs = static_library('git_rs',
>          sources: [
>            'lib.rs',
>       +    'varint.rs',
>          ],
>      -   rust_abi: 'c',
>      +   rust_crate_type: 'staticlib',
>        )
>       
>        ## src/varint.rs (new) ##
> 3:  e54393392a < -:  ---------- BreakingChanges: announce Rust becoming mandatory
> -:  ---------- > 5:  d5946e0114 BreakingChanges: announce Rust becoming mandatory
> -:  ---------- > 6:  0d367976de ci: convert "pedantic" job into full build with breaking changes
> -:  ---------- > 7:  82086a5328 ci: enable Rust for breaking-changes jobs
> 
> ---
> base-commit: 2462961280690837670d997bde64bd4ebf8ae66d
> change-id: 20250904-b4-pks-rust-breaking-change-7167d9d3e37d
> 
> 

