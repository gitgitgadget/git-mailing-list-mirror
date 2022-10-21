Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3F6C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 01:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJUBtz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 21:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJUBtx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 21:49:53 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C93652DC5
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 18:49:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id l22so2188492edj.5
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 18:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6DeQDDa4h/AuQ1AqY7Xe0BU7IdInA68SacvQ+81dUYs=;
        b=OXdx3TIA+/hsgkJsRBeR+xIKhUMQDJPtVh6NF9wB92i88nChUMsQDTwDSFG5fx9aGk
         7hF8UiZLGR7K8sgWeV3TAOPJBA47vLKSnDT6SwPfAA8OQ/9NUjw12bxkpH8kLsNaNDgH
         eGNCDBh2UPyvMegtJKSct1ggpyom3z2J38tNrtUVvFxOB2nTVpbedAB8OXM2ynVcd79o
         YT7otP5RBDiNcZE1VPbcoD/zNVWa4+HGpSWpcSrkE49GtGk0DGwEagAzSqPqaSuheZ9W
         xKZSPWCKdzCVAsCzZYi3Z2xWrcuat6OXmjxt54wHtC0+QF7xHAHlPN9Kn9TcPz+4bkPR
         QXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DeQDDa4h/AuQ1AqY7Xe0BU7IdInA68SacvQ+81dUYs=;
        b=6WvOPWmb0OGvtL8uzjrvgG17NsStGLXVxiHtygWelRvxs2fHDmpmhin9pXanAT9Uau
         7+An3lfYUV1HLXk1YojBrvzNgv84TUTNX3znFuMoe5RcS7twDtgOkg6pVGidtxl7bllT
         y19MSQfvQYFzxEP+WVrhRcdVYgBuiOvw3h2uTHgvBI4M8bTR3QeEcUWTlogGpF6KXrMH
         HkKnmFwMqFP8tiWmNS5UPwNFzLu/C80foUknKTSTjFJUC1JnqSFRvHnGpKTLQrYMFnqX
         09ydPzNf/L7AwjLpFqEYGSCrKVpB4sKegPBKNHROrqMAY7siJW9rKDs89fAQVfC61F/c
         ZZAQ==
X-Gm-Message-State: ACrzQf3NMFKMmDEGYEWGc8lfLD1VVRup+Ojr/I2i6CIpugPzb+0NRai/
        RObtFOegehxbGr84QJ7aHZiM7k9lmgue1A==
X-Google-Smtp-Source: AMsMyM6K8JjEGI/uWFqIYL+0bnYPEh47BoNg18PIXIRaaoT8JgBehtusYIi9UzgRcuyTUEFACryQiw==
X-Received: by 2002:aa7:cc90:0:b0:458:b07c:f35f with SMTP id p16-20020aa7cc90000000b00458b07cf35fmr14487384edt.310.1666316986650;
        Thu, 20 Oct 2022 18:49:46 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id x2-20020a50ba82000000b0044eb5b922bdsm12798450ede.24.2022.10.20.18.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 18:49:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1olhAP-006iWe-0k;
        Fri, 21 Oct 2022 03:49:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v3 6/6] diff-lib: parallelize run_diff_files for submodules
Date:   Fri, 21 Oct 2022 03:13:23 +0200
References: <https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/>
 <20221020232532.1128326-7-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221020232532.1128326-7-calvinwan@google.com>
Message-ID: <221021.86pmemeyiu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 20 2022, Calvin Wan wrote:

> @@ -103,6 +117,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  			      ? CE_MATCH_RACY_IS_DIRTY : 0);
>  	uint64_t start = getnanotime();
>  	struct index_state *istate = revs->diffopt.repo->index;
> +	struct string_list submodules = STRING_LIST_INIT_NODUP;
>  
>  	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
>  
> @@ -227,6 +242,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  			newmode = ce->ce_mode;
>  		} else {
>  			struct stat st;
> +			unsigned ignore_untracked = 0;
> +			int defer_submodule_status = !!revs->repo;
>  
>  			changed = check_removed(istate, ce, &st);
>  			if (changed) {
> @@ -248,8 +265,24 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  			}
>  
>  			changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
> -							    ce_option, &dirty_submodule);
> +							    ce_option, &dirty_submodule,
> +							    &defer_submodule_status,
> +							    &ignore_untracked);
>  			newmode = ce_mode_from_stat(ce, st.st_mode);
> +			if (defer_submodule_status) {
> +				struct submodule_status_util tmp = {
> +					.changed = changed,
> +					.dirty_submodule = 0,
> +					.ignore_untracked = ignore_untracked,
> +					.newmode = newmode,
> +					.ce = ce

Nit: We usually add the trailing "," to lists, except as a marker of
"don't add anything after this", i.e. only omit it when we have NULL as
the last element, but it's good to have it here.

> +				};
> +				struct string_list_item *item;

Nit: Another \n here to seperate the variables from the code, maybe...

> +				item = string_list_append(&submodules, ce->name);
> +				item->util = xmalloc(sizeof(tmp));
> +				memcpy(item->util, &tmp, sizeof(tmp));

This whole thing is much more readable, thanks.

> +				continue;
> +			}
>  		}
>  
>  		if (!changed && !dirty_submodule) {
> @@ -268,6 +301,40 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  			    ce->name, 0, dirty_submodule);
>  
>  	}
> +	if (submodules.nr > 0) {
> +		int parallel_jobs;
> +		if (git_config_get_int("submodule.diffjobs", &parallel_jobs))
> +			parallel_jobs = 1;
> +		else if (!parallel_jobs)
> +			parallel_jobs = online_cpus();
> +		else if (parallel_jobs < 0)
> +			die(_("submodule.diffjobs cannot be negative"));
> +
> +		if (get_submodules_status(revs->repo, &submodules, parallel_jobs))
> +			BUG("submodule status failed");

A BUG() is probably too strong if we're invoking a subprocess,
i.e. maybe the OS got tired of us and killed it, which is just an
exception, not a bug in git.

And, I may be missing something, but later in that function we do:

	if (repo_read_index(r) < 0)
        	die(_("index file corrupt"));

Do we need to read the index there if we're just invoking a "status"
command, isn't it reading it for us & reporting back?

> +struct submodule_parallel_status {
> +	size_t index_count;
> +	int result;
> +
> +	struct string_list *submodule_names;
> +	struct repository *r;
> +
> +	/* Pending statuses by OIDs */
> +	struct status_task **oid_status_tasks;
> +	int oid_status_tasks_nr, oid_status_tasks_alloc;
> +};
> +
> +#define SPS_INIT { 0 }

Nit: It's good to add *_INIT macros sometimes, but here we just have a
private API that's only used once, which is...

> [...]
> +int get_submodules_status(struct repository *r,
> +			  struct string_list *submodules,
> +			  int max_parallel_jobs)
> +{
> +	struct submodule_parallel_status sps = SPS_INIT;


...here, to copy some context around, and...

> +	const struct run_process_parallel_opts opts = {
> +		.tr2_category = "submodule",
> +		.tr2_label = "parallel/status",
> +
> +		.processes = max_parallel_jobs,
> +		.hide_output = 1,
> +
> +		.get_next_task = get_next_submodule_status,
> +		.start_failure = status_start_failure,
> +		.pipe_output = status_pipe_output,
> +		.task_finished = status_finish,
> +		.data = &sps,
> +	};
> +
> +	sps.r = r;
> +
> +	if (repo_read_index(r) < 0)
> +		die(_("index file corrupt"));
> +
> +	sps.submodule_names = submodules;

...the net result is needing to first assign SPS_INIT, then add the "r"
member, then "submodule_names". In this case this looks easier:

	struct submodule_parallel_status sps = {
		.r = r,
		.submodule_names = submodules,
	};
	const struct run_process_parallel_opts opts = {
        [...]

> +	string_list_sort(sps.submodule_names);
> +	run_processes_parallel(&opts);

> +
>  struct submodule_parallel_fetch {
>  	/*
>  	 * The index of the last index entry processed by
> @@ -1445,6 +1459,13 @@ struct fetch_task {
>  	struct oid_array *commits; /* Ensure these commits are fetched */
>  };
>  
> +struct status_task {
> +	struct repository *repo;
> +	const char *path;
> +	unsigned dirty_submodule;
> +	int ignore_untracked;
> +};
> +
>  /**
>   * When a submodule is not defined in .gitmodules, we cannot access it
>   * via the regular submodule-config. Create a fake submodule, which we can
> @@ -1956,6 +1977,142 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
>  	return dirty_submodule;
>  }
>  
> +static struct status_task *
> +get_status_task_from_index(struct submodule_parallel_status *sps,
> +			   struct strbuf *err)
> +{
> +	for (; sps->index_count < sps->submodule_names->nr; sps->index_count++) {
> +		struct submodule_status_util *util = sps->submodule_names->items[sps->index_count].util;
> +		const struct cache_entry *ce = util->ce;
> +		struct status_task *task;
> +		struct strbuf buf = STRBUF_INIT;
> +		const char *git_dir;
> +
> +		strbuf_addf(&buf, "%s/.git", ce->name);
> +		git_dir = read_gitfile(buf.buf);

Okey, so the "NULL" variant of read_gitfile_gently(), as we don't care
about the sort of error we got, but...

> +		if (!git_dir)
> +			git_dir = buf.buf;
> +		if (!is_git_directory(git_dir)) {

Isn't this something we could have asked read_gitfile_gently() about
instead, i.e. the READ_GITFILE_ERR_NOT_A_REPO condition?

> +			if (is_directory(git_dir))
> +				die(_("'%s' not recognized as a git repository"), git_dir);

It would be a detour from this, but perhaps setup.c can be tasked with
knowing about this edge case and returning an error code, but even if we
punt on that we can just do the is_directory() here, but get the
!is_git_directory() for free it seems.

> +			strbuf_release(&buf);
> +			/* The submodule is not checked out, so it is not modified */
> +			util->dirty_submodule = 0;
> +			continue;
> +		}
> +		strbuf_release(&buf);
> +
> +		task = xmalloc(sizeof(*task));
> +		memset(task, 0, sizeof(*task));

s/xmalloc/xcalloc/?

> +		task->path = ce->name;
> +		task->dirty_submodule = util->dirty_submodule;
> +		task->ignore_untracked = util->ignore_untracked;

Cn do we the same readability trick here that we did with "struct
submodule_status_util tmp = {" earlier & the memcpy()? Looks like it...

> +static int get_next_submodule_status(struct child_process *cp,
> +				     struct strbuf *err,
> +				     void *data, void **task_cb)

Nit: Too early wrapping, "void *data" should be at the previous line
(which won't exceed 79 chars)?


> +{
> +	struct submodule_parallel_status *sps = data;
> +	struct status_task *task = get_status_task_from_index(sps, err);
> +
> +	if (!task) {
> +		return 0;
> +	}

Nit: Don't need {}-braces here.

> +
> +	child_process_init(cp);
> +	prepare_submodule_repo_env_in_gitdir(&cp->env);
> +
> +	strvec_init(&cp->args);
> +	strvec_pushl(&cp->args, "status", "--porcelain=2", NULL);
> +	if (task->ignore_untracked)
> +		strvec_push(&cp->args, "-uno");

Nit: Maybe worth spelling out --untracked-files=no (or maybe "-uno" is
more idiomatic at this point...)

> +
> +	prepare_submodule_repo_env(&cp->env);
> +	cp->git_cmd = 1;
> +	cp->no_stdin = 1;
> +	cp->dir = task->path;
> +	*task_cb = task;
> +	return 1;
> +}
> +
> +static int status_start_failure(struct strbuf *err,
> +			        void *cb, void *task_cb)
> +{
> +	struct submodule_parallel_status *sps = cb;
> +
> +	sps->result = 1;
> +	return 0;
> +}
> +
> +static void status_pipe_output(struct strbuf *process_out,
> +			       void *cb, void *task_cb)
> +{
> +	struct status_task *task = task_cb;
> +	struct string_list list = STRING_LIST_INIT_DUP;
> +
> +	string_list_split(&list, process_out->buf, '\n', -1);
> +
> +	for (size_t i = 0; i < list.nr; i++) {
> +		if (parse_status_porcelain(list.items[i].string,
> +				   strlen(list.items[i].string),

Nit: I think you can use for_each_string_list_item() here, saving some
verbosity..

> +int get_submodules_status(struct repository *r,
> +			  struct string_list *submodules,
> +			  int max_parallel_jobs);

s/int/size_t/ because at this point you've already die()'d in the one
caller if it's <0 from the config parser, so we know it's unsigned
(actually >1, but unsigned will have to do :).
