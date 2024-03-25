Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE472199EA7
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361195; cv=none; b=IRTYxcdAPgOUM4erFFoyuQlBxZZOUn3wrVsQFkvCAA4OcQhfajXKk8Xk84ygEHYu4qTX4VbmvFmLKyaIfn3f2fg5bzNuGTzDCOarWHyDNtoQ487txz8eEugDcuNQu40bj44D7d19n9ook+34mQ8eTEXhgTuO7dN0yoOtub+vuXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361195; c=relaxed/simple;
	bh=2LC7wLbTOBmz0LsfMwLzI2PyQg7FJTB3LgCJ/KNUvTA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YRKN2NJfBZ2DKo+6hjN199b1XU5E1qHvTbT7eAGA83cIx+sBIWlazWktxRaQTGYAnLub54Uc+wQQKGaYB1BzKXC2eFbRDnJSTw0zTqz32dtwGLVVJAWn4oy+GnPHVukWsa6Z7nObb/82VVgDAv0Njf4KJP106uqW+rxlMx7zdYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6Do0d21; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6Do0d21"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d68cf90ec4so71032131fa.1
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 03:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711361191; x=1711965991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X5QFvJ0Vunr8NczBnC8j7ueP2Dmmd1AMjtxoyYRR2mI=;
        b=T6Do0d21dqEnvimFrfT8Frap8Rf8nkMeSFa/IZsu4EXRfIC39FOy6XGdA97FxNJicU
         lFauDA6MQt1hxrBDbECjNvjzTgptesGTnQHMIA1t2ya711eCYUMCiGW2sVSB5bX8Zwcl
         YhcC732aquib3RVQ5C+LbQ9Lcl34nUdoV6t9yCXzoCTXWqodpigzYoTSiYWldxHx41u1
         bPmpLfjvbfHFiuJqKbjSAoLJfswi3JPG5WRaEaOv3iubQAE8UMz+vkqTc7gvdFNq6V5+
         NeEKxm4Wa8enjVXIVjptOJNpwQVn0Q76vl8nMQOYGkxFC9E6g4XkGbmSqvhiah5JbiSE
         MG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711361191; x=1711965991;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5QFvJ0Vunr8NczBnC8j7ueP2Dmmd1AMjtxoyYRR2mI=;
        b=G39tKpuSr/dhD+bWUvX+NiRufkmcKEeu3LuhfEhz69jqZdZE+IBZS2NN5yvzcAk/Y/
         gaQ84nLbEbzyeWsUUxVYZdkWgMITubfIEHASutydcyDI/29Xi2tRmp4x3YTePdJPNg2q
         89VAKtM4HBApqPOV8ur0d9f3sIn8kI/EaVbyty+aGpNaO87j0W8Vk8z0bpDwfGTrq3U8
         JEBbUApXkSsPoa0T6jhaDXdcrn1O+oy/ljjcKGn2U5D6WAPJTLpuUL8CHSKzd/1xVLnS
         Z8lsnUFl9kC2/b4/5u9ilQg/4jVQP1EanY3/GMToMyjtVc//NfcgdeF9Sr6ai1JMrcgZ
         uvMQ==
X-Gm-Message-State: AOJu0Yxg+KxOSQMMY0M04qG75TSNIf+dNm7uqpOB0yMjkeZIiz82MHFL
	cnz56GOHpYwzY5DRk64rQ6opQpC//zekzVvoiJvTP+61wxXAkt75Z609cnZM
X-Google-Smtp-Source: AGHT+IH1Ovrvu0GLYKLsJ8oWlN1NqkQVOILN08BqAyL6e7LFJeqo7FhvCKrqjA6Ziae3UCogUpWfGw==
X-Received: by 2002:a2e:8090:0:b0:2d4:8e2f:e3d6 with SMTP id i16-20020a2e8090000000b002d48e2fe3d6mr4053382ljg.10.1711361190794;
        Mon, 25 Mar 2024 03:06:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443? ([2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b004147ec48845sm7897103wmo.26.2024.03.25.03.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 03:06:30 -0700 (PDT)
Message-ID: <03513931-7070-4430-bfae-aa039f73d74b@gmail.com>
Date: Mon, 25 Mar 2024 10:06:29 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/6] maintenance: use packaged systemd units
Content-Language: en-US
To: Max Gautier <mg@max.gautier.name>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
 Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20240322221327.12204-1-mg@max.gautier.name>
 <80580cc5-0285-43d2-ac51-71dce16f0028@gmail.com> <ZgE2pFt-pXurYnKU@framework>
In-Reply-To: <ZgE2pFt-pXurYnKU@framework>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Max

On 25/03/2024 08:32, Max Gautier wrote:
> On Sun, Mar 24, 2024 at 02:54:58PM +0000, Phillip Wood wrote:
>> Hi Max
>>
>> On 22/03/2024 22:11, Max Gautier wrote:
>>> * Distribute the systemd timers used by the `git maintenance start` with
>>>     the systemd scheduler as part of git, rather than writing them in
>>>     $XDG_CONFIG_HOME.
>>>
>>> This allows users to override the units if they wish, and is more
>>> in-line with the usual practices of distribution for systemd units.
>>
>> Thanks for suggesting this, I think this is a useful change, but the
>> implementation could be improved.
>>
>>> We also move away from using the random minute, and instead rely on
>>> systemd features to achieve the same goal (see patch 2). This allows us
>>> to go back to using unit templating for the timers. This is also a
>>> prerequisite to have static unit files.
>>>
>>> Note that even if we really need more specific OnCalendar= settings for
>>> each timer, we should still do it that way, but instead distribute
>>> override alongside the template, for instance for weekly:
>>>
>>> /usr/lib/systemd-user/git-maintenance@daily.timer.d/override.conf:
>>> [Timer]
>>> OnCalendar=<daily specific calendar spec>
>>
>> We should definitely do that. Using systemd's random delay does not prevent
>> the different maintenance jobs from running concurrently as one job may be
>> started before a previous job has finished. It is important to only have one
>> job running at a time because the first thing "git maintenance run" does is
>> to try and acquire a lock file so if the hourly job is running when the
>> daily jobs tries to start the daily job will not be run.
> 
> Thinking about that, it occurs to me that the current scheme does not
> prevent concurrent execution either: the timers all use Persistent=true,
> which means they can fire concurrently on machine boot, if two or more
> would have been triggered during the time the machine was powered off
> (or just the user logged out, since it's a user unit).

Interesting, I wonder if the other schedulers suffer from the same problem.

> So maybe there should be a more robust mechanism to avoid concurrent
> execution ? I assume from what you say above the lock is acquired in a
> non-blocking way. Could going to a blocking one be a solution ?

It is possible to wait on a lock file but I'd be worried about building 
up an endless queue of processes if the process holding the lock file 
crashed leaving it in place without anyway to automatically remove it.

I don't think we need to solve that problem as part of this patch series 
but we should take care not to make it worse. Long term we may be better 
scheduling a single job and have "git maintenance run" decide which jobs 
to run based on the last time it run, rather than trying to schedule 
different jobs with the os scheduler.

>> As the daily job is
>> a superset of the hourly job and the weekly job is a superset of the daily
>> job so it does not make sense to run more than one job per hour.
> 
> Is that set in stone, or could they perform disjoint set of tasks
> instead ?

All of the schedulers are set up to run a single job each hour, I don't 
see why we'd start running disjoint sets of tasks in the different jobs.

>>> The cleanup code for the units written in $XDG_CONFIG_HOME is adapted,
>>> and takes care of not removing legitimate user overrides, by checking
>>> the file start.
>>
>> This points to an alternate strategy for supporting user overrides - don't
>> overwrite the unit files if the user has edited them. I think that there is
>> still a benefit to moving to system wide unit files though as it means that
>> if we improve the unit files in the future systemd will pick up these
>> improvements automatically. That is an improvement over the status quo where
>> the users' unit files are written once and never updated.
>>
>> I think it would help to reorder the changes in this series as follows:
>>
>> 1 - simplify the invocation of "systemctl --user"
>>    This would be the current patch 3 without adding "--force" or
>>    moving "--now" combined with the relevant test changes from patch 6.
>>    This would make it clear that those changes are a simple clean up that
>>    is independent of the other changes made in this series.
>>
>> 2 - don't delete user edited unit files
>>    This would be based on the current patch 4 and would show that we can
>>    avoid deleting unit files that the user has edited without the other
>>    changes in this series. This change should have an associated test.
>>
>> 3 - start using systemd's random delay function
>>    This would be the current patch 1 without the template changes and the
>>    commit message should explain that it is in preparation for disturbing
>>    system-wide unit files.
>>
>> 4 - install system-wide systemd unit files
>>    This would be based on the current patch 2 with the addition of
>>    overrides to prevent more than one job running per hour. The unit
>>    files should be installed under $XDG_DATA_HOME when $(prefix) starts
>>    with $(HOME), not just when they are equal. The associated test
>>    changes from patch 6 should be moved here as well as the "--force"
>>    change from patch 3.
>>
>> 5 - documentation updates
>>    I'm on the fence about having these in a separate commit like the
>>    current patch 5 or updating the documentation when the code is
>>    changed.
> 
> I had started cooking v3, I'll take into account, thanks !

Thanks

Phillip
