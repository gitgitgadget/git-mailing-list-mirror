Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BA943849D
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108587; cv=none; b=RYr/vNAs6+KEV7O82Y+HSjmB/5q2nG2eDRXT7iPjRnAP5Ul3jXPFk8aQrelo05Lfo4E1Wuchb3J0XUGtkbAFYqbarhMSeZJcADOiIIWhx4BwDj+M7xHa2uVgmnQv6opKphkbHB0q0CyFKzVrm/YGkR5FMu5Xq3GbgD/RGO7nw7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108587; c=relaxed/simple;
	bh=QcI3jokbi3XREoC64GnoP9Tqfvii962XYoLzHlbMLxU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mFvlfU3TOM1VOaKR5LIJXbIeLx1mCF9/vX8aRLjUq176hqlPpgp3P6SlQwx757bfdLGx2V+uQ09egpmNjG5uLL2lxi2QXItPteJtuzNf459nvSwsk0gwQ84cBsHq30bDIaOfE7YsCVBV4nAQxWydXKSOQFKvSriwPfkLHbQg/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7RLEKtu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7RLEKtu"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so11377055e9.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 02:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784108577; x=1784713377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=in/4TfWSybLbwefza9EVGIU26tXidv1MJdEf16oeimw=;
        b=B7RLEKtun+dRBxWM7KxVzkDXBoFw5wQ4vvN+1CRBWk3+7jXLiRlBlONg4oET18Szk3
         oR3AClcVkSSlwu6BDJqidvFIp+BouF2wAzqZYW4z/FUSfza6Avby/3ndYI1g1iWISEgF
         h99obJIztDRcn/0An43+NX3r3GrxFgv2e5hU2UooJ7GZ57MlN+Pl2N1Touxn5PkeB9C2
         9YA2D9cQD51veIN5QES9pHmzVFST6yi2tIqHcdy8WVc9cg6QJ3E6zsnoyV3FpTnzS04I
         H3l3ZS9Txsx9LTsKfnOKPmbvY5zGkYGJpbzsmSI7YrTlP8rBScXPZQaA2zAxVOlTm0U0
         DGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784108577; x=1784713377;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=in/4TfWSybLbwefza9EVGIU26tXidv1MJdEf16oeimw=;
        b=Vx/aVlr8yHG0XajWN9D152BLXqJ9ZGhe0cYFuXFz3D+Jll2n+T5QtblpnZdNZtTyRz
         48CMXDBMCsWfECSpSxMO2tAf2tMw+PUB1kthOAtnA9GeNT7dLApbPL3XtKC4BBNZZIXB
         rBPUNnGxXtKnhtgAe/IiVkf0+xzjmO3k1w39Y6e4Q8MWrInf+8zQSBvNfOTAXvETj8c7
         dDtLpNgw1raaXrBjWPTYQ/VzininT3cKXTUX4PIyU9KERMfWN7SR3/2ZajDjLhCfZw8R
         ko73Lcnchr1FPuYL+XkCrySqjAemfkTn0/b4OgJ26pTWi2VgSEgcXinw2nToboQe34Nk
         qntw==
X-Gm-Message-State: AOJu0YzWgcfr8bCGrFmfTu03KvclXlLkFHvHYKPJFVoHQ9BR16oNKsL5
	DeP7zajyC5IXkm6AnWUwv2ISu+seWaONKHDGg9/BQHj8Jp8WwWOM/3Cs
X-Gm-Gg: AfdE7cn50v4DyBQozK06CuoaJB0ee3SXtTRka6xE6WPhKVzPBaNzbKqtI/mCEhmPU1A
	Io8zZ9hjsI/yABZ/D8/i+ri08ykQLZXWM4qPzQ+K9+gp68TYEKayrDP4pSK4IAZtGAn8cSX5ioc
	IGMJvGQWiFPVvuDEt1wKe6YID3GGnUTaZeRxsb+TS5H0RRv7D6huL+/NwR6dKlHv5IsORpcwP1F
	3qeLsd55nSD5oSTu2AOrSeLyjPwOT+RdfjYQ9gN1LBV8rqtQHssnxeW+an4kZp9oLV9eFVkyaGC
	GSE/cEftSBAdUh2NvnrbjsmHW5FZX8ivKl1pG/t812ALNHBO4Gmy9kd61Fndj+nN2WJlbJQLsTY
	0Q4GxhhZmPP0a8mzq5ytHw41bo2+/6Bx/ia4EHyVLtyu22ZCo0/x7eNwF9SvVeA1J86v35DSeAx
	pgBAik0557c3IO3zK8LwsEWKVSLSt93VWUOwoyQzB96oe8g1/LsS0GFB/Jg/wC1qonI3k=
X-Received: by 2002:a05:600c:8217:b0:495:3c6f:7c18 with SMTP id 5b1f17b1804b1-4953cbdc5a5mr18955995e9.3.1784108576552;
        Wed, 15 Jul 2026 02:42:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953c6fe0c6sm38286425e9.1.2026.07.15.02.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 02:42:55 -0700 (PDT)
Message-ID: <6cdccc2b-c0b4-497f-8408-a18bd0981505@gmail.com>
Date: Wed, 15 Jul 2026 10:42:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 03/10] sequencer: be more careful with external merge
From: Phillip Wood <phillip.wood123@gmail.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Junio C Hamano <gitster@pobox.com>,
 Farid Zakaria <farid.m.zakaria@gmail.com>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
 <cover.1783948637.git.phillip.wood@dunelm.org.uk>
 <3d79362332c1208eed1fb7f8b0d431ee92fe45c5.1783948637.git.phillip.wood@dunelm.org.uk>
 <alTvtOc39bLR4ocx@ugly.lan> <58c488c1-139a-4b56-9f80-2492b081f659@gmail.com>
Content-Language: en-US
In-Reply-To: <58c488c1-139a-4b56-9f80-2492b081f659@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/07/2026 10:35, Phillip Wood wrote:
> Hi Oswald
> 
> On 13/07/2026 15:01, Oswald Buddenhagen wrote:
>> On Mon, Jul 13, 2026 at 02:17:20PM +0100, Phillip Wood wrote:
>>> If an external merge strategy cannot merge (for example because it
>>> would overwrite an untracked file) it exits with a non-zero exit
>>> code other than 1. This should be treated differently to a merge
>>>
>> s/to/from/, i think?
> 
> Both are valid - the internet tells be "different to" is more common it 

sigh s/be/me/

Phillip

> British English, whereas "different from" is more common in American 
> English. I guess for an international audience "from" would be the 
> better choice.
> 
>>> with conflicts
>>
>>> which is signalled by an exit code of 1
>>>
>> parenthesize, and add comma?
>>
>>> because as
>>> the merge failed
>>>
>> (maybe add comma? here it becomes muddy ...)
>>
>>> we need to reschedule the last pick. The caller
>>> expects us to return -1 in this case. Also reschedule without trying
>>> to merge if the commit message cannot be written
>>>
>> add comma?
>>
>>> as that prevents us
>>> from successfully picking the commit.
>>
>> i know that most commas (and parens (or em-dashes)) are optional in 
>> english, but they _really_ help parsing complex sentences, because 
>> they reduce the amount of "read-ahead" required.
>> i'm stopping at this commit, but subsequent ones could also use the 
>> treatment. i trust that you don't actually need detailed suggestions.
> 
> I've added a few more commas to later commits, but concrete suggestions 
> are always welcome.
> 
> Thanks
> 
> Phillip
> 

