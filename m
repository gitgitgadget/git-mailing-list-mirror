Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1351FC7CA
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084291; cv=none; b=NSNjX3gy9WGGiofwaq5Ydlu4B/ONATpW42rkXz1ox9rRYheLVVoE3HWrfu1CiTMOaPURVbKSSbvS7Cd3Y91bgJ7UOuDTgxcyAUTGFajs7pLOPA089A+IiOViggaa8U+QH0vY0JvHS7fIU2IakdlTgUHAgPnlzA20Ke7DwgSncd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084291; c=relaxed/simple;
	bh=Ejlp43C7xzB2DvF7rLm1VgZzyxEVNL1bTwsPM5fxstE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oI4Oo7xiKT77lV/2wiivXShJMhzqMZ5vDrEqRqd4DvvJf+N5srTfFB4pf8P1X33sOeq8Au3EOMHDVpnjOMN1y3Bb8XHkllIwP2oszEIWuPLtbaFgrcg5Xi8JAO1CwvdyLfCzNcHPujfXCGWiFWA8VqBiZc2z3ZVL1jnT/ZGRKdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBxQgEbH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBxQgEbH"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abf48293ad0so526085666b.0
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 02:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741084288; x=1741689088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bti1dohy2R9QbFIvhV1vAFgA2Jk09eHW0lSq23tjXcg=;
        b=RBxQgEbHfe13vDVuYHsZOHwao+yMIuZxc7Un5Ea0Vj4OVGeEmo5U1KJD6pGYtOJ7NQ
         wLlnVR6nIA2atpS43uNkNmDokwIAzxBjtLvM7ttm/ItadIgqUJdBmCybjUI2NDbhH+Ie
         +4Vzbv60LRl+Zg8wudZxTUcvI06Ys5U/uiV5V6uWqFuaf8hWGWtGe+QxL8YXKOLSCuEw
         j1cGMgnqam/ZhJygS9rqwfpHiNOjqtBCHfWN6oFhPNhG/ONleRvnm47ZuH3Db0IHex4q
         NdoymcXcSwAbTjE18CgDf1hHR0zTSh3eEfWAt/Hsa2WMROWUr1e8yOZwMGSjLlLCU8GP
         DipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741084288; x=1741689088;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bti1dohy2R9QbFIvhV1vAFgA2Jk09eHW0lSq23tjXcg=;
        b=uqBCGRl6ZwbhqYuTtkyDGuqmgtA6t9RZoaQVJyxBtTUWvGbZZAQavZBe6FBuWR1/al
         7CNeg34Pgq0NtmpiF6ITJq7H7EYLBr67u8jffwZIniEIsUllumCakyo4UrcvkO2OP1bv
         0xE2352MRVodhfxFkyoyyBAbNSV8EQT4mzfbG+VQw+8s/Mtw+ubVxv1BS2ikwmZgfsqW
         a6aipjMHe8Q7aSDi11dGCAq/5pQ9hS4f7dp5Tx9eBHGTWApGW0zxq6U7FB0V9zUvs9fm
         jsJWKE8LyjEY/27p9drWbXw1794SMJwKjIcQTxTUDMDPyH5G1y4lOuSS/ey16V6kv11M
         BasA==
X-Forwarded-Encrypted: i=1; AJvYcCUH7XvRyhjb8/Bl+hbSeZS7jJdiPdvmMHbK7jUr8dN3L5HGhatBuswcIdL8CqMk4C6BPH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsAHcpIIAgYZDi9JtvVuYTWZ5veDBb/HMkD9Ch6EVwEpCt945t
	CJa6t7KEM7ob3T5JUhYssFK4TkxghaZECmX92H6lS1/ao3A8HKV4
X-Gm-Gg: ASbGncu7DpRFqeMhXdhXVq8fS1dT6h1yVY17anANrE+Yp+WAjUeVb9tlAAs1eT4M5ZD
	AMK5HGmqX0t3ujrwn+uT5H/Y0XvovNZs91mYsXHbaz3Q4DUOheAnW79Ul4LeXVgWNYZu/kSlu+3
	nISu/a4wcm7oKO+i4Ig4ssC60InqvckIkpkTvOK3QPfUbUxJdG473Eg8vgH4B/LPviK5pb+zT+7
	sSruAXvRf3LQ/0kuB6wiFBFjWlmPiZH4IiX4QbJgWcam+6+28U4kZnA9jROKOFQlGSulNltfCfV
	Lq2RAce7W6ysuyAkLkCN98ycoTTh9/zrSqbbPtf5sOu5qNxG1EFu9GC0OfL+JUhHO6EuJRgVa2S
	ZbbCOpGvl5mdxIVMOBtGCx6w=
X-Google-Smtp-Source: AGHT+IFc5viVTFo/57oQCTG4vDN96+wqiQoHMVTZhrC7415AXKnH9E4sd5UigfNqK0/cKFOA3L6DjA==
X-Received: by 2002:a17:907:2d20:b0:ac1:e1e1:1f30 with SMTP id a640c23a62f3a-ac1e1e1403fmr559458566b.38.1741084288041;
        Tue, 04 Mar 2025 02:31:28 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac20381299asm6084366b.46.2025.03.04.02.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 02:31:27 -0800 (PST)
Message-ID: <33e6e65e-c68b-4b88-a66b-53b808745a24@gmail.com>
Date: Tue, 4 Mar 2025 10:31:23 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 6/7] refs: implement partial reference transaction
 support
To: Karthik Nayak <karthik.188@gmail.com>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com
References: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
 <20250225-245-partially-atomic-ref-updates-v2-6-cfa3236895d7@gmail.com>
 <2755fb78-d587-4ad9-b22f-b60dfa752d7a@gmail.com>
 <CAOLa=ZQCWFGsaPN+J8R9eQMBJqNNyoeDLkLwCFBbBzTG_R_-sg@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAOLa=ZQCWFGsaPN+J8R9eQMBJqNNyoeDLkLwCFBbBzTG_R_-sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 03/03/2025 20:21, Karthik Nayak wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> On 25/02/2025 09:29, Karthik Nayak wrote:
>>> Git's reference transactions are all-or-nothing: either all updates
>>> succeed, or none do. While this atomic behavior is generally desirable,
>>> it can be suboptimal especially when using the reftable backend, where
>>> batching multiple reference updates into a single transaction is more
>>> efficient than performing them sequentially.
>>>
>>> Introduce partial transaction support with a new flag,
>>> 'REF_TRANSACTION_ALLOW_PARTIAL'. When enabled, this flag allows
>>> individual reference updates that would typically cause the entire
>>> transaction to fail due to non-system-related errors to be marked as
>>> rejected while permitting other updates to proceed. Non-system-related
>>> errors include issues caused by user-provided input values, whereas
>>> system-related errors, such as I/O failures or memory issues, continue
>>> to result in a full transaction failure. This approach enhances
>>> flexibility while preserving transactional integrity where necessary.
>>>
>>> The implementation introduces several key components:
>>>
>>>     - Add 'rejection_err' field to struct `ref_update` to track failed
>>>       updates with failure reason.
>>>
>>>     - Modify reference backends (files, packed, reftable) to handle
>>>       partial transactions by using `ref_transaction_set_rejected()`
>>>       instead of failing the entire transaction when
>>>       `REF_TRANSACTION_ALLOW_PARTIAL` is set.
>>>
>>>     - Add `ref_transaction_for_each_rejected_update()` to let callers
>>>       examine which updates were rejected and why.
>>
>> I think this is a much better design. I wonder if we want to signal to
>> the caller of ref_transaction_commit() that there were ignored errors
>> rather than forcing them to call ref_transaction_for_each_rejected() to
>> find that out. Another possibility would be to call the callback from
>> ref_transaction_commit() but that would mean changing the signature of
>> ref_transaction_begin() to take the callback and user data when
>> REF_TRANSACTION_ALLOW_PARTIAL is passed.
>>
> 
> Yes, I did toy around modifying `ref_transaction_*` at first, but I
> think the current implementation is slightly better. Users of the ref
> API do not have to worry about complexity of partial transactions unless
> they really need to. So in that case, for most users, the API remains
> simple and clean, and for specific users who do want partial transaction
> support, they can activate it via the flag and use the iterator to
> collect the rejections at the end.

That makes sense. I have a slight concern that iterating through the 
errors is O(number of ref updates) rather than O(number of errors). If 
we expect most updates to succeed that it is a shame to have to check 
them all just to see there were no errors. Maybe we could be store the 
errors in a separate list of (update-index, error) pairs to avoid that.

Best Wishes

Phillip

