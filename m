Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79D8367286
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780349597; cv=none; b=Yw8d2aNcJYYN8ta57CnPC/weqDpZgTJoZbjrIPW4/SwyJBdk+S+HK5NiA0nf65Bxm8GKavxFDLNocwjoZq0vO39DxQJRCzpaxgsfwNEBv1If+ci3pnzEXt3ZWFPCX8xTwJkMW/kpk6two/usRgRryyY9uuwgoMy5UJNxBYQipwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780349597; c=relaxed/simple;
	bh=sPJuG/J8DWzRRMTdpMdQZ66geU6tZc/Axu6Qiythlko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UsP3RBXx78qx8FPEfd1YZ4EXBkQ82Xf09E0SdoSnLMazms6GiwGdF/vnXCcDOmD91NW2DVntp8xml0q0uw/5RKuPP3GGnjCMxDUCXBg8ox3owCkloVgJx2QY5q7tWVto5HkzYOJC1SHpT/vawrm+3qcmMDZRh91TEPgWHeOTGR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LIHUesPK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Me4/BU3Q; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LIHUesPK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Me4/BU3Q"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 864497A0053;
	Mon,  1 Jun 2026 17:33:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 01 Jun 2026 17:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780349594; x=1780435994; bh=t0+lBvD1zK
	SUxBKLpt30KTZGXXW4aC33ih3cjTmB35g=; b=LIHUesPK7CqVT7eWvHie6eK517
	Epmb70X72kIpGnfe9nbRVph/B3byrs3imEEIfEI7SLh1eS/RjzqEOiPMMiumD1iy
	G7q2SJ9vdP+E5nqvkyk9Gfs0ScSRSJq3FGY/na0PwTgfiaC1UrVJ7va5dPnhORV6
	7YZ7ReC+W/iofgXJTNZFboVAWxEXAah1+jQrr6J6FJ2Zw0HJw12rHLosHrZtpo2u
	RY+f2m4Vuo2J5Gc6BDWvp4ne7r40d+MfPQDW9wbdHX/1Z5x8u9yw6kBgJsz1h89C
	CYEznOW7nw1cbquxXeRgap2f8F0OSObllsJKfll2O9y1QQKmuwy1XhGwQQqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780349594; x=1780435994; bh=t0+lBvD1zKSUxBKLpt30KTZGXXW4aC33ih3
	cjTmB35g=; b=Me4/BU3QJwzVwPyAH4uYlgxoZ+mBGYrxzk/yVpf18qWPGwLKQ8J
	8Yp9mf9bAJAr1m3iKXK81Zqf5fKfsaL2rSyx6pSccy7tW+a6BGwVg45AkdGaFpeg
	0JtZ51igmW73k8CXzlulRooaUTINOV3IPN4i35tcmR12WwsMy2BAzjEbINrww1RU
	nsRmET/Yek3JwuIVVTBbajHGYtPQKgS7z7nyRcY/62L714l4sBelQF6QGiifaY1r
	6Lci/gcRGHBHDbBpGXx4gYpp35xUSGXo2G6hrkySxO9Q/24ldKreg12KSDBjpgSS
	nNE6oerQ3Z7OF9zru03A7LpU3Tr/VSYyUXg==
X-ME-Sender: <xms:mvodasqqkSmUoMU7P-9provfv0NssICZEfwvXyA7nyim0elUuhNxDA>
    <xme:mvodaspRmKWnwMTFid82n_TqBHqi6C5avMVqkj_d2WaBgFJBY5j1Nplv7bIGngUhi
    ecciLM2QEubzKyG_gb9Fr6TVueqrXr4yYgw88ZMWjPMlSk7JGY>
X-ME-Received: <xmr:mvodan3dzBVXn3B2YXH7qHRNKkMYXULdfsv3xVAUx3uJUqm7fFvwogHvVPPyQvWIHu7udbjX8Ziz_5VA2FAvYizRDcY8PScck2IE>
X-ME-Proxy-Cause: dmFkZTFdmW9AZCwcaqOMgbAo6/z7K0dGQ0LPPkmQ2b9+R5KUG6g35dz7NbmWuk6ojqnpYe
    bzUI2HVyZH6pFUQBdF5Z5PWZNnxsHmbDZ3Clh2I0spEz8dMWAUH9WejmoJH4s9mvNKo842
    mqCHpTzKjpqckc6esMLTGfe+dwR3FNfAaVZHrzgxZCsLt7SeL4GZUVBhpTsoTHVgO608um
    9hlq50+/Ez2Mr57rMpT/LroWahYi+WwGr5JzDcYIQ5bSiqAanP2yX4GmZtp+R6fOWBGy4g
    LvawNcp3hZO0+YePR4aHu7ctwEzf3kM/FXMsGRQHqgUNFnqZBfB4c92cSeUKGc5u2aORW9
    Bz+r9jTQYB0EBHQlmtYEDI0wTGTzQkmRrIeuyvWLiTDFFSupqfEN1FOKqZq/2Ex/Dlu+jT
    yCzkVqSW8NG8TBffXWy/UPenGHU+EnstKSAqp0uaoQ/imvXD5CPfTjIQsaYRef7FZhW8Ji
    i0ITCvN8QxGuoxnRS6QmJCuoXze/xOE8MKiEf8K8j5hcz1wpzacMS9EfCf0yZdcbE0uT3f
    YJ4+Eegvmlr7koYjtnlQ1TplvyJj8x4Z0w+xSZ9WUQPLk6h+SE66FGQM+RL05Dlk/CNtGM
    mzg3O4ffCUeWDLkKJxHjrNzVRRQPg/cDZibHsIBxSzHMReQKCja9bep1yGKQ
X-ME-Proxy: <xmx:mvodaiGaLM1SVk7lOj76A05ugtrRWRBlARN00Qqs0NkN0SKYpbhC0g>
    <xmx:mvodaqGWpqX0SvTQzIW6u0eDtp8zdD6cF5twX0U55YgYHlkzYxkHWQ>
    <xmx:mvodat6oYuDa74Pc-iT3D2keooU8IlwP6t3sleM1NH3x0oG-7CMfQA>
    <xmx:mvodanwvf-VCZCg0BMl6fDzGJClOZSUTbrWjQ4bokABSRFWJLH8ZJw>
    <xmx:mvodauEsCiOiCFwTbk4EjLZ8dpNGIp0pPcgqvsinxUTefG41XMSJYUF0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 17:33:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Thomas Gummerer <t.gummerer@gmail.com>,  Elijah
 Newren <newren@gmail.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  Victoria Dye <vdye@github.com>,  Adam Johnson <me@adamj.eu>
Subject: Re: [PATCH v2] stash: reuse cached index entries in --patch
 temporary index
In-Reply-To: <pull.2306.v2.git.git.1779491545531.gitgitgadget@gmail.com> (Adam
	Johnson via GitGitGadget's message of "Fri, 22 May 2026 23:12:25
	+0000")
References: <pull.2306.git.git.1779194605735.gitgitgadget@gmail.com>
	<pull.2306.v2.git.git.1779491545531.gitgitgadget@gmail.com>
Date: Tue, 02 Jun 2026 06:33:12 +0900
Message-ID: <xmqqcxya3q07.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Adam Johnson <me@adamj.eu>
>
> `git stash -p` prepares the interactive selection by creating a
> temporary index at HEAD, switching `GIT_INDEX_FILE` to it, and then
> running the `add -p` machinery.
>
> That temporary index was created by running `git read-tree HEAD`.  The
> resulting index had no useful cached stat data or fsmonitor-valid bits
> from the real index.  When `run_add_p()` refreshed that temporary index
> before showing the first prompt, it could end up lstat(2)-ing every
> tracked file, even in a repository where `git diff` and `git restore -p`
> can use fsmonitor to avoid that work.
>
> Create the temporary index in-process instead.  Use `unpack_trees()` to
> reset the real index contents to HEAD while writing the result to the
> temporary index path.  For paths whose index entries already match HEAD,
> `oneway_merge()` reuses the existing cache entries, preserving their
> cached stat data and `CE_FSMONITOR_VALID` state.
>
> This makes the refresh performed by `run_add_p()` behave like the one
> used by `git restore -p`: unchanged paths can be skipped via fsmonitor
> instead of being scanned again.
>
> In a 206k file repository with `core.fsmonitor` enabled and a one-line
> change in one file, time to first prompt dropped from 34.774 seconds to
> 0.659 seconds. The new perf test file demonstrates similar improvements,
> with maen times for without- and with-fsmonitor cases dropping from 6.90
> and 6.83 seconds to 0.55 and 0.28 seconds, respectively.
>
> Signed-off-by: Adam Johnson <me@adamj.eu>
> ---
>     stash: reuse cached index entries in --patch temporary index
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2306%2Fadamchainz%2Faj%2Foptimize-stash-patch-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2306/adamchainz/aj/optimize-stash-patch-v2
> Pull-Request: https://github.com/git/git/pull/2306

The diff relative to the previous round looked good.  I am not a
"stash -p" user myself, but I suspect that there are people who
heavily use it, so I'd feel safer if an extra set of eye looks at
the patch and gives an Ack, but other than that I have no comments
on the patch.  Looking good.

Thanks.


>  builtin/stash.c             | 70 +++++++++++++++++++++++++++++++++----
>  t/perf/p3904-stash-patch.sh | 43 +++++++++++++++++++++++
>  2 files changed, 107 insertions(+), 6 deletions(-)
>  create mode 100755 t/perf/p3904-stash-patch.sh
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 32dbc97b47..c4809f299a 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -372,6 +372,56 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
>  	return 0;
>  }
>  
> +static int create_index_from_tree(const struct object_id *tree_id,
> +				  const char *index_path)
> +{
> +	int nr_trees = 1;
> +	int ret = 0;
> +	struct unpack_trees_options opts;
> +	struct tree_desc t[MAX_UNPACK_TREES];
> +	struct tree *tree;
> +	struct index_state dst_istate = INDEX_STATE_INIT(the_repository);
> +	struct lock_file lock_file = LOCK_INIT;
> +
> +	repo_read_index_preload(the_repository, NULL, 0);
> +	refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
> +
> +	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
> +
> +	memset(&opts, 0, sizeof(opts));
> +
> +	tree = repo_parse_tree_indirect(the_repository, tree_id);
> +	if (!tree || repo_parse_tree(the_repository, tree)) {
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	init_tree_desc(t, &tree->object.oid, tree->buffer, tree->size);
> +
> +	opts.head_idx = 1;
> +	opts.src_index = the_repository->index;
> +	opts.dst_index = &dst_istate;
> +	opts.merge = 1;
> +	opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
> +	opts.fn = oneway_merge;
> +
> +	if (unpack_trees(nr_trees, t, &opts)) {
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	if (write_locked_index(&dst_istate, &lock_file, COMMIT_LOCK)) {
> +		ret = error(_("unable to write new index file"));
> +		goto done;
> +	}
> +
> +done:
> +	release_index(&dst_istate);
> +	if (ret)
> +		rollback_lock_file(&lock_file);
> +	return ret;
> +}
> +
>  static int diff_tree_binary(struct strbuf *out, struct object_id *w_commit)
>  {
>  	struct child_process cp = CHILD_PROCESS_INIT;
> @@ -1321,18 +1371,26 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
>  		       struct interactive_options *interactive_opts)
>  {
>  	int ret = 0;
> -	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
>  	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
> +	struct commit *head_commit;
> +	const struct object_id *head_tree;
>  	struct index_state istate = INDEX_STATE_INIT(the_repository);
>  	char *old_index_env = NULL, *old_repo_index_file;
>  
>  	remove_path(stash_index_path.buf);
>  
> -	cp_read_tree.git_cmd = 1;
> -	strvec_pushl(&cp_read_tree.args, "read-tree", "HEAD", NULL);
> -	strvec_pushf(&cp_read_tree.env, "GIT_INDEX_FILE=%s",
> -		     stash_index_path.buf);
> -	if (run_command(&cp_read_tree)) {
> +	head_commit = lookup_commit(the_repository, &info->b_commit);
> +	if (!head_commit || repo_parse_commit(the_repository, head_commit)) {
> +		ret = -1;
> +		goto done;
> +	}
> +	head_tree = get_commit_tree_oid(head_commit);
> +	if (!head_tree) {
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	if (create_index_from_tree(head_tree, stash_index_path.buf)) {
>  		ret = -1;
>  		goto done;
>  	}
> diff --git a/t/perf/p3904-stash-patch.sh b/t/perf/p3904-stash-patch.sh
> new file mode 100755
> index 0000000000..4cfce638be
> --- /dev/null
> +++ b/t/perf/p3904-stash-patch.sh
> @@ -0,0 +1,43 @@
> +#!/bin/sh
> +
> +test_description="Performance tests for git stash -p"
> +
> +. ./perf-lib.sh
> +
> +test_perf_fresh_repo
> +
> +test_expect_success "setup" '
> +	mkdir files &&
> +	test_seq 1 100000 | while read i; do
> +		echo "content $i" >files/$i.txt || return 1
> +	done &&
> +	git add files/ &&
> +	git commit -q -m "add tracked files" &&
> +	echo modified >files/1.txt
> +'
> +
> +test_perf "stash -p, no fsmonitor" \
> +	--setup 'echo modified >files/1.txt' '
> +	printf "q\n" | git stash -p >/dev/null 2>&1 || true
> +'
> +
> +if test_have_prereq FSMONITOR_DAEMON
> +then
> +	test_expect_success "enable builtin fsmonitor" '
> +		git config core.fsmonitor true &&
> +		git fsmonitor--daemon start &&
> +		git update-index --fsmonitor &&
> +		git status >/dev/null 2>&1
> +	'
> +
> +	test_perf "stash -p, builtin fsmonitor" \
> +		--setup 'echo modified >files/1.txt && git status >/dev/null 2>&1' '
> +		printf "q\n" | git stash -p >/dev/null 2>&1 || true
> +	'
> +
> +	test_expect_success "stop builtin fsmonitor" '
> +		git fsmonitor--daemon stop
> +	'
> +fi
> +
> +test_done
>
> base-commit: 7bcaabddcf68bd0702697da5904c3b68c52f94cf
