Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8A21DC99C
	for <git@vger.kernel.org>; Thu,  1 May 2025 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746108664; cv=none; b=YhFdetFAOgPuLvaDbTsIR25bYFkL6YTTbrmE7MnMIiFVdy52qK+SXOoA/j0aZ3Y7BOwXKEDkqfLrZYohlxKhW8cJivLqT1Xr0hYBw22DFxW8bJ5qIgu7NizNWOfDfozIb+/fEjp1HGi48Ed3dTQvYhQ+Pd93su7AuEJ4Oel+h3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746108664; c=relaxed/simple;
	bh=JxEcpuHoLMLKEGKvVbtIKXfhhubQxKtp+aAuXS3NicU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HwrckAykT0QLaRy6xgLafRCA2wzKcaIFuunViw4VqN3sQM6qBFLK0DCY4YjksA7EFAdh4kcuKdEj1GGoX/CHLsuC40goOql9kF8VtvTtVt9vzEw4jCL89m/TIXBbye4syqCVM18qC6I22+/l7lTcdliRKep7GkoOWyg5sVVwb6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3Cbb8l9; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3Cbb8l9"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39c1ef4ae3aso591664f8f.1
        for <git@vger.kernel.org>; Thu, 01 May 2025 07:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746108661; x=1746713461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GwIV1ZueUYH8Z2p3K1n4c4IyG0OwsuF6lRBp0OjphNk=;
        b=e3Cbb8l9Lqt1iL9Ln0VDf7HNQB8ckiPlu8bFaMaP7kD1T1c2B0HzngEjBt8i2OSs3g
         +DBoZu+tKZskN1bEh9c6lRgAWjEvamQxSO74XYIvziF3AsKRwm2pAkggYLAVVRTyzolJ
         XBhpQObS0OY7awnWcLW5bCWrLZ4+zoStkTdO07aQZ4DeXPAWD9PCuhSvmdy+mMRjRhRC
         KOZTHbZGX2DbDleHxT8GKEfebqV0o+PMQmzA5B1gUyZPMQqfNd87q3Z7VwyfaEpjemxQ
         AeGHJuvbaVoTNHa0FrnI4lRHsNrrpo64SavRtkGMUrBfShLDacctxAs2iyXxXGerPkoZ
         V93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746108661; x=1746713461;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GwIV1ZueUYH8Z2p3K1n4c4IyG0OwsuF6lRBp0OjphNk=;
        b=Sn/7pqEAqJT05AJ3HOdjuU5UxWp+V3KCcFHmtJfcQmsIR2l8VCmmUfzEG4lp++XrHH
         PCMhu7EatjcgCYgc8qgAB/ASOb7/iGk5/9ZgCrYwTOjup2mqyeIJMny1BUhN9sQWf+Or
         A8VLsLshQN1xYRO432dzpaLZxd9JrezsRgugkA5ODN4I7yPszMyNUr0kU+a12FNFZoir
         mPu5igjmtep+OH3In8BHCPixDSPf8e20T1sxGJl8Q2oH0OTDnU+GUNbgev6tCdXZk/Fk
         4Gf4+WDelD1Bff/sqBuF/nwhWeTmIau0fx5UFoU9pq1E7SF1qD6Ah81tg+r24ZJUfQoB
         sfYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXryfnGnSH4L0BXs92j6Qzk+ugP2AMaoai+SrNgGOWtxQeCA0DZwN3TerktuF7k5wHWCWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjI5zb74KDRTmsrSSQc+yjBJv5Q9Rn66TRuawdBZcVNTBW8rV9
	R0jUUa+UB87t+DglyZi89Zlcq2SHfRiyPjFcjeAL9h/nmm8UN1f2HtSNSQ==
X-Gm-Gg: ASbGncst1oMutWhN2h52+b8zX3O4Gr1GrG/hFI737oNQOs+H9vSnBDGO52meP5fn+rd
	xHRaSt6F0Ii76Lz665ygX5EoO1eO4jTyw4BuJ5OKnj/8ganAPR4TroKS0pmhUku0EpT7ZNDyMz1
	YeqSOqFKcGBNoTzYriPIOel2nFvwjXEJXNXSr1bb/6N49Jjs/cTq9XFJv273GTpgTt2n9mVD2OP
	A5wK4SaWkE+u//T6pm9l+D6MTq5nGOuzNaziMVKX7R+DA3gSPVLPYr8IyF/Qq2PmTsyhy6FlMEg
	fzvHHPCE5wKNBpDfPOumM5KiYqNFWSOD9c/vf8LdACrvR+m52Ttv9+i9yxv1w1V2S8AHownjJqx
	tKjll4HSzDpzvTt7R
X-Google-Smtp-Source: AGHT+IEnCedyK7lSuKF0oyKBzKw2jO58Z5xETsas1iw4GUJ0nePhZrCjPPnySCT3Vq9kN/9EnpNHOw==
X-Received: by 2002:adf:e40d:0:b0:3a0:6a8b:ae4a with SMTP id ffacd0b85a97d-3a0941d9dfbmr1769425f8f.24.1746108660413;
        Thu, 01 May 2025 07:11:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a095a882f1sm937863f8f.74.2025.05.01.07.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 07:11:00 -0700 (PDT)
Message-ID: <a834c708-8904-44c5-9481-5f796cf0054e@gmail.com>
Date: Thu, 1 May 2025 15:10:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG] rebase: can write reflog with uninit. `action` string
To: Jeff King <peff@peff.net>, Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <20250428194048.149348-1-code@khaugsbakk.name>
 <ce0f41e4-7d90-4398-a0e9-e8ba69791e57@gmail.com>
 <fbc97d6a-2022-4a64-a2ba-5a7255cd81a6@app.fastmail.com>
 <20250429215155.GA36727@coredump.intra.peff.net>
Content-Language: en-US
In-Reply-To: <20250429215155.GA36727@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peff

On 29/04/2025 22:51, Jeff King wrote:
> On Tue, Apr 29, 2025 at 09:40:13PM +0200, Kristoffer Haugsbakk wrote:
> 
>> On Tue, Apr 29, 2025, at 11:22, Phillip Wood wrote:
>>>> #0  run_git_commit (defmsg=0x555555babe70 "<repo path>/MERGE_MSG", opts=0x7fffffffc070, flags=0) at sequencer.c:1158
>>>
>>> Thanks for the backtrace. It would be useful to know what's stored in
>>> opts->ctx->reflog_message at this point if it's not too much trouble
>>> please can you run "print *opts" and "print *opts->ctx" here.
>>
>> Today I ran on f65182a99e5 (The ninth batch, 2025-04-24) at
>> sequencer.c:1148.  I was never able to reproduce this
>> `opts->ctx->reflog_message` having a weird value with GDB today.  The
>> reflog was also fine.
>>
>> Then I ran without GDB and I got the weird reflog that I expected.
> 
> Have you tried building with "make SANITIZE=address,undefined"?
> 
> This is a wild guess, but since ctx->reflog_message is pointing to a
> static strbuf, it could be a use after free if the strbuf is reallocated
> due to another call to reflog_message(), but we are still holding the
> old pointer via ctx->reflog_message.

Oh, nice insight. I'd forgotten we had callers of reflog_message() that 
didn't store the result in ctx->reflog_message. One of those callers is 
in do_reset() which due to the way the todo list gets constructed is 
likely to be called just before do_merge().

Thanks

Phillip
