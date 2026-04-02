Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D1A2DCC04
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775152142; cv=none; b=J6YXOo/anuhpE9TVKtCOxDj2fW1BKcYBaVe5BXr+fomsJshsE1Kwdw1fz/MrVnCEKempI84zFLoqAQdJObZNhBDVUgXpkJKYyeg3akyhyq8f9AGfT8WyBcWI2j5d3tqgWV7NRXaiPHK/yb0PhOWUDIGVn1wTYSXlk8CUY005IKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775152142; c=relaxed/simple;
	bh=jfjMH2AF/6B2VaTMkgTRUQyuzjozos7prDLKkAhPwnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hARUbOP2wvpu6viWZzB739PVgGpUvQZM1yrDi2LTb+lYvybQut9OQMbjKcCYEuzPFSgoG3lrWKBls2AfL57IBBIm7LVGe3OYz/WRjoY6NPOQ+miI5sw4ZtA611gXAd65Mr5ib2VMIiUo/r8n9cHyXztgnAmEA0k+Xg4WYrdCeVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dbb2DSV8; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dbb2DSV8"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3597822d6d8so95329a91.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 10:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775152141; x=1775756941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sSZI+o63dKJnq8abP3sRq5W4C3Vp+7LdzoZK2ve9kQE=;
        b=Dbb2DSV8mm8Fy6Tv09EhPm/WDZeXIrDKSjnHTEnZFeReIdUeKaSopzTq8ctDMEhslH
         W90JQvknAgVqaCpPM9FlO18eI6Os+gwrN85qj9efvUsL1NYiz6QaR8qEdLZ5Wim0u9cO
         5cYvQjDPnsxQxGuRN8/x3A0h1E+KvnCGzu8LjPQLX/9EyqX1I4zk5QCqEzlU/OzdtM2w
         o5rbAV69J5dpN/a3ItsT97gNHWtSO8H+t8eWXQI+ExnPAcfR9OutHIfaZp35rd0lM/OB
         x73ihvNZE+cdBbasFGUf0d1ofcLs/fXgstMp0IKIbmPn1orUUKBAWaVB4Dc/QxYGxJJU
         HKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775152141; x=1775756941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSZI+o63dKJnq8abP3sRq5W4C3Vp+7LdzoZK2ve9kQE=;
        b=TP9S3Mt5w2ikA1TMNM0cHwVo/AKC3IWcEBIguXNeCjzDFUbJmDAZp8HQ6NtITpbJL5
         IkjWBJJqRoNi/OpyGz0B6VFyjpyRSYZEO9gSUuoHBExCHrlwLv4q/oSpy17KH6fCsVTA
         rjPkTeBIl8FnsJXsz9rC2vcumZ1QvvODAn4YkTwXt/LxB/6zt3LhsojB2ZReL+psP4SQ
         IHfJ+6jxlpJMmMkG31fX7GIjuqdkLr63DoDNX6tSgY+d1osC6yR+iZeY7z20yJMtVe5D
         2R9CTDjT5IkCJOBdUzIf+9MmrM6lSt6/28/qqN91RCqeSXDe3+cUVfFTY3bRBOx1cfjf
         pncA==
X-Forwarded-Encrypted: i=1; AJvYcCXOMDof6ubKmKg997yw5g9rAuXcwWKfhvuvc/1xiEG1cXYCBcWycPPegwl14tJGqrqUHZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC7jdmixbFpA8rxwHtcpmANyilnRwFda/Fj/+ecIGm5WRJjKGI
	tjxzpO28lm20JvXeIH+GGy0lm/MkPz+d/cv8QZrHi6dfl7c5CzXuHfM4
X-Gm-Gg: AeBDievI3LgeJ0CkWq1laj+Sc3773StN0NN1pz4cQAmChbniIIh6PhEe74WgiVIhtNh
	NTKiajtlbkWeLtQskrR4zIQ5BIwC1B00OyjsnnHo8WImTndgibmzHjK412WlQU6lfcYoaqRZ/JM
	hZF1Fwz5sd5FLRGHnPhhlruSoMkpGPmnF0FFt7iOIqh1ohKIbT/kZOOZp7j/x8B/Vv3M8z16RYe
	FoIpj/W9VJZ935fLphdPVAKPjqB49UvJcckNi7urx7nrBV4s0U7Ey69LoszQcGcPjtg83rsl85w
	pysvSRNyeIBRBIMX6mHoi7p3LvmGH1F0+fg7Lw1RoqNkJtCm9fsQy6xmRwl7P6lh1f+rcxSPxzZ
	jNuEN9ejvBE3sdbHzJP7FHALIMKoXcRtEtCMNfn3SsZz2PBmKdArnwsEHEaWhtNF2AJZQGXVuGO
	9lsExUBPATOKVDVhiH58zzSSFdPjDbsjqOYnjamuDasReEWtdOEHlqLrTuFsPd4HBGf46I0GFK6
	01ptDs0WMU=
X-Received: by 2002:a17:90b:2247:b0:35b:ed51:afac with SMTP id 98e67ed59e1d1-35dc6fd4056mr5272602a91.6.1775152140821;
        Thu, 02 Apr 2026 10:49:00 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe977031sm8604268a91.17.2026.04.02.10.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 10:49:00 -0700 (PDT)
Message-ID: <7d8ec377-0555-48d8-b016-6794329932a1@gmail.com>
Date: Fri, 3 Apr 2026 01:48:56 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] refs: add struct repository parameter to
 branchname helpers
Content-Language: en-US
To: =?UTF-8?Q?Burak_Kaan_Kara=C3=A7ay?= <bkkaracay@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org,
 Jeff King <peff@peff.net>
References: <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260329101725.1092900-2-shreyanshpaliwalcmsmn@gmail.com>
 <ac4aZRveWXjOtxgB@pks.im> <ac6K5UnVdw67Rfpy@gmail.com>
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <ac6K5UnVdw67Rfpy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/3/26 01:03, Burak Kaan Karaçay wrote:
> Hi,
> 
> On Thu, Apr 02, 2026 at 09:27:33AM +0200, Patrick Steinhardt wrote:
>> On Sun, Mar 29, 2026 at 03:46:39PM +0530, Shreyansh Paliwal wrote:
>>> diff --git a/refs.c b/refs.c
>>> index 685a0c247b..5cdc8858c5 100644
>>> --- a/refs.c
>>> +++ b/refs.c
>>> @@ -758,10 +758,10 @@ void copy_branchname(struct strbuf *sb, const 
>>> char *name,
>>>      strbuf_add(sb, name + used, len - used);
>>>  }
>>>
>>> -int check_branch_ref(struct strbuf *sb, const char *name)
>>> +int check_branch_ref(struct repository *repo, struct strbuf *sb, 
>>> const char *name)
>>>  {
>>>      if (startup_info->have_repository)
>>> -        copy_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
>>> +        copy_branchname(repo, sb, name, INTERPRET_BRANCH_LOCAL);
>>>      else
>>>          strbuf_addstr(sb, name);
>>>
>>
>> I have to agree with Tian's comment on v2, this part here looks wrong. I
>> don't think we should depend on `startup_info` here, but we should
>> exclusively rely on whether or not the caller has passed in a
>> repository. And that will likely require a bit more scrutiny to figure
>> out whether there are any callers that shouldn't pass in a repository
>> because it's not initialized.
>>
>> Alternatively, we could go with Tian's suggestion of checking for `repo
>> && repo->gitdir`.
>>
>> Patrick
> 
> This approach actually leads to a bug and segfault in a specific edge
> case when running 'git check-ref-format'. The current tests don't cover
> this scenario, but they can be extended to catch it.
> 
> If GIT_DIR is set to a non-existent path,
> 'startup_info->have_repository' becomes '0' but 'repo->gitdir' still
> holds the invalid path. As a result, the code enters the first condition
> and crashes. The case can be tested with this command:
> 
> $ git --git-dir='non-existing' check-ref-format --branch @{-1}
> 
> Modifying the behavior of 'repo->gitdir' might solve the issue, but I
> belive that falls outside the scope of this patch. After a quick search,
> I found a prophecy from Peff about the 'startup_info->have_repository':
> 
> [1] https://lore.kernel.org/ 
> git/20190806124954.GA13649@sigill.intra.peff.net/
> 
> Thanks,
> Burak Kaan Karaçay

You’re absolutely right.

Actually, I’d already spotted the error when I wrote that bit of code, 
which is why I said 'I dunno' - simply to give an idea of what I was 
trying to achieve. It looks like we’ll have to go with a much uglier 
solution. ;)

One possible approach (albeit temporary and useless) is to wrap the code 
in a macro or an inline function (in repository.h, I guess?):

> static inline int repo_has_repository(struct repository *repo)
> {
> 	/*  
 >	* NEEDSWORK...
>	*/> 	if (repo == the_repository)
> 		return startup_info->have_repository;
> 
> 	return repo && repo->gitdir;
> }

This will remove a large amount of startup_info->have_repository...But 
that doesn’t solve anything, just as stuffing rubbish into a bin doesn’t 
change the fact that it’s rubbish. The 'startup_info->have_repository' 
still requires a significant amount of effort to refactor.

So still, I dunno.

Regards, Yuchen
