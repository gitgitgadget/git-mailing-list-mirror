Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97C731F453
	for <e@80x24.org>; Wed, 13 Feb 2019 23:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387636AbfBMXVf (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 18:21:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36196 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfBMXVf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 18:21:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id o17so4467448wrw.3
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 15:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3UVS13rrdDAbQMWrnNIVzNuYT7NYIETIJGg3lVIsd9Q=;
        b=OAB3zb3tFp0ho7a9sduZn3HbHAy+FNbZYwpGHtRp0yxMuTfkqRFd2ueDFWne9NvRtz
         X0nckJ35vrccKEQPA1KOE7BgOWXaoEVdRXrVX8tNmNj6UJIqs17/m+bGIpwKP5k+iqmf
         6RPF0GTAoLFCAhLuTskaJFl0+hXgCXgradEGVToCAk78n2r41wNetpKKjhj05WG/UAWL
         kAcv0fLSLAV+AzNXlyV3Tk3/2Cj5pFdWK/NVf4cyjXTwRIShp73H7CcWym17M2lKrB54
         ijJ8n5aaDQEQ8ai9kywMUCsfn+A3zneIy1uxFsCmGqMVyt+jD9VYjtKeKtIbFBuZvKJ6
         GTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=3UVS13rrdDAbQMWrnNIVzNuYT7NYIETIJGg3lVIsd9Q=;
        b=X3y75YqXFjCovg59qGe6sctlZpZeyBEIN3PZM9NuRAOvCCUfFMMYrnedIn4lyQGMty
         uKJBTihYt64j2pbjuSbfcMFUwzdNRgBvLCxLszKXw4Eq2N92WTw2q1N3CXAIhMRvM7AV
         wF2W+5vA0G8gpIBaNkrhuoPtZYWv7IBiNi68o2UFTM1JaC2ZxOgoFgPUAbBBOnd5fvAK
         yP0i+R29a6bDi56YsBq6zVFaKBv9+hYkFvTC278Ys+jpikoaz0gPfK5PkIXDPYIDUHaY
         8jf0fxToYHnmux+43N8/H6WuHTHC5S99wrF8TnabcrIuQS/2dVjFHtBwIvzmoX+cwofW
         TJlA==
X-Gm-Message-State: AHQUAuYRq5mIOcxYVjq7RXUnfUJ/UMiDUFnD6mC+2Z/kvEt1AGBeFC4i
        UFmG13K+PGnEls+6V0tmtB4=
X-Google-Smtp-Source: AHgI3IbRWdYyqrgZuOP1/4iPuL7pdhAF85eGlukqLQLyFrquXEM/JXSf+RYZEDdcJ2Cvy+fcL0XKFg==
X-Received: by 2002:adf:9d14:: with SMTP id k20mr355530wre.97.1550100093114;
        Wed, 13 Feb 2019 15:21:33 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f187sm716835wma.4.2019.02.13.15.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 15:21:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase: fix regression in rebase.useBuiltin=false test mode
References: <xmqqva1nbeno.fsf@gitster-ct.c.googlers.com>
        <20190213214908.9459-1-avarab@gmail.com>
Date:   Wed, 13 Feb 2019 15:21:30 -0800
In-Reply-To: <20190213214908.9459-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 13 Feb 2019 22:49:08 +0100")
Message-ID: <xmqqlg2j9sw5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Let's do this for 2.21 then and I'll re-submit the legacy removal
> patch after we start 2.22.

OK, I would have thought that a prereq to check if the environment
is set and skip these problematic tests would be a lot cleaner
(primarily because the "legacy removal" patch will not touch the
body of the tests at all), but for just the coming few weeks, this
would suffice.

Thanks.

>
>  t/t3404-rebase-interactive.sh | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 52fa41c707..b60b11f9f2 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -149,10 +149,12 @@ test_expect_success 'rebase -i with the exec command checks tree cleanness' '
>  
>  test_expect_success 'rebase -x with empty command fails' '
>  	test_when_finished "git rebase --abort ||:" &&
> -	test_must_fail git rebase -x "" @ 2>actual &&
> +	test_must_fail env GIT_TEST_REBASE_USE_BUILTIN=true \
> +		git rebase -x "" @ 2>actual &&
>  	test_write_lines "error: empty exec command" >expected &&
>  	test_i18ncmp expected actual &&
> -	test_must_fail git rebase -x " " @ 2>actual &&
> +	test_must_fail env GIT_TEST_REBASE_USE_BUILTIN=true \
> +		git rebase -x " " @ 2>actual &&
>  	test_i18ncmp expected actual
>  '
>  
> @@ -160,7 +162,8 @@ LF='
>  '
>  test_expect_success 'rebase -x with newline in command fails' '
>  	test_when_finished "git rebase --abort ||:" &&
> -	test_must_fail git rebase -x "a${LF}b" @ 2>actual &&
> +	test_must_fail env GIT_TEST_REBASE_USE_BUILTIN=true \
> +		git rebase -x "a${LF}b" @ 2>actual &&
>  	test_write_lines "error: exec commands cannot contain newlines" \
>  			 >expected &&
>  	test_i18ncmp expected actual
