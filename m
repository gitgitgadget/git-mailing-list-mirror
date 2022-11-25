Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96C3C433FE
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 06:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiKYGlK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 01:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiKYGlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 01:41:09 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1161B9CE
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 22:41:06 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id z26so3351419pff.1
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 22:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3Y1+SIyc1z5YT0oqS52ZEFwOLFf3xZzvF30W85PnN4=;
        b=plBkTYeRoE5iI+jiv4FONB2MpVCcaDGflURfEYSoPPzHEV1RIBTile0/SVt/Q+UvZd
         hKggY1UxHH/dQS+Bi/2vWqSlbSGMfF9vuO2us64YQsLBWXwS4FD4LfIdx3KwqP1vgovN
         UDsUZQKG6dNKGkrXPvHQMy37txLnSuNUh4FeY5u0O5CHgBfsAXBtREWSmlWuSE+yi0RY
         /IumffsbJ69ljdVhuTwVubhm36V6nyDCaRlz0dOHyAsAMmkYDv7+wt0+yxN25BJpI1Zl
         Bdguo5j6mqpnMTHh5d8CkvozFO4su1SkymaEzFVJsTdGrx5jsgj0YkdFtUN+D6QMX799
         jL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3Y1+SIyc1z5YT0oqS52ZEFwOLFf3xZzvF30W85PnN4=;
        b=wsmMiRgUhbaScAvY5GNPO+T58SA7sQE2QD1pM3/7ToSnTJW1kdJ1XyHf4zoqLWF91e
         Ii9/JgazW6f0hBbYt7Npeh2E9Qp9X7d8tjb9RKDNVHqe9p3WVPVr9ZuezGqTD6KnNKzD
         LYU7GYRQxRJiJYtvMAt8S+K2no1m4AZ/Jg7nm5Mj3EPkfyrY/WPRQEdCUvJohSaAsAb3
         9YrlG++zSrovBsZffzWa/szvAV6F4ggM73SAsqhVKLJq6guo4sgRputXd8LL6ZgrBFRy
         ECi7ppz9tAxZPZZ1BJUU22BwNpShuIe27M+CvtURxztn0Rm+mu0zrvL+yvCgt0SN3q3/
         qZtA==
X-Gm-Message-State: ANoB5pm8r+sncJvJPZ4FtukggZdmIQ1anTPAfuwAyj8pHV+Od47CDP7Y
        ET0YaqRBf9d8Q19UKQEjySPORMyjZ7Ai5Q==
X-Google-Smtp-Source: AA0mqf7/+qsS7GuCWfU1itxlp7Z31EgzZHsJj58CtLyyDn3u1BxUahA6saNBgWPxMdD6PFl/Ia+Vmw==
X-Received: by 2002:a63:4c4d:0:b0:46f:8c3a:8b2b with SMTP id m13-20020a634c4d000000b0046f8c3a8b2bmr15134532pgl.477.1669358465696;
        Thu, 24 Nov 2022 22:41:05 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b001896af10ca7sm131313plk.134.2022.11.24.22.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 22:41:05 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Cc:     git@vger.kernel.org,
        "Randall S . Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH] trace2 tests: guard pthread test with "PTHREAD"
References: <patch-1.1-f7f21c94a6c-20221124T214813Z-avarab@gmail.com>
Date:   Fri, 25 Nov 2022 15:41:04 +0900
Message-ID: <xmqqilj3edtr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Since 81071626ba1 (trace2: add global counter mechanism, 2022-10-24)
> these tests have been failing when git is compiled with NO_PTHREADS=Y,
> which is always the case e.g. if 'uname -s' is "NONSTOP_KERNEL".
>
> Reported-by: Randall S. Becker <randall.becker@nexbridge.ca>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t0211-trace2-perf.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Makes sense, to sweep the immediate breakage under prerequisite.

But why would a global counter need threading?  I know that the
counters can optionally report per-thread stats, but that is
optional and it would still be useful if we can count events in a
single-threaded program, no?

>
> diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
> index 0b3436e8cac..b4e91351181 100755
> --- a/t/t0211-trace2-perf.sh
> +++ b/t/t0211-trace2-perf.sh
> @@ -203,7 +203,7 @@ test_expect_success 'stopwatch timer test/test1' '
>  	have_timer_event "main" "timer" "test" "test1" 5 actual
>  '
>  
> -test_expect_success 'stopwatch timer test/test2' '
> +test_expect_success PTHREAD 'stopwatch timer test/test2' '
>  	test_when_finished "rm trace.perf actual" &&
>  	test_config_global trace2.perfBrief 1 &&
>  	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
> @@ -249,7 +249,7 @@ test_expect_success 'global counter test/test1' '
>  	have_counter_event "main" "counter" "test" "test1" 15 actual
>  '
>  
> -test_expect_success 'global counter test/test2' '
> +test_expect_success PTHREAD 'global counter test/test2' '
>  	test_when_finished "rm trace.perf actual" &&
>  	test_config_global trace2.perfBrief 1 &&
>  	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
