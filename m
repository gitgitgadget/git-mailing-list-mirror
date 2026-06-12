Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525783E51DE
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268774; cv=none; b=PcGqwAdbBEd7pMMmYhiicL01QX8OFcFN6M4QcnH1Ojz9t5+2dNmoXch4ZDinwX01dqWdPqWUhmPgyVPio55ja+zsNHRsXri7sGdcnLjL72NEwGxim/RIoin/xWbZgpzGR7lUM6keVHQxfzVnYdz/4dLzyiIysdj7Jxn+IFvfOno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268774; c=relaxed/simple;
	bh=j5GO/1cXrOtST66SMXJdKINA4KyHBIFS/JcoggWWAOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CMEuCga8Lj0N7i6uDnH+JgLs5gy67h2cgQ7C9HizthNRSaFrnlqqf6uzYqzuBt+GbnqDbAIRsw7/s+hDn35AzbXTa/TDpYdB+eZG22k/+YrEPWs5eYSp3qDZFp2hELjb5c3JvjDan8Y7HdcUUPoCbZP5I/qepL5gr253JEYxtGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pt7HSXoq; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt7HSXoq"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-91574384cc2so106999585a.2
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781268771; x=1781873571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZtfewZl5PPl950xs0NJP6mEkMXqvL85BgyieRTdmW1w=;
        b=Pt7HSXoqus/f+rW0nkx1F+OMci5qiYt4/egX0ionc97caKvmiMBXbCpwIT1/umHbAf
         ua3awIgAiiFfE++Hi248TICiRCOu63BmZkdWB2NV8cUxwshqZEI2gtknwru/25m/uYG1
         gSDmd1rAoyACHOmktgHmlC1S3hnTaVX7MDBLK6eO3wiKRcReBfRruv5FeR8GHW2oDbVv
         GTZ+c0U53GdBE6lkWmxXy+pkKHVetePI4DjyowOueQbQWV2jOqseUsnJK6DirT1vv9vO
         5awdNAmxfbRo+EKnj2Fbr0rFix1qy5F6NUttsQLOz5A0ivR8g31r1CQpA0j47eIcljIL
         FhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781268771; x=1781873571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtfewZl5PPl950xs0NJP6mEkMXqvL85BgyieRTdmW1w=;
        b=e48tpccJP2d/eztHd9rS2miLMOAAfSO6uZFwlce4KTvbzQi0r8Z/SYaG0VzU/F8/dk
         OwRt3UHyIzG6p1Dtk1upVPtwCMItBEDotvgBnS1WYllTQ7Pocbe0/kYaWR9MF40yAJzk
         9lg4yH/m6xyRBYUJibDgLOzkMPtxzJEQsM7nV7K71KgNfiHB/qxk+N9fZ6Cmckg9Qw0m
         JlFZOoWWrdwpe9KW6v7TSczAAWwcLTAqRUCMFD2LJy1CtCoBPLmGHPj30yP6TqfWEAsV
         w6C8FPE02jc3/PoN/QXtgZIQ7xFdKmmbNUVV/cxzs2lVFkgg0lbmviObEv2C1oYG4poC
         CsrA==
X-Forwarded-Encrypted: i=1; AFNElJ/1PXIsurSS1Y9kOkmFWt6UiSC4SEnjXp8m8QD8Qga4hqDaKDhaLIfRR3vTuuTLPgVAcHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx31qSIPcyxkW02/qfAuMtajTtEjliPIEybIyIjfwJLwIcX7ytV
	Q3n2y6vmBJUf0ZDIVGFrlloFYN06jFQEJ4bfhd2KUpoP8JHTZ7s1zzRoujoYqQ==
X-Gm-Gg: Acq92OF1KGYDmHMixWZtPAecqcXKK9hVH8uwKfCMqra5RrE409ESzzZfv089MpDksvJ
	HyZTAnc+y9j1jeymmtW/elIKkuyjN6resCPKmTkZhsJuOkpWpE/Q/99HyMexNyUbIUdiIreBekO
	l33XVA/7QyrmZIWMnan9GeYBCG0g/Fn1QWpRQqBniscR4klBmV4ehKH4/QvBlEosY06D5cVNAu7
	+yyzvx5J0U+Iepx0ssv0qFASsqNFgjilhnJ55/PHiH5X8XKVXlUVYnULAtLs/akmEUd+6PUXG7r
	YurjzOkSiyXZ70Dlcb8hoxr9JG56ROQsEW4EUfo6jTxFELB1ioYjpTqGTI02RxCDYD6OcVotDcG
	HVa3jyBTpm+DAsXInD9VaeZ3y84shhM4ge5vLCBXDSrcXrIaG8CJsTYtL/1dNyNQ6Qff/ZYJELR
	OyvKFcMJiOEZ5JfFpmpMdbJHWQ0R6eug852tOB88PWJc33sah6LbzM88XQwSvyOQ25+a4B
X-Received: by 2002:a05:620a:7103:b0:915:b506:56cc with SMTP id af79cd13be357-9161bab4538mr392456685a.7.1781268771158;
        Fri, 12 Jun 2026 05:52:51 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a056eb8sm195803185a.40.2026.06.12.05.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 05:52:50 -0700 (PDT)
Message-ID: <0b3f7429-a4fb-4f7a-bf7b-5a0edeb1db52@gmail.com>
Date: Fri, 12 Jun 2026 08:52:50 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] commit-reach: terminate merge-base walk when one paint side
 is exhausted
To: Kristofer Karlsson <krka@spotify.com>, git@vger.kernel.org
References: <CAL71e4Mp7ewv0UGS8j=iTq6quyxLXzrr0uNDbWR8JKaOsTSVyA@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAL71e4Mp7ewv0UGS8j=iTq6quyxLXzrr0uNDbWR8JKaOsTSVyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/2026 7:15 AM, Kristofer Karlsson wrote:
> I have an idea to make it faster for fetching all merge-bases for
> common flows in large repos, as long as the commit graph is
> reasonably up to date.
> 
> The key part is the exit condition in paint_down_to_common.
> Instead of waiting for the queue to only contain stale entries,
> it is enough to wait for one of the sides to be exhausted,
> i.e. side 1 is exhausted if no more commits exist in the
> traversal queue flagged with only PARENT1. For example, if
> the two sides are origin/HEAD and a small PR branch, the PR
> branch will quickly become exhausted at the merge-base, while
> the main side will continue.

Generally, you'd replace the queue_has_nonstale() condition
with a more generic queue_can_halt() condition.

> Now you may ask: why is that a safe condition?
> 
> The traversal in paint_down_to_common has two logical phases
> due to the priority queue ordering:
> 
>   1. Process all commits with infinite generation numbers.
>      This includes all commits when there is no commit-graph.
>   2. Process all commits with finite generation numbers.
> 
> These happen in strict order -- all INFINITY commits are popped
> before any finite-generation commit.
> 
> The optimization only applies after the walk enters the second phase.
> In the first phase, the traversal behaves exactly as today
> and uses the existing termination condition.

This would mean that queue_can_halt() would need to know the
following:

1. If we peek at the top of the queue, is that a commit with
   infinite generation number? If so, then we can only use
   queue_has_nonstale().

2. Otherwise, we know that all commits in the queue are ordered
   topologically and can use a different, faster check. To start,
   we need to keep going as long as at least one commit has only
   one side

> In the second phase, traversal follows strict topological
> order -- descendants are processed before ancestors. Paint flags
> propagate from each processed commit to its parents, which have
> strictly lower generation and are therefore not yet examined.
> 
> A new merge-base candidate can only form when a PARENT1-only path
> meets a PARENT2-only path. Once a commit acquires both paint flags
> in this phase, any descendant carrying both paint flags would
> already have been processed.
> 
> Once one side is exhausted from the queue, no new meeting between
> pure sides can occur. Any commit that subsequently acquires both
> paint flags must inherit them from a commit that already had both
> flags -- it is deeper in the graph and cannot affect the final
> merge-base set. We can stop.

The important thing to realize at this point is that commits in the
queue have received flags from their children (children were walked
topologically and "push" flags to their parents).

The STALE bit is pushed from commits that have bits for both sides
of the merge. This isn't something that we can learn from just
walking each side: we need some amount of walking within the
intersection.

This doesn't matter if we are looking for a single merge base, but
when we want the full set of independent merge bases, then the STALE
bit becomes very important.

> On a large monorepo with previously expensive merge-base and
> merge-tree queries, I observed speedups ranging from roughly 300x
> to 1000x. The nice thing is that this works for merge-base --all
> and every internal caller of paint_down_to_common -- we no longer
> have to restrict the optimization to finding just the first merge-base.
> 
> Does the correctness argument above hold?

I think that it doesn't work when trying to get all merge bases. It
requires


   A    X
  /| __/|
 | |/   |
 | B    |
 | |    |
..........
 | | __/
  \|/
   C

In this example, B can reach C through some long list of commits.
This makes B (and X) have much higher generation number than C.
After exhausting both sides of A...X, we have B and C in the queue
with both side bits and neither are stale. But we need to walk
from B to C to discover that C should be stale.

> Happy to come back with a patch later if the logic holds and the
> overall approach is wanted.
You are identifying a point where optimizations are possible, based
on your measurements of the time spent in this walk waiting for
queue_has_nonstale() to end the loop. Specifically, the cost of using
a BFS approach is costing time.

One place that I would recommend here is to take the work you are
doing to investigate the behavior of tips_reachable_from_bases()
or get_reachable_subset() to see if we can use a DFS-based approach
_in this case_ where we have exhausted both side and are only caring
about the STALE bit checking these cases.

Remember that the DFS idea only helps in the case where we find a
path between commits (B to C in this case) without walking all of the
commits above the minimum generation (generation of C). In an alternate
case where B and C are truly independent, this would not save any time.
But these "they are mutually unreachable" cases always require walking
the full set based on the generation number. The good news is that the
vast majority of cases do not actually have multiple independent merge
bases, so there is potential here.

Thanks,
-Stolee

