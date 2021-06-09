Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C1FC48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 13:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B49066139A
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 13:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhFINIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 09:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFINIO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 09:08:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CACBC061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 06:06:05 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k5so1312117pjj.1
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 06:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WDLWgbIxidZe62yMvO8KReuK31LuPv4foKxGLIzPNXk=;
        b=H5tG4yt64RMV78R1kxe8UYnR83afYpJe+eOFwizr9/TevMZu5qH0z6xFmibhBi0G+V
         oNhC+VB9vkKmyIvkjpjWxZSyYCFOn1D2/w9IlPb65vLegpGfWSH8BJ3hB8Ehkfdf6VxT
         2t5GpzuKRlJKOtZLu5CyBPWZ+gC/nKbLpXzDJcF8Ai/77ntG2rCYjsrFbYf6QBN/KRy/
         tylB1qhRPf8DXUBjD42CQiN0RVXJARan9u5DvcX6IZVh6D8qqL0+sqeJur4FqvU4CTjv
         4UPE0bpEvb04mnAaj/9ER+4Lz8Rt6hB9pTd3oWxSt6F5LXn/5stceVEP4rpj9icFcHbV
         EWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WDLWgbIxidZe62yMvO8KReuK31LuPv4foKxGLIzPNXk=;
        b=S27apqhI+SWbt5TJhLJNVby8oxNnwYg/cIGj0bDXdRVUcIwzni/EtCBIs4vOz27rgM
         NJhhF55PgKwwjhMX+9Mx/mYg+y0wd4UjrgvLegsUyAL1idyTDIH78N6qR3zOvG0D8TzF
         KzocdPg5DwnOMlI0I7Car6ct/T+/O5i6ZD0FzMzpKx4VWF/gT4mGl2ZQQLyB/FEa1KZz
         ZjVwhePCmhwCkO/msIqgCOZgNHJOtGHKNSKoDkO8+xAyF6qZpN/NBr+lEzZNmIAZyjnf
         Xzafnp9Jfk7zwrrjb8jAsoW2nZp9/8BtCUEQWhJL0W3ai+pO+L3n2LizP6zyUv7f/Xaj
         lGMQ==
X-Gm-Message-State: AOAM533XErQgV8avAkt12HgZs/+3PYiePXFgjQB3ZrhWAQcM+G7Ql7G3
        yd4Hx3+EdbZhvdWI1cImEsY=
X-Google-Smtp-Source: ABdhPJybvA3SpeE3XJ0AC5r8lBlEAF2Ea1crwO/iLhQgDoiR9aZzitSaRsf/k1w+9lQKN7+k8N5lnA==
X-Received: by 2002:a17:902:b190:b029:105:cb55:3a7a with SMTP id s16-20020a170902b190b0290105cb553a7amr4949551plr.17.1623243964916;
        Wed, 09 Jun 2021 06:06:04 -0700 (PDT)
Received: from localhost ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id d24sm17453141pjv.49.2021.06.09.06.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 06:06:04 -0700 (PDT)
Date:   Wed, 9 Jun 2021 20:06:02 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [GSoC] [PATCH v2 1/2] submodule--helper: introduce add-clone
 subcommand
Message-ID: <YMC8upoajZm0QQ5G@danh.dev>
References: <20210605113913.29005-1-raykar.ath@gmail.com>
 <20210608095655.47324-1-raykar.ath@gmail.com>
 <20210608095655.47324-2-raykar.ath@gmail.com>
 <YL9jTFAoEBP+mDA2@danh.dev>
 <3B9B2CD5-2B99-4BF3-B348-5766F1CEB6D7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3B9B2CD5-2B99-4BF3-B348-5766F1CEB6D7@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-09 16:01:40+0530, Atharva Raykar <raykar.ath@gmail.com> wrote:
> On 08-Jun-2021, at 18:02, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> > 
> >> [...]
> >> +static char *get_next_line(char *const begin, const char *const end)
> >> +{
> >> +	char *pos = begin;
> >> +	while (pos != end && *pos++ != '\n');
> >> +	return pos;
> >> +}
> > 
> > On my first glance, this function looks like a reinvention of strchr(3).
> > Except that, this function also has a second parameter for "end".
> > Maybe it has a specical use-case?
> > 
> >> +
> >> +static void show_fetch_remotes(FILE *output, const char *sm_name, const char *git_dir_path)
> >> +{
> >> +	struct child_process cp_remote = CHILD_PROCESS_INIT;
> >> +	struct strbuf sb_remote_out = STRBUF_INIT;
> >> +
> >> +	cp_remote.git_cmd = 1;
> >> +	strvec_pushf(&cp_remote.env_array,
> >> +		     "GIT_DIR=%s", git_dir_path);
> >> +	strvec_push(&cp_remote.env_array, "GIT_WORK_TREE=.");
> >> +	strvec_pushl(&cp_remote.args, "remote", "-v", NULL);
> >> +	if (!capture_command(&cp_remote, &sb_remote_out, 0)) {
> >> +		char *line;
> >> +		char *begin = sb_remote_out.buf;
> >> +		char *end = sb_remote_out.buf + sb_remote_out.len;
> >> +		while (begin != end && (line = get_next_line(begin, end))) {
> > 
> > And this is the only use-case.  Because you also want to check if you
> > reached the last token or not.  I guess you really meant to write:
> > 
> > 	while ((line = strchr(begin, '\n')) != NULL) {
> > 
> > Anyway, I would name the "line" variable as "nextline"
> > 
> >> +			int namelen = 0, urllen = 0, taillen = 0;
> >> +			char *name = parse_token(&begin, line, &namelen);
> >> +			char *url = parse_token(&begin, line, &urllen);
> >> +			char *tail = parse_token(&begin, line, &taillen);
> >> +			if (!memcmp(tail, "(fetch)", 7))
> >> +				fprintf(output, "  %.*s\t%.*s\n",
> >> +					namelen, name, urllen, url);
> > 
> > I think this whole block is better replaced with strip_suffix_mem and
> > fprintf.
> > 
> > Overral I would replace the block inside capture_command with:
> > 
> > -----8<-----
> > 	char *nextline;
> > 	char *line = sb_remote_out.buf;
> > 	while ((nextline = strchr(line, '\n')) != NULL) {
> > 		size_t len = nextline - line;
> > 		if (strip_suffix_mem(line, &len, "(fetch)"))
> > 			fprintf(output, "  %.*s\n", (int)len, line);

Fix-up for my suggestion:

To be bug-for-bug with shell implementation, it should be:

		if (strip_suffix_mem(line, &len, " (fetch)"))

> > 		line = nextline + 1;
> > 	}
> > ---->8-----
> > 
> > And get rid of parse_token and get_next_line functions.
> 
> That looks much simpler. Thanks!
> 
> I realised that all the token parsing I do is not really necessary.
> What I really want to do is "If this line ends with '(fetch)',
> print it, but without the '(fetch)'", and I think your version
> captures that succinctly.
> 
> >> +		}
> >> +	}
> >> +
> >> +	strbuf_release(&sb_remote_out);
> >> +}
> >> +
> >> +static int add_submodule(const struct add_data *add_data)
> >> +{
> >> +	char *submod_gitdir_path;
> >> +	/* perhaps the path already exists and is already a git repo, else clone it */
> >> +	if (is_directory(add_data->sm_path)) {
> >> +		submod_gitdir_path = xstrfmt("%s/.git", add_data->sm_path);
> >> +		if (is_directory(submod_gitdir_path) || file_exists(submod_gitdir_path))
> >> +			printf(_("Adding existing path at '%s' to index\n"),
> >> +			       add_data->sm_path);
> >> +		else
> >> +			die(_("'%s' already exists and is not a valid git repo"),
> >> +			    add_data->sm_path);
> >> +		free(submod_gitdir_path);
> >> +	} else {
> >> +		struct strvec clone_args = STRVEC_INIT;
> >> +		struct child_process cp = CHILD_PROCESS_INIT;
> >> +		submod_gitdir_path = xstrfmt(".git/modules/%s", add_data->sm_name);
> >> +
> >> +		if (is_directory(submod_gitdir_path)) {
> >> +			if (!add_data->force) {
> >> +				error(_("A git directory for '%s' is found "
> >> +					"locally with remote(s):"), add_data->sm_name);
> > 
> > We don't capitalise first character of error message.
> > IOW, downcase "A git".
> 
> Got it.
> 
> > Well, it's bug-for-bug with shell implementation, so it doesn't matter much, anyway.
> 
> While it is meant to be a faithful implementation, I think this
> is a good opportunity to make minor style fixes.
> 
> >> +				show_fetch_remotes(stderr, add_data->sm_name,
> >> +						   submod_gitdir_path);
> >> +				fprintf(stderr,
> >> +					_("If you want to reuse this local git "
> >> +					  "directory instead of cloning again from\n"
> >> +					  "  %s\n"
> >> +					  "use the '--force' option. If the local git "
> >> +					  "directory is not the correct repo\n"
> >> +					  "or if you are unsure what this means, choose "
> >> +					  "another name with the '--name' option.\n"),
> >> +					add_data->realrepo);
> > 
> > Is there any reason we can't use "error" here?
> 
> The message in its entirety looks like this:
> 
> error: A git directory for 'test' is found locally with remote(s):
>   origin	git@github.com:tfidfwastaken/abc.git
> If you want to reuse this local git directory instead of cloning again from
>   git@github.com:tfidfwastaken/test.git
> use the '--force' option. If the local git directory is not the correct repo
> or if you are unsure what this means, choose another name with the '--name' option.
> 
> Since the 'error:' is already there in the first line, having it
> prepended before 'If you want to reuse...' felt redundant to me.
> 
> Besides, it's more of an informational message about what a user
> can do next, rather than a message that signifies an error.
> 
> If there is a preferred convention or label for such messages,
> I can use that. The shell version did not have any such thing though.
> 
> >> [...]
> >> +	struct option options[] = {
> >> +		OPT_STRING('b', "branch", &add_data.branch,
> >> +			   N_("branch"),
> >> +			   N_("branch of repository to checkout on cloning")),
> >> +		OPT_STRING(0, "prefix", &add_data.prefix,
> >> +			   N_("path"),
> >> +			   N_("alternative anchor for relative paths")),
> >> +		OPT_STRING(0, "path", &add_data.sm_path,
> >> +			   N_("path"),
> >> +			   N_("where the new submodule will be cloned to")),
> >> +		OPT_STRING(0, "name", &add_data.sm_name,
> >> +			   N_("string"),
> >> +			   N_("name of the new submodule")),
> >> +		OPT_STRING(0, "url", &add_data.realrepo,
> >> +			   N_("string"),
> >> +			   N_("url where to clone the submodule from")),
> >> +		OPT_STRING(0, "reference", &add_data.reference_path,
> >> +			   N_("repo"),
> >> +			   N_("reference repository")),
> >> +		OPT_BOOL(0, "dissociate", &dissociate,
> >> +			 N_("use --reference only while cloning")),
> >> +		OPT_INTEGER(0, "depth", &add_data.depth,
> >> +			    N_("depth for shallow clones")),
> >> +		OPT_BOOL(0, "progress", &progress,
> >> +			 N_("force cloning progress")),
> >> +		OPT_BOOL('f', "force", &force,
> >> +			 N_("allow adding an otherwise ignored submodule path")),
> > 
> > We have OPT__FORCE, too.
> 
> Will switch over to that.
> 
> >> +		OPT__QUIET(&quiet, "Suppress output for cloning a submodule"),
> > 
> > And, please downcase "Suppress".
> 
> OK.
> 
> >> +		OPT_END()
> >> +	};
> >> +
> >> +	const char *const usage[] = {
> >> +		N_("git submodule--helper add-clone [--prefix=<path>] [--quiet] [--force] "
> >> +		   "[--reference <repository>] [--depth <depth>] [-b|--branch <branch>]"
> >> +		   "[--progress] [--dissociate] --url <url> --path <path> --name <name>"),
> > 
> > I think it's too crowded here, I guess it's better to write:
> > 
> > 	N_("git submodule--helper add-clone [<options>...] --url <url> --path <path> --name <name>"),
> 
> OK. It shouldn't be an issue to shorten it, because this is not
> user-facing, and is only ever used within 'cmd_add()'.
> 
> >> +		NULL
> >> +	};
> >> +
> >> +	argc = parse_options(argc, argv, prefix, options, usage, 0);
> > 
> > From above usage, I think url, path, name is required, should we have a check for them, here?
> 
> We could. The reason why I was not too rigorous about this is
> because I plan to eliminate the shell interface for this helper
> eventually and call add-clone from within C, in the next few
> patches.
> 
> But this is a small ask, and I can just add a quick check just
> to be extra safe, so I'll do it.
> 
> >> +
> >> +	add_data.progress = !!progress;
> >> +	add_data.dissociate = !!dissociate;
> >> +	add_data.force = !!force;
> >> +	add_data.quiet = !!quiet;
> >> +
> >> +	if (add_submodule(&add_data))
> >> +		return 1;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> #define SUPPORT_SUPER_PREFIX (1<<0)
> >> 
> >> struct cmd_struct {
> >> @@ -2757,6 +2955,7 @@ static struct cmd_struct commands[] = {
> >> 	{"list", module_list, 0},
> >> 	{"name", module_name, 0},
> >> 	{"clone", module_clone, 0},
> >> +	{"add-clone", add_clone, 0},
> >> 	{"update-module-mode", module_update_module_mode, 0},
> >> 	{"update-clone", update_clone, 0},
> >> 	{"ensure-core-worktree", ensure_core_worktree, 0},
> >> diff --git a/git-submodule.sh b/git-submodule.sh
> >> index 4678378424..f71e1e5495 100755
> >> --- a/git-submodule.sh
> >> +++ b/git-submodule.sh
> >> @@ -241,43 +241,7 @@ cmd_add()
> >> 		die "$(eval_gettext "'$sm_name' is not a valid submodule name")"
> >> 	fi
> >> 
> >> -	# perhaps the path exists and is already a git repo, else clone it
> >> -	if test -e "$sm_path"
> >> -	then
> >> -		if test -d "$sm_path"/.git || test -f "$sm_path"/.git
> >> -		then
> >> -			eval_gettextln "Adding existing repo at '\$sm_path' to the index"
> >> -		else
> >> -			die "$(eval_gettext "'\$sm_path' already exists and is not a valid git repo")"
> >> -		fi
> >> -
> >> -	else
> >> -		if test -d ".git/modules/$sm_name"
> >> -		then
> >> -			if test -z "$force"
> >> -			then
> >> -				eval_gettextln >&2 "A git directory for '\$sm_name' is found locally with remote(s):"
> >> -				GIT_DIR=".git/modules/$sm_name" GIT_WORK_TREE=. git remote -v | grep '(fetch)' | sed -e s,^,"  ", -e s,' (fetch)',, >&2
> >> -				die "$(eval_gettextln "\
> >> -If you want to reuse this local git directory instead of cloning again from
> >> -  \$realrepo
> >> -use the '--force' option. If the local git directory is not the correct repo
> >> -or you are unsure what this means choose another name with the '--name' option.")"
> >> -			else
> >> -				eval_gettextln "Reactivating local git directory for submodule '\$sm_name'."
> >> -			fi
> >> -		fi
> >> -		git submodule--helper clone ${GIT_QUIET:+--quiet} ${progress:+"--progress"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${dissociate:+"--dissociate"} ${depth:+"$depth"} || exit
> >> -		(
> >> -			sanitize_submodule_env
> >> -			cd "$sm_path" &&
> >> -			# ash fails to wordsplit ${branch:+-b "$branch"...}
> >> -			case "$branch" in
> >> -			'') git checkout -f -q ;;
> >> -			?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
> >> -			esac
> >> -		) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
> >> -	fi
> >> +	git submodule--helper add-clone ${GIT_QUIET:+--quiet} ${force:+"--force"} ${progress:+"--progress"} ${branch:+--branch "$branch"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${dissociate:+"--dissociate"} ${depth:+"$depth"} || exit
> >> 	git config submodule."$sm_name".url "$realrepo"
> >> 
> >> 	git add --no-warn-embedded-repo $force "$sm_path" ||
> >> -- 
> >> 2.31.1
> >> 
> > 
> > -- 
> > Danh
> 
> Thanks for the comments!

-- 
Danh
