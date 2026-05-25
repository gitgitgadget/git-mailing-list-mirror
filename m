Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96F82868B4
	for <git@vger.kernel.org>; Mon, 25 May 2026 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779749423; cv=none; b=TB9dlYZM2oAZdeNN9rOSGUFTD30gVu6Ajx4d9LkOTylRecZKjszci3/vBF70oab5qZ3bRzJMjyW9BpFpx/29z3f6ZEtIGvGGKsA7fJ4u2zmJOFr2cl5DKaoA5ca+yN0SknYR1EbcwwK1+hGyyJIbvhSThzF3WYfY4jqAJJmZMNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779749423; c=relaxed/simple;
	bh=ySyFRQfP/yQUfZZCzrf046+AgkQviHoO8DFrJwqwrLM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mwf/BS1e2pUUvW9Erj3IJ6vcREVmZwIKnW1amK3zGPqSBcn85qBzEIZCL1Y5pbzIJVGPUkAK5tsxJLpBrqaV835VOSaenrH4bcIUCWsBs+BdnhOGRK6Exht4G5Xl3/dU2yUmyQVRo6W4y7Vvj+3rx668Rk5fXx1wpeD3XIFEO0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wA5GolLw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bJU9Irdi; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wA5GolLw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bJU9Irdi"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 324D014000F0;
	Mon, 25 May 2026 18:50:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 25 May 2026 18:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779749420; x=1779835820; bh=HbHWxof2Tu
	YKBogKTw+0E7olj9cPk9jS07A/flD7aWk=; b=wA5GolLwN6dNWEIyRTyE/5EzUa
	09I5/QTuiwvfcXKkI9PCpdj+ApNJDzqoMw5/2eSCSeiBS+gWDH5bvfv/+BJv0NW5
	FUM4PV+5jA429IDYdyGhMk+JlRG+8gO3hYBiAj87wIGxLnppTZsFmcIuaYUHAvqB
	ZlFEKngNHWGz2NoGZyqQgYAq95Cx7Ei8LP/kIA/eyxP259ziZRGvkNYzNkaqmiqk
	8K3b8whltrKqbGp9zIr15qs7sC74XDTJ4A4VluR1nT/IzmF/M6Rs1xuPWVGdtaYz
	K885Tybc3f4axnXU2pJ8Vj5YD4ezpDN/lag69xFK/Mrx2ZjGKYanPYw6ybRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779749420; x=1779835820; bh=HbHWxof2TuYKBogKTw+0E7olj9cPk9jS07A
	/flD7aWk=; b=bJU9IrdiOmNnFi+qJ/8LNrJJrvgbn0RZUpXQVqLjM8mLoCzpU7l
	vXOhF74Sn4Ft6MFYYcW1fOZH7Lz6gRVEkoAcfwsWHdT8s3ifCc1Jh2jtZsVS7HnR
	G82yzjkVThCpd8fgDTHW5rXwdNjn51Ur7StV9zo0kixbQhHuS260ka7f0XBdaHha
	kksSVZv99lVE7TR14jPBQFfp+YHjg/yOiZet0NN/A9udcVLkEPpOgqGMXP0rYmAi
	dkC+EyO3C6+oAhzgeU30QIERcwD4ITEbPKbz9EXqwLHzz53xNA1LSpGOue+xpB2H
	R4Y2nvML8OEy7wYo9lnfiaVsaajfoBapeCA==
X-ME-Sender: <xms:LNIUarJnEIIaO_3bOhsmMLQUs8HtW3AmX-lBZUJ8sCuNkTPdL0r7GA>
    <xme:LNIUai1UrwnCSAZ4FTYjDQ0UdeoOBWZ8ieLG_mlGMe3z0AW4yK8aBTwkFoSTScb9E
    HT0iAvwAXhp3GEQUN3TwRt0YLxWLt7HHJtP89tbj4X5yytN9ZngEw>
X-ME-Received: <xmr:LNIUatifho2gNtocVs3qb9Nmwva0dVxbIq99FQfL2eRxjoD2HzHbfX4pwf9SZ-mG2GspVeSWUl26jO5UO8j_eskg7ar3MIsCWat6>
X-ME-Proxy-Cause: dmFkZTE9lY9/bCc0VvqYDJozxyc7EPwAoNvm4k4+7Jk+9XOs9uDxAJuZU6tdrVU15H0XNd
    GvElR0Vl/TZbzjQP4pBbv9hZgzqs7zFs1zzXTRvNAts2IQcO6B4TNiL0atyj7ltR/YJKuH
    +d04KzJv7unYmrbPxL0KDKiU+NwUUeX2N9Uye98DkI566zfRM3UOsA9L8qfyliMmiZs3cK
    MXRmFIuV+G9PZzP6ziTTKfYWbXtvLJo9Cqb0c+eXmghqUsP68OoAZHwlQfM8quQtjOo7Uw
    rSBlWhGpuGb3wUXSVyHbHaiwk1Fxvdztzf1pPLdguavtTgwXs+Jd9B0+XC7dZW5t2TfbdI
    NjzC7AR6qpfZJuuOZzsRiAnStuyP7iuETinfWP4t56gek/2CjIBsjp4414rHYzrrEicAcb
    sEJu4SOyRE2Q8TIGoWj+gh6UpQA1VeN81EB1TpRi42L2lAHTsJooZGndt1xwmYbct+3uO3
    v48ZoSq63nmfAkd9qtYZF988sLCGVMZlkmAYV9SyyNT6Fe3m0SaCLH2Qh7eXrgJdVmZmE8
    kTMlCuCre9LHK1oUN3RHO7H25445Zrobay6pZBP5RODXpf8BPNDrpAcYd/Gb/grRnW1RVO
    /T6QULDZdDZN6j6Zuta7RAcjPFFZ88dryY98W5fjVTuBrrUeAjTzaDl8mQlA
X-ME-Proxy: <xmx:LNIUarWO-8Q-GuYZnG2-B30uPj3C_puEEDDQNa6AUJibHDMe1HPbDA>
    <xmx:LNIUakUwpMwpQrUVQgb74AFMtJJnPbMGpm3ErH1lhXreXWDGmCjFgw>
    <xmx:LNIUajiqEoqDOqYAx9uKx-w9oe8C2tJEzbO5NGr6EnLv6xUHAQyBFw>
    <xmx:LNIUanZAiRgwIV-g1Tzkyl5MYg35XjKx6nvhhFzM9aNJ7gse4jaEMA>
    <xmx:LNIUaj-q67qj9z6jCKp89_piw7C2qAL9r7Sd8uwkAEkc8EFwCgL0LJjs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 18:50:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Jeff King
 <peff@peff.net>,  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v2 2/3] commit-reach: deduplicate queue entries in
 paint_down_to_common
In-Reply-To: <fc38c0f856e93b80073ec3f1b9f641b9ab187e4e.1779719286.git.gitgitgadget@gmail.com>
	(Kristofer Karlsson via GitGitGadget's message of "Mon, 25 May 2026
	14:28:04 +0000")
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
	<pull.2124.v2.git.1779719286.gitgitgadget@gmail.com>
	<fc38c0f856e93b80073ec3f1b9f641b9ab187e4e.1779719286.git.gitgitgadget@gmail.com>
Date: Tue, 26 May 2026 07:50:18 +0900
Message-ID: <xmqqzf1ncded.fsf@gitster.g>
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

> From: Kristofer Karlsson <krka@spotify.com>
>
> paint_down_to_common() can enqueue the same commit multiple times
> when it is reached through different parents with different flag
> combinations. Add an ENQUEUED flag to track whether a commit is
> currently in the priority queue, and skip it if already present.
>
> Introduce prio_queue_put_dedup() and prio_queue_get_dedup()
> wrappers that manage the ENQUEUED flag on enqueue and dequeue.

OK.  I guess an obvious alternative design would be to have an
associated hashtable for deduping, or tweak prio_queue_get() so
that it notices duplicated entry just before it returns (i.e.,
peek and discard until queue->array[0].data is different from
what you are going to return).  Both would not beat the cheap cost
of using a single bit per object, I guess ;-)

> This change is performance-neutral on its own: the O(n)
> queue_has_nonstale() scan still dominates the per-iteration cost.
> However, the deduplication guarantee (each commit appears in the
> queue at most once) is a prerequisite for the next commit, which
> replaces that scan with O(1) tracking.
>
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>  commit-reach.c | 27 ++++++++++++++++++++++-----
>  object.h       |  2 +-
>  2 files changed, 23 insertions(+), 6 deletions(-)

Thanks for the clean-up in the previous step, by the way.

> diff --git a/commit-reach.c b/commit-reach.c
> index 5a52be90a6..85583ae359 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -17,8 +17,9 @@
>  #define PARENT2		(1u<<17)
>  #define STALE		(1u<<18)
>  #define RESULT		(1u<<19)
> +#define ENQUEUED	(1u<<20)
>  
> -static const unsigned all_flags = (PARENT1 | PARENT2 | STALE | RESULT);
> +static const unsigned all_flags = (PARENT1 | PARENT2 | STALE | RESULT | ENQUEUED);
>  
>  static int compare_commits_by_gen(const void *_a, const void *_b)
>  {
> @@ -39,6 +40,22 @@ static int compare_commits_by_gen(const void *_a, const void *_b)
>  	return 0;
>  }
>  
> +static void prio_queue_put_dedup(struct prio_queue *queue, struct commit *c)
> +{
> +	if (c->object.flags & ENQUEUED)
> +		return;
> +	c->object.flags |= ENQUEUED;
> +	prio_queue_put(queue, c);
> +}
> +
> +static struct commit *prio_queue_get_dedup(struct prio_queue *queue)
> +{
> +	struct commit *commit = prio_queue_get(queue);
> +	if (commit)
> +		commit->object.flags &= ~ENQUEUED;
> +	return commit;
> +}
> +
>  static int queue_has_nonstale(struct prio_queue *queue)
>  {
>  	for (size_t i = 0; i < queue->nr; i++) {
> @@ -70,15 +87,15 @@ static int paint_down_to_common(struct repository *r,
>  		commit_list_append(one, result);
>  		return 0;
>  	}
> -	prio_queue_put(&queue, one);
> +	prio_queue_put_dedup(&queue, one);
>  
>  	for (i = 0; i < n; i++) {
>  		twos[i]->object.flags |= PARENT2;
> -		prio_queue_put(&queue, twos[i]);
> +		prio_queue_put_dedup(&queue, twos[i]);
>  	}
>  
>  	while (queue_has_nonstale(&queue)) {
> -		struct commit *commit = prio_queue_get(&queue);
> +		struct commit *commit = prio_queue_get_dedup(&queue);
>  		struct commit_list *parents;
>  		int flags;
>  		timestamp_t generation = commit_graph_generation(commit);
> @@ -132,7 +149,7 @@ static int paint_down_to_common(struct repository *r,
>  					     oid_to_hex(&p->object.oid));
>  			}
>  			p->object.flags |= flags;
> -			prio_queue_put(&queue, p);
> +			prio_queue_put_dedup(&queue, p);
>  		}
>  	}
>  
> diff --git a/object.h b/object.h
> index 2b26de3044..8fb03ff90a 100644
> --- a/object.h
> +++ b/object.h
> @@ -75,7 +75,7 @@ void object_array_init(struct object_array *array);
>   * bundle.c:                                        16
>   * http-push.c:                          11-----14
>   * commit-graph.c:                                15
> - * commit-reach.c:                                  16-----19
> + * commit-reach.c:                                  16-------20
>   * builtin/last-modified.c:                         1617
>   * object-name.c:                                            20
>   * list-objects-filter.c:                                      21
