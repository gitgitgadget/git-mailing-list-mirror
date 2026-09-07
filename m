Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220144508F8
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775666; cv=none; b=q7U6qGUTnGVrphmsOTq6R5+bwu0dExf0MzGWfFlf57mYYjdwm69KypCOlWvWHvPurfHHh9/IHMM2iX9ylxA1vq0gmeIGBcL8R79vru1gMDhj2l1UShLvVYElXAih7hqOIsXkvJmu6qk2Kweu8klG7HuOeTPzerR53p5R01taDUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775666; c=relaxed/simple;
	bh=Lz4rgT6j+YFKkMlE2BxegdHbt7eY/LjLuW/ZOb2LeII=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=InaXtej74kjIntcsOTBcDGdmxKlsB8jFYyu2fWh9kAyqTBaTX1yIF0WyObr/V452EAQiJhTvnfAWbKqjhXLyHGAIYraIyH+wgYQ8jWZhJFu4Rqh65Aa98J2jS2YtvHcADXa+IDab/IZ63Ishl0N8WgmWJOkAvW6679YDvLfhyrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrRz14bq; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrRz14bq"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c1600d040e4so565810366b.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2026 03:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788775663; x=1789380463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4hBzzNGHNQx0ppP2u+EgiLTZ9IplZDQ8gm367lhqiik=;
        b=FrRz14bqmzxfI0KRCoCFnRzsedGMUkgngYPwT3BxM7A46BOS5GyqfoO6tZnjKn/BWr
         DEBZiDp8nS+GYZ8IXVicx3XP4gfz8kodotd2v2227qGY6JaV0iJgCpM93BxFu89CSE3B
         u5w3hJKscsUxhWNCohB02aik9oCFNx1biPE2JPplo1dvzxBtfbaMu19jTYeG8gllyVYz
         jCMd18BpkDja0xdw99fwTTvzFUUfv3vZ2ooV5yoCU0FsDH9thVbaa00ijkaF5h8XY+II
         o8xvLNM2a5e2lQgIdduD9qEzh2pWvHSptVKI4o0X6YJqp5SF+aqM5FlSbWQwWtemWgBJ
         UmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788775663; x=1789380463;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4hBzzNGHNQx0ppP2u+EgiLTZ9IplZDQ8gm367lhqiik=;
        b=gRzisz3lObbFJ/O5YQE5sYd7A+XZr/TYTN0K2hRjjMHLgZ538XP7rfDZkEkfwAC7Hs
         454n2gpn0ytFaXjNoxYsoQt93DAMN1724MbDF9oWhJ3SYNcslTqFyFFnVnlVUjZTkBwU
         e54P2W4Ulh1mmQ0mDJX8ic3/FjnSwuvE8wScgAfFt+Q8h76x8GwDNe4IWeR2HB4etkfl
         43zVKHcCnRQcm2bZO+RjeFuBYRgH0aX5VBIkwh+dCiSSYkRlsSLHvnRzO169DXE7kO5u
         1RYs7+OKivS400wEj/WBEihZUAg8b3QEQwoTQdYbl6+mSXhFiE1Aftm5B6BhDmeO4KPw
         VfgA==
X-Forwarded-Encrypted: i=1; AKwUvBxA3cz7HopOtamtfliOwinwmzj3kcZ4TcwFYVf+H9UXTkdhWGlE3UgEOzPYzgs3munxENA=@vger.kernel.org
X-Gm-Message-State: AFuF++m8X16FtXTQ6lFcvGozN7tbMbn8fafKTZbkK+kZWrZQU1HzImq7
	0+xReUG2R7w57I7Dc9qsrWJt3Zg+/oo0rMsXq7SSnujBlccp9abEtXLM
X-Gm-Gg: AYBFou1WbTv5DEvEBLAtREK1YAmqJPVpbFAzhbKzDUijOyW9M6e08GaDqq3Mhi45Ycj
	L/Zq/NmzgFNjYfTtQLLbQrdhZTv+RtHtIw4wP4yX3XHo0KMdfjhKPT48cJVqFWgQxvWE4alQUdO
	kbAG7O9d9S49Ee/YrD3jg8tJ8KcziHf/+IAzQ2QdeViypAr06JiRab2mwDg7VCWMNp9fxAJLjLl
	3o7qcCdq3HW8c9ZUapT47bfktbaW3EguQqzMyVZ2Jj+C65ymxWzsXiLy/LHPamoJwTXnkVrJQe8
	ZrEZdpIsNG5GABsFhXMqt7+9lMdZVXMj24GaktF+z2Z6xzfNz1OoxDK1PueK5XEjCRwTE47QOou
	N3umUYndfLVsMLAK3GDvl5PH8D3vfO4NHsjfnw+kY5+8jClXEAkEanzArFNdb2GN9rG4/TNLFR5
	eG30sgo4/dnkMcvmoXRTO1/ETxyZsUx9HaNNstWVjzfhkc2gm0xlWRfQgZO/CktAzZNk/lvbYkz
	NVTwLXRjRz4nUbQsDhPnRjeWhKgKgf7tSmhecvnk6fE
X-Received: by 2002:a17:906:4792:b0:c26:3341:b8f6 with SMTP id a640c23a62f3a-c263341bcddmr388698266b.31.1788775663076;
        Mon, 07 Sep 2026 03:07:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5bd68esm430447366b.57.2026.09.07.03.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 03:07:42 -0700 (PDT)
Message-ID: <595d0d45-7000-4c52-8430-f18ce8f99c71@gmail.com>
Date: Mon, 7 Sep 2026 11:07:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] rerere: keep a background gc from killing a rebase
To: Thomas Bachem <mail@thomasbachem.com>, phillip.wood@dunelm.org.uk
Cc: gitgitgadget@gmail.com, git@vger.kernel.org, ps@pks.im, gitster@pobox.com
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <pull.2214.v2.git.1788507876543.gitgitgadget@gmail.com>
 <5e613735-60e2-429d-a5bb-1a4f03578604@gmail.com>
 <CAA0xjtrkjaOC_+jhN=Vjm9e0T+iqAZeeMKx-ymVaQcLA37bm-w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAA0xjtrkjaOC_+jhN=Vjm9e0T+iqAZeeMKx-ymVaQcLA37bm-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas

On 04/09/2026 16:55, Thomas Bachem wrote:
> On 04/09/2026 16:21, Phillip Wood wrote:
>> With Patricks patches that's no-longer true I think. I think a better
>> motivation, as the cache is per-repository, rather than per-worktree, is
>> concurrent writers running in different worktrees.
> 
> MERGE_RR is per worktree, though, and so is its lock:
> 
>      $ git -C linked rev-parse --git-path MERGE_RR
>      /path/to/main/.git/worktrees/linked/MERGE_RR
> 
> so writers in different worktrees never meet on it. What they share is
> rr-cache, which a gc in one worktree prunes under its own worktree's
> lock only. That is a gap of its own, and not one this patch closes.

Oh, I didn't realize the lock was per-worktree. So the lock "rerere gc" 
takes does not actually stop another process running in a different 
worktree from altering the rerere cache.

> What remains after Patrick's series is any "git rerere gc" that runs
> while a command records a conflict, from "git gc", from a maintenance
> run, or from auto maintenance once enough entries are stale. The v3
> message says it that way.
> 
>> Overall, this commit message is rather long and it would be helpful if
>> you could distill it to remove unnecessary and unrelated details.
> 
> Done, it is a quarter of the size now.
> 
>> Why do those commands fail rather than wait?
> 
> They wait like everything else, and once the time is up they fail
> instead of going on without rerere, which is all they are for. That
> way a stale lock gets the usual advice to remove it. The config text
> said otherwise, fixed.

That's good, I think I'd maybe misunderstood what the original patch was 
trying to say.

>> It might be worth adding a check above here that BUG()s out if the
>> caller passes an incompatible set of flags.
> 
> Added, for RERERE_NOWAIT with RERERE_LOCK_OR_DIE and for
> RERERE_READONLY with either.
> 
>> A background job that the user did not explicitly start printing to the
>> terminal is rather confusing as it is likely to get mixed in with the
>> output of whatever is running in the foreground.
> 
> The detached maintenance run has no terminal: daemonize() closes the
> standard descriptors and reopens them on /dev/null, so the gc's
> warning goes nowhere when it loses the lock. Where it cannot detach,
> on Windows, it runs in the foreground of the commit that started it
> and there is no race to lose. The warning the user does see is the
> foreground command's own, when it gives up waiting.

Thanks for clarifying that

Phillip

> 
> Thanks,
> Thomas

