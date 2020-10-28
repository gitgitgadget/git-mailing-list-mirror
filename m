Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD5FC388F7
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 21:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 371CC246CD
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 21:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgJ1Vo5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:44:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35080 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgJ1Vo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 17:44:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id n15so660059wrq.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 14:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6GmMgxDqzxhiyc7rmiux9RumsArwmCU7shrr5OXnp9A=;
        b=ezYyUFpvO4MT0ZXOA9PahZAjHzUer6Qz3TgOO19pEqOYH5nhg9zAbLaNR0dzeIeuhZ
         vTBVWMqtb2PAtBKtjvO7gwAN+OBUedLWryp+Z1wMkoB9eZop8+790BVDeh6RfDzKVwAi
         mPByPGymR3JVQbFoOvnHgCkGsyGXJ7t5DhOsGCrta4NERiHPKd0h60Ksn3aci3c9PBbf
         RTGet/A4Cc8M6go0gbC1iJ+grS5BrmnQN2/qOjMrn5h2MApE9vqitH/J9kxJaiYAB5nX
         Lo4L9VJCumE6JGXX2YlM026WIJuT7g89+UPqakEFUpne1UIe7og6qUns1WLK1cZEH+cu
         3lJw==
X-Gm-Message-State: AOAM5301Zbx+2ZZavwR2e6OpLFit4UoXMNjrslAFOKDdY+1HMAzKhG8v
        8f6RiURw3V+ioKQ5bHlciJN2U7Ft/ONYiy/zIDca6IzH
X-Google-Smtp-Source: ABdhPJw6UMu0vp+Zf+RNCq/XIcOJeBDIR+amVa48Vp/kFaf65DzhEM9LH4PQDs66iZgfSYxmcC8U7CFv37TdFfF1QoQ=
X-Received: by 2002:a17:906:f24b:: with SMTP id gy11mr123022ejb.371.1603906400347;
 Wed, 28 Oct 2020 10:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.774.git.1603889270.gitgitgadget@gmail.com> <27ef94e9cc4189c3d74e984437dcce24e1f29678.1603889270.git.gitgitgadget@gmail.com>
In-Reply-To: <27ef94e9cc4189c3d74e984437dcce24e1f29678.1603889270.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 28 Oct 2020 13:33:09 -0400
Message-ID: <CAPig+cRFaT9ww3K368b58m-xgW843jhZWjXDspVrfdyYY-_wRA@mail.gmail.com>
Subject: Re: [PATCH 5/6] line-log: mention both modes in 'blame' and 'log'
 short help
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 28, 2020 at 8:48 AM Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> 'git blame -h' and 'git log -h' both show '-L <n,m>' and describe this
> option as "Process only line range n,m, counting from 1". No hint is
> given that a function name regex can also be used.
>
> Use <range> instead, and expand the description of the option to mention
> both modes. Remove "counting from 1" as it's uneeded; it's uncommon to
> refer to the first line of a file as "line 0".
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
> diff --git a/builtin/blame.c b/builtin/blame.c
> @@ -889,7 +889,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
> -               OPT_STRING_LIST('L', NULL, &range_list, N_("n,m"), N_("Process only line range n,m, counting from 1")),
> +               OPT_STRING_LIST('L', NULL, &range_list, N_("range"),
> +                               N_("Process only the given line range (<range>=<start>,<end>) or function (<range>=:<funcname>)")),

The "<range>=" bit is redundant and confusing (and ugly). Considering
that the description already says "Process only the given line
_range_", it should be fine to drop the "<range>=" lead-in. Perhaps:

    Process only the given line range <start>,<end> or :<funcname>"

This might feel too succinct, but that's often true of short -h help.
Such succinctness is generally acceptable as long as more detailed
documentation can be discovered easily (such as in the 'man' page).

Same comment regarding the rest of the changes in this patch.
