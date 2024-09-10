Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1124817A5AA
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993110; cv=none; b=GeQz1NKM4qnzTwwwerfRKwzBGbm9SZCSSQmHyYTVYTpbu8s70F07sPlWRD9iYvSaL27yBKx0g2Lrp2s8/B7bCPs6ChiHMZal5M+9bRbhZdpoLwFWQKgR5rzLO+LS2p2i0nCjIlgTFuTPyr3JU8SrAE7j6q3bQcNvgqoD6c7AbC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993110; c=relaxed/simple;
	bh=QnPfofxrRMcokNg4lcgEU6/ZbeUrzx7kyEg6bdJiVUQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=a0yAr7rLWmSFYMO4vIIwrr4GGmHAJir7Gy2DhgfMdljhTNE5jk8gBgJcmmmU7J488gyZE2vg50pv6H6lpbjL0J8lQWM9l2dcyqk5Mk67Ylfvjaywv9WJO7Tpgizz5SR7kywCMy8c5tbnz8/PjAbengiagp2sBqb/qBxW2R5Bb4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ybf8+aQ0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ybf8+aQ0"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb806623eso10452655e9.2
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 11:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725993107; x=1726597907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7LGBYgYF9oFnJuyLUbwrCWeDkIbD+B7P3FEw2AXNAhA=;
        b=Ybf8+aQ0tPt/u3LwEiQ70qrhDmhaJhKyjL+/kWuwMfy2BvZLkq7bvCtqDlBcdUaWCI
         fKz1aLJQhf+J2YRkkKQFmNoGiQ67F/I/SxqWIoITHFuyLmtcOqMtht6jUsu7rLQsyPoc
         d6x5x1Swyq4FPWDcq09UzJReTG2Sbfl6uOafr74i8fhzDdFVOZFHCUCwPjb8V85VzuFd
         JWTHKcs1SP7a+ddlat7JVJziyxSDno1lQMgMx5yw4kn7fuFyUTt4XL7mnSY9X41rDK1o
         nz3wcfUJja/8wb6EukpPcjah9chmrsog/n/FzrmQkV+Poae/yo5GuaCefn5J0SJ0MZWN
         2vOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725993107; x=1726597907;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7LGBYgYF9oFnJuyLUbwrCWeDkIbD+B7P3FEw2AXNAhA=;
        b=Jtu5Ncy9lF6y9nLZY8W3QeyWeDzLSL42hyUQ+qbJIAyH9mRuN4M/5P0pYXtILIlFxF
         4N55YNQLROfX3APwFm2HyOKkJ+7I3221JzPsFoqNlEGlER2x/iAfXaUkYzUSkk1Zg/oZ
         wNnZec/PXFgo+LrkysIzcCjCkyo1xK3vjPOKyWBsHCfFv30bNffhgYAxAUDBtsiuePj5
         llFgzT6EF1F3KVycU1xjrwSE+oqDDAGFq7SXqF0t9aOztcpYqEPrMLsN6lR9C7p3XCfY
         QtQDSnga2LXmgziJ9HH9/9spo/JC4NOFm3kHWxvmhL3Qa75iitD4HI9XXOvBRPLxyN3D
         3cEQ==
X-Gm-Message-State: AOJu0Yx6PK9RM4fpfN46S6eyHoN6IHEVWoQ33eoxjwqoVSAdjoRMCQre
	bO2F4LvPg++xWqru6HoMBIuy/E1GmaFinXb1eNPB7iRbdvuTfmaUboOFAA==
X-Google-Smtp-Source: AGHT+IGgjFlHd7QcaDoFZbUGa+gQ9qFDiGhclH/02wtjoeBkqKx4cgcH+bCdkcO8ED4PuVaYLQQDFg==
X-Received: by 2002:adf:e686:0:b0:374:bd03:ab7c with SMTP id ffacd0b85a97d-378b07cb4f3mr300527f8f.33.1725993106388;
        Tue, 10 Sep 2024 11:31:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956e8674sm9697375f8f.115.2024.09.10.11.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 11:31:45 -0700 (PDT)
Message-ID: <ecf84ea5-2f4a-4a80-b7d4-0198f2fd6ee8@gmail.com>
Date: Tue, 10 Sep 2024 19:31:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [ANNOUNCE] Outreachy mentor sign-up deadline is Wednesday
 September 11th at 4pm UTC
To: Patrick Steinhardt <ps@pks.im>,
 Christian Couder <christian.couder@gmail.com>
Cc: git <git@vger.kernel.org>, Git at SFC <git@sfconservancy.org>,
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Tilda Udufo - Outreachy Organizer <organizers@outreachy.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <CAP8UFD10B4ROEjvP7MPygALuUFgyBQqZVhAjgSUris3cdiowsQ@mail.gmail.com>
 <Zt6pbMP3Rpjy-pC_@pks.im> <Zt6rC7TtUvxWGXN-@pks.im>
Content-Language: en-US
In-Reply-To: <Zt6rC7TtUvxWGXN-@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/09/2024 09:00, Patrick Steinhardt wrote:
> On Mon, Sep 09, 2024 at 09:53:20AM +0200, Patrick Steinhardt wrote:
>> Thanks for organizing this! With the clar unit testing framework having
>> landed I think it would be a nice project for Outreachy to convert (a
>> subset of) our unit tests to that new framework.
>>
>> There is still a bunch of work that I'm in the process of upstreaming
>> [1][2][3][4] as well as a refactoring of the macros to make them
>> typesafe that I'm currently preparing. But none of these changes should
>> impact how the clar is used, so I would say that it is fine to queue up
>> such a project.
>>
>> Patrick
>>
>> [1]: https://github.com/clar-test/clar/pull/99 (MinGW and HPE support, merged)
>> [2]: https://github.com/clar-test/clar/pull/100 (CI support for Windows)
>> [3]: https://github.com/clar-test/clar/pull/101 (out-of-memory handling)
>> [4]: https://github.com/clar-test/clar/pull/102 (selftests)
> 
> I forgot to say: I'd be happy to mentor or co-mentor such a project.
I'd be happy to co-mentor a project like that

Best Wishes

Phillip
