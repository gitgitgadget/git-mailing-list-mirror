Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767A21AF0A7
	for <git@vger.kernel.org>; Tue, 13 May 2025 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747147152; cv=none; b=Q7pQKy2KcVG3Qh2Xvx3eA0k59AY3S3vbFjasiHHSAqbbTqWycmjSDsaOuMEAuTcXJibl8PSNXbeqyZL2ZXplkYyxh3gt00zllOv1O48rL+6vZ1LukRdSPJZvToJVxcpOcOcKNQd0dAzWsKWKUfYPMndXC0V1Pu8hECEkYIYXjyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747147152; c=relaxed/simple;
	bh=pxvrDCuu17yfxe7Pi4zKBWU2h4VkrWkF7fMe1J1z+kM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=h1hC+DNV+3IIoe/mzasycgHKCzxjfmiqyw9FzBSThUqm9RhhvLpIXWXg3q2vizzZqAKQUOhNrwO8Wh6AXS33paUSGAc/f+xjvtj1aOraFHBI9i5KmW8JIn1Dul03whZ56krW1F9G5FqludGHhJQAgFO3OmEIOIPBnt28lsLLQNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtvPic0x; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtvPic0x"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a0ebf39427so4641876f8f.3
        for <git@vger.kernel.org>; Tue, 13 May 2025 07:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747147149; x=1747751949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FMKbEMVZFZDVA+/EMWcdJDdCugAkGqNsjJKmEZFdNxs=;
        b=OtvPic0xg84qPG6vLembhJ081Yrx7SommLB5ygN6UiDIqK59Y63JTD376e67ZOs52j
         WeiI+wcYw2TVN4enE5yXEnX1kZ7kCPyWLTHsgQ5tQjEYbgziWtdOBUzdPO3omMXP0fE/
         CA/wnz1rATmPTT/9Bg4lH9q1JnEM6J/GoMXhOyeK9EdE1KZtYDXjQOx5vTFji2iYy44J
         FVGF1FUOeTXweBy/Q3Qm9Hivhu4Hhyoco6sCjHGjmkL+twjsyuIBW7MGPFqC8u06Daq2
         MRCJ4+vdBoz7DiFMtEkmKSjW/KlIQymMvb5y6E0x3Vj5FD1MEKjFpMyW7l8xbNwrTzZD
         TF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747147149; x=1747751949;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMKbEMVZFZDVA+/EMWcdJDdCugAkGqNsjJKmEZFdNxs=;
        b=J15i2eKUa1+II81aK3i/wPNFT/zQLQ8Ed8Zq/l3bfBx59yTPLN7cEEPptRUeFNGLN4
         JIcrh5IcB3Q17abdWlRhpZLWSiSwlL6+5TM58zknUyty346LF/UUPhPDgtspFOIriiSS
         LXGFiPxlCB61kLbDNfYjR6N6PLhn1upjCneMOjC9TkYEkNl8gnzX7lfnFmOAZ6NdCg4x
         mc84wzP82inVUtqLTYnGypsK21sPkHDq6vO1yvBnVclqYFmzHFPZCnJNri4J/CFlmW6u
         Ol03vockiw1qFs5MGshl+MLRrGdYhIgAuG58FDa5Mas8+cyI8vtdDFgx/hc/7GG8j66V
         c5UA==
X-Forwarded-Encrypted: i=1; AJvYcCXXRxl0hE6zkdCH8NzApdhsnPzz/FvCCHNMuUR63urfeRIcpac29e2jTLQMTIEY2W32gzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM0HhdEJHZgGiHxJUICfVycQETcGv8wZCd2tkeTdY/cljnl22N
	9i4Nm9GHfjg3G5elb/7maYTlrhpuq8rSGW55llbJwHM6+OwZozJe
X-Gm-Gg: ASbGncsdJonS91C8kr6N4qKwNTmCf/QuRUpJDbTB6nVQy2faeNKThdBP5jGVQQvbFXI
	XR9WAri3TNbQ8oeZ85WrIppM/Pv5YOK0vgIp4cfpM6YSfjjmPTSko90xTMhR0A2M35/l4FHcwRr
	41bk42FErQiy940w+N9La/zCp/7tL4HzecHt8EELl+Hs71rafTT4r3Zp+sLBvcr/LRJaJhWDPic
	2Q/vj4mt3/CZW1hE6oAxNiIcS/CYUR8GwaqetsohcfRSoLUOjNwlfNVzuqo6dius57qGdXxv3kx
	I/o8syJB80qnXnJET/+abKKfe9emZNqP1rcxf8CfumkRS5c67BzhQtMmSOW/YTkZ8Gc8AVmXZJr
	SUM58qFi3OYaCutb8Z4YVZY8lhko=
X-Google-Smtp-Source: AGHT+IEgpeqvBBwODkt41Lx/GVbOED6tdlE+j/XGuLwIrJu97htiPIF2TSKK0yFX0fT1CnpAdcYthA==
X-Received: by 2002:a05:6000:2401:b0:3a1:fb99:3b16 with SMTP id ffacd0b85a97d-3a1fb993df2mr11861560f8f.26.1747147148069;
        Tue, 13 May 2025 07:39:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecaeasm16294966f8f.28.2025.05.13.07.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 07:39:07 -0700 (PDT)
Message-ID: <0862a881-2e0a-4051-949f-3d0b94408fd5@gmail.com>
Date: Tue, 13 May 2025 15:39:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/4] add-patch: add diff.context command line overrides
From: Phillip Wood <phillip.wood123@gmail.com>
To: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Christian Couder <christian.couder@gmail.com>,
 Leon Michalak <leonmichalak6@gmail.com>
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
 <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
 <973dfadd1b3c7e214b14c75494b3b3b786227362.1746884789.git.gitgitgadget@gmail.com>
 <431d6fec-3955-4703-8bb3-376eae7ff052@gmail.com>
Content-Language: en-US
In-Reply-To: <431d6fec-3955-4703-8bb3-376eae7ff052@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/05/2025 14:52, Phillip Wood wrote:
>> diff --git a/builtin/stash.c b/builtin/stash.c
>> [...]
>> @@ -1826,8 +1831,15 @@ static int push_stash(int argc, const char 
>> **argv, const char *prefix,
>>           die(_("the option '%s' requires '%s'"), "--pathspec-file- 
>> nul", "--pathspec-from-file");
>>       }
>> +    if (!patch_mode) {
>> +        if (add_p_opt.context != -1)
>> +            die(_("the option '%s' requires '%s'"), "--unified", "-- 
>> patch");
>> +        if (add_p_opt.interhunkcontext != -1)
>> +            die(_("the option '%s' requires '%s'"), "--inter-hunk- 
>> context", "--patch");
>> +    }
>> +
> 
> This needs to die on invalid context values as "git stash" seems to
> ignore the exit code of the subprocess that checks for negative values.

Looking more closely the problem is that it quits if there are no 
changes to stash before validating -U or --inter-hunk-context. I think 
it should validate the options before checking if there is anything to 
stash.

Best Wishes

Phillip

