Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB47C433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 17:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1416B600CD
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 17:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhCORLb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 13:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbhCORLD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 13:11:03 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C880C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 10:11:03 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id o22so25481343oic.3
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 10:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dFlkN1W3qWd+Fih2sqs5K6rcwOBdmhHyN6LZFYN+Pb0=;
        b=qd77EvPyhq1x1rd6AiAA0nvj1x8jkmJNYe8cBMWMEXiJnir+nlabDGelN3X2/fAAse
         11akb7xxWmwcnPI9cKpO3mte85pBEiVX8khOyy93aFjG+dQIuLAIxAYuNQ9XdrbeKFB6
         RFYdunCkYp2uCH65ILj1AB/yrpdPPK7vGPvGYLOpMlbqJAT5BJe0cT21LLU7/JyPlR12
         kS2hiD30Ia4EXwKruSD4zsH9CON6thR9SDRo82nXPcnmb3K6eVAbIW3FNZGJFBK7plz7
         Ld+YBeWs8A/VtMycVf9pqj96anD/UAcGYT5STZXhpmMlV69Y00CZntWwJt/ldIpVqCpu
         xMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dFlkN1W3qWd+Fih2sqs5K6rcwOBdmhHyN6LZFYN+Pb0=;
        b=LfYiFFJhopd7kILmLfXSy9NKGPdnNQCLX0ddEktvA4O6Wkt2kF/BO+upI6vp+V9lUU
         v2Gv0mvQJxzh8fakAXRqtDaOw8KjkL9gMABLlbUiyB52N/kfWe5Ug4kzSq8uWWVOgmhL
         ZIWneMxyCiasdZoiD3VSOaqgYqfxcbbaM+Cg8YkPm+1QvL1Wekf/JA2+Cb7FpPMPBRwc
         72C/QaLy1FkaCr0OLfE9VLoF1tOp+82+CvzgYxlGhw1EadYr6CEHQ/u9gvCb0QO+zDE4
         6caitBWoSWzpfGSHGdsc0akFnRCuLsA+ZRmpwgr+yyo1LCizkvuz0NmFmxqE/l4nLTqV
         7YPA==
X-Gm-Message-State: AOAM532Iy96ML7DSKPARuSixgTVg3eoE4+qjaw7B3kiH9hmLJoG9qhZu
        zXPD6j75alTKH76ciIlrBxS6zs4q0Nm8apGUs8o=
X-Google-Smtp-Source: ABdhPJz9T8RlktbSpkexg8PF8KhqVO4ZPsBv0fKw69+Awg7m7/1+nkTBuJJOMPXbpCxNCvdG84h1IGm55BtGX+xA3S4=
X-Received: by 2002:a05:6808:a8a:: with SMTP id q10mr82636oij.167.1615828262129;
 Mon, 15 Mar 2021 10:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.845.git.1614484707.gitgitgadget@gmail.com> <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 Mar 2021 10:10:50 -0700
Message-ID: <CABPp-BGEJ+Qvb4C0bgnMEoxVZfYj1NMrtYF-opLG2gcwJ3-v_A@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Optimization batch 9: avoid detecting irrelevant renames
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 8, 2021 at 4:10 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series depends textually on ort-perf-batch-8, but semantically it's
> almost completely unrelated and can be reviewed without any familiarity with
> any of the previous patch series.
>
> There are no changes since v1; it's just a resend just over a week later to
> bump it so it isn't lost.
>
> === Basic Optimization idea ===
>
> This series determines paths which meet special cases where detection of
> renames is irrelevant, where the irrelevance is due to the fact that the
> merge machinery will arrive at the same result regardless of whether a
> rename is detected for any of those paths. This series represents
> "Optimization #2" from my Git Merge 2020 talk[1], though this series has
> some improvements on the optimization relative to what I had at that time.
>
> The basic idea here is:
>
> We only need expensive rename detection on the subset of files changed on
> both sides of history (for the most part).

I know this series was already reviewed and even a subsequent series
was reviewed, but I thought I'd insert a bit of history trivia:

I first submitted this optimization in late 2017 as an RFC at
https://lore.kernel.org/git/20171110222156.23221-9-newren@gmail.com/.
Unfortunately I had only handled the "for the most part" piece, not
the other special cases.  I knew not handling those other cases caused
bugs, but didn't readily find a solution for them at the time.  I kept
mulling it over periodically despite being switched onto other
projects; eventually I weaseled my way into being able to work on it
again and with some effort was able to work out the other necessary
conditions and audit the code to verify I had all the cases covered.
Those "other cases" were much more easily expressed in the context of
merge-ort's data structures than merge-recursive's, in part because
merge-ort's data structures were picked to help me solve this
optimization problem and the various known failing testcases that I
wanted to fix.
