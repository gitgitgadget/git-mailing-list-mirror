Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEF819F470
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730417; cv=none; b=UadLV6I2Wi9gvZS9hrzVglUELes6oPeVy9X4y37drhXBdeaLFS6W8xFUI05YZkMwVNMG6a7Rp5d0z0HOekB6lS7lmwofnLIQIMlJE694Aus+TDcoDVUKk1RufG0KRvNB39lW9+luZ2R2DmIdj2Gs4RftIdZKp6ClGmXV4eA4fA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730417; c=relaxed/simple;
	bh=MPtRXt7XkmLKppTksF7sXek19I3kQv4B5igia70V+Es=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kFQAKojjmOQjkdr5/2xHqvS68HWkjXjPZsFJRHji7pG4LrNhrAk4wXoLPff/EujDDPBynv/S6UZnHb1S+F+cdgu1vWOZKW3EoI0WxQCDm8r6f3TdmX7eu030klyx0x7ZU89lA4uBiOFO9MGfW2ptdgQSoalfZUj5xzWDZQ3dct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFbSxZle; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFbSxZle"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d3d662631aso224692a91.1
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723730415; x=1724335215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4TVMya5CwNcMCSYHIPGlmaohXly8AxzfIDx6ZIGCZbY=;
        b=ZFbSxZlegTisNDA5d8VfIyREdR1YaE46TeY8tL6Fp9tMgHFfvQMVMhEM4neGmPmTZY
         mUsWyZb0Iy6hYrCpAc8OW9j2V1ctiRbqcOx2Mh/6S4n1sKngRWIjb7xF7GQOGQxeEWh+
         8tDSRX8wL5ICOYnq9aFI+yuerYXyRexdedqajgNU/jdA2wd9PqfhYLdLXNluH93SgUmf
         ylUklv5kJJC5kFcb3fkNps5SaGpid6LBLzv/EQzPo1fTPpJ2YyXNuXtQSk+fKYtc678W
         kera5+3j87sbRmOyCaythMwiyhFjxjuBOSL4DerZB25fANN0pjy8bdl7dKPM7K6/ck4t
         Bp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723730415; x=1724335215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4TVMya5CwNcMCSYHIPGlmaohXly8AxzfIDx6ZIGCZbY=;
        b=NLP7uVv8apk8TClPwSXLWTp88rKUJgv217BLPjP13LMHV3/SAK719ivc/cqsuoOqaH
         q2sOvYd091KEVnzLCXQf6aKktOPULJlrsofRfudpOst/pOUERyYGANe0tZsMAwK+EOVn
         aPCs7IbM/MmUItVROTy3DL+nWQrjjzpu5g0ngPYE4vwjiNavAQjbWVJBPImk0z/rhgEg
         bM/l1Xhr7Spl5SYvOr2hXfCcPVrSaLBZDu9WnfB9YokEbPOlCxBI6hS22VtSirLdeqvR
         QJkK9vzs2ZLzPHCLneOvV3zuFhyTI6cjGqNScRtGnzLaZm1MwjO6QfcrwcL/p9Ad6diZ
         0BkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIz2LxbZBLG7skVXi8ZBH8+SM2kYRtyKzluiAasG8D3t+iuQi+WWMb3bFYNFvFFcHnqqWLZyiYxuMWzn28deBlKUYt
X-Gm-Message-State: AOJu0Yypd0r8WkxvL3fhLHdocPa63x0YTmAG3r1DvW4pXD+LT++LK+6S
	0IZYYeHemM36Nn4NpN5daU05dNutgTJLZB1zIa+fLrX+oI6BRR7jvn/o0XYx
X-Google-Smtp-Source: AGHT+IFY46fYEPnpS8vQSlujqMsd6Z562CvKh499e8qqt+s8RcxEzHCzsoyTkkQ3Kb2q3/bws91x8g==
X-Received: by 2002:a17:90b:4c81:b0:2c9:6f06:8005 with SMTP id 98e67ed59e1d1-2d3aab48b1cmr7311764a91.26.1723730415059;
        Thu, 15 Aug 2024 07:00:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:69ca:a1c4:ca16:9d53? ([2600:1700:60ba:9810:69ca:a1c4:ca16:9d53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3d6877124sm584012a91.16.2024.08.15.07.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 07:00:14 -0700 (PDT)
Message-ID: <eddcc0a0-a366-4627-8878-f1b5d0af2436@gmail.com>
Date: Thu, 15 Aug 2024 10:00:13 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] builtin/maintenance: fix auto-detach with
 non-standard tasks
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1723533091.git.ps@pks.im>
 <8d6cbae951177718b49d5cfbbeca2d5b0073e266.1723533091.git.ps@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <8d6cbae951177718b49d5cfbbeca2d5b0073e266.1723533091.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 3:18 AM, Patrick Steinhardt wrote:

> @@ -1063,6 +1063,7 @@ static int maintenance_task_gc(struct maintenance_run_opts *opts,
>   		strvec_push(&child.args, "--quiet");
>   	else
>   		strvec_push(&child.args, "--no-quiet");
> +	strvec_push(&child.args, "--no-detach");
>   
>   	return run_command(&child);
>   }

I was looking for this earlier, as it could have been placed in either of
the previous two patches. I can understand not putting it in Patch 5
because then the default of 'git maintenance run --auto' would not
daemonize the gc subprocess. But it seems like patch 6 would also have
been fine. Here is good, too.

> +	/*
> +	 * When `maintenance.autoDetach` isn't set, then we fall back to
> +	 * honoring `gc.autoDetach`. This is somewhat weird, but required to
> +	 * retain behaviour from when we used to run git-gc(1) here.
> +	 */
> +	if (git_config_get_bool("maintenance.autodetach", &auto_detach) &&
> +	    git_config_get_bool("gc.autodetach", &auto_detach))
> +		auto_detach = 1;
> +

This && caught me by surprise, but it's really "if both of these config
options are unset, then set a default." Makes sense after thinking a bit
harder.

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

And this changes because it's the new default. You don't need config change
to the test repo to make this happen. Good.

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

I appreciate the care taken in these test cases. It verifies the logic around
the if statement that I had to read twice.

Thanks,
-Stolee

