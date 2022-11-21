Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101D5C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 00:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiKUAri (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 19:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiKUAr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 19:47:28 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564601D4
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 16:47:25 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id ci10so2894114pjb.1
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 16:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTShfYgBpbu0I8xjjL1wsl0XnBhiKAhnAGsHpc2YorA=;
        b=DIqwxht5YpunC5uDXA3ySuqWghbZ0nTpXyGayXxp8L7dDmoKKGf01fj9y9hGPcD5YS
         2VsIdoZyNM6qHRxA/lDn+enpvH2xmZ7B1IcWLvNOYKfEQXh7MwT30NPl+wvmpAazy26I
         xpNX0hsOAej6q6RkCmtgtTFv0n/7tGsKlOF5rdjDV5duf4KMt9BypBy7UDxBjWMigdJB
         dW75zLRx0HMoXaD5reP72d1fXOBkez9A3RSBOHek6RiE2qZqGRCqhX52VHybQh1vqEIP
         5tCT17GNYwODFo3GYPIXvsguUUg0UAz5DxqEuT9Z3h0N/n2ZYTCaPCCFGxb42/ySck91
         gDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTShfYgBpbu0I8xjjL1wsl0XnBhiKAhnAGsHpc2YorA=;
        b=Mn/NOjeMRRe9gyd5GnjeV86hV5QM9cUkb595u6MsDUpzXlE6Gb8wDTdpg8xnlAf6ng
         A68A9akBH4+MVVNZ0DtOqt/giYaIQ/wMItNfemRja0IZz2U3PPn8DdjC1XzNvGKMP2R7
         xExGEvoVFIMCg306oyA5imzfACgbV2uVZGl3l3XYp/1pVyDWTSKTZnyZbi3J6r0PJl1f
         CK31wLuMIBE1yN7tzCnboJx6HH+x6MMMbKgqrZVWdYOqBbYUYlF1fyTjiSyq6kDZkh1X
         jhVYMxsdMdH0etU9lCP8wM6RQR0Pe6N+Amsc0wcHiOgTUOxsIdpW41bYiwiYwHzlxXqG
         WWlg==
X-Gm-Message-State: ANoB5plG1DzeZtCgJW5eWo38TuCRlU0WOsZ5sxcvKaxLFFmZexDq3UK1
        hzyA/3ORpTB4HPZCBq9vxMs=
X-Google-Smtp-Source: AA0mqf6NFSXSjYcc4bvl9uCOK6PljNvn4dyiCXbd9teWQTgaxQaDKSNIr+/n78yedHmilnpWa5xGxA==
X-Received: by 2002:a17:902:b114:b0:186:c958:6cd8 with SMTP id q20-20020a170902b11400b00186c9586cd8mr9238417plr.145.1668991644774;
        Sun, 20 Nov 2022 16:47:24 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902f39500b001871acf245csm8149206ple.37.2022.11.20.16.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 16:47:24 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2022, #04; Fri, 18)
References: <Y3g95OYdwzq2OP3z@nand.local>
        <35abf6a0-982c-42d3-78c8-0298b53e6faa@dunelm.org.uk>
        <on4s271q-21s5-onsp-ss70-863nr403760p@tzk.qr>
Date:   Mon, 21 Nov 2022 09:47:23 +0900
In-Reply-To: <on4s271q-21s5-onsp-ss70-863nr403760p@tzk.qr> (Johannes
        Schindelin's message of "Sun, 20 Nov 2022 22:24:02 +0100 (CET)")
Message-ID: <xmqq8rk5yvz8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Not only that. `ab/various-leak-fixes` still merges an older iteration:
>
> -- snip --
> $ git range-diff ttaylorr/ab/various-leak-fixes~15^2...ttaylorr/pw/rebase-no-reflog-action
> 1:  d6f756b0d66f ! 1:  d188a60d7228 sequencer: stop exporting GIT_REFLOG_ACTION
>     @@ Commit message
>          pass the reflog action around in a variable and use it to set
>          GIT_REFLOG_ACTION in the child environment when running "git commit".
>
>     +    Within the sequencer GIT_REFLOG_ACTION is no longer set and is only read
>     +    by sequencer_reflog_action(). It is still set by rebase before calling
>     +    the sequencer, that will be addressed in the next commit. cherry-pick
>     +    and revert are unaffected as they do not set GIT_REFLOG_ACTION before
>     +    calling the sequencer.
>     +
>          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>
>       ## sequencer.c ##
> 2:  be0a662f863c ! 2:  0e34efb31d89 rebase: stop exporting GIT_REFLOG_ACTION
>     @@ Commit message
>          reflog_action.
>
>          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>
>       ## builtin/rebase.c ##
> -- snap --
>
> And that superseded iteration of `pw/rebase-no-reflog-action` _did_ hit
> `next`.

Thanks, all.

So in short, we should

 * revert the merge of ab/various-leak-fixes to 'next'

 * rebuild ab/various-leak-fixes using the updated iteration of the
   other topic

 * merge rebuilt ab/various-leak-fixes to 'next'.

in this order.


