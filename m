Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5A618E06
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707908558; cv=none; b=f2OHAN2xmtQvz2WLjNnv5XgpNYEFHryJvWf7m0xaiAvQYsVxqY1LCgsKUpDG9W77a6MmlI6S7W1OMnqqhC8HPHwoUgM5Bh/rsE8qtUM26en1DJ9vI587iF7DJBdAJEOVtEn1UYevPSr1doiIKHZf0Wib6kiYbOy8oGEPX3V46FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707908558; c=relaxed/simple;
	bh=Q4MvUBSfgK3eXQJ+sofz6JXMDy/ERtzlRgIpf9tZ5x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lb6/8X3CtepHqoKN+vimXnTx8Wuz4X51dAvZmpT5I8sR0l9rtGaWTTgwesq5Jo16ZFX4szVYzeYogrz42U35A3aIeDQWqQgc/yVq6SSGM7xWSxuWze/kS28oAByIlXIY8NzmSGT5ttJc1HJ7zvL+6mrKk1D87PeX4pC8sQ9FlEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNPAcR2C; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNPAcR2C"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-411a5b8765bso3701675e9.1
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 03:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707908555; x=1708513355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8jaUzM2qMQt1by7QwE9vCJz1MD8M/KvDC3lplIHCVkc=;
        b=LNPAcR2CUbXzMjNJqiHrYHbyjg62nEgCmxaXrKMAt+nn/CyI4LOWJuu5DALvSfKztM
         Ul2uTPTZnVd6DToUrXpL5OfkJEOzYaPGIOD+xy6hpF+VWct0cJmTCn/YwMhvHIL/QzmC
         02CHWh4A0ENO1r8Coji6hGgb1SQeR1Mb7qZT/aBMRxdZIEy0gnPVr9B3pZASvE0wVmyE
         T+3DEjrNKtnrFDJCUuH86Cl5aH96ED0rstIHwbtmsERDkpuUeJUJxXj1Nalv5LvkT5E5
         x3e0n/pMP0HOa9AuhrbZjNvXkM+RRQiKWLEW6O0iz/5nmGSW90GtmG2Lf8OvDNneBvSE
         QEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707908555; x=1708513355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jaUzM2qMQt1by7QwE9vCJz1MD8M/KvDC3lplIHCVkc=;
        b=NkacDTsIU8bTdiOI0ozW9xlv0Yig3v0nhi7r2NcB48l8VT84ztoRwn8ireTlBla/qq
         aEqGeOD47ODIHaZ3TzHWwN5h+yhd1U19D3REhAnzE6x31g+uUHb7R0OQnoWIMLLQvO3Q
         oLbXjGYjCGlZRSuTe/ZYz4xBKyrfPxeGydR9IdUy/y0Wsu7wmVqRAg4zZ2ci4uROigU2
         F4iQ9coZUW40EscBYbfMEkjIILaAtyBwaCD/pS2VU9yuyLAbBIglhCwmnQrWSV76nFVd
         KWfaYWrhPbK+HEIWncrcjjBLQCKqfmKJnjKBE2D2HTV+Uy1/Yb+gSsolQcLJfLenDnN/
         fJBA==
X-Forwarded-Encrypted: i=1; AJvYcCU9AeFZCGZh4e8Ugappr61utKP7ET1STNoxovzA0U0mfMWAWfN9InpelybF4CXPvjfRClinRncROKD+/6O9cEgEqI65
X-Gm-Message-State: AOJu0YxLeHnwA6gfnx0xZbm0sBTgFBhFON3bZVlV1Ox+PFj66VdoreRC
	OadtXTAV+RbPp924KHZl/qYsJvd9VRxzctt+pGD8D/ugDuMMloPW
X-Google-Smtp-Source: AGHT+IHoUSo5UzZKr0fHhWFsduirW6j4OBJIjvpmtKUyqereL5Idwdts4hm41G/z+VuWkLpEeCqozQ==
X-Received: by 2002:a05:600c:35c1:b0:410:99ee:d65a with SMTP id r1-20020a05600c35c100b0041099eed65amr1250468wmq.20.1707908555120;
        Wed, 14 Feb 2024 03:02:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWAGkOHFUZOCDnIZZhaK2thkPwxzatUEbHwrZV2m/3H4iCbRDKs5Us9jfVHPdUAEaPxcWaB5hQ5pPzX54ryX/FG3QISkdlsUmLuIocl+aMcDCGeuj7E/7OifZDxSBDuMi92bSqBHsTkkMg/0j37nydrdLw6r+2bEWfWqWhR6ceGd6vMJkxvooUz/cK3Z79N2WSoAfNB7WjnkUwu5RDSiukCcuKha/oJ7pn0RoqANr0QOrWwIg4L+k+8iVMidquKCJc=
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id h14-20020a05600c314e00b00411ee1dd5afsm1196183wmo.16.2024.02.14.03.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 03:02:34 -0800 (PST)
Message-ID: <568f9c07-0b2c-4d4f-9d35-aeeb6e1e29c4@gmail.com>
Date: Wed, 14 Feb 2024 11:02:35 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] revision: implement `git log --merge` also for
 rebase/cherry-pick/revert
Content-Language: en-US
To: Philippe Blain <levraiphilippeblain@gmail.com>,
 phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
 Michael Lohmann <mial.lohmann@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Michael Lohmann <mi.al.lohmann@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-0-3bc9e62808f4@gmail.com>
 <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-2-3bc9e62808f4@gmail.com>
 <c5d60b5b-3181-4bb7-a7f8-eb97474526d7@gmail.com>
 <790a3f11-5a8c-42f2-7a35-f2900c0299b4@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <790a3f11-5a8c-42f2-7a35-f2900c0299b4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Philippe

On 13/02/2024 13:27, Philippe Blain wrote:
> Le 2024-02-12 à 06:02, Phillip Wood a écrit :
>> Hi Philippe
>> On 10/02/2024 23:35, Philippe Blain wrote:
>>> From: Michael Lohmann <mi.al.lohmann@gmail.com>
>>> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
>>> index 2bf239ff03..5b4672c346 100644
>>> --- a/Documentation/rev-list-options.txt
>>> +++ b/Documentation/rev-list-options.txt
>>> @@ -341,8 +341,10 @@ See also linkgit:git-reflog[1].
>>>    Under `--pretty=reference`, this information will not be shown at all.
>>>      --merge::
>>> -    After a failed merge, show refs that touch files having a
>>> -    conflict and don't exist on all heads to merge.
>>> +    Show commits touching conflicted paths in the range `HEAD...$OTHER`,
>>> +    where `$OTHER` is the first existing pseudoref in `MERGE_HEAD`,
>>> +    `CHERRY_PICK_HEAD`, `REVERT_HEAD` or `REBASE_HEAD`. Only works
>>> +    when the index has unmerged entries.
>>
>> Do you know what "and don't exist on all heads to merge" in the original 
> is referring to? The new text doesn't mention anything that sounds like 
>that but I don't understand what the original was trying to say.
> 
> Yes, it took me a while to understand what that meant. I think it is simply
> describing the range of commits shown. If we substitute "refs" for "commits"
> and switch the order of the sentence, it reads:
> 
>      After a failed merge, show commits that don't exist on all heads to merge
>      and that touch files having a conflict.
> 
> So it's just describing (a bit awkwardly) the HEAD...MERGE_HEAD range.

Ah, that makes sense, thanks for explaining


>>> +    for (i = 0; i < ARRAY_SIZE(other_head); i++)
>>> +        if (!read_ref_full(other_head[i],
>>> +                RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>>> +                oid, NULL)) {
>>> +            if (is_null_oid(oid))
>>> +                die("%s is a symbolic ref???", other_head[i]);
>>
>> This would benefit from being translated and I think one '?' would suffice 
>> (I'm not sure we even need that - are there other possible causes of a null 
>> oid here?)
> 
> This bit was suggested by Junio upthread in <xmqqzfxa9usx.fsf@gitster.g>.
> I'm not sure if the are other causes of null oid, as I don't know well this
> part of the code.
> I agree that a single '?' would be enough, but I'm not sure about marking
> this for translation, I think maybe this situation would be best handled with
> BUG() ?

I think it would be a bug for git to create MERGE_HEAD as a symbolic ref 
but when we read MERGE_HEAD and find it is a symbolic ref we don't know 
if git created it or some third-party script so I think we should just 
report an error.

Best Wishes

Phillip

