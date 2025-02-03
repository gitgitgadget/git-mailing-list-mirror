Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F1420896D
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595492; cv=none; b=txX/wa67vtf2uqd8OolokiiuyOvfJC+j8l5rv6xCXUBVJPGl+bmW3YotPT0Ahjn7/cjN9hTTdGkGE3K7xYlY3JXriAv2E8s4zhxCWQ7BdXY+heaPFF5qS/fnr+tOlEGNiPWgdG5azl4FqOhDfkN+6p1ivHcr3qHhIN3epocWxY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595492; c=relaxed/simple;
	bh=rVaJp2N05JIO6euoWCHvBrhBJZpDZTOvGqOH1uHiaH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpTonRkp8wWgfdRfjE8cqOFH8r6yEXXGI68hquqGmRmi8KXJqqIddCc13E3JRcfP/TlnPTvbWdCLmMZ8+QHKBEN1gXmQ/zN6TIed+mpZ4pBVEpNayseDDCzbOM2a8NUK6HlT29dsEFZoCDQ+eVK0sF/pOneaS6fvnS9/TjGVc8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXRw7nwn; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXRw7nwn"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6f44113c101so38941607b3.1
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 07:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738595489; x=1739200289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wVdFt0C/uhIsG20ZFCGFG4lngr1oFMOKTbV48BHcFu8=;
        b=HXRw7nwndmoSVXuyzsq5V1EyO0Of4RG9AEOVaB03fjR6iOw+MEWFBbZSCQ0wyVm+G4
         71hKFC8jokcEWoBpSDofrXCVjFzRLGRxgchIvPu584naLxzbECUQMcL0fLtRLrXJa3cy
         zs3wlIxHkYtps++oLC1ja88+0Oyk813y6webPTc7GEWFDuMK9PxdKcBP8TNp0FJ4kA57
         IhOfsszdUv+ZzWwfKnvtzmF3zURyyscu+VSPMliEZrE4AIko3haUDGfNj8oCquyPLEti
         BhajLsQO5cnXC2G0IjhryMnpE7/SVhJMrcXyOoPWWDO9T/fViZoEGsyCdFYPYuVUh1GN
         Kznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738595489; x=1739200289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVdFt0C/uhIsG20ZFCGFG4lngr1oFMOKTbV48BHcFu8=;
        b=etZG7GEseICL8Lf7aoWbKha4mXGRn7sXqeBjLHiNpMDFyAwl8dlwyrsPPFnEmjqXG3
         UGP2qb+QRE2AH+d1F2b6hITSr0M8L8CL0eir9FLaHo/AoSrfgdv2yP3TQnbKgDhvrAjo
         siDCvFtSKFljJ1yx9bbWF2krR2kZssSWTMFYmkzJSwxROjznaEYAJZ5GO0dXwVtVHAl2
         +CwPFTTv4JpY0JWiE1fDzAVW+jnvLJfzc1Hl5eYBkEkKh3Pi/8viXQeKCPVjVoS6XiKW
         QS9HkZP/1on0lqXWHqZ1zzW80BxIw9C3InLG47b44WvFXK1+/JsEYrrBtKUixGT2Ux18
         Wb+w==
X-Gm-Message-State: AOJu0YwjsYCjWRtw5CuRPjlaayPFIY6uOVcURfWZjBi3AzHBez0jiThl
	FarIGPohKWCyu6YOurCoNLHOfDJQD2bhvOv/fbVeEzN4FBO5mNaS
X-Gm-Gg: ASbGncu125FaZ5MUCq8ikGM8CTHWaCaBxLCo/10dQ1GqTa/ABnSR5jwL0vMQ47d/ZCV
	Tsp3/6JHlS0/WKSQmjZ5ZRg8yGEB65GAVYrP/XVxXci7Dh6K6NiVDzHUk7q6gD2GaT3gw5xkPDx
	aWfvR8IVNh6hlcyhiIzN5rdDoMnNw0eoLvpt9xSCIoFGPa+frzfOrsjn50x2XGKmrQYHwCCZCiT
	UILa+6s3M2cT/Y+k/mfODTYP6TvZ9ZNCKmHxl5UBrMzLytMQpQARHE3wlxdfytVBU2n8KVgwJ4u
	jBc9kt/fa0aCaUh0oNniLXjPRRRNCpx3dLOHrm4lMiTTXXqxsA3oS+qImOmir2Lm6SZ99pO0w64
	wp38=
X-Google-Smtp-Source: AGHT+IH1CUQ0Ze+jjSAmla9eEpYVpE5m01VQ7QFDwznqN3dS2PaZRrZSYQtzrd58C6P7P//Rds00Cw==
X-Received: by 2002:a05:690c:45c4:b0:6ee:8363:96d3 with SMTP id 00721157ae682-6f7a8409ce3mr179620907b3.27.1738595489434;
        Mon, 03 Feb 2025 07:11:29 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:2dfe:af96:f238:f6f1? ([2600:1700:60ba:9810:2dfe:af96:f238:f6f1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f8c4a79b94sm21262757b3.111.2025.02.03.07.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 07:11:28 -0800 (PST)
Message-ID: <34379f16-9da6-440b-8656-5d580056c36b@gmail.com>
Date: Mon, 3 Feb 2025 10:11:28 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] backfill: add --sparse option
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com,
 christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
 jonathantanmy@google.com, karthik.188@gmail.com,
 Derrick Stolee <derrickstolee@github.com>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
 <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
 <2723143afb397507cbc794375525c37497046dc2.1734712193.git.gitgitgadget@gmail.com>
 <Z4jY4rELRYvS2gOk@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Z4jY4rELRYvS2gOk@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/25 5:01 AM, Patrick Steinhardt wrote:
> On Fri, Dec 20, 2024 at 04:29:52PM +0000, Derrick Stolee via GitGitGadget wrote:

>> +		if (ctx->info->pl) {
>> +			int dtype;
>> +			enum pattern_match_result match;
>> +			match = path_matches_pattern_list(path.buf, path.len,
>> +							  path.buf + base_len, &dtype,
>> +							  ctx->info->pl,
>> +							  ctx->repo->index);
>> +
>> +			if (ctx->info->pl->use_cone_patterns &&
>> +			    match == NOT_MATCHED)
>> +				continue;
>> +			else if (!ctx->info->pl->use_cone_patterns &&
>> +				 type == OBJ_BLOB &&
>> +				 match != MATCHED)
> 
> For my own understanding: is there as pecific reason why one of the
> branches uses `== NOT_MATCHED` whereas the other one uses `!= MATCHED`?

With cone mode sparse-checkout, 'match' could equal MATCHED,
MATCHED_RECURSIVE, or UNDECIDED, which we want to be considered all the
same case: continue along this path.

When not in cone mode, we can't decide to filter by trees (hence the
OBJ_BLOB restriction) and then the result can be MATCHED, NOT_MATCHED,
and UNDECIDED. This rule matches the following realization:

  * MATCHED if there is a positive pattern that matches the path.
  * NOT_MATCHED if there is a negative pattern that matches the path.
  * UNDECIDED if no pattern matches the path.

This is subtle, but switching this to "match == NOT_MATCHED" will
result in the test failing (and the test is right).

I will make note of this in my commit message in the next version, as
well as adding a test that has nested positive and negative patterns.

Thanks,
-Stolee

