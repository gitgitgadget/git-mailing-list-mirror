Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-28.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E452C433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 22:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10AAE64EB4
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 22:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhBRWdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 17:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhBRWdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 17:33:09 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1FCC061574
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 14:32:28 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z6so2387094pfq.0
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 14:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=bjD7hQ+HDNKwatzs7+Xp7Nri2b5spEUFvJdB7KeHH4o=;
        b=KulvuomvJkE5eIAA/iTWvc+zD9HMQ+AsNraSu7WjNxNGFra2KN6DiO+wuWqRZ8S4AC
         bsGDkKd058NLmrOGs7UWbPxttE2nnCMqItqnpNudSGW0AoedjF2BzwlS9THuIsU81vdB
         4feVTtnGwXUoJGkOPjh4ZnTAIEiZCQcTSXnPyWc02IglSVwdIazT2Dcth8TaNVI5fyoo
         GNF/M9Qg2iVxxxCy0X8clhry/sCLLZizPBhs+wtJiyi6/Lz7Dw++QLlDl+aCgLohA15W
         TDDy2sKXJ+E2mO2gFDWJfAJF5tORyxCIOGQjewfIsj5N8i4rgjHkNedAXKYQFMilfMCu
         gK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=bjD7hQ+HDNKwatzs7+Xp7Nri2b5spEUFvJdB7KeHH4o=;
        b=myHCq3FnwsYhsh4JVUJpp6lNfRD0h/E635tG4lwcxwHtQUXY/YT0+lrzus4Jsu6Wyw
         831ayvl4PpE4w7yFIttZ9fF2lJCeWoJOyI66xnzTRhPXLKmVWIcDhdXYY8ejZh/Yj4IB
         hhLT3S92yGVHxJi0/9jufcWu97rlf/7iDRLumdXlv3ohgMOwDPXCBFtFvReGp11OKsks
         B5AGiR5+OiAKkYTcYtlGnCzM2wo7RxrJs8Q4K3/JebD9pE5GZp1+tcMd096ABy9forD7
         /RvVvw9EadEBDvaJvawhW5WZcL5RCV/etHOt7PmVdGtlD379fhIEbwmRoNtU4eUZWblj
         sPwg==
X-Gm-Message-State: AOAM5330N1ApT/qFfwc7A7FiWhOGMcVwQn9Mu5DEDG3ZYLmDiEyJwwpq
        KbXZ3QGULv7ke9L/NKMAOoKi5g==
X-Google-Smtp-Source: ABdhPJw2yVIR5qJtJpM0747GV4bZH3HYyulkhhydEfPPowrTaX81IwCbE6kTJ2kl63HCEndS7dsp4w==
X-Received: by 2002:aa7:9571:0:b029:1e6:5f49:24a0 with SMTP id x17-20020aa795710000b02901e65f4924a0mr6340165pfq.25.1613687548292;
        Thu, 18 Feb 2021 14:32:28 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:fca0:af9c:8209:f7cc])
        by smtp.gmail.com with ESMTPSA id t187sm4500539pfb.91.2021.02.18.14.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 14:32:27 -0800 (PST)
Date:   Thu, 18 Feb 2021 14:32:22 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 00/17] use config-based hooks (config-based hooks part
 II)
Message-ID: <YC7q9okiZVEp8Cwx@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20201205014945.1502660-1-emilyshaffer@google.com>
 <20201222000435.1529768-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222000435.1529768-1-emilyshaffer@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.12.21 16:04, Emily Shaffer wrote:
> Since v2:
>  - Renamed 'master' to 'main' in new t5411 (proc-receive) test.
>  - Removed some accidentally included debug strings.
>  - Fixed a nasty bug in the reference-transaction hook conversion where calling
>    'oid_to_hex()' would invalidate references to the output of earlier
>    'oid_to_hex()' runs farther up the callstack. Instead, the hook callsite now
>    uses 'oid_to_hex_r()'.
> 
> Another thing I wanted to do in this series but ended up not having time
> for before the holidays was to figure out a way to consolidate
> Documentation/githooks.txt and Documentation/git-hook.txt. My personal
> preference would be to remove githooks.txt's contents, move the "Hooks"
> header from there into git-hook.txt, and have 'git help githooks'/'git
> help hooks' redirect to git-hook.txt; I don't have a patch to share here
> because I ran out of time before vacation :) What do others envision the
> documentation looking like?
> 
> Thanks!
>  - Emily
> 
> CI run: https://github.com/nasamuffin/git/actions/runs/436905873
> 
> Emily Shaffer (17):
>   commit: use config-based hooks
>   am: convert applypatch hooks to use config
>   merge: use config-based hooks for post-merge hook
>   gc: use hook library for pre-auto-gc hook
>   rebase: teach pre-rebase to use hook.h
>   read-cache: convert post-index-change hook to use config
>   receive-pack: convert push-to-checkout hook to hook.h
>   git-p4: use 'git hook' to run hooks
>   hooks: convert 'post-checkout' hook to hook library
>   hook: convert 'post-rewrite' hook to config
>   transport: convert pre-push hook to use config
>   reference-transaction: look for hooks in config
>   receive-pack: convert 'update' hook to hook.h
>   proc-receive: acquire hook list from hook.h
>   post-update: use hook.h library
>   receive-pack: convert receive hooks to hook.h
>   run-command: stop thinking about hooks
> 
>  Documentation/githooks.txt                    |  45 +++
>  builtin/am.c                                  |  30 +-
>  builtin/checkout.c                            |  16 +-
>  builtin/clone.c                               |   7 +-
>  builtin/commit.c                              |  11 +-
>  builtin/gc.c                                  |   4 +-
>  builtin/merge.c                               |  14 +-
>  builtin/rebase.c                              |   7 +-
>  builtin/receive-pack.c                        | 326 ++++++++++--------
>  builtin/worktree.c                            |  30 +-
>  commit.c                                      |  20 +-
>  commit.h                                      |   3 +-
>  git-p4.py                                     |  67 +---
>  hook.c                                        |  39 ++-
>  read-cache.c                                  |  12 +-
>  refs.c                                        |  38 +-
>  reset.c                                       |  15 +-
>  run-command.c                                 |  66 ----
>  run-command.h                                 |  24 --
>  sequencer.c                                   |  83 ++---
>  t/t1416-ref-transaction-hooks.sh              |  12 +-
>  t/t5411/test-0015-too-many-hooks-error.sh     |  47 +++
>  ...3-pre-commit-and-pre-merge-commit-hooks.sh |  17 +-
>  transport.c                                   |  55 +--
>  24 files changed, 493 insertions(+), 495 deletions(-)
>  create mode 100644 t/t5411/test-0015-too-many-hooks-error.sh
> 
> -- 
> 2.28.0.rc0.142.g3c755180ce-goog
> 

My only complaints on the previous version of this series have now been
resolved, so LGTM.

Reviewed-by: Josh Steadmon <steadmon@google.com>
