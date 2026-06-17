Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E7843D4ED
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706150; cv=none; b=GoF8E0jp0D1NhMLYx7fhL/9DefWCpQqsahUhbQO0HKrrTZyKhVqTFAhXGhXvA5unex/jtw0x/NsSZiUCdaFZrzEstseGlNhhxhpqUCn5k/p2uOYFSXPo5/L7//kcqYuF1MVe8N4SD3jr0fKW2hX3GKuno/srb5ft0M/o78ZQzMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706150; c=relaxed/simple;
	bh=wVllKG62J0EepoPlj12KmilLAxDkcyo2FKQsFXAKcfc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ol/DwL6OqgAuv6dwFYmG9pZCf//npdkTG4qLCTUpsEv+C8UzMq65ke8m/7dO+y7ZrcLDTyK2UpB/DpLXyqT/KVOxyjuBVadWPwCQr1pvHLEL7Nc/PzOlxw7vs1uEUXqM0fesJ4GJddgUwLh55RbgMtw5IIe4LvqtFYiG/6l5Dy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PC8+CtDE; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC8+CtDE"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6930f7e83b1so1504496a12.0
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 07:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781706147; x=1782310947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+tZSR17xB3fSqdtkCggohiOqPoiIhjQ7uCqEKVFFg4=;
        b=PC8+CtDEcizimJJb0a6F97eLqRVeOG4A1q/KEVLGutZcR2mjt7LtclB6P571k2UlAL
         4kMcOf4v77ijqIQg9uIECgDoRDm+6PCZfnMf5JTB/xNdJFQHtlxdkmqT2c+JZKsZ1d3b
         PqwceIfOEPnRpyyD3tgIfYK+nzQ0kdyB7u3kA421tXGwbQyjZckBBLT9On1XWuFW/K8V
         g3+MyLwMEe2RkBrpf2OfEunBdyywaYl0MTFLIkxckuXezpjYS2JeU+J4KS6b6DU3JCIJ
         8EeZPMSi6K9hyt7Q8CfljREmEYP2IHEKlfDb/9IomkRbjUl1Kf/Ko1ID/ZIYqoL21Wqy
         9roQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781706147; x=1782310947;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+tZSR17xB3fSqdtkCggohiOqPoiIhjQ7uCqEKVFFg4=;
        b=VFen9cFI6185aLZKLrWnvb9QuGxDpBY1c1+sEic7RVhXXjeWVoyXBB5Ys2NN6QyAyD
         sDpmwdmkNPdr9+DOStPNjcKEuT1K2nsDfXsqSUD/32vUZVuQkTuZnHH/SyN2x63mFKSp
         Il9wY2QqZ0RUWS91MOY/3Uh7ESBSaI1iKlNhcj9dfO7YU5YXbrIAQ7F8lKcUJIv3D/V6
         gRPqmZZftiK8f+XjhqF+DCHVELSNiD+aYg3maDmpQIwPCrpchUe7H1W1A/AfsVRmXgqr
         wb7T1Q0LbRbnXeVLrmW5DlLIVRdu6VVgAqksCQKYlx+jgXgylg6sbG24xBu6mwmc9gs6
         3k1w==
X-Forwarded-Encrypted: i=1; AFNElJ/K1V5jcA0yNLJfqyG2F0Hk0Jx/MYP1XUZrDOxtWd2O/WRf/ribQqNFQU7wtJTOq/F5y7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGcSPuSv5TvtUNMeVlkE7mkonPwddhv79Uh3pDcgC/+vxvyviC
	dpS1OZDuiLOH0jJzYxtjXXy8X4hgMayCsabCKzLXOYOcXP/a89TNq5fY
X-Gm-Gg: AfdE7cmQlzTzaFKYlEhPEk8bhhLqyuOE9xlMIdcN7zRlJ0HhyxNhmae2f94/wQk138A
	hIeV8imsgnTyOv6EehiyKPysWIYt/9wb26Ee9z3AzwtaVn8qVMWOfgdafVkZMJDfEIR5Bq8BxjD
	1nbpmFNQjepUfMPm120L0rvZieKRM+iTEXN5JhWkhsDEVbt4DiCWuaYsRuBZXvKFNAdBtcghKGY
	sw62C08ruNQojUNKn0/k0Lg/yrxnJJiHSvGrEXCwCdBpC6Q4pVDKlnqWiC3SxennMu7onxKy2yV
	HNnmETUgboE8vM9e4IUio+bKqpyN2xkl2m3sPmB+V6ypIMKmK0gmU2JQnFC+t9gWUhO+cEIRxu+
	2gBgcN80styLo64aViwKAtdihPnXu21V2C7EpaTXr8cITFCZNyJLmU0vXtUPQRDfX9Yu9CC2fmx
	KThwBDRShcFeq2dNxTZ7cFkZqaXmWMKNR3kKNK766U/BwWU6Ba2AZvjth7GVfmcz5g2Gw=
X-Received: by 2002:a17:907:2711:b0:bd5:1605:e1c3 with SMTP id a640c23a62f3a-c05d6c4d234mr120027166b.1.1781706146951;
        Wed, 17 Jun 2026 07:22:26 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb5318d8dsm777932166b.26.2026.06.17.07.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 07:22:26 -0700 (PDT)
Message-ID: <5829103e-d357-4880-b295-fa0d9f4a2c62@gmail.com>
Date: Wed, 17 Jun 2026 15:21:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v15 0/7] branch: delete-merged
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
References: <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
 <pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
 <f68e2a11-02a5-47b9-a01a-458eba821c37@gmail.com>
 <CAHwyqnXRo=P5Zihs6s7Uh8CrYCO7mjyeZ5nAv9JqYbGH0RE72g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnXRo=P5Zihs6s7Uh8CrYCO7mjyeZ5nAv9JqYbGH0RE72g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/06/2026 12:17, Harald Nordgren wrote:
> On Wed, Jun 17, 2026 at 12:01 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
 > >> Our SubmittingPatches documentation recommends waiting for the
>> discussion to settle before sending a new version. When you know someone
>> is going send more comments on a series it is a good idea to wait for
>> them before sending a new version to avoid too much churn on the list
>> which makes it hard for people to keep up. I'm not going to read this
>> version in detail because I know another version will be needed but I
>> did spot a couple of things in the summary below.
> 
> Got it. I think I am waiting a fair bit between sending new versions.
> My last version here was 2 days ago.

Right but you sent that version a few hours after I'd posted a partial 
review which concluded by saying I'd finish it the next day. If you send 
a new version when you are waiting for further comments it clutters the 
list because you know you're going to have to post another revision when 
you get the rest of the comments. Anyone reviewing the interim version 
is wasting their time. When you receive review comments, by all means 
start thinking about them and updating your local copy but please don't 
post a new version until the discussion on the previous version has 
settled down.

>> Not changing force sounds like a bad idea. The whole point of unpacking
>> the flags at the start of the function is to avoid accidental
>> regressions. Unpacking the flags into separate variables means the rest
>> of the function does not need to know that the function arguments have
>> changed.
> 
> My reason for keeping it like this was to avoid the slightly awkward
> double re-assignment of both flag and boolean:
> 
> ```
> case FILTER_REFS_REMOTES:
> ...
>      flags |= DELETE_BRANCH_FORCE;
>      force = true;
> ```
> 
> But your way is likely still better, because the definitions at the
> top of the function are clearer.

Oh, are we passing flags on to another function? If so I'd missed that 
and it does complicate things as we don't want two sources of truth.

Thanks

Phillip

> 
> Harald

