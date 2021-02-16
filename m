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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D795CC433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 19:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B000B64D7F
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 19:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhBPTq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 14:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhBPTq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 14:46:58 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0662C061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 11:46:17 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id q20so6812212pfu.8
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 11:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=YWgNjr4/TLZ0DAGTWdwqPjRmuzlUDl92gjdssUnuhYs=;
        b=FKl1OQvQCYxhBmuy6fQ6JNk0e1Q2UI30lw942nHRfC09mY38woz6sYnQkmrskupyau
         mhhH2Uo7XgrJcr5DzJJUASWd9wkAUemSnZGvlW8MAUO35+2rG/3q3NTyAyFQQDjAlZ8y
         vhadI+9jqgi4L8jSlBbo+LbhLExHtnTkUcuWFMDKIpZpqFwCIKVajbCeFZCFc+y4UZeR
         APV5cnebbKSefMTZ353Qbi50ktKOZkWlRkj4xiCM72psDvtjwF+C9ODCRixlqNb+nVSl
         08G6+mQJxdcHlrz0frl+7s358s2J9dl1/Xx0MS/wc8Tm447MasuFRNmut3F6yt+alKrq
         mMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=YWgNjr4/TLZ0DAGTWdwqPjRmuzlUDl92gjdssUnuhYs=;
        b=LOz5NkVFO1FAaqs75X0V3Gc8+5ZRkvQsciAXz8SovL2Ytt8H6EdnrMogJoSPOmaqjc
         fQ2mjVWMjfApqZaY3ZZOvdGnbt71RjlA7u5iX85EzBBj9cRouchspNvt4D00jmCpv2JN
         4Ndc9cWwqCAcgZ5sMI3dn4YPeLHuJxFkS8tJgpO4DV24rg4itI4ryPrBT4gdIjP4C5am
         3RwTBy9cKXTQFCEo0t0wc6m4sSGtudZTGrIIaPmF0bWaFFCDDApCS3cd+bgRwRSOM/r5
         0m1pvF2ESXA0wp1ffR2OQ7eUwZ61vemTTfGNtuew8LxfRpDEZRojPbmSay4pH5ZS6h9C
         fi8g==
X-Gm-Message-State: AOAM532EoMw8IM98nsZ34ZJa6wIPx/zd2WQ7yc3WfRbfB1wlcj2bc+2W
        TB7JCP6zi3jkrzSc1o4dbD2KqoEbw/2G/g==
X-Google-Smtp-Source: ABdhPJz17hESzTKyiMTI0CJ4YMQLZ49ouK4KgaXKIucIEqATz5+tXiorRT8dsVpgSd5FmhAwLxF2Fw==
X-Received: by 2002:aa7:9018:0:b029:1d9:55d7:1ffc with SMTP id m24-20020aa790180000b02901d955d71ffcmr20832867pfo.71.1613504777307;
        Tue, 16 Feb 2021 11:46:17 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:708a:4111:699b:757])
        by smtp.gmail.com with ESMTPSA id q18sm24587559pfg.72.2021.02.16.11.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 11:46:16 -0800 (PST)
Date:   Tue, 16 Feb 2021 11:46:11 -0800
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
Subject: Re: [PATCH v7 00/17] propose config-based hooks (part I)
Message-ID: <YCwhA6VIs16uMnJG@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20201205014607.1464119-1-emilyshaffer@google.com>
 <20201222000220.1491091-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222000220.1491091-1-emilyshaffer@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.12.21 16:02, Emily Shaffer wrote:
> Since v6:
> 
>  - Converted 'enum hookdir_opt' to UPPER_SNAKE
>  - Coccinelle fix in the hook destructor
>  - Fixed a bug where builtin/hook.c wasn't running the default git config setup
>    and therefore missed hooks in core.hooksPath when it was set. (These hooks
>    would still run except when invoked by 'git hook run' as the config was
>    called by the processes which invoked the hook library.)
> 
> CI run: https://github.com/nasamuffin/git/actions/runs/436864964
> 
> Thanks!
>  - Emily
> 
> Emily Shaffer (17):
>   doc: propose hooks managed by the config
>   hook: scaffolding for git-hook subcommand
>   hook: add list command
>   hook: include hookdir hook in list
>   hook: respect hook.runHookDir
>   hook: implement hookcmd.<name>.skip
>   parse-options: parse into strvec
>   hook: add 'run' subcommand
>   hook: replace find_hook() with hook_exists()
>   hook: support passing stdin to hooks
>   run-command: allow stdin for run_processes_parallel
>   hook: allow parallel hook execution
>   hook: allow specifying working directory for hooks
>   run-command: add stdin callback for parallelization
>   hook: provide stdin by string_list or callback
>   run-command: allow capturing of collated output
>   hooks: allow callers to capture output
> 
>  .gitignore                                    |   1 +
>  Documentation/Makefile                        |   1 +
>  Documentation/config/hook.txt                 |  19 +
>  Documentation/git-hook.txt                    | 117 +++++
>  Documentation/technical/api-parse-options.txt |   5 +
>  .../technical/config-based-hooks.txt          | 355 +++++++++++++++
>  Makefile                                      |   2 +
>  builtin.h                                     |   1 +
>  builtin/bugreport.c                           |   4 +-
>  builtin/fetch.c                               |   1 +
>  builtin/hook.c                                | 176 ++++++++
>  builtin/submodule--helper.c                   |   2 +-
>  command-list.txt                              |   1 +
>  git.c                                         |   1 +
>  hook.c                                        | 416 ++++++++++++++++++
>  hook.h                                        | 154 +++++++
>  parse-options-cb.c                            |  16 +
>  parse-options.h                               |   4 +
>  run-command.c                                 |  85 +++-
>  run-command.h                                 |  31 ++
>  submodule.c                                   |   1 +
>  t/helper/test-run-command.c                   |  46 +-
>  t/t0061-run-command.sh                        |  37 ++
>  t/t1360-config-based-hooks.sh                 | 256 +++++++++++
>  24 files changed, 1717 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/config/hook.txt
>  create mode 100644 Documentation/git-hook.txt
>  create mode 100644 Documentation/technical/config-based-hooks.txt
>  create mode 100644 builtin/hook.c
>  create mode 100644 hook.c
>  create mode 100644 hook.h
>  create mode 100755 t/t1360-config-based-hooks.sh
> 
> -- 
> 2.28.0.rc0.142.g3c755180ce-goog
> 

Sorry for the delayed reply. I am happy with this series as-is. Thanks
for all your work on it!

Reviewed-by: Josh Steadmon <steadmon@google.com>
