Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A85CC433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 10:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C6C6101C
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 10:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241801AbhIFKLX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 06:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241751AbhIFKLW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 06:11:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A198C061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 03:10:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n5so8998187wro.12
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 03:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w8l7W0qIUZVITH+8XLWYA1GItwcvdb/1rnJC+yNnIgY=;
        b=PYktSo3bnNj8o1ycOALV+h92k/el17LHdtpK0LtIeTcjozuFM3pXjrMHJZn6ABYG/x
         jRlNS/ZzWQarNLCnTINL0yTI7QvslxWZhHjUHyuR4Tjg7tdgnLfhKbg2sHtWTXnOHUY0
         SX9acqztcOAI7wVf0QmiHO+RyAIkB35UwYPsqxb5Qlk3s+ETW4T2HVoCfbqSBpN8CIHp
         ySmwreqIAyG3IDioQhpjYU9A0B3/nKddhNHtrTuTeLH4yUu/SG+vcqN6UMkLygkMX4nJ
         e2JQvEuBccbirNn9A2panf6qKyfpKyQmpfpl6VpCu7Vbew3JE0gRIFEllkpo+ZNNd19W
         3FJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=w8l7W0qIUZVITH+8XLWYA1GItwcvdb/1rnJC+yNnIgY=;
        b=n9DJqI2JlirXTfIWxOrIhQnv+2zncgDycoBunRXGMzk0lxCP8w9jRsC0xIqoVPhjSN
         W4AV4+A452h+4Y0i0ABJ6eTKXhue3d4MOlQsJJBzUC/hohK+RmMv4/9OeBew1WiQy1cd
         bAxDL57mx7SpyqTxiuksshFCtyodhXZnhZymBnjS5pnWWN+Gd6ueZ9AGNIKkL27BiUxI
         QAWWLwxvuUai8/yvmoW7VNRQPLEywV28hkKOeZw1WRMW6BIPQA+dzPE6EmEbz1EEuzWq
         8xd8dWQWzpZtYjxKS4rbRKCa1piZuUIcatB/z4fXIGO7+EgJRPTXJEr6AkA2qsL4xSKc
         cXWQ==
X-Gm-Message-State: AOAM53124aY+5Yz9pVO/SuSvU23KHIYSkBU62sQNWUZHCIQ5OGXO3hq0
        RcmT8qbX5BZvKyggnJk3BZ8=
X-Google-Smtp-Source: ABdhPJy+jM4ToARbj86RzX03d/BbotmrsfVoHZP3HZ5TivViL5s5WDiBUJvyyjdejzqN0i4DDIf0tg==
X-Received: by 2002:a5d:58dc:: with SMTP id o28mr12058930wrf.399.1630923016891;
        Mon, 06 Sep 2021 03:10:16 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.254])
        by smtp.googlemail.com with ESMTPSA id a10sm7475829wrd.51.2021.09.06.03.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 03:10:16 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 7/7] rebase: drop the internal `rebase--interactive`
 command
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
 <4492cca369cdc0c8cd39b3dafab86d798cfbaa8f.1630497435.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <cf76b707-bd59-26f8-f257-02d773294495@gmail.com>
Date:   Mon, 6 Sep 2021 11:10:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <4492cca369cdc0c8cd39b3dafab86d798cfbaa8f.1630497435.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi dscho

Thanks for working on this, it opens up the possibility of future 
cleanups now we're not constrained by supporting cmd_rebase__interactive()

On 01/09/2021 12:57, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> [...]
> @@ -437,24 +362,6 @@ static int run_sequencer_rebase(struct rebase_options *opts,
>   
>   		break;
>   	}
> -	case ACTION_SHORTEN_OIDS:
> -	case ACTION_EXPAND_OIDS:
> -		ret = transform_todo_file(flags);
> -		break;
> -	case ACTION_CHECK_TODO_LIST:
> -		ret = check_todo_list_from_file(the_repository);
> -		break;
> -	case ACTION_REARRANGE_SQUASH:
> -		ret = rearrange_squash_in_todo_file();
> -		break;
> -	case ACTION_ADD_EXEC: {
> -		struct string_list commands = STRING_LIST_INIT_DUP;
> -
> -		split_exec_commands(opts->cmd, &commands);
> -		ret = add_exec_commands(&commands);
> -		string_list_clear(&commands, 0);
> -		break;
> -	}

As Alban mentioned, I think it would be worth removing the enum members 
as well as the case clauses here.

Best Wishes

Phillip

>   	default:
>   		BUG("invalid command '%d'", command);
>   	}
> @@ -476,98 +383,6 @@ static int parse_opt_keep_empty(const struct option *opt, const char *arg,
>   	return 0;
>   }
>   
> -static const char * const builtin_rebase_interactive_usage[] = {
> -	N_("git rebase--interactive [<options>]"),
> -	NULL
> -};
> -
> -int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
> -{
> -	struct rebase_options opts = REBASE_OPTIONS_INIT;
> -	struct object_id squash_onto = *null_oid();
> -	enum action command = ACTION_NONE;
> -	struct option options[] = {
> -		OPT_NEGBIT(0, "ff", &opts.flags, N_("allow fast-forward"),
> -			   REBASE_FORCE),
> -		OPT_CALLBACK_F('k', "keep-empty", &options, NULL,
> -			N_("keep commits which start empty"),
> -			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN,
> -			parse_opt_keep_empty),
> -		OPT_BOOL_F(0, "allow-empty-message", &opts.allow_empty_message,
> -			   N_("allow commits with empty messages"),
> -			   PARSE_OPT_HIDDEN),
> -		OPT_BOOL(0, "rebase-merges", &opts.rebase_merges, N_("rebase merge commits")),
> -		OPT_BOOL(0, "rebase-cousins", &opts.rebase_cousins,
> -			 N_("keep original branch points of cousins")),
> -		OPT_BOOL(0, "autosquash", &opts.autosquash,
> -			 N_("move commits that begin with squash!/fixup!")),
> -		OPT_BOOL(0, "signoff", &opts.signoff, N_("sign commits")),
> -		OPT_BIT('v', "verbose", &opts.flags,
> -			N_("display a diffstat of what changed upstream"),
> -			REBASE_NO_QUIET | REBASE_VERBOSE | REBASE_DIFFSTAT),
> -		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
> -			    ACTION_CONTINUE),
> -		OPT_CMDMODE(0, "skip", &command, N_("skip commit"), ACTION_SKIP),
> -		OPT_CMDMODE(0, "edit-todo", &command, N_("edit the todo list"),
> -			    ACTION_EDIT_TODO),
> -		OPT_CMDMODE(0, "show-current-patch", &command, N_("show the current patch"),
> -			    ACTION_SHOW_CURRENT_PATCH),
> -		OPT_CMDMODE(0, "shorten-ids", &command,
> -			N_("shorten commit ids in the todo list"), ACTION_SHORTEN_OIDS),
> -		OPT_CMDMODE(0, "expand-ids", &command,
> -			N_("expand commit ids in the todo list"), ACTION_EXPAND_OIDS),
> -		OPT_CMDMODE(0, "check-todo-list", &command,
> -			N_("check the todo list"), ACTION_CHECK_TODO_LIST),
> -		OPT_CMDMODE(0, "rearrange-squash", &command,
> -			N_("rearrange fixup/squash lines"), ACTION_REARRANGE_SQUASH),
> -		OPT_CMDMODE(0, "add-exec-commands", &command,
> -			N_("insert exec commands in todo list"), ACTION_ADD_EXEC),
> -		{ OPTION_CALLBACK, 0, "onto", &opts.onto, N_("onto"), N_("onto"),
> -		  PARSE_OPT_NONEG, parse_opt_commit, 0 },
> -		{ OPTION_CALLBACK, 0, "restrict-revision", &opts.restrict_revision,
> -		  N_("restrict-revision"), N_("restrict revision"),
> -		  PARSE_OPT_NONEG, parse_opt_commit, 0 },
> -		{ OPTION_CALLBACK, 0, "squash-onto", &squash_onto, N_("squash-onto"),
> -		  N_("squash onto"), PARSE_OPT_NONEG, parse_opt_object_id, 0 },
> -		{ OPTION_CALLBACK, 0, "upstream", &opts.upstream, N_("upstream"),
> -		  N_("the upstream commit"), PARSE_OPT_NONEG, parse_opt_commit,
> -		  0 },
> -		OPT_STRING(0, "head-name", &opts.head_name, N_("head-name"), N_("head name")),
> -		{ OPTION_STRING, 'S', "gpg-sign", &opts.gpg_sign_opt, N_("key-id"),
> -			N_("GPG-sign commits"),
> -			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> -		OPT_STRING(0, "strategy", &opts.strategy, N_("strategy"),
> -			   N_("rebase strategy")),
> -		OPT_STRING(0, "strategy-opts", &opts.strategy_opts, N_("strategy-opts"),
> -			   N_("strategy options")),
> -		OPT_STRING(0, "switch-to", &opts.switch_to, N_("switch-to"),
> -			   N_("the branch or commit to checkout")),
> -		OPT_STRING(0, "onto-name", &opts.onto_name, N_("onto-name"), N_("onto name")),
> -		OPT_STRING(0, "cmd", &opts.cmd, N_("cmd"), N_("the command to run")),
> -		OPT_RERERE_AUTOUPDATE(&opts.allow_rerere_autoupdate),
> -		OPT_BOOL(0, "reschedule-failed-exec", &opts.reschedule_failed_exec,
> -			 N_("automatically re-schedule any `exec` that fails")),
> -		OPT_END()
> -	};
> -
> -	opts.rebase_cousins = -1;
> -
> -	if (argc == 1)
> -		usage_with_options(builtin_rebase_interactive_usage, options);
> -
> -	argc = parse_options(argc, argv, prefix, options,
> -			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
> -
> -	if (!is_null_oid(&squash_onto))
> -		opts.squash_onto = &squash_onto;
> -
> -	if (opts.rebase_cousins >= 0 && !opts.rebase_merges)
> -		warning(_("--[no-]rebase-cousins has no effect without "
> -			  "--rebase-merges"));
> -
> -	return !!run_sequencer_rebase(&opts, command);
> -}
> -
>   static int is_merge(struct rebase_options *opts)
>   {
>   	return opts->type == REBASE_MERGE;
> diff --git a/git.c b/git.c
> index 18bed9a9964..268cdd82cfc 100644
> --- a/git.c
> +++ b/git.c
> @@ -577,7 +577,6 @@ static struct cmd_struct commands[] = {
>   	{ "range-diff", cmd_range_diff, RUN_SETUP | USE_PAGER },
>   	{ "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX},
>   	{ "rebase", cmd_rebase, RUN_SETUP | NEED_WORK_TREE },
> -	{ "rebase--interactive", cmd_rebase__interactive, RUN_SETUP | NEED_WORK_TREE },
>   	{ "receive-pack", cmd_receive_pack },
>   	{ "reflog", cmd_reflog, RUN_SETUP },
>   	{ "remote", cmd_remote, RUN_SETUP },
> 

