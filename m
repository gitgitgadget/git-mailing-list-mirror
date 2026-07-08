Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FDD2690EC
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783532993; cv=none; b=IkK5bOMPmcB+kTFwtHMm6GUGABrDSe88odBwsN5wey0I7iwEuZdG2EOBTKXmY67YWeObU6Eb9bOecWd5i64RansuO0rl0vMV+5OP88fQyg2vd8knU+990we1PEmxhafWapil7+K8/7ZZX8WoPXbPMVKxHUPx/Pp1C8cprt+T0JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783532993; c=relaxed/simple;
	bh=7WEF+L17yf/TBQqaOAdsEjSwprX72uoA2mcIPzSk+vk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HqGLPvG5jgcfKg7Uyv2FKf8DhkhHTb3QZuQVI623v3T9c2y/UjL4gyOjiOg4xU2DPW5U5p7sJW+rrl1Bq317NnYUX7GH+8GSKcZ30yEnIPEh/4JGzWnJ43bObyOzqRyZYFuEv214g5c+zdOVK/LfS+PF/MAG0+nEDV9Yv04MHPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=En0Lixmq; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En0Lixmq"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c0a81d286so728971cf.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 10:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783532990; x=1784137790; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pOIZkoBgjNmzCIT/NDOlEAshqS70xxNfDNgMvTJBcKg=;
        b=En0Lixmqotp7Ux8ahEhza7tgYEHW19FFibTakD1u9ArAdCra2/czTgtk7hqJRJt+0q
         7zmkW28nstx0bbXCBHSTf6X69qxioLl7ooiN131Sr6LxWBAMnCevlXTPyyHVBIEcWg8o
         4Nbr4KJ98BgB5L7SWO/BaU+RBNMBOVIfAt9YZKT0I8psZCV31ozfRY/A0dACxgWqF8NB
         ow2Jcu3QEp/COZl7mPYQtK28lRQgGHv1WWsLnr8bTt+dVYPQbyREoYQ7EjdUdv4nGgqy
         LrVSjF03cTlNalHhOJdIGCvnnQH4F3LoCJuBAQrPY1flkpbt1WqphqN6kKv40X9B24Tq
         TREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783532990; x=1784137790;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pOIZkoBgjNmzCIT/NDOlEAshqS70xxNfDNgMvTJBcKg=;
        b=pleUxEAhvpGnO1UIE+5USsr40H/uMw8h3+gdaY7+4SXek2slRXSMt21CufIg/qmmwg
         DpCUGElHu1bOsVNmiRExMvs3VM9B342fzpXX2LyYSNEN+ebDoMnNRbsfHlbL3u0MyxO9
         joktsUKIcQpH9TqHa2Ex1c07PwBWf0h2B5NOATWVdyyO4pMvXJljhSd0eXG33XbhaIIe
         4EtA9zO79dMETpGjMoQObZC6RufupEXnkmiDRH35LD5fxZwNSZhZigPX4Seicfh+u4/Z
         OKOZe4gFJp7/FmJza5n1fklZcLQTswAvWvmWr3kkZUC3DdhKjmXPGbbEA3bXMWMpW5eh
         DL2Q==
X-Gm-Message-State: AOJu0YxXvHqNCgohpQvBW49gZpZMdZTI0u63JliQUDPKNjzpd3igxOFh
	o/GyWu0FyfUi2nxz/AQwqG2KxaCnaASPFdXcMVqU8tR4a73zg8QoWK6YbZDKjA==
X-Gm-Gg: AfdE7cnCTgbqG+d8qQNLGTyuUzallHj68exQOYD+lK4AMdWW7lCglOKH2xjGWQzu711
	WTRScpjnlle93ln8Jth5ttBFZKjlpzdHSw9XABduu/lxcQzupWITnRMNDzFFo1AwqxbjSaWggZi
	VLW/VKir5Gkq4CkHtg/dPvPFe3arcO45UFmnZtMfHCbolNuCqOFbFhvkBl4dkVbUkYw+9O0FiiY
	w+3FWSa4ZLPKF7Ce42/n+AnegOBsNbigplDi0/6s4+nG7W3aQvoN6UPXHrxy+TXzK+7UiXLcbva
	uWKsiItFTcZ400p/QtTxU1cM2YiX6HC1SjJDWeicsp0QGiIVFZsptiazGYaQLGKsZs+ZilFGfgG
	hVmKUBpmR+YUwGjJDf+Ud4h6zgc/QimX12peCIC/pWRsj6DmcTfelWPOxthfKh/Gho1wVPzHFrU
	8Qm1SopEisUfYt
X-Received: by 2002:ac8:598e:0:b0:517:63df:91a5 with SMTP id d75a77b69052e-51c7a751700mr7199441cf.19.1783532990371;
        Wed, 08 Jul 2026 10:49:50 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.47.18])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41d2cf18sm152066021cf.14.2026.07.08.10.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 10:49:49 -0700 (PDT)
Message-Id: <pull.2132.v3.git.1783532989.gitgitgadget@gmail.com>
In-Reply-To: <pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com>
References: <pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Jul 2026 17:49:46 +0000
Subject: [PATCH v3 0/2] prio-queue: use bottom-up sift for extract-min
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

This tweaks the prio_queue implementation to use a bottom-up approach
sifting for get [1].

In practice, the performance boost is small, but measurable for reasonably
large prio_queue:s (thousands of elements, not millions) but it should never
increase the work.

Minor note on v3: After the most recent discussion I am not 100% sure how to
reason about the value of this change - both the value gain and code cost
seem small, but since there was some interest and research done by René I
wanted to complete this v3 anyway so it can be properly discussed (though
still maybe ultimately closed).

Here's how it works:

Instead of placing the last element at the root and sifting it down with two
comparisons per level, cascade the vacancy down by promoting the smaller
child (one comparison per level), then place the last element at the vacancy
and sift it up. Since the displaced element is likely to belong near the
bottom of the heap, sift_up() typically does very little work.

sift_down_root() is kept as-is for the fused replace path in
prio_queue_put(), where the new element is arbitrary and may belong near the
root -- Rene's testing showed that cascade regresses on git-describe for
this reason.

Benchmarks (rev-list --all --count) on public repos confirm no regression on
git.git and linux.git. On a large example repo with thousands of active
branches the cascade yields a measurable (~2%) end-to-end improvement; the
gain is modest because the lazy-fold optimization (now in next) already
fuses most get+put pairs, leaving only the remaining unfused gets to benefit
from cascade.

René's exhaustive analysis [2] of all permutations up to n=12 confirms that
cascade never requires more comparisons than standard sift-down for a full
drain.

Note: sift_up() currently uses swap, matching the existing code style. It
could be further optimized to use copy (hold the element in a temp, shift
parents down, write once), but that would require changing compare() to
accept element values instead of array indices. Left for a potential
follow-up.

Changes since v2:

 * Rebased on kk/prio-queue-get-put-fusion (now in next).

 * Split into two commits - refactoring and then introducing cascade_down.

Changes since v1:

 * Kept sift_down_root() and prio_queue_replace() completely unchanged,
   preserving René's optimization that avoids the get+put overhead for
   replace. The cascade approach now only applies to prio_queue_get().

 * Extracted the new logic into a separate sift_up_rebalance() function
   rather than inlining it in prio_queue_get().

 * Updated benchmark numbers for ascending, descending and random insertion
   ordering. No regressions in any scenario.

[1] https://en.wikipedia.org/wiki/Heapsort#Bottom-up_heapsort [2]
https://lore.kernel.org/git/pull.2132.git.1780250236304.gitgitgadget@gmail.com/T/#m114df6e1c2845acbbc64d875ed7dc1d7d9193ed5

Kristofer Karlsson (2):
  prio-queue: extract sift_up() from prio_queue_put()
  prio-queue: use cascade for unfused gets

 prio-queue.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)


base-commit: 00534a21ce949ef80a5b8b9d7fc20b7d381038e9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2132%2Fspkrka%2Fcascade-sift-down-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2132/spkrka/cascade-sift-down-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2132

Range-diff vs v2:

 -:  ---------- > 1:  ec6a448563 prio-queue: extract sift_up() from prio_queue_put()
 1:  6051d44e59 ! 2:  89a22c6a75 prio-queue: use cascade-down for faster extract-min
     @@ Metadata
      Author: Kristofer Karlsson <krka@spotify.com>
      
       ## Commit message ##
     -    prio-queue: use cascade-down for faster extract-min
     +    prio-queue: use cascade for unfused gets
      
     -    Add sift_up_rebalance(), an alternative to sift_down_root() that
     -    halves the number of comparisons per extract-min.
     +    When flush_get() removes the root without an immediate replacement,
     +    use a cascade-then-sift-up strategy instead of sift-down.
      
     -    The standard extract places the last array element at the root and
     -    sifts it down.  At each level this requires two comparisons (left
     -    vs right child, then element vs winner) and a swap.
     +    Standard sift-down places the last element at the root and sifts it
     +    down.  This needs two comparisons per level (pick the smaller child,
     +    then compare against the element), even though the displaced element
     +    almost always ends up near the bottom where it came from.
      
     -    sift_up_rebalance() instead promotes the smaller child into the
     -    root slot at each level — one comparison and one copy — until the
     -    vacancy reaches a leaf.  The last array element is placed at the
     -    vacancy and sifted up to restore heap order.  In practice the
     -    sift-up rarely moves more than a level or two because the last
     -    array element tends to be large.
     +    cascade_down() instead moves the vacancy down by promoting the
     +    smaller child at each level (one comparison per level), leaving the
     +    vacancy at a leaf.  The last element is then placed at the vacancy
     +    and sift_up() floats it to its correct position, which is typically
     +    very little work since it already belongs near the bottom.
      
     -    Work per extract drops from 2d comparisons + d swaps to
     -    d comparisons + d copies + a short sift-up.
     +    This is the well-known "bottom-up" variant of sift-down [1].
      
     -    prio_queue_get() now calls sift_up_rebalance() instead of placing
     -    the last element at root and calling sift_down_root().
     -
     -    sift_down_root() and prio_queue_replace() are left unchanged.
     -
     -    Synthetic benchmark (10 rounds of 10M put+get cycles, CPU-pinned,
     -    same compiler and Makefile flags):
     -
     -    Ascending keys (git's typical pattern — parents have lower
     -    priority than children):
     -
     -      queue width  baseline  patched  speedup
     -               10     4.39s    3.91s    1.12x
     -              100     9.10s    6.61s    1.38x
     -            1,000    11.84s    9.25s    1.28x
     -           10,000    17.50s   13.92s    1.26x
     -          100,000    23.97s   20.19s    1.19x
     -
     -    Descending keys (worst case — last element always sinks to leaf):
     -
     -      queue width  baseline  patched  speedup
     -               10     4.94s    4.95s    1.00x
     -              100     9.75s    9.42s    1.03x
     -            1,000    15.01s   15.29s    0.98x
     -           10,000    24.79s   23.88s    1.04x
     -          100,000    29.69s   28.24s    1.05x
     -
     -    Random keys:
     -
     -      queue width  baseline  patched  speedup
     -               10     5.05s    4.99s    1.01x
     -              100     9.90s    9.50s    1.04x
     -            1,000    15.35s   14.77s    1.04x
     -           10,000    25.35s   24.21s    1.05x
     -          100,000    65.71s   63.38s    1.04x
     -
     -    No regressions in any scenario.
     -
     -    End-to-end benchmark on the linux kernel repo (1.4M commits,
     -    range v5.0..v6.0, 311K commits, 20 interleaved runs, 1 warmup):
     -
     -      Command                      baseline  patched  speedup
     -      rev-list --count v5.0..v6.0    484ms     474ms    1.02x
     -
     -    The improvement scales with DAG width: wider DAGs produce larger
     -    priority queues, amplifying the per-level savings.  In small or
     -    narrow repositories the queues stay shallow and the sift-down
     -    cost is already negligible.
     +    [1] https://en.wikipedia.org/wiki/Heapsort#Bottom-up_heapsort
      
     +    Helped-by: Rene Scharfe <l.s.r@web.de>
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
       ## prio-queue.c ##
     @@ prio-queue.c: static void sift_down_root(struct prio_queue *queue)
       	}
       }
       
     -+static void sift_up_rebalance(struct prio_queue *queue)
     ++/* Cascade vacancy toward a leaf, promoting the smaller child at each level */
     ++static size_t cascade_down(struct prio_queue *queue)
      +{
      +	size_t ix, child;
      +
     -+	/* Cascade: promote smaller child at each level. */
     -+	for (ix = 0; (child = ix * 2 + 1) < queue->nr; ix = child) {
     -+		if (child + 1 < queue->nr &&
     ++	for (ix = 0; (child = ix * 2 + 1) < queue->nr_; ix = child) {
     ++		if (child + 1 < queue->nr_ &&
      +		    compare(queue, child, child + 1) >= 0)
      +			child++;
      +		queue->array[ix] = queue->array[child];
      +	}
     -+
     -+	/* Place the last element at the vacancy and sift up. */
     -+	queue->array[ix] = queue->array[queue->nr];
     -+	while (ix) {
     -+		size_t parent = (ix - 1) / 2;
     -+		if (compare(queue, parent, ix) <= 0)
     -+			break;
     -+		swap(queue, parent, ix);
     -+		ix = parent;
     -+	}
     ++	return ix;
      +}
      +
     - void *prio_queue_get(struct prio_queue *queue)
     + static inline void flush_get(struct prio_queue *queue)
       {
     - 	void *result;
     -@@ prio-queue.c: void *prio_queue_get(struct prio_queue *queue)
     - 	if (!--queue->nr)
     - 		return result;
     - 
     --	queue->array[0] = queue->array[queue->nr];
     ++	size_t ix;
     ++
     + 	if (!queue->get_pending)
     + 		return;
     + 	queue->get_pending = 0;
     +-	queue->array[0] = queue->array[--queue->nr_];
      -	sift_down_root(queue);
     -+	sift_up_rebalance(queue);
     - 	return result;
     ++	--queue->nr_;
     ++	ix = cascade_down(queue);
     ++	queue->array[ix] = queue->array[queue->nr_];
     ++	sift_up(queue, ix);
       }
       
     + void prio_queue_put(struct prio_queue *queue, void *thing)

-- 
gitgitgadget
