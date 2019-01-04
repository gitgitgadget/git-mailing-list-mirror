Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73F581F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 18:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfADSiH (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 13:38:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35791 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfADSiG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 13:38:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so2093119wmt.0
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 10:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=5Awm+UaaI9FV91AC/RSaO5OWm0hxesJM1G59t8MMG5c=;
        b=UneVcigDlyBBfx3VG5PIXEApAYGwSK+G4c8BfgDOe/+p4o1gqHogsr9MAW4OE6i0wd
         qqgvJGOaUUyrqkDbs20eGlkYWfajgszgqknxl5FKmVY21m2gwSJisQnivyDxgqdGH4Ji
         wecOn0NXi3l2CpgfKbHYMhGov6r1x9zG28GbA5oTehjcWDSEA86BefS/WjxC87ia/5KD
         3thpDDi/XfEJNqn5ITRmeUk5LF2GU4F5N5IAFjAnO6Db5m6/HWidq5cXoPxeg5scZzcu
         wQ2lkuNtUjmSD23thd5ZajjWfdEermOHp3Nd6y62r4Q79vkZmPtXQXdf5ImL8FilhHEe
         vo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=5Awm+UaaI9FV91AC/RSaO5OWm0hxesJM1G59t8MMG5c=;
        b=oShygkdXZ+ePR00Nn7lF/R/mS3fsu5QWo7rQ7m251zhI+sZOEsazTRDk4w9nQ2GSN4
         nj7vx1eT5OOHDgtvykxkYqe048oJHXvE5ZQ3E5gk0wqCyRXnwParBf5ZuO0meX+EPtrl
         n2SmaH8RRdVRCQhkVhWfib0iLn8F5rwwfBQZkjyU6JEOilKLpQ7AjTQz0JvaTm6uKXkt
         JFUL1mj4oWNctm91WKN0/9nNj4GQfKvS+65wChxDh66WhIVbQX2fWV+msWxVFTnrzkBi
         ngeQKkKcCyVxCtYoekUrusSINVFT5EoV/oojfg8k1foWWF0pcYst4ZIJyDgkJ04eVKxj
         /QEw==
X-Gm-Message-State: AJcUukfJgo7EtfH64Gd0EiDcTqtM4KedlGU4uSeEbfnW59qQXhVsTq6b
        nVRHM3kn0yrJQe8ucoI7X78=
X-Google-Smtp-Source: ALg8bN6jMJ9ldsdU5R57VxUEU9HYTQK6nl8CScYFxUnF/DjLPR4Ymbq3DCWuIBoqJJpIB6e67Yyspw==
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr2173334wme.73.1546627084314;
        Fri, 04 Jan 2019 10:38:04 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c15sm1354557wml.27.2019.01.04.10.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 10:38:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH 4/4] built-in rebase: call `git am` directly
References: <pull.24.git.gitgitgadget@gmail.com>
        <2b5ece8263936f0a7dfad864c0de43d784fdaf1f.1545398254.git.gitgitgadget@gmail.com>
Date:   Fri, 04 Jan 2019 10:38:02 -0800
Message-ID: <xmqqwonkclpx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +static int write_basic_state(struct rebase_options *opts)
> +{
> +	write_file(state_dir_path("head-name", opts), "%s",
> +		   opts->head_name ? opts->head_name : "detached HEAD");
> +	write_file(state_dir_path("onto", opts), "%s",
> +		   opts->onto ? oid_to_hex(&opts->onto->object.oid) : "");
> +	write_file(state_dir_path("orig-head", opts), "%s",
> +		   oid_to_hex(&opts->orig_head));
> +	write_file(state_dir_path("quiet", opts), "%s",
> +		   opts->flags & REBASE_NO_QUIET ? "" : "t");
> +	if (opts->flags & REBASE_VERBOSE)
> +		write_file(state_dir_path("verbose", opts), "%s", "");
> +	if (opts->strategy)
> +		write_file(state_dir_path("strategy", opts), "%s",
> +			   opts->strategy);
> +	if (opts->strategy_opts)
> +		write_file(state_dir_path("strategy_opts", opts), "%s",
> +			   opts->strategy_opts);
> +	if (opts->allow_rerere_autoupdate >= 0)
> +		write_file(state_dir_path("allow_rerere_autoupdate", opts),
> +			   "-%s-rerere-autoupdate",
> +			   opts->allow_rerere_autoupdate ? "" : "-no");

Inside rebase, allow-rerere-autoupdate can be -1 (unspecified), 0
(declined) or 1 (requested), and this code is being consistent with
that convention.

The "--[no-]rerere-autoupdate" option that is parsed via
OPT_RERERE_AUTOUPDATE (used in builtin/rebase--interactive.c among
other built-in commands) on the other hand is tertially that uses 0
(unspecified), 1 (requested) and 2 (declined).  This might be a
ticking timebomb to confuse us in the future that may be worth
fixing but probably outside this series.

> +	if (opts->gpg_sign_opt)
> +		write_file(state_dir_path("gpg_sign_opt", opts), "%s",
> +			   opts->gpg_sign_opt);
> +	if (opts->signoff)
> +		write_file(state_dir_path("strategy", opts), "--signoff");
> +
> +	return 0;
> +}

The above looks like a literal translation of a helper function with
the same name in git-rebase--common.sh.  Good.

> @@ -459,6 +490,30 @@ static int reset_head(struct object_id *oid, const char *action,
>  	return ret;
>  }
>  
> +static int move_to_original_branch(struct rebase_options *opts)
> +{
> +	struct strbuf orig_head_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
> +	int ret;
> +
> +	if (!opts->head_name)
> +		return 0; /* nothing to move back to */
> +
> +	if (!opts->onto)
> +		BUG("move_to_original_branch without onto");

This check is absent in the scripted version, but from the message
we generate here, it is clear that the caller must not call this
when there is no "onto" commit.  Good.

> +	strbuf_addf(&orig_head_reflog, "rebase finished: %s onto %s",
> +		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
> +	strbuf_addf(&head_reflog, "rebase finished: returning to %s",
> +		    opts->head_name);
> +	ret = reset_head(NULL, "checkout", opts->head_name,
> +			 RESET_HEAD_REFS_ONLY,
> +			 orig_head_reflog.buf, head_reflog.buf);

The *action given to reset_head() here is "checkout".  Makes me
wonder about two things:

 - The only real use of the parameter in the callee is to prepare
   the error and advice messages from the unpack_trees machinery,
   but because we are using it in REFS_ONLY mode, it does not
   matter.  In fact it might even be misleading; perhaps pass NULL
   or something, so that a mistaken update to reset_head() later
   that lets REFS_ONLY request to go to unpack_trees machinery will
   catch it as a bug?

 - Another topic in flight wants to make sure that the post-checkout
   hook gets called when the RESET_HEAD_RUN_POST_CHECKOUT_HOOK flag
   is given by the caller, and IIRC, the use of the flag is strongly
   correlated to *action being "checkout".  Do we want to pass
   REFS_ONLY and RUN_POST_CHECKOUT_HOOK flag for this call, or do we
   rather keep it silent?  As the original scripted version did not
   use "checkout" here and never triggered post-checkout hook, I am
   inclined to say that we should not pass that other bit.  That
   then leads me to suspect that we do not want *action to be
   "checkout" here.

> +	strbuf_release(&orig_head_reflog);
> +	strbuf_release(&head_reflog);
> +	return ret;
> +}

Unlike the scripted version, this does not die() upon failure, so
the caller needs to be careful about the returned status.

> @@ -466,6 +521,129 @@ N_("Resolve all conflicts manually, mark them as resolved with\n"
>  "To abort and get back to the state before \"git rebase\", run "
>  "\"git rebase --abort\".");
>  
> +static int run_am(struct rebase_options *opts)
> +{
> +	struct child_process am = CHILD_PROCESS_INIT;
> +	struct child_process format_patch = CHILD_PROCESS_INIT;
> +	struct strbuf revisions = STRBUF_INIT;
> +	int status;
> +	char *rebased_patches;
> +
> +	am.git_cmd = 1;
> +	argv_array_push(&am.args, "am");
> +
> +	if (opts->action && !strcmp("continue", opts->action)) {
> +		argv_array_push(&am.args, "--resolved");
> +		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
> +		if (opts->gpg_sign_opt)
> +			argv_array_push(&am.args, opts->gpg_sign_opt);
> +		status = run_command(&am);
> +		if (status)
> +			return status;
> +
> +		discard_cache();
> +		return move_to_original_branch(opts);

It is curious why discard_cache() is placed exacly here, as if we
want to preserve the contents of the in-core index when
run_command() failed.  But I do not think we care about the in-core
index as the only thing that happen after "return status" is to
return the control to run_specific_rebase(), let it jump to
finished_rebase label to clean things up and rturn control to
cmd_rebase() and exit based on the status value.

It's not like move_to_original_branch() wants to call read_cache()
and get the result from the "am" that run_command() executed,
either.

Puzzled.  Care to explain a bit more in the in-code comment?

> +	}
> +	if (opts->action && !strcmp("skip", opts->action)) {
> +		argv_array_push(&am.args, "--skip");
> +		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
> +		status = run_command(&am);
> +		if (status)
> +			return status;
> +
> +		discard_cache();
> +		return move_to_original_branch(opts);

Ditto.

> +	}
> +	if (opts->action && !strcmp("show-current-patch", opts->action)) {
> +		argv_array_push(&am.args, "--show-current-patch");
> +		return run_command(&am);
> +	}

Up to this point, it is a faithful conversion of the first case/esac
statement.  Good.

> +	strbuf_addf(&revisions, "%s...%s",
> +		    oid_to_hex(opts->root ?
> +			       /* this is now equivalent to ! -z "$upstream" */

Does "this" refer to the "opts->root being true" check?

Because you are flipping the polarity of the test from scripted
version, shouldn't the comment be updated to "-z $upstream"?

> +			       &opts->onto->object.oid :
> +			       &opts->upstream->object.oid),
> +		    oid_to_hex(&opts->orig_head));

> +	rebased_patches = xstrdup(git_path("rebased-patches"));
> +	format_patch.out = open(rebased_patches,
> +				O_WRONLY | O_CREAT | O_TRUNC, 0666);

Unlike scripted version, we do not remove a (possibly) existing file.
We give CREAT in case there is no existing one, and TRUNC in case
there is an existing one.  Makes sense.  A more faithful translation
would have unlink(2)ed a (possibly) existing one, and then because
we can afford to, passed O_EXCL to avoid stomping on somebody else
racing with us, but I do not think it is worth it.

> +	if (format_patch.out < 0) {
> +		status = error_errno(_("could not write '%s'"),
> +				     rebased_patches);

s/write '%s'/open '%s' for writing/?  I dunno.

> +		free(rebased_patches);
> +		argv_array_clear(&am.args);
> +		return status;
> +	}
> +
> +	format_patch.git_cmd = 1;
> +	argv_array_pushl(&format_patch.args, "format-patch", "-k", "--stdout",
> +			 "--full-index", "--cherry-pick", "--right-only",
> +			 "--src-prefix=a/", "--dst-prefix=b/", "--no-renames",
> +			 "--no-cover-letter", "--pretty=mboxrd", NULL);
> +	if (opts->git_format_patch_opt.len)
> +		argv_array_split(&format_patch.args,
> +				 opts->git_format_patch_opt.buf);
> +	argv_array_push(&format_patch.args, revisions.buf);
> +	if (opts->restrict_revision)
> +		argv_array_pushf(&format_patch.args, "^%s",
> +				 oid_to_hex(&opts->restrict_revision->object.oid));

It is kinda surprising to see that we have learned quite a lot of
fringe "configurations" we need to explicitly override like this.

Looks like a quite faithful conversion, anyway.

> +	status = run_command(&format_patch);
> +	if (status) {
> +		unlink(rebased_patches);
> +		free(rebased_patches);
> +		argv_array_clear(&am.args);
> +
> +		reset_head(&opts->orig_head, "checkout", opts->head_name, 0,
> +			   "HEAD", NULL);

This one may need to trigger post-checkout hook.  The scripted
version does two different things depending on the value of
$head_name, but we can just use the same code without conditional?

> +		error(_("\ngit encountered an error while preparing the "
> +			"patches to replay\n"
> +			"these revisions:\n"
> +			"\n    %s\n\n"
> +			"As a result, git cannot rebase them."),
> +		      opts->revisions);
> +
> +		strbuf_release(&revisions);
> +		return status;
> +	}
> +	strbuf_release(&revisions);
> +
> +	am.in = open(rebased_patches, O_RDONLY);
> +	if (am.in < 0) {
> +		status = error_errno(_("could not read '%s'"),
> +				     rebased_patches);

s/write '%s'/open '%s' for reading/?  I dunno.

> +		free(rebased_patches);
> +		argv_array_clear(&am.args);
> +		return status;
> +	}
> +
> +	argv_array_pushv(&am.args, opts->git_am_opts.argv);
> +	argv_array_push(&am.args, "--rebasing");
> +	argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
> +	argv_array_push(&am.args, "--patch-format=mboxrd");
> +	if (opts->allow_rerere_autoupdate > 0)
> +		argv_array_push(&am.args, "--rerere-autoupdate");
> +	else if (opts->allow_rerere_autoupdate == 0)
> +		argv_array_push(&am.args, "--no-rerere-autoupdate");
> +	if (opts->gpg_sign_opt)
> +		argv_array_push(&am.args, opts->gpg_sign_opt);
> +	status = run_command(&am);
> +	unlink(rebased_patches);
> +	free(rebased_patches);
> +
> +	if (!status) {
> +		discard_cache();
> +		return move_to_original_branch(opts);
> +	}
> +
> +	if (is_directory(opts->state_dir))
> +		write_basic_state(opts);
> +
> +	return status;
> +}
> +
>  static int run_specific_rebase(struct rebase_options *opts)
>  {
>  	const char *argv[] = { NULL, NULL };
> @@ -546,6 +724,11 @@ static int run_specific_rebase(struct rebase_options *opts)
>  		goto finished_rebase;
>  	}
>  
> +	if (opts->type == REBASE_AM) {
> +		status = run_am(opts);
> +		goto finished_rebase;
> +	}
> +
>  	add_var(&script_snippet, "GIT_DIR", absolute_path(get_git_dir()));
>  	add_var(&script_snippet, "state_dir", opts->state_dir);


Overall, this was quite a pleasant read and a well constructed
series.  Other than two minor points (i.e. interaction with the
'post-checkout hook' topic, and discard_cache() before calling
move_to_original_branch) I did not quite understand, looks good to
me.

When merged to 'pu', I seem to be getting failure from t3425.5, .8
and .11, by the way.  I haven't dug into the actual breakages any
further than that.

Thanks.
