Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C7E199949
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735542226; cv=none; b=BRLDAR/Qddss5/eE5IIyM9eWV9gIZ34mQ5nPMQdZfnH09JhVo6JGob9GkTD7ZBDynLfUnCDUCKzNX2UmnpS6cK438ySV9Pcml6w2/LrBtf/ccyunK4T0IGF572UCuJtvtBQnYV9xkId+ldS4R+advC7QyjnB5Rxj9qahnHsWDIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735542226; c=relaxed/simple;
	bh=16BDUMeNDNGDWQNkMkInzUNvxflane5kreB+/ylFT2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPkQ6CruNNatCi1rf+CSZPOqJzAD/qlqRxjazpiXw20P4dqnAin2r2I6mrv0h2Ydc4JhrkDy6PaUH4q9/9KhVIsVK7fcBEW78BofXUZEJ+vAEaH5BTnaxpHwnjP0peu+StCMJZb1diOPvGgV/VIquFSVCr1onbXeq3/l3iXKbcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F3x7AVvF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jGb82ejx; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F3x7AVvF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jGb82ejx"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CD39413801ED;
	Mon, 30 Dec 2024 02:03:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 30 Dec 2024 02:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735542222; x=1735628622; bh=hjLXqEv1ht
	9iUX8R/L/pVE26b3Toioeq6O/iOF60Ct0=; b=F3x7AVvFYJ1su6i902Kh4qjUYz
	jB09hOkcUtKJs9yxzbmVxzSCeNaJiVdJLELNAeSgEWrfbDx4p1g95/lOjgaDw7Iz
	/u/rTM/ZDN9xHLTleEPZfa26Me8Ibk/tHkbWr59nwvafOHXqKOphv562w3TjMGM+
	isVg9OfGLXSyY2x4WXyTfDDQ+FYtabaB0utvCtgmZfoyQq3Nz0QmiYZ5+6+CGPTz
	EmWu7XyLdQxFQAzRKfiHP5GAzpRNBzKAxMZFrOIl6H6dCvYJYDPNZ39alo//pEUn
	4ltOdruGZmJGV8uN8XbWQnZdqAaFs+1mJ5KLPs7WgrrRsty6YXnwBUFCgKZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735542222; x=1735628622; bh=hjLXqEv1ht9iUX8R/L/pVE26b3Toioeq6O/
	iOF60Ct0=; b=jGb82ejxQEtBI1SwKGnSxUSEi/UMxknU84a/tRbRcGZqe3XwB2L
	P884ZM8hUJRqfahLYqEbvXj6GvEpy7qZK3aNXcSnfWhTKG4uZnRSiyFsRk2iZHZy
	kbBaIGrsnIc/yFLtv2GcMb1a94SIPaPujnCiR3/Oyomkr7PNtjdwtPghy50hHUic
	+P1qlxIJ9k6hTdEgfkpLRs6b3h147e5BsdyW63NkZenZcv4hWEVUdMTkXfVXV3zz
	5Jd9u1HahOpNwDlRaIrBtua6ZQTbblfMg/nnAF5Rw54fAJSf+rCFzDvfOkEpEY5u
	REk7iW/TgK63nvyXz2MQ9Fho6ewiRsffl+A==
X-ME-Sender: <xms:zkVyZ229q5yXdEKP65Ceqp0nJ9ApPuGRwmQyc1yMiwB8Qb_yJmk9WQ>
    <xme:zkVyZ5GxwW-r4fYes6XjF-m5PTjgmC4SYJ-eajwNk8Oj0MAs4roU9ODwNCb9YJnFR
    LnMd4A1ka_FuHk63g>
X-ME-Received: <xmr:zkVyZ-44DQL4T9RMurMKhvJov_00DZaBAkDn27Rjf5riSdRnyhO0TX0okPiKO1KcFmkZthl0kbzyLCQVFKQSRZLlpgpJo5xnaWjaYwHCg75C03RG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvhedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:zkVyZ319EuV_DHM3-hxhvDaknY8CCgivDA_rjO5d0CZYa6AoSgxjpw>
    <xmx:zkVyZ5GAHXe4tiVkUnhxW5nXaAhp3S7u86xw4Y-SIxnYbFPdl7Na2Q>
    <xmx:zkVyZw-gpP3ov0brd1twXr9bs03nf3ChC_wtIxVW3VFgtG_NKi5i-A>
    <xmx:zkVyZ-kxV-lIMbUvxkHoN0C4X0L-vq9UD8VIq-Bt3FVac2Tr_JjPRg>
    <xmx:zkVyZ9i0237mOhVUnSxPGlIhZZtJ7Bx_4qfScv_-eKT_vrtIYR-9FNh4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 02:03:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b84b137e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Dec 2024 07:03:39 +0000 (UTC)
Date: Mon, 30 Dec 2024 08:03:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] thread-utils: introduce optional barrier type
Message-ID: <Z3JFyniivEd716aX@pks.im>
References: <20241230042325.GA112439@coredump.intra.peff.net>
 <20241230042830.GC113400@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230042830.GC113400@coredump.intra.peff.net>

On Sun, Dec 29, 2024 at 11:28:30PM -0500, Jeff King wrote:
> One thread primitive we don't yet support is a barrier: it waits for all
> threads to reach a synchronization point before letting any of them
> continue. This would be useful for avoiding the LSan race we see in
> index-pack (and other places) by having all threads complete their
> initialization before any of them start to do real work.
> 
> POSIX introduced a pthread_barrier_t in 2004, which does what we want.
> But if we want to rely on it:
> 
>   1. Our Windows pthread emulation would need a new set of wrapper
>      functions. There's a Synchronization Barrier primitive there, which
>      was introduced in Windows 8 (which is old enough for us to depend
>      on).
> 
>   2. macOS (and possibly other systems) has pthreads but not
>      pthread_barrier_t. So there we'd have to implement our own barrier
>      based on the mutex and cond primitives.
> 
> Those are do-able, but since we only care about avoiding races in our
> LSan builds, there's an easier way: make it a noop on systems without a
> native pthread barrier.

I think this is fine for a first iteration. If we ever feel the need for
having barriers anywhere else for actual correctness we can iterate on
the solution and provide wrappers for those platforms.

> This patch introduces a "maybe_thread_barrier" API. The clunky name
> (rather than just using pthread_barrier directly) should hopefully clue
> people in that on some systems it will do nothing. It's wired to a
> Makefile knob which has to be triggered manually, and we enable it for
> the linux-leaks CI jobs (since we know we'll have it there).
> 
> There are some other possible options:
> 
>   - we could turn it on all the time for Linux systems based on uname.

Tiniest of nits: these are all full sentences, which should start with
an upper-case letter.

>     But we really only care about it for LSan builds, and there is no
>     need to add extra code to regular builds.
> 
>   - we could turn it on only for LSan builds. But that would break
>     builds on non-Linux platforms (like macOS) that otherwise should
>     support sanitizers.

Mh. I'm not a huge fan of having extra code for just a subset of our
builds and think that having the code generally enabled on platforms
that support it is preferable to reduce the number of build variants.
But...

>   - we could trigger only on the combination of Linux and LSan together.
>     This isn't too hard to do, but the uname check isn't completely
>     accurate. It is really about what your libc supports, and non-glibc
>     systems might not have it (though at least musl seems to).
> 
>     So we'd risk breaking builds on those systems, which would need to
>     add a new knob. Though the upside would be that running local "make
>     SANITIZE=leak test" would be protected automatically.

... this is a fair remark. So I dunno.

> And of course none of this protects LSan runs from races on systems
> without pthread barriers. It's probably OK in practice to protect only
> our CI jobs, though. The race is rare-ish and most leak-checking happens
> through CI.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Makefile       |  7 +++++++
>  ci/lib.sh      |  1 +
>  thread-utils.h | 17 +++++++++++++++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 97e8385b66..2c6dad8a75 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -141,6 +141,10 @@ include shared.mak
>  #
>  # Define NO_PTHREADS if you do not have or do not want to use Pthreads.
>  #
> +# Define THREAD_BARRIER_PTHREAD if your system has pthread_barrier_t. Barrier
> +# support is optional and is only helpful when building with SANITIZE=leak, as
> +# it is used to eliminate some races in the leak-checker.
> +#
>  # Define NO_PREAD if you have a problem with pread() system call (e.g.
>  # cygwin1.dll before v1.5.22).
>  #
> @@ -2079,6 +2083,9 @@ ifdef NO_PTHREADS
>  else
>  	BASIC_CFLAGS += $(PTHREAD_CFLAGS)
>  	EXTLIBS += $(PTHREAD_LIBS)
> +	ifdef THREAD_BARRIER_PTHREAD
> +		BASIC_CFLAGS += -DTHREAD_BARRIER_PTHREAD
> +	endif
>  endif
>  
>  ifdef HAVE_PATHS_H

Okay. The Meson equivalent would be:

diff --git a/meson.build b/meson.build
index a0654a3f24..db4c1e6929 100644
--- a/meson.build
+++ b/meson.build
@@ -788,6 +788,10 @@ threads = dependency('threads', required: false)
 if threads.found()
   libgit_dependencies += threads
   build_options_config.set('NO_PTHREADS', '')
+
+  if get_option('b_sanitize').contains('leak') and compiler.has_function('pthread_barrier_init', dependencies: threads)
+    libgit_c_args += '-DTHREAD_BARRIER_PTHREAD'
+  endif
 else
   libgit_c_args += '-DNO_PTHREADS'
   build_options_config.set('NO_PTHREADS', '1')

> diff --git a/thread-utils.h b/thread-utils.h
> index 4961487ed9..3df5be9916 100644
> --- a/thread-utils.h
> +++ b/thread-utils.h
> @@ -53,5 +53,22 @@ int dummy_pthread_init(void *);
>  int online_cpus(void);
>  int init_recursive_mutex(pthread_mutex_t*);
>  
> +#ifdef THREAD_BARRIER_PTHREAD
> +#define maybe_thread_barrier_t pthread_barrier_t
> +#define maybe_thread_barrier_init pthread_barrier_init
> +#define maybe_thread_barrier_wait pthread_barrier_wait
> +#define maybe_thread_barrier_destroy pthread_barrier_destroy
> +#else
> +#define maybe_thread_barrier_t int

Out of curiosity: why did you pick a define here and not a typedef?

> +static inline int maybe_thread_barrier_init(maybe_thread_barrier_t *b UNUSED,
> +					    void *attr UNUSED,
> +					    unsigned nr UNUSED)
> +{
> +	errno = ENOSYS;
> +	return -1;
> +}
> +#define maybe_thread_barrier_wait(barrier)
> +#define maybe_thread_barrier_destroy(barrier)

So the way these wrappers are implemented it is not possible to check
for errors of `pthread_barrier_init()` et al. When the implementation
exists we do have return codes, but if it's stubbed out we don't.

I think we should align these two implementations so that it does become
possible to check for errors, or otherwise we wouldn't be using the
pthread APIs correctly. It does raise the question though whether we
should really return `-1` in the stubbed-out variant or whether we
should instead pretend as if things were alright.

An alternative would be to die in case the pthread-functions return an
error.

Patrick
