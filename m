Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441E6225A8
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707057000; cv=none; b=uc2I8Uz3F0Pu42du4OwoeAohAk3diGbDA8jj1m84uHpCP+yfG7ieOhRRvWhHvK6kLJstLauPA0moGYFPALRXRVaNaSLv/CugESHtwE+9ng2Wx1BMTxEoYF15nuKNaeZbHFWe5rUvGOfN5tM+3p/5sLH/kD/bo9RyLCpn8oFv7Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707057000; c=relaxed/simple;
	bh=eN0XdrFtg93ohgbdmsEnPNpitT8v5S6UCklWbtiL9XA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cNIbG+LVvAXT9Al/YxnY40zDUxJm6abQ+cqtZab+UGC45pZa09828HR6jpjCxOh7pYWkleoxxSo5YfBVQmeoPtYQcmdw9Qw/rr225+QtbTNnI0uts4monZs+2BnhPeAuMd993TpOW4RbD2sZjjneLdMKBhBiC03bc22LVl5eLpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXGCB+Zi; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXGCB+Zi"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d746856d85so26415925ad.0
        for <git@vger.kernel.org>; Sun, 04 Feb 2024 06:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707056998; x=1707661798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YKbM6ALVDCzhuNTVrWnkxC4/YD10xFY1MV7IADMPA0c=;
        b=TXGCB+ZiLsH3RizG231/qaVa47VmTulwtRMOGUFziubI6jAJlBV2VWKHpHvIJNBq/h
         sj/UK3Hdu0SVXmNOMA+QAqfcMaBHXQpxT87VS95jIX5ViuOzp4PXDOMERJzR43ynfOjw
         4SLMBZNraOUqH1Jujvnmmr+sLWpjWB+iPFMNiXpWy9WFK6GikiqoXmlyC+9NHLWp3Ebt
         m6Fpz47VzhPL2uLl/eH2MeBLc4ImuIsyzMuyKT75QfhGmwVOpYzwrO1k0e4Xjdj7HSDK
         5mHmpXXybvMqVDagBxSGqeOhaB9OmXDWSgJZcrXrSEe9NicJoKD657UAwP2ocfTJwCFG
         SWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707056998; x=1707661798;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKbM6ALVDCzhuNTVrWnkxC4/YD10xFY1MV7IADMPA0c=;
        b=hfMaetr5eFh2tNDf2TWNCbNMjYlQduRi/o+vF4EJox24q7ndwlH7urqiy0eGbKbb3+
         aY6/OEaGrQ64z9j79/FLU7WtpHo/ceynBczK+7NB46oFCBgN/MhnVBZnUPH9xm1rXXRY
         6evnmGOnqk1+ZUNCzwmeCSc+Mrn1v8JfSsTpFFOFW5FjjXFWcv+9YJ8FBEZ2EQypyLgw
         bbbBy28a7tespRGsz9EcaBjw07/Oq2w8Y2lsqMn7HTSg056HgUuQOvOwGuk0Ytrnb531
         IeIy9jXDDjYDIDGQepC6aS5uGaKA66R7Ng0i0momAkPbzCfDKTv85U/F9Ym//hWPFuGA
         aCiA==
X-Gm-Message-State: AOJu0YxzlVFUzfAE9FbewKw92L6yqJK3CZobcYsFvkmaPIsPq7fHB2fM
	yjtso22HzbITQ5/C/Is0xAWXIqi7MCUzS0x4kmEACnZETCSU5B5b
X-Google-Smtp-Source: AGHT+IEcZhfdsLL8lMbITQtxAjISvPpMihZYQbXYc50FpEht5Z2xmbCbhJMmE8DOXnsPIP78JY+smw==
X-Received: by 2002:a17:903:443:b0:1d7:41f4:be8e with SMTP id iw3-20020a170903044300b001d741f4be8emr5954610plb.65.1707056998424;
        Sun, 04 Feb 2024 06:29:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXvUBjTdCNAhGRIkdWkHiL1nVi5pi3BS6rxKkxtJyRdokBZgfKnyXTvTB4wCWW+UL3sVZiz4Xhhw39OvgVmHTtbrqUW8DQxQkh0GG4vXer5pj6KLqn4ogsm3MTvdTIwJnoLobP9IKDkOfYdGHqnFFzFQLa5BFTKK574inhl6KQN/9fcihR0zI1uHNIycjiyWE/msjjAAAo=
Received: from [192.168.208.87] ([106.51.148.224])
        by smtp.gmail.com with ESMTPSA id ji7-20020a170903324700b001d944bf2d83sm4661769plb.7.2024.02.04.06.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 06:29:57 -0800 (PST)
Message-ID: <8c54e368-285d-4b3f-a4f4-02774d0e6f50@gmail.com>
Date: Sun, 4 Feb 2024 19:59:53 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git in GSoC 2024
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Patrick Steinhardt <ps@pks.im>,
 Christian Couder <christian.couder@gmail.com>
Cc: git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
 Karthik Nayak <karthik.188@gmail.com>
References: <1de82b27-116a-450e-98c0-52eb65a8f608@gmail.com>
 <CAP8UFD1VAvnkM6afZvtpdXhA4csDBDwMnF9yUzSx_ut-Ypf+eA@mail.gmail.com>
 <Zbi8pfvGpYrlZXAu@tanuki> <ZbpGzAd6FGEeTdrh@tanuki>
 <c61322de-8cd9-42b8-a04b-a8ae47b25c5e@gmail.com> <Zbtmoo8qTmj-yt99@tanuki>
 <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
Content-Language: en-US
In-Reply-To: <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/02/24 17:11, Kaartic Sivaraam wrote:
> 
> On 01/02/24 15:08, Patrick Steinhardt wrote:
>>
>> I'll have a the beginning of next week and will think about topics
>> meanwhile.
>>
> 
> Thanks, Patrick! It would be great if you could share the same as soon 
> as possible. The deadline for applying to GSoC is Feb 6 (18:00 UTC) and 
> we need the ideas page to be decent enough before we go ahead with 
> applying for this year.
> 
> If the elaborate project description could take time, feel free to share 
> a paragraph or two that are supplemented with a few references. That 
> should be sufficient for applying to GSoC.
> 

If at all it's helpful, you could find the earlier idea pages in the 
website repo [1]. For instance, the one from 2022 could be found at [2].


[[ References ]]

[1]: https://github.com/git/git.github.io

[2]: https://github.com/git/git.github.io/blob/master/SoC-2022-Ideas.md

-- 
Sivaraam
