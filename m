Return-Path: <SRS0=euRE=EN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A56CC388F9
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 10:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C5F20704
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 10:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEiXv8el"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgKGKrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Nov 2020 05:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgKGKrh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Nov 2020 05:47:37 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9466EC0613CF
        for <git@vger.kernel.org>; Sat,  7 Nov 2020 02:47:36 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id j14so3797689ots.1
        for <git@vger.kernel.org>; Sat, 07 Nov 2020 02:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ok0UeMkwE+KhdXcfHNwJDB6/A8aLO5e88gB5wtimFr4=;
        b=PEiXv8elS3d9UFSgzETQy/He+obh89AABpGeRwyqKmcUAYFvuRg3789geWlQhxvu1j
         JbCjLOexvWj/vpkqg5HJo56MfoM/vsonCtO3kp0Pw51ujWsBXkNqWnW6sZoskJXi2C+Z
         C1vYlym5R9wfwIYbKZao8A9rBJuHeOgM+gk/j/xPr9Eh3flLfIORv/TCBsmQzcAvsfBP
         Y2JKXqYsrD0n+7C2VXFsovuPNBL1l4I5Jq9uWICepT7KIC9ZSVGTv56bzMaspydnVEcs
         rik5UzsEn1Vt01E1qCpTtRVb5pxakgu25XeNHuowPEnu9y49DA2u5g6goJvx+kpSwXF4
         xfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ok0UeMkwE+KhdXcfHNwJDB6/A8aLO5e88gB5wtimFr4=;
        b=iEzXlFjzzUN88nLNBzZ3M3c0/oDbGWH2NLbc5oKDrL5wGyISmsWBHGubRr97DXaEDi
         o+k65nbPidU/wrlK61U9BMIo9horp39p1M+u01F550yIa9ZzBcMybcvev9XWdvN+vKbL
         J8G1bFtsaeVOMXqYVtRZ6lHYrVvxzv+lkaWHqjirFpuWlp0BgZHqgUmYTCW0SW50n1/t
         rk9pUl4qjGPEsXj1u7plNXAxiUVbmTYxwz29mywtN8wFZC7KIBO/Vp/XrJ+QtW9c/glV
         et2UzM5LiR6D2YCMU1tnDmyWNJLO1CZ6aGGnB3gl79MhjxGMI1mz7zIR7p/15UEnZwzG
         LJ1w==
X-Gm-Message-State: AOAM533Ng98WyIjfRz8/rbllgZd6yAh0EiNBnFeKkAUu8Zq/dxQaKAPi
        Zi2I4/DZbRpL0iNHXs/QZHVfXtuWJEMumZ7lmQc=
X-Google-Smtp-Source: ABdhPJyWINy/uFEIpe8U30ZPQFlfxGBjt0u3sDFdy1k6oSAhnK77oP0NrIbbmXJ8jmuFsjW8bTkqRVnHS0ZKJldPFSQ=
X-Received: by 2002:a9d:3f66:: with SMTP id m93mr4224531otc.35.1604746056050;
 Sat, 07 Nov 2020 02:47:36 -0800 (PST)
MIME-Version: 1.0
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
 <20201026175742.33356-1-sangunb09@gmail.com> <CAHjREB7W2P9_P4LoMHVVzV_YR5-_51zdbRZ0fpEDVkgkd7sh8w@mail.gmail.com>
 <xmqqblges4ue.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqblges4ue.fsf@gitster.c.googlers.com>
From:   Sangeeta <sangunb09@gmail.com>
Date:   Sat, 7 Nov 2020 16:17:24 +0530
Message-ID: <CAHjREB7-QWHBOQQPdDdEM-gJm=w3+4D=N=5TaS3UE__6XnSpJA@mail.gmail.com>
Subject: Re: [Outreachy][PATCH v6] diff: do not show submodule with untracked
 files as "-dirty"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,

I worked on passing --ignore-submodules=none as the default behavior
of git status so that the user doesn't end up deleting a submodule
that has uncommitted (untracked) files.

The following changes make git status pass the ignoreSubmodules none
argument as default.

@@ -4587,7 +4587,7 @@ void repo_diff_setup(struct repository *r,
struct diff_options *options)
        options->orderfile = diff_order_file_cfg;

        if (!options->flags.ignore_submodule_set)
-               handle_ignore_submodules_arg(options, "untracked");
+               options->flags.ignore_untracked_in_submodules = 1;

        if (diff_no_prefix) {
                options->a_prefix = options->b_prefix = "";


@@ -607,6 +607,9 @@ static void
wt_status_collect_changes_worktree(struct wt_status *s)
                rev.diffopt.flags.override_submodule_config = 1;
                handle_ignore_submodules_arg(&rev.diffopt,
s->ignore_submodule_arg);
        }
+       else if(!rev.diffopt.flags.ignore_submodule_set){
+               handle_ignore_submodules_arg(&rev.diffopt, "none");
+       }

I have had to set the flag manually in diff.c because when we call
handle_ignore_submodules_arg() with "untracked" arg,
options->flags.ignore_submodule_set is set to 1 and therefore when we
check for it in wt-status.c it appears that user has already set some
config and therefore we shouldn't add "none" as ignoreSubmodules arg.

Another way to do that is to have one more flag in diff_options that
can let us know whether options->flags.ignore_submodule_set was set by
the user or by diff passing untracked as the default argument.

Can someone please help me with what might be the right way to proceed?

Thanks!
