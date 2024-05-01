Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DEB12F5AA
	for <git@vger.kernel.org>; Wed,  1 May 2024 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577997; cv=none; b=BwXba7hqg8x3/LhrmBBCVw/VWIb8g6OGCZSh14TzMdPU9vPheedyjUocJPQqQfnJcO82g/hjsLSf0S8oMkPrxwp4F8vFDyz3lKW/DSw10JKFIAnKxvVZpj09ZjnfjNyZGGNARWq6vd0wKx1LKe+H0n6vr2Zk+0BHGoAtuEbfnt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577997; c=relaxed/simple;
	bh=vVkFV+A0LGZnPMHxLHkVcSBMc2gfTZ4xcymCu+MfPiY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EmXj4JD5aDfMx2ZIHhJ8FpS0aD0pcMvG7BWPPwacVaI6pmw+DZxmxnUHsa/6NSNKn37eJ0TowWJDsr/VQZ03sNtEKD1MGCsp5BHuWZM+spowhjFx7q3r5HNOOlRsZlyEg4HiBmnRgXlCOz8P9EwU/R2vVWngN+K3ZDG1WPPeiz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5C30BsX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5C30BsX"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41b5e74fa83so46432035e9.0
        for <git@vger.kernel.org>; Wed, 01 May 2024 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714577994; x=1715182794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V8uPWfAiA0y3Qp7Oz5xfsK69624mDiy+L8Eo6EMsCJE=;
        b=f5C30BsXf+xRJDdqrZ5slRHMP0GZxhRtIhk+3G2ClY4LszwMeul9cC2njyjmUIw3dq
         5FbIRyeL56oZZLhIycabrpgZbhaByarjGDEbdmADWubYfJx2+S2E9l9Mz2l9Bzm1wpaI
         EfDG1V7z0jauibJKAFkWIBGJQpHztj0KABJoh2IRRQ6nzTgWvPw0EEsOa+Nhwo+22+Ex
         nYHch+MyGzJLLHc8msLtvyQUjgjV8q+ad09KJoJE2SVQYMlJRdpzg1Gn2rVyECmRF8FY
         tqSzb63NzzgTOs3z8bH42iSXnjyi7flO90jdDg4fnpaPZ+J+OfnbEevAjT+LIX2iXZ+2
         fvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714577994; x=1715182794;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8uPWfAiA0y3Qp7Oz5xfsK69624mDiy+L8Eo6EMsCJE=;
        b=iJI86LbTBMxJ/JSkmZvgwzVrlT5TbS5hLmqu6xBRAEJS/6j+8R2YY+VEQz6avNACsI
         RtPlXPrXmSXNJ/RJpU301fdrtuzQQ8X0u29sXKCp02sJXr+xLAqNxYE8Prz7RCPgl3im
         089Ok3qBwXBJE4jdyvS9cmAPXHg8SmjRyxsrAwgmTKCKNSZilKcrEUyUY9TRXKxobFPp
         +Yz3Boy/Wj1UCvLUlk3NyJKWUZ29kLOFABmIwPb3JLKlyhHdYZCCU3dKz0rF90FCmIX7
         aDXrN26dHcOguOeKNDWc3kKG/3Uva+aaucZBZc1JmoFGyoQwYGiDny7BnJTFvfNXYSmc
         f9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFon1e5xr4w9gOJKJJgYzRAwrEpQ8fEtDoIM2ZQ+JqojnOJZCHpwmdlOwwKmtZ8jXB1UGCdE3/f13lcm3fPB9YB8bY
X-Gm-Message-State: AOJu0YyqlJva/zJhkyWjFQ02FnEeUJrqqUwQyTXEfOdreTj34QckXZuc
	W6v/Mir4ZEImRQLY2BRb5uVlA1fyz2J1Ek2GrV7G3idXInJ9bld3
X-Google-Smtp-Source: AGHT+IHC1hesdbkQlmCmaltlmz+SAolYXRN5Bbl/7o2TMas9Oc5a6c/i5jDZ6yB3TOZhNRvaROTbqw==
X-Received: by 2002:a05:600c:1f0e:b0:416:88f9:f5ea with SMTP id bd14-20020a05600c1f0e00b0041688f9f5eamr2000739wmb.34.1714577994424;
        Wed, 01 May 2024 08:39:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8e01:7cd2:1ad2:b4af:7cb4? ([2a0a:ef40:64f:8e01:7cd2:1ad2:b4af:7cb4])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d594f000000b0034dbb122af4sm2464246wri.113.2024.05.01.08.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 08:39:54 -0700 (PDT)
Message-ID: <7a3fcf9c-a70f-47e8-9624-40b407f90242@gmail.com>
Date: Wed, 1 May 2024 16:39:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 1/2] add-patch: do not show UI messages on stderr
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
 <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
 <952a9514-3cf1-4601-8f0d-db57adc750c3@gmail.com>
 <10905ab3-bb3c-4669-9177-84c8e6759616@gmail.com>
 <27fbb12a-f2d2-459c-a27b-519f69242105@gmail.com>
 <ce11355e-25f3-4d76-91ae-bd561143dd49@gmail.com>
Content-Language: en-US
In-Reply-To: <ce11355e-25f3-4d76-91ae-bd561143dd49@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 30/04/2024 17:38, Rubén Justo wrote:
> On Tue, Apr 30, 2024 at 03:47:04PM +0100, phillip.wood123@gmail.com wrote:
> 
>>> @@ -1778,9 +1777,9 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
>>>    			break;
>>>    	if (s.file_diff_nr == 0)
>>> -		fprintf(stderr, _("No changes.\n"));
>>> +		err(&s, _("No changes."));
>>>    	else if (binary_count == s.file_diff_nr)
>>> -		fprintf(stderr, _("Only binary files changed.\n"));
>>> +		err(&s, _("Only binary files changed."));
>>
>> These two mean we'll now color these messages which we didn't do before. I
>> think if we hit this code we don't print anything else (apart from the
>> warning about add.interactive.useBuiltin being removed) so it probably does
>> not matter whether we use stdout or stderr here and I don't have a strong
>> opinion either way.
> 
> Can we consider those messages not part of the UI?  IIUC, if we hit that
> code we haven't entered in the interactive UI. 

I thikn so

> Maybe we should:
> 
> diff --git a/add-patch.c b/add-patch.c
> index c28ad380ed..b11a435738 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1780,9 +1780,9 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
>   			break;
>   
>   	if (s.file_diff_nr == 0)
> -		err(&s, _("No changes."));
> +		error(_("no changes"));
>   	else if (binary_count == s.file_diff_nr)
> -		err(&s, _("Only binary files changed."));
> +		error(_("only binary files changed"));
>   
>   	add_p_state_clear(&s);
>   	return 0;
> 
> Or, simply leave them untouched in this series.

Either option sounds good to me

Best Wishes

Phillip
