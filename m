Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0E32797A1
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755253529; cv=none; b=BH99V+qq5FgFh3fKPqwpd5F9bTNJtyF+ZNqKJVIgLcrSvCvy6jpj+8VhjSXncTo+Y8OlGtB/WIQa2BAufnRO8W+MLaDQxf4Anl3V8mlHv1cCrmbHFX7BIIngPy7MzzRBgXSkyaqaAUTrXzxR9F7PnX74Djj+Tiv+xE2iHkFePRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755253529; c=relaxed/simple;
	bh=aBT8bAi7jN74YYqFAEDW5hPVV9eAoWxc+gUf0BoXwqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQGwJiY3LoeNnAyIYFkDzYfflpzTHVGD5YDUmIrkiJjEANEN8UCus0L4q6VIr05eA4I/ZyHJiAQ8l6HB30OSlRaG7t0chahBQUo/QBPnWXpMBbvzBd9m/QmRfR9C6A6YZWRGTKg4EDZC6sxc/X4ANcTZ2yg26X3BTXpUR2nS3W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xn1qbDzc; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xn1qbDzc"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b9e413a219so1528075f8f.3
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 03:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755253526; x=1755858326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w08met23VZV41IdJM+f2aEPuc1imTzn/rrMljcIXKqQ=;
        b=Xn1qbDzcJINgfUskfBq/W26biVY15QIqXek/2x3z3kFBPHyCOTEpOcYNhTG6yfor/M
         mStJbb3J/uKLOiyO8ewcDenAOc4++prtYF8++Z7UMsvaujblSxWo8PNQZbOOngvB7/7G
         46ZYVguOVvuowoyyGXRutFtdBs4SdEwqzvKak2/nMOIxurdtXH25Dz7VLxF4pAu2S/8X
         jt//jKtskw/TWN0x9Jh0gGFGMrpAnW4gnj01v9QftA7UzpePBEpr1F2A0/DREWeHvPkp
         /heUkAu5IYDRutRgdVcC2OwV3hb0bHdEljk6mk0O3oGFLe+z8Qgo+kVJsZIMc9r5aqG7
         c/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755253526; x=1755858326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w08met23VZV41IdJM+f2aEPuc1imTzn/rrMljcIXKqQ=;
        b=b8pTKM2dP5btyfjhmmmb8u4aDB9BGlyiXbSvOT90rIPuWDhCDzAIvUWcGE7kyV544a
         rFkZbcUnYWIwt6jbXpoKwV+EMMqmYTO0HjkkrdIYixpEyy2tBYj7ZNMN4mu1y9KT5hLp
         Zq7jscplwArhqiHpY35XlqQ+DeNOfvOJnlTUOhGXLo7vz7/9SRx5DrsXGEPK96FGq6zo
         zaN0ntPVQJuYn5MFyt2ZKv+Orq4ZEtUfouSnM1OBYfWO4PFRDbbteAZBOmfNwAZAGL8a
         hVYZdYurmiub15o+c0x0EKRIeH4hnk4CCX/AURBQS2Y4J99jBjFy3jOXRfVMS1UGh3EW
         mlxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgH6sej89RyueYFbSUDuXOTdvOFZqUCd7JJlZ9JELSF3b3TrgWgRsROg397K1Gx/48/eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEnhrOKj//J7RUHzEssNaSRLBbcIca1mZo1t3AZnhogTqx/wMv
	xpIvvmDLQ2tzOfymQxmcVIHPIt0Ye6rWsmSAlfuv+z77rZh7ctdkhpRh
X-Gm-Gg: ASbGnctbH00DS4xifnfhBhLVH47K4ADZqdbXqhGr1vGpF2LfxoIaQzkhYy1bAfo1+5E
	iJeIXcpPMRF5/ekYv+Soj1w6aRDBR0Z5WNg8ugcdq/G/cOZcQYMzvD3esuu3lxtx7RspqbvRtMT
	uQNO5a7kipi4BBgyqGr84zvW0wIzqwGHfIbTJC6vsYp84WPkrsXxDG8lUXjbKmibMVNFpiXkivL
	Ybe29KcS8Ghv6XeOsN+GHnEFBB3qh7IHr6vACxdsMsGRDIHBoLVXg5330X63qtZ/Og+xFjiyUhy
	lFaQ+6svSeBgg0rTosXLsFor2BkxsHk66Neu2K9fYZpblYX3yZlzaCxsDCM/laC35IottXV/sNi
	Mxi6BTDZbEsLU6dj6BgxCOTYznu7N+6lOiXDZilDr9fw4Lfc=
X-Google-Smtp-Source: AGHT+IFIYKrOfowGRri44IrOgo4mbTPmaJS+GpwVqpXEmBfTQHjHSxFaTL3dskDKtPbo4D0ToPAi/g==
X-Received: by 2002:a05:6000:2c0a:b0:3ba:c0d2:3985 with SMTP id ffacd0b85a97d-3bb66942988mr1287395f8f.7.1755253525951;
        Fri, 15 Aug 2025 03:25:25 -0700 (PDT)
Received: from [192.168.1.194] ([90.254.76.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb68079341sm1378853f8f.50.2025.08.15.03.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 03:25:25 -0700 (PDT)
Message-ID: <50bdac9c-ce4f-4682-846f-6d6b3f278123@gmail.com>
Date: Fri, 15 Aug 2025 11:25:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] doc: git-rebase: clarify DESCRIPTION section
To: Julia Evans <julia@jvns.ca>, phillip.wood@dunelm.org.uk,
 Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Karthik Nayak <karthik.188@gmail.com>
References: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
 <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
 <52504ef0-7d4c-4298-af11-10477673e9d0@gmail.com>
 <aa1c2758-79f9-47f6-87d4-16b19fa5bd63@app.fastmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aa1c2758-79f9-47f6-87d4-16b19fa5bd63@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2025 16:33, Julia Evans wrote:
> 
>> I'm happy to leave it out but I
>> wonder if we should drop the references to --fork-point and --root as
>> well given they're also both pretty niche. I'd also be very happy to go
>> with Junio's suggestion to replace steps 1 & 2 with a general
>> description that does not mention 'git log' at all.
> 
> I like the idea of leaving out `--fork-point` and `--root`.
> 
> Now that I know the use case for `--reapply-cherry-picks`: what I like about
> leaving in the `git log` description is that I think it makes it easier for
> folks to build a mental model of why a `git rebase` might  be slow: there's a
> "fast step" (the `git log` step) and a "slow step" (the `git patch-id` step).
> Then even if we don't mention `--reapply-cherry-picks` in this section, a user
> could infer that there might be a way to speed up the "slow step", and find the
> `--reapply-cherry-picks` option to speed it up. 

Possibly though I think they'd need a reasonably good understanding of 
how the cherry-pick detection works - do most folks really know what a 
patch-id is and that detecting cherry-picks means generating a diff for 
each commit on either side of the merge base?

> Maybe we could mention that the
> `git patch-id` step can be slow in some cases.

That might be worth it depending on how much detail we want. I think it 
is only really a problem on large fast-moving repositories where a lot 
of upstream commits get added between rebases and on partial clones. The 
latter is due to a sub-optimal implementation that does not batch the 
fetches for missing blobs, though I guess if your repository is big 
enough to warrant a partial clone you'd be likely to hit the first issue 
even if the fetching was more efficient. If we say it can be slow we 
should perhaps mention that this step can be skipped

> (also I might have misunderstood the "fast step" and the "slow step" thing,
> I'd be interested to know if so)

I've commented on this in my reply to Junio - I think it depends where 
you draw the stop boundaries.

Thanks

Phillip
