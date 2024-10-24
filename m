Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB831E2614
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776555; cv=none; b=gV4MKwhpoeWZ7SehQHrmjAguQf+1Lh6WxJsrLWS7n2QRiQ0REQ+ZwdnlsUsXcAxni/NCqsb4AwwHGZFMIaXi2vlOVQBb2KTA5d0Qwg75Nonm36yXL5UAMHNvSqERT36yQDI5yINLvA37dT+w99P83SFm+TwIrzKnxFNoW+qFr1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776555; c=relaxed/simple;
	bh=nHpbDBfEGVuk9hJXrB5oVF5kplStna0CjvqUAj3bivo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHfBm8KPsvqCrnGUGpyZ+mw8mnXNvGcQ54iWxZOZez3Q77zPhOqLleeteygAnyvFHY03exrVS2YPVQvJiFaW3DqaN64/5t2F/mLNgbwIn0Atx6HNX4DkPIOhEPMvhGV8thjhkAIGfAZG1ubB2Crt9eEe2B0wD9TYm4GyMK3RlN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a99bFGZf; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a99bFGZf"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e2e41bd08bso11336147b3.2
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 06:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729776552; x=1730381352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y7q6ELO7Ku2rRT+uhPoxcS3rWcrVLO+GuxEqhn61WtU=;
        b=a99bFGZf7H+sGzIx1LhCrt07pdlLpJeV0BvSNKidKOcY+hJzMvfIFAbCQPiPYJgOta
         waqmugkxI8rg6ocvImnsP87nEM3B/THodyx7LhGZM7JaGQjczK0UwVjFF0Aws3WqREUW
         YtJTOHen84fw0pHMJ4f1a6NRoOGOk0PHO88HUxEF66lYnQpt0AyMaulK2QNvyB9VoYMA
         Ao23xIhtplpXpxBz5jTCx4r5UOcdeidNRu15fz0xnu3DvCexEvTcdrryBkWEZt1rZT4Z
         8+pX68hbOiOGVsmtatKYZKwwDtIF9HP3HbQFQhaRtgboQThHhPq0ZMzWZ59DJ8F/Gv2o
         jneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729776552; x=1730381352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7q6ELO7Ku2rRT+uhPoxcS3rWcrVLO+GuxEqhn61WtU=;
        b=pLOzxi5P9xyZGlX8DnNg5/k2KFqyMxNPsjeA8wvPn7SNryG/DPZM1qdMxSNcmulRux
         kBaXW4w7Pe3MSLQ22IuUGXH0gB02PMQtau0ZOql2eAo9PYZ6ZpSmEnfUSt9usTvVy4Z2
         gUFCAV2k4bPa3DXqNQ8V5NnriFKD3WTcwFCb1GDXqdSnsEI82XpnWq/boEOt12P6kFOs
         rDi+6bDrnVSBpdYk5W8h0SCvfEWZzjsCy49zDQho1Ue2KKZ47Y5HpMXIa8KVerz5vyY2
         1KnO8tQE/MsbUkLwB/B/VSCqmPUg5eboc+Cgf3+tjOTNHfxLJgafJ284XqOqZZJckpZY
         5EQg==
X-Gm-Message-State: AOJu0YwD0OaRb/R+TR69OJ/NmBSRHMZaL+WuqvB/9PWSU1poMnYtZ4hL
	WuNwNpAdmQBBti/aOs/7ysMOjdzODZfRqZnRbzDiVD8mcWxIpk3b
X-Google-Smtp-Source: AGHT+IHaJNzBnADThdbTHd9FmyNsghFBDsBry4GIMEUFUZ/UZSizyeQ3tHNg8D2VYnSTC+cI8WWI7Q==
X-Received: by 2002:a05:690c:4886:b0:6e3:ca30:25f with SMTP id 00721157ae682-6e7f0e32241mr71859867b3.25.1729776551616;
        Thu, 24 Oct 2024 06:29:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:d8af:5600:801d:e7e9? ([2600:1700:60ba:9810:d8af:5600:801d:e7e9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5a502fcsm19659787b3.36.2024.10.24.06.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 06:29:03 -0700 (PDT)
Message-ID: <dd18a858-31bf-497d-bb19-d371102dfa2a@gmail.com>
Date: Thu, 24 Oct 2024 09:29:02 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] pack-objects: add --path-walk option for better
 deltas
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
 christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
 <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
 <ZxbLFLDgCm6wLmB9@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ZxbLFLDgCm6wLmB9@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/24 5:43 PM, Taylor Blau wrote:
> On Sun, Oct 20, 2024 at 01:43:13PM +0000, Derrick Stolee via GitGitGadget wrote:
>> Updates in v2
>> =============
>>
>> I'm sending this v2 to request some review feedback on the series. I'm sorry
>> it's so long.
>>
>> There are two updates in this version:
>>
>>   * Fixed a performance issue in the presence of many annotated tags. This is
>>     caught by p5313 when run on a repo with 10,000+ annotated tags.
>>   * The Scalar config was previously wrong and should be pack.usePathWalk,
>>     not push.usePathWalk.
> 
> Thanks. I queued the new round. As an aside, I would like to find the
> time to review this series in depth, but haven't been able to do so
> while also trying to keep up with the volume of the rest of the list.
> 
> I know that this topic was split out of a larger one. It may be worth
> seeing if there is a way to split this topic out into multiple series
> that are more easily review-able, but still sensible on their own.

I'll see what I can do. I needed to re-roll after discovering an issue
when trying to integrate the algorithm with shallow clones. The solution
ends up simplifying the code, which is nice.

> I haven't looked in enough depth to know myself whether such a cut
> exists, but it is worth thinking about if you haven't done so already.

In the current series, there's a natural cut between patches 1-4
and the rest, if we want to put the API in without a non-test consumer.

I could also split out the 'git repack' changes into a third series.

Finally, the threading implementation could be done separately, but I
think it's not complicated enough to leave out from the first version
of the --path-walk option in 'git pack-objects'.

Thanks,
-Stolee

