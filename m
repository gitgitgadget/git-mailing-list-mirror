Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6EE19415D
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593027; cv=none; b=Gp1lJhMzDm4nqnCwenHj/pANE5mvOERn/QNtQCdXTFImtUITXK2mfR7wsHdOgD+d0xp6ueUrBEHMAQCwaj1u5q8GitLRloRHZRSs4l7BgBwVDEPtfzYwpEGcZEAb7dy3zdsdRU0ZxDojyL+C9MuWDg3EJXG5d/z8frcs9UdUZ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593027; c=relaxed/simple;
	bh=202CoQ0z91pOxwviqPgE5xMZhnjJQnTbOY2y30J0u1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQVCvJqaBhzRAdUZ4tp2sOfktOdde2u/SruyAZ7cXLaXP2ine/TRrg691r9X6QUY7j5RpvMYKq4TGhRCvunEe8nC9I6nwgJBvgGBr/42cAuCBQOaZ+j6cHOJMM3dazqWOOlOgED3u8KqjtYe0rDPp5zQpgaV9cudFvwLrheB/og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhBMgy/P; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhBMgy/P"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42153115c65so15308455e9.0
        for <git@vger.kernel.org>; Wed, 05 Jun 2024 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717593025; x=1718197825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=56LPKT7RZUO+UT2zPkqBl/+RWbQ0CJqazi3oLJEjjS4=;
        b=BhBMgy/PgdC91uLusl7yeiWE/TyYBcWFaInGSXlAV0L82ws+ZnYbpUhQNvq7sC6+iq
         XTe9wPz0NKlbNORZi6p6jOIN+7YJk+ydq9GFH783YOIrwfFkJJekVJyfszJ6noIObR+y
         yjy0eVisn9Qtf0QOyRtfZk7Y8NR3sIH9B6eouHk/YoapXOVdf4vh6vNGyvJtmoA+lAxR
         Mfzk0i1XQoysIgRRnzXEirdccMwUcyjljl+oFnx0CYqEAG/F4IryIz68mbXeR92ZwzDw
         meBwGIsJRoTIAp/lCELDQUExMEbR5X/7CkFcl0431H/1iE0J6qRAW1y9sXPTf9ejmCWA
         DDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717593025; x=1718197825;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56LPKT7RZUO+UT2zPkqBl/+RWbQ0CJqazi3oLJEjjS4=;
        b=GI0IIZ/bDExAZde50S+h6/fFp7pb8pO8JkOwzgm9WoMw8/BR1ai+m7xZx/n5ZAvQFk
         wmZ/c0DQ31Thel319d8L3EiWQGRuBABQ3uoFFnvOKmkc+OOwiP5NbAeA8uXo7QeNVUPG
         bjMIEbhR23aGQ2wQyFPFhK9KhVY5rmsAkmx5t1Z+OAVsmm6dPQSMAVGgKmsOC++yXB5A
         YQAzW/cH/Fo78VW2FU5XntXXUYr9DmP6bgcx+/bPq9CfsJB1OG2yoDKM4NkwnMoolGm1
         8mNvfo1PuhS16PlvXBmX2W32sVZcVjwT6YOkoxnpCY4LKvTUoNUtRPbMEtT5yymVWLXq
         a7bg==
X-Gm-Message-State: AOJu0YyzOK3Frf6L2AuSYVkAUYQZ6ETUYxysTZpzqNnsXVc+1wolkz36
	wxkjJ5Vt8EKBOQbiPfQjxj3C9yOA6yJ1/h/yT/LCfZZjfoD1ThvT
X-Google-Smtp-Source: AGHT+IHHSAZOTTtSIyiKovUmr1S/mPYQMPrRAfj9fZAefSS98ich7k+4Dzu0q3SwslURL4h2sylvfw==
X-Received: by 2002:a05:600c:4455:b0:420:1a3:dd04 with SMTP id 5b1f17b1804b1-421562dd431mr18404855e9.24.1717593024456;
        Wed, 05 Jun 2024 06:10:24 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:641:9001:d2c6:37ff:fef6:7b1? ([2a0a:ef40:641:9001:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35dd064bbb1sm14479430f8f.101.2024.06.05.06.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 06:10:24 -0700 (PDT)
Message-ID: <7ae05b6a-fb63-4ec7-8006-e968862cc5c7@gmail.com>
Date: Wed, 5 Jun 2024 14:10:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] date: detect underflow when parsing dates with
 positive timezone offset
To: darcy <acednes@gmail.com>, phillip.wood@dunelm.org.uk,
 Junio C Hamano <gitster@pobox.com>,
 darcy via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Jeff King <peff@peff.net>
References: <pull.1726.git.git.1716801427015.gitgitgadget@gmail.com>
 <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
 <xmqqwmn66zzc.fsf@gitster.g> <2d771a72-3021-46db-ac32-e008a7ace34c@gmail.com>
 <67c23773-21a4-4ad5-9b98-5e44578166dd@gmail.com>
 <4574e410-ca1a-495f-9835-14ee3fa454a1@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <4574e410-ca1a-495f-9835-14ee3fa454a1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/06/2024 09:48, darcy wrote:
> On 4/6/24 00:13, Phillip Wood wrote:
> 
>> Hi darcy
>> On 03/06/2024 12:44, darcy wrote:
>>>> Do we also want to check for overflows in the other direction (a large
>>>> timestamp with a negative timezone offset)?
>>> Is this something people want added? I am happy to implement this if
>>> so, though it wasn't my original intention.
>> I think if we're worried about the date overflowing in one direction it
>> makes sense to fix overflows in the other direction at the same time
>> especially as I think that the other case involves a signed integer
>> overflow which is undefined behavior in C.
> 
> That makes sense.
> 
> Though I am reading the `tm_to_time_t` code now and it only allows years
> up to 2099.
> 
>>     if (year < 0 || year > 129) /* algo only works for 1970-2099 */
>>         return -1;

Thanks for taking a closer look, I wasn't aware of that. Reading Peff's 
reply it seems like timestamp is actually unsigned and as we limit the 
maximum year to 2099 it seems unlikely we'll overflow from too larger 
date after all.

Best Wishes

Phillip

> I can of course add a check here for dates close to the end of 2099, but
> it seems that the bigger issue is that some day people will want to use
> Git after 2099... Should I see if I can extend this range? I'm not sure
> where that specific year comes from, it doesn't seem to be based on a
> limit of the size of `time_t`, and the comment or git logs don't seem to
> provide a reason.
> 
> 

