Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E99230BD9
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308476; cv=none; b=XAc4B5TqPOrkyPEbvqJ5+XjpXbyaJHcezLaCyMusXDhnSI1c8tfGCEZJfLj0MAEOTH7fffEgGRNLLXprr+ntFXWWhlsbS1koEXomrMBztUXAAjaPWZo/J4iyMzs832a24YidJrUVWUuGj0AotdKMphK8nzbvZpO7PMYhRUsS1Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308476; c=relaxed/simple;
	bh=d2WltD4m/aCuXQ7jm17Ub2uzbHavlobHlQPFKpFSPXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oAYKOAQVzNd+4RwNSCwtFfJE7MScacBzWJptFz8EGw7TO+sOh3wtgiyqs7FfxesjeTIBCF2fY4xgGEhhGL7MRQT/V+GpugAJ/THBVX1mR7gYkscdY0MysFDJAh094Rzj0ty1B0sKQVPESLTN9gHn9kkgwB0TSfTPgmFJnAFTIgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0RvLk7T; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0RvLk7T"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-915aa0a9293so224111285a.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 06:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782308474; x=1782913274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f10xNaS2MftkLitu0E8EiS2UqLCvnbTwpaiquPZEP2k=;
        b=K0RvLk7TWCitrOi19wPCr0zAG7L6rWpVftyCGhxXJ/KPg5WPmY3+gdpu9KmaMK0Li9
         2Qn9l6TdRIQD+J4ak24XcbH5+pwvCljfHMq3g+uUwHcws6MWccq4MZT46Hj41hUPcRCp
         USs4/D0tbT3wolO2Sfv3I3FImouBVuRO8L6Vkql9ajH+piEZwPLNY927jX+SQxd18cRl
         AN2XxWNww8RrD3rnjdyR8ptC27HoG88eTFrPtprE25Az1Tf+aT3s68VZOYLBV33PUUAh
         oUqaussuZLSUCuWM3lQeXJtBH1pd89u82Uy0YNNR0kp6uhkvdlvR7L5G2P7yZhNaOY7W
         7K5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782308474; x=1782913274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f10xNaS2MftkLitu0E8EiS2UqLCvnbTwpaiquPZEP2k=;
        b=eegP+M8CWndDBRc/tF79BRWX6NCB1R8th5IbaxwBTO3lX6Lp5TGTKuOYJQWbOWZ4SE
         6QJf8gZF4m8KWLJXpA7DDgKwcHkadGrwmh7qYoMxbgjx2ZCxpjmUQhsl0YP52Ey+TqCj
         kzGcMn5alOXbTRYuQydUL6RwgqzTf9k6MrUO1BnvrNnt7soZwL1dLnx859pcX94Q86Es
         RW5vQAnhrHTE/+57+FD3/Cq6vSZLmifWhMtPfk8gwprOC+pgmiVdi981Tz8twrszMB2e
         gc0bMw5BDVveOMbAEDdjJws5wu5yI0JRkjXvVy8yDvnVKcyKWMq1LhHk/pqiKykxpIXA
         uEwQ==
X-Forwarded-Encrypted: i=1; AFNElJ8rXflpf8vpFCA4Q6nod5RNOVVDt0+RVl8Jc8Oz01+KA0xrybG3SdsxqJJNzmSmaud/8dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuM+7KPitOSjfcmWrQZcz6aZ1irqe0iTKjcyM010wk4yfbwjVh
	iYARwpuWt0E0rim1/puqxpkVkLRqq9kr4KR8PrSgKbP5d8YylyhKN+qP4LNvWhsE
X-Gm-Gg: AfdE7clTkPIa4TWjz1//6WYyW0xZgfiDAw4jFNSWQkoWq88yp6axaE6WU2cpLAfCj8r
	oHq/8fWt/7jE9mtZHxrkje8YyX4CIDmUz8F9HBmdGda8JIvzP+SJ3RJxvTV392n7vxzIXgX5yPh
	iLjGYVWInhHrIc49ihUY4oav5TJcivSK+k8IKhXpZFYdYz2JMMQ6Pe/6DCyt4b25XsVqaXquepq
	BAaGz4CmembB9yQI8UCG/uGeSQtXiC3q7ko04VPTIflOpSKNmtr300jtj8kPggSvM30Ees3dKxE
	2tGFHWpHe/NcGu0toAdeUNkw5u8TtkUEuOTqCtNxPSpvalLocqTlvE4lcJnSHL03yf2xjQFd2sR
	0346gMGwOdPCuPqynQhXtV6RN/I2LWeSEnfGL1pENsEvty/KCFpQdSE7uPO+VGZaOy/qn3gKek4
	9q+Wmd2vOFEB8U1PAfEOvMNnA5THUJBsEbCgvKMa/9bXQJQhT2Rf8xcxygKA==
X-Received: by 2002:a05:620a:4493:b0:915:29cd:306c with SMTP id af79cd13be357-925ffbe21ebmr1163449485a.9.1782308473596;
        Wed, 24 Jun 2026 06:41:13 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fe235092sm560257485a.21.2026.06.24.06.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 06:41:13 -0700 (PDT)
Message-ID: <560c91df-3c07-4c8f-9924-ef0cc7646e08@gmail.com>
Date: Wed, 24 Jun 2026 09:41:12 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] commit-reach: add trace2 instrumentation to
 paint_down_to_common()
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Kristofer Karlsson <krka@spotify.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
 <6ade4df2ed2a836a3b4c5400ab13e8247e36c029.1782303254.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <6ade4df2ed2a836a3b4c5400ab13e8247e36c029.1782303254.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/2026 8:14 AM, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> Add a step counter and trace2_data_intmax() call so that the number
> of commits visited during the paint walk is observable via
> GIT_TRACE2_PERF. This provides a way to measure the impact of
> future optimizations without relying on wall-clock benchmarks alone.

> +	trace2_data_intmax("paint_down_to_common", r,
> +			   "steps", steps);

This is great data. Very clearly marked for what we should be
doing here.

> +test_expect_success 'merge-base --all commit-walk steps' '
> +	test_when_finished rm -rf .git/objects/info/commit-graph \
> +		.git/objects/info/commit-graphs &&

(highlighting this chunk)

> +	rm -rf .git/objects/info/commit-graph \
> +		.git/objects/info/commit-graphs &&
> +
> +	GIT_TRACE2_EVENT="$(pwd)/trace-none.txt" \
> +		git merge-base --all commit-9-9 commit-9-1 >actual &&
> +	test_trace2_data paint_down_to_common steps 81 <trace-none.txt &&

I'd rather see the whitespace line before the `rm` to make it
more obvious that it's setting up the "none" case.

> +
> +	cp commit-graph-full .git/objects/info/commit-graph &&
> +	GIT_TRACE2_EVENT="$(pwd)/trace-full.txt" \
> +		git merge-base --all commit-9-9 commit-9-1 >actual &&
> +	test_trace2_data paint_down_to_common steps 80 <trace-full.txt &&
> +
> +	cp commit-graph-half .git/objects/info/commit-graph &&
> +	GIT_TRACE2_EVENT="$(pwd)/trace-half.txt" \
> +		git merge-base --all commit-9-9 commit-9-1 >actual &&
> +	test_trace2_data paint_down_to_common steps 81 <trace-half.txt
> +'
> +

This test is a great example. I look forward to seeing that it
updates in the future.

One thing I was hoping to see was that your side-exhaustion tests
(from patch v2 2/7) would also include these checks so they are
more obviously updating when the implementation updates later.

One way to accomplish that is to reorder this patch before adding
those tests so their first version includes these checks and then
the values update when changing the implementation.

Thanks,
-Stolee


