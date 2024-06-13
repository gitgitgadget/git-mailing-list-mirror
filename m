Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43271392
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285472; cv=none; b=RBUFMdfopVWfDwYXk1gKRlrmvnkVbh4zOYsqStbiuq//aAdbJEZYyKcGodr0IQXj45S7RXAJYUtRzRvD6yuTc8Mz3or5lRrwTtt3mqHxDZUHDu7bMGEtQEJawtgkcI+Xyg9cIg76q1xVlIuLhUda4fLix6h339wy3dBpI+0ns/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285472; c=relaxed/simple;
	bh=rBXhYWIBPGSRRkB0yHE258MpToUqyvBnH6cWXePNscE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfHOb5kou1/vpHPnYZrXR7id9dawH+hWNUeSTNKLVUmctVRqk3gP4sLOf9ECWwE4QxMW4+Fs0pNetmTFl03Qtktam+4z1h8Xg6V9TKgraWZ5cnPtu48rzpa80LBNGE61pwm4NmAKwk7zTQTsWqDL8bsA5JI+fmdjCzftfBWo/SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxVdFn5D; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxVdFn5D"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42278f3aea4so10394875e9.1
        for <git@vger.kernel.org>; Thu, 13 Jun 2024 06:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718285468; x=1718890268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5ArwUn62hMctSSwX/5iNWsTPkLu/0bwMwoE4rsqO9JE=;
        b=gxVdFn5DF3K30UsAIgVnR0PI+ADh39GRJNZn1obia699PePo1Gf9zC/oVhhF6uK59y
         rpzMrEVH6ADFmlf21f37WyT4R//aRAPKSzbx64XgVu6sY4XvMDnkgXOW6VGGr0H6wjqP
         fe+0eoDVLWheQDm72NAUlr0qWFUQCkod9Q49p3T0EMrq/i2HbxsXZylBPFJaJ1herRJF
         unIO5JmGI2gqL9r+wiA9O7PNVfaSGKCBJupDHGGyGzdXIXyHIo7w4kF0xWVGsif88W6i
         6STCBXjdTPZqRXbMCNloNics4KT9KLP9kb9oyyiQFL2W2c9j+sUMSQJ6gphpFmIOFudv
         UH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718285468; x=1718890268;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ArwUn62hMctSSwX/5iNWsTPkLu/0bwMwoE4rsqO9JE=;
        b=uKeB55IsKMF61KZxtN3oBAzioEBp/FoxBtQHlmBW25YumriLkmOQ3TtZsxqqVHwGHI
         bqEVVU1p3H7z4LWiQesMci3GCikKG8DWUAqZZnM9o7JXWIYA/GwhUDHcktq+k9ImGG6e
         KTiuit5AyhPoii1gmfPw9qkqtinoPb97aJ9X40tQJ7C8FuJHuzV/Vg1c1aHU/Y0yPqsZ
         +UwjrV6FA/SydIb66xhZqUE1fw3fmMcNd2ieD9Iult55bmHHEK5iqyNEKQUjxVfJpEt6
         yW3XNa1EAqHLwH305kyIEiUeG+mL71VV+eEknb/YThodJJ32jUBUryTjkkhOaRMm7Jo8
         Um+A==
X-Forwarded-Encrypted: i=1; AJvYcCU3WsKPPO1ghO2P0nrZvfP0E6Or6TZerEtou9YmnGJXu8BmIk3MsNYYyWI/q4zDhISCgi9EdyQu0z3dkfKB+T1sJI3z
X-Gm-Message-State: AOJu0Yxi4z009rupwTMwOyBNPhbr9y/fXuag17HkRIGRpWzQWJ0yrOTc
	pai37w3QymcBXsRuoySrxoFlSYPqxKA5LhPiDKlJdCPWIRLDGeSf
X-Google-Smtp-Source: AGHT+IFg2WmEYWsZKAI2yoH/IltRWx2gdIUuyEqZP0oaGK0UMHYy4FmIkzclZWWagDJKQIJ7u6a5/Q==
X-Received: by 2002:a05:600c:1d1c:b0:421:f68f:a144 with SMTP id 5b1f17b1804b1-422867beeccmr49866765e9.36.1718285467882;
        Thu, 13 Jun 2024 06:31:07 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42284d1130esm27145015e9.0.2024.06.13.06.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 06:31:07 -0700 (PDT)
Message-ID: <a03cd45e-e4e0-42c7-bb98-b25cac12e42f@gmail.com>
Date: Thu, 13 Jun 2024 14:31:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] date: detect underflow/overflow when parsing dates
 with timezone offset
To: Karthik Nayak <karthik.188@gmail.com>,
 darcy via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: darcy <acednes@gmail.com>
References: <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
 <pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com>
 <CAOLa=ZTgP+OwVrT87=og4tVdhsqjErMUJzCuT9bdDatFS=J8hQ@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAOLa=ZTgP+OwVrT87=og4tVdhsqjErMUJzCuT9bdDatFS=J8hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 12/06/2024 10:49, Karthik Nayak wrote:
> "darcy via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> +
>> +/* timestamp of 2099-12-31T23:59:59Z, including 32 leap days */
>> +static const time_t timestamp_max = ((2100L - 1970) * 365 + 32) * 24 * 60 * 60 - 1;
>>
> 
> Nit: but since we're calculating the number of years here (2100L -
> 1970), shouldn't we also be calculating the number of leap days instead
> of hardcoding it?

I'm happy with a hard coded constant for the number of leap days - I 
think it is probably easier to check that (which I have done) than it 
would be to check the calculation as I'm not sure off the top of my head 
if is it safe to do (2100-1970)/4 or whether we need something more 
complicated.

Best Wishes

Phillip
