Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C643FEAD2
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818035; cv=none; b=g2TZXbcDP3RAH5FDfSk1BHtAG/1o6tozejX4bdpUsVKj4aOF88WbaQQxcLX+JB24sSksyABH4IGqLpmYXfyWiR5CoghUx+1Io1q5B93dUF54n5qbBcesLnl4Rt8qg2FDqs26IWPrXkaQ4dGqFYmna9d7wNtHuxaaz88brm/24eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818035; c=relaxed/simple;
	bh=sjVsNtu8NkO7FqU7d4r7727MeGYMNETUioPckV+C3kM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Fr03EC0cdjEyBipA/hzIyD8OlE1zf9N/POqn3/U6yNu+GCnVyRh3ZB1mCDr3PkElE8ebVMEBfnJtUgVHhKHHJ/x9hy4JgNJiWfo6QiWSngirZq3E7shFtswhEAD813vTZKmExPU8jmq9EHiu0Zii5gjxR0XqHpmm3i0rkk95KMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdqucD2T; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdqucD2T"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43152b79d25so47579695e9.1
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 06:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730818032; x=1731422832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oBfAeG6Zyv2Qq2T7uph+KHalesEkd3IkGA/ljx4/QxQ=;
        b=UdqucD2TgB9kXrf8SOA3Io1NLleruY8sSmlj0nYEZlzolQ3rs1Bj4chZdEtkjf/MBf
         8gFmnZurlzAUn2/80z3hYDgrl815+k+TT6iUbW6b0ElMZRfw7Uy69IkrKUao6cRAzl8J
         rgGSixtZrHg5yrwzhd8TAIBhQI7F8HD5KpzvhzGorC6/4cmHVkfpgf3ogatKFZ39uIyQ
         cTdkxGpYqaCPW2538CG1rw9N93tpaSkNgKen9yiZwx9amEQ/QLYeI4sEonBKFf3T1xz/
         oqk+kUD/nkBVrYTLCmA1g29szYRoT16z9/6AfvEgPx8oopXyKoYNcMZTl/VPsZXTJkbG
         UEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730818032; x=1731422832;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBfAeG6Zyv2Qq2T7uph+KHalesEkd3IkGA/ljx4/QxQ=;
        b=ivruQtOXi31pMKWzcfIAVcZdeNaoP8bh2B8UVVC/nCgZaSHGs1Lg228nLXpnjnZgSS
         UdYw7PncpdKftELwgIhZXgpJKawV6YlLfgMxb5C/RFlf4fvB6fvLmZvRHCUEVM31/qac
         a1DExA9DDBpS6Wl+f3RRPG2B6EWZwjTVHh8jkxDxp+k4cqrkDgQ366s/5FmJ5OezgNCu
         UJGpZlT0fuYwxJMB5HWEcIQ4j8e2lXEdn528N2JdAtOT7C7iB5s/HfGDdkmJnizxPrcA
         2OthylDW+t7kYtIbCqtB6u+q26ti2pasqouolWOLWJmJp1yn0hG5mfKPk9ObmVSm3iqP
         fmOA==
X-Gm-Message-State: AOJu0Yz0wyo1k3xPqE64htocgqAy0tzm3JAufbjRP/WltFmy3e8HD36L
	S4sL70bQupq0NTym0/9n75hDIHZ6BjYEBsbY9SmR7ZYoOrnjicpoeelh7g==
X-Google-Smtp-Source: AGHT+IERVp5rn826JXKKUhYfshFFh5pdRHDbj3VWPjs41DnNZh5FZoBCOI0lKol7S8kMDauK8ieEfw==
X-Received: by 2002:a5d:59a2:0:b0:37d:5129:f454 with SMTP id ffacd0b85a97d-381be776c81mr16392880f8f.15.1730818031817;
        Tue, 05 Nov 2024 06:47:11 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6b0:6601:5a4c:6f5b:4f15:3158? ([2a0a:ef40:6b0:6601:5a4c:6f5b:4f15:3158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e565csm16369746f8f.48.2024.11.05.06.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 06:47:11 -0800 (PST)
Message-ID: <b548c532-e54a-4edc-94aa-f3c2925602e6@gmail.com>
Date: Tue, 5 Nov 2024 14:47:11 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4] remote: allow specifying refs to prefetch
To: Patrick Steinhardt <ps@pks.im>,
 Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee <stolee@gmail.com>,
 Shubham Kanodia <shubham.kanodia10@gmail.com>
References: <pull.1782.v3.git.1726741439445.gitgitgadget@gmail.com>
 <pull.1782.v4.git.1728073292874.gitgitgadget@gmail.com>
 <Zym--GVNJt_lsQEz@pks.im>
Content-Language: en-US
In-Reply-To: <Zym--GVNJt_lsQEz@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/11/2024 06:45, Patrick Steinhardt wrote:
> On Fri, Oct 04, 2024 at 08:21:32PM +0000, Shubham Kanodia via GitGitGadget wrote:
> 
>> diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
>> index 8efc53e836d..186f439ed7b 100644
>> --- a/Documentation/config/remote.txt
>> +++ b/Documentation/config/remote.txt
>> @@ -33,6 +33,13 @@ remote.<name>.fetch::
>>   	The default set of "refspec" for linkgit:git-fetch[1]. See
>>   	linkgit:git-fetch[1].
>>   
>> +remote.<name>.prefetchref::
>> +	Specify the refs to be prefetched when fetching from this
>> +	remote. The value is a space-separated list of ref patterns
>> +	(e.g., "refs/heads/main !refs/heads/develop*"). This can be
>> +	used to optimize fetch operations by specifying exactly which
>> +	refs should be prefetched.
> 
> I'm a bit surprised that we use a space-separated list here instead of
> accepting a multi-valued config like we do for "remote.<name>.fetch".
> Shouldn't we use the format here to make things more consistent?

I agree that would be a good idea. I also think that it would be helpful 
to expand the documentation to explain exactly how the patterns are 
matched. I think "remote.<name>.prefetch" would better match the 
existing "remote.<name>.fetch" and "remote.<push>.name" config key names.

Best Wishes

Phillip

