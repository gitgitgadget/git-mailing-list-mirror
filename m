Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AE7C388F9
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 12:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C8922226
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 12:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm1Bt8nT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgKUMr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 07:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbgKUMr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 07:47:26 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CA0C0613CF
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 04:47:25 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r17so13738756wrw.1
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 04:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Ecw/6NH3DLofp6wQ4qEyR3wcBME2yzwEWUHUXaKyxY=;
        b=Lm1Bt8nTGXhAaSwo3zb4S6LYt7WuqjqabUfXtg395e1LRtteSx4Q6OrIHMGzs/XxIg
         pBZtZgjhMt+3jG/EFtpjy9DPN1Pyo5yFCeVCwJQDosZhQqo6hpoA6LXSmrE38s6EAM3o
         Nits5N8OnTdzbqshb1XloJ3P2AOwn++nZOTHuORAFjAcNI6z+2VsiCnTxow/dWgxcDJO
         41A+RXNCIq1M8ktYudyAixr1ZncFMuSxUcSXIC1HT7htZZzPaKQqVo1dvGrJcVvw79wc
         W0p1+2RivKXHBq9lmVONuWdRYBCaRkWvjZXRbQEC07YCJrbG2cEa37aLrJYiZtbkknGy
         Se3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Ecw/6NH3DLofp6wQ4qEyR3wcBME2yzwEWUHUXaKyxY=;
        b=qEJ8lvBKp8AmS157l0EugRTBxfMCtX85EmGbsMLcvkoiQTAk2ouFzqbYi10eJpQqt7
         ZZ7XmBDHOLH/IaxmPTCD34Ls9C1vpe9eStr0RekbkNqpjexwA5A8MWQBozZsXdibxwcd
         /nwnoLmH+YSDRR9E2X85gg/p/8Rb8BJaq36TKs8+x54qDkTigfTMtxgMfLaAVRQtH5tR
         KKw620MyCulOsQGIzkxBwGkN8Zd0zmq30hzLdBM8s2aRNbZF5gaDbdz4adTh+4+9B8TR
         sBe/Aeb6Su3bKlwllsOIacec2X9AGvZtmnosX0vIkP8T4NO8zzhijCXHzEPzSpWTHJcX
         Q6fA==
X-Gm-Message-State: AOAM530+9IuWXfldKLTvD44d26pwj0oyjlZ6hO9waHEj3STRzMs9ow1S
        /B+DkHvUywkkdopzp6/tYjQPxVcAJPp9uhyNny4=
X-Google-Smtp-Source: ABdhPJxCruqxOzTS8cgim7zW3Nag8ATxbP8t869j8XtLirAdbWYjkJ+sFBcyFhc/tAxGLZqt9YqEqL9UmRcwKBHqsaE=
X-Received: by 2002:a5d:4947:: with SMTP id r7mr20037878wrs.50.1605962844407;
 Sat, 21 Nov 2020 04:47:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.919.git.git.1605891222.gitgitgadget@gmail.com> <5143cba7047d25137b3d7f8c7811a875c1931aee.1605891222.git.gitgitgadget@gmail.com>
In-Reply-To: <5143cba7047d25137b3d7f8c7811a875c1931aee.1605891222.git.gitgitgadget@gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sat, 21 Nov 2020 04:47:13 -0800
Message-ID: <CAPx1GvfaZ-pRznnOQELBYQ7LCk-sr_-Rd0aPcJ6ghM5yt8LpnA@mail.gmail.com>
Subject: Re: [PATCH 3/3] stash: fix stash application in sparse-checkouts
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, matheus.bernardino@usp.br,
        Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 20, 2020 at 8:56 AM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> branch.  However, this simplistic view doesn't quite work in practice,
> because stash tweaks it a bit due to two factors: (1) flags like
> --keep-index and --include-untracked (why we used two different verbs,
> 'keep' and 'include', is a rant for another day)

:-)

Not that this should affect any of these changes, but I'd also note
that the fact that using `-u` or  `-a` makes a third commit that cannot
be ignored later is a problem as well.  (`git stash list` should probably
annotate the listed stashes as to whether they are two- or three-commit
stashes.)

> stash has traditionally gotten this special behavior by first doing a
> merge, and then when it's clean, applying a pipeline of commands to
> modify the result.  This series of commands for
> unstaging-non-newly-added-files came from the following commands:
>
>     git diff-index --cached --name-only --diff-filter=A $CTREE >"$a"
>     git read-tree --reset $CTREE
>     git update-index --add --stdin <"$a"
>     rm -f "$a"
>
> You might that between the merge that proceeded these commands and these

s/might/might think/, perhaps?  And, s/proceeded/preceded/, probably.

(I didn't look closely at the rest of this but the idea seems sound.)

Chris
