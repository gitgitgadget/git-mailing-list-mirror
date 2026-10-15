Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488D73EFD3D
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083475; cv=none; b=MIJqOKFC1ZaZZp8yWsBbz75lb+CHh78ifKopkPDNpS3K5P5B+QWnbmWFYyGQS9mwo8OtLE138YeA/MV9Fj5X8yqUjvIQ8vsxhHGCf1oKbVRl41xywFcOPSj36HFbF2EFYl5W5MvJxUBB9t+XhFkKhrA6StWKw4mwA1tZPMpL5xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083475; c=relaxed/simple;
	bh=HvxKys9IIFDNhCBFFeVFtpwE30LZPJQriDIpgPZAy0c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ghCNXPzF/Yb02+m9EWwhn9eh5KAl2SoV0uAAlxts23PIPmJ9Yc+3dle3oYFHaaW3StZluwRiXP3169FwR7Vni1ycJyNQjeWwb1tjs1GbJJrJT9XlJeJWviT8i885fpZJ6XCu5dVIIrMB0NuluNOoqSf+Dk6Zb6hrVtOqfI99xt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=m/exJY7D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q+QzSCu4; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="m/exJY7D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q+QzSCu4"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A1FCC1D00126
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 12:57:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 15 Oct 2026 12:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792083461; x=1792169861; bh=sXjvP3nBEf
	BbzhAC23y6HxoCcE+zhevgJZ7kuuryYws=; b=m/exJY7D5WFHDqQbpwkubSMlJi
	ZG37UqP3HylmQkSdMB1Tx/ZPid0F2EiuIXldSiR6Smfs5JjFMtTjqjNey7DnrQBb
	NsjUxvro7hL6elQQcSPQj9ZSi9U45u9dUlB4lVpEzMDaQfED9b3hHxQkeSd/ejRA
	kMCBxlAkeyXGGqnii0TeaQIBoLL9NVKwY5yzYfmtk9NxVGbb8oXG3aZLZl1/ehYk
	4OAn25DsgyNr6bvxdfgXHGV0cvYBve0oQV39keTOjbg3vDeAqKcIaZv4IHFMhuqj
	djKKyIX1th7bZO+tUXVhED+gy/d+VdHvLkMcfAKr1vSnutMv0apCMpLzl+VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792083461; x=1792169861; bh=sXjvP3nBEfBbzhAC23y6HxoCcE+zhevgJZ7
	kuuryYws=; b=Q+QzSCu4KBU06qsgAOabBZQ9UlpExrbbPfYDkGbeutseka7SzxL
	UWgeKlJKzk1+404Vt1FbSxqFMR3cQk9EKSyJLdPZsxe8QXQV44N3z/Ee8+06iYwE
	GRMhHl7i8CwMlMjAvZGXq/ocmWPeG73JrQomH2GV92NSiKImbRwGCHvPUCw/oAsd
	Rwco20c/0y45tmoA/E7ZQX8ULO8AM9DI6d7r+yeAybk1jp3oswHiDFMcB1ekF59R
	/xz7Z9GCNN0ey3UCDmRxhvBW2OvRC7+oKfZOF95SMsZrDPBUlTUgJHSxXAFpIBg+
	/tPqiqCa/J5aldqUWVJbItGVIJqNxdFbdOA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792083461; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Sx9cQ4tBaogoaBmNZQ1UplY/MAOgXd1sRbBu09mbvs/LKFW
	a6ksKtarTS/JlWtymWTT1ub0cLBn7DrzlDZq8+5uCJvRsR1M+5eFM8JGq/1+T5Zw
	H9wu8Glv+ZfBnwaegDduLrZMzbd+69w5TdMQf9Pn28jzrje6IYsU3s95Pnv0cQI6
	LJeiv+scLRhMkcvDaRniXygwuRr8pluWcaD8b1103psI0iR/QdMAZr3pKVgqCrVm
	9DVS79Qi8JJW5ECcKYjdoK3DcWEtJP9F3GA2zii8MyRcZJmTMXpHTWt6Nr1Mk8jI
	auUD9HErqwMva9sRh7p3HaMHc3NKUoZyJdHVwhw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:lxpriGjOg7Fj6IrNo3wI3uNXVWp8RdCVj4DKUR2ph/4=:HvxKys9IIFDNhCBFFeVFtpwE30LZPJQriDIpgPZAy0c=;
X-ME-Sender: <xms:BAbRaqCBGAG1l_oorX9bmuphJjEzA_et3spuggJmTSE99GWueB9LiA>
    <xme:BAbRagCEd16H2lnpfAljRyJzJWo6kYrThUvjnAAgzmnX6icGFb2YhRxlLYTIbNrHf
    dJywo-sHnr-imDssPOsUSebDtgFXqaXkjnuf5ogUc7EUaxrjmFfRA>
X-ME-Received: <xmr:BAbRakBeHM9O-00sXb0bCW9GhM1ilD2ZJAkezX16CYAn4go2ZhbjMWt30mT5ke2PuupkkY2K0R3cgn6SbmhsPVEdptE3zkUc4mzc>
X-ME-Proxy-Cause: dmFkZTEh+/fPMFAI6koqBZE+yyiZqjgETLUBdZ4aH6wWDvHsSKSbYz4Simj044ATq0Sl9g
    4U/P9L9VoCmp29egBFd9Cc5JEep8OlQi+J1esQLBD9ev2fd9agRmqndubsurTmGkf3u+Ug
    D3x61z+V4LQHYV3OybkUfUrcz0dqhGmjUeoFSyurhnqIRwe7g1RGV8lA2jPgw6Pvqw5GYn
    CO0yqe6xVYmkGNUEsWlOFIsM2zXnfoP5iRORwzitZjXW5Mo9G4sAw0BqaYloqyxutILmND
    atD7HjVL7Krc+kNpshDgWmVP3oQ4IlD0JXNz2clZ+kBEf7Dh/xfdYDuGLZLgKrO/hhIFUo
    2Na10rZCnsDcrtPcZA8+xrmCrtUU+4z2SHjdOvG0J/Cbe/j7iSQyl83vRJ4R4/Bw15xO5X
    reTW5Fq3s2RfhSi1FkBeMB2ago63piOewIADmjFV955u6WJtiMBHtNOQ3NczoHs8TFcb5l
    ToGvJo1EdyT1ZcyWTmlc2VddF9G8GwFCgIFMqnIh0vvuuRehFtoSQnsWjlEtr5aslJzrlt
    0Z2LM3eGDZzFlHQpGEPk0YGlUBGV55Q61gAzaoKDmrwgv4ud+EyJIYdDDYHAVwVN9fit24
    EEGYd+bv3/UfkT1dRgHWgSGjGdpCNqBuBOjBylZnqarNQPFuFVHx3NK5CsHg
X-ME-Proxy: <xmx:BAbRajpe10MnSz_hS6RjxQujmtbWvVJe64ABgrskGNJ5DmIzuUqpQg>
    <xmx:BAbRammUz46Ot-Znnd20Aua3OuVwP2q-y9-k_g57ac9ZzfQmo7LMPA>
    <xmx:BAbRarzOvYLhworv0wk0e-2iXsDW1OiNqN07MsAEV7E19EKV8JvqEw>
    <xmx:BAbRam8vT8f91s1RgLZABkmXp0efXsyqRd8wFfHumkoW0-_f79NEaw>
    <xmx:BQbRak0MruO7izj8JC1clb5jRIdbUWCh_uYmGoPzjhziQsdm-9seaM0C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 12:57:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Miklos Vajna <vmiklos@collabora.com>
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,
  git@vger.kernel.org
Subject: Re: [PATCH] log: speed up --follow following renames for non-linear
 history
In-Reply-To: <atDnyzC_2oaLF0Wo@collabora.com> (Miklos Vajna's message of "Thu,
	15 Oct 2026 16:48:43 +0200")
References: <as44NVKZA9C9S5ae@pks.im> <as6hmUG5AaL5iLbO@szeder.dev>
	<atDnyzC_2oaLF0Wo@collabora.com>
Date: Thu, 15 Oct 2026 09:57:39 -0700
Message-ID: <xmqq8q3yq4u4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miklos Vajna <vmiklos@collabora.com> writes:

> Test the performance of 'git log --stat --follow --
> include/linux/rsc_table.h' on linux.git, it used to take about 28
> seconds, and since commit 304812ed33 (log: improve --follow following
> renames for non-linear history, 2026-06-22), it takes 6m43s.
>
> What happens is that propagate_follow_pathspec_to_parent() does a
> somewhat expensive rename detection of the current commit vs all of its
> parents, and this slows down 'git log --follow'.
>
> Fix the problem by introducing two shortcuts:
> 1) Only do that when the path is added relative to a parent and
> 2) If the path is the same as in one of the parents, then just follow
>    that history
>
> These shortcuts keep all the uses-cases in t4219-log-follow-merge.sh
> working, but now the above use case takes 29s, close to the original
> cost.

The original follow-renames implementation kicked in only when the
path being followed did not exist in the parent.  log_tree_commit()
calls log_tree_diff() to show the diff for the current commit, which
calls diff_tree_oid(), which checks with diff_might_be_rename() to
see if the path we have been following is missing in the parent and
only then runs try_to_follow_renames(), which is expensive, to find
out where it came from.  It avoided the expensive second diff when
we know the path we have been following existed in the parent.

But reading log_tree_commit() in today's code, it seems that
propagate_follow_pathspec_to_parent() is called, after we have
ALREADY spent cycles to run the log_tree_diff() and flushed its
output.  The precious clue that tells you if the path you have been
following is shared with the parent has already been flushed at that
point.

Perhaps inside log_tree_diff_flush() while we still have the list of
filepairs in diff_queue is where you should be able to see if any of
the paths you have been following appeared anew relative to the
parent(s) and to decide if you must adjust the list of paths you
follow for renames, instead of calling the diff machinery all the
time from propagate_follow_pathspec_to_parent() unconditionally.

I am not sure if it may be cleaner to first rip out all the change
introduced in 304812ed33 (log: improve --follow following renames
for non-linear history, 2026-06-22) and then rethink the approach,
instead of piling more code with additional patches.  I dunno.

Thanks.

>  log-tree.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 70 insertions(+), 4 deletions(-)
>
> diff --git a/log-tree.c b/log-tree.c
> index 83a3c4bf9b..0d7bf001f0 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -1180,6 +1180,74 @@ static void propagate_follow_pathspec_to_parent(struct rev_info *opt,
>  	diff_free(&diff_opts);
>  }
>  
> +enum follow_path_change {
> +	FOLLOW_PATH_SAME,
> +	FOLLOW_PATH_ADDED,
> +	FOLLOW_PATH_OTHER,
> +};
> +
> +/* How does the followed path change from parent to commit? */
> +static enum follow_path_change get_follow_path_change(struct rev_info *opt,
> +						      struct commit *commit,
> +						      struct commit *parent)
> +{
> +	struct diff_options diff_opts;
> +	enum follow_path_change ret = FOLLOW_PATH_OTHER;
> +
> +	parse_commit_or_die(parent);
> +	repo_diff_setup(opt->diffopt.repo, &diff_opts);
> +	copy_pathspec(&diff_opts.pathspec, &opt->diffopt.pathspec);
> +	diff_opts.flags.recursive = 1;
> +	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
> +	diff_setup_done(&diff_opts);
> +	diff_tree_oid(get_commit_tree_oid(parent),
> +		      get_commit_tree_oid(commit),
> +		      "", &diff_opts);
> +
> +	if (!diff_queued_diff.nr)
> +		ret = FOLLOW_PATH_SAME;
> +	else if (diff_queued_diff.nr == 1 &&
> +		 !DIFF_FILE_VALID(diff_queued_diff.queue[0]->one))
> +		ret = FOLLOW_PATH_ADDED;
> +
> +	diff_queue_clear(&diff_queued_diff);
> +	diff_free(&diff_opts);
> +	return ret;
> +}
> +
> +/* Compute a path to follow in each parent of a merge */
> +static void propagate_follow_pathspec_to_parents(struct rev_info *opt,
> +						 struct commit *commit,
> +						 struct commit_list *parents)
> +{
> +	const char *path = pathspec_single_path(&opt->diffopt.pathspec);
> +	struct commit_list *p;
> +	enum follow_path_change *changes;
> +	int nr = commit_list_count(parents), i;
> +	int has_same = 0;
> +
> +	if (!path)
> +		return;
> +
> +	ALLOC_ARRAY(changes, nr);
> +	for (p = parents, i = 0; p; p = p->next, i++) {
> +		changes[i] = get_follow_path_change(opt, commit, p->item);
> +		if (changes[i] == FOLLOW_PATH_SAME) {
> +			has_same = 1;
> +			break;
> +		}
> +	}
> +
> +	for (p = parents, i = 0; p; p = p->next, i++) {
> +		if (!has_same && changes[i] == FOLLOW_PATH_ADDED)
> +			/* Never the same, added here: expensive rename detection */
> +			propagate_follow_pathspec_to_parent(opt, commit, p->item);
> +		else
> +			remember_follow_pathspec(opt, p->item, path);
> +	}
> +	free(changes);
> +}
> +
>  /*
>   * Show the diff of a commit.
>   *
> @@ -1303,10 +1371,8 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
>  	if (opt->diffopt.flags.follow_renames) {
>  		struct commit_list *parents = get_saved_parents(opt, commit);
>  		if (parents && parents->next) {
> -			struct commit_list *p;
> -			for (p = parents; p; p = p->next)
> -				propagate_follow_pathspec_to_parent(opt, commit,
> -								    p->item);
> +			propagate_follow_pathspec_to_parents(opt, commit,
> +							     parents);
>  		} else if (parents) {
>  			remember_follow_pathspec(opt, parents->item,
>  				pathspec_single_path(&opt->diffopt.pathspec));
