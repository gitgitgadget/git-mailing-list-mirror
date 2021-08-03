Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D7FC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 17:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3133460F0F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 17:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbhHCRBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 13:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237576AbhHCQ6m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 12:58:42 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783D7C061385
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 09:57:24 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id k7-20020a4abd870000b029025e4d9b0a3dso1600666oop.6
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 09:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z2y91Yk8iJMgaz2JjB+rz0jkUPa1hNXaDYkacHIAvog=;
        b=UEIV0T3/VUM0eBP181XQP7fUhSepDLc4tjyWZHgtdJnnF5B38L2J5wtwNsskWJSwtg
         8Km1f3GQ0qO52ty3rkJBo8w7LZ4uIwE7U/ONRtbNMsyfIdRV/TSu7x9uLTzclX5WaWsZ
         zKOvfsNvGODy5WVuhxRSumaNvtYeazaXT8s9vOsqrQDkkJ4+U9C2cbnzFqMb/JLTQzj8
         dj4si1WKrOSHF3ShVg8h/iN8tUgZWiT+WBTX91RUlUgv7nTZzozWKp+GIZxJRASaTXYm
         hwuifJv5iX7qSqNni5zqpo/8AztaTvzcDibAFi7JCz2GNNYOzW19Rzq5ZLEPN0YaOkQx
         Ivgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z2y91Yk8iJMgaz2JjB+rz0jkUPa1hNXaDYkacHIAvog=;
        b=YUHMDuDGxquF/MlA2NUrYq+xMANTB9RLU2JphLBNS870v2DAiYQPiAXvRo3DhAYuhg
         jA0y8vFnfil0ljAN9hZs0ExDtwkYA8xrMIToNcy2X4/aupRmI3xjZGiuBfibfnn4uXdx
         4GlbGguMe+3hm+owmhLXxUwjhLOtG9kWNYwtuF80+7V/apL2qMxRLsQO3Sx4uNHtz4Mw
         XdYSE5nVFsyq1eeeUnF1MM7BWgj4pCcA9Cj2BvwWG1J2HiSU1MiLYVhL9X/kJxi9jXNn
         lPaftXQD4KCaqYWpcsCqrAy/56bPgXcOCJ+ljQXy6TQKKpsuhKogoOWfe915zStqj3E2
         qnBw==
X-Gm-Message-State: AOAM533VbAr/00rAtKvMVdle64KQ0Dtz+4to7qezzFhjbUHHUUFA0kK1
        Am0crz82qzDsZYKOXY0NaQCcKmxbXYzOU/zn/vQ=
X-Google-Smtp-Source: ABdhPJxnOClvAWvD0QWrxyGUpZfohItfhdUCnHZH8HqHpi2uXv2Oq30Jo6RNEejxUm/K+O12Og+iq1LByUc9wz3rWnw=
X-Received: by 2002:a4a:d40a:: with SMTP id n10mr15089436oos.32.1628009843827;
 Tue, 03 Aug 2021 09:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com> <YQlnNXgk3qcGb5Bk@coredump.intra.peff.net>
In-Reply-To: <YQlnNXgk3qcGb5Bk@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Aug 2021 10:57:12 -0600
Message-ID: <CABPp-BGgcpMbFrEjaDxpfb8=Wr_5O76qCDq1OSbpemrnYDcsqw@mail.gmail.com>
Subject: Re: [PATCH 0/2] [RFC] Switch default merge backend from recursive to ort
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 3, 2021 at 9:56 AM Jeff King <peff@peff.net> wrote:
>
> On Sun, Aug 01, 2021 at 12:07:39AM +0000, Elijah Newren via GitGitGadget wrote:
>
> > This is an RFC series designed to spur feedback about switching the default
> > merge backend (reviewing the patches is of secondary importance at this
> > point). Some questions:
> >
> >  * Are there things others want before this series is considered for
> >    inclusion?
> >  * What kind of timeline do others think is reasonable?
> >  * Would it be beneficial to let this series sit in 'next' for an extended
> >    duration to gain more feedback?
>
> It looks like others gave some more specific review on the patches, but
> on the meta-topic of "do we switch, and when", my response is: yes, and
> soon. :)
>
> Having watched the development of merge-ort, plus all of the weird
> corner cases in merge-recursive we've seen over the years (many of which
> you found and added tests for while working on merge-ort!), my gut
> feeling is that the switch is _much_ more likely to fix problems people
> might see in the wild rather than cause them.
>
> It would make sense to me to do the switch in 'next' early in the
> post-v2.33 cycle. It can cook there for a bit, but I think we have found
> that it's much more likely to see actual use once it hits 'master'. So I
> don't see a particular reason to have it sit in 'next' for a long time.
> We should get as much exposure in 'master' during the v2.34 cycle as
> possible.

> The nice thing is that the two strategies can co-exist. So if it does
> turn out to have any regressions, it's an easy revert to switch back,
> and even post-release users can switch at runtime. We have pull.twohead,
> but I don't think we have an equivalent that would impact a bare "git
> merge" or "git rebase -m". Maybe it would be worth adding those as an
> escape hatch?

Actually, pull.twohead is not pull specific; it already affects merge,
rebase (-m is the default for rebase, btw), cherry-pick, and revert.
pull.twohead has affected a bare "git merge" since 1c7b76be7d ("Build
in merge", 2008-07-07).  I thought it was weird that "merge strategy"
for the merge command was specified via a config option under "pull",
and included my misgivings about it in the commit message of
14c4586c2d ("merge,rebase,revert: select ort or recursive by config or
environment", 2020-11-02) when I made sequencer.c pay attention to
that config option as well:

"""
    Also, allow folks to pick the new algorithm via config setting.  It
    turns out builtin/merge.c already had a way to allow users to specify a
    different default merge algorithm: pull.twohead.  Rather odd
    configuration name (especially to be in the 'pull' namespace rather than
    'merge') but it's there.  Add that same configuration to rebase,
    cherry-pick, and revert.
"""

But no one had an alternate suggestion or opinion on attempting to
migrate the configuration to a different name, so it has just stuck.
Anyway, if folks want to try out 'ort' with the 2.32 or 2.33 releases,
they can set pull.twohead=ort.  Once we switch the default, they can
set pull.twohead=recursive to get the old default.
