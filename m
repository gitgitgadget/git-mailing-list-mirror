Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA072E716B
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090664; cv=none; b=AkibaMcWzrgARDGoSUWQTxMpIiZ+g1LXXxBDDTZJikPfDTtx4QMf5fv9hv5L9T++GZw10cPAvMVdvXntztqJlwus+nqmITQ0QQANCpe1cqjSKQvaoQG6m14YHvHBQS7yGvGrT6ylxwGpFgoQTEzYRqWPTAsDid53oB1bvmIRRnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090664; c=relaxed/simple;
	bh=6FIRLT4UO5nihosbYi1GgWpK8W9iJYhEFpm+lpQGbPY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=V+yncDBvSt6thtZvYjrHjnSzvfWXIwSy5yKLifmKhKRb8wIJVAgunoLRuet9EmqEluts3eB9LxEXRpL7asotDBD7C8edtwTScdomGcxb+rwH89JCyurLbaR1N/CjvYuwOWQ+6rX6LyGclIAEty+RMtkKpH2AwRdcZnEmZz+eOrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwwSUAif; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwwSUAif"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b7920354f9so5398085f8f.2
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 06:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755090660; x=1755695460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q4Mqtf20RyNay3ytve5Ensn5oSmtTVuNG8mXBmcwG6g=;
        b=DwwSUAifBjVs7kmiFdN3Otjs7vp8ol2PZ6EN5YfgAIhOtM1q2Lsf6ZKVXewQE/mUbz
         rCtgVOgfYhJpfLtwD/n+aEI2SXhObQakv0HmhOMrZT3VWis5/IAf+j8puNd8fEACV9v8
         EAwq1usPHTum72Zs28ZRidlRrD9YCw3I1uiJORSFT2a9fkUYdlSO9zHMikN7YDv+Y/uy
         C1W8BvT4RU419S9rkb9aaoeJaiyHz6orpQoNT/qy+dLDqnwOSMkv5yUzQJ4jmTu+f16b
         3QWH8C87F2fqg4on9fO30wIzBDkDtK7b/A74ceQWIujVS59mf4oUzNgbLM4FWgmEC/D/
         8A/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090660; x=1755695460;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4Mqtf20RyNay3ytve5Ensn5oSmtTVuNG8mXBmcwG6g=;
        b=dv2GODHsWrlfWzXGylX2eu/EjjrcVejLJXwmyl8IbF56lljg3RdkEWLoDsZurGvW81
         PcvlKhQDKrxCxr3kdMqKu0E4CbU0vTjMOq5POopKpaQnbdoqBWRvM2bWx8ZooRX44iTH
         uQ9yaNydRAEt/5YPQ4jnS8JF6byTRta5RbMImbCI/WG9XLO/kqh5UcgRjq8xDcn7OGW5
         KafM1BPNPnxAGwslzo5t2Y0If60QsKNiGTAIXPzGzbsKfHfuXKQniz9cChyiLGkvf5Aq
         51h4AVw61NmIuHIlgUPXCY52DROWqn3xlwdO+Jzx7GD4EiJnyJvofLJdVkVgVHTHwvTU
         heXA==
X-Gm-Message-State: AOJu0YycI93cpEsW1ythDQgoks/u3p9Tx1tjo27+8Frjn1//kvle3IZz
	BdjURjm7x70OUoqfZbvCnYVWRxe8KaAs8/cZkKwpHoZZfwWCBAPo2XN1
X-Gm-Gg: ASbGncuudJHApiHMyuWVf606s0WBSDGbITt+eyovec27aHKAuRlKJgYXwiObCXQm+N9
	dn73vRnxrdA8uQGTqXh+DfynfEY/E4/EgV2+2OloZbJT5gTMfKWZ7QTm2NHgPButcb0gs9318MV
	0nkZ765tj/pFRdDnkGE8wuDm3k5nlSfXpDr+y35LPthC3s75nYh0dVDIJYOgexzj+/jDRHloB6f
	h6Ef8zw1qU+V3Qouaz7vljf6sVq/JOxYIvt051mpvM/Au+zN3Pt4ewApsEIDK5SS632zKj9ogOJ
	qF5GlvzvPP99SYePrQ5J/3l7Dbwvkaf5fRW5yPsnw+yN7ZucBLNg/9RGq+VnNhRFeu/FI5ZP4EI
	wATUYr1Bh1YSSWL0NWLfebkYDjTUsTXnDIGG9XZIKVxRpLYmWHgFREehzlyHr8/6NUzZwuVx4Ut
	FnZSYoSV8iPLU=
X-Google-Smtp-Source: AGHT+IHHn3lB5lyHhhB8nJ2EkmqqH3rYW1DCrdIEUHMpb7J2clwJ6rvTAAqulN+z0GmiKzyNsWwnAA==
X-Received: by 2002:a5d:5d88:0:b0:3a5:243c:6042 with SMTP id ffacd0b85a97d-3b917d29aeemr2285080f8f.2.1755090659404;
        Wed, 13 Aug 2025 06:10:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c338c7dsm47876557f8f.0.2025.08.13.06.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 06:10:58 -0700 (PDT)
Message-ID: <b118903c-a50a-4ae4-b41e-1c47c37218c4@gmail.com>
Date: Wed, 13 Aug 2025 14:10:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] xdiff: optimize xdl_hash_record_verbatim
To: Alexander Monakov <amonakov@ispras.ru>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org
References: <20250728190520.10962-1-amonakov@ispras.ru>
 <20250728190520.10962-3-amonakov@ispras.ru>
 <aedb1be1-3151-421e-94ce-27bc77d80b83@gmail.com>
 <353c7865-d9b5-2a1c-4d71-cd1136581f01@ispras.ru>
 <5cf47722-7073-4761-8698-090af840d0c4@gmail.com>
 <c2fe3b69-8436-af46-c47d-dde5bb037227@ispras.ru>
Content-Language: en-US
In-Reply-To: <c2fe3b69-8436-af46-c47d-dde5bb037227@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexander

On 11/08/2025 15:14, Alexander Monakov wrote:
> 
> On Mon, 11 Aug 2025, Phillip Wood wrote:
> 
>>> That's what the 'cycles' column in the table gives (6.21/5.8 = 1.070...)
>>
>> It would be helpful to add a column with those calculations in it rather than
>> forcing the reader to calculate the speed up for themselves.
> 
> Ok, will change it to
> 
> version | speedup over (A) | cycles, bn | instructions, bn
> ----------------------------------------------------------
> A                            6.38         11.3
> B         1.027              6.21         10.89
> C         1.1                5.80          9.95
> D         1.094              5.83          8.74
> ----------------------------------------------------------

That looks good, thanks

>> Also what is the cycles column measuring? What is it that takes 6.21 cycles
>> for B and only 5.8 cycles for C?
> 
> Billions of cycles, e.g. in C the entire command completes in 5.8e9 CPU cycles.

Ah, for some reason I'd not realized than bn was short for billion
>>> Then you get 9% from the inlining patch and only 2% from the faster hash
>>> function? That's a bit surprising, which compiler and CPU you used? Is it
>>> with default optimization (-O2)?
>>
>> I used gcc with -O2 -march=native on an i5-8500. I saw a similar improvement
>> from the inlining when I was playing with xxhash.
> 
> Thanks, I'll see if I can benchmark it on a Skylake in the coming days. That
> said, I think most users will get Git from their distro, without -march=native,
> right? So I'd suggest looking at plain -O2, especially for xxhash, which
> selects hashing primitives based on CPU-indicating predefined macros.

For xxhash I was using the system library rather than compiling it myself
>>> I'd say under reasonable assumptions (e.g. a not too ancient CPU with
>>> 3-cycle integer multiplication) the new scheme is generally faster even
>>> without asm.
>>
>> Thanks, fwiw I don't see a measurable difference in the timings with and
>> without the asm on my machine -
> 
> To be clear, by "without asm" you mean forcing the !__GNUC__ branch where
> REASSOC_FENCE macro is empty?

Exactly

>> sometimes one is faster, sometimes the other, any difference is within the
>> noise.
> 
> Would you mind showing your 'gcc --version'?

gcc (Debian 12.2.0-14+deb12u1) 12.2.0

> Also, I prefer 'perf stat' for
> such measurements, because its measurements are not so sensitive to frequency
> scaling (plus, you can compare my cycles/instructions counts with yours if you
> run 'perf stat', but I cannot compare your seconds from hyperfine with mine
> because of course my CPU runs at a different frequency than yours).
> 
> 'perf stat -r 5' runs the workload 5 times and prints averages and deviation.

I'll try and take a look at that though I'm off line next week and I'm 
not sure I'll have time before then.
>>> No, what we need to do here is outside of the abstract machine's view,
>>> standard functions are not going to help.
>>
>> That's a shame. I'd hoped that stopping the compiler reorder the code would do
>> the same thing - what is the asm doing that's different?
> 
> atomic_signal_fence only blocks reordering of references to memory that can be
> observed from a signal handler interrupting the current thread. It has no effect
> on variables whose addresses do not escape (let alone never taken in the first
> place). Here we want to force a particular evaluation order for variables that
> end up on registers and are not supposed to appear in memory at all.

Ah, that makes sense

Thanks

Phillip
