Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515826DCE1
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 06:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439282; cv=none; b=DirwSskLsy1o5CETO/NGAgXr9/IMNI1/9yMiCFhFYJKtUEkZPzzHLHR9OyGrMb8Q7rs31Bb+Prq9WXLRaSMd+i6graULl7N8AArVAc9SGEysUCbxNB8hPgyqvJ8OTC/WXOV0i4Sbm/aiiIvWKEIrH/fKWA2VZa9oazW3NZTSbKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439282; c=relaxed/simple;
	bh=boh/ff444aiosRD1wT0IHeini2IVpcX/eK9hVzMG37o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcxKGkcXLUHgFt7X9MLnjoW9t3wM6tr2hBFnIkOwVU/tPlOENG+NghGY7iQmkSFL7ognRa0YcSD1EfxpHiW3tgOyNX/B1kLU66gPiM/Qh2xuSuRr62e1XMhB3ezQMEB3CjdJpsp+hhlcuISX3zyu6T4FItYyGu/14fisdmqo10U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D1a8DnoE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tlIUHJ7p; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D1a8DnoE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tlIUHJ7p"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 6BF8FEC019E
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 02:01:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 08 Oct 2026 02:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791439279; x=1791525679; bh=TNkWSXzlxu
	jFdijZzZkckEesGYlBy0yFxXL43XKHsis=; b=D1a8DnoExV0um9jmNGaVvyvKg1
	oTxT+dTWrgaexNOrbSSgxC8b2b5+lKtYlXaGuje8viXipxYOWIBKZIO79qPLQtyo
	zXvL0wZhNqLYe6gE9JTp9Ls8B0BXLLME/Opf7TCCOJbugqupjYySsjCGsNKMvigg
	oBOMEXwSmDfTrBujLuWxPutj9eD2rYwB7bri1Fv36yAQAvSPOx9WmuRZWUuJWf7K
	dtkbK3WEwbfFIK8xAKpYjw3JslDzpcJ1cBSnIwAFtpT08IUH6RfLjpWugDyCiP1w
	xRXyOLCNhHNyJqGhwEQLMj6aXTuzkfx5N1nvzYVOHAAMbHq9fsC3xrmNUq+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791439279; x=1791525679; bh=TNkWSXzlxujFdijZzZkckEesGYlBy0yFxXL
	43XKHsis=; b=tlIUHJ7pwqhfWfhIucfVZ97/JyM2ww+NASq3trnrH0p6XeX/zCu
	ImRU5mPrP3u71mNT5Fgy913w515XsMwDqVZBudHTcf6Wv0SCbsw7YgGv6Zcdwa0l
	lVoDvMInbxRxggBWgwXYeoYCn1LUbMxHd+5XAiHXJztANRFrLqbJRA7TGbAAV85D
	Nf3nyORFeZVJH3q4tLYEFW29EFqdMQD4P4HbGVy8o7+yMg0Qd2JG8SnRU/fQazZL
	wC3I2tVnbSLmEIXUUgWHGxhouKfNilaFQyIkt/YllyZUveQm70eHHKnzZeYTY7My
	0zTy6CIPC/rHyq8dUonK+7xvUIeNG+aDd/g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791439279; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:o4Chcr/6GRkFXfdgQ2ZkRGLmmHjuObRlIGaz2xSeQVIzv0Q
	XmVscQlYQ+ONhEjHm5oTIOGtWW4Vm4GcW17/7XRLjZhjx5z6NvG6lwdM+/MVu8bP
	DYHIjYQRdenk6X5FV4Es6j00ap67OJTUtCVhWdVYmfrY/25VLWybgsrdHwYuNQHM
	CykVPbzhkEr4Nuk0anyCM4frIaFPnXRJ+WYFI0bIJjvptafaAkwKSW3Fx0Vp67Dd
	RWyqZ7eG5t8wVodeGtdKzH49CWsJNRpuqsPeYvF+Q2caWMb3mNnVmo/6wrINvQ6M
	qcbizCX9QA3757LlGdnmTZL+7upZXmU+ruMej6g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6RPn+GLhYsGfaXdjIiHPB1JUQwqHUAtZ2PKv2TfTT9E=:boh/ff444aiosRD1wT0IHeini2IVpcX/eK9hVzMG37o=;
X-ME-Sender: <xms:rzHHaotfZ_LdsrHykpUdQh62v-KkyPU5lrCBD-ndY30t-3Xob8Lh8w>
    <xme:rzHHapLRb6vGZHzk0_ZHFjxQC4nlsqY_1hPunVMIzphfIltADFSu3arwdJ7X0DdF2
    WNPQGATkEZ2Lg9n_NagSAYKppK2-j1TvM-u6Qxr0DpHjBMmalZsjGU>
X-ME-Received: <xmr:rzHHatnBQIx7YfmaxrY3polbfbGHMhmYGd9wQPflsW7S46jj_1KNHg>
X-ME-Proxy-Cause: dmFkZTGu/eaOD/RE9hIDxjEYRqx2oBR9iSPh/dITRYRRWa5EmL0p0yZ68fwgAPeScMJ9aX
    /9Em/yows4Gd/gnjkpiqHz+bsjyKabGOqRJG8pvRqrY2IWOeWElVJCNPbve7LvjS/ycZsi
    GV//sTzu1sEc1hmL9Xm07LysJK/CYwg5mM7b2eDhLX482Lh1q1GUnImhsJ3NEGzwGLIeTx
    4VeokilWffWLSBItIPcqRi++UYf+KsWB4Edev5D2UJL8Z/UzQBgKmkGdFj+nf/MeLnfW0/
    kYIsWaTGdNuqZrA9bUQmOj4mEr7xUDIJycHuOD9hbI62wX1MC2CGRsPSr/IuZfGMctizNx
    wCUicyBi7QARUOcHmbeiDcxwuf8MRHprM44zKE+FANPzj1vKCFvr9eHndhTZkZv50QHoPB
    v4v7Zo7z+crODKUXGR+E1EhPuLrBn79pUhJqs9P/KWiFFwhh4vvW9ssT3X0A4dUR7YRxQ0
    9b5lFHaFAunVnuHJHQTPAlmtdAGhHqaLkqfUJ3t2hsBNrvnmQIx3Fyo5ZLq8F2vWxC5dRe
    B237THRRmu39YPLA881srjHOgOg0/TOJUD9u8mLHYKwl65Ty2GM6yXu5YLZ2N+wBWul/TW
    Y1Hc9Onscx4xn3okCYZRjE3ya266nlKirCt8o8X8JJ476zi1t8jCHome1Vmw
X-ME-Proxy: <xmx:rzHHaiLvtKtfZa1fakn_OvMJn8nPrf92r_Xk96yIOR1OZ2h2VIAOKw>
    <xmx:rzHHaq4ssAArX9QK0HQbQ78544DNZ_XcIr8URKoENOsBINJfBuW9Bw>
    <xmx:rzHHau14vzY0hsp7q1rGRqi0ogvTASYA66PCdUDN4vesIv0EN1f4eQ>
    <xmx:rzHHaofhr2S2pksAoD0NfNXhHaF7wQPjXWEwBp4Ey0Ne5Fl_Vz3ehg>
    <xmx:rzHHapKyjY6_ESFC8XWZMDR2lqoFe501HlpKAElTazGOEEZNqCi2tZD7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 02:01:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 622905af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 06:01:15 +0000 (UTC)
Date: Thu, 8 Oct 2026 08:01:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
	Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v3 2/2] fetch: write commit-graph using updated refs only
Message-ID: <ascxqBn0RsXnLWSp@pks.im>
References: <pull.2239.git.1790930019.gitgitgadget@gmail.com>
 <pull.2239.v3.git.1791382977.gitgitgadget@gmail.com>
 <01da9857bcd847bec4eb85d8f57ea1cdc40b1758.1791382977.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01da9857bcd847bec4eb85d8f57ea1cdc40b1758.1791382977.git.gitgitgadget@gmail.com>

On Wed, Oct 07, 2026 at 02:22:57PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> When fetch.writeCommitGraph was introduced in 50f26bd035 (fetch: add
> fetch.writeCommitGraph config setting, 2019-09-02), the stated goal
> was to stay updated with the latest commits after fetching new
> objects.  The implementation used write_commit_graph_reachable()
> because it was the only API available, but two things have changed
> since then:
> 
>  1. write_commit_graph() was added, and it accepts an explicit set of
>     commits as seeds, enabling more targeted commit-graph updates.
> 
>  2. The ref-scanning callback add_ref_to_set() became more expensive
>     in 630cd5194e (commit-graph.c: peel refs in 'add_ref_to_set',
>     2020-07-22) when it started to validate the refs against the odb
>     for correctness.  On a repository with many refs, this makes the
>     full reachable scan unnecessarily costly for a targeted fetch.
> 
> Optimize the commit-graph write by using only the newly updated refs
> as seeds instead of scanning all refs after every fetch.  To keep
> this change small, skip the optimization for multi-remote fetches
> (since that would require propagating the set of refs across process
> boundaries).
> 
> This relies on the commit-graph write being additive, keeping the
> commits that are already in the graph.  fetch already operates in
> this mode (COMMIT_GRAPH_WRITE_SPLIT) and now that becomes
> required for correctness.  Without that mode, the write would
> replace the commit-graph and lose other commits.

Everything from here...

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
> 
> Full commit-graph coverage of all refs remains the responsibility
> of "git maintenance", "git gc" and "git commit-graph write".
> Regular Git operations may trigger "git maintenance run --auto",
> which periodically rebuilds the commit-graph from all reachable
> refs.

... to here is still overly verbose, especially the last paragraph. But
I haven't been complaining about that in the last round, and the rest
reads significantly better now. So this is not worth another reroll, if
you ask me.

Other than that I'm happy with this series now, thanks!

Patrick
