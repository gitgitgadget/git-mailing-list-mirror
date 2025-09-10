Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA7D26FA77
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513045; cv=none; b=RRv1vu9TlqfC1KDL0tW3Ogb5SH7iEd/OvX7TETwmCrzDBeRP7zWaiUWGQMlHHHKkYP9WoYyB+yzp+LPRA15Sk14Tdopad41C01LJrS60PWUeUz8t+kDdmlJXcUev5Ap9aSkShNJhUy/QS8Zn2lVX9SUC++PGWaMjHM55HAzAjfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513045; c=relaxed/simple;
	bh=XjNNIeOEts+8JAj787YIrLZ+UvH8U3a/+Mj0frTIxB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePHmpQxEm7W45JBtNfKJYyLPokosKJdBuoyvTxbZR3Avq54xunaawCE/F0CuD64Apq9isvMCmpfRRi9BsXhvkRMHnD4scDBi4XRsSpf8VvI0dne05bseyHeDd7u8bYOeY5SQI9QG6c3qStCIDP05yVukcifarDCDK4a5t5f7ndI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JigLKrfy; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JigLKrfy"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so4430525f8f.3
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757513042; x=1758117842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UdDZIKalgFh1jJcbrREtokPfL1HNK56YS9E2nbXfwMw=;
        b=JigLKrfyRzdt3605FMAAfu8MHXksHgKMJkdSBr1AokGW3EfZ30YTvnSjs2TJm8dFrg
         LNKiSnNJBFVSQn4TTnT2iFizfm9iEmfo4at8Tnq9dS9ZS2cbv5YuC9l8KM+/XKJe1JHj
         GEJBjeIKe0M3ow9KXoVi79A25ONSM+BA6XKGk/sAt99MCWElcYFb/cZ5n0Yp5bYKtLUt
         Up4xsk5ENVVjcRzG+4LszgUhxkcCGCMl4z+QkpdVkcjvJMMAenRQxUk8eed0WzNsl1r8
         BHGfccijhF1z4vno3XF5Vk9UdGasmnFTGVgcfC6wMb5SuDui9UeAOr+Jez+6qh+luXxO
         NUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513042; x=1758117842;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdDZIKalgFh1jJcbrREtokPfL1HNK56YS9E2nbXfwMw=;
        b=tM/MvJReSirXf25M4pAejqWq0PJhhiymKZifgSDF/zXwKkpYKOA5gemCdLzEKvFxRA
         raQa4hCPzopkE+DknN9JpYiJDHYBdA+gV0NZqmg5jZMQqwppx3ypILM3HasEX8ayRDxj
         eb/q/ZJ/03Z7v/Hp0so5tqL6EEP5u3VElZTtH7HKO0G7kIZSdzntR5FW+bJbc7RtZfkf
         TxnVh5JTkxfTg8vIgHWPnfiTNzi2QwGOT1TtaCT1TQM+S+F8DnLzwdNT8brd2BgIWprX
         KzhUKuJBZsOqjqF4F2OLgoXrdQ8zgraUpFtbX/xFX349Ff4Dy3pRQxGb+dHwGWXkOgHA
         EXaA==
X-Forwarded-Encrypted: i=1; AJvYcCVosazj8DerDFNA1DxEX3zx+0D70LfsP4Q7FBxlF/fp+h/5ohuJVSO4qx8eZKuf6zLhKCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRDiv/UNKmvR3NH8pYetW4lrUHDZYv3Mn2G/GyG1vpjCzG9cuY
	nED0sJIDwMPrSGC1Dnf0rrfglHWgDrFZbZBZMrNzFQHpTswVK3LHdUiz
X-Gm-Gg: ASbGncvy0Kt/x2rd3ZZREbwtKf32AuH9VX3d93ZBP5nSfNCR1FpLuZJqFQROiwHXr05
	Q38MaNLArkS+A1LahMumGSPU57qWyxOZlX405qKnRkA3a9mv83W1IYLCJuEjSJDPZK8EwqpRaHN
	VdPRUB1DsNaBtf1Jgp9H7JJzec++fW7mQET2yAlck9LmFGCGqL6wsw8Abye4HHXiSuIF5ROIeA+
	CbBuEdD+DFAImmPXKW+JXuuRaX/kiVcM+f7KVzaKtQ7opAXacRkJVZX7P74FhSzKJukvPv1tZ53
	2tW8zaN+T5NgpP/FdNoVaYNhQxLO6AbBwRK4XqxS1CNpd5gebwOayKNQPnyyyT5lXnO0wL9fL05
	fZuiBo+PlQ7BotmmLi5fxScy4I8UlOSXs6dZZVJSSVliEplYOrHM/fbOmYW0crWpgXTQniwuHu4
	UrVTXYrS+lxg==
X-Google-Smtp-Source: AGHT+IGRK0jH+qCRD+bCdng1OMkL2159JQagUEoEXg0NjXCWuSops8nqwQ9Wkhj0x0zY6cy3s1zGUQ==
X-Received: by 2002:a05:6000:22c2:b0:3c7:308e:4dff with SMTP id ffacd0b85a97d-3e643c1b67emr11810451f8f.57.1757513041472;
        Wed, 10 Sep 2025 07:04:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521ca20dsm7631167f8f.21.2025.09.10.07.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 07:04:01 -0700 (PDT)
Message-ID: <f74b9dfe-b05c-431e-8872-92e2bbb75b8c@gmail.com>
Date: Wed, 10 Sep 2025 15:04:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC v3 02/18] sequencer: add option to rewind HEAD after
 picking commits
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 Martin von Zweigbergk <martinvonz@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
 <20250904-b4-pks-history-builtin-v3-2-509053514755@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250904-b4-pks-history-builtin-v3-2-509053514755@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 04/09/2025 15:27, Patrick Steinhardt wrote:
> While the sequencer infrastructure knows to rewind "HEAD" to whatever it
> was pointing to before a rebase, it doesn't do the same for non-rebase
> operations like cherry-picks. This is because the expectation is that
> the user directly picks commits on top of whatever "HEAD" points to, and
> we advance the reference pointed to by "HEAD" instead of updating it
> directly.
> 
> We're about to introduce a new command though that needs to detach
> "HEAD" while being more similar to git-cherry-pick(1) rathen than to
> git-rebase(1). As such, we'll want to restore "HEAD" to point to the
> branch that we started on while not using the more heavy-weight rebase
> machinery.
> 
> Introduce a new option `restore_head_target` to do so. Persist the
> option into the sequencer configuration so that it persists across
> different processes, e.g. when we need to stop due to a merge conflict.

As with the last patch, can we use this new option in "git rebase"? The 
sequencer is already a nest of conditionals, it would be nice to 
minimize the number of new ones.

Thanks

Phillip

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   sequencer.c | 27 ++++++++++++++++++++++++++-
>   sequencer.h |  3 +++
>   2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 7066cdc939..bff181df76 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -413,6 +413,7 @@ void replay_opts_release(struct replay_opts *opts)
>   	struct replay_ctx *ctx = opts->ctx;
>   
>   	free(opts->gpg_sign);
> +	free(opts->restore_head_target);
>   	free(opts->reflog_action);
>   	free(opts->default_strategy);
>   	free(opts->strategy);
> @@ -3142,6 +3143,8 @@ static int populate_opts_cb(const char *key, const char *value,
>   	} else if (!strcmp(key, "options.skip-commit-summary")) {
>   		opts->skip_commit_summary =
>   			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
> +	} else if (!strcmp(key, "options.restore-head-target")) {
> +		git_config_string_dup(&opts->restore_head_target, key, value);
>   	} else {
>   		return error(_("invalid key: %s"), key);
>   	}
> @@ -3709,6 +3712,10 @@ static int save_opts(struct replay_opts *opts)
>   	if (opts->skip_commit_summary)
>   		res |= repo_config_set_in_file_gently(the_repository, opts_file,
>   					"options.skip-commit-summary", NULL, "true");
> +	if (opts->restore_head_target)
> +		res |= repo_config_set_in_file_gently(the_repository, opts_file,
> +				"options.restore-head-target", NULL, opts->restore_head_target);
> +
>   	return res;
>   }
>   
> @@ -5177,6 +5184,23 @@ static int pick_commits(struct repository *r,
>   			return -1;
>   	}
>   
> +	if (opts->restore_head_target) {
> +		struct reset_head_opts reset_opts = { 0 };
> +		const char *msg;
> +
> +		msg = reflog_message(opts, "finish", "returning to %s", opts->restore_head_target);
> +
> +		reset_opts.branch = opts->restore_head_target;
> +		reset_opts.flags = RESET_HEAD_REFS_ONLY;
> +		reset_opts.branch_msg = msg;
> +		reset_opts.head_msg = msg;
> +
> +		if (reset_head(r, &reset_opts)) {
> +			error(_("could not switch HEAD back to %s"), opts->restore_head_target);
> +			return -1;
> +		}
> +	}
> +
>   	/*
>   	 * Sequence of picks finished successfully; cleanup by
>   	 * removing the .git/sequencer directory
> @@ -5533,7 +5557,8 @@ int sequencer_pick_revisions(struct repository *r,
>   	if (opts->revs->cmdline.nr == 1 &&
>   	    opts->revs->cmdline.rev->whence == REV_CMD_REV &&
>   	    opts->revs->no_walk &&
> -	    !opts->revs->cmdline.rev->flags) {
> +	    !opts->revs->cmdline.rev->flags &&
> +	    !opts->restore_head_target) {
>   		struct commit *cmit;
>   
>   		if (prepare_revision_walk(opts->revs)) {
> diff --git a/sequencer.h b/sequencer.h
> index 1767fd737e..a905f6afc7 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -72,6 +72,9 @@ struct replay_opts {
>   	/* Reflog */
>   	char *reflog_action;
>   
> +	/* Reference to which HEAD shall be reset to after the operation. */
> +	char *restore_head_target;
> +
>   	/* placeholder commit for -i --root */
>   	struct object_id squash_onto;
>   	int have_squash_onto;
> 

