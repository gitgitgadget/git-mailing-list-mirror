Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EB134F48C
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735481; cv=none; b=kTrQelvaFC+tJU8KnJLyrjdwx/l06SAnXwEfvHysrScTudssoOrdlmhdBKGB4fA3GGGzdPqhPN3DptlU9W6fm530L18Rtp7VnpkA+HdxTaFZfQ+pUtwgeMrIrZd7J0z/EMrMtNo5PHrEffjCZIvzQYofKpiBXZmE1bHYgkpxvHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735481; c=relaxed/simple;
	bh=eRzmSI2p1EW8FgATnPcfuvKyv6BWgY6LXlw4Etfzcx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoC+2yTsg0tCWNZ7fk7klS8Rwod/U7xGo7M5YX/sel8OZ2s6xpFRXHpJBJaB3vStESJCrabMz8uA6p8x3gzP/iaArRIiP5KL0NfL9WUFNdRr4WWeqIvRg4oDVaFwYOmni/33yi7g7JpffoEWjJ/81ACXkUAT2qlrCUVZa5Zymmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYZPUAK6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYZPUAK6"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so18963555e9.2
        for <git@vger.kernel.org>; Fri, 21 Nov 2025 06:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763735477; x=1764340277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uHGG7Ne3gG1yYbblgzzqq7MtF4Hfm4YGMltgQUO2tYI=;
        b=QYZPUAK6TERwGwTmwfhDzEIkE7npkK58HEAC+tgg1UBV8tTmc6StXqaG778pgyPz55
         cfWdyddcuGfPk0OrMuPDuaqaE7SLaJFHXjjmHc9H+R/VBTzIMRUHnL86d3l1I57Na8vH
         sLUf71o7Rd09PGYR526nL+PYuKSjvajOacHcNPZ4ji6yl6SnHCTXXz3hj/lyHzMSUzUm
         9Wr8OKpj0Gjjp9O1qAc3Qk46O7y1TXTubPMditsButjMZsNZwvYJHi05elIg2A5er44/
         blfijKMhjAtb4aane8W2T0Rnqe7yya93s0y/QrUilehyG4IpPy85mv/6ECR5qOUZUn7w
         VzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763735477; x=1764340277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHGG7Ne3gG1yYbblgzzqq7MtF4Hfm4YGMltgQUO2tYI=;
        b=IgavJTv7S6lUoU9025j5vQjbh/XpjYUcqyjc6pjLHMAy2vTKW+99rCyHXEUl1t4HMy
         oyDwr7YmGfgId2NArTiBDbkUFTCTeRRynV59sclnfkLDGUjBzMVc6fB7ZEKmdqFaX5BY
         vpM4h5VjoYvn+mWZgt6a5NZRXDpjou54j3iEFhE/n+qRXg6Nh/EdUsXkwT2UTzZpFkM3
         MWAJIYoJHlkPFVNopuZY/kogoN7kZ45w+8ZayETV8tz17IIJgZvrjv4XeSIZR31+WeTd
         TyokLucf3SHDKAhYfPzafbXeo0TByyhB1VVowSKbtB8YQJT95ItZvPenQfHBELGfhfO1
         zRqw==
X-Forwarded-Encrypted: i=1; AJvYcCWlxitcCIuGjpGvNYbOA0H14vpqJPoAR6tfbdxFXjlaCOS1qySsuTA8lX90wimWOOurbWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfyRjJBZvbkL5UJ1Is/jRhcEUqK3Isa2bPX64izevl5goxS96C
	3wt4AOQvAtNM/rnpuqrrUIHL0v0jM15O1dYT5fxWTMQOdlNSkUyYHICE
X-Gm-Gg: ASbGncsJlkxZ/DUcQ9e7byhHEHni6V7xJDy7o7Skc60QFi/42OSecwrLDclNsPt38JY
	AX5AhbHEh+/LBA8ywnAKeND/akfX/z61aagxjS/276bj9fitrog8fLJXNV2QYK/3WeDUoJXKVwN
	kw+9A+BBxKlPr3YNr8rxS/UzjaG0Im6xPjCoVbwxjxEwWbOFI2hGUULTaYxTSD1Oo69dbY7wyK4
	0gfx7Tvh9HxwPe7lUnZ0dV2y8UjqLHE9phiEaqIblWmRUe2WBF0vyd2HtdTpPPrAc808KtAwafY
	X/oE9ovJY1sq9J45s6K5em06t+ihIUIc/z9F3uZRR9vI2kCCPpp+jTsfMLYddJ/P2vBLvs3RarO
	8qc5BHcIdEFHISDgnWaMWe6eNFhEU+OIYW1PFKASmSXfaTl0j4aFuCh6C+DoNlSBeLowSqrq4Gw
	+RiO0Ft1jQZPCfuNwx9XOvaF97Q9c8Bj+GuLtsxfNb8Jt2PvQ0U3dG+swWt55yGGA=
X-Google-Smtp-Source: AGHT+IHTbLCTqD4InkfYNNfeimpenW4wZkPu5ZkpYB02hOlvSXvbVDMd0zyxXXrPtE0PC9fYY/wHGg==
X-Received: by 2002:a05:600c:314d:b0:477:7975:30ea with SMTP id 5b1f17b1804b1-477c01f2cc7mr25862035e9.29.1763735477213;
        Fri, 21 Nov 2025 06:31:17 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3558d5sm45913305e9.1.2025.11.21.06.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 06:31:16 -0800 (PST)
Message-ID: <a27fce64-0d4c-4280-93e5-00cce812d1b2@gmail.com>
Date: Fri, 21 Nov 2025 14:31:14 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 11/11] builtin/history: implement "split" subcommand
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 Martin von Zweigbergk <martinvonz@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-11-407dd3f57ad3@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20251027-b4-pks-history-builtin-v6-11-407dd3f57ad3@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 27/10/2025 11:33, Patrick Steinhardt wrote:
> It is quite a common use case that one wants to split up one commit into
> multiple commits by moving parts of the changes of the original commit
> out into a separate commit. This is quite an involved operation though:
> 
>    1. Identify the commit in question that is to be dropped.
> 
>    2. Perform an interactive rebase on top of that commit's parent.
> 
>    3. Modify the instruction sheet to "edit" the commit that is to be
>       split up.
> 
>    4. Drop the commit via "git reset HEAD~".
> 
>    5. Stage changes that should go into the first commit and commit it.
> 
>    6. Stage changes that should go into the second commit and commit it.
> 
>    7. Finalize the rebase.
> 
> This is quite complex, and overall I would claim that most people who
> are not experts in Git would struggle with this flow.

If they want to test the split commit it's even more complicated because 
they need to stash the unstaged changes. We should think about how we 
can add support for testing split commits to this command in the future.

> Introduce a new "split" subcommand for git-history(1) to make this way
> easier. All the user needs to do is to say `git history split $COMMIT`.
>  From hereon, Git asks the user which parts of the commit shall be moved
> out into a separate commit and, once done, asks the user for the commit
> message. Git then creates that split-out commit and applies the original
> commit on top of it.

As others have said (and I thought we'd agreed c.f. 
<aMfdR3JE4zq-2j9b@pks.im>) I think it would be better to prompt the user 
to edit the existing commit message when creating both commits. 
Elsewhere Elijah mention being able to split a commit into more than two 
commits. I wonder if we could loop running run_add_p_index() and 
committing the result until there are no more changes left. It does mean 
that the user has to actively select changes for the final commit though 
which might be annoying. We can always play with that later.

Looking below I do wonder if we can share more code between subcommands 
when it comes to checking the commit we're given on the command line and 
re-creating a commit and having the user edit the message.

> +static int split_commit(struct repository *repo,
> +			struct commit *original_commit,
> +			struct pathspec *pathspec,
> +			struct object_id *out)
 > {
> [...]> +	/*
> +	* Construct the first commit. This is done by taking the original
> +	* commit parent's tree and selectively patching changes from the diff
> +	* between that parent and its child.
> +	*/
> +	repo_git_path_replace(repo, &index_file, "%s", "history-split.index");
> +
> +	read_tree_cmd.git_cmd = 1;
> +	strvec_pushf(&read_tree_cmd.env, "GIT_INDEX_FILE=%s", index_file.buf);
> +	strvec_push(&read_tree_cmd.args, "read-tree");
> +	strvec_push(&read_tree_cmd.args, oid_to_hex(&parent_tree_oid));
> +	ret = run_command(&read_tree_cmd);

Why do we need to fork "read-tree" here rather than call unpack_trees() 
ourselves?

> [...]
> +	/* We retain authorship of the original commit. */
> +	original_message = repo_logmsg_reencode(repo, original_commit, NULL, NULL);
> +	ptr = find_commit_header(original_message, "author", &len);
> +	if (ptr)
> +		original_author = xmemdupz(ptr, len);
> +
> +	ret = fill_commit_message(repo, &parent_tree_oid, &split_tree->object.oid,
> +				  "", "split-out", &split_message);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = commit_tree(split_message.buf, split_message.len, &split_tree->object.oid,
> +			  original_commit->parents, &out[0], original_author, NULL);
> +	if (ret < 0) {
> +		ret = error(_("failed writing split-out commit"));
> +		goto out;
> +	}

Don't we have the same code for rewording a commit, maybe we should 
package this up into a shared helper function.

> +static int cmd_history_split(int argc,
> +			     const char **argv,
> +			     const char *prefix,
> +			     struct repository *repo)
> +{
> +	const char * const usage[] = {
> +		GIT_HISTORY_SPLIT_USAGE,
> +		NULL,
> +	};
> +	struct option options[] = {
> +		OPT_END(),
> +	};
> +	struct oidmap rewritten_commits = OIDMAP_INIT;
> +	struct commit *original_commit, *parent, *head;
> +	struct strvec commits = STRVEC_INIT;
> +	struct commit_list *from_list = NULL;
> +	struct object_id split_commits[2];
> +	struct pathspec pathspec = { 0 };
> +	int ret;
> +
> +	argc = parse_options(argc, argv, prefix, options, usage, 0);
> +	if (argc < 1) {
> +		ret = error(_("command expects a revision"));
> +		goto out;
> +	}
> +	repo_config(repo, git_default_config, NULL);
> +
> +	original_commit = lookup_commit_reference_by_name(argv[0]);
> +	if (!original_commit) {
> +		ret = error(_("commit to be split cannot be found: %s"), argv[0]);
> +		goto out;
> +	}
> +
> +	parent = original_commit->parents ? original_commit->parents->item : NULL;
> +	if (parent && repo_parse_commit(repo, parent)) {
> +		ret = error(_("unable to parse commit %s"),
> +			    oid_to_hex(&parent->object.oid));
> +		goto out;
> +	}
> +
> +	head = lookup_commit_reference_by_name("HEAD");
> +	if (!head) {
> +		ret = error(_("could not resolve HEAD to a commit"));
> +		goto out;
> +	}
> +
> +	commit_list_append(original_commit, &from_list);
> +	if (!repo_is_descendant_of(repo, head, from_list)) {
> +		ret = error(_("split commit must be reachable from current HEAD commit"));
> +		goto out;
> +	}

This is very similar to cmd_history_reword() up to this point. When we 
add the "drop" and "amend" subcommands they're going to want to do the 
same checks.

> +	parse_pathspec(&pathspec, 0,
> +		PATHSPEC_PREFER_FULL | PATHSPEC_SYMLINK_LEADING_PATH | PATHSPEC_PREFIX_ORIGIN,
> +		prefix, argv + 1);

This and calling split_commit() below are the only real differences with 
cmd_history_reword(), is it worth trying to share some more code between 
the two?

> diff --git a/t/t3452-history-split.sh b/t/t3452-history-split.sh
> [...]
> +test_expect_success 'refuses to work with merge commits' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit base &&
> +		git branch branch &&
> +		test_commit ours &&
> +		git switch branch &&
> +		test_commit theirs &&
> +		git switch - &&
> +		git merge theirs &&
> +		test_must_fail git history split HEAD 2>err &&
> +		test_grep "cannot rearrange commit history with merges" err &&
> +		test_must_fail git history split HEAD~ 2>err &&
> +		test_grep "cannot rearrange commit history with merges" err
> +	)
> +'

My comments from the reword tests apply here as well.

Thanks

Phillip

> +
> +test_expect_success 'refuses to work with unrelated commits' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit base &&
> +		git branch branch &&
> +		test_commit ours &&
> +		git switch branch &&
> +		test_commit theirs &&
> +		test_must_fail git history split ours 2>err &&
> +		test_grep "split commit must be reachable from current HEAD commit" err
> +	)
> +'
> +
> +test_expect_success 'can split up tip commit' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit initial &&
> +		touch bar foo &&
> +		git add . &&
> +		git commit -m split-me &&
> +
> +		git symbolic-ref HEAD >expect &&
> +		set_fake_editor "split-out commit" &&
> +		git history split HEAD <<-EOF &&
> +		y
> +		n
> +		EOF
> +		git symbolic-ref HEAD >actual &&
> +		test_cmp expect actual &&
> +
> +		expect_log <<-EOF &&
> +		split-me
> +		split-out commit
> +		initial
> +		EOF
> +
> +		expect_tree_entries HEAD~ <<-EOF &&
> +		bar
> +		initial.t
> +		EOF
> +
> +		expect_tree_entries HEAD <<-EOF
> +		bar
> +		foo
> +		initial.t
> +		EOF
> +	)
> +'
> +
> +test_expect_success 'can split up root commit' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		touch bar foo &&
> +		git add . &&
> +		git commit -m root &&
> +		test_commit tip &&
> +
> +		set_fake_editor "split-out commit" &&
> +		git history split HEAD~ <<-EOF &&
> +		y
> +		n
> +		EOF
> +
> +		expect_log <<-EOF &&
> +		tip
> +		root
> +		split-out commit
> +		EOF
> +
> +		expect_tree_entries HEAD~2 <<-EOF &&
> +		bar
> +		EOF
> +
> +		expect_tree_entries HEAD~ <<-EOF &&
> +		bar
> +		foo
> +		EOF
> +
> +		expect_tree_entries HEAD <<-EOF
> +		bar
> +		foo
> +		tip.t
> +		EOF
> +	)
> +'
> +
> +test_expect_success 'can split up in-between commit' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit initial &&
> +		touch bar foo &&
> +		git add . &&
> +		git commit -m split-me &&
> +		test_commit tip &&
> +
> +		set_fake_editor "split-out commit" &&
> +		git history split HEAD~ <<-EOF &&
> +		y
> +		n
> +		EOF
> +
> +		expect_log <<-EOF &&
> +		tip
> +		split-me
> +		split-out commit
> +		initial
> +		EOF
> +
> +		expect_tree_entries HEAD~2 <<-EOF &&
> +		bar
> +		initial.t
> +		EOF
> +
> +		expect_tree_entries HEAD~ <<-EOF &&
> +		bar
> +		foo
> +		initial.t
> +		EOF
> +
> +		expect_tree_entries HEAD <<-EOF
> +		bar
> +		foo
> +		initial.t
> +		tip.t
> +		EOF
> +	)
> +'
> +
> +test_expect_success 'can pick multiple hunks' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		touch bar baz foo qux &&
> +		git add . &&
> +		git commit -m split-me &&
> +
> +		set_fake_editor "split-out-commit" &&
> +		git history split HEAD <<-EOF &&
> +		y
> +		n
> +		y
> +		n
> +		EOF
> +
> +		expect_tree_entries HEAD~ <<-EOF &&
> +		bar
> +		foo
> +		EOF
> +
> +		expect_tree_entries HEAD <<-EOF
> +		bar
> +		baz
> +		foo
> +		qux
> +		EOF
> +	)
> +'
> +
> +
> +test_expect_success 'can use only last hunk' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		touch bar foo &&
> +		git add . &&
> +		git commit -m split-me &&
> +
> +		set_fake_editor "split-out commit" &&
> +		git history split HEAD <<-EOF &&
> +		n
> +		y
> +		EOF
> +
> +		expect_log <<-EOF &&
> +		split-me
> +		split-out commit
> +		EOF
> +
> +		expect_tree_entries HEAD~ <<-EOF &&
> +		foo
> +		EOF
> +
> +		expect_tree_entries HEAD <<-EOF
> +		bar
> +		foo
> +		EOF
> +	)
> +'
> +
> +test_expect_success 'aborts with empty commit message' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		touch bar foo &&
> +		git add . &&
> +		git commit -m split-me &&
> +
> +		set_fake_editor "" &&
> +		test_must_fail git history split HEAD <<-EOF 2>err &&
> +		y
> +		n
> +		EOF
> +		test_grep "Aborting commit due to empty commit message." err
> +	)
> +'
> +
> +test_expect_success 'commit message editor sees split-out changes' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		touch bar foo &&
> +		git add . &&
> +		git commit -m split-me &&
> +
> +		write_script fake-editor.sh <<-\EOF &&
> +		cp "$1" . &&
> +		echo "some commit message" >>"$1"
> +		EOF
> +		test_set_editor "$(pwd)"/fake-editor.sh &&
> +
> +		git history split HEAD <<-EOF &&
> +		y
> +		n
> +		EOF
> +
> +		cat >expect <<-EOF &&
> +
> +		# Please enter the commit message for the split-out changes. Lines starting
> +		# with ${SQ}#${SQ} will be ignored.
> +		# Changes to be committed:
> +		#	new file:   bar
> +		#
> +		EOF
> +		test_cmp expect COMMIT_EDITMSG &&
> +
> +		expect_log <<-EOF
> +		split-me
> +		some commit message
> +		EOF
> +	)
> +'
> +
> +test_expect_success 'can use pathspec to limit what gets split' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		touch bar foo &&
> +		git add . &&
> +		git commit -m split-me &&
> +
> +		set_fake_editor "split-out commit" &&
> +		git history split HEAD -- foo <<-EOF &&
> +		y
> +		EOF
> +
> +		expect_tree_entries HEAD~ <<-EOF &&
> +		foo
> +		EOF
> +
> +		expect_tree_entries HEAD <<-EOF
> +		bar
> +		foo
> +		EOF
> +	)
> +'
> +
> +test_expect_success 'refuses to create empty split-out commit' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit base &&
> +		touch bar foo &&
> +		git add . &&
> +		git commit -m split-me &&
> +
> +		test_must_fail git history split HEAD 2>err <<-EOF &&
> +		n
> +		n
> +		EOF
> +		test_grep "split commit is empty" err
> +	)
> +'
> +
> +test_expect_success 'hooks are executed for rewritten commits' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		touch bar foo &&
> +		git add . &&
> +		git commit -m split-me &&
> +		old_head=$(git rev-parse HEAD) &&
> +
> +		write_script .git/hooks/prepare-commit-msg <<-EOF &&
> +		touch "$(pwd)/hooks.log"
> +		EOF
> +		write_script .git/hooks/post-commit <<-EOF &&
> +		touch "$(pwd)/hooks.log"
> +		EOF
> +		write_script .git/hooks/post-rewrite <<-EOF &&
> +		touch "$(pwd)/hooks.log"
> +		EOF
> +
> +		set_fake_editor "split-out commit" &&
> +		git history split HEAD <<-EOF &&
> +		y
> +		n
> +		EOF
> +
> +		expect_log <<-EOF &&
> +		split-me
> +		split-out commit
> +		EOF
> +
> +		test_path_is_missing hooks.log
> +	)
> +'
> +
> +test_expect_success 'refuses to create empty original commit' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		touch bar foo &&
> +		git add . &&
> +		git commit -m split-me &&
> +
> +		test_must_fail git history split HEAD 2>err <<-EOF &&
> +		y
> +		y
> +		EOF
> +		test_grep "split commit tree matches original commit" err
> +	)
> +'
> +
> +test_expect_success 'retains changes in the worktree and index' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		echo a >a &&
> +		echo b >b &&
> +		git add . &&
> +		git commit -m "initial commit" &&
> +		echo a-modified >a &&
> +		echo b-modified >b &&
> +		git add b &&
> +		set_fake_editor "a-only" &&
> +		git history split HEAD <<-EOF &&
> +		y
> +		n
> +		EOF
> +
> +		expect_tree_entries HEAD~ <<-EOF &&
> +		a
> +		EOF
> +		expect_tree_entries HEAD <<-EOF &&
> +		a
> +		b
> +		EOF
> +
> +		cat >expect <<-\EOF &&
> +		 M a
> +		M  b
> +		?? actual
> +		?? expect
> +		?? fake-editor.sh
> +		EOF
> +		git status --porcelain >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_done
> 

