Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB78C001DB
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 11:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjHNL2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 07:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjHNL1m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 07:27:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2DCE5F
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 04:27:41 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-317f1c480eeso3722285f8f.2
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 04:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692012460; x=1692617260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0y04NJSPMkAKuTg6pDsIn843OJXA7BNeF/UO4YWoRBo=;
        b=p7UW3iKSbjietSjNy2/4Zzt9pCojefqiWAgITDGTLyT+KKMMnExbG2LN0hKQ6JxDac
         eSTjqzqXI0ac1YwdWp00XrBXKv9opwQ+tt2LEpGTg7Xf5AzAjehtzB4w+jBJmDL6GnL8
         tsTF/CCTY9UQjhhfR79NZWrISt+KANN1KKPQYUEWDsmMchQ+qYHlsEsgleZIsgtDI5vB
         6PB7OhiiS83MfVMv80TkGb65wWTg5Lpv4CPyGlwsOUHtiBseD/Fdoo0aY6nF3keB+6F+
         yhun7mIFG7bkstkn5MDotoJ+h+LLyGNht54LDsdhiWhUDxje/1//xd45Ki8vkiFcj78T
         23Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692012460; x=1692617260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0y04NJSPMkAKuTg6pDsIn843OJXA7BNeF/UO4YWoRBo=;
        b=JlNeNz4cPDMtzLE1hUxZ5B8HT3h3Ub4yoq6w/HyJIK8BfpLgvPZfke7Nx3WJMXOOY4
         l4zuLIlQRoKuvKK0CdxIhz53J4Aukq+DdGTbIChKyo46AKWCmFH7bE4s5PEmwBmMUwQx
         eE5R98erpEcYABKCMvGZ89O3OGfN7oYhhveixAVr6mjPzxjme+Kaw0lZ/mGnHZQ2PrsE
         lQQYlhizSDAJM6EHBIFWZRqjpsUudkeCGfiLG51UGfAtXSxGc0ZRWr4oJd7ZpLoAyFqE
         dA2/1UrT9hD2eH58O/uD+Q7Jpa4H/pJluhdwhXL2VDzNAUA3SSuHMsBYZt+ZOxEVEmiE
         q+uQ==
X-Gm-Message-State: AOJu0Yzs8jXsFf6reHbHuP78LMcz7HR9pSMHM/d/2bYH2L2wPXQYt2Lf
        KkRbGUBzgyULP2pfcs7lenk=
X-Google-Smtp-Source: AGHT+IF+5QYkarI475EZlJh+inG9DL2zH/f2pBDM6p932gLDFElFeY557l4azmmsvATMwhI/2hXjiQ==
X-Received: by 2002:a05:6000:511:b0:317:648c:3895 with SMTP id a17-20020a056000051100b00317648c3895mr6350504wrf.33.1692012459584;
        Mon, 14 Aug 2023 04:27:39 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003fbbe41fd78sm14089285wmc.10.2023.08.14.04.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 04:27:39 -0700 (PDT)
Message-ID: <055a1132-fe35-4f83-ae7c-16d84ca42f2c@gmail.com>
Date:   Mon, 14 Aug 2023 12:27:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 7/8] maintenance: fix systemd schedule overlaps
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>
 <86c4255d63d7f38b7a4811e5667404bce04f77f8.1691699987.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <86c4255d63d7f38b7a4811e5667404bce04f77f8.1691699987.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 10/08/2023 21:39, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The 'git maintenance run' command prevents concurrent runs in the same
> repository using a 'maintenance.lock' file. However, when using systemd
> the hourly maintenance runs the same time as the daily and weekly runs.
> (Similarly, daily maintenance runs at the same time as weekly
> maintenance.) These competing commands result in some maintenance not
> actually being run.
> 
> This overlap was something we could not fix until we made the recent
> change to not use the builting 'hourly', 'daily', and 'weekly' schedules
> in systemd. We can adjust the schedules such that:
> 
>   1. Hourly runs avoid the 0th hour.
>   2. Daily runs avoid Monday.
> 
> This will keep maintenance runs from colliding when using systemd.

Thanks for fixing this, the patch looks good

Best Wishes

Phillip

> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>   builtin/gc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index e52129e485c..6f8df366fbe 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -2350,11 +2350,11 @@ static int systemd_timer_write_timer_file(enum schedule_priority schedule,
>   
>   	switch (schedule) {
>   	case SCHEDULE_HOURLY:
> -		schedule_pattern = xstrfmt("*-*-* *:%02d:00", minute);
> +		schedule_pattern = xstrfmt("*-*-* 1..23:%02d:00", minute);
>   		break;
>   
>   	case SCHEDULE_DAILY:
> -		schedule_pattern = xstrfmt("*-*-* 0:%02d:00", minute);
> +		schedule_pattern = xstrfmt("Tue..Sun *-*-* 0:%02d:00", minute);
>   		break;
>   
>   	case SCHEDULE_WEEKLY:
