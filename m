Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B2B4C8C
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 11:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548594; cv=none; b=QXw6dabo5D4tCI4klp8k7MqfrGU75M9zBywNgby1dQ0IAQXy3AqfzoJBsMDqziTNefWFEMhONNZvA8H71jWmrLbiRdLi5EaQfnFB05y4Gyj0Yg9/+0nFZzq2tdOSDrHdZvHtLE4dp7EDZn3efQVa0uqrwlt6vJH2r2vN+A28FgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548594; c=relaxed/simple;
	bh=+9AszpvAV1Ueon/6/FDAsv/M9wdLQFknMHZMd2PReSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CN9XTTiQB+fRH9eB4wC75qPOMPEOpYo/rOgqzlOC5UsjdLTBW5gGHxQeyrWjdlw0z+SQc/elBDaCdZTdgnF5cn3qv0yn1Px8IAKwhfOL6ppr7JYEEzZi8S9EhXTUsgGOTlI2fngb//ZKBywybothiuxnjoUZFeXwvfXxuo+DeYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtH+P9np; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtH+P9np"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42803bbf842so53157345e9.1
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 04:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723548591; x=1724153391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E6CdLFpAupTxb/5WvvUzGzWzUIwbEqDmNqfoQWI+4EI=;
        b=BtH+P9npDTQsO50d/Sf6z+TwWjCreZmplmpOZx/0CfL/sOHgHs8T40NRW9wIGzYhnW
         2tu7GLqbWclFp88TLk+NxfNSLOqT3+x+HgMy1VmLqDgrb4nfD9RiT/1xlSjB5eA2+U6Z
         5C/IE82S/lrzkDqMUaCHvYmEQIYZz44GfsDq08ZEBo0LCSYEU3F1WnuOiLnMUP2wlOuU
         lnich0SvkFAVvFRhqP+HtlJQ5iyOLudWY4i5IikX4No1278RhMvXrN/zCTjO8WdaoBV9
         mMd/zKu2hKrWFn9W6U32f9OGO4sPRxziEz5ehWbQlvMmlKm+Vf7FkUMzPN4oY0DwQFPk
         hA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723548591; x=1724153391;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6CdLFpAupTxb/5WvvUzGzWzUIwbEqDmNqfoQWI+4EI=;
        b=h25UuG12bWsMJIvszNelsl0Rkn4twjDPAVBYgs5aL8G6XL36C6++LF9nFBEdM6zhif
         stcepgAytm62lBhqMxrFJsFbCqj3nM2KWGe0mM/wCWd0DCv/Wz/AkM4BHX2vDX+wuQ0e
         S+3YMjK8xTS251RnTDkcLkLj+BoiBe0pOCBTIkOg+jQBjCk434lI4kcqBaCN7E0pICXH
         AKCvYatLj0ZRbO277nFnxtmoEHYghnA/R3ZEUlM9hEPQUtK6KSEH+fyGxJBVIGJpP6F9
         +LK2y60ajWqNvGquzhzUKFzKCuPKLOTjxjINu4b6jvWrMfj7W0tEmxgTPcVCo+mw4qp5
         pqSw==
X-Forwarded-Encrypted: i=1; AJvYcCVgqGez8li+1yzQWFTQSyatnaCAESqI97MTv5ud2fAlOxOAEsL/qcWeV+OpAOKJ9SkmkK8wk9B8AZ1tnoizePrGRjhw
X-Gm-Message-State: AOJu0YxJrXlZc4R38jZeb2YEjNW4wHKPAZdysgegolw0wbfs6kwzjoLb
	B+Bi3CVn8eSt7DUt4IcBACryMvITQShhA1Wq/uJiE4EbLtDh7gHW5mpkSw==
X-Google-Smtp-Source: AGHT+IEWYyaywqcG/aQce373Hk9lNUxZznz3fOCijCcWjeO6NsVXcex+w2jxEoNS2TWAM9bKq6CQTg==
X-Received: by 2002:a05:600c:1c1f:b0:425:64c5:5780 with SMTP id 5b1f17b1804b1-429d47f38efmr30134075e9.1.1723548590422;
        Tue, 13 Aug 2024 04:29:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69b:eb01:545f:b423:671d:5e99? ([2a0a:ef40:69b:eb01:545f:b423:671d:5e99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c74a68bsm223048695e9.22.2024.08.13.04.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 04:29:50 -0700 (PDT)
Message-ID: <779795d2-eefd-4fac-b29f-9943f98bc83b@gmail.com>
Date: Tue, 13 Aug 2024 12:29:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 7/7] builtin/maintenance: fix auto-detach with
 non-standard tasks
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1723533091.git.ps@pks.im>
 <8d6cbae951177718b49d5cfbbeca2d5b0073e266.1723533091.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <8d6cbae951177718b49d5cfbbeca2d5b0073e266.1723533091.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 13/08/2024 08:18, Patrick Steinhardt wrote:
>
> Fix this bug by asking git-gc(1) to not detach when it is being invoked
> via git-maintenance(1). Instead, the latter command now respects a new
> config "maintenance.autoDetach", the equivalent of "gc.autoDetach", and
> detaches itself into the background if not told otherwise. This should
> continue to behave the same for all users which use the git-gc(1) task,
> only. For others though, it means that we now properly perform all tasks
> in the background.

I fear that users who are running "git maintenance" from a scheduler 
such as cron are likely to be surprised by this change in behavior. At 
the very least "git maintenance" will no-longer return a meaningful exit 
code. Perhaps we could switch the logic to be opt in and pass "--detach" 
(or "-c maintenance.autoDetach=true") when running "git maintenance" 
automatically from "git rebase" etc.

Best Wishes

Phillip

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   builtin/gc.c             |  1 +
>   run-command.c            | 12 ++++++++++-
>   t/t5616-partial-clone.sh |  6 +++---
>   t/t7900-maintenance.sh   | 43 +++++++++++++++++++++++++++++++---------
>   4 files changed, 49 insertions(+), 13 deletions(-)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 63106e2028..bafee330a2 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1063,6 +1063,7 @@ static int maintenance_task_gc(struct maintenance_run_opts *opts,
>   		strvec_push(&child.args, "--quiet");
>   	else
>   		strvec_push(&child.args, "--no-quiet");
> +	strvec_push(&child.args, "--no-detach");
>   
>   	return run_command(&child);
>   }
> diff --git a/run-command.c b/run-command.c
> index 45ba544932..94f2f3079f 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1808,16 +1808,26 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
>   
>   int prepare_auto_maintenance(int quiet, struct child_process *maint)
>   {
> -	int enabled;
> +	int enabled, auto_detach;
>   
>   	if (!git_config_get_bool("maintenance.auto", &enabled) &&
>   	    !enabled)
>   		return 0;
>   
> +	/*
> +	 * When `maintenance.autoDetach` isn't set, then we fall back to
> +	 * honoring `gc.autoDetach`. This is somewhat weird, but required to
> +	 * retain behaviour from when we used to run git-gc(1) here.
> +	 */
> +	if (git_config_get_bool("maintenance.autodetach", &auto_detach) &&
> +	    git_config_get_bool("gc.autodetach", &auto_detach))
> +		auto_detach = 1;
> +
>   	maint->git_cmd = 1;
>   	maint->close_object_store = 1;
>   	strvec_pushl(&maint->args, "maintenance", "run", "--auto", NULL);
>   	strvec_push(&maint->args, quiet ? "--quiet" : "--no-quiet");
> +	strvec_push(&maint->args, auto_detach ? "--detach" : "--no-detach");
>   
>   	return 1;
>   }
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index 2da7291e37..8415884754 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -229,7 +229,7 @@ test_expect_success 'fetch --refetch triggers repacking' '
>   
>   	GIT_TRACE2_EVENT="$PWD/trace1.event" \
>   	git -C pc1 fetch --refetch origin &&
> -	test_subcommand git maintenance run --auto --no-quiet <trace1.event &&
> +	test_subcommand git maintenance run --auto --no-quiet --detach <trace1.event &&
>   	grep \"param\":\"gc.autopacklimit\",\"value\":\"1\" trace1.event &&
>   	grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"-1\" trace1.event &&
>   
> @@ -238,7 +238,7 @@ test_expect_success 'fetch --refetch triggers repacking' '
>   		-c gc.autoPackLimit=0 \
>   		-c maintenance.incremental-repack.auto=1234 \
>   		-C pc1 fetch --refetch origin &&
> -	test_subcommand git maintenance run --auto --no-quiet <trace2.event &&
> +	test_subcommand git maintenance run --auto --no-quiet --detach <trace2.event &&
>   	grep \"param\":\"gc.autopacklimit\",\"value\":\"0\" trace2.event &&
>   	grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"-1\" trace2.event &&
>   
> @@ -247,7 +247,7 @@ test_expect_success 'fetch --refetch triggers repacking' '
>   		-c gc.autoPackLimit=1234 \
>   		-c maintenance.incremental-repack.auto=0 \
>   		-C pc1 fetch --refetch origin &&
> -	test_subcommand git maintenance run --auto --no-quiet <trace3.event &&
> +	test_subcommand git maintenance run --auto --no-quiet --detach <trace3.event &&
>   	grep \"param\":\"gc.autopacklimit\",\"value\":\"1\" trace3.event &&
>   	grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"0\" trace3.event
>   '
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 771525aa4b..06ab43cfb5 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -49,22 +49,47 @@ test_expect_success 'run [--auto|--quiet]' '
>   		git maintenance run --auto 2>/dev/null &&
>   	GIT_TRACE2_EVENT="$(pwd)/run-no-quiet.txt" \
>   		git maintenance run --no-quiet 2>/dev/null &&
> -	test_subcommand git gc --quiet <run-no-auto.txt &&
> -	test_subcommand ! git gc --auto --quiet <run-auto.txt &&
> -	test_subcommand git gc --no-quiet <run-no-quiet.txt
> +	test_subcommand git gc --quiet --no-detach <run-no-auto.txt &&
> +	test_subcommand ! git gc --auto --quiet --no-detach <run-auto.txt &&
> +	test_subcommand git gc --no-quiet --no-detach <run-no-quiet.txt
>   '
>   
>   test_expect_success 'maintenance.auto config option' '
>   	GIT_TRACE2_EVENT="$(pwd)/default" git commit --quiet --allow-empty -m 1 &&
> -	test_subcommand git maintenance run --auto --quiet <default &&
> +	test_subcommand git maintenance run --auto --quiet --detach <default &&
>   	GIT_TRACE2_EVENT="$(pwd)/true" \
>   		git -c maintenance.auto=true \
>   		commit --quiet --allow-empty -m 2 &&
> -	test_subcommand git maintenance run --auto --quiet  <true &&
> +	test_subcommand git maintenance run --auto --quiet --detach <true &&
>   	GIT_TRACE2_EVENT="$(pwd)/false" \
>   		git -c maintenance.auto=false \
>   		commit --quiet --allow-empty -m 3 &&
> -	test_subcommand ! git maintenance run --auto --quiet  <false
> +	test_subcommand ! git maintenance run --auto --quiet --detach <false
> +'
> +
> +for cfg in maintenance.autoDetach gc.autoDetach
> +do
> +	test_expect_success "$cfg=true config option" '
> +		test_when_finished "rm -f trace" &&
> +		test_config $cfg true &&
> +		GIT_TRACE2_EVENT="$(pwd)/trace" git commit --quiet --allow-empty -m 1 &&
> +		test_subcommand git maintenance run --auto --quiet --detach <trace
> +	'
> +
> +	test_expect_success "$cfg=false config option" '
> +		test_when_finished "rm -f trace" &&
> +		test_config $cfg false &&
> +		GIT_TRACE2_EVENT="$(pwd)/trace" git commit --quiet --allow-empty -m 1 &&
> +		test_subcommand git maintenance run --auto --quiet --no-detach <trace
> +	'
> +done
> +
> +test_expect_success "maintenance.autoDetach overrides gc.autoDetach" '
> +	test_when_finished "rm -f trace" &&
> +	test_config maintenance.autoDetach false &&
> +	test_config gc.autoDetach true &&
> +	GIT_TRACE2_EVENT="$(pwd)/trace" git commit --quiet --allow-empty -m 1 &&
> +	test_subcommand git maintenance run --auto --quiet --no-detach <trace
>   '
>   
>   test_expect_success 'register uses XDG_CONFIG_HOME config if it exists' '
> @@ -129,9 +154,9 @@ test_expect_success 'run --task=<task>' '
>   		git maintenance run --task=commit-graph 2>/dev/null &&
>   	GIT_TRACE2_EVENT="$(pwd)/run-both.txt" \
>   		git maintenance run --task=commit-graph --task=gc 2>/dev/null &&
> -	test_subcommand ! git gc --quiet <run-commit-graph.txt &&
> -	test_subcommand git gc --quiet <run-gc.txt &&
> -	test_subcommand git gc --quiet <run-both.txt &&
> +	test_subcommand ! git gc --quiet --no-detach <run-commit-graph.txt &&
> +	test_subcommand git gc --quiet --no-detach <run-gc.txt &&
> +	test_subcommand git gc --quiet --no-detach <run-both.txt &&
>   	test_subcommand git commit-graph write --split --reachable --no-progress <run-commit-graph.txt &&
>   	test_subcommand ! git commit-graph write --split --reachable --no-progress <run-gc.txt &&
>   	test_subcommand git commit-graph write --split --reachable --no-progress <run-both.txt
