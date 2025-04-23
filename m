Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F03D28EA52
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745436315; cv=none; b=Ycp9m1vO/ZShZfXI1iYh3zIWgDngl7m0gwyH+aEehD0aShbR8QoGATwxonn9EP2byOHFIP5KuSqhGbryShqmh+Z1ScHashWjl/8jXJThHZ1Y0UZ5sqRQdfdRsIC4bja04tShPKdQQhd2Fbhaoc0cU3J/8C8AiEDw8w0uRN2wJqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745436315; c=relaxed/simple;
	bh=eoTAExLuow+/qjUqlKSb9a0Glk9JPKWtVBkZv3a1KPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lx5jv+Z4re/lG1ORg+NYBK/jhF+2cJzLyapQwTgHc1B/9xOGZ8io+2muNjcI1Px9fe5+mjbIIvKhk/edG071akBi1iJsnUPEiUnyNHhNXfjcpiShP8syXlKcPVk00/01VYY3wz3/6l/pGp3NlwXj7V//uuZ6P7mKt8LW8TpVcnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgESqD4r; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgESqD4r"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e573136107bso122519276.3
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 12:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745436312; x=1746041112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=717/NJbccQ4twDKRSv2T75WExAJtXgNE/v3j7vMys5U=;
        b=bgESqD4rBs/bCGPnAidEGpdB5HmYA12rXO8031CRkUW6i+Eca5ALj1SsiDmqvkE+Za
         iYYX66seML9D9+aT4JS92/EIQ4l6RrMkLsCrtKLchuD24FggFB5/Z0TjR5qF6UcDQFpm
         yh4wBT4aL3sl2mXocFAO8EHQO9bV2415YjaZVbTufnRW2nysL1NB+20EPlX/eA4dmwoU
         9FVtGxIYifeLvAm7X1GbHpo7DDJFkakkjwXTqAL0Q3dnUhTg/un9DmH8m2rHMROohhaZ
         1QbDvb0mvMaPhO+QCbXSEuEwCTsCOQdBjeXvQ6fu5y7XfEyfAuZvaopNKTQTvcFDVtoI
         OGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745436312; x=1746041112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=717/NJbccQ4twDKRSv2T75WExAJtXgNE/v3j7vMys5U=;
        b=qYqn27vMvPhBk1UlwefEnUQTw4hKKJIuc+SlHCIf3qaBjR06kcCwozs3bQr0U1YAxy
         euNJh/ZDbHv90siiNt0JXWV+Wy5irj2u2roz1R25/Myr0Rjavmxl5O4eKWxbLTEG5ZOK
         U6pP2bMcSGBFUMMh5KoFNZyYytnRZ717kn+Xed9B2+SdtTN5usFl7OxwoBxNJvthYKFx
         u0HeYS4A5cwsRvSxrujjVUw4nlOVbq5YFeBP0rblhFlglJz4lBbafZLUzLVrXNbgOkkX
         KHmIJYiPiIdH5T87AYMaLt5+773RpLKw6eyau5CHRXPOW7/MZhKVj8HZ018ycpGUqKaH
         lDMg==
X-Gm-Message-State: AOJu0YzqIgB3t1ydH40gak6BJvIiKZ8WY03GHPxhDo9zcbE69mUNVRDC
	7SKuPksMe5MBx9cdoqQTzOkdVL1d+vNxMBVx10yYyOpfBFMlrcWd
X-Gm-Gg: ASbGncunaJnhd43Q8Ci1x5CJRZTHDQ5Cto9vIzSTUzYz7snwP4tJGb+HeDImZgwkYj5
	pdk2XgYNvRmKQR76mid/FtHXOzyIUhpSzR76zCL6hFV3Dumuei1SdxvpST4gzirmElZN4QlmoRD
	FVLT8W+QDFWKVi5gwUURMgVm6/Jmb51PJ8g/88eaaQO/M7qCRQrE6Wh5DCtAOte8LXxtFaCBAPp
	bWwbpRstkgSlPWzZ6KIZRFvFjJ+fip+df5k1gQpmRK4pUGa76BlEgbqr3D8pj324gVGwy3GwLal
	aCipqnzMDYBP41kIWX65/Z1Ahp9bPX8DShFGyJq2zWr9nCz14D9ovUbhdys9rDzDAui+4lFFJaO
	k3F660HtTWwX9oAT4
X-Google-Smtp-Source: AGHT+IHVOojo3QA10KVruEjyXT153IXKywu+4R2LB8rfho/PjdOpRS517aExRpe7HbVJ/1UUmV4GJw==
X-Received: by 2002:a05:6902:2501:b0:e6d:deb9:637a with SMTP id 3f1490d57ef6-e730356807amr77149276.17.1745436312250;
        Wed, 23 Apr 2025 12:25:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:a542:402d:78ab:7227? ([2600:1700:60ba:9810:a542:402d:78ab:7227])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e729e960940sm2668366276.15.2025.04.23.12.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 12:25:11 -0700 (PDT)
Message-ID: <d5cdcfe0-5dd1-46ed-9860-a9949bd6b3b5@gmail.com>
Date: Wed, 23 Apr 2025 15:25:11 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] maintenance: fix launchctl calendar intervals
To: Junio C Hamano <gitster@pobox.com>,
 Josh Heinrichs <joshiheinrichs@gmail.com>
Cc: git@vger.kernel.org
References: <20250421054633.231069-1-joshiheinrichs@gmail.com>
 <20250421054633.231069-2-joshiheinrichs@gmail.com>
 <xmqq1ptl76oh.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq1ptl76oh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/21/2025 1:42 PM, Junio C Hamano wrote:
> Josh Heinrichs <joshiheinrichs@gmail.com> writes:
> 
>> When using the launchctl scheduler, the weekly job runs daily, and the
>> daily job runs on the first six days of each month. This appears to be
>> due to specifying "Day" in the calendar intervals, which according to
>> launchd.plist(5) is for specifying days of the month rather than days of
>> the week. The behaviour of running a job on the 0th day is undocumented,
>> but in my testing appears to be the same as not specifying "Day" in the
>> calendar interval, in which case the job will run daily.
>>
>> Use "Weekday" in the calendar intervals, which is the correct way to
>> schedule jobs to run on specific days of the week.

Wow, good find! Thank you for submitting a fix for this issue.

Thanks,
-Stolee

