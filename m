Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F74AC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 13:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbiBPNii (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 08:38:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiBPNih (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 08:38:37 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AB52A39D3
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 05:38:25 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id bg10so2371006ejb.4
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 05:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=pARkPx/OZ5Z3CubsQdXL/gN+NZDFmjguCsEJIw/M1l0=;
        b=QOs7Twwbxwww7N4t2JlAihYOdPGXWB9yVdHbGnAo7NYEWXLHMGG/PvTSHq/w4kSm6K
         xNgbBz2+hXpimOVK4brPPfavdioCowHyNsLv5G5wg0Izkm6WMDlpTLreLc5ujJ7oWAKp
         7b3DF8JdEJXvwLh/XoFND9ExgdJLTVBgtdFDPU8778a1P1YLmQshCeDDyjGa+PECiDOl
         Dg5QiuQIePE+eucwgpvjGTAwgd3twi0ppAFNlbwTnSlcHnISAef+57jeg3eTjx/ovPQ5
         iLqaV5eVY1Sn3Lc32s74TfNG/IPc/SKTluBoRnvGnEuW4fS/E43A6GL9BttobLADBssX
         DzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=pARkPx/OZ5Z3CubsQdXL/gN+NZDFmjguCsEJIw/M1l0=;
        b=3wh9K1qQ3Co1nW/GwM+XpCz4b1a5o28Ujsa4zkaI7GsYOdw8SJKC2CgoTkM0DaFPeB
         kqphkph3gDteGfOvLBmgIs/KzTSTkX98IUJBWedh8Jv1D0wXn/qsp2EVQywyPP5ZKZ66
         DhqQJnvPn67y/2oDh5kqsRpkg9/qKG6LY3nULWoe1pym2+wXOt1gYQkM3Do61oI8gUVJ
         9gof82r8ArVy6PtAxwpvMNB2R3dlNmZOZ7fl+jL5jO+emQbvBjuGRZ/vWwlvnWcjaaBm
         4/mii7IN/Vte42EykGkcIG9WYTKH9EQtnREPkD7F/YCz5pIl57FQKI53lIaJL1A5hLhz
         WB0A==
X-Gm-Message-State: AOAM532hAuqt8/0vKJpQD06w6Q0VFyoPSxus3TKjc2e4jUObqCUVJD4m
        xjql3jjj58E/coybxvXqt88=
X-Google-Smtp-Source: ABdhPJxNvyTJjMunhqT7M40GXCD86zqgG5GLDovmb1UZtskkujQnsS9oOOtlkLoQWCPxRmlBuT0IVg==
X-Received: by 2002:a17:906:6144:b0:6cf:bb2e:a2e1 with SMTP id p4-20020a170906614400b006cfbb2ea2e1mr2415304ejl.299.1645018703706;
        Wed, 16 Feb 2022 05:38:23 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p4sm11900021ejm.47.2022.02.16.05.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 05:38:23 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nKKVi-003M7X-Km;
        Wed, 16 Feb 2022 14:38:22 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Edward Thomson <ethomson@edwardthomson.com>, git@vger.kernel.org,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH 1/1] xdiff: provide indirection to git functions
Date:   Wed, 16 Feb 2022 14:27:27 +0100
References: <20220209012951.GA7@abe733c6e288>
 <20220209013354.GB7@abe733c6e288>
 <220216.86wnhvvgeh.gmgdl@evledraar.gmail.com>
 <7e6385f8-f25d-69f5-edae-6f5d6f785046@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <7e6385f8-f25d-69f5-edae-6f5d6f785046@gmail.com>
Message-ID: <220216.86leybszht.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 16 2022, Phillip Wood wrote:

> On 15/02/2022 23:40, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Wed, Feb 09 2022, Edward Thomson wrote:
>>=20
>>> Provide an indirection layer into the git-specific functionality and
>>> utilities in `git-xdiff.h`, prefixing those types and functions with
>>> `xdl_` (and `XDL_` for macros).  This allows other projects that use
>>> git's xdiff implementation to keep up-to-date; they can now take all the
>>> files _except_ `git-xdiff.h`, which they have customized for their own
>>> environment.
>> It seems sensible to share code here, but...
>>=20
>>> +#ifndef GIT_XDIFF_H
>>> +#define GIT_XDIFF_H
>>> +
>>> +#define xdl_malloc(x) xmalloc(x)
>>> +#define xdl_free(ptr) free(ptr)
>>> +#define xdl_realloc(ptr,x) xrealloc(ptr,x)
>> ...I don't understand the need for prefixing every function that may
>> be
>> used from git.git with xdl_*. In particular for these memory managing
>> functions shouldn't this Just Work per 8d128513429 (grep/pcre2: actually
>> make pcre2 use custom allocator, 2021-02-18) and cbe81e653fa
>> (grep/pcre2: move back to thread-only PCREv2 structures, 2021-02-18)?
>> I.e. link-time use of free().
>
> I read that paragraph a couple of times and I'm still not sure I
> understand what you're saying. It is not unusual for libraries to
> define their own allocation functions and the code base is already
> using xdl_malloc etc so these defines seem quite reasonable. As you
> point out below we'd need wrappers for xmalloc() etc anyway so I'm not
> sure what the problem is.

That you generally don't need to define such wrappers for free() and
malloc(), because that's something you can handle at link-time.

This is current libgit2, which seems to have a version of this patch
integrated:
=20=20=20=20
    $ git reference; git -P grep '\bfree\(' src/xdiff
    c8450561d (Merge pull request #6216 from libgit2/ethomson/readme, 2022-=
02-13)
    src/xdiff/xmerge.c:             free(c);
    src/xdiff/xmerge.c:     free(next_m);

I.e. I think instead of having xdl_free(), xdl_regcomp() etc. it makes
sense to just slowly go in the other direction and call free(),
regcomp() etc. Since it seems we're going to be maintaining an xdiff
fork permanently.

>> Of course trivial wrappers would be needed for x*() variants...
>>=20
>>> +#define xdl_regex_t regex_t
>> This is a type that's in POSIX. Why do we need an xdl_* prefix for
>> it?
>>=20
>>> +#define xdl_regmatch_t regmatch_t
>> ditto.
>>=20
>>> +#define xdl_regexec_buf(p, b, s, n, m, f) regexec_buf(p, b, s, n, m, f)
>> But this is our own custom function, which brings me to...
>>=20
>>> +#define XDL_BUG(msg) BUG(msg)
>> ...unless libgit2 has a regexec_buf() or BUG() why do we need this
>> indirection? Let's just have xdiff() use a bug, and then either libgit2
>> will have a BUG() macro/function, or it'll fail at compile-time.
>> This seems to at least partly have been inspired by git.git's
>> 546096a5cbb (xdiff: use BUG(...), not xdl_bug(...), 2021-06-07), i.e. we
>> used to have an xdl_bug(), but now we just use BUG().
>> I then see on your libgit2 side 1458fb56e (xdiff: include new xdiff
>> from
>> git, 2022-01-29).
>> But why not simply?:
>>      #define BUG(msg) GIT_ASSERT(msg)
>> It would make things easier on the git.git side (etags and all).
>
> If we want xdiff to be usable for other projects I think we're going
> to have to accept that it is sensible to namespace its functions.

We're just talking about sharing code with libgit2, which I agree with
as a goal. I just don't see why we'd need to have e.g. XDL_BUG() as
opposed to libgit2 just providing a BUG() for its compatibility with our
xdiff.

We have other in-tree code with the same goal that does that, see
reftable/system.h.

It means that development in git.git can proceed without worrying about
the special-case, including stuff like this not doing what you think,
because you forgot the xdiff-specific alias:

    git grep -w BUG

And as long as libgit2 doesn't have a BUG() of its own (which it's
unlikely to do, since it's a generally usable library, and thus is
concerned about namespace conflicts) it can just provide the wrapper,
and providing that will be the same amount of work o that side, no?

This proposed wrapper is also BUGgy in that it's not __VA_ARGS__. It
just happens to work right now because none of xdiff/ uses >1 argument,
but that sort of thing is another reason to use BUG() and push the
compatibility headaches to whoever is doing the one-off import into
other codebases.
