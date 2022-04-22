Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84107C433FE
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 23:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiDVX21 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 19:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiDVX1b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 19:27:31 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393B2111CBF
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 16:06:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id g18so19007107ejc.10
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 16:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=uFMBS4UCt/GFSolCR+ELLHf7/7jgsk3xr+s7HtrHXuE=;
        b=SAPzse5fYp2qlvivi3dEmkFsOUA6UpKVDyQDZcvsw2wEABv1UMytU6pJy+DreIEDgW
         IvHtQifjCslLoX7oSYaPrY3WYMsqoRBoRY6fz/JO+d2f5woIry335yVu4YBmOKv33waC
         2CTfc1KxHTobpPRy9z4JSEzKziHinUDGxOmSaU/EUizvdZ/hPPw6dm7KFeeXwBmkZ96S
         WA+kn2GaKoH8AdTdwFIX0c+efmJFFBgF7tAnhuNV/L4Yh01QK4yfg/pRjJiPzJ743GNU
         CqLRF9v6Th41bQK4XbJeqTpftquvjFpb0IcNQXFILkdMpGZFWvus8uODMTAmW9WZf1Qx
         T08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=uFMBS4UCt/GFSolCR+ELLHf7/7jgsk3xr+s7HtrHXuE=;
        b=FFewLtyNyCjGzVTm5XEGsIXx2w68TCM6i1WdayGJPkVX89JhFB/aixI5vFw9KYKbKT
         HULoaC+xdOVIcTIiSS8taiQNVREtssJ2MbBcqm3dAR2fAaLvzkDlzS0Q5BYXPBIpSQUO
         YOGZDnU5vMb8BXlYRR9NvJvUgz+q0tGypp3QRUUFAZjB2E9dngo7e95oGUGbg7GzALeB
         iHlMA6pmaOgAAjc5wZCZILaENwpP6MVUNmvKL6deUryXaJ2J4kiqZrWlTbI0vchOkLH/
         rKt6/VO7WIVVBDh/9cr3A96kjjuZu39nQIBeFbHBFg9Ivi/QiKb2y2K86+xLi4w6jH//
         BbuQ==
X-Gm-Message-State: AOAM5327V6b5a+7JmMqHW/uOCiMxM3RD5O4XCDLMbuWdut8tRQQEMwoa
        SVoOOBRhYf/uUgBC8FCA7vtSvQoypGHSIg==
X-Google-Smtp-Source: ABdhPJzZzGdOd0gvuxIRFozZzMnodC6YQqMfjAoSzJguNIvHq9swqgywGo746HIwIIFtpmxlReYZPw==
X-Received: by 2002:a17:907:d04:b0:6e8:8cbc:e86a with SMTP id gn4-20020a1709070d0400b006e88cbce86amr6356133ejc.194.1650668806422;
        Fri, 22 Apr 2022 16:06:46 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f1-20020a056402194100b00416b174987asm1461759edz.35.2022.04.22.16.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 16:06:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ni2MP-000NbT-G7;
        Sat, 23 Apr 2022 01:06:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1] rebase - recycle
Date:   Sat, 23 Apr 2022 00:57:12 +0200
References: <20220422183744.347327-1-eantoranz@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220422183744.347327-1-eantoranz@gmail.com>
Message-ID: <220423.86bkwsra4a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 22 2022, Edmundo Carmona Antoranz wrote:

Just minor nits from a quick read. Not on the main logic, just syntax
etc. issues:

>  #define DEFAULT_REFLOG_ACTION "rebase"
>  
> @@ -49,7 +52,8 @@ static GIT_PATH_FUNC(merge_dir, "rebase-merge")
>  enum rebase_type {
>  	REBASE_UNSPECIFIED = -1,
>  	REBASE_APPLY,
> -	REBASE_MERGE
> +	REBASE_MERGE,
> +	REBASE_RECYCLE
>  };
>  
>  enum empty_type {
> @@ -83,6 +87,8 @@ struct rebase_options {
>  		REBASE_DIFFSTAT = 1<<2,
>  		REBASE_FORCE = 1<<3,
>  		REBASE_INTERACTIVE_EXPLICIT = 1<<4,
> +		REBASE_RECYCLE_OR_FAIL = 1 << 5,
> +		REBASE_ATTEMPT_RECYCLE = 1<<6,

Needs consistent whitespace for <<.

>  	} flags;
>  	struct strvec git_am_opts;
>  	const char *action;
> @@ -104,6 +110,16 @@ struct rebase_options {
>  	int fork_point;
>  };
>  
> +struct recycle_parent_mapping {
> +	struct oidmap_entry e;
> +	struct commit *new_parent;
> +};
> +
> +struct recycle_progress_info {
> +	struct progress *progress;
> +	int commits;
> +};
> +
>  #define REBASE_OPTIONS_INIT {			  	\
>  		.type = REBASE_UNSPECIFIED,	  	\
>  		.empty = EMPTY_UNSPECIFIED,	  	\
> @@ -384,6 +400,12 @@ static int is_merge(struct rebase_options *opts)
>  	return opts->type == REBASE_MERGE;
>  }
>  
> +static int can_recycle(struct rebase_options *opts)
> +{
> +	return oideq(get_commit_tree_oid(opts->onto),
> +		     get_commit_tree_oid(opts->upstream));
> +}
> +
>  static void imply_merge(struct rebase_options *opts, const char *option)
>  {
>  	switch (opts->type) {
> @@ -771,6 +793,173 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
>  	return status ? -1 : 0;
>  }
>  
> +static struct commit *recycle_commit(struct commit *orig_commit,
> +				     struct oidmap *parents)
> +{
> +	const char *body;
> +	size_t body_length;
> +	const char *author_raw;
> +	size_t author_length;
> +	struct strbuf author = STRBUF_INIT;
> +	const char *message;
> +	size_t message_length;
> +	int result;
> +

We tend not to \n\n-break the variables.


> +	if (result)
> +		die("Could not create a recycled revision for %s\n",

Error messages should not start wth capital letters, so "could.." not
"Could". Also needs _() markings for translation. Then don't add a \n.

> +	struct recycle_parent_mapping *mapping;
> +	mapping = xmalloc(sizeof(*mapping));

Add \n\n between variable decls & code.

In this case though we can just put the xmalloc() with decl...


> +	struct commit *orig_head;
> +	struct commit *new_head = NULL;
> +	struct commit *commit;
> +	struct commit_list *old_commits = NULL;
> +	struct commit_list *old_commit;
> +	struct oidmap parents;
> +	struct progress *progress = NULL;
> +	int commit_counter = 0;
> +
> +	init_revisions(&revs, NULL);
> +	revs.commit_format = CMIT_FMT_RAW;
> +	orig_head = lookup_commit_or_die(&opts->orig_head, "head");

Just declare this with the variable, seems it doesn't need
init_revisions, or does it...?

> +
> +	opts->upstream->object.flags |= UNINTERESTING;
> +	add_pending_object(&revs, &opts->upstream->object, "upstream");
> +	add_pending_object(&revs, &orig_head->object, "head");
> +
> +	if (prepare_revision_walk(&revs))
> +		die("Could not get commits to recycle");

ditto capital letters, _() etc.

> +	if (isatty(2)) {

Skip {} for one-statement if's.

> +		start_delayed_progress(_("Recycling commits"),

Missing the assignment to progerss, so this never works, presumably...

> +				       commit_list_count(old_commits));
> +	}
> +
> +	old_commit = old_commits;
> +	while (old_commit) {
> +		display_progress(progress, ++commit_counter);

I.e. still NULL here...

> +		new_head = recycle_commit(old_commit->item, &parents);
> +		recycle_save_parent_mapping(&parents, old_commit->item,
> +					    new_head);
> +		old_commit = old_commit->next;
> +	}
> +
> +	stop_progress(&progress);
> +
> +	return new_head;
> +}
> +
> +static void recycle_wrapup(struct rebase_options *opts,
> +			   const char *branch_name, struct commit *new_head)
> +{
> +	struct strvec args = STRVEC_INIT;

\n\n again.

> +	if (opts->head_name) {
> +		struct wt_status s = { 0 };
> +
> +		s.show_branch = 1;
> +		wt_status_prepare(the_repository, &s);
> +		wt_status_collect(&s);
> +		if (!strcmp(s.branch, opts->head_name)) {
> +			struct reset_head_opts ropts = { 0 };
> +			struct strbuf msg = STRBUF_INIT;

ditto.

> +			strbuf_addf(&msg, "rebase recycle: "
> +				    "moving to %s",
> +				    oid_to_hex(&new_head->object.oid));
> +			ropts.oid = &new_head->object.oid;
> +			ropts.orig_head = &opts->orig_head,
> +			ropts.flags = RESET_HEAD_HARD |
> +				      RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
> +			ropts.head_msg = msg.buf;
> +			ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
> +			if (reset_head(the_repository, &ropts))
> +				die(_("Could not reset"));
> +			strbuf_release(&msg);
> +		} else {
> +			update_ref(NULL, opts->head_name,
> +				   &new_head->object.oid, NULL,
> +				   0, UPDATE_REFS_DIE_ON_ERR);
> +
> +			strvec_pushf(&args, "checkout");
> +			strvec_pushf(&args, "--quiet");
> +			strvec_pushf(&args, "%s", branch_name);

You want just strvec_pushl() here., or strvec_push(), but definitely not
strvec_pushf(). You're not using the formatting.

> +
> +			run_command_v_opt(args.v, RUN_GIT_CMD);
> +			strvec_clear(&args);
> +		}
> +	} else {
> +		strvec_pushf(&args, "checkout");
> +		strvec_pushf(&args, "--quiet");
> +		strvec_pushf(&args, "%s", oid_to_hex(&new_head->object.oid));

Ditto.

> +
> +		run_command_v_opt(args.v, RUN_GIT_CMD);
> +		strvec_clear(&args);
> +	}
> +}
> +
>  static int rebase_config(const char *var, const char *value, void *data)
>  {
>  	struct rebase_options *opts = data;
> @@ -1154,6 +1343,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			 N_("automatically re-schedule any `exec` that fails")),
>  		OPT_BOOL(0, "reapply-cherry-picks", &options.reapply_cherry_picks,
>  			 N_("apply all changes, even those already present upstream")),
> +		OPT_BIT(0, "recycle", &options.flags,
> +			N_("Run a recycle, if possible. Fails otherwise."),

run not Run, and drop the "." at the end.

> +			REBASE_RECYCLE_OR_FAIL),
> +		OPT_BIT(0, "attempt-recycle", &options.flags,
> +			N_("Run a recycle, if possible. Continue with other approaches if it can't be done."),

Ditto.

Also I think you want "OPT_BOOL"...?

> +			REBASE_ATTEMPT_RECYCLE),
>  		OPT_END(),
>  	};
>  	int i;
> @@ -1234,6 +1429,20 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		die(_("The --edit-todo action can only be used during "
>  		      "interactive rebase."));
>  
> +	if (options.flags & (REBASE_RECYCLE_OR_FAIL | REBASE_ATTEMPT_RECYCLE)) {
> +		if ((options.flags & (REBASE_RECYCLE_OR_FAIL | REBASE_ATTEMPT_RECYCLE)) ==
> +		    (REBASE_RECYCLE_OR_FAIL | REBASE_ATTEMPT_RECYCLE))
> +			die(_("Can't use both --recycle and --attempt-recycle."));

You can use OPT_CMDMODE() to declare flags that are mutually exclusive,
but maybe it's not a good fit in this case.

> +		if (options.flags & REBASE_INTERACTIVE_EXPLICIT)
> +			die(_("Can't use --recycle/--attempt-recycle with interactive mode."));
> +		if (options.strategy) {
> +			die(_("Can't specify a strategy when using --recycle/--atempt-recycle."));
> +		}
> +		if (options.signoff) {
> +			die(_("Can't use --signoff with --recycle/--atempt-recycle"));
> +		}

Aside from capital, _() etc. these can also drop {}'s

> +				printf(_("Recycled %s onto %s.\n"),
> +					branch_name, options.onto_name);
> +				recycle_wrapup(&options, branch_name,
> +					       new_head);
> +				ret = 0;
> +				goto cleanup;
> +			}
> +		} else
> +			printf(_("upstream and onto do not share the same tree. "
> +				 "Can't run a recycle.\n"));

Don't use printf() when puts() would do (the latter case).

The else is missing {} (see CodingGuidelines). I.e. if one arm gets it
all of them get it.
