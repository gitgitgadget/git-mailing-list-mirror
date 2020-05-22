Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F8DC433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 10:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD86A2072C
	for <git@archiver.kernel.org>; Fri, 22 May 2020 10:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHanN7Op"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgEVK1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 06:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgEVK1r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 06:27:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC30C061A0E
        for <git@vger.kernel.org>; Fri, 22 May 2020 03:27:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g12so8450150wrw.1
        for <git@vger.kernel.org>; Fri, 22 May 2020 03:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=BBajqcr36cb8WZEGXKxoMb4MrhoagJH5k04bckQdvH8=;
        b=DHanN7OpPT+MpzGPqws6mae+ezDvQAK4DHWOSwAF63R7vEdmbS4D20NO743kSJbuky
         aj1XkWhhjdM3R9nJrCWTbCYNQAleNaXdLBcOZ8NQWWcpcAt49sRS5rcZeapcEYHxYLCi
         HNHNN3yyI6ICBccju0//GiaFJAjZtYZX9f1mczzCMhFX1cPf61M1jIhRLNbYrcE90lcD
         HjLm+0+b30S5N8sR58x6wdVrklYQ2m+7G6dGrRSyOPF+gOVFpmF3fr1IuBz+KNvftfnx
         Pr5+K/3KQc7ZXaAGUS8m6W4WqmLuhiPSQbnK9vSiUIApqQNe7RP7i+ypkHdaeuxBdOZj
         HSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BBajqcr36cb8WZEGXKxoMb4MrhoagJH5k04bckQdvH8=;
        b=pXdubccxzFSALdEqrWihTSZ53lDE8Ar2yxcPRuO+aUF9uNIahHazHBfonR1FLRV0ge
         yBC+qhuVHPer9VS0ytpmo+Hd57PeJfwK9JXSqt13eluPJTjht58Yorg7YnGJKyVNgyIO
         khdlvOQJnTVVEaU6ciW2C6Civu3/A6SH+c00tTrzWfovlfC88mj355Vy2MasJFHRK0aZ
         qK/wiloJwyQ3ymccwzVmt/I6373tp+FJOoe2rCoX0tU/elBiFtTGHq9USHXCsQh0w5N0
         A8X4MLTNo+E9/QZDdxpKfolaA3/hUPynMXCmEFw5IE1+wsO0YxX2b7T1tq3fkxldLky9
         PEnw==
X-Gm-Message-State: AOAM533LQOP4nC2VR9u8M1D8APJgfdU97RjMwhzQ5zoaUaAtj/gMPJ3S
        13960IqemoZzhKMAmg9VF06uxuyc
X-Google-Smtp-Source: ABdhPJx3GQhtBrSLwZMihBIPt3E/VhU9RXRG+mOiqTJm4nSmisFrZOGAOFdpra+v8vNEvRoEbV3QVg==
X-Received: by 2002:a5d:514f:: with SMTP id u15mr3071880wrt.132.1590143265333;
        Fri, 22 May 2020 03:27:45 -0700 (PDT)
Received: from [192.168.1.201] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.googlemail.com with ESMTPSA id s67sm9351921wmf.3.2020.05.22.03.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 03:27:44 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] hook: add list command
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20200521185414.43760-1-emilyshaffer@google.com>
 <20200521185414.43760-4-emilyshaffer@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <41e4fcf3-5d39-71a2-35b2-ee143cd59033@gmail.com>
Date:   Fri, 22 May 2020 11:27:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521185414.43760-4-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily

On 21/05/2020 19:54, Emily Shaffer wrote:
> Teach 'git hook list <hookname>', which checks the known configs in
> order to create an ordered list of hooks to run on a given hook event.
> 
> Multiple commands can be specified for a given hook by providing
> multiple "hook.<hookname>.command = <path-to-hook>" lines. Hooks will be
> run in config order. If more properties need to be set on a given hook
> in the future, commands can also be specified by providing
> "hook.<hookname>.command = <hookcmd-name>", as well as a "[hookcmd
> <hookcmd-name>]" subsection; at minimum, this subsection must contain a
> "hookcmd.<hookcmd-name>.command = <path-to-hook>" line.
> 
> For example:
> 
>   $ git config --list | grep ^hook
>   hook.pre-commit.command=baz
>   hook.pre-commit.command=~/bar.sh
>   hookcmd.baz.command=~/baz/from/hookcmd.sh
> 
>   $ git hook list pre-commit
>   ~/baz/from/hookcmd.sh
>   ~/bar.sh
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  Documentation/git-hook.txt    | 37 +++++++++++++-
>  Makefile                      |  1 +
>  builtin/hook.c                | 55 +++++++++++++++++++--
>  hook.c                        | 90 +++++++++++++++++++++++++++++++++++
>  hook.h                        | 15 ++++++
>  t/t1360-config-based-hooks.sh | 51 +++++++++++++++++++-
>  6 files changed, 242 insertions(+), 7 deletions(-)
>  create mode 100644 hook.c
>  create mode 100644 hook.h
> 
> diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
> index 2d50c414cc..e458586e96 100644
> --- a/Documentation/git-hook.txt
> +++ b/Documentation/git-hook.txt
> @@ -8,12 +8,47 @@ git-hook - Manage configured hooks
>  SYNOPSIS
>  --------
>  [verse]
> -'git hook'
> +'git hook' list <hook-name>
>  
>  DESCRIPTION
>  -----------
>  You can list, add, and modify hooks with this command.
>  
> +This command parses the default configuration files for sections "hook" and
> +"hookcmd". "hook" is used to describe the commands which will be run during a
> +particular hook event; commands are run in config order. "hookcmd" is used to
> +describe attributes of a specific command. If additional attributes don't need
> +to be specified, a command to run can be specified directly in the "hook"
> +section; if a "hookcmd" by that name isn't found, Git will attempt to run the
> +provided value directly. For example:
> +
> +Global config
> +----
> +  [hook "post-commit"]
> +    command = "linter"
> +    command = "~/typocheck.sh"
> +
> +  [hookcmd "linter"]
> +    command = "/bin/linter --c"
> +----
> +
> +Local config
> +----
> +  [hook "prepare-commit-msg"]
> +    command = "linter"
> +  [hook "post-commit"]
> +    command = "python ~/run-test-suite.py"
> +----
> +
> +COMMANDS
> +--------
> +
> +list <hook-name>::
> +
> +List the hooks which have been configured for <hook-name>. Hooks appear
> +in the order they should be run, and note the config scope where the relevant
> +`hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable).
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/Makefile b/Makefile
> index fce6ee154e..b7bbf3be7b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -894,6 +894,7 @@ LIB_OBJS += grep.o
>  LIB_OBJS += hashmap.o
>  LIB_OBJS += help.o
>  LIB_OBJS += hex.o
> +LIB_OBJS += hook.o
>  LIB_OBJS += ident.o
>  LIB_OBJS += interdiff.o
>  LIB_OBJS += json-writer.o
> diff --git a/builtin/hook.c b/builtin/hook.c
> index b2bbc84d4d..cfd8e388bd 100644
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -1,21 +1,68 @@
>  #include "cache.h"
>  
>  #include "builtin.h"
> +#include "config.h"
> +#include "hook.h"
>  #include "parse-options.h"
> +#include "strbuf.h"
>  
>  static const char * const builtin_hook_usage[] = {
> -	N_("git hook"),
> +	N_("git hook list <hookname>"),
>  	NULL
>  };
>  
> -int cmd_hook(int argc, const char **argv, const char *prefix)
> +static int list(int argc, const char **argv, const char *prefix)
>  {
> -	struct option builtin_hook_options[] = {
> +	struct list_head *head, *pos;
> +	struct hook *item;
> +	struct strbuf hookname = STRBUF_INIT;
> +
> +	struct option list_options[] = {
>  		OPT_END(),
>  	};
>  
> -	argc = parse_options(argc, argv, prefix, builtin_hook_options,
> +	argc = parse_options(argc, argv, prefix, list_options,
>  			     builtin_hook_usage, 0);
>  
> +	if (argc < 1) {
> +		usage_msg_opt("a hookname must be provided to operate on.",
> +			      builtin_hook_usage, list_options);
> +	}
> +
> +	strbuf_addstr(&hookname, argv[0]);
> +
> +	head = hook_list(&hookname);
> +
> +	if (!head) {
> +		printf(_("no commands configured for hook '%s'\n"),
> +		       hookname.buf);
> +		return 0;
> +	}
> +
> +	list_for_each(pos, head) {
> +		item = list_entry(pos, struct hook, list);
> +		if (item)
> +			printf("%s:\t%s\n",
> +			       config_scope_name(item->origin),
> +			       item->command.buf);
> +	}
> +
> +	clear_hook_list();
> +	strbuf_release(&hookname);
> +
>  	return 0;
>  }
> +
> +int cmd_hook(int argc, const char **argv, const char *prefix)
> +{
> +	struct option builtin_hook_options[] = {
> +		OPT_END(),
> +	};
> +	if (argc < 2)
> +		usage_with_options(builtin_hook_usage, builtin_hook_options);
> +
> +	if (!strcmp(argv[1], "list"))
> +		return list(argc - 1, argv + 1, prefix);
> +
> +	usage_with_options(builtin_hook_usage, builtin_hook_options);
> +}
> diff --git a/hook.c b/hook.c
> new file mode 100644
> index 0000000000..9dfc1a885e
> --- /dev/null
> +++ b/hook.c
> @@ -0,0 +1,90 @@
> +#include "cache.h"
> +
> +#include "hook.h"
> +#include "config.h"
> +
> +static LIST_HEAD(hook_head);
> +
> +void free_hook(struct hook *ptr)
> +{
> +	if (ptr) {
> +		strbuf_release(&ptr->command);
> +		free(ptr);
> +	}
> +}
> +
> +static void emplace_hook(struct list_head *pos, const char *command)
> +{
> +	struct hook *to_add = malloc(sizeof(struct hook));
> +	to_add->origin = current_config_scope();
> +	strbuf_init(&to_add->command, 0);
> +	strbuf_addstr(&to_add->command, command);
> +
> +	list_add_tail(&to_add->list, pos);
> +}
> +
> +static void remove_hook(struct list_head *to_remove)
> +{
> +	struct hook *hook_to_remove = list_entry(to_remove, struct hook, list);
> +	list_del(to_remove);
> +	free_hook(hook_to_remove);
> +}
> +
> +void clear_hook_list(void)
> +{
> +	struct list_head *pos, *tmp;
> +	list_for_each_safe(pos, tmp, &hook_head)
> +		remove_hook(pos);
> +}
> +
> +static int hook_config_lookup(const char *key, const char *value, void *hook_key_cb)
> +{
> +	const char *hook_key = hook_key_cb;
> +
> +	if (!strcmp(key, hook_key)) {
> +		const char *command = value;
> +		struct strbuf hookcmd_name = STRBUF_INIT;
> +		struct list_head *pos = NULL, *tmp = NULL;
> +
> +		/* Check if a hookcmd with that name exists. */
> +		strbuf_addf(&hookcmd_name, "hookcmd.%s.command", command);
> +		git_config_get_value(hookcmd_name.buf, &command);

This looks dodgy to me. This code is called by git_config() as it parses
the config files, so it has not had a chance to fully populate the
config cache used by git_config_get_value(). I think the test below
passes because the hookcmd setting is set in the global file and the
hook setting is set in the local file so when we have already parsed the
hookcmd setting when we come to look it up. The same comment applies to
the hypothetical ordering config mentioned below. I think it would be
better to collect the list of hook.<event>.command settings in this
callback and then look up any hookcmd settings for those hook commands
after we've finished reading all of the config files.

> +
> +		if (!command)
> +			BUG("git_config_get_value overwrote a string it shouldn't have");
> +
> +		/*
> +		 * TODO: implement an option-getting callback, e.g.
> +		 *   get configs by pattern hookcmd.$value.*
> +		 *   for each key+value, do_callback(key, value, cb_data)
> +		 */
> +
> +		list_for_each_safe(pos, tmp, &hook_head) {
> +			struct hook *hook = list_entry(pos, struct hook, list);
> +			/*
> +			 * The list of hooks to run can be reordered by being redeclared
> +			 * in the config. Options about hook ordering should be checked
> +			 * here.
> +			 */
> +			if (0 == strcmp(hook->command.buf, command))
> +				remove_hook(pos);
> +		}
> +		emplace_hook(pos, command);
> +	}
> +
> +	return 0;
> +}
> +
> +struct list_head* hook_list(const struct strbuf* hookname)
> +{
> +	struct strbuf hook_key = STRBUF_INIT;
> +
> +	if (!hookname)
> +		return NULL;
> +
> +	strbuf_addf(&hook_key, "hook.%s.command", hookname->buf);
> +
> +	git_config(hook_config_lookup, (void*)hook_key.buf);
> +
> +	return &hook_head;
> +}
> diff --git a/hook.h b/hook.h
> new file mode 100644
> index 0000000000..aaf6511cff
> --- /dev/null
> +++ b/hook.h
> @@ -0,0 +1,15 @@
> +#include "config.h"
> +#include "list.h"
> +#include "strbuf.h"
> +
> +struct hook
> +{
> +	struct list_head list;
> +	enum config_scope origin;
> +	struct strbuf command;
> +};
> +
> +struct list_head* hook_list(const struct strbuf *hookname);
> +
> +void free_hook(struct hook *ptr);
> +void clear_hook_list(void);
> diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
> index 34b0df5216..4e46d7dd4e 100755
> --- a/t/t1360-config-based-hooks.sh
> +++ b/t/t1360-config-based-hooks.sh
> @@ -4,8 +4,55 @@ test_description='config-managed multihooks, including git-hook command'
>  
>  . ./test-lib.sh
>  
> -test_expect_success 'git hook command does not crash' '
> -	git hook
> +test_expect_success 'git hook rejects commands without a mode' '
> +	test_must_fail git hook pre-commit
> +'
> +
> +
> +test_expect_success 'git hook rejects commands without a hookname' '
> +	test_must_fail git hook list
> +'
> +
> +test_expect_success 'setup hooks in global, and local' '
> +	git config --add --local hook.pre-commit.command "/path/ghi" &&

Can I make a plea for the use of test_config please. Writing tests which
rely on previous tests for their set-up creates a chain of hidden
dependencies that make it hard to add/alter tests later or run a subset
of the tests when developing a new patch. t3404-rebase-interactive.sh is
a prime example of this and I dread touching it.

> +	git config --add --global hook.pre-commit.command "/path/def"
> +'
> +
> +test_expect_success 'git hook list orders by config order' '
> +	cat >expected <<-\EOF &&
> +	global:	/path/def
> +	local:	/path/ghi
> +	EOF
> +
> +	git hook list pre-commit >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'git hook list dereferences a hookcmd' '
> +	git config --add --local hook.pre-commit.command "abc" &&
> +	git config --add --global hookcmd.abc.command "/path/abc" &&
> +
> +	cat >expected <<-\EOF &&
> +	global:	/path/def
> +	local:	/path/ghi
> +	local:	/path/abc

We should make it clear in the documentation that the config origin
applies to the hook setting, even though we display the hookcmd command
which is set globally here for the last hook.

Best Wishes

Phillip

> +	EOF
> +
> +	git hook list pre-commit >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'git hook list reorders on duplicate commands' '
> +	git config --add --local hook.pre-commit.command "/path/def" &&
> +
> +	cat >expected <<-\EOF &&
> +	local:	/path/ghi
> +	local:	/path/abc
> +	local:	/path/def
> +	EOF
> +
> +	git hook list pre-commit >actual &&
> +	test_cmp expected actual
>  '
>  
>  test_done
> 

