Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D12D17E919
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727277662; cv=none; b=JstO/tNI20zyQCmWpfqqAk8uepM0jn37qn57OVW9uWbO8ag6jsHKtrs6GTdK23JlSCJc3KtEOt8WATJRFKvHoqscpW3Zm09TlSEMOJUQ+WaSjAodRY8WiS6TLouP+yGAblL8fZjjxXJDsMzUSJWGFbxi6rK+4BiIETb99vpckF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727277662; c=relaxed/simple;
	bh=QrQkkwX/9p4k90JQi+4xBa2e6AC87oUdQlr7u6vs9NQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SneoTJ/bonJtWtpQXeU7RsFCbFfqvsxgyG32QmxEMDPD8QEVSaGDMR/enQD4+v8T+Uudzt8W9JgpwY0KKzoo6WvYfxoDqRYYYuXnF6cUbiReqPcLb9cTKRNYT2GKiUq11cM+EAEjC34hH9x+tfBhRb1LuWTcWLLYWBZJkjFWFbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpxOT9Vj; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpxOT9Vj"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c71f1396e4so1973598a12.0
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727277658; x=1727882458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e+IzGhG9nY9+ITHTR+ob04W4WStBmN8y6XPH6wwukMU=;
        b=OpxOT9VjorwBRyfF8+5onUzj8PP2NIVazk1JbfCHbcqc1kj2QFeQaMYKxNlxfKlRc5
         y2GM9atVeujAykFSaUQb6p0xXmDalc3Tw2oW7MKA7OqkryJnydsLLxaY7gYgyCjb8DHw
         QRp0EQDtZcOM4enR8G/Xq8mVJD06htgZDqznOWf2onwuIDL8lxmBlMzByimEAkSvAV5O
         fFDYsUFC3OirE/zFzolU+cUK7sPo+WkIOnb+FCA3xAeJhr0raApSE4CJuQ/h2oi5QdKO
         UiPuIQ1DNSZzd/RJIJEqmUi4D6JOxGH88l9aZkMabe4fQTNGCtA61aasWtT3R1QjbgWj
         xyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727277658; x=1727882458;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+IzGhG9nY9+ITHTR+ob04W4WStBmN8y6XPH6wwukMU=;
        b=YZYdpukzZn/S7F84XvSJj0FPEO92NJ/YCpWrXfQjjNcP0gk61gS7WPm332DsEe49Pi
         9nPWdHPqBfK16Fd4WdOV98DWw9bnddUoDr00W6qnmPaSjLgOUgL3nDqA1TN17pU0hUU4
         1HvYp6b0lL/6cjTse3lKJ0jxz9OO5N7g70lFFjGKg9MiN4paLdO6XRzU/g//VmpcoULl
         2ECSdBL3i/KaHRs9smxvMAkvrY+pfLMWsfay1yjD1+jNwJTST4p0dQX2r8eVVdgP0qWJ
         HhiGvnWY21/oyiEUyZP2KnshAxhy+6W+l9MSMm8STMD91PsJW577qUEHyc51lPPJFGHo
         QX2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJEDbYhPlnLoPJCw6P7Lh1aKoettFiAU5f6Ur2oPDSj+/mfn5hejRoiTv/HKcj1nvFD64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvHkAeC0DeC9b9xQKqFpBdfnIWBVojhwqmR3a3hlZGm5Btin2s
	jkT9A3b8UuXiL12XM0R56wpNJ7ySGFNz+SsCnNnCneTCwUNps2M5
X-Google-Smtp-Source: AGHT+IFZojo6WT7x/G0s0SNiQy9JjU5RzGQF0OD6t7mYb6nw+lB3MMo52tZgI3zEaErFVb7P6fpgXw==
X-Received: by 2002:a05:6402:274f:b0:5c4:4fcb:92fc with SMTP id 4fb4d7f45d1cf-5c7206438f0mr2451795a12.24.1727277658194;
        Wed, 25 Sep 2024 08:20:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4973c5sm1977403a12.35.2024.09.25.08.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 08:20:57 -0700 (PDT)
Message-ID: <a5e3322d-4e63-4b8c-84af-6578fe257cad@gmail.com>
Date: Wed, 25 Sep 2024 16:20:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] repack: pack everything into promisor packfile in
 partial repos
To: Han Young <hanyang.tony@bytedance.com>, git@vger.kernel.org
Cc: calvinwan@google.com, jonathantanmy@google.com, sokcevic@google.com,
 gitster@pobox.com
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
 <20240925072021.77078-1-hanyang.tony@bytedance.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20240925072021.77078-1-hanyang.tony@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Han

On 25/09/2024 08:20, Han Young wrote:
> As suggested by Jonathan[1], there are number of ways to fix this issue.
> We have already explored some of them in this thread, and so far none of them
> is satisfiable. Calvin and I tried to address the problem from fetch-pack side
> and rev-list side. But the fix either consumes too much CPU power or results
> in inefficient bandwidth use.

I was wondering if it would be possible to cache the tip commits in 
promisor packs when repacking so that a subsequent repack only has to 
walk the commits added since the last repack when it is trying to figure 
out if a local object should be moved into a promisor pack.

> So let's attack the problem from repack side. The goal is to prevent repack
> from discarding local objects, previously it is done by carefully
> separating promisor objects and normal objects in rev-list.
> The implementation is flawed and no solution have been found so far.
> Instead, we can get ride of rev-list and just pack everything into promisor
> files. This way, no objects would be lost.
> 
> By using 'repack everything', repacking requires less work and we are not
> using more bandwidth. The only downside is normal objects packing does not
> benefiting from the history and path based delta calculation.

I've just been looking at Documentation/technical/partial-clone.txt and 
I think there are a couple of other implications of this change

 > An object may be missing due to a partial clone or fetch, or missing
 > due to repository corruption.  To differentiate these cases, the
 > local repository specially indicates such filtered packfiles
 > obtained from promisor remotes as "promisor packfiles".

Packing local objects into promisor packfiles means that it is no longer 
possible to detect if an object is missing due to repository corruption 
or because we need to fetch it from a promisor remote.

 > `repack` in GC has been updated to not touch promisor packfiles at
 > all, and to only repack other objects.

Packing local objects into promisor packfiles means that GC will 
no-longer remove unreachable local objects.

It would be helpful if the cover letter or commit messages discussed the 
tradeoffs of these changes and updated that document accordingly.

Best Wishes

Phillip

> Majority of
> objects in a partial repo is promisor objects, so the impact of worse normal
> objects repacking is negligible.
> 
> [1] https://lore.kernel.org/git/20240813004508.2768102-1-jonathantanmy@google.com/
> 
> Han Young (2):
>    repack: pack everything into promisor packfile in partial repos
>    t0410: adapt tests to repack changes
> 
>   builtin/repack.c         | 258 ++++++++++++++++++++++-----------------
>   t/t0410-partial-clone.sh |  68 +----------
>   2 files changed, 145 insertions(+), 181 deletions(-)
> 
