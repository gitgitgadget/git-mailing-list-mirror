Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701553B637E
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484978; cv=none; b=NpD0Vg5m67RPcLC0WKV+wNbg54Ew8is4NSdjGXVKE+DWCdWAsY9tYjipgFBALsABIZNpjQB2fZ1SW42zO9dl37Dm4FsKZHnzyKX3YBbplqbr8IDMXKmXHQPI6X57T8vh/2XL+LqEVfrTLBnbqlbkCYdigxQwUMzqIShMqIx5Q4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484978; c=relaxed/simple;
	bh=xq384b0++qBlmkbnav+p8o9o1EmIcfuFUZBbenLneP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S31oSAIEjCm+MOuDDAwryOcRiDIWWorllGFW3pFHPjdrr6xzFHS/uL2TijJ3oVoyhaoj+edFDNkOoUjj40L4SwMLsCR9dbSGRODRwSoipx8U8TO3E3xK2NFx0YwuYuVA87+rlbYNUlkBUOdSabw7/TBEOMmkoowYdEwjrbYep10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rhr8YHj8; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rhr8YHj8"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51a86916326so2824161cf.2
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782484976; x=1783089776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jyP2EC43N5Qw+jziqtZjxq/oRJRsQ0FxwOaqQ/pc5fg=;
        b=Rhr8YHj8b4WKi+b6M4LblSaKVhkMTw7lW0V1leVYCpzF1i+51vdpaAHrJA5EDKIJoQ
         8eKCN+4yk5dSnMNlpQit5ThQIIjI6/tuBqpwipqJX6idj/sUieh6mSuSuB8/ChoA5OLr
         P4vBaDBuJsBAEHoIJCqoMWj1+SBjslgO7Oq6/9Ld+XT++aeybvYnnbQajP0CF8wr6u66
         GQlZg3AzAGkdb0AC/koDcZQVtPyHiq+ffpVo+haq5+eOd0XApcrrZnOIvzQZQRCmBNBB
         Xj2A1DJMWLJvxaBjaE6n8BEU72cJ+7IWj1faktQO6SIjI9sAXNZwefLmmEGApnKdaiS5
         p/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782484976; x=1783089776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jyP2EC43N5Qw+jziqtZjxq/oRJRsQ0FxwOaqQ/pc5fg=;
        b=omIEFjLvpDYsoVk8nQDAPys/81fVM94MbsQwQ7tq/5VnBgVzjOxheMa9chgdVS8SA6
         iRoaYQOP1wxCEjKtpYi7My32rDlTPiy0QMKHztPJU96Sgwi/tHthm3IaqHYtJCEdkAGs
         hnR65BqdzLmu/I1Vef0nNjMFmjP3xTGcg8ZxON+NVwhFMMYwfwGMHfKEnIJyyuM1mBXL
         PRgd2z6ASsw31gFP55xQY3dIrvcX0a8thp+/7TgKeFeCu5QSZ74uxxEYBlGDgFSu3jcS
         7ZUNgDpTs+JsghmBrt9TUhPSjPG9LHOcweKFZ+N9FCC/deWOXis/N3Bt5IUfRBuNoq00
         /2VA==
X-Forwarded-Encrypted: i=1; AFNElJ8ym1PCK6QJDqb1az3sjfut1W5a+60O+l007YZl/9MENUPUsKnnzfXa/qxpdbQ/efAbiIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGzfeBgomLrKCWX1VmHjPxvOqZeV92ols6v7UgJaj2gyuo2016
	0LY4AOKLxwD6TbdBZtlCQv/IemwPp+f2FwQAqJ66cDpaPrJ4+cxZtyxw
X-Gm-Gg: AfdE7clPXko8bS6CKD1xkDEHkuaeR0ZZrhw1+FGXkgfpaCI6V7kR03HhqEE08EDY1rQ
	hWEblpKqTkpb8bhYHNPNgU/ZiWKVl5Ql3dkBKq7x1YAmsjVwB/NR7ckds1BvbF6UJ71dr5rO+Rj
	n1Fl10rgZwp2Se7yrz527LTLh26WzPl8v5VCG9H12agNXNaO2UfKkKVuNrxvqm6uYvYzpDf+kjc
	prwVLnjwvCc2vDCCyvgw6KrCZUA4rv2AVbIHEItyZ6O9RVQWZD9EgOl6S3T+EWM9UTeprHO/MzB
	AA0mwNGpA76KJNGxMgpf5IIR0O5sagKTusSp8Yf4SNfIGU2rXIr1JiUAQO8AUVy3TuHdIuepQW5
	ufRbLQ/h1xsKkTuSQ/LnX5Z78SShXCf45Jq1v7gHAFvmtgnR8rIm/F7rbOmlBT0JowfgOmKRGLX
	cxPmLqfBRBJtX+0/IA5irrUwqek2LO+ajHMVFHK/mG4HdiWTV1TfLTzJRNvQ==
X-Received: by 2002:a05:622a:4291:b0:517:6435:c4ce with SMTP id d75a77b69052e-51a72822e58mr100044271cf.49.1782484976191;
        Fri, 26 Jun 2026 07:42:56 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df82c6459bsm214308266d6.46.2026.06.26.07.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 07:42:55 -0700 (PDT)
Message-ID: <34ff8be2-1b3c-480f-ae27-9d65875e6e62@gmail.com>
Date: Fri, 26 Jun 2026 10:42:55 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] commit-reach: move min_generation check into
 paint_queue_get()
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Kristofer Karlsson <krka@spotify.com>
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
 <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
 <4b9f192d98b8e8f2d30eed4261a73e766eeafcc2.1782479286.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <4b9f192d98b8e8f2d30eed4261a73e766eeafcc2.1782479286.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/2026 9:08 AM, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> Consolidate the min_generation termination condition into
> paint_queue_get(), alongside the existing stale-entry and
> side-exhaustion checks.
> 
> Move last_gen into struct paint_state so that
> commit_graph_generation() is called exactly once per dequeued commit
> and the result is shared across all termination checks and the
> monotonicity BUG assertion.  The loop body in paint_down_to_common()
> reads state.last_gen instead of recomputing the generation number.

Thanks for incorporating this change into this version.

> +  4. Generation cutoff: the dequeued commit's generation is below
> +     a caller-supplied `min_generation` threshold.

Technically, this was always a termination condition of the walk,
but now we are correcting the documentation to match. It was just
not part of the termination in the dequeue method until now.

> @@ -89,6 +89,8 @@ struct paint_state {
>  	int p1_count;
>  	int p2_count;
>  	int pending_merge_bases;
> +	timestamp_t min_generation;
> +	timestamp_t last_gen;
>  };

I'm happy that these details are being imported into the struct.

My first reaction is that last_gen shouldn't be here because we
can see a generation from the dequeued commit. I'll read on to
be sure.
  
>  static void paint_count_update(struct paint_state *state,
> @@ -138,11 +140,23 @@ static void paint_queue_put(struct paint_state *state,
>  static struct commit *paint_queue_get(struct paint_state *state)
>  {
>  	struct commit *commit = prio_queue_get(&state->queue);
> +	timestamp_t generation;
>  
>  	if (!commit)
>  		return NULL;
>  
>  	commit->object.flags &= ~ENQUEUED;
> +	generation = commit_graph_generation(commit);
> +
> +	if (generation > state->last_gen)
> +		BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
> +		    generation, state->last_gen,
> +		    oid_to_hex(&commit->object.oid));

Oh I see. It's just for this condition.

Does this case still break without 'state->min_generation' in the
condition?

> +	state->last_gen = generation;

This is an appropriate use of this value. My concerns are no longer
valid. Thanks for letting me think out loud.

> +	/* generation cutoff */
> +	if (generation < state->min_generation)
> +		return NULL;

And here's the crux. Again, impossible for this to halt when
min_generation is zero.

>  	if (!state->pending_merge_bases) {
>  		/* only stale entries remain */
> @@ -151,7 +165,7 @@ static struct commit *paint_queue_get(struct paint_state *state)
>  
>  		/* one side is exhausted */
>  		if ((!state->p1_count || !state->p2_count) &&
> -		    commit_graph_generation(commit) < GENERATION_NUMBER_INFINITY)
> +		    generation < GENERATION_NUMBER_INFINITY)
>  			return NULL;

Good reuse of the value.

>  	}
>  
> @@ -177,9 +191,10 @@ static int paint_down_to_common(struct repository *r,
>  	struct commit *commit;
>  	int i;
>  	int steps = 0;
> -	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
>  	struct commit_list **tail = result;
>  
> +	state.min_generation = min_generation;
> +	state.last_gen = GENERATION_NUMBER_INFINITY;
>  	if (!min_generation && !corrected_commit_dates_enabled(r))
>  		state.queue.compare = compare_commits_by_commit_date;
>  
> @@ -196,18 +211,8 @@ static int paint_down_to_common(struct repository *r,
>  	while ((commit = paint_queue_get(&state))) {
>  		struct commit_list *parents;
>  		int flags;
> -		timestamp_t generation = commit_graph_generation(commit);
>  		steps++;
>  
> -		if (generation > last_gen)
> -			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
> -			    generation, last_gen,
> -			    oid_to_hex(&commit->object.oid));
> -		last_gen = generation;
> -
> -		if (generation < min_generation)
> -			break;
> -

I'm happy this is getting cleaned up.

>  		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
>  		if (flags == (PARENT1 | PARENT2)) {
>  			if (!(commit->object.flags & RESULT)) {
> @@ -219,7 +224,7 @@ static int paint_down_to_common(struct repository *r,
>  				 * descendant of this one.
>  				 */
>  				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
> -				    generation < GENERATION_NUMBER_INFINITY)
> +				    state.last_gen < GENERATION_NUMBER_INFINITY)
>  					break;
>  			}
>  			/* Mark parents of a found merge stale */

And here's another termination condition. We are now leaking the
abstraction of the 'state.last_gen' which give me some bad feelings.

We are getting to the point where I'd leave such a thing for a
follow-up, but since you are needing to re-roll, then this is
another case where we can move this into the paint_queue_get(). I
don't think this is me "raising the bar" from earlier recommendations,
because I was asking for all loop termination to be in the get()
method, if possible.

But also: I'm not looking at the full method right now to see if
terminating _at this location in the loop_ is critical. So it may
very well be impossible to move this into the get() call, in which
case please ignore this suggestion and use state.last_gen.

Thanks,
-Stolee

