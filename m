Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD3D357D0B
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945293; cv=none; b=fDTU3DNu9b43KDflA/0KUX+oPhTVWGPL5zVZfjyUIjHvwMjBcxU+lTGkGMNS5imKqIzcnUU2UyJHg0eJy3Rn1IyQpUtrrHboJ14cedOv13O9AiK4dR7qEuLllgHIv8dAa6XvQ0QxF/weukCGGqmPjfHA4tHUYXkuBeG3akXc50k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945293; c=relaxed/simple;
	bh=5RFxGzI5fGHYBN+klPlaHvgRVQaYw02ntjZ/1yg6/aM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKvWo2DX16Itna3mi3lQv+jnvFWl86nqabLB5zR4hDm9aU/viucllDvB/KMyKnZ4dX944r0U0UKzWl3vpEUgf+nmEjCVVK3EgzOdXY4i40xXKQ92hPO02UBLxxb5IwdCA5C8MLqPx3QmhQhc1EG6XrYV6O08gDh0ZqZuC9NP4Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9Kh6kLi; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9Kh6kLi"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8568e3ecfc3so3888789b3a.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 02:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788945288; x=1789550088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1xHY8mUHQeDvuTJMDrZWbwZ703nd8PO7epCJp36iWD4=;
        b=c9Kh6kLipQ4qwpWn0PvUG0UFAM3Eiubm2kdd3qJlnaUw9iX//e6WI0hvQ+/42nKfav
         DDJdt8bdxh8qaBOBugWBUUGHQWCQKho8raoXOmu5m3fUKRHtWW7SkhZy8SDW34HILqIQ
         7MXkRcRDT2s7VM8Srmm7fPTwjGrTiA/9xsnCG6bET8LEyDMIFQ/osqWeVVvkW/x8bjll
         WCg59RsevJAiGvL4xFiMYqMLys+9/wI6+FiMqZ7kd8m98czf0/XLRQqFv62g3iSSLAd2
         /n31FiyCdXwdviMRTI0OaU9DtPzqPrQy3sTtS/PzT5gd0lEHSa7VOoNDzF36LDkD1/EL
         guPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788945288; x=1789550088;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1xHY8mUHQeDvuTJMDrZWbwZ703nd8PO7epCJp36iWD4=;
        b=lYX7reLgSIAlyUodJcayIlFUQ9/1YYryIA97rK9CFaautaoMFEhByXcLX1z0F6FqBW
         oy2rajqMRyuWgOb1KL/AC04A+mCr55+jRN4GUr4v4pEPseIWyvNUw2bPN7jCoHtpLB7m
         EVpRRbkBCWw3Erf2o9bh1IAWjSQEuhbAp0VD5JlslbXJTFvR/joxaIfJ1Gcg2/MIr8IN
         01eo08IlA08h42b6kmGyXgtyijj8s7GrYokYxWp8dPu+6N0rHGvpARjTeaXa2/LCUaok
         gwjvrmQADhup81c6tRatIGHpE18kQStQVhBI5eM8XYoD5KwuvtYru6xFFlUZfxG61+/d
         GlmQ==
X-Gm-Message-State: AFuF++lWPxGsP8P4f45kD8yRD9wKK5p79k9ynQ1wExeZUX9dDJikOnvL
	Hdq4R5Vve6XBQh6CV1TdnHTTBLk+S3L77dvBD3Oi65F3bz3ZboW5bBMC
X-Gm-Gg: AYBFou10IS1tQ6KgjrXPwblkushW4QgK0upxlU36bKyeRMZW+Qq+Nfqpj9Q0jLvA08m
	ryVRkrN2lfH5lbqFu9dT9T+db7XTJbyiyF6nIdUfL+mjDa8BBM78Bdu23kCdB5z0aAVwbW40JeL
	5+l6htxbfLXADTkSxyllqiwC4o+dzA7nKw2o7yDMJhsSCj6NWbZ2kdSA0ID4UA7aI8AeoEtzZpj
	F/Duc6GftbKNEbiM4XJEP33KTbV3Q3HTEoXn5TJI11olYgOC4735ATp9sqyGim6mhe7jlJLopWC
	SqHfkUsuSrJUy9hiw62oWDsPbASm3Ya3eouURI+e7OcwfoVGbMdqCMxmUwEwZ5doeXFaLcTVUUs
	p9GIVWYi080HAQe6vyyPP0x37atpNFnGHJN11qPTbwWmWD6oiPwMPfAoN7CESG5OWhFnDTBFblg
	TEVi1pLXfJ+h1rz/9k9W4BVmGgqcZBEVLYdnjRBfuQhMtIp80JFtCvgb0m+WzSbs/ZJ5owKpCEO
	CruS3/rshKTNuRfCMXsS252+kSnjITgbWPwSmlznSx/j5cp5AHrwRc=
X-Received: by 2002:a05:6a21:6f16:b0:3d0:868d:8ccb with SMTP id adf61e73a8af0-3da3a0a8503mr56275117637.13.1788945288289;
        Wed, 09 Sep 2026 02:14:48 -0700 (PDT)
Received: from ?IPV6:2406:7400:12b:61a6:e00a:2dbb:bdc9:907c? ([2406:7400:12b:61a6:e00a:2dbb:bdc9:907c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432424d27asm57327192c88.2.2026.09.09.02.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 02:14:47 -0700 (PDT)
Message-ID: <472d9d2b-efea-48a9-98f0-02364b1a9ccf@gmail.com>
Date: Wed, 9 Sep 2026 14:44:43 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] builtin/init: rename "--ref-format=" to
 "--ref-storage-format="
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
 <20260907-b4-pks-unify-ref-storage-format-v2-1-6733c90ca5b0@pks.im>
 <aacc3fcb-43e6-4f62-b083-5fbabaa9f494@gmail.com> <aqED9Xn6xibcp9pf@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <aqED9Xn6xibcp9pf@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/26 12:30, Patrick Steinhardt wrote:
> On Tue, Sep 08, 2026 at 02:31:22PM +0530, Kaartic Sivaraam wrote:
> 
> I'm aiming for a a quiet deprecation -- the old options keep on working,
> but we don't show them anymore. We may eventually remove them
> altogether, but I neither want to warn about use of old options now or
> even remove them as that would likely cause more negative consequences
> than is worth it. It's not like we want to soon use the old names.
> 

Understood.

> 
> But I agree that we should keep the old options documented. Otherwise,
> it might be hard to figure out what those options do in case they for
> example still exist in an old script.
> 

Yeah, makes sense.

>>
>> Relevant only if we are deprecating the old option: We could change the
>> description of the old option to convey that it is deprecated so that it
>> could be easily distinguished by anyone reading through. I suggest this by
>> noting a similar pattern in `builtin/name-rev.c` for the `--stdin` argument.
> 
> We don't really have to update the description as we pass
> `PARSE_OPT_HIDDEN` anyway, so the option is not even shown.
>

Indeed. I was suggesting to change the description only for the sake of 
someone who reads the code to quickly get an idea that we have 
deprecated the old names. The PARSE_OPT_HIDDEN would definitely hint at 
it but this just a suggestion to make it more obvious :-)

That said, it's fine if we don't change the description too. It isn't a 
big deal.

>> If we don't plan to deprecate, I suppose we could use OPT_ALIAS to clarify
>> that `ref-format` is an alias of `ref-storage-format` similar to how
>> `recursive` is marked as an alias of `recurse-submodules` in
>> `builtin/clone.c`.
> 
> I was originally planning to use `OPT_ALIAS()`, but we don't seem to
> support `PARSE_OPT_HIDDEN` there. Maybe it's better to add a small
> preparatory patch to support that though.
> 

Indeed. OPT_ALIAS does have that caveat. A patch to allow the alias to 
be hidden by choice would indeed be worthwhile.

-- 
Sivaraam

