Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020C93839B3
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874816; cv=none; b=dSPY9vJx5MWCtSH89dzvsN1YaSF1+QRWHiI3gnffGD35Qy0zhnx7V3nMx7DI4t5+sD0TzH+XxWLnWuVgoO6elIECeSJ1sq71+amkJY1EUSuAKusIPES9iE3KY+vxZG8IkitRMDQspV0oAEyWRsR5NGft52TLTsAW8NSeWelPqNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874816; c=relaxed/simple;
	bh=fxz0fUbOyrLysjPUQTPjDqPbzY0Y1Mx3mdYiNahXvYA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BQYA9wj2+v7ZJfY8E2naEOIf2/rpu3TbZ1npeCAB1o0AutAvQjn3VlAsvngusW2Xpa4Qh49dGmpxDkYv2ea6alvo8BM52e6/Uvsu24IAnVQy8PAql5+sDjsyABG+/x0X7HJ+YbcWaCnAIYyyoLAwvYHOOLwzcPU3sLLNoynVvkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+H+bU20; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+H+bU20"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso14315685e9.2
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 06:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781874813; x=1782479613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sk4STYx9NUz9Fh/iUMBtMuLsPZ+MCU8AVsrAgwoto8M=;
        b=B+H+bU201QDg75VbwEJ7YnB87bZkuFoo0RcQWMNRFvuwZKfG95pq4BTJiFXKJJZCdJ
         XJvo5vu+9BBpc8V+H8fgFX7Q83hSTF7lOgqQXKz8p7Z4lZQQIp/TXADzm6xjKScYGX5Z
         yzwmSj0rZC1tbSiLJKtUuR55Pjrcg6B8hsy//FQIfsH3x3lm4+RW1AYUOhSkbzil7hYo
         K4DNS3tppGhWkKlOoP185OIhw54uaj3nQ7+e1LeIvcd85YHgAZj1IX2oXTT3BYw8ZQZx
         yNCmcpimU6b1Uy7B94D64sFkCuMdryMyICfLuz95FjoDKlEBZKf8ZKG1/9PeO1a+uZlN
         8ASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781874813; x=1782479613;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sk4STYx9NUz9Fh/iUMBtMuLsPZ+MCU8AVsrAgwoto8M=;
        b=YNnLG7CG85D1GQIq4D+1OfDCEoABP1Cna9qdj1X0EgOkTkbuHNTdp3EPdnvuC8wlN9
         +vB1A4Ec5W/lTFSHry7JLEfRC0u8r1ejMSZmtWrXziZrrnKcvTl91AlbSRmONTW10tVC
         zQY55aWHU4RPk5cjhNBk4Uvd9FcovGNUHyxhKy/KP1tF6LWAGLt9vpaftoDwIkgFta9J
         up9dr06LkOtwSHl57FOuseeqDdtC0/tGqjl88b/c0kR7cFhedS41NGuhoNSyuXfMwTCw
         4oEXaTekzNITH553pawnb8YqgZ7xI1sWNqeftsHJvtUMtcdUOB5Cpzb2FmG0nc4eXRfo
         Dc+w==
X-Forwarded-Encrypted: i=1; AFNElJ8uYbYvhLeajNSJkf/B2MnZy1YKMV//wr5OT44xVdu4zb6Zi+kK+RNnPjBRlr1xv25i5cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQnbVOn41sI5By7oUI/wVYGTuMn9yJFZOQ3mWVUfF9MhcnIIBk
	jGUidgI1eVESfnNC3q3vAqnUFD3yHkdn8Fj0gP1Py2JDhMEuNuFYdb47
X-Gm-Gg: AfdE7clvmAz4K3hHySsvBPa0T8hGTjnLBr+Ssup0/Qos70lIYFOIWhJ92iiRQyF+YVV
	4VnuudOdeKwtRYtJjO6mTs/QZ7lnsxUStwomoUYi129eTXn9eP9rCsObGiW9H/0eoMoR5Tlbn9Q
	excCWJtCjuz+7NJPUCSesOAG1LkIcmqjGcpl9BhVok/WRNaCAcwildbuhjv8+wVdtjGeSZde1M1
	gWdFzQiRM9rmj8zrCl07/PdmF5yPLhnMt9wVZiyGbOTbDyYfhAxsft8AW8uRbh8uqikK0W7PdjF
	81B0aPIlQ19bJvYNZVhlcF/e80lAcxNGxpk50F/S4m7Svu+w5gavUwhbbKr3tu6z5Ai28XZjrDd
	Cyx2+/UYE5YJ4I8N4mc4o38gMWMPPCqKFVLxAONdqz6idWliZ9KIn+a01qGQhOgJUiB+11BhlW2
	3zKuG+spdb8so1GGyXjUqLF3weQMEUEBS/89drsWWufI/mrWW94NKOQzfLc2tJXwirRUJt23Xg0
	FdP7A==
X-Received: by 2002:a05:600c:1c1c:b0:490:b724:507d with SMTP id 5b1f17b1804b1-49240e40a01mr64641935e9.11.1781874813142;
        Fri, 19 Jun 2026 06:13:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240eef2basm63709105e9.2.2026.06.19.06.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 06:13:31 -0700 (PDT)
Message-ID: <42ffcb36-7fff-4948-9b8d-2c54eb626e66@gmail.com>
Date: Fri, 19 Jun 2026 14:13:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v14 4/6] branch: add --prune-merged <branch>
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
 <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
 <9924373da0a0598cabe4f08f3bc4200833679171.1780999917.git.gitgitgadget@gmail.com>
 <78b6dfdd-df61-4c44-96eb-b527cb26243c@gmail.com>
 <CAHwyqnUsjpCHfS=eBphmkdDGYpQZ_LQUJi1mjrxV8ZXi+w4yhg@mail.gmail.com>
 <37f2a483-c8bf-4c24-84de-c6233cc20b25@gmail.com> <xmqqcxxnsufl.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqcxxnsufl.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/06/2026 17:08, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> One thing I've just thought of related to this patch is whether we want
>> to protect branches that are the upstreams of branches that are not
>> slated for deletion. With stacked branches it is possible that a branch
>> has been merged but has other branches stacked on top of it that have
>> not been merged.
> 
> An interesting point.  We do have "this topic is built on the result
> of merging these other topics into main" and I expect the practice
> is wide spread.  These base topics may graduate first, but other
> topics may still be updated.
> 
> But when you rewrite these other topics, wouldn't you leave their
> bases untouched?  IOW, a new iteration (i.e. "rebase -i") would
> reuse the base that was used in an earlier iteration, i.e. the
> result of an earlier merge of the other topics, some of which might
> have been pruned since then, into an older 'main', so it is OK to
> lose these other topics once they have graduated, simply because you
> wouldn't be recreating the merge that you used as the base of this
> remaining topic, no?
> 
> Or am I missing something?

I was thinking that if I have feature1 with upstream origin/master and 
feature2 with upstream feautre1, then once feature1 is merged I'd still 
like "git log @{u}.." and "git rebase" without an explicit upstream to 
work when feature2 is checked out. If "git branch --prune-merged 
origin/master" deletes feautre1 then those commands stop working. Maybe 
it would be sensible to update feature2's upstream once feature1 is 
merged (which I think is what you're saying above) but do we really want 
to force the user to do that by deleting feature1?

Thanks

Phillip

