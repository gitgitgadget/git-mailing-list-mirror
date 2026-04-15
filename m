Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A2C3264D4
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245798; cv=none; b=dOMxoNRaRnPBUr19Ke1Hx34pjqNPmAJp8zmk4zbfGOi/JAYKksjbSBZgCVgU1cHtPdfbL9rhTZTjNmisVn0lM4cwlACbxO/RJ5ef33IiFg6xYCVlBXn45qN7Z4AUbMYwkD7e+D7WE6bW8cAT69Nloj10nzqFp20KE7GpfCoTOro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245798; c=relaxed/simple;
	bh=Lj0fWZSwfWUCTUR12wpck8HiUdugCqe18ISTpEwaa2Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uBT8m+H2zgxzfcWqK/PizNIKzjMvOK4+aEV/hR1WL/Un2rv0j+m5w+MK4HM5FG4JuAKPqYzsfXfUFOkKHbQHa1+I85axugnE1qvx8zmMExQUEU3ITDDPrZVA/PmXhEM7owFKysHqW5+gAw8woiONU0pVG9AVQ/UI47kpvKxU+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9sXLAN2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9sXLAN2"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b00ed86fso67531625e9.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 02:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776245796; x=1776850596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T2w4TTKKmGrDv7JsuIm1nEJsnJXizn4cjguzdxcNKqY=;
        b=e9sXLAN2QpuSy7XjRbIWO96jf9Kh9kPsZN0C3G4YKnZ26lFUu8FgEQjLygWr2us+Sx
         N2uWy4BeP1d7NDHoRZmhASj+JPJrIdXOOeqQuttTxeMlb0v2B2PbABHd0lWLvguYpp5R
         GAgv/aA3vR7pB80go59ZXsFw9vXdvZzpEXjH51o4EclKfexSMS9NsOBi0g/vf6hSM5Mc
         rL5MkJxqnmftn7rAnQnVX/qnsavl566lO9CpiL3NoX7s2HGSjE+XBP55ydmL3/cIzL1W
         fXrad1pN8DT0I7vAZpjbJvaTgfDYlNMk5FJC1W4mY+ksIOQhQjmqetyzUHitkHp5QcjJ
         xcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776245796; x=1776850596;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2w4TTKKmGrDv7JsuIm1nEJsnJXizn4cjguzdxcNKqY=;
        b=B5sy5npRUM/msT3EenmFqDKaRZAmlOTIc+SXNi4BecjNDMLSleHmLRtVjKxekJkYvZ
         VKgbx8X+YnlKuhdcsDet4MEDP/NoKAJwlWiFmV8GiWmCKQDIccHX4HM+kFd0bfKyiCQR
         iOMdK857yd+SJ4c9zzMz+0IOogJO8D9YcLyW8sozAC3/ZqZT7rMqWbGLNx5uyOdPVotm
         t8fJOBpclVWgyculctKbHA1vW8Wej9wkrwVFvQmypivREIVHi1qqMSHiiZFtFOeoiZf4
         DoPhpRT2gr9BTSs7tRHgzE43ER7c8AWooLmA6BlCa4TbFcymoSKQ/qYUxp8i9KzE8ihX
         OBlQ==
X-Forwarded-Encrypted: i=1; AFNElJ94c/XrVcp88Cr72wKdGHMTDt31blJhqrah8MAq6OAi+5cfRRZ5xhGztQRWwQaBciTCDzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJKLJnKzDlgI39eU7dZqIowVXjak5vjtYWFHN4HUT8knqxprQB
	lHsJtzV+2MC9PVS8U260o49MuYlt2j+5bQPUx8XWCZLUaxb38hm3fUXN3oU1oA==
X-Gm-Gg: AeBDievcqe8RqGmbW8tBzJrwRp8sUxPQc5w8mVT+l7gOzVBYSYkG+kLutf+mUvJ+qe7
	SEYNFP4pezPur0LtnME7iZV6vDjFtfPeIyRnTrYwBRdg9VJv+c/MrKvWkh0BnYbZ6ktk8jQhCMU
	y7aT+vNayaZRUGGc/xwwLpuHkL6yimXeitIM40Uz4dlELc+tsaOztWR0quopt3WnmDBdFzBOM2h
	E0mnishQPLp75E5uvW0vVj8H3CHW2Y4GnDTeqi+OOIFB7z0QjZ86+4VeUVXy/5wD1kpSoHtozUQ
	PmMe99tnOVyV/P7QViBOJh3ENx7rSHlYChLMuKeyI8Hv/0p5eCmdyRWaQmjQvgo/jwXAB7zbsPb
	yhtSNOXAToLIc0wGbKvocrQ2nsIF4pEXtlU6A+ANRz9Y4wC1AtSdm7K8FVNn6jKsuaAGkFXjDIZ
	K6rZRBAn2lBPRfDqT4S/GDFR1ljwVLlPAlBPfexhp+WT9JiG0wqqwHCZSs8XG9nebzygMVQV9Fk
	g8=
X-Received: by 2002:a05:600c:198c:b0:485:3fd1:9936 with SMTP id 5b1f17b1804b1-488d67b8d43mr288881645e9.5.1776245795894;
        Wed, 15 Apr 2026 02:36:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f1dd899esm36471235e9.1.2026.04.15.02.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 02:36:35 -0700 (PDT)
Message-ID: <21c205c6-687f-41b4-9f43-22e6ea6928b3@gmail.com>
Date: Wed, 15 Apr 2026 10:36:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com,
 peff@peff.net, phillip.wood@dunelm.org.uk
References: <f012cc7e-14fa-40d2-84dc-7407fdceb36d@gmail.com>
 <20260415081659.86783-1-haraldnordgren@gmail.com>
Content-Language: en-US
In-Reply-To: <20260415081659.86783-1-haraldnordgren@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/04/2026 09:16, Harald Nordgren wrote:
>>> +	if (old_branch_info.name)
>>> +		stash_label_base = old_branch_info.name;
>>> +	else if (old_branch_info.commit) {
>>> +		strbuf_add_unique_abbrev(&old_commit_shortname,
>>> +					 &old_branch_info.commit->object.oid,
>>> +					 DEFAULT_ABBREV);
>>> +		stash_label_base = old_commit_shortname.buf;
>>> +	}
>>> +
>>>    	if (do_merge) {
>>>    		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
>>> +		if (ret && opts->merge) {
>>
>> As we saw above merge_working_tree() can return non-zero for a variety
>> of reasons. We only want to try stashing if the call to unpack_trees()
>> failed. Even then if you look at the list of errors in unpack-trees.h
>> you'll see that only a few of them relate to problems that can be solved
>> by stashing. The old code just tried merging whenever unpack_trees()
>> failed so it probably not so bad to do the same here but we should not
>> be stashing if merge_working_tree() returns before calling unpack_trees().
> 
> What you are saying makes a lot of sense.
> 
> I gave this a shot now, trying to return an error code that only attempts
> the stashing when it has a chance of improving the outcome. Not at all sure
> if it's correct though!

That sounds like the right approach

>>> +						   autostash_msg.buf);
>>> +			created_autostash = 1;
>>> +			ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
>>> +		}
>>>    		if (ret) {
>>
>> I'm confused by this - if we stash then don't we expect the call to
>> unpack_trees() in merge_working_tree() to succeed and therefore return
>> 0? If opts->merge is false then we should not be trying to apply the
>> stash when merge_working_tree() fails.
> 
> I'm attempting to fix this by making call to apply_autostash_ref
> conditional on whether or not the autostash was actually created. Makes
> sense?

Yes, exactly

Thanks

Phillip

