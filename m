Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877383F1078
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791355160; cv=none; b=qSNSCYOEIixFxi6l7s1CNEanXrRC80tFoYqF6MLba2IIMaaFZz/Dklu77wqHiqevfHSJscP/xmO8vO39aviOg9p/U7MLy1AQZTxF+J1RnFFVq4AuH8SYUfOlmCR+lD4oIuVU0T7k+uDP2NE8+kjOg+hPbEWBh9UApfKCzfPtPRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791355160; c=relaxed/simple;
	bh=u1XsFTK9+u6NbJQg4lDpdC5t6KCUf7Wi7fp5Hp2g058=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMt9yFzR2j+GRtQ6a4si6R/mkJ1IL+C2PDDP8U8q4KyuTPQpQEiki2bW7FLqQDHjH6hnQrbRjhgtFqKyEmmOehYj06YjRJ9hI4SWYuhiM0pLy1371r6PsLUen7TaTMbLVEGEKhSZcI+IamyqzMXvnsz7MQs16HF+fp6dpCRo3J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lXWlOxPn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fuhKK9W/; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lXWlOxPn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fuhKK9W/"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 9752EEC0397
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 02:39:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 07 Oct 2026 02:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791355157; x=1791441557; bh=UFB+0V2dVM
	ytkOkh4LL34NnwSMzzwTKUfp4cCYS6Nck=; b=lXWlOxPncpVW9wBmbWuTSQhDwu
	JSpsRLRe95tjwFfoZu+0k2cFoiz8G4wS1MAluf34sU9nEa/SUbxrahOPjwVKsiD3
	byPUCt2Uqmq/YQvQ484Os00uhJWeK9NqMt+5lkaD8n4NY/kYg/SiVBLvSCARHHcX
	cBMY9DfzVGTtfWnzXfmEufrswt6yy2Svf5EvTTWIc4yoo5QBIz4MsItklDx/TE4l
	UJCZHTd2Ff3T6k78SQJHg8afzI/+kUnIgKggWXNnEM/5ZlGJE0KOEXqOaHxHB17D
	ShxECvO+VHrGcbDaWrF6pfFPbfeLs5WOO6V95H8OqNSK92NK2b6OiNaESUkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791355157; x=1791441557; bh=UFB+0V2dVMytkOkh4LL34NnwSMzzwTKUfp4
	cCYS6Nck=; b=fuhKK9W/YP5R822fu5bXu3OJ7F4AdquI9bBIUZtrlvYbvrTPiOL
	8pLpv1aYi7K8RrExtW8GpMgeQv5Z6aY0gWhf8DDIQ0Ujx8aUHH852bTNBREDKFxh
	Ry57NnWScFnEBhDp8gYydTgXBOcnS51eYBqbcWdn5iYkmzk1MJd732YraLylUeXM
	vvk+nMDbjQE3eRmukp/noG6X+Sp3TsqUgf1jr9siDzWRmvH550pJejNfuQPqdzLl
	JNqgJd/Lg7XXHqm++grjRQuT74nWDYd5L8ZgxfMeCYit+7bXaG9RBBXOLLNNvbMu
	14DEbH1JEcTaYSJxu+9wGg6SiF/TC0n27PQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791355157; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:F2zt/YkQBSPH+LpnP8jN7qt/ecSB5jCJuxaZ2J4/TJoSqIv
	mfG4L5V/aCKz92WhpYFlP5iBmG4Cl3NbCGiY44siF/s5h74SFngS0lNDini1/IvY
	kT5B7GWbGPKbOj9GXufXJk3IG+B9nfPfWbakehLNHtUfKxmoqfFPNICTmxHswB52
	H2uj4nMxd8mBTM36Dy5lj/SqCFUAnU+W/VTk90QfnO8C1WqS2I9901KBSn0j8DJE
	aagUHb1b3LhHf+rV2VK6FiTBtVaNicZHLkA6t1RlNZI5rxgtU9RVxZktsIEmI0Io
	3+4Kh+Un7jF6PvkfkeUwbOtqAvvCZcEqyaXsMbQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:lXMHIqTcRvvywtxdEsDJBItJuU1JirOUkeuOWvLqk8U=:u1XsFTK9+u6NbJQg4lDpdC5t6KCUf7Wi7fp5Hp2g058=;
X-ME-Sender: <xms:FenFag8R6hphYzKoHIIbFcW106lIUfy6JWks90xGv2VA0IJkwV-UkQ>
    <xme:FenFasb-QXT-cGhE52t25y6Brv0NdTsbo3EQeo25-9JbPgvXqBSe-zkG8h7tJy-r4
    yoNX-vtEfZhJSNI5I7E8PBS9S_5uiv1KZwRUizH-YssfaXOnJGeYA>
X-ME-Received: <xmr:FenFav24Sqa88jxkte0TVxLtncWRIc1jaHrMslg0Fv7czzVWdNFkSg>
X-ME-Proxy-Cause: dmFkZTFR7NRXzuXu1wWao+SPKmede6sCG5Zk/8lFYNda1e5MydCOeDwzA3/r7WZSL0sSPS
    VmxL9R2TnieWdoBC5JvFmd9F3mbS87jXPBxyEwW7qB7EdVMvP1rsQ4P3Pm0F0p+ztLsQcW
    SZW8cpEitZ5cJkRvmEM9pdQDUzRnY6PoMKBnHcDxBRRaNxkSxvxa70rrQVjKJpz4TdR3dk
    ewq4pMhkQxZ9ChoJAvWLJ9L7Q226VC6k2UimUpv4R4LT+NEQfcJJdw/XIlfsUcHhLvtl6C
    fsMcIf9qbXvKeXQnKKY2UEq3d2g3IeEYRloP3pJ6XplsBBqfA2Wgw7xD9mH8oPSNk4YmAW
    BTnmNOE1glunCEdlYDj02ImA84CQ8ZllDwwRZrREX7PLhK1pTIhv2HiARQqayfUt3EkJXm
    eC77C0bp2/rcU79ahfbIabHe6GXWR3obXNL/VdFHjiqpTqE6+q+DDxZIA9/0WaywJh/tiJ
    8eU+e9IDKI+mSBj5LGr03kjVIGJ3EfeLPuVclykMyskqkBawmbheh8kWACiSTjOCg6YGSL
    tJz0G9Ks9W7rVgXs7Z0PUME/rSOUKDx2r9uAnPYAxa/RHDagrTmGUVUzG/0NdExS+2eJmj
    yxUIMb+U5yr0ZQDdVDrsXvyxQd8Ht2jDlPdfz0M0LFuN8zwTkj39YFORs0dg
X-ME-Proxy: <xmx:FenFanaBLcPTUDJscetprTqzBi7JvVEtXgMwm-beQ__fFlvJCZhLTQ>
    <xmx:FenFanLy7Q9T0i_qcnseGfehX1Wn5f3ip2QUqwR5WbHbtt8EkijwMw>
    <xmx:FenFamHFanx6oJu1YRhYgXZ8bAxjVTU6SPhq-MN4nOvicTMEjjwttw>
    <xmx:FenFauumPwh7X60OoOBjcCXDr3mJbqxT-iezH0kbgtF8KcmdzWNJTQ>
    <xmx:FenFalZA-tTyvCUfXTf5Fx_LqtagBOzUgrarluohCFEZLLLcPx09Wprw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 02:39:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1bc1428e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Oct 2026 06:39:14 +0000 (UTC)
Date: Wed, 7 Oct 2026 08:39:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
	Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v2 2/2] fetch: write commit-graph using updated refs only
Message-ID: <asXpD2YB_MpunVFs@pks.im>
References: <pull.2239.git.1790930019.gitgitgadget@gmail.com>
 <pull.2239.v2.git.1791279992.gitgitgadget@gmail.com>
 <7507354cc97bb63b3bcdc4a089b5387da28500a0.1791279992.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7507354cc97bb63b3bcdc4a089b5387da28500a0.1791279992.git.gitgitgadget@gmail.com>

On Tue, Oct 06, 2026 at 09:46:32AM +0000, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> When fetch.writeCommitGraph was introduced in
> 
>     50f26bd035 (fetch: add fetch.writeCommitGraph config
>                 setting, 2019-09-02),

Tiny nit, not worth a reroll and something I missed in the first round:
it's rather uncustomary to have this commit stand out like this, we
typically have it embedded in the free-flowing text.

> the stated goal was to stay updated with the latest commits after
> fetching new objects.  The implementation used
> write_commit_graph_reachable() because it was the only API available,
> but two things have changed since then:
> 
>  1. write_commit_graph() was added, and it accepts an explicit set of
>     commits as seeds, enabling more targeted commit-graph updates.
> 
>  2. The ref-scanning callback add_ref_to_set() became more expensive
>     in
>         630cd5194e (commit-graph.c: peel refs in 'add_ref_to_set',
>                     2020-07-22)

Likewise.

>     when it started to validate the refs against the odb
>     for correctness.  On a repository with many refs, this makes the
>     full reachable scan unnecessarily costly for a targeted fetch.
> 
> Optimize the commit-graph write by using only the newly updated refs
> as seeds instead of scanning all refs after every fetch.  To keep
> this change small, skip the optimization for multi-remote fetches
> (since that would require propagating the set of refs across process
> boundaries).
> 
> Since do_fetch() already knows which refs were updated, collect them
> into an oidset and then pass them directly to write_commit_graph().
> fetch always writes the commit-graph in split mode, so this adds a
> new layer on top of the existing chain rather than replacing it:
> close_reachable() walks from the updated tips and stops at commits
> already present in the graph, so the new layer only contains the
> newly fetched history, and commits covered by the existing layers
> remain covered.  This relies on split mode; a non-split write would
> replace the graph with just the closure of the seeds.

The part about split commit graphs is important to point out here, as
this is what we rely on to make this whole infra even work. The other
parts about how we collect the object IDs feels overly verbose though,
as you're basically just explaining the diff without providing much
context.

> The reachability closure also covers auto-followed tags, since their
> targets are reachable from the fetched tips that caused them to be
> auto-followed.

This piece of information feels a bit random to me. Tags aren't even
part of the commit graph, are they? And for auto-followed tags we'd
of course naturally cover the commits they point to, but that's just
business as usual and nothing that we specifically had to make sure
keeps on working, right?. So I wonder why this is explicitly being
pointed out now.

> Refs that are rejected because they would require changes to
> .git/shallow are skipped, just like store_updated_refs() does.  Their
> objects are received but their history is incomplete, so walking from
> them would make the commit-graph write fail.

And this bordering on the line of getting too verbose, as well. You
already explain this in code with a comment already, so you're basically
just repeating that.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 533fdfe7d8..574c361530 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1903,10 +1903,34 @@ out:
>  	return retcode;
>  }
>  
> +static void collect_updated_tips(struct oidset *tips, struct ref *ref_map)
> +{
> +	struct ref *rm;
> +	for (rm = ref_map; rm; rm = rm->next) {
> +		struct commit *commit;
> +		/*
> +		 * Like store_updated_refs(), skip shallow-rejected refs:
> +		 * they are not stored, and their history is incomplete.
> +		 */

Okay. It's unclear why the reference to `store_updated_refs()` exists
here, as it doesn't seem to give me any useful context. But the other
part about why we skip this is helpful.

> diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
> index f323ceebd2..624bd124be 100755
> --- a/t/t5537-fetch-shallow.sh
> +++ b/t/t5537-fetch-shallow.sh
> @@ -135,6 +135,34 @@ test_expect_success 'fetch that requires changes in .git/shallow is filtered' '
>  	)
>  '
>  
> +test_expect_success 'fetch.writeCommitGraph skips refs that require changes in .git/shallow' '
> +	git clone --no-local --depth=2 .git shallow-graph &&
> +	(
> +		cd shallow-graph &&
> +		git checkout --orphan no-shallow &&
> +		commit no-shallow
> +	) &&

Can't we instead:

    git -C shallow-graph checkout --orphan no-shallow &&
    test_commit -C shallow-graph no-shallow

> +	git init notshallow-graph &&
> +	git -C notshallow-graph -c fetch.writeCommitGraph=true \
> +		fetch ../shallow-graph/.git "refs/heads/*:refs/remotes/shallow/*" &&
> +	(
> +		cd shallow-graph &&
> +		commit no-shallow-2
> +	) &&

And likewise, `test_commit -C shallow-graph no-shallow-2`?

> +	rejected=$(git -C shallow-graph rev-parse main) &&
> +	(
> +		cd notshallow-graph &&
> +		git -c fetch.writeCommitGraph=true \
> +			fetch ../shallow-graph/.git "refs/heads/*:refs/remotes/shallow/*" &&
> +		git for-each-ref --format="%(refname)" >actual.refs &&
> +		echo refs/remotes/shallow/no-shallow >expect.refs &&
> +		test_cmp expect.refs actual.refs &&
> +		test-tool read-graph commit-info shallow/no-shallow &&
> +		test_expect_code 1 \
> +			test-tool read-graph commit-info $rejected 2>/dev/null

Okay. So if I understand correctly, this test here verifies that we can
read the non-shallow commit from the graph, but not the shallow one.
Makes sense.

> +	)
> +'

Thanks!

Patrick
