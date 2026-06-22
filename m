Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCF234CFDD
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159809; cv=none; b=sKJmij6Jk/qVwYOrPCFX52XxVk33E6EvPCamwRVqMUaCE1JOz6d+V++NtAGVCNS3CtfkfULTSfomjop5zmyMRRim8xBn+dpWAJucVBcPJLsjlc2UjNYZpXq8vg9bRr/2PBDsqig2HXYXO3ZTiGQwE9GELipYv9/6afu8lihxrSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159809; c=relaxed/simple;
	bh=nbJz1knaX/Bm48EZfdAEaQQWs/GlYhYlwYGCqTmvePg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ObVCas9suN7EHRNnzKFpRSjgrrJYOjeUb8y6JEppZ+66u7QhZuI03lp6Xuk8FawpRanFQES93BwJqJ1jkLE0rYByiQ+6D1liIfkHc1w3wCOZi2IJkNSsU8znuLtEJZCHaPTNAtasVSIpiho/I2nV9FASf6W+/4tD8udgLCbHCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+6nycst; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+6nycst"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66319257aa1so2707132d50.2
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 13:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782159807; x=1782764607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RHeh2bsSS95f0hATtdn+DF/L5xGG6vMIP7ELV0mgv8k=;
        b=A+6nycstX70x9q/LRLCVSZ2+B906jyDo6zAnzhxp/sC9VxGhKGPWwrmSqAQjvwTLxU
         aKHOeonX0PXOu3apraQIuw0DufA9D8vNPkVaEepCwMu4eIn7doRgDjj8QFf/AOgLppt3
         Hmjwfbpwsmn3Gie4QeIaA8bBTn4tYRjWDfTMUObFvQqJUZWZLoCGM65M2dsPKN3syl3I
         9YX5E/RfPn+VpdXMQQb+dV9+G9T6EO7RleMrEuefYeY9jt6ywVpiDMWFxuzSH7TAXeYI
         s+yYNLVgsAxF95O09bZQUAdmeDG63XSft4J3U3FsuYs/5extIki1AkaMDFrDjLXM9W//
         8nuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782159807; x=1782764607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHeh2bsSS95f0hATtdn+DF/L5xGG6vMIP7ELV0mgv8k=;
        b=lPqSnt0VJCIpLiUQ/9HEW+F6SHfOV28qe63MVvOt1z0fLctS/4qW41WsJpi5KQJHxV
         IKs1qNAYG9MEtr60y4q3A1L81LaeTra8ZZZms335OCew/DOxT/slocvMj0ZS6k+oaA5y
         fViafyReFVJZe/zQPIJXVKp8VZZFo2nfQda148trFMFYaevyAFEqKu4W5X7XfXEpyITR
         6op6SjrJ/XIWAdREak2urKU0nQmsU4N95JebM/DBDJIwJlt+8xBV4NesirdLjY7CWP3n
         XrnnvTYFa8XdUzHp8KIqLEpVhFaALzNOKUqLPUjt6yuJdTo6bQ5RaBrNYYlY+nHn98cr
         61IA==
X-Forwarded-Encrypted: i=1; AHgh+RrFUDNDI3cxLRs87/4zBgMMsTPrkp55mvZly5DjHOZ6P9bXBAjMMjBAvpG73J9c6M7h9WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5nU1/5H9oErWbEKfezi5axuzc9CiMORsaKZXU4ZWac4oVAAxz
	Zu3Mg9jID2RDqWIgFWgO01CdTd46wsmJweDR9vcGARV5jgDoax520U2JfA+k6ZtWkyA=
X-Gm-Gg: AfdE7ckk3P7iwA2zcJaZ3pmHd6AbUlCI3/mHLvytqktRyyCs9AEFq/ofCtw0IF6rADY
	AOIehgmDNSDvb18aa1zifvyzauNraApDfe4VaQRB14w2sC9G7anlMnwj/gu38k0DPHjTUkVxGsu
	WI3VMERW8vrY5G01GXgQxVK8oPbq6qLGUmP2Ig+37Gq/ABcxAHIbrV/v746iCEyHL+MwW2YpelK
	Hm2qsovVjhHpMx03QxedioAzo9Njf0GipLnw7giHPtzOXRubcbMTMydG2yVjHE9laaInJP2kxGk
	AA2tOdSwYyyE0nvXb5y6zE4Psb4V6iAi4y4bHbtsWPQhUoiMe4HDkZbACeVxcZcmGlRTBwz44F1
	yAwxNbI1Wwr6KxUQt6fxL4fibw8de78Pk1mN01t1c7SNk2guKxyUTvqoQSI08fwmcYkDv1gRcbC
	2KDiy2e/glJHuoMCPGEaOmT2XkfblxB36+z3XjDiPnT/S5S0q6AHcpqS0SkqxIGuBCPQRf
X-Received: by 2002:a05:690c:4d82:b0:7e2:2c41:4f75 with SMTP id 00721157ae682-801311edff1mr153056617b3.5.1782159806588;
        Mon, 22 Jun 2026 13:23:26 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81fcb55csm103788866d6.34.2026.06.22.13.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 13:23:25 -0700 (PDT)
Message-ID: <8d07f5a9-82fa-4aed-b407-363e659f6851@gmail.com>
Date: Mon, 22 Jun 2026 16:23:25 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC 2/6] commit-reach: introduce struct paint_queue with
 per-side counters
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <316e4dfe261043730c77142639f86f5c3cabe370.1781951820.git.gitgitgadget@gmail.com>
 <f0c9eb6e-60b1-4eb6-86be-3af4d87afe85@gmail.com>
 <CAL71e4Pcw-UUbHBw_j6PFx2bXmxZ93VLMWG+3Qap=RmCJa_ZgA@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAL71e4Pcw-UUbHBw_j6PFx2bXmxZ93VLMWG+3Qap=RmCJa_ZgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/2026 3:14 PM, Kristofer Karlsson wrote:
> On Mon, 22 Jun 2026 at 20:10, Derrick Stolee <stolee@gmail.com> wrote:
>>

>> Also: technically "case 0" should be a BUG() state, right? We
>> shouldn't be walking any commit that isn't reachable from at
>> least one side. (case 0 does happen for old_paint, though.)
> 
> No, this is actually intended - initially I started with skipping
> case 0 and let it fall through, but that would hide _other_ bugs.
> I use 0 as a marker for "not in the queue" so we have this:
> Enqueuing: 0 -> flags
> Dequeueing: flags -> 0
> Only the case with the modified commit being in the queue
> will have non-zero flags. I tried to document this, but perhaps
> it is not clear enough, I will see if I can rephrase it, or add an
> inline comment around the case itself.

I bet this would be obvious if I tried to change the code and
run the tests. thanks for the explanation.

>>> +     while ((commit = paint_queue_get(&queue))) {
>> ...> +
>>> +             if (queue.p1_count + queue.p2_count +
>>> +                 queue.pending_merge_bases == 0)
>>> +                     break;
>>>       }
>> When possible, I like to try to make loops only have one terminating
>> condition. Should we have paint_queue_get() return NULL when it sees
>> this internal state condition?
> 
> Possibly, but that would couple the paint_queue struct very tightly with
> the usage. Not a problem in practice since it only has one call site, and
> it's unlikely that we want to add more of them but it may feel more natural
> to let the paint_queue purely have the queue semantics and counters,
> and keep the halt condition within the function itself. I don't feel
> super-strongly about this and can change it if needed, I will just need to
> verify that nothing else gets complex as a result, I have not fully thought
> through the effects.

Hm. Interesting. The coupling is perhaps expected, because the data
structure tracks counts that don't otherwise need to be tracked.
Maybe the terminating condition method could be descriptively named
to say why it would be completing.

>> Also, I'd rather see it of the form of (!count) instead of using
>> addition to make it clear that we care about each value being zero.
> 
> I did consider that, and most of the code in commit-reach.c at least
> prefers x and !x over x != 0 and x == 0, but my thinking was that
> other code in the repo did use comparison operators specifically
> for things like counters. Happy to change it to conform better though!
I just worry about the idea that a negative number (or an addition
overflow) would create conditions for termination that we did not
intend. That's why using the nonzero status as true/false combined
with ands and ors is better.

>> Finally, I think we actually want this case to get the benefit:
>>
>>         if ((!queue.p1_count || !queue.p2_count) &&
>>             !queue.pending_merge_bases)
>>
>> I do see that you have this condition in patch 3 with the extra
>> detail that the max generation in the queue is finite. I think this
>> is more reason to include this in the data structure method and not
>> in the loop.
> 
> Yes, but just to be clear, you don't want to merge together patch 2 and 3
> here, just grouping the halt conditions closer together
> (within paint_queue_get)? Keeping patch 2 and 3 separate would be nice
> to make it easier to show that introducing this extra counter bookkeeping
> does not negatively impact the overall performance too much.
No, I don't want you to squash them. I was perhaps unclear as I was
discovering the structure as we went. The thing I was missing above
was the "finite generation number" condition, which you make very
clear in patch 3.

Thanks,
-Stolee


