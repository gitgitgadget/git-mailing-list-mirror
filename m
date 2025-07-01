Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67EF2701D9
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363994; cv=none; b=MQcakhFeN4fI0NtkFylTKJqUBFY6AsL6zIFsaVY04MgFANF1xYxWSWqdvoZiYczBivzBS8vu+A1he32X/dkpNYG1UeALdFVHIPitfPuQKE/5CpKmMAPwd5K4epcr6AyeFM52TIlrdvvopLJSeJQGSzh8G7YMw3+djfjI4NO0tF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363994; c=relaxed/simple;
	bh=VAaTd69k2qI0aHVXrtzzx1ffae8Wn3fpWkTlPf1k078=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=maDLWrOzjkFT563gpjdmAQgLQPOneyDV2mSVEXLsTC0GTUZJqO6rc09/ZghUtgGc66HHg+9qe+Arhx3IOBrCJjvHLNXbtlMXmiIv21L+U3vSLbbi1pD+6B4B7/+MS0qPjv5No9Z+iqiJCrfBZYZi34uRnFCPwzh1bc3rQGmJCoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFZRinQ8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFZRinQ8"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4538bc1cffdso29392435e9.0
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 02:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751363991; x=1751968791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UfzI3hZVp9SYx8K84zkcw6WXCdbU+e3GE7TNqraR0Kw=;
        b=FFZRinQ8P5E20sTH/bRDwYxGvx6K7TBW71NUiB9BwhG/NwqfK+W9kPACqqkL3QPO4D
         XedBnpNcOBHYVyaxwpLlIc2YrV30o/qAkOXI8nLhjONcktw51cPZNEuvRWdGMMZfwptb
         moZRioqW8GWxAjn2lfLuvuv3ZZui+Hm5GAyO5JI1wybaEQsjE9rKVsPewXC8efFNd0Kc
         vY7DLujdU2pf9CaEKPH5/M8LMdjS/mN/EiqVeWJAhzcyUNr8wdDX3WhrcIZZMUA4cv+o
         z04hwFD9YDTKqg9WjbB+ZtTrGXguS8iJ00PgUbTXkQ4+GSp3qbnWb73Q4Zw01lqpxYoQ
         MKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751363991; x=1751968791;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UfzI3hZVp9SYx8K84zkcw6WXCdbU+e3GE7TNqraR0Kw=;
        b=LGH72awanTz4cU7M3oYYhx84ebIF7NdGd9tM4YCPvredRtR9O2IPEI34mdUW7ftSTb
         mv8uO/uIfh0E/MD1A0NG/Ex9GGGPYDm0BaPwK1DpWvPc6zHJrnv1LpDywHU9VpDZMgdx
         De38/GYt7TBulQWbX8a+GVimtbd+1Jfu4Wo5XOnXVuUVTNUg/k9Uv7dqxcGvJbfF/LHL
         2/YVMCEVH9pU0FFZtFAu1M6jQUMqXH0fxAEHydeVKODxFGTuuTZEifhkOJYAqcdea6dq
         S89lZiMJuwyXgnfgaqZFo9PtkYgUQZOze378OLKEflIQmF0/P68wR7SWrBXfSBcZ/M3Q
         XP/g==
X-Forwarded-Encrypted: i=1; AJvYcCUcwIZuD0aeOFpIrIwm5CVEorAXfNmkGJ0GQJfiaZhF1ZUkgcDsMDfkqCwxszm3C2V9WXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP3L49H32hTyFEa5F3HbpQdBt2HK64hdwA6vK5kxYMw8K0az92
	5EOOOOvUQ69B0mCgE02Jroxon4FZ+U8ul7Ur5YA3oq1HuLs7P4ulZLJH
X-Gm-Gg: ASbGncvRmDONVfQc6YmBkzDaSRHCORwu5q7PXGicLY7Ro8/Afi0BHjsiI0aZj9V96FM
	XwN0s+LVYBwTsTtSChJw3yBxuIvRez7UELpnKL0WRlQznysencBlMjbduLdHGmneYGnnzDJC8SN
	hila0Bcxx0TOLl5IbPO15JwXrMKmldOeuruQjZs9FhOd1COU8a6yAFsT568Q8Vg9vJs7CJ2FadN
	pIZvYO1jfjl/nbDvU4+fIHoK3M7ponXFfBU2FUG2WySN1du9epJ8f8VkP8ubWxWTI2HQsCdHFl5
	rfeEd2JYZl+thzJ07Kx9+XyFv+Bky2BScOIz7zBpC/KG6tYGA7UvoED8Pa28LEPVxHiyD8JPrZz
	Brx3KXrhBilN7mugWROrSsMxkiVUJRIedEVav3AFjoafyqCnmOOUkE/INCg==
X-Google-Smtp-Source: AGHT+IHqZ0IRKaYzG5gKXE7DG2A/2IPtZzhz4t0mufgG0uzlcu5hOT7bARpDBtl8lbCuWuX7GClkFQ==
X-Received: by 2002:a05:600c:4ed2:b0:453:7b2b:ed2e with SMTP id 5b1f17b1804b1-4538ee8cb15mr165853795e9.24.1751363990789;
        Tue, 01 Jul 2025 02:59:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:8515:f93a:c957:e0a3? ([2a0a:ef40:700:a501:8515:f93a:c957:e0a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453b3542838sm10272225e9.1.2025.07.01.02.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 02:59:50 -0700 (PDT)
Message-ID: <db172526-334f-404d-a9ea-530ec2e6e549@gmail.com>
Date: Tue, 1 Jul 2025 10:59:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] add-patch: add diff.context command line overrides
To: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Christian Couder <christian.couder@gmail.com>,
 Leon Michalak <leonmichalak6@gmail.com>
References: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
 <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
 <b68c58b667c29c66433b4634ad44ee9ec5257e80.1751128487.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <b68c58b667c29c66433b4634ad44ee9ec5257e80.1751128487.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Leon

On 28/06/2025 17:34, Leon Michalak via GitGitGadget wrote:
> From: Leon Michalak <leonmichalak6@gmail.com>
>  
> +for cmd in add checkout restore 'commit -m file'
> +do
> +	test_expect_success "${cmd%% *} accepts -U and --inter-hunk-context" "

Looking at this again, I think the test bodies here and below should be 
wrapped in single quotes because they are passed to eval and we want to 
expand $cmd when the body is evaluated, not before. That would also 
simplify the quoting inside the tests as we don't need to escape double 
quotes. That's not your fault - you've just copied what I suggested before.

> +test_expect_success 'The -U option overrides diff.context for "add"' '
> +	test_config diff.context 8 &&
> +	git add -U4 -p >output &&
> +	test_grep ! "^ firstline" output
> +'

Don't the tests above check this as they set diff.context and 
diff.interhunkcontext and pass different values to -U and 
--inter-hunk-context?

Thanks

Phillip
