Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DC9202987
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750840828; cv=none; b=RWtwMYCuATkwI8FCgTfbuy+UbbTI8eSf5uXszzEKw1D2GTNwVxRjVCrON723tjyh6szSTSyfqJnOyVLmGfWcc/Mg3DMh/roIqhWpEC9mPC3zVqVuRYayWJXtu8pLK7yR7dJcZltvbIYJByi37WIaXh3ULSlrM0hQzbL9hyKCHXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750840828; c=relaxed/simple;
	bh=oD9dq3mFY0GuPwgEUilx58jNulfqQikAhiJOzS6g3cQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KXyNR2gbYeAFCZSbW+fSOSxVOIrANaYnioBjwhWuaklaCJXfiz5inWE0SppF4fxMK0ZxQSb5FQS7CbeMKU2LGvrWwXyggv9KMNTF2mRj+eN6leLt4NxuNqPBVvXZ2PHvoJcrsX+6BJRf428obMCW9I3e4pewMTejT9KvKeUmsJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyR+ULIz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyR+ULIz"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso52657835e9.2
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 01:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750840825; x=1751445625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BVvEdEhbCNNFpWG3gxnhhj2GMm9qrQeA83ZEJ7KoT04=;
        b=JyR+ULIzWzUUtDr+ycmbnU3XadtMNWbNIO3f493cpUrpswYHfF6/RnddoMXSx/l96L
         sKFRW4qPeCkmomeh9anL7zMKZ+HCwXgDvTH/3+MTCIAjFiRZe30NCmUvGAgy9tIBdd0a
         p4pkIyoIIW+U5WgBC03CEnClUBVm0ZMIsmd4Ppz/C2rB6zswGGZ4+wITJHFfl/4XCNgy
         zY4VaAUJwhqEas2nX2/riSurAvWjVQz4Beqn85tT/FgZOA2UGFhdz23IE4H3YpdmO8Xj
         lWfygOJV7cgUXoXL6Lu3rHP61kuMntTxCUJ0MuH+cVhjYXYA2yNgOfAoHRGhdt5MTrN8
         B5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750840825; x=1751445625;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVvEdEhbCNNFpWG3gxnhhj2GMm9qrQeA83ZEJ7KoT04=;
        b=Ns3y5BCoLgLQYb3RFebEgdF3QyUviH+6rAzDl+XQY2Hz5fqICK+sRYkhGnslhLPEXE
         IjYiU/W5Gf8O+MbIeTEzmrXHPH5w7dabM1eN1Kd1a15jej4naUf+ZWyUnB1vKIMmTOua
         /MpOXbm4EpUStpJOPBBJ6WXEwIkbg0aXGlZcnZFbBBdkV4BA+Tgdb0sdPnvWvS1NXliD
         OH0Fz8NI2KHB6GKW8PNUPlqbYqrAYtz0Aqm9vt7rdYuKaxzKZ+MihvR2UEOEUzxU5qud
         JXP5G09va11VzN49ws/8rOd8LUtB6iPsZ4TwZSceU5awM5BjKnjrdr6McmuHDSaybXmL
         7l+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCCT+JKHIAefdrH6HnM/hPKBVjehQ96QBKxT9RKRJkHl8DPXy69m8GPDCrPQq2D843v+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUwTalENBlAgTJWJ6mFYLJUCgMUwdHfMhmPszVOm26suZgigyn
	lKDpOKm6hZ31fxiuvRr+O812kLdVq3HQmlqxBt8qys/VQl0vNI0HxuHT
X-Gm-Gg: ASbGncsZEzIBbYIrDl1cvnQTl8YIUlllD9C1MsGTuXZnqeGCRvCR7zvhABfSgMJnXM7
	8RZ+twwn6j8u3JvCl95gO8e7tZguO2nm4tslKiGWazSj7aNyX3Ired0/F7BKhfBsb/sAtQ3huAL
	B76mNdZPYYsDjaszOhyJN1CPZPB0h08hNqspfcUKOH0NJTxL2XI5uh9kqfynTYjZbfoQBRupXla
	BClKghv1rRv+xEScm8YlLDmmxLyIOl0zOC8tLvchfK7+2ccIIdFkRb3p1EGHaUmxqFxuWGodhYS
	OUrGpMEE1BI4gAsjY9v3Q94WBl8YiW6RlyCXPgUK5Y4ufRaBh/Ia6up8wLfqI85XPdUfCQ9Ezzb
	5XyW4Uiob4YkGFYccwvKvI8ipxoJT+asmb1EoYj/7UVoV8iwx
X-Google-Smtp-Source: AGHT+IG2Tbr7HyV6ZsJL+/zMqy8tx8uG/48YNXsWNvajTYYXEdvUY3Cc5BSmoAp9Gm92Xna2q0e79w==
X-Received: by 2002:a05:600c:c177:b0:453:aca:4d05 with SMTP id 5b1f17b1804b1-45381af0ae6mr20184365e9.31.1750840825258;
        Wed, 25 Jun 2025 01:40:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823566d4sm12753885e9.19.2025.06.25.01.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 01:40:24 -0700 (PDT)
Message-ID: <e892fe89-045f-4220-8436-2d536f10e1a2@gmail.com>
Date: Wed, 25 Jun 2025 09:40:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC RFC PATCH v2 5/7] repo-info: add the field
 references.format
To: Junio C Hamano <gitster@pobox.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org,
 ps@pks.im, karthik.188@gmail.com, ben.knoble@gmail.com
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-6-lucasseikioshiro@gmail.com>
 <254e4819-a693-4fb7-aa92-260038cbfbe2@gmail.com> <xmqq8qlh2mc0.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq8qlh2mc0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/06/2025 16:25, Junio C Hamano wrote:
 > >>> +                echo '$expected_value' >expect &&
>>> +                git repo-info '$key' >output &&
>>> +                cat output | parse_json >parsed &&
> 
> Running "cat" on a single file and piping it to anything is an
> anti-pattern.  The fact that you can pipe output into the downstream
> command means that the downstream command is prepared to read from
> its standard input, so
> 
> 	parse_json <output >parsed &&
> 
> should be sufficient, right?

Good catch, I commented on this in a test below this one but missed it here.

>>> +                grep -F 'row[0].$key' parsed | cut -d ' ' -f 2 >value &&
>>> +                cat value | sed 's/^0$/false/' | sed 's/^1$/true/' >actual &&
>>
>> sed accepts filenames so there is no need to use "cat" here. It also
>> accepts multiple expressions so you only need a single command
>>
>>      sed "s/^0\$/false/; s/^1\$/true/" value >actual &&
> 
> And you probably do not even need grep piped into cut either, as sed
> is a powerful enough language.  We can also cheat a bit by taking
> advantage of the fact that the characters used in keys are fairly
> tightly controlled, so perhaps something along this line?
> 
> 	sed -n -e "/row[0].$key/{
> 		s/^[^ ]* //
>                  s/^1\$/true/
> 		s/^0\$/false/
>                  p;
> 	}" parsed >actual &&

Nice, as well as saving a couple of processes this avoids truncating 
values that contain a space.

Thanks

Phillip

