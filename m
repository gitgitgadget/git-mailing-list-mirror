Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187663254A2
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 19:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775503906; cv=none; b=m+NBu+Z/LusU1s409HauPX+13qwqEOfvNXtK2I9V6m+CN+rjvL9ueGPBw+oMan/b7Uv6U4uMnd30dy+yWZqRV2GDQsEIulI72iMIBpT6GDEUHwLHGnjQl4oyDIRou+QHFBw6DtIzgf0AdZ5Epr3DOdlSWcR6d/5eJinVnjgef2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775503906; c=relaxed/simple;
	bh=ZkpxhbqegUChxrc40+XRTyFT3GOUdqcX8s0fFiUd2t8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eX7tdVmbOhs1JyokAoohHLGYnO2hEnNhEVfFr7zfphWMrKAa/NUTLTGm13NgXNuTdLW7HYblh21O0tQNDjzuy2UzvGu3r2f0tpXKy9QkkilAPgnWvn56ZKN/ZVMvGJKJ2yZw3eoaRoChWCwHK3Z3QRaM+ZCGLvI2Vq/XXEGRQ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtuvCDvt; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtuvCDvt"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d029f346eso3654156f8f.3
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 12:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775503903; x=1776108703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZkpxhbqegUChxrc40+XRTyFT3GOUdqcX8s0fFiUd2t8=;
        b=ZtuvCDvtU57XRToWu9mh42n4KvzSzEhWZSpWHtUGH/BcvH2LHnthMgrznZxuVGNz97
         3Cq2dGItlJ+vsMs9Y5ryPeSMDa5F+wYkDe+8eXOgWx2VBf57BLyTqfQjwc4aN+sfjpJn
         ab+th+tZmr+hNWSFebZLL6fqzG9G+F1oSDvJueqL0MjNbkA3yJfgiA//JOFDpzxFNSWj
         xEq0crSCJNWuz3NEGbmX8MvcM1JzCXBqxXAkLwhw4OhNjnxEOY2gV3fAoiiV07DDX8bP
         gYDTgBEZOlv82/FJgCEzi+YzLsNG1HG8bfbVCNPjm2+2w0emYzBVYIaSPoY28ouqwk4D
         nwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775503903; x=1776108703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkpxhbqegUChxrc40+XRTyFT3GOUdqcX8s0fFiUd2t8=;
        b=geSGktU1siztHsjo7eIhGd3JjQ3XYG3qscer2Rdsf8nyzM6YTePwfa+SLlBiRDQziD
         X9GyuB+i3hGp0qp3HatlNrN8wOhVQHqqJLW0jsMD0iurKqqgrG/ZHBbvwirFnbK21j6e
         qBan/5eIZ059/LNGVCW1YzqHpRttJhqvnev/Xkxt56BG6VMnYep7SDnp1VI73ph6j9N2
         QSs1fIS/vo68sSiv1aYKNjqiimMIZaq2trty+MyOqEQ0DVvSkEG93mFt2K7rz2LWIPWK
         h2eABXCr3xcKmkzwKPw3L81iffM69d7S51Bj80FYzEbzqwFBGV6kTcLaWjAqLT+9VHlO
         j/3w==
X-Gm-Message-State: AOJu0YxweT8Glr2mAxWF91+Qu35K1+m3L+3aN34p/nn44DbvMA4MGhpw
	mirzLISmUF270VYnQ9LUZf0VaGW+2eEYgnZOblty4s8AZf4NjaThDJDF
X-Gm-Gg: AeBDietBAgiO5R7mVGkUZCjCqDOXY8Mgk6vOHUI3M6FB2lo1mvOCmG+0zB4/9OTZ0NK
	nyC53k/W5gIl4SuLdwG3ShRcF8I8nHgz7XjIFVvahLJfNbROy36ORkLHxIsUecvj9tON2HML6FZ
	Y5NqB5p2zLUwrqZASbS5Yo+NMw7MmKHpWbQ55qU3cmOo9+HCj73Py0vHbQkpOTvgPI1tm8KJYzH
	KYBOBZ9ar2XPh0eIA8vyG+00R4l3xHbgbM4fyvLdRIgvDOqAUXI9rfj4X6YDci2vq9Y4Kd/jfLc
	jXBcOl4frWvX1Lpm6bzN6OmkuGCWPiCsIYY9MW+O+D7V3aYZY8mStTSRebRRcpFC7qN72QvPbO9
	n3siDyPt2XnuSqC2YUxW/lNNOFy1GIwSPqOjS5y+EwWJiX/Tgdd1q21WyAGZmsXLQuxF+wqpowC
	hh4ptd5hve10jQqUb4qYxTs9dRgMfRVr9oJMKNPetg32wPANs2jOqQYvAvhvDT4E7LvYjpORMJ7
	9yKXz7C
X-Received: by 2002:a5d:5847:0:b0:43b:4e13:221f with SMTP id ffacd0b85a97d-43d29300bf1mr20956255f8f.47.1775503903106;
        Mon, 06 Apr 2026 12:31:43 -0700 (PDT)
Received: from [192.168.50.249] (host-79-30-45-36.retail.telecomitalia.it. [79.30.45.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f5bsm39228278f8f.7.2026.04.06.12.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 12:31:41 -0700 (PDT)
Message-ID: <568cb40a-373e-4ad1-a6a0-fb7289da92e2@gmail.com>
Date: Mon, 6 Apr 2026 21:31:39 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] object-file: don't use object database without a
 repository
To: Justin Tobler <jltobler@gmail.com>, Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, cat@malon.dev
References: <20260404172817.2995133-1-luca.stefani.ge1@gmail.com>
 <20260405064651.GA1452907@coredump.intra.peff.net>
 <145b6c7f-c037-4a87-b561-d2b4d8c5a0cd@gmail.com>
 <20260405191750.GA1525850@coredump.intra.peff.net>
 <adP0hnV7Gl08qqqf@denethor>
Content-Language: en-US
From: Luca Stefani <luca.stefani.ge1@gmail.com>
In-Reply-To: <adP0hnV7Gl08qqqf@denethor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 06/04/2026 20:17, Justin Tobler wrote:
> On 26/04/05 03:17PM, Jeff King wrote:
>> But I think the actual code change in your patch is the wrong thing, so
>> I also don't think we'd want to just squash that test in. I'm hoping
>> Justin has some insights on how to do a more complete fix.
> I agree with Peff here that the correct fix should continue to use the
> object streaming mechanisms. To avoid this segfault, we really should
> avoid using ODB transactions when there isn't an ODB in the first place.
>
> I replied in another thread[1] with how we could go about fixing. To
> summarize, it just so happens that I already have a patch[2] out on the
> list that appears to resolve this issue.

Thanks, just verified it works as expected.

>
> For the use case here, git-diff(1) is only interested in generating the
> hash for the "large" blobs and not actually writing anything to the ODB.
> This patch introduces a separate "hash-only" variant of
> `index_blob_packfile_transaction()` and is used to bypass creating an
> ODB transaction when object writes are not needed.
>
> If this is the route we want to go down, I can extract this patch from
> the current series and send it as a separate fix. :)
If this ends up happening CC me and I'll gladly stamp it with Tested-by :)
>
> -Justin
>
> [1]: https://lore.kernel.org/git/adPjXKGIT5O7SK6E@denethor/T/#m9cee420941b66abfb0244ea4b7762ba8d0ff7b52
> [2]: https://lore.kernel.org/git/20260402213220.2651523-5-jltobler@gmail.com/
