Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6445C280A22
	for <git@vger.kernel.org>; Tue,  6 May 2025 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537444; cv=none; b=JypOWhDMu72eK1NwCMW/a3QeHn47jXPj+qlF3mS1+Um8nMw7f/Dp3SJnULK2Fex+IsFRTXIfvD64Rrur769976ifwUfNzA76Ur4m1dUxsmoA0YHDrIC/r6OXgmaZfwP08SAfcrhTG+qteGSUJVqNPVNtF4k1AD7Me2uCyCgfBJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537444; c=relaxed/simple;
	bh=IPZDXos9qOxomGN9bvLORDP2numhIlbz3AvHdm/bE4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVymUI9gCxDlkcR6ee866TlT3LIQ0KPcSp2jf+6iiDOnAQRXejg1kW6TwFISSWrfQJuWRHnC/NFEfSW5c1qs96hSl5mxbquUkbVt8sOcQU6oTuEVrzlEsuutHtLIkpAUkJu9NHJklOKFz0qEck1LBnmR1MbB/EhQyMRy7Tl0T34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDsNOTiA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDsNOTiA"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso37955705e9.2
        for <git@vger.kernel.org>; Tue, 06 May 2025 06:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746537439; x=1747142239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XIDR2txc4M4dFgmrH14pwigGGzZuc6LhzBsxSfIKnmU=;
        b=lDsNOTiACiVZsDr3iIr9X8rBTjB1CC8L1bEu8GRxrPlztdEV4NbK2cvs0WUigkFfpL
         8HOomG5HjMHRnWSyYdymrLeYnyZe0qqzeouzGmUmTqN+pqM7s36f1Yp649k0zQJU+b0N
         yrlbuG3bmOh5c7DyeXiW+HPEg4dQKSNHmDUvB9+KmWu7CmySBBS+lkx5D6l0pbRQcYlw
         DHp561aMyfv8RPMS6IXNJlqfHPm/vlByVMrqIQQs+nT6UHbJhowBUbsANK0RCbv8BEgb
         EPfxHJc56qK/I/mIsf7+Hzc0v63/F/19nUr4jJ9CKbk61w1glvOtJEhuoT/erUw9Pfj/
         BPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746537439; x=1747142239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XIDR2txc4M4dFgmrH14pwigGGzZuc6LhzBsxSfIKnmU=;
        b=AegK9jw53gB2S5nrZjtYKWK+aZ5xG3fG7p5WGqxG3XE7WbVtO4luj1sQDw7NAsXq15
         XXH2dd5dtLqDSy6sEd+/HjKPvGE0TacCumbd3G/PV68MPMO9YVQtrqWLT5jjdWfsxD3K
         FjcWmm9eHNIHqUvbaLh0tMENM8oFqfpCmzMeVIJdV9FkXHsu73w7nUzYT7rK9l7cqNlB
         negpEkq+xgf+4RdbowuWTtG9LkRdLjDMbCK4ok2ANmPhSliDD7hhhVGHasaNAdSKa7BR
         2hnV8r9f1YCUL0Dn34UEVz8KEZLl7WeC8QCCsRrfZ3lU1bRx1T9OLkBLxc3iNmQgCSH1
         5Gkg==
X-Forwarded-Encrypted: i=1; AJvYcCXBDZ6dq19IpyeLA58+RCwIFtPi1aeHmnFi5RY8gD/AZVqIUbmwypBdpxmzZuVD0av1moI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzITZNTNp9iqERsFZX2qDbzyxOp9TJBrjw5oVrPFmmLMU4EWAfv
	tgL51H8w9tAp0xhbC2itrhTt7eGmhFylV7muyBOp9x8PVpI8PL23
X-Gm-Gg: ASbGncseAgEHbCgX0q0TEI67TqFpk3/jjnt6KE+8tJX8SaO78rTZOIS+OmvYYcF68PK
	tSddPXRpzO8a87ONjQjKZ/AklsNNffye/F0WT6eG6cM9OJI1c9pELc7/1mrTP87mmhFPTHQLcQq
	FpurRFVAig6O/0hTokZDFxF9NKV3HBvTr1wcjqqNe9DhhMfN7QFmdgJgydOtmgxbE/atILSeeht
	i/YdXTsHJyM81/PzqPB5UEIkC8gCJorE0ewQY6jQtV6tJZwOrUpBkWKKnroItk+sXlJY6k2lVyL
	QJQaeY7xqwuZcL66yQsZs4lIDj/gqHjzj+dFp4USjAPiEYfOhjPVIJ53MlwB5H6fXCsdfmkGdt5
	WWPRsWAbIpiRrrc7fzdJM6Cc=
X-Google-Smtp-Source: AGHT+IFM4j6rLObfUjvZRXZLjqTCQStuCC71R9rymKrniKuNYV1KjLMotxQOhrjqDnFDfgsLzxLKHQ==
X-Received: by 2002:a05:600c:37ce:b0:43c:f4b3:b094 with SMTP id 5b1f17b1804b1-441bbea0e40mr146058725e9.6.1746537439183;
        Tue, 06 May 2025 06:17:19 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:efb:6e00:24f3:2d85? ([2a0a:ef40:700:a501:efb:6e00:24f3:2d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2aed5e8sm213745185e9.16.2025.05.06.06.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 06:17:18 -0700 (PDT)
Message-ID: <142f6110-b26d-4495-9b68-7c438b17f86b@gmail.com>
Date: Tue, 6 May 2025 14:17:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab-ci: always run MSVC-based Meson job
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
References: <20250428-pks-gitlab-ci-execute-win-meson-v1-1-f68683552b9e@pks.im>
 <56a0f8fd-7568-b579-1ff3-e0b088b53345@gmx.de> <xmqqv7qoceiv.fsf@gitster.g>
 <aBnm4fP1RYgoIEc4@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aBnm4fP1RYgoIEc4@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/05/2025 11:39, Patrick Steinhardt wrote:
> On Mon, Apr 28, 2025 at 11:44:08AM -0700, Junio C Hamano wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>     Or perhaps we pick a
>>     single representative job and only after it passes start other
>>     jobs?  None of the tweaks along these lines I can think of feel
>>     satisfying to me.
> 
> Wouldn't that only mean that the pipeline takes even longer from start
> to finish? Even if the representative job succeeds it doesn't tell me
> anything about whether there are leaks, or whether it works on Windows,
> or on macOS. But given that I am on Linux, I especially care about jobs
> that use a platform different than my own and always wait for them to
> finish before sending out a patch series to the mailing list.

I did wonder if it is possible to make a failing job kill/cancel all the 
other jobs but I think we have a few flaky tests that occasionally 
randomly fail which complicates things.

Best Wishes

Phillip


> Patrick
> 

