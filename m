Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED139280332
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 09:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409162; cv=none; b=AMvbi1Ff1cXGGxCHhIaQUiYv9UF+KIagW3/bvsOcyzTRCEcJfpaBvtpNwaKXIHUBR9EKdwL83E/Hw3ojXax1UX5dBolDENYsiK1Cn29vfnyAH2bMv7j06ulEvPUiTtRWMEYKIM14PG7pId6NdRzkK5FhM2X8J9NRnLm4qwc4EhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409162; c=relaxed/simple;
	bh=nsOIM8vuh51KEY/K55ibYw9YeIFap5DbQYSM8wFYY4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCD4tI/en3r37m2LKr7dNNtfZ1mQ897H6jDi7W+a6Wd9r030weUFvKVSrjCGds4iywGk9Vo97j7Xw5UbSKHYzVm2dCba7lBkQe1vF+Au/2lmmO3fjA+hgUjZExPja5sd50MeaqlG5GrldbtDnZ2K+anCfpfkp3FkqS9v4OSnOOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqmo7fyG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqmo7fyG"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45ddddbe31fso18151265e9.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 02:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409159; x=1758013959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TDBKmM0m0DT5f0Ff+0C8rwOLv+UCU/31+DrChwLQVj4=;
        b=hqmo7fyGWCp8cDNUqj8+wU/LTCCWrUMWMRuyK5znGBhqTOM1UJZ7v5QeSCI+503XmL
         ZjMobIlzrkKhH/CU5WDkSTZiedQ0zHDb9PPbmxlUFDZDjdV2L2jHhLjCFJDdPxmouhLs
         6NFNEdPLcETA7mR6HDO5oX4aazpuz0RUHfb6FCcSixAfVqdRI9avy1fV+dNb/PuYUcdL
         0cPVkWLLYXbxP/6dIkjTghcwvToDRKKPZqcXhmcu1WqI12D4WuqCW9pDbLhYdKBDJ2Cg
         kcwfpAAP8P7N+279hIzJNOgg1Ki3GSYfSZMUSOisi7cUIq6W8asw3uPy8HDkM7zqi2Kg
         YnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409159; x=1758013959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDBKmM0m0DT5f0Ff+0C8rwOLv+UCU/31+DrChwLQVj4=;
        b=dbROkLYxPhlOGr/c180BxUgt+otkh8GuktIa3msbfEEXmGV22iteFvJfDbhhMGUncn
         c/2e12i1OclZ9Ht4YnwctZRJckU2No3GKC59fdGqyc+DEluTYPvPRKhUZ+l8mx8jgvQI
         /TNWDqdhd/QLMGVACgVh/7JPD0UbKJIeM9YFabo/Vf1j4/JDqM36Cc0fU1WM6jXmFS2W
         tyOGpZ/z2Ze/3H1fi4WuOsK41oFNow+2FsqW5od2SwtKrYr7gdyEn53cUQsbIcjJjcwP
         mwHPkG1esHuqnoyAVHy3uabBX/wdWZ9R2m5iO2TzO3Y2Mr5O39Z/0qvRLSeMkAmqhCkz
         a4Zg==
X-Gm-Message-State: AOJu0YxXQAqJZOwM58XzHGLopPO7mGAdkXL8iF2WdsYPhdBPz3LegQyD
	sApsKu0JKLDy2XxE4NSn7AfcbXqpE56s68wqKiII/wtOUyrmyZAGNHQSZtEI9XfG
X-Gm-Gg: ASbGncuUywPP5J+5Y88YA/X72Ti2jr3wlQEvin8RG8F6+Lvyei64weGH5YgGZr/l6k6
	2Wg2Vd4FgU+nLiqGEet8B0zi/MJ7b0XexqbVskUcZ4HBtgQBe97fRfu9KuUJcEcxkAbvp29BGgW
	nupRvEnqWHU5Egvhps2QbDLUQ+oUC+J640XwkIXobHusqZElCB4YvIKKX6CGbnqnnV0B7RN6Vc3
	MCgLEPLdDSujAMFOeiKIDlo6DlrPiuYOI3ZzQR36vURZ4TvRUdzyS6jTnKSjbKCo01vRQksxoz7
	NZorssmzvh63FbIH30sAGOz78J1CpySj1x0VVPAcmXejr/sb8dVjYSaQIlKegr+TdDERL4/Ifzb
	sjEuNHIJCOP2Qc+fZUo8dZogryo5vWHshHiegPJHsuMNZQvk0DurO17Ajq8UofQrKEFjr6qbYZM
	A9CsbCtgd9en0hFR4=
X-Google-Smtp-Source: AGHT+IG3oUVTvqK1ZvDl9Pi7Xw2qTMiERHjHbACzEUmaBFCWg/KF5INlczDOxEol5/b12PcgK/3EeA==
X-Received: by 2002:a05:600c:4ed1:b0:459:db71:74d7 with SMTP id 5b1f17b1804b1-45ddded6d45mr92081185e9.27.1757409158802;
        Tue, 09 Sep 2025 02:12:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc? ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df3353ae6sm2862745e9.0.2025.09.09.02.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 02:12:38 -0700 (PDT)
Message-ID: <6914d50d-20bb-40f2-9d52-920f37b6a3f1@gmail.com>
Date: Tue, 9 Sep 2025 10:12:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/4] t9902: switch default branch name to main
To: Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Wing Huang <huangsen365@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
 <cover.1756992089.git.phillip.wood@dunelm.org.uk>
 <f1bf01e13226cf3f6ca0e811123278248e4eea6d.1756992089.git.phillip.wood@dunelm.org.uk>
 <aLrULt3p_sHvj8r0@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aLrULt3p_sHvj8r0@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/09/2025 13:14, Patrick Steinhardt wrote:
> On Thu, Sep 04, 2025 at 02:21:31PM +0100, Phillip Wood wrote:
>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> index 6650d33fba6..964e1f15693 100755
>> --- a/t/t9902-completion.sh
>> +++ b/t/t9902-completion.sh
>> @@ -11,9 +11,9 @@ test_description='test bash completion'
>>   # untraceable with such ancient Bash versions.
>>   test_untraceable=UnfortunatelyYes
>>   
>> -# Override environment and always use master for the default initial branch
>> +# Override environment and always use main for the default initial branch
>>   # name for these tests, so that rev completion candidates are as expected.
>> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
>> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>>   
>>   . ./lib-bash.sh
>> @@ -1453,7 +1453,7 @@ test_expect_success 'git bisect - start subcommand arguments before double-dash
>>   		HEAD Z
>>   		final Z
>>   		initial Z
>> -		master Z
>> +		main Z
>>   		EOF
>>   	)
>>   '
> 
> Hm. Wouldn't it be preferable to do something like the below patch
> instead? We would potentially also have to sort the output, but like
> this we don't care about the initial branch name at all.

If we're going to do that then I'd strongly prefer that we have the test 
suite set something like TEST_DEFAULT_BRANCH and use that instead of 
forking "git branch" or "git symbolic-ref" everywhere. It keeps the 
tests cleaner and avoids slowing the test suite down by adding a bunch 
of new processes.

As this patch series is focused on removing 
GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main rather than making tests 
independent of the default branch name I'd prefer to leave this patch as is.

Thanks

Phillip


> Patrick
> 
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 6650d33fba..321005a06a 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -11,11 +11,6 @@ test_description='test bash completion'
>   # untraceable with such ancient Bash versions.
>   test_untraceable=UnfortunatelyYes
>   
> -# Override environment and always use master for the default initial branch
> -# name for these tests, so that rev completion candidates are as expected.
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
> -export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> -
>   . ./lib-bash.sh
>   
>   complete ()
> @@ -1449,11 +1444,11 @@ test_expect_success 'setup for git-bisect tests requiring a repo' '
>   test_expect_success 'git bisect - start subcommand arguments before double-dash are completed as revs' '
>   	(
>   		cd git-bisect &&
> -		test_completion "git bisect start " <<-\EOF
> +		test_completion "git bisect start " <<-EOF
>   		HEAD Z
>   		final Z
>   		initial Z
> -		master Z
> +		$(git branch --show-current) Z
>   		EOF
>   	)
>   '
> 

