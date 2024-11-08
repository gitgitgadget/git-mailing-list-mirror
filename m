Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AC21F4FC0
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731077909; cv=none; b=gHLStnwz613sMUivGou6BMzCTKatQqFthnNJ1THwV7d784YoZo0LsoQfbA6G+liQwQTB5TlYqbLuA6sKg/WX/flRiLSDqHV3K+BFM+6+LUpoZBZO2BLoMS+DW/DrYLUd0K4a8iWQdXH6vlontKK47WXKu3B8EWbBXg1TQmgtQKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731077909; c=relaxed/simple;
	bh=D//9AoSDmGnlUNqe0vlcTqQP2azXN1+8f9Mj/1OHI5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyuUBxq86mAXoIAEG2xwocEN8MiywIHlEYa+plmgFqzL1g1nkkQiAyG8NuVFOG4XtL5i6qCWQGvNwKWADEgPzg7ZBs4KLMfJqYkj5r42pivFi/k7JWFxs458caazWoynkD/bHmV0GKBkNw0aaA5Ii0Ee1t7lI4tAyWucuq6D9Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akcNCU6t; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akcNCU6t"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ea07d119b7so18619207b3.0
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 06:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731077907; x=1731682707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D//9AoSDmGnlUNqe0vlcTqQP2azXN1+8f9Mj/1OHI5s=;
        b=akcNCU6tU8ZG9Ycc4j1KTd9LWRtnhCQhAynCCTmW8PtRuTsmF774jc8MOUrrRTz38A
         2vsUu2N+beaBp/zWfKoloHqbdCkqVS9smIPSJJdEEIKbYh7cXeguQJnuI3u8TcOFbYSj
         Ed8vdjXCwTEe8uJXQnV5i2Lt4aYcy4VJtHYaIzJa9KuV7+O6X76F1eaW24eFzG7Imxh0
         V26+i6aoNAXL/HZxf0odzcsnW6sxmVQdvHErkbfUV8Y020IHd0NFPiYDpgeGgdm7EQtk
         qL8HO3YoZeSgoIcDkXXH3uWQQR09L4uw+jZX+RSR9HBxqnNpFhkhmcoISHoMwrJv2B8U
         7cRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731077907; x=1731682707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D//9AoSDmGnlUNqe0vlcTqQP2azXN1+8f9Mj/1OHI5s=;
        b=ZmgsManLNp9mrZcCvHttMeCGJ4xwYfaQ3FpSLEIVHPsQEweK2pP9BMqnODgPS5f5bO
         j2AVakz+mmjuHeGtIqxLTPDr1Y+zaS/FBQkQnhAx9p4UZf7KA9q4T746mekXT8pwYF6u
         msYtdJEvzvgyRz4OSnZAqNSRJuTMUJwzq93u9OymnH79mK/p51ZZyt5Z1FAY0KCVJZON
         A3GTaqOyOqgACMEk0IJnvjZ4Gqa6mI/sv3149c5CGJ+VWZa233/1PBZVYtHJnP1VHNwl
         e70dRgEYNgvn42s0IiHuoVmCJ2/QUztPpR9qasArFLPkV78HIMQPLxC4RojJ4D68yOER
         KQFg==
X-Gm-Message-State: AOJu0YweZionpuyDJ++dnUfXXRDvVC0HBHPQBgqy0+DZlH4eUon75eGa
	drHkgzCFdonxEPP70wJG/aRED4JyTOXQcgABPcP0vPaQNwyOZlFy
X-Google-Smtp-Source: AGHT+IGnpeCiL0nMesxeQp1uY5Lm0G0EqyxtFnpsLgFroLZSVKKf9okba46E2v2wcii8Vss///D6Kw==
X-Received: by 2002:a05:690c:4d83:b0:6e5:a4d6:e544 with SMTP id 00721157ae682-6eadddb5d23mr35173257b3.24.1731077907096;
        Fri, 08 Nov 2024 06:58:27 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:cdf0:7186:dd7d:aa91? ([2600:1700:60ba:9810:cdf0:7186:dd7d:aa91])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8ef4aasm7374097b3.32.2024.11.08.06.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 06:58:26 -0800 (PST)
Message-ID: <34e00703-1324-494a-9323-ed87718bc235@gmail.com>
Date: Fri, 8 Nov 2024 09:58:25 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] t6601: add helper for testing path-walk API
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com,
 christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
 jonathantanmy@google.com
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
 <6f93dff88e7cf81800c8f2c8d39175d962a0576f.1730356023.git.gitgitgadget@gmail.com>
 <Zyt3aE2yNOgDyw4Y@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Zyt3aE2yNOgDyw4Y@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 9:04 AM, Patrick Steinhardt wrote:
> On Thu, Oct 31, 2024 at 06:27:00AM +0000, Derrick Stolee via GitGitGadget wrote:
> [snip]

> This function is leaking memory. I'd propose to add below patch on top
> to plug them, which makes t6601 pass with the leak sanitizer enabled.
Thanks! Applied for the next version.

-Stolee

