Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF01A25A321
	for <git@vger.kernel.org>; Mon, 25 May 2026 01:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673391; cv=none; b=FeAZlU4E7QZ5WllKzr4JuFMAarZS/3SGVLRZM4ePH8DAEW9pgVC+vhJpzt2d41P37yqVFk5epsfN9q0jD4N4tFtHOjhaM23wanY/hOyHgMNSh9vXxzZOZA0IZLjG0aBS6rHQepwMOeFYqW3tScBxj3cMO+x5msAWGDsoRQuPMIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673391; c=relaxed/simple;
	bh=Il59Du6ctDV7bDQ6zAyq5vfJK2d17ykv7Mqq/iZFgv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SkNV3RilVoLA0/XNf1baYpY40CtScPzSzMAPtTNHzq3SHyJtvLMZcFl36AFPZGnhM8Wt3EfPyTzMQKct0TC+zehxrD2a8nfAWQYmOl0HtMVUhRxl/eTNeyYaPsaFvp3YTtFAL6/rnxkPJAxuQg0nlIYgCxnLVMLBKmptzD4w+Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jd6O4AkE; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd6O4AkE"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-914b5f85129so244278385a.3
        for <git@vger.kernel.org>; Sun, 24 May 2026 18:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779673389; x=1780278189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lif4zJAprRVK8s99IaW9DbQJYvUKpREhfEaszx0UB1A=;
        b=jd6O4AkElx/PGBOOFU7R7uJDo5CrclgasWiRQ0iYSbPhRA0LsFJULfj+PU8Ld7E/YI
         VxBYo2em8hweN+bQ982LD53KmQpZUNPIq93Ahxu3UYmYd+zhkhnF3H8CrzLolP/qMHdx
         YD5xHxTK2XVW+R+vQ2UClFjUYrMqAtcTx6T9BL5yWUpUcrpIQHyQmAiQXEwUAd9k4hqw
         mBbWdVP2lbg9pgtdGEtRLg0qNLWBVMcYARPWEYUREAb1eqt3+ycE3plTkgQaccKG+r/+
         9zCenG39Xi/g8Y7lN3472K1kZYTzDIV0a4Gltwnax/BjIcLZKDX776lkhcJPw+Ypra9o
         96Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779673389; x=1780278189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lif4zJAprRVK8s99IaW9DbQJYvUKpREhfEaszx0UB1A=;
        b=OSXrY05lOzeBD3SG+dMqeIdUqRG0xXmE8nEhNesjbPdOWpOBdCrS6FLyTXgBLhD6VQ
         efe3xztYYnwykNTb+Z3htRVJLHnfH9kGd+xS3Ppjd41vxPxbk0m8l+vKkE0osTsCSFhy
         N/QcmGbpGbcA9LHgXjbPrbtaXqAsui2IrCRfoySToIcBdGj9E9Cwuz6UN6Z6VN3jBDIe
         ALc8Hf8GFoIBzfVBIVJ2tsbU1N4sIOTmz3Vn87pJlxAbmYs1mvjzt1a/EvQU7LnI7MsE
         6LCGXEv7Lr/y1J6OIw6zs31qd7yipk85jm0836u5GyKvqEDV9P/ITZk5M+rW662+X240
         sq8Q==
X-Gm-Message-State: AOJu0YyRXx4XMb881RkANqyU+nxA1v/T9joqaDP1l1fA8psOvGLJ3B2C
	TV+t2s2ew2X3jiaJMwa56GfdVY08Mm4HNFkhJ/BSZV4HI4BC4kMSJp5xaYirVA==
X-Gm-Gg: Acq92OEG7fZI/wmWPBaGJFnHurvqCGjy+4bTnzM606GR3XEtvGPOksB1ylhWWNLX9Yw
	WFmD7q6Paab+J4tExvxo7mZYoiflTBtPlAZQGbleci/In8j2zJ7s90DWt1P1gsdEJuzkYi2bC9f
	6dP2sztk736x+oqVgHvJwjdnbXPUdehzQ6yUxYS7YX2orhYNlBLgwO8BCpOUy3XIdGQRWOnAvcb
	FWx0FqJyrXKIsHakggfK/kfSjPyq7X/8stN6n0wl4KSaNDeFHkXz2oiD1OOzA2nrhYDvBEPiWya
	NJNUEXTf2jLTxDIpHJ08GGmNA0bMrrwwUtl/OMl4e89hlhu4Q9a39/l/JTVaqctQrfAuHvvdBCo
	uEN8Io/KT37aay6ZYI0vm7JY8u8kYnrzNmwDUs3dQ76zbbmNHS8Whmd9BqC6lQuebAiKjTjexXV
	FuuAanyAOp6kQpkFNm4FNKvMasYBVqS52N7BxWaTid9oqxl98sb+y8TlVjXVpQ8T2VuqyG1op/k
	CyTvFkx+YYBwOMv2UKavYhdj61LwtT3utfDhPqixctXS3qI2zU=
X-Received: by 2002:a05:620a:6404:b0:914:ca75:e8ba with SMTP id af79cd13be357-914ca75eb1amr873185185a.52.1779673388818;
        Sun, 24 May 2026 18:43:08 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:4178:7958:947f:ef4f? ([2605:a601:9b88:8300:4178:7958:947f:ef4f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb9d5d63sm913091385a.30.2026.05.24.18.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 18:43:07 -0700 (PDT)
Message-ID: <ca39c8ca-ca4c-4954-a1ab-633bfa55f64b@gmail.com>
Date: Sun, 24 May 2026 21:43:06 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] commit-reach: deduplicate queue entries in
 paint_down_to_common
To: Junio C Hamano <gitster@pobox.com>,
 Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
 <1d3751569ba3a5f0c353fb468578d6c5bcd0b738.1779644541.git.gitgitgadget@gmail.com>
 <xmqqpl2kgyvy.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqpl2kgyvy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/24/26 7:40 PM, Junio C Hamano wrote:
> "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
>> diff --git a/commit-reach.c b/commit-reach.c
>> index d3a9b3ed6f..c16d4b061c 100644
>> --- a/commit-reach.c
>> +++ b/commit-reach.c
>> @@ -17,8 +17,9 @@
>>   #define PARENT2		(1u<<17)
>>   #define STALE		(1u<<18)
>>   #define RESULT		(1u<<19)
>> +#define ENQUEUED	(1u<<20)
>>   
>> -static const unsigned all_flags = (PARENT1 | PARENT2 | STALE | RESULT);
>> +static const unsigned all_flags = (PARENT1 | PARENT2 | STALE | RESULT | ENQUEUED);
>> ...
>> diff --git a/object.h b/object.h
>> index d814647ebe..05cbf728e9 100644
>> --- a/object.h
>> +++ b/object.h
>> @@ -74,7 +74,7 @@ void object_array_init(struct object_array *array);
>>    * bundle.c:                                        16
>>    * http-push.c:                          11-----14
>>    * commit-graph.c:                                15
>> - * commit-reach.c:                                  16-----19
>> + * commit-reach.c:                                  16-------20
>>    * builtin/last-modified.c:                         1617
>>    * sha1-name.c:                                              20
>>    * list-objects-filter.c:                                      21
> 
> Not directly the fault of this series, but we'd need to audit and
> update this table of bit assignment to match more recent reality.
> 
> For example, there no longer exists sha1-name.c but the table claims
> that bit 20 is in use for its own purpose, and it being stale makes
> it harder to audit and ensure that this new use would not crash with
> these existing uses (note. there are other uses of bit 20 in other
> subsystems).

It would be worth adding an update patch before this patch, that
only makes these adjustments

> FWIW, object-name.c, which was formerly known as sha1-name.c, uses
> the bit 20 as ONELINE_SEEN bit, which is used to turn textual object
> names like :/string (i.e., commit with that string in its message)
> into raw object name, and bit 20 is cleared from all the objects
> involved in the search before the helper function returns.

This appears to me like the only interaction that _could_ have
overlap with paint_down_to_common().

> Presumably, once commit-reach.c starts queueing commits and reuses
> this bit for its own purpose, we will never try to parse a textual
> commit object name to clobber what we thought is ENQUEUED bit,
> breaking the code introduced here, so we are probably safe against
> its use.
> 
> I didn't check all other uses of bit 20, though.

FLAG_LINK in builtin/index-pack.c and FLAG_OPEN in
builtin/unpack-objects.c both seem to be completely independent from
this use in commit-reach.c.

Thanks,
-Stolee



