Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A543398B
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817921; cv=none; b=a6SetLukAri0fFBr/9lC9w7mvgW4prd79mvmC/Eb7zX0s/gb+xQEMj9OBDHcbBYhL59W+I4m+fGcSJ1gIgp6Ibcjmj1jtkMwUfSHQBp3JxxbxuNT8KJKTxturUj8Qx5ZysRIs7l7i3osQlnrlvhrHfUNIj2WJUuw/7phMVNlhfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817921; c=relaxed/simple;
	bh=OBe9Lxe0Nq9RncU+Rhjh1l10O7YgI8FbnYb6i3qgZ/Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Dvv/6BBfb5YTv9BZkjooM21X1416hxLvfRiVJ4/19rqpk1eW8VNLCpNVjl9j1+JyZ5xcfnbFOnVXqkjXhbH5+mnI+HCXcT/QkWqWq87Q5LjsJ9T89UYY0k8llgS46pi46Ym/ZdrTO4eZOybigtxwP8bMzaHIIMtnHWcTulvqbMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXFEH2bw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXFEH2bw"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-431688d5127so43941125e9.0
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 06:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730817918; x=1731422718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=feYEPI9vfW5+MkK+N0rqYwnTJPeLDOUBX2ehYo7acqU=;
        b=mXFEH2bwK0S8dDKcphGa5tHrveTNwxOjiuMSPps7PxdNji23zlKlYYVoCGp0Y84Y2U
         nH2Eu3x0Hy6z/8i9MXG7VQNjUArnBclz+GJb6pCZ0dAhhN0yGZDW4Qg3A9xqsONr7gnF
         kggJQXKxJJzEP9bzRaE9ndr8pHhtm3XYBvM7aSoQnUWF3/vukY1PQTeJFGbGpjdHWr9z
         Zxfld7QgR8ksahoqPTYCpz8CYcxcd6JeXMPsuL1SlzI1Zf/TJUzOQgFgl0l0awJvjVSl
         PiYobasS1TA8B7Bl4AB5/hN0yfUDmpfRlULOSPzF8UxxYK6hWAT253dBz0+XuwQA+CtA
         g1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730817918; x=1731422718;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=feYEPI9vfW5+MkK+N0rqYwnTJPeLDOUBX2ehYo7acqU=;
        b=E2VTT+Mu/AEhMy2u7eR3Q3svLcv3h7CL7OcY2l2BWSlTBhQuiQLoDFMAjWxaKmIDtR
         MFmNM62EDxBsXlH7KpG63F9GQ4hIFkBLIcIPnM1F3V0cw+4lkwozH/SvxNSXlIf5dXnL
         NmQaPx5swKC+gZymBFFxj751YCe96/Kv2fHkJWKMHGvVPmzIkCxGYDrA6Tgak4fbUSmo
         9KF4IxnHhkMXD7P5tlxiL2+ZO+XmF7pHm00SIShLlTeeE48rCAo4M7MP55+Gu9Hjhu47
         cSjgAPdAYkXnsaQFIq8U58I6Hi5xQmdAvCc0K999WThMQvxKZPpSWoZPbkf3jYPo7t7o
         W4Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXgonJg5I8TtRtotCr0oYqEZNxfx7rRi5CCjE9Ds8o4YEgb10BnOu++3cw1rs1oTp1lcwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdJMXV+gTe7rkEa+Ez9lmijDT1G0KeLuCC5bH9W0qYT7GmSvea
	efjQNxViOzAnesO62os0dVnpnZW6vR+GsyGDazdSGbhI2yWUs/6V2Oophg==
X-Google-Smtp-Source: AGHT+IExvUsnAT2OFqo86PIfr6n71XzfjJ+YCI/Jop5XhFJXv8UcBbDb8cX7hyN3b0JvhM4w1dsfiw==
X-Received: by 2002:a05:600c:4f4a:b0:431:50fa:89c4 with SMTP id 5b1f17b1804b1-4319ac6fb17mr343146715e9.3.1730817918055;
        Tue, 05 Nov 2024 06:45:18 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6b0:6601:5a4c:6f5b:4f15:3158? ([2a0a:ef40:6b0:6601:5a4c:6f5b:4f15:3158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf429sm187453265e9.12.2024.11.05.06.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 06:45:17 -0800 (PST)
Message-ID: <8c4e5911-d908-437a-8eec-385e272c8847@gmail.com>
Date: Tue, 5 Nov 2024 14:45:17 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4] remote: allow specifying refs to prefetch
To: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee <stolee@gmail.com>,
 Shubham Kanodia <shubham.kanodia10@gmail.com>
References: <pull.1782.v3.git.1726741439445.gitgitgadget@gmail.com>
 <pull.1782.v4.git.1728073292874.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1782.v4.git.1728073292874.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Shubham

On 04/10/2024 21:21, Shubham Kanodia via GitGitGadget wrote:
> From: Shubham Kanodia <shubham.kanodia10@gmail.com>
> 

I agree with the Patrick's comments on the implementation, I've left a 
couple of test comments below.

> +test_expect_success 'prefetch with positive prefetch ref patterns' '
> +	test_create_repo filter-prefetch-positive &&
> +	(
> +		cd filter-prefetch-positive &&
> +		test_commit initial &&
> +		git clone . clone2 &&
> +		git remote add remote2 "file://$(pwd)/clone2" &&
> +
> +		cd clone2 &&
> +		git checkout -b feature && test_commit feature-commit-2 &&
> +		git checkout -b wip/test && test_commit wip-test-commit-2 &&
> +		git checkout -b topic/x && test_commit topic-x-commit-2 &&
> +		git push -f origin feature wip/test topic/x &&
> +		cd .. &&

I think it would make sense to have a blank line before this rather than 
after it so "cd" is grouped with the commands executed in that directory.

> +		git config remote.remote2.prefetchref "refs/heads/feature" &&
> +		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head \
> +			--recurse-submodules=no --quiet" &&
> +		GIT_TRACE2_EVENT="$(pwd)/prefetch-positive.txt" \
> +			git maintenance run --task=prefetch 2>/dev/null &&
> +		test_subcommand git fetch remote2 $fetchargs <prefetch-positive.txt &&

This seems to be testing what "git maintenance" runs which is not really 
related to testing the prefetch ref pattern matching. I think just

	git maintenance run --task=prefetch &&

would be sufficient. We certainly should not be redirecting stderr to 
/dev/null as that hides any error messages that are helpful when 
debugging test failures.

> +		git rev-parse refs/prefetch/remotes/remote2/feature &&
> +		test_must_fail git rev-parse refs/prefetch/remotes/remote2/wip/test &&
> +		test_must_fail git rev-parse refs/prefetch/remotes/remote2/topic/x

these are the important tests for checking the prefetch pattern 
matching. We should perhaps be using "git rev-parse --verify"

The test coverage looks good

Best Wishes

Phillip

> +	)
> +'
> +
> +test_expect_success 'prefetch with negative prefetch ref patterns' '
> +	test_create_repo filter-prefetch-negative &&
> +	(
> +		cd filter-prefetch-negative &&
> +		test_commit initial &&
> +		git clone . clone3 &&
> +		git remote add remote3 "file://$(pwd)/clone3" &&
> +		cat .git/config &&
> +
> +		cd clone3 &&
> +		git checkout -b feature && test_commit feature-commit-3 &&
> +		git checkout -b wip/test && test_commit wip-test-commit-3 &&
> +		git checkout -b topic/x && test_commit topic-x-commit-3 &&
> +		git push -f origin feature wip/test topic/x &&
> +		cd .. &&
> +
> +		git config remote.remote3.prefetchref "!refs/heads/wip/*" &&
> +		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head \
> +			--recurse-submodules=no --quiet" &&
> +		GIT_TRACE2_EVENT="$(pwd)/prefetch-negative.txt" \
> +			git maintenance run --task=prefetch 2>/dev/null &&
> +		test_subcommand git fetch remote3 $fetchargs <prefetch-negative.txt &&
> +		git rev-parse refs/prefetch/remotes/remote3/feature &&
> +		git rev-parse refs/prefetch/remotes/remote3/topic/x &&
> +		test_must_fail git rev-parse refs/prefetch/remotes/remote3/wip/test
> +	)
> +'
> +
> +test_expect_success 'prefetch with positive & negative prefetch ref patterns' '
> +	test_create_repo filter-prefetch-mixed &&
> +	(
> +		cd filter-prefetch-mixed &&
> +		test_commit initial &&
> +		git clone . clone4 &&
> +		git remote add remote4 "file://$(pwd)/clone4" &&
> +
> +		cd clone4 &&
> +		git checkout -b feature && test_commit feature-commit-4 &&
> +		git checkout -b topic/x && test_commit topic-x-commit-4 &&
> +		git checkout -b topic/y && test_commit topic-y-commit-4 &&
> +		git push -f origin feature topic/x topic/y &&
> +		cd .. &&
> +
> +		git config remote.remote4.prefetchref \
> +			"refs/heads/topic/* !refs/heads/topic/y" &&
> +		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head \
> +			--recurse-submodules=no --quiet" &&
> +		GIT_TRACE2_EVENT="$(pwd)/prefetch-mixed.txt" \
> +			git maintenance run --task=prefetch 2>/dev/null &&
> +		test_subcommand git fetch remote4 $fetchargs <prefetch-mixed.txt &&
> +
> +		test_must_fail git rev-parse refs/prefetch/remotes/remote4/feature &&
> +		test_must_fail git rev-parse refs/prefetch/remotes/remote4/topic/y &&
> +		git rev-parse refs/prefetch/remotes/remote4/topic/x
> +	)
> +'
> +
>   test_expect_success 'loose-objects task' '
>   	# Repack everything so we know the state of the object dir
>   	git repack -adk &&
> 
> base-commit: 2e7b89e038c0c888acf61f1b4ee5a43d4dd5e94c

