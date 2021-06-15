Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DBAC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 08:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F13226141B
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 08:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhFOJBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 05:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbhFOJBq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 05:01:46 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F90C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 01:59:42 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 5so42574286ioe.1
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 01:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4xbvXsd0PMDKJOozTC24w+Tokc6OiKKvOR7qmcAKgtA=;
        b=PgiD8ygIa57vwrNMok4JvB2Z0PYhvGEHEsjhvG76xAcom3EZ4PoAztuUZR9XpDSe2n
         NJ1Bv99vyxO9Rb7BfdGqBzS2odDUwC4L+61Y6Bsbxl49tJ8zFtIYBwm8yhrXxZNm0Lih
         NBciNmHD+0EJ/w1cT6dM8wNOBtpquHWfiGaB25NLY1r7/Dvz+ztjyDt3Z7+GojbF8Nps
         ms9r739Xy/bXWX4FGzWi8y3JBNFjUTYiVWfaTNdqkxEMHkE6kz+d2jnV50fieZuzV9LW
         Y9ioltKJ2BTjGtePwPbAea9HSC5Vk2Ihiv8fcGO4eh2dNA07yNqhxGtoC/L7actROxQo
         w6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4xbvXsd0PMDKJOozTC24w+Tokc6OiKKvOR7qmcAKgtA=;
        b=MMlCpHTPTqMh7lNx1Gd7cVJhTU+XXoDk+0GxfMugKWksars11yxL6FT3DWK4Kf0bfZ
         n6PRfUB0zKCPTV29cQ75T9wExlDuvyyQrLYFOPErHjUe/sfqeYT5fHVzFn4XvEfUwi8M
         SDosbjvi3dwjV6ZI1O3K8l8X4caaYKn+/Dfy15rVVBJvQ+xZJXIYgmHcKF8gXGXvrua7
         a9P8GyVYeKC9r/bFHdReZB3df8D0DZp/euOgwGVWxwqcCTABkCYycKPMR9NUjXvV8++G
         ksCHvwhHWbeS7F3plNGv6N0E/fy4FwaJUig4PoheBpMGrioTc2W8Lgn1vCi/UOF4MZaJ
         X/zQ==
X-Gm-Message-State: AOAM533JkvefWT1A2FaJzDiOzbvxGrUZmsVYRATgj5GMgqHFh8UtC+X3
        9NXYXb/g7Mwakjyh91VWJevJ++ucrU+6tDMZa9JfzWUNOjpIo4PW
X-Google-Smtp-Source: ABdhPJxwxEx+F0jwnxQJhiQZip4RBfrmgKSYdWolakjMtwcECYvuASB+gtevk0PmlCjLM8AwVjfy7zwgn1ca5xE7ktI=
X-Received: by 2002:a02:9a17:: with SMTP id b23mr20802293jal.10.1623747582357;
 Tue, 15 Jun 2021 01:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8QHL-6-DxoRKtx5cVp_DePxtWYU4CuBweYfCG1hGZZhaA@mail.gmail.com>
 <CAP8UFD0jiZuPvO-oYXw9PmVQ56tpYc9nxUxAjPQrc2f1qwEqUQ@mail.gmail.com>
In-Reply-To: <CAP8UFD0jiZuPvO-oYXw9PmVQ56tpYc9nxUxAjPQrc2f1qwEqUQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 15 Jun 2021 16:59:31 +0800
Message-ID: <CAOLTT8QS7bG5M2Ro+vApUDtOgjxgrpUg5Mgp+tOQgyqwpENN1Q@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 4
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=
=8814=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=884:02=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Sun, Jun 13, 2021 at 4:17 PM ZheNing Hu <adlternative@gmail.com> wrote=
:
>
> > In addition, some scripts like `printf "%b" "a\0b\0c" >blob1` will
> > be truncated at the first NUL on a 32-bit machine, but it performs
> > well on 64-bit machines, and NUL is normally stored in the file.
> > This made me think that Git's file decompression had an error on
> > a 32-bit machine before I used Ubuntu32's docker container to
> > clone the git repository and In-depth analysis of bugs... In the end,
> > I used `printf "a\0b\0c"` to make 32-bit machines not truncated
> > in NUL. Is there a better way to write binary data onto a file than
> > `printf` and `echo`?
>
> You might want to take a look at t/t4058-diff-duplicates.sh which has
> the following:
>
> # make_tree_entry <mode> <mode> <sha1>
> #
> # We have to rely on perl here because not all printfs understand
> # hex escapes (only octal), and xxd is not portable.
> make_tree_entry () {
>        printf '%s %s\0' "$1" "$2" &&
>        perl -e 'print chr(hex($_)) for ($ARGV[0] =3D~ /../g)' "$3"
> }
>

Yes, perl can indeed do this, and perhaps python can do it too.
However, python may need to consider portability issues.

> > Since I am a newbie to docker, I would like to know if there is any
> > way to run the Git's Github CI program remotely or locally?
>
> There are scripts in the ci/ directory, but yeah it could help if
> there was a README there.
>

Thanks, I probably know how to use it.
As you said in another article, GitHub-Travis CI, this is exactly what I ne=
ed.

> > In the second half of this week, I tried to make `cat-file` reuse the
> > logic of `ref-filter`. I have to say that this is a very difficult proc=
ess.
> > "rebase -i" again and again to repair the content of previous commits.
> > squeeze commits, split commits, modify commit messages... Finally, I
> > submitted the patches to the Git mailing list in
> > [[PATCH 0/8] [GSOC][RFC] cat-file: reuse `ref-filter`
> > logic](https://lore.kernel.org/git/pull.980.git.1623496458.gitgitgadget=
@gmail.com/).
> > Now `cat-file` has learned most of the atoms in `ref-filter`. I am very
> > happy to be able to make git support richer functions through my own co=
de.
> >
> > Regrettably, `git cat-file --batch --batch-all-objects` seems to take u=
p
> > a huge amount of memory on a large repo such as git.git, and it will
> > be killed by Linux's oom.
>
> In the cover letter of your patch series you say:
>
> "There is still an unresolved issue: performance overhead is very large, =
so
> that when we use:
>
> git cat-file --batch --batch-all-objects >/dev/null
>
> on git.git, it may fail."
>
> Is this the same issue? Is it only a memory issue, or is your patch
> series also making things slower?
>

Yes, they are talking about the same thing, the memory usage is too large.
Of course I should check for memory leaks first. However, this is mainly
caused by changes in the strategy of cat-file printing object data.

The original cat-file needs do fewer (one time) copies in read_object_file(=
)
or stream_blob(), now cat-file needs do four time (or more) copy in
oid_object_info_extended(), grab_sub_body_contents(), append_atom(),
and pop_stack_element().

> > This is mainly because we will make a large
> > number of copies of the object's raw data. The original `git cat-file`
> > uses `read_object_file()` or `stream_blob()` to output the object's
> > raw data, but in `ref-filter`, we have to use `v->s` to copy the object=
's
> > data, it is difficult to eliminate `v->s` and print the output directly=
 to the
> > final output buffer. Because we may have atoms like `%(if)`, `%(else)`
> > that need to use buffers on the stack to build the final output string
> > layer by layer,
>
> What does layer by layer mean here?
>

In the case of using multiple nested %(if) %(else), the data may be
copied to the
"previous level" buffer of the stack through pop_stack_element().

> > or the `cmp_ref_sorting()` needs to use `v->s` to
> > compare two refs. In short, it is very difficult for `ref-filter` to re=
duce
> > copy overhead. I even thought about using the string pool API
> > `memintern()` to replace `xmemdupz()`, but it seems that the effect
> > is not obvious. A large number of objects' data will still reside in me=
mory,
> > so this may not be a good method.
>
> Would it be possible to keep the data for a limited number of objects,
> then print everything related to these objects, free their data and
> start again with another limited number of objects?
>

"limited number of objects", is this want to reduce the overhead of free()?
May be a good solution. But I think, can we just only release the memory
of an object after printing it instead of free() together like ref_array_cl=
ear()
does?

> > Anyway, stay confident. I can solve these difficult problems with
> > the help of mentors and reviewers. `:)`
>
> Sure :-)

Thanks!
--
ZheNing Hu
