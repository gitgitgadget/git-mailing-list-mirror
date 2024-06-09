Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BB62233A
	for <git@vger.kernel.org>; Sun,  9 Jun 2024 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717943380; cv=none; b=txWX8cn+gzxCCSXfgt9H4htQPWjvSo1t/p4VpS1hey4xP739jmlDjBg4rICkvOTHoqd42C0U42HuoW0rvl72pfajpX/6pjr0KvJdKVt5tNorSYUeZnhpQVwVMu4t2snpSPZ7rQaK48HWC1+XNfMoChG0bu8YUTxVspGQM3xefMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717943380; c=relaxed/simple;
	bh=GQCWx56uNjtPGGnYm3aB1maRtAJjs+c4Nvz2bQvUR1w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tKe+fGRvsIzcxnGcHD04hGtFjT5JUiMKQmgxdfFtkkstLVIkVagooVT8C788QbXNPDWbegDKoZJ/gfnDRfH0jYkrDgPh8ZPbMEwGbZNMTQDipg17bBdqFJzI/J6JaLOZI47U2PnHXJxywF+5bV+HZslvmVl9MY7n4Y442pnVlTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCHWGGzx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCHWGGzx"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-421757d217aso16535915e9.3
        for <git@vger.kernel.org>; Sun, 09 Jun 2024 07:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717943377; x=1718548177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kA0dy2iK5iWpHF8KNGDSdDPl8zfiDGnH8fZHAZzMl8g=;
        b=XCHWGGzxAFYb4mJTtG5UD7lLDu+QdPGkt7YW3W7El8c0uKYchfnYoH0qRl7FOb6ovK
         FvLlnxT8faNH5/M7O2PxQBe0KEa3eHnMhlq8tHyl+eRfcx65CV6Zkk3Lfel7GMjyl1CC
         xbcQMKCteT8mO0LjRgUMhuH1bpMxrDSbolyQjuaGJ6WyTEzvWy2vZehRphNmJEaTaSGt
         T9bCvd7/gEOIDweg4S5L8hMKjS0eAw6UA4y+TM4ItM9KgAT1X7vDpprIFWsHqwOw05VO
         Qj/nM3k4g6jqXfNdFMaeDmdUg+ub5HQb3U0Pf/VJoEjfGFC07iO8kDq6QWA9hmDt7rgs
         A1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717943377; x=1718548177;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kA0dy2iK5iWpHF8KNGDSdDPl8zfiDGnH8fZHAZzMl8g=;
        b=q/Sv+u+yoLShFBrn5MiCKJTRjUjw2U6sjrDekSCmM/rwMawXpFMfmLCfEhn+GrFqQ+
         lUyRW6xJA+CDl6LFX+WYNhqEGJBGqJNTl6IioxkI8O8FgxRyZ3Fx7y7A3jM3Y3KeHCVJ
         IYRmIxRLQpXoG3L6NXuNi/2p66NXVHzW4gOAlwURCWJlNEIaiqtpY3qdCR9lfUCS7W3V
         nRkOM3vN9GFQiGiQzEyoSMsS1ygYGwdvwUV7cDXzZq4wDLPUltD4WY4uolvBgbXsW0iJ
         JBfehiZFrXJfk40UqD5vTZ2UnjKLjDzH/FBgF1HBt1HY7LD1CnfkbwMzVkpdp5jDBX40
         lp6A==
X-Forwarded-Encrypted: i=1; AJvYcCV6ABg1+2qO8KrdfMotuYPt3ngUeoQAbDCy+gk40xur5jvUI/MotIGD9rOqUkfrmofVzSSlhRNSqWebxS+fq6FcKFVW
X-Gm-Message-State: AOJu0YwzrLh6CphwMg9Yt8QKjZcOrZeTukvaIHMLScl1LBAh00npLBAe
	X9NcEwvaNDYLWJGcrLDZ8eJeF82eKfG85J1Wusc1YOavEtOjxjNg
X-Google-Smtp-Source: AGHT+IGsG9lSUX/AtjBgYnjUTyAAq14OZv8BXnxA+POf7ve8hNpRekoX127uSRymnkIG0TQZRQ9Meg==
X-Received: by 2002:a05:600c:4f4a:b0:421:2dae:24c4 with SMTP id 5b1f17b1804b1-42164a2b14bmr81811315e9.25.1717943376773;
        Sun, 09 Jun 2024 07:29:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:641:9001:124f:b55:b414:cf29? ([2a0a:ef40:641:9001:124f:b55:b414:cf29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c19e97dsm112576765e9.5.2024.06.09.07.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 07:29:36 -0700 (PDT)
Message-ID: <a2a59f5e-fd55-41d3-8472-b99256e1f428@gmail.com>
Date: Sun, 9 Jun 2024 15:29:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
To: Dragan Simic <dsimic@manjaro.org>, phillip.wood@dunelm.org.uk
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <20240604101700.GA1781455@coredump.intra.peff.net>
 <xmqqikyo207f.fsf@gitster.g>
 <20240605090935.GF2345232@coredump.intra.peff.net>
 <6056d585-6380-43e7-adf1-9f9aadd2a7db@gmail.com>
 <a8d3415e3913e3a0798a748ed7f7a093@manjaro.org>
Content-Language: en-US
In-Reply-To: <a8d3415e3913e3a0798a748ed7f7a093@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dragan

On 08/06/2024 06:54, Dragan Simic wrote:
> On 2024-06-05 15:21, Phillip Wood wrote:
>> On 05/06/2024 10:09, Jeff King wrote:
>>> On Tue, Jun 04, 2024 at 08:32:04AM -0700, Junio C Hamano wrote:
>>>
>>> Given that the main use case for "|" is for human viewing through a
>>> pager, I think the colorful, filtered version meant for users is the
>>> best default. And then the "bare" version can come from an alternate
>>> command or a knob.
>>
>> I think that's a very good point. It is hard to see what "|" can be
>> used for other than viewing the hunk as (a) git does not read the
>> output so it cannot be used to filter or edit the hunk that is applied
>> and (b) we pass an isolated hunk so the post-image offset in the hunk
>> header is likely to be wrong and there is no indication as to which
>> file it comes from so the program being run cannot apply the hunk
>> itself. Having the escape codes does make it harder to filter the
>> hunk. For example to just look at the post-image as one needs to do
>> something like
>>
>>     grep '^[^-+ @]*[+ @]'
>>
>> instead of just using '^[+ @]' as the pattern but the bonus is that
>> the output is colored.
> 
> Agreed, but as I already explained, [1] only when using the bare "|"
> command.  When "|xyz" is used instead, the version of the hunk with
> no coloring escape sequences should be piped to xyz.

Having read the message you referenced I'm struggling to understand the 
use-case for stripping escape codes - what do you want to do with the 
hunk that means you want to remove the color?

Best Wishes

Phillip

> 
> [1] 
> https://lore.kernel.org/git/844704794168f9fcb85c75014c84cde0@manjaro.org/
