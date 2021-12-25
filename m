Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1543C433EF
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 02:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhLYCuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 21:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhLYCuM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 21:50:12 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F68C061401
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 18:50:11 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y22so39075851edq.2
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 18:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1julohNZZAIraoUKx5mXVQyvHEaCO4OEc3lbFmMogCE=;
        b=lLLUjUAjt/xSlkj12SBkml7VfhDMF+Ehf8hlq5kCW39m2WOdbZjWtX5hJCq5k2Lgzr
         uBWQSBLob2qrxiwSvkhbrtmL6fhHgUiDd5caeHS4a/H0L4zxbS4pstxHiZYsd9Nk7Re7
         nwmRpaQewf+nhv55V9TSDYm+f+X+yI1au+AQePUWv21urKyM5GdrYBh8nnE1aOIfmicI
         u4Tff0dD8L7DqoTvk/NXwKRujLZ09xANkzSesnihwG2dOioLz/iaRVnJf7MO76ZSa+6Q
         LiuhDmk6oiERj4Cp+lQ0a1Qixptl9+1N1w1X0Zp4yI92UUnGpMP386BBGelrNwKEqXYU
         rFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1julohNZZAIraoUKx5mXVQyvHEaCO4OEc3lbFmMogCE=;
        b=Y4Ez2puP6ECq4B0Fqegp68ko5Vo9AP6VlxCzzrbTw7lgJhcxWsWNNvR+8YmdEGVCV+
         D4PVDHFCkgwOxSsElfgTt0uUlrO+Z7FECGGckVFWqexSFSNudbZnSDxQSrrvr6hry3IS
         HD6KBvjCYcIWNZ7m84JvB4fBxOyK6dji63BTe2vRXSocf+601i5ilHvC2r0JYUAcHyds
         vYRecDOulJom6nnJCOpnuFp0G0LrpJygND4LhnfN6UKAWcxwV7jhwGtWfbbRxvdF4blM
         +7KnpV7mCWNKmsHI41YD1RR3Fjfveu6+0PRY0qMI3AyYEkFKR/7ZdEM6zZA7/tIsgvHr
         8XpQ==
X-Gm-Message-State: AOAM532Xd+DrBW9C44WqLmD22pg1gjJudfnS7MWU52BJYQqxWT8AfJ8V
        sCMtb0pg0GRkPlMauuiO1uQPNakQNMYWdoQxu6w=
X-Google-Smtp-Source: ABdhPJyunqrg7rplJ26BkkD3Vm49ZeeX3/WJFdZbxqkna8GXLQ+uZ02pmXEqbL3gi65NcFxSho4RC7gbno8eRA9wM88=
X-Received: by 2002:a17:907:3f1e:: with SMTP id hq30mr6829861ejc.613.1640400610340;
 Fri, 24 Dec 2021 18:50:10 -0800 (PST)
MIME-Version: 1.0
References: <xmqqsfui6g7q.fsf@gitster.g> <xmqqsfuh5tz4.fsf@gitster.g>
In-Reply-To: <xmqqsfuh5tz4.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 24 Dec 2021 18:49:59 -0800
Message-ID: <CABPp-BFiMy55mCMJSHk9PmKa8EUd-6mR5z5xM7J3P2dZBjRq5g@mail.gmail.com>
Subject: ds/sparse-checkout-requires-per-worktree-config (Was: Re: What's
 cooking in git.git (Dec 2021, #05; Thu, 23))
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 24, 2021 at 6:11 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > * ds/sparse-checkout-requires-per-worktree-config (2021-12-21) 5 commits
> >  - sparse-checkout: use repo_config_set_worktree_gently()
> >  - config: add repo_config_set_worktree_gently()
> >  - worktree: add upgrade_to_worktree_config()
> >  - config: make some helpers repo-aware
> >  - setup: use a repository when upgrading format
> >
> >  "git sparse-checkout" wants to work with per-worktree configration,
> >  but did not work well in a worktree attached to a bare repository.
> >
> >  Expecting a redesign?
> >  cf. <CABPp-BG7nwsdEYrnfqhAbWU4ndJHcqGf6RS_6DzJittuNVLvoA@mail.gmail.com>
> >  source: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
>
> FWIW, this topic by itself passes its self test, but when queued
> near the tip of 'seen', it seems to break t1091.
>
> For an example run that fails on win+VS test (8), see
> https://github.com/git/git/runs/4629824103

Unrelated to your comment, other than being about this same series:

I think "redesign" is too strong a word here.  I think the patches are
a useful start...and might even represent the majority of the code
needed; it's just that they are focusing too narrowly.  core.worktree
should also be handled, and I think we should include fixes at the
`git worktree add` level, not just `git sparse-checkout {init,set}`.
