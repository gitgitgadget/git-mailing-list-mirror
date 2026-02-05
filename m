Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CF842DFE0
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307130; cv=none; b=bLb9QO/7ITFNVxYXeiwReKlPbOmRfZJU916J2oRNrJtHn86jPgxbWzZ+lZrDFELc5nvwoFgdRn5ZUr5e7hxPDKNpSIskErpiVrUkkjI34xmcPGWg52mq1xIXT5KA+rJTdnu2FzRHfC72zKuD4lZtqkVA/J0we5DhdCJItfrVErU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307130; c=relaxed/simple;
	bh=U5WXy7u8i0xhbQw2L5xz31RkAvqc3z8aYxjKGjnKRjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFKZmrckbPXKMthi1JrlG9E882xuz8MO97PI6CRuisyWKHbcJVYH5UEU7KtdZXaC8RmiFT0qt0A8m7KMZNXrwvt8/RGm7oPab+suWmvD/7K4wo5mrpGdICGSjXvLU1EBvaDlH/kB1ja30BGQGGaYDz0RmMgZXCIUgmPXUCFsCdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PC6A6gLG; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC6A6gLG"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48068ed1eccso11824925e9.2
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 07:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770307129; x=1770911929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HNQAHSlzwJl7Nc7gNh3vWs5zYcNs7b02MOe6l05V78Q=;
        b=PC6A6gLG0j4OSXvHcJtqFNNKtP1ugjKbvIeH6LWn2xHnP6MF/Ur/gDIXrTjKvyS5LD
         z15IzhudTH9hjzaNasCiMExfZbY1VfGByov9vcylgJ+vW91aIsukMYmxCPTG9FLP/5wr
         auwHUcILsp/HbkJoTFTWJNA3a4CdQhxtbq2VqG4VsA/U7lkzA2IburPGXItmhg4uA1+n
         jTV8yCubLVlfS9LNJcLonVm2vSUVe+vY+EwQ7eNMg8zMh7YmvzBolwOIk0GBlwisYg6f
         FF+9bbD0yXS3EgKi7BgImDX2KswcLz5YN+D1WdKFw+Y/gKhdxFNyujX0eBDTBNwBCTtm
         8JsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770307129; x=1770911929;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNQAHSlzwJl7Nc7gNh3vWs5zYcNs7b02MOe6l05V78Q=;
        b=q6oH/Ytph5hCSeRmMojj5J2XboA0vk4+YnRWdPTrs6tnik7KHyWof/T8HnL0khGoiJ
         LWr0afzM8xqivVPvLQphEDOU7FKwWAWcSFDBehR2Zrqc3ttRBJQLri8DaDO6IKL6J/Wt
         sPhrKqNt9Bef62/Wi2Hbcu7SsOBlQhf8Z5qdjLx5YsOTe1WyZTcJVeKACGCoZ2/8hTet
         z63U33rKLYWVU0V6AUVkqdDJk6rUd10iWWU9WxndoJQ7hCxkShk84j+p7rc0Ty2BxH57
         qvRnOxtNdxWMa7lZ28MDlj3I0MPclEhJ67xgJ0IzZGXGs+B9cvfQ/06fnZtbFlUiQTBp
         vJCw==
X-Forwarded-Encrypted: i=1; AJvYcCUaYpuz9+n3NgsBfZRmo7RUpT0O2z8T2BABOFhnY9Uq+K7mrOI81tOS64KvPu81WGYwGu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaoPdaLft0yjy70Wz5ToBqg5hrtRku/p9SVjgDn1xkVP8G1+t3
	ylLXeTGIRhAb1UR3jzv1kGZriamRlg0hIsi0Zqg5lSNY46I9nNGoAdwk
X-Gm-Gg: AZuq6aKW4kYnF2gmQnwj6bCmj2TI2MxnBxz2M4uyrrLQ4B6iNTnJCMtEee6/UFT4GZz
	nxRT4sBSEEYywjxBFZMz/KXLrUioXq14ybTzPnSjpIcQ0cjRG+Z1xZdanxWAOWWxeK/HcOn0V51
	KA/0QNjAsM9nU1R1VDWTcZTnurjWdO4x6FXu9eSxYKGicVOHI2DvN/UvqhD9sZLoYvNfe5uetmK
	bjhBkh53Qr5q7DmXE4c1ZHKd4e0YbHuAKTElIAHApu3kh9lpxNs+YIepTZTXk/5A/ObybKcSnA2
	x9DUsPJiFnHJqWPxkTV+AKVtM42C2WYMPtJx+I4rn+1ErzaEN59sND+/aYoVeJpw8jeUnnj94hK
	GX+wNskWd7xNBqwsKqiBnDkbRIP07ypmZBQZycSMCfayjh38NucESDmDRw9QnKJvrE0n/Ak7Are
	RQ2aicjV8h3hcR4L0rMHLZkJSwJ505HDAJW/ShdqFhZmET9XO6nqjK9je7W/gtwaTOWw==
X-Received: by 2002:a05:600c:8b0f:b0:477:a54a:acba with SMTP id 5b1f17b1804b1-4830e97938fmr105694135e9.17.1770307128777;
        Thu, 05 Feb 2026 07:58:48 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d2c88dsm92272315e9.5.2026.02.05.07.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 07:58:48 -0800 (PST)
Message-ID: <f432e771-8247-4305-afef-94333729033d@gmail.com>
Date: Thu, 5 Feb 2026 15:58:47 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH V2 2/3] wt-status: pass struct repository and wt_status
 through function parameters
To: Karthik Nayak <karthik.188@gmail.com>,
 Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260205101524.125452-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260205101524.125452-3-shreyanshpaliwalcmsmn@gmail.com>
 <CAOLa=ZSkTH8KC04KubktP1EkU4EHYs0CtmUPkPVe74zi0wcTBA@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAOLa=ZSkTH8KC04KubktP1EkU4EHYs0CtmUPkPVe74zi0wcTBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/02/2026 11:09, Karthik Nayak wrote:
> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
> 
>> Some functions in wt-status.c relied on the_repository because no
>> repository instance was available in their local scope.
>> There is also a specific case in wt_status_check_rebase() where the
>> worktree can be NULL, so accessing wt->repo may lead to a segfault.
>>
>> Update these functions to accept a struct repository or struct
>> wt_status parameter, and adjust callers accordingly.

These callers pass wt->repo so it's important to explain that the 
callers all have a non-NULL worktree instance so passing wt->repo to 
wt_status_check_rebase() is safe.

>> Replace the
>> remaining uses of the_repository in these functions with the
>> passed-in repository instance.
>>
>> This removes the use of the_repository global variable from
>> wt-status.c completely.
>>
> 
> Okay, but this doesn't fix the issue I stated in the previous commit. I
> do wonder if we can re-order the commits and pass the repo struct to
> functions like 'get_branch()'.

That sounds like a good suggestion

Thanks

Phillip

