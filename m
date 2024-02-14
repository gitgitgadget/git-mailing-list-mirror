Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDE518E06
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707908712; cv=none; b=XCn0falbdt4fX3Z/1+O/OTteO9PkjlRMhKxVagGodCG2iramPIVP5iyFiQkN8/Ob+2L4a+IhSBPaU+fxcHnY1s3izICkcLy1+UduR02Qvs4DTncddB2+YvPIf/1o45xovUqmX3eL/abqS0irAgICkx2KTXrChNMbgkPyJ6NNXAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707908712; c=relaxed/simple;
	bh=jyBaHu2GhnJnEM2HX8GipjuD8XfGpsHk3e+bPcmF/Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Khb3KRBq67u5nT58U/HwRExuWXvbDJJeDBVeO6k2nzvovI+qu8aHXtSp8Pue9pK2rFDupwVijLZ2hwlOQNmnreFhYe693hJdb3aVgG7gCcB+PmleQ1WFddTMOSxpr5D3HoFbQi+VA/0WR6l7eXHuDFkQAHp4Hb/tudS38ud9JCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DamQ0HOO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DamQ0HOO"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-411d76c9ce3so8097595e9.3
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 03:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707908708; x=1708513508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uY0JP+pt3jNXVb3XhyOc1KY58Z/uA+FoNAvQyG+QwWk=;
        b=DamQ0HOOVmehN0JCAJxHO87FMjd4s9F4ezb7L6Cb1efVHD8s9+G3s1XX/VJva+UCLH
         i6Z98lX+npk6TkgVYpevM2yqhMZIPbVV+2ERDKIjIOfiryr6RgdMR0f6XtDeV901eoku
         WGn3bLRG4FuNpUcgHf3LDgGjsMD/S1SDvpBLP4vcIo6FaF17gNv2JfzGA6RfRKDudIwa
         nXxIl2BX5VBy2lbgNwlV5vPtgzkxlnbrKwNx5eRs9/EG79Q0S2UG8gKGdFOvqPiMQ2+N
         JL4cKm7bEH9EbBpjLMQBDTdIbQahEYga+xsjtSsrgRBokiXwTYrGHFP7CdNRjuFsHzjl
         h3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707908708; x=1708513508;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uY0JP+pt3jNXVb3XhyOc1KY58Z/uA+FoNAvQyG+QwWk=;
        b=sgIkdjDqRTTLZGHqWYGohqyBiHelPs+zBuDL238BYBvjfIjBua0SZyZwX189DwvzU0
         S4eG3OKiKEzMRR35FfYJ6o2T3XN3W792KTBfqBYOP3uNqqHYfGt5t974XkE+JfiXViik
         OYm07gqQXxAkAmaedjQV4d6fsZtanfVhOsqcZAKGSHWDDOTYAtACimGDKWEhqOEoVD6I
         Nwd/DGPdTWgJpxNSw311/A5LP9Np6+tWn2lZtMFOTxdaX2nyTVTsZI2kN3AjpcGmF8lZ
         aLD/cAeY+NZ4XDVlVv6vpeJ+4C//eCpVEFjFOHfpjtI30N+ShftJNN0iyBr64n+b0n6T
         nToQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI+TRwfY3viFx0Al6RTC+FI+GZDzosn6VPj+Btx8BEAWVa9RdZnoF1Yxqwt8YQzF1iKKEGz0UZQOvwuVlwn6amFYjd
X-Gm-Message-State: AOJu0Yz9NyMe7asHLUglI4NEuLbt9F0jluO84F7/pWOJDlL+fGxyaS9c
	EAtiKxG/NGkjsicqrK02xhSKDUaP8g1uZNLU646WVUAB07KRXbB9hc+9DlKl
X-Google-Smtp-Source: AGHT+IHZmdYq51jpohBy+oCcp8K1arVqTL330VIplWcyAaOSxpE3wPMMvOGlQMy4gYbmiMNiwVQ3IA==
X-Received: by 2002:a05:600c:4f4f:b0:40f:c655:abd2 with SMTP id m15-20020a05600c4f4f00b0040fc655abd2mr2005841wmq.19.1707908707977;
        Wed, 14 Feb 2024 03:05:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1DQe/0Eqq5t1ygc4Gy3FxlMRLNMo3tQWn9xoyn45X1KgOJwefRuE849vfh12smXlPHJIodWTmrY0qi+MDFxXB+M8FYnPj+ecuN/n4Buy38xK18inlMk6Hfp5Nog2UfAiE26Q/8swR
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id h14-20020a05600c314e00b00411ee1dd5afsm1196183wmo.16.2024.02.14.03.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 03:05:07 -0800 (PST)
Message-ID: <7fc9a39a-f09b-4a81-b987-c5dd0ebca793@gmail.com>
Date: Wed, 14 Feb 2024 11:05:08 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/8] rebase: update `--empty=ask` to `--empty=drop`
Content-Language: en-US
To: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org
Cc: newren@gmail.com, me@ttaylorr.com, gitster@pobox.com
References: <17b2b5fb5acd8fad.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <17b2b5fb5acd8fad.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

On 11/02/2024 04:54, Brian Lyles wrote:
> I just noticed that I incorrectly specified `--empty=drop` in the
> subject of this commit. It should read "rebase: update `--empty=ask` to
> `--empty=stop`". This will need to be corrected in a v3 reroll.

Thanks for flagging that, I'm afraid it will probably be next week 
before I take a proper look at these

Best Wishes

Phillip


