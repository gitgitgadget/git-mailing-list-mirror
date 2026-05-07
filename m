Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4317340DFD3
	for <git@vger.kernel.org>; Thu,  7 May 2026 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177036; cv=none; b=fXsVIrmG37ktsY6kUTIWlXfKsbthV0/wOt1es205OE6m8+gLBzouba6oTtXdnglK4xueGGdXNgHQ8/9eqVCXdTZjPmjCq3btAgg0XvhTQ0+KMUm/qZG1ZxPSXwMsRQgZMjiFLbfoY9bG7LaNedBSFOSO7VbRxPx+wi7Zaq3Wyxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177036; c=relaxed/simple;
	bh=fsPSs5Ct1NmFTB+zWy6xXrqQGRECHfxyS7ga5GsDjbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RLxJntqWdNk9hjzErTAi0sOWQ0bNhxFQJMkAjIp0pjlBT7q2LETIPCYfNA9g3dsZibSovoK/FNWthQb6dVwZSqSCpqxXhgH/R4uGeeavL1oV1X3OQH6fDqlp+Yk7WP1ilTRIUHkGC42jAGJokRzPFd9c7WyMozdM23dx2Wu5/0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qbuXUERw; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbuXUERw"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-6312a0d556cso350437137.3
        for <git@vger.kernel.org>; Thu, 07 May 2026 11:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778177034; x=1778781834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jG9AJDWOjyhFww15cZr5cloBofHo5kQEZQFNZ8ivicw=;
        b=qbuXUERwVmhThq3d1QA0Z23oZtHUjIyuDx9B2eYwQESpA058XdNEVsR21BpNzH3Too
         TaGUar4mKz+g7crbiQXjZC2aoldamMhVR5kmXYtWGpYHKjryng2AgmMR2EGODEws4Wst
         /gZ7uqVPyc0vOp11CFMCW5m1vDroIvrrIqTUiW4iU3eeng8L5lLUgrsRbYd5KCtuBx/D
         cEBWBx60bfTZMw198rpQI8ahoVbeHB46HF8s8Il000QtamDJ7T4xwwFapgKYvRoeZn4Z
         jiwmNZF2w2yYZTeXkay/JP/hG33hg4+vDhKCKOA7dE2M5xY5I3avzFjx2kVHLgAqBm6l
         VrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778177034; x=1778781834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jG9AJDWOjyhFww15cZr5cloBofHo5kQEZQFNZ8ivicw=;
        b=TLl5dzPCwMTkFlrusC5R5Geic3UtZMxEr63Txz57JDjfGgpq/Zi9jTmy/CFkS/F/l6
         R1/HxBOEUqdPmf1QKF1FKXz25tIu7bmMDCOPzAU/e6SdjG2rz7CjITqMDpaPfGtT9dLI
         n5yyVARmHBqYg4XRfbZ98Vso8wkyIknuMPSFFI7AbRcv31P+RChrRYmT/tU8HD9Em/uk
         VsZ0vTZYO8/RorTJOP9FOTfzgdGlnYgbTaBtZ+pRklR5Bw4l44TNztBia5FFS5n9XlfP
         il1pJ9S2L3mCQMRV+4FZxzszG+YcoSsWMBiZNHqNCRWNwqJiq08gYAuEt7yuGIJX00at
         shmA==
X-Forwarded-Encrypted: i=1; AFNElJ8A/DIywLe02/iY+UV2869ODfu3wZTqalNVmDy8Z2fOdvP1E4b8SW+qWR5eXdZ9SFJiSqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfgfF5/Le00FilRYYlD9uw8WYQ5ZhLGUdl7PSX1PAONOoLZSr0
	06dEGAhHUKyxALOYWSFRcqKCvq3BGDrPwEjfMyaRmUn8vFC7pPE+Jl1e
X-Gm-Gg: AeBDies/TGDoja1eVOkyr/JuZk4j410qyoYfyiAlL63PmK1iJFjmcE1wNY4myl1aQk9
	ZIDDfEvJXfq+6DksEWQZKvBnpJCXGpsi0hxze46qFGTnvcqd66x9t8nmN+Xjv0+lx7Kks+4ryfU
	VybTFeoOX6l5PHDAAyxkIT4DB3WYu/74H98wkoUfhFOMvGkpsLgXUaPAwmIYEkGCc3o9fXZf74t
	JX50g8Ahc7LwolX1ogPdHHwPjDWBLkylHKU1jPhshO06GZJdKwNgVg1Y/D61SPsBB/zEoe3kuvS
	ntgdW0RJIWCgDNadQARhudAAxz8bgCgcCal+3hB63ZYCZ9GWB4xZPw0VKoaenBX38eRCOp2VSxB
	hhR/4PWzAeXbpiO9IeMKpJrQH4/hyconjCo72DQeOrNZA1k2vu2P6WFc+3WOxpdaKVPlPgu0xeZ
	nWouSirptqMtcfXQ/d5Tg+0frbwE41iND6CLPcrSxFnOqa7YoVOYVhzh+V3mf1gGvy/d8AZA==
X-Received: by 2002:a05:6102:4420:b0:608:1b6e:f4dc with SMTP id ada2fe7eead31-630f8ee9c5dmr4989154137.11.1778177034020;
        Thu, 07 May 2026 11:03:54 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c24ff43sm2007864185a.29.2026.05.07.11.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 11:03:53 -0700 (PDT)
Message-ID: <0b67df77-b0c8-47dd-ace5-8dd80474bbe6@gmail.com>
Date: Thu, 7 May 2026 14:03:52 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: add caveat about turning off commit-graph
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
References: <caveat_commit-graph.671@msgid.xyz>
 <5f9f4998-4538-4bc1-a245-4248e18c4e86@gmail.com>
 <3f0e03e4-f1ca-4010-aacf-72b3ce0aebd1@app.fastmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <3f0e03e4-f1ca-4010-aacf-72b3ce0aebd1@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/7/2026 10:30 AM, Kristoffer Haugsbakk wrote:
> On Wed, May 6, 2026, at 15:59, Derrick Stolee wrote:
>>> [snip]
>>>
>>> But this isn’t mentioned in the user-facing doc. Let’s mention it on
>>> git-replace(1) and git-commit-graph(1).
>>
>> I like your initiative to present this incompatibility in the
>> user-facing docs.
>>
>>> +CAVEATS
>>> +-------
>>> +
>>> +The existence of replace objects or commit grafts turns off reading or
>>> +writing to the commit-graph. See linkgit:git-replace[1].
>>> +
>> This does seem a little weak. It doesn't really say how this will
>> impact the user. Perhaps we could add something about how performance
>> will likely degrade in this mode?
>>
>>   The existence of replace objects or commit grafts turns off reading or
>>   writing to the commit-graph, which can cause performance issues. See
>>   linkgit:git-replace[1].
> 
> Thanks, that’s good. But I think this addition makes sense only on
> git-replace(1). In this (example) git-commit-graph(1) case the whole doc
> already explains what the commit-graph is about.

That's fair. Thanks!
-Stolee

