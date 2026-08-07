Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37AC47DD56
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108121; cv=none; b=Hq/++Wl3hmVA5cDOu9lGXfPYi4naQclVDGSYb3JE+IrNa6W/zkmptBteSbI/r6hKKZcsUNgBp+YAoYPqtoGVmpFRePnC0WQVBDzwnBVv3OWfZHUrIFF2phbgV5buJV+3OSinC8U/knM/DiV2eBoqGZ3u1AiXeRBqfNKvA8TBV0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108121; c=relaxed/simple;
	bh=vc0DSwhg159kMU5U19VrsmcnwEIJsxjRPj31iVAQues=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/oLRUBPKaQZD91IKwB0TXx8DKkDAHatyJkJ49H255/0c9uJ+LXNGkjmWbB4fi9p17WjUSVWPKxKlGiX1SobD2V+RGske+GTNqDG60dVAWjm+rzxQhOGyt0yeoKrLPMCDeK+7iLqEhZDq1MDA5W0fASDGC89ecwLWWg8GWd+N3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CybT1+CM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CybT1+CM"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49557167508so30193175e9.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 06:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786108105; x=1786712905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uXQ+7BqCtwZUoi0plZeX7uwHez6nupbkwOTbkNkdv3U=;
        b=CybT1+CMw1Glkbcn87/WaTNteaPI26Vw6oe6vpiDKr78DHiYAVE3ohUyRspno1sQQ7
         0SCR2j3kMq/h8OMV2nr/oujAKU7zctJNX580wGqEyIPin8Q9HWZqf0A4qbypfx2q60TK
         NUM3kEL/5nqM7Bb51Wounv5lIeljoqa1CM/LJWSmVEhlnV10N2KDJWoJv/2UkW1E6ywa
         CE5F3HImXlhLfqFy2bs3AhexGVodb0rwbkaTsGdcs7rzQTYh7oO0huofwesYR3arJ31M
         xkvWAhDbm/58a2+nh6M2ZfRWuacq/iujTJvNNnqu9Pug+YfGOLtsJxXE4bYmvSpT/khM
         7WDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108105; x=1786712905;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uXQ+7BqCtwZUoi0plZeX7uwHez6nupbkwOTbkNkdv3U=;
        b=KJ4EnFMi8lYWadsCmYOYd2/eSqphpm645LnKGdvxfZYcRQKLisb955HFlkAZ6dBVpx
         N8wZJZEDjDk5oe4vYqskuWJXZZ+Hb/r04GEBaXPHjHxEUzdhGNyYmUfP4cWZFQHd3v+i
         5rHyECJfF7Jlyhy913UOaoAPcWcmdoLj672P3qFymUavRUqf2GP38Pox9bwN+/Pkqi9c
         n4OBCmfR3LE4zNb8S4sLDu+39Qx+N9PKYMT4lDxqXUc1eULXejlqeoxM9wn6A5A3Wz24
         IuXhPJmTBmB+EhqAEDQnk7nTRDGKXCcJMPmPgbByzdSxwH6VXIVMAmzlZolhzyDVSLI3
         OuwQ==
X-Gm-Message-State: AOJu0YwQF7OeZ8OTScMsQSiw6HqdjLxaWGKtkeWlfIrjTN++rfW/Urvz
	K5+YaLabdVsFIepG6D6aFYlKxY2eOyBl3SRYN57LJBIPhf6wchGuvonL
X-Gm-Gg: AR+sD10hQ15/rbb1D09hieWYKv1iyXZqBW85nKkGYQZY41AtKyObBDjFi2F4vk/YAiA
	74IHm6RH3DjpkB3fsdSa8f80b9hf25Oo7WF1oeUb7brigUBR/U0GEYWkoYv36uVlDG0YfiNqi48
	klHQCMsSkPUn6gIObE6yjGNz7yWEUjE5Lr9CABVNz/jZo9ma8WXloUDwnrD9OLYv6Qn9+pXaO3P
	mBP4FsT5KHZCxjMXTc6RwV1EvcQkau5LIsGP6T5yoNTDap7iSxHGKbHcW+uVPUkQfIgQ1fnSs+L
	MEqI7aUJ5tS7Ku+Mjc7CEeYI+RUZh2OMCCBrUI4by8rSjo9+AGnaXKpLM7Y3ELvGh+IzomB2GNc
	cNx97cj8321OSx3roopkpwH3yaOY61HkULwpkMJG4ZUsIWoNRsN/cdO6sF+/hYtnLpcbtSZt2ov
	okc3q+xq4Kc3KPuD1k7hdV2Mvb6An5drLxan785+5rgGltkWCrcZKE9C0xiSxri+Kf/doxf+q7b
	TqrKUu0F6yK8fk1z4v95N2jk5qdC/NAc/6kWteI65U=
X-Received: by 2002:a05:600c:620e:b0:495:6274:56c2 with SMTP id 5b1f17b1804b1-4994e70a6f5mr366911165e9.2.1786108104232;
        Fri, 07 Aug 2026 06:08:24 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499542851d6sm162852195e9.12.2026.08.07.06.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 06:08:23 -0700 (PDT)
Message-ID: <10103c22-af8f-4bf3-b4ab-a3e4ce0491d4@gmail.com>
Date: Fri, 7 Aug 2026 14:08:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Feature request] Separate explicit fetch mapping from default
 fetch selection
To: Junio C Hamano <gitster@pobox.com>,
 "Douglas Puchalski (dpuchals)" <dpuchals@cisco.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
References: <C47215A6-B86F-4AB2-B20D-54D048B9B2BA@cisco.com>
 <xmqqcxvuhcrg.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqcxvuhcrg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/08/2026 03:42, Junio C Hamano wrote:
> "Douglas Puchalski (dpuchals)" <dpuchals@cisco.com> writes:
> 
>> Git version: 2.55.0
>> Environment: macOS 26.6
>>
>> I configure a remote to fetch only a small default set of branches:
>>
>>      [remote "origin"]
>>          fetch = +refs/heads/main:refs/remotes/origin/main
>>          fetch = +refs/heads/team/*:refs/remotes/origin/team/*
>>
>> This prevents `git fetch origin` from fetching and updating a very large
>> number of remote branches.
>>
>> When I explicitly request another branch:
>>
>>      git fetch origin topic/example
>>
>> Git fetches the branch into FETCH_HEAD but does not create or update:
>>
>>      refs/remotes/origin/topic/example

That annoys me too. There is a similar problem with the push refspec if 
you want to use it to map the refname rather than specify a default set 
of branches to push.

> I haven't thought things through, but I suspect that what you want
> might be an opposite of explicitly listing what is tracked on
> remote.*.fetch configuration, but having remotes/origin/* hierarchy
> of refs as the source of the tracking information.
> 
> It was a long ago this was invented, and I haven't used it for
> almost forever, but shouldn't this
> 
>      $ git fetch \
>              --refmap="refs/heads/*:refs/remotes/origin/*" \
>              origin topic/example
> 
> do what you want to do?  If so, perhaps it would make a good
> starting point to make it easier to use (e.g., perhaps a
> configuration variable can specify the refmap to be used, or
> something).

So we'd have something like "remote.<remote>.fetchMap" and 
"remote.<remote>.pushMap" that mapped refnames, but did not affect what 
gets fetched or push by default? That sounds useful (I've not thought 
through the interaction with the existing settings though).

One of my other bugbears about the refspec config is that the first 
matching one wins, rather than the longest match so you have to edit the 
config file rather than use "git config" to add a refspec that matches a 
sepcific branch, otherwise the default "refs/heads/*:..." that's created 
when the remote is added is used instead because it comes first.

Thanks

Phillip

