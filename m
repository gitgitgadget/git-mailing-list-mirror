Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0640A40EB91
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159947; cv=none; b=ORQfyWiqAy7Iljvc6p7a0kerm1Bj8arMh2gpfUr6ti9wez9IjHbgLrh+0ZFA/ORTuYKZci1KyQ0hhxMswOQpTcTmxwwOKBuNCc4qc7+lPYg0nyXnkT8r+4LviaNmsyMOacpVinklAoVyVsb2eQwMuaGHRMXxEU/jmKxXCGMl0Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159947; c=relaxed/simple;
	bh=xAxcjq0DO3utuDRAyh86EQWWfP8p3ZQZG8hxyzl6AbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t/b5aw/e+Wx3w/UqqLOAb2BHMkdD4+GvaAEc1ATqNtRm0ycgOHb1KFqxKGUC/tBaTBrHHR1FdsH4kQOIbKC63Em6cp/3q9iIDy392Jnvc9xj0BfGWNONkCpjwUftDirnkgKLBJkV30maJE8OxvxOutGMoeRimJQBR9UHExhnLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gz7gkI0q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IhJnuj2J; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gz7gkI0q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IhJnuj2J"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 36EB0EC0180;
	Mon, 27 Jul 2026 09:45:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 27 Jul 2026 09:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785159944; x=1785246344; bh=WfjxqaXlOf
	f0b6klYQ/Iaglqpgpn0Ha3Ny8oP7kjnjE=; b=Gz7gkI0q8hvnQuOMGcGQogZORJ
	Zo2VnEv7JVRWZnjaS5c0UmiLlIi1grNQDlS6ztGxpMG5ZkYikl4c38SbEv0WDF8X
	UA17MrV8O0XGal3k77bUw+5BowsilKotVsxdX7DsjiF4T24wWGYubmPWJokb1kh0
	XPDJnatyuD6XJDoW4bUfU+MyY9lhPsmw0KcmL+224Xl90gO9kUX2R3ezFtI8QJtt
	ASk/zmj+tEin9lzQyu5Bfu1ZeHztb8dJnyjzTibuu9g4JRvmyiC1rynBwPwmb1+M
	trXsGV2yqlsf9i9lXr/guNuRfl+IP8ZNtpqSpaFXsbetqtp2YKDxfQdUV6fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785159944; x=1785246344; bh=WfjxqaXlOff0b6klYQ/Iaglqpgpn0Ha3Ny8
	oP7kjnjE=; b=IhJnuj2JWLGtIwSQ8ASCuggioJDAi11xddTXWK+SnjtyowIyuDy
	AiVM+9fCRP/3Sb2J3NXPbLMmUqtAudepgvZtF8tu4TWO85uUOgNIbrV94eoAf/BX
	sXPOPZDJ4cdNg6AXfEYFtmuoQbAS5ufndi4mdM69wZvxlHjFTxv7MpNFGwvT5ygB
	KAKFhE4W3Xe5sh5G8uk7L+RmDqZPlg4b4BpMktM+ZQHwg5HFx4zzKi4MklH6XEZX
	uc5sn6PhaMrmtnV/G2wW36UJZE8cBDLmu0aabCrprYJZE2PU+36k0m+ZEJq1As8P
	Nm/PDWiiyJb2BtzCcYua5bXDCx8y4UaP2Yw==
X-ME-Sender: <xms:CGFnaoq0NxRQsx-koRSN1CWyATRSfbzckqacEmgdcHdJwkxhqaAQ0w>
    <xme:CGFnaljBUN5dVfHZDcmGSdt_kanbclyz_ibuB2DTG6kVAm1EjpQW1MZjpjnkTRY5f
    FwccqHduOJV7qcmLvmGL8TS1gxVF32m1BPyXgpwqBtOluVAhjal0Q>
X-ME-Received: <xmr:CGFnalj1SWbjWuyFb9wNzaa2ljPsUhQJvVlQxCyuYikOhgRibVgA1Gx-pcqSu1wtBDP0hwKsYpXdQsx_0GTizWMM8cfL4-Tc2w>
X-ME-Proxy-Cause: dmFkZTE5QGFX9SCuQIgf/6jijCGGiCmD7IjCSfXGpp+fm33SYU4ppIAy6dZ3ZsKHV99zMA
    MotiNmJyuUAZPwOtrz8B5Enc6l/8drty/XeBpmO4zojibI/n7TdkUEBBb+PtI5771ZRFAW
    rZHdNfUrDY27zT1AQtd4p/6GGq43swddR8wp0FN/tidGUGm7hvsmJaMq082bcq1bGM0nmJ
    44vowRItG09/wPUG4rkr09XSam1DvhpdOJmvNrkb1hwMy8IlgODHaisYdcSXEiA/5O7gun
    GhnOOsljDqcfZo2Hu8QF+rm7P2bWUVRu0b7XZo2dA4hITN8wt/jv+wk6Po6K1FjJfMxPGb
    YoNNRZuwWZT3Ybn+QS5zrpPg5cyo60CUdvlb024cFmybzlGty0VVTLYBW9Db06eZMFUwq1
    +DoV9idEJhjvCpGIr2y5rsyPsRD0bZs3/9z7o3esMbqOLIJ7W+7AlxVqmwvxGl4dKfedUc
    CKBW+3LC/8Vt4juFmkAFcobolq94W29SIBUWSZIqOhUA7f0Qspy6C41o8qMe3S0VjTTDsT
    zVHJ86HvXSV23ANdA22Jjx1LykVPXRqVyvemyh6wpn4/XRE7zknT2djO5+prUKo9bQ5Ni0
    ku0EDLhsNTgzFkrObGMDAl6pB7mzMfWn4kK3r3rBz+KWUthtCwTDBzaZNTPQ
X-ME-Proxy: <xmx:CGFnariwqwKiWFnmwKBAj2jf33d9DCu27QbWR5N6xJV8jBBIvi1KYw>
    <xmx:CGFnalJLlRISpvkX_zmoqWWWBGqxTZHHFem-pOQpU3x7-_89pFfVhw>
    <xmx:CGFnaqEX0ZqEaIVg4fXB05E7tS-cWwLItFy9tsmMDflYJqmX9Wxwmw>
    <xmx:CGFnapT95oIbHuq5eVl663EMnkMbr2ptT3UlhqjDeJw3R4xz3JTOvg>
    <xmx:CGFnauwoUdNdtGGGXeqKR-vKm9gq8hunRKLU_VPggHRAO4gmdguWryof>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 09:45:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Michael
 Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH] revision: make get_commit_action() a pure predicate
In-Reply-To: <pull.2169.git.1784143793613.gitgitgadget@gmail.com> (Michael
	Montalbo via GitGitGadget's message of "Wed, 15 Jul 2026 19:29:52
	+0000")
References: <pull.2169.git.1784143793613.gitgitgadget@gmail.com>
Date: Mon, 27 Jul 2026 06:45:41 -0700
Message-ID: <xmqq8q6wpmuy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> commit_early_ignore() runs twice on the -L path, once for that gate and
> once inside get_commit_action(), but it reads only object flags and pack
> membership, disjoint from the TREESAME flag the fold sets, so the repeat
> is harmless.

This one confused me a bit, so I'll think aloud below to see if you
can spot where I am misunderstanding your code.

> +/*
> + * Whether the commit is ignored by the cheap checks that read only its
> + * traversal flags and pack membership (e.g. already shown, or marked
> + * uninteresting), before any check that examines the commit's date,
> + * parents, message, or diff.
> + */
> +static int commit_early_ignore(struct rev_info *revs, struct commit *commit)
>  {
>  	if (commit->object.flags & SHOWN)
> -		return commit_ignore;
> +		return 1;
>  	if (revs->maximal_only && (commit->object.flags & CHILD_VISITED))
> -		return commit_ignore;
> +		return 1;
>  	if (revs->unpacked && has_object_pack(revs->repo, &commit->object.oid))
> -		return commit_ignore;
> -	if (revs->no_kept_objects) {
> -		if (has_object_kept_pack(revs->repo, &commit->object.oid,
> -					 revs->keep_pack_cache_flags))
> -			return commit_ignore;
> -	}
> +		return 1;
> +	if (revs->no_kept_objects &&
> +	    has_object_kept_pack(revs->repo, &commit->object.oid,
> +				 revs->keep_pack_cache_flags))
> +		return 1;
>  	if (commit->object.flags & UNINTERESTING)
> +		return 1;
> +	return 0;
> +}

This mirrors what the original get_commit_action() did to return
early with 'commit_ignore'.  Collapsing the nested 'if' for the
kept-objects case is a nice touch that makes the result easier to
follow.

> +/*
> + * Decide whether this commit is shown or ignored.  Keep it a pure
> + * predicate: callers such as the commit graph depend on it having no
> + * side effects, so per-commit mutations (such as -L range tracking)
> + * belong in the caller, simplify_commit(), not here.
> + */
> +enum commit_action get_commit_action(struct rev_info *revs, struct commit *commit)
> +{
> +	if (commit_early_ignore(revs, commit))
>  		return commit_ignore;
> -	if (revs->line_level_traverse && !want_ancestry(revs)) {
> -		/*
> -		 * In case of line-level log with parent rewriting
> -		 * prepare_revision_walk() already took care of all line-level
> -		 * log filtering, and there is nothing left to do here.
> -		 *
> -		 * If parent rewriting was not requested, then this is the
> -		 * place to perform the line-level log filtering.  Notably,
> -		 * this check, though expensive, must come before the other,
> -		 * cheaper filtering conditions, because the tracked line
> -		 * ranges must be adjusted even when the commit will end up
> -		 * being ignored based on other conditions.
> -		 */
> -		if (!line_log_process_ranges_arbitrary_commit(revs, commit))
> -			return commit_ignore;
> -	}
>  	if (revs->min_age != -1 &&
>  	    comparison_date(revs, commit) > revs->min_age)
>  			return commit_ignore;
> @@ -4314,7 +4316,23 @@ struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit
>  
>  enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
>  {
> -	enum commit_action action = get_commit_action(revs, commit);
> +	enum commit_action action;
> +
> +	/*
> +	 * For a line-level log without parent rewriting, fold each commit's
> +	 * ranges as the walk reaches it (parent rewriting does this eagerly in
> +	 * prepare_revision_walk()).  Fold before get_commit_action() so the
> +	 * ranges carry across a commit that a later, cheaper check ignores;
> +	 * the commit_early_ignore() guard skips a commit get_commit_action()
> +	 * would ignore outright.
> +	 */
> +	if (revs->line_level_traverse && !want_ancestry(revs) &&
> +	    !commit_early_ignore(revs, commit)) {
> +		if (!line_log_process_ranges_arbitrary_commit(revs, commit))
> +			return commit_ignore;
> +	}
> +
> +	action = get_commit_action(revs, commit);

The primary change in the patch is to lift the "line-level" code out
of get_commit_action() and move it to one of its callers (namely
simplify_commit()).  The other caller is known not to trigger the
affected parts of the function, which was discussed previously at
https://lore.kernel.org/git/xmqqtsqxfdl4.fsf@gitster.g/ and started
this leftover bit.

We used to call get_commit_action() to decide the fate of the
commit.  If get_commit_action() returned anything other than
'commit_show', simplify_commit() simply returned that action without
doing anything further.

The original get_commit_action(), when on the code path that calls
line_log_process_ranges_arbitrary_commit() to check if we want to
ignore this commit, did what the commit_early_ignore() helper does
in this version before reaching that point.  So this updated caller
in simplify_commit() recreates the exact same logic.

We do end up executing the commit_early_ignore() logic twice if
line_log_process_ranges_arbitrary_commit() does not tell us to ignore
this commit.  With only two callers of get_commit_action(), we could
easily reuse the result of commit_early_ignore() if we wanted to, but
it is probably not worth it.

So the patch looks good.  Will queue.  Thanks.
