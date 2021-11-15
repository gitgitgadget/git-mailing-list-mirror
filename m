Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57352C4321E
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 08:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36AF063237
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 08:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhKOJBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237249AbhKOI7s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 03:59:48 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B59AC061202
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 00:56:41 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id y5so15375458ual.7
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 00:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nbljx1P9rMyd5b7OXw0tc7kQkFOfYySd5n/crjUnwMU=;
        b=pvn8kofEcmlF2UUynOmqojtc3go5anu5AnXXhdCREyRhTHcTX1qe+luG9JLoZitiqw
         6kFb9JT06wa7hHUO6Z6B6NXARhhSnSu8EjVlyy264kZkBT5n9rwz8C0WXJmNeF9dluvR
         GdnDhY8pJVP9xrTNSzSPmreiPVOZCoutJNfN1akTA411iKH/G9/tZcoMiNa912hYOmTp
         yfJRhg6ltshS27VvrrsV5FIZwWSlMmKP+Cv1d902ixP2YXDBhiApCcfWJmKc1ItIJp9u
         m9wlcBupZCBWJzZR1iyVlEjm3IPBqNs20Be8YWSdAI4SIfhCVLe9RhdsLBGbwhquVyOd
         HaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbljx1P9rMyd5b7OXw0tc7kQkFOfYySd5n/crjUnwMU=;
        b=NdXUue2HzKnXD+1fm/fl2Yys+hlnxbtwtiMkvNlQAoc7wFQnPNa4TGTO94MMY3veQ0
         qypArYRkiW4Frb5dSgdTw4M/ggtirDJyHiT0DFC5/vSvBe8S9ebRhx2LmHVyaoKG9Jik
         Sl5lCAIG+qEPEG7e7FvvvCg8SHWVrXB8dWAqdHArb5iKGghYfBwhiJTbymolLIlZj7WG
         VioMEqx2SHa3QiJGpBbcrET2r6POv5I2/AjBoXtoEibfV1bwNarqmVVf7C87/W0ffsCR
         3crjQ+9+auwqmnBeLOsUO9uY5uiSVpYunH1Yj9fb1jVCwdkVs6hTZKlNdPL8CFimUTd/
         GRYg==
X-Gm-Message-State: AOAM532s+uv2ncFOoX1/NqWu4iTEn1ZpQpirMU9SqW5Ac0AqacDCAEd3
        TGZBCyyWmID4vEabcjZ/bXjUeNKPxDQmtx+JXQVkhpth
X-Google-Smtp-Source: ABdhPJxzUxYy6vb9j0JQLPKQkuopyRwUcb4uiqVSCt6FcltrvBOE7rmYpKddGw2bJruWmgyuHxpb+p4uXNixm4fKFqk=
X-Received: by 2002:a05:6102:cd3:: with SMTP id g19mr41727020vst.14.1636966600429;
 Mon, 15 Nov 2021 00:56:40 -0800 (PST)
MIME-Version: 1.0
References: <CADL96rvRX2R_4Wm23tz88hDUztcpK531RU+Ops2UVoiOW0bCHw@mail.gmail.com>
 <30188556-935e-f5cf-c9e0-4ff8a528e5d8@gmail.com>
In-Reply-To: <30188556-935e-f5cf-c9e0-4ff8a528e5d8@gmail.com>
From:   Erwin Villejo <erwinvillejo@gmail.com>
Date:   Mon, 15 Nov 2021 15:56:29 +0700
Message-ID: <CADL96rvWidDUEChJX8JCruUKjaOWqXrZn6-sG0EYb82_k_LTsA@mail.gmail.com>
Subject: Re: git pull bug report
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is nothing to reconcile since the branches have not diverged:
local is ahead of upstream. So I think it is a bug, no?

Best regards,
Erwin

On Mon, Nov 15, 2021 at 3:54 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 15/11/21 15.42, Erwin Villejo wrote:
> >> What did you do before the bug happened? (Steps to reproduce your issue)
> > * make local changes, stage, and commit
> > * local is ahead of upstream. confirmed by `git status`:
> >
> > ```
> > $ git status
> > On branch main
> > Your branch is ahead of 'github/main' by 1 commit.
> >    (use "git push" to publish your local commits)
> > ```
> >
> > * try to pull upstream to local
> >
> >> What did you expect to happen? (Expected behavior)
> > No-op (and NO failure) since local is ahead of upstream.
> >
> >> What happened instead? (Actual behavior)
> > `git pull` fails with error:
> >
> > ```
> > $ git pull
> > hint: You have divergent branches and need to specify how to reconcile them.
> > hint: You can do so by running one of the following commands sometime before
> > hint: your next pull:
> > hint:
> > hint:   git config pull.rebase false  # merge (the default strategy)
> > hint:   git config pull.rebase true   # rebase
> > hint:   git config pull.ff only       # fast-forward only
> > hint:
> > hint: You can replace "git config" with "git config --global" to set a default
> > hint: preference for all repositories. You can also pass --rebase, --no-rebase,
> > hint: or --ff-only on the command line to override the configured default per
> > hint: invocation.
> > fatal: Need to specify how to reconcile divergent branches.
> > ```
> >
> >> What's different between what you expected and what actually happened?
> > I expected no failure and no-op since local is ahead of upstream.
> > Instead, `git pull`
> > fails because it thinks the branches have diverged.
> >
> >> Anything else you want to add:
> > I found this bug in VSCode. VSCode runs `git pull` first before `git
> > push` when pushing to upstream.
> > This bug causes pushing via VSCode to always fail, although it can be
> > worked around by simply opening
> > a terminal and running `git push` manually.
>
> You need to do the prompt above, so not a bug.
>
> When reconciling, do you want merge or rebase?
>
> --
> An old man doll... just what I always wanted! - Clara
