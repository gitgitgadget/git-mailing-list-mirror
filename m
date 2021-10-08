Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384E0C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 07:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D55361029
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 07:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhJHHrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 03:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbhJHHrK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 03:47:10 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37064C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 00:45:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r18so32970891edv.12
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 00:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=YaO8DELHiQ310fzjYuCrM1F/0eFbAV3DHa2N3FkjPR4=;
        b=jmRigb4Kfqm4oPKkY0HaUZnO0EB8PzxiWimXIKwLczqpvpIqIGNvmnzK+OxehCsF58
         VbgWT7ce5iYXS+g8sB6GR5xW7chkH29bM6Pz62Fvoask6x/GxgpL97FAV+YDS50AYxX2
         Ve5qWLEbKEmN5iHBDjJOsWM+lIMx1ghJ3UfQPUxQMY4cY8tEtyN0ghiUAkEiptb8Xqdo
         6BPOl2hjZmje2ftM50u6aJN2uOiX4SNfJi7brve8DrMbTRcnv1p7y5m4GZSgXVLWuVer
         vDYK4y2ZZOrJ+HGmqafth0lqMiHZ8ywD9LLiKs+HE3v7KJpx0IuuMNQBAnUyNxBecrES
         Tjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=YaO8DELHiQ310fzjYuCrM1F/0eFbAV3DHa2N3FkjPR4=;
        b=2ulrS4HSbkVTkbsA9t8jKJZ8iOz+ExvikiQCT4alHCqSipBnH8t+MCM4MWZ4REFpWi
         aKh/g0iImPbGfVSQxpOBzGNVMhCUokJGiTOSqAYZUBLv2QLZH8/B6Co7S5qUBz8UNZY1
         ZI/GkhQ2a5X/FqGf3cjVk+xPQasYerxVmNQxoURZsrbKp16okEMjhTFqpARXllSMWO2q
         hQ6JpBcCGxgdHEt9niXSu6UwS7k5DrAaemjmHF+NA06eHRu8RVVLKz6WyjnPbQBTBJLv
         H/OwnreuG7xUpgAhASVYs2GcXUmQm05/n4KUxoVFHjZD6J/TTVVTMwmx6fTv0DIIMrXF
         F6Vg==
X-Gm-Message-State: AOAM53126E+i9dOmTB+vkuKyqLIAWAFVbnmf72ynRJkrC6r92WQZHyzJ
        iwCIJPRxs0JlrtoP8HE+Idc=
X-Google-Smtp-Source: ABdhPJzN+o0sywYdgrtwvElipkcxkX9pmNT0bQiLdu4vwK7w7kJCxSIvaDKQ4ocO+G8VJwxlTY2+jQ==
X-Received: by 2002:a17:906:32d9:: with SMTP id k25mr2343975ejk.290.1633679113574;
        Fri, 08 Oct 2021 00:45:13 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r6sm698372edd.89.2021.10.08.00.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 00:45:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/9 v2] test-mergesort: use repeatable random numbers
Date:   Fri, 08 Oct 2021 09:23:21 +0200
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
 <522fba5e-1048-3377-45c1-7107b55dc6e1@web.de> <xmqq7dew7aqd.fsf@gitster.g>
 <87o887q0s9.fsf@evledraar.gmail.com>
 <850aa059-61d9-0eba-5809-e0c27a19dfb4@web.de> <xmqqee9210a1.fsf@gitster.g>
 <a3eeb255-56e3-eb22-ebf7-e9f04c95fa44@web.de>
 <b73452fa-f5b0-0ab4-25e8-7494637c49f5@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <b73452fa-f5b0-0ab4-25e8-7494637c49f5@web.de>
Message-ID: <87tuhsez93.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 08 2021, Ren=C3=A9 Scharfe wrote:

> Use MINSTD to generate pseudo-random numbers consistently instead of
> using rand(3), whose output can vary from system to system, and reset
> its seed before filling in the test values.  This gives repeatable
> results across versions and systems, which simplifies sharing and
> comparing of results between developers.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Change: Use uint32_t to avoid relying on unsigned int being exactly
> 4 bytes wide.  D'oh!
>
>  t/helper/test-mergesort.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
> index 29758cf89b..c6fa816be3 100644
> --- a/t/helper/test-mergesort.c
> +++ b/t/helper/test-mergesort.c
> @@ -2,6 +2,12 @@
>  #include "cache.h"
>  #include "mergesort.h"
>
> +static uint32_t minstd_rand(uint32_t *state)
> +{
> +	*state =3D (uint64_t)*state * 48271 % 2147483647;
> +	return *state;
> +}
> +
>  struct line {
>  	char *text;
>  	struct line *next;
> @@ -60,8 +66,9 @@ static void dist_sawtooth(int *arr, int n, int m)
>  static void dist_rand(int *arr, int n, int m)
>  {
>  	int i;
> +	uint32_t seed =3D 1;
>  	for (i =3D 0; i < n; i++)
> -		arr[i] =3D rand() % m;
> +		arr[i] =3D minstd_rand(&seed) % m;
>  }
>
>  static void dist_stagger(int *arr, int n, int m)
> @@ -81,8 +88,9 @@ static void dist_plateau(int *arr, int n, int m)
>  static void dist_shuffle(int *arr, int n, int m)
>  {
>  	int i, j, k;
> +	uint32_t seed =3D 1;
>  	for (i =3D j =3D 0, k =3D 1; i < n; i++)
> -		arr[i] =3D (rand() % m) ? (j +=3D 2) : (k +=3D 2);
> +		arr[i] =3D minstd_rand(&seed) % m ? (j +=3D 2) : (k +=3D 2);
>  }
>
>  #define DIST(name) { #name, dist_##name }

Just to your upthread:

    "Right, so we'd need to ship our own random number generator."

I don't really think this matters in either case here, and if anything a
flaky failure in this test would quickly point us in the right
direction, as opposed to say having the N test_expect_success being run
in rand() order or whatever.

If we'd like results we can compare across platforms we're surely better
of here running this in a loop with different per-platform srand()
values N times for some high value of N, than we are in picking one
"golden" distribution.

But just on srand() and rand() use more generally in the test suite: I
think it's fine to just assume that we can call srand()/rand() and get
"predictable" results, because what we're really after in most cases is
to avoid hard-to-diagnose flakyness. If as a result of random
distribution we'll get a consistent failure on one OS (or the flakyness
is just OpenBSD...).

Also generally: If you'd like "portable" rand() for a test just shell
out to perl. I ran this on various Perl versions (oldest 5.12) on Debian
Linux, OSX, Solaris & OpenBSD, all returned the same number for both:

    ruby -e 'srand(1); puts rand'; perl -E 'srand(1); say $^V; say rand'

Whereas a C program doing the same:
=20=20=20=20
    #include <stdio.h>
    #include <stdlib.h>
=20=20=20=20
    int main(void)
    {
            srand(1);
            printf("rand =3D %d\n", rand());
            return 0;
    }

Returns different numbers an all, and on OpenBSD the number is different
each time, per their well-known non-standard srand()/rand() behavior.
