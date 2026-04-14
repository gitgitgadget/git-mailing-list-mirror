Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A85522FE0E
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175627; cv=none; b=IEP24GESReAoWPdU3nD4mkSoZi5oLx9zL9bu0dhInSA1lXlKVWv47Bfc3FIastx8/iFxV0cemYTj47da1l6NF+k/FUPYsHyQiN1vCEnxorheR5tu9psFN5ibg/tVC+VV0v0PyzZC3PS4IfIKSBG9O9BEtCMRicfcHJOWvclO3Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175627; c=relaxed/simple;
	bh=fBdlmFh/L/fZoQAEeQ2LDNRLico9cynjYkIwb24oFMQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fx52s5C05Cw5/WN7ng2f2vgEc9QDX2aZMY5FBx88JacUiyP+aHs+N6AdFShF0t20mcCLe5x2/N3BHQddcb2NF12CYJFfgYfGrZz+xH4yBuMcy5ewpFtvxFA5iNACJZMFyADN+FJsihpgpOMrgaUIt9rzyY8n6iuIGFM+FUsm3oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7qhVtSK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7qhVtSK"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d75312379so1596437f8f.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 07:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776175623; x=1776780423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1qIgcr4kagISNV4QCsDlFMtPLyn4MSPcQ2w1A2Oai1g=;
        b=s7qhVtSKsPEz4N6x+m4G+VF8p6r2rZfdzq4+Rph2h1XqIo/+tVUoy9AQhWTi3Ttwaf
         +X/TYT4RJSaiyY1j7P5m9XTSbZqqXeAz6cbSwzcDnXVEL4tfFpbNXyl4uhI/hsHapI1U
         HZWMnpQkZDchnqrzlozUjJY0bVQsPQxunXZShxnFYbnCjnPbzb7wiHy/9/IaxCT2F8LU
         3euN6uELuOri2cx3wmgZQ8D1EkbEZ1+7Hm4ZD/cc5verPKwVfi5Fz12k7/ZXnfarCZNb
         cz/PicixtYjwJQVSQFE5thU7bqscpqhpAjArJhAcCsnXQTwqMRHHtf0shTFTOINDAsDm
         gXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776175623; x=1776780423;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qIgcr4kagISNV4QCsDlFMtPLyn4MSPcQ2w1A2Oai1g=;
        b=Zwu1uvyiS/yrasRJiss+RA3LUUsh0naWKBXqrhoe50jM3UVcASzTNKnZXLxqOYMaMR
         9OpZBOlPyYvJWkIdye3nU4ygpypfuAvMGF8Q2e/nHXejJGsOjlfpGu76Q2J8ZyILuTwF
         JN3+/HFsZ/bwzmLs9LUNWDW2fUM9ndMWO3YQpzsKJWd+ktxM2+7cswp54/nCNVEzzo4d
         rkukGx+litBJcD8Y9NgGAL/9i8Qlqa3UALVYNrIfYiU+cWz84p0+gz2GZU0x5XjrBAXA
         TJV2h54FbDchEe0lBDvF9X4OHb6MfPRraIeCVfNTyxd4MRNpbJLJDCz3c+FJPGpfSlCZ
         pw5g==
X-Forwarded-Encrypted: i=1; AFNElJ+fX5MGPk/jFg9PblmTHkpXnCZ0Gcpo/z+8tsdRCUCZ8Q8Oo1x5E607AII6801uJhMMzfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YylUfwTGUPd0PgLE0AfwwDcme1ts6l2VdNGL9Dx+e+oZi5GLlYh
	D9QbS7fGUgpzPR5hkcdQL9fObQnm5IUgSGdKSt843y7UBrH2kUMA4DafsUIHDQ==
X-Gm-Gg: AeBDiev1llOMFCywHnYYu2xTFeCayAU5lrqNB0Jdy7ehSzDRYHErdi1Gt+OOUrxyiF+
	nmpgqABhtpQTC/qAKF3Smee/ZJtx3QhyQ01gQNPxjgkfcM8brwwk3oUAEwXwv0ZSzj5Box0jr1E
	XKQeZTjO2A6NuyFCFUo1QZ7ryQkmmkCti3dvYUEM+OByPmLEzse5U9iUppoId+pNt/D6S8L60+W
	FtO4FW3bewi7w3E58yKtp25Kewxr1NdO3HVvH+/W7YNqz4j+QFlfAT75BiXhv+2QNdnWZAZ1UOv
	IIViUHryRCs8JdEzsXVa/axkW7iwQw2/Ns/XBmHjPA0Z7uNf0IkejXIc69pQ6jylf1bOY/j3fpb
	G4n6G4AcdVQHbkF8b+7+AqoLwm6YIQbgfL2fuKwG5tV/WZ31/0ggcgtXmZHrGwPJeUXIyV4KAID
	6Z/7VvWQrSm1nUn8VSq9IOeZjQafvhW7amc2fzdwXKOKUnL5w7vM5Bg5izLsFyaUErqIPHbEXd5
	rjlY2yOtuCKwg==
X-Received: by 2002:a05:6000:178b:b0:43d:78ae:b785 with SMTP id ffacd0b85a97d-43d78aeba0emr12782151f8f.21.1776175623128;
        Tue, 14 Apr 2026 07:07:03 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e46a85sm42126721f8f.24.2026.04.14.07.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 07:07:02 -0700 (PDT)
Message-ID: <f012cc7e-14fa-40d2-84dc-7407fdceb36d@gmail.com>
Date: Tue, 14 Apr 2026 15:07:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v12 4/4] checkout: -m (--merge) uses autostash when
 switching branches
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Chris Torek <chris.torek@gmail.com>, Jeff King <peff@peff.net>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2234.v11.git.git.1776163819.gitgitgadget@gmail.com>
 <pull.2234.v12.git.git.1776171585.gitgitgadget@gmail.com>
 <911e520431e9923d0b5795532e2abe794477707d.1776171585.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <911e520431e9923d0b5795532e2abe794477707d.1776171585.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

For the subject line I think

     checkout -m: autostash when switching branches

would be more in keeping with our usual style.

On 14/04/2026 13:59, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> When switching branches with "git checkout -m", local modifications
> can block the switch. 

Really? Isn't the point of "checkout -m" to merge the local 
modifications into the branch that's being checked out?

> Teach the -m flow to create a temporary stash
> before switching and reapply it after.  On success, only "Applied
> autostash." is shown. 

and a diff of the local changes?

> If reapplying causes conflicts, the stash is
> kept and the user is told they can resolve and run "git stash drop",
> or run "git reset --hard" and later "git stash pop" to recover their
> changes.
> 
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>

I've skipped the docs as I'm short on time

> @@ -783,8 +783,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
>   	struct tree *new_tree;
>   
>   	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
> -	if (repo_read_index_preload(the_repository, NULL, 0) < 0)
> +	if (repo_read_index_preload(the_repository, NULL, 0) < 0) {
> +		rollback_lock_file(&lock_file);
>   		return error(_("index file corrupt"));
> +	}
>   
>   	resolve_undo_clear_index(the_repository->index);
>   	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
> @@ -797,14 +799,18 @@ static int merge_working_tree(const struct checkout_opts *opts,
>   	} else {
>   		new_tree = repo_get_commit_tree(the_repository,
>   						new_branch_info->commit);
> -		if (!new_tree)
> +		if (!new_tree) {
> +			rollback_lock_file(&lock_file);
>   			return error(_("unable to read tree (%s)"),
>   				     oid_to_hex(&new_branch_info->commit->object.oid));
> +		}
>   	}
>   	if (opts->discard_changes) {
>   		ret = reset_tree(new_tree, opts, 1, writeout_error, new_branch_info);
> -		if (ret)
> +		if (ret) {
> +			rollback_lock_file(&lock_file);
>   			return ret;
> +		}
>   	} else {
>   		struct tree_desc trees[2];
>   		struct tree *tree;
> @@ -814,6 +820,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
>   		refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
>   
>   		if (unmerged_index(the_repository->index)) {
> +			rollback_lock_file(&lock_file);
>   			error(_("you need to resolve your current index first"));
>   			return 1;

The changes up to here look like fixes for an existing bug and so would 
be better in a separate patch.

Sometimes we return "1" and sometimes "-1" what does that signal to the 
caller?

>   		}
> @@ -846,82 +853,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
>   		ret = unpack_trees(2, trees, &topts);
>   		clear_unpack_trees_porcelain(&topts);
>   		if (ret == -1) {
> [lots of deletions]
> -			if (ret)
> -				return ret;
> +			rollback_lock_file(&lock_file);
> +			return 1;
>   		}
>   	}
>   
> @@ -1166,6 +1099,10 @@ static int switch_branches(const struct checkout_opts *opts,
>   	struct object_id rev;
>   	int flag, writeout_error = 0;
>   	int do_merge = 1;
> +	int created_autostash = 0;

This can be a bool

> +	struct strbuf old_commit_shortname = STRBUF_INIT;
> +	struct strbuf autostash_msg = STRBUF_INIT;
> +	const char *stash_label_base = NULL;
>   
>   	trace2_cmd_mode("branch");
>   
> @@ -1203,10 +1140,37 @@ static int switch_branches(const struct checkout_opts *opts,
>   			do_merge = 0;
>   	}
>   
> +	if (old_branch_info.name)
> +		stash_label_base = old_branch_info.name;
> +	else if (old_branch_info.commit) {
> +		strbuf_add_unique_abbrev(&old_commit_shortname,
> +					 &old_branch_info.commit->object.oid,
> +					 DEFAULT_ABBREV);
> +		stash_label_base = old_commit_shortname.buf;
> +	}
> +
>   	if (do_merge) {
>   		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
> +		if (ret && opts->merge) {

As we saw above merge_working_tree() can return non-zero for a variety 
of reasons. We only want to try stashing if the call to unpack_trees() 
failed. Even then if you look at the list of errors in unpack-trees.h 
you'll see that only a few of them relate to problems that can be solved 
by stashing. The old code just tried merging whenever unpack_trees() 
failed so it probably not so bad to do the same here but we should not 
be stashing if merge_working_tree() returns before calling unpack_trees().

> +			strbuf_addf(&autostash_msg,
> +				    "autostash while switching to '%s'",
> +				    new_branch_info->name);
> +			create_autostash_ref_with_msg_silent(the_repository,
> +						   "CHECKOUT_AUTOSTASH_HEAD",

It's a shame we have to create a ref here. MERGE_AUTOSTASH exists so 
that "git merge --continue" can apply the stash once the user has 
resolved any merge conflicts. We don't have that problem here because 
there is no user interaction and we could just hold onto the stash oid 
in a variable.

> +						   autostash_msg.buf);
> +			created_autostash = 1;
> +			ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
> +		}
>   		if (ret) {

I'm confused by this - if we stash then don't we expect the call to 
unpack_trees() in merge_working_tree() to succeed and therefore return 
0? If opts->merge is false then we should not be trying to apply the 
stash when merge_working_tree() fails.

> +			apply_autostash_ref_with_labels(the_repository,
> +						       "CHECKOUT_AUTOSTASH_HEAD",
> +						       new_branch_info->name,
> +						       "local",
> +						       stash_label_base,
> +						       autostash_msg.len ? autostash_msg.buf : NULL);

Can we create an autostash without setting a message in autostash_msg?

>   			branch_info_release(&old_branch_info);
> +			strbuf_release(&old_commit_shortname);
> +			strbuf_release(&autostash_msg);
>   			return ret;
>   		}
>   	}
> @@ -1216,8 +1180,31 @@ static int switch_branches(const struct checkout_opts *opts,
>   
>   	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
>   
> +	if (opts->conflict_style >= 0) {
> +		struct strbuf cfg = STRBUF_INIT;
> +		strbuf_addf(&cfg, "merge.conflictStyle=%s",
> +			    conflict_style_name(opts->conflict_style));
> +		git_config_push_parameter(cfg.buf);

This is rather unfortunate - it might be nicer for 
create_autostash_internal() to set the conflict style.

> +		strbuf_release(&cfg);
> +	}
> +	apply_autostash_ref_with_labels(the_repository, "CHECKOUT_AUTOSTASH_HEAD",
> +				       new_branch_info->name, "local",
> +				       stash_label_base,
> +				       autostash_msg.len ? autostash_msg.buf : NULL);
> +
> +	discard_index(the_repository->index);
> +	if (repo_read_index(the_repository) < 0)
> +		die(_("index file corrupt"));
> +
> +	if (created_autostash && !opts->discard_changes && !opts->quiet &&

Wouldn't it be a bug if we've created and autostash when 
opts->discard_changes is set? Why do we need to check it?

> +	    new_branch_info->commit)
> +		show_local_changes(&new_branch_info->commit->object,
> +				   &opts->diff_options);

So this is a change to the output when using "checkout -m"? If so it 
might be better as a separate change.


I'll have to leave it there for now, I'll try and look at the rest of 
the changes later in the week.

Thanks

Phillip

> +
>   	ret = post_checkout_hook(old_branch_info.commit, new_branch_info->commit, 1);
>   	branch_info_release(&old_branch_info);
> +	strbuf_release(&old_commit_shortname);
> +	strbuf_release(&autostash_msg);
>   
>   	return ret || writeout_error;
>   }
> diff --git a/sequencer.c b/sequencer.c
> index c2516000bd..b78a8ff092 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4770,15 +4770,23 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
>   		strvec_push(&store.args, stash_oid);
>   		if (run_command(&store))
>   			ret = error(_("cannot store %s"), stash_oid);
> +		else if (attempt_apply)
> +			fprintf(stderr,
> +				_("Your local changes are stashed, however, applying it to carry\n"
> +				  "forward your local changes resulted in conflicts:\n"
> +				  "\n"
> +				  " - You can try resolving them now.  If you resolved them\n"
> +				  "   successfully, discard the stash entry with \"git stash drop\".\n"
> +				  "\n"
> +				  " - Alternatively you can \"git reset --hard\" if you do not want\n"
> +				  "   to deal with them right now, and later \"git stash pop\" to\n"
> +				  "   recover your local changes.\n"));
>   		else
>   			fprintf(stderr,
> -				_("%s\n"
> +				_("Autostash exists; creating a new stash entry.\n"
>   				  "Your changes are safe in the stash.\n"
>   				  "You can run \"git stash pop\" or"
> -				  " \"git stash drop\" at any time.\n"),
> -				attempt_apply ?
> -				_("Applying autostash resulted in conflicts.") :
> -				_("Autostash exists; creating a new stash entry."));
> +				  " \"git stash drop\" at any time.\n"));
>   	}
>   
>   	return ret;
> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
> index ad3ba6a984..e4e2cb19ce 100755
> --- a/t/t3420-rebase-autostash.sh
> +++ b/t/t3420-rebase-autostash.sh
> @@ -61,18 +61,30 @@ create_expected_failure_apply () {
>   	First, rewinding head to replay your work on top of it...
>   	Applying: second commit
>   	Applying: third commit
> -	Applying autostash resulted in conflicts.
> -	Your changes are safe in the stash.
> -	You can run "git stash pop" or "git stash drop" at any time.
> +	Your local changes are stashed, however, applying it to carry
> +	forward your local changes resulted in conflicts:
> +
> +	 - You can try resolving them now.  If you resolved them
> +	   successfully, discard the stash entry with "git stash drop".
> +
> +	 - Alternatively you can "git reset --hard" if you do not want
> +	   to deal with them right now, and later "git stash pop" to
> +	   recover your local changes.
>   	EOF
>   }
>   
>   create_expected_failure_merge () {
>   	cat >expected <<-EOF
>   	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
> -	Applying autostash resulted in conflicts.
> -	Your changes are safe in the stash.
> -	You can run "git stash pop" or "git stash drop" at any time.
> +	Your local changes are stashed, however, applying it to carry
> +	forward your local changes resulted in conflicts:
> +
> +	 - You can try resolving them now.  If you resolved them
> +	   successfully, discard the stash entry with "git stash drop".
> +
> +	 - Alternatively you can "git reset --hard" if you do not want
> +	   to deal with them right now, and later "git stash pop" to
> +	   recover your local changes.
>   	Successfully rebased and updated refs/heads/rebased-feature-branch.
>   	EOF
>   }
> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index 9bcf7c0b40..c474c6759f 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -210,6 +210,214 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
>   	test_cmp expect two
>   '
>   
> +test_expect_success 'checkout --merge --conflict=zdiff3 <branch>' '
> +	git checkout -f main &&
> +	git reset --hard &&
> +	git clean -f &&
> +
> +	fill a b X d e >two &&
> +	git checkout --merge --conflict=zdiff3 simple &&
> +
> +	cat <<-EOF >expect &&
> +	a
> +	<<<<<<< simple
> +	c
> +	||||||| main
> +	b
> +	c
> +	d
> +	=======
> +	b
> +	X
> +	d
> +	>>>>>>> local
> +	e
> +	EOF
> +	test_cmp expect two
> +'
> +
> +test_expect_success 'checkout -m respects merge.conflictStyle config' '
> +	git checkout -f main &&
> +	git reset --hard &&
> +	git clean -f &&
> +
> +	test_config merge.conflictStyle diff3 &&
> +	fill b d >two &&
> +	git checkout -m simple &&
> +
> +	cat <<-EOF >expect &&
> +	<<<<<<< simple
> +	a
> +	c
> +	e
> +	||||||| main
> +	a
> +	b
> +	c
> +	d
> +	e
> +	=======
> +	b
> +	d
> +	>>>>>>> local
> +	EOF
> +	test_cmp expect two
> +'
> +
> +test_expect_success 'checkout -m skips stash when no conflict' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 0 x y z >same &&
> +	git stash list >stash-before &&
> +	git checkout -m side >actual 2>&1 &&
> +	test_grep ! "Created autostash" actual &&
> +	git stash list >stash-after &&
> +	test_cmp stash-before stash-after &&
> +	fill 0 x y z >expect &&
> +	test_cmp expect same
> +'
> +
> +test_expect_success 'checkout -m skips stash with non-conflicting dirty index' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 0 x y z >same &&
> +	git add same &&
> +	git checkout -m side >actual 2>&1 &&
> +	test_grep ! "Created autostash" actual &&
> +	fill 0 x y z >expect &&
> +	test_cmp expect same
> +'
> +
> +test_expect_success 'checkout -m stashes and applies on conflicting changes' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 1 2 3 4 5 6 7 >one &&
> +	git checkout -m side >actual 2>&1 &&
> +	test_grep ! "Created autostash" actual &&
> +	test_grep "Applied autostash" actual &&
> +	fill 1 2 3 4 5 6 7 >expect &&
> +	test_cmp expect one
> +'
> +
> +test_expect_success 'checkout -m with mixed staged and unstaged changes' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 0 x y z >same &&
> +	git add same &&
> +	fill 1 2 3 4 5 6 7 >one &&
> +	git checkout -m side >actual 2>&1 &&
> +	test_grep ! "Created autostash" actual &&
> +	test_grep "Applied autostash" actual &&
> +	fill 0 x y z >expect &&
> +	test_cmp expect same &&
> +	fill 1 2 3 4 5 6 7 >expect &&
> +	test_cmp expect one
> +'
> +
> +test_expect_success 'checkout -m stashes on truly conflicting changes' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 1 2 3 4 5 >one &&
> +	test_must_fail git checkout side 2>stderr &&
> +	test_grep "Your local changes" stderr &&
> +	git checkout -m side >actual 2>&1 &&
> +	test_grep ! "Created autostash" actual &&
> +	test_grep "resulted in conflicts" actual &&
> +	test_grep "git stash drop" actual &&
> +	git stash drop &&
> +	git reset --hard
> +'
> +
> +test_expect_success 'checkout -m produces usable stash on conflict' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 1 2 3 4 5 >one &&
> +	git checkout -m side >actual 2>&1 &&
> +	test_grep "recover your local changes" actual &&
> +	git checkout -f main &&
> +	git stash pop &&
> +	fill 1 2 3 4 5 >expect &&
> +	test_cmp expect one
> +'
> +
> +test_expect_success 'checkout -m autostash message includes target branch' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 1 2 3 4 5 >one &&
> +	git checkout -m side >actual 2>&1 &&
> +	git stash list >stash-list &&
> +	test_grep "autostash while switching to .side." stash-list &&
> +	git stash drop &&
> +	git checkout -f main &&
> +	git reset --hard
> +'
> +
> +test_expect_success 'checkout -m stashes on staged conflicting changes' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 1 2 3 4 5 >one &&
> +	git add one &&
> +	git checkout -m side >actual 2>&1 &&
> +	test_grep ! "Created autostash" actual &&
> +	test_grep "resulted in conflicts" actual &&
> +	test_grep "git stash drop" actual &&
> +	git stash drop &&
> +	git reset --hard
> +'
> +
> +test_expect_success 'checkout -m applies stash cleanly with non-overlapping changes in same file' '
> +	git checkout -f main &&
> +	git reset --hard &&
> +	git clean -f &&
> +
> +	git checkout -b nonoverlap_base &&
> +	fill a b c d >file &&
> +	git add file &&
> +	git commit -m "add file" &&
> +
> +	git checkout -b nonoverlap_child &&
> +	fill a b c INSERTED d >file &&
> +	git commit -a -m "insert line near end of file" &&
> +
> +	fill DIRTY a b c INSERTED d >file &&
> +
> +	git stash list >stash-before &&
> +	git checkout -m nonoverlap_base 2>stderr &&
> +	test_grep "Applied autostash" stderr &&
> +	test_grep ! "resulted in conflicts" stderr &&
> +
> +	git stash list >stash-after &&
> +	test_cmp stash-before stash-after &&
> +
> +	fill DIRTY a b c d >expect &&
> +	test_cmp expect file &&
> +
> +	git checkout -f main &&
> +	git branch -D nonoverlap_base &&
> +	git branch -D nonoverlap_child
> +'
> +
> +test_expect_success 'checkout -m -b skips stash with dirty tree' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 0 x y z >same &&
> +	git checkout -m -b newbranch >actual 2>&1 &&
> +	test_grep ! "Created autostash" actual &&
> +	fill 0 x y z >expect &&
> +	test_cmp expect same &&
> +	git checkout main &&
> +	git branch -D newbranch
> +'
> +
>   test_expect_success 'switch to another branch while carrying a deletion' '
>   	git checkout -f main &&
>   	git reset --hard &&
> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 9838094b66..cbef8a534e 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -914,7 +914,7 @@ test_expect_success 'merge with conflicted --autostash changes' '
>   	git diff >expect &&
>   	test_when_finished "test_might_fail git stash drop" &&
>   	git merge --autostash c3 2>err &&
> -	test_grep "Applying autostash resulted in conflicts." err &&
> +	test_grep "your local changes resulted in conflicts" err &&
>   	git show HEAD:file >merge-result &&
>   	test_cmp result.1-9 merge-result &&
>   	git stash show -p >actual &&
> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index f043330f2a..5ee2b96d0a 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -325,6 +325,18 @@ int parse_conflict_style_name(const char *value)
>   		return -1;
>   }
>   
> +const char *conflict_style_name(int style)
> +{
> +	switch (style) {
> +	case XDL_MERGE_DIFF3:
> +		return "diff3";
> +	case XDL_MERGE_ZEALOUS_DIFF3:
> +		return "zdiff3";
> +	default:
> +		return "merge";
> +	}
> +}
> +
>   int git_xmerge_style = -1;
>   
>   int git_xmerge_config(const char *var, const char *value,
> diff --git a/xdiff-interface.h b/xdiff-interface.h
> index fbc4ceec40..ce54e1c0e0 100644
> --- a/xdiff-interface.h
> +++ b/xdiff-interface.h
> @@ -55,6 +55,7 @@ void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
>   void xdiff_clear_find_func(xdemitconf_t *xecfg);
>   struct config_context;
>   int parse_conflict_style_name(const char *value);
> +const char *conflict_style_name(int style);
>   int git_xmerge_config(const char *var, const char *value,
>   		      const struct config_context *ctx, void *cb);
>   extern int git_xmerge_style;

