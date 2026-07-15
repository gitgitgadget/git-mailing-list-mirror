Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0864B3749F2
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784135857; cv=none; b=GAVT2yYrTfjIpR7IGO8B/vm+awDBropKv8vkxstQwwSEd1xIEycc/VzA7EVY9/Vjeq9A9uUXj/IdBSL7pFtgGvE1yyaQKz+16SPP24s8nhwBNJmJ945UIwM3wqKJ4X+r8BJSOerOyy+ag5JZl0y8oROGRhBbTBaD8HiSJj5c6vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784135857; c=relaxed/simple;
	bh=yx197Pg00g2SfVx2zGB4LZaZkCr9+9v3ypBkC/XlCHM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y2NFEkPIz5Jvot1tYZRif9nIRTMeiHzcCWhtuuoCOHfNcs62iqvvwuIbHpQcdYSmXimUtXq+N0IRB0pYa47WafY8vD+hBB5uPS9zrcBk1kVrGePle9/Yp4L2QKdkJhnvxtbhsWLlZX5fRpSQmejKm1HskgRzoNYTr6ezNxeaD7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KSnHBDXf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jRSaLuNe; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KSnHBDXf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jRSaLuNe"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 0FB04EC0259;
	Wed, 15 Jul 2026 13:17:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 15 Jul 2026 13:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784135852; x=1784222252; bh=zYpAjefYml
	PnheFgrtsqFG2VnljR8Je0bVv56bkojyQ=; b=KSnHBDXfNEXJ08QbZnrXU76PXS
	oyAJE9YJjOIEBLLfBKQoM6y1VK0oOmKoZ1MAQco+1VANllr+N/ebWJ9oGYvya2Qj
	VSkDu3PJohyHEzgzfdd3cK7N/QzWZmq+kdmSHLdkx8F0j4kT0o3jn0/deHqvoQ6h
	ubIdyGwlqq+0WdwS6B5q83ZGKTdn+d+t1o7qC4uCyjxs5niDO8hkHkUNoOEZuo6Q
	GUzg+VxwE27ts64tAMgN1EFq1rmA3wHWLeGEoHeg6JbTh6icQsPvewUbDgkQFyit
	x9OJLKpIdMacATf7ehiPXz1iqK9pjzU2qv2e6ikWWzpE3K2qgY8529fMi1lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784135852; x=1784222252; bh=zYpAjefYmlPnheFgrtsqFG2VnljR8Je0bVv
	56bkojyQ=; b=jRSaLuNeuITV1znO0rsNMHjm1NAXayE9K0AdoKOFsTUb1cbhosK
	G40gL/XXlNl4LPKB7P3YeZ8ZheEIPlhF3/XAOlE2b4PhLt4kevmsqnn7QbOsy4xh
	FdqLF+fmHgEwPuH9eWFco0KCY/EMb9lu7aSIP4YeCbzR/Q9V59v8CHNBQM8wNjr7
	uJ7+r2SEgzj/mOapq0xpuJx+j2KVY+l3gy6T2Dp2H/yN7lzYhTVEAQAWN3Uxui53
	Kt7rWjJ/jvEINLQqY/KE0K8sJ7LNV8QifBZRUPIgvJ3EsqoUdKWtikOBZ8wT5e1o
	R4P0rYKPqjvLrpmInR44fDFn2rTjyQsERlw==
X-ME-Sender: <xms:q8BXaiivzXLQc_8RbOaesJAtoUmvODfN9TXy4vbR9NGNfyVn50BqOw>
    <xme:q8BXaqd7o4dSp4jX5AUXwaFEmXLTUkHLJFpQHHxXZ6DZ-Ho3_2BQWHYgLPPquTdCu
    sF-pcw1xmYbyfoehzL8gV5B-ZiuGOW3zoX4tTnnttPZ96OW3Bu8jw>
X-ME-Received: <xmr:q8BXane4JabPo8Ml_v6Dv4OWgNMEdGJFd_qX_SbBY8RhWyIsLpj4zPqiIZKzHpSQ8-raDiivxyc0yIrRYqKQ5cMC9Qw9wSzTFObEzo8>
X-ME-Proxy-Cause: dmFkZTFQDRwRoks5jeDPDIm/s/lUWyhm/xy3nBc9B+wlIiJvKwsbvoGoV+xNIY7lKp/yHn
    viydVd3dkK8FY8VKMV90FLPm9U1doi5XGMofAFHVs4FaCJALDBNMh2T1BufF1UPueCIuls
    9hOXVrF1SuIRdsFTHh1OctK4sTUFkbEfERVFHm1BjOSjQSuRH8D+LWvdaQtwGvAWknAnNP
    pIASbzAA0cq8s/oSzTZP0zI9C+HDW6Jk9A8BpaEG9QbbBNeKAEVqxG6MpyXSTzZC3+aqQS
    WOE5uo34A3dQhn0ElwOaLjrnaywC/dMDw1cLEqZ+C/tWGwbXjlZwgRgY9eUrWq15HdmIrY
    nd8gH+bO7qbETYCt7KIZchi6vYrmtUUVNKViD0+LQnsgNmq8+DZGczgSNJyk1teQmrh4RA
    tq1M1bdd90D9iMkiFjppzrZrOaq9NvKQQ2neV49zJpRwOoEdUdwxoR1y/gQMmin3z1BaiG
    jexZH6YG4IZnr4oeerEkZYE9TDrxnJbPge0Mx+03dhz1L+xsMiw2kZTRm7X1MQyuvUSVee
    casinTDRWd5YkRgm9cRKeJXPi/qVQopoCx2DykW2ilLVIT0D3gEulqx96iDbXST8mCxP22
    nQcjVjigvzIs/BN+uagEMlBw558EKXL8z1v5RdEkYNOpz3T87g953/weVt2A
X-ME-Proxy: <xmx:q8BXak_4SMrdq44nFtEeK8FT_sOdMjyeq0A9NWQMkS09N-0TR65J2A>
    <xmx:q8BXajkvXoWSKZNG4UOQ50N3Ex_2hAcIxmERAByi42ESWoGIEimHfg>
    <xmx:q8BXam_SpGiUUKAFsUH-mw0ekO7sSlqVW6kz5R4XltRlgSohZ_4jCA>
    <xmx:q8BXahldZFHbc1--D7QcSSn0TWGHGTy-ZdyA4QLospKFXnQnTt6gjA>
    <xmx:rMBXaqecmkjF9T1uBcoBgalQly5jPGNl_OhCaJ3C0FhNyqPkf3CBhw1Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 13:17:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5] show-branch: convert per-branch flags to commit-slab
In-Reply-To: <20260715120156.53025-1-gatlavishweshwarreddy26@gmail.com> (Gatla
	Vishweshwar Reddy's message of "Wed, 15 Jul 2026 17:31:56 +0530")
References: <xmqqwluwpvme.fsf@gitster.g>
	<20260715120156.53025-1-gatlavishweshwarreddy26@gmail.com>
Date: Wed, 15 Jul 2026 10:17:29 -0700
Message-ID: <xmqqy0fcnpee.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com> writes:

> +static struct commit_rev_flags rev_flags_slab;
> +static int flags_stride; /* number of uint64_t words per commit */
> +
>  static struct commit_name *commit_to_name(struct commit *commit)
>  {
>  	return *commit_name_slab_at(&name_slab, commit);
>  }
>  
> +static uint64_t *get_rev_flags_ptr(struct commit *commit)
> +{
> +	return commit_rev_flags_at(&rev_flags_slab, commit);
> +}
> +
> +static uint64_t *peek_rev_flags_ptr(struct commit *commit)
> +{
> +	return commit_rev_flags_peek(&rev_flags_slab, commit);
> +}
> +
> +static int has_any_rev_flags(struct commit *commit)
> +{
> +	uint64_t *f = peek_rev_flags_ptr(commit);
> +	int i;
> +	if (!f)
> +		return 0;
> +	for (i = 0; i < flags_stride; i++)
> +		if (f[i])
> +			return 1;
> +	return 0;
> +}

We are no longer limited to 26 or 64, which is excellent.  Early
in "git show-branch --help", we prominently say "It cannot show
more than 26 branches and commits", which needs updating.

I wonder if we have enough test coverage for this command.  If we
were paranoid, we might have had a test that feeds 30 revs to make
sure the command fails, which would now fail with this change.
We should check if any existing tests need updating, and write a
few new ones to ensure proper coverage of the expanded limits.

> @@ -226,34 +285,34 @@ static void join_revs(struct prio_queue *queue,
>  		      struct commit_list **seen_p,
>  		      int num_rev, int extra)
>  {
> -	int all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
> -	int all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
> -
>  	while (queue->nr) {
>  		struct commit_list *parents;
>  		int still_interesting = !!interesting(queue);
>  		struct commit *commit = prio_queue_peek(queue);
>  		bool get_pending = true;
> -		int flags = commit->object.flags & all_mask;
>  
>  		if (!still_interesting && extra <= 0)
>  			break;
>  
>  		mark_seen(commit, seen_p);
> -		if ((flags & all_revs) == all_revs)
> -			flags |= UNINTERESTING;
> +		if (has_all_rev_flags(commit, num_rev))
> +			commit->object.flags |= UNINTERESTING;

I am afraid these two do quite different things.

In the original, a local 'flags' variable is made UNINTERESTING,
which is then used in the 'while' loop below to inspect and
propagate the UNINTERESTING (and other) bits to the parents,
without smudging the current commit itself.

In the updated code, you smudge the commit in question itself with
the UNINTERESTING bit.  Won't that prevent this commit, which is a
merge-base, from being shown?

>  		parents = commit->parents;
>  
>  		while (parents) {
>  			struct commit *p = parents->item;
> -			int this_flag = p->object.flags;
>  			parents = parents->next;
> -			if ((this_flag & flags) == flags)
> +			if (has_all_rev_flags(p, num_rev))
>  				continue;
>  			repo_parse_commit(the_repository, p);
>  			if (mark_seen(p, seen_p) && !still_interesting)
>  				extra--;
> -			p->object.flags |= flags;
> +			{
> +				int _b;
> +				for (_b = 0; _b < num_rev; _b++)
> +					if (test_rev_flag_bit(commit, _b))
> +						or_rev_flag_bit(p, _b);
> +			}

This part also behaves quite differently.  The original checks if
the parent already has all the bits in 'flags' (including the
UNINTERESTING bit) and avoids traversing further if so.  If the
parent is missing any of those bits, however, they are
propagated down to it.

In the updated code, you do not paint these parents
UNINTERESTING at all.

> @@ -263,7 +322,6 @@ static void join_revs(struct prio_queue *queue,
>  		if (get_pending)
>  			prio_queue_get(queue);
>  	}
> -
>  	/*
>  	 * Postprocess to complete well-poisoning.
>  	 *

What is this change about?

> -		warning(Q_("ignoring %s; cannot handle more than %d ref",
> -			   "ignoring %s; cannot handle more than %d refs",
> +		warning(Q_("ignoring %s; cannot handle more than %zu ref",
> +			   "ignoring %s; cannot handle more than %zu refs",
>  			   MAX_REVS), refname, MAX_REVS);

Indeed.  Since you are no longer limited to 27 or 64 bits, it is
certainly nice to see that the code is prepared to bust the %d
limit.  ;-)

However, our CodingGuidelines document says we cannot portably use
"%zu" yet.  Can't we use an unsigned long or something more
established here?  We surely do not expect to ever fill the full
range expressible by size_t.

Thanks.
