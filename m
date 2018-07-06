Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F27A1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 21:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933039AbeGFVaT (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 17:30:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35802 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932496AbeGFVaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 17:30:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id v3-v6so11994783wmh.0
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 14:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sOQzykmPvbmm2vrg4Gnk9iOdXSgkdGkrybyRkQmDv5c=;
        b=Y6/zJjXsqwMzVgaVTY+4bTauKUJ43F7YjZTOIPm5tEhybrvkeT5F/rqzTWjwqGVrdC
         f5Gaqt0LfyEAqHm5xbwbuTnnLi+Z+VtjLa0m5lfdj3IOaQleF+CaSc/wBDVt/OkB0cHp
         tq/q5Coa4zGvh1tzupOd0GQ6z7zpOVmvz7fYIJ2nQHneKpbKrkGo5dPIIEB3WlZIEmle
         DzsOANN6FH+xdzk3v8EYXbir9Ip2/JNMPzeUz1HKeU180oJq9Z9ddt5fiNVtVgN9lpwx
         4CFL/ECRyhcGJxWWCLoPo5LZj1Vi0Iz4RreY4hTuwL8g0nOk8/QFqYzQL+1lSo0T6knk
         ehYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sOQzykmPvbmm2vrg4Gnk9iOdXSgkdGkrybyRkQmDv5c=;
        b=DejydRK7xbUvMFLW3UxZoAGEeUEt9X7Ynkgaa+N5Ct8k1O7o4q48I50/qY/o6B27Z2
         BZKF3pXGzn8CAEkds4bL9SKR68qinzg9cmwkemHseU/4KQV+srmTGadL6bHEdieI5Bkn
         5Qn7vkNjEjKIyQP6rZLComyeo9/rJ1xpp2sl8uNW5w/2iV/2toAYS4bCLU+dnTXxVzsW
         E/RkC//aHdQDQvkrRz4uQpr+NTFG95nNLRc/Q5cIU63lwCSejLadJJ2pxB6TtOFoRutG
         LPoHDQ/g/U70vB3pqmS+hfqLbHRyzi87PbT1GXTqeabfp4g6virC2gMlbdxVs0m8Ny4K
         b/8g==
X-Gm-Message-State: APt69E3QO2obC+1IQgMG9hM47XenzGbp/deHhSX07R1g9LYslVPTDihN
        KzcPcadcK3wt5aMH3FTbvcc=
X-Google-Smtp-Source: AAOMgpc+7ISBDQ3Am9TRAvQyVwUif9+V5Xfs1aPMkP5OXrDKjtlt7qK3wUnvNct60cg948jZqNxIHg==
X-Received: by 2002:a1c:e70b:: with SMTP id e11-v6mr514755wmh.22.1530912615326;
        Fri, 06 Jul 2018 14:30:15 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 125-v6sm18087356wmw.9.2018.07.06.14.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 14:30:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, sbeller@google.com,
        alban.gruin@gmail.com
Subject: Re: [PATCH v3 4/4] builtin/rebase: support running "git rebase <upstream>"
References: <20180628074655.5756-1-predatoramigo@gmail.com>
        <20180706120815.17851-1-predatoramigo@gmail.com>
        <20180706120815.17851-5-predatoramigo@gmail.com>
Date:   Fri, 06 Jul 2018 14:30:14 -0700
In-Reply-To: <20180706120815.17851-5-predatoramigo@gmail.com> (Pratik Karki's
        message of "Fri, 6 Jul 2018 17:53:15 +0545")
Message-ID: <xmqqsh4whx21.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratik Karki <predatoramigo@gmail.com> writes:

> +static void add_var(struct strbuf *buf, const char *name, const char *value)
> +{
> +	strbuf_addstr(buf, name);
> +	strbuf_addstr(buf, "=");
> +	sq_quote_buf(buf, value);
> +	strbuf_addstr(buf, "; ");
> +}
> +
> +static int run_specific_rebase(struct rebase_options *opts)
> +{
> +	const char *argv[] = { NULL, NULL };
> +	struct strbuf script_snippet = STRBUF_INIT;
> +	int status;
> +	const char *backend, *backend_func;
> +
> +	add_var(&script_snippet, "GIT_DIR", absolute_path(get_git_dir()));
> +
> +	add_var(&script_snippet, "upstream_name", opts->upstream_name);
> +	add_var(&script_snippet, "upstream",
> +				 oid_to_hex(&opts->upstream->object.oid));
> +	add_var(&script_snippet, "head_name", opts->head_name);
> +	add_var(&script_snippet, "orig_head", oid_to_hex(&opts->orig_head));
> +	add_var(&script_snippet, "onto", oid_to_hex(&opts->onto->object.oid));
> +	add_var(&script_snippet, "onto_name", opts->onto_name);
> +	add_var(&script_snippet, "revisions", opts->revisions);

Looks alright.

> +	switch (opts->type) {
> +	case REBASE_AM:
> +...
> +	default:
> +		BUG("Unhandled rebase type %d", opts->type);
> +		break;
> +	}

Better.

> +	strbuf_addf(&script_snippet,
> +		    ". git-rebase--common && . %s && %s",
> +		    backend, backend_func);
> +	argv[0] = script_snippet.buf;
> +
> +	status = run_command_v_opt(argv, RUN_USING_SHELL);

This used to use run_command_v_opt_cd_env() to pass extra
environment but now we can do a simpler one.  As cmd_rebase()
has called setup_git_directory() to chdir to the top level of
the working tree, we just want to .-source the backend within
the current working directory, so loss of cd is also good ;-)

> +	if (status == 0)
> +		finish_rebase(opts);
> +	else if (status == 2) {
> +		struct strbuf dir = STRBUF_INIT;
> +
> +		apply_autostash();
> +		strbuf_addstr(&dir, opts->state_dir);
> +		remove_dir_recursively(&dir, 0);
> +		strbuf_release(&dir);
> +		die("Nothing to do");
> +	}
> +
> +	strbuf_release(&script_snippet);
> +
> +	return status ? -1 : 0;
> +}
> +
>  int cmd_rebase(int argc, const char **argv, const char *prefix)
>  {
> +	struct rebase_options options = { -1 };

The first field of this struct is "enum rebase_type" defined without
"REBASE_TYPE_UNSPECIFIED = -1" in it.  It probably makes sense to
add that constant there so that you can spell this value out.

> @@ -52,5 +194,98 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	trace_repo_setup(prefix);
>  	setup_work_tree();
>  
> -	die("TODO");
> +	options.type = REBASE_AM;
> +
> +	switch (options.type) {
> +	case REBASE_AM:
> +		options.state_dir = apply_dir();
> +		break;
> +	case REBASE_MERGE:
> +	case REBASE_INTERACTIVE:
> +	case REBASE_PRESERVE_MERGES:
> +		options.state_dir = merge_dir();
> +		break;

Have "default:" here that barfs with BUG() to help future
introduction of bugs as the code to set options.type grows
complexity over time.

> +	}
> +	if (!options.root) {
> +		if (argc != 2)
> +			die("TODO: handle @{upstream}");
> +		else {
> +			options.upstream_name = argv[1];
> +			argc--;
> +			argv++;
> +			if (!strcmp(options.upstream_name, "-"))
> +				options.upstream_name = "@{-1}";
> +		}
> +		options.upstream = peel_committish(options.upstream_name);
> +		if (!options.upstream)
> +			die(_("invalid upstream '%s'"), options.upstream_name);
> +	} else
> +		die("TODO: upstream for --root");
> +
> +	/* Make sure the branch to rebase onto is valid. */
> +	if (!options.onto_name)
> +		options.onto_name = options.upstream_name;
> +	if (strstr(options.onto_name, "...")) {
> +		die("TODO");
> +	} else {
> +		options.onto = peel_committish(options.onto_name);
> +		if (!options.onto)
> +			die(_("Does not point to a valid commit '%s'"),
> +				options.onto_name);
> +	}
> +
> +	/*
> +	* If the branch to rebase is given, that is the branch we will rebase

Style: align asterisks.

> +	* branch_name -- branch/commit being rebased, or HEAD (already detached)
> +	* orig_head -- commit object name of tip of the branch before rebasing
> +	* head_name -- refs/heads/<that-branch> or "detached HEAD"
> +	*/
> +	if (argc > 1)
> +		 die ("TODO: handle switch_to");

Style: no SP between "die" and "("

