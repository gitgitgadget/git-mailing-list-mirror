Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F2B194A48
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 05:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729490115; cv=none; b=lmZnatw/kg5m2QvyPTQp2nV2y8w2PmXWA3XUmUile/eLYB5Qu04E/eX+FY85gtaVqGR60/aanwI/t9H+DucmJJJneLTvp3msvi+fPmUSUM43ngk/xrnGesrsiQYp1qh3aHteWc7G2F2v3I+NVOHlJTOYKV3fGfoJOuHcsy+KZks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729490115; c=relaxed/simple;
	bh=COsqs6Oj6ZDtIMveH3jV4oBYF3d+Mny4KoVd4Q9XRLI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WyU6OU4qfVsq8nIzrfwLr+hM1TazEL8cQGscTTH4jP5vZxRpGHoj5+q11jL3AjhIdMWJ+9rbMqs7p1UXkDdrRcEohNvyaXqcQ9U/Y3XLXT4U2E5gkLgPfaneWt22wu0L8NyRHoN70plgy4xfHV8JcyM5ElA9e4QQtYUK34CmM3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avXTGNku; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avXTGNku"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a4031f69fso585152766b.0
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 22:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729490111; x=1730094911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ViWbhom+/0V92NkawyFT5f7w7jwSXOaP/g9paL9OLcM=;
        b=avXTGNkuD4leVwDUk0c/zwmqqKOYgqW0LfuMYPcjKahmJZduOcERHPqqsdiR6kllqL
         l9esgmEwf51h3Lna58dHDnTDj9N7e511UlQDOhbFqToMgzwZa9MmKxvyW5zyWke1WfxK
         bmID5Dtaq2t7R45bEOm9pvacWy6wbCCYi+t1asQVuPVDFiFlpNG7meRthLnLD0YrKBp8
         1vkAy8/9JwGX0FS9ClV2eK1JyBzWd7C0LrPJ0a+fKDkvP8M3q+6l5f1c6Hg9isMDmPL2
         fNtjl3ARCfgatyNXxnpCcSNdhsj46YgcZGF1ACbjYcN4h5vSZR6UiDKibZgbTrY/plHa
         azZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729490111; x=1730094911;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ViWbhom+/0V92NkawyFT5f7w7jwSXOaP/g9paL9OLcM=;
        b=ocAJPD+b4UCE5p4c86mTsivcTMtRqOdx6R+a+wv4HZtfKwPPCOi0fnK1Sxn1ua3nvn
         fB8tEfcs8EhQ88Vl7v0U8EVxWv+HmaezpbnwmTHK562CtTvsAgX+MtHjtwln8LqP5jjy
         MTP3Hpr5CJQl6EEsdABWAu1h7Xyoefi49F0FAOZD2t/9UFW+ZUu7F74y0DqNssf9QtGY
         e4O6iiOfJ7UVSd3aTlJxSvdsAnCDXkw9IFkEg1AkKZLsQ0QFFRAoCG/M2V7O6RtIiJPa
         g4GoQaR+IwlhIUswYlVVdCbqL+Pi0JMZmJR8lkiONCUGenG+QyXJp9WaDX/aDZn38GRd
         /Vrg==
X-Forwarded-Encrypted: i=1; AJvYcCWW2Fkp6VNHt9/27moXzBtqs0JO9FgKiRl1ARB/MD5vWHHAXm2KblRfmS6vGcCOazQHSEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvML1dFLeNGzj6hHGyq8HNR3tdR6XUqwy1g5Nr3E33zV2GxNby
	GiJuE1f71xoYEF63xNwht3vO2NlSKP1aOO6QPgwM3L74rl6XSWefl85jRIAW
X-Google-Smtp-Source: AGHT+IEHaCtueUsmvsukwsXiUTTqngCKun97DSH4UvRv28ESCeFpIJSYUZM7sHQp6CdM3nUDiIV6Pw==
X-Received: by 2002:a17:907:3f9d:b0:a99:fc3d:7c76 with SMTP id a640c23a62f3a-a9a69bb56admr1223935566b.37.1729490111212;
        Sun, 20 Oct 2024 22:55:11 -0700 (PDT)
Received: from [172.30.9.8] ([131.228.32.168])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912f6862sm161712266b.87.2024.10.20.22.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 22:55:09 -0700 (PDT)
Message-ID: <fd5fab45-1363-41c8-915a-5578a35d219d@gmail.com>
Date: Mon, 21 Oct 2024 07:55:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: document how uploadpack.allowAnySHA1InWant impact
 other allow options
From: Piotr Szlazak <piotr.szlazak@gmail.com>
To: Piotr Szlazak via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, Taylor Blau
 <me@ttaylorr.com>, Jeff King <peff@peff.net>
References: <pull.1814.git.git.1729112794671.gitgitgadget@gmail.com>
 <pull.1814.v2.git.git.1729355997353.gitgitgadget@gmail.com>
 <72184384-07ff-4f74-91d7-280ca78407b5@gmail.com>
Content-Language: en-US
In-Reply-To: <72184384-07ff-4f74-91d7-280ca78407b5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.10.2024 18:46, Piotr Szlazak wrote:
>
> On 19.10.2024 18:39, Piotr Szlazak via GitGitGadget wrote:
>> From: Piotr Szlazak <piotr.szlazak@gmail.com>
>>
>> Document how setting of `uploadpack.allowAnySHA1InWant`
>> influences other `uploadpack` options - `allowTipSHA1InWant`
>> and `allowReachableSHA1InWant`.
>>
>> Signed-off-by: Piotr Szlazak <piotr.szlazak@gmail.com>
>> ---
>>      doc: document how uploadpack.allowAnySHA1InWant impact other allow
>>      options
>>
>> Published-As: 
>> https://github.com/gitgitgadget/git/releases/tag/pr-git-1814%2Fpszlazak%2Fupload-pack-allow-flags-v2
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git 
>> pr-git-1814/pszlazak/upload-pack-allow-flags-v2
>> Pull-Request: https://github.com/git/git/pull/1814
>>
>> Range-diff vs v1:
>>
>>   1:  8a2673bdf31 < -:  ----------- upload-pack: fix how 
>> ALLOW_ANY_SHA1 flag is disabled
>>   -:  ----------- > 1:  2a9fa4dabba doc: document how 
>> uploadpack.allowAnySHA1InWant impact other allow options
>>
>>
>>   Documentation/config/uploadpack.txt | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/config/uploadpack.txt 
>> b/Documentation/config/uploadpack.txt
>> index 16264d82a72..0e1dda944a5 100644
>> --- a/Documentation/config/uploadpack.txt
>> +++ b/Documentation/config/uploadpack.txt
>> @@ -25,7 +25,11 @@ uploadpack.allowReachableSHA1InWant::
>>   uploadpack.allowAnySHA1InWant::
>>       Allow `upload-pack` to accept a fetch request that asks for any
>>       object at all.
>> -    Defaults to `false`.
>> +    It implies `uploadpack.allowTipSHA1InWant` and
>> +    `uploadpack.allowReachableSHA1InWant`. If set to `true` it will
>> +    enable both of them, it set to `false` it will disable both of
>> +    them.
>> +    By default not set.
>>     uploadpack.keepAlive::
>>       When `upload-pack` has started `pack-objects`, there may be a
>>
>> base-commit: 34b6ce9b30747131b6e781ff718a45328aa887d0
>
> PATCH v2 which updates documentation.
>
> I wrote 'By default not set', as definitely 'Defaults to `false`' in 
> not true.
>
> Only when `uploadpack.allowAnySHA1InWant` set to `true` or `false` it 
> will affect reported capabilities.
>
> Regards,
>
> Piotr

On the second look code changes will be needed, as at the moment final 
result will differ between:
[uploadpack]
         allowTipSHA1InWant = true
         allowReachableSHA1InWant = true
         allowAnySHAInWant = false

and:

[uploadpack]
         allowAnySHAInWant = false
         allowTipSHA1InWant = true
         allowReachableSHA1InWant = true

Regards,
Piotr

