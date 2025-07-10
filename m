Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EE822094
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 13:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153338; cv=none; b=JyMwKVRQuyadciQDQeRuEFd7bMhftJgdC6uOIbEA6gIA27/VAPxhro58kEU0aIKyRl45fNyVzp2gam4DH8S78vm/aBphHuRPeob4+KxgsZkeW0svix/OD7bs/UztXNaE0nCragVXEGChd2x/QO22CDh64Ks+fLHzCYdrDr54TYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153338; c=relaxed/simple;
	bh=9q1HlqOnH+M/yIqZPNg0vFAP8FlM1D3p2i0F2e96YUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iy0udubjP7JdND2UPAYhWUuD7QFKfH96zQ9JDwEOGyVDD5BfI1yfrBmhO/J5cV/cn2DWR2ZHSr17DZiY7RqLktqGBWEtodYs+u6+PGq/dheC+q1ECtJEwBJnDuTkF12nTX6gMCsCx36+tqYr3xdsIwMgzQ7WHnTQ2VBEMRfsnI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVIkOQK0; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVIkOQK0"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so757359f8f.2
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 06:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752153335; x=1752758135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AsPirOxfx0OoA33RF5RlgX9aYYHkIKPF+K6iPpQEfH0=;
        b=LVIkOQK0Msz/rEJQcAQxb/oYbJ33VXXXZp5rhrt6cr1qyOuW6ChdfO2UcMnYa/J56a
         rd4O6+v4ubm9+eIBTWFizPNs/rkn8gq6W8dX95O4Jc28tgCuPWgR7o9CkWYQ08ARbzwH
         MnOpQrTcsjanCu/ltz6LlfBOZoPkgazUIkdrsXaif01/IXG0pB+TVUrRI+Y8utBKles1
         QRLrovfd/JULOksndhvcKw8SmaAeeM3Lvk91r5DoFWL9N278Uj9AC708ocPLooDb50lJ
         sOPl9hoDnJ8BhVX/GYnPpnXCGQuJu6GOm3HaXHQbk675yXhdrV9lurIYeKK7LXPtoVMK
         fy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752153335; x=1752758135;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsPirOxfx0OoA33RF5RlgX9aYYHkIKPF+K6iPpQEfH0=;
        b=ouo/20y1Q1PT0IyjVup8bvE8QUceLcxFHnox7XmQE7OUiEEuc9ramEylK+RCl5hLD8
         Vhsdo+ME5j8zHsvSo17gZdq26HBRNTmhUKQvZjrx2aZI/J7ylUbPonV0KZTQKdPndS40
         RBqdnkphl9W2QdISGZNQzTIsZm/RTuQxiV8OA0GwFVwV6BYw0/4nj3rbcHDOVdYGF/4a
         8SaMpEcd2bMvu9Y0wQd2aMze/KBEecbQLxans+BMDI/Zv0hjHTSwLQ8l7g2ByPrjmtS9
         ZWCam3GM+EReM2rG1w8KRmI5RohgTK/UYx3oZ0Is7QTm+qkKQH1c1rHLf1gpyvUEFcxj
         HFRw==
X-Gm-Message-State: AOJu0YwywZIpiL6CD4TVzQF30l9uR0J4j8pd95Z9t5a+UIgB3ozTj4KP
	YTtLVyw0d4bR1V212xtJSb/RBe+NlA11YeJSxdMKi1QxOGbklGSIZ2tu
X-Gm-Gg: ASbGncu0qD6FN0JtKvlhQiTTIR4zqWF+8IiZdefBRyXGEkcgc32E6l7DeMN0Dpp93nO
	HB3WRyGl+GvIt0fFLiS1wiQu6AO4PH4H1Of36ryIFzbQ0JYtp7XgNA40cZ2dzwCLx/XhIZETJB/
	pe0+dk0U5Frkid2m/Gs57Ip8RInM1f/eGOEzIj+c5RJKAlSWBt1ggMbud1Tz2COSOcCVX8he8HT
	RnFbEJ6lvkc7jBHJaMuYd5f73O6tmjmTPEbMMC43Kbeo4XtozBwQutUWcRBCg36JS0KIFnKYbyw
	8RHMtN+9nkRhVMPUzvMQBTSLcuS5EHhbbyngaXli19Kq/if7iHr7A7AXmMz9ckomLs3Hi7wG0RC
	36/fbaUmHg1xIBLly23lSbLrNNfz+GeNp08U9cL88IlrsY2c=
X-Google-Smtp-Source: AGHT+IHqLuQ2tJXBu3fcHE0gF+z6lJG/YJnDIoUzn4elbswXMbPhf567d1+Zu9Oya5IFw32527/obw==
X-Received: by 2002:a5d:5846:0:b0:3a5:1471:d885 with SMTP id ffacd0b85a97d-3b5e86f1b21mr2654727f8f.56.1752153335073;
        Thu, 10 Jul 2025 06:15:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:750:6901:bcb1:bcf5:a6e1:fe48? ([2a0a:ef40:750:6901:bcb1:bcf5:a6e1:fe48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d70csm1883139f8f.62.2025.07.10.06.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 06:15:34 -0700 (PDT)
Message-ID: <35ba62ab-19c3-4092-aa7c-9043b898e284@gmail.com>
Date: Thu, 10 Jul 2025 14:15:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC RFC PATCH v3 0/5] repo-info: add new command for retrieving
 repository info
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com,
 ben.knoble@gmail.com, gitster@pobox.com, phillip.wood@dunelm.org.uk
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250706231938.16113-1-lucasseikioshiro@gmail.com>
 <c1f871ec-96a0-4dbc-b84b-4add36bec682@gmail.com>
 <C1991C27-9F57-47F7-A622-B3777BCFACCA@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <C1991C27-9F57-47F7-A622-B3777BCFACCA@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lucas

On 08/07/2025 20:27, Lucas Seiki Oshiro wrote:
> 
>> These all look like good changes. Looking through this series I do think that
>> it would be more readable and maintainable if you adopted the table drive
>> approach suggested by Junio.
> 
> Today I had a meeting with my mentors (Karthik and Patrick), and yeah, this is
> something that I'll change in v4.

That's great

> Returning the keys in the same order as they were requested in the
> null-terminated format is not so useful now that I'm keeping the keys in the
> output. Dropping this assumption allows me to make this code simpler.
> 
>> That way we would avoid the nested switch statements and each piece of
>> information only needs to be retrieved once rather that having to retrieve it
>> separately for the JSON and plaintext output. Below is a sketch of might look.
>> Each key is handled by a callback and we have a table that maps key names to
>> callbacks. For the json output we use one json writer per category to build
>> output for each category.
> 
> At first glance it looks good to me. It still seems to me that it needs to
> somehow treat duplicated keys.

We can detect duplicate keys by adding an array

	char seen_key[ARRAY_SIZE(handle)];

and checking to see if we've already set `seen_key[j]` in the inner 
loop. We should also detect invalid keys which we can do by setting a 
flag when we find the key or by moving the declaration of `j` into the 
outer loop and checking that `j < ARRAY_SIZE(handle)` at the end of the 
inner loop.

Thanks

Phillip

