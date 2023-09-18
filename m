Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0866CD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 16:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjIRQHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjIRQHH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 12:07:07 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FDE3C27
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 09:05:28 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso74372561fa.3
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695053127; x=1695657927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D4upgN1N1fvxiZcFG2kiDaBnHhL5a43EsiQxWYxWGlA=;
        b=kavusP3jJk6Yj0CJbVAadDIdOp0Ein9Fwd0fcRzEiQniaAhNRMGcIT8UMLbT5XXkF/
         SZ6Rt7sfNS1UnKcM6OuiDUef/p6Kjm5apf1gweiLGGjbk3iLPN6HvK4lqNr0s8mVTPfU
         2JC5Q5RwES+dP+CcrL63MiR1/43UeM3Wmj7wwj5S78aHUxGq+U/o/JSqAZ2nSPyycwrh
         7j/xZtAQgV/ueYiksNwRGizHjDmE4OlbvmGERYoZhZqdSJ3izqc8Cbt0wrjIhnw0V19X
         OnLZFP3QMr0kPxtfLuaz2tVtGVPXatmNjoOgB8z/PZ8OBq8Qg1/l9u/kzO7j4GY0ijlE
         RhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053127; x=1695657927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4upgN1N1fvxiZcFG2kiDaBnHhL5a43EsiQxWYxWGlA=;
        b=l4pp3PXGNbjTLE6qm4ozRxJxAQkalJdXOH1Cx1Pm994L+7tk6Jxbz5XODoeiZilCBn
         tDnwQh8+Tcs/w+gEzpKG/lnF9VurMpp2mTeHFZAxid+VpZDoOGILdDTuUoU/0/siyAXT
         vFabh1DtLDJ6J8b5SejQxoOc4mxSFlKJ2yrMrL/i5D+XO/4yK2eEW5swqduy5bRGs0AD
         XTYqtutXc1Qduym/ffy2xWq+KG86osQUvx1prm42txF1xXHGSh9F2AR/BWEcQBsnB6kE
         frRLsE7eVw2vJOefZEG31M9Ayk94zZEm/8BnILf9Cyqo+pMGLOqP5HNGo1Lc70oBfyCh
         FjKA==
X-Gm-Message-State: AOJu0Yw1LeUawV17qR08hsRumGpv0YOACUwM67MdUwKdZ8a2fpz7Cuaq
        Lt9SxPqSiCkjmvbGI+JlmqgR2YjfWZnIBg==
X-Google-Smtp-Source: AGHT+IHB7bOOJ3xFMhjhCJyDWbagRRDjfX4XfHLlxFjLLd+1rVNu3Thn83QDrx+9rkTsZu1j22YVAw==
X-Received: by 2002:a05:6000:706:b0:321:5218:9434 with SMTP id bs6-20020a056000070600b0032152189434mr2634862wrb.3.1695044037598;
        Mon, 18 Sep 2023 06:33:57 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id e1-20020a5d65c1000000b0031984b370f2sm12704580wrw.47.2023.09.18.06.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 06:33:57 -0700 (PDT)
Message-ID: <0bf56c65-e59f-4290-8160-cce141f692d5@gmail.com>
Date:   Mon, 18 Sep 2023 14:33:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
Content-Language: en-US
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Git List <git@vger.kernel.org>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de> <ZP2X9roiaeEjzf24@ugly>
 <15530a5f-8d06-24c9-bc2d-e313c895f477@web.de>
 <20230912084029.GD1630538@coredump.intra.peff.net>
 <xmqqa5tmau6e.fsf@gitster.g> <6dc558c6-f78c-4d9c-8444-498de8e4d22a@web.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <6dc558c6-f78c-4d9c-8444-498de8e4d22a@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René

On 18/09/2023 10:28, René Scharfe wrote:
> Here's a version that preserves the enums by using additional int
> variables just for the parsing phase.  No tricks.  The diff is long, but
> most changes aren't particularly complicated and the resulting code is
> not that ugly.  Except for builtin/am.c perhaps, which changes the
> command mode value using a callback as well.
> 

> diff --git a/builtin/am.c b/builtin/am.c
> index 202040b62e..00930e2152 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -2270,13 +2270,14 @@ enum resume_type {
> 
>   struct resume_mode {
>   	enum resume_type mode;
> +	int mode_int;
>   	enum show_patch_type sub_mode;
>   };
> 
>   static int parse_opt_show_current_patch(const struct option *opt, const char *arg, int unset)
>   {
>   	int *opt_value = opt->value;
> -	struct resume_mode *resume = container_of(opt_value, struct resume_mode, mode);
> +	struct resume_mode *resume = container_of(opt_value, struct resume_mode, mode_int);
> 
>   	/*
>   	 * Please update $__git_showcurrentpatch in git-completion.bash
> @@ -2300,12 +2301,12 @@ static int parse_opt_show_current_patch(const struct option *opt, const char *ar
>   				     "--show-current-patch", arg);
>   	}
> 
> -	if (resume->mode == RESUME_SHOW_PATCH && new_value != resume->sub_mode)
> +	if (resume->mode_int == RESUME_SHOW_PATCH && new_value != resume->sub_mode)
>   		return error(_("options '%s=%s' and '%s=%s' "
>   					   "cannot be used together"),
>   					 "--show-current-patch", "--show-current-patch", arg, valid_modes[resume->sub_mode]);
> 
> -	resume->mode = RESUME_SHOW_PATCH;
> +	resume->mode_int = RESUME_SHOW_PATCH;
>   	resume->sub_mode = new_value;
>   	return 0;
>   }

Having "mode" and "mode_int" feels a bit fragile as only "mode_int" is 
valid while parsing the options but then we want to use "mode". I wonder 
if we could get Oswald's idea of using callbacks working in a reasonably 
ergonomic way with a couple of macros. We could add an new 
OPTION_SET_ENUM member to "enum parse_opt_type" that would take a setter 
function as well as the usual void *value. To set the value it would 
pass the value pointer and an integer value to the setter function. We 
could change OPT_CMDMODE to use OPTION_SET_ENUM and take the name of the 
enum as well as the integer value we want to set for that option. The 
name of the enum would be used to generate the name of the setter 
callback which would be defined with another macro. The macro to 
generate the setter would look like

#define MAKE_CMDMODE_SETTER(name) \
	static void parse_cmdmode_ ## name (void * var, int value) {
		enum name *p = var;
		*p = value;
	}

then OPT_CMDMODE would look like

#define OPT_CMDMODE_F(s, l, v, h, n, i, f) { \
	.type = OPTION_SET_ENUM, \
	.short_name = (s), \
	.long_name = (l), \
	.value = (v), \
	.help = (h), \
	.flags = PARSE_OPT_CMDMODE|PARSE_OPT_NOARG|PARSE_OPT_NONEG | (f), \
	.defval = (i), \
	.enum_setter = parse_cmdmode_ ## n,
}
#define OPT_CMDMODE(s, l, v, h, n, i)  OPT_CMDMODE_F(s, l, v, h, n, i, 0)


Then in builtin/am.c at the top level we'd add

MAKE_CMDMODE_SETTER(resume_type)

and change the option definitions to look like

OPT_CMDMODE(0, "continue", resume_type, &resume.mode, ...)


Best Wishes

Phillip

> @@ -2316,7 +2317,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>   	int binary = -1;
>   	int keep_cr = -1;
>   	int patch_format = PATCH_FORMAT_UNKNOWN;
> -	struct resume_mode resume = { .mode = RESUME_FALSE };
> +	struct resume_mode resume = { .mode_int = RESUME_FALSE };
>   	int in_progress;
>   	int ret = 0;
> 
> @@ -2387,27 +2388,27 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>   			PARSE_OPT_NOARG),
>   		OPT_STRING(0, "resolvemsg", &state.resolvemsg, NULL,
>   			N_("override error message when patch failure occurs")),
> -		OPT_CMDMODE(0, "continue", &resume.mode,
> +		OPT_CMDMODE(0, "continue", &resume.mode_int,
>   			N_("continue applying patches after resolving a conflict"),
>   			RESUME_RESOLVED),
> -		OPT_CMDMODE('r', "resolved", &resume.mode,
> +		OPT_CMDMODE('r', "resolved", &resume.mode_int,
>   			N_("synonyms for --continue"),
>   			RESUME_RESOLVED),
> -		OPT_CMDMODE(0, "skip", &resume.mode,
> +		OPT_CMDMODE(0, "skip", &resume.mode_int,
>   			N_("skip the current patch"),
>   			RESUME_SKIP),
> -		OPT_CMDMODE(0, "abort", &resume.mode,
> +		OPT_CMDMODE(0, "abort", &resume.mode_int,
>   			N_("restore the original branch and abort the patching operation"),
>   			RESUME_ABORT),
> -		OPT_CMDMODE(0, "quit", &resume.mode,
> +		OPT_CMDMODE(0, "quit", &resume.mode_int,
>   			N_("abort the patching operation but keep HEAD where it is"),
>   			RESUME_QUIT),
> -		{ OPTION_CALLBACK, 0, "show-current-patch", &resume.mode,
> +		{ OPTION_CALLBACK, 0, "show-current-patch", &resume.mode_int,
>   		  "(diff|raw)",
>   		  N_("show the patch being applied"),
>   		  PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
>   		  parse_opt_show_current_patch, RESUME_SHOW_PATCH },
> -		OPT_CMDMODE(0, "allow-empty", &resume.mode,
> +		OPT_CMDMODE(0, "allow-empty", &resume.mode_int,
>   			N_("record the empty patch as an empty commit"),
>   			RESUME_ALLOW_EMPTY),
>   		OPT_BOOL(0, "committer-date-is-author-date",
> @@ -2439,6 +2440,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>   		am_load(&state);
> 
>   	argc = parse_options(argc, argv, prefix, options, usage, 0);
> +	resume.mode = resume.mode_int;
> 
>   	if (binary >= 0)
>   		fprintf_ln(stderr, _("The -b/--binary option has been a no-op for long time, and\n"
> diff --git a/builtin/help.c b/builtin/help.c
> index dc1fbe2b98..d76f88d544 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -51,6 +51,7 @@ static enum help_action {
>   	HELP_ACTION_CONFIG_FOR_COMPLETION,
>   	HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
>   } cmd_mode;
> +static int cmd_mode_int;
> 
>   static const char *html_path;
>   static int verbose = 1;
> @@ -59,7 +60,7 @@ static int exclude_guides;
>   static int show_external_commands = -1;
>   static int show_aliases = -1;
>   static struct option builtin_help_options[] = {
> -	OPT_CMDMODE('a', "all", &cmd_mode, N_("print all available commands"),
> +	OPT_CMDMODE('a', "all", &cmd_mode_int, N_("print all available commands"),
>   		    HELP_ACTION_ALL),
>   	OPT_BOOL(0, "external-commands", &show_external_commands,
>   		 N_("show external commands in --all")),
> @@ -72,19 +73,19 @@ static struct option builtin_help_options[] = {
>   			HELP_FORMAT_INFO),
>   	OPT__VERBOSE(&verbose, N_("print command description")),
> 
> -	OPT_CMDMODE('g', "guides", &cmd_mode, N_("print list of useful guides"),
> +	OPT_CMDMODE('g', "guides", &cmd_mode_int, N_("print list of useful guides"),
>   		    HELP_ACTION_GUIDES),
> -	OPT_CMDMODE(0, "user-interfaces", &cmd_mode,
> +	OPT_CMDMODE(0, "user-interfaces", &cmd_mode_int,
>   		    N_("print list of user-facing repository, command and file interfaces"),
>   		    HELP_ACTION_USER_INTERFACES),
> -	OPT_CMDMODE(0, "developer-interfaces", &cmd_mode,
> +	OPT_CMDMODE(0, "developer-interfaces", &cmd_mode_int,
>   		    N_("print list of file formats, protocols and other developer interfaces"),
>   		    HELP_ACTION_DEVELOPER_INTERFACES),
> -	OPT_CMDMODE('c', "config", &cmd_mode, N_("print all configuration variable names"),
> +	OPT_CMDMODE('c', "config", &cmd_mode_int, N_("print all configuration variable names"),
>   		    HELP_ACTION_CONFIG),
> -	OPT_CMDMODE_F(0, "config-for-completion", &cmd_mode, "",
> +	OPT_CMDMODE_F(0, "config-for-completion", &cmd_mode_int, "",
>   		    HELP_ACTION_CONFIG_FOR_COMPLETION, PARSE_OPT_HIDDEN),
> -	OPT_CMDMODE_F(0, "config-sections-for-completion", &cmd_mode, "",
> +	OPT_CMDMODE_F(0, "config-sections-for-completion", &cmd_mode_int, "",
>   		    HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION, PARSE_OPT_HIDDEN),
> 
>   	OPT_END(),
> @@ -640,6 +641,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>   	argc = parse_options(argc, argv, prefix, builtin_help_options,
>   			builtin_help_usage, 0);
>   	parsed_help_format = help_format;
> +	cmd_mode = cmd_mode_int;
> 
>   	if (cmd_mode != HELP_ACTION_ALL &&
>   	    (show_external_commands >= 0 ||
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 209d2dc0d5..c64b38614a 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -346,7 +346,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>   	int i, full_tree = 0;
>   	int full_name = !prefix || !*prefix;
>   	read_tree_fn_t fn = NULL;
> -	enum ls_tree_cmdmode cmdmode = MODE_DEFAULT;
> +	enum ls_tree_cmdmode cmdmode;
> +	int cmdmode_int = MODE_DEFAULT;
>   	int null_termination = 0;
>   	struct ls_tree_options options = { 0 };
>   	const struct option ls_tree_options[] = {
> @@ -358,13 +359,13 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>   			LS_SHOW_TREES),
>   		OPT_BOOL('z', NULL, &null_termination,
>   			 N_("terminate entries with NUL byte")),
> -		OPT_CMDMODE('l', "long", &cmdmode, N_("include object size"),
> +		OPT_CMDMODE('l', "long", &cmdmode_int, N_("include object size"),
>   			    MODE_LONG),
> -		OPT_CMDMODE(0, "name-only", &cmdmode, N_("list only filenames"),
> +		OPT_CMDMODE(0, "name-only", &cmdmode_int, N_("list only filenames"),
>   			    MODE_NAME_ONLY),
> -		OPT_CMDMODE(0, "name-status", &cmdmode, N_("list only filenames"),
> +		OPT_CMDMODE(0, "name-status", &cmdmode_int, N_("list only filenames"),
>   			    MODE_NAME_STATUS),
> -		OPT_CMDMODE(0, "object-only", &cmdmode, N_("list only objects"),
> +		OPT_CMDMODE(0, "object-only", &cmdmode_int, N_("list only objects"),
>   			    MODE_OBJECT_ONLY),
>   		OPT_BOOL(0, "full-name", &full_name, N_("use full path names")),
>   		OPT_BOOL(0, "full-tree", &full_tree,
> @@ -384,6 +385,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>   	argc = parse_options(argc, argv, prefix, ls_tree_options,
>   			     ls_tree_usage, 0);
>   	options.null_termination = null_termination;
> +	cmdmode = cmdmode_int;
> 
>   	if (full_tree)
>   		prefix = NULL;
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 50cb85751f..6dbe57f0ac 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1061,6 +1061,7 @@ static int check_exec_cmd(const char *cmd)
>   int cmd_rebase(int argc, const char **argv, const char *prefix)
>   {
>   	struct rebase_options options = REBASE_OPTIONS_INIT;
> +	int action;
>   	const char *branch_name;
>   	int ret, flags, total_argc, in_progress = 0;
>   	int keep_base = 0;
> @@ -1116,18 +1117,18 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		OPT_BIT(0, "no-ff", &options.flags,
>   			N_("cherry-pick all commits, even if unchanged"),
>   			REBASE_FORCE),
> -		OPT_CMDMODE(0, "continue", &options.action, N_("continue"),
> +		OPT_CMDMODE(0, "continue", &action, N_("continue"),
>   			    ACTION_CONTINUE),
> -		OPT_CMDMODE(0, "skip", &options.action,
> +		OPT_CMDMODE(0, "skip", &action,
>   			    N_("skip current patch and continue"), ACTION_SKIP),
> -		OPT_CMDMODE(0, "abort", &options.action,
> +		OPT_CMDMODE(0, "abort", &action,
>   			    N_("abort and check out the original branch"),
>   			    ACTION_ABORT),
> -		OPT_CMDMODE(0, "quit", &options.action,
> +		OPT_CMDMODE(0, "quit", &action,
>   			    N_("abort but keep HEAD where it is"), ACTION_QUIT),
> -		OPT_CMDMODE(0, "edit-todo", &options.action, N_("edit the todo list "
> +		OPT_CMDMODE(0, "edit-todo", &action, N_("edit the todo list "
>   			    "during an interactive rebase"), ACTION_EDIT_TODO),
> -		OPT_CMDMODE(0, "show-current-patch", &options.action,
> +		OPT_CMDMODE(0, "show-current-patch", &action,
>   			    N_("show the patch file being applied or merged"),
>   			    ACTION_SHOW_CURRENT_PATCH),
>   		OPT_CALLBACK_F(0, "apply", &options, NULL,
> @@ -1233,10 +1234,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	if (options.type != REBASE_UNSPECIFIED)
>   		in_progress = 1;
> 
> +	action = options.action;
>   	total_argc = argc;
>   	argc = parse_options(argc, argv, prefix,
>   			     builtin_rebase_options,
>   			     builtin_rebase_usage, 0);
> +	options.action = action;
> 
>   	if (preserve_merges_selected)
>   		die(_("--preserve-merges was replaced by --rebase-merges\n"
> diff --git a/builtin/replace.c b/builtin/replace.c
> index da59600ad2..205c337ad3 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -554,12 +554,13 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
>   		MODE_CONVERT_GRAFT_FILE,
>   		MODE_REPLACE
>   	} cmdmode = MODE_UNSPECIFIED;
> +	int cmdmode_int = cmdmode;
>   	struct option options[] = {
> -		OPT_CMDMODE('l', "list", &cmdmode, N_("list replace refs"), MODE_LIST),
> -		OPT_CMDMODE('d', "delete", &cmdmode, N_("delete replace refs"), MODE_DELETE),
> -		OPT_CMDMODE('e', "edit", &cmdmode, N_("edit existing object"), MODE_EDIT),
> -		OPT_CMDMODE('g', "graft", &cmdmode, N_("change a commit's parents"), MODE_GRAFT),
> -		OPT_CMDMODE(0, "convert-graft-file", &cmdmode, N_("convert existing graft file"), MODE_CONVERT_GRAFT_FILE),
> +		OPT_CMDMODE('l', "list", &cmdmode_int, N_("list replace refs"), MODE_LIST),
> +		OPT_CMDMODE('d', "delete", &cmdmode_int, N_("delete replace refs"), MODE_DELETE),
> +		OPT_CMDMODE('e', "edit", &cmdmode_int, N_("edit existing object"), MODE_EDIT),
> +		OPT_CMDMODE('g', "graft", &cmdmode_int, N_("change a commit's parents"), MODE_GRAFT),
> +		OPT_CMDMODE(0, "convert-graft-file", &cmdmode_int, N_("convert existing graft file"), MODE_CONVERT_GRAFT_FILE),
>   		OPT_BOOL_F('f', "force", &force, N_("replace the ref if it exists"),
>   			   PARSE_OPT_NOCOMPLETE),
>   		OPT_BOOL(0, "raw", &raw, N_("do not pretty-print contents for --edit")),
> @@ -572,6 +573,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
> 
>   	argc = parse_options(argc, argv, prefix, options, git_replace_usage, 0);
> 
> +	cmdmode = cmdmode_int;
>   	if (!cmdmode)
>   		cmdmode = argc ? MODE_REPLACE : MODE_LIST;
> 
> diff --git a/builtin/stripspace.c b/builtin/stripspace.c
> index 7b700a9fb1..e8efa0e7ac 100644
> --- a/builtin/stripspace.c
> +++ b/builtin/stripspace.c
> @@ -33,13 +33,14 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
>   {
>   	struct strbuf buf = STRBUF_INIT;
>   	enum stripspace_mode mode = STRIP_DEFAULT;
> +	int mode_int = mode;
>   	int nongit;
> 
>   	const struct option options[] = {
> -		OPT_CMDMODE('s', "strip-comments", &mode,
> +		OPT_CMDMODE('s', "strip-comments", &mode_int,
>   			    N_("skip and remove all lines starting with comment character"),
>   			    STRIP_COMMENTS),
> -		OPT_CMDMODE('c', "comment-lines", &mode,
> +		OPT_CMDMODE('c', "comment-lines", &mode_int,
>   			    N_("prepend comment character and space to each line"),
>   			    COMMENT_LINES),
>   		OPT_END()
> @@ -49,6 +50,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
>   	if (argc)
>   		usage_with_options(stripspace_usage, options);
> 
> +	mode = mode_int;
>   	if (mode == STRIP_COMMENTS || mode == COMMENT_LINES) {
>   		setup_git_directory_gently(&nongit);
>   		git_config(git_default_config, NULL);
> diff --git a/parse-options.h b/parse-options.h
> index 5e7475bd2d..349c3fca04 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -262,7 +262,7 @@ struct option {
>   	.type = OPTION_SET_INT, \
>   	.short_name = (s), \
>   	.long_name = (l), \
> -	.value = (v), \
> +	.value_int = (v), \
>   	.help = (h), \
>   	.flags = PARSE_OPT_CMDMODE|PARSE_OPT_NOARG|PARSE_OPT_NONEG | (f), \
>   	.defval = (i), \
> --
> 2.42.0

