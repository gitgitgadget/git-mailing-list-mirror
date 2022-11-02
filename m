Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8019CC4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 17:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiKBRYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiKBRYP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 13:24:15 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877E338E
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 10:24:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id n12so47069725eja.11
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 10:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V8D7pzlYRSxJSwXivTsC+DNwqh1uv7k5mHNVxWeoxtk=;
        b=P70RBdUuNfOy4LR0fkhJufH9LBec7dmi5+XOkClbuJv/ohcK+yqe3izgWH8pred/qQ
         EsyO6C2CvmqkMXHAkcqf24/H2uuJ3OEx5sAhgXtU+GkKt5UQLn+pRBz/TcejkYUrdXJf
         Az2fOJ9sbjr9U+adh2s5BUlbl04w44O5K1kQoj+UhQNcPRFJlH4ov3jULojGJq3IJazz
         SpW/kq1KUZ8vPI2PXlaBdPZD7UF2mpvqAGm5S/zS9MeiPT9GghKF3oNwAl2djsI+9WFb
         DokrRQaEbEfXMGiEH7zJzMuIqS2Vlkm0OU5cpO8gNMLWD+PB6oFrjL+lyGJkAzuPnu5L
         tg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8D7pzlYRSxJSwXivTsC+DNwqh1uv7k5mHNVxWeoxtk=;
        b=X1bhFh15ArS+KL1pfIS76AmS41TwZaG4+NcT6rBhG++6kOJDGGQLGAJm+8rXuC1Ij7
         rWTCSf283OkDmiI3SGxTO/BitrL8WuAGRo6VAW77e03zFLKIb1lsplJLaEzZ8p8JlNIc
         tbKjrAMHarHJkTTB+UypXYPDF3RamoNYL5TvAcENxAvWVknLMrX3H585gKUZcPWG4TUq
         L5M7J4oCAoqkbQYs0Mdp658d56FPwIWL91SAy8Is2uW9QIM1pIzbRPBgK209r5VbOu6W
         M/iA20TytNtOdJZjECu6FQ9dKYAiGMqf0VGGCu8VlHOGRjaCngOyZfwsI1WkQxPOWcVW
         N5Jw==
X-Gm-Message-State: ACrzQf0XLV4DWA0PiSw48KVHrvo5OgpPxYlzz83esoNWhAV1SbbylGMj
        1ocXbTEXhfQMQZnFSmoSaAFfNIGjMZTSDA==
X-Google-Smtp-Source: AMsMyM41Z7dRp6T82b0fF0riAE8M8UYfy2XjVP2jgZkxj+TCrKls2zKqc70hi7ABD/gK0K9Xl8VAmQ==
X-Received: by 2002:a17:906:fd8d:b0:780:997:8b7b with SMTP id xa13-20020a170906fd8d00b0078009978b7bmr25064686ejb.635.1667409852987;
        Wed, 02 Nov 2022 10:24:12 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090623e100b007adbd01c566sm1257570ejg.146.2022.11.02.10.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 10:24:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqHTH-00Bu0b-3B;
        Wed, 02 Nov 2022 18:24:11 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: js/bisect-in-c (was: What's cooking in git.git (Oct 2022, #09; Mon,
 31))
Date:   Wed, 02 Nov 2022 18:22:17 +0100
References: <Y19dnb2M+yObnftj@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y19dnb2M+yObnftj@nand.local>
Message-ID: <221102.86cza52rt0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 31 2022, Taylor Blau wrote:

> What's cooking in git.git (Oct 2022, #09; Mon, 31)
> --------------------------------------------------
>
> * js/bisect-in-c (2022-08-30) 17 commits
>  . bisect: no longer try to clean up left-over `.git/head-name` files
>  . bisect: remove Cogito-related code
>  . Turn `git bisect` into a full built-in
>  . bisect: move even the command-line parsing to `bisect--helper`
>  . bisect--helper: make `state` optional
>  . bisect--helper: calling `bisect_state()` without an argument is a bug
>  . bisect: avoid double-quoting when printing the failed command
>  . bisect run: fix the error message
>  . bisect: verify that a bogus option won't try to start a bisection
>  . bisect--helper: migrate to OPT_SUBCOMMAND()
>  . bisect--helper: make the order consistently `argc, argv`
>  . bisect--helper: make `terms` an explicit singleton
>  . bisect--helper: simplify exit code computation
>  . bisect--helper: really retire `--bisect-autostart`
>  . bisect--helper: really retire --bisect-next-check
>  . bisect--helper: retire the --no-log option
>  . Merge branch 'sg/parse-options-subcommand' into js/bisect-in-c
>
>  Final bits of "git bisect.sh" have been rewritten in C.
>
>  Needs review.
>  cf. <xmqqv8pr8903.fsf@gitster.g>
>  source: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>

I see this has been ejected out of "seen", presumably due to the
outstanding conflicts.

To the extent that Johannes doesn't have time I'd by happy to re-roll
this & look at it/fix whatever outstanding issues I spot.

I gave it a once over a few weeks ago, and didn't see any outstanding
problems with it worth rewriting in that iteration, but didn't have time
to give it stress testing to see if there were still some lurking
unexpected/untested behavior changes.

Johannes?
