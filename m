Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F8A71B51
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933253; cv=none; b=m8VE2O02T8kIKJ/k+DTS/dvEK1OsDbGBZHsdHKTD6lz0VNYTlja8V/4pjOwf2rsJVZ89G+caGVvS53x1O0IJCqM4BqEXedBBtfsgw+2RiDGAZYbIRhmgUCSrzOE1P5+++9daaJ4s44oiYhXiGZKnyWiUVV2UHPYGvsrnK/XGin4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933253; c=relaxed/simple;
	bh=jqKEZkFPVkR1mZ/d01OLXVQN6d/QcCuNToJcn5F1rGM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=UjfE4JEtUCFHsdVQVh/mAkbYm1JZ4MuFEawqRR0I4ibionpUFN4swLoaFWmodu2Jte78QJRMaVJ02Ak/JhDEnqpys7U0ytpuhYIFP82fEyPmBYwm7Jlv/U018Y5Bl2HangIJQY0/x+AFH7LIVizdGwqfPEFhBsA11/uXUkUvIpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAHRKT0W; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAHRKT0W"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-367339bd00aso3395952f8f.3
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 08:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719933251; x=1720538051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xce3DtoiHoYQII/qyAnDkUwdbwVTcXgmH5RME1qHBrk=;
        b=nAHRKT0WRRDLzYCXouo3qjXPWKJUYXJidc/6yhgB345EuRrdARbsfJPkF4/zKjMGMk
         t3BU/sLI85OmUu5DAnn9cuENIXnt2YdLS+k+jHAkds8dmix1K93VM1gc8wGkF1PoRrwu
         HW9Owtzg08SCBdi5vLaYc4ZVoIMSxqceMlx8QroWJQXZoOxUScaazPxOFxj/P9VycXsX
         /LvVQTtXzi1k2proqYkqQng4tFTgSUscUspymyeIYj/7SYDYRIqqutS8pKTgH5DuxOWa
         26B4lOiGXGuqhqS2jZxJoBSEqg9xifAJ/3BbyjzrRGKv9v6//l1PMHiBs9u0mZ0uk0mp
         pGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719933251; x=1720538051;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xce3DtoiHoYQII/qyAnDkUwdbwVTcXgmH5RME1qHBrk=;
        b=D9KyMf9QP4lC3GVb584in5pvo6bb12Q4Q38zzzcTVyawJNklRuN/LuNorozuvV0O1a
         r241GL6lZkgebulwo30iI+vNu56KPl7FpSQbWaR0hG0TRJ8Xr9jy4CYqueIpy1Ajc87o
         I5AaGGArIVd2LZJjBhvYeG6DJr+rJcar92mdDS5VIp4IJ2DtQPZgHSfUp1Y9xpzbEPue
         xTO9xo4HTUzH9CVBabs0DM+WNV/NxPhWrOVHaTYjfMPiSaYeiFd/4NMuRPonaIdj3daj
         sJbaxDPZfuyp/ihZSzxarpfds1fRfFhXtlTQDIHrPoIuE3rEQ69tM3Ta5TXDo/IL6a4v
         lJnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLiHnDIAqJoY265kYaCd1qX5rgyvVExmIYxOZen4gLd1QsMwB4m++YucrNmGlAstB6Aocf4m8vKkFkf+6VLbJO9FEn
X-Gm-Message-State: AOJu0Yw3GltSMq2S04V8LKXegAGWxPq8FCsxtKTr5rmPPRBW3kIeIxg1
	OKdEg5WbVK3bMyx5awPrUwDTXsZ5GWYShEReZnWiefUD0n1CY2iy
X-Google-Smtp-Source: AGHT+IFC09pe0oCZf2YKlPmv0VsrEdGX2AMivemi8Loi6prSxwEo5TWG6ohDvMEc559F5UKVwpnyUw==
X-Received: by 2002:a5d:4d10:0:b0:35f:1128:250d with SMTP id ffacd0b85a97d-3677572e6a4mr6103446f8f.68.1719933250654;
        Tue, 02 Jul 2024 08:14:10 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36789d5ec1csm1744368f8f.37.2024.07.02.08.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 08:14:10 -0700 (PDT)
Message-ID: <eae0ccf4-8747-400c-96ab-b7fc7a51beb9@gmail.com>
Date: Tue, 2 Jul 2024 16:14:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/6] t-ctype: use TEST_RUN
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Josh Steadmon <steadmon@google.com>, Git List <git@vger.kernel.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <abb96bfc-ed97-4c8e-a99a-0dadce45398e@web.de>
 <eh556xjlxipeyumm3gchiiggyogpcuznil5kwvudcpyecj4uxq@uy5tk66blzsl>
 <1a9c7351-68c2-4f2a-b00f-b4c8422ebe08@web.de>
Content-Language: en-US
In-Reply-To: <1a9c7351-68c2-4f2a-b00f-b4c8422ebe08@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi René

On 01/07/2024 21:04, René Scharfe wrote:
> Am 01.07.24 um 21:49 schrieb Josh Steadmon:
>> On 2024.06.29 17:44, René Scharfe wrote:
>>> Use the macro TEST_RUN instead of the internal functions
>>> test__run_begin() and test__run_end().
>>>
>>> Signed-off-by: René Scharfe <l.s.r@web.de>
>>
>> Nitpick: please expand the commit message here as you did for the
>> following patches.
> 
> There is not much more to it: Use of internal functions is discouraged,
> so this patch replaces their calls with the new public feature.  Perhaps
> a "Kinda-requested-by: Phillip Wood <phillip.wood@dunelm.org.uk>" would
> be appropriate?

Perhaps something like

These tests use the internal functions test__run_begin() and 
test__run_end() which are supposed to be private to the test framework. 
Convert them to use the newly added TEST_RUN() instead.

would be sufficient?

Best Wishes

Phillip

> Unlike in the later patches the tests themselves are unchanged, so this
> has no consequence for people that want to add or modify character
> classifier tests.
> 
> René
