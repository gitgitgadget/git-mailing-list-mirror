Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C26307482
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401505; cv=none; b=SMfmz4bsjRrLbw/Z6aog467t1hxHtl50ScbygjIyvvr5TYYi7ZkaTv5vkM8rqj82PtVA1n5Lys07nE8i3jV5QNRS8AuGBzAjWjtMCItC21WGlSXYGKfD44Luwvc2qTo21NLd+9U75adZWNVLuLtHRfZ3IMWq7Z9oVDJ42zXpXCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401505; c=relaxed/simple;
	bh=Lf47xiQvHziPka2JUvnhGOUKulk8VTynEktyMEnla7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLy5oYQIY9zCp2Eo4GdR0459r51kOkeiNR/82Xn+z8VDstHsbHcKUES6GIfpVWIW3QHaOEoLg6iAZ1Ig4Vn5DVIWBFA6LeoZXcwIP2WNa4fllmEbhbHJs2u2RzVjNN80dbvpW7Mt0BOzf7Og8vxgSWz2pnTTvF7DCTIX1nROT/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+WEMvyF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+WEMvyF"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77251d7cca6so4425578b3a.3
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 00:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757401503; x=1758006303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ye/ODImDv94HgAucDTZJHcNZdMsW63rhrvHFmDvI6xU=;
        b=N+WEMvyFArUq1jbBptqB91FPsMZWGSEXuAk0SRnFwdDY/yF4qajhPUDAApM5ADklA2
         NEsPyHjSeTT84UPS1HcS/vcpGEuvLwX9BJ0HxekkX2Iz24i3OCBiVXJiXFUn7ccWlawL
         aAuQ8Ze2ER2h2IrMiTpOOGxzginD4aDHozvchZOYVemdUzf/N7pz3OI6wukXaueFYYo3
         e00Hb0PY9DpHhL3N1tG9i1wiIkW5E9Aq3ZMaAa8nwQoufkq6mnxBW5tPamGFSC//JKe/
         N/IdFsEQax7m7S0fiGTMK2v/9S1wua+iTRHCuSbCIzAqO7eazeiOsaKnxUsv4D/B5gPO
         4dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757401503; x=1758006303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ye/ODImDv94HgAucDTZJHcNZdMsW63rhrvHFmDvI6xU=;
        b=WIcJBZC081IBK/8vtVGaSPvMd1hDwPcevogNjDb2eNk04OVKAwTJi2KpmZeFhB8nnT
         +MRjtx7I49atfH5KCxM72kyNvBqdXZvbfo/0x4cHrw3gqqYuT9zP1pDHPinL7Rb0Ki6N
         UUr2dA0lwre5qJ6Bys5kHGrrj8+Hm4/BueY79I2jD25EH2q0aFwcYqWh3AePhT61QN/1
         xF+U4d9rxdbIr4HAup2BedytMElhI6veIVUp8QGU2HSrOvQzkewzoET0/r6nMCePfzJX
         kcIxe+CBnTZBa6QTyqkuJoy5avBMP/npDIs4lmAgZh2XkY9uJF3Fo7ltwtJWN0LOU7Zh
         UxOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWI4+fJRuKCBrzrbg/sPftBtsdTPnSZk3FLK/Fx/g/S2mn9FMyKtwTH2/m1iElEtLcUQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTD7L5gKifOfi24ZcV/EEuM7hH9bXan+T1tefS77pcFNitr+Rn
	c9MiSzc51qw9RUjb37JmQZpRgQMfXtddFUhoeWppeBDe+wHeX6HlrFy7
X-Gm-Gg: ASbGncsXJM5Crnhec0WhDcKi+v5mhvm8udinzzXSnmcT4uXvr+14xFzT8Vn9l0Atbp4
	7fylh7WA5jN3jzLwpSimAIb5a+XwM7w4vYO+zBpzdK1qRgDLMwrhASZvJC9oXGGnpO3kcHcoGL7
	TQc5OT3320OxF9Hg3WRVBBYIAnOJWmjac6x9oieIvmjCEigjzqvL9WtvXqfNBpvRB/sUCVtD8Z1
	u10X8UYpXTVOKVXS4Qb7h5584X04XhZFf0Q3LMFQ44j7cIyk7wgcTBbcxKfwWkAXRY9EQEs+Y3A
	kze85VlZdCnsxzPZCIiB04sUt7SjvbGRaKTeaVfyT5RmMBlxBCxfWo6mZYmX7UsyF1Bxsx9QYR5
	r79azfZXPlE5R4Mkh2B/a+G/w0Ff/emDNzRxPy3+DI471g6ceBU3dn41mhIF9eQvJrqHeaxlJW0
	s3nion9CsF8EaOCG2GtDlG
X-Google-Smtp-Source: AGHT+IGGSlztpa54N9xuiaR0Ar0Dnso/PDPnMhVG/ViiJ4BqYefXMX8ICvh+VdVQU2gROFCvD3Gqlg==
X-Received: by 2002:a05:6a21:6daa:b0:249:467e:ba68 with SMTP id adf61e73a8af0-2534519ce15mr14945440637.50.1757401503421;
        Tue, 09 Sep 2025 00:05:03 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:7e97:4c88:d5cc:6104:3a86? ([2406:7400:56:7e97:4c88:d5cc:6104:3a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28ade38sm27398389a12.34.2025.09.09.00.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 00:05:02 -0700 (PDT)
Message-ID: <24e0eefb-da7e-4ebe-b417-993b9b105160@gmail.com>
Date: Tue, 9 Sep 2025 12:34:57 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] replay: add --update-refs option
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Toon Claes <toon@iotcl.com>, John Cai <johncai86@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <e8bca1d7-96d7-42b3-95b7-6a525fd3f67d@app.fastmail.com>
Content-Language: en-US
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <e8bca1d7-96d7-42b3-95b7-6a525fd3f67d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 08/09/25 20:03, Kristoffer Haugsbakk wrote:
> On Mon, Sep 8, 2025, at 06:36, Siddharth Asthana wrote:
>> This patch series adds a --update-refs option to git replay. Right now,
>> when you use git replay, you need to pipe its output to git update-ref
>> like this:
>> [snip]
> Both patches introduce whitespace errors.  You can check with
> `ci/check-whitespace.sh`.
Thanks for catching that. I will fix the whitespace issues and run the 
script before sending v2.
>
> That script will suggest a way to fix it.
>
> There’s also a `\ No newline at end of file` (I don’t think whitespace-
> check checks that).
