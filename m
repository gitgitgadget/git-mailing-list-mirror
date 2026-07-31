Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B62221FB4
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504401; cv=none; b=oO5CLPR3r/SumM/tZZOY+nz47I9FbVOMUM0tDwrbsg7fxhfBAZzuqeMzjV4YqmBP+pgU3cF+tl00rEpCnOabpVrKbHK7lUQTxCJ7AnR7prnzigYAUpEBnI4q+ZO32Nk+gXhbUDzRi66QFilsYCLyIByuhoXPVqGP7CoDZsWyaJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504401; c=relaxed/simple;
	bh=N29prjsg7AiaYSAK9U0v84uPt6XmmhPyc13dznrqVxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UdSwYYpC8MkDc7tkn1plx26ounMs+8q7x9gZ/dRSA39NVo6+XIGvNkx4x6oOu8Pg35VHU/K46jOesioXQGCfReRAoYA6vfSnoUiVv0YwItyY02oFzvQt9LXvv7ntbcubvXEHPEgpmj9b0XLX/bTBHd43j0XRiKojYRSvr1/OXx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7Bu5nVY; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7Bu5nVY"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8f23e851626so6649496d6.3
        for <git@vger.kernel.org>; Fri, 31 Jul 2026 06:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785504399; x=1786109199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xSHp8JQO57z+Poend40aFLeXgY9qX2tuNFsSAvWMR+w=;
        b=r7Bu5nVY/+ykSEMYhxXmIDZkHC21ssDNF0Nrwu2jZStO2Q3zZnAYUWmpd43FVU3Gft
         DH9JGL86YtRKLUyZm+oazvvwKq3f1Qte7kOaeBdTppYgU0SDFvpazQSVfI5dYrJ0yoeU
         ka+AJJp/mPjeVr72jjTBCpYe0nz4QHtxyaZJQ1yVxbx3OJZV/xhrqtkE3cFQYAkbCTPK
         FipT8SKPTKVM4bpEveasf6mMpVVW8lmhTMoJ+hhAs+w5q3rpRTWcxfnrcKHQxuG781Yp
         c0r63R/VY6kobZ0xSuttmZ/m/YFEHIurnEktSyxgIOf62YSFQ58g8Aob9NQRPdn8l8NQ
         vnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785504399; x=1786109199;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xSHp8JQO57z+Poend40aFLeXgY9qX2tuNFsSAvWMR+w=;
        b=GwZCgnlEqrsXl17U+5Z/PeDs5qhrQqZt1BscUZKSvhKisFIAwebyuwXqHn6mmv3hHn
         kRBbStWVB/HfIMhLMgQKBuUcDcNaA7swSTY3KIySXcekaK42DoZNDE6V0uIp2aCctnIa
         TQPA2JyBwsKOpaDgLT/3xk2oV4u0GzK5hYqF37vapPAzfmaQN8VlI9+WftBvQHCOjXUQ
         MJ8Y9W62M6kJY5XrKRvwocEyq09zdjDqZynWfE/KRYTkLHeDkWx3URqRPPodv9Xb/1Ha
         Eo+1ctaNBZpr/DPzVd3FrINosOkWYAi4Y9sEV08JhYE6EVSsr8zUrbLNuMLe3OZZ2fwz
         eL6g==
X-Forwarded-Encrypted: i=1; AHgh+RoNKsfHIqVo5uUlXUNp00T0lbHUA2lnBXWiCjZEZ9PcPZa2ILxiohxPk9RKOZariB7ft5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwllUtB2+5sRnnEpfRRW7/EQHGZlywr5x1KQgJIH4fKtdOPcZR
	fSEpfCpYwQO9ZVGjdEJwk6Quzij0Z4S1TPA/BnxAqrmfLAOQRWKkppYNjFe5lQ==
X-Gm-Gg: AR+sD11C1Sv9iuHEMy0FdE/mXGxB77p2aS4ekwFvyztppG9qTNWKpqRTbV9/JmFIydJ
	RKn9UygTxy+qmw5WnfsKyYKwDBeRTN85HBmNuuItTYY4epQ7ITv8Ap60BRSaigfGGts9pX2Dn1h
	FarwApT4bI0KzwVtAhnQyjVwslAiskQ8FdMC9dEXFggN0f2byRxGUc50xwgr9bQmT8vrVNDPBZz
	4h5H6LuPD+VG3hzNbEMFyVrqAEMZQo0NEPFiT8gC34sG4xKEVLb3mOtHgiWuJcMbM8i06p1L12G
	ZVCMqgvDE73pywcQ4DqGctAjGt1K+Jk3LR7CtWki4D5UMvHAUdxaFyOYlfU7w5cPuMR0W6W0Czx
	kep4FdvnOG0RbEOw9GB30ATPVKDKy9Ex7ubNqlWQnNGQ0pptKSltq0hW5T6tcGGABuW7CZchBuV
	bI5aqatGgZB2LpKyNT+kBNMj1bK4hux7KFhU1e+CH1lDmUZ8HY2iGkS+O3OOx7XHttgnv2X424u
	/IWk6r6rympRnkEC0leFLTfD1/ElIz7elZWCCTsRW2g1bln5rjL7DM+ImIVXCm6JRXYgqe8TQFO
	GspRy/bqE/+n7Xo=
X-Received: by 2002:a05:6214:2f8e:b0:8ff:6304:da9 with SMTP id 6a1803df08f44-908421dac41mr38798456d6.6.1785504399295;
        Fri, 31 Jul 2026 06:26:39 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908432a0d83sm10345656d6.6.2026.07.31.06.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 06:26:38 -0700 (PDT)
Message-ID: <fbb118df-7c82-49a5-90bb-4458b7e9a850@gmail.com>
Date: Fri, 31 Jul 2026 09:26:38 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] trace2: tolerate failed timestamp formatting
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <ttaylorr@openai.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
 <alpXW5U6sndZtgqV@com-79390> <c8d443a5-3cfb-4752-8716-cf0d8fadd9d3@gmail.com>
 <xmqqzezlhgyo.fsf@gitster.g> <xmqqh5lho4xc.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqh5lho4xc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/29/2026 5:35 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>>> Would it make more sense to fix the xsnprintf()/libintl boundary and
>>>> treat Trace2 reentrancy separately? I still can't explain why the
>>>> allocation failed, so there may be another GfW-specific piece I’m
>>>> missing.
>>>
>>> I think that your suggested change has merits and should be pursued.
>>> I'll explore it a bit to confirm.
>>
>> That band-aid may be a good idea, but I would prefer not to see the
>> conditional in a common source file like 'wrapper.c'.  Somewhere
>> MinGW-specific would be more appropriate, would it not?
> 
> Did anything come out of this discussion?

Sorry that I've been unavailable to come back to this thread, but here
is what I've learned in the meantime:

* Taylor's hunch that the memory allocation is more likely at fault
  is seeming more and more correct. When we fixed this issue, other
  issues around memory allocation came to light.

* For that reason, I'll rework this patch to point at the allocation
  as the likely reason the parsing fails. Avoiding a die() in the
  tracing code is still critical.

* Thus, I'll also replace the xstrdup() in the trace code to avoid a
  die() due to allocation problems.

* I will take a deeper look at this wrapper change and how it might
  be done in a careful way, as Taylor says his patch was an example
  only and not the "right" way to do it.

Thanks,
-Stolee

