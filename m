Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB8C305E3B
	for <git@vger.kernel.org>; Thu, 21 May 2026 22:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779404211; cv=none; b=f12fBh3k7s/1mYOD9nCY2o4XD/EkJiiZ5eQ8HzILXltNZ+S8sMZxZEEiM0Bf5IRRE34Kak0JGaT3TL3LwkdSUqtd3yPgj+vdkgei8uf3mtOgvuktTv5D4e4gIjPlAOIkhOXY291M9SgxBOxgJLLHnSMw4aj1sI7t1PGzRW1VvSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779404211; c=relaxed/simple;
	bh=vlc2xs5Phh1d+JI+xhd6b24mJ2SYGx/G+3o6bFzSpZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wv0MDynvc7y6UpgZRSuZ2+sPxoEeG1cybYmigF5RnC+ZtH1NkCOBEvknibY5qfoLUd7HQWw56YV6HW+VHNtG60Vejt652K1u4TqNSxjrNKyB3vQiv2f59LIll4tqSec/uTQojXjJRa2pPIbU5HaHGPXwvnGkGg85K4qiOzrEpek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oRzUS+6f; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRzUS+6f"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8acae26e564so82635136d6.2
        for <git@vger.kernel.org>; Thu, 21 May 2026 15:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779404209; x=1780009009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u0hm8M9ugRTcqzK9TNqGIM8lSELSnqTq4F5cnhvyEkk=;
        b=oRzUS+6f8q087Qyb1RlDDdzLpqk9uepkWK4cWR3heDOJIP4WLHiN9ZmxzTBKGQzdud
         uH7uBMieH64Cg9xUNx/ewoSM3f1WQma5gsbGVPj9UEenl4lzZAYi2XKkOKlIKup8lcQb
         7hkfFqxKrT/n9BspBtA2YaXhbSIDP70k2d4eY6eUFUunCbTeTO81w7zEEuV/fvu0aGTe
         vGFLB1WYtJ/XB3XYtLBTXSU/bCGEoMyOmmOKijB1dhkTOvErXCb7fN7g/9Atv42rYw/e
         NVQkT44Gb7GjAsk7UYU/bzqBa0yayUTwV2Ik8v1MD7rRtTh2hdC5sE0MEQUsEXwwnpen
         qfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779404209; x=1780009009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0hm8M9ugRTcqzK9TNqGIM8lSELSnqTq4F5cnhvyEkk=;
        b=CGjuZyXdSwxzy5NImNBpxWnzjeojLQl3Rs5uJPFxB3bofCeWDEi7pgZuvV9ULRMHUG
         iEtVE4LxG3tLr6Jm6ipvLw8hFR5vMbEh3nTP8ESJ52vAzx6XzT3oulBCGzU0RsmHtlwM
         FF6EY7ozYIOCzGm85KAC0T7N3DqChi8X5pmV3GnnkqOHcYWheBB9Gt/wVJ2rC1jSeMQu
         S5trPMMTmZXTpjfIJp6AKZtvdCniYrukxdGoKDrThfcj4h7QYFiFmCoz0+EhOlRSSrkr
         UdAE3Gko5pA8pQb7DyWir8HCjhqLpk7AFqjXH5Edly1De0ZrrrNMfj6lJKemZMFFnodU
         mumg==
X-Gm-Message-State: AOJu0YzZGQJKH/QyI5ZbKQtihPvfqnAciBp7x3lQegIc4qGymRdbS1BL
	r05o2pbnUPSCxqR35oIZ619+qvAFnVDsI+T+PqLtr1q+r8fzoxI2gyMr
X-Gm-Gg: Acq92OHiWJmKSPwEFoKTwA5a8K2PSRJnwL1hY5apCKTM4xeI9J025kVBC3gaaEVYo/o
	AIVa/IwtC2Ru4YG+iFN1zdfiiY0EzstNMhXN5sV1IEAQ1lz/IMmkeaB8TXLwp+RTyhXpFaa1rgy
	Tv3zzsENtl85MafuoUNSHEpow9vm7HeVCoCYGH7H3TZ01IhWrxqPscezHETY+rtIZ/iDCPeXIoU
	hqxg9T5uNtkeuLYGm9K1Mw2YMbhzu3YWq7HgSCkQLBUpJ3gvRruVQnZSsVQJEfYZfyvsyHQL03+
	YXtRQLK4oOAGxCrtuv30nBnZP3OW7NaqjaNBq/on6xee/iH5x+4MPMJnDDcEiPq3qvW/X5sNTHE
	HNOJx1wRgEroi75YQwo8iVqU1B4QTHqe7die5BoHxRCFLhf1cg40c29/V0aFs1IHU5T7/aabMM+
	+41a0jTr9iF27F5u+qQti3nMWHxjz9bXJAlmCbn5B7lg9r0Fv6EXeyL33tohM7UQhqyvjP2Ysl/
	6W4UiuDsGXwmBouwqeWGL8R83jInJCDKFIMqO9pgsK4v0eJctKXfdVG9O8=
X-Received: by 2002:a05:6214:54c3:b0:8ac:732b:6cf1 with SMTP id 6a1803df08f44-8cc7b674477mr26175016d6.24.1779404209356;
        Thu, 21 May 2026 15:56:49 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:b19a:969:106e:4f95? ([2605:a601:9b88:8300:b19a:969:106e:4f95])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcd813sm1226086d6.10.2026.05.21.15.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 15:56:48 -0700 (PDT)
Message-ID: <2485a7c4-c798-4886-ab64-a22fa70f55be@gmail.com>
Date: Thu, 21 May 2026 18:56:48 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/13] t/perf: add pack-objects filter and path-walk
 benchmark
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, karthik.188@gmail.com,
 kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net, ps@pks.im
References: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
 <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
 <fb8a0f9c43d4e41712839a93c4db6a294a7b5285.1778707135.git.gitgitgadget@gmail.com>
 <agz3fOHvVKGLMxgb@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <agz3fOHvVKGLMxgb@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/19/26 7:51 PM, Taylor Blau wrote:
> On Wed, May 13, 2026 at 09:18:45PM +0000, Derrick Stolee via GitGitGadget wrote:
>> +	>depth2-dirs &&
>> +	while read tdir
>> +	do
>> +		git ls-tree -d --name-only "HEAD:$tdir" 2>/dev/null || return 1
>> +	done <top-dirs >depth2-dirs.raw &&
>> +	sed "s|^|$tdir/|" <depth2-dirs.raw >depth2-dirs &&
> 
> Ugh, I think that this was a bad suggestion on my part, since $tdir
> should be empty at this point.
> 
> Could we use --format here like so?

The --format option is clean. The full loop will look like this:

	while read tdir
	do
		git ls-tree -d --format="$tdir/%(path)" "HEAD:$tdir" || return 1
	done <top-dirs >depth2-dirs &&

> I guess that breaks if $tdir contains a formatting atom, so perhaps we
> should keep the spirit of the original (but using an intermediary file
> instead of piping the output of Git to another command).

Thanks,
-Stolee


