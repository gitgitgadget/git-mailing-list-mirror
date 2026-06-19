Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0A8282F02
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781883230; cv=none; b=iarMk3QtXvohHr2LqKbopaSACidXuWE4cTvRUp9Hy6VMJMr0mxhwQpQqATcV0RHB14AkEuJXtyCaHIMEt5dS2TTVa+8zdmF775VKsdCTl6uTh9IKsBNT5qNrJ9f/k+egHmO1hq2DXhgP3Eftou0eGNrBpPqnALMzbOA2lPkvV9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781883230; c=relaxed/simple;
	bh=2O13aYfC0qx+jqY8qmtgjevSNDniRlvN2jN8qcSoehA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUO1Ve8rNFxdbM/kX0P+LOYbPpnj49Kz9bid4mVUx2DE2zGjqSAd8A25cjJt/K7uxqnRqH/1kkYoxfEHtw3UKlcMM20YKU4dO2kPOEnzyHWxjOl0ukR7VCNh5GvYC0I4CoaBTwkhjqlSygfzY7bvJaunnMP4WY3pjg2/mmxxFG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7TWPM05; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7TWPM05"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-91588056619so161791185a.2
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 08:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781883228; x=1782488028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rrWyadbS0sQrN5RFk2DEsU7WSV8rqEjLT7X7hM8HMLk=;
        b=X7TWPM05MUc9Gkpj/ue8pok3GhZO6X4rak3WgKG7vKNSWz2TFYFJuvYcd5INunrdRm
         X9LM/AdTu77/TrxxTLQP9tLXRV/jWLHfc0SrkIjbPRM7PWClXr3q66mJb4L5/6k5ATZ/
         Xb0t33lru4kML3OqmyJ+94ABpZgk4LUaHCt30RvKeCp55o2q4a+fPqpg6TfnI9Di9W1C
         HpAuBM8MfunRiAwszljuEMuyHE+Rb+wNc2WTj6VyTnX7EpCwV7PLl5vMetfKdxzGGJHR
         TSSF1dkd3ihfWy0Z+jP3bkfk5KTYBMLwuroKUAZ7lDXWa8bZN4dBQal7XEDG7uKnACQG
         PfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781883228; x=1782488028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rrWyadbS0sQrN5RFk2DEsU7WSV8rqEjLT7X7hM8HMLk=;
        b=ffYN/EdOvqaZ8Q+bGFsOSWligy0zE3Et6X2saICDNv5I5T/cLkOpHoNgI31VdNE3g+
         ruXDBsOxrwVtzqNo5bh4Y44rG6LuzDlOAckEF8gVMuvs3KaQpszpwZDRkOapa/m+ySil
         XgYk/Erhqxrf4f6oodrasRiztXcSI3Ooz2/xxxDcR4A+uhSQBRbgpKOlK8237BAfjZI2
         JC36pJdzIV3Tbk9pKA6+7Eo4nd7jXBF/5MEs3mblwwvlE7NF/kUaREr+b+4KiW2jIL1W
         WzziNAaNt8wM0r+7Rw/LJlNVYF7OE7taeNRxs9PTt7BxhYj1f0XLHovj1cWXQ1HuSM7Q
         aNew==
X-Gm-Message-State: AOJu0Yw8mvEwtM0GWWoswnjcvrMhnPDAhk7tY/TmVLEMCQ2GqfVQrUNj
	UZL9r8P9PbTstbXosBkRXjvDmh0D8wWJqFP557Cpxl9UTGqKNzSmC0av
X-Gm-Gg: AfdE7cl8RMs1ggetmVdhbbaidRSQ5lmHMmfHSnEkLqkh7HUwQCY2dxAgFISIbgApuwm
	0HngSxqHU5OdH9TjVdqX9VUWCeEfRv+WuFA/z9kJY/XZUCNVaZKjN6tfr+EgJNc7lpO6hD0ms4H
	lVdBKjIkkX2zGZzi8a+CATvs99SKTMy5/XarsVybmzVvQwq7J1JjjR43R/5NEKJ3gBVOLUF1srA
	IoLEuL89ViBnv2ivyydZ+j/SMVLswYrqWaqgr1gXbdaav35evGhm+e+1hlzJHqU2+SCFzmLO8+W
	XixsXZ1NLcuCW8O8ud76WKvQDVJB/77q8VItJxtTXj95K5CJtM4yZRKU2XbkFOgRh/XqvnxTno1
	N/Nh4xqNchRiLVnSiEteWL3Exrk8/5vnIEDe7AG0e7QmCoUhbEyZoEUpWSVkCpesHPFUKwwAuBY
	mNl9KKBi5RAjkq2Wg/WBoS+V41T3wAZVLHG4bcpUhsmnoDYb+l7ttvlyNQ1w==
X-Received: by 2002:a05:620a:8005:b0:915:f664:2568 with SMTP id af79cd13be357-9208d6ed316mr605219785a.50.1781883228407;
        Fri, 19 Jun 2026 08:33:48 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a1819fa5sm271440985a.20.2026.06.19.08.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 08:33:47 -0700 (PDT)
Message-ID: <7afdaf77-07f5-4d48-955d-e153d148f647@gmail.com>
Date: Fri, 19 Jun 2026 11:33:47 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] pack-objects: support reachability bitmaps with
 `--path-walk`
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
References: <cover.1779923907.git.me@ttaylorr.com>
 <cover.1780438896.git.me@ttaylorr.com>
 <ffad584a43ebf3cb2138e8dce7daef84ab72712f.1780438896.git.me@ttaylorr.com>
 <849c659f-efa8-430a-bfac-0c26a3ed1aaa@gmail.com>
 <ajVSHvL+On9AEV+g@nand.local>
 <131d7ad3-7791-4d6f-bdf3-afa6b0831a71@gmail.com>
 <ajVXlcHgIF2XkmMQ@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ajVXlcHgIF2XkmMQ@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/2026 10:52 AM, Taylor Blau wrote:
> On Fri, Jun 19, 2026 at 10:40:51AM -0400, Derrick Stolee wrote:
>>> [...]
>>> , which gives us:
>>>
>>>     Test                                            HEAD^             HEAD
>>>     ----------------------------------------------------------------------------------------
>>>     5311.3: size of bitmapped pack                           278.8M            278.8M -0.0%
>>>     5311.38: size of bitmapped pack (--path-walk)            278.7M            278.7M +0.0%
>>>
>>> (eliding other tests). I considered whether there are other interesting
>>> tests, but I think "repack" is the right layer to run perf tests, since
>>> you're always writing a closed pack. We could try different subsets of
>>> the repository's objects (which would also have to be closed), but I
>>> don't think this is that interesting.
>>
>> This sort of thing does help to show that we're getting different
>> behavior when repacking with and without --path-walk. And this test
>> is showing the slightest change for git.git, but is likely more
>> impactful for the other repos I've used to demonstrate the benefits.
>>
>> So this is the kind of data I'm hoping to see, but also with data
>> from other repos whose data shapes benefit from --path-walk more
>> than git.git and repos where name-hash v1 is sufficient to give a
>> similar result.
> 
> I'm glad this is the sort of data you're looking for. I'm happy to run
> this on other repositories.
> 
>> I'd also like to see if the repack _time_ changes with this, but
>> these direct size comparisons are the biggest indicator I'd like to
>> see.
> 
> Unfortunately a timing comparison is kind of a pain here. We'd have to
> use test_perf, which will perform the same repack multiple times. We
> could do that, though it's wasteful, and changes like bf4a60874af
> (p5326: generate pack bitmaps before writing the MIDX bitmap,
> 2021-09-17) move us in the opposite direction.
> 
> I'm not opposed to changing this to test_perf if you feel strongly about
> it.
Repacking is expensive and time-consuming. I care a bit about it,
but not as much as I care about the size difference. Feel free to
skip the time performance impact for now.

Thanks,
-Stolee

