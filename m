Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407ABC433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 09:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJGJYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 05:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiJGJYO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 05:24:14 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D882DCD5D0
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 02:24:13 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b7so6352425wrq.9
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 02:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1hfA8pHWoJNkL0cS6p/pkj5HmN9seY0rqk5uHHwNuow=;
        b=T+qtF/cN4OWGNASaOlniaQeVrqArTstc9hGOKwkw2VuZvcJ4+mnSJMsQ24iCrbsLtB
         B6FElf62I9AVJY2OgXQTxP7TqI3y5+HTRCGRX4f6VwWMwq2DFcXkamsRBCut87AL8r74
         X46/cWXWdTS0TU3ZuGzIqKCkwz4k9SFBF1yHybqFyHmSUN7iPRH/A91fIkDjLHZV3Svt
         BGgeqbLOa3tulcKUMW09nKcc58Ufb+Y315JhRoEF9Yg/nt+ueJ8JKIPE2WNWqGheTGvR
         mzQ2pK1kFXg5RhKlAqiPJPiTuJnGvo5/h1liDgkFzi8KWljXEudliI0AXCjmmKRNQ/3s
         zTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hfA8pHWoJNkL0cS6p/pkj5HmN9seY0rqk5uHHwNuow=;
        b=0kJ+0lV1p0jpiTTrds13FywsoqkE8ayzUhzUWE/i0oVmnN3557LgloeFVnzeIT6qxe
         so1Y2I+Yax7Q1NPrqAtNYaHjcXMg4fGTCzhO+r6ScJ9CLXVOToQX2P6PhN9VvrZtfh0s
         BHJO0YI2ECG87gCX/D6a2WvpuXRq3v1lXcz8hoFasQRkjI7OWVmlIOvmLU3pCccom3Zn
         Zz+xSSurFPbDsZKXbFI1TSPMvio+UL83P8r6IOOpraS2GxRqSwAHN7XTDZEehykBgEnl
         dqfWlBHGqqcFC551hsTiQRFt+9RHKWdclRKIVjWzFAbAGgF/CU5RpiQKE7KoR1K81wUl
         F9ow==
X-Gm-Message-State: ACrzQf1zj35YR5DyejXB4+j/cp/Uiybad+fE0B/7e9DP9NDr2EvL0cdN
        gdb5i0bFf3f7TPYbwcFy3pqFsn68H6I=
X-Google-Smtp-Source: AMsMyM7kU8YXB3SXg+RC1RC8rf4EZddtQC/r7pZ42EngahH2u1SfJxW7Aj8lhFmwuXB6GK5vtUs7/Q==
X-Received: by 2002:a5d:650f:0:b0:22e:6597:fdd0 with SMTP id x15-20020a5d650f000000b0022e6597fdd0mr2434142wru.127.1665134652340;
        Fri, 07 Oct 2022 02:24:12 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id o5-20020adfe805000000b00228cd9f6349sm1492743wrm.106.2022.10.07.02.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 02:24:11 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <9f3216e5-1397-2d91-19dc-47e8165783a6@dunelm.org.uk>
Date:   Fri, 7 Oct 2022 10:24:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 05/15] run-command tests: use "return", not "exit"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
 <patch-05.15-4ebbf6207fe-20220930T111343Z-avarab@gmail.com>
In-Reply-To: <patch-05.15-4ebbf6207fe-20220930T111343Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 30/09/2022 12:28, Ævar Arnfjörð Bjarmason wrote:
> Change the "run-command" test helper to "return" instead of calling
> "exit", see 338abb0f045 (builtins + test helpers: use return instead of exit() in cmd_*, 2021-06-08)
> 
> Because we'd previously gotten past the SANITIZE=leak check by using
> exit() here we need to move to "goto cleanup" pattern. See
> fdc8f79f1f1 (leak tests: run various "test-tool" tests in t00*.sh
> SANITIZE=leak, 2021-10-12) for prior art. for when this code was opted
> into the "linux-leaks" job.

That commit just adds some TEST_PASSES_SANITIZE_LEAK=true lines, it's 
not nothing to do with "goto cleanup", I don't think we need to 
reference any prior art, just explain why we need to add the cleanup 
which you already do.

>   	if (!strcmp(argv[1], "run-command-parallel")) {
> -		exit(run_processes_parallel(jobs, parallel_next,
> -					    NULL, NULL, &proc));
> +		run_processes_parallel(jobs, parallel_next, NULL, NULL,
> +				       &proc);

There is no explanation of why it is safe to discard the return value 
here. The answer is in the next commit message, but needs to be 
mentioned here as well.

Best Wishes

Phillip
