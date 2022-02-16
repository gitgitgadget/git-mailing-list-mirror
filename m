Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3CCC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 09:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiBPJYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 04:24:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiBPJYL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 04:24:11 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44C21B31C0
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 01:23:53 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id p15so3142882ejc.7
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 01:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=T/gDywfUWxbRRBzjSbI4JmTVzlNaykOOMsVg/hL2TGE=;
        b=azmW+ZJhJjFFjOhwSzMWMuDWOsth118GAOmXGPSFDB5vz1da9mVinisER/J/o9hfOq
         FpBKx/QgTSwQD6ZpY23JOQFs4fJPglyKzAI6Ro31nfvaG5cLkoH6xsIRj4qYWvDbXf9x
         vZ8AqGl/H0r0fbOrJjAic7SKFB5KK3/BgmERYzwYEZ10oGoRwEA5XhGDjTXubVPB10QL
         6N/Ryo/X5JIkQrH9BleHQaarZIymoxVRgCOacqVCZqA53uCgV4+iWkjofUGk2qxVC4GQ
         vanGPDSPRr+mlFIFFf+e6BvJGtCW5L9fJOktwn0+2RlVldnbmeRsTuNgweT/5I1k5V+m
         s4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=T/gDywfUWxbRRBzjSbI4JmTVzlNaykOOMsVg/hL2TGE=;
        b=p0zmixQ6K+eqGHURWIOVW0MOc9kiMWE2bRN8gJP9v7RnB3268G6eTfTm4GTBEbXcPj
         IF43K4dH+uqcJUzdkRFUMgbb9qPadUf9CaoHb3Cbym0hH+8XxJJss5e4eKVL6iL/T7Kz
         qhc3AvEm3NqmXJt5SFp21/DlQz/rftBNC591luhOxRNbEjQq+ZyCemKxO8gL5RzQpzRD
         VdPGbSPiyvSfIfaF+I94YmwImSWVqc/rQJ1+CrfYY1s99wH518gfjdPalDuzTCid6C5j
         mn+4q/LLAddRNLnzNwga3ZlH/rT3+ELarMzYUCd2EWU2E4UM94acactNmjpXQLzisM6U
         U0uA==
X-Gm-Message-State: AOAM531PSiQpX8fvbFDNMN4RyboQ5ri4V72izIVP3NwgdL3NVEYtJ7LQ
        6DOOyRpypL+ApNPu/ZQSH5g7YwefogtVPg==
X-Google-Smtp-Source: ABdhPJzS8gE4I+5r4REyJD0k4cwJa/pYIcsTYCRYmheHotQv2zTOZMebKeG0rFerBWzC3c11oDDwEg==
X-Received: by 2002:a17:906:b2c6:b0:6a9:4bc4:2ec2 with SMTP id cf6-20020a170906b2c600b006a94bc42ec2mr1556312ejb.718.1645003405339;
        Wed, 16 Feb 2022 01:23:25 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x10sm1361958edd.20.2022.02.16.01.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 01:23:24 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nKGWy-0039Ia-97;
        Wed, 16 Feb 2022 10:23:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 4/5] Update documentation related to sparsity and the
 skip-worktree bit
Date:   Wed, 16 Feb 2022 10:15:25 +0100
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
 <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
 <0af00779128e594aff0ee4ec5378addeac8e88a2.1642175983.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <0af00779128e594aff0ee4ec5378addeac8e88a2.1642175983.git.gitgitgadget@gmail.com>
Message-ID: <220216.86k0dvupv7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 14 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Make several small updates, to address a few documentation issues
> I spotted:
>   * sparse-checkout focused on "patterns" even though the inputs (and
>     outputs in the case of `list`) are directories in cone-mode
>   * The description section of the sparse-checkout documentation
>     was a bit sparse (no pun intended), and focused more on internal
>     mechanics rather than end user usage.  This made sense in the
>     early days when the command was even more experimental, but let's
>     adjust a bit to try to make it more approachable to end users who
>     may want to consider using it.  Keep the scary backward
>     compatibility warning, though; we're still hard at work trying to
>     fix up commands to behave reasonably in sparse checkouts.
>   * both read-tree and update-index tried to describe how to use the
>     skip-worktree bit, but both predated the sparse-checkout command.
>     The sparse-checkout command is a far easier mechanism to use and
>     for users trying to reduce the size of their working tree, we
>     should recommend users to look at it instead.
>   * The update-index documentation pointed out that assume-unchanged
>     and skip-worktree sounded similar but had different purposes.
>     However, it made no attempt to explain the differences, only to
>     point out that they were different.  Explain the differences.
>   * The update-index documentation focused much more on (internal?)
>     implementation details than on end-user usage.  Try to explain
>     its purpose better for users of update-index, rather than
>     fellow developers trying to work with the SKIP_WORKTREE bit.
>   * Clarify that when core.sparseCheckout=true, we treat a file's
>     presence in the working tree as being an override to the
>     SKIP_WORKTREE bit (i.e. in sparse checkouts when the file is
>     present we ignore the SKIP_WORKTREE bit).
>
> Note that this commit, like many touching documentation, is best viewed
> with the `--color-words` option to diff/log.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/git-read-tree.txt       | 12 +++--
>  Documentation/git-sparse-checkout.txt | 76 ++++++++++++++++-----------
>  Documentation/git-update-index.txt    | 57 +++++++++++++++-----
>  3 files changed, 98 insertions(+), 47 deletions(-)
>
> diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
> index 8c3aceb8324..99bb387134d 100644
> --- a/Documentation/git-read-tree.txt
> +++ b/Documentation/git-read-tree.txt
> @@ -375,9 +375,14 @@ have finished your work-in-progress), attempt the merge again.
>  SPARSE CHECKOUT
>  ---------------
>  
> +Note: The `update-index` and `read-tree` primitives for supporting the
> +skip-worktree bit predated the introduction of
> +linkgit:git-sparse-checkout[1].  Users are encouraged to use
> +`sparse-checkout` in preference to these low-level primitives.

I was honestly a bit confused about whether we were really referring to
the git-update-index and git-read-tree commands here, or some
sparse-checkout (re-)usage of the same as "primitives", but reading it
again & the commit message we're just talking about the commands here.

So this really just wants to assure readers that they're advised to use
the shiny porcelain command instead of the plumbing.

I think we should refer to these as e.g. "linkgit:git-update-index[1]"
not "`update-index`" here, and call them e.g. "plumbing commands"
instead of "primitives" here, which will address that (the reader
wonders "what's a primitive?").

> -Initialize and modify the sparse-checkout configuration, which reduces
> -the checkout to a set of paths given by a list of patterns.
> +This command is used to create sparse checkouts, which means that it
> +changes the working tree from having all tracked files present, to only
> +have a subset of them.  It can also switch which subset of files are
> +present, or undo and go back to having all tracked files present in the
> +working copy.

In terms of prose I think it's preferred to keep matter-of-fact "Slices
and dices apples, making them easier to eat" instead of "This command
slices and dices apples, which means that it's easier to eat them".

I've forgotten what the linguisting term for that is, but it's more
consistent with our docs, and makes for easier reading.

> +The subset of files is chosen by providing a list of directories in
> +cone mode (which is recommended), or by providing a list of patterns
> +in non-cone mode.

As someone with light familiarity with sparse-checkout:

I'm still not sure if this is telling me that it's preferred to list
directories v.s. patterns, or if it's telling me it's better to operate
in "cone mode" v.s. "non-cone mode", or some combination of the two.

IOW I think peeling out that "(which is recommended)" and making it
clearly refer to which (or both?) of the two we're talking about would
be much better.

> +When in a sparse-checkout, other Git commands behave a bit differently.
> +For example, switching branches will not update paths outside the
> +sparse-checkout directories/patterns, and `git commit -a` will not record
> +paths outside the sparse-checkout directories/patterns as deleted.

(I didn't read through the rest in any detail)
