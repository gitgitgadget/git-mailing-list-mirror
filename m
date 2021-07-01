Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212CFC11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 23:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE0A613DC
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 23:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbhGAXES (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 19:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbhGAXER (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 19:04:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984ECC061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 16:01:46 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id df12so10688409edb.2
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 16:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=W+N8g7jgmprAlsbC3Y98cyb2uK46hcEGHkz/6gME2UE=;
        b=I9rlwfvXePrN2rOF7g4QlaCFG6F5z22yD+rW+OeKfb8CUN2COz+Gqot/XXhqF5ln/y
         Nzr5kMzSIKtES5ao/9SXZk0tnPR2BileyiS6VC2KKIJ9QTMle5+bR7WqPyoG+KhL4mgM
         a02IkedVBM1PokWF0aFv06qVhLeV0cXnSoZfGUZ8rbip9pYspxMvuqiLw1w3sO2n3v4O
         zfGkxPEXMgvMKeMw+lcE7fD7A2nc1EGgPQqWJm+gkaZ+nlpVGWcyEIiNdXZZejs91cRF
         Yug3ewgnkRZTvPSmR9flfln31pJ5ZeESybZqUGQEEkekJPHEA7kyi5ovkBJW5fnGNjwD
         NNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=W+N8g7jgmprAlsbC3Y98cyb2uK46hcEGHkz/6gME2UE=;
        b=lrPUeTnN7YhaSrBP3NraKWxal7R2urySdKbLtPQV5sX4+kQMsRSvZ8A6UNnvcqys2Y
         0RQRKmvdlll2CZL0nWagPHUKxxN2IHAs/MCio0cy07/BQMRrs4Xd8IsCx85T/JD5h+Co
         pC6VrA1O4arsUiK7Qr3HfWovvZ+/a6PGlzOYUOdY0KQkmiUGBIEmrz2HpL1B6NYCB4we
         UXZFMZ3WMNraI/jD5M1C+Z6GoqWKyRxxDT3OoruDy6CobrxAMJHq9/ACJNpdjpToyjq8
         UwacdLYFOEcgwmi3hkPa3f+lLhAS3LdMSQqGcNUCmaLWlF2JN1saLOfhPjaHFZ0Uewy8
         m3eA==
X-Gm-Message-State: AOAM530Y3a8M8qEaWFmvxWWV+ETrfIEdzexkzmV0MGE4iiJwVX/s979U
        d/kRYmEkMm3q/+KO6795R3eF1OGubNbEAA==
X-Google-Smtp-Source: ABdhPJyc8I1Z+Q/fhybh9dKxg3KVsQIWf/2ozPsiRblh4hpJOhh9ykaw4EjTkIzux5Gi2lTTvOAMSw==
X-Received: by 2002:a05:6402:1d2d:: with SMTP id dh13mr2877042edb.282.1625180504818;
        Thu, 01 Jul 2021 16:01:44 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id em20sm389933ejc.70.2021.07.01.16.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:01:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 17/34] fsmonitor--daemon: define token-ids
Date:   Fri, 02 Jul 2021 00:58:28 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <37fdce5ec3afaa9aae5001c648fced0675dae0c4.1625150864.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <37fdce5ec3afaa9aae5001c648fced0675dae0c4.1625150864.git.gitgitgadget@gmail.com>
Message-ID: <87mtr5bpuw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:

> +	if (!test_env_value) {
> +		struct timeval tv;
> +		struct tm tm;
> +		time_t secs;
> +
> +		gettimeofday(&tv, NULL);
> +		secs = tv.tv_sec;
> +		gmtime_r(&secs, &tm);
> +
> +		strbuf_addf(&token->token_id,
> +			    "%"PRIu64".%d.%4d%02d%02dT%02d%02d%02d.%06ldZ",
> +			    flush_count++,
> +			    getpid(),
> +			    tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
> +			    tm.tm_hour, tm.tm_min, tm.tm_sec,
> +			    (long)tv.tv_usec);

Just bikeshedding, but can we have tokens that mostly sort numeric-wise
by time order? So time at the start, not the flush_count/getpid.

Maybe I'm missing something, but couldn't we just re-use the trace2 SID
+ a more trivial trailer? It would have the nice property that you could
find the trace2 SID whenever you looked at such a token (could
e.g. split them by "/" too), and add the tv_usec, flush_count+whatever
else is needed to make it unique after the "/", no?
