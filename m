Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8F9C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7524960FC0
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhHBQ1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbhHBQ1w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 12:27:52 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA018C061760
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 09:27:42 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 26so6855168oiy.0
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 09:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l0qCSxiuUPMRzqCb77vmMGG2UUJJGCAzkzdIQhM81cg=;
        b=Ux4/yGHyqUxMkxLcljtknOchmbf/R1Xaw4/zgh8DgwRLW/qHQB0Av8QffMa69fUBSy
         jUYHLllgF23q+MvwJfhUfDifs/G9pWr48W/2ATbD5/Wz0LqRCsPK4uiPVEWEQ92/kTI9
         zLZnRxTgiKwz2t7FfswyJyHySl4JwpH1JpaCwlowqjdtz56sZ1ohMwou7616kKUAfkD/
         Bdf9x15gfCjsavOeX9eCl9jrcxT3hxcqxYWei8jfNi0WqjxH6DatduXPgFbbVIrroqw9
         UA8Ad1xAH9kbl7yGaWD+LJLlZEjnwK+y205ZvWI9EAC47AiNEKR1M1iFStdyyqDA6A8Z
         1Rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l0qCSxiuUPMRzqCb77vmMGG2UUJJGCAzkzdIQhM81cg=;
        b=QkUi+gRxpXa+ltkWvinB3Lpnwqx5YXNnqBFwcuD/9kaKwvLf1zB0WybAAKCz3c2j4/
         Eye1UPUBq+nWXMchKs3KZGc3DdS0s4xOP5TshbHRdGqz3WEbpC6PkenlfNXMulqoHjvI
         RWb0A/6DFF/4Znh775nUkph/ShAXKIoDmmhpH5LY7O2uTEtE3VW4R4mN4WF1H/yhnfsv
         uxWGpneqIouZtrtAQb8sE7i/5MIOjZ+jzanIgOwz6hQ//8e3SgUUWKRIAdT784+0+Rsr
         Jd4Sqy0z+rtdNR/35uFr1lmYK/z+uM1K0sy9qJvaBoEWNm8nM50S0fkEV6ArJjXht1b9
         BvGQ==
X-Gm-Message-State: AOAM53163srTyMFZX4Gh4pDs6jh8jyLiVoaFrrQUdtXQOVlOAfXGU8ZS
        2/YUeLAV3jxilttzyFPSi8VF8PHu0mwxH0Szzx0=
X-Google-Smtp-Source: ABdhPJyq0JdprG7A/0VWZipIPalNCOtsvis5IhRD7HvLaCPo5eg2Wf/WBtjTfcpzA4+eeL31OJHmY28GsOjDhF2rDcE=
X-Received: by 2002:aca:c0c3:: with SMTP id q186mr9671757oif.39.1627921662093;
 Mon, 02 Aug 2021 09:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com> <ec1bb449-347a-924d-7462-3cef6facc0e9@gmail.com>
In-Reply-To: <ec1bb449-347a-924d-7462-3cef6facc0e9@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 2 Aug 2021 10:27:31 -0600
Message-ID: <CABPp-BHNYPzJc=oksWfkUGqsrmK_nhr_24WcaqjZoK_+4wG=tA@mail.gmail.com>
Subject: Re: [PATCH 0/2] [RFC] Switch default merge backend from recursive to ort
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
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

On Mon, Aug 2, 2021 at 9:05 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 7/31/2021 8:07 PM, Elijah Newren via GitGitGadget wrote:
> > This is an RFC series designed to spur feedback about switching the default
> > merge backend (reviewing the patches is of secondary importance at this
> > point). Some questions:
> >
> >  * Are there things others want before this series is considered for
> >    inclusion?
> >  * What kind of timeline do others think is reasonable?
> >  * Would it be beneficial to let this series sit in 'next' for an extended
> >    duration to gain more feedback?
> >
> > Some potentially useful context in relation to the above:
> >
> >  * I've personally used the ort backend for well over a year
> >  * I have ~50 testers using ort as the default merge backend since Nov.
> >    2020.
> >  * ort fixes known bugs in recursive, and there are no known regressions
> >    (more testers may change that)
> >  * ort is significantly faster than recursive
> >  * ort provides one new feature already, and enables more that are on the
> >    way
> >  * The commit message of patch 1 has more details about the last three items
> >    above
> >
> > So...thoughts?
>
> I fully endorse this change as soon as possible. I've applied the patches
> you supplied here and submitted a PR to microsoft/git [1] to take them.
>
> [1] https://github.com/microsoft/git/pull/404
>
> I've done my own share of testing on some of our private monorepos to see
> how ORT compares to the recursive algorithm. My data is not perhaps as
> rigorous as yours, but I did notice that the ORT algorithm was consistently
> within the 5-6 second range while the recursive algorithm would vary within
> the 7-20 second range (and some outliers near 30s).
>
> Of course, I'm particularly excited about the benefits to the sparse index
> work. I also have a prototype of a 'git merge' integration with sparse
> index which was not very hard because the ORT strategy does not use the
> index as a data structure. With that change, my tests dropped to between
> 0.5s and 1.5 seconds. (This shows just how much my earlier timings were
> stuck on index reads and writes.) Now, the largest indicator of time is
> how long it takes to resolve text conflicts.
>
> Thanks! What a monumental effort.

It's certainly been a long haul.  And you jumped after all my
preparatory patches when I started submitting actual merge-ort
patches.  Since that time about a year ago, you have reviewed nearly
every single one of these patches, and there have been well over a
hundred of them and they've been far from trivial.  The code is better
today because of your comments and suggestions.  Thanks for the
monumental review effort.

One quick question on your timings here, though: in the past, when you
compared timings, you compared merge-recursive *without* rename
detection to merge-ort *with* rename detection.  Are you doing the
same here (just so others have a better sense of what is being
compared)?

Thanks again!
Elijah
