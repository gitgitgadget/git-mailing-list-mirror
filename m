Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F831340273
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772476590; cv=none; b=LefnB+KcN9yNfkLtZIU3sEBwlC8aPRKC79n3YjS1Onx0k+lMujzjK21+gsissGYGoVd8mZp9BOUb/0UJxxealurU2QFm+BxmjLsndaa+LKAy5xrOkFFmcHQH7dpnKDTiSg7hp9K4uHxSq8b+YJksNMKQmgfwNx1HPgWZA7QgLlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772476590; c=relaxed/simple;
	bh=xH6YjwLIJO2P577RvOun7u+ce/1lBwWf6GyVGQ8AErk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q78QwImBCDS1DUQIeZ2+qRK5ltX3AyJ0mNPQegsJqQr3vIO9bqllFFA4fFgOsNP65GUgjTQZhhgcqU7esMoVnDW19NRVgzanGXWRu7Y1yMk8PqkgHHot7HambRLLjPRLz8FjbmsgqEyYrUB9iqiJRAVn8EXxYsxuHUf+LeSgNsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6gSRvv5; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6gSRvv5"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cb5138df1aso474213385a.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 10:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772476588; x=1773081388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HSALgyFTMer9c3IB9WW11a9uMrW10TQkpYg7q/s+4k8=;
        b=T6gSRvv5njDQZ3kBL3iu1eZuTq5NwtMUDTBWVnbgLeiFfiwpxS2axaGapYbcZvnKHB
         Gc54lmQmTf1ReUMUB0+eBqB0loaQM9Ne/ozM/AH650iTScIp7+VXY6nt1Mi2Y1HNshfl
         e758DAgQuJTk4lez25DSG1zfuQUzJ9DfXWaCZo6YsgXjf2WRKcimNA6MoFjvuGC8EHTl
         r+x1kaUEKYT1FVr5/okiaihbdoqo5OhxTv4YNvaj/M9yrljQ2/k68+xJ5WLqLZVhK0q+
         LdpdZDxPn7DIfkMlP3yzvacyfbNNuq94igZOaLOPA0iFHRpU7U6vVsEsH7utXjLYuop+
         4M+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772476588; x=1773081388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSALgyFTMer9c3IB9WW11a9uMrW10TQkpYg7q/s+4k8=;
        b=o43wr2qPnHLim/CgIM2bBSxkfonSV7u069kAuIuf6XLfGp2jc7LBEDzj078TipHhdf
         nYoQdzvqY8KO+ybmJdC2Q66aulIjXP9LWF/hraSY+p5TP7kTGoTY/8wfBj8BawXKHUeU
         V69UhoUeaXR0K/YS91QQI+fpBgMzgqVyJDUJpMGsa7hMhchBeYapfwsGezwigIfvTr56
         AqB6LqpXJcmH6HyqHvBILEbFbOnxd7DGrLARC+6wNCw81sRpscvoDnwAS3K+fe9e9xV9
         nT7g2Ruu+RUkmLuA3kzMc5RR/iR+DaBqOvRLd7n23kPm6u9FyQyTvKdAVNLEWuW7AiwM
         VXgg==
X-Forwarded-Encrypted: i=1; AJvYcCUkF9ILo//QeBTaDLQA7RuEEmzg1fZF+yl9y530BpmWLd1QTi6H8utA8LuuCM9YTL/7Dw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDRJaKbqk1lQdpyPMBc72NQTGGGcZjeuszutZ+w5sfDc4Am2z
	FkXAtEbTayCGKSOwiFR3d0K6DA0UPU4yezT4geVrD47b98ljn2hTChGq
X-Gm-Gg: ATEYQzy3sqgOHH2UsYALWNA6cxcr6luILyrqajiv0SCZUtSy+i3mj/i2mx3rgKMFsep
	wE78z2S7HwtfJoy0yDfEvM8e4RVIdMefIIMxpyy3UE8dCU0Ok4m1U9cK7CVSB450Pn2XM9PATvH
	gPPqDtjX9rynLxXlYX7TieigZ2Pf1PDRjxsX7bl0bwBd1zLxyJOtzmfdnvdb8GnKMyHTd8Qwa+Q
	WqOY4WGZdYr9sthUQTDZgK5ljWJ1sFQUuRxlB26+4Rs58GH/Vv1U02OiSjd+PXyTZ7jmIgSv9At
	OcNHE/gQCHvVJGcuySOxv4t4uprKgtLC5cRINbMgyZb8b46DqMhzHil46PvA+d3ucLQ9XFLnVKZ
	mV+HNFkTH/l4Ee/h5ZH3RGTbznuWuHi3eeVLx4jVaPklCwuTtqSiu7ajRIBcLOJzVNC9/4CaW/s
	YpUfBTj+eJS4+3yspDjFNkk6IOL0MAOVXRCNpezApOXOQdQmq2Mn5N3v1zn+sKW0zoBTiygg==
X-Received: by 2002:a05:620a:414a:b0:8c8:82a1:11c9 with SMTP id af79cd13be357-8cbc8d73453mr1664251685a.14.1772476587808;
        Mon, 02 Mar 2026 10:36:27 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6f926csm1215252285a.32.2026.03.02.10.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 10:36:27 -0800 (PST)
Message-ID: <c747c645-7773-44e8-9d1a-74f5eb89e318@gmail.com>
Date: Mon, 2 Mar 2026 13:36:26 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] for-each-repo: test outside of repo context
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, fastcat@gmail.com,
 Eric Sunshine <sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>,
 Phillip Wood <phillip.wood123@gmail.com>
References: <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
 <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
 <6e9d4f3029daa2c0068bb16939b943e7ac924222.1772465805.git.gitgitgadget@gmail.com>
 <20260302175606.GB28275@coredump.intra.peff.net> <xmqqpl5m13s7.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqpl5m13s7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/2026 1:31 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Mon, Mar 02, 2026 at 03:36:42PM +0000, Derrick Stolee via GitGitGadget wrote:
>>
>>>  test_description='git for-each-repo builtin'
>>>  
>>> +# We need to test running 'git for-each-repo' outside of a repo context.
>>> +TEST_NO_CREATE_REPO=1
>>> +
>>>  . ./test-lib.sh
>>
>> Interesting. I was going to point out that this won't do what you want
>> by itself, because Git will keep walking out of the trash directory and
>> may find the containing repository.
>>
>> But it looks like this should be enough due to 614c3d8f2e (test-lib: set
>> GIT_CEILING_DIRECTORIES to protect the surrounding repository,
>> 2021-08-29). Supporting this case wasn't the intent of that patch, but I
>> don't see any reason why it should not work reliably.
> 
> I am surprised that use of GIT_CEILING_DIRECTORIES was not done
> until 2021, actually.  The reason the configuration variable was
> invented for is exactly to avoid discovery processes going upward
> and ending up in a repository different from what we mean to work
> with.
 
I didn't know about these historical details. All I know is that I
wrote these changes on top of the buggy patch in [1] and confirmed that
it failed with a segfault. Thanks for confirming the reason that this
works!

[1] https://lore.kernel.org/git/86cd83f65b30aab3233e27b3e5c4f03041e68766.1771903950.git.gitgitgadget@gmail.com/

Thanks,
-Stolee

