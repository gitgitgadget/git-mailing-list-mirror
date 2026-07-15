Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D754433021
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108129; cv=none; b=Tev0Z7CrJx38kfk5xzJFlj3lKs3tV9gBvQoX1m1g2HtWmmZsLDXgXFRpEVXKg239B18pBRGn5kdsVWLNzkF9b8Zd9OHZm/dyUFTqhXg5iiySQu5dBqc3hEPde8bYv1NG+IP2FIfGqMu1dsYqQuUePntDCIzBDIFaCrRdm48CuwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108129; c=relaxed/simple;
	bh=Y7l4/oKDvV6hh/gh7L/GwrPUdwXu9aR9mdrhM0kI0Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCrmSFsPZ3hcbnvE1ncpFVG9btnuwhLm9ZiXrSl362gin4iDayPLwAijHtr2fBzNwRp2+LSrSYDE8v78sh4B1UFsdSe+qR+ZGlWlNGss8xJj0QVy9ZHLtvj7pcqdS+jeqfy640x2Yrs340e5QBa7ke91YlUelpR7LCG650K0mBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6GZLDqu; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6GZLDqu"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso7942677a12.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 02:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784108120; x=1784712920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TbFJCDUFdOPe/fc2Vy79EFmWA/L2+HUEpI3SgHHbqQE=;
        b=d6GZLDqu9HSfYePnfFgLL/XN8sU7QV8C9LmmFUjqeomNKRxRDk8D53ciE29hgEsjgh
         wEep3bCQkTiTNd8E4/ZQtXN4MyoRefw+43vFfuUDzT8Zn+b41s5qxqMTP07UwFgyQmoX
         XtTC5s01mfcKvsw1ZY7W6RJ+ngfRBNZW/zNO8KgOcqNNHACELsa7eu+WOco2d+eFtsOt
         qfwt6RIc9lzNLvCpummNBo0nO+9xXJljjWQAAUJXOEH6RjhQKbPKu4KF8c2nrjZNUbSi
         UtxOJijU5ZfWBINyAjcsC0zEcz2cCZ/oTSzESa9207v3R1hLzYZ6z0Vzu9MI0ht/YGlS
         k1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784108120; x=1784712920;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TbFJCDUFdOPe/fc2Vy79EFmWA/L2+HUEpI3SgHHbqQE=;
        b=jr+8liWJTdndJiGOra1H31STotlasxtImbCl5n5NBgVP6lmVgi8jDKv7kNGjP8BgSc
         Gk+WC/gsiWr4+M/7isBghSPIzsa2XgJELB54EHzZcXtKc1pQ4ytfO1kb/pNXkeORZHg6
         S/JJ/7/5bhTmxWA2WF/4W2XvQNmi1+3hPWqN6NadvO2Awlt8YTbw8vyoiIffG6HLHKd6
         kjlCTISCXAcGQTJjKVoTDKZ5iSFZ5RRtQB3MkRCVXQKhK97kdiNcLiItCz8QvKbzR19v
         LuPf+JMD4yfBv4kCeX0ZCVDT7AwTyhaBoVsYL8tNAL/xjOCIEtIi/nF5Js3JBiovNsbO
         v8iA==
X-Gm-Message-State: AOJu0Yzl/+4MKF6wdyvcDzV2cK1elN83eRVtkTcN+2sPShpSLK0+VcBk
	nC1sSKUCvw6wlO0iiOIPbN450Wq7YDhLtcc4RYzAGgCu0jywK40wLv9f
X-Gm-Gg: AfdE7clZiZFuXrl+rnn5s2L7Q8dYAYl6EpjeFzadXsBMRBXUCyXoLB0na/B1qythmzT
	lqKXrhJoHrxK1925vaNMxKu93qtbtUJkkDRC+nWkluH7z+epgz6Oe7kO0Z/ynpLueL/jO+OFz42
	JrMOFGCOv4N/7ISDYjBHnS1Uu6MpE757QPHiPICmlQQXpAlhJZ+6KXQB4wOr8O0voCjLl2qoIFQ
	S43sjxP2zN1XsZmUDP+QlFaqU6lhLYI+RZNdY7e0kQD8gI3/UVKCgfLMzwbUyDKusLEW3AidH9x
	8oYQSXzG+hBb7YcW8uN4DBEX7FOztV5Yy6xV3pPqvPbFRbMigRcLUi6wGWgpJLSNjJ81NwKKPVT
	Y/2ZOplMt5mBqax08uh4+vRi6ffCmyJZ2GuOZckRFV6zEW+HXoefX7i9KC4+gfNjP0N7cd3jnk2
	gm0lTPr+enyB7ZsetVVEqiIjxfzoZxJF1g/xsX7gC7/ENZ88R3jGXEzGlkEdJZgrxvo38=
X-Received: by 2002:a05:6402:c46:b0:698:3b7c:7e41 with SMTP id 4fb4d7f45d1cf-69cd6dcd540mr3304188a12.33.1784108120107;
        Wed, 15 Jul 2026 02:35:20 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd2936143sm2678586a12.25.2026.07.15.02.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 02:35:19 -0700 (PDT)
Message-ID: <58c488c1-139a-4b56-9f80-2492b081f659@gmail.com>
Date: Wed, 15 Jul 2026 10:35:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 03/10] sequencer: be more careful with external merge
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Junio C Hamano <gitster@pobox.com>,
 Farid Zakaria <farid.m.zakaria@gmail.com>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
 <cover.1783948637.git.phillip.wood@dunelm.org.uk>
 <3d79362332c1208eed1fb7f8b0d431ee92fe45c5.1783948637.git.phillip.wood@dunelm.org.uk>
 <alTvtOc39bLR4ocx@ugly.lan>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <alTvtOc39bLR4ocx@ugly.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Oswald

On 13/07/2026 15:01, Oswald Buddenhagen wrote:
> On Mon, Jul 13, 2026 at 02:17:20PM +0100, Phillip Wood wrote:
>> If an external merge strategy cannot merge (for example because it
>> would overwrite an untracked file) it exits with a non-zero exit
>> code other than 1. This should be treated differently to a merge
>>
> s/to/from/, i think?

Both are valid - the internet tells be "different to" is more common it 
British English, whereas "different from" is more common in American 
English. I guess for an international audience "from" would be the 
better choice.

>> with conflicts
> 
>> which is signalled by an exit code of 1
>>
> parenthesize, and add comma?
> 
>> because as
>> the merge failed
>>
> (maybe add comma? here it becomes muddy ...)
> 
>> we need to reschedule the last pick. The caller
>> expects us to return -1 in this case. Also reschedule without trying
>> to merge if the commit message cannot be written
>>
> add comma?
> 
>> as that prevents us
>> from successfully picking the commit.
> 
> i know that most commas (and parens (or em-dashes)) are optional in 
> english, but they _really_ help parsing complex sentences, because they 
> reduce the amount of "read-ahead" required.
> i'm stopping at this commit, but subsequent ones could also use the 
> treatment. i trust that you don't actually need detailed suggestions.

I've added a few more commas to later commits, but concrete suggestions 
are always welcome.

Thanks

Phillip

