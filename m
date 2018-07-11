Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A78FB1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 17:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733047AbeGKRkd (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 13:40:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34883 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732860AbeGKRkc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 13:40:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id a3-v6so9766221wrt.2
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 10:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+AIPZVYZA3ubd/EixJK47r7At/CUWb7jsYS/EmEhSpc=;
        b=hIEBGd9dhH+pd0BaecY2gs49pTCr/AU/i9T2pJ5Z8ec5oRs3dJE+qipgyjSScM/jV3
         Aqy2A9uSYCNOjnsRusWukNwZN1F0g2IFaAjWhDUvSftjL3vbZgJ/tkf/qLWInwJjFNxO
         1Hd28WQsKyOODMkaD7mL8WnFSdaNpgP0Kx9mEMeM5yZRy9iqWUCu9Qxqg5pGOQTAIzSc
         epd8ChsiflwqRS6m1vw0kHgI+f5+oh9s/CVjCDSTcD3B0ndO+6qUNywFMYLSEPprn57y
         nAzG1fPODniSxjjqJUEdJ3NTomh84gDviwjUatYnVo4vWvYpgue98xjRNIoZT0lEd+rN
         dz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+AIPZVYZA3ubd/EixJK47r7At/CUWb7jsYS/EmEhSpc=;
        b=nkcCF/xIhqRAcppek3Mxj8fzGD4+jFttutpd+sFXXYYiiPl4Ala6Ixtl2vQnnZ6iI7
         XYeJk/ecRQD4CcmMmljGoDEQUmuR57SkHuu6BiO+QiasZ+7W7OAU11k/HtrCSdEDKrql
         qsZDI6RVykhZDkObSqVtiWSJK5vHQbcritnDODRyuFPDBaCrUABLmVfOgUHAA3adS0eg
         IQ3VOrTrk/JtO9jrx+xx6nlzO1tRgqp1BScJJbTryTs9mPTy5zfvIx0U571miMBN8oy9
         PH93mROLEVpR2nfJHywNWFdQCpKZoELxpVL5likbHlzwP1IpL8HjloxE9hV0FQIiNTBc
         F+6Q==
X-Gm-Message-State: APt69E3L1Tc6e6SK9/uYsKywlqtaeq1w5yXeTPD9TYCuIz4SXTocdP9j
        AhQIb8tkCjBUtaq4uQNa5xU=
X-Google-Smtp-Source: AAOMgpevcBw0yTTRUZpVUNAJA8prOj8Ovwgr87wzov1f2ZOW2TgLsHG5ILiOQkJi1Y13gO9MeXp9wQ==
X-Received: by 2002:adf:fa45:: with SMTP id y5-v6mr23650748wrr.138.1531330509911;
        Wed, 11 Jul 2018 10:35:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w21-v6sm3022974wmw.29.2018.07.11.10.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 10:35:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] rebase -r: support octopus merges
References: <pull.8.git.gitgitgadget@gmail.com>
Date:   Wed, 11 Jul 2018 10:35:08 -0700
In-Reply-To: <pull.8.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Wed, 11 Jul 2018 12:38:09 +0000")
Message-ID: <xmqqbmbd3cc3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> The `--rebase-merges` option of `git rebase` generates todo lists that include the merge commits that are to be rebased.
>
> To keep things simpler to review, I decided to support only regular, 2-parent merge commits first.
>
> With this patch series, support is extended to cover also octopus merges.

;-)

To be honest, I am not sure if there still are people who use
octopus (even though I freely admit that I am guilty of inventing
the term and the mechanism), given its downsides, primary one of
which is that it makes bisection less efficient.

Nevertheless, this *is* the right thing to do from feature
completeness point of view.  Thanks for following it through.

>
> Johannes Schindelin (3):
>   merge: allow reading the merge commit message from a file
>   rebase --rebase-merges: add support for octopus merges
>   rebase --rebase-merges: adjust man page for octopus support
>
>  Documentation/git-merge.txt  |  10 ++-
>  Documentation/git-rebase.txt |   7 +-
>  builtin/merge.c              |  32 +++++++
>  sequencer.c                  | 168 ++++++++++++++++++++++++++---------
>  t/t3430-rebase-merges.sh     |  34 +++++++
>  5 files changed, 204 insertions(+), 47 deletions(-)
>
>
> base-commit: e3331758f12da22f4103eec7efe1b5304a9be5e9
> Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-8%2Fdscho%2Fsequencer-and-octopus-merges-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-8/dscho/sequencer-and-octopus-merges-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/8
