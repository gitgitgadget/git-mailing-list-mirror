Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25601C433ED
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 15:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8528613C4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 15:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbhDVPdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 11:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhDVPdi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 11:33:38 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24D5C06174A
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 08:33:03 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id g24so3254027uak.11
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 08:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ltP9H/KHla5BW10qOkLTq59kKjg5Hn6ME/OcCcltbYQ=;
        b=axoYhCiv7C0h+lFuY9aF34wfaf2SXUJjk1vBExl7DRAR7WsIGFg5f/6PnzwRICFlmx
         C4hEtt4e9il0Hk6atbU8uI2GUYEP600uAbFeLl0JjeOcG3V0DxhozcbXYK+vtdYUs7Gs
         aoaJuwbFxvgo8MD8Vm2sWiSTjFTjnj/qwoXllGrdmnxG8WnlOv5io4U56U8/Y5QORcs5
         itkF+iqpspH1KoBg/py0kK7Hb7P7GiHsfFdpx6GtNVYcOe1ZTsuqhQOfYq/d73LrVVFR
         xjDFjlTE9nFOayUvRjOEtsKNWRrf0/J6GbL+AoC1xurzCD9e2He3WWo+MXmQnWADJG2C
         jfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltP9H/KHla5BW10qOkLTq59kKjg5Hn6ME/OcCcltbYQ=;
        b=s/svmlnud/kLRNUU+tpHyB2SoaTpqM4RQEtzDBqEsisBu9HQkySlgzOlky5T1eDFpR
         YeCyrL2HHNE7utEci6hOPnAv8WCGb57vRSMkx0IwP3oGCaSehnA2KYX1RMUInJByTwW6
         Gu3u6vR23MSBKeIinm7uSrh1mgZkG6u99o8Xnqq0AMTjJ2KiA+lRorcHialLLokWpP4Y
         v+V0nIokVHtsR5M4bnRA4OkseW626jlzIVamWTudao2uiQ4Xx77w/GdiIegzVfc163Qf
         NHdXdmvwhwP8XMsDrNeEfxB+Mwx4xaFkA8xn0rmdbr0CTorscncskRUtVIxShQe5xEjx
         D1ww==
X-Gm-Message-State: AOAM531LIRV4WBL25+nlAGPEKROi1fqAw/zplzVHS1DLzTzMpMRcVS4F
        fEr73GvJO+jPLWQV1UC8ru+OU+fe6ItfJu2a8yQ=
X-Google-Smtp-Source: ABdhPJztwnyk1993XuLezDw94cQhDTKLzyutY7ipfpKQ/Nlf+my363sDCBxRQTE4RtyoHLr8ibM+wGNFCDz9f1O5OXI=
X-Received: by 2002:ab0:6030:: with SMTP id n16mr3287303ual.87.1619105582852;
 Thu, 22 Apr 2021 08:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <YHofmWcIAidkvJiD@google.com>
In-Reply-To: <YHofmWcIAidkvJiD@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 22 Apr 2021 08:32:52 -0700
Message-ID: <CA+P7+xrTSBVWcX2uZmHAErKWXAFHesGNv5cizeTfmX5yuJCD-g@mail.gmail.com>
Subject: Re: RFC/Discussion - Submodule UX Improvements
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertcui@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 16, 2021 at 4:38 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> -- Create mode (git switch -c / git checkout -b)
>
> 1. The current worktree is checked for uncommitted changes to tracked files. The
>    current worktree of each submodule is also checked.
> 2. A new branch is created on the superproject; that branch's ref is pointed to
>    the current HEAD.
> 3. The new branch is checked out on the superproject.
> 4. A new branch with the same name is created on each submodule.
>   a. If there is a naming conflict, we could prompt the user to resolve it, or
>      we could just check out the branch by that name and print a warning to the
>      user with advice on how to solve it (cd submodule && git switch -c
>      different-branch-name HEAD@{1}). Maybe we could skip the warning/advice if
>      the tree is identical to the tree we would have used as the start point
>      (that is, the user switched branches in the submodule, then said "oh crap"
>      and went back and switched branches in the superproject).
>   b. Tracking info is set appropriately on each new branch to the upstream of
>      the branch referenced by the parent of the new superproject commit, OR to
>      the default branch's upstream.
> 5. The new branch is checked out on each of the submodules.
>
> What doesn't already work:
>
>   * Safety check when leaving uncommitted submodule changes
>   * Propagating branch names to submodules currently requires a custom hacky
>     repolike patch
>   * Error handling + graceful non-error handling if the branch already exists
>   * "Knowing what branch to push to": copying over which-branch-is-upstream info
>     ** Needs some UX help, push.default is a mess
>   * Tracking info setups
>


As someone who uses submodules extensively for various projects, I'm
not sure about propagating branches into the submodules.

I think i'd only want this behavior if/when I intend to work on a
submodule. Because of the nature of submodules being distinct, we tend
towards doing submodule work separately, merging it, and then pulling
that change into the super project.

>
> -- Switching to an existing branch (git switch / git checkout)
>
> 1. The current worktree is checked for uncommitted changes to tracked files. The
>    current worktree of each submodule is also checked.
> 2. The requested branch is checked out on the superproject.
> 3. The submodule commit or branch referenced by the newly-checked-out
>    superproject commit is checked out on each submodule.
>
> What doesn't already work:
>
>   * Same as in create mode

I'd imagine there are multiple cases here. For cases where you're not
actively developing submodule, you want to just checkout the right
contents (i.e. what is tracked by the super project). But if you're
developing the submodule in conjunction with the super project you
might want to instead checkout the matching work (as in above where
you create a branch within the submodule?)

> - git status
>
> -- From superproject
> The superproject is clean if:
>
>   * No tracked files in the superproject have been modified and not committed
>   * No tracked files in any submodules have been modified and not committed
>   * No commits in any submodules differ from the commits referenced by the tip
>     commit of the superproject
>
> Advices should describe:
>
>   * How to commit or drop changes to files in the superproject
>   * How to commit or drop changes to files in the submodules
>   * How to commit changes to submodule references
>   * Which commit/branch to switch the submodule back to if the current work
>     should be dropped: "Submodule "foo" no longer points to "main", 'git -C foo
>     switch main' to discard changes"
>
> What doesn't already work:
>
>   * "git status" being super fast and actually possible to use.
>     ** (That is, we've seen it move very slowly on projects with many
>        submodules.)
>   * Advice updates to use the appropriate submodule-y commands.
>

Yea, a slow status means people tend to not use it!

> -- From submodule
>
> git status's behavior for submodules does not change compared to
> single-repository Git, except that a red warning line will also display if the
> superproject commit does not point to the HEAD of the submodule. (This could
> look similar to the detached-HEAD warning and tracking branch lines in git
> status today, e.g. "HEAD is ahead of parent project by 2 commits".)
>
> What doesn't already work:
>
>   * "git status" from a submodule being aware of the superproject.
>

This seems like a very good improvement. One of the biggest complaints
about submodules I've had to deal with when helping coworkers is the
fact that submodules weren't moved forward automatically, and that
they had no real idea that the submodule was different. This tended to
lead towards commits including submodule rewinds on accident.


> - Worktrees
>
> When a user runs 'git worktree add' from the superproject, each submodule in the
> new worktree should also be created as a worktree of the corresponding submodule
> in the original project.
>
> What doesn't already work:
>
>   * worktrees and submodules getting along - submodules are now freshly cloned
>     when creating a superproject worktree

This is something I would love to see fixed!  Right now using work
trees on a project with submodules is problematic. Especially a
project with many submodules, as this ends up making many extra
clones, taking disk space and network time to setup.

>
> - git clone --reference [--dissociate]
>
> When cloning with an alternate directory, submodules should also try to use
> object stores associated with the referenced project instead of cloning from
> their remotes right away. It is unclear how much of this works today.
>
>
> What doesn't already work:
>
>   * Writing some tests and making them pass
