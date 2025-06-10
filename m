Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A1625D8F5
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749550316; cv=none; b=IzWOW1tvd2FoaVP6ndrDFmcnb4R7NDZWuw817X6vidx+sCGSREoIQuJVP5rbhEexQebiT5ySFNt6HdSQ5zNXXjBeaoSe606HZ2S9BRT2U/N86XmSo5Mrtipb2rLU/jfi9xyg3ewCueThzlxnGg+04nlQ0wGYUf7nUpBbknPMJtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749550316; c=relaxed/simple;
	bh=rNzk/Eji1sak7Q2RKTerVYhUwH6zp4g1oC/R73zpI0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=uq/ulVBxy9QZUxv7yrET4nV4OhThWh2y+rVS+4TMf6sjd8lleMNCmf1gBSHUdlau7eP3HOMYLaVFkZ+NCNAJWwXgZFf+m/AaU1GrjYu28fElD7FLMcmgP+JAw8qyX5atuqLSK7FgBJLWzZ+HRxoydD4zwguKy3toyRQNgIIXO+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpK/rOCX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpK/rOCX"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-441ab63a415so54625875e9.3
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 03:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749550313; x=1750155113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lVXsZUTLgUZL4s5aLoD+MzVgqe8H1DQxtpskLJwWtcY=;
        b=CpK/rOCX+pVbHhvElvcM8RkbgviTDF9zGfrddqvYMFxwr7OEhn3DuBleXgmO/YL73N
         NZwlWx/hqEMXtCby7OLg2RXPocTDZmCXb/LgnMrfzpkFHCoc+sYgEwwlJ0olAed7fu0K
         +ThvWk+drt0/m5E7ttXw96M6MkRAGF+fIro/tS1vcey8mMKOEDUwMan3KUl7p7/B2hyo
         e/DcpnaNzCwyhCvXEgO2KrfibhGLfNnU65bBsKj5pagn7g7vOkiPqfy7YY/rRlH/rvsD
         kiOj2S92xT3bMmdOWz2/RO5w8rFiDjk21+LPA16gn4H9+rbPkxxaTvHUkry0ZzkqPfq4
         aM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749550313; x=1750155113;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVXsZUTLgUZL4s5aLoD+MzVgqe8H1DQxtpskLJwWtcY=;
        b=pmfeM88JqWBm1VUymNEp8xcGjyUAvXQfbY65EAThOErcIZjAEbHaEJIOHgYqy5Orz4
         C+F7Uvj3/4JLN5xWbJNBJq1i2e7VCTZUL6qsWE7JhnGSJYyXNmA8VvdLLyCRMW1gS3rW
         F89NrEQ4fNn7ruYo3djwf0PYeWqo5z6QPTV9X0BKrtj8vAuqtroPZ5vHYberbFlD+ukz
         gfXXzDPx/VvnHGMUFwEEVqq7NAJUE3yB9pgd7ZtkGqALZFRPZoNPUPvG5TP39BcHrOmS
         uxUEhlB0JSygiiJg1FhQh0QNa5k7+A8qNP69pwYuo0WnOzltsg5RDjSmNHEIKU2UkT71
         PTWw==
X-Forwarded-Encrypted: i=1; AJvYcCVS4vGzhUOHzRYvqVSoZKR4X3+KVXyzAHpm5W3LavD+OQ8Gr78iXdEn6xwUyZ5HaXcR4LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIDI/L7cU/Mt9Y/aGRAxU/+eaxRVTzxDVY5US0W4iRZTHWbwfB
	uWRt3oa1VK1WrthrZBrj6VgYapMmJa7lzlFtemYQnIvGHSHljBN0JVVI
X-Gm-Gg: ASbGncsEARXjNvgeH6n2Vbg+p/HwTI6NFDVehRcqOSGueMVCSJKzh437XRixaHigbYD
	8ff2YGsWaTUkjX5Fgcj2sdSj7rjP5P1uPjqBMGqxthDbLVj9SjnAkQ/9SGP+nly/nfhSv3zRHF0
	TkyK8K8oE7MnS7OI4SRk2fdlqs89r4F5Oolx9gqAtF1ZwDZGQ5VOIeq018LcArtMG6BGZOCXM5z
	S0/ZxG8R2im0HGc+hYapfDrvP0x+9ZuibabY78UIRF1fsyGgl8j2oFJSXp04CxcIFuI3fEiSXl9
	yHr9xtdXRi1NHTyAOAd9aKEFpTyGkRSJLhl3slBwNhQTPt0YE3l6KSuynBKlJX1sDeKR2hXzfpI
	dh/wVDO1u4lKc97mi1z2P4uJor/DU9bmm6NPVCzYI8vSl
X-Google-Smtp-Source: AGHT+IGw7S9cnhhB/fGRodgZ78UO34c9phuFPnNQn6cC+bHG0aG2WqTU8jqi4bbgiHpzDpLkn21dsQ==
X-Received: by 2002:a05:600c:4e16:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-4531dead583mr15714515e9.32.1749550312661;
        Tue, 10 Jun 2025 03:11:52 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:efb:6e00:24f3:2d85? ([2a0a:ef40:700:a501:efb:6e00:24f3:2d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532468360sm11730543f8f.100.2025.06.10.03.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 03:11:52 -0700 (PDT)
Message-ID: <7e796844-97e2-4b45-a76e-4c1fcb1da3ae@gmail.com>
Date: Tue, 10 Jun 2025 11:13:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rebase: write script before initializing state
To: =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>, git@vger.kernel.org
References: <20250609221055.136074-1-oystwa@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
Cc: Junio C Hamano <gitster@pobox.com>
In-Reply-To: <20250609221055.136074-1-oystwa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Øystein

On 09/06/2025 23:10, Øystein Walle wrote:
> If rebase.instructionFormat is invalid the repository is left in a
> strange state when the interactive rebase fails. `git status` outputs
> boths the same as it would in the normal case *and* something related to
> interactive rebase:
> 
>      $ git -c rebase.instructionFormat=blah rebase -i
>      fatal: invalid --pretty format: blah
>      $ git status
>      On branch master
>      Your branch is ahead of 'upstream/master' by 1 commit.
>        (use "git push" to publish your local commits)
> 
>      git-rebase-todo is missing.
>      No commands done.
>      No commands remaining.
>      You are currently editing a commit while rebasing branch 'master' on '8db3019401'.
>        (use "git commit --amend" to amend the current commit)
>        (use "git rebase --continue" once you are satisfied with your changes)

Thanks for working on this.

> By attempting to write the rebase script before initializing the state
> this potential scenario is avoided.
> ---
> The diff looks perhaps more messy than required. The only required
> change is the filling in of make_script_args and the call to
> sequencer_make_script() above the call to init_basic_state(). But then
> the `if (ret)` looks out of place, and moving that up means adding `goto
> cleanup` which means the code that was previously the else case can be
> dedented.
> 
> get_commit_format() calls die() in this case, so cleaning up the
> sequencer state isn't an option. Maybe it shouldn't call die in the
> first place, but that looks to be much larger change.

I don't think that should be too difficult and it is the only way to fix 
this that ensures we restore the stashed changes when the commit format 
is invalid. The test added in this patch should be updated to check that 
the changes stashed with '--autostash' are restored when the commit 
format is invalid.

Looking at the callers of get_commit_format() there are three in 
revision.c:handle_revision_opt() only one of which can fail. That can be 
converted to

	if (get_commit_format(...))
		die(NULL);

I think we can do the same for the caller in 
builtin/log.c:cmd_log_init_defaults() and should be straight forward to 
update the example in Documentation/MyFirstObjectWalk.adoc in a similar 
way. The caller in sequencer.c:sequencer_make_script() should propagate 
the error.

Note that to use "die(NULL)" you need to base you patch on the branch 
'ps/maintenance-ref-lock' which is currently in next.

I'm about to go off the list for a couple of weeks but I'm sure someone 
else will be happy to answer any questions that you have.

Best Wishes

Phillip

> 
>   builtin/rebase.c             | 42 ++++++++++++++++++------------------
>   t/t3415-rebase-autosquash.sh | 10 +++++++++
>   2 files changed, 31 insertions(+), 21 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 2e8c4ee678..8139816417 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -293,15 +293,6 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>   				&revisions, &shortrevisions))
>   		goto cleanup;
>   
> -	if (init_basic_state(&replay,
> -			     opts->head_name ? opts->head_name : "detached HEAD",
> -			     opts->onto, &opts->orig_head->object.oid))
> -		goto cleanup;
> -
> -	if (!opts->upstream && opts->squash_onto)
> -		write_file(path_squash_onto(), "%s\n",
> -			   oid_to_hex(opts->squash_onto));
> -
>   	strvec_pushl(&make_script_args, "", revisions, NULL);
>   	if (opts->restrict_revision)
>   		strvec_pushf(&make_script_args, "^%s",
> @@ -310,21 +301,30 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>   	ret = sequencer_make_script(the_repository, &todo_list.buf,
>   				    make_script_args.nr, make_script_args.v,
>   				    flags);
> -
> -	if (ret)
> +	if (ret) {
>   		error(_("could not generate todo list"));
> -	else {
> -		discard_index(the_repository->index);
> -		if (todo_list_parse_insn_buffer(the_repository, &replay,
> -						todo_list.buf.buf, &todo_list))
> -			BUG("unusable todo list");
> -
> -		ret = complete_action(the_repository, &replay, flags,
> -			shortrevisions, opts->onto_name, opts->onto,
> -			&opts->orig_head->object.oid, &opts->exec,
> -			opts->autosquash, opts->update_refs, &todo_list);
> +		goto cleanup;
>   	}
>   
> +	if (init_basic_state(&replay,
> +			     opts->head_name ? opts->head_name : "detached HEAD",
> +			     opts->onto, &opts->orig_head->object.oid))
> +		goto cleanup;
> +
> +	if (!opts->upstream && opts->squash_onto)
> +		write_file(path_squash_onto(), "%s\n",
> +			   oid_to_hex(opts->squash_onto));
> +
> +	discard_index(the_repository->index);
> +	if (todo_list_parse_insn_buffer(the_repository, &replay,
> +					todo_list.buf.buf, &todo_list))
> +		BUG("unusable todo list");
> +
> +	ret = complete_action(the_repository, &replay, flags,
> +		shortrevisions, opts->onto_name, opts->onto,
> +		&opts->orig_head->object.oid, &opts->exec,
> +		opts->autosquash, opts->update_refs, &todo_list);
> +
>   cleanup:
>   	replay_opts_release(&replay);
>   	free(revisions);
> diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
> index 26b42a526a..5d093e3a7a 100755
> --- a/t/t3415-rebase-autosquash.sh
> +++ b/t/t3415-rebase-autosquash.sh
> @@ -394,6 +394,16 @@ test_expect_success 'autosquash with empty custom instructionFormat' '
>   	)
>   '
>   
> +test_expect_success 'autosquash with invalid custom instructionFormat' '
> +	git reset --hard base &&
> +	test_commit invalid-instructionFormat-test &&
> +	(
> +		test_must_fail git -c rebase.instructionFormat=blah \
> +			rebase --autosquash  --force-rebase -i HEAD^ &&
> +		test_path_is_missing .git/rebase-merge
> +	)
> +'
> +
>   set_backup_editor () {
>   	write_script backup-editor.sh <<-\EOF
>   	cp "$1" .git/backup-"$(basename "$1")"

