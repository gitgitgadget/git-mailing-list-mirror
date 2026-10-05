Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98E237F334
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187222; cv=none; b=epPWhY8lyJT2EFdVr6gTuKUsY8gCjKvXx9SEkJjszJKgb8Bvu9yPRLBuk4n9658BYhXHJFGpM2Kp8r0ePNgzjiXHBEYOlxBCib5xctMn+dp6vUlV0s7/G5rbWgyE5rT3cryDuNvv8JR6e8hRT36w6gSqzvre7VQgN8/f6W4QDZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187222; c=relaxed/simple;
	bh=JVt5+Tq41QyUzVzH9XKua+MUFXx2lcr7VRMNRGmTy4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPMe+IWciGdkp/Y0Fx4OyrCALVUOJTDiHsjFf/WRXFryikWnbWRvtSSh/ZedgM7j4I/A/mE0axWUNHohT6fG/RA2WScPKqtmTZYRqXlEOx71+wGBi+nV1K0eo87GDb/jeUiNI+NGSzbZBYoYaYIWVU1tS+FJZqNu7KfPGBkzxqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rSId10ca; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ENety5bM; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rSId10ca";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ENety5bM"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id DD3D4EC0C6A
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 04:00:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 05 Oct 2026 04:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791187219; x=1791273619; bh=xH1Fa7j3qq
	5zkMHb5WnYOEELtHa6Md/BQ729wk0NEy4=; b=rSId10caXlZ6M+Doo4Cs7rt5ZG
	A/YeNxv1oZhtxKnlBFIZxIFRnBZpH1jrsWlrB3Aa94hNsSbquiEircQNiNrZjITH
	GlEREdEmASTFzzubph9LAgpC3s2QM+JqrokU6Z9kEmC8NYeabKz7dKhd1p10M8sP
	d6ViWALr4T3dgNDQ2BNQgQinGndFlKkhUh5mafG5jdjwFwHtkxTpUP6EvgRyiqxk
	49a8bJ2AFttGrigTrdT9DaHlEJI1/NYvHBA6TA+Vhcqfy+jBwmUOo8+WP8aVj3j/
	Bm2gUymkRFzQc2UlIRuY8OiZMYDBvn9MaQrMQfiFqrluinvV7I2f9ll6u5VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791187219; x=1791273619; bh=xH1Fa7j3qq5zkMHb5WnYOEELtHa6Md/BQ72
	9wk0NEy4=; b=ENety5bMLDsfTutdE45jjCLtfx/DUt3c6yV83S95TVQnEViOay8
	m6EJ7KjeeY49PHq/jvhC+PfI5vuQmu/o481+dfKYXKEIGh0R8SqhExBgjqmOPC8k
	aY4zGyHUBxlYKLmNa5CjbqWmLwyZyXUypXPvrLnc0P89458tbEmdKtytne8AgyQB
	CJUbOpTH1AZvlvm2wn1m10pcIXeYuQVv3hJWf5IY/oOx5wsrLdAJzwaFJMpjj8yW
	P4ki7CO4WAkE9HgFuFr6sWncHhckK3mzkGm90FxokicgYhxmte0x1R+P1Odijgyk
	+inee5RRJ3FV7ktBJV2VeyeN8wW0wtPsk+A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791187219; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Z7ljUHkSidmas+IikhL5yNslC0KyGb/to+TX5eu8ZcMPwin
	CfYVO1M7pAShqsbNw5hpIGH5lec7QH0QcXW66OhoGnU/AGC5a8XpbdVsAkUXdERq
	uuQW3MkH2kAWooyxls9bHzvXt6iWR8pQzCK80FGBFMNWfgtH53wzrMuvl8kKu2nS
	RBwHgHM612VXZ24WIiPVATAfocStve9ehQZnm42ALZACzStjQX/NFted0hwu/hnT
	kKGQMElhO6oja4bHaO4l2DZ+mPxYX3rg7LhfvPn8IvLgHKNPc7ULE8780XhorwUQ
	xCVVrI0VYLXp3qSHzQkJ/IVB4/5d8Q5mtXaDFWw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:4zX0d1H9riC05SiEn/8PXWySkNxOk9DUc9WrcG5+ZbQ=:JVt5+Tq41QyUzVzH9XKua+MUFXx2lcr7VRMNRGmTy4M=;
X-ME-Sender: <xms:E1nDajzU6muRMfTa3Zr_pwHJB_g0WoO_QPBgK1zV8eCVv0HaiCILcg>
    <xme:E1nDais9zE6uMS0BjAhtYimX-1R6njTL7EddUjG2UD4ok6jtbQGA2T68mtUc75HDg
    3tlf-RygUn3niJlgAkfQtcHFk9e9yLKzAA6J7qyeJA4Jdt8RjE2Ow>
X-ME-Received: <xmr:E1nDaqu1DO4q0Z8VQGwhi0rrhLiT7I2YjW1RnhNUy4Ot59HVzS3tTFbrvnKfQDxHUTU4u-M>
X-ME-Proxy-Cause: dmFkZTEEdDeswijo76BZbMQYRip2AQCmwGsZR3uOKcX/rpII1sFJNsitTzmms4kepdvTHX
    sDiCEca5PCWYJpOELmld8tfpkX4dq1XR+kj5ezcba3Qa9/6LwwB9L6FqTjAJT1nPOLXo4f
    2F8b0hKoowVyH10WAZ/WCj6zemRj5lvfXxVIF1UouFVZsfiLkFF3A7SWDzyXc2ZQkTgaWF
    HX7spDgJPWmsA46pgChelzKXxmAMt+J05r82z3BZZKKU80yffDIWw+NlJhyDoM8Z8ngZAD
    uac3B+sL4+w6AaunxGEa2ANxsym4KJPKL7VeQ4C+ofb7RBQrf+MEiFRRzIBwn0FORRoIAr
    GN1M+qbpvfeOdCpoRDv9Ed+2+On8HT9+SUg/YpkVxIcWi0bwFYvFCGlWnLWExJ6XXYZ10s
    Lf6cHBMipXB65bnO5ZTQ6CeyAMyTA1jhc02IoxI0RFxgn7zCYrfm3glgpH0dWghGQVxiNj
    F1dytYJE//cC6CO053wXtcBxZlywtjPlNqTV/UoO35JfErACa2PL/idqN2JO2rxR1DVEZZ
    KF624UCNOgUizr1OEuMeCXmliIbKiHuPAOVOkP2/qcnfHS2USymd/IHTk/nbQM4kjn4J1k
    dW2Lq7uKXeYJvjRFG93f3p6AYcVL9SUyt8WJ4+2PSkt92ChRFR6WqbI2N7iA
X-ME-Proxy: <xmx:E1nDanN_D3NB3wC6JdbOhbbdVrz6F-N32wofa0kTf9buEkfW1D99qg>
    <xmx:E1nDao0RgIxCYkfnWfV7XxTWe2qHMro-oDTd1nlHq0RGjwSQzN2ZuA>
    <xmx:E1nDajOo2WC2vYvtWQDG2TGt_GQ0Ctg411E6gYGHLQZgmAbbOt815Q>
    <xmx:E1nDao15oYCLZQEtmoQn2UVMZ5D_wqAukJfdsUdPmBDFVqKqz0YXmQ>
    <xmx:E1nDap_Z91VlBfmoTy3jSKGWGzhV-lmjO0JFlTT55ESj7onrw9CSyHxT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 04:00:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2bf4b7ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Oct 2026 08:00:17 +0000 (UTC)
Date: Mon, 5 Oct 2026 10:00:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v2 2/2] connected: add incremental connectivity check via
 rev-list
Message-ID: <asNZD7AOC6QL9q1d@pks.im>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v2.git.1790600552.gitgitgadget@gmail.com>
 <6ad528f4bb42a960910eb4fe917a3766fa55d598.1790600552.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ad528f4bb42a960910eb4fe917a3766fa55d598.1790600552.git.gitgitgadget@gmail.com>

On Mon, Sep 28, 2026 at 01:02:32PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> The full connectivity check uses rev-list to find commits
> reachable from the incoming tips but not from the
> already-connected side, then walks their object closure.  Commit
> traversal stops at the connectivity boundary, but trees and blobs
> reachable from that boundary still need to be walked so they can
> be marked uninteresting, allocating a struct object for each one.
> On repositories where the boundary commits have large trees, the
> connectivity check for small incoming changes visits and tracks
> more objects than needed.

Okay. In the old world we basically mark evertyhing as uninteresting,
including trees and blobs, ...

> Add an alternative connectivity check that verifies incoming
> commits incrementally against their parents.
> 
> The verifier processes incoming commits with ancestors first and
> compares each new tree against its trusted parent trees.  Entries
> already seen on the trusted side are skipped by OID, so unchanged
> subtrees need not remain at the same path to be recognized.
> Changed subtrees are recursively compared against same-path parent
> subtrees, and new subtrees without a comparison base are verified
> from scratch.

... whereas in the new world you propose to skip marking trees/blobs as
uninteresting. Instead, the idea is to compare the trees/blobs of the
old tips directly with the trees/blobs of the new tips and only verify
those parts that have changed between the two?

This can of course cause us to verify significantly more objects in some
scenarios. But it does have the consequence that we scale with the
number of changes, not with the number of preexisting objects in the
repository. And that's something I'd really appreciate, because marking
reachable objects as uninteresting is extremely expensive.

One thing I wonder though... does this help with the scenario where we
have tons of references or do we still end up passing "--not --all"? I
have seen many times that parsing the refs by itself is dominating the
time of the connectivity check quite significantly. So ideally, I'd like
to have a solution that also catches this case. Your benchmarks do not
cover that scenario though.

> Incremental uses substantially less memory when it can prune
> most of the boundary tree walk.  In the long-history case the
> two modes visit similar object sets and memory converges.
> 
> The regression cases in the CPU benchmarks are in wall-clock
> time rather than memory, primarily from scanning some trees
> more than once.
> 
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>  Documentation/config/transfer.adoc            |  20 +
>  Documentation/rev-list-options.adoc           |   6 +
>  .../technical/connectivity-check.adoc         | 134 ++++
>  Makefile                                      |   1 +
>  builtin/rev-list.c                            |  19 +
>  connected.c                                   |  24 +
>  meson.build                                   |   1 +
>  t/meson.build                                 |   1 +
>  ...enerate-repo-p5412-connectivity-check.perl |  44 ++
>  t/perf/p5412-connectivity-check.sh            |  92 +++
>  t/t5412-connectivity-check.sh                 | 680 ++++++++++++++++++
>  tree-verify.c                                 | 316 ++++++++
>  tree-verify.h                                 |  15 +
>  13 files changed, 1353 insertions(+)
>  create mode 100644 t/perf/generate-repo-p5412-connectivity-check.perl
>  create mode 100755 t/perf/p5412-connectivity-check.sh
>  create mode 100755 t/t5412-connectivity-check.sh
>  create mode 100644 tree-verify.c
>  create mode 100644 tree-verify.h

May I suggest splitting up this patch in the following way?

  - One commit that introduces the new option, but for now only accepts
    "full" as the algorithm.

  - One commit that introduces the benchmark.

  - One commit that introduces the new flag for git-rev-list(1).

  - One commit that then introduces the new strategy.

That may make it a bit easier to focus on the actual change.

> diff --git a/Documentation/technical/connectivity-check.adoc b/Documentation/technical/connectivity-check.adoc
> index d20bff6af6..0a8f370546 100644
> --- a/Documentation/technical/connectivity-check.adoc
> +++ b/Documentation/technical/connectivity-check.adoc
> @@ -107,3 +107,137 @@ When a new reference points to a non-commit object, such as a
>  tag, tree, or blob, that object is not part of the commit walk.
>  These non-commit tips are handled by the subsequent object
>  traversal.
> +
> +Incremental connectivity check
> +------------------------------
> +
> +The incremental mode, selected by
> +`transfer.connectivityCheck=incremental`, avoids traversing the
> +full tree walk of the boundary commits.  Instead, it verifies
> +each incoming commit's tree against the already-trusted trees of
> +its parents.

Can we define "parents" here? Specifically, I wonder how you define
"parent" in the case where you perform a force push or when creating a
new reference. Is it the parent of the first new commit? Is it the old
state of the ref, if it even exists?

> +Trust model
> +~~~~~~~~~~~
> +
> +A tree is trusted when its transitive object closure is known to
> +be connected.  Trees reachable from commits on the
> +already-connected side of the boundary are therefore trusted.

Where the "already-connected side of the boundary" is anything reachable
via a reference.

> +Incoming commits are processed with ancestors before descendants.
> +Once an incoming commit's tree has been verified, it is trusted
> +and can be used as a comparison base for later descendants.
> +
> +This gives an inductive correctness argument: every parent of the
> +commit currently being verified is either already connected or is
> +an earlier incoming commit whose tree has already been verified.

Right. The big question to me still is how you identify
already-connected trees without having to read all references.

> +Worked example

Worked?

[snip]
> diff --git a/tree-verify.c b/tree-verify.c
> new file mode 100644
> index 0000000000..5c11c2251a
> --- /dev/null
> +++ b/tree-verify.c
> @@ -0,0 +1,316 @@
[snip]
> +static void verify_commit_tree(struct repository *repo,
> +			       struct commit *commit,
> +			       struct verify_state *vs)
> +{
> +	struct oid_array base_trees = OID_ARRAY_INIT;
> +	struct commit_list *p;
> +
> +	/*
> +	 * Parent trees are trusted: boundary parents are already
> +	 * connected, and earlier incoming parents were verified
> +	 * first due to the topological processing order.
> +	 */

I feel like I still miss where exactly you establish the trust boundary
between preexisting fully-connected commits and new commits.

> +	for (p = commit->parents; p; p = p->next) {
> +		const struct object_id *tree_oid;
> +		parse_commit_or_die(p->item);
> +		tree_oid = get_commit_tree_oid(p->item);
> +		if (!tree_oid)
> +			die(_("unable to load root tree for commit %s"),
> +			    oid_to_hex(&p->item->object.oid));
> +		tree_map_add(vs->trees, tree_oid, TREE_TRUSTED);
> +		oid_array_append(&base_trees, tree_oid);
> +	}
> +
> +	if (!get_commit_tree_oid(commit))
> +		die(_("unable to load root tree for commit %s"),
> +		    oid_to_hex(&commit->object.oid));
> +	verify_tree(repo, get_commit_tree_oid(commit),
> +		    &base_trees, vs, 0);
> +	oid_array_clear(&base_trees);
> +}
> +
> +void verify_commits_incremental(struct repository *repo,
> +				struct commit_list **commits,
> +				int exclude_promisor_objects)
> +{
> +	struct verify_state vs = { 0 };
> +	struct commit_list *iter;
> +	unsigned nr_before;
> +
> +	if (repo->fetch_if_missing)
> +		BUG("verify_commits_incremental must not be called "
> +		    "with fetch_if_missing set");
> +
> +	vs.trees = kh_init_oid_tree();
> +	vs.exclude_promisor_objects = exclude_promisor_objects;
> +
> +	/*
> +	 * Ancestors must be verified before descendants so that parent
> +	 * trees can be trusted without re-verification.  Sort explicitly
> +	 * rather than relying on the caller's ordering.
> +	 *
> +	 * sort_in_topological_order() silently drops cycle members,
> +	 * so explicitly check if the size has changed.
> +	 */
> +	nr_before = commit_list_count(*commits);
> +	sort_in_topological_order(commits, REV_SORT_IN_GRAPH_ORDER);
> +	if (commit_list_count(*commits) < nr_before)
> +		die(_("cycle detected in incoming commit graph"));

I don't think we should just die, should we? That may not interact well
with git-receive-pack(1) and others that expect a broken connectivity
check to bubble up errors so that they can properly report those to the
client and clean up their local state.

> +	*commits = commit_list_reverse(*commits);
> +
> +	for (iter = *commits; iter; iter = iter->next)
> +		verify_commit_tree(repo, iter->item, &vs);

> +	kh_destroy_oid_tree(vs.trees);
> +	oidset_clear(&vs.trusted_blobs);
> +	trace2_data_intmax("connectivity", repo,
> +			   "trees_loaded", vs.trees_loaded);
> +	trace2_data_intmax("connectivity", repo,
> +			   "blobs_checked", vs.blobs_checked);
> +}

Patrick
