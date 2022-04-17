Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F1DC433EF
	for <git@archiver.kernel.org>; Sun, 17 Apr 2022 02:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiDQCP6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 22:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiDQCP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 22:15:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA0533350
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 19:13:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 11so9026248edw.0
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 19:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f76OOfXBn3hxjQ7PZ14Or68iAwPp7N1N2HX/BZOw9bA=;
        b=btG5YslyQhl6Vir+a216z+9FpGmuxuD4O7HNWWZCgiaNrxZujfvDB10inr9fnZZeG4
         SQ10+xri4Z0YA4lUTcf8pSTaGl+ceuzV+8ex/pFvbZUmO6I+pJpEyWHnKUoRxefEzlbC
         eoZ9NcE97c9sz5QQhdneMQU9Pl+hwDypra3mcWDzTsDrQvT120DEVSvvivTCCxNK1iQf
         d59v3G1OyXsdgUjhaYpljsMDBE4feitLgJwxp8fxjFiZtAn88C7cXNvBzrZvk6Wi4cmQ
         iJcd2OFbxLVks1967I1KN+JXYRGI9eB0ojzqx300N6VuZpciIQHz8R8aNNNUQMcUSpIv
         a2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f76OOfXBn3hxjQ7PZ14Or68iAwPp7N1N2HX/BZOw9bA=;
        b=J0KchigQnUpW3kIi3k+M4pIr8csGkfu2Oxnhk2CicifVs5Dhd0nfRjS2OVM/seGdUf
         ZcEWQBkJFgYJwh3hg2GaJ3O2osa4Joq9jrOg6D7rq/5f+w37RB7mUBpzp8l2vjaJvyB+
         w7p0dfrl/Kbq5CdyzD5Po4d0O9wTKeFHfA6hca/Pt9+bTs+WIauGBOXwVmrEFhh3/rPF
         l/XxQnsNS/hSb1l8P4GDiEf42jEmIJBpFTALE//mqsNptK/TjBUE5b0QcNYk1wJ5y0FK
         /hc6brdRk7N83KYw8dKaj//qzU+iLmWDWdvAA/Eb+v7aMR670XV6qh2rsnTVw1DK6D0c
         RThw==
X-Gm-Message-State: AOAM530fG+w1RtWsO4Dh0QyDXDqik77edXsiKFAZIztTrdbPe96jMkU5
        zck8L3k0PJ4fZTxn/btsmpjqKeUin5Ubvx/I2tg=
X-Google-Smtp-Source: ABdhPJwc5xN4/t0VqHDtcIwt1+aqT+nsENgYYWViIea33fbJEc7ZSryOfkVEXFA1k8R2TLn5K/MBQwaHOgeLdgmoqoE=
X-Received: by 2002:a05:6402:5254:b0:41d:7abe:3e08 with SMTP id
 t20-20020a056402525400b0041d7abe3e08mr6157018edd.153.1650161600039; Sat, 16
 Apr 2022 19:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com> <64cae3bc-e1b9-d118-2d78-208dc772f74a@gmail.com>
In-Reply-To: <64cae3bc-e1b9-d118-2d78-208dc772f74a@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 16 Apr 2022 19:13:08 -0700
Message-ID: <CABPp-BGyesv-0upHdipLg+VrA08FV3cD7NrVK9xm4iVgn8iqHQ@mail.gmail.com>
Subject: Re: Review Request (was Re: [PATCH 0/7] rebase: make reflog messages
 independent of the backend)
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 4, 2022 at 8:34 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> If anyone has time to review these patches I'd be very grateful. I've
> cc'd this message to some list regulars who have reviewed rebase patches
> before but if anyone else fancies taking a look at them that would be great.

I apologize for the delay here...especially when it came after you had
already waited a month and a half.  (This is the first git thing I've
done in over a month, sadly.)  Anyway, I just read through the series
and left some comments; mostly looks good but I second the request to
split up one of the patches.


> On 21/02/2022 11:10, Phillip Wood via GitGitGadget wrote:
> > This is a series of rebase reflog related patches with the aim of unifying
> > the reflog messages from the two rebase backends.
> >
> >   * improve rebase reflog test coverage
> >   * rebase --merge: fix reflog messages for --continue and --skip
> >   * rebase --apply: respect GIT_REFLOG_ACTION
> >   * rebase --abort: improve reflog message
> >   * unify reflog messages between the two rebase backends
> >
> > This series is based on pw/use-inprocess-checkout-in-rebase
> >
> > Phillip Wood (7):
> >    rebase --apply: remove duplicated code
> >    rebase --merge: fix reflog when continuing
> >    rebase --merge: fix reflog message after skipping
> >    rebase --apply: respect GIT_REFLOG_ACTION
> >    rebase --apply: make reflog messages match rebase --merge
> >    rebase --abort: improve reflog message
> >    rebase: cleanup action handling
> >
> >   builtin/rebase.c          | 144 ++++++++++++-----------------
> >   sequencer.c               |   5 ++
> >   t/t3406-rebase-message.sh | 185 +++++++++++++++++++++++++++++++-------
> >   3 files changed, 214 insertions(+), 120 deletions(-)
> >
> >
> > base-commit: 38c541ce94048cf72aa4f465be9314423a57f445
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1150%2Fphillipwood%2Fwip%2Frebase-reflog-fixes-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1150/phillipwood/wip/rebase-reflog-fixes-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1150
