Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7EAC433EF
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 00:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiAHASY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 19:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiAHASY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 19:18:24 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A68DC061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 16:18:23 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id q25so19489774edb.2
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 16:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8cH3jfmvQdW0PfKEaSdunIsyttQCEHffDWoUAYCkMjQ=;
        b=WvRKhbf05xskEQqHzpUMgB71YNaXo0q3VQS05x3z3nQxmo557DQvvPd4PcvmyIPlgB
         5lzMSsfSoZeKeQgiSpAAC5hPv8q4WY5n/zF5iL1DASaM94pK5mHm1Skc2CzYeny1otCq
         vCGiJfhL8GyJVUVPAY+HExrrSQPMKI+bGAT1T4hoigCO3x9huUydk6rOvqPL4QHaXxHX
         aa7H/9WfDzUh7OqiOCD24ykRYqKSi16YR46inCxlOYIMSb0c2OmZ0f1KkW5zw5f7ur9t
         eYEaWJ+iD3UA48ZN9xFWDke0JLfuaKiJyXZqMk3b1DMCGaEwqUZ40aP/DIdt/VGR8dn/
         /GBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8cH3jfmvQdW0PfKEaSdunIsyttQCEHffDWoUAYCkMjQ=;
        b=YM7i/fljpOPWX000BayMgGrD7PiSJM7pb+7jAFL9qIrrQN6N8EIkbnwLRDsfe5yZsm
         YL/A5vRE6tHF0Z92D/xoqdOgi8ov4pWJ42yUFAet+abcz24nW9oX28lVA4PVGX4MMCKK
         StA+v9OD1EZkxhC7EZwMVVy/ez3KLgvyfoBDy/rIW39ekqxCc5h0oD+hDZH3whgihCqq
         j+Ol0JLUOamKyS9R55gHudfavAxG+udvdr8awSyqPS1TqP4gNUPhIblTnhe9+ufpzOmd
         WN+StJljwacwAYK+Lw049HJOZnyH4C0kjjNI59yL8L329sk89nKFla5gCiWYWmFaBY+K
         VBAQ==
X-Gm-Message-State: AOAM5332vKm+V445z1TdiiPR3uNbZZY/YbDjxEN3/XhzxcMlMP1uOVkq
        jEY+nD5Sryibs3t2bRBXD0n2bf8UIyV2Wl8v/do=
X-Google-Smtp-Source: ABdhPJyNsjgo+kFNyP5JZKOucfCFGgI566CKqMEANiO+W51RUY7Vvz/uav3L8LM9UiAXvZyPo/jc++qm2HQ1U1ZYNvI=
X-Received: by 2002:a05:6402:190c:: with SMTP id e12mr66352153edz.153.1641601102165;
 Fri, 07 Jan 2022 16:18:22 -0800 (PST)
MIME-Version: 1.0
References: <20220105132324.6651-1-jrtc27@jrtc27.com> <YddjJ+uIQM34Gedo@nand.local>
 <xmqqh7agbiuq.fsf@gitster.g> <97D2AB55-0F8F-4C38-A5C6-1AAA43EA064A@jrtc27.com>
 <xmqqfsq09ziq.fsf@gitster.g> <YdeJ8Ub2Q0/c9kO2@camp.crustytoothpaste.net>
 <4D8B32AE-8316-4907-98F6-097901EC3DC0@jrtc27.com> <Ydea3EO7wrYc9/Ij@camp.crustytoothpaste.net>
 <xmqq7dbb9wcz.fsf@gitster.g> <40077881-e91a-dfba-5950-cdc03719264d@web.de>
 <xmqqzgo76xpj.fsf@gitster.g> <f40c1b47-9aad-2dcc-ceeb-5dee2b517cd8@web.de>
In-Reply-To: <f40c1b47-9aad-2dcc-ceeb-5dee2b517cd8@web.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 7 Jan 2022 16:18:10 -0800
Message-ID: <CABPp-BG3rwC2fy-1fu0GwzofUjaF2HbJOC79BNBHxSoVS-vNAQ@mail.gmail.com>
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 7, 2022 at 3:30 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
...
> --- >8 ---
> Subject: [PATCH] stable-qsort: avoid using potentially unaligned access
>
> Like in the previous patch for compat/qsort_s.c, remove the optimization
> of using an on-stack buffer to avoid small allocations.  This ensures
> maximum alignment for the array elements and simplifies the code a bit.
>
> The performance impact for the current callers is unlikely to be
> noticeable:
>
>  * compat/mingw.c::make_environment_block() uses ALLOC_ARRAY and
>    ALLOC_GROW several times already, so another allocation of up to 1KB
>    should not matter much.

Not familiar with this code, but that makes sense to me.

>  * diffcore-rename.c::diffcore_rename_extended() is called once per diff
>    or twice per merge, and those require allocations for each object and
>    more already.

Actually, this sort could be skipped entirely if it can determine all
renames early (either because they are found via exact matches, or
they aren't relevant for the merge result, or they are found via
basename comparisons).  This sort is only called when we have to
resort to the full quadratic pairwise comparisons between files, in
which case we're also slurping in full files, doing the diffcore-delta
work to convert each file's contents into a spanhash, and then
pairwise comparing spanhashes for every pairing of source &
destination files that remain.  That work would absolutely dwarf the
malloc of a kilobyte.  So I agree, it's not worth worrying about this
one.

>  * merge-ort.c::detect_and_process_renames() is called once per merge.
>    It's responsible for the two per-merge diffcore_rename_extended()
>    calls mentioned above as well, though.  So this is possibly the most
>    impacted caller.  Per-object allocations are likely to dwarf the
>    additional small allocations in git_stable_qsort(), though.

The particular sort call directly found in
detect_and_process_renames() was once nearly 30% of overall execution
time in merge-ort[1], but according to some local notes I kept, it
eventually dropped to about ~1% of overall execution time after
trivial directory resolution[2] (due to the fact that it could just
include some higher level directories and omit all the files
underneath them -- i.e. it had far fewer paths to sort).

Since I suspect your change here would generally just be a small
percentage of the overall git_stable_qsort() time (if it can even be
measured), and git_stable_qsort() time is a small percentage of
merge-ort runtime, I think any runtime differences here would be
negligible.

[1] https://lore.kernel.org/git/140c1e89e0ec69c5c5e8a99b632c1cf25c2325d4.16=
23168703.git.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/pull.988.v4.git.1626841444.gitgitgadget@gma=
il.com/

>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  stable-qsort.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/stable-qsort.c b/stable-qsort.c
> index 6cbaf39f7b..7ff12467cd 100644
> --- a/stable-qsort.c
> +++ b/stable-qsort.c
> @@ -48,15 +48,9 @@ void git_stable_qsort(void *b, size_t n, size_t s,
>                       int (*cmp)(const void *, const void *))
>  {
>         const size_t size =3D st_mult(n, s);
> -       char buf[1024];
> -
> -       if (size < sizeof(buf)) {
> -               /* The temporary array fits on the small on-stack buffer.=
 */
> -               msort_with_tmp(b, n, s, cmp, buf);
> -       } else {
> -               /* It's somewhat large, so malloc it.  */
> -               char *tmp =3D xmalloc(size);
> -               msort_with_tmp(b, n, s, cmp, tmp);
> -               free(tmp);
> -       }
> +       char *tmp;
> +
> +       tmp =3D xmalloc(size);
> +       msort_with_tmp(b, n, s, cmp, tmp);
> +       free(tmp);
>  }
> --
> 2.34.1

Patch looks good to me.  Reviewed-by: Elijah Newren <newren@gmail.com>
