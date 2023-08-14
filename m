Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F23C04A94
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 11:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbjHNL1M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 07:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbjHNL06 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 07:26:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A281E62
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 04:26:51 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso39199945e9.0
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 04:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692012409; x=1692617209;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E957kV/SGqy73fzbo9Sj855OGlsFuofloZyIF7r4Be8=;
        b=El426o8GeQduX27edTUO8vqRzW3m4ZiEqTOii7+5WWgAd4iUMsdk9TFmIHSoGRjVzE
         5/M3NwIuA0SQo+6NGxflA9TMJLo1q9tZ6j9RhWd788FZZ9G1BfLTE6glm1trUdPPX/a/
         PFxaeSuXaoDHKFryqDcMiENLMptKRGUyxPXAw8MiHSSBrtil5IeJg/VLcJJji1RsgHrn
         vYqscaiyNGeuhz7W7OK1ATdFpLJewX6uYc37XzJaVlXFPTkLBKxXsJjGt03ZYJE/YV3G
         FVDvR/k21OXyHiLqreqXiLqCeL/fRT70zTsMW5g6C/ED1+WqTPEuju/5hIt0D7gtWX+Q
         5nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692012409; x=1692617209;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E957kV/SGqy73fzbo9Sj855OGlsFuofloZyIF7r4Be8=;
        b=Ni+VHPaHaRMoij9OJ3AuvXjkgva2XHiq8UPNwpn5YJvCN9guH58UA8kxfsvozyBL3f
         mTMqHpL/VyBJ7ep+w+wGkfGrFPlH3HU0v1P7P7tEhXwr6vINxsp9/4u73Prkcz+S+enM
         lkxH1OTcsb3eaHV9u9/FtQ8u0/WEel47dFfZBXRUhQg5EKml8h+gUCfYwA3mQKFNxLSD
         u4yqjzJmrr3wWe/cbBzZClteS6Dsb6+m30nLXHM+JsBqtCEo28PIJDZ72C1kB+5EHtoX
         7KCc/e1oZMFKlxXS8FmgI+DfaXx2NIJ+46nPpQQ8xj2uIvGvnwPH0W+g5zqPzW7mYpyW
         SR0w==
X-Gm-Message-State: AOJu0YyYczt20SH7g8Ex36NCt+szrewl3NPZm6jQ+W5UtHWYjATDMYuU
        DmMxUeUPiXil7KGUxnKnnnXadwMgzJ4=
X-Google-Smtp-Source: AGHT+IGFWa3u0NMAVKQ2Sf7lfHc+eK1HYFATcfApkvdmccwFrgAxhmjoRiVcOEsQOylF7wP0HByYyg==
X-Received: by 2002:a05:600c:3787:b0:3fe:89be:cd3 with SMTP id o7-20020a05600c378700b003fe89be0cd3mr6446366wmr.22.1692012409180;
        Mon, 14 Aug 2023 04:26:49 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003fbbe41fd78sm14089285wmc.10.2023.08.14.04.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 04:26:48 -0700 (PDT)
Message-ID: <5d431d2c-2d2c-4fb5-82ca-b9684523e512@gmail.com>
Date:   Mon, 14 Aug 2023 12:26:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 6/8] maintenance: use random minute in systemd
 scheduler
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>
 <e43778d3e408f5a77b01bce13df6f8b037473cc3.1691699987.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <e43778d3e408f5a77b01bce13df6f8b037473cc3.1691699987.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

This all looks good to me now, I've left a comment on the test but I 
think it is probably fine to go in as it is.

> -static int systemd_timer_write_unit_templates(const char *exec_path)
> +/*
> + * Write the schedule information into a git-maintenance@<schedule>.timer
> + * file using a custom minute. This timer file cannot use the templating
> + * system, so we generate a specific file for each.
> + */

Thanks for adding comments to the functions that write the timer and 
service files, they really helpful especially for readers who are not 
that familiar with systemd.

> +static int systemd_timer_delete_unit_files(void)
> +{
> +	systemd_timer_delete_stale_timer_templates();
> +
> +	/* Purposefully not short-circuited to make sure all are called. */
> +	return systemd_timer_delete_timer_file(SCHEDULE_HOURLY) |
> +	       systemd_timer_delete_timer_file(SCHEDULE_DAILY) |
> +	       systemd_timer_delete_timer_file(SCHEDULE_WEEKLY) |
> +	       systemd_timer_delete_service_template();

Using "|" rather than "||" is a nice touch.

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 487e326b3fa..9ffe76729e6 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -744,7 +744,15 @@ test_expect_success 'start and stop Linux/systemd maintenance' '
>   	# start registers the repo
>   	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
>   
> -	test_systemd_analyze_verify "systemd/user/git-maintenance@.service" &&
> +	for schedule in hourly daily weekly
> +	do
> +		test_path_is_file "systemd/user/git-maintenance@$schedule.timer" || return 1
> +	done &&
> +	test_path_is_file "systemd/user/git-maintenance@.service" &&
> +
> +	test_systemd_analyze_verify "systemd/user/git-maintenance@hourly.service" &&
> +	test_systemd_analyze_verify "systemd/user/git-maintenance@daily.service" &&
> +	test_systemd_analyze_verify "systemd/user/git-maintenance@weekly.service" &&

As we only write the template service file I'm not sure what we gain by 
these three checks but they don't seem to be doing any harm.

Best Wishes

Phillip
