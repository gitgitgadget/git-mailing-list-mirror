Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B82AF1E
	for <git@vger.kernel.org>; Wed, 21 May 2025 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747840837; cv=none; b=MAPQz+x+QWiGHgNaOCYg+cBWDSY9Q7CtybumExIN15lSe5NJQux86Bp2vzAiF5PDRGapUUxK/qezY58m8r46RGHSK/s4PHDsDwP9fdxSTpJAstqOjjAchakVc9WO1n0tkUKEeUw5VfhsIpxsKeZNTmCokJLkaOPYi6voXkpU8IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747840837; c=relaxed/simple;
	bh=kkNLDEkbdrdqIo63v/RfC/2avYPkSo94NKKmcrqfVro=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lmZwAnvWGI5lN8zqEHdLhuXBcCHHc73zhhwDO85PdFrV8ssckJG8TdUFr5giGgjT0L6e7Me64eDq53yWaZZ23oMiGK1g4wRSYlzYITF5aJEMOe/nJrUCp4PjZwqa9S/i4i+6F2OUCr1LrJUmwqC226VtN02U5B6eVpjp73XBnIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSBBM8MB; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSBBM8MB"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a365a68057so3903571f8f.0
        for <git@vger.kernel.org>; Wed, 21 May 2025 08:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747840834; x=1748445634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rR5ytDhV7H47uLQq/SjwwcyBQ+REALHJYxiI5GqPsCU=;
        b=JSBBM8MBGBEkKhD+ew6lCEc6RN0R1FXPrZ1syJ22/k9HwcwCCNH6Ml6y88t6KmwVfA
         j4i36lJ/42sSx5pCnYJTQb7CivtHWXo7f2ZA9Zy4w/I8hAfy7RDHZ+oQatpM/UdJPzVO
         CcSFLlhI0tDRaH3AeenEeGpmYviulC0oZufK+whVB2CDFus93YxFvnd4hPve/iMTqz4R
         ogDJuWHFN0Dxz6oeElCozhryijMq/qIgtwQNZ14wCnWElYDOHd7W+A+c6LXtlwSIKTta
         VhILyfRE5leN4bWf5fW/raR08YwpDgsDC7WPoHJIgPaXaqAPq32RnXeB5OYZXaGGYyiS
         u1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747840834; x=1748445634;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rR5ytDhV7H47uLQq/SjwwcyBQ+REALHJYxiI5GqPsCU=;
        b=TMI8jWSuosWiis5HubxPMqyTWXnRjdtzAZSd1iSqHn4TweseV8ubKdyq9rdlopaKj2
         btNgy3FFs6j2uXULIkxJKtxnZ5rBw+DXABerkDjC/uwzgRM1YINxkeDTmwY2ordC5lOr
         D9unRK2y/r0uYL6kxKgj8MJ90+kAq2909VsPGawKJZTiVgXXFFdfR/C43DRpyEfeaYPn
         8rWEStI7ItzWJjTWVV9s6If2tyCoDT4omU3AJtEM8GFcQWSO3wkxRd7rV/XunBtrivLf
         yz+l1RCG37yoXBBrX4rhi1JH1DjOB2T8ho5BTYCbI/dXeZ+FXp1iUmf0XYqMCmvP0jzz
         g5PQ==
X-Gm-Message-State: AOJu0YzJiwJ40Loye9Gg+NYMdtZVLZru7U/NP2Hwc/ZnCOgm01QQseI7
	3JEQR8bkQqOJBUtoHwH3WXKdgPpp3E1c9MEmxMuE0Qy/YDBLXXEl/v0Z
X-Gm-Gg: ASbGncsdcVRO/ZhMvlgDTWsD+Gf0DT0cBc339WxU4BEb4g/TLDyQ5FB7uf7RCfoBVTu
	toJjDsxPT4064rslIsZAoQSEZuHwKcpxSMe60EgdfPY3zoAL80prx7df484oU3XO8VsZN4OUgP3
	mbMc1HYtaLWnzy3/xlqFtcfcszdeTB34RDr2HAcrh4QfoOvHFQ0fxfsekk/pSOVO6Ae8INMvf1a
	2HaQX0i+8JQ0Dk/zcZb5EJr9dkLTwt7bUyNR8wuQaQVb15wRasy+DvJTxxEWHfFZcXWzb8Yy0iS
	LhPWJyGUj3rjXrgwP2tFbQ8//6KEBOE+6odOsgpyJgoJwheqbRtvQW4qcpeapu1vR0dbZsdAYKO
	9HPA9oh1UxE5zHYiMGdu5pL+tdP27mthlR6Z+Lw==
X-Google-Smtp-Source: AGHT+IEoUQFXFe/ydbrUBW7MRVcNuwbocO3qaDq8SxXXZZm6o7uhdXSVMH6WctlXpBx27ObRVFLRLQ==
X-Received: by 2002:a05:6000:290c:b0:3a3:61b8:a637 with SMTP id ffacd0b85a97d-3a361b8a7a8mr17706811f8f.22.1747840834072;
        Wed, 21 May 2025 08:20:34 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a361a81fd8sm18708470f8f.81.2025.05.21.08.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 08:20:33 -0700 (PDT)
Message-ID: <7302bdf8-f713-43eb-aa78-759bb1e1b6b6@gmail.com>
Date: Wed, 21 May 2025 16:20:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/4] midx repack: avoid potential integer overflow on 64
 bit systems
To: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
 <9f07da4fe71d21b14226d8f0132cd3c8600fba13.1747753388.git.phillip.wood@dunelm.org.uk>
 <aCzDCEK7OhCYyAZa@nand.local>
Content-Language: en-US
In-Reply-To: <aCzDCEK7OhCYyAZa@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/05/2025 18:59, Taylor Blau wrote:
> On Tue, May 20, 2025 at 04:04:25PM +0100, Phillip Wood wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> On a 64 bit system the calculation
>>
>>      p->pack_size * pack_info[i].referenced_objects
>>
>> could overflow. If a pack file contains 2^28 objects with an average
>> compressed size of 1KB then the pack size will be 2^38B. If all of the
>> objects are referenced by the multi-pack index the sum above will
>> overflow. Avoid this by using shifted integer arithmetic and changing
>> the order of the calculation so that the pack size is divided by the
>> total number of objects in the pack before multiplying by the number of
>> objects referenced by the multi-pack index. Using a shift of 14 bits
>> should give reasonable accuracy while avoiding overflow for pack sizes
>> less that 1PB.
> 
> Ahhh, this renders some of comments on the previous patch moot. I think
> that this is a not-unreasonable concern to be addressing even on modern
> 64-bit systems, since I have definitely encountered packs that have on
> the order of ~2^28 objects in them.

Thanks, that's good to know

Phillip

> I like this approach quite a bit, thanks!
> 
> Thanks,
> Taylor
