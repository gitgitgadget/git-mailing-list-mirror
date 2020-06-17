Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6367AC433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 17:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A737217D8
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 17:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="h7OHadqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgFQR6z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQR6z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 13:58:55 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7568FC06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 10:58:54 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c17so3966384lji.11
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 10:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k7S8GRkTif6Ma8B2Kdsin9azpJCrLO3vU0f/cutI//0=;
        b=h7OHadqY4kkeZ6Dd0QTx9x67cGNb/mmeqHwu3sRJRAb75/3gux43YRjPad0XOxLCeV
         TRigg9zh2WtO0h31ko8mdjw9S0RKUeWQ/pwadUyFccyq6LPV6OUFjVVTiHHJU/g3gwfp
         bMrSaSZLhQH4hDzbEhvK44wW/m4WwSr+gFm8q/ZFfZVK2jAS680H1RGXPvf5m6wjuT6W
         rOU2Lwh/pXIslA3cygYFg7m73xIKzPYzz8dVi3ITSwDP1FEqIf2i36lvnOCixxXNJaUw
         DbKjZBWQSeWqTCc4FxBNtKbX0G0Hb5iHaYbKlZDKtHqAkUtiouE38pOwzjtVMqErp5Ry
         EcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7S8GRkTif6Ma8B2Kdsin9azpJCrLO3vU0f/cutI//0=;
        b=JgPAVWXlxi3g6ooqSHpivgKXyY+/WsjOtqv1/hnvX1avLaKMVBqimwMzRozwIPGM0A
         S2S/wWqFn7HSUxpbObBn2mRhHhIajqnYgyHDzUabR3Yw8LIfFQWOkOdqkK3AzunwQO9z
         7Jui+M2NpmwqyE4oRwpxn2KkBOuEt1apOlkANW5Nz9RRpouv75l6WJkTYCl27i+unAG2
         cyefFxAySjTckruf2jKJFkqCvw5aAMxNSB5xFueyICGciS42QWFycol0OX2BjIyveA8o
         W4HHC3aKS8m/4YHzjs+0g4Q7LpLYiQoFCgBNpHnebPD33pDQdvWigNZWcksZTfK3ELRZ
         meog==
X-Gm-Message-State: AOAM532dOwTEksJm5MK17gdzn9U/WaIohEcPQ1uwQs3lNd4PSsl1Prmj
        6LvnGAGtVM1cS1cSFMq2nHr7VNGs7kj4FEWOqIt30A==
X-Google-Smtp-Source: ABdhPJz0EZ0Stif57foVEJqwvqwX0EPGMJ5+c9TT6Iq+c5o3t+JTNpdNgWvJmUY0rCQn6YSATTDFOC2MXmHTdQt5D+Y=
X-Received: by 2002:a2e:9cc:: with SMTP id 195mr205781ljj.107.1592416732844;
 Wed, 17 Jun 2020 10:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.809.git.git.1592356884310.gitgitgadget@gmail.com>
In-Reply-To: <pull.809.git.git.1592356884310.gitgitgadget@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 17 Jun 2020 14:58:41 -0300
Message-ID: <CAHd-oW5gTJO=6pYXvg3v=JfjffcajPyMpsUOoqXnozwYrg3WwQ@mail.gmail.com>
Subject: Re: [PATCH] unpack-trees: do not set SKIP_WORKTREE on submodules
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 10:21 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Elijah Newren <newren@gmail.com>
>
> As noted in commit e7d7c73249 ("git-sparse-checkout: clarify
> interactions with submodules", 2020-06-10), sparse-checkout cannot
> remove submodules even if they don't match the sparsity patterns,
> because doing so would risk data loss -- unpushed, uncommitted, or
> untracked changes could all be lost.  That commit also updated the
> documentation to point out that submodule initialization state was a
> parallel, orthogonal reason that entries in the index might not be
> present in the working tree.
>
> However, sparsity and submodule initialization weren't actually fully
> orthogonal yet.  The SKIP_WORKTREE handling in unpack_trees would
> attempt to set the SKIP_WORKTREE bit on submodules when the submodule
> did not match the sparsity patterns.  This resulted in innocuous but
> potentially alarming warning messages:
>
>     warning: unable to rmdir 'sha1collisiondetection': Directory not empty
>
> It could also make things confusing since the entry would be marked as
> SKIP_WORKTREE in the index but actually still be present in the working
> tree:
>
>     $ git ls-files -t | grep sha1collisiondetection
>     S sha1collisiondetection
>     $ ls -al sha1collisiondetection/ | wc -l
>     13
>
> Submodules have always been their own form of "partial checkout"
> behavior, with their own "present or not" state determined by running
> "git submodule [init|deinit|update]".  Enforce that separation by having
> the SKIP_WORKTREE logic not touch submodules and allow submodules to
> continue using their own initialization state for determining if the
> submodule is present.

Makes sense to me.

I'm just thinking about the possible implications in grep (with
mt/grep-sparse-checkout). As you mentioned in [1], users might think
of "git grep $rev $pat" as an optimized version of "git checkout $rev
&& git grep $pat". And, in this sense, they probably expect the output
of these two operations to be equal. But if we don't set the
SKIP_WORKTREE bit for submodules they might diverge.

As an example, if we have a repository like:
.
|-- A
|   `-- sub
`-- B

And the [cone-mode] sparsity rules:
/*
!/*/
/B/

Then, "git grep --recurse-submodules $rev $pat" would search only in B
(as A doesn't match the sparsity patterns and thus, is not recursed
into). But "git checkout $rev && git grep --recurse-submodules $pat"
would search in both B and A/sub (as the latter would not have the
SKIP_WORKTREE bit set).

This might be a problem for git-grep, not git-sparse-checkout. But I'm
not sure how we could solve it efficiently, as the submodule might be
deep down in a path whose first dir was already ignored for not
matching the sparsity patterns. Is this a problem we should consider,
or is it OK if the outputs of these two operations diverge?

[1]: https://lore.kernel.org/git/CABPp-BFKHivKffBPO0M_s-JtpiLyEMLZr+sX9_yZk9ZX7ULtbw@mail.gmail.com/
