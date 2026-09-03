Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3674B1284
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444053; cv=none; b=f4czMDKPWFSfNhemhZXSvBfmYCYjSErjpHBHcXl5+HT1FmDIf++D2RMnQjlYacf24t+JWaf8dj+NbSKHdcLJh4K1xsePjh2wku/7U4flwj3ONozGB/8Mj4AqvAhQhtpl1Co3aYBRa0Zg7sPaJaaYQdehvFaAzQn+sd2Hw54CuQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444053; c=relaxed/simple;
	bh=cTF4KQef4kSBfsAaPJsRuV+0QBSE1Kt5SdRUFo/3E1I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=unAUYsPQN2lA6hmh/jVanlLnGdwM781G4oaLy7zevqcWOee5hyefJXCJSXz6Dc4B/YHB3gTL+nWSTLLGc7ZO0yYje1hlEyLSHlrjRwNU0kNVhDt4ZIO36duko1wUekWvVrJhRHVV4mz8riiRwbQs8uum6aVrzYLIjbv4gpmuQTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qm3YX4uB; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qm3YX4uB"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a668cacdadso3656997a12.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 07:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788444031; x=1789048831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RdT/ppwUUEzWtzCUqo+Ay5wlVsJMruxEmufDIOqFKz8=;
        b=Qm3YX4uBpcV35+jBwuch6V9mR9g1MjPtczh4bJmJbOKKVavDVRqOy1u/n85bXFmpsn
         kG96UHAMI+0SsHHCbtHqndXn3P/vhZofHrFAvo7swIDdsnxNQXPrsOIaDQVCMAiDGMTL
         1b+VWGlbjmG0E6HiESKezuzaTKU84XhETDoRN30kCoJ0MT0F7ecu4aV4cs+brBGXBfLt
         P7A3EqZQ3qTTbmHnh87D3g4FlVeZPt6yZlNDF9Av5Or1o3DZ6MRpcIrZqO+JkggG96ea
         cqZ1z84XNhT/shDGnGda8nJgvPrevLtgsBx9lpWn7a2tOhY6sjaEvZ8mgPjqjLnMjJT4
         7oNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788444031; x=1789048831;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RdT/ppwUUEzWtzCUqo+Ay5wlVsJMruxEmufDIOqFKz8=;
        b=JtL9XTpgxg72JM8o6GpFGIrvO4FsEO4aydkRdwr8xUkOzQ8q/sJ771kh976sfLiwQl
         DzAi15uFM5BESIShH0XmnKpLpSXGUHOAHPpYb1vJb9kVFjs0wFW3nSLo8q8uZIydgkt5
         56dDThD3zACtJoiqOE2pxZXV2EcTYHMN6FbLOGAC2a+2VJM+65ZLJd1YkXZFCXhowrRq
         F9hYnMxvRcw/MEV5v5b9P7Qrprskc27BDCWa+FpmXPe3AjWhvEgJdfSZwR6Dg0BEqVHX
         HDJxpI1nCbbOENUOStQssIq6vsUxlm8bosLxm85fSrmsfhvnP/DEktgT17LqZ1LUcNgk
         7EfQ==
X-Forwarded-Encrypted: i=1; AKwUvByTHJwBiIHd6n2eEqoMl6MNl87Db9mZIZ0gTeOQz+BH1V5NLivN0unZ5w03iYbHeBYbHAU=@vger.kernel.org
X-Gm-Message-State: AFuF++kl578+OAS7ojV3o+MfkOiIFrwuML1gjXJPT0pepoDFiZSHSwGF
	3Yk0QB9VVkndfV05GxrAl8Kef2WAfOWr0zN27i2j7QHTO+OLfBpaUA69
X-Gm-Gg: AYBFou3JE7seqXx3W4ZYtittLB22RCbPDaThnoNi+8UWACOwmyBEWbFSTnVCxWDbyE5
	cteaquL/rV9hCjjX2EGUV9mREks4MEAButjaKfsionFI5hIASYWh0t+ol+LaqP5tWBFjkB2xxTh
	Kg0VtkrUFoDCZcxR3fRlt62b5N5gx3AiC17l8zlnZEIJGy9eZ/W6zQNrh3dwMgioMVwYjFoP3EN
	iVP2YsYToH0s4qbqROyyTv2cd37mTuneW/EM+j+C04EFek7x0FJT53O9hfrN5G5GztX/by0ACPH
	KefrLK96/a63DFYgP7oMGWnUJKd2VyqgdL+G9glXDSEQzjQdPEwBmLpdfDB5S4O3E30SskrrAKg
	SZtROv4RDbXKLSMZrnr4MWTYhENMY3q6UFW2UnEeI1dz8C1VFAhWR+ZwBBSiNlmM/j3xdHYwCJX
	wAkVz7AxYVVqeg/zmPtfrXk9qGncYWpw/AxTAusu9SmypMth5nPp7Mq5WxmzLjgi3moXfadl1xu
	MwJ6pHtd7xmpsYBxpOkvWydkVeLibEZwId3ZbQmXJ4=
X-Received: by 2002:a05:6402:a0cf:b0:6a6:32f9:d7d0 with SMTP id 4fb4d7f45d1cf-6a682af6405mr8221306a12.21.1788444030820;
        Thu, 03 Sep 2026 07:00:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a67f953223sm2277676a12.28.2026.09.03.07.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 07:00:29 -0700 (PDT)
Message-ID: <66283358-9b87-4485-a036-ba91e6d7fcad@gmail.com>
Date: Thu, 3 Sep 2026 15:00:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/2] checkout -m: refine autostash fallback
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
 <pull.2364.v4.git.git.1788373743.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2364.v4.git.git.1788373743.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 02/09/2026 19:29, Harald Nordgren via GitGitGadget wrote:
> Avoiding checkout -m autostash retries when no tracked local changes exist
> and visually separating autostash conflict advice from the subsequent
> branch-switch message. Addresses #leftoverbits from here:
> https://lore.kernel.org/git/cfd09dbf-8d77-4464-8030-3a0ffb4aeae7@gmail.com/
> 
> Changes in v4:
> 
>   * Conflicts now exit with status 1 like merge-tree, other failures exit 128
>     so exit 1 unambiguously means conflicts. Stash changes split into their
>     own commit.

Thanks for changing the exit codes, I don't have anything to add to 
Junio's comments.

Thanks

Phillip

>   * The autostash apply helpers use the return value (enum
>     stash_apply_result) instead of an out-parameter, and only claim conflicts
>     when git stash apply actually reported them.
> 
> Changes in v3:
> 
>   * Use enum for git stash return values, to separate conflict from generic
>     error.
> 
> Changes in v2:
> 
>   * Simplify logic and combine to one commit.
>   * Test full output with test_cmp.
> 
> Harald Nordgren (2):
>    stash: reserve exit status 1 for conflicts
>    checkout: separate autostash conflict advice from branch-switch
>      message
> 
>   Documentation/git-stash.adoc |  9 +++++
>   builtin/checkout.c           | 15 ++++----
>   builtin/stash.c              | 32 ++++++++++++-----
>   sequencer.c                  | 66 ++++++++++++++++++++++--------------
>   sequencer.h                  | 19 +++++++----
>   stash.h                      | 21 ++++++++++++
>   t/t3903-stash.sh             | 25 ++++++++++++--
>   t/t7201-co.sh                | 16 ++++++---
>   8 files changed, 149 insertions(+), 54 deletions(-)
>   create mode 100644 stash.h
> 
> 
> base-commit: 1630431f326e15fcde608827b5ff38422528eb59
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2364%2FHaraldNordgren%2Fhn%2Fgit-checkout-m-leftoverbits-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2364/HaraldNordgren/hn/git-checkout-m-leftoverbits-v4
> Pull-Request: https://github.com/git/git/pull/2364
> 
> Range-diff vs v3:
> 
>   1:  8e1979dd6c ! 1:  ff43221802 checkout: separate autostash conflict advice from branch-switch message
>       @@ Metadata
>        Author: Harald Nordgren <haraldnordgren@gmail.com>
>        
>         ## Commit message ##
>       -    checkout: separate autostash conflict advice from branch-switch message
>       +    stash: reserve exit status 1 for conflicts
>        
>       -    "git checkout -m" stashes the user's local changes when it cannot
>       -    perform the checkout, and then applies the stash.  When applying the
>       -    stash results in conflicts, the advice on how to deal with them is
>       -    printed directly on top of the branch-switch message ("Switched to
>       -    branch ..."), making the two hard to tell apart.  Print a blank line
>       -    in between so that the advice and the branch-switch message are
>       -    visually distinct.
>       +    "git stash apply", "pop" and "branch" exit with status 1 both when
>       +    applying the stash entry resulted in conflicts and when they fail for
>       +    other reasons, so callers cannot tell the two apart.
>        
>       -    To make this possible, "git stash apply", "pop" and "branch" now exit
>       -    with status 2 when applying the stash entry resulted in conflicts, in
>       -    which case the stash entry is left in place; other failures exit with
>       -    status 1, as before.  The exit statuses are documented in the "git
>       -    stash" documentation.
>       +    Follow the convention of "git merge-tree" and the merge strategies,
>       +    which exit with status 1 to indicate conflicts and with a different
>       +    non-zero status for errors: those subcommands now exit with status 1
>       +    only when applying the stash entry resulted in conflicts, in which
>       +    case the stash entry is left in place, and exit with status 128, the
>       +    status die() uses, when they fail for other reasons.  Document the
>       +    exit statuses.
>       +
>       +    cmd_stash() used to collapse the return values of the subcommand
>       +    implementations to a boolean.  It now maps negative values, which
>       +    signal a failure, to 128 and passes everything else through as-is.
>       +    The only implementations that return a positive value are "apply",
>       +    "pop" and "branch", which return the value of do_apply_stash():
>       +    "apply" returns it directly, and "pop" and "branch" drop the stash
>       +    entry, via do_drop_stash(), which always returns 0, only when the
>       +    application succeeded.  The positive value is always 1, as
>       +    do_apply_stash() only returns a positive value when the three-way
>       +    merge was unclean.
>       +
>       +    Make the convention explicit by introducing enum stash_apply_result
>       +    with the values STASH_APPLY_CLEAN, STASH_APPLY_CONFLICT and
>       +    STASH_APPLY_ERROR, and use it for the in-process autostash helpers,
>       +    too.  They spawn "git stash apply" and can now tell conflicts apart
>       +    from other failures, e.g. a crash or death by signal of the child,
>       +    which map to exit statuses above 1.  Since we know the stash entry
>       +    was saved, tell users so in the error message instead of leaving them
>       +    wondering what happened to their stashed changes.
>        
>            Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>        
>       @@ Documentation/git-stash.adoc: include::includes/cmd-config-section-all.adoc[]
>        +EXIT STATUS
>        +-----------
>        +
>       -+The `git stash` subcommands exit with status 0 on success and non-zero
>       -+on failure.  The subcommands that apply a stash entry, i.e. `apply`,
>       -+`pop` and `branch`, exit with status 2 when applying the stash entry
>       -+resulted in conflicts, in which case the stash entry is left in place.
>       -+Other failures exit with status 1 (usage errors exit with status 129).
>       ++The `git stash` subcommands exit with status 0 on success.  The
>       ++subcommands that apply a stash entry, i.e. `apply`, `pop` and `branch`,
>       ++exit with status 1 when applying the stash entry resulted in conflicts,
>       ++in which case the stash entry is left in place, and with a non-zero
>       ++status other than 1 when they fail for other reasons.
>        +
>         
>         SEE ALSO
>         --------
>        
>       - ## builtin/checkout.c ##
>       -@@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
>       - 	int flag, writeout_error = 0;
>       - 	int do_merge = 1;
>       - 	int created_autostash = 0;
>       -+	enum stash_apply_result autostash_res = STASH_APPLY_CLEAN;
>       - 	struct strbuf old_commit_shortname = STRBUF_INIT;
>       - 	struct strbuf autostash_msg = STRBUF_INIT;
>       - 	const char *stash_label_base = NULL;
>       -@@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
>       - 				git_config_push_parameter(cfg.buf);
>       - 				strbuf_release(&cfg);
>       - 			}
>       --			apply_autostash_ref(the_repository,
>       --					    "CHECKOUT_AUTOSTASH_HEAD",
>       --					    new_branch_info->name,
>       --					    "local",
>       --					    stash_label_base,
>       --					    autostash_msg.buf);
>       -+			autostash_res = apply_autostash_ref(the_repository,
>       -+				    "CHECKOUT_AUTOSTASH_HEAD",
>       -+				    new_branch_info->name,
>       -+				    "local",
>       -+				    stash_label_base,
>       -+				    autostash_msg.buf);
>       - 		}
>       - 		if (ret) {
>       - 			branch_info_release(&old_branch_info);
>       -@@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
>       - 	if (!opts->quiet && !old_branch_info.path && old_branch_info.commit && new_branch_info->commit != old_branch_info.commit)
>       - 		orphaned_commit_warning(old_branch_info.commit, new_branch_info->commit);
>       -
>       -+	if (autostash_res == STASH_APPLY_CONFLICT && !opts->quiet)
>       -+		fputc('\n', stderr);
>       - 	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
>       -
>       - 	if (created_autostash) {
>       -
>         ## builtin/stash.c ##
>        @@
>         #include "object-name.h"
>       @@ builtin/stash.c: static void unstage_changes_unless_new(struct object_id *orig_t
>         
>        -static int do_apply_stash(const char *prefix, struct stash_info *info,
>        -			  int index, int quiet,
>       +-			  const char *label_ours, const char *label_theirs,
>       +-			  const char *label_base)
>        +static enum stash_apply_result do_apply_stash(const char *prefix,
>        +					      struct stash_info *info,
>        +					      int index, int quiet,
>       - 			  const char *label_ours, const char *label_theirs,
>       - 			  const char *label_base)
>       ++					      const char *label_ours,
>       ++					      const char *label_theirs,
>       ++					      const char *label_base)
>         {
>       + 	int clean, ret;
>       + 	int has_index = index;
>        @@ builtin/stash.c: static int do_apply_stash(const char *prefix, struct stash_info *info,
>       - 	clean = merge_ort_nonrecursive(&o, head, merge, merge_base);
>         
>         	/*
>       --	 * If 'clean' >= 0, reverse the value for 'ret' so 'ret' is 0 when the
>       + 	 * If 'clean' >= 0, reverse the value for 'ret' so 'ret' is 0 when the
>        -	 * merge was clean, and nonzero if the merge was unclean or encountered
>        -	 * an error.
>       -+	 * Translate the value of 'clean' so 'ret' is STASH_APPLY_CLEAN
>       -+	 * when the merge was clean, STASH_APPLY_CONFLICT when it was
>       -+	 * unclean, and a negative value if it encountered an error.
>       ++	 * merge was clean, and 1 if the merge was unclean or a negative value
>       ++	 * if it encountered an error.
>         	 */
>       --	ret = clean >= 0 ? !clean : clean;
>       -+	ret = clean >= 0 ? (clean ? STASH_APPLY_CLEAN : STASH_APPLY_CONFLICT)
>       -+			 : clean;
>       + 	ret = clean >= 0 ? !clean : clean;
>         
>       - 	if (ret < 0)
>       - 		rollback_lock_file(&lock);
>       -@@ builtin/stash.c: static int do_apply_stash(const char *prefix, struct stash_info *info,
>       -
>       - 	if (has_index) {
>       - 		if (reset_tree(&index_tree, 0, 0))
>       --			ret = -1;
>       -+			ret = STASH_APPLY_ERROR;
>       - 	} else {
>       - 		unstage_changes_unless_new(&c_tree);
>       - 	}
>        @@ builtin/stash.c: int cmd_stash(int argc,
>         	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
>         		    (uintmax_t)pid);
>       @@ builtin/stash.c: int cmd_stash(int argc,
>        +	if (fn) {
>        +		ret = fn(argc, argv, prefix, repo);
>        +
>       ++		/*
>       ++		 * The subcommand implementations return 0 on success, a
>       ++		 * negative value on failure, and STASH_APPLY_CONFLICT
>       ++		 * when applying a stash entry resulted in conflicts.
>       ++		 * Map failures to 128, the status die() uses, so that
>       ++		 * exit status 1 unambiguously indicates conflicts.
>       ++		 */
>        +		if (ret < 0)
>       -+			return 1;
>       ++			return 128;
>        +		return ret;
>        +	} else if (!argc)
>         		return !!push_stash_unassumed(0, NULL, prefix, repo);
>       @@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int atte
>         			strvec_pushf(&child.args, "--label-base=%s", label_base);
>         		strvec_push(&child.args, stash_oid);
>         		ret = run_command(&child);
>       -+		if (ret && ret != STASH_APPLY_CONFLICT)
>       ++		if (ret > 1)
>        +			ret = STASH_APPLY_ERROR;
>         	}
>         
>       @@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int atte
>         				  "do not want to resolve them now, run \"git reset --hard\" and\n"
>         				  "apply the local changes later by running \"git stash pop\".\n"));
>        +		else if (attempt_apply)
>       -+			ret = error(_("could not apply autostash"));
>       ++			ret = error(_("could not apply autostash; "
>       ++				      "your changes are safe in the stash"));
>         		else
>         			fprintf(stderr,
>         				_("Autostash exists; creating a new stash entry.\n"
>       @@ stash.h (new)
>        +	 * The stash could not be applied because it resulted in
>        +	 * conflicts.  The stash entry is left in place.  The "git stash
>        +	 * apply", "pop" and "branch" subcommands exit with this status
>       -+	 * in this case.
>       ++	 * in this case, mirroring the convention of "git merge-tree" and
>       ++	 * the merge strategies.
>        +	 */
>       -+	STASH_APPLY_CONFLICT = 2,
>       ++	STASH_APPLY_CONFLICT = 1,
>        +
>        +	/* Something went wrong. */
>        +	STASH_APPLY_ERROR = -1,
>       @@ stash.h (new)
>        +#endif /* STASH_H */
>        
>         ## t/t3903-stash.sh ##
>       -@@ t/t3903-stash.sh: test_expect_success 'apply with custom conflict labels' '
>       +@@ t/t3903-stash.sh: test_expect_success 'stash.index=false overridden by --index' '
>       + 	test_cmp expect file
>       + '
>       +
>       +-test_expect_success 'apply with custom conflict labels' '
>       ++test_expect_success 'apply exits 1 on conflicts' '
>       + 	git reset --hard initial &&
>       + 	test_commit label-base conflict-file base-content &&
>         	echo stashed >conflict-file &&
>         	git stash push -m "stashed" &&
>         	test_commit label-upstream conflict-file upstream-content &&
>        -	test_must_fail git -c merge.conflictStyle=diff3 stash apply --label-ours=UP --label-theirs=STASH &&
>       -+	test_expect_code 2 git -c merge.conflictStyle=diff3 stash apply --label-ours=UP --label-theirs=STASH &&
>       ++	test_expect_code 1 git -c merge.conflictStyle=diff3 stash apply --label-ours=UP --label-theirs=STASH &&
>         	test_grep "^<<<<<<< UP" conflict-file &&
>         	test_grep "^||||||| Stash base" conflict-file &&
>         	test_grep "^>>>>>>> STASH" conflict-file
>       @@ t/t3903-stash.sh: test_expect_success 'apply with empty conflict labels' '
>         	git stash push -m "stashed" &&
>         	test_commit empty-label-upstream conflict-file upstream-content &&
>        -	test_must_fail git stash apply --label-ours= --label-theirs= &&
>       -+	test_expect_code 2 git stash apply --label-ours= --label-theirs= &&
>       ++	test_expect_code 1 git stash apply --label-ours= --label-theirs= &&
>         	test_grep "^<<<<<<<$" conflict-file &&
>         	test_grep "^>>>>>>>$" conflict-file
>         '
>         
>       -+test_expect_success 'apply exits 2 on conflicts and keeps the stash entry' '
>       ++test_expect_success 'pop exits 1 on conflicts and keeps the stash entry' '
>        +	git reset --hard initial &&
>       -+	test_commit exit-code-base conflict-file base-content &&
>       -+	echo stashed >conflict-file &&
>       -+	git stash push -m stashed &&
>       -+	test_commit exit-code-upstream conflict-file upstream-content &&
>       -+	test_expect_code 2 git stash apply &&
>       ++	echo stashed >file &&
>       ++	git stash push -m pop-stashed &&
>       ++	test_commit pop-upstream file upstream-content &&
>       ++	test_expect_code 1 git stash pop &&
>        +	git stash list >list &&
>       -+	test_grep stashed list
>       ++	test_grep pop-stashed list
>        +'
>        +
>       -+test_expect_success 'pop exits 2 on conflicts and keeps the stash entry' '
>       ++test_expect_success 'stash branch exits with a non-1 status on errors' '
>        +	git reset --hard initial &&
>       -+	test_commit pop-exit-code-base pop-file base-content &&
>       -+	echo stashed >pop-file &&
>       -+	git stash push -m pop-stashed &&
>       -+	test_commit pop-exit-code-upstream pop-file upstream-content &&
>       -+	test_expect_code 2 git stash pop &&
>       ++	echo stashed >file &&
>       ++	git stash push -m branch-stashed &&
>       ++	test_expect_code 128 git stash branch conflicting-branch refs/heads/does-not-exist &&
>        +	git stash list >list &&
>       -+	test_grep pop-stashed list
>       ++	test_grep branch-stashed list
>        +'
>        +
>         test_expect_success 'stash show --include-untracked includes untracked files' '
>         	git reset --hard &&
>         
>       -
>       - ## t/t7201-co.sh ##
>       -@@ t/t7201-co.sh: test_expect_success 'checkout -m creates a recoverable stash on conflict' '
>       - 	test_must_fail git checkout side 2>stderr &&
>       - 	test_grep "Your local changes" stderr &&
>       - 	git checkout -m side >actual 2>&1 &&
>       --	test_grep "resulted in conflicts" actual &&
>       --	test_grep "git stash drop" actual &&
>       --	test_grep "git stash pop" actual &&
>       --	test_grep "The following paths have local changes" actual &&
>       -+	cat >expect <<-EOF &&
>       -+	Your local changes are stashed, however applying them
>       -+	resulted in conflicts.  You can either resolve the conflicts
>       -+	and then discard the stash with "git stash drop", or, if you
>       -+	do not want to resolve them now, run "git reset --hard" and
>       -+	apply the local changes later by running "git stash pop".
>       -+
>       -+	Switched to branch ${SQ}side${SQ}
>       -+	The following paths have local changes:
>       -+	M	one
>       -+	EOF
>       -+	test_cmp expect actual &&
>       - 	git log -p -1 --format="%gs%n%B" -g --diff-merges=1 refs/stash >actual &&
>       - 	sed /^index/d actual >actual.trimmed &&
>       - 	cat >expect <<-EOF &&
>   -:  ---------- > 2:  935fa0a9ae checkout: separate autostash conflict advice from branch-switch message
> 

