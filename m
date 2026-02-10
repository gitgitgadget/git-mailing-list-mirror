Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116A4328B6E
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 04:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770697336; cv=none; b=r3Tl0xjvKuIRV8DJNxqKIJLhj6wO7UO55xBY60b1WfVxjOMgOf+TEb/ExNMf2OxHClwAu4DwRa174qmpWS3WNoa2seCp4WcnC8hE5Q3vJInV2m5Iq3lJHb9hgxCwiFMUrmzIteWdyggxO+MVurPHWEEmrtwYeM7HM5DlcH3WLrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770697336; c=relaxed/simple;
	bh=YHDSqno6w22Evl6jtmdftgUW4Ujagu2LfaNbdqq/I60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rOB9bh+DIT4g3NxjyAPc3aCUvxEWixnH/8H8wEy3rmuxDAiofJ2W08jjkXk2u3T95apLG8dAHBLq3Keodxq8lNtY2krrbO5JKOBaeyFSmO96evdMCNDJW3zDH1sTU0zDmOMtIOTI1Qzvo4wgnKXi7itskfoQkryLLGmFOCCZJSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCoMcAgj; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCoMcAgj"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb20bcff5aso8991985a.3
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 20:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770697334; x=1771302134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ppV4nbqjJfQrfPqBZrSE6VFRGim2tuMz003HiTnDMP4=;
        b=WCoMcAgjEc7lZrENI90MY4rLOoWkudwjces8bHz/PA0kW7UXJ2HOab+E2+0gfNAUXz
         en94NK50rQabmnMGFf3piCpe64wH1BjGiG+d9Q0bsxw2GlsOo8KD8OENBtL+ziZS4lhV
         APESJLi3UjBx3vQ9lyTzck9Q0N4azidfUqKQBQhz8tAyM8NoE3emEl5o2F4vMasIq2FE
         U15+7gDYx7cZwccP2dyivvBchVaa83f88ae4da/JNKwOihHIY6wxehgUrSPCWSaNPTQO
         i4CTLwSq/B0I97t3CjMhzSjqhHqiDTN0J8CHIvRMQ5sO5htGwvARoXiNa76tuauBrpd5
         h3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770697334; x=1771302134;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppV4nbqjJfQrfPqBZrSE6VFRGim2tuMz003HiTnDMP4=;
        b=uu6HAbvcFrQELiOeOgpB+XDYS8rjdJdwUNh52B/EHcU/6RGcwu7iud/q2nO3g4PHXd
         DJn4bpSlPWM1rcpODwCoOmz/yOtYdN6hn4GjILc004ePYRjMtwiwN+crPRVp8LTqF4qf
         qYGihQCXFMGZz0WgbGawbh7nbVdjPUe4/TtCJWYDfqTa9WQcBDu5gPAALZpQDRy8R5VQ
         e/tU2YD4Xuo5fTQBuUcIyCCq0rgdDpOOKaJnZ3olVJtSg6qhvKc6GDRcxIQqc5P/F11i
         zXGTzfriMJihkY3Jey1zA8Bb8jcH+yWjUgKKMTe6W4AbWC3TbZ+rTzpgH2Yk97P50ooE
         /vqg==
X-Forwarded-Encrypted: i=1; AJvYcCWcG+skYI2Qy6FD31ZOr1mh8ej6cfBaCHkF4yYvKcYS/+Y8tNZUbNOUOeeqfWF4EU3+Fmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNC/r63BQXzJO0UhhFMdw4uBgzvcuYgRItvEMBYwPF8P9+Mq5y
	IA/DCZH4xPtBWvQIVspRSt3P7nX2WwolVU5JxVzgQ0h1Ugm61B2LcnJC
X-Gm-Gg: AZuq6aJvuHVb+0g+255eGuj71PSd3KPgeblYZh80TUjXUpysRGHlt712NGq2SMVgrVX
	qc8zd2j3M7K/8Ht8+VucIQipd3Oh6cRRUpE46Ykc4wt9vZdZUUy3+Ple7o4l8MydvH3+aknMKmt
	4SKnkAokubJxyQuuGHEQChJkHtppFxe2ctt889tCvkVGkm1Jto/42jI//1tSadjDY4kjI3bdnug
	xHZDUPLHu+uG0k7LCSVXEcaAXTqf9EnfOZMrM/y/FN0yO0jdZXbRw8LlrOkXAl4yxshoza+MBVS
	PzyDVhi5odttXp0UxsatSpT9Ucj8rCnozK+uUs7b40q0I5fNUnsQQDW4EYfztJb/22GbpUM6THL
	+/sxHEN31UPGDIM7YZv+wFT8Ub9Gssu9EHYtY3ntjhNShVAljxpmPYH8LpzrUsVchhHu4R6bWMp
	K4Bznc7B53hXHmTD/Lv1alBKXqOxKeVKCuvfWPpF0iwz9qj+lOJToMoyRyjmCW8Ay6UxSxNQ==
X-Received: by 2002:a05:620a:40c9:b0:8a4:107a:6772 with SMTP id af79cd13be357-8cb1f72a954mr109906585a.76.1770697333994;
        Mon, 09 Feb 2026 20:22:13 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c077a8asm93178996d6.52.2026.02.09.20.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 20:22:13 -0800 (PST)
Message-ID: <a9c39434-c179-491f-87fb-52b1c2705790@gmail.com>
Date: Mon, 9 Feb 2026 23:22:12 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] docs: add design doc for config-batch
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
 <014e959cf4a4e19afe6becdb155f49d0f96739f8.1770214803.git.gitgitgadget@gmail.com>
 <1702a6b0-78a0-49e8-b3e0-a112c251c9ed@app.fastmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <1702a6b0-78a0-49e8-b3e0-a112c251c9ed@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/2026 12:38 PM, Kristoffer Haugsbakk wrote:
> On Wed, Feb 4, 2026, at 15:19, Derrick Stolee via GitGitGadget wrote:

>> +`git config list [--<scope>]`::
>> +	Getting all values, regardless of config key, would require a
>> +	multi-valued output similar to the `help` command. This tool will
>> +	likely assume advanced options such as `--show-origin`.
> 
> What does it mean to assume options?

I mean that since we expect to have the output parsed by tools, then
we will probably want the maximum amount of information by default.
Maybe --show-origin isn't as helpful as --show-scope.
 
Thanks,
-Stolee

