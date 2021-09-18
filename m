Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775CFC433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 11:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B74A60F43
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 11:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbhIRLSI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 07:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbhIRLSI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 07:18:08 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB56C061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 04:16:44 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id s125so4723560vkd.4
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 04:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wUzMuNFEjQBUqVVOvTjHNrWO55Xahc/83VCqOjplXxk=;
        b=JfrJYZ3mwZuxBB6Ocuiy7XeAZpeoLnB7WTS2xeGw7X+9vFMFsgHK+tMLdtak2h3j8t
         2HuUrFMOl0vo8LQU8hp3CqOvVbUAjtlpeDOTfn8+mG2oCdJ9SplFE20kdReLrz1ORzaR
         F1CKE60Cl7b0kAULYOeTcGC+OWICCXWN4Nbxm5xGcVLEhIk5DtkNxNomF7MerUtuURZY
         seoL5YOdKp4vtG3TckYCR/K4px2prXBPCBwxvjByqG3Luu+gCdfry9teimkR5viLoLcS
         +x7MyniixpJgUi4s5Z/Rkz0iRc4R0lyzenTPLK2+YK8nhw20q1Ti2xiTw2/366nUSsR7
         6k6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wUzMuNFEjQBUqVVOvTjHNrWO55Xahc/83VCqOjplXxk=;
        b=ZQQvw58JwYaS1RWs/PXh7l0a7CxnMUDAXwyBxUr0hhJEItfshwsq9jPYJQDFQx1LRS
         FMHMH64Bl3sFmRQFuZxdJqMDcfITCX+qWMGR+cxRYGH8ZYW57JXGPoNFwZll5sYUt2MY
         cFQbpQext8VWkKlE0MjGTR1rR1LFQwS20UqDMQMdl6gPjrTR+cKATJ18THulQzVoprTP
         3R8cyVNQG6tAggK4b3yC7WINdRo8fWA0DjXjYEv9Obgju6Cf9AUPFQ4dE7tEvCUMmX54
         5L4+F7GtQghTujZUCikcLXvMeniyZLVRURRvdFG9cR3Vmq2YmF18ylkgXoDl0tmDw4Cu
         4koQ==
X-Gm-Message-State: AOAM5332TwQDQLRyCjRmtSnAPE45j+3+49elOIwHnV0iFEbZFXQ7v8F9
        RtxZkZsghhqXWhDh6OJiEroZCkkw4VyU17SjWtMAiEFovwo=
X-Google-Smtp-Source: ABdhPJxGMZy3yZAnwDFcE20SLyphXGAEGanGLEIWVFYivL21AI1mKc/N/VoyxmDNR8C1r/Hddp3tttKvAh+T53IQjfQ=
X-Received: by 2002:a05:6122:8d4:: with SMTP id 20mr10967773vkg.19.1631963803873;
 Sat, 18 Sep 2021 04:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqlf3ug3q7.fsf@gitster.g>
In-Reply-To: <xmqqlf3ug3q7.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 18 Sep 2021 04:16:32 -0700
Message-ID: <CAPUEsphMUNYRACmK-nksotP1RrMn09mNGFdEHLLuNEWH4AcU7Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #05; Fri, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * cb/plug-leaks-in-alloca-emu-users (2021-09-16) 2 commits
>   (merged to 'next' on 2021-09-16 at 2eecae2de3)
>  + t0000: avoid masking git exit value through pipes
>  + tree-diff: fix leak when not HAVE_ALLOCA_H
>
>  Leakfix.
>
>  Will merge to 'master'.

Not arguing against, but just to make clear that this is
unmasking 4 additional leaks in `git show` that have no fix yet.

So if someone were to run a SANITIZER=leak build it will fail in t0000
while before it will look like it succeeded (at least).

FWIW those leaks don't exist in maint, and while I have brute forced
fixes for them, those fixes are not correct and at least one of them
might need assistance from dscho who is in PTO.

> * cb/pedantic-build-for-developers (2021-09-03) 3 commits
>   (merged to 'next' on 2021-09-10 at b8df102019)
>  + developer: enable pedantic by default
>  + win32: allow building with pedantic mode enabled
>  + gettext: remove optional non-standard parens in N_() definition
>
>  Update the build procedure to use the "-pedantic" build when
>  DEVELOPER makefile macro is in effect.
>
>  Will merge to 'master'.

I was really expecting someone to complain while this was in "next",
while there is not much that can be done by cooking it for longer if
who would be affected doesn't build "next", I wouldn't be surprised if
people complain, so like the previous topic is likely to be "noisy".

> * ab/sanitize-leak-ci (2021-09-16) 2 commits
>  - tests: add a test mode for SANITIZE=leak, run it in CI
>  - Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS
>
>  CI learns to run the leak sanitizer builds.
>
>  Will merge to 'next'?

This is always failing in "seen", and as explained above will fail
also in "next" and "master" which then make it unlikely to be a useful
indicator of quality.
I think it will be more useful merged into next, if it will only fail
there if the guilty topics from "seen" will also get merged, and of
course will be even more useful if not failing, but I haven't seen
much action there, and as explained above, I am also part of the
problem.

> * hn/reftable (2021-09-10) 20 commits
>  - fixup! reftable: implement stack, a mutable database of reftable files.
>  - Add "test-tool dump-reftable" command.
>  - reftable: add dump utility
>  - reftable: implement stack, a mutable database of reftable files.
>  - reftable: implement refname validation
>  - reftable: add merged table view
>  - reftable: add a heap-based priority queue for reftable records
>  - reftable: reftable file level tests
>  - reftable: read reftable files
>  - reftable: generic interface to tables
>  - reftable: write reftable files
>  - reftable: a generic binary tree implementation
>  - reftable: reading/writing blocks
>  - Provide zlib's uncompress2 from compat/zlib-compat.c
>  - reftable: (de)serialization for the polymorphic record type.
>  - reftable: add blocksource, an abstraction for random access reads
>  - reftable: utility functions
>  - reftable: add error related functionality
>  - reftable: RFC: add LICENSE
>  - hash.h: provide constants for the hash IDs
>
>  The "reftable" backend for the refs API, without integrating into
>  the refs subsystem.
>
>  Will merge to 'next'?

I reported a minor issue[1] with OpenBSD which AFAIK hasn't been
included in a reroll yet
There were also concerns about some interfaces being unnecessarily
public[0] and code style issues that IMHO might be worth tackling
while the series can be replaced wholesale.
FWIW this used to be also one of the topics causing the leak CI failures[2]

Carlo

[0] https://lore.kernel.org/git/d3c6bd3d-9f1c-00e3-fa31-67ad0d45fdbf@ramsayjones.plus.com/
[1] https://lore.kernel.org/git/CAPUEspiY=V3y10nc-xUpv7AXwtTv1e1jyRC6FvRrcS3H_ASNnw@mail.gmail.com/
[2] https://lore.kernel.org/git/87sfyfgtfh.fsf@evledraar.gmail.com/
