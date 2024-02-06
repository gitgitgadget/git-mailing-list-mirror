Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3C358233
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707216606; cv=none; b=PQDMycBEMQEm7NyXAQ9c2UfxMrEpjANvZghftV5ipESZjKqlrt6WL/7BYqODelAdP5dBVt0dE+df15AA8rwP3NI/eqkZ7dvrukWjPgBleymjerft6oiwdrpSDJofUgcqIi5ISifDzJeZBzoQvlGN3I2rAmQQAobc3XOUpAvSVqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707216606; c=relaxed/simple;
	bh=UNIGnMjwOjdj6z/mHExi+cJ0tW1iIEn/LARprY10tGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJ2tu9AsUeQ6bzyKKa75qVT7gvHjR47jV8kx4HzBxsp36m9N3d8Oqfrh1XhzfqZlyvtBI9EFJlo+fXKI3G32T+1kWyjg9HhNurtU+TRrBOJLQRCD4XpI4kgaRr4TSi85ydkN+Z22ZYOXXYk2aEZtDk9INIiDQbwQFrzjy+T9fHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcpwPFx4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcpwPFx4"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fe00cb134so7823985e9.3
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 02:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707216603; x=1707821403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LX02IMquVqMO65QCu4uTeXqP/CTaEqpczO4zy0YJFyg=;
        b=XcpwPFx4dXpeBL9+nMs+DI1WkNxjjjTplHZzlhi1YTKEQIsRayz94eNpYQuT+yXsjm
         TgbLnITlD2xQuAKPvVy+3sqscFc7T1FcBnBh6HfkB2s/etOvRKJPNzINHoob7CBW6w/1
         91v9dgMclr/EaMsTlgoHzRP6gbXIH61lwJhWY5X/voq4FGR1jfADrIXfND12z4yxbu7k
         MkzCu4++yfXdSFE+0iiuBIk3oauLlLraC5p7xlKvNgCZ8J7ozXqcHmRg8q2r+BimxO5c
         er8c0Gpl2Pv6oJnSCVzNew4Wp5LlKIeIxV0IA/n/0/l/0P5Zopcipg5++sst6vrld3Tq
         MO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707216603; x=1707821403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LX02IMquVqMO65QCu4uTeXqP/CTaEqpczO4zy0YJFyg=;
        b=XURy7Yx04Kg+5KS+acipohOJR1GIzUo/5H7bkY+fablo/wPmOsyY1KGyRuOPlYB34n
         US8UBTJrqRKIvNt6hVn12YiS5aDLEcDO9Pz+qP+8nS5gJpMaeiNX10YxvAmy573qnNzv
         xMb/HAKWSsVWXQTflkUxJTu3skEfl6kqjU22dVrmA3A5hyEwNLAE1Pjk9hwV/G8oqSVK
         DaCvh3iVGdrjh/Twg1kjHHb53ZgAFXYF8PCZ92CFuaa0LMVUySkGr0ZKkLhtYjuiqAHP
         clTzkx2deqYoeVWUquh2XkMTY8l1DyFH3YmYjIIOvXlw7UOo+b8k0W3q1SRK3QbY3IN4
         NU3A==
X-Gm-Message-State: AOJu0YzsXKPRuZqhmC3/fEbl04RgWKAfaI32B1GAgN/mxmIiyhCK95b0
	uJAvj0B1anfIxvOKLCT+P44YyxZnBVnWeR+YfIfAMSKkmomz49Gy
X-Google-Smtp-Source: AGHT+IHlnl8/i1vG/pIA0O+fcKpk0Px7Kzq0UClEZk7lvHLlz/BPweV5AdVT2gs+WXVYYJkp0dyDaQ==
X-Received: by 2002:a05:600c:45d1:b0:40f:c1f9:c884 with SMTP id s17-20020a05600c45d100b0040fc1f9c884mr1762857wmo.39.1707216602862;
        Tue, 06 Feb 2024 02:50:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVQjbvl2ktmlYst+r/Bxb3dwUQ58JKvMgc8h0MQkxf6qyaOAunAyvi7quDNc0liiW2lrhcoB2Pts4N3Jw5HcUcKf9y4NArikWtQgsrRp7CX9mSrKxDoyA==
Received: from ?IPV6:2a0a:ef40:62e:a901:386f:d8d1:628a:e68d? ([2a0a:ef40:62e:a901:386f:d8d1:628a:e68d])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c4f4200b0040fc771c864sm1604999wmq.14.2024.02.06.02.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 02:50:02 -0800 (PST)
Message-ID: <c9d660a3-4254-4ac7-9476-b7817348aa60@gmail.com>
Date: Tue, 6 Feb 2024 10:49:58 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
 gitster@pobox.com
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240129113527.607022-1-karthik.188@gmail.com>
 <20240129113527.607022-5-karthik.188@gmail.com>
 <98d79d33-0d7e-4a9c-a6a3-ed9b58cd7445@gmail.com> <ZcHEmyvvMR_b_Idl@tanuki>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZcHEmyvvMR_b_Idl@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 06/02/2024 05:33, Patrick Steinhardt wrote:
> On Mon, Feb 05, 2024 at 06:48:52PM +0000, Phillip Wood wrote:
>> Hi Karthik
>>
>> On 29/01/2024 11:35, Karthik Nayak wrote:
>>> When the user uses an empty string pattern (""), we don't match any refs
>>> in git-for-each-ref(1). This is because in git-for-each-ref(1), we use
>>> path based matching and an empty string doesn't match any path.
>>>
>>> In this commit we change this behavior by making empty string pattern
>>> match all references. This is done by introducing a new flag
>>> `FILTER_REFS_NO_FILTER` in `ref-filter.c`, which uses the newly
>>> introduced `refs_for_each_all_refs()` function to iterate over all the
>>> refs in the repository.
>>
>> It actually iterates over all the refs in the current worktree, not all the
>> refs in the repository. I have to say that I find it extremely unintuitive
>> that "" behaves differently to not giving a pattern. I wonder if we can find
>> a better UI here - perhaps a command line option to include pseudorefs?
> 
> I tend to agree, and have argued for a flag in another thread, too [1].

Thanks for that, I'd missed that discussion

> Something like `--show-all-refs` feels a lot more intuitive to me and
> also doesn't have the potential to break preexisting scripts which pass
> the empty prefix (which would have returned the empty set of refs, but
> now returns all refs).

Yes, and as you point out in that other thread flag would allow the 
pseuderefs to be filtered and allow us to show the refs for all 
worktrees as well in the future.

Best Wishes

Phillip

> [1]: https://lore.kernel.org/git/ZZWCXFghtql4i4YE@tanuki/
> 
> Patrick
