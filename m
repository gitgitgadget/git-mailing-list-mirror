Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580B03451AB
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872790; cv=none; b=CAokJFg/GZTc3xQdZcOkQgXKPgw5LMR44obbaDTXuqmRtFLY7qWCnfQtfsYnREisgqe7QEXxDVdyuwZyMx4EaVzyW0a+tkAlBrJ1DS4zBQyXYeK4tL4bCQVAH0eoRRvxejwIQ5bWpW/ZRtnYAHDzIW8VtldrrNVaU9udua0v3dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872790; c=relaxed/simple;
	bh=fIx3e2DxuGJeKsU4joT+NK6sDrMOeMS5Py8JMgpjGT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vrdop+4mTGcnqhWdRVGOO74rGBUzQRco2XMd08NJi61Vs5DRZ66w6Zo+xvzF67HAANCgbd+rZjqJ/Lg4rGAejxlaJMUYxyEqgppVuZU/hIRjC6SIrLo5VH1i7HCue1olRpgeEL8TE+YipNmoJEnugo6Vy2Qvi5mJx51gcZYRAcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePS+GGbN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePS+GGbN"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47758595eecso22696915e9.0
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 06:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762872785; x=1763477585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KlnLz6fUo/pIyqIdM1cb0I6rA7wlHzqot1F0S9yq1WU=;
        b=ePS+GGbNLwMokdFhJ2MUi3/DAKSlNlYa43B72iIwuJ5gAClULVUbhHvJ15PwJ+Ray0
         Nea1ffzEGUiYlO/be6awCwkq7iaFVHo4387iTTRWyIHg889RajW4x9Q3zCHvBLCIJeFE
         z/LSljEVN8JF+ofmoWp1cGoCO0SYZHONW4zuBJ7cjIwFIiC04SeI/0niGosGiBzkpV/X
         PzSyTq+ez819nZ9yEXoGknuHCa9ZoADCjQYcfPXg+rjf9Aj6UAFosUjSpJnAdzVdMtNr
         pozaq0FOsJZobDeIojJRazgSfXv2bWQ6wlNx1fJuVOdK33B61V0s9tupBFRcOPq1dQ2x
         ZX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762872785; x=1763477585;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlnLz6fUo/pIyqIdM1cb0I6rA7wlHzqot1F0S9yq1WU=;
        b=HWHrO57Pdqh8KMcVDqgMuq4qR1OT1+PCdJFjhxyjuXxWgGCJbGx1ejSYwFvcnLkFkE
         rfCZMUdAkxidsNAq1GiRsnHT4hGWkUKJOpGYwnYC37iK6m8ywzNxx7F4VixqXrY876DD
         VvMCUq/uJo5Ui9V+NXfLZS8cS2udu+NV8J8m2M/kGUJC4VjNmsokfQ8pqbY3qxbpqCcN
         yuVC7Nfz5rG+5oVgil3dr2+3OopLITie/Thf8Fh9wJ/qRdC7t8pVaIwkq047xv/BxqRq
         lWbFnzMEk/BC1hc51RAX1t9zg+4lSh5CXWtGYVQq+8e7nF2OFHbvosq2J1rDeWGB+j0/
         vp5g==
X-Forwarded-Encrypted: i=1; AJvYcCVPkEecQi5/rrtsHnH4w4ENS1KQHNcOq6kSiBEcRPTefaKZpzti6ANpKKlQW8Ilgel5+C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlNFCJ1leTWy3O949yLAhz+DelGZ+VC3SIApbPCeTZX7aE1X0f
	fvfEYOZeCXJP/PNsTvsL2oiJpnDKQM9x8gDn7AUhId0NVtuqP84iIE4H
X-Gm-Gg: ASbGncvVq8LgsHryU1tBuYi7KwMEphfVwBHaGBycMQueU6MBA2+Hgztx78+cUiMVBSt
	FTNzhsUSyrZ3eqy3QZdou4pzr8zY1cjZQauNRvvQ8O4y2g00WVn4wrErnMHniqBGEooQmC74ZCk
	liHgvmXBSHnFWUjVZy5Yc/yRfwculwYjdEUOcibNaesq3crDJKEHX6qVyaFtptAvR9a1fAw3Sph
	20c1xRK5qV3Ks/TT0vK2uaTVgOfs6p93iDD6lKXxq3DN+e3nEKjDHAU4JSZEcAct5c1pUscNuyS
	jfS1qzcS5yvBqjGya+UXVRh9Yzc1LobMYauX4IwNZcrF26NDrKOPESUQgjpmhHinZJw+uKrf4Gr
	fGV3I/M27sgowiX8w9ud1YepNJ/I7pBF7Oe/Zh8DN2uaoM/VBoA8bbpQZ9gFdhVJMf0wV/wI266
	/Fq3Nubp/Pd4u9oYNPmQUs/tDDjyFgJelirX30zCw12shVFZaBPsUL
X-Google-Smtp-Source: AGHT+IETnTRZEd72eDHI0CQt5ZVvzwz6Yx+jX+5W7TUVJLQWTkOk6eV6fFWmu0XjahGr6qXGJ3FQcA==
X-Received: by 2002:a05:600c:474c:b0:477:55c9:c3ea with SMTP id 5b1f17b1804b1-4777329747emr99101665e9.35.1762872785199;
        Tue, 11 Nov 2025 06:53:05 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce20ff3sm370772385e9.10.2025.11.11.06.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 06:53:04 -0800 (PST)
Message-ID: <f7a9bf6d-d723-437f-badd-517fbf47d945@gmail.com>
Date: Tue, 11 Nov 2025 14:53:03 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] commit: add --committer option
To: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 phillip.wood@dunelm.org.uk,
 ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>, ZheNing Hu <adlternative@gmail.com>
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com>
 <aRIoleD6nP-kA4Xn@fruit.crustytoothpaste.net>
 <20251110201136.GB127132@coredump.intra.peff.net> <aRLdsu-MUgPPdIgX@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <aRLdsu-MUgPPdIgX@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/2025 06:54, Patrick Steinhardt wrote:
> On Mon, Nov 10, 2025 at 03:11:36PM -0500, Jeff King wrote:
>> On Mon, Nov 10, 2025 at 06:01:57PM +0000, brian m. carlson wrote:
>>
>>> On 2025-11-10 at 16:50:04, Phillip Wood wrote:
>>>> On 09/11/2025 10:22, ZheNing Hu via GitGitGadget wrote:
>>>>> From: ZheNing Hu <adlternative@gmail.com>
>>>>>
>>>>>       This patch introduces the --committer option to git-commit, providing:
>>>>>        1. Consistency with the existing --author option
>>>>>        2. A more convenient alternative to environment variables
>>>>>        3. Better support for automated workflows and scripts
>>>>>        4. Improved user experience when managing multiple identities
>>>>
>>>> What's the use case for the same person committing under different
>>>> identities? We already have a config mechanism to set different identities
>>>> for different repositories but I'm struggling to see why someone would want
>>>> to create commits under multiple identities in a single repository. For
>>>> scripts it easy enough to set the relevant environment variables if a tool
>>>> wants to create commits under its own identity.
>>>
>>> Someone who works on the same project under both their personal and
>>> corporate identities.  For instance, me working on the Git project.
>>>
>>> Some open source projects also require a CLA and you have to use a
>>> particular address to match the one that's listed on the CLA.  For
>>> example, Google requires an address with a Google account, so in the
>>> hypothetical state where I was going to contribute to one of their
>>> projects, I'd need to use a different committer identity with my Gmail
>>> address.
>>>
>>> I've also kept business logs in Git when I had a small business and I
>>> might well need to log approving a profit distribution (with my
>>> corporate address) and log accepting a profit distribution (with my
>>> personal address).  Those would need separate digital signatures from my
>>> two different email addresses.
>>
>> Is a "--committer" option the best solution there, though? I'd think
>> you'd want to set user.* in the repo-level .git/config (or using a
>> dir-specific include) would be less error-prone.
>>
>> That doesn't help for using two identities for the same repo, but in my
>> experience it is easier to use two separate repositories for that to
>> match the organization of the work (even if you may sometimes fetch
>> between them).
>>
>> I'm not totally opposed to the new flag, and in general I'd defer to
>> people who say they find a new feature useful. I'm just having a hard
>> time imagining a scenario where it's the best option.

Yes, it strikes me as very inconvenient to have to specify "--committer" 
each time. I'd have though you'd either want to (i) set up an alias in 
which case you can start your alias with "-c user.name=..." or 
"!GIT_COMMITTER_NAME=...", or (ii) set GIT_COMMITTER_NAME in your shell.
> The reason why I find it useful is mostly scripted uses. Sure, you can
> already set environment variables there. But from my experience,
> environment variables tend to be a significantly worse API compared to
> command line options:
> 
>    - They are harder to discover in the manual page.

They're documented in the COMMIT INFORMATION section of the "git commit" 
man page, admittedly that comes after the options and examples but 
overriding the committer is a fairly niche requirement.

>    - You don't have any "guarantees" that Git actually interprets them,
>      as there won't be an error if you mistype the name.

Playing devil's advocate even if you use "--committer" you still need to 
check the result to make sure there were no typo's in the committer info 
just as you would if you were setting GIT_COMMITTER_NAME.

>    - Cause and effect may be detached with environment variables, but
>      with command line options that's never the case.
> 
> So I myself would prefer using "--committer" over its accompanying
> environment variable any point in time when I have a scripted use case
> for it.

I'm wary of cluttering the UI of one of our core porcelain command with 
options for use with scripting.

Thanks

Phillip
