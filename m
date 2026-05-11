Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EE629CE1
	for <git@vger.kernel.org>; Mon, 11 May 2026 02:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778465309; cv=none; b=E+BXzK0SGBs9UHQLQRxFqwbHRiWB7vOQhIYG6clEh7jYEWIRewB4zPpFERjuQe0g85D2ol/h1XI4s3trPZBOofNLKO0QsdgVvB2JYnK7kQUhQyYo8/4i1L5BOXQUXqgcXhmSZ8o30hEKNk4CyduXBUBZQ66duauLh+JRpYKQdro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778465309; c=relaxed/simple;
	bh=1Y74ADDnb1elSTpwmGFrYabMfLVRPOc8YehcEGAi7mQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sRfmkrmaiGjJyPELd9/UOaoDxZc8QjbUNYe9OSw7VnamcPTXy1M11lg8D6sLSW2a2M6KXdFfalTEpcozFjijyxRjyGsrmL9SXAYqUzlXfuSNvwUSWckksadfX0nZe3hwdovyZTRmk+gjjYPQ9TKUQUSHAlqIBTaNhflgFkbLChM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JhlVpTKt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mX7AYkRQ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JhlVpTKt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mX7AYkRQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B87F27A00A1;
	Sun, 10 May 2026 22:08:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 10 May 2026 22:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778465307; x=1778551707; bh=f0zSMip91n
	RUnJnO2C2qC7PfjwraGxzmgoEShayiN8g=; b=JhlVpTKtM9LhAuTAtcK/xwr6YG
	GfdBgoR0+nCtRBC8WiIljyLNkvS505Ql+q9g//6kvoU1hb8tmUzGSIYuIDz+FLT+
	Au5a2OD5QoRvvO4VAW7k4ZVqzT9Aj04vnyFi+MTBckva+KXihwuTTLOe0xJdnGLt
	wNfykHpg/DE5GeTNOeYvs8gxEtPWM5ykwFOdTzbkoyvS8JCTsdOMFpqyyrIGhbeh
	v6TFzwECh3MxM4EW6OrZdhVOZtHSPX0x60mXmJz82DnmI1XGeHHXHpKjIFsmFiu/
	dllWuByAaBmYHJCQz/Gp3r/vBTHO74fQGAxvEY4L0x1Wqhqq5/c1PAvCmtpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778465307; x=1778551707; bh=f0zSMip91nRUnJnO2C2qC7PfjwraGxzmgoE
	ShayiN8g=; b=mX7AYkRQZOrgUtRwhs4fZC2OiT3FpItDdepmJ+5/FluHavVlk10
	hZH4uJxyjIRWcsgZ3aPWCShonfxTIcPkHEqRfDHwvufimkK/6AgicheyHZKfb22K
	HTXv7JyyGDH5Cm//rMfQn23MOCDzmICJmmAK0lHb6YGEAWcLvad9oXdqLXgIx0o5
	D6lesW76Pj3885mMM9Aj/rsR7y2wDzXw4LHu1UnQV62pjLN5iI/ckRV7Ik4b/OFk
	7Ffik6uv8e+pAwnCzBxLgBtJZtZwmdRnMRbL/HqewimIvmsGh5YL4yD9PuRvLxqw
	N/6x6l+XE/upYymWZ5zBpBEwvNdtZV8gRaw==
X-ME-Sender: <xms:GzoBatHMlQtoZp7VWbe-qiKICO6QG6Bf0OIFIrbgDCi5olYDZAvniA>
    <xme:GzoBapPhpK5KuzY8i3iLFVSFZeOwh08oM5UoyLjqOkpRSK2aPzJZkYcWD0F9LBPzI
    OQCUAEPOvZniO7w2sRc7i7GA3hgW5WUGXkv5evea1tuiHUbt3Icww>
X-ME-Received: <xmr:GzoBanewdI_50J4o_-K62zYW5B7Qp-P4QSHxNgJDaqbOcUu8vx013UnANnzRrK2G4R1-NGt25gRap0HDfFrm2qvXuWAZqtmXnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhkrgesshhpohhtih
    hfhidrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GzoBaus2j1AUZ51PjqqesNI7pORLqQy0C-IIb-nX1xN8Nb8AYJk0XA>
    <xmx:GzoBaglBC5jWLEfy7RprPAMXeBs-cGyY9imnYmJVYMODRLBU9nPw6g>
    <xmx:GzoBaowggZ_ylARlthrQF_XRVi7nh5M35KOYJkzt6dvEnixuQ41a9g>
    <xmx:GzoBaqPrgaz2W5pNw-Nfh_5Bv2OYKss9SBPQSqUVYeQ2l5aPYr4WBg>
    <xmx:GzoBapsKywJ6FtZopAX0yztWpSZdig8eqO4Ky2IyH65lhcgP42BenoX7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 22:08:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Kristofer
 Karlsson <krka@spotify.com>
Subject: Re: [PATCH] commit-reach: early exit paint_down_to_common for
 single merge-base
In-Reply-To: <pull.2109.git.1778252837132.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Fri, 08 May 2026 15:07:17
	+0000")
References: <pull.2109.git.1778252837132.gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 11:08:26 +0900
Message-ID: <xmqqh5oevgth.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/commit-reach.c b/commit-reach.c
> index d3a9b3ed6f..c9d2d594de 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -55,14 +55,16 @@ static int paint_down_to_common(struct repository *r,
>  				struct commit **twos,
>  				timestamp_t min_generation,
>  				int ignore_missing_commits,
> +				int find_all,
>  				struct commit_list **result)
>  {
>  	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
>  	int i;
> +	int has_gens = min_generation || corrected_commit_dates_enabled(r);

Giving a name that identifies what the commonly-used logical
expression means is a very good idea, but don't some caller pass
min_generation==infinity (i.e., not zero) when there is no
generation available?  E.g., remove_redundant_no_gen() passes
the result of calling commit_graph_generation(), and without commit
graph, we would get infinity here, right?

Given that the second user of this variable is guarded by !find_all,
the variable being true even when we shouldn't be using generation
numbers may not matter for the purpose of the early break, but then
it means that the patch squanders the perfect opportunity to clarify
what the variable means, which is not very lovely.

>  	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
>  	struct commit_list **tail = result;
>  
> -	if (!min_generation && !corrected_commit_dates_enabled(r))
> +	if (!has_gens)
>  		queue.compare = compare_commits_by_commit_date;
>  
>  	one->object.flags |= PARENT1;
> @@ -97,6 +99,11 @@ static int paint_down_to_common(struct repository *r,
>  			if (!(commit->object.flags & RESULT)) {
>  				commit->object.flags |= RESULT;
>  				tail = commit_list_append(commit, tail);
> +				/* Generation-ordered queue: no later
> +				 * commit can dominate this one. */
> +				if (!find_all && has_gens &&
> +				    generation < GENERATION_NUMBER_INFINITY)
> +					break;

Three comments

 * See Documentation/CodingGuidelines for our preferred style for
   multi-line comments.

 * I do not think we often use "dominate" to describe relationship
   between commits, and I am not sure what you want the word to mean
   in this context.  Can you clarify?

 * The code is getting way too deeply indented.  Perhaps using a
   helper function and


                        if (!(commit->object.flags & RESULT)) {
                                if (mark_result(r, &tail, commit,
						find_all, min_generation))
                                        break;
                        }

   move the logic to mark the newly discovered commit as one of the
   possible result, and to tell the loop to terminate, to it, along
   with the comment on the meaning of its return value, may make the
   code easier to follow?

> +/* To be used only when object flags after this call no longer matter.
> + * When find_all is false and generation numbers are available, returns
> + * after finding the first merge-base, skipping the STALE drain. */

Ditto on the style.
