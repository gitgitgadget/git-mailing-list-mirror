Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E19717BEAA
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723715518; cv=none; b=oqnRR6ERhH6KyqDwSa+54FBJdk71xxglH1iycjUmXEIH1zdj2gtQ9PF8gmeVNkov+rvZGZ3EX6SWoMqkZWmZBXNhDD2ZtNHKKfkG2tq8z5l/agiwKxpbbBqlWVdTsYqZc81gm1JqlfCB4fP/spgIFfPBsU8NVLIIEr7vZvfdL1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723715518; c=relaxed/simple;
	bh=CaPg1R6HaIN0X6ytq34DTcLwicxs8mol49LUnOkyjlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fOcGYRFbiXNmMlIBTiz4NSnCwYk/N4oHbqfVAvNj6N+KhldGQilevyMX4pYDwakuLDomFeKjfIJqQ91eza89+QNiNUlXXoEP7l7tGwm8k2F1uZ96pK1nXhvNib49YciNCP3xJWjoEBFEXjkuFfO9/VJrafdkEzg0Q48Q6oSqQeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnP74Z5Q; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnP74Z5Q"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3718ca50fd7so137199f8f.1
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 02:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723715515; x=1724320315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UdlPTUgVC2VfbLZaCvqrFrCj29YzgIbkJnpzqqw1HhE=;
        b=LnP74Z5QZgxp5h7Gf1iGJzDgh6acUAY6tXSWqz7JeXom9rra2MTyRb4JGgv21UZ368
         FWzvdLymSUyGNbob8aNtPhWR7m72wWTxsCkmvq5hAYvK4m1RxuvXc7pTBU6uGN9gB9ZN
         S3XT0MRtHkqyrSHXQ8Aq2zp2+P/FSz3OZni+jkXA8ch3+8Yk0szVeYpQPeSmBwggOCks
         RVmgWqT/cndgrXmWg5QxtZLFftZSqYxjkhFZZhedOrAmBw7yFFoLIhUM2hFt7xdsXppv
         MG6cgJzymlJLUiGZMORKWTCfjg/m7firDCkXPibwRuPKmWEcKUHY1bSxsT+wscN/PWfV
         IExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723715515; x=1724320315;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdlPTUgVC2VfbLZaCvqrFrCj29YzgIbkJnpzqqw1HhE=;
        b=mcgRPiPdUklB33V0FyeQRfji+aDLAL4IPnQiINzENPlIkSr6vJftAXANqI+iNAEsAZ
         /j7SCAjmbAMGlI/M/RpjVi5k9bmWWPerT8MgZwO9kj/Zwa8vpfbGU3fWc+YGfd1+ObzX
         q+a8Hn/oNWnzZ2BwFm4Qa++wEsJXUOQ1IhAoGYlqkrWgg1zwtxy2wfemqFRhGjvUnJ4N
         OR8K/D5hmbHqrRpx+hRS0ZV/iYz8UsECVvdkVTjzlGuZANiP7J5rnYUry9NBPLCJq3Fi
         Va58sJLbeN0Kn4tQlowgDHr9pQeYsZCe34k4dXwG0+ovSbbcB3q8Wre/Po/w7i0xUlwd
         Q8og==
X-Gm-Message-State: AOJu0YwHPZg016F7ic0SfHJTYnlaxtEImuMB1i8I89uimqEqN+5QpMC+
	zPdqW+sH6wi/J7yAcE119FmHOXVtr7YrW4MWwzhxEoZUF/tk5J6U
X-Google-Smtp-Source: AGHT+IFogYBWSE9AhIU1ajYt5VdXFKl3BO+LinTXSNVuif+BZ4qGxTtcT0K+uEpoFOTgCImJpKU7Cw==
X-Received: by 2002:a5d:4942:0:b0:371:88e5:6d48 with SMTP id ffacd0b85a97d-37188e56e25mr1293227f8f.2.1723715515043;
        Thu, 15 Aug 2024 02:51:55 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69b:eb01:545f:b423:671d:5e99? ([2a0a:ef40:69b:eb01:545f:b423:671d:5e99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aaadcsm1059018f8f.98.2024.08.15.02.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 02:51:54 -0700 (PDT)
Message-ID: <0882a098-eb07-41b1-9527-04bdb77fa0d4@gmail.com>
Date: Thu, 15 Aug 2024 10:51:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/3] safe.directory: normalize the configured path
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20240720220915.2933266-1-gitster@pobox.com>
 <20240723021900.388020-1-gitster@pobox.com>
 <20240723021900.388020-3-gitster@pobox.com>
 <5332f244-7476-492a-a797-2ef7ba73f490@gmail.com> <xmqqbk2ljvty.fsf@gitster.g>
 <5e4906be-2cbe-44b5-b490-593ee5a42b95@gmail.com> <xmqqh6bnyqjp.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqh6bnyqjp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/08/2024 18:15, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> On 25/07/2024 17:11, Junio C Hamano wrote:
>>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>>
>>>> I think this is sensible if the key is an absolute path, if the key is
>>>> a relative path I think we should ignore it as it is not clear which
>>>> directory the user meant.
>>> The only thing that worries me in that proposal is that doing so
>>> would break a configuration that used to work.  I'd rather leave
>>> the tightening of it to future work with its own justification.
>>
>> As far as I know the only caller that tried to match a relative
>> directory was enter_repo(), all of the other code paths pass an
>> absolute path from getcwd(). Before this series git daemon required
>> the relative directory "." to be specified in addition to the absolute
>> path so that will not be broken by removing support for relative
>> directories. Are there other users of enter_repo() that still rely on
>> being able to match relative paths?
> 
> Offhand I do not know of any, but no guarantees.  I am tempted to
> leave it as a prerequisite task for those who want to tighten this
> codepath further.

Fair enough. I will note though that this change makes it much more 
likely that "safe.directory=." will match as it now behaves like "*". 
Previously it only matched when we tried to match it against "." whereas 
now it matches any directory.

Best Wishes

Phillip
