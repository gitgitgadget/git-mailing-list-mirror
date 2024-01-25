Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198C08495
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 05:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706161330; cv=none; b=GBSthhHTgD+7vp2bzK331jNg+WwBEP/3uvxipWHIe2phYH+5Jn0bzh5kF0teMGs4v1uaeBB8Kf5s9wGTqiAEV7asqAmNq2R4Z+/Fn3MP3JvXsLVfbIV/yZ5Bdr+1oAxTmqQ09hFHMu08LdvGDHw5mYRAO6sQjqSmLA+36tkEcPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706161330; c=relaxed/simple;
	bh=+2OLEVclqRRvkJTWdoSu2PjN/q7TDcYLpAhOxOxi2xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BF1z2rHPVgNXxGw4eX0EGsm2Xqi20qPR1H4gUNKe3mLO/l/WXSMSlqwht4yg2YX8reulHaBt/Hz8u+Gj8Bm+4jK5p9NRd9HdxMl+xGVwJ51rowTt9jAYUfCIRk9EqUtK7SGfjQpW3wAeYXM/p7+5wtrFU8bsJrCJLriz7wZwTZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVwwk8zx; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVwwk8zx"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bdca4f495cso1173953b6e.3
        for <git@vger.kernel.org>; Wed, 24 Jan 2024 21:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706161328; x=1706766128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dzgq7ZnrRpa9cJI2vd7YUqfmHOGAeZaXkfU8HAAh5PU=;
        b=BVwwk8zx4QfaaXm2diZRAOUYcd357kx+R8x5TbzKjFShILczS5qnCpS/DuWkAktmsE
         ESJStbHphSxgUwM+XPegAfHoX22fRx5Kx0DDIYlzWIVpxB5X3yyKEfBH0qo6GF60iH4c
         wWY5HMVnB7Phe5v6AKw+n5Ys8dEwr6xtMECTQP40UUQw16MORlHM93hBMf7kT2uKHLhP
         ERwhfcu5BIf+Hw6nc1eRY/xbZ1FDv7BufezMRffeYJMBr5mesWCrR49FlfeMSK7xzlse
         dJOqaYyiwLgHpL/3y5IrksOA2x2zgHnU8xLjjMeL7z+wYTWmMRt5CUcQikXw4IQmSUDy
         +ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706161328; x=1706766128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dzgq7ZnrRpa9cJI2vd7YUqfmHOGAeZaXkfU8HAAh5PU=;
        b=dL93y5z7DP6FH4XhYGg4H4iCTQVIHnoYDsf5Iy0q8Cg5H3CvOFhi+1F7AMfz4PHuZ7
         TVePxE358AFhVH3SIb8nNfOS4ks3O7X7fOFAsJ0ItUXA44jyQ/3aSe6wKfQTq0X/lEQr
         7LnV41mdHZnHwj2GGsX9jW6vIIh19Bi7xA7Z1b8lA+qIO1FFXq5X7izA+3dvAc/lmZqo
         tTqs3yQxXj30fN8BGdzT01/Y8qyZHIqDr+olxrxiMxO+JObzulaoMAqVJRRghcyJaOJp
         dsY57x2G9Qcp1qUpGWc5IjOaKfCemN6nzVe4GtuVuO/bAYpimsX7EpdVN8G7eOfaXF6g
         MV7w==
X-Gm-Message-State: AOJu0YzZgtTOX7n3YuX/+Q3i3A8k0UCS2IYYb5jG3DM4UBo7K0/jfLo6
	LqHTozRXr1xEU3/cspIJj342BUMzLJq7x1Yrw+bHqnntt2FtmhDu
X-Google-Smtp-Source: AGHT+IHFVHXSU+5WgzkO+iKr5HJRi+fVp9unOTQq1TIVM+2+8fWNLWwmtMsTar+yNDPxVNS9p4LS2Q==
X-Received: by 2002:a05:6808:1492:b0:3bd:692d:b234 with SMTP id e18-20020a056808149200b003bd692db234mr359905oiw.46.1706161328051;
        Wed, 24 Jan 2024 21:42:08 -0800 (PST)
Received: from [10.42.165.185] ([103.158.43.18])
        by smtp.gmail.com with ESMTPSA id l63-20020a632542000000b005d66caee3d0sm363207pgl.22.2024.01.24.21.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 21:42:07 -0800 (PST)
Message-ID: <d135a291-7b51-4cd6-86ec-676c1c5b04e9@gmail.com>
Date: Thu, 25 Jan 2024 11:12:02 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] FIX: use utf8_strnwidth for line_prefix in diff.c
To: Christian Couder <christian.couder@gmail.com>,
 Md Isfarul Haque via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1653.git.git.1706105064.gitgitgadget@gmail.com>
 <ac9338533c9096c090d1463c1b29505bde019731.1706105064.git.gitgitgadget@gmail.com>
 <CAP8UFD2oxpefhGtH61wZvcHEvd24jtu_ZBVsnNZMjD2aM_NDcg@mail.gmail.com>
Content-Language: en-US
From: Md Isfarul Haque <isfarul.876@gmail.com>
In-Reply-To: <CAP8UFD2oxpefhGtH61wZvcHEvd24jtu_ZBVsnNZMjD2aM_NDcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/25/24 01:31, Christian Couder wrote:
> On Wed, Jan 24, 2024 at 3:04 PM Md Isfarul Haque via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Md Isfarul Haque <isfarul.876@gmail.com>
>>
>> This patch adresses diff.c:2721 and proposes the fix using a new function.
> 
> Please give more details here about what is currently at diff.c:2721
> and what the patch is fixing, as lines at diff.c:2721 could move to a
> different location if some changes are made to diff.c before your
> patches get merged or after they get merged.
> 
> Also if the patch is addressing an issue in a code comment I would
> expect the corresponding code comment to be removed by the patch.

I understand and apologize for the mess-up. I will keep it in mind next time. 

> About the subject, maybe "diff: use utf8_strnwidth() for line_prefix"
> is already better.
> 
>> Signed-off-by: Md Isfarul Haque <isfarul.876@gmail.com>
>> ---
>>  diff.c | 18 ++++++++++++++++--
>>  diff.h |  1 +
>>  2 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/diff.c b/diff.c
>> index a89a6a6128a..e3223b8ce5b 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -2300,6 +2300,20 @@ const char *diff_line_prefix(struct diff_options *opt)
>>         return msgbuf->buf;
>>  }
>>
>> +const struct strbuf *diff_line_prefix_buf(struct diff_options *opt)
> 
> This function seems to be used only in diff.c, so it could be static.

As Junio pointed out, I will probably use the existing function with slight
modifications and use it. Besides, having unnecessary allocations and frees
will probably only add overhead.

-- 

Thanks and regards
Md. Isfarul Haque


