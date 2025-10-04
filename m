Received: from dcvr.yhbt.net (public-inbox.org [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AB02AF1D
	for <git@vger.kernel.org>; Sat,  4 Oct 2025 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759540177; cv=none; b=nqjfPfPRz6iZaTxEd8fj42RycZHEeNV34G5ibmrYC59eWe1XxC4BhqbIigtV9cP26mKJZ5WFG4Abq2bzAiB9c6mgk21iwBqDmXAdDr17PR+P31pVbJ5T31aGdpKQnzRjkNISawZk+kiRbBG9qoPl0OE2Ta8WBjHxXf0RfY83rDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759540177; c=relaxed/simple;
	bh=d0V67bQTn2royw5DVIDApaPhPdA5KOY16mjGZIbHJ/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/wsUJQqXEeSBM1n0tfj7m72ui1aYT1qSCsLrxePxslF+PoHeWFxbgylVJn0aBcYJZYCZwT+avWvV2X+gouPx4rBQJL5vrwj0Z4ixz1dWxlIJ7lwjNkUoT5TnLM2VO61UZrKQad7pn7kUQsbIR3tPRD6eHlLQFTBp1YIU9uksJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=q3l3WHZm; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="q3l3WHZm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1759539721;
	bh=d0V67bQTn2royw5DVIDApaPhPdA5KOY16mjGZIbHJ/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q3l3WHZmY8Dg7c3fM5BNIwMZz0p+FZiqHMBLAEFZDvsZiuvxd0da0vE8DPM399Cbi
	 uPIO9UJ9qjFkxJC/25lMG6xqXbymp+YGyLWZ+s8OkeFp4S4K4P3qqbLjOAELLjoc0g
	 SYnyz77lpPu7qreh3PT6S4I5/xGAfFryDDue9jLk=
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AF041F513;
	Sat,  4 Oct 2025 01:02:01 +0000 (UTC)
Date: Sat, 4 Oct 2025 01:02:01 +0000
From: Eric Wong <e@80x24.org>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: what's missing from newer C? [was: [PATCH v5 0/9] Introduce Rust
 ....]
Message-ID: <20251004010201.M85772@dcvr>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
 <20250925011043.M401827@dcvr>
 <CAH=ZcbCEioNGaksTKnYyakABWGwTWv4WQZCnOtARydtLrx11MQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH=ZcbCEioNGaksTKnYyakABWGwTWv4WQZCnOtARydtLrx11MQ@mail.gmail.com>

Ezekiel Newren <ezekielnewren@gmail.com> wrote:
> On Wed, Sep 24, 2025 at 7:10 PM Eric Wong <e@80x24.org> wrote:
> > What else is missing from C?
> 
> 1. Checked Arithmetic
>   * C23: <stdckdint.h> for checked integer operations.
>   * Rust: built-ins like checked_add, wrapping_add.
> 2. __counted_by__ attribute
>   * Clang 18 / GCC 15: experimental, helps catch buffer overflows.
>   * Rust: slices already carry length, preventing out-of-bounds by design.
> 3. __cleanup__ attribute
>   * GCC, Clang, TinyCC: long-standing extension for RAII-like cleanup.
>   * Rust: Drop trait ensures deterministic cleanup.
> 4. RCU / concurrency libraries
>   * Userspace RCU, ConcurrencyKit, etc. available in C.
>   * Rust: crossbeam, Arc, lock-free crates.
> 5. Format string checking
>   * GCC/Clang/MSVC check format strings at compile time.
>   * Rust: format! macros type-check arguments.
> 6. Regex and parsing
>   * C: POSIX regex, PCRE2, re2c, wuffs.
>   * Rust: regex crate (safe, no unchecked buffer access).
> 7. Dynamic analysis
>   * C: Valgrind, ASan, TSan, UBSan, MSan.
>   * Rust: Miri, LLVM sanitizers.
> 
> What else is missing in C?
> 
> Compared to Rust, here's where C still falls short at the language
> level (not just tooling):
> 
> 1. Ownership and lifetimes
>   * No borrow checker; compiler can't prevent use-after-free, double
> free, or aliasing bugs.

As I understand it, the borrow checker is a big part of the slow
compile times which makes it impractical for poor (and/or
anti-consumerist) folks to contribute.  At least Rc/Arc exists
but we can also rely on __cleanup__ to do RC in C.

RCU also has GC-like properties for resource management
with less overhead than a full-blown GC.

> 2. Async/await coroutines
>   * No language support. Async requires threads, callbacks, or libraries.
>   * Rust: async fn / .await integrated into the language.

As someone who's worked on implementing async/green threads for
a VM; I find myself disagreeing with async/green-threads these
days because stacks end up eating large amounts of memory in
less-than-obvious ways.  Memory used by a pure event loop (or
event loop combined w/ native threads|processes) is a sunk cost
in either design.  However, (last I checked,) even Golang ends
up growing stacks in giant 2KB increments whereas event systems
only need dozens or hundreds of bytes (not KB) per FD.

> 3. Explicit numeric conversions
>   * C silently promotes between ints/floats/signed/unsigned.
>   * Rust requires explicit casts (down and up), reducing surprises.

I think the "new" -Wconversion switch can help
<https://gcc.gnu.org/wiki/NewWconversion>, but I haven't tried it.
Using C23 ckd_* functions and wrappers can also help, of course.

> 4. Sum types with exhaustiveness checks
>   * C: enum + union is manual, compiler won’t enforce full handling.
>   * Rust: enum + match requires covering all variants.

Not sure what you mean by "full handling" (banning the
`default:' label?), but C switch + enums do a pretty good job
of warning, already.

I certainly wish enums were more widely used in C projects.

> 5. Safer error handling
>   * C: errno, return codes, ad hoc conventions.
>   * Rust: Result<T, E> + ? operator, forcing handling.

It's down to coding style, yes, but it's not bad.  Linux kernel
uses __attribute__((__warn_unused_result__)) (aka
`__must_check') to force error checking.

> 6. Concurrency safety by design
>   * C11 added atomics, but race conditions are unchecked.
>   * Rust: Send / Sync traits enforce thread-safety at compile time.

I assume you mean "parallelism" safety? (referencing our
terminology below).  It's never been a big problem to me
with RCU and proper understanding of POSIX semantics.

> 7. Namespaces / modules
>   * C: relies on foo_bar() prefixes and headers.
>   * Rust: mod and crate system.

I don't miss namespaces; it seems to be mainly dealing with
colons vs underscores. (Side note: underscores tend to be
cheaper for Xapian (and presumably other search engines)
to deal with :>).

AFAIK, Rust modules + crates are centrally controlled and
publishing requires an account on a proprietary service owned
and operated by a convicted monopolist.  That doesn't fly with
some folks such as myself.

> 8. Default immutability
>   * C: everything mutable unless marked const.
>   * Rust: immutable by default, opt into mut. You have a choice of 1
> mutable reference xor many immutable references to something.

Sure mistakes were made ~50 years ago, but const exists and we
can enforce that via coding style.

> 9. Package management
>   * C: out of scope for the language
>   * Rust: built in with Cargo dependencies

As a Perl user who has avoided CPAN for ~25 years, I prefer
to let distros manage packages and ignore language-specific
managers.  This seems out-of-scope for this discussion,
so more in footnote[1]

> In Rust there is a difference between concurrency and parallelism.
> Concurrency in Rust is about running multiple tasks with a single
> system thread. Whereas parallelism is about assigning tasks to
> multiple threads. I highly doubt that C will ever get coroutines
> because it requires the compiler to create a state machine out of each
> function that uses async or await keywords. The C language just isn't
> robust enough for that in my opinion.

Your terminology matches mine even outside of Rust (IOW,
"ConcurrencyKit" probably should've been named "ParallelismKit").

There's certainly been attempts at coroutines for C.  From what
I've seen in headlines, it certainly seems async + function
coloring in Rust has its fair share of problems and growing
pains.  Again, I really don't think async is worth the problems
and surprises, especially in a low-level(?) language.

> And there's probably more that I haven't covered here.

Again, I would've been much happier if git used more very
high-level language(s) instead of rewriting things to C years
ago.  Given that ship has long sailed, an evolutionary approach
towards improving C would be less exclusionary than a
revolutionary one such as Rust.

Rust seems to try to be a replacement for C++ (with even slower
build times) rather than a thin layer to interface with the OS +
hardware.  C++ mixes high-level and low-level concepts too much
for my liking (and Rust the same).  This is down to personal
taste, but I prefer a good distinction between high and
low-level languages.


[1] - I strongly prefer to only use distro package managers due
      to multi-language projects, distro-specific quirks, extra
      review, ethics/license checks, etc.  I also strongly prefer
      NOT having a central entity affecting users across all
      distros.
