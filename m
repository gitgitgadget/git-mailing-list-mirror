Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3B3330662
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786124090; cv=none; b=BMlmqehGSo0M16w3nUJGdG+9X8xyfEjw0PHUyFZtYnYFR9lfkNtSTo2pr5h8eJCXV9VyY7Tcm1n5o7WEL5T4sTtzIWGMe5TN5RAnHXuqb8EtmR2couzp+kTJsq/MWCkWR3hANg3WNAp1ryPQbz5glv2IoWKqbIbldBQX74U5rPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786124090; c=relaxed/simple;
	bh=l95vy7sNFc61g39nhx4rsu+NIvkUmgfZzlbbOAfd/MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eO5XOdQxWy1189dzHAPbdn7L7NS+runGssfN5zuABBURZqSH/KEIG6E3wSAnSm6H536RxYPHyG4k9ZZ6MQTGhYt3P2viJ5fiOt3ggSLVwL78hYVkj81krOmorzuiJx5UcLdk4hpeluoiK54UvuiL6HkYTaYXBMj2BzFddP4OpxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaaqzBQ0; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaaqzBQ0"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4583b1703d3so1258877fac.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 10:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786124085; x=1786728885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CqWFgAeywyYPAo8WtL3Fx2ayLu9T8bAOBL3NUc+jmus=;
        b=iaaqzBQ0t/1lDsH73erJYD1YfcCxZHjRfTFJ8CVI9KrowXE9h6792loEoN4gp699n/
         bQNeWzfrKiPofGcc3MUnfzcmdvIzg4jSzaMVx63u3DMv1n56tlVtUHmtV3hupbsE7km8
         ZIV7EoCRqhQViY3gb0DAGpwUpyede3dvJRYH8CDDeaVDRowyuhNmj9mhTQyZugHN7d25
         EB22XM7dkSKjZA0hBECf+wnu96V1+e7BSToM1JiLZ/EFqrRWC7uTN2KHfQLEYjPySw+H
         9OSxi2nWl27Vqao5GmUMr0S9dW22BXu+ZuFcxqzEOs+1rqM1QDiDpn0UmOnlCOKvtina
         0JOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786124085; x=1786728885;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CqWFgAeywyYPAo8WtL3Fx2ayLu9T8bAOBL3NUc+jmus=;
        b=F7HFpe5qqJTt894usEaFVmxVcDS0GyNFSPFERS2dKC9PGu7frDjk9iO9l+AJqdMJYg
         lagvNvlRDWlc8Rxl1c/qSD89s1mLAPmpbuT/hnnZqDGOrKA8jqctZBeuhYbgDr/WSOOP
         aPQrmyXmFpIbv8eZYeW/NyYXi5/nmUnMP8SFgJ9JaQ1aC13v1SlFCL2TjINVHAbqJHgR
         YVIMmoyi1x779ijKnyUJZW81JjiqGqPGQy/3/aT/RAl0zpxczG9uCR1lM4HK8GiBYQir
         qNLlApGATRyjiSHTIQiIMgTco0Fdai9Hoyi/0cSoK+qAiR5iKP7CVIht6aGPHJUYOd3j
         CxAA==
X-Gm-Message-State: AOJu0YzuWGuz5FuBAyY+oeGH7H9RPzxWlSFqy/jAtYQae3cqxVFec3Ks
	HbVPo9InMLBJnZ2BYX9qKf99LgkJbVMgDBvoyJIb2p/yBQL14Xv8xrvGxF5otQ==
X-Gm-Gg: AR+sD11fjmNN9TBPBs/bsjeTqWR8quDNUfullbd5fYv01Ra4nRVWSSZyCDAjSprYbzU
	njpTceAt6LIaEAiwowhgc2fqgpi8I5FnLkB0v3YZ+CEThCLPHpVMzgahEqTXwg/EJHNzWNHOKN5
	xrYIujpRLCBvDa2Qni5t4GNtnx50UPqOmBIaR26m0OkZcLBxAb+jY0y597ymyh7IZQ76V/oxpbx
	SQlCsOHdfBrJK1Z82bm0LU8v2djz0ZrffeQgZp4i1a3qz1Pm+McYrPkwEdPp6gZo3q1pyxDde0t
	y2207UWzfEvWQlaYOTSUQXFLqkCPOmHwG3oeFpCzQfwQh7Tl21TLb/U7mxbhba1OYN+5WnlPPnS
	mMDz5sIPilssGGJcjZUhpNIFmYqfbFrhw6fvFlWzSpfpT1rZrBvPp26R0+MT24Ld13vaVGItHMp
	h4Ks+Z3789i3n52uN/heUAori8dpJw9NdfGFVzSrvnvs+H0J7t70YeRQ==
X-Received: by 2002:a05:6871:580f:b0:448:66ab:ac5d with SMTP id 586e51a60fabf-45a0f40ca5emr1257599fac.19.1786124085257;
        Fri, 07 Aug 2026 10:34:45 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f1e21215sm2498496fac.13.2026.08.07.10.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 10:34:44 -0700 (PDT)
Date: Fri, 7 Aug 2026 12:34:42 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v8 3/3] replay: offer an option to linearize the commit
 topology
Message-ID: <anYLeQj4Sx2vZqvy@denethor>
References: <20260728-toon-git-replay-drop-merges-v8-0-ced11dffe749@iotcl.com>
 <20260728-toon-git-replay-drop-merges-v8-3-ced11dffe749@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728-toon-git-replay-drop-merges-v8-3-ced11dffe749@iotcl.com>

On 26/07/28 05:45PM, Toon Claes wrote:
> One of the stated goals of git-replay(1) is to allow implementing the
> git-rebase(1) functionality on the server side.
> 
> The default mode of git-rebase(1) is to act as if `--no-rebase-merges`
> was given. This mode drops merge commits instead of replaying them, and
> linearizes the history into a sequence of regular (single-parent)
> commits.
> 
> Add option `--linearize` to git-replay(1) to do the same. Each replayed
> commit is stacked on top of the previously replayed one. When a merge is
> encountered, the commits reachable from all of its sides are replayed
> into the single line and the merge itself is dropped.
> 
> If a ref was pointing to a merge commit, that ref is updated to the
> merge's last replayed ancestor.

Just to clarify, does it really matter if the ref was pointing to the
merge commit directly? I assume it is just "flattening" the merge
commits in the revision range.

> git-replay(1) accepts multiple revision ranges, for example:
> 
>     $ git replay --onto main topic1 topic2

Per some discussion earlier in the thread, is "accepts multiple revision
ranges" the correct wording here? Would it be more correct to say
multiple branches instead?

> Without `--linearize` this replays 'topic1' and 'topic2' onto 'main'
> independently and updates both refs.

Ok, so git-replay(1) updates each branch sepecified separately.

> For now this is disallowed with option `--linearize`. Linearizing more
> than one branch at once would concatenate unrelated histories into a
> single line, and update each branch to some point in that line. That
> won't be the result most users want, especially because the order
> depends on the order of the revision walk, not the order of the branch
> names on the command line.

I'm not quite sure I follow. Why would the inclusion of the
`--linearize` option force concatenation of multiple references? Is it
mot possible to linearize each of the branches in isolation and update
the reference accordingly?

> For the same reason disallow the use of `--contained` with
> `--linearize`.
> 
> Users who want to linearize multiple branches are advised to do this in
> separate git-replay(1) invocations. Linearizing multiple branches at
> once might be added later.

Ok.

> Note that `--linearize` is not modeled after git-rebase(1)'s
> `--rebase-merges[=<mode>]` interface. Recreating merges, by preserving
> their topology, is a distinct operation that would be a separate mode.
> `--linearize` only drops merges and replays commits linearly. So
> git-replay(1) uses its own option rather than reusing that interface.
> 
> Based-on-patches-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  Documentation/git-replay.adoc |  19 +++++++-
>  builtin/replay.c              |   6 ++-
>  replay.c                      |  60 +++++++++++++++--------
>  replay.h                      |   5 ++
>  t/t3650-replay-basics.sh      | 109 +++++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 176 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
> index a32f72aead..656a6924d9 100644
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -10,7 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  (EXPERIMENTAL!) 'git replay' ([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)
> -			     [--ref=<ref>] [--ref-action=<mode>] <revision-range>
> +			     [--ref=<ref>] [--ref-action=<mode>] [--linearize] <revision-range>
>  
>  DESCRIPTION
>  -----------
> @@ -88,6 +88,23 @@ incompatible with `--contained` (which is a modifier for `--onto` only).
>  +
>  The default mode can be configured via the `replay.refAction` configuration variable.
>  
> +--linearize::
> +	In this mode, each replayed commit is stacked on top of the
> +	previously replayed one, so all replayed commits are flattened into
> +	a single linear history.
> ++
> +When a merge commit is encountered, the behavior of git-rebase(1)'s
> +option `--no-rebase-merges` is imitated. All commits in the range
> +reachable from the merge commit are replayed into a linear history, and
> +the merge commit itself is dropped. A ref that pointed to a merge commit
> +is updated to the merge's last replayed ancestor.
> ++
> +Only a single branch can be linearized at a time: `--linearize` cannot
> +be combined with multiple positive revisions or with `--contained`,
> +because that would concatenate otherwise unrelated histories into one
> +line. To linearize several branches, replay them in separate `git
> +replay` invocations.

I still don't fully understand the justification here. I'm not sure it
really needs to be in the documentation though. It may be fine to just
say "multiple branches are not supported with this option" or something
along those lines.

> +
>  <revision-range>::
>  	Range of commits to replay; see "Specifying Ranges" in
>  	linkgit:git-rev-parse[1]. In `--advance=<branch>` or
> diff --git a/builtin/replay.c b/builtin/replay.c
> index 39e3a86f6c..d39626a37d 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -85,7 +85,7 @@ int cmd_replay(int argc,
>  	const char *const replay_usage[] = {
>  		N_("(EXPERIMENTAL!) git replay "
>  		   "([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)\n"
> -		   "[--ref=<ref>] [--ref-action=<mode>] <revision-range>"),
> +		   "[--ref=<ref>] [--ref-action=<mode>] [--linearize] <revision-range>"),
>  		NULL
>  	};
>  	struct option replay_options[] = {
> @@ -111,6 +111,8 @@ int cmd_replay(int argc,
>  			     N_("mode"),
>  			     N_("control ref update behavior (update|print)"),
>  			     PARSE_OPT_NONEG),
> +		OPT_BOOL(0, "linearize", &opts.linearize,
> +			 N_("drop merge commits, replaying only non-merge commits")),
>  		OPT_END()
>  	};
>  
> @@ -132,6 +134,8 @@ int cmd_replay(int argc,
>  				  opts.contained, "--contained");
>  	die_for_incompatible_opt2(!!opts.ref, "--ref",
>  				  !!opts.contained, "--contained");
> +	die_for_incompatible_opt2(opts.linearize, "--linearize",
> +				  !!opts.contained, "--contained");
>  
>  	/* Parse ref action mode from command line or config */
>  	ref_mode = get_ref_action_mode(repo, ref_action);
> diff --git a/replay.c b/replay.c
> index 7e35f40d37..1e1bc7c10a 100644
> --- a/replay.c
> +++ b/replay.c
> @@ -404,6 +404,12 @@ int replay_revisions(struct rev_info *revs,
>  	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto,
>  			   &detached_head, &advance, &revert, &onto, &update_refs);
>  
> +	if (opts->linearize &&
> +	    update_refs && strset_get_size(update_refs) > 1) {
> +		ret = error(_("'--linearize' cannot be used with multiple revision ranges"));

Should this say "multiple branches" instead?

> +		goto out;
> +	}
> +
>  	if (opts->ref) {
>  		struct object_id oid;
>  
> @@ -437,26 +443,40 @@ int replay_revisions(struct rev_info *revs,
>  	while ((commit = get_revision(revs))) {
>  		const struct name_decoration *decoration;
>  
> -		/*
> -		 * Decide where to replay this commit on.
> -		 * If the parent commit was replayed already, the replayed result
> -		 * can be found in `replayed_commits`. Otherwise fall back to `onto`.
> -		 * When reverting, commits are replayed in reverse order and thus
> -		 * its parent isn't replayed yet. Therefore revert commits are
> -		 * always replayed onto `last_commit`.
> -		 */
> -		struct commit *parent = commit->parents ? commit->parents->item : NULL;
> -		struct commit *base = get_mapped_commit(replayed_commits, parent, onto);
> -
> -		if (mode == REPLAY_MODE_REVERT)
> -			base = last_commit;
> -
> -		if (commit->parents && commit->parents->next)
> -			die(_("replaying merge commits is not supported yet!"));
> -
> -		last_commit = pick_regular_commit(revs->repo, commit, base,
> -						  &merge_opt, &result,
> -						  mode, opts->empty);
> +		if (commit->parents && commit->parents->next) {
> +			if (!opts->linearize)
> +				die(_("replaying merge commits is not supported yet!"));
> +			/*
> +			 * Drop the merge commit: do not pick it, leave
> +			 * `last_commit` unchanged, and fall through to the
> +			 * rest of the loop. As a result:
> +			 * - refs pointing to the merge commit will be updated
> +			 *   to `last_commit`.
> +			 * - the next replayed commit uses `last_commit` as its
> +			 *   `base`.
> +			 */

Ok, when the linearize option is provided, we now drop the merge commit
and continue on.

> +		} else {
> +			/*
> +			 * Decide where to replay this commit onto.
> +			 * If the parent commit was replayed already, the replayed result
> +			 * can be found in `replayed_commits`. Otherwise fall back to `onto`.
> +			 * When reverting, commits are replayed in reverse order and thus
> +			 * its parent isn't replayed yet. Therefore revert commits are
> +			 * always replayed onto `last_commit`.
> +			 * Also when opts->linearize is true, set the base to
> +			 * `last_commit` to create a single linear history.
> +			 */
> +			struct commit *parent = commit->parents ? commit->parents->item : NULL;
> +			struct commit *base = get_mapped_commit(replayed_commits, parent, onto);
> +
> +			if (opts->linearize || mode == REPLAY_MODE_REVERT)
> +				base = last_commit;

Ok IIUC, when we are linearizing commits we are just replaying them onto
the most recently replayed commit. Makes sense.

-Justin
