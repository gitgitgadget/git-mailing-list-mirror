Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61EBC76196
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 15:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjDJPyu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 11:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjDJPyt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 11:54:49 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC4D1B9
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 08:54:48 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id f188so36839431ybb.3
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 08:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681142087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQTZuQijK/yLWw0QLXxlFpDBcTC//xEPv53/6acRoYc=;
        b=r7j51Zev9k6dTsv4BXNMOfPPfzAszyl/GHMWw3h1KQy32VOpf9rUwm0fmxoNJoJn/X
         b4Dh3lE14Jtgqv15pn6jPglMPZGnFKDlcOT49WG6vA5b6P3POyurjZSKdXtyIiuNKrBS
         jZKH6WMedVmysIqHkwS7PCL39ell/vP8I9qi4xRfzeiRafOkWH4bTN3G/ehq/vmRK01K
         uqKaVc99CZpRSif40YXIUmB6RliAyflUjyIpsFFuE8G5Q/0HF/qNHLgEjyp2aBA5YFrf
         nOKqkVYapB7hVODJz8TSOSNDup/CxFTcijwAbSZogwS+8QOk+8uqjdjspc7Nr9mLk8op
         SarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681142087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQTZuQijK/yLWw0QLXxlFpDBcTC//xEPv53/6acRoYc=;
        b=SddQxvjiG66Et3DWtpWw0CIlJIqAP1NNeIxcDYGYFWJn86UP3E79fp212hurE1okgz
         RKdiWdDt917tJJXcpgCg1KUFdgb9W45PxAvPe33BwcqKJ4yh7A3lGocuTZLtSpd1HWmR
         H17nSEcxLg0NpsBRZymLmMnBsQLbF/K5uPn6tcuFaVf+m6jEPSkbVBqunZkLIoThvbxN
         jbF4uaghyx+xyEX0oR69h+roz1aP+K9PoFWZWaNW3F8aw4sFXovqBBsJzmFPhX2mcx6a
         Mw9AHbHc5dToLehOMhRW30vwtMa4njf0rbricY177vtF22JLLI4KOrXWIeDFvz2ufqJj
         zxhA==
X-Gm-Message-State: AAQBX9evj/UpuSgQL1aPEoZ2VhVdj/zE77o4Ef+r8eqyLCCdLPyDrmra
        FNWdUZFTNLVSu2/c/fuUOPEnrVzfrcsGXdxh+1oA6B57oOSr5+fr/uUVCw==
X-Google-Smtp-Source: AKy350aFmfprrD6hzvNfI2BtgXhDZVTcvUi2sWzy91kX2HrgF3NhfQzrANSn3IVovzcuR8yNBfvLMeFabR+j9OqVkx4=
X-Received: by 2002:a25:d994:0:b0:b8e:fbcb:d6ef with SMTP id
 q142-20020a25d994000000b00b8efbcbd6efmr2063921ybg.4.1681142087534; Mon, 10
 Apr 2023 08:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
 <20230405173020.730912-1-calvinwan@google.com> <CABPp-BHi8tNxoLKSxCaHbyK3zHRevJTqJQdNjU3cLynNExmYVQ@mail.gmail.com>
In-Reply-To: <CABPp-BHi8tNxoLKSxCaHbyK3zHRevJTqJQdNjU3cLynNExmYVQ@mail.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 10 Apr 2023 08:54:36 -0700
Message-ID: <CAFySSZBix0UWYtc75J+SrFKApdkyWGktGGJ4TLCMOVOu_go5iQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] Header cleanups (splitting up cache.h)
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I meant wrapper.c haha -- I'm also currently interested in doing the
same header cleanup you did in cache.h with git-compat-util.h

On Fri, Apr 7, 2023 at 12:08=E2=80=AFAM Elijah Newren <newren@gmail.com> wr=
ote:
>
> On Wed, Apr 5, 2023 at 10:30=E2=80=AFAM Calvin Wan <calvinwan@google.com>=
 wrote:
> >
> > "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > > This series builds on en/header-cleanup
> > > (https://lore.kernel.org/git/pull.1485.v2.git.1677197376.gitgitgadget=
@gmail.com/)
> > > and en/header-split-cleanup
> > > (https://lore.kernel.org/git/pull.1493.v2.git.1679379968.gitgitgadget=
@gmail.com/),
> > > and continues to focus on splitting declarations from cache.h to sepa=
rate
> > > headers. This series continues dropping the number of cache.h include=
s; in
> > > this series we go from 254 such includes to 190.
> > >
> > > The series may appear to be long at first glance, but is repetitive a=
nd
> > > simple. It should be relatively easy to review, and falls into roughl=
y 3
> > > categories. An overview:
> > >
> > >  * Patches 1-6, 7: Being more explicit about dependencies. This was
> > >    motivated by the fact that trying to find unnecessary dependencies=
 on
> > >    cache.h were being made harder by implicit dependencies on trace.h=
,
> > >    trace2.h, and advice.h that were included via cache.h. (Similar to
> > >    gettext.h handling in the previous series.) So I simply try to mak=
e
> > >    dependencies more explicit, for both these headers and a few other=
s. To
> > >    make review easy, I split it into half a dozen patches, one header=
 per
> > >    patch (well, except that I handle trace.h and trace2.h together). =
Patch 7
> > >    then removes several includes of cache.h that are no longer needed=
 due to
> > >    patches 1-6.
> > >  * Patches 8-19: For several choices of FOO, move declarations of fun=
ctions
> > >    for FOO.c from cache.h to FOO.h. To simplify reviewing, each case =
is
> > >    split into two patches, with the second patch cleaning up unnecess=
ary
> > >    includes of cache.h in other source files.
> > >  * Patches 20-24: Other small manual cleanups noticed while doing abo=
ve work
> > >
> > > Since patches 1-15 & 17-19 are just more of the same types of patches
> > > already reviewed in the last two series, it probably makes more sense=
 for
> > > reviewers to focus on the other patches: 16 + 20-24 (which also happe=
n to be
> > > smaller). I would particularly most like review of patches 16, 22, & =
24
> > > since they are the least like any previously reviewed patches.
> >
> > Patches 1-15 a& 17-19 LGTM! Very welcome changes to see the size of
> > cache.h shrink after this and your previous series.
> >
> > I had the same change in patch 16 on a local branch, specifically movin=
g
> > editor related functions from strbuf. The eventual dream for lower leve=
l
> > libraries such as strbuf is to separate out the functions that touch
> > higher level objects, allowing for the eventual libification of parts o=
f
> > Git.
> >
> > Patch 20: removal of unnecessary headers are always welcome since it
> > allows readers to easily understand what dependencies a file has.
> >
> > Patch 21: I do have a suggestion that I will leave on the patch
> >
> > Patch 22: with what's currently in wrapper.h, it feels like it's
> > becoming the new dumping ground for functions that don't quite have a
> > home elsewhere. While I think this change makes sense right now, I do
> > hope in the future wrapper.h can be broken up with more reasonable
> > boundaries rather than "this function is a git-specific stdlib or
> > whatever lib function".
>
> Yeah, I wouldn't be surprised that we have multiple places needing
> cleanup.  I haven't looked much at wrapper.[ch] from this angle, but
> you got me curious and I took a brief glance.  Do you really mean
> wrapper.h, or wrapper.c?  wrapper.h is actually pretty small, only
> declaring 8 functions.  The other 32 non-static functions in wrapper.c
> are declared in git-compat-util.h.
>
> > Patch 23: same reasoning as with patch 20, swapping to more precise
> > headers clarifies file dependencies
> >
> > Patch 24: moving more items from the "dumping ground" to where they're
> > supposed to be :)
> >
> > Besides patch 21, the rest of the series LGTM, thanks!
>
> Thanks for taking a look!
