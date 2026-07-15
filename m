Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755B037E5C6
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784129427; cv=none; b=j6NocqK2lgIOkx7bfEqky1x79hXiPuHBUzxqpK1iiXHRPp+KyRtWZtIDDYIPFNyKG81nt5g/dc04njVIko4YvbYyanB2q4Xmd3Dy7Ui9QoeXqXxzTlyoWVhiAQf5yomeSpvWMiHGCks8Vc8ufeaGeb7UUZRaILaLKeXuvw3W1Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784129427; c=relaxed/simple;
	bh=v5qBQ5sNYBfxgDiaZSuAtwG2deXUAOiymoVQ8RC1gDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCBOsr4nc6KiBiFqQfKxirFlqoKdnNR9COa2E5XN+fKvC7875WCAArORZluBKXPMTtOgvVAGZNxp/pkomenhRrt+OQHb/iNRMgowucuS7Ri1XmJ4av33QHBxi/5oxyyVmB/TPWoLLQ5jTgdltn2VubB9hEhfgJPQe6dQR6nByPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KggB+hl3; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KggB+hl3"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69a5ecbbfb2so3768323a12.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 08:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784129424; x=1784734224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0RXoyFhcuZeqjw26pNgTREjQN3PnSfgqIwyStAtKlHQ=;
        b=KggB+hl3G7BnpOabInluk2V9xpzEFRJ3ERmgrwcya+xLJfuMe+ka1qM7tcX5goC1yM
         40HZzd+RV+UOYaMYZ+4RehjAja8FQ9YW8qrFnjoaPAoa4GoXBCQnKzb6HiMOTsoeL0FC
         /hnaBFDG//Lro6wfyVbbWsZy9XTUmvWiU/7+o4TWWkwGTmUlWqXPLrz+DZplqDLI+zNh
         bWZoAeSRh8Kepe3Zbp0Woh9+0qD/Er65/x2YlqOi7kd9lwJVjEQx1t3fZT9JrPlmw7vr
         mRXVcyDjGBEj3fAdBFsJ4j38gmHIRbaDFnegTAKIfiW+wVKjXFMpEOEXfxrCoX/2dKgs
         i5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784129424; x=1784734224;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0RXoyFhcuZeqjw26pNgTREjQN3PnSfgqIwyStAtKlHQ=;
        b=fGa6fuq3pkqzfeJUO2CRAtDkjVZov+YC41ABbOGrJ53vZMOp6IgR44J1yEvhrfxmZh
         sF51nlUXTjPPfA3FDTQEY31l9fYU3anVDgbrIwBPKCBx6yM+GdEvqS326YzT3XTYE7ah
         8qTSJP6RG1zrigcQDKUwxUMTEc9ezwUTChj9OZR1MzfZxwwJmzkRw9yo6X7RoKLd4ESU
         PM9ECLI0CkEeLUYRszmzkUYM+XBDAKhboVTYg8q4DeQnYcTvK85sbHUaWSd91ogoxju6
         /Zf2YPyX+JlK2q4SUnD9MWui+1yUCu0NHmARvxr+zJcu1JglMyAwJ63UvfkK6DzBNKWM
         yhSw==
X-Forwarded-Encrypted: i=1; AHgh+RqsAYFhRUuCRlDMTzbSzVgMzYROQKd4O7pT8SY6f8bh/m/NAuTMf66vtfzLKMCJBfNlyUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt6H02Xzf+D1apN19vrlxbfX6AOaIClCD7ISkPELhSussf7wfn
	H5BKZfiGBPPE8Zr8gZa4V1+/sK2ngL76ODYRchXwZGw4tSgoy2KVJkWz
X-Gm-Gg: AfdE7clSnP5KFvZt7BXnIIGAz78lqJ1p7Q4nvwZ0B/yHMINNqrgpe31P9OmPeQ4p3Eo
	oiV0kEYgDM17a/6aT12VP4ZPhFkIPMI0+0EEb529EHRO5cKw3gR+UggPKZyfVrD+X1PZjmNDuJt
	ggb0Oh/Icd4sVnu7UdfLelFOS62gwTvMrj6zSX2STVEe9NDPanFqUVwF9JBgI191sxXKAylpjan
	FAKJdja7WmSclZVbPEu55A3l0m4iKd4DzTBG9LW7WrMxfAadFdXW7mxQ+2djXjB6bkuNkNkOcB/
	A1sAnbSb4JrHuWZAwFTkg2a4Z7olzcgRAfN6yjuJwIv0CaoKXIXzxrGfj79C0aC2ufUBaSBC38V
	k0Y1MCoi7tCP2KBO89V9ervH46a128Sf0cNAB4GeHOhRwpYg6NuUKzLVNyEZX8itvA/JUbkfurO
	nZiLJvheELXiX0uc/taWQB5sMzfIzxFtP/bqP7IHR0KVkh4tmXXkZBFbATmPtL4GNlQ8M=
X-Received: by 2002:a05:6402:3512:b0:699:6415:750a with SMTP id 4fb4d7f45d1cf-69c5f12197cmr8625935a12.23.1784129423269;
        Wed, 15 Jul 2026 08:30:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd2878eaesm3346231a12.2.2026.07.15.08.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 08:30:22 -0700 (PDT)
Message-ID: <690b965e-5f07-4aa4-a64c-96e60a86d73b@gmail.com>
Date: Wed, 15 Jul 2026 16:30:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] sequencer: honor --empty when a fixup!/squash! empties
 its target
To: Farid Zakaria <farid.m.zakaria@gmail.com>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>
References: <20260711-fz-autosquash-empty-v3-1-d227b63eb511@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260711-fz-autosquash-empty-v3-1-d227b63eb511@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Farid

On 12/07/2026 01:38, Farid Zakaria wrote:
> When "git rebase --autosquash" melds a "fixup!" or "squash!" commit into
> its target, the result can be a commit that no longer changes anything
> relative to its parent, for example when the melded change reverts the
> target.  Rather than dropping or keeping this empty commit, the rebase
> stops with
> 
> 	You asked to amend the most recent commit, but doing so would
> 	make it empty. ...
> 
> and the "--empty" option has no effect on it.  This makes backing a
> change out of a series awkward: reverting a commit as a "fixup!" and
> running "git rebase --autosquash --empty=drop" ought to remove both the
> commit and its revert, but it halts instead.
> 
> A "fixup!" is applied by amending HEAD, so the melded commit has HEAD's
> parent as its parent and is empty when the index matches the tree of that
> parent, not of HEAD.  do_pick_commit() only compares against HEAD, so it
> never notices that the meld cancelled the commit out and falls through to
> "git commit --amend", which refuses to create an empty commit.
> 
> After melding a fixup or squash, check whether the amended commit is
> empty -- its index matches the tree of HEAD's parent -- and, if so, honor
> "--empty" just as for a commit that becomes empty when picked: keep it,
> drop it, or halt.

To honor --empty we need to know if the commit that is being fixed up 
was originally empty or not, as we should only drop commits that become 
empty. That means we cannot just check if the commit has become empty 
after applying the fixup - we somehow need to remember whether the 
original commit was empty as well.

Having thought about it a little more, there are a quite a few corner 
cases which we need to think about. If there are conflicts when applying 
the revert  the user might run "git reset HEAD^" to drop the commit 
themselves which makes our life easy because we don't need to do 
anything special when they continue the rebase. However, they could run 
"git checkout HEAD^ :/" to reset all the files in the worktree without 
dropping the commit, in which case we need to update 
commit_staged_changes() to drop HEAD if it wasn't originally empty.

If HEAD becomes empty in the middle of a sequence of fixups, for example

     pick C
     fixup revert-C
     fixup D

we don't want to squash D into the previous commit, so I think we should 
only drop commits that become empty after applying the all the fixups 
targeting it. do_pick_commit() has a final_fixup function argument so 
that should not be a problem.

If the original commit is empty then

     pick empty
     fixup commit-that-becomes-empty

or

     pick empty
     fixup empty-fixup

should not drop the fixed up commit. In the first example we should 
continue to respect --empty=stop for the fixup becoming empty. The 
latter only really makes sense with "fixup -C", or "fixup -c".

There isn't necessarily a pick command before a fixup for example

     reset C
     fixup revert-C

or

     exec some command
     fixup revert-HEAD

or

     break
     fixup revert-HEAD

are all possible if the user edits the todo list. For these three cases 
one option is to say that because there is not a "pick" command before 
the "fixup" command we don't drop the commit. I think that probably 
makes it easier to determine if the original commit was empty because we 
can record that when we see the "pick" command. That does feels a bit 
inconsistent though. It is possible that a commit can become empty after 
the user has reworded or edited it

     reword C # or edit C
     fixup revert-C

but it is a bit strange for the user to ask to edit a commit if they 
really want to drop it, so maybe requiring a "pick" command in order for 
the commit to be dropped is a good idea.

I think we can record whether a pick is empty at the beginning of 
do_pick_commit() and store that in a new member of struct replay_ctx. 
We'll need to save and restore that new member when we stop for the user 
to resolve conflicts. The state reading is done in read_populate_opts(). 
To save it we'll need to create a file when we stop for conflicts.

> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index f6c22d1598..7eb8bbe95f 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -282,6 +282,11 @@ by `git log --cherry-mark ...`) are detected and dropped as a
>   preliminary step (unless `--reapply-cherry-picks` or `--keep-base` is
>   passed).
>   +
> +A commit can also become empty as a result of `--autosquash`, when a
> +`fixup!` or `squash!` commit cancels out all of the changes of the
> +commit it is melded into.

The rebase man page does not currently use "melded", it talks about 
squashing commits together - we should probably make the new text 
consistent with that.

> diff --git a/sequencer.c b/sequencer.c
> index 0fe8fed6c3..bc24132c7c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1817,6 +1817,39 @@ static int allow_empty(struct repository *r,
>   		return 0;
>   }
>   
> +/*
> + * Melding a "fixup!"/"squash!" amends HEAD, so the resulting commit is empty
> + * when the index matches the tree of HEAD's parent (rather than of HEAD, as a
> + * plain pick would).  Returns 1 if the amended commit would be empty, 0 if not,
> + * and negative on error.
> + */
> +static int amended_commit_is_empty(struct repository *r)
> +{
> +	struct object_id head_oid, *cache_tree_oid;
> +	const struct object_id *parent_tree_oid;
> +	struct commit *head_commit;
> +
> +	if (repo_get_oid(r, "HEAD", &head_oid))
> +		return error(_("could not resolve HEAD commit"));
> +	head_commit = lookup_commit_reference(r, &head_oid);

You can simplify this slightly with

	head = lookup_commit_reference_by_name(r, "HEAD");
> +	if (!head_commit || repo_parse_commit(r, head_commit))
> +		return -1;
> +
> +	if (head_commit->parents) {
> +		struct commit *parent = head_commit->parents->item;
> +		if (repo_parse_commit(r, parent))
> +			return -1;
> +		parent_tree_oid = get_commit_tree_oid(parent);
> +	} else {
> +		parent_tree_oid = the_hash_algo->empty_tree;
> +	}
> +
> +	if (!(cache_tree_oid = get_cache_tree_oid(r->index)))
> +		return -1;
> +
> +	return oideq(cache_tree_oid, parent_tree_oid);
> +}
> +
>   static struct {
>   	char c;
>   	const char *str;
> @@ -2260,10 +2293,34 @@ static const char *reflog_message(struct replay_opts *opts,
> [...]
>   static int do_pick_commit(struct repository *r,
>   			  struct todo_item *item,
>   			  struct replay_opts *opts,
> -			  int final_fixup, int *check_todo)
> +			  int final_fixup, int *check_todo, int *dropped)

Rather than adding a new parameter, I think we should extend the return 
enum added in pw/rebase-drop-notes-with-commit with a new member to 
indicate that we dropped HEAD.

> @@ -2493,23 +2553,67 @@ static int do_pick_commit(struct repository *r,
>   	}
>   
>   	drop_commit = 0;
> -	allow = allow_empty(r, opts, commit);
> -	if (allow < 0) {
> -		res = allow;
> -		goto leave;
> -	} else if (allow == 1) {
> -		flags |= ALLOW_EMPTY;
> -	} else if (allow == 2) {
> -		drop_commit = 1;
> -		refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
> -				NULL, REF_NO_DEREF);
> -		unlink(git_path_merge_msg(r));
> -		refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
> -				NULL, REF_NO_DEREF);
> -		fprintf(stderr,
> -			_("dropping %s %s -- patch contents already upstream\n"),
> -			oid_to_hex(&commit->object.oid), msg.subject);
> -	} /* else allow == 0 and there's nothing special to do */

I don't think we want to delete this - we still want to tell the user if 
a fixup became empty, but we want an additional check along the lines of

	if (final_fixup) {
		/*
		 * If the original commit was not empty and HEAD is now
		 * empty then drop HEAD.
		 */
  	}

> @@ -4980,7 +5084,7 @@ static int pick_one_commit(struct repository *r,
>   		return error_with_patch(r, commit,
>   					arg, item->arg_len, opts, res, !res);
>   	}
> -	if (is_rebase_i(opts) && !res)
> +	if (is_rebase_i(opts) && !res && !dropped)
>   		record_in_rewritten(&item->commit->object.oid,
>   				    peek_command(todo_list, 1));

Don't we need to clear the pending list of rewritten commits from the 
original pick and any intermediate fixups, rather than just to skipping 
recording the final fixup as rewritten? It is probably worth adding a 
test to 5407 to check that (there is an example in 
pw/rebase-drop-notes-with-commit).
> diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
> index 5033411a43..d8085abf1d 100755
> --- a/t/t3415-rebase-autosquash.sh
> +++ b/t/t3415-rebase-autosquash.sh
> @@ -461,13 +461,15 @@ test_expect_success 'abort last squash' '
>   	git commit --allow-empty -m second &&
>   	git commit --allow-empty --squash HEAD &&
>   
> +	: "squashing empty onto empty leaves an empty commit; --empty=keep" &&
> +	: "keeps it so the squash still reaches the editor, which aborts" &&
>   	test_must_fail git -c core.editor="grep -q ^pick" \
> -		rebase -ki --autosquash HEAD~4 &&
> +		rebase -ki --autosquash --empty=keep HEAD~4 &&

Are we adding --empty=keep for clarity here? I wonder if the original 
was deliberately testing the default.
>   	: do not finish the squash, but resolve it manually &&
>   	git commit --allow-empty --amend -m edited-first &&
>   	git rebase --skip &&
>   	git show >actual &&
> -	! grep first actual
> +	test_grep ! first actual
>   '


> +test_expect_success 'fixup! leaving an empty commit empty stops with --empty=stop' '
> +	git reset --hard base &&
> +	git commit --allow-empty -m placeholder &&
> +	git commit --allow-empty -m "fixup! placeholder" &&

As both commits start off empty we shouldn't stop. --empty only applies 
to commits that become empty when they are rebased. The same applies to 
the next couple of tests.

Thanks

Phillip

> +	test_when_finished "git rebase --abort" &&
> +	test_must_fail git rebase -i --autosquash --empty=stop HEAD~2
> +'
> +
> +test_expect_success 'fixup! leaving an empty commit empty is dropped with --empty=drop' '
> +	git reset --hard base &&
> +	git commit --allow-empty -m placeholder &&
> +	git commit --allow-empty -m "fixup! placeholder" &&
> +
> +	git rebase -i --autosquash --empty=drop HEAD~2 &&
> +
> +	git log --format=%s >actual &&
> +	test_grep ! placeholder actual
> +'
> +
> +test_expect_success 'fixup! leaving an empty commit empty is kept with --empty=keep' '
> +	git reset --hard base &&
> +	git commit --allow-empty -m placeholder &&
> +	git commit --allow-empty -m "fixup! placeholder" &&
> +
> +	git rebase -i --autosquash --empty=keep HEAD~2 &&
> +
> +	git log --format=%s >actual &&
> +	test_grep placeholder actual &&
> +	git diff --exit-code HEAD~1 HEAD
> +'
> +
> +test_expect_success 'a dropped emptied fixup is not recorded as rewritten' '
> +	git reset --hard base &&
> +	test_commit --no-tag preR fileR 1 &&
> +	test_commit --no-tag changeR fileR 2 &&
> +	R=$(git rev-parse HEAD) &&
> +	echo 1 >fileR &&
> +	git commit -m "fixup! changeR" fileR &&
> +	F=$(git rev-parse HEAD) &&
> +	test_commit --no-tag keepR fileK keep &&
> +
> +	test_when_finished "rm -f .git/hooks/post-rewrite actual.rewrites" &&
> +	write_script .git/hooks/post-rewrite <<-\EOF &&
> +	cat >actual.rewrites
> +	EOF
> +
> +	git rebase -i --autosquash --empty=drop HEAD~4 &&
> +
> +	: "changeR and its fixup were dropped, so must not be reported as" &&
> +	: "rewritten, but the surviving keepR must be" &&
> +	test_grep ! -e "$R" -e "$F" actual.rewrites &&
> +	test_grep "$(git rev-parse HEAD)" actual.rewrites
> +'
> +
>   test_done
> 
> 
> 
> 

