Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46314C4321E
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 21:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiLEVDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 16:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiLEVDU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 16:03:20 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9722B251
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 13:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1670274073; bh=1b+mvNaN9942eiictKr8Cmz3MU4HKV51DZgm7veAlIc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Tmg5uHAzUUmdk08lfeCvo9IyAyZA/dUFPss/UT6LrPZXxZ2Wm79EKNqjTSurJW/XJ
         cdZOdqR7CIGcqxGv3WYeIWHBWyKXuKzAuOeRAAmdpMfe1+itR4suc5UdLUgl+5UVH9
         lSlG4uAYbHRM6Cu78zRs63aRxBSE1hOZp4u7B8OKeEcqHFkJOi7MbNUHx982NYUhqU
         Fy+3CHwPfFi6sd6Bw8uI+0nvheOtpV/fwbVamdrvEMoUq8AoyUigEYOCsErTVlpRb8
         wBLHGic9JLhLT0VjtYEb202WyuzD/1yg+xlQyryFCTgqbrMTGE8S0OgTgB7atoVN1T
         nC6YJmV6sTyNQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M59nK-1p1C7p0bA4-001G4V; Mon, 05
 Dec 2022 22:01:13 +0100
Message-ID: <a8e33b1e-1056-5f75-55b5-65c0bceef3ca@web.de>
Date:   Mon, 5 Dec 2022 22:01:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH] git-compat-util.h: introduce CALLOC(x)
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JeJhHaRMak9PtDrHYZbkfSONk+Jr2nj/7PqxCorFFAZFKApagBU
 tCxakQAOUaAz0Qn3sc2CsYDJWM5e2oYBGQqbQNUHDAzuC+DiQkOnDFgQV6DchD+rmL0R3WR
 Yr2QII0rJA0cH+rAvedgYudKaiFL0JA2iZGfsh1v+gw8DA0hbG38PpYq8sWIjz5x6YZhYUH
 xrz2hEDiUsEyyWDlHwqyQ==
UI-OutboundReport: notjunk:1;M01:P0:SRMZIa53KZI=;2lBFM+mcPIKNXlfwgBH+Fr6LBPy
 DcYjKVxTnZGH9zOkrXkwWmaoOQELJ+k/dQ3gXxUnVmn5H/Dw4RXqMcDS7bzjlE2MTlbQM2Sx9
 JaVhKfOA8Trz1c1dU7jsCAevr4VjQxFQMyu8XcD1ytMTTUwPeXIf95Oysn6JZuIH1zQ0tXScc
 2ylGVUvgQpR0EjdpUi8kEHHyr3Q0+OLESRFtuXp63EfYtRebFEIUof/LKKiVT3QmJItcLwW3Z
 5Hgs8TmOyA5Y2wt7KpRelLpjIr9wWOGgwEZ/ervw/KW7rj/ZyRwp/H78yAaqpVKRUz5YBBDFv
 F4GmKw85ryzdwS/kH/HCS6VOpk4rz4n1Z93A2cDX3x4PlCFaWGbQQ0B1kaMfciJOCIv92mibI
 Q86whIgYFvhcJc8zhda/SfTCPgm0CueNBl0z0HkrcSVZpguUVRHPipvuAJTmVRjtXEQxHewcI
 XXQmAvGkSM92PYPWMr/IJvcncEh2Hs5rIhTZWlbHCI+mOTtwnOPxH//OGmjpPzT4dQCVNSmP2
 xq/QHALdotImt0ptKHfV/ONeGP7vzKaTYrtS3ED14HH958NDCCISLTBGyKecU81KfzTm4drI9
 Crt34ZG6rO5gIzuJvKa7cOWXHdBpNhcyT6e3QN+GhoF929cYFjEZKVZ1TJg8n6/zOrY7IEtyi
 GOestK4shmGO8urgDedk3vN1R2qilUqw5Tg/X+KUUZZr8opjIk4wgS+5HbJVDkU82paZJmTOb
 dC/hTweWewGM5yZwi3o1nMcLD5scFBk8o1Mc0zzqweYExBHTnE+EgsLWnB5i37Zk8S7wz3ma6
 kf79Pthoz2/LING3zAhbC0kVXYuvRtEXX2SntmhikTn7RL3VNMfSNl2vzOh2h2L5eS+ByqV21
 uh2WBYzq9DE4B/22SSIPHDmRWDufS9sBj2Z98eXP/9B53KRdIk1XT/BILbe1IOVOS0BxWD2OO
 ibDVVHpNYJ1jEyiL+q6s/0Wx0Fw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.12.22 um 19:54 schrieb Taylor Blau:
> When zero-initializing a struct without the use of static initializers
> like "{ 0 }", it is common to write one of:
>
>     T *ptr =3D xcalloc(1, sizeof(T));
>     T *ptr =3D xcalloc(1, sizeof(*ptr));
>
> These correctly initialize "*ptr" to the all-zeros value, but have a
> couple of drawbacks. Notably, both initializations are verbose, but the
> former is a foot-gun. If "*ptr"'s type changes to something other than
> "T", the programmer has to remember to update not only the type of the
> variable, but the right-hand side of its initialization, too.
>
> In git.git, it is sometimes common to write something like:
>
>     T *ptr;
>     CALLOC_ARRAY(ptr, 1);
>
> ...but that is confusing, since we're not initializing an array. Rather,
> we're using the CALLOC_ARRAY() macro to pretend like we are. But since
> the array length is 1, the effect is zero initializing a single element.

An object and a single-element array of objects allocated on the heap are
indistinguishable.  In that sense there is no confusion -- we are indeed
allocating a single-element array.  But if the intent is to only get one
thing then having to fill in 1 in the bulk order form is a bit tedious,
especially since this is the most common kind of request.  A shortcut for
the frequent case makes sense.

> Introduce a new variant, CALLOC(x), which initializes "x" to the
> all-zeros value, without exposing the confusing use of CALLOC_ARRAY(),
> or the foot-guns available when using xcalloc() directly.

AFAIK the first "c" in "calloc" is for "continuous", not "zeroed".  A
single object is always contiguous, so the "C" in "CALLOC" is
tautologic if read in that way.  It fits our naming scheme for
ALLOC_ARRAY and CALLOC_ARRAY, though, so that might not be much of a
problem.

And there are lots of occurrences of xmalloc(sizeof(T)) and
xmalloc(sizeof(*ptr)) that would benefit from the automatic size
inference of ALLOC_ARRAY -- an ALLOC macro would complement
CALLOC nicely.

> Write a Coccinelle patch which codifies these rules, but mark it as
> "pending" since the resulting diff is too large to include in a single
> patch:
>
>     $ git apply .build/contrib/coccinelle/xcalloc.pending.cocci.patch
>     $ git diff --shortstat
>      89 files changed, 221 insertions(+), 178 deletions(-)
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> This is a follow-up on [1], where introducing CALLOC(x) as the preferred
> alternative to CALLOC_ARRAY(x, 1) was first suggested.
>
> The patch is straightforward, and I am pretty sure that the Coccinelle
> rules are right, too ;-). But as a first-time Coccinelle user, any extra
> scrutiny on those bits would be appreciated.
>
> The main point of discussion I think is whether we should consider
> adopting this rule. I am biased, of course, but I think that we should.
>
> In any case, we should focus our efforts on polishing v2.39.0, but I
> wanted to send this out to the list before I forgot about it.
>
> [1]: https://lore.kernel.org/git/Y1MrXoobkVKngYL1@coredump.intra.peff.ne=
t/
>
>  contrib/coccinelle/xcalloc.pending.cocci | 21 +++++++++++++++++++++
>  git-compat-util.h                        |  8 ++++++++
>  2 files changed, 29 insertions(+)
>  create mode 100644 contrib/coccinelle/xcalloc.pending.cocci
>
> diff --git a/contrib/coccinelle/xcalloc.pending.cocci b/contrib/coccinel=
le/xcalloc.pending.cocci
> new file mode 100644
> index 0000000000..83e4ca1a68
> --- /dev/null
> +++ b/contrib/coccinelle/xcalloc.pending.cocci
> @@ -0,0 +1,21 @@
> +@@
> +type T;
> +T *ptr;
> +@@
> +- ptr =3D xcalloc(1, \( sizeof(T) \| sizeof(*ptr) \) )
> ++ CALLOC(ptr)
> +
> +@@
> +type T;
> +identifier ptr;
> +@@
> +- T ptr =3D xcalloc(1, \( sizeof(T) \| sizeof(*ptr) \) );
> ++ T ptr;
> ++ CALLOC(ptr);

This rule would turn this code:

	struct foo *bar =3D xcalloc(1, sizeof(*bar));
	int i;

... into:

	struct foo *bar;
	CALLOC(bar);
	int i;

... which violates the coding guideline to not mix declarations and
statements (-Wdeclaration-after-statement).

> +
> +@@
> +type T;
> +T *ptr;
> +@@
> +- CALLOC_ARRAY(ptr, 1)
> ++ CALLOC(ptr)
> diff --git a/git-compat-util.h b/git-compat-util.h
> index a76d0526f7..827e5be89c 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1107,6 +1107,14 @@ static inline void move_array(void *dst, const vo=
id *src, size_t n, size_t size)
>  		memmove(dst, src, st_mult(size, n));
>  }
>
> +/*
> + * Like CALLOC_ARRAY, but the argument is treated as a pointer to a
> + * single struct.
> + *
> + * Preferable over xcalloc(1, sizeof(...)), or CALLOC_ARRAY(..., 1).
> + */
> +#define CALLOC(x) (x) =3D CALLOC_ARRAY((x), 1)
> +
>  /*
>   * These functions help you allocate structs with flex arrays, and copy
>   * the data directly into the array. For example, if you had:
> --
> 2.38.0.16.g393fd4c6db

