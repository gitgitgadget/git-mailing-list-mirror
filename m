Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2B03A782A
	for <git@vger.kernel.org>; Thu, 14 May 2026 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778788670; cv=none; b=OHvR28UtHj1n/bBpSxM7dy5INHYE+F0XjNiTB7gDosD9uqmWgiRaI+qjLffwOVrOzv/4lds46WH8qLJL6t4zDYRoKlRpN7m98DaMCf9PDD0V57S6D0O/NaD/V4GSuPvT7ms+hH9dbJ/6c1gKz03Pd0bd/imm2NIDrR0YkfC6B7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778788670; c=relaxed/simple;
	bh=6oJXVllevu7qA8Z5GaFQBSiXCAfJLMDo82g/KKEZ3KU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TfUEtVzBgoWBr8fjcoiO3G9YyMPA03dZKIs6iDU7DJ/Fod3nc63zX7jKII+sxK1ownvfOipzevITcztgdKO9sRsVCGjGrm/4OqdYZpjlJXZwxxwhe05DJR1+sMfeEBpy4zKX9RVxzQbFyFg5OcBEUGN3dxYrpmhaD9TPYVOotSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLUUNYbw; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLUUNYbw"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8bb09239328so69506666d6.3
        for <git@vger.kernel.org>; Thu, 14 May 2026 12:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778788667; x=1779393467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBwc1BnIiHLYrnA2OijEKE1ErGWVgqTT//dN1srqyCU=;
        b=JLUUNYbw4UGf+JryyZnBKC6teomdpr2axHsY+cHzSs2Ob0yuCbgdTgYkbrW+HNTZ5O
         aUCfpxHuoY/wAAmPMZUmlxMSMEHmmKEedYjw+kg/cc7Sx9Dixf4XRWZU3S9ybQ8F3p4h
         p3pb8MnYMHTbF71OF5RyYb/NOTBeWLIYWVP3ru4CwABeieTc7R60538YzryuOCsfTNT0
         UhgQycmFyjL3JqJ1DLNrdd39wWBuwmoeazQXNTZhVs6BPpS6ENTGodnmOpIWx30Ak3J8
         A/Epdz4uLJPrtiP4YQJdHElMWS508l9MSQra+1oSQEPE73Rpu9yBHAAnz+l5l7LQffDZ
         hphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778788667; x=1779393467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBwc1BnIiHLYrnA2OijEKE1ErGWVgqTT//dN1srqyCU=;
        b=HWdNyzH9tKXWQmeQpaIspUMgj6IYCQALx0cNYZ566tQr+rOWQLvQJBN+K8XMQOpaPD
         ydeVL1MlnazmP2WdphIRBdFOduljApqI+R4HyeBK1DbER8AOUmzBpbsJCIOBrC2jeZ2e
         mCzSq/hQdZqc8TX0wLuTOcALaOdUhxK/oHCfQDvbnL53CbrtNhO/+kVByLhcBn3GzWS4
         9UmlgGjAD7mix7SMss0BeznOPUxO9ApgvciZgPvW7PB9EAHMbIxPCo09WH388y/fxQ+T
         6zp7OneRHWAFnHpxHJx/BnbIQD6pO+OawxeK2d91HCYQ6cQlu87sECVmd9UR7sRzZFKd
         6m5Q==
X-Forwarded-Encrypted: i=1; AFNElJ96jcXiibhJzJizT+YjqDqaceOIURtC/cZQ+TDCJjKL4D3fsULfd9FCwbUHy7To6MOQhFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbe9KdiQsXY1FaismJlHwgssVfZss6Y7QNAlSEiYWpqBavXpXM
	3lXhC4IxY0HRpNU0pZunbhelm67WK6dZk+ERzUHpGXscdlSVU2WSyFMW
X-Gm-Gg: Acq92OFbM+g3AbigyTdX+jgBvfV0/+RNDQjKFLVqb9GTHADtIN4DSQcSleMVe5whAQO
	uOOrGjQvRQ59iQLaeY10br+tnQZWPOcet05ZCMfIrYpAJCtE6a2B0stvZA7YHotIwtb7S+m58hH
	0+4RVISXGckfEug3Yq7b+0bULTGXcgyWge03JTGJopCg7dMdxjBTET/d0KuUNI0yG4fGz4a5IHH
	766m/BchQ0czXLXiK6fMtFv3VK89OVQ/Zz8Fbhq2hI0uUDvReaEOtqDjmrQyWmUAobciQyc381K
	GGi4Dx5LDTObDvSTutS/Uy9d+sS7MtuMP17nfSupp0AmnjOqBA8aQ8fHUdk6XxDBQjzb7LolWrN
	l3aeTCGMrnWcZKaTOTWdq55hSJhMU+szkrDoCGJUctplloc+Ik9BmpH5VJmpCHH5B8U3fixLEZV
	R8NZc4YnvN+jN5idj8U+08VZFJDYf3a1C7ut0VdCNPDBajDfxsvzTRQi8vjVIRpBKnVnFdkw==
X-Received: by 2002:a0c:f014:0:b0:8c7:2c4e:ec3c with SMTP id 6a1803df08f44-8ca0f6a09d0mr16412956d6.29.1778788667122;
        Thu, 14 May 2026 12:57:47 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908d1bb46sm31846706d6.11.2026.05.14.12.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 12:57:46 -0700 (PDT)
Message-ID: <7e5abff7-79c9-41c3-9cfa-2aaf0e69a6a8@gmail.com>
Date: Thu, 14 May 2026 15:57:46 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] revision: use priority queue in limit_list()
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>
References: <pull.2114.git.1778777491939.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2114.git.1778777491939.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/14/2026 12:51 PM, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> limit_list() maintains a date-sorted work queue of commits using a
> linked list with commit_list_insert_by_date() for insertion.  Each
> insertion walks the list to find the right position — O(n) per insert.
> In repositories with merge-heavy histories, the symmetric difference
> can contain thousands of commits, making this O(n) insertion the
> dominant cost.

Linear operations are bad, especially when multiplied by linear-ish
loops, causing quadratic behavior.

> Replace the sorted linked list with a prio_queue (binary heap).  This
> gives O(log n) insertion and O(log n) extraction instead of O(n)
> insertion and O(1) extraction, which is a net win when the queue is
> large.

Yes, much better.

> The still_interesting() and everybody_uninteresting() helpers are
> updated to scan the prio_queue's contiguous array instead of walking a
> linked list.  process_parents() already accepts both a commit_list and
> a prio_queue parameter, so the change in limit_list() simply switches
> which one is passed.
> 
> Benchmark: git rev-list --left-right --count HEAD~N...HEAD
> Repository: 2.3M commits, merge-heavy DAG (monorepo)
> Best of 5 runs, times in seconds:
> 
>   commits in
>   symmetric diff   baseline   patched    speedup
>   --------------   --------   -------    -------
>             10       0.01      0.01       1.0x
>             50       0.01      0.01       1.0x
>           3751      21.23      8.49       2.5x
>           4524      21.70      8.29       2.6x
>          10130      20.10      6.65       3.0x
> 
> No change for small traversals; 2.5-3.0x faster when the queue grows
> to thousands of commits.

This is good. Is there any chance that you could demonstrate this with
any commits in the Git repo? It does have some interesting behavior,
especially around point releases that are independent from the 'master'
branch and thus could have lopsided symmetric differences using well-
established tag names.

>     Switching to a prio_queue (binary heap) reduces insertion cost to O(log
>     w), bringing total cost to O(N·log w). The practical result on the same
>     repository:
>     
>     commits in
>     symmetric diff   before     after      speedup
>     --------------   --------   -------    -------
>             3751      21.2s      8.5s       2.5x
>             4524      21.7s      8.3s       2.6x
>            10130      20.1s      6.6s       3.0x

Very nice! I notice that this data is in your cover letter, but
not the commit message. Is that intentional?

>     This affects any command that triggers limit_list() — i.e., when
>     revs->limited is set — including --left-right, --cherry-mark,
>     --cherry-pick, --ancestry-path, bisect, and rebase's fork-point
>     computation. The practical trigger is git status --ahead-behind on a
>     branch that has diverged from upstream in a merge-heavy repository.

This also impacts 'git log --graph' when there is no serialized
commit-graph file. We are still using limit_list() in that case.

>     The change is minimal (+21/−17 lines, single file) because
>     process_parents() already accepts both a commit_list and a prio_queue
>     parameter — limit_list() just switches which one it passes.

The key logic is turning the initial list into the starting
points for the priority queue and everything else is about
moving types around, it seems.

> @@ -1451,6 +1447,7 @@ static int limit_list(struct rev_info *revs)
>  	struct commit_list *newlist = NULL;
>  	struct commit_list **p = &newlist;
>  	struct commit *interesting_cache = NULL;
> +	struct prio_queue queue = { .compare = compare_commits_by_commit_date };

Here, we are _not_ using generation numbers, which is correct
for this case because we are matching the date-based sorting
of the previous list.

>  	while (original_list) {
>  		struct commit *commit = pop_commit(&original_list);
> +		prio_queue_put(&queue, commit);
> +	}
> +
> +	while (queue.nr) {
> +		struct commit *commit = prio_queue_get(&queue);
>  		struct object *obj = &commit->object;
  
This is a fun reuse of lines to take the old "drain the
list as it is being mutated" loop and turn it into "fill
the priority queue" and "drain the priority queue as it
is being mutated"

This code change looks good. No new tests are needed, since
this is a performance-only change. Do any of the tests in
t/perf/ demonstrate this improvement?

Thanks,
-Stolee

