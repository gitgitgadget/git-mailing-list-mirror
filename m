Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C92218ADD
	for <git@vger.kernel.org>; Sun,  7 Jun 2026 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780832597; cv=none; b=Hgb1rWP5nXRGmxVjyb9C/RjnGmJOmkACAV+OoMLubXxhq/uOOfA3nlZzrxWkcHi4Xxs+H72q59eaPJgXxoNigwIhUs0GUVRgZfjcwDEgQBtpRdff2BGs0nnCgMAurby6UhAZ3/l5yzO/xc/qaa3SZTtXj26r0YCeJvlx3jHHVI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780832597; c=relaxed/simple;
	bh=Km7V7XJmper2zx05WpmxoUHUzXukuX8eFS0/cGuRnVQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=P1+R7ljEVc40XR0k2XeRNMhGi2vntrCLtbgqxPmOO2S+69sUp+QLkSPmJHkVjHqTR72vAXXp9hKidnpsygGZ9macyZAGRLOrpEP+HSE/h1ygCuM1YMOXQXrTwBF34YivmzT4UCV9eSb0e1V8Au0vNl7R6KOV0aqZ9lrWGuZujow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXRtJ4CJ; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXRtJ4CJ"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-138188a7dccso1738745c88.1
        for <git@vger.kernel.org>; Sun, 07 Jun 2026 04:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780832595; x=1781437395; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0galy2KjeH/DYGFlOX074eSGH7mZr3M9mOVfnSAAsg=;
        b=NXRtJ4CJGkLCvQR+/muRBBRfPufEo2g5DYRvB3j3v85OJBuhUsHr3cZDTOlaut7N0E
         QbrCzdnGRiyU76xROhMXPhTedj7KeNpN7JTuvHSZpQFDkh+yy4QmsTJzQs64ri7v4n5K
         583J5xwIOUpQMRRqJ+LR+xVCu0PYeyc9IhTA5gHtvVvsrdGgPrbzB38abePfatl4hAsz
         bjBE61ZVMlf2skDpsYG3UWTycV24x5FD0rMOp0SCriACEjk2orVkG2sC56NJ7/8yFX5Z
         oqXrZnAMgHesmFd3KTBhWSMtIse3dEOLfeYeCYfZYdITZVbYLID40aaRYiorIBqDXeZM
         x8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780832595; x=1781437395;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T0galy2KjeH/DYGFlOX074eSGH7mZr3M9mOVfnSAAsg=;
        b=RGPk139tCk2Y50/iJ3ws2I9bJ+ymVS9HQkBJ+6KLDxxMwj5w89YXIUTiojOw29SYIJ
         KCXM1dxeBY9TTumf7nOONc6HWOQg11gaKjjT1x/R/5/WIc526TMsYR5wD/eWlqOPqBO9
         QUlxOF7r7bissSPHmgKpH3QEigNKIdM75imTiM7BPPD/GVmEoYQf6JcYi4XLGlYdlujy
         LbvF/MQOk/fWdR9HRKQHLEiNka2ClofD1oRhA3ea7mcGJQS6ZqQwZ/5PCdWLs2fYzUgM
         A6fa9NFPu3AUbGFHA1xvtBEMcVJOHg/kCM6AKtuLc1mIfb2EnEOiXSMfBLh9IB9h7DBy
         akcg==
X-Gm-Message-State: AOJu0YwXsa425A4zO+bO7OnRk7YB2HZlY+gNGM3/S0Gdny9m5vkYtFxe
	D3XaUaVL3iSFtf6wwhYSqKA8WqpMYQw8B+/fn/bo9U8ZhvSuL5R5yevR71gGbA==
X-Gm-Gg: Acq92OE9367es5hYxylNDvHTzLMJUew2FnTpDu/3uCgH0SRtK0gCSha6uuTLzYDesxf
	vVnR9RnsjUzVx4HHamm1XYGJ5bNNBACrAGdYmrQlgYG5dnWu1XfnBKiGsn1HeBqgK4i0plL1h6V
	b0GqL/3RR2KEg9k4NxzcjArxTT9OWnSVj9X8DPBct54tXyRvpHSsXgqUBxctJg6L8b8FkXcMOuf
	5tEoLlxzPxYXPSZfCfNhqIlquyJ/5t9N5zZv7h0YPebM3ZjlfugjgU/yYHWxrk3aDz56l+aKO+Q
	j7QvZpa12t2Eh0Fz7n+9O2TAgXoDXoDUPAqxaf7CLBU69PQoOMIvMUoC5HP7xA4754IyU9xURyu
	9Wi7zg7H48+KnwFPTBw4gcG78oPUUiR7zCmFzpTeuu6j0s93aokG8MzX8qJzqNQueTRg7Jch9zH
	zVQlM4wwOaDkyiN5CL4zGJjS8BGHXkFJKUvtw=
X-Received: by 2002:a05:7022:4199:b0:12a:b39a:339f with SMTP id a92af1059eb24-1380671267cmr5120877c88.21.1780832595196;
        Sun, 07 Jun 2026 04:43:15 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.140.3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13803eb106esm6518720c88.5.2026.06.07.04.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 04:43:14 -0700 (PDT)
Message-Id: <pull.2140.v3.git.1780832592.gitgitgadget@gmail.com>
In-Reply-To: <pull.2140.v2.git.1780772477.gitgitgadget@gmail.com>
References: <pull.2140.v2.git.1780772477.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Jun 2026 11:43:09 +0000
Subject: [PATCH v3 0/2] prio-queue: fold lazy_queue into prio_queue for automatic get+put fusion
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

Rene's lazy_queue wrapper in describe.c was a clever optimization -- by
deferring the get, a following put becomes a simple replace, avoiding a full
remove-rebalance-insert cycle.

It turns out this pattern is so common in git's traversal code that it makes
sense to fold it into prio_queue itself. Gets and puts are interleaved in
virtually every commit walk, so the fusion is essentially always a win.

This is mostly a code simplification -- three callers had independently
reimplemented the same optimization, and they all collapse to plain get+put
now. The 1.7-2.7% speedup on traversal-heavy workloads is a nice bonus.

More details and benchmark numbers in the commit message.

Related to but independent of the cascade sift-down work in
kk/prio-queue-cascade-sift -- the two can land in either order.

Changes in v3:

 * Adopted Rene's suggestion to move the flush logic below the LIFO
   early-return (LIFO mode never sets get_pending, so flushing there is a
   no-op).

 * Went a step further and inlined the flush logic directly into get() and
   peek(), eliminating the flush_get() helper and its forward declaration of
   sift_down_root().

 * Updated benchmark numbers with more rigorous methodology: 30 interleaved
   runs with paired t-test on an idle server. Split results into code paths
   that already had manual fusion (neutral) vs code paths that benefit from
   the new automatic fusion (1.7-2.7% improvement).

Changes in v2:

 * Added a second commit that renames .nr to .nr_internal so that direct
   access from outside prio-queue.c is a compile error. Verified that after
   the rename, only prio-queue.c references nr_internal.

 * Added prio_queue_for_each() macro for callers that need to walk all
   elements (describe.c, show-branch.c, commit-reach.c, revision.c,
   negotiator/skipping.c).

 * Converted remaining .nr loop conditions to use
   prio_queue_get()/prio_queue_peek() as the loop condition, or
   prio_queue_size() where get/peek isn't suitable.

 * Fixed several callers missed in v1 (object-name.c, fetch-pack.c,
   path-walk.c, pack-bitmap-write.c, negotiator/default.c,
   negotiator/skipping.c, revision.c, builtin/last-modified.c).

Kristofer Karlsson (2):
  prio-queue: fold lazy_queue into prio_queue for automatic get+put
    fusion
  prio-queue: rename .nr to .nr_internal to prevent direct access

 builtin/describe.c          |  70 ++++++------------------
 builtin/last-modified.c     |   7 +--
 builtin/show-branch.c       |  24 +++-----
 commit-reach.c              |  24 ++++----
 commit.c                    |  11 +---
 fetch-pack.c                |   4 +-
 negotiator/default.c        |   4 +-
 negotiator/skipping.c       |  12 ++--
 object-name.c               |   2 +-
 pack-bitmap-write.c         |  10 ++--
 path-walk.c                 |   8 +--
 prio-queue.c                | 106 +++++++++++++++++++-----------------
 prio-queue.h                |  19 ++++---
 revision.c                  |  16 +++---
 t/unit-tests/u-prio-queue.c |   6 +-
 walker.c                    |   4 +-
 16 files changed, 144 insertions(+), 183 deletions(-)


base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2140%2Fspkrka%2Flazy-prio-queue-pr-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2140/spkrka/lazy-prio-queue-pr-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2140

Range-diff vs v2:

 1:  29af24445e ! 1:  e882206d29 prio-queue: fold lazy_queue into prio_queue for automatic get+put fusion
     @@ Commit message
      
          Defer the actual removal in prio_queue_get() until the next
          operation.  If that next operation is a prio_queue_put(), the
     -    removal and insertion are fused into a single replace — writing
     -    the new element at the root and sifting it down — which avoids
     +    removal and insertion are fused into a single replace, writing
     +    the new element at the root and sifting it down which avoids
          a full remove-rebalance-insert cycle.
      
          This matches the dominant usage pattern in git's commit traversal:
     -    get a commit, then put its parents.  The first parent insertion
     +    get a commit, then put its parents. The first parent insertion
          after each get is now a replace operation automatically.
      
          This generalizes the lazy_queue pattern from builtin/describe.c
     -    (introduced in 08bb69d70f) into prio_queue itself.  Three callers
     +    (introduced in 08bb69d70f) into prio_queue itself. Three callers
          independently implemented the same get+put fusion:
      
            - builtin/describe.c had a full lazy_queue wrapper
     -      - commit.c:pop_most_recent_commit() reimplements the same
     -        get_pending flag with peek+replace
     -      - builtin/show-branch.c:join_revs() used the same peek+replace
     -        pattern
     +      - commit.c:pop_most_recent_commit() used peek+replace
     +      - builtin/show-branch.c:join_revs() used peek+replace
      
     -    All three now collapse to plain _get() and _put(),
     -    with the data structure handling the fusion internally.
     +    All three now collapse to plain _get() and _put(), with the data
     +    structure handling the fusion internally. This simplifies callers
     +    and means every prio_queue user gets the optimization for free
     +    without needing to implement it manually.
      
          Remove prio_queue_replace() since no external callers remain.
          Add prio_queue_size() for callers that need the logical element
          count, since the physical nr may temporarily include a
          pending-removal element.
      
     -    Benchmarked on a large monorepo (10-15 interleaved runs, 1 warmup):
     +    Benchmarked on a large monorepo (30 interleaved runs,
     +    paired t-test, Xeon @ 2.20GHz):
      
     -      Command                       base    patched  speedup
     -      merge-base --all A A~1000     3.88s   3.77s    1.03x
     -      rev-list --count A~1000..A    3.57s   3.43s    1.04x
     -      log --oneline A~1000..A       3.70s   3.49s    1.06x
     -      rev-parse :/pattern           365ms   364ms    1.00x
     -      describe HEAD (linux.git)     184ms   190ms    1.00x
     +    Code paths that previously did eager get+put (new optimization):
     +
     +      Command                       base    patched  change  p
     +      merge-base --all A A~1000     3828ms  3725ms   -2.69%  0.0001
     +      rev-list --count A~1000..A    3055ms  2986ms   -2.27%  0.0601
     +      log --oneline A~1000..A       3408ms  3350ms   -1.71%  0.0482
     +
     +    Code paths that already had manual get+put fusion (expect
     +    neutral - the optimization moves into prio_queue but the number
     +    of heap operations stays the same):
     +
     +      Command                base   patched  change  p
     +      show-branch A A~1000   9156ms  9127ms  -0.32%  0.3470
     +      describe (git.git)     1983ms  1963ms  -1.02%  <0.001
      
          No regressions in any scenario.
      
     +    Suggested-by: René Scharfe <l.s.r@web.de>
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
       ## builtin/describe.c ##
     @@ prio-queue.c: void clear_prio_queue(struct prio_queue *queue)
      +	queue->get_pending = 0;
      +}
      +
     -+static void sift_down_root(struct prio_queue *queue);
     -+
     -+static inline void flush_get(struct prio_queue *queue)
     ++static void sift_down_root(struct prio_queue *queue)
      +{
     -+	if (!queue->get_pending)
     -+		return;
     -+	queue->get_pending = 0;
     -+	if (!--queue->nr)
     -+		return;
     -+	queue->array[0] = queue->array[queue->nr];
     -+	sift_down_root(queue);
     ++	size_t ix, child;
     ++
     ++	for (ix = 0; ix * 2 + 1 < queue->nr; ix = child) {
     ++		child = ix * 2 + 1;
     ++		if (child + 1 < queue->nr &&
     ++		    compare(queue, child, child + 1) >= 0)
     ++			child++;
     ++		if (compare(queue, ix, child) <= 0)
     ++			break;
     ++		swap(queue, child, ix);
     ++	}
       }
       
       void prio_queue_put(struct prio_queue *queue, void *thing)
       {
       	size_t ix, parent;
       
     +-	/* Append at the end */
      +	if (queue->get_pending) {
      +		queue->get_pending = 0;
      +		queue->array[0].ctr = queue->insertion_ctr++;
     @@ prio-queue.c: void clear_prio_queue(struct prio_queue *queue)
      +		return;
      +	}
      +
     - 	/* Append at the end */
       	ALLOC_GROW(queue->array, queue->nr + 1, queue->alloc);
       	queue->array[queue->nr].ctr = queue->insertion_ctr++;
     -@@ prio-queue.c: static void sift_down_root(struct prio_queue *queue)
     + 	queue->array[queue->nr].data = thing;
     + 	queue->nr++;
     + 	if (!queue->compare)
     +-		return; /* LIFO */
     ++		return;
     + 
     +-	/* Bubble up the new one */
     + 	for (ix = queue->nr - 1; ix; ix = parent) {
     + 		parent = (ix - 1) / 2;
     + 		if (compare(queue, parent, ix) <= 0)
     + 			break;
     +-
     + 		swap(queue, parent, ix);
     + 	}
     + }
       
     +-static void sift_down_root(struct prio_queue *queue)
     +-{
     +-	size_t ix, child;
     +-
     +-	/* Push down the one at the root */
     +-	for (ix = 0; ix * 2 + 1 < queue->nr; ix = child) {
     +-		child = ix * 2 + 1; /* left */
     +-		if (child + 1 < queue->nr &&
     +-		    compare(queue, child, child + 1) >= 0)
     +-			child++; /* use right child */
     +-
     +-		if (compare(queue, ix, child) <= 0)
     +-			break;
     +-
     +-		swap(queue, child, ix);
     +-	}
     +-}
     +-
       void *prio_queue_get(struct prio_queue *queue)
       {
      -	void *result;
     -+	flush_get(queue);
     - 
     +-
       	if (!queue->nr)
       		return NULL;
       	if (!queue->compare)
     - 		return queue->array[--queue->nr].data; /* LIFO */
     - 
     +-		return queue->array[--queue->nr].data; /* LIFO */
     +-
      -	result = queue->array[0].data;
      -	if (!--queue->nr)
      -		return result;
     --
     ++		return queue->array[--queue->nr].data;
     ++
     ++	if (queue->get_pending) {
     ++		if (!--queue->nr) {
     ++			queue->get_pending = 0;
     ++			return NULL;
     ++		}
     ++		queue->array[0] = queue->array[queue->nr];
     ++		sift_down_root(queue);
     ++	}
     + 
      -	queue->array[0] = queue->array[queue->nr];
      -	sift_down_root(queue);
      -	return result;
     @@ prio-queue.c: static void sift_down_root(struct prio_queue *queue)
       }
       
       void *prio_queue_peek(struct prio_queue *queue)
     - {
     -+	flush_get(queue);
     -+
     - 	if (!queue->nr)
     +@@ prio-queue.c: void *prio_queue_peek(struct prio_queue *queue)
       		return NULL;
       	if (!queue->compare)
       		return queue->array[queue->nr - 1].data;
     - 	return queue->array[0].data;
     - }
     --
     +-	return queue->array[0].data;
     +-}
     + 
      -void prio_queue_replace(struct prio_queue *queue, void *thing)
      -{
      -	if (!queue->nr) {
     @@ prio-queue.c: static void sift_down_root(struct prio_queue *queue)
      -	} else {
      -		queue->array[0].ctr = queue->insertion_ctr++;
      -		queue->array[0].data = thing;
     --		sift_down_root(queue);
     --	}
     --}
     ++	if (queue->get_pending) {
     ++		queue->get_pending = 0;
     ++		if (!--queue->nr)
     ++			return NULL;
     ++		queue->array[0] = queue->array[queue->nr];
     + 		sift_down_root(queue);
     + 	}
     ++
     ++	return queue->array[0].data;
     + }
      
       ## prio-queue.h ##
      @@ prio-queue.h: struct prio_queue {
 2:  bb8b0f78f1 ! 2:  033215e304 prio-queue: rename .nr to .nr_internal to prevent direct access
     @@ prio-queue.c: void prio_queue_reverse(struct prio_queue *queue)
       	queue->alloc = 0;
       	queue->insertion_ctr = 0;
       	queue->get_pending = 0;
     -@@ prio-queue.c: static inline void flush_get(struct prio_queue *queue)
     - 	if (!queue->get_pending)
     - 		return;
     - 	queue->get_pending = 0;
     --	if (!--queue->nr)
     -+	if (!--queue->nr_internal)
     - 		return;
     --	queue->array[0] = queue->array[queue->nr];
     -+	queue->array[0] = queue->array[queue->nr_internal];
     - 	sift_down_root(queue);
     - }
     +@@ prio-queue.c: static void sift_down_root(struct prio_queue *queue)
     + {
     + 	size_t ix, child;
       
     +-	for (ix = 0; ix * 2 + 1 < queue->nr; ix = child) {
     +-		child = ix * 2 + 1;
     +-		if (child + 1 < queue->nr &&
     ++	/* Push down the one at the root */
     ++	for (ix = 0; ix * 2 + 1 < queue->nr_internal; ix = child) {
     ++		child = ix * 2 + 1; /* left */
     ++		if (child + 1 < queue->nr_internal &&
     + 		    compare(queue, child, child + 1) >= 0)
     +-			child++;
     ++			child++; /* use right child */
     ++
     + 		if (compare(queue, ix, child) <= 0)
     + 			break;
     ++
     + 		swap(queue, child, ix);
     + 	}
     + }
      @@ prio-queue.c: void prio_queue_put(struct prio_queue *queue, void *thing)
     + 		return;
       	}
       
     - 	/* Append at the end */
      -	ALLOC_GROW(queue->array, queue->nr + 1, queue->alloc);
      -	queue->array[queue->nr].ctr = queue->insertion_ctr++;
      -	queue->array[queue->nr].data = thing;
      -	queue->nr++;
     ++	/* Append at the end */
      +	ALLOC_GROW(queue->array, queue->nr_internal + 1, queue->alloc);
      +	queue->array[queue->nr_internal].ctr = queue->insertion_ctr++;
      +	queue->array[queue->nr_internal].data = thing;
      +	queue->nr_internal++;
       	if (!queue->compare)
     - 		return; /* LIFO */
     +-		return;
     ++		return; /* LIFO */
       
     - 	/* Bubble up the new one */
      -	for (ix = queue->nr - 1; ix; ix = parent) {
     ++	/* Bubble up the new one */
      +	for (ix = queue->nr_internal - 1; ix; ix = parent) {
       		parent = (ix - 1) / 2;
       		if (compare(queue, parent, ix) <= 0)
       			break;
     -@@ prio-queue.c: static void sift_down_root(struct prio_queue *queue)
     - 	size_t ix, child;
     - 
     - 	/* Push down the one at the root */
     --	for (ix = 0; ix * 2 + 1 < queue->nr; ix = child) {
     -+	for (ix = 0; ix * 2 + 1 < queue->nr_internal; ix = child) {
     - 		child = ix * 2 + 1; /* left */
     --		if (child + 1 < queue->nr &&
     -+		if (child + 1 < queue->nr_internal &&
     - 		    compare(queue, child, child + 1) >= 0)
     - 			child++; /* use right child */
     ++
     + 		swap(queue, parent, ix);
     + 	}
     + }
       
     -@@ prio-queue.c: void *prio_queue_get(struct prio_queue *queue)
     + void *prio_queue_get(struct prio_queue *queue)
       {
     - 	flush_get(queue);
     - 
      -	if (!queue->nr)
      +	if (!queue->nr_internal)
       		return NULL;
       	if (!queue->compare)
     --		return queue->array[--queue->nr].data; /* LIFO */
     +-		return queue->array[--queue->nr].data;
      +		return queue->array[--queue->nr_internal].data; /* LIFO */
       
     - 	queue->get_pending = 1;
     - 	return queue->array[0].data;
     -@@ prio-queue.c: void *prio_queue_peek(struct prio_queue *queue)
     - {
     - 	flush_get(queue);
     + 	if (queue->get_pending) {
     +-		if (!--queue->nr) {
     ++		if (!--queue->nr_internal) {
     + 			queue->get_pending = 0;
     + 			return NULL;
     + 		}
     +-		queue->array[0] = queue->array[queue->nr];
     ++		queue->array[0] = queue->array[queue->nr_internal];
     + 		sift_down_root(queue);
     + 	}
       
     +@@ prio-queue.c: void *prio_queue_get(struct prio_queue *queue)
     + 
     + void *prio_queue_peek(struct prio_queue *queue)
     + {
      -	if (!queue->nr)
      +	if (!queue->nr_internal)
       		return NULL;
       	if (!queue->compare)
      -		return queue->array[queue->nr - 1].data;
      +		return queue->array[queue->nr_internal - 1].data;
     - 	return queue->array[0].data;
     - }
     + 
     + 	if (queue->get_pending) {
     + 		queue->get_pending = 0;
     +-		if (!--queue->nr)
     ++		if (!--queue->nr_internal)
     + 			return NULL;
     +-		queue->array[0] = queue->array[queue->nr];
     ++		queue->array[0] = queue->array[queue->nr_internal];
     + 		sift_down_root(queue);
     + 	}
     + 
      
       ## prio-queue.h ##
      @@ prio-queue.h: struct prio_queue {

-- 
gitgitgadget
