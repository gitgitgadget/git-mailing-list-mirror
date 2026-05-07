Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DC93D668C
	for <git@vger.kernel.org>; Thu,  7 May 2026 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154059; cv=none; b=QZ1a6mqbm4xpquEJfbfGjrav3UaPHd3NOEas9hIzeOPOujf7pG8reu88H1WkLNNh/IM0jGIZWtUfGa2Uqag+IRyyfAU9buZmHUJ+/XAuB5fAbOCIEBAGy06ZkStFV5s2NNrv+P28+bRUyMWdJUsTXGH/VKI+BGtGMsI7P5TMKPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154059; c=relaxed/simple;
	bh=ANj+59TozRp4BBB74n+XEHVIGGc8XfOHlWxQ/J3mb3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rfi66YYB4fsXae4cq7fFZzxQNGGwUsuA73pFpBF0z9zMatmI2WgAN7sKD4mp8rBLLe8MytSs1wbs0w1/uQ8uCuawABqpT/H2Tbzkxfx7lmPZhSo3kveVzykp6NOKxto9Y0rjnb+zYYs2jtjLVl65nHFG0M8VIXudyxlyzmT3+00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAofsnLx; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAofsnLx"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8b74b460d77so6694736d6.3
        for <git@vger.kernel.org>; Thu, 07 May 2026 04:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778154057; x=1778758857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hBZ5cHob5Yas1RHpzEsCxvGp5JXGdPwgCRiMvsX8BKM=;
        b=TAofsnLxTa6pQY52dS5s52r1SqdUImnhm0TzwwqRUmQKZjEx9EtVtFWHi0M1RNbiY+
         +NDvgFXkCKBP61dIL92XksOIsgZ4VfPMEUJb7LHg+/WJq6CgiWZ1x81egXyC9J5uSkmC
         Dj+axBxJZ+Q65yHILhapJQRIMcKtu/RH75KyiF8wzPX/yosx5p2xR+pu2m+443swIcv4
         L3t4wJZktBz30yPPzCTqtdFr7V3wAvcyuyL1cEzgua2auR1wAtyJN9iOm2Dqe6Xj19Jz
         cHaWW5QAgAZzCRYm9lV0UiUjw8fhi5ItexkNB1pcu7K8ki19Z9pKG+P02UidrB/F5TDc
         UXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778154057; x=1778758857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hBZ5cHob5Yas1RHpzEsCxvGp5JXGdPwgCRiMvsX8BKM=;
        b=O0Ja4SnAJ+jAoiXpiAyUae7Hl7sb/1tsFvsdoY8EXRwvT+3CBXqwxk/pEfNNtHL5wv
         pwgFedimGjQv93n6hFzWRUZtn/g1LlYLN47UuTv9rTGiMrh9ezeUFJIiIWwN9A7YXcDB
         dd6+o/S2aGK6vyGH8k9KJ9tqVKLDDpSIFnrpJIElxuJHP+xRtzVgJ9l56gOaKQO4Jf3w
         mXwATW3Y4no3f1xkgHljYFVQd7crRfM1KnJLs+2UYs3ghKyScIqq7+IieDYrdPoa6ZnW
         wRoSZJmmGV/GbDdIYu9qFVJ/7EpDGykeJUltxj/lIDxMucmQCrLspv0V+9MYA8TmT5ml
         OSCg==
X-Forwarded-Encrypted: i=1; AFNElJ8+QEEsuaKXoj26b2hprZEWW87iZXs/jFEQIRkAGOD0MHCdiaBHRV+3vt5quanicvcW2So=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy302TEcMiVSgY2k+O3S1JX8ww7FioIIkGYvg6nHfiUZ+flQlr6
	Jk9ZcWrtCw3Lm1gEXAdfVuayw3/MpEF90TG7M5DclNFGfF3fLS1+ExSM
X-Gm-Gg: AeBDievGGEIXZfQbuBhfQlYEqrenphfmzyhHe+VYx/C3DL6OYMIhMgtUu/rm0yu8T0d
	J2hf+es4CFEuelngeFflZRqA7P3XOgx2pI98EDSWiE4jPGhLjM3UWPc2K69fHaXSSGgmgpJAYPu
	BIH5DwCditSeU8Gc4G/hfIqznSmpbIlQ7kIQhgRm1kdrfGH3Oim589Za0LJWa53l3UWibr/kDfP
	RV1feEikXzUldqLF6iKe/Lq3o5O6f0262JS9dvStBQ9BDZQcdDswjhL+d4kALbefxCjDQe1gYwt
	dVC68+LtkvStt+tDpKRU63jRm6m6kLcrmh6f/oCOWziHTegYDBOfRjNZ6TAkcA+FQoznurIn1bU
	AKQ8c/YV8bYg4WYf0gHzxfu8OX0JjXFwx/ywQzWnh3T0ygBNSVnOy64Cc2wP9K17ftdI+e7OCy1
	FAVi9TWFxamX3Q0rF0DFiqU+KqFBYocDkWrPi1ooU45MLT0GaQsU09HP4RlNyq3UykhQwrJI1Q6
	kblwD1o2rJ/uh2pC0NH0nO3NTty2/G6Sm5GJuzn7zX0mH5HSVDv6sS7NIMDP9ohkpHG9g==
X-Received: by 2002:a05:6214:1d2e:b0:8ae:61f1:c562 with SMTP id 6a1803df08f44-8bc41bca521mr119011746d6.6.1778154056905;
        Thu, 07 May 2026 04:40:56 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:c441:9261:ffb:e4da? ([2605:a601:9b88:8300:c441:9261:ffb:e4da])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5397bdc7bsm211766586d6.20.2026.05.07.04.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 04:40:56 -0700 (PDT)
Message-ID: <f5a08ae2-3eec-4939-b6d3-c31f8968dd09@gmail.com>
Date: Thu, 7 May 2026 07:40:55 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] pack-objects: integrate --path-walk and some
 --filter options
To: Taylor Blau <me@ttaylorr.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, karthik.188@gmail.com,
 kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net, ps@pks.im
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
 <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
 <f5d8d4aa-2453-45ef-bc96-2b94bdf55c7e@gmail.com>
 <afo+mEITFBSLevqV@nand.local>
 <07b36bd8-376b-4a98-a735-0c0f75452c24@gmail.com>
 <afpWOGhWJrRdPtcy@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <afpWOGhWJrRdPtcy@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/5/26 4:42 PM, Taylor Blau wrote:
> On Tue, May 05, 2026 at 03:44:56PM -0400, Derrick Stolee wrote:
>> Thanks for this suggestion. I got pulled away from my investigation, so
>> wasn't to this point yet.
> 
> No problem. One of those things that in the course of responding to your
> email, I had written enough to fix at least one of the tests. I hope I
> didn't step on any toes as a consequence.
> 
>> I think the initial idea was that the feature was too niche to add it to
>> the CI builds right away. Your series is going to make it a lot more
>> important, so adding this to CI builds may be valuable.
> 
> Sounds good to me. I imagine that this makes more sense to place as a
> preparatory patch in your series, but LMK if you would rather I place it
> in mine.

I've got some changes that make everything work, and they plug into
the right patches at the right time. I need to do a few more rounds
of tweaking, but I should have a new version of the series ready by
tomorrow with these fixes.

In summary, we've got a few things going on:

1. At the base of the topic, the backfill tests fail because they
    assert that stderr is empty and the warning about combining
    filters comes up. This goes away with the integration, but it
    was causing the tests to fail patch-by-patch.

2. In partial clone situations, as you deduced, the direct object
    requests were getting filtered out. This starts with the blob
    requests with blob:none and then the tree requests are added
    in with the tree:0 filter.

3. When getting to your bitmap patches, there are some subtleties
    around the --path-walk option adding --boundary to the revision
    walk but that changes the object set and breaks tests. I need
    to think more about the solution here, but I'll include it as
    a reply to my v3 cover letter when the rest of this series is
    re-rolled.

Thanks,
-Stolee

