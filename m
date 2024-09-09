Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781D71B1502
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873210; cv=none; b=OCHe2FAcYQioaniq6LLcEzY+flaGFEAxeXrciEUsA8TkBCbEWgKdkAugmlvifrj3HdtBk4B1fcqRaIHBWPC2bGBLCQwIDc9q1ro5/nHnOwY/pVLEOpaR4RMBJpJvwLUK9BrLJ5xIIVMDpWep3lAAhwH7VovJaQSNSrxIOOWGgQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873210; c=relaxed/simple;
	bh=gEgbAc4FeZpypEjVN1UGqPuvqyLaEEaYSA80Om4kXKw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JHvVIryw+YIp6oMyLZlhYw6C1SDIiL9c4m4HcnpVAjrLuoHZWNIDNxvR1tztciQUTBpuAuCUXaGj/JQ8NBwV3xiivMFLeCxQp9Es5gc72GA3golnX6R9gB2Ju12gE9jy3FJkFBSkAyHbiKeKJnhEmT/P6tVA0uc4+7NTa04kuU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTgMGC8O; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTgMGC8O"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso18333735e9.2
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 02:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725873207; x=1726478007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=njrg3CdT+MxEV1VM/n1gpGtRRLlx+vwuB80TLSNuRGE=;
        b=mTgMGC8OOim6dsA46JWu5NRE2k2AMvnSYEzZonNX5a3LmJM2s7QVH4ZBghNrL0vp4V
         O40LyCkB9cX8a3RjFqbvyDD/hMh7zzU57o+8dVPxOueIAbQmRIYVDG41aw61H3rZQ0/6
         dmydIwlhXEk2Tkcl8abINepGRj0t5NL9xtW2EBlZY9upAI2oZEyfQmtNaRZeDOdbb3TK
         hfKcQ2ykNR2zriOW4JrMnfX1UbfI5qc2J1s4om3vFaIHH0HxBktTTtl4Oz6yaCn7/r/d
         AAQDsyTEyoMLCof1iXnKGhLAp+4OZ8pJZf9dNa/9VkWPCJmF8KYoGr5/ljr3X3YcGAI1
         Pt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725873207; x=1726478007;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njrg3CdT+MxEV1VM/n1gpGtRRLlx+vwuB80TLSNuRGE=;
        b=tYF0F2TwxBdFoRnc+5GMbiKsyKLO0xvnsnt784YKkh6yZdDozwmS+UvJhsiJQ6eKLR
         IkSIMUh+VC6at1y/bp0yyH0zL5b03ACariZa+P5tFeZsQhGPZEpNeXyklHGnwmux4fZm
         6cPVOrV2SJ0xYbaBt3HdJW8yzfp9xywVTrtssNJIp7hhk7BPBKA08lgd8u3D+IazyItP
         6WkAXzjHrQ/qwDmw+VC/oKmn9Bg4h0Uw/ySdNR8t9PzSQnIFpYQiMd7M+LbiTvumCPLm
         1W8BTN75scPLdX+wbfLfCV29kQ+tfWbuBPRggmJXpjOCtO0tCtzx+Jkn8gCS6atZV/3b
         frSw==
X-Gm-Message-State: AOJu0Yz1OBG8Jcy5TYNr60qinTVePXUIElflWzKTRPvCc5nka8OgjR9s
	zjSOLuAF3Mhpcc/TZEEoHynpcmTjiiepl3JHK7zrvL6e8pFCk26CBwh2JQ==
X-Google-Smtp-Source: AGHT+IH9k6YHcW0fhmNnkFWemJFdZ82EmaYQHPSbxcEOBTk8WcCEYhhHY4/ZbYRz5YfrgiY+enj+yg==
X-Received: by 2002:a05:600c:1c86:b0:428:150e:4f13 with SMTP id 5b1f17b1804b1-42cadb6a2d2mr50598795e9.33.1725873206039;
        Mon, 09 Sep 2024 02:13:26 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb77afd5asm30355885e9.17.2024.09.09.02.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 02:13:25 -0700 (PDT)
Message-ID: <20fc64ed-24a1-45c0-928f-ddb4c6106262@gmail.com>
Date: Mon, 9 Sep 2024 10:13:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: =?UTF-8?Q?Re=3A_=60git_remote_set-branches_=28without_--add=29_=3Cn?=
 =?UTF-8?Q?ame=3E_=3Cbranch=3E=E2=80=A6_=60_does_not_add_refspecs_to_=60remo?=
 =?UTF-8?B?dGUuPHJlbW90ZT4uZmV0Y2hgIHdoZW4gYHJlbW90ZS48cmVtb3RlPi5mZXRjaGAg?=
 =?UTF-8?Q?does_not_exist?=
To: Han Jiang <jhcarl0814@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
References: <CANrWfmR1y64OP+506JUO3Beic9kn5_TrhMQ1ZucVcDEn03noLg@mail.gmail.com>
 <612756e2-fc84-4d49-9f74-ff1998f66f7c@gmail.com>
 <CANrWfmS9PCKyK3X0rFnWfecrn-ETmcdtoPtA6j9QS7nTwfivKg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANrWfmS9PCKyK3X0rFnWfecrn-ETmcdtoPtA6j9QS7nTwfivKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/09/2024 23:24, Han Jiang wrote:
> A way to get into the state is `git remote set-branches <remote>`
> (followed by zero <branch>es), which removes `remote.server.fetch`
> configuration variable.

Oh, I wonder if that is a feature or a bug? I see we don't sanity check 
the branch name either so we'll happily create refspecs containing any 
old rubbish. I'll send a patch series that fixes the original bug and 
checks the branch names later this week.

Best Wishes

Phillip

> After that, `git remote set-branches <remote>
> <branch>…` does not work. (But `git remote set-branches --add` can be
> used to get out of the corrupted state.)
> 
> Shortened version of the example:
> git remote add server git@example.com
> git config list --local
> git remote set-branches server
> git config list --local
> git remote set-branches server branch1 branch2
> git config list --local
> 
> On Thu, Sep 5, 2024 at 9:07 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> On 03/09/2024 11:37, Han Jiang wrote:
>>> Thank you for filling out a Git bug report!
>>> Please answer the following questions to help us understand your issue.
>>>
>>> What did you do before the bug happened? (Steps to reproduce your issue)
>>
>> It is always helpful to show how to reproduce a bug but please try and
>> aim for a minimal reproduction recipe. It is much easier to follow if
>> you show which output lines come from which command. In this case one
>> can reproduce the issue with
>>
>> $ git remote add test git@example.com
>> $ git config --get-all remote.test.fetch
>> +refs/heads/*:refs/remotes/test/*
>> $ git config --unset-all remote.test.fetch
>> $ git config --get-all remote.test.fetch
>> $ git remote set-branches test main topic
>> $ git config --get-all remote.test.fetch
>>
>> I haven't looked into what causes this. I wonder how likely users are to
>> be affected - how did you get into a state where there was no fetch
>> refspec set for your remote?
>>
>> Best Wishes
>>
>> Phillip
>>
>>> cd '/'; cd '/'; rm --force --recursive -- './test_git'; mkdir "$_"; cd "$_";
>>> mkdir --parents -- './server' './client';
>>> git -C './client' init './repo'
>>> git -C './client/repo' remote --verbose
>>> git -C './client/repo' config list --local --show-scope --show-origin
>>> git -C './client/repo' remote add server 'file://'"$(realpath
>>> './server/repo.git')"
>>> git -C './client/repo' remote --verbose
>>> git -C './client/repo' config list --local --show-scope --show-origin
>>> git -C './client/repo' remote set-branches server branch1 branch2
>>> git -C './client/repo' config list --local --show-scope --show-origin
>>> git -C './client/repo' remote set-branches --add server branch3 branch4
>>> git -C './client/repo' config list --local --show-scope --show-origin
>>> git -C './client/repo' remote set-branches --add server branch3 branch4
>>> git -C './client/repo' config list --local --show-scope --show-origin
>>> git -C './client/repo' remote set-branches server
>>> git -C './client/repo' config list --local --show-scope --show-origin
>>> git -C './client/repo' remote set-branches server branch1 branch2
>>> git -C './client/repo' config list --local --show-scope --show-origin
>>> git -C './client/repo' remote set-branches --add server branch3 branch4
>>> git -C './client/repo' config list --local --show-scope --show-origin
>>> git -C './client/repo' remote set-branches --add server branch3 branch4
>>> git -C './client/repo' config list --local --show-scope --show-origin
>>>
>>> What did you expect to happen? (Expected behavior)
>>>
>>> (local config has branch1 and branch2:)
>>> remote.server.fetch=+refs/heads/branch1:refs/remotes/server/branch1
>>> remote.server.fetch=+refs/heads/branch2:refs/remotes/server/branch2
>>> remote.server.fetch=+refs/heads/branch3:refs/remotes/server/branch3
>>> remote.server.fetch=+refs/heads/branch4:refs/remotes/server/branch4
>>> remote.server.fetch=+refs/heads/branch3:refs/remotes/server/branch3
>>> remote.server.fetch=+refs/heads/branch4:refs/remotes/server/branch4
>>>
>>> What happened instead? (Actual behavior)
>>>
>>> (local config does not have branch1 and branch2:)
>>> remote.server.fetch=+refs/heads/branch3:refs/remotes/server/branch3
>>> remote.server.fetch=+refs/heads/branch4:refs/remotes/server/branch4
>>> remote.server.fetch=+refs/heads/branch3:refs/remotes/server/branch3
>>> remote.server.fetch=+refs/heads/branch4:refs/remotes/server/branch4
>>>
>>> What's different between what you expected and what actually happened?
>>>
>>> Anything else you want to add:
>>>
>>> Please review the rest of the bug report below.
>>> You can delete any lines you don't wish to share.
>>>
>>>
>>> [System Info]
>>> git version:
>>> git version 2.46.0.windows.1
>>> cpu: x86_64
>>> built from commit: 2e6a859ffc0471f60f79c1256f766042b0d5d17d
>>> sizeof-long: 4
>>> sizeof-size_t: 8
>>> shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
>>> feature: fsmonitor--daemon
>>> libcurl: 8.9.0
>>> OpenSSL: OpenSSL 3.2.2 4 Jun 2024
>>> zlib: 1.3.1
>>> uname: Windows 10.0 22631
>>> compiler info: gnuc: 14.1
>>> libc info: no libc information available
>>> $SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe
>>>
>>>
>>> [Enabled Hooks]
>>> not run from a git repository - no hooks to show
>>>
