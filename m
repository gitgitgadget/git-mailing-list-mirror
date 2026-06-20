Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF3234F26F
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781967408; cv=none; b=A2rDWED0Ym1CDfQy8yc4QGPpFrnbo6kkIE2WNzB6OpL+rWK2jqD0yTMq8VfJpuNg0awuYdF63Ne1hlvYJad1d0/hZUIcRilC0YEQiTQi4k/Iyc123OBbmpdrINiWUmQrFcrDxR4sVOtqEQ6Nyqj1rXl+/RVFuf4qzKo8n10NeQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781967408; c=relaxed/simple;
	bh=jcdzTgSPkRxZlaTfYW81H9b4eWEOzxkU2ZPqXsY+jtw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g2MFZyE4rmUoRhdHxeN3G1eWrij14afKDG0WZsa4hzq1Z8Ga+BTlxdzvWPYnE9GhVRKKlfcidj0naXQdTmQtcF0E10CXLNxE2j4ggn5d3VHjHpAnfAfsS2Eyd93NqUayZCAmGlHkHQe/fKi7Dn6B3QzBERb6gfy+VXEj7j3D+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yy5dmfVA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b1Qv8Nm+; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yy5dmfVA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b1Qv8Nm+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7E0E0EC0121;
	Sat, 20 Jun 2026 10:56:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 20 Jun 2026 10:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781967405; x=1782053805; bh=Z/bpa4o6wq
	dzHxrbqodVEt/oqOSxpEXElKz9uZKhfYQ=; b=Yy5dmfVAGQtH/sa8e4A0j+wyFj
	oTx3MOT+UoqZAwZwWeYjCN8Os0sj7IikN52fz+DVA2UapJ64I3Hal5J8Ac2XLwe2
	wZLSVWT+lfurx9Pkzem+WlADrlTCzVFGSZhwCoqLuuFh9CFcZJ87tDEiSFEZNBg3
	phlrpvnTsmCsMFgdoBL30upOin22qhb1SNyphDdNAgYTl0Ref2ZpFS4kJpdh2Dpb
	cxdfzDuN704krAcMpiKAA7PTnN9q29SV+bj/iVu/3awVvSzzMmAx4DSDlcyM9DGD
	HbQHVJMo9Ko4X/BfOnHtkZYlynT7wvWd5k/EWvzSz3YLvufQqRRYR5KfrJqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781967405; x=1782053805; bh=Z/bpa4o6wqdzHxrbqodVEt/oqOSxpEXElKz
	9uZKhfYQ=; b=b1Qv8Nm+fsZzbVhc3w6skE+1Q7lf6YvEGeawtEci34sscKPf0l1
	loLAVJFTR2hpy5uUrcKIEdG5vR+BDELSKy5J9LRsNBaDnVseC4Dk+A2YKCkz/KjY
	yEDqErswEv2AjPVB3106Jhh3kTwLOvEVTRTujqBewF1rLTM+8F6NI2t8Nb71mxt4
	7OoZGVmG24okDcnn4uDoqJDq2HTvvWRW0nqhCg9nl5LTUevswQzm2JVetn/migLk
	J8BrPW68cs5RRIRKDEpCMqJ1wFBRaIFV/fHzXSVgg6osEgS7HTkhEHroLvGFkIrO
	LZorHSMvKTy0ijR8mMME3EQkOcrsPMK/fzA==
X-ME-Sender: <xms:LKo2as085GXjkleHe6isa8uBMk8j0Uku8JyH1ujBqTniWlLhZ4TgwQ>
    <xme:LKo2atmwN6k4xlMbRPjEJHtmFYeoeZjQ6adH1NGVPrxmVxb-v_cdZUgrqYXTXnyIm
    GIaoc3EFGJ3itk6WURUgLc2jdPZ05N9hr5qMX2fc55vn6DsiR22d5U>
X-ME-Received: <xmr:LKo2ai5Nj-RPcYoXx1cJ0rdwqZAtJ-QFBKcUP7K9wCbF-IfF6TYZtaDXmwMdFPTbY1_ugdVrmIxEeuBJePdct5zrOC5-02AyQ25FDvo>
X-ME-Proxy-Cause: dmFkZTGGrh7CpPOjWxP5HkQuf3cnsLYeVf8t+btcOMzcWqW8euI/e5MmYypyVs0tMMozJm
    Z4Da84Ve0Xe+AtdEBL04IHS5SOjp4S1m+XCT1SameYrXnZmqh0+cwfdXRHCkwJ0hPa6U96
    3kVbuhdQMsnyJRxG5EAKWL6ACxPZLDnJbC7zYBD96Xm+ofP0qjxX2pfSBbp1xv/DQ0DHF1
    oeqIi/9BASp98UnKTIYVTWq4mZXs0+WqQDokLXr/auU4xTuQzrxGnpaHxvPnCKLKCSI234
    vesNLytkjaR05JxO45uAWqMHSNCMpBKPoFKHkOBctSvKGuxmWUvLrXqVxn1hIMEasEmOVO
    DLU21uyaN+3gCZWncqUBDuVcTWOY7/sW2tVmBVhPPxaAZ8IV74VW4C76mGfg2oqdvwQL6o
    BoyDf0oJwXhO0uQ+hB4llloKv57Ei0LV+JWcimdn6FqjuShRB6zWr07+aiQRlH/pGVBc6Q
    NSWT9mukC1K1qhsf482E/hayIqr2k0LxgY88DefdKQEo/CITr4IVLqHBForx2oBbac4AzE
    MEwCqlJL324mLLbBOkPtBIpJeFcnJUbPB7A3IeOh3gn0PdNyLwi6zCWtF+hgavHTLXsjAG
    k2vv4vjFtXFgoeQqvS0SLObRaeRXU8oo80sjlHZUnF4ocYC5cQMlPFT9A02w
X-ME-Proxy: <xmx:LKo2aol8bSgX4yAQ-LwYuPU4_JzFHrTrT45mAOAc0loFqmsPus62Sg>
    <xmx:LKo2alX_uqosHZvWngRHCJSC_yRlpHWcl4dfZke6pacVihW2K2tjtA>
    <xmx:LKo2apQIJ2m3T7TX_9jeS_gsZPOvfTyh6fDxMwwghMAZaMTe8PFjWw>
    <xmx:LKo2aqDsOt8yQq93hhNVMzjqXM52W4lgGQ0vcDgwcWD5xoCThyAs3g>
    <xmx:Lao2ar8ADVQgeb3jHzcEkl0qyU1JRFOwqYmGimbfKYsRTR0P5hqfMVTO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Jun 2026 10:56:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  krka@spotify.com,  ayu.chandekar@gmail.com,
  chandrapratap3519@gmail.com,  christian.couder@gmail.com,
  jltobler@gmail.com,  karthik.188@gmail.com,  peff@peff.net,
  phillip.wood@dunelm.org.uk,  siddharthasthana31@gmail.com,  Kristofer
 Karlsson <stoansen@gmail.com>
Subject: Re: [PATCH v6 2/3] revision: add peek functions for lookahead
In-Reply-To: <20260620-ps-pre-commit-indent-v6-2-cdc6d8fd5fbc@gmail.com>
	(Pablo Sabater's message of "Sat, 20 Jun 2026 12:11:51 +0200")
References: <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
	<20260620-ps-pre-commit-indent-v6-0-cdc6d8fd5fbc@gmail.com>
	<20260620-ps-pre-commit-indent-v6-2-cdc6d8fd5fbc@gmail.com>
Importance: high
Date: Sat, 20 Jun 2026 07:56:42 -0700
Message-ID: <xmqqzf0pfefp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> The graph code in a subsequent commit needs to be able to look ahead in
> order to set indentation-related flags.
>
> Using revs->commits is brittle and the data structure that holds the
> pending commits might change in the future.
>
> Add two functions that abstract this for the graph.
>
> Helped-by: Kristofer Karlsson <stoansen@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  revision.c | 38 ++++++++++++++++++++++++++++++++++++++
>  revision.h | 10 ++++++++++
>  2 files changed, 48 insertions(+)
>
> diff --git a/revision.c b/revision.c
> index e91d7e1f11..a472a28853 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -3708,6 +3708,44 @@ static unsigned int count_explore_walked;
>  static unsigned int count_indegree_walked;
>  static unsigned int count_topo_walked;
>  
> +struct commit *revision_peek_next_commit (struct rev_info *revs)
> +{
> +	struct topo_walk_info *info = revs->topo_walk_info;
> +
> +	if (info)
> +		return prio_queue_peek(&info->topo_queue);
> +	if (revs->commits)
> +		return revs->commits->item;
> +
> +	return NULL;
> +}

OK.  "If we are doing topo_walk, topo_queue is the priority queue to
peek into, otherwise revs->commits list is being used" is a bit too
intimate implementation detail I am not comfortable to depend on,
but as long as it is contained inside revision.c it should be OK.

Lose the space between the function name and its (parameter list)
from this and the next function.

> +int revision_has_commits_after (struct rev_info *revs, int n)
> +{
> +	struct topo_walk_info *info = revs->topo_walk_info;
> +
> +	if (info) {
> +		int visible = 0;
> +		for (size_t i = 0; i < info->topo_queue.nr && visible < n; i++) {
> +			struct commit *c = info->topo_queue.array[i].data;
> +			if (get_commit_action(revs, c) == commit_show)
> +				visible++;
> +		}
> +		return visible > n-1;
> +	}
> +	if (revs->commits) {
> +		struct commit_list *cl;
> +		int visible = 0;
> +		for (cl = revs->commits; cl && visible < n; cl = cl->next) {
> +			if (get_commit_action(revs, cl->item) == commit_show)
> +				visible++;
> +		}
> +		return visible > n-1;
> +	}
> +
> +	return 0;
> +}

Regarding the use of get_commit_action() here, I wondered if this is
safe, because usually get_commit_action() is called only once per
commit during history traversal from simplify_commit(), but this
patch adds calls to it for all of the remaining commits being
processed without consuming them (so get_commit_action() will be
called on these commits again later as the history traversal
progresses).

If get_commit_action() a pure function without any side effects,
this may be safe, but line-log has something with side effect in the
function.

I _think_ this is OK, as "--graph" sets .rewrite_parents bit (as
well as .topo_order bit) on, which makes want_ancestry() to return
true.  Which in turn means even if -L is in effect, we will not call
line_log_process_ranges_arbitrary_commit() that is the only source
of side effect in this function.  Somebody needs to sanity check
this, but we may want to leave an in-code comment to warn future
developers not to call get_commit_action() on random commits outside
of the normal history traversal under what condition (namely, -L
without rewrite_parents).

Even better, perhaps add

	if (revs->line_level_traverse && !want_ancestry(revs))
		BUG("do not call this");

at the beginning of revision_has_commits_after() function, and
describe why in the header file comment for this function below?

> diff --git a/revision.h b/revision.h
> index 00c392be37..a10c6b0940 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -572,4 +572,14 @@ int rewrite_parents(struct rev_info *revs,
>   */
>  struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit *commit);
>  
> +/*
> + * Peek into revision's next commit without consuming it.
> + */
> +struct commit *revision_peek_next_commit(struct rev_info *revs);
> +
> +/*
> + * Check if there are n more commits to be shown yet.
> + */
> +int revision_has_commits_after(struct rev_info *revs, int n);
> +
>  #endif
