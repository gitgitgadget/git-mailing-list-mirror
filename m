Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF71922F388
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 04:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770696942; cv=none; b=ZHhtbMG09YtpZU27i4ySSyCQ2Gz05L6GYitggIRnXNKF4J7wbr3SOWsAu8d9UXGdDjT58mL9A0Nmi4wjjjL5Oj4AxYiyvrTr6iJZzE2yq23HnvTPzXW000NoKrJ9PX+EFcqA5dfdspjph7adtj2dFARf4nXCOCHigL+FyoGdZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770696942; c=relaxed/simple;
	bh=vq3OqmUmpqRDfunJtf21oEhV0m2oH90feg52R2bvPbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BfcACG2YtZ0ppfgxLoEFPKRZpjJFmp5KkWkOuDkAaKba/HHo1E2/gcINmIdkndzWeIldU5tAitIrdFjaMhhCn2CR0AIdYmZiTXGane/Bue84Aecj3FAnMDzCNfL/A+C5n7tnXhnnfFvbkdZffDnf+qxKqGbpSAjqHbRBv0g6eig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M588WGAu; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M588WGAu"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c710439535so32088085a.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 20:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770696941; x=1771301741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O1iAsxCBtIpCosjiq2xLgqWGcTFf2zfbGz6F4grotiQ=;
        b=M588WGAuvUqCoVWp01FeMmdVo0IBMNfUIGBI3Nlr5clCn18ZVD/tz8/fwjfhSUgpng
         U0z0YvcLHnYdcTvlCUezFHQlHG9hmon7izP/BKpQCbUEiQM3ac8abwBLqA9Yu79+d8Nl
         3U33XjgW4N50W+Q5r9cE9Lu/18U2Xvyw7YNlv30aTWa9hRLPWVmmbeXs92gseSfWSZto
         dgP+fNmv/FTMJOLO0A1f1vCph54H8gNRi5wIDpJlARlIkzBjPkbx5tOoxoS43ywf0Nh3
         93+l/aRCGmy+9IBpwhJdcSH3LMlcdVnIdd0MtoxbWOw19JXUquEyDa4YsFSEl0Yd+1vK
         6nMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770696941; x=1771301741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O1iAsxCBtIpCosjiq2xLgqWGcTFf2zfbGz6F4grotiQ=;
        b=h/zHjpW+CckH7HQbILbe2ZguB4NeMt2InS6Q17Yw3nPwAkz7s3tI4dpZ/tO4s/TTLt
         PcBmglqRMmCSHHF0ew+/YbJb5lPPoH/BMXVEkg7gb0BkNckh1PtfH9uGUIyKyY8E1OEl
         +0juvaK91O0QhxvxHeCp15OGiMsenzO7OQxyWaDrA0vKK9O3sl2K5rP2uK4Gfw4zoNW1
         bceYJaRfn+YavBXV2SV2hZDk29kNNpSe/mMD2vPG/MRD6lNsM34fBj9wu00NzFLei9ih
         a6xcqHVMT1ZMiXzx8BjsSS2tdqPc3HbbHBfug+c0+ZtK3JPJ/Lf1+9nvDdan3v6Vfy59
         4heA==
X-Forwarded-Encrypted: i=1; AJvYcCVlqufRW2ja89dUwYVRBi8Pi0Lhnq7jaSj8UWrien7CGuDdWNaPfQ/GYwaKGYvplKt9EFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7cLi5snuoGzdoNzbokirBSIlTtfBQ3qAaw1KWZNOBvxzqrqT5
	ZsJpVSjEbp7q6IlETuaqS+t9OGj81jGkI1293itymdKKr+s7GMWzbN80
X-Gm-Gg: AZuq6aISqjkRDTo5yyz8HDvmXW60T9GBVufqZ9RylOnnOGzsteGQGCXca76WmCgn1mp
	u+m2U/Gmo1KuxLpeH3O2fW4qWqUMBw5zCKGmjVx5eeJEWZcJbk7KydBg9Q0YlIIwBFPt4cjhQlp
	MGozwUdyCX0VA8l7rIre2dz/LYBD6zBkCx3ccy4rQKdVsLdMzt8JuJA2fJKOzYbvVchdbIy0r11
	7MASUtJ9ytZBwMf50vLzkvgL/yRhahTa+aSvq8gJLQSv8tRp+fY7kO1OZBFKJpAw5Ze9HlpzWst
	69uSKTzYakEH5i0taDgvo5EIqfFBQI7xambt4L05j4XHYqb0jwmH66EJzR/VKKHidQXO89YFcSY
	GupkFJwEd/CRvHrPyHNzNIsMbzcpTOQeiEjfKRwykefo0tanLkQU3r9BSZjL3l1hntTnQ8UpohV
	5qZ4waWqW0cAYf5H3J8dQDXkuFAe8ofLA3FajyvfhkNKYddTWLrTneY3JUlUTDY0WGSYzDcQ==
X-Received: by 2002:a05:620a:2984:b0:8c7:136f:3fb5 with SMTP id af79cd13be357-8caf09634aamr1832966385a.54.1770696940661;
        Mon, 09 Feb 2026 20:15:40 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-896fb9ad27fsm43474876d6.4.2026.02.09.20.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 20:15:40 -0800 (PST)
Message-ID: <ce2887a1-1324-4ca7-aa1a-549baec7a770@gmail.com>
Date: Mon, 9 Feb 2026 23:15:39 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] trace2: add macOS process ancestry tracing
To: Matthew John Cheetham <mjcheetham@outlook.com>,
 Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
 <d99a30a1a77f0f23468dba987da08b32dd9a92fa.1770307510.git.gitgitgadget@gmail.com>
 <7390e189-16ac-43b3-a63c-a8b942d5934b@gmail.com>
 <VI0PR03MB1163484F620092CD9CE36C836C065A@VI0PR03MB11634.eurprd03.prod.outlook.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <VI0PR03MB1163484F620092CD9CE36C836C065A@VI0PR03MB11634.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/9/2026 10:13 AM, Matthew John Cheetham wrote:
> On 09/02/2026 14:36, Derrick Stolee wrote:

>>> +    /*
>>> +     * Recurse to the parent process. Stop if ppid is 0 or 1
>>> +     * (init/launchd) or if we've reached ourselves (cycle).
>>> +     */
>>> +    if (ppid > 1 && ppid != pid)
>>> +        push_ancestry_name(names, ppid, depth + 1);
>>
>> This kind of tail recursion could be easily converted into a loop. I
>> usually prefer loops to recursion when possible, in case we want to allow
>> an unlimited number of parents in the future.
> 
> I had based this on the compat/linux/procinfo.c implementation which
> also uses recursion to walk the parent processes (and also defines an
> upper limit to the number of processes to walk).
> 
> If I were to transform this to a loop, would we not also be wanting to
> update linux/procinfo.c too?

If you're matching the structure in the Linux version, then keep it.

If it's worth fixing, then it would be worth fixing in both places at
a later time.
 
Thanks,
-Stolee

