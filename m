Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8532AD14
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749463496; cv=none; b=LelLVn+BEFUpgQaTGaGzKFotOvpfDs9aX68PW4vQAeUKidZ7nw/ymyxoa0GvjXOAv/ZH1cLtgDBfMTIhvZ44QvyZ831NTt97gCSJZ//GPhHfeDm80HnW4jyhHpHSLOw3UMfFo8vknMjMbIjhw7fvI7uG63ARiT8CTf+m7c8n1ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749463496; c=relaxed/simple;
	bh=aBHZ24xM22vOlBSqjd8biV/MmXGqc5sl5sPNmVcONLM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=WmuERqLkc69N25t8JxicwELGREAEWXDHzBnL1vVwoJJQrk7VkZ7HsyQ/NMu53RYd03ZWJX/iJ8Yy/sUuoan1kXOwx6y4v8rtF+QOIZDx1iGOzHsajnC7D4DdO0rAP/jr2OElLShMbvHV4EXRp5VxyUpziykqcMcVK7Q24lajw4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5te7jwb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5te7jwb"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so48697045e9.1
        for <git@vger.kernel.org>; Mon, 09 Jun 2025 03:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749463493; x=1750068293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :reply-to:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZV8Bl0B5wG+/DaaUsPB3GMNDPETfybMYoaZRJOu31M=;
        b=c5te7jwbs5G79DfiDxHitKR4tVtex5WJdLJBFVgDIr6SRJRIE5IxtEs2e04YeYVa2P
         soCHRRGyjbDmtHhqJO0hcNSWTXG8h0YxlF/Fwn+MLdv5Vdb9oqP0ogx+M1m00yjMviDS
         9dcvYwxQKVNNxIrsIwA/GZ0ejPA4COKES2mL7DCRgL+pHwyS/9ycaQifRVT7/GJLrGZE
         SwmiPDA5vu3XYdHyj5eA+VuA7ZoI0p7mZb4LAAZ8j3X8INQmXojugXzU2YK7S6UYAOE7
         g+giRFY3OEg9VsMaPDJ7nk1rFaLv1JAdnNocNdNdaVCbpGW+OC642kodnNYqhhyt9hfu
         B6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749463493; x=1750068293;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :reply-to:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZV8Bl0B5wG+/DaaUsPB3GMNDPETfybMYoaZRJOu31M=;
        b=j59cj8MdBnRaAgHBv4J1z/5x0VgbFGhZstJU6oOYUxecDjmim1S0G58ZJrr5tao+0x
         d+akK6F3IwG7u41UOzBtJfP/MbleZavW5ceR3xlgPYSx8/pjIyjL88voXxtZbCGlj1Jb
         SZCw6v8cjcmo+5Gmcgo1Bb9BV00KLTgLbSvlYN/dnO+nkCm7GiSEk4D3Kn3F6aRbOJ92
         HHOl5xTjtDJS0c1ACAgzVmQwZkn/hfR+QKKWZWlTjjItydj9mb7zcwOY0v1Zoa8EPYT7
         A+qUDIkv6B7NPyoqlEiXjcG3EMdnjt3ozx+E+rkWzwy8eupJ6np3Ld3ccGZAG6qDBmcw
         F3gw==
X-Forwarded-Encrypted: i=1; AJvYcCWHUIF6Lbp0BMHBY/onElNCnQK/jh98Sg0IcmyG7isEI42kZQ9x5Ip+qHzUEd9a29spRio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyum0xqEP21m/PijZ25UahjryLI9rb8ePtqiYyUBoOaUbFFns4w
	6vG4nxFwsBskx74AWoN/KpyEbtMjWkgcEeQeGAdKKQW7P3Rj8NGZcIGafTy7SQ==
X-Gm-Gg: ASbGncvDuh+zhwRXuca/ORSNvGm6+zRWQ/gweGypEwvm/Q91Lkx1HHXRJhhBVtENErU
	rpsffAJsNSXIbkzw/RwqIkttqOapIMH+trATCQSaa39QPaRDF8aYek1y+cvlGihoi5A5sw3hs0R
	I0hTfPCArWpKBFhxrph5toA589ZSf/9iGX4csDVUvPy5XriyKFdcOCSkH1KmexwxhtxkjZkL1Qo
	ZWNCDx4/YQ2xCKT4RHV+P7hyWwKqIJrTvCusbX4CXWCjoVEgyFPtL+dFw3eQnRq8v5Cx/lwxyLj
	2JFWYaViePhewCCrs/ShxBSDumDrRQWQiw35EZ3LaRsCkBH7IylGH9LMiVd0tBRbaUghssgbbua
	lTfqLvhnFj0DYA4W5MAW+UnQeCNWS/aApP/NC
X-Google-Smtp-Source: AGHT+IHxcIAfXOcWmXREBuOUnuzAIaMXTy3Ty9fGHCDk+t+Fr1hT7Dplp3KezGQnYh44pvESNGBi3w==
X-Received: by 2002:a05:600c:a00e:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-452013d7e0emr110619075e9.21.1749463492460;
        Mon, 09 Jun 2025 03:04:52 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:9c3f:142d:8a80:1b04? ([2a0a:ef40:700:a501:9c3f:142d:8a80:1b04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4526e055ff5sm107121515e9.8.2025.06.09.03.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 03:04:51 -0700 (PDT)
Message-ID: <bf6b2d49-d2c6-4197-99ae-06401093c8b8@gmail.com>
Date: Mon, 9 Jun 2025 11:06:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question: is there a short way to merge the last commit to the
 second last one?
From: Phillip Wood <phillip.wood123@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Aditya Garg <gargaditya08@live.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: phillip.wood@dunelm.org.uk
References: <PN3PR01MB959708ED22FE7FE70C17C852B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <aEXdKMjAbry1aTXe@tapette.crustytoothpaste.net>
 <993914f7-5023-459c-b1e8-ebec2646e243@gmail.com>
Content-Language: en-US
In-Reply-To: <993914f7-5023-459c-b1e8-ebec2646e243@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/06/2025 20:31, Phillip Wood wrote:
> On 08/06/2025 19:57, brian m. carlson wrote:
>>
>> If your goal is to just do the fixups and squash and not anything else
>> interactive, then you can do this:
>>
>>      GIT_SEQUENCE_EDITOR=true git rebase -i --autosquash
> 
> Just a quick note to say that since git v2.44.0 you can just run
> 
>      git rebase --autosquash

That will also rebase your branch if you don't specify a commit. When 
you're re-rolling a patch series it is normally preferred to keep the 
same base commit. You can do that by adding "--keep-base" to avoid 
rebasing onto the updated upstream branch.

Best Wishes

Phillip

