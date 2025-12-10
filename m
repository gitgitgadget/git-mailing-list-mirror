Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520C6271462
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765360302; cv=none; b=KMNUTY8gXJ726ws04Ph9i3bN0jTH4p3pdMUFN+nX/ssgLbstUUgP2Wo6U+Ju2NqAUut7c3+02NOLO+1ZSBOBpqnL5gSbtidCqepvO+BPe6biEWIMfu4y+RvxZTNW4j7dX7zUn19kejU4rQV+UMO0h1b3kTBZR9NfwfPykZ+rRYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765360302; c=relaxed/simple;
	bh=Suwt5Isz8WZF3A+JLlxWGZ8As4lS9qQFPDf1KMY6Ebg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ko64mhVP6SjF8ZUI4euXZhItHYSbPfrSnrvojUQCBTR3Ijodp4C/r5l7UOsgbbRPza0Z/YE1o3TmbK9wXLQh+jNTTr2pZYTxiC8jIhijEJ0P+Orjz460CZOxY30X7dJPQjLIybRJaJ8acKzwxgn8ZrNKqNgYNhhttRemZzXyssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJ72Kix+; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJ72Kix+"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42e2b80ab25so2693297f8f.1
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 01:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765360298; x=1765965098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u4RbvdrRcoLJi0JhvhLsVmlqKtRcD32rC5r6s2v55tA=;
        b=PJ72Kix+PK+gRL9oWc9MCcbl0esmBs0S/uOyBwkX4o+w4PH5Ff6a6r2JE5Q8F7yR3O
         Ahkh0ePMoWnHTx5I/Ywh5Aeyd2Z9WtfM7Wi49O3bkaIZ4k3F6KAVBC1LRyaNTrZTDFeJ
         /NTjkq0/MMetefVbU1Qsc9lsZs92qRM9A8eqYivcrj8v5CltW42u94EIPRXztkHOUfCd
         yeSWuJVTo5BuqYEGGm3TdJHj5vtnZtS0966RP346FZCmZBc5AC/o+B3DgnjMe3S3eNZc
         at2z//6UHUDo2pyJbxC4CkyhHo3gQyd5zR6/oubjSQyS7BCjMe93x5yXpDZWQy6Uyj8O
         CjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765360298; x=1765965098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4RbvdrRcoLJi0JhvhLsVmlqKtRcD32rC5r6s2v55tA=;
        b=vZj3D5eZ7b8TjneUVaV4azWr/3ZUlLxEt7ziBbIxsIbbP0eZZ4VvmvJMhwEljL5VCg
         DCUZJxqBYr9doBcrQUgRbD8J/fcueNDlUuDPMak+9w+eMhhAZXi0LumY1xTatjLHRtFs
         nYpylfBMJesmoNwhTQDer2bOkSjX/oLnCFC62yy9UbhnBMnwcuUzLkVyNqpakG2fQxwp
         3A0d0F7eXCu3aT4QKjfjWyZ4sOxgzSuYDs1PjSuIweAAhsIQ8o9PftPwyYwlfkHD94vR
         72LytsS5u/tkqSjzPyxR7Mv5206u3BWykVmLNvg+rXyemMn8C1H4GiQDLzlrOkYFgBx6
         nc6Q==
X-Gm-Message-State: AOJu0YzGqgvVrpaJ9SyyDBiM2LEVsgODKrkXIO45KnXdWbPVsQQSsHLY
	MnE0OQHCrNeWkA3om37rcMhO0cuoxWkNfAoAMux6s/wbexoTYT0xFbHd
X-Gm-Gg: AY/fxX73DAkEUGptSIY/Oi70PMXxTKBtREURfIuPrqRBSRRSfOYWTkbxaF1zj6UIk6I
	ZGVFYZSvRuCCkN6HOdrwGMSiNssfsxVQWCi3QQmCf8WcX6jkrBVI2PFHuF5iUDXgI/73C7cqMlz
	4YtSrxekLCS3nKY7xDVC+swc+zGNVD+Y6GEp1sgzpjpRJ0aw9KoC1enRcGoO191OBNQFSw5nHKm
	rPk5x2opGjINiuk4ipoXBnLRz+jPDOck8pgzcwTZUBnDgGoP3xqdu9Z+8+7ssKk8w1DejlKD2cR
	rv710XsjtaYeBe+MHWcLEQJs3j+EXlEqvHOh650BWC9YSiFYWozkhnTXfU3c1UoHw/S2GR0neao
	hIcW7HvdAxozjic+XWPEn+5pAKw9mnRPcOwVtdUMvTnai7YxBqZFt1BrR2kRQy7xKF4awOz01Fi
	IlW6mpgExETuKwex6vx1GspjVUxNV1M8JZQcI3+YXbGlwlAHrsFLRJWJnnAYyqvtc=
X-Google-Smtp-Source: AGHT+IHwUol6AbigBJ/PkZzhpGKpbMWTLI4v6zPdST0UyqjMnEbIFHAukaRcJ8H9mWBavwMM4d94ow==
X-Received: by 2002:a05:6000:2c11:b0:42b:3ab7:b8b8 with SMTP id ffacd0b85a97d-42fa39d2f5emr1820573f8f.25.1765360298414;
        Wed, 10 Dec 2025 01:51:38 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfee50sm36484425f8f.14.2025.12.10.01.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 01:51:37 -0800 (PST)
Message-ID: <48ba9303-45f4-43bf-a257-10d58474096c@gmail.com>
Date: Wed, 10 Dec 2025 09:51:33 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 11/11] builtin/history: implement "split" subcommand
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 Martin von Zweigbergk <martinvonz@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-11-407dd3f57ad3@pks.im>
 <a27fce64-0d4c-4280-93e5-00cce812d1b2@gmail.com> <aS81GAuKV79x_V2K@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aS81GAuKV79x_V2K@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/12/2025 18:51, Patrick Steinhardt wrote:
> On Fri, Nov 21, 2025 at 02:31:14PM +0000, Phillip Wood wrote:
>> On 27/10/2025 11:33, Patrick Steinhardt wrote:
>>> +	* Construct the first commit. This is done by taking the original
>>> +	* commit parent's tree and selectively patching changes from the diff
>>> +	* between that parent and its child.
>>> +	*/
>>> +	repo_git_path_replace(repo, &index_file, "%s", "history-split.index");
>>> +
>>> +	read_tree_cmd.git_cmd = 1;
>>> +	strvec_pushf(&read_tree_cmd.env, "GIT_INDEX_FILE=%s", index_file.buf);
>>> +	strvec_push(&read_tree_cmd.args, "read-tree");
>>> +	strvec_push(&read_tree_cmd.args, oid_to_hex(&parent_tree_oid));
>>> +	ret = run_command(&read_tree_cmd);
>>
>> Why do we need to fork "read-tree" here rather than call unpack_trees()
>> ourselves?
> 
> This is an artifact of how the `run_add_p()` interfaces work. They
> unfortunately do not work on top of an in-memory index, but they work on
> an on-disk index.

Oh I see, but why does that mean we need to fork a subprocess rather 
than writing the index to disc in this process?

Thanks

Phillip

>>> [...]
>>> +	/* We retain authorship of the original commit. */
>>> +	original_message = repo_logmsg_reencode(repo, original_commit, NULL, NULL);
>>> +	ptr = find_commit_header(original_message, "author", &len);
>>> +	if (ptr)
>>> +		original_author = xmemdupz(ptr, len);
>>> +
>>> +	ret = fill_commit_message(repo, &parent_tree_oid, &split_tree->object.oid,
>>> +				  "", "split-out", &split_message);
>>> +	if (ret < 0)
>>> +		goto out;
>>> +
>>> +	ret = commit_tree(split_message.buf, split_message.len, &split_tree->object.oid,
>>> +			  original_commit->parents, &out[0], original_author, NULL);
>>> +	if (ret < 0) {
>>> +		ret = error(_("failed writing split-out commit"));
>>> +		goto out;
>>> +	}
>>
>> Don't we have the same code for rewording a commit, maybe we should package
>> this up into a shared helper function.
> 
> Hm, indeed, there's a bit of non-trivial logic here. I'll refactor this.
> 
>>> +static int cmd_history_split(int argc,
>>> +			     const char **argv,
>>> +			     const char *prefix,
>>> +			     struct repository *repo)
>>> +{
>>> +	const char * const usage[] = {
>>> +		GIT_HISTORY_SPLIT_USAGE,
>>> +		NULL,
>>> +	};
>>> +	struct option options[] = {
>>> +		OPT_END(),
>>> +	};
>>> +	struct oidmap rewritten_commits = OIDMAP_INIT;
>>> +	struct commit *original_commit, *parent, *head;
>>> +	struct strvec commits = STRVEC_INIT;
>>> +	struct commit_list *from_list = NULL;
>>> +	struct object_id split_commits[2];
>>> +	struct pathspec pathspec = { 0 };
>>> +	int ret;
>>> +
>>> +	argc = parse_options(argc, argv, prefix, options, usage, 0);
>>> +	if (argc < 1) {
>>> +		ret = error(_("command expects a revision"));
>>> +		goto out;
>>> +	}
>>> +	repo_config(repo, git_default_config, NULL);
>>> +
>>> +	original_commit = lookup_commit_reference_by_name(argv[0]);
>>> +	if (!original_commit) {
>>> +		ret = error(_("commit to be split cannot be found: %s"), argv[0]);
>>> +		goto out;
>>> +	}
>>> +
>>> +	parent = original_commit->parents ? original_commit->parents->item : NULL;
>>> +	if (parent && repo_parse_commit(repo, parent)) {
>>> +		ret = error(_("unable to parse commit %s"),
>>> +			    oid_to_hex(&parent->object.oid));
>>> +		goto out;
>>> +	}
>>> +
>>> +	head = lookup_commit_reference_by_name("HEAD");
>>> +	if (!head) {
>>> +		ret = error(_("could not resolve HEAD to a commit"));
>>> +		goto out;
>>> +	}
>>> +
>>> +	commit_list_append(original_commit, &from_list);
>>> +	if (!repo_is_descendant_of(repo, head, from_list)) {
>>> +		ret = error(_("split commit must be reachable from current HEAD commit"));
>>> +		goto out;
>>> +	}
>>
>> This is very similar to cmd_history_reword() up to this point. When we add
>> the "drop" and "amend" subcommands they're going to want to do the same
>> checks.
>>
>>> +	parse_pathspec(&pathspec, 0,
>>> +		PATHSPEC_PREFER_FULL | PATHSPEC_SYMLINK_LEADING_PATH | PATHSPEC_PREFIX_ORIGIN,
>>> +		prefix, argv + 1);
>>
>> This and calling split_commit() below are the only real differences with
>> cmd_history_reword(), is it worth trying to share some more code between the
>> two?
> 
> Yup, done.
> 
> Thanks!
> 
> Patrick
> 

