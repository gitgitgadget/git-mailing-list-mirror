Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2191D6187
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 22:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758925085; cv=none; b=BYJctU10lv5dAwPAuwbHUB/xVjKvEd6iYzCUfN1F/KVZDdYWETYdj8WBVVtE/p8n2rf7jqIjUUe3L9dNh3vZyheawF4krElmFN7NJhZuzsu1ZIElM5oIQ6lpUHbHnj8Vwmn6vz0tHupnQfr5SC+CxUAYkXnqi2pzwN6xhTupv6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758925085; c=relaxed/simple;
	bh=0y98ljHdSdbTQamhbBHcuj4E9BPfLngI30wt1AW6GeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHBa74VybENRuoOcLzJgrgxJxBXMUIIXAx4SI7pqViyYur1JYgPLO6j69YKZT6s6F2u/YhyChaOzmtcfUxMLwb84cIby6PTtnRYwzXVrM/RNumR+m+WHLu6UxRancRbqcR/mSUqjiGy/NziaDrS/pH2LkU3F58H8rkD985O2GEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmVTe4bQ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmVTe4bQ"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-36639c30bb7so26773701fa.3
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 15:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758925081; x=1759529881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmE0E9rWxkmkYD0K/McRUjTSZ3D3+1ll3ZUrWS2r/6s=;
        b=nmVTe4bQI35yQEt2TCv8vDvm017/4IOO6PBBUuD+Nzt3+vIgAopXjy2NC+stzbQXoc
         2B1FkDgApW8Y/Rcc2NCsC7XnbPB3Stg3jDpkx3tq4b42FyuIx3vWY09F2MQuwbOoJ87P
         SMFQUtNpjAZC7xmCK2lRkZZL1g2XCVVAVofrVBk6RUf94XpLuYjAVrnIWC/2IfGWrDuO
         PLdO/mWuJuxrVkx6013l73YNygwEsjwd5ldMcVDnTosImXzVLLNLCwl9K4MDu3CKDN9Y
         b0j1XWcPnpPYAyex0D8lS+BCrGhkSr5blDx6I6vCSh99yUKKCbj3xGCMJdhz78U3CniO
         c2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758925081; x=1759529881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmE0E9rWxkmkYD0K/McRUjTSZ3D3+1ll3ZUrWS2r/6s=;
        b=LxADteepXMyIqmHAScs+Cs099OoIBzm/sjkk+yDbE0vqEGCh+8GezKwtppOXB9eFYv
         6cN52UeWGSHW9I5U0TjVFDTH8wac2yZFMlagBeGU40NvlkzC01obTURtKkS2ut+NOl0a
         j07icS/2C7KosvJqyH/BHNEqV4Vm41FcJe9Wqk8tdlf2Rm/pd6sSbjHNDxeJlHm75fgH
         /iMXVbuws0nndM4l3fPYBuVvA6HGsRZwVzOw073MZuFYKEpTHLzfPfEgkA+NwyhFiEc9
         teELm7qXXCcYK+ql3p/nl2lE28lVVePWdmOgbtKRpwyEqDl2lpNXfT0Oq5iNhKRJuyzx
         eo4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgWA1mr/FMA+8+JB0CLq2tjRaXhznMm5zEuYIOcrycqteX/pj7lVFMEfemRdk9doCnTHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF8mVR/Hsdzhh0YLevCEh0ZnkGnYWB8lhznahm+9RJIL37FfBA
	t54xc6yrhWXmb3lmmWrgxx/M3591wlhr3KgQenBqOuYaoDwQutCRD/wVqUObGUprcgu3KE+zj8v
	FKe1IfzE4BGDFNVmT4sAF+oo77AcmyhI=
X-Gm-Gg: ASbGncv6/PInSWoqy3Q3KHmd2XrSNd+76PphM+pjPV9n1hjRR1nc00YDBJ0HIVLa/jq
	PomJJ6zwpev1Nil18v2G0x2cTTO0Nr8zlXtj5gVa+22KXxcSl9wPNeXC07ENj+1ujPsxzwhmBpk
	emBnYC1IsHPlFSZJf4m6JJaB0KuD5Cy6KJ3IjZalw60WhLq7UC8hRmlDY3PTa20mCMNyBXGa8Lx
	ev5xzin
X-Google-Smtp-Source: AGHT+IFuakuaosf2m6eob4MMsTtkzrJE32byjlm4IvCI9mlPTmumE762luOrQodCQCdPS3X0vrsCnQ1NwZ+1ug/7iBw=
X-Received: by 2002:a05:651c:221d:b0:36a:878b:6e34 with SMTP id
 38308e7fff4ca-36f7a3ccc2emr28170931fa.0.1758925081214; Fri, 26 Sep 2025
 15:18:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im> <20250925011043.M401827@dcvr>
In-Reply-To: <20250925011043.M401827@dcvr>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 26 Sep 2025 16:17:49 -0600
X-Gm-Features: AS18NWD_HS0UxO07bU_xHS7LrdPt7c5ZjIulRJ16Z1u-vkUigqTVQ0zcf902pE8
Message-ID: <CAH=ZcbCEioNGaksTKnYyakABWGwTWv4WQZCnOtARydtLrx11MQ@mail.gmail.com>
Subject: Re: what's missing from newer C? [was: [PATCH v5 0/9] Introduce Rust ....]
To: Eric Wong <e@80x24.org>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
	Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	Elijah Newren <newren@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Sam James <sam@gentoo.org>, 
	Taylor Blau <me@ttaylorr.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 7:10=E2=80=AFPM Eric Wong <e@80x24.org> wrote:
> What else is missing from C?

1. Checked Arithmetic
  * C23: <stdckdint.h> for checked integer operations.
  * Rust: built-ins like checked_add, wrapping_add.
2. __counted_by__ attribute
  * Clang 18 / GCC 15: experimental, helps catch buffer overflows.
  * Rust: slices already carry length, preventing out-of-bounds by design.
3. __cleanup__ attribute
  * GCC, Clang, TinyCC: long-standing extension for RAII-like cleanup.
  * Rust: Drop trait ensures deterministic cleanup.
4. RCU / concurrency libraries
  * Userspace RCU, ConcurrencyKit, etc. available in C.
  * Rust: crossbeam, Arc, lock-free crates.
5. Format string checking
  * GCC/Clang/MSVC check format strings at compile time.
  * Rust: format! macros type-check arguments.
6. Regex and parsing
  * C: POSIX regex, PCRE2, re2c, wuffs.
  * Rust: regex crate (safe, no unchecked buffer access).
7. Dynamic analysis
  * C: Valgrind, ASan, TSan, UBSan, MSan.
  * Rust: Miri, LLVM sanitizers.

What else is missing in C?

Compared to Rust, here's where C still falls short at the language
level (not just tooling):

1. Ownership and lifetimes
  * No borrow checker; compiler can't prevent use-after-free, double
free, or aliasing bugs.
2. Async/await coroutines
  * No language support. Async requires threads, callbacks, or libraries.
  * Rust: async fn / .await integrated into the language.
3. Explicit numeric conversions
  * C silently promotes between ints/floats/signed/unsigned.
  * Rust requires explicit casts (down and up), reducing surprises.
4. Sum types with exhaustiveness checks
  * C: enum + union is manual, compiler won=E2=80=99t enforce full handling=
.
  * Rust: enum + match requires covering all variants.
5. Safer error handling
  * C: errno, return codes, ad hoc conventions.
  * Rust: Result<T, E> + ? operator, forcing handling.
6. Concurrency safety by design
  * C11 added atomics, but race conditions are unchecked.
  * Rust: Send / Sync traits enforce thread-safety at compile time.
7. Namespaces / modules
  * C: relies on foo_bar() prefixes and headers.
  * Rust: mod and crate system.
8. Default immutability
  * C: everything mutable unless marked const.
  * Rust: immutable by default, opt into mut. You have a choice of 1
mutable reference xor many immutable references to something.
9. Package management
  * C: out of scope for the language
  * Rust: built in with Cargo dependencies

In Rust there is a difference between concurrency and parallelism.
Concurrency in Rust is about running multiple tasks with a single
system thread. Whereas parallelism is about assigning tasks to
multiple threads. I highly doubt that C will ever get coroutines
because it requires the compiler to create a state machine out of each
function that uses async or await keywords. The C language just isn't
robust enough for that in my opinion.

And there's probably more that I haven't covered here.
