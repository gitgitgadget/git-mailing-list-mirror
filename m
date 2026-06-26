Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1903F86EF
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484521; cv=none; b=a+wQIpZantUwpvrvV7P/61+Kc6WEbprE2qVEGB3ZvM8niAJ0gaWpSUIye1Zevsua5YkUR0WhhI7xPTfBL6xxKrhGgPOTYGuN0KtlOOkmIpF/W6W5b2AXQCHMrFHg/XswZPDCwSpehNhB5EBiIEuFJmLp4Qg6lgaeavmQmKQXnus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484521; c=relaxed/simple;
	bh=ZXz5CXJMBBWeaCi8FaZyI4icqcjOaJY9sMyl6rZm+Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUcdsbn2kfJ4CyZ29mxEAINwly5yEHmqWITXKwRHhZdejFC6fVdCvqnOAGnfdVVAYR+xn+LvTCvscj/eIHb8ehgXdPUaOdg8QYXrJ5TiYjSm3TgyXGBztVg3CUI0mnVCSNbS1o+oa1vl5IycJ+og4Tf/HdAPJ0A8IO0cjb1SfLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdkAWyOW; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdkAWyOW"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8de4dd10a61so8800636d6.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 07:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782484519; x=1783089319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJmTw8Uxd8NFWE4MgaefqdPrUXlF686lXvEkwh7PCqI=;
        b=BdkAWyOWmod8bP78r9R+mUx3LGaxrkBuZ3CAW0m5J+nUaTTaC+Zz/GqnqL0v0dXo77
         bkIUNEQV0YAH44umIM83g5NKopyinFyDecvuFynGAw7/Rbeg1DX8VNBXoQyYFIntck7E
         VvV3JGRIfLZqR0QBnhlXNJcj7nv/iqgACfQxLsbjjUZWM4bVBbLrx4VhTXZa4SP62THm
         AHOO4Dlxa3zZjdaN+0aDjo/ra6f4UQ4c/5bjRimPYR0pajwJeVxpDCQtU7XPrvNPOodx
         3/RRL+unwu1FA02xIm5UjmCmnFXByJCEIB7JJCx4Ac24iR659RT5Z1mX9NOWp17LrJis
         cTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782484519; x=1783089319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJmTw8Uxd8NFWE4MgaefqdPrUXlF686lXvEkwh7PCqI=;
        b=hyUCe4i/TeigF4LZz4GFVJywZpzFu2TAbjRlk9EacJVDYebr9ORVSLSiCXntQncfNi
         42zLk61VkRS5YihlXTOKtiriIKW5qdf0EiQTMFgBK5VnmcllQhfNn8cPKa1y+Q7G8wo9
         B/AFU012CeiakiGnGmesOxIu2TB6Jl2N6WD3PhMGp4L0U1NFfpuZ1L9iqlhTQMVr83tF
         8lO3afI+Ubi0tLVdqXSIQF6FIANkgejzVtRCpDCQahfXeYECOB4bXcaW/C4hqzIrHJyz
         Mf3WwctBknzbs06SSTkpMo4XOuJYTRFyn9R57pmGXs2oqP5dOV0Il/YIvGUmiDhPS2ql
         yLEg==
X-Forwarded-Encrypted: i=1; AHgh+RqfT3qNhY/IkHQjS8gRQX/e0vyNsq1HPdFVwUlMgClVItc6qSKHRpxm2uK6eCIqkn0NUms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFxjMwR+zps40cCwt4mqYSnaG7r5nWjsoiadLxDvqLmCsLtcmt
	PVrd+4ZkBNcyZ1ditbb9ovDQU5sGKjzODQqCFE8Bslh2LXGzZNUtWXhNGQ76yWK3
X-Gm-Gg: AfdE7cliVu7rL/1b9bhgB/onn9O8bzuLQDR9OgIvyuFBG69ewSuUYfXWNQfakVtOb9g
	DPalbov/F9RiB3LUjVhGG9aOSNpogNWwfWR0LBgGgQ8fNkLFvgbgxBcIOUhW0GosSJVkQ6qxMdz
	NUIfT+P2Wx7WAI0Ob78foW0R7PNmbm6uTuLSO4OHbXBoI+YLVQR/oeMnYEYLu+MIjV6TFS8PmBd
	HiyL6kG5oH4XTMH11cQkFO3ujSWzL/hbnrN+mFgWEFMuicujmErBRyozHx8xcti8b4xGq648kvV
	Rzlp4jgofbw3HbwqnKLTcmJ6PQRo98n/yZ6OT3m9I9blR7iUvjicYvupfJuGoWR17Yv9RFLGpNh
	/pNTWm7Ah4Y7QhSP1saSaKlinpITs3c/RiSAM7s/H6snfJecast4zvyxzNwJH6fHWBQSD/fz8/m
	60Hvf7h2iUBuyTcBkWEc3jW4AmFTl70J3IyquZTG69fAAeDrEUDggxC6m77Q==
X-Received: by 2002:a05:6214:130d:b0:8dd:fde8:68c7 with SMTP id 6a1803df08f44-8e6d4cf4deamr120357796d6.30.1782484519181;
        Fri, 26 Jun 2026 07:35:19 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8e8ce95b5c0sm12338936d6.39.2026.06.26.07.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 07:35:18 -0700 (PDT)
Message-ID: <5edd5912-80b2-4372-b921-52c20e496276@gmail.com>
Date: Fri, 26 Jun 2026 10:35:17 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] commit-reach: terminate merge-base walk when one
 paint side is exhausted
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Kristofer Karlsson <krka@spotify.com>
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
 <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
 <f3572a8a89c74fad54a9e53be6f0e34daa2d50c2.1782479286.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <f3572a8a89c74fad54a9e53be6f0e34daa2d50c2.1782479286.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/2026 9:08 AM, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>

> @@ -140,9 +144,16 @@ static struct commit *paint_queue_get(struct paint_state *state)
>  
>  	commit->object.flags &= ~ENQUEUED;
>  
> -	if (!state->p1_count && !state->p2_count &&
> -	    !state->pending_merge_bases)
> -		return NULL;
> +	if (!state->pending_merge_bases) {
> +		/* only stale entries remain */
> +		if (!state->p1_count && !state->p2_count)
> +			return NULL;
> +
> +		/* one side is exhausted */
> +		if ((!state->p1_count || !state->p2_count) &&
> +		    commit_graph_generation(commit) < GENERATION_NUMBER_INFINITY)
> +			return NULL;
> +	}

This continues to look correct.  
>  	paint_count_update(state, commit->object.flags, -1);
>  	return commit;
> @@ -188,7 +199,7 @@ static int paint_down_to_common(struct repository *r,
>  		timestamp_t generation = commit_graph_generation(commit);
>  		steps++;
>  
> -		if (min_generation && generation > last_gen)
> +		if (generation > last_gen)
>  			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
>  			    generation, last_gen,
>  			    oid_to_hex(&commit->object.oid));

You mention in your own reply that this is broken. This also looks
like a stray change for this patch, so perhaps your end state is
correct despite this patch causing failures. Will inspect soon.

> -	test_paint_down_steps 45 2 25 3
> +	test_paint_down_steps 45 1 25 1
...> -	test_paint_down_steps 81 80 81 81
> +	test_paint_down_steps 81 9 57 10
These diffs are satisfying.

Thanks,
-Stolee

