Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC93A254B1B
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759448214; cv=none; b=VvjbbXFKk+NCfJlewjsBISwct7xSAMgLykXYYnyAX0bN3oNouWMt4Bvx8Hd4E7S6WYOmCB8jaPbYJu62mkuVpprDt21BqinE1B9zz+Iq+YTAUrn2e8xQb+4AX/aEl6SkXEpKk0hXZqXwNP4m5I30uj3iUSNC7oSQAwsWH3LwwfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759448214; c=relaxed/simple;
	bh=CYTIM93zZQ7MzKrASHlomzMgCQ0WCXR7t4Gn7oW86nE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2RNJhhlgqP+QOdbl+uAWhV5Vts5MdvUf1YPHsyKlccD/u9xbjZ3q3X3V3KacHK3usCFp2m8jXZgZblcMdkcQ2J2FrDGnL6/fAnYJyqdi9Jg36ewUG3iOmq5WrSJn90ZR4UwObAb3/clpWJPqhh4oLOZJ07LEIeDT+0Db1dkEis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7wctO0J; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7wctO0J"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b54a588ad96so1109412a12.1
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 16:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759448212; x=1760053012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KwesJt2vCc5Q8AnDTck9rq3QrewNQDz/n/BVPTRB+E=;
        b=e7wctO0JTjhD08tIHMhKOpt0hAKgGgSzuf0LA/1nyPICgWmUj31NVNHZ7J9etV7oei
         +2O9IFtD3rM8wqti77TBN3U+wJvbkuKJcLFx/3tWGbmE1+nVixwBo44dzRTGHc2fexax
         8E87Lh/6OBecbpdgSXW5woigkUoKfMqhfAAee2vUUVuWOZBn1k8cl5dmGxs/6374wHVC
         dDKP6sLIJ11c6Bwla5Dwnechf6twBFRD8JgIc7X6f4ytCoYf0tXsBiPMghLrYvlzPK1c
         6VNtG11hbjj1/IsZHIZybnIdFkB78yWX9iogW4PXmilECk1kqxt6orBKybohYruZfGp3
         Wo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759448212; x=1760053012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/KwesJt2vCc5Q8AnDTck9rq3QrewNQDz/n/BVPTRB+E=;
        b=Ei7+M2ZpaG1K0ZOm6uwnmpi+TVxMGqfcu92XExOHjOyQsN1MnS36/0Gd+3oopapnZD
         Uz/+V/K9uOTPsCofnXDW4QQiY7NF32ehoUw6ySphoe+LkbOnQWFRQIqxtFhsJR1X8ubR
         DI3o+bagMCrMuV/2njKq3kTzzIWPwnBPhMrbkWBSHIEmOvwo0+KMa0Az0BtOHnBbNeA0
         6Whxv8DsFOQkl4BzFQ93kTJBabW1V22NegaWp5pgHMxURpNc3v2ofQfi9pdBeRsdJxTx
         j+N/Y8cF2QP2+WMoUjZOqAWGQrzst0652fJ91qP1wlwNVyGV2BESi8DofatElG8xU7bo
         7Ynw==
X-Forwarded-Encrypted: i=1; AJvYcCVX0ndIimKo83Ru41V5sCX7ZpfsMdIUTnADz3qnsVKLALcaB/oVErEQypkZPtDSzMIjqEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCzCXG77aziJMQn8QoxArqyaQF5yUhtrEqSPj4I62QnIfsgHBo
	qOYDjX8eHYEnMeIFlrdvf+6DEhGcqpN3tdbpz0knVe1zaP//fQOTkm62
X-Gm-Gg: ASbGncvNlJ2E40JPJwK/ntYHeY/3jH5L2Xqs088+qjld/Mphh4AAEmI44i2Dj1qiZ9L
	RIyE7LMzy0v+3PXiH5S0HXNGV/YnFgwku6UCbFhCdfsiMqeZshieiTBumlpAwK9jmfLncRCp8uo
	9zdrQO/uMFErQnA/iGPG1MBEREgvOmyxJJs7fWwDCP0yPRedlAZgF1YsQFqxKm/MmAU9gMqUuCz
	u5mDQ31U4rN2iZAJEHwX0fzxhzlKBLO8aiekaWueaohk3iAwMoE9W9kDiDUDHGj7N6hnYy0x/O6
	J7/UuE8CpFqQjiISVgbQjIR/RT73WOZ8/guHlJSOt4LHOJHm6PLGtiwmc4MP8FCfOMCTu8veshx
	SwP6dSpYMyWCUxFw0XXQnzRJORk47Kaiet5T3iE/qMgwxqD/uIWWIPJZ52ScjGwvrSprmdpxOId
	3H9KGiS3eLJh7doEuRIxLIRtsiAQLYlBngjJUnPPU58fYY+oas3eIpV4GUy+W3d9qruQMlEhmwg
	HNRFsti+wt/y7bdYeFX2i4jPYQxe5eOcw==
X-Google-Smtp-Source: AGHT+IEgeVgjd3jH1WBYx4ogeQc9VPXfDJlhZ/zGx33DPwwdkxWhsNyNcQfikgPDmGFpvDLyCppnWg==
X-Received: by 2002:a17:903:1aec:b0:267:c1ae:8f04 with SMTP id d9443c01a7336-28e99daba22mr9955395ad.20.1759448212016;
        Thu, 02 Oct 2025 16:36:52 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:b4ff:982c:6a19:d5f4:4acb? ([2406:7400:56:b4ff:982c:6a19:d5f4:4acb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d111b3dsm31990955ad.10.2025.10.02.16.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 16:36:51 -0700 (PDT)
Message-ID: <61107972-5755-49b9-a126-9442418ddff0@gmail.com>
Date: Fri, 3 Oct 2025 05:06:45 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] replay: make atomic ref updates the default
 behavior
Content-Language: en-GB
To: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>, Patrick Steinhardt
 <ps@pks.im>, Elijah Newren <newren@gmail.com>,
 Andrei Rybak <rybak.a.v@gmail.com>, Karthik Nayak <karthik.188@gmail.com>,
 Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>,
 John Cai <johncai86@gmail.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <f0abdc27-6850-4b9d-b4eb-a1c92f731142@app.fastmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <f0abdc27-6850-4b9d-b4eb-a1c92f731142@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 02/10/25 22:44, Kristoffer Haugsbakk wrote:
> On Sat, Sep 27, 2025, at 01:08, Siddharth Asthana wrote:
>> This is v2 of the git-replay atomic updates series.
>>
>> Based on the extensive community feedback from v1, I've completely redesigned
>> the approach. Instead of adding new --update-refs options, this version makes
>> atomic ref updates the default behavior of git replay.
>>
>> Why this change makes sense:
>> - git replay is explicitly marked as EXPERIMENTAL with behavior changes
>> expected
>> - The command is primarily used server-side where atomic transactions
>> are crucial
>> - Current pipeline approach (git replay | git update-ref --stdin)
>> creates
>>    coordination complexity and lacks atomic guarantees by default
>> - Patrick Steinhardt noted performance issues with individual ref
>> updates
>>    in reftable backend
>> - Elijah Newren and Junio Hamano endorsed making the better behavior
>> default
>>
>> [snip]
> On the topic of changing experimental commands: I really like the
> git-for-each-ref(1) (git-FER) output format design.  It just outputs refs and
> related data.  It’s not a command for “bulk delete refs” or “check for
> merge conflicts between these refs and upstream (git-merge-tree(1)”—it
> just supports all of that through `--format` and its atoms.
>
> And for this command it seems to, at the core, output a mapping from old
> to new commits.
>
> Now, I’ve thought that a “client-side”[1] in-memory rebase-like command
> would need to support outputting data for the `post-rewrite` hook.  And
> is that not straightforward if you can use `--format` with `from` and
> `to` atoms?  (I ask because I have never called hooks with git-hook(1).)
>
> I just think that (naively maybe) a `--format` command like git-FER with
> all the quoting modes might be a good fit for this command.  Then you
> can compose all the steps you need yourself:
>
> 1. Call the exact git-update-ref(1) `--batch`/`--stdin` or whatever mode
>     you need
> 2. Write a message to each reflog if you want
> 3. Call the `post-rewrite` hook
>
> † 1: c.f. server-side which I get the impression only wants to do cheap
>       rebases


Hi Kristoffer,

That's an interesting perspective on using --format for composability,
similar to git-for-each-ref's design.

The constraint right now is that git replay's output needs to work
directly with update-ref --stdin, which has a specific format. Adding
--format would let users customize the output, but then they'd need to
transform it to the update-ref format anyway for the most common case,
which seems like extra work.

Your point about post-rewrite hook support is well-taken though. As this
command evolves toward client-side interactive rebase (which was Elijah's
original design goal), we will definitely need hook integration. At that
point, a --format approach with atoms like %(old) and %(new) could make
sense for letting users extract the commit mapping in whatever form they
need for hooks or other tooling.

For this iteration I am focusing on the simpler atomic update case, but 
I will
keep the --format idea in mind for future work. Do you see a specific use
case right now where --format would help, or is this more about
future-proofing the design for when we add client-side features?

Thanks for the thoughtful feedback!

