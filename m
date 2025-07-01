Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE322749C5
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751377130; cv=none; b=sPaE4NgKSgg382SRE9PhdwtAuYpvYo7RH/2sYVVJp100+rtPr2FvsgDB88lRfnsWP0j/TuPh94NhxXjCLxLeIcdcaFIDLBjMzHNCWzkxeDgCPQbIk0LmXubR4yWkR4oys5mUv0sYhoxbIK+5LocMbpjEN/0a3JCwpKQUGDg28kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751377130; c=relaxed/simple;
	bh=KJrqE4nX2heEXtB0sHRZ1g5PoSVpYj1I1REEpnsOUb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkfAeVnUIxgV3y8ulEhYZ5+0C66t2+Z9P74yLUHDKlS4Clhfc8nD19vkAI2ZlQeHnptKUlIdSZBQIWhh0o8jVzC1XzdfRmf8yUNkEpNTtYEYrCRMES9+0iBB5xBZ7+fFutendHGFnvcKZkqY7nPeViVF5JHSxt6ybLsDnsKQgWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzqyTvi+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzqyTvi+"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so16864325e9.2
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 06:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751377126; x=1751981926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h8v4aE9YgojEtgm4uFRorBfhlXEmYzGXc/dim+9oSdE=;
        b=PzqyTvi+0o336MY/4O4E2ut0S0OtSMyoUuaBUWP68X+HIb+D24anBCOOFLGyRnnkjT
         CSV++q1B+AaA0K3znRL3Ny58jCYLSXz2mNHifbeWEAsUrtEfPmxOiRb6cx7N1SfImKMF
         hg4umUjAsRsH01g4eyMCcQT91+EvLvvP/TaaV5m7lqBhg7amteIqgTtZKP4M2KDJF8iv
         1Hc70jmVNEDuKJWhaCgNGrmWBsEIbcyQVA8bkaDYoj4l+izdoCD8XMSrDG5q2ewglczw
         w7c5tUq3j3qd4qnZXhafQF21YS4EKjAzqhaDMYPUmDX65dwKIZNoQPNIEQegFsfSmvi6
         UYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751377126; x=1751981926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8v4aE9YgojEtgm4uFRorBfhlXEmYzGXc/dim+9oSdE=;
        b=NdhUXMjX0e8Y6c1pn8QerFBOwosf7ozK+EkK8CSMCZwq2kfgl9LLHlatbtElDIPDZF
         S2CM52EZVTwokO7hC1jxNc1KHVt+ssGvd2zYBF8UMvbkS/RLKg2aBp9MU8kxM+AFEYeS
         gaLxJAP7TCkQAlO8Bi31JPw+j28XS5mUARwlxBBCy0WqM8dZsTbUfn/1+3MrpRhL9rmI
         7bYOzrWPqT6KO0hvT2mmex6BOqpeq73NkqKPlmpa8Sc2xXWbTvA2ZdWmhIt55k44lJqH
         E0rvBnaDfjy+CFZxxm1/qsSP2HCMl6BlkjW4CZqaZ2Tz2Oln/RneVk8yZ3gncsuCanM7
         y+YA==
X-Gm-Message-State: AOJu0Yys4MlLwMC/u2wByXe0IaGdA0JwTigEe3SMuYdQ3BBx2JrX4FDx
	Lsu1XGKD0Q8aAEA0geqyrdrS5049eGmFqQ2krKS2F8Az9TOLhADzCpsn
X-Gm-Gg: ASbGncsohF8cVcAvM6WVBL6pNJ3rXaBpJp86i3bz4SztTQWER/+4yukTjptTG0783S5
	H6Yib5sEPJIg5n/EP9L+qdEatNOg+hgXxExkDJFSGZI2x9nCiI+55VolWRl/mdboFUt8XGH4X07
	peNTqYG3FyUln25e8e0aS7cKrLvJfp/h4r6n4WzMynXX3IHkrSM4+PRfNbz6pWs5CQFKQPnnlfB
	CmSilqcrubEW3Ky2FQSK9af5vLfw3QoP2vgmKxWxUlczQqq943WOIpEb+mTtg+vRtNIWIeOgjIv
	ZsFkGFUU9CmZOHCFI0ga6h6oamJNqEVQ7XP632FANTxme+nr7p50rVF16NGiM5V+fodC/G4R7Iq
	sqUeLRl8PA2Mwj4sceF+Sb5sNaNGejDyGpEbwtA==
X-Google-Smtp-Source: AGHT+IGxOWXnwc7ZsBxJNEzDNdUHW+l8GGW70guEkwXg3aj4kxnZ7nyanY92MBhbg0WNB/YtvPV+cg==
X-Received: by 2002:a05:6000:2c0b:b0:3a3:7387:3078 with SMTP id ffacd0b85a97d-3a8f577fdd1mr14924154f8f.4.1751377126073;
        Tue, 01 Jul 2025 06:38:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f943sm13237648f8f.101.2025.07.01.06.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 06:38:45 -0700 (PDT)
Message-ID: <de0d02a8-37fd-4a24-9042-972398d72adb@gmail.com>
Date: Tue, 1 Jul 2025 14:38:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH] daemon: add a self pipe to trigger reaping of
 children
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, chris.torek@gmail.com, gitster@pobox.com
References: <c314cd2d-8fdd-4386-bda0-881ff87d9204@gmail.com>
 <20250626182432.87523-1-carenas@gmail.com>
 <59087d2d-6034-44d4-9fa0-c51d4bd60683@gmail.com>
 <zy6xtfqnncs3kuipgvdb7jiu7ynodbf7mld4r2ojy3jwkkthm6@jtnzecikxda2>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <zy6xtfqnncs3kuipgvdb7jiu7ynodbf7mld4r2ojy3jwkkthm6@jtnzecikxda2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Carlo

On 28/06/2025 07:19, Carlo Marcelo Arenas Belón wrote:
> On Fri, Jun 27, 2025 at 09:38:36AM -0800, Phillip Wood wrote:
>>
>> On 26/06/2025 19:24, Carlo Marcelo Arenas Belón wrote:
>>>
>>> diff --git a/daemon.c b/daemon.c
>>> index d1be61fd57..d3b9421575 100644
>>> --- a/daemon.c
>>> +++ b/daemon.c
>>> @@ -912,14 +912,17 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
>>>    		add_child(&cld, addr, addrlen);
>>>    }
>>> -static void child_handler(int signo UNUSED)
>>> +int poll_pipe[2] = { -1, -1 };
>> Maybe call this signal_pipe? I'm not sure what poll_pipe means.
>>
>>> +
>>> +static void child_handler(int signo)
>>>    {
>>>    	/*
>>> -	 * Otherwise empty handler because systemcalls will get interrupted
>>> -	 * upon signal receipt
>>>    	 * SysV needs the handler to be rearmed
>>>    	 */
>>>    	signal(SIGCHLD, child_handler);
>>
>> I think from Chris' email that it is conventional to do this at the end of
>> the handler.
> 
> It really depends on which flags the signal was expected to use.  For maximum
> portability it would seem better to have it at the beginning to minimize the
> inherent race condition from when SA_RESETHAND is on effect (which was more
> of a SysV signal() tradition).
> 
> Will move it to the end, regardless, as it won't be needed once the call is
> setup using sigaction().
> 
>> As I said above we could add an additional commit that moves
>> this into the event loop to fix the infinite recursion on AIX.
> 
> Not sure I understant what you mean by this.

Delete the call to signal() from child_handler() and move it to the 
event loop so it is called just before poll()

> I think Chris made clear that
> the AIX issue comes from the handler being expected to do the wait() calls,

The issue is calling signal() without calling wait() first. By removing 
signal() from the signal handler there can be no recursion.

>>> +
>>> +	if (poll_pipe[1] >= 0)
>>> +		write(poll_pipe[1], &signo, 1);
>>
>> write() might fail so we should save errno around it. Conventionally one
>> would re-try on EINTR as well though in this case the most likely reason for
>> that is another child exiting which means the pipe would be written to
>> anyway.
> 
> EINTR shouldn't be possible here from SIGCHLD, because that signal is
> blocked here, 

Hmm I'm not sure that is guaranteed by POSIX though it is true with BSD 
or SysV semantics I think. From a maintainability point of view we could 
see EINTR here if we added a handler for another signal in the future so 
I think we should make sure it is handled correctly.

I wrote it this way because it was only meant to be used as
> a fallback to the EINTR being triggered in poll() and so it wouldn't matter
> if it was lost (for example because of a SIGPIPE).

I'm not convinced about making it a fallback - to me that just means 
we'll never notice if it is broken.

> Once we move to sigaction, SIGPIPE could be added to the mask for this
> handler, but that code can't be implemented on the current base.

I'm not sure I understand. The signal mask supplied to sigaction just 
blocks those signals while the handler is running, they're still 
delivered afterwards so we'd still receive SIGPIPE if the read end was 
closed. We could ignore SIGPIPE so that we get an error from write() 
instead but I'm not sure it is worth worrying about as if the read end 
of the pipe has been closed we have a bug.

>>>    }
>>>    static int set_reuse_addr(int sockfd)
>>> @@ -1121,20 +1124,43 @@ static void socksetup(struct string_list *listen_addr, int listen_port, struct s
>>>    static int service_loop(struct socketlist *socklist)
>>>    {
>>>    	struct pollfd *pfd;
>>> +	unsigned long nfds = 1 + socklist->nr;
>>> +
>>> +	ALLOC_ARRAY(pfd, nfds);
>>> +	if (!pipe(poll_pipe)) {
>>
>> If we cannot create a pipe here then things have gone pretty badly wrong and
>> I think it is unlikely we're going to be able to accept incoming connections
>> so it would be best to die().
> 
> True, but since this is "optional", there is no harm on letting this continue
> even in failure.

Except that we'd never know if this code was broken. We don't expect it 
to fail so why make it optional?

Thanks

Phillip

