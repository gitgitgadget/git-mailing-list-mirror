Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53056211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 01:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbeLEBHJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 20:07:09 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:40058 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeLEBHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 20:07:09 -0500
Received: by mail-vs1-f74.google.com with SMTP id e124so9405737vsc.7
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 17:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=70LHoCwp1Z/ZpwiZIuBB3d/GqS6tJIxrIFLxo7Z+7lA=;
        b=Q7KzjrA7b5WAKvoZRc0BdHKnQVbdRREVwJzBdqfxN3k+PY27MQS5HgqfzyhLvt1KyP
         jtFcjsTtSRj3p8QTEDs1OUg962r6XALPNNVj8QiE5m56gwOmfRm1EaAx5YJlcLRHrcgS
         MrbAbVZJd38uWva/HkECpUPRhKBOOod+lQlROr5fXeHqy00B3m4rbirMAcvewhkoIJEY
         62XLUqVi9ezGt36qduem+LRilffxqyIN2wnU31QRfpWk450dEIW0ACoHLIQqV+kaN5YP
         9p/Vas8BXXwqjipBnrDmNs0WeWLphwjAj4BS1gMvHvNnwL1lOXb7HV6RHu72gi2xri5k
         RVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=70LHoCwp1Z/ZpwiZIuBB3d/GqS6tJIxrIFLxo7Z+7lA=;
        b=Urbt1D717KIHhQwxQwWbNYEuA8j5v7b4o6iqSHoP7XttnuzPYvlI2ebCKlqaW+/YT3
         dBdEKlkKymAZjOxCxKgKMaj/vtCCzQ6jA273jG2ZWu21NfsmB6ZUCEI/CbffMb9H4LT2
         D5nmi28zZI/QBodnic/AJzKSn4PCVk2d0Jq9wjmWZ1yZlmxPu8j/1XVwOV/VflyKDGAP
         KGR0Pa2xkYEZbSeF7DZ7aW7fr3pwmjsQvq/7w0/ATFZ6B7g+NtKbCjjjLl1MfoI0xMtp
         3it0ghav+6I34WA5h6E+uwv5fQ/FjIyJOAfm4lHb6tHtgcOqCUhfCGraIsPZa0PhsyTb
         2M1w==
X-Gm-Message-State: AA+aEWYGoXqiaM3RFqFPwBbyzuO5bXrQoj+zUIevIm6fAe8MttUm4qwM
        XiELLFmVmFu15nmwX35okKs0gGkfsCIo/oCsEmMH
X-Google-Smtp-Source: AFSGD/XJWmEMQGrevjxJvDsLDwuIu25ZoEzavi2x2laKZcT+FFpeMfpZmWpvNNHdhUKLjNhEzbcnWRf/tCjQDJ2gNARX
X-Received: by 2002:a1f:9d53:: with SMTP id g80mr18892572vke.3.1543972028123;
 Tue, 04 Dec 2018 17:07:08 -0800 (PST)
Date:   Tue,  4 Dec 2018 17:07:04 -0800
In-Reply-To: <20181129002756.167615-10-sbeller@google.com>
Message-Id: <20181205010704.84790-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181129002756.167615-10-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 9/9] fetch: try fetching submodules if needed objects were
 not fetched
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Try fetching a submodule by object id if the object id that the
> superproject points to, cannot be found.

Mention here the consequences of what happens when this attempt to fetch
fails. Also, this seems to be a case of "do or do not, there is no try"
- maybe it's better to say "Fetch commits by ID from the submodule's
origin if the submodule doesn't already contain the commit that the
superproject references" (note that there is no "Try" word, since the
consequence is to fail the entire command).

Also mention that this fetch is always from the origin.

> builtin/fetch used to only inspect submodules when they were fetched
> "on-demand", as in either on/off case it was clear whether the submodule
> needs to be fetched. However to know whether we need to try fetching the
> object ids, we need to identify the object names, which is done in this
> function check_for_new_submodule_commits(), so we'll also run that code
> in case the submodule recursion is set to "on".
> 
> The submodule checks were done only when a ref in the superproject
> changed, these checks were extended to also be performed when fetching
> into FETCH_HEAD for completeness, and add a test for that too.

"inspect submodules" and "submodule checks" are unnecessarily vague to
me - might be better to just say "A list of new submodule commits are
already generated in certain conditions (by
check_for_new_submodule_commits()); this new feature invokes that
function in more situations".

> -		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
> -		    (recurse_submodules != RECURSE_SUBMODULES_ON))
> -			check_for_new_submodule_commits(&ref->new_oid);
>  		r = s_update_ref(msg, ref, 0);
>  		format_display(display, r ? '!' : '*', what,
>  			       r ? _("unable to update local ref") : NULL,
> @@ -779,9 +776,6 @@ static int update_local_ref(struct ref *ref,
>  		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
>  		strbuf_addstr(&quickref, "..");
>  		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
> -		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
> -		    (recurse_submodules != RECURSE_SUBMODULES_ON))
> -			check_for_new_submodule_commits(&ref->new_oid);
>  		r = s_update_ref("fast-forward", ref, 1);
>  		format_display(display, r ? '!' : ' ', quickref.buf,
>  			       r ? _("unable to update local ref") : NULL,
> @@ -794,9 +788,6 @@ static int update_local_ref(struct ref *ref,
>  		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
>  		strbuf_addstr(&quickref, "...");
>  		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
> -		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
> -		    (recurse_submodules != RECURSE_SUBMODULES_ON))
> -			check_for_new_submodule_commits(&ref->new_oid);
>  		r = s_update_ref("forced-update", ref, 1);
>  		format_display(display, r ? '!' : '+', quickref.buf,
>  			       r ? _("unable to update local ref") : _("forced update"),
> @@ -892,6 +883,8 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  				ref->force = rm->peer_ref->force;
>  			}
>  
> +			if (recurse_submodules != RECURSE_SUBMODULES_OFF)
> +				check_for_new_submodule_commits(&rm->old_oid);

As discussed above, indeed, check_for_new_submodule_commits() is now
invoked in more situations (not just when there is a local ref, and also
when recurse_submodules is _ON).

> @@ -1231,8 +1231,14 @@ struct submodule_parallel_fetch {
>  	int result;
>  
>  	struct string_list changed_submodule_names;
> +
> +	/* The submodules to fetch in */
> +	struct fetch_task **oid_fetch_tasks;
> +	int oid_fetch_tasks_nr, oid_fetch_tasks_alloc;
>  };

Better to document as "Pending fetches by OIDs", I think. (These are not
fetches by default refspec, and are not already in progress.)

> +struct fetch_task {
> +	struct repository *repo;
> +	const struct submodule *sub;
> +	unsigned free_sub : 1; /* Do we need to free the submodule? */
> +
> +	/* fetch specific oids if set, otherwise fetch default refspec */
> +	struct oid_array *commits;
> +};

I would document this as "Fetch in progress (if callback data) or
pending (if in oid_fetch_tasks in struct submodule_parallel_fetch)".
This potential confusion is why I wanted 2 separate types, as I wrote in
[1].

[1] https://public-inbox.org/git/20181026204106.132296-1-jonathantanmy@google.com/

> +/**
> + * When a submodule is not defined in .gitmodules, we cannot access it
> + * via the regular submodule-config. Create a fake submodule, which we can
> + * work on.
> + */
> +static const struct submodule *get_non_gitmodules_submodule(const char *path)

Thanks, this is a good explanation.

>  static int get_next_submodule(struct child_process *cp,
>  			      struct strbuf *err, void *data, void **task_cb)
>  {
> -	int ret = 0;
>  	struct submodule_parallel_fetch *spf = data;
>  
>  	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
> -		struct strbuf submodule_prefix = STRBUF_INIT;
> +		int recurse_config;

Unnecessary local variable recurse_config, but that's not a big deal.

[snip the part where we use a heap-allocated task instead of a few
variables on the stack]

> -			repo_clear(repo);
> -			free(repo);
> -			ret = 1;
> +			spf->count++;
> +			*task_cb = task;

And here we see why we need the heap-allocated task - it needs to go
into the callback data.

> +	if (spf->oid_fetch_tasks_nr) {
> +		struct fetch_task *task =
> +			spf->oid_fetch_tasks[spf->oid_fetch_tasks_nr - 1];
> +		struct strbuf submodule_prefix = STRBUF_INIT;
> +		spf->oid_fetch_tasks_nr--;
> +
> +		strbuf_addf(&submodule_prefix, "%s%s/",
> +			    spf->prefix, task->sub->path);
> +
> +		child_process_init(cp);
> +		prepare_submodule_repo_env_in_gitdir(&cp->env_array);
> +		cp->git_cmd = 1;
> +		cp->dir = task->repo->gitdir;
> +
> +		argv_array_init(&cp->args);
> +		argv_array_pushv(&cp->args, spf->args.argv);
> +		argv_array_push(&cp->args, "on-demand");
> +		argv_array_push(&cp->args, "--submodule-prefix");
> +		argv_array_push(&cp->args, submodule_prefix.buf);
> +
> +		/* NEEDSWORK: have get_default_remote from submodule--helper */
> +		argv_array_push(&cp->args, "origin");
> +		oid_array_for_each_unique(task->commits,
> +					  append_oid_to_argv, &cp->args);
> +
> +		*task_cb = task;
>  		strbuf_release(&submodule_prefix);
> -		if (ret) {
> -			spf->count++;
> -			return 1;
> -		}
> +		return 1;
>  	}

And if we ran out of submodules but have pending fetch-by-OID tasks, we
execute them.

> +static int commit_exists_in_sub(const struct object_id *oid, void *data)
> +{
> +	struct repository *subrepo = data;
> +
> +	enum object_type type = oid_object_info(subrepo, oid, NULL);
> +
> +	return type != OBJ_COMMIT;
> +}

Should be commit_missing_in_sub.

> +	/* Is this the second time we process this submodule? */
> +	if (task->commits)
> +		return 0;

Should be goto out, to clean up properly?

> +test_expect_success "fetch new submodule commits on-demand outside standard refspec" '
> +	# add a second submodule and ensure it is around in downstream first
> +	git clone submodule sub1 &&
> +	git submodule add ./sub1 &&
> +	git commit -m "adding a second submodule" &&
> +	git -C downstream pull &&
> +	git -C downstream submodule update --init --recursive &&
> +
> +	git checkout --detach &&
> +
> +	C=$(git -C submodule commit-tree -m "new change outside refs/heads" HEAD^{tree}) &&
> +	git -C submodule update-ref refs/changes/1 $C &&
> +	git update-index --cacheinfo 160000 $C submodule &&
> +	test_tick &&
> +
> +	D=$(git -C sub1 commit-tree -m "new change outside refs/heads" HEAD^{tree}) &&
> +	git -C sub1 update-ref refs/changes/2 $D &&
> +	git update-index --cacheinfo 160000 $D sub1 &&
> +
> +	git commit -m "updated submodules outside of refs/heads" &&
> +	E=$(git rev-parse HEAD) &&
> +	git update-ref refs/changes/3 $E &&
> +	(
> +		cd downstream &&
> +		git fetch --recurse-submodules origin refs/changes/3:refs/heads/my_branch &&
> +		git -C submodule cat-file -t $C &&
> +		git -C sub1 cat-file -t $D &&
> +		git checkout --recurse-submodules FETCH_HEAD
> +	)
> +'

It would be nicer if all these tests started from scratch (that is, an
empty repository), but they are understandable - thanks.

In addition to the tests here, I would like a test that checks that
submodule commits pointed to by interior superproject commits also work.
For example:

  submodule:
  B   C
   \ /
    A

  superproject:

  current HEAD -> a commit -> the ref we're fetching
  gitlink=A       gitlink=B   gitlink=C

When fetching recursively in the superproject, we should make sure that
both B and C are fetched in the submodule.
