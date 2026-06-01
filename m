Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612A0B640
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 00:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272573; cv=none; b=YvdB4b7KUMgVj8TpZyaCTsv8kAo22GZtMSvWaTBdIaA/o3jHHxPM8D6nQEttRWu+0cqJfx++iZGID/c7pXMaIg3CORM/krE2UPxkLNhKDkqH+i5QCUkn9G1L9zf4MyYucRR6q01WCeScUblZpYCI5zOLt6lYAZjX4OU2rzm5fA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272573; c=relaxed/simple;
	bh=sG5Tb9fn55GrziNPFQetBOeXsVZorDKBfaXMofijd+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ige6WD635znohaCkzZMNGvP2ggsrqLnV9DSDsSf5zhVKBvJMkZhSYBVwU7S55DACuxNFFZBtX/QmW7uWNyv353NwJPgP1Xdw+NkSAk4i/03TEFAk2wV/ttdwI1B7oeh7qZXHtDLSBESQKoKenTgjfxl5+SXPXrtncmreT7Tk6SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=s9EX4+Yt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WNEwunLS; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="s9EX4+Yt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WNEwunLS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8F7A77A004D;
	Sun, 31 May 2026 20:09:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 31 May 2026 20:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1780272571;
	 x=1780358971; bh=amaaYSbGsT+WgdGNzx9Dm/ErLsKVppLqLuxaq2XnoME=; b=
	s9EX4+YtkHG9Nq4jSeN1XDPm9LNWLT3jZwcdIrxkuxBpG9hj0eOasn8R5BiLZ3vH
	2GcaBzM4iFtm8NFyFzrkr657Ws7MpEHjo71oa561AGSRpMTnZlpphGMHk539eLWX
	cy4cR6Myoxq6oZM4O6njitUn+Lobbz6GzbocVc+k0aOA5u/2Bp4m6d5FLCPYJYE+
	atM+xKN02Ry1qKEYjaVvf0hEZuaXuTSWpEoewo1eeS4wF/LdwbI209hY81z/d3MD
	a+SOCPYr1AZCEcD3pr1VY++JpaYxX3L/E4vrPfQMhXhhNdAdBKTiCZ6unOoyjorJ
	0yDp+6xa011+ZjKPYW5hSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780272571; x=
	1780358971; bh=amaaYSbGsT+WgdGNzx9Dm/ErLsKVppLqLuxaq2XnoME=; b=W
	NEwunLSjwc7BS5gzqDv8Q+ZxE43aS+RNKblKM62yLeCk86clDsBAArN78kWrBhEe
	T+lUjQNSxpOiUgXAHmX3MLFY352e2l8PsvdOyPYepgCdl9t20Zru2KCl/4uMFgpe
	C7lN3Uj8mSOxDXteoskha9yQ/0Rl0V0FuKmtZP9zc2hFIWstDcmbMVEzqJu7cL1X
	4ooR+NFxU3LX1NZLffOZkfWvfhjZ2/32ukITqP9kSmpIdTtFBScAl7j3c2tmW85W
	KTVJxnSuNPWwcfQe4n+T9vU8X/XvJ+MGCEiw85AjriS3WdIk8nz+ubLuyPP/byNg
	XNvVWk5Tlrs3LNEEqeqkg==
X-ME-Sender: <xms:u80calmK279ikzetmmG6DTQS8-pmJvte_zj7Vwsi1aMZ0785imRljQ>
    <xme:u80canvE_sFAlAk8GWv-X2yC8Wl3L19Bs8dziXghA27jr9Aq0bjB2jJ0NNSiQbZTq
    MW_SVJhlk3ZiGnChS_ieUnk0x6PUYWPA8KtVa0DDPriwYWAn-lY7zQ>
X-ME-Received: <xmr:u80caj-9duxOMoKNgnxpMV4xgF2i8USxFah-7OmwELFFhPFFVsEcpajxP7vkVqs9BNWaYtuUkqkn9JSJ48RaMtUYuYqRDSGBgVog>
X-ME-Proxy-Cause: dmFkZTF9LtDtVhZh64xOWjIPwj0E9/VhLDyK+wlELeqny80TI42YUpbxbyniOdYhWOytjt
    Yn+ue7jvMk4Veyqdq4o5AeQfa1m+mgPah2aRXEV4yT5xc/t9rNWg3GSY23135zyWr7yTVW
    2meGjwFZB08b3ZFEb07v9w6efFKLPeMyDHmJmVuTpctNSwoBY1bQfV9rbCc4QbDO6DZ2rk
    kJLCe6smpsH5JDYp1dHHsvWyYSiTKXgQCgW1aKsmvATa7H0QiXTdac37QFIHSWEcP22TBO
    9IYv+a3oBUIQLAVnqSFkFPWPUiVgOLWTFMvUVJUX6k/s8qkdrKQ+nCt8iLT/64AbCxLMnT
    3Srd4xEWCUCrupnDEk5jJalfmacjbyhs/Q7JN6E7teaOT+cvgaUhG9NY43DsIqs2g8YP8i
    +jIbJi8XiG4GyUIBrip9i956xnSKJ2Dht3/WFDo4xlBE6tpIVmZRP98sAykKvBpMSOCYU1
    4a8du9JVSxhAjoinr8XnTbdqFuvd9Jec0E4pNUqngffqa4mChVHAJpS5xO9Tu0POARKZ7t
    x6uyyw/3oqO+xunEOAWmhsdKebuMckcaAI8kBPbl4UG4ehn2R+bomVFdJh4Oxfgr7/7hH6
    X0ity5a819gQjio9S3ergKYO4uJ/RMHWZR2VtJC3jL/a1VtVwnZQc+wQHRUg
X-ME-Proxy: <xmx:u80cahNYSvrgaHqVljClKXbXnFN09Hh9wH8XV-9MRlgNj25UdAi0yA>
    <xmx:u80cahFPYj0_t3K-07LApeAI2lEsNvEx-4HslQXjEGyPLd0lbCZCyw>
    <xmx:u80cavRJjRvRDXJ0n6shWYe9jNUxgPmCYbAndKHxzLi6tabHnt2P6Q>
    <xmx:u80cauv8wsY4QMeLkJhUlWT4fG24cJQ3Ho4f9qwDDPfjI9AIBnjfPA>
    <xmx:u80cauyh5_qt3kGEKO5nleaV0wkBKdPzNMikPLSx1mlVntQU2c3xYmJV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 May 2026 20:09:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH] prio-queue: use cascade-down sift for faster extract-min
In-Reply-To: <pull.2132.git.1780250236304.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Sun, 31 May 2026 17:57:15
	+0000")
References: <pull.2132.git.1780250236304.gitgitgadget@gmail.com>
Date: Mon, 01 Jun 2026 09:09:29 +0900
Message-ID: <xmqqqzmrazpi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

I'll add René the recipients, as _replace() was added by him as
optimization, so "this new one is functionally equivalent to the
original" somewhat misses the point, even though we may all agree
that the change is a very good one overall in the end when we look
at the entire picture.

> From: Kristofer Karlsson <krka@spotify.com>
>
> Replace the standard sift-down in prio_queue_get() with a
> cascade-down approach.
>
> The standard approach places the last array element at the root,
> then sifts it down.  At each level this requires two comparisons
> (left vs right child, then element vs winner) and, when the
> element is larger, a swap (three 16-byte copies).
>
> The cascade approach instead promotes the smaller child into the
> vacant root slot at each level — one comparison and one copy.
> The vacancy sinks to a leaf, where the last array element is
> placed and sifted up if needed — typically zero levels since the
> last array element tends to be large.
>
> In the common case, work per extract drops from 2d comparisons
> + 3d copies to d comparisons + d copies: roughly half the
> comparisons and a third of the data movement.  The sift-up phase
> can add work when the last element is smaller than ancestors of
> the leaf vacancy, but this is rare in practice.
>
> Simplify prio_queue_replace() to a plain get+put sequence.  This
> is semantically equivalent: the old implementation wrote to slot 0
> and sifted down, which has the same observable effect as removing
> the root and inserting a new element.  No caller observes queue
> state between the two operations.  The previous implementation
> shared sift_down_root() with get, but the cascade approach no
> longer accommodates that cleanly since sift_down_root() now
> expects the element to reinsert at queue->array[queue->nr], left
> there by prio_queue_get() after decrementing nr.  This is fine in
> practice: replace is only called from pop_most_recent_commit()
> (fetch-pack, object-name, walker) and show-branch — none of
> which appear in any hot path.
>
> A synthetic benchmark (10 rounds of 10M put+get cycles, ascending
> integer keys, CPU-pinned, median of 3 runs, same compiler and
> Makefile flags) shows consistent improvement across all queue
> sizes, with no regressions:
>
>     queue width       baseline    cascade    speedup
>     ------------------------------------------------
>              10        4.32s      3.97s      1.09x
>             100        7.95s      6.49s      1.23x
>           1,000       11.30s      9.66s      1.17x
>          10,000       16.34s     14.15s      1.16x
>         100,000       21.43s     18.66s      1.15x
>
> With descending keys (worst case — the last element always sinks
> to a leaf in both approaches) the cascade still wins slightly
> (1-4%) by replacing swaps with copies, and never regresses.
>
> In end-to-end git commands the improvement is modest because
> sift_down_root is only ~8% of total runtime.  Profiling
> rev-list --count on a 2.5M-commit monorepo shows sift_down_root
> dropping from 8.2% to 0.4% of total runtime.  The improvement
> scales with DAG width: wider DAGs produce larger priority queues,
> amplifying the per-level savings.  In small or narrow repos the
> queues stay shallow and the effect is negligible.
>
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>     prio-queue: use cascade-down sift for faster extract-min
>     
>     Hi, I am not sure this is just noise or not but I thought it at least
>     was interesting.
>     
>     I looked into the internals of prio_queue and found it was technically
>     doing too much work and could be simplified/optimized. I found I could
>     optimize it by ~20% for the common case (adding commits that would
>     typically end up far back in the queue) but only ~1% for the reverse
>     case (adding things to the front of the prio queue). The average speedup
>     is somewhere in between I suppose. That said, this is not really the
>     bottleneck so the overall boost seems to be around ~3-4% improvement for
>     repos with wide DAGs.
>     
>     I would normally classify this as not urgent or important, but I think
>     the advantage is that the change is very small and simple and it already
>     has good unit tests (t/unit-tests/u-prio-queue.c).
>     
>     With that said, here are the details:
>     
>     The prio_queue_get impl is based on removing the root entry, then moving
>     the very last element into the root slot, then sifting it down into the
>     right place. This uses both comparisons between sibling elements in the
>     heap as well as comparisons between the element to add and one of the
>     siblings. Then it uses swap operations to move things correctly.
>     
>     This patch instead promotes the smaller child upward at each level,
>     leaving a vacancy that sinks to a leaf, then places the removed element
>     there with a short sift-up to keep the heap balanced.
>     
>     We can analytically compare this - for a sift-distance of d we can
>     reason about the number of operations to execute.
>     
>     Before: 2d comparisons + 3d copies
>     After:   d comparisons +  d copies
>     
>     
>     After changing sift_down in this way, the replace operation can't simply
>     depend on it anymore, so I reimplemented it as a sequence of get + put.
>     This is technically correct but maybe not as efficient. However, I am
>     not sure that it matters, since I couldn't see any usage of the replace
>     operation in any hot path.
>     
>     Performance: Profiling git rev-list --count on a 2.5M-commit monorepo
>     shows sift_down_root dropping from 8.2% to 0.4% of total runtime,
>     effectively eliminated as significant overhead.
>     
>     Synthetic benchmark 10 rounds of 10M put+get cycles, CPU-pinned, median
>     of 3 runs, same compiler and Makefile flags.
>     
>     Ascending keys (git's typical pattern -- parents have lower priority
>     than children):
>     
>     queue width  baseline  patched  speedup
>              10     4.32s    3.97s    1.09x
>             100     7.95s    6.49s    1.23x
>           1,000    11.30s    9.66s    1.17x
>          10,000    16.34s   14.15s    1.16x
>         100,000    21.43s   18.66s    1.15x
>     
>     
>     Descending keys (worst case — last element always sinks to leaf in both
>     approaches):
>     
>     queue width  baseline  patched  speedup
>              10     4.84s    4.78s    1.01x
>             100     9.43s    9.20s    1.03x
>           1,000    15.28s   14.71s    1.04x
>          10,000    23.61s   23.49s    1.01x
>         100,000    29.16s   28.22s    1.03x
>     
>     
>     No regressions in any scenario.
>     
>     End-to-end benchmarks
>     
>     All benchmarks use a benchmark setup of 1 warmup run followed by 10
>     timed runs. Each configuration is built from the same source tree and
>     tested on the same repo in alternating order.
>     
>     linux kernel (1.4M commits) — range v5.0..v6.0 (311K commits):
>     
>     Command                      baseline  patched  speedup
>     rev-list --count v5.0..v6.0     455ms    440ms    1.04x
>     
>     
>     I also ran it on git.git but did not see any performance diff at all,
>     due to the size and narrow DAG.
>     
>     The improvement scales with DAG width: wider DAGs produce larger
>     priority queues, amplifying the per-level savings. In small or narrow
>     repositories the priority queues stay shallow and the sift-down cost is
>     already negligible, so the change is not noticeable.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2132%2Fspkrka%2Fcascade-sift-down-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2132/spkrka/cascade-sift-down-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2132
>
>  prio-queue.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/prio-queue.c b/prio-queue.c
> index 9748528ce6..18005c43c4 100644
> --- a/prio-queue.c
> +++ b/prio-queue.c
> @@ -62,17 +62,21 @@ static void sift_down_root(struct prio_queue *queue)
>  {
>  	size_t ix, child;
>  
> -	/* Push down the one at the root */
> -	for (ix = 0; ix * 2 + 1 < queue->nr; ix = child) {
> -		child = ix * 2 + 1; /* left */
> +	for (ix = 0; (child = ix * 2 + 1) < queue->nr; ix = child) {
>  		if (child + 1 < queue->nr &&
>  		    compare(queue, child, child + 1) >= 0)
>  			child++; /* use right child */
> +		queue->array[ix] = queue->array[child];
> +	}
>  
> -		if (compare(queue, ix, child) <= 0)
> +	/* Place queue->array[queue->nr] (left by caller) and sift up. */
> +	queue->array[ix] = queue->array[queue->nr];
> +	while (ix) {
> +		size_t parent = (ix - 1) / 2;
> +		if (compare(queue, parent, ix) <= 0)
>  			break;
> -
> -		swap(queue, child, ix);
> +		swap(queue, parent, ix);
> +		ix = parent;
>  	}
>  }
>  
> @@ -89,7 +93,6 @@ void *prio_queue_get(struct prio_queue *queue)
>  	if (!--queue->nr)
>  		return result;
>  
> -	queue->array[0] = queue->array[queue->nr];
>  	sift_down_root(queue);
>  	return result;
>  }
> @@ -111,8 +114,7 @@ void prio_queue_replace(struct prio_queue *queue, void *thing)
>  		queue->array[queue->nr - 1].ctr = queue->insertion_ctr++;
>  		queue->array[queue->nr - 1].data = thing;
>  	} else {
> -		queue->array[0].ctr = queue->insertion_ctr++;
> -		queue->array[0].data = thing;
> -		sift_down_root(queue);
> +		prio_queue_get(queue);
> +		prio_queue_put(queue, thing);
>  	}
>  }
>
> base-commit: c69baaf57ba26cf117c2b6793802877f19738b0d
