Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6252253FB
	for <git@vger.kernel.org>; Wed, 14 May 2025 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235799; cv=none; b=iZqfFhcGZBuSMj9RiorZy7dzeuiMI2YzdAgUwieONVPtuJeIow90wJdCBeJbVRC9/oTA/Xig8jdHF32GC/E0hKbRQeLp57lR33+LtOX9LcdZxj/ILH/C/Dh2KeYEXNA/dv2fYwNg7R1gI9s+t5EWzLPBaArzfsnbNVByBNqqUsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235799; c=relaxed/simple;
	bh=hamSteYIl2vY4vosEa0VmLvq24MvVeRVn6dNzUay0lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sYcJUZBwwfeV8chGL1aP0GQyzq4NqcXi+TtEL7Ej5PxQlJADyjDCbHbZdWLaq0j08fZXTaGz0+k5GCEbX4E4g+Kico7ucp38YkskTf9OgY8xIeooPO4BY5I80rAQ+vmVbgIYKX3qK/bwqOjLqGWNrR0vi5ZEsXhEgV5o91k/4mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msMw/u6l; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msMw/u6l"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a0b933f214so3423684f8f.0
        for <git@vger.kernel.org>; Wed, 14 May 2025 08:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747235796; x=1747840596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pr9mt8/kTPmQWq9WlUyIihKI0omBcBgSJjZSrAtsBbw=;
        b=msMw/u6lC+1hM6iP4pBtA8txIL35wqNUqTmay8funZdhFryV206oCjlfoQoq0ozPCo
         iAULOBBep9/dcCVqYukE7z2Xv0qxRSV9csa8DF3cRI2zLuChZFAK6uR/uGlT/nzQSjZR
         Zoqc9lBNF2HPm/8KrGRXuRyGYCkyHNoutt8WyY88Kf8jrEnf5I2g34er3H8zr1rJuzjL
         Tktw1dontevQ296Wwcp0+Nr/agl6UNn7JqexQ0aIIOkTQ8LiGZ12m3+uBvP3jba/sJm7
         L0cWxuPfLYtBkHqGpa32a8vWct+0A2BMWr2Lov0COMuFpQIzN98aTc+BfAOBHZnz7pOc
         +59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747235796; x=1747840596;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pr9mt8/kTPmQWq9WlUyIihKI0omBcBgSJjZSrAtsBbw=;
        b=SP8sBNJWkjqC0eikG1SYBmwJuyPqzPoBXVkGyZOuuHkZbg+tCvZ8DG2sEAvHx7o/GI
         Bz+spsUF+q9L6pwyYIx1sRfbdYxhJpJGWF7qChY4Ov2ak08dIsXv2WllMRrab6/dadLM
         R6kpQO9YJAJA7VKhG+F7rdM8yr33pvKg618RgcSlCQ1a521HvY5hdoq5vtblcv87vsnr
         /e0A+rU99xMyWKuCb5FqFRqJg8uMGtgucjnjJP4yHb2rc+eVpRQqaj4GqRuEunCjSZya
         tCiHliK8c4IOJ04NuxQv3i0zPi7H18G8H6ncBIgPXyobWzQgBIFK4eaKy1/nepM9qmHg
         4tPw==
X-Forwarded-Encrypted: i=1; AJvYcCVGf8ypXUAmFh3Zr21Mr7PFp/a4aMS4KDx8786bnKlDTJTkVOo6YrqNFOXHwPuMH2rDx/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgW4RsGPBP/hPjhkEPoSfT5g6m9oeqbahajHebRCG4l1fJuauA
	UMSW+dqc6i6ytxIFfSTAU7+zcZ8lYtOGJsao94U1eywzrp1w17dh
X-Gm-Gg: ASbGnct4ktS4DKROaqDVJ93pkVyZu2qbFQjs+m8JSDkHgkwlrsyyx+v0ws4l/gFtIiy
	ock6CcmTjB0O0OuT7G35Vx+N17LCijJZDwjFDkqbiD8IRIMuQHKdccapvKXn8GkA/VIBGIEEzpF
	zIIIfMoNyqxnCVXiAVZzhyyZMisapM0s+NnF1kY6CJpCdx18Z9kxdLQJ5QYh60y+Aw4kWu5zogr
	4FtEErMC+tHSZLgVF+qtvAtii64lEAMsHjo62chw7uZp2eWbQ7DTL4DyUb0Azzb5MejbKZ6amHm
	AXs12qaZ4emt9zkr7pRcPvuN3yA2KB3Lw5JvObhss19CcNNA3DqN6/s/hlPL/9yJEyIlCBSHtum
	orlOdOP2FOxszLqmHhE1Dek0zMXU=
X-Google-Smtp-Source: AGHT+IFecdQP9/PXeVhxtf59prGb6AMEhgUas95jT7i+X+T+aXuzYUW7rM78p0PFA1/BYih44Mm0vQ==
X-Received: by 2002:a05:6000:4202:b0:3a0:b9a9:2fd9 with SMTP id ffacd0b85a97d-3a34994f2f7mr2962854f8f.51.1747235795598;
        Wed, 14 May 2025 08:16:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4d0dbsm19718184f8f.88.2025.05.14.08.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 08:16:35 -0700 (PDT)
Message-ID: <c1f7a9d6-4a44-4c00-bf26-6852819361e9@gmail.com>
Date: Wed, 14 May 2025 16:16:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/3] Integrate the sparse index with 'git apply' and 'git
 add -p/-i'
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, newren@gmail.com, Derrick Stolee <stolee@gmail.com>
References: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stolee

On 07/05/2025 01:55, Derrick Stolee via GitGitGadget wrote:
> The sparse index helps make some Git commands faster when using
> sparse-checkout in cone mode. However, not all code paths are aware that the
> index can have non-blob entries, so we are careful about rolling this
> feature out gradually. The cost of this rollout is that some commands are
> slower with the sparse index as they need to expand a sparse index into a
> full index in memory, which requires parsing tree objects to construct the
> full path list.
> 
> This patch series focuses on the 'git add -p' command, which is slow with
> the sparse index for a couple of reasons, handled in the first two patches:
> 
>   1. 'git add -p' uses 'git apply' as a subcommand and 'git apply' needs
>      integration with the sparse index. Luckily, we just need to add the repo
>      setting and appropriate tests to confirm it behaves as expected.
>   2. The interactive modes of 'git add' ('-p' and '-i') leave cmd_add()
>      before the code that sets the repo setting to allow for a sparse index.
>      Patch 2 fixes this and adds appropriate tests to confirm the behavior in
>      a sparse-checkout.

This made me wonder about the other commands that take "--patch" like 
checkout and reset. Do you know how well they handle the sparse index? 
They'll all benefit from the changes to git apply in this series but I 
was wondering if they need any further changes.

Best Wishes

Phillip

> A third patch adds a performance test to p2000-sparse-operations.sh to
> confirm that we are getting the performance improvement we expect:
> 
>                          BASE    PATCH 1        PATCH 2
> ---------------------------------------------------------
> 2000.118: (full-v3)     0.80   0.84 +5.0%     0.84  +5.0%
> 2000.119: (full-v4)     0.76   0.79 +3.9%     0.80  +5.3%
> 2000.120: (sparse-v3)   2.09   1.39 -33.5%    0.07 -96.7%
> 2000.121: (sparse-v4)   2.09   1.39 -33.5%    0.07 -96.7%
> 
> 
> Thanks, -Stolee
> 
> Derrick Stolee (3):
>    apply: integrate with the sparse index
>    git add: make -p/-i aware of sparse index
>    p2000: add performance test for 'git add -p'
> 
>   builtin/add.c                            |   7 +-
>   builtin/apply.c                          |   7 +-
>   t/perf/p2000-sparse-operations.sh        |   1 +
>   t/t1092-sparse-checkout-compatibility.sh | 102 +++++++++++++++++++++++
>   4 files changed, 113 insertions(+), 4 deletions(-)
> 
> 
> base-commit: 6c0bd1fc70efaf053abe4e57c976afdc72d15377
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1914%2Fderrickstolee%2Fapply-sparse-index-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1914/derrickstolee/apply-sparse-index-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1914

