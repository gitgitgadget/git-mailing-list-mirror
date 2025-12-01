Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2797B2550AF
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764592843; cv=none; b=GOWgSXNXtbiHtva4TgNmVWVCdKpgv602NaDU6JxNJ/d2Nt6LcakZN7EmrD1z7/kSK8I9Hhthin6WJofl9jXRTMpCoAG0sCEmzMCpKxfv/2DjGVVQWXNc17DxJQSS33WHD0UoNxPWd4XYKvVdhhT1hn6wSqDvHhs8AZJ6oDvmFhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764592843; c=relaxed/simple;
	bh=wB56hwlJEMjBAQcTHR3/a9TpNYdg+agp58SqcXjH+0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BO2bXvo7nN5ZAuy4uszWfpyJsYedoWrfgSDDBv5TRKfTz+UrNzf4wX42dq5uSAJF9/FvIu+iNkFcgeXmBhJhJ2b1m8+W6Vlz3ib9U38XB2+P3bX9wxDFkZVihmXN7r14c82xM2nM+FS0mfxG6xZ8TBfKAyH2qxpFvI4jVYE6Jug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSJRYGk2; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSJRYGk2"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b220ddc189so444120985a.0
        for <git@vger.kernel.org>; Mon, 01 Dec 2025 04:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764592841; x=1765197641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9C8xWLsuU3cEnYX0tmDNTJbsAvES5pQ9y259S34ZV94=;
        b=aSJRYGk2giqU2YMg14i5JtuwTMueroswJYCD9H+jbZ+11yUa53OLx9rHUty6LWFMJ7
         vG7xEYmJqf6X2+wlsJeS5lNvjVtY2cn43AuP94ReBBmOSM+CbeMMcQlPV4f2xSEYhQ5H
         Szk0Ic1GR+6TJN+GIlhGTFKsHQ+I+FlsJvj+lfoN1PrQFBQwGyrFi4qAV1iONFHs6vD/
         DQ6lzWBFb4Qf5o1bgzdu3u3VgQo/2iVe7e1dDi5rJfJ3mN7RRBMhwyZ5mon+93bV4hJQ
         SUydl3bg1clv9/xon83lsEUmlaK7MXtdyrpOcxO6zV/hqTZohkFYeWatQFvt8YQmEwIf
         Vk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764592841; x=1765197641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9C8xWLsuU3cEnYX0tmDNTJbsAvES5pQ9y259S34ZV94=;
        b=mZlBJk6T2sR1n9LPuQ7CdHHdHOxFi+0QfB6gSzY09nWZ9BCMjJvSjbFoXqIxJh8kYY
         f+b1UYP5s688RO6bXTJyv9+7xctIAkMfKx7L9PXnHDFjuOB2rfK01g6BS8C8PlB6PUww
         a63eyRK9R4XSkOO0KujRd1pHaSxdcF5Jv1bg8piyCMqKH3vVnx2IsOXoOYaaXVv7nDdK
         ioPZUigLXFXAUpfX/+ESd1MNh34mfJR9UqnIIN17GFD38LrgJaC+iEk4zpo8QPecZHus
         iE5UZ6RxUwzJguheN+KPrUHCs/XZORL1sPx2srLrVAfl952nyf2Dd+uTJzl7pQqEUfaH
         maBw==
X-Gm-Message-State: AOJu0YyU6uElJ5Nm5yAlumeC9O5IDFYQASDpPo6OseUccuGd4ff/8nfQ
	P+5yVQehoRHSL9EPD4CNUpcPTcxlIadYBi96Q3o1sMCjLobTO7pfLJ9P
X-Gm-Gg: ASbGncuwZ6Pj+8JiMVKRO4ufZWCu+AEPNstnsnl3qNkZTWQWve4MLam9d4LJ1Yhn3/1
	hKeMs4KTmdns99c1bURgbNu9zsxOHyB6rKwjy3+IWKsJ69j1Y9Y9XVEC3TswKwXNd7lAtvi1AC8
	0l5/Q37LoWyhqd17Ro4hBcW2y5fEY5z+8pk2MeKKpxJyMgZjbwKzjtSJznFJJ0mi/5LxvdrKytP
	wfiFbR3PI28BSwECH2ZRHecT0nXZERyY4furA84hMckekwRZcCPef8I7zQuhRSFQv9rBSuhRqwM
	TVHvgnG2/KX72bcSvGAnEpVhS5Do7/JSp53g0uz+qsvAnBBrmD60fbVdxn6mvsgtkKftxiIkIWC
	xaQ8Jkk57TL656NzyEx/tGmnE8xOxVMB/12J5pNsQx0k0k3fY5mzhXK4OtL6fRqhA5TqEKebBWh
	e3Du5MWa8/b54NWVMyQus6aBpqvEp4xi4YmdSFohTiqI+Q7nR0VMZH0A==
X-Google-Smtp-Source: AGHT+IGz1N6zhA5JFnIvV6Qixaqrfn+OPlYhJvLdiJ4Kuu72hgqvWOS89ds4G9ecq4E+g+rg7iuU0A==
X-Received: by 2002:a05:620a:4490:b0:8a3:1b83:fbf with SMTP id af79cd13be357-8b33d1f93a1mr4964413385a.21.1764592840912;
        Mon, 01 Dec 2025 04:40:40 -0800 (PST)
Received: from [192.168.1.253] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1c909asm843278285a.40.2025.12.01.04.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 04:40:40 -0800 (PST)
Message-ID: <e0745f6c-9de6-4c48-82ac-07db2d664a2a@gmail.com>
Date: Mon, 1 Dec 2025 07:40:39 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] scalar: document config settings
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, atthewhughes934@gmail.com,
 johannes.schindelin@gmx.de
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
 <18580f020d149eaa8271542d7e629ef10fd8c9a0.1764195516.git.gitgitgadget@gmail.com>
 <aS1YCAIrafQ2iEfz@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aS1YCAIrafQ2iEfz@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/25 3:55 AM, Patrick Steinhardt wrote:
> On Wed, Nov 26, 2025 at 10:18:36PM +0000, Derrick Stolee via GitGitGadget wrote:
>> diff --git a/Documentation/scalar.adoc b/Documentation/scalar.adoc
>> index f81b2832f8..b34af225e6 100644
>> --- a/Documentation/scalar.adoc
>> +++ b/Documentation/scalar.adoc
>> @@ -197,6 +197,164 @@ delete <enlistment>::
>>   	This subcommand lets you delete an existing Scalar enlistment from your
>>   	local file system, unregistering the repository.
>>   
>> +REQUIRED AND RECOMMENDED CONFIG
>> +-------------------------------
>> +
>> +As part of both `scalar clone` and `scalar register`, certain Git config
>> +values are set to optimize for large repositories or cross-platform support.
>> +These options are updated in new Git versions according to the best known
>> +advice for large repositories, and users can get the latest recommendations
>> +by running `scalar reconfigure [--all]`.
>> +
>> +This section lists justifications for the config values that are set in the
>> +latest version.
>> +
>> +am.keepCR=true::
>> +	This setting is important for cross-platform development across Windows
>> +	and non-Windows platforms and keeping carriage return (`\r`) characters
>> +	in certain workflows.
>> +
>> +commitGraph.changedPaths=true::
>> +	This setting helps the background maintenance steps that compute the
>> +	serialized commit-graph to also store changed-path Bloom filters. This
>> +	accelerates file history commands and allows users to automatically
>> +	benefit without running a foreground command.
> 
> Is this something we also want to promote to "default" eventually? The
> downside of course is that maintenance takes a bit longer, but given
> that it runs in the background anyway this shouldn't really impact our
> users all that much.

I'm not sure, as this is a significant cost to the computation time. It will
impact foreground commands, as well. It increases the size of the file, too.

It's worth considering, but I don't think the answer is very simple.

>> +commitGraph.generationVersion=1::
>> +	While the preferred version is 2 for performance reasons, existing users
>> +	that had version 1 by default will need special care in upgrading to
>> +	version 2. This is likely to change in the future as the upgrade story
>> +	is solidifies.
> 
> Is that still the case? We _did_ have some bugs in the upgrade path in
> the past, but I thought it got all sorted out by now?

This is very likely, but I haven't validated myself. I'd be interested to
double-check and update this setting in a later series. If we update to 2,
then this would be a good reason to overwrite the old config for a while.

> [snip]
>> +fetch.unpackLimit=1::
>> +	This setting prevents Git from unpacking packfiles into loose objects
>> +	as they are downloaded from the server. This feature was intended as a
>> +	way to prevent performance issues from too many packfiles, but Scalar
>> +	uses background maintenance to group packfiles and cover them with a
>> +	multi-pack-index, removing this issue.
> 
> The second sentence here reads as if "fetch.unpackLimit=1" was the
> feature you are talking about, which led to some puzzlement at first.
> But what you are talking about is the _default_ unpack limit of 100.
> Maybe something like this reads better?
> 
>      This setting prevents Git from unpacking packfiles into loose objects
>      as they are downloaded from the server. The default limit of 100
>      objects was intended as a way to prevent performance issues from too
>      many packfiles, but Scalar uses background maintenance to group
>      packfiles and cover them with a multi-pack-index, removing this
>      issue.

Good catch. Thanks!

-Stolee

