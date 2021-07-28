Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2E6C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 22:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9602C60EFD
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 22:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhG1Wwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 18:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbhG1Wwn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 18:52:43 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871D4C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 15:52:40 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id c2-20020a0568303482b029048bcf4c6bd9so3782806otu.8
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 15:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6vK5TS042nd+D61RoFdyl+e4wZe2BPJOc84XQyH1B9w=;
        b=On46L0hU4i4SL9+yFR+2XzQfVrYMDCKNCX79A+erMV7AxH+0HTPSDbflQT/xaTuA2i
         63xSPcNWTldPw0myYab+aZU5GobZF3+C/2BmiRYLYei8GwqIQdCnpl0NIboqLRvcpUsk
         gKEIB0eZjwYzoriVhEwkt3ku89mgzesjYflzPPLt0xYC1K75mxMSjc/SoQLF/+/tnBi9
         q8AeIZqy0ikTao0M9Zlpr0LL5EJeDy9LEwK+BWmHwEojgbtt1LIoAntvD2F3/e6LOIf6
         Om2W7MlGTDNtZ10xNum8ZfLRHVppNVwLAKRrqsGZm8F5UQvaz0oB9z9vB1YmZpttv2yh
         3xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6vK5TS042nd+D61RoFdyl+e4wZe2BPJOc84XQyH1B9w=;
        b=BprtovRzzpWAkakq1d47BpdzFK/18tTBsXtqAN6pwpL+4rb7eu4uhuVp8PIL+NoTkM
         BVrB59pq6nQvqFuItMUwSw7m4BwQniaFZKCcwDHjuH29Sw/PQdx3TB0uncyA9lpsIoWc
         bDm3Fh6IL7bSyo6R2gyYXtJkj5yJvkhKPJQ86AmqPsjKmHReEh4FQOGTmjrJvB21OYUu
         /6W95pxgeICimceup6M4XhqkBAq3kr0yCkPxj/gvV9lVRwbL8IRISrICZzrcnxUlOEvL
         UssOwqEIjwW+UkrQPOgdC/XVvwE5EZuqThGdimzopVm+JHhp0TI9ArWnH5osvzWaXG03
         PVQQ==
X-Gm-Message-State: AOAM532LNQBNrhSnjoqu69UGc53hjcuFzdGng1idS7J0yFIrVT/MziNx
        L1zVudgSnupyQ8lZXhswci6XUYq99ho/DrpPI44=
X-Google-Smtp-Source: ABdhPJxOR6Ta6SOSe5+psMmbFbUhqPoDT5ViHH0hetOlEBfPjq/qn9pGr4LVgrlzHYE6mmvQTxdYLkQoFXLcJQagCGw=
X-Received: by 2002:a05:6830:1d73:: with SMTP id l19mr1522615oti.316.1627512759932;
 Wed, 28 Jul 2021 15:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.990.git.1627044897.gitgitgadget@gmail.com> <884002ab-c59d-143d-0cf0-8d06d5fb5f0f@gmail.com>
In-Reply-To: <884002ab-c59d-143d-0cf0-8d06d5fb5f0f@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 28 Jul 2021 16:52:29 -0600
Message-ID: <CABPp-BGF7kMP_KKVQguy6=x4Ex24UNfbKvEDEhd7wHSaDZ3+jg@mail.gmail.com>
Subject: Re: [PATCH 0/7] Final optimization batch (#15): use memory pools
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 26, 2021 at 8:44 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 7/23/2021 8:54 AM, Elijah Newren via GitGitGadget wrote:
> ...
> > =3D=3D=3D Basic Optimization idea =3D=3D=3D
> >
> > In this series, I make use of memory pools to get faster allocations an=
d
> > deallocations for many data structures that tend to all be deallocated =
at
> > the same time anyway.
>
> Makes sense. This is appropriate for a final optimization, since the gain=
s
> tend to be quite small.
>
> > =3D=3D=3D Results =3D=3D=3D
> >
> > For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
> > performance work; instrument with trace2_region_* calls", 2020-10-28), =
the
> > changes in just this series improves the performance as follows:
> >
> >                      Before Series           After Series
> > no-renames:      204.2  ms =C2=B1  3.0  ms    198.3 ms =C2=B1  2.9 ms
> > mega-renames:      1.076 s =C2=B1  0.015 s    661.8 ms =C2=B1  5.9 ms
> > just-one-mega:   364.1  ms =C2=B1  7.0  ms    264.6 ms =C2=B1  2.5 ms
>
>
> But these are larger than I anticipated! Amazing.
>
> > =3D=3D=3D Overall Results across all optimization work =3D=3D=3D
>
> I enjoyed reading this section. I'm excited to make ORT the default in
> the microsoft/git fork and see how this improves the lives of our users.
>
> > =3D=3D=3D Caveat =3D=3D=3D
> >
> > It may be worth noting, though, that my optimization numbers above for
> > merge-ort use test-tool fast-rebase. git rebase -s ort on the three
> > testcases above is 5-20 times slower (taking 3.835s, 6.798s, and 1.235s=
,
> > respectively).
>
> The performance and behavior changes recommended here should definitely
> be considered. However, the benefits still apply and at the moment users
> do not expect immediate responses from 'git rebase' so we have some time
> to approach with caution.
>
> I only had one small question that is not even important to the
> correctness of this series, so feel free to ignore it. The patches tell
> a convincing story.
>
> Just to be careful, have you taken the time to run the merge-ORT tests
> with --valgrind?

Yes.  In addition to the testsuite, I also ran the testcases above
under valgrind (especially mega-renames) -- and with those testcases I
had the leak checker turned on.  It was somewhat surprising how much
slowdown I saw when I introduced some accidental memory leaks while
optimizing.  But it all runs clean with the patches I submitted.
