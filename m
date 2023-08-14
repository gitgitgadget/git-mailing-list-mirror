Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF67C41513
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 11:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjHNL3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 07:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbjHNL2x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 07:28:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CA2FA
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 04:28:52 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe12820bffso38012875e9.3
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 04:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692012531; x=1692617331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iTtYKVbemsXsUktz7T7ZZnw3DPFv3EpN3LL/IVickMY=;
        b=jVKT3VpLuTmmZ7F0xmbtvNq2b+pRY6+q9hAEXdzj1tDaywv+vO+tAw706YbFELbvaZ
         5GoCU6b+TEGf6x0jkFDmbx4yFYHs05qJ1SQTMqnAqn27GIufxGeu/upxj/ingYyiLzWt
         Td2lTrMiXdG2RzTNaMvM/1jBJNZ3DGamO+y/cATAX4Kg7Z68v9i81rOtH8Sj2NKdp7Lz
         u8lblBI12Io8uAEjIFUL8EGDLznZ3t+i4kXyLwq6vqLc1TzGBncSPCwFfJr54TnGZMe7
         xdkwVFYQUGlask18g4cyGKmBd8ZNxIlvXyDNj3LmTCw0W5vidirBOgBAWn/6eqtPoHDv
         zBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692012531; x=1692617331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTtYKVbemsXsUktz7T7ZZnw3DPFv3EpN3LL/IVickMY=;
        b=QQ2cw3XUIqymIFtYyXV996EuPu7NDWIFMYQ5dFBGqvSN+mVouIwaquIKbmSdQqrUQW
         WdZZt7SQJXu0id2RyB4MC7ou6ppoH1AuParX/JzSAJMENugv0KYVUWqKbUS6D08ajH6r
         D32VgzU7dCkA3sshOUT2r44+Ikf6hl3GM2JfxNfRAxNpr3T5JxUR6lvtUo9nZaxt/4iA
         7QXZrZR0i7lcfpTv6gW0WASbXJ0N65luBF63zneuckIUyS30bH5IZ5EQo+BCc/ZyX2ot
         aO0wdfjZP51qaCjpoM0GYwJhZhu90+XUa+0sQZnY0pAqlcuToLOOx2RVDdylhIJPboLT
         NPEw==
X-Gm-Message-State: AOJu0YzHvoE9QF1CZqnZzq7sGMv5eR1vYMwa9gVHQ0tEuHq8/AH5GKX/
        tM9HoVafw0509e8PyiLsp8U=
X-Google-Smtp-Source: AGHT+IEZ0ja2q6CrYss4rj98ZcW6b10BWi937QzyQ28i7ErhwZ9L8gx6skFVXrqSYIYuH2fcI6lSwg==
X-Received: by 2002:a05:600c:2101:b0:3fb:d1c1:9b79 with SMTP id u1-20020a05600c210100b003fbd1c19b79mr6901250wml.30.1692012529551;
        Mon, 14 Aug 2023 04:28:49 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003fbbe41fd78sm14089285wmc.10.2023.08.14.04.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 04:28:49 -0700 (PDT)
Message-ID: <fee3baa3-f962-45be-9b41-4bb17a5d1475@gmail.com>
Date:   Mon, 14 Aug 2023 12:28:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 8/8] maintenance: update schedule before config
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>
 <f0c0f6eff883c62f6b07223b5f1da3fd8e462507.1691699987.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <f0c0f6eff883c62f6b07223b5f1da3fd8e462507.1691699987.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 10/08/2023 21:39, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> When running 'git maintenance start', the current pattern is to
> configure global config settings to enable maintenance on the current
> repository and set 'maintenance.auto' to false and _then_ to set up the
> schedule with the system scheduler.
> 
> This has a problematic error condition: if the scheduler fails to
> initialize, the repository still will not use automatic maintenance due
> to the 'maintenance.auto' setting.
> 
> Fix this gap by swapping the order of operations. If Git fails to
> initialize maintenance, then the config changes should never happen.

The commit message and patch look good to me

Thanks

Phillip

> Reported-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>   builtin/gc.c           |  5 ++++-
>   t/t7900-maintenance.sh | 13 +++++++++++++
>   2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 6f8df366fbe..fe5f871c493 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -2728,9 +2728,12 @@ static int maintenance_start(int argc, const char **argv, const char *prefix)
>   	opts.scheduler = resolve_scheduler(opts.scheduler);
>   	validate_scheduler(opts.scheduler);
>   
> +	if (update_background_schedule(&opts, 1))
> +		die(_("failed to set up maintenance schedule"));
> +
>   	if (maintenance_register(ARRAY_SIZE(register_args)-1, register_args, NULL))
>   		warning(_("failed to add repo to global config"));
> -	return update_background_schedule(&opts, 1);
> +	return 0;
>   }
>   
>   static const char *const builtin_maintenance_stop_usage[] = {
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 9ffe76729e6..e56f5980dc4 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -849,4 +849,17 @@ test_expect_success 'register and unregister bare repo' '
>   	)
>   '
>   
> +test_expect_success 'failed schedule prevents config change' '
> +	git init --bare failcase &&
> +
> +	for scheduler in crontab launchctl schtasks systemctl
> +	do
> +		GIT_TEST_MAINT_SCHEDULER="$scheduler:false" &&
> +		export GIT_TEST_MAINT_SCHEDULER &&
> +		test_must_fail \
> +			git -C failcase maintenance start &&
> +		test_must_fail git -C failcase config maintenance.auto || return 1
> +	done
> +'
> +
>   test_done
