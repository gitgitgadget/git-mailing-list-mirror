Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D2E484255
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940133; cv=none; b=ET8SRl8ilCDq1Bm8FBeJQdJVpf0iTwVWOH7CZ75gC5w9oom+YbTsBo9AAp98/LDbLM0ppgdS23uPrEn2f5LS/FDZMMT0EUmwESCLMpf7JJ450JPmiVre753/NMznCTg+6EvKcxpRA0gOokDGhUo3m19Vz9GLpOSInQtDTmhYeHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940133; c=relaxed/simple;
	bh=Jn0sYFR1JRc5OmZ6sNhvn05BgU4lpG0/69imyiuv7Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4ca3RkCAT03dPNOhpp09inIhgp5WXWH1dRdxHTgtuhVsAZgO20ud6ZaBFH4comVQqIfr2twkKefGNE0JMdslLV17T0mI4pyx2UdaJHd/RnPxc65Cuhp1tu1ZlizyGM8aVkB97Up4PPkiB/6QuFQmnDmSBlEJnOPQd92lmVLL4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eZjUycvg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JHy2lD4U; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eZjUycvg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JHy2lD4U"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 471C8EC02E1
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 07:22:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 02 Oct 2026 07:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790940130; x=1791026530; bh=yQcimWgvwO
	yTBbsUt5+dUXvwib7GRKIcreLiPlIgUnI=; b=eZjUycvgqagAMe4L2e1i/C68Z0
	uqQeuNtp3AyGg81e+K0GWqw224HpQ5sBIVJT48jjNosYddwQgkGYhIwBORLepvl6
	TWkQQidqFwY8ANRlgf/x8KelhkG9QuVwMM9u9XMigCXUfxVUj1JyhcTsJIbfh+1A
	EoOaYhWCK5t5VpB9gf0rn6GDKEgXnGaTSqXOSGJ3ek5Z8AgCpy3RtY57Lulbxf9T
	Oy2P/g1sxKoCXYI7jHjWX2I9uERkwLgFq7Hf9e8HhF+mltVcgWNelepfAqLfgfs7
	BDDqbnwzuzWIr7x18ht0HgEOO9zZvDU3gjFx6C2gmbkgURxSJ9YmQBvVKe3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790940130; x=1791026530; bh=yQcimWgvwOyTBbsUt5+dUXvwib7GRKIcreL
	iPlIgUnI=; b=JHy2lD4Ueur1KASUOSP//mvzxer2OKncVQS8xZThaPNWHjVZ2zb
	t1Vsk2/kfbx8XDDSxKCdA5QV3Fz6WH90y+ey5rtkzNzrId4vTHvAaickjUvuCOMO
	mJQ41xzs9xyzDCDDiVn5WNJkmv2fMd2G5sksngp9Qn+9ajMt6hgKfSYLotwdiarx
	90BSbg6hSfd63ATazkAerRHR6haxLjzH99PQEbc4RHpJ+ALahju80QttxegwYhb2
	g9YOvr/OtF7DJs9M5jh8pUQ+bd2DYcZq3oAGT4l4ZwwCbZL9vOzDUkeUT+SdngV9
	tWIOGM4gsjTkHGWxY0vsjGGaZiJrbU4LknA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790940130; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:jsIgFC9oUs4eElqrGL9O6MWt4Owt879q8lUOdlX11a/Txtl
	9BMwvZuxW4yLclenXW4OBLO/7UbkwDTG0kub0cSYJJfNXAi7CY/TOZO+Y/Uw8Q1t
	x+ROsxhiEpSgE1f3HmhwEnPGiiqgEOppMuEDIM42kwxWw0huoL2EEvFdHz4MP+6e
	uZx2jLXAIz0/S/KxwSpykQ/NBuTI6uezTygb5VUYsf2NL+6UF6GIVmUHVVjRVN83
	/ThqipZKsRoc2hHHP7Mj9vJsfKz5GmCjcZHN2/KhxaNGB0eF4pJ9a6HTepGynRMo
	O5OyhxL3Q3y+wAe5LqSuuzPF+zV8RDCWGrOH75w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:zeyPQ2KpuKeZiCrCOzV2O67TVZPbwa+GE4mORqe2s6Q=:Jn0sYFR1JRc5OmZ6sNhvn05BgU4lpG0/69imyiuv7Rk=;
X-ME-Sender: <xms:4ZO_aiNtHUFLncZIavcYw8USkUVdJ4pc2tpZ2vwQmn7OFrWSiheh4Q>
    <xme:4ZO_akorShcOM6ZD9YfBQRIycnQiTerBJdATH4oQVjalswc4GzD8JRBZm7Y5s-cSU
    OpH8VxtRff6UjemAqgKboSa1SDlZna5bf2JSGOL5SWf7psfW4wSRyY>
X-ME-Received: <xmr:4ZO_ajFFdOp0OZNg_vjUM7y0Fya9p4yFbpyNtsZZ1LzMuBsvFXYRZA>
X-ME-Proxy-Cause: dmFkZTGjPLKPrmizOma232HJNguG3zzM1P2r/5pIm32zvYlPabp2GOkogy8OHq5FTtJMbA
    aQUjI6w/BtQwY3OZAZv3ltxjcVUqbVdAGS/whqSQlCzuEEO8/ZdvGNmqeXnJ0bdQYOP+E7
    aePOTbdSF3oTexBs5IlfFHai9Ryc6LmjBKOG2iyU3NdSdd9y9J3Wx+xWRK6LqVKs550zc+
    zdBiz1GV4yq812mjoFydSVHwWz0ty9UPMdGhFWELB9ugR0Cw3Bcb5CKqtFJHYhq2NKf5+Y
    fSJMeFCzsl4wAw0bH90kHBTbAi/YCrnJyv9wPxqmT0BwIf5Fgf6FNXgYAc60NbeTIVAtSv
    encyJxJljvEmMD7IbKjF+NlQ7iNOF2NxTQa6oE28sJ88dyWqFDstfa4epRdoaUbr9BKWSU
    UdKUhc8g34dCKjoCsAXDvbiofTI9cOedCiEPLkk33oat+su13MUbao/jKm8KBz/eBEYP9I
    vYcdCTLLLMbY71MIzcaPNBQejW45Cl7x7tkdPf8+fm7cUaH/BLpWtoZoLHBKb8iufoZ0X8
    gh2d60fdLvLJUzC215zNd3sCNywpvp9uzuPTDgxbbJQpR6ilKu1TIlSzCnSW0KUvK+LFIi
    veIXh90+fkQO7BfxvYTDPmEHzalj5piUASrcylRqxff8cVMhgo+TQv/bFGdw
X-ME-Proxy: <xmx:4pO_aprrxHTxGIqkt_uoyRZCc8k6Q_Zx7aivCWB_5_E7HNCNeYsuhA>
    <xmx:4pO_asZ78seM9SrnorYao3cENDjeDRZ50qyck5dgjXN3yzPfmgbGXg>
    <xmx:4pO_aiW2KlsOaK3YZYmkXmFXh3mavSJshq1LlwKGNxJTVwCzjKTn4w>
    <xmx:4pO_al9C-T7IYsGRIZSB4fK5EsOVe3hOf6sIwS554XnQwQLUgIdcgQ>
    <xmx:4pO_aqqx6b5T7fkcLmobSaPhcnaIlUrq4wjQ0HDSN9s5fXQ99DzmyP3u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 07:22:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 23fca52a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Oct 2026 11:22:06 +0000 (UTC)
Date: Fri, 2 Oct 2026 13:22:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
	Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH 2/2] fetch: write commit-graph using updated refs only
Message-ID: <ar-T2y54X1uDQ4mX@pks.im>
References: <pull.2239.git.1790930019.gitgitgadget@gmail.com>
 <fee92f3c2009f8f282fe98e6b16d403704db9ad9.1790930019.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fee92f3c2009f8f282fe98e6b16d403704db9ad9.1790930019.git.gitgitgadget@gmail.com>

On Fri, Oct 02, 2026 at 08:33:38AM +0000, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> When fetch.writeCommitGraph was introduced in
> 
>     50f26bd035 (fetch: add fetch.writeCommitGraph config
>                 setting, 2019-09-02),
> 
> the stated goal was to stay updated with the latest commits after
> fetching new objects.  The implementation used
> write_commit_graph_reachable() because it was the only API available,
> but two things have changed since then:
> 
>  1. write_commit_graph() was added, and it accepts an explicit set of
>     commits as seeds, enabling more targeted commit-graph updates.

Hm. The big question here is whether these additional seeds are additive
or exclusive. That is, if I have an existing commit graph already, would
it basically just extend the commit graph with the additional object IDs
or would it replace the commit graph with a new one that only considers
the passe object IDs as input?

I would hope that it's additive, because otherwise you may now lose
commit graph coverage for stuff that was covered before the patch.

>  2. The ref-scanning callback add_ref_to_set() became more expensive
>     in
>         630cd5194e (commit-graph.c: peel refs in 'add_ref_to_set',
>                     2020-07-22)
>     when it started to validate the refs against the odb
>     for correctness.  On a repository with many refs, this makes the
>     full reachable scan unnecessarily costly for a targeted fetch.

I was wondering whether incremental commit graphs would also be part of
the reasoning. Because in theory, now that we have those, we could even
extend the commit graph on a fetch by just writing another layer.

> Optimize the commit-graph write by using only the newly updated refs
> as seeds instead of scanning all refs after every fetch.  To keep
> this change small, skip the optimization for multi-remote fetches
> (since that would require propagating the set of refs across process
> boundaries).

Yeah, the way we perform fetches can be a bit annoying at times, as all
these subprocesses make it very hard to exchange information.

> Since do_fetch() already knows which refs were updated, collect them
> into an oidset and then pass them directly to write_commit_graph().
> In split mode, close_reachable() walks from the updated tips and
> stops at commits already present in the graph, efficiently adding
> the newly fetched history.  This reachability closure also covers
> auto-followed tags, since their targets are reachable from the
> fetched tips that caused them to be auto-followed.

Aha! So I wasn't that far off :) Now there's a follow-up question
though: what happens in non-split mode?

> After fetch_one() returns, call prepare_commit_graph() (which is
> made non-static by this commit) to determine the graph-write mode:
> 
>  - If no commit-graph exists yet, fall back to the full reachable
>    scan so the first graph creation covers all refs.
> 
>  - If a commit-graph exists and the fetch updated at least one ref,
>    write incrementally using only the new refs as seeds.
> 
>  - If a commit-graph exists but the fetch is a no-op, skip the
>    commit-graph write entirely.
> 
>  - For the multi-remote path (fetch --all), where child processes
>    do the actual fetching, fall back to the full reachable scan.

All of these make sense, but the above question is not answered yet.

> Full commit-graph coverage of all refs remains the responsibility
> of "git maintenance", "git gc" and "git commit-graph write".
> Regular Git operations may trigger "git maintenance run --auto",
> which periodically rebuilds the commit-graph from all reachable
> refs.

Curiously, you mention performance as motivating factor for this change
but don't provide a benchmark demonstrating the benefit.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 533fdfe7d8..8ad7331640 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1903,10 +1903,30 @@ out:
>  	return retcode;
>  }
>  
> +static void collect_updated_tips(struct oidset *tips, struct ref *ref_map)
> +{
> +	struct ref *rm;
> +	for (rm = ref_map; rm; rm = rm->next) {
> +		struct commit *commit;
> +		if (rm->status == REF_STATUS_REJECT_SHALLOW)
> +			continue;

Hm. Shouldn't we also refuse almost all of the other values here? I'd
expect that we only want to consider a tip when it has REF_STATUS_OK.

> +		if (is_null_oid(&rm->old_oid))
> +			continue;
> +		if (rm->peer_ref &&
> +		    oideq(&rm->old_oid, &rm->peer_ref->old_oid))
> +			continue;
> +		commit = lookup_commit_reference_gently(the_repository,
> +							&rm->old_oid, 1);
> +		if (commit)
> +			oidset_insert(tips, &commit->object.oid);

This is something that always trips me with `struct ref`, that I'm never
quite sure what's what. So please forgive my ignorance, but why do we
look up `rm->old_oid` here?

> @@ -2535,6 +2559,12 @@ int cmd_fetch(int argc,
>  	int negotiate_only = 0;
>  	int porcelain = 0;
>  	int i;
> +	enum {
> +		GRAPH_WRITE_REACHABLE,
> +		GRAPH_WRITE_TIPS,
> +		GRAPH_WRITE_SKIP,
> +	} graph_write_mode = GRAPH_WRITE_REACHABLE;
> +	struct oidset updated_tips = OIDSET_INIT;
>  
>  	struct option builtin_fetch_options[] = {
>  		OPT__VERBOSITY(&verbosity),
> @@ -2822,7 +2852,13 @@ int cmd_fetch(int argc,
>  		}
>  		trace2_region_enter("fetch", "fetch-one", the_repository);
>  		result = fetch_one(remote, argc, argv, prune_tags_ok, stdin_refspecs,
> -				   &config, &filter_options);
> +				   &config, &filter_options, &updated_tips);
> +		if (prepare_commit_graph(the_repository)) {
> +			if (oidset_size(&updated_tips))
> +				graph_write_mode = GRAPH_WRITE_TIPS;
> +			else
> +				graph_write_mode = GRAPH_WRITE_SKIP;
> +		}
>  		trace2_region_leave("fetch", "fetch-one", the_repository);
>  	} else {
>  		int max_children = max_jobs;

It's a bit curious that we have `GRAPH_WRITE_SKIP` as an explicit value
here as it can be trivially derived from `oidset_size()` anyway. But
other than that this is the safeguard that you were talking about: when
we have a commit graph already then we only update with new tips,
otherwise we use a full reachability walk.

Thanks!

Patrick
