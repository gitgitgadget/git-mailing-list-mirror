Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B29920469B
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593525; cv=none; b=IC6DuVYZd5uPI9yLqOlZYLJJStXhYfreveMo9fjburo74s4brLljVwMFfBJjAUg37wbAHPgOFqLamAQ5c5ekzPSERpipgXKr+sAGjF6si9SGo/YTKdqH5Zz1EdkSR4yRkEBos+13gUjvw5dLg8XKQtFT+m/VLZKiZxfq/P+6Hb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593525; c=relaxed/simple;
	bh=abOmkQL4BLtDvQ9c9TKSZIhmrwJ3IDCyJ22qJIZQnKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/y15bHCYJpcpvYqOU6nk6XAnQr7lLwBDLVR/NGer4tYtX5p72xt2W7fNWyWeVtnOSeK9yVArdFfBYO9CMmAVrw+hwDMhtqNV0IGObVSYwoaGdZiLCzKobeEY+RhFvM7NyN0cKrFiP0cnK/sY/DVx0r7pFIT7j6JeWK5mDepPxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQ9D4Dir; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ9D4Dir"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e549a71dd3dso4369401276.0
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 06:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738593522; x=1739198322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JaNBvFNUGICAE6Maq561yruFn9hCjlTqkn/QPBURX8M=;
        b=GQ9D4DirqASTPXeUXA0D4Asu7UrIMEGHTeX8GWJHsdEGeioGg3TqFcqromoibaOYeW
         uemQ+M4xIHApqtLKUhyRLCEX+vMpBpuWrCiRuCCXv/PKJD0wNFEiwQ411tnur5y8UXZB
         lUV8+7AIczeCmYylfTv6/0uTolllmSK2WCYhou7pcH7m/OfEtAs9dnBxi3noDgpM5887
         tMYlE3/GoYfnKpq44dXXmaUZclaz7jBy1Q9/JCQp/oFK355Ix6bON7CPzPF8+JVvyxpA
         z46FFc7UP1sUrllQl5U/ol3Q9g7DZE1LMfjDocUMmLcYHRu18EuZ11+3tk7p/TbggGog
         GnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593522; x=1739198322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JaNBvFNUGICAE6Maq561yruFn9hCjlTqkn/QPBURX8M=;
        b=IQoLcwmSZ7Fub/N1uFDCK0dpXLqXwazcYUai8JD72LRpTIifO7uRgwrAtCWuCWS7nA
         e3/0wnGyQEf289kd1QYPx7OoWDZEE+us0b06u6P3EJ/FHFVf1L3C3g00FWvY2rgKNvfQ
         2Un/Qk3DfuEKvgka5N5GzBxneZUxkneCHRjukfv5wkD0L1AtlO+l/k34QTxNVn+ED4Ku
         BV4094/2sUHEr3nh9jzfAdaIJcoMc//m7+WB6R3KBjL7KTooV72V0bZ8mUeRXhJUCdwa
         ezIz2Fy2VMuiLyTZlYl1Z6v9hB5QzppDhOm1OhA32kMt+QlY+vAKUlUYuMpgKixUJmIw
         limQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWnZIrKrqFgqclIkisNoPNPlBRcQvxZd9ARnyc7gSAgv38kxCZl7Y4fkCXJuYBzGqttHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0cpqu3rT3JebI8gjc5RcNcS3Bw8oMJGDDiSFeoB3x3gK9aS8Q
	8eg0zUe5/nQBo1ZK8a7L6xRGdUe+iKW0maQOfV/oJAP7gBE+X8lu
X-Gm-Gg: ASbGncvaiYUV7Sc3LnXDwvRPz0WlOOS1n9LQsT1BVkTypZ3GYyhjeAenU7+7epL0zuP
	HjpOulkW/Fr1YC4lokYraGk7jOIIprh5KNgQjhc22TEb6uuTQr6PrukS5hxpm8Mo5MhA/cVd3WM
	wzMDieYPX8chY+6ZqspVnxEs0IsIangJJ+Je4gHvvxjOscGDbi9lGtlxQdI94yiNOG4xdRr6xqC
	iccGa7lxPrQniBzBfg2OorJj/jsQyIjZYwYvVt93CvPselw4D2cPFNhtaJLSrWQSo6unm/r+Lbe
	TDalG7FRt5iD2NTe9QpFl+ACvlwoqTiumpfuNHEcwsBaUB9cga0M2XdeIq0KLg1CVaVTCxg67Hg
	31JM=
X-Google-Smtp-Source: AGHT+IExzrubmxJo6jW1jpp8zpHHQJtibzAT8QUdtBvExDQoGHBizJUUvHJ74QaidKk3mtIMrLwY+A==
X-Received: by 2002:a05:690c:4a08:b0:6f0:237e:fc4f with SMTP id 00721157ae682-6f7a8426b56mr174105367b3.35.1738593521943;
        Mon, 03 Feb 2025 06:38:41 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:2dfe:af96:f238:f6f1? ([2600:1700:60ba:9810:2dfe:af96:f238:f6f1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f8c4b9ab41sm21244757b3.120.2025.02.03.06.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 06:38:41 -0800 (PST)
Message-ID: <65e1bd7b-f388-424f-96dc-2df9b50540d2@gmail.com>
Date: Mon, 3 Feb 2025 09:38:40 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] backfill: add builtin boilerplate
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
 me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com,
 christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
 jonathantanmy@google.com, karthik.188@gmail.com,
 Derrick Stolee <derrickstolee@github.com>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
 <0300aa1b8c37dcd0d529cc24588ae77960fdfbff.1733515638.git.gitgitgadget@gmail.com>
 <Z4jbW7UtaC7hQU1Z@pks.im> <xmqqfrlisl23.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqfrlisl23.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/25 12:52 PM, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>> On Fri, Dec 06, 2024 at 08:07:14PM +0000, Derrick Stolee via GitGitGadget wrote:
>>> diff --git a/Documentation/git-backfill.txt b/Documentation/git-backfill.txt
>>> new file mode 100644
>>> index 00000000000..640144187d3
>>> --- /dev/null
>>> +++ b/Documentation/git-backfill.txt
>>> @@ -0,0 +1,23 @@
>>> +git-backfill(1)
>>> +===============
>>> +
>>> +NAME
>>> +----
>>> +git-backfill - Download missing objects in a partial clone
>>> +
>>> +
>>> +SYNOPSIS
>>> +--------
>>> +[verse]
>>> +'git backfill' [<options>]
>>
>> Ah, one thing I forgot about: this could use the new `[synopsis]` style,
>> which removes some need for formatting directives.
> 
> Yeah, I thought it was more or less simultaneous development and it
> was OK to convert after the dust settles, but it seems to predate
> the series by 3 months.
> 
> $ git show -s --format=reference 029eff9e34f 375852e20
> 029eff9e34 (doc: update the guidelines to reflect the current formatting rules, 2024-09-24)
> 375852e20f (backfill: add builtin boilerplate, 2024-12-20)
> 
> ds/backfill:Documentation/CodingGuidelines does tell us '[synopsis]'
> is available, even ;-)

Thanks. I was not aware of this new style. Will be fixed in the next version.

Thanks,
-Stolee

