Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 838AF20282
	for <e@80x24.org>; Sun, 11 Jun 2017 21:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbdFKV1j (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Jun 2017 17:27:39 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:33982 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbdFKV1i (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2017 17:27:38 -0400
Received: by mail-wr0-f179.google.com with SMTP id g76so77578162wrd.1
        for <git@vger.kernel.org>; Sun, 11 Jun 2017 14:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sgiM9vxCTbSynUgJtpNi6ael+2SO30SFs2S0wk9xx6M=;
        b=DVg2Mbrnhn/1GJI2nX5zBE8qpqrhpVDYJ2U4hiB1+ughYjgszgWURrzx9r3oPBL1GW
         sHJyngXUzYgTh8s9+i+s/MzfOrSVXV73ZUFKvSTyK2MrAXvVoPB/yyW4b4UENHRgjHLG
         Gce8/SJkMSS++h20RYu+kiTqFDcPFJH21CdkbMg68tnr/4Cg4V1elbERUb7/VpNvGH8t
         sk6hMIZIaYSnViq591IVNctaLAu40He6hO+6pStU6mc5Sj/YetVeBnWAWUOusKZt8b66
         6ZxLohaYM7yeFq3UDJU7LyCkI6hHcrudEvOY5Ki+rJ4pzzGojIWC+s/N5afuNdj8yT0k
         TZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sgiM9vxCTbSynUgJtpNi6ael+2SO30SFs2S0wk9xx6M=;
        b=ZeD2THw670w7EH8KkyQzHt/gj9CxsRJYEGq7y5X1S0GigblEd7UnxeEHZsX7d8jV1H
         3FPIZ7qEGGhfrW5Db/RlA59BfHdn4/kDkqUY1ZfIEg1G+bdj/iBimUCioS1tDCrFQ8EM
         HHwz/2BVImZ15oErn5mnZHwQf6xNfcvU12Qe/s9X+9s0HGycT9PhHSu9NeoRL8gAwjbs
         gm5+qlkknzjWozSB8Ma+a2aRagvJUGUSnBgycPi3wn0zxXvREGw8Jrxp+YvgVBeS/Vs6
         3EHCwBIyLdGJr3i4VoC61PBn9HUTbpUH8Sqi89H/18TKA/k3R5GedE3LfBTjp6zzUnh7
         681Q==
X-Gm-Message-State: AODbwcC8egHYMHp5FN0v0JkWJOPBcI6K0hxeT8gulg1Eq8qbCGil0CG7
        mBev/IDpJO6qVw==
X-Received: by 10.28.23.9 with SMTP id 9mr5775618wmx.108.1497216456229;
        Sun, 11 Jun 2017 14:27:36 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id p65sm10637564wrb.64.2017.06.11.14.27.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Jun 2017 14:27:34 -0700 (PDT)
Date:   Sun, 11 Jun 2017 22:27:39 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 5/5] stash: implement builtin stash
Message-ID: <20170611212739.GA7737@hank>
References: <20170608005535.13080-1-joel@teichroeb.net>
 <20170608005535.13080-6-joel@teichroeb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170608005535.13080-6-joel@teichroeb.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/07, Joel Teichroeb wrote:
> Implement all git stash functionality as a builtin command
> 
> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
> ---

Thanks for working on this.  A few comments from me below.  Mainly on
stash push, as that's what I'm most familiar with, and all I had time
for today.  Hope it helps :)

>  Makefile                                      |    2 +-
>  builtin.h                                     |    1 +
>  builtin/stash.c                               | 1224 +++++++++++++++++++++++++
>  git-stash.sh => contrib/examples/git-stash.sh |    0
>  git.c                                         |    1 +
>  5 files changed, 1227 insertions(+), 1 deletion(-)
>  create mode 100644 builtin/stash.c
>  rename git-stash.sh => contrib/examples/git-stash.sh (100%)

[...]

> 
> +
> +static const char * const git_stash_usage[] = {
> +	N_("git stash list [<options>]"),
> +	N_("git stash show [<stash>]"),
> +	N_("git stash drop [-q|--quiet] [<stash>]"),
> +	N_("git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
> +	N_("git stash branch <branchname> [<stash>]"),
> +	N_("git stash [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]"),
> +	N_("                [-u|--include-untracked] [-a|--all] [<message>]]"),

This is missing the newly introduced push command.

> +	N_("git stash clear"),
> +	N_("git stash create [<message>]"),
> +	N_("git stash store [-m|--message <message>] [-q|--quiet] <commit>"),

create and store are not currently advertised in the usage.  I think
this is intentional, because those commands are intended to be used
only in scripts.  I don't have a particularly strong opinion on
whether they should be added or not, but if we do add them I think we
should do so consciously in a separate commit, instead of adding them
on in this commit.

> +	NULL
> +};
> +
> +static const char * const git_stash_list_usage[] = {
> +	N_("git stash list [<options>]"),
> +	NULL
> +};
> +
> +static const char * const git_stash_show_usage[] = {
> +	N_("git stash show [<stash>]"),
> +	NULL
> +};
> +
> +static const char * const git_stash_drop_usage[] = {
> +	N_("git stash drop [-q|--quiet] [<stash>]"),
> +	NULL
> +};
> +
> +static const char * const git_stash_pop_usage[] = {
> +	N_("git stash pop [--index] [-q|--quiet] [<stash>]"),
> +	NULL
> +};
> +
> +static const char * const git_stash_apply_usage[] = {
> +	N_("git stash apply [--index] [-q|--quiet] [<stash>]"),
> +	NULL
> +};
> +
> +static const char * const git_stash_branch_usage[] = {
> +	N_("git stash branch <branchname> [<stash>]"),
> +	NULL
> +};
> +
> +static const char * const git_stash_save_usage[] = {
> +	N_("git stash [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]"),
> +	N_("                [-u|--include-untracked] [-a|--all] [<message>]]"),
> +	NULL
> +};
> +
> +static const char * const git_stash_clear_usage[] = {
> +	N_("git stash clear"),
> +	NULL
> +};
> +
> +static const char * const git_stash_create_usage[] = {
> +	N_("git stash create [<message>]"),
> +	NULL
> +};
> +
> +static const char * const git_stash_store_usage[] = {
> +	N_("git stash store [-m|--message <message>] [-q|--quiet] <commit>"),
> +	NULL
> +};
> +

[...]

> +
> +static int do_push_stash(const char *prefix, const char *message,
> +	int keep_index, int include_untracked, int include_ignored, int patch,
> +	const char **argv)

argv here is a list of pathspecs.  I think this would be a bit easier
to follow if the argument was called "pathspecs".  

> +{
> +	int res;
> +	struct stash_info info;
> +
> +	if (patch && include_untracked)
> +		return error(_("can't use --patch and --include-untracked or --all at the same time"));
> +
> +	if (!include_untracked) {
> +		struct child_process cp = CHILD_PROCESS_INIT;
> +
> +		cp.git_cmd = 1;
> +		cp.no_stdout = 1;
> +		argv_array_pushl(&cp.args, "ls-files", "--error-unmatch", "--", NULL);
> +		if (argv)
> +			argv_array_pushv(&cp.args, argv);
> +		res = run_command(&cp);
> +		if (res)
> +			return 1;
> +	}
> +
> +	read_cache_preload(NULL);
> +	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
> +	if (check_no_changes(prefix, include_untracked, include_ignored, argv)) {
> +		printf_ln(_("No local changes to save"));
> +		return 0;
> +	}
> +
> +	if (!reflog_exists(ref_stash)) {
> +		if (do_clear_stash())
> +			return error(_("Cannot initialize stash"));
> +	}
> +
> +	if (do_create_stash(&info, prefix, message, include_untracked, include_ignored, patch, argv))
> +		return 1;
> +	res = do_store_stash(prefix, 1, info.message, info.w_commit);
> +
> +	if (res == 0 && !quiet)

Sometimes the function is used directly in the if, and sometimes the
res variable is used.  I think it would be nicer to consistently use
one or the other.  My preference would be to always use the functions
directly, as res is not used anywhere other than the if.

Also I think we prefer using (!res) instead of (res == 0) for checking
return values.

> +		printf(_("Saved working directory and index state %s"), info.message);
> +
> +	if (!patch) {
> +		if (argv && *argv) {
> +			struct argv_array args = ARGV_ARRAY_INIT;
> +			struct argv_array args2 = ARGV_ARRAY_INIT;
> +			struct child_process cp = CHILD_PROCESS_INIT;
> +			struct strbuf out = STRBUF_INIT;
> +			argv_array_pushl(&args, "reset", "--quiet", "--", NULL);
> +			argv_array_pushv(&args, argv);
> +			cmd_reset(args.argc, args.argv, prefix);
> +
> +			cp.git_cmd = 1;
> +			argv_array_pushl(&cp.args, "ls-files", "-z", "--modified", "--",
> +				NULL);
> +			argv_array_pushv(&cp.args, argv);
> +			pipe_command(&cp, NULL, 0, &out, 0, NULL, 0);
> +
> +			child_process_init(&cp);
> +			cp.git_cmd = 1;
> +			argv_array_pushl(&cp.args, "checkout-index", "-z", "--force",
> +				"--stdin", NULL);
> +			pipe_command(&cp, out.buf, out.len, NULL, 0, NULL, 0);
> +			strbuf_release(&out);
> +
> +			argv_array_pushl(&args2, "clean", "--force", "-d", "--quiet", "--",
> +				NULL);
> +			argv_array_pushv(&args2, argv);
> +			cmd_clean(args2.argc, args2.argv, prefix);
> +		} else {
> +			struct argv_array args = ARGV_ARRAY_INIT;
> +			argv_array_pushl(&args, "reset", "--hard", "--quiet", NULL);
> +			cmd_reset(args.argc, args.argv, prefix);
> +		}
> +
> +		if (include_untracked) {
> +			struct argv_array args = ARGV_ARRAY_INIT;
> +			argv_array_pushl(&args, "clean", "--force", "--quiet", "-d", NULL);
> +			if (include_ignored)
> +				argv_array_push(&args, "-x");
> +			argv_array_push(&args, "--");
> +			if (argv)
> +				argv_array_pushv(&args, argv);
> +			cmd_clean(args.argc, args.argv, prefix);
> +		}
> +
> +		if (keep_index) {
> +			struct child_process cp = CHILD_PROCESS_INIT;
> +			struct strbuf out = STRBUF_INIT;
> +
> +			reset_tree(info.i_tree, 0, 1);
> +
> +			cp.git_cmd = 1;
> +			argv_array_pushl(&cp.args, "ls-files", "-z", "--modified", "--",
> +				NULL);
> +			argv_array_pushv(&cp.args, argv);
> +			if (pipe_command(&cp, NULL, 0, &out, 0, NULL, 0))
> +				return 1;
> +
> +			child_process_init(&cp);
> +			cp.git_cmd = 1;
> +			argv_array_pushl(&cp.args, "checkout-index", "-z", "--force",
> +				"--stdin", NULL);
> +			if (pipe_command(&cp, out.buf, out.len, NULL, 0, NULL, 0))
> +				return 1;
> +			strbuf_release(&out);
> +		}
> +	} else {
> +		struct child_process cp = CHILD_PROCESS_INIT;
> +		cp.git_cmd = 1;
> +		argv_array_pushl(&cp.args, "apply", "-R", NULL);
> +		if (pipe_command(&cp, info.patch, strlen(info.patch), NULL, 0, NULL, 0))
> +			return error(_("Cannot remove worktree changes"));
> +
> +		if (!keep_index) {
> +			struct argv_array args = ARGV_ARRAY_INIT;
> +			argv_array_pushl(&args, "reset", "--quiet", "--", NULL);
> +			if (argv)
> +				argv_array_pushv(&args, argv);
> +			cmd_reset(args.argc, args.argv, prefix);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int push_stash(int argc, const char **argv, const char *prefix)
> +{
> +	const char *message = NULL;
> +	int include_untracked = 0;
> +	int include_ignored = 0;
> +	int patch = 0;
> +	int keep_index_set = -1;
> +	int keep_index = 0;
> +	struct option options[] = {
> +		OPT_BOOL('u', "include-untracked", &include_untracked,
> +			N_("stash untracked filed")),
> +		OPT_BOOL('a', "all", &include_ignored,
> +			N_("stash ignored untracked files")),
> +		OPT_BOOL('k', "keep-index", &keep_index_set,
> +			N_("restore the index after applying the stash")),
> +		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
> +		OPT_STRING('m', "message", &message, N_("message"),
> +			N_("stash commit message")),
> +		OPT_BOOL('p', "patch", &patch,
> +			N_("edit current diff and apply")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +				git_stash_save_usage, PARSE_OPT_STOP_AT_NON_OPTION);

"git_stash_save_usage" is slightly different from the usage for
push, which we should display here.  We probably should introduce
"git_stash_push_usage" for this.

> +	if (include_ignored)
> +		include_untracked = 1;
> +
> +	if (keep_index_set != -1)
> +		keep_index = keep_index_set;
> +	else if (patch)
> +		keep_index = 1;
> +
> +	return do_push_stash(prefix, message, keep_index, include_untracked, include_ignored, patch, argv);
> +}
> +

[...]

> +
> +int cmd_stash(int argc, const char **argv, const char *prefix)
> +{
> +	int result = 0;
> +	pid_t pid = getpid();
> +
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	git_config(git_default_config, NULL);
> +
> +	xsnprintf(stash_index_path, 64, ".git/index.stash.%d", pid);
> +
> +	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
> +		PARSE_OPT_KEEP_UNKNOWN|PARSE_OPT_KEEP_DASHDASH);
> +
> +	if (argc < 1) {
> +		result = do_push_stash(NULL, prefix, 0, 0, 0, 0, NULL);
> +	} else if (!strcmp(argv[0], "list"))
> +		result = list_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "show"))
> +		result = show_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "save"))
> +		result = save_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "push"))
> +		result = push_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "apply"))
> +		result = apply_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "clear"))
> +		result = clear_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "create"))
> +		result = create_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "store"))
> +		result = store_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "drop"))
> +		result = drop_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "pop"))
> +		result = pop_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "branch"))
> +		result = branch_stash(argc, argv, prefix);
> +	else {
> +		if (argv[0][0] == '-') {
> +			struct argv_array args = ARGV_ARRAY_INIT;
> +			argv_array_push(&args, "push");
> +			argv_array_pushv(&args, argv);
> +			result = push_stash(args.argc, args.argv, prefix);

This is a bit of a change in behaviour to what we currently have.

The rules we decided on are as follows:

 - "git stash -p" is an alias for "git stash push -p".
 - "git stash" with only option arguments is an alias for "git stash
   push" with those same arguments.  non-option arguments can be
   specified after a "--" for disambiguation.

The above makes "git stash -*" a alias for "git stash push -*".  This
would result in a change of behaviour, for example in the case where
someone would use "git stash -this is a test-".  In that case the
current behaviour is to create a stash with the message "-this is a
test-", while the above would end up making git stash error out.  The
discussion on how we came up with those rules can be found at
http://public-inbox.org/git/20170206161432.zvpsqegjspaa2l5l@sigill.intra.peff.net/. 

> +			if (!result)
> +				printf_ln(_("To restore them type \"git stash apply\""));

In the shell script this is only displayed when the stash_push in the
case where git stash is invoked with no arguments, not in the push
case if I read this correctly.  So the two lines above should go in
the (argc < 1) case I think.

> +		} else {
> +			error(_("unknown subcommand: %s"), argv[0]);

Currently we're displaying the whole usage string in this case.  I
think we should keep doing that.

> +			result = 1;
> +		}
> +	}
> +
> +	return result;
> +}
> diff --git a/git-stash.sh b/contrib/examples/git-stash.sh
> similarity index 100%
> rename from git-stash.sh
> rename to contrib/examples/git-stash.sh
> diff --git a/git.c b/git.c
> index 8ff44f081d..4531011cdc 100644
> --- a/git.c
> +++ b/git.c
> @@ -491,6 +491,7 @@ static struct cmd_struct commands[] = {
>  	{ "show-branch", cmd_show_branch, RUN_SETUP },
>  	{ "show-ref", cmd_show_ref, RUN_SETUP },
>  	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
> +	{ "stash", cmd_stash, RUN_SETUP | NEED_WORK_TREE },
>  	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
>  	{ "stripspace", cmd_stripspace },
>  	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX},
> -- 
> 2.13.0
> 
