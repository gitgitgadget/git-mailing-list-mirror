Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428AD47D93E
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244193; cv=none; b=kcSqvrHBn42RHhMzQzrpFRYebOhfYQIzaZ4qNSYgdc0W1zmBp1ykyCgmHC5YlMS+jB2NgH5CaSeMpIR5H7JlQGCDzbQ13QyxA7ZtTSgOEsw/2PXNxd0/Jr41Mx2ggxPfWPHMzMhAqtn8pe5eLRo4Soq+t/gVrD7bKpCf8ucUCxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244193; c=relaxed/simple;
	bh=oynOYrqMF0yK+mkHLBGO3X8LYNzhJujne0eCYFJr/GM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0uFu0cPRrZeT7qy7xeSVm+C3C23voOuC2Nu+Hv0j71S0/O8Jjp5q7uRrrT/4Ro2WTvb0rCZbTEs3uGFkP9PEp9+ReDxOLsLrK2H6wmgHhpds3jycT3s5/Fj5VtEan/5mvXFclHDbovs4vOzBybaR93QxItb4dnJRH3CjClnofI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=antmicro.com; spf=pass smtp.mailfrom=antmicro.com; dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b=Byxn0zbc; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=antmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="Byxn0zbc"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c169ae1cb26so241985766b.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 09:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google; t=1787244189; x=1787848989; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mL6RX2ugJ297XOxTfXKE+Tn/qDnkTlC585SoCGIKSRY=;
        b=Byxn0zbcc7NhoECNcZaD4/QfrycaawwUK4gtgzbyYCEjqrjlGvTaufhX4v0D03EjWI
         MvD83zHQB1yxAeg/YYwKz0i/O8BEnki1rWuGSgKntX/wR+OMJUMYwg+2WZSrYzFN7EQZ
         lwqj+1/vU9fGzxIHUfbwsJdCsDiLSlGLLBduU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787244189; x=1787848989;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mL6RX2ugJ297XOxTfXKE+Tn/qDnkTlC585SoCGIKSRY=;
        b=KmgVKLun8cWpVCIdWtC7gXUzbyirPEK/rHLaRPaycUp01cEXME18WF2E/CsSXKabpZ
         v68RHGOIQjHCQubA1o+lo1m+woSkdWh2XmN0sYz94FyrN1n8KL3EZBd8tj2xo7peQMpL
         neaNWhoIknfCw2IJko0ZRwo1r5yKDPUmsIPO+AyJhjvbml1PHIsAgagD63iVfllSyHHT
         ExfLSPalwO1+V6UooWcUO7hy/cBUg6lXJRJz5uvmVzhhDPXYXnDKrmY0suRzLm1B70D5
         kIjEZ5ttJL91ibf6e0UcTXaSYr8mVBOp31XEDhB7eEUeV8tDpoJ37L5FjB6vLyYvNZDa
         QmZQ==
X-Forwarded-Encrypted: i=1; AHgh+RpbmYNLizUA7Xr/BrnRPXPdzcwGxo8cSPJDBE2qtJFh45bzGBUQ8fn2ZS8RZ+bMHYaqPGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo8DAuyuBQyrDjKJEZMPkTZYZyIHO00SNWxno177szKN6nJhgO
	9MIGASMs/o/LepRKW8hDsWEx8k5Ti9qp2Ra90HpNfV9UK9PIdCBG952WMaM/BIlhgoI=
X-Gm-Gg: AR+sD10sXC/3U9eRlqDMM/y7GZyyax+tJWUDeUFZVlWDpxElnAppF8LCLPC1dVQAc6c
	No1gd9MP9PUDVu/lEDBxX7bSyzR4JEuVawcjRPe+RAdHC7tNUurZSSfAKPuG7AvtU76xcaKsuq5
	WG2ztMYfaZqW36Rt40t9DO/whs+NCmx7Rt1AIln9rknsA+a3bw1OKBL/fQ0XIrdlg884QQikQJf
	orSg/pwj/ENWICkS9VzccJUJupZr95gfm4W6fdu3w9/0KKB2VGGGohR2LlpRV6CdiF3RVMU20XW
	5O72DtG0d+W+K0BFqX6xsB2puSrG5lx01bVV1Ji/+xN85o8jmXB8qs6HJU3zvk1gXruhO6Ea504
	2R8AbFrLFMQDAq8nW/mrtCTkFbCEql0fssdyK0+lhcrTSjeZ/Zm030PbCnDFHByWF7wZVR/Ac0Q
	dDDRygH8rMru8u438O6xRv4/nGHjP6gSy2GIYueb1NBgeOfoA+1PseVk+OTi+bzAfvSsAmjRYT/
	Io=
X-Received: by 2002:a17:907:7ba6:b0:c21:42af:4cb with SMTP id a640c23a62f3a-c244d63f5c8mr544906966b.6.1787244189401;
        Thu, 20 Aug 2026 09:43:09 -0700 (PDT)
Received: from [10.10.8.17] ([213.17.234.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24589d9df9sm99538166b.1.2026.08.20.09.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 09:43:08 -0700 (PDT)
Message-ID: <2b9cc581-7c8e-4cb3-9524-2b466209ac7e@antmicro.com>
Date: Thu, 20 Aug 2026 18:43:08 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pull: add --hard mode
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: Artur Bieniek via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Artur Bieniek <ar2rekb@gmail.com>
References: <pull.2384.git.git.1787052873141.gitgitgadget@gmail.com>
 <xmqqwltn1o4e.fsf@gitster.g> <0c2607e2-16da-4efd-879f-82ef2c2aa127@gmail.com>
 <xmqqo6ewsrzd.fsf@gitster.g>
Content-Language: en-US
From: Artur Bieniek <abieniek@antmicro.com>
In-Reply-To: <xmqqo6ewsrzd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

One case where --ff-only does not seem to cover that audience is when 
the upstream branch itself is rewritten.

For example, a checkout may contain no local development at all and only 
be used to track the latest state of an upstream branch, but if that 
branch is rebased or otherwise force-updated, git pull --ff-only will 
refuse to update it because the histories have diverged.

That seems like a reasonably natural use case for the behavior Phillip 
described: git pull --reset on a clean working tree would mean "make 
this checkout match the fetched upstream", while still refusing by 
default to discard uncommitted changes.

I also like that distinction better than my original --hard proposal, 
since the destructive working-tree behavior would no longer be implicit 
in the primary option.

Thanks,
Artur

On 8/20/26 5:59 PM, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I think if the design was slightly different so that it errored out by
>> default if there were uncommitted changes then that would make it worth
>> while as it is safer than "git fetch; git reset --hard @{u}" and would
>> allow the user to carry over those changes with "--autostash". So to me
>> something like
>>
>> 	git pull --reset [--discard-changes | --autostash]
>>
>> would be a more convincing design.
>> ...
>> If it refused to reset by default when there were uncommitted changes
>> would that be safe enough? Uncommitted changes would be protected and
>> any local commits that become unreachable after the reset can still be
>> retrieved from the reflog. It's not quite the same as integrating remote
>> and local changes, but more like updating the working copy.
> 
> Yup, but git pull --ff-only serves the "No development is done in
> this repository; it is merely to keep the latest sources here"
> audience just fine.
> 
> What you are suggesting may be *useful* for those who agree with
> this statement:
> 
>      I do value my local changes because I haven't committed them,
>      but I am willing to discard these changes and replace them with
>      whatever the upstream did.
> 
> but I am not sure of the use case for a repository/working tree
> that is managed in such a way.

