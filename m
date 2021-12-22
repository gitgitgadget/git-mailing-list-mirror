Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FBAC433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 22:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbhLVWyd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 17:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhLVWyd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 17:54:33 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A450BC061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 14:54:32 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y22so14298558edq.2
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 14:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3eK91tYriWCBRQ0QGFIOv+84Tc8Ngta2OZlrnTbQE30=;
        b=Ycc7gbSO7InpkBkdVPO7rpIc/TNuQwdYZEDw9MHokL9LbJ6VFKUUsmawy9fQ4P0FR/
         AGHYqNhxoqxhi0YYG2W9UZSlBbjULk+rfBatO8fvkEPPrSFTB4IASlo4x+D4gMDZB3BD
         v2Y8uRc+mlJWLq3Rt9S1czyZ17guUxiQAunkEU2GvJn1R6+rkt29Ul5aZ1RTtCjTR/+L
         8qEgO477fxHlHDCFfWQzzUmUv8yiSb7QMAN6/Ts9+0OaQx+HrCGmwaG1sO06JTMnLPt1
         4IsezJti10p+FWDeoFW5CV03s+2X5bPEtNZSV9SKhq9hcZGfhGrBBYDbT3nMBEINuefH
         NRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3eK91tYriWCBRQ0QGFIOv+84Tc8Ngta2OZlrnTbQE30=;
        b=c85vN/non8YtW/VsXTRBc13dEaAIJ//TWQMXKsOzWsoz70JOnUXw6MJT03KrOknQpa
         GUCVgo2Ez8Bl6+FqNa2giHcAiUnbCbCrqtttM0k5ShSuRzRUqBH0Hmv8LrkcDOBXZ3aY
         zSUbVL/4/JfjKYazs0WgR1bcMWqotI6SmdFMCoHcySmlo2wYCPQ7Iwoa9Peka03YVqSO
         x4RA2nE99NABAsWzqcPFQ1ho2lxgA3+qTTK59Tcr1idF5/Mi7BtcjB+8OAVBw9TRMFTA
         2tjGRX45e5FEZFh5UHzds/KC1UUyNHuV0Z4iYz61WAqIcSjjvP26fceTQGA+0lWTJXKc
         PE8Q==
X-Gm-Message-State: AOAM533EEZNUdEpHW7EvCEpF8k96WqyU9AiK9gHOFsIURtl1uKSyZ97m
        mox46pMIh/ByNMj7QXCZzuA5Fl5s2uetVUuN62Y=
X-Google-Smtp-Source: ABdhPJxQk6Bgld6FERQO6a7k7yEZCImyZxgtsRqJq8XMLrhG7PjsMfj/4EK6zZhFhpFNiBQ7hY0vt7A6q4OpWllBXmA=
X-Received: by 2002:a05:6402:1014:: with SMTP id c20mr4692019edu.186.1640213671212;
 Wed, 22 Dec 2021 14:54:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com> <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 22 Dec 2021 14:54:19 -0800
Message-ID: <CABPp-BG7nwsdEYrnfqhAbWU4ndJHcqGf6RS_6DzJittuNVLvoA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Sparse checkout: fix bug with worktree of bare repo
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, allred.sean@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 22, 2021 at 8:00 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This patch series includes a fix to the bug reported by Sean Allred [1] and
> diagnosed by Eric Sunshine [2].
>
> The root cause is that 'git sparse-checkout init' writes to the worktree
> config without checking that core.bare might need to be set. This only
> matters when the base repository is bare, since creating the config.worktree
> file and enabling extensions.worktreeConfig will cause Git to treat the base
> repo's core.bare=false as important for this worktree.
>
> This series fixes this, but also puts in place some helpers to prevent this
> from happening in the future. While here, some of the config paths are
> modified to take a repository struct.
>
> The critical bits are in Patches 3, 4, and 5 which introduce a helper for
> upgrading to worktree config, a helper to write to worktree config, and then
> consume that config helper in builtin/sparse-checkout.c and sparse-index.c.

Based on the description I went and fetched the patch series and tried it out.

This feels like a bandaid to me.  In addition to fixating on core.bare
(thus overlooking core.worktree), it also overlooks that people can
use worktrees without using sparse-checkout.  What if they do
something like:

  git clone --bare $URL myrepo
  cd myrepo
  git worktree add foo
  git worktree add bar
  git worktree add baz
  ... days/weeks later ...
  cd foo
  git config extensions.worktreeConfig true
  git config status.showUntrackedFiles no  # Or other config options
  ... hours/days later ..
  cd ../bar
  git status

At this point the user gets "fatal: this operation must be run in a
work tree".  And it's much, much worse if the original clone was not
bare, but had core.worktree pointing somewhere else (because then the
`git status` invocation will show the differences between the *other*
worktree with the HEAD of *this* worktree).  I think that "git
worktree add" should check if either core.bare is false or
core.worktree is set, and if so then set extensions.worktreeConfig and
migrate the relevant config.

While there may be some concern about non-git clients not
understanding extensions.worktreeConfig, I'd say that this type of
situation is one where we are just flat broken without it.  Without
it, we're stuck in a situation that will: (a) confuse users ("Why does
core.bare/core.worktree seem to get ignored or have incorrect
values?"), (b) confuse non-git clients (are they really going to have
the tricky logic to overrule core.bare/core.worktree when in another
worktree?), (c) confuse git itself after subsequent configuration
tweaks, and (d) (related to item c) lead to ever more complicated
logic in core git to attempt to know when and how to overrule
core.bare and core.worktree as additional concerns enter the picture
(e.g. will someone contribute code to override core.bare/core.worktree
when run from a worktree with extensions.worktreeConfig=true, just as
someone originally wrote code to override core.bare/core.worktree when
the extensions.worktreeConfig setting wasn't present?)


I also think `git worktree add` should handle additional configuration
items related to sparse checkouts (as we've discussed elsewhere in the
past), but that's going a bit outside the scope of this series; I only
mention it so that we're aware the functionality added to `git
worktree add` will be getting some additions in the future.
