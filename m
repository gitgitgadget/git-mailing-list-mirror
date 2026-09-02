Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61ED4A8429
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363588; cv=none; b=ng5zRXItJlygVSjRdeCCYy7Q2bUZcHlOAmLHMvSuBZDsBJWvuVhpzRdEZa7DklWeAPnkwoGeKtoXELTNErqXqzpxrg0p2Mv/d0+p3smChgxrQAwj3kcOHiX8GSRYiVJzw/P840YScTu/0KAVI4XHVCCxOyrJCACRlUMROUOq590=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363588; c=relaxed/simple;
	bh=xquwt8225JuihV3juVlLYsWGaPWFcwkNj2NyIG8aS4A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HfvskXGuX5JbB7P8lMXmMhVPEbHDzXSIcYWJqybcAks7A/jY0iYAGrhofQvWtva1hqpgi7CIwV36KZXBN0OlRECT0le/IkfV4CDU6AJFGyQmeaYxUYNMgeDd63xVg5IsepMMTGLhwPuJ4hmZs1ZNanKyRN0z2IQiec4NuAAtklo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwnbWsUv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwnbWsUv"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so12107425e9.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 08:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788363584; x=1788968384; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i9XXejXbdhygYNnHOEMmJ/2MTFLoD3kKzfxLC7M4mcg=;
        b=bwnbWsUv6Oif6WWZbLAlEFStAYZ8RdtK3fHqAwuAaIzIogTF7mx8Cn+TQGhgNQMbRd
         gd+NSQfTGIaRBFghtBJ/4GLYkOkyACZ+40Mf0iUssvTA0Bkz5Chc8acz9swsigH6kStl
         zsz5UhHx/O25mhwjExZFhqnx6lLrxpiWHStDz03hQd/TfRoWpaQ0j6xCBhW5uP8ypu1K
         pcrigUTfQL9zzHpKMjhdYs0hcinQ2iVE6iMi8Lq5CjfxlPWWSOj67PhWFdla6uGzEmJp
         XdYxzdPBBfjlklrS48yyuTAd1krTBLsI2/HZG7ovqCpoYJLUWyi4L3s00HZbJSz+vWdq
         H4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788363584; x=1788968384;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i9XXejXbdhygYNnHOEMmJ/2MTFLoD3kKzfxLC7M4mcg=;
        b=oKD1gtez5N8Ju30x17jPdFtnKsZaoi770FTNoQTzCiijWE7+8BiK2aVcu9BWnH/RTF
         K49pGrSdrDRVH5JN+4mZteJaCg8mlXO2543TwSkc5CM3nRpt2HjG8PB19stQ4Ui2B+Gp
         VP9S7sk1w7CGc/0A14bXC4YCPqyiTQPhAydEw8E9m4qKiQ7M0TNtRUJZsC2A0DyjWezd
         Hr/6N0M0h8QdjrT17s/Mw7GAOTbRDnvreCN/+shoeATw71O+cZJZvQBhcEE0w+mMzrb9
         eyT2jZtbmTlwNXqCbghp31IYYYhFtkXF8bau2Typseu9WNcsrktEV6Edtf4elKrNBqHN
         oa1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq9o5eI14zcDcPKmK+zs7skSt+C68ZuXv9XQyN/L7J1J2S1Kss6sKDx9BxsBnmZRVfxYrk=@vger.kernel.org
X-Gm-Message-State: AFuF++mwKrcTtVKt082Iq6hhQsNusO9jiMhy5a9xDGpXodODt7aCiQ28
	elxxJh2CMUddD53dreu5AGryOtCCa07old2xKdz+lPwUWFDA+0ttevfcXnxoow==
X-Gm-Gg: AR+sD12ADfRjohgO2c8aq8QYCOAJEjwCFkLZIx3tJ9O536qRyNZ0LXZMLJyQvtmLMDV
	Hcj70f2upSeze4nS23Sk9yWMBy0cLmaAjZJtygxDRfq8HdkhP+oswP4DKAk3HIFcx9oiL5jmmOp
	YDB6PSEIYO+kSU/wJ9DJW57JMn5Otq2oElSbioQ6EorGfMKg1IiAQlym7CPIVeN793aif9FJoyW
	vyt7LWFZmIJs8jYL/Z1M146F9jQYpE21oTl1KThSLY1oYE4p7JFHM8eP04Fxs2ZLYJkbdRqgn72
	8uG3TC8Nd/ABqZkHG9M6lbp13oK3eqfYLzq3lGplVQ4fIzhX+o0CoPJjCUARssGvScrwWhajSCz
	SopZA3u2O4EuoAxy5avQUCG1/tEB3NmoT+RMNVB0ye/77C7Y80TLT0J0zDJL3GHBjsCQunO87Z5
	BDw7+tuzwGmF+aEmM8xBoSV/KBVEs74ziwzObZNy7dRSgCjuNi0aOdL9eW730WQfl4vPhHRSo0a
	iQnxQQDiRW2NIvVaC2jW6eA5lzEG+tPP0aGHGu+Z3o=
X-Received: by 2002:a05:600c:4fc8:b0:49c:c96a:d36b with SMTP id 5b1f17b1804b1-49ce581f269mr107990015e9.12.1788363583647;
        Wed, 02 Sep 2026 08:39:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee3acf2csm1047495e9.0.2026.09.02.08.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 08:39:43 -0700 (PDT)
Message-ID: <4ed77ebd-e4ba-4d37-9c92-d987b70135a6@gmail.com>
Date: Wed, 2 Sep 2026 16:39:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 4/5] commit: refuse to amend during conflict resolution
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
 <pull.2389.v4.git.git.1788301481.gitgitgadget@gmail.com>
 <e77b34c1cf414839d922d0ce252d4700a313c7bb.1788301481.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <e77b34c1cf414839d922d0ce252d4700a313c7bb.1788301481.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Elijah

On 01/09/2026 23:24, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Running `git commit --amend` during conflict resolution is an ugly
> foot-gun.  For many years, we have rejected amending during conflict
> resolution in the middle of
>    - a merge
>    - a cherry-pick
> However, this was never extended to other operations that can also
> produce conflicts:
>    - an `am` operation
>    - a revert
>    - a rebase
> 
> Extend it to handle these other cases now.
> 
> Extending to `am`, revert, and the apply backend of rebase are fairly
> straightforward.  However, with the merge backend of rebase we have to
> be more careful, since it powers interactive rebases and
>    - the interactive machinery internally uses `git commit --amend` for
>      `squash` and `reword` directives
>    - users are expected to `git commit --amend` after hitting an `edit`
>      or `break` directive
> So, we need to be careful with rebase to only reject amending when doing
> conflict resolution.
> 
> A few files under the rebase-merge/ directory provide us the necessary
> information:
> 
>    - stopped-sha is written only when the rebase stops and hands control
>      back to the user, so its presence marks a genuine stop -- as opposed
>      to the sequencer's own internal `git commit --amend` while applying
>      a squash, fixup, or reword, during which no stopped-sha exists.
> 
>    - amend is written only when the rebase stops with HEAD already
>      pointing at the commit the user is meant to amend: a clean `edit`,
>      or a fast-forward `reword`.  Its absence at a stop therefore means
>      the commit did not apply, so HEAD is the previously-applied commit
>      rather than the one being rebased -- exactly the case we refuse.
> 
> So for the merge backend we die when stopped-sha exists and amend does
> not.  This covers a plain conflicted pick as well as a conflicted `edit`
> (both leave HEAD on the previously-applied commit), while still allowing
> a clean `edit` or `reword` stop and a `break` stop (no stopped-sha).
> stopped-sha is unlinked at the start of the resume loop, so a resumed
> squash's internal amend is unaffected.

This looks good now that it is using rebase_path_*() rather than hard 
coding the paths.

Thanks

Phillip

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   builtin/commit.c                | 27 +++++++---
>   sequencer.c                     | 57 +++++++++++++++++++++
>   sequencer.h                     | 23 +++++++++
>   t/t3404-rebase-interactive.sh   | 87 +++++++++++++++++++++++++++++++++
>   t/t3507-cherry-pick-conflict.sh | 11 +++++
>   t/t4151-am-abort.sh             | 11 +++++
>   6 files changed, 210 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 9b6eaa3c72..284fc7fdc6 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1324,15 +1324,30 @@ static int parse_and_validate_options(int argc, const char *argv[],
>   		use_editor = 0;
>   
>   	/* Sanity check options */
> -	if (amend && !current_head)
> -		die(_("You have nothing to amend."));
> -	if (amend && whence != FROM_COMMIT) {
> -		if (whence == FROM_MERGE)
> +	if (amend) {
> +		if (!current_head)
> +			die(_("You have nothing to amend."));
> +		/*
> +		 * Refuse to amend in the middle of any operation that is
> +		 * meant to record its result as a new commit on top of HEAD
> +		 * rather than by rewriting HEAD.
> +		 */
> +		switch (sequencer_ongoing_operation(s->repo, whence)) {
> +		case ONGOING_NONE:
> +			break;
> +		case ONGOING_MERGE:
>   			die(_("You are in the middle of a merge -- cannot amend."));
> -		else if (is_from_cherry_pick(whence))
> +		case ONGOING_CHERRY_PICK:
>   			die(_("You are in the middle of a cherry-pick -- cannot amend."));
> -		else if (is_from_rebase_now_empty(whence))
> +		case ONGOING_REBASE_NOW_EMPTY:
>   			die(_("The now-empty commit has been dropped -- cannot amend."));
> +		case ONGOING_REVERT:
> +			die(_("You are in the middle of a revert -- cannot amend."));
> +		case ONGOING_AM:
> +			die(_("You are in the middle of an am session -- cannot amend."));
> +		case ONGOING_REBASE_CONFLICT:
> +			die(_("You are resolving conflicts during a rebase -- cannot amend."));
> +		}
>   	}
>   	if (fixup_message && squash_message)
>   		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
> diff --git a/sequencer.c b/sequencer.c
> index d336c309ca..6a28e0dd9a 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -142,6 +142,13 @@ static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
>    * command is processed, this file is deleted.
>    */
>   static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
> +/*
> + * The apply ("am") backend keeps its state in the rebase-apply directory;
> + * the "applying" file within it marks a plain `git am` (as opposed to an
> + * apply-based rebase).
> + */
> +static GIT_PATH_FUNC(apply_dir, "rebase-apply")
> +static GIT_PATH_FUNC(apply_path_applying, "rebase-apply/applying")
>   /*
>    * When we stop at a given patch via the "edit" command, this file contains
>    * the commit object name of the corresponding patch.
> @@ -6966,6 +6973,56 @@ int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
>   	return 0;
>   }
>   
> +enum ongoing_operation sequencer_ongoing_operation(struct repository *r,
> +						   enum commit_whence whence)
> +{
> +	/*
> +	 * The merge, cherry-pick, and (empty) rebase-pick stops are already
> +	 * distinguished by 'whence'.
> +	 */
> +	switch (whence) {
> +	case FROM_MERGE:
> +		return ONGOING_MERGE;
> +	case FROM_CHERRY_PICK_SINGLE:
> +	case FROM_CHERRY_PICK_MULTI:
> +		return ONGOING_CHERRY_PICK;
> +	case FROM_REBASE_NOW_EMPTY:
> +		return ONGOING_REBASE_NOW_EMPTY;
> +	case FROM_COMMIT:
> +		break;
> +	}
> +
> +	/*
> +	 * 'whence' is FROM_COMMIT, but we may still be in the middle of an
> +	 * operation that records its result on top of HEAD; detect those
> +	 * from their on-disk state.
> +	 */
> +
> +	/* In the middle of a revert? */
> +	if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD"))
> +		return ONGOING_REVERT;
> +
> +	/* In the middle of an `am`? */
> +	if (file_exists(apply_path_applying()))
> +		return ONGOING_AM;
> +
> +	/*
> +	 * In the middle of a rebase that stopped for conflict resolution?
> +	 * The apply backend only ever stops for conflicts, so the presence
> +	 * of its state directory is enough.  The merge backend writes
> +	 * stopped-sha whenever it hands control back to the user, but omits
> +	 * `amend` unless it stopped with HEAD already pointing at the commit
> +	 * to be amended (a clean edit/reword stop); its absence therefore
> +	 * marks a conflicted stop.
> +	 */
> +	if (file_exists(apply_dir()) ||
> +	    (file_exists(rebase_path_stopped_sha()) &&
> +	     !file_exists(rebase_path_amend())))
> +		return ONGOING_REBASE_CONFLICT;
> +
> +	return ONGOING_NONE;
> +}
> +
>   int sequencer_get_update_refs_state(const char *wt_dir,
>   				    struct string_list *refs)
>   {
> diff --git a/sequencer.h b/sequencer.h
> index 64a9c7fb1b..fb4a744208 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -277,6 +277,29 @@ int sequencer_get_last_command(struct repository* r,
>   			       enum replay_action *action);
>   int sequencer_determine_whence(struct repository *r, enum commit_whence *whence);
>   
> +/*
> + * An in-progress operation that records its result (often a conflict
> + * resolution) as a new commit on top of HEAD, during which amending
> + * HEAD via "git commit --amend" is almost always a mistake.
> + */
> +enum ongoing_operation {
> +	ONGOING_NONE = 0,
> +	ONGOING_MERGE,
> +	ONGOING_CHERRY_PICK,
> +	ONGOING_REBASE_NOW_EMPTY,
> +	ONGOING_REVERT,
> +	ONGOING_AM,
> +	ONGOING_REBASE_CONFLICT
> +};
> +
> +/*
> + * Return which in-progress operation, if any, is underway; see enum
> + * ongoing_operation.  'whence' is the origin already computed for the
> + * pending commit.
> + */
> +enum ongoing_operation sequencer_ongoing_operation(struct repository *r,
> +						   enum commit_whence whence);
> +
>   /**
>    * Append the set of ref-OID pairs that are currently stored for the 'git
>    * rebase --update-refs' feature if such a rebase is currently happening.
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 81f4844950..4e6c3e2f19 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1883,6 +1883,93 @@ test_expect_success 'correct error message for commit --amend after empty pick'
>   	test_grep "now-empty commit has been dropped -- cannot amend." err
>   '
>   
> +test_expect_success 'commit --amend is refused at a rebase conflict stop' '
> +	test_when_finished "git rebase --abort" &&
> +	git checkout --detach conflict-branch &&
> +	(
> +		set_fake_editor &&
> +		FAKE_LINES="1 3" &&
> +		export FAKE_LINES &&
> +		test_must_fail git rebase -i A
> +	) &&
> +	test_path_is_file .git/rebase-merge/patch &&
> +	test_path_is_missing .git/rebase-merge/amend &&
> +	echo resolved >conflict &&
> +	git add conflict &&
> +	test_must_fail git commit --amend --no-edit 2>err &&
> +	test_grep "You are resolving conflicts during a rebase -- cannot amend" err
> +'
> +
> +test_expect_success 'commit --amend is refused when an "edit" pick conflicts' '
> +	test_when_finished "git rebase --abort" &&
> +	git checkout --detach conflict-branch &&
> +	(
> +		set_fake_editor &&
> +		FAKE_LINES="1 edit 3" &&
> +		export FAKE_LINES &&
> +		test_must_fail git rebase -i A
> +	) &&
> +	test_path_is_file .git/rebase-merge/patch &&
> +	test_path_is_missing .git/rebase-merge/amend &&
> +	echo resolved >conflict &&
> +	git add conflict &&
> +	test_must_fail git commit --amend --no-edit 2>err &&
> +	test_grep "You are resolving conflicts during a rebase -- cannot amend" err
> +'
> +
> +test_expect_success 'commit --amend is allowed at a rebase edit stop' '
> +	test_when_finished "git rebase --abort" &&
> +	git checkout --detach no-conflict-branch &&
> +	(
> +		set_fake_editor &&
> +		FAKE_LINES="edit 1 2 3 4" &&
> +		export FAKE_LINES &&
> +		git rebase -i A
> +	) &&
> +	test_path_is_file .git/rebase-merge/amend &&
> +	echo tweak >fileJ &&
> +	git add fileJ &&
> +	git commit --amend --no-edit
> +'
> +
> +test_expect_success 'commit --amend is allowed at a rebase break stop' '
> +	test_when_finished "git rebase --abort" &&
> +	git checkout --detach no-conflict-branch &&
> +	(
> +		set_fake_editor &&
> +		FAKE_LINES="break 1 2 3 4" &&
> +		export FAKE_LINES &&
> +		git rebase -i A
> +	) &&
> +	test_must_fail git rev-parse --verify REBASE_HEAD &&
> +	echo tweak >fileJ &&
> +	git add fileJ &&
> +	git commit --amend --no-edit
> +'
> +
> +test_expect_success 'commit --amend is refused at an apply-backend conflict stop' '
> +	test_when_finished "rm -rf apply-backend" &&
> +	test_create_repo apply-backend &&
> +	(
> +		cd apply-backend &&
> +		test_commit base file &&
> +		git branch -M mainline &&
> +		test_commit upstream file upstream &&
> +		git checkout -b side mainline~1 &&
> +		test_commit conflicting file side &&
> +		test_commit unrelated other &&
> +		test_must_fail git rebase --apply mainline &&
> +		# the apply backend only ever stops for conflicts, and
> +		# leaves HEAD on the previously-applied commit
> +		test_path_is_dir .git/rebase-apply &&
> +		test_path_is_missing .git/rebase-apply/applying &&
> +		echo resolved >file &&
> +		git add file &&
> +		test_must_fail git commit --amend --no-edit 2>err &&
> +		test_grep "You are resolving conflicts during a rebase -- cannot amend" err
> +	)
> +'
> +
>   test_expect_success 'todo has correct onto hash' '
>   	GIT_SEQUENCE_EDITOR=cat git rebase -i no-conflict-branch~4 no-conflict-branch >actual &&
>   	onto=$(git rev-parse --short HEAD~4) &&
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
> index 44596cb1e8..42de398f76 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -364,6 +364,17 @@ test_expect_success 'failed revert sets REVERT_HEAD' '
>   	test_cmp_rev picked REVERT_HEAD
>   '
>   
> +test_expect_success 'commit --amend of revert fails' '
> +	pristine_detach initial &&
> +
> +	test_must_fail git revert picked &&
> +	echo resolved >foo &&
> +	git add foo &&
> +	test_must_fail git commit --amend 2>err &&
> +
> +	test_grep "in the middle of a revert -- cannot amend." err
> +'
> +
>   test_expect_success 'successful revert does not set REVERT_HEAD' '
>   	pristine_detach base &&
>   	git revert base &&
> diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
> index 8e1ecf8a68..9313a074b2 100755
> --- a/t/t4151-am-abort.sh
> +++ b/t/t4151-am-abort.sh
> @@ -63,6 +63,17 @@ do
>   
>   done
>   
> +test_expect_success 'commit --amend during a failed am fails' '
> +	git reset --hard initial &&
> +	cp file-2-expect file-2 &&
> +	test_must_fail git am 000[1245]-*.patch &&
> +	echo resolved >file-1 &&
> +	git add file-1 &&
> +	test_must_fail git commit --amend 2>err &&
> +	test_grep "in the middle of an am session -- cannot amend." err &&
> +	git am --abort
> +'
> +
>   test_expect_success 'am -3 --skip removes otherfile-4' '
>   	git reset --hard initial &&
>   	test_must_fail git am -3 0003-*.patch &&

