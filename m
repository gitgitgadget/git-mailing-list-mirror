Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D6C2DA75A
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764271435; cv=none; b=uwAek+VUVomB3uJ9ZssmapnHZEM/lQ4UaUJfoLctjMr79X6YPO5aPWieeAh4eM60TgIlR/daAgy84t6vObelT9WvHfTwtJlknhbxpzx2fkuqjtgy38H3DA4WhAr/KrE0ySoSC8nUnmxMJ8ucshAXNmLT+Y3K+03pYpPAL9+xK7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764271435; c=relaxed/simple;
	bh=+wMn7bcyU2YvYJOhx/uRX06JH+vTuUjaA90/PD3zTG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmtACCdZqGhqymskNYBJeSjoZDUI5ZVkEDFYEIxBtrQC0DMgBkmAzoRw5fk6mJjzsYEsvqWeQ0Jrrhoq0DhmOZgtiru9TLKpCoorQsEHBhFukat/zjDXyda48vCVfqmH53UDVhEURYi061V2vf1Ewr6FkWxAXKiOVIm4o9y0cnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4Cn+HDN; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4Cn+HDN"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-343ff854297so1455095a91.1
        for <git@vger.kernel.org>; Thu, 27 Nov 2025 11:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764271434; x=1764876234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kun3Y4KFa/m0bwXL3WJ/Ue30xWhozIqEHNJUd3QFwDI=;
        b=X4Cn+HDNVPKdZM9DyZf+4c5MLBw+i+iOFIDeq4EIdcqPIZSaF5izUYdWHuIzF23E1W
         T5Y9r3/d4aGBCCFyqkdwpYD2QvD253eiyF4YCZgoQg4vjgEThNXXYAoMXe49VgWIXx2q
         FUMAATzFES8Yw4zsZiRqgB2+EHI/+eT4xFTzqbHT90vLLygvjgJyf5/i7iQlCUrvu7BW
         vg6jmEAPOE3EXCeHSlSnJ4w0TYsTtPWjryp7KHy7un6kQK52sQvshbkJReo/4nO2D2KI
         QI4e34IOynGkMAVCD2AEnCMSJZYdKaQcHz214uSrKGKV5zvyzep4Cvb0RVfJGUKer9+G
         byuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764271434; x=1764876234;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kun3Y4KFa/m0bwXL3WJ/Ue30xWhozIqEHNJUd3QFwDI=;
        b=Hz5eiLTrfHoYC7cnxQ4ayBFkiVGR4tmgLcNqp+Mb+qgA+E/VQ8XBfiFW1OU8tVd4SC
         7fs68JdZNz7UzeKcOfQhctrmwhULKh2MA9oSHVbmZJrAp3ujSFtB6al3MTjL00uCrzU+
         9S1SuRy8t5nbws7lMAGr0It0K7YSVjpwBguYC5aHMxzahz6HDjy49yZjr4ik+3vBjZ9C
         9QgG2zFC7l9IhJuzCwR/d9HvTNqBgh46CCnaKxn/kpk7LiOXSlMMAhe9krN+2YncpGA2
         oO1Y8UnNQ53gTWGrAWwRy1+575celvZRGfoZN5yC0iXN/qcSpped/BBAI07He0qNoXUF
         Eang==
X-Gm-Message-State: AOJu0YxTwhrSFYEZwAuo70mMwp/AhI09qG+U06Lq5hZYSqAdEoFqTYBf
	zaMgis/0+7AmuqudZhD2ixFpSUpfePVske+PnczY98dv/+n386/xn+ut
X-Gm-Gg: ASbGncuf0i36ewULAYaXn6q167EPE/9uQta2H4CmANib/4QbgZRSCnxxG/GCBL3QLiq
	vMg/j5z+GP7lyGPTUy/HRtTJ7mwbtq2+jB2FDZzMREaNTtHATY52NBlxknK/0/JGtuood9N0bPv
	Cxf/7Kk+SQoKEeYR9SvVnLe/Y+VJpvKzvKJuojLAV+zw7hj2aKccVCfwR79IvAZ3mBMzI+ybzt9
	xZakO2Q8gJxKKhQHMmFqFGodpwzJNH63XNraVOhojnLTUIAxJaEU+gEf9WlBImKVakh+HKJZ7Vp
	HRObU+KcYxenP1L2TxoYL3ypTF7Wu1Wbw9wKNsZAgIdsYv5TQRvpAYexASrjV/nKgfPuMowRdh2
	oty+l0htLOKmvGa4PAf2/63pHhJ9e2HZZMne6u9lVmCJkyKOhXQJT5wZcuxb14gentaBlyP+h8m
	Y96/vV7JUGZVsgLafFwsbXTcQ9rMzPldlkqzCBnsE3vYNW9gIa2P/EEzMur58kvax669BlBj+ul
	GJpzwm4aV5Z5GdPJJJHK/DKbwGAlWHjyQ==
X-Google-Smtp-Source: AGHT+IHisuxDjl6iurUPPZzbQP/sW7M0UVuV3sm8R384xA8DhFhgPxSEcctG7I2mbnOQuuRqkAlDxg==
X-Received: by 2002:a17:90b:5105:b0:335:2eef:4ca8 with SMTP id 98e67ed59e1d1-34733f4f4d2mr23848901a91.33.1764271433733;
        Thu, 27 Nov 2025 11:23:53 -0800 (PST)
Received: from ?IPV6:2409:40e3:30a4:b776:a4fb:44b4:6c24:a31a? ([2409:40e3:30a4:b776:a4fb:44b4:6c24:a31a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a7c3f1asm6508350a91.16.2025.11.27.11.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 11:23:53 -0800 (PST)
Message-ID: <78e31e24-5eab-44d8-a7e0-d3efae6ca6cf@gmail.com>
Date: Fri, 28 Nov 2025 00:53:46 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] replay: add --revert option to reverse commit changes
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im,
 newren@gmail.com, phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk,
 karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251125170056.34489-2-siddharthasthana31@gmail.com>
 <xmqqwm3drk6m.fsf@gitster.g> <706e2875-a3f9-447f-9f43-690990a2342d@gmail.com>
 <xmqq8qfsmraa.fsf@gitster.g>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqq8qfsmraa.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 27/11/25 02:43, Junio C Hamano wrote:
> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>
>>>> +This creates new commits on top of 'main' that reverse the changes introduced
>>>> +by the last three commits on 'feature'. The 'feature' branch is updated to
>>>> +point at the last of these revert commits. The 'main' branch is not updated
>>>> +in this case.
>>> Is there any topological requirement between 'main' and 'feature'
>>> branches?
>> Yes, and I failed to explain this. For reverts to produce meaningful
>> non-empty commits, the commits being reverted should already be in the
>> target branch's history. I will clarify the examples to show this
>> topology requirement explicitly.
> We need to be a bit careful, though.  Strictly speaking, what we
> have is not a requirement on the shape of the history.


Right - it's the changes that need to exist in the target tree, not the 
commits themselves. Cherry-picked commits can be reverted even without 
topological ancestry. I will fix the documentation.


>    If a topic
> that was merged to the development branch gets cherry-picked to the
> master branch, and then it turns out to be faulty and needs to be
> reverted, we can still "revert" the original topic out of the master
> branch, even though topologically, the original topic is *not* in
> 'master'.
>
>>>> +		/* For revert: swap base and pickme to reverse the diff */
>>>> +		merge_opt->branch1 = short_commit_name(repo, replayed_base);
>>>> +		merge_opt->branch2 = xstrfmt("parent of %s", short_commit_name(repo, pickme));
>>> That is an overly long line (sorry, I notice these things when a
>>> line does not even fit in 92-col terminal).
>>
>> Fixed in my local tree by introducing a `pickme_name` variable.
> Just a line-folding at an appropriate column may be sufficient, e.g.,


Will do.


>
> 		merge_opt->branch2 = xstrfmt("parent of %s",
> 					short_commit_name(repo, pickme));
>
>>>> -	free((char*)merge_opt->ancestor);
>>>>    	merge_opt->ancestor = NULL;
>>>> +	merge_opt->branch2 = NULL;
>>> Not a new problem, but what is the point of setting these two (but
>>> not branch1) to NULL?
>>
>> You're right, this is inconsistent. The intent is to prevent
>> use-after-free, but setting only some fields to NULL is incomplete. I
>> will either set all three to NULL or add a comment explaining the rationale.
> Is this the only place that resets a subset of merge_opt members for
> reuse?  If not, are these multiple places want to reset the same
> subset of the members?  Perhaps we can use a helper function to
> clarify in such a case.


This is the only place in replay.c. The reason we only NULL ancestor and 
branch2 is that those are the ones allocated with xstrfmt() - branch1 
points to short_commit_name() which doesn't need freeing.

A helper would make the intent clearer. I will look into adding one.

Thanks,
Siddharth


