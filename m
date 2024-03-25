Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8B013D51C
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384759; cv=none; b=ssW8GxQYglB+0p3IreY1OJsnlcVLQ9SIbm8CFIslTDvbNU0Ut6D2hkcMpyvSFWy8/LFsOYIpDWYDbzvUkZaTrNsVIYNW5Ap3SR4O7T+QmE21nS5uEZI/7MRtKPrbcfB5WiJPwi8UGebXUzfDqyFpi1ZsjjHe8sMaYsM3+vpMx7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384759; c=relaxed/simple;
	bh=TZ7P0+XGuY4HdwSpwppMbHJVFG9STgW0ErZqqogpft0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DsY8G4FXd632hkkWwwV5/MjjI6cHwixVL8SKxH/1AnQtspVrhZsITmAE/mfuzQqyGYPzolqEz2FwgWX9BbcavaoMBDRs8blW3HE2ekTxekP7nWRKGdByoxUWEDiRlczxJTllDZJ78vPsVLkaoF0ztd/hf2wblvIUQN4d3e2KJd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KA/mCAWG; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KA/mCAWG"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d41d1bedc9so85223631fa.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 09:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711384756; x=1711989556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TKetWCvkiQcoPv6V8mCl56bnBbF+VSSyArt1pdjpmQo=;
        b=KA/mCAWGgKQxWuvPBfKemr73qx2mQtJDE5XvQzPzNLCT+8ZkJZoRgoLmrL7Ij3kAOu
         i1bxMie39AcUDkmygdts2ia7fPHjamp6z+qN5F4PUxjkQoQLL1ymUBLIaVaJ96fo9qGA
         TEFYMnNXDf3Y2EK6AfAlIdWld1yMQOOZ/My6W4hYhz3VcyxduXBysgqk8mTh6bsFov0G
         j44VWQ5Uq98XAIV8rm25MDWpEn69J4x4F2hHmmjADb3cd76hKknxuHRJGTxs0GNj7bJs
         wVPY/KPGGZarlpDrFyDRixhuxAJWrFs2ED6M90ltIfA/tfLeq36TAE5xSgh1YtUbMsMp
         d6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711384756; x=1711989556;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKetWCvkiQcoPv6V8mCl56bnBbF+VSSyArt1pdjpmQo=;
        b=OCauw4+4X5kr9tlJ2gzmwxDcq+pLTfDjXS8xa3kiRpBGb1tfNPMFcP1GM9TacCtl7N
         uf4mrCfarXd5S6bLaoHm66ut++FQ41C9eoi1Y4BjeulA4X0iyJILKr1EiBak8cfgQb36
         ohYmMooLdzR5Fvza5bPkrBZw4QcomGzfKhiLMWi3c7qc8dj/NZDL647MQYk9d4h8YOAA
         R45FQqZhljmHFBCUWqNJKi4pUpSAuPyS5RFgtM0WsbMI/U/SCd0AOaZGY71SuIaWu8w+
         XOWJ6UdRnQAW2gTv0IdHWYDjGEzNpoEI0xlnqr08iLMTARCWfGdgJKbYL/YwSVStulgj
         tQVw==
X-Gm-Message-State: AOJu0YzsKCYZ/fF0j+UATprnZTx3M5mtEwdIXiSWSC8GNWJWtnDkhvU/
	0Eb2wB8teFrNMVLaB0pRsW10AqFose4eFRFxSaC6nRBX2UnT44+f
X-Google-Smtp-Source: AGHT+IFFGLWfMy+Gce2qMG15iMBm8WXvYiumxXhfXTxHVq2xaUjyMb7bleBW4Su4or8+cUJXPtsn0g==
X-Received: by 2002:a2e:b0cc:0:b0:2d4:5c03:5ccb with SMTP id g12-20020a2eb0cc000000b002d45c035ccbmr5896328ljl.10.1711384755482;
        Mon, 25 Mar 2024 09:39:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id l12-20020a1709062a8c00b00a45f39b2d16sm3220130eje.200.2024.03.25.09.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 09:39:15 -0700 (PDT)
Message-ID: <4f439090-0af4-4105-b009-250f522409c8@gmail.com>
Date: Mon, 25 Mar 2024 16:39:16 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/6] maintenance: use packaged systemd units
Content-Language: en-US
To: Max Gautier <mg@max.gautier.name>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
 Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20240322221327.12204-1-mg@max.gautier.name>
 <80580cc5-0285-43d2-ac51-71dce16f0028@gmail.com> <ZgE2pFt-pXurYnKU@framework>
 <03513931-7070-4430-bfae-aa039f73d74b@gmail.com> <ZgFtorXnGPm45oO0@framework>
In-Reply-To: <ZgFtorXnGPm45oO0@framework>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/03/2024 12:27, Max Gautier wrote:
> On Mon, Mar 25, 2024 at 10:06:29AM +0000, phillip.wood123@gmail.com wrote:
>>>>> Note that even if we really need more specific OnCalendar= settings for
>>>>> each timer, we should still do it that way, but instead distribute
>>>>> override alongside the template, for instance for weekly:
>>>>>
>>>>> /usr/lib/systemd-user/git-maintenance@daily.timer.d/override.conf:
>>>>> [Timer]
>>>>> OnCalendar=<daily specific calendar spec>
>>>>
>>>> We should definitely do that. Using systemd's random delay does not prevent
>>>> the different maintenance jobs from running concurrently as one job may be
>>>> started before a previous job has finished. It is important to only have one
>>>> job running at a time because the first thing "git maintenance run" does is
>>>> to try and acquire a lock file so if the hourly job is running when the
>>>> daily jobs tries to start the daily job will not be run.
>>>
>>> Thinking about that, it occurs to me that the current scheme does not
>>> prevent concurrent execution either: the timers all use Persistent=true,
>>> which means they can fire concurrently on machine boot, if two or more
>>> would have been triggered during the time the machine was powered off
>>> (or just the user logged out, since it's a user unit).
>>
>> Interesting, I wonder if the other schedulers suffer from the same problem.
> 
>  From what I can find (didn't dig much):

Thanks for looking at this

> - cron does not have the problem, because it will just miss the timers
>    if the machine was powered off. Not really better ^

Yes, skipping the jobs is not great. On debian at least the job will be 
run if it is less than three hours since it should have been run. See
https://manpages.debian.org/bookworm/cron/cron.8.en.html

>    - anacron though is another implementation of cron which apparently
>      support that semantic and is the default on ubuntu [1]
>      I can't find if there is something to avoid the same problem that
>      Persitent=true imply

> - same goes for launchctl (Effect of Sleeping and Powering Off at the
>    bottom of the page [2])

As I read it the job is rescheduled if the computer was asleep when it 
should have run, but not if it was powered off.

> - for schtasks it's apparently possible to have a similar mechanism than
>    Persistent [3]. There is a policy apparently to handle multiples
>    instances [4] but I'm not completely sure whether or not theses
>    instances can have different parameters.
>    It's currently defined that way for the schtasks scheduler:
>    "<MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>\n". I
>    don't think it would prevent parallel execution between the different
>    schedule though, it seems to me they are different tasks.
> 
> [1]: https://serverfault.com/a/52338
> [2]: https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/ScheduledJobs.html
> [3]: https://learn.microsoft.com/en-us/troubleshoot/windows-server/system-management-components/scheduled-task-not-run-upon-reboot-machine-off
> [4]: https://learn.microsoft.com/en-us/windows/win32/taskschd/tasksettings-multipleinstances

We should have a think about what to do about this once your patches to 
move to system-wide unit files are merged. We'll need to come up with 
something that works for all the schedulers so that we don't miss the 
daily and weekly jobs when the computer is powered off and ensures we 
don't run concurrent jobs.

Best Wishes

Phillip

>>> So maybe there should be a more robust mechanism to avoid concurrent
>>> execution ? I assume from what you say above the lock is acquired in a
>>> non-blocking way. Could going to a blocking one be a solution ?
>>
>> It is possible to wait on a lock file but I'd be worried about building up
>> an endless queue of processes if the process holding the lock file crashed
>> leaving it in place without anyway to automatically remove it.
>>
> 
> At least with systemd we have some mechanisms to deal with that.
> - systemd timers don't touch an already running unit, so that won't
>    trigger a new hourly or daily if the previous one is still running.
> - for the automatically removing it, we could:
>    - use XDG_RUNTIME_DIR ("%t" in systemd units) which is removed on
>      logout
>    - optionally add a tmpfiles fragments to delete locks which are really
>      too old (tmpfiles won't delete files on which a lock is taken)
>    - I thought about using a common RuntimeDirectory (see systemd.exec),
>      but this is not possible due to [5]
> 
> 
> [5]: https://github.com/systemd/systemd/issues/5394
> 
>> I don't think we need to solve that problem as part of this patch series but
>> we should take care not to make it worse. Long term we may be better
>> scheduling a single job and have "git maintenance run" decide which jobs to
>> run based on the last time it run, rather than trying to schedule different
>> jobs with the os scheduler.
>>
>>>> As the daily job is
>>>> a superset of the hourly job and the weekly job is a superset of the daily
>>>> job so it does not make sense to run more than one job per hour.
>>>
>>> Is that set in stone, or could they perform disjoint set of tasks
>>> instead ?
>>
>> All of the schedulers are set up to run a single job each hour, I don't see
>> why we'd start running disjoint sets of tasks in the different jobs.
> 
> I was wondering if running distinct tasks would allow overlapping
> execution, or if the different tasks are not safe to run concurrently
> anyway. I'm not familiar enough with them and the git internals to tell.
> 
> Another option if the tasks set was distinct for each service instance
> would be to use dependencies and ordering directives like this:
> weekly.service
> ```
> [Unit]
> Requires=daily.service
> After=daily.service
> 
> [Service]
> ExecStart=<run only weekly stuff>
> ```
> 
> daily.service
> ```
> [Unit]
> Requires=hourly.service
> After=hourly.service
> 
> [Service]
> ExecStart=<run only daily stuff>
> ```
> 
> hourly.service
> ```
> [Service]
> ExecStart=<run only hourly stuff>
> ```
> 
> That would avoid concurrent execution I think.
> 
