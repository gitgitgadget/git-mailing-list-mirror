Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C677C433ED
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 14:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C1061263
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 14:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhDCO14 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 10:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhDCO1z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 10:27:55 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0BDC0613E6
        for <git@vger.kernel.org>; Sat,  3 Apr 2021 07:27:52 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id u12so41872ilj.2
        for <git@vger.kernel.org>; Sat, 03 Apr 2021 07:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4iuHdU1FVyFkcH33QN5NiSJsDsjHJLu90vu75RrVr5I=;
        b=bSNKNyd13VFo/kBPAGryd1Azp2I29hatxwM7wP6OU0hCsQGDVnOQRY6AUln24R4eMB
         Wp7qJiG8enWNF+Mad5DF6sROPPGAC9kLii2Ta2yKEqvzS3yWwpQS2ELGqfGx9KTABiZ6
         a9k7KbRvplPrHvMw+teSh35rJK+6Ug8FVATedU42X+SdZ65+T3S/U4uW8PQoJxnphYDj
         cQSvKz6HXNc+jFWxvjl4ZJh0uEi9DAGNfqHHc8PISon88n3pMDBhaA8bKUsqYPHbTfBZ
         tywAXaVHkFMkxPxRUB7YkDm89g9KWtat0JghxuxnpOTCVhHWwhhrolSQCpDsrlg3Weiu
         KA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4iuHdU1FVyFkcH33QN5NiSJsDsjHJLu90vu75RrVr5I=;
        b=MGVRGBuewtrU1clL4BQsS37OYL7Ge822yoTtYGT56qsOCq7avYxogP3+m/bm+b9bnT
         wiAiiAu+6wZMYD03HDLYgb1yypRphDQQ0GGTPNxeO+IRJQsnJx4DWIhbR3cH0Rb5Nf/M
         Z1VmJkM1VhDiVF1KwkMLcFfi3npQ+GkN3rsJjesvPEr8rq5534BxSSAAmGYuqDJVmBXY
         teMYAGivwZMlCKFf0MKxltu3Ac8gG9HYEPdg9A6zuTdxZeECpI5Z3kVa2kWFy2YG8pac
         75i5lnt/zzQmomaglLnZXB3axWMC8mUCuAf9d9J984kPFKydy9rmqHAu8X/X8vizO+08
         ri3g==
X-Gm-Message-State: AOAM533VrMIXskbu4XKYWY8z1Wt0mL0oAQn9HSNr3IHVMJPTO5jAqMJt
        uq91fdoF2zThUjG/ilzvF/eObEXkc/7fbdxDZNI=
X-Google-Smtp-Source: ABdhPJyEhSv4y+GTJEoYo/2PaEIEdMgw2Pj5a4pxXUwS2RKvWa3fFEhr/U/Pjrv9RSx/sK5WjEDYfdeSIvTLNCnrlRI=
X-Received: by 2002:a05:6e02:19c6:: with SMTP id r6mr14342068ill.174.1617460071885;
 Sat, 03 Apr 2021 07:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RfE4nn5NnjZh7xuF09-5=+K+_j_2kP0327HVdR4x_wAQ@mail.gmail.com>
 <YGc6ybE1wD1ck0uB@coredump.intra.peff.net>
In-Reply-To: <YGc6ybE1wD1ck0uB@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 3 Apr 2021 22:27:39 +0800
Message-ID: <CAOLTT8R_kmdNhJaMjj60H0SEzs6-KrzTQhBHzShQ82aoDa5vzw@mail.gmail.com>
Subject: Re: GSoC Git Proposal Draft - ZheNing Hu
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        olyatelezhnaya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Peff,

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B44=E6=9C=882=E6=97=A5=E5=91=
=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:39=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Apr 02, 2021 at 05:03:17PM +0800, ZheNing Hu wrote:
>
> > * Because part of the feature of `git for-each-ref` is very similar to
> > that of `git cat-file`, I think `git cat-file` can learn some feasible
> > solutions from it.
> >
> > #### My possible solutions:
> >
> > 1. Same [solution](https://github.com/git/git/pull/568/commits/cc40c464=
e813fc7a6bd93a01661646114d694d76)
> > as Olga, add member `struct ref_format format` in `struct
> > batch_options`.
> > 2. Use the function
> > [`verify_ref_format()`](https://github.com/gitgitgadget/git/blob/84d06c=
dc06389ae7c462434cb7b1db0980f63860/ref-filter.c#L904)
> > to replace the first `expand_format()` for parsing format strings.
> > 3. Write a function like
> > [`format_ref_array_item()`](https://github.com/gitgitgadget/git/blob/84=
d06cdc06389ae7c462434cb7b1db0980f63860/ref-filter.c#L2392),
> > get information about objects, and use `get_object()` to grub the
> > information which we prefer (or just use `grab_common_value()`).
> > 4. The migration of `%(rest)` may require learning the handling of
> > `%(if)` ,`%(else)`.
>
> I think one thing to keep an eye on here is the performance of cat-file.
> The formatting code used by for-each-ref is rather slow (it may load
> more of the object details than is necessary, it is too eager to
> allocate intermediate strings, and so on). That's usually not _too_ big
> a problem for ref-filter, because the number of refs tends to be much
> smaller than the number of total objects. But I'd expect that moving to
> the ref-filter code would make something like:
>
>  git cat-file --batch-all-objects --batch-check=3D'%(objectname) %(object=
type)'
>
> measurably slower.
>

Forgive me for thinking about the whole question too simple. It seems that
there are a lot of points to think about in this project.

> IMHO the right path forward is not to try porting cat-file to use the
> ref-filter code, but to start first with writing a universal formatting
> module that takes the best of both implementations (and the commit
> pretty-printer):
>
>   - separate the format-parsing stage from formatting actual items, as
>     ref-filter does. This lets us have more complex formats without
>     paying a per-item runtime cost while formatting. This should also
>     allow us to handle multiple syntaxes for the same thing (e.g.,
>     ref-filter %(authorname) vs pretty.c %an).
>

This is a good suggestion.
Olga seems to have wanted to remove `mark_query` in `struct expand_data`,
I think she also wanted to separate the two parts.

The ref-filter uses `used_atom` as the result of parsing `%(atom)`, It=E2=
=80=99s
really worth learning.

>   - figure out which data will be needed for each item based on the
>     parsed format, and then do the minimum amount of work to get that
>     data (using "oid_object_info_extended()" helps here, because it
>     likewise tries to do as little work as possible to satisfy the
>     request, but there are many elements that it doesn't know about)
>

I have indeed noticed that `oid_object_info_extended()`
can get information about the object which we actually want.
In `cat-file.c`, It has been used in `batch_object_write()`, and
`expanding_atom()` specify what data we need.
In `ref-filter.c`, It has been used in `get_object()`.
I am not sure what you mean about "many elements that it
doesn't know about", For the time being, `cat-file` can get 5
kind of objects info it need.

Maybe you think that `cat-file` can learn some features in
`ref-filter` to extend the function of `cat-file --batch`?
E.g. %(objectname:short)? I think I may have a better
understanding of the topic of this mini-project now.
We may not want to port the logic of cat-file,but to learn some
design in `ref-filter`, right?

>   - likewise avoid doing any intermediate work we can; as much as
>     possible, format the result directly into a result strbuf, rather
>     than allocating many sub-strings and assembling them (as cat-file
>     does).
>

I guess you mean `scratch` in `batch_object_write()`
every time new content is added after `strbuf_reset`,
but refilter just append messages to `final_buf`.

>   - handle formats where the necessary item data may or may not be
>     present. E.g., if we're given a refname, then "%(refname)" makes
>     sense. But in cat-file we'd not have a refname, and just an object.
>     We should still be able to use the same formatting code to handle
>     "%(objecttype)", etc. Likewise for formats which require a specific
>     type (say %(authorname) for a commit, but the object is a blob).
>     Ref-filter does this to some degree for things like authorname, but
>     we'd be extending it to the case that we don't even have a refname.
>

I may not have a very deep understanding of some details.
On this issue, I think we can use `info_source` to invalidate interfaces th=
at
are not of the same type(only allow SOUCR_OTHER)

Let me summarize:
First part : Parsing any type of atoms, whether it is %an or %(authorname).
Second part : Find all functions that get objects information (which
`oid_object_info_extended()` can't get)
Third part : Optimize multiple small strings in cat-file into one `finnal_b=
uf`.
Forth part : Error handling for unsuitable atoms.

Que:
These task sound like the logic of `ref-filter`, so if I can
participate in this project
later, should I start with optimizing the logic of `ref-filter`, right?

> -Peff

Thank you so much!

--
ZheNing Hu
