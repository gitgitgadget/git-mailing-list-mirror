Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2426405C41
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781097055; cv=none; b=P4tcvGM8V+FXIvhogtuME/a+JjwX4l60ymshygpIjbNg4Mvtvdngikaj7nUwJPP2IdlBG/dADh6zQZHn0/zJEKnYeikZMlrfhX4BBHdS0q0ocsPCcv7MXu97twgUs7B+Y6EsZb38CNtAbahanFbUd2l2kGWhMn3GaYs8EosMpGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781097055; c=relaxed/simple;
	bh=60c68sbQSj4IV9tjxjCXLd2/LYQVoK9f+T/RTsvomI0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jSH1hBz1k01HhHd8GdfTR/SFD8o9LqgtdfUAgIwp9v9Fl0Lilp/SvMpW/RZLB483hqNaOy+Oog1W+7Hhaa7MJlj2lIWCUH6UGK8xp2mdR7GQ4RNjKws+c3y6sKj2k44T+G5LULyW5wO63toniRi848JxNZDx5eGJM1xrwGSKrao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5cpJ9V8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5cpJ9V8"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b613a17bso66213155e9.3
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 06:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781097052; x=1781701852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nUoY4XvGoXm//RO10qEtFALbuhGgTgdV0vkBuDXFeFw=;
        b=h5cpJ9V8yB9aUd/yAEfpq7Vqqn0kH7I94rdFmL9GRw3cE118cFZq44zzGWHluJCbWc
         Y9W80f1UkwR1V45clspjs2YRstH735RfwQG7qUuixs5Fi7JuEi7IAjy9+yD8uMeU4mC/
         F27a/hCP3pI2qFONoBMSPjw8GeANtrDRxGWxJh2InRdOECbey15SvCgX7njeBvGHBpun
         1Uex6pGuMl3Ee+cI57RX3Y8IX9DSMyIT5WyQO3ygOzAuUspaCGCeHWi8cTMKm+3Zi+3k
         cCoVmrPNQqPs5cqUwo9Uv4casib/sh1+UJawzBXqt5pJZ5Huk/WQS207pXAqtM1v1m94
         Z4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781097052; x=1781701852;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUoY4XvGoXm//RO10qEtFALbuhGgTgdV0vkBuDXFeFw=;
        b=imR9qLnQotarwSMIj+V0qgYLrR6xYA5LXOg9RXQ+qbD+YvGZRZ2wiXkrMHpNRhshLr
         1ERAXBLosF/nuq8MKRmzrFJcMW4dJiMRlqVhU4eQGRrfaAK7+tHO5FlAEo+Q9Mv0sSqH
         0kppa7miBgydzcAUY1dRd4IB0UgClVKwt5HFxZU69PY7qN/wCNYRbEezNLeinXXPg73U
         QLi8jZ+zubUH7L3SjJaqCXM6WoSUuxbz3F6MvaCMRjGZHiO+UHriUR6xhhQnNS111Qqx
         wAFMukE6E2t6XltO3GKZDi2Txoau6rlarU4oJ/vtV4VVoXdUQTlZE/zqqI3ZtHLC9Sye
         0+LA==
X-Forwarded-Encrypted: i=1; AFNElJ+wbhHQvGnDP0NQn/HjfvsXQ+ggB31HPqSjlhqQOaRWsdZWtTeBSZksIuh+83niLpNVkKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5W4Ck8hO9EBs+kWRkF3FeyHjQY2xV3aZ1+V3SwJt2dh0NT6d6
	Ab/K7S8jy/pulFGVXgdp/hz7fafMCnSLtwn1Zoclr8JZKYLxR/xHM+KX
X-Gm-Gg: Acq92OFnkuC4SaemK4SEkJGzZLuMeKz+A/ZluUIQ0MDTtgRF+vq80pK223odCgJe2bc
	LP6GFdSYmkh+Ygjdl9P+p7lPbv3QhekBJ9V7H5Vt9F7uzZdRiCzANla+I/cVAqtEB5lU5sbSXLu
	cEMaSYVIo24qF+jMPnERfvpFOwk3PhwwluMNRjD3YKVWKJ2bHle9I7ijQpQEXW+RXdUvdm6Fq4x
	U9PZ/4O5geb6dmZoFXvrevcMXWl3/oiOXqi48HUJnpdjcbCkBYZaUxJSEZAgBQsASkLDRKIKCY5
	zPScLoaut+fJQR/eni4z2SWpvit9BNF222Up37gr9Td/ux+HwBQ1mNxWdnewrD6lx4ggS02IuMM
	Sxh+xueYfK/AtqRYu+p8Es0MTzRo1be1x1pGs9kXZ4VUYhh9zEVhFR6uP/jkEHZP0K/JWTJ4Rl3
	Xud+DCVvMgqPN/POGNkgLSA2rWg34SFNw2TpTp+VXqRDsVrMrubj026QTvKf5eEEEBo7htYk/Px
	pUf+v+nbuXK6lib
X-Received: by 2002:a05:600c:4eca:b0:490:be8e:c890 with SMTP id 5b1f17b1804b1-490d720425emr93736085e9.13.1781097052050;
        Wed, 10 Jun 2026 06:10:52 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b59f0sm643277145e9.2.2026.06.10.06.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 06:10:51 -0700 (PDT)
Message-ID: <b2c7a210-f6c3-40f4-9c42-e81c7e316bc9@gmail.com>
Date: Wed, 10 Jun 2026 14:10:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 03/10] reset: rename `reset_head()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>,
 Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
 <20260610-b4-pks-history-drop-v4-3-70d5f0ae8c25@pks.im>
Content-Language: en-US
In-Reply-To: <20260610-b4-pks-history-drop-v4-3-70d5f0ae8c25@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 10/06/2026 09:52, Patrick Steinhardt wrote:
> In a subsequent commit we're about to adapt `reset_head()` so that the
> reference update to HEAD is optional, only. At this point the function
> starts to feel misnamed, as it doesn't necessarily have anything to do
> with the HEAD reference anymore. The gist of the function then is that
> we reset the working tree to a specific new commit, updating both the
> index and the checked-out files.
> 
> Rename it to `reset_working_tree()` to better reflect that.

That sounds good. Because we defer renaming the flags this patch is very 
straight forward.

Thanks

Phillip

> Note that we don't adjust the flags yet. This will happen in a
> subsequent commit.
> 
> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> ---
>   builtin/rebase.c | 20 ++++++++++----------
>   reset.c          |  5 +++--
>   reset.h          |  4 ++--
>   sequencer.c      |  8 ++++----
>   4 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index fa4f5d9306..22fbba3c62 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -592,7 +592,7 @@ static int finish_rebase(struct rebase_options *opts)
>   static int move_to_original_branch(struct rebase_options *opts)
>   {
>   	struct strbuf branch_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
> -	struct reset_head_opts ropts = { 0 };
> +	struct reset_working_tree_options ropts = { 0 };
>   	int ret;
>   
>   	if (!opts->head_name)
> @@ -610,7 +610,7 @@ static int move_to_original_branch(struct rebase_options *opts)
>   	ropts.flags = RESET_HEAD_REFS_ONLY;
>   	ropts.branch_msg = branch_reflog.buf;
>   	ropts.head_msg = head_reflog.buf;
> -	ret = reset_head(the_repository, &ropts);
> +	ret = reset_working_tree(the_repository, &ropts);
>   
>   	strbuf_release(&branch_reflog);
>   	strbuf_release(&head_reflog);
> @@ -685,7 +685,7 @@ static int run_am(struct rebase_options *opts)
>   
>   	status = run_command(&format_patch);
>   	if (status) {
> -		struct reset_head_opts ropts = { 0 };
> +		struct reset_working_tree_options ropts = { 0 };
>   		unlink(rebased_patches);
>   		free(rebased_patches);
>   		child_process_clear(&am);
> @@ -693,7 +693,7 @@ static int run_am(struct rebase_options *opts)
>   		ropts.oid = &opts->orig_head->object.oid;
>   		ropts.branch = opts->head_name;
>   		ropts.default_reflog_action = opts->reflog_action;
> -		reset_head(the_repository, &ropts);
> +		reset_working_tree(the_repository, &ropts);
>   		error(_("\ngit encountered an error while preparing the "
>   			"patches to replay\n"
>   			"these revisions:\n"
> @@ -855,7 +855,7 @@ static int rebase_config(const char *var, const char *value,
>   static int checkout_up_to_date(struct rebase_options *options)
>   {
>   	struct strbuf buf = STRBUF_INIT;
> -	struct reset_head_opts ropts = { 0 };
> +	struct reset_working_tree_options ropts = { 0 };
>   	int ret = 0;
>   
>   	strbuf_addf(&buf, "%s: checkout %s",
> @@ -866,7 +866,7 @@ static int checkout_up_to_date(struct rebase_options *options)
>   	if (!ropts.branch)
>   		ropts.flags |=  RESET_HEAD_DETACH;
>   	ropts.head_msg = buf.buf;
> -	if (reset_head(the_repository, &ropts) < 0)
> +	if (reset_working_tree(the_repository, &ropts) < 0)
>   		ret = error(_("could not switch to %s"), options->switch_to);
>   	strbuf_release(&buf);
>   
> @@ -1116,7 +1116,7 @@ int cmd_rebase(int argc,
>   	int reschedule_failed_exec = -1;
>   	int allow_preemptive_ff = 1;
>   	int preserve_merges_selected = 0;
> -	struct reset_head_opts ropts = { 0 };
> +	struct reset_working_tree_options ropts = { 0 };
>   	struct option builtin_rebase_options[] = {
>   		OPT_STRING(0, "onto", &options.onto_name,
>   			   N_("revision"),
> @@ -1385,7 +1385,7 @@ int cmd_rebase(int argc,
>   		rerere_clear(the_repository, &merge_rr);
>   		string_list_clear(&merge_rr, 1);
>   		ropts.flags = RESET_HEAD_HARD;
> -		if (reset_head(the_repository, &ropts) < 0)
> +		if (reset_working_tree(the_repository, &ropts) < 0)
>   			die(_("could not discard worktree changes"));
>   		remove_branch_state(the_repository, 0);
>   		if (read_basic_state(&options))
> @@ -1410,7 +1410,7 @@ int cmd_rebase(int argc,
>   		ropts.head_msg = head_msg.buf;
>   		ropts.branch = options.head_name;
>   		ropts.flags = RESET_HEAD_HARD;
> -		if (reset_head(the_repository, &ropts) < 0)
> +		if (reset_working_tree(the_repository, &ropts) < 0)
>   			die(_("could not move back to %s"),
>   			    oid_to_hex(&options.orig_head->object.oid));
>   		strbuf_release(&head_msg);
> @@ -1880,7 +1880,7 @@ int cmd_rebase(int argc,
>   			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
>   	ropts.head_msg = msg.buf;
>   	ropts.default_reflog_action = options.reflog_action;
> -	if (reset_head(the_repository, &ropts)) {
> +	if (reset_working_tree(the_repository, &ropts)) {
>   		ret = error(_("Could not detach HEAD"));
>   		goto cleanup_autostash;
>   	}
> diff --git a/reset.c b/reset.c
> index 3b3cb74dab..799596398b 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -12,7 +12,7 @@
>   #include "hook.h"
>   
>   static int update_refs(struct repository *repo,
> -		       const struct reset_head_opts *opts,
> +		       const struct reset_working_tree_options *opts,
>   		       const struct object_id *oid,
>   		       const struct object_id *head)
>   {
> @@ -85,7 +85,8 @@ static int update_refs(struct repository *repo,
>   	return ret;
>   }
>   
> -int reset_head(struct repository *r, const struct reset_head_opts *opts)
> +int reset_working_tree(struct repository *r,
> +		       const struct reset_working_tree_options *opts)
>   {
>   	const struct object_id *oid = opts->oid;
>   	const char *switch_to_branch = opts->branch;
> diff --git a/reset.h b/reset.h
> index a28f81829d..f130152014 100644
> --- a/reset.h
> +++ b/reset.h
> @@ -17,7 +17,7 @@
>   /* Update ORIG_HEAD as well as HEAD */
>   #define RESET_ORIG_HEAD (1<<4)
>   
> -struct reset_head_opts {
> +struct reset_working_tree_options {
>   	/*
>   	 * The commit to checkout/reset to. Defaults to HEAD.
>   	 */
> @@ -55,6 +55,6 @@ struct reset_head_opts {
>   	const char *default_reflog_action;
>   };
>   
> -int reset_head(struct repository *r, const struct reset_head_opts *opts);
> +int reset_working_tree(struct repository *r, const struct reset_working_tree_options *opts);
>   
>   #endif
> diff --git a/sequencer.c b/sequencer.c
> index 1ee4b2875b..d73ecf0384 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4677,7 +4677,7 @@ static void create_autostash_internal(struct repository *r,
>   	if (has_unstaged_changes(r, 1) ||
>   	    has_uncommitted_changes(r, 1)) {
>   		struct child_process stash = CHILD_PROCESS_INIT;
> -		struct reset_head_opts ropts = { .flags = RESET_HEAD_HARD };
> +		struct reset_working_tree_options ropts = { .flags = RESET_HEAD_HARD };
>   		struct object_id oid;
>   
>   		strvec_pushl(&stash.args,
> @@ -4707,7 +4707,7 @@ static void create_autostash_internal(struct repository *r,
>   
>   		if (!silent)
>   			printf(_("Created autostash: %s\n"), buf.buf);
> -		if (reset_head(r, &ropts) < 0)
> +		if (reset_working_tree(r, &ropts) < 0)
>   			die(_("could not reset --hard"));
>   		discard_index(r->index);
>   		if (repo_read_index(r) < 0)
> @@ -4867,7 +4867,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
>   			 const char *onto_name, const struct object_id *onto,
>   			 const struct object_id *orig_head)
>   {
> -	struct reset_head_opts ropts = {
> +	struct reset_working_tree_options ropts = {
>   		.oid = onto,
>   		.orig_head = orig_head,
>   		.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
> @@ -4876,7 +4876,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
>   					   onto_name),
>   		.default_reflog_action = sequencer_reflog_action(opts)
>   	};
> -	if (reset_head(r, &ropts)) {
> +	if (reset_working_tree(r, &ropts)) {
>   		apply_autostash(rebase_path_autostash());
>   		sequencer_remove_state(opts);
>   		return error(_("could not detach HEAD"));
> 

