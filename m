Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DBFC00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiHUN3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiHUN3c (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:29:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD23F205D2
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:29:30 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fy5so16711845ejc.3
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=DVpwUmHpo9aq63ZZ2dvGdqSCeec65NqpRA074of/gFg=;
        b=f00bRw7wFvxUWPJpiHKNBaF8jGMR3ZuDXsv2HibxQcAUO8YT5+Najb07iOau6MkwWg
         L66fnqPTTOvyuhUEKbDT7OdafEFTCVV4ppjhCMObmUTdQsIZClq48xMdEB53whpUhiRH
         q7lIHVU2NozCeSmgRzVq+2h2KXL05McQAvtKzNRX/bpWHYSf8b15J226wJSKp+5fzDq4
         QVkzxIrmTJmwa4e4RC6Zr8yhHz2jDycx0k7bKBhWgvGdMcXs16xOn2pRkx0wF62AEZct
         E3QXrqc+KUTvJ6MYmF1IDvN0mfQN3oYkmC45AjHvuWfYbNXFLSy6lRfEJotxpmirl5IK
         EzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DVpwUmHpo9aq63ZZ2dvGdqSCeec65NqpRA074of/gFg=;
        b=DiRUZQoeUicBsbM82uM4sl1UoNEkfhUPfpLRGWmp9pd+lwI2d3ovQqUbUj5mSWrfoo
         FejYx43g1MS7oUzgdHmbvQ+RKYd9lqahAHV9Vag3fTL5UmnciSf8+c/hRW0xuVWuk+yL
         1N1N8WMAnrUMo/kLjbjYJqxZBQEyED6XevksuKbSs9Ozzc7kl5cOBZxdmiB9l55wPDm/
         Li+1+y8PQyoFzAgCh3laBuqdISsIAmtzuN8OHIRyboVg/+z0XfWMJ47GzrotMYdhIS8G
         tiuzSk27KJw7YLidyKF2NH8BhAIwtz7KBe89mA1wRtg/nh+ZiAiPvwtcZABbsQ2QJoRL
         61nw==
X-Gm-Message-State: ACgBeo0mxgJAmV46aAPW48Mx1cg3RW28NGbQ3qtf0B8kX5F7Dmj0RmkQ
        6ea2bGEgvw8vVmhgA1OSXfqfD4vSWR4/kw==
X-Google-Smtp-Source: AA6agR5QWwjW/LXNorlm8RfM8aaofLZ6vGTtIo43R01PjZYmY4Cl021ep1VjANF8cfbN6eMNoKGVpw==
X-Received: by 2002:a17:906:ef8c:b0:730:e4e0:1f69 with SMTP id ze12-20020a170906ef8c00b00730e4e01f69mr10308022ejb.113.1661088568789;
        Sun, 21 Aug 2022 06:29:28 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id r11-20020a170906704b00b007315c723ac8sm4829132ejj.224.2022.08.21.06.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:29:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oPl14-0018Zs-1S;
        Sun, 21 Aug 2022 15:29:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: sg/parse-options-subcommand (was: What's cooking in git.git (Aug
 2022, #07; Fri, 19))
Date:   Sun, 21 Aug 2022 15:25:30 +0200
References: <xmqqbksfirfm.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqbksfirfm.fsf@gitster.g>
Message-ID: <220821.86r1194te1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 19 2022, Junio C Hamano wrote:

> * sg/parse-options-subcommand (2022-08-19) 20 commits
>  - builtin/worktree.c: let parse-options parse subcommands
>  - builtin/stash.c: let parse-options parse subcommands
>  - builtin/sparse-checkout.c: let parse-options parse subcommands
>  - builtin/remote.c: let parse-options parse subcommands
>  - builtin/reflog.c: let parse-options parse subcommands
>  - builtin/notes.c: let parse-options parse subcommands
>  - builtin/multi-pack-index.c: let parse-options parse subcommands
>  - builtin/hook.c: let parse-options parse subcommands
>  - builtin/gc.c: let parse-options parse 'git maintenance's subcommands
>  - builtin/commit-graph.c: let parse-options parse subcommands
>  - builtin/bundle.c: let parse-options parse subcommands
>  - parse-options: add support for parsing subcommands
>  - parse-options: drop leading space from '--git-completion-helper' output
>  - parse-options: clarify the limitations of PARSE_OPT_NODASH
>  - parse-options: PARSE_OPT_KEEP_UNKNOWN only applies to --options
>  - api-parse-options.txt: fix description of OPT_CMDMODE
>  - t0040-parse-options: test parse_options() with various 'parse_opt_flags'
>  - t5505-remote.sh: check the behavior without a subcommand
>  - t3301-notes.sh: check that default operation mode doesn't take arguments
>  - git.c: update NO_PARSEOPT markings
>
>  Introduce the "subcommand" mode to parse-options API and update the
>  command line parser of Git commands with subcommands.
>
>  Will merge to 'next'?
>  source: <20220819160411.1791200-1-szeder.dev@gmail.com>

I looked it over is detail this time around (and meant to for v1). I
think that all of what I mentioned in my review can be left for later,
except maybe the subtle change in "case" label fall-through pointed out
in [1], but it doesn't introduce any functional changes. So if SZEDER is
happy with it I'm fine with it.

1. https://lore.kernel.org/git/220819.86h7285a1o.gmgdl@evledraar.gmail.com/
