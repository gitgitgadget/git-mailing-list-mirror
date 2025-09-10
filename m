Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953EA2F2908
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757536114; cv=none; b=Pifu/QVVjkBhgEgv5TLFoJ8P+niPwvy9xL02YLUnHY5xDybb1/Odnk/iRCB2DsTR0MjyKan+ga1AmllpBpfat02d0uRTpzWGmBbs3YVZh2MDm2lAPZy1qtJNWtzNt3hCjdoNqmEjAxe0wiqw+IYR86hquQlSoUheXdReq91jPgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757536114; c=relaxed/simple;
	bh=DjJOmZ60HPSVnpct6ORQKTHuzihSd6LctPCCv3VaC8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2AT6ml61XQ7JvIhPYtq3kzr5O8k5I0d/8wIj5MIsst0Kj/xzfFK/grYeTS8A8RkgeV+3/W6dRSFSKYgfD7d0I+n22EETQ3A1T91R1ZgiKKtq/NIlYmWKl3l/YsuaNI5pDdacixtWbAsCTb4flb3IHLo43e1V/bdWPb1pELkG9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNnfDORp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNnfDORp"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-25669596921so37180625ad.1
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 13:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757536112; x=1758140912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZL3QPl7dMCj+VHtWDtFwVsVFTOIbpRheWb6SWGq6ZuQ=;
        b=iNnfDORpkzZcafAEpr+Nr57O4KyNNxvRSuqttuU+sPQUwyHfUZbGYGCJkgawODgv4a
         sk9vebBd+yn10YW9EFKMbCFrFv5ZYJe3iVCytflWyvP7Odr312uTOMVM29QnisdN1NRK
         B6aM9p67aAXGLcUfRjc+jeWPIe4R1k6wAxiP3Fg4573czVjU5tSRJs5E9K+K4gJFXU10
         tkU9uZRbwz546efrTnxgsmoPeeU/dgRHNmSpN2Mnvov2pGoLFc919JmcxXfC/f4KG1cG
         8eAK1umJpAaTpXM2cpvSq7CFPnVNvFLTix7We6H9IwyCfjlaeifKVsyAwy/ZsDu/KYYi
         lU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757536112; x=1758140912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZL3QPl7dMCj+VHtWDtFwVsVFTOIbpRheWb6SWGq6ZuQ=;
        b=mOsw6a8SZJtJUueA/Z8/U7AFn2x9IwCy0pnYalq3q9sIAStw1h1BSSLTnXHi0Ao7SQ
         QUIDR2Rgw9UXgkq6C6tpE9ul6T1yiF9J+DDSNkmu1rTdYpvuRCd+YdzTom9TYfoPnSX8
         CaAyt7Wl978FpoCR/IiwLd8TcYUBHLBOBXqY86L5eqyXAhS76K3/7nPrkUjjIAPPqsUS
         4M5oMIR5jkFXsWjJV8EmLqD2+kDbdb5VepmrzaLzQYo1rWCMAG6VC9yiP03kXlsffs8Y
         UQ/AOIXiPNV9t7uru3cHcTkXNUFU2pXwV4eEEogFJHGEhRLjXN00rncTHimVnlvlUWdI
         ptbg==
X-Forwarded-Encrypted: i=1; AJvYcCWr2rHdw+wiuuHegYEGFxBs4xX/SbbElKQzpyx7eG2dJSQ66DOtnw5yd+p2fPjPXyXKfbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD8T1qhjJQaAMpjd1xys5HTliRD7LZmGxXhxn2jYMuB7Oib8U/
	W7wZlGVXTwJoRKuiTXXd1t7n/QEjSk6HoZQewxJ4VuB7WLAUkU3OuzHvTkuSqFxq
X-Gm-Gg: ASbGncvhXRhMZzylnYHjWlIvwgxEy5GsHRBwEhCxRatzX6jNJrptJVWVEIWkAaHuyh9
	ghVMOC0b4PogY7iwqWgrinWcD+jMhOCKKKdLLhOisTmf6yzAgsJrHLkqcvJj4KpDUkmxRCFTjh/
	47JW+K5HDmbM2l2K0IH6cWUy5JzDQC0p1Kr2lLSAM0XIW/OTC82JjXyh+I7QM236ZTkrY1O05V4
	gUs9xyKH2WvaiFfOgkV0XqHzFs7IFYru8PDytuLg6XXU4DZlQfYkmD+L8iQw9zHScdIlE1TDI0k
	OfByIgJOyhF8848gLHEMCOd6RSO6uvqzW0XnyvmWHaJPcxCmXUcVy1X+Q3EQG8DLNRLjjyiYTJk
	GjNY7nGVVIwQIOC1Yy7NVv4puhJkRIiNIlt8lZMDf16GzgqgznpSPwdp6Bj/uH65J6q7WV+jIUn
	fP18exh11S47B6u5myKOngmEfb1ILeLuibSw==
X-Google-Smtp-Source: AGHT+IGexE7cD/oJLegr1q9ru4MocE6enZkB7+ZV2KdvG1OEBd3B8EmvUE4VtJFnE1j16KYX6SVJ3Q==
X-Received: by 2002:a17:902:d2d2:b0:24c:92e6:3916 with SMTP id d9443c01a7336-2516f04e100mr254302355ad.21.1757536111604;
        Wed, 10 Sep 2025 13:28:31 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:7e97:9da:149a:656d:6410? ([2406:7400:56:7e97:9da:149a:656d:6410])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a27af540esm36489075ad.47.2025.09.10.13.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 13:28:31 -0700 (PDT)
Message-ID: <1c18057f-44fb-4442-831c-9d9f53a4ec0c@gmail.com>
Date: Thu, 11 Sep 2025 01:58:25 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] replay: document --update-refs and --batch options
To: Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Toon Claes <toon@iotcl.com>, John Cai <johncai86@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250908043620.57848-3-siddharthasthana31@gmail.com>
 <0683661d-3e70-40e7-9f14-c1702d17fb80@gmail.com>
Content-Language: en-US
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <0683661d-3e70-40e7-9f14-c1702d17fb80@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/09/25 00:50, Andrei Rybak wrote:
> hello, Siddharth Asthana
>
> On 08/09/2025 06:36, Siddharth Asthana wrote:
>> @@ -91,6 +120,27 @@ $ git replay --advance target origin/main..mybranch
>>   update refs/heads/target ${NEW_target_HASH} ${OLD_target_HASH}
>>   ------------
>>   +To rebase `mybranch` onto `target` and update the ref directly:
>> +
>> +------------
>> +$ git replay --update --onto target origin/main..mybranch
>> +# No output; mybranch is updated directly
>> +------------
>> +
>> +To rebase `mybranch` onto `target` using atomic ref transactions:
>> +
>> +------------
>> +$ git replay --update-refs --onto target origin/main..mybranch
>> +# No output; mybranch is updated atomically
>> +------------
>> +
>> +To rebase multiple branches with partial failure tolerance:
>> +
>> +------------
>> +$ git replay --update-refs --batch --contained --onto origin/main 
>> origin/main..tipbranch
>> +# No output; refs updated in batch mode, warnings for any failures
>> +------------
>> +
>>   Note that the first two examples replay the exact same commits and on
>>   top of the exact same new base, they only differ in that the first
>>   provides instructions to make mybranch point at the new commits and
>

Hi Andrei,


> Adding new examples above this paragraph separates it from the 
> existing examples it refers to.


Good catch. I will restructure the examples section in v2 to maintain 
the logical flow, ensuring the explanatory paragraph stays connected to 
the examples it references.

Since I am moving to a default-behavior approach (atomic ref updates by 
default), the examples will be much simpler anyway:

     # Default behavior (atomic updates)
     git replay --onto target origin/main..mybranch

     # Traditional pipeline output
     git replay --output-commands --onto target origin/main..mybranch | 
git update-ref --stdin

This should make the documentation flow more naturally.

Thanks for the review,
Siddharth

