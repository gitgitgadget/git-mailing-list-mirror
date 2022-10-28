Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9343C38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 16:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiJ1QGa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 12:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiJ1QFl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 12:05:41 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7ED3AB00
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 09:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666973082; bh=blczZpbYckDZAlvawSzGwAfFdwYNp/g2C0SSIs/KihU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FUAa9NOlQFjLoM1jOUavoLuK4OLiHIYhGnUQ5eYkQ6mHqBF4jUfHH6s29SI0zqTWQ
         oGQjXF50itx/1/zY5aqQE0QzFJfbxJ+ufOcH5019z/gQxOjV0jgn1S88FOs24mb276
         kbSfCZmj6AoVFaMy+9OpkEW3jKs9ccIIux84BE1Mfpf37JWFBN9dt/rPyWrqW6sODX
         8rtpIvbh2+x6MsXCkWK18RwAYJCFCeq1cBMzBDHBOzonXHgVbru/cGATEY+V/vxjCm
         hCnIjpyhSOvgOnBgf1zSP/Tobmy+961meK1COn5Nd5Utlc83FD5OI66ZfzhD0VUb+6
         4kcyy3ehd3h5A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MEUSE-1oq2Xw2phK-00G38y; Fri, 28
 Oct 2022 18:04:42 +0200
Message-ID: <749f6adc-928a-0978-e3a1-2ede9f07def0@web.de>
Date:   Fri, 28 Oct 2022 18:04:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 0/8] run-command: remove run_command_v_*()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <221028.86edusan0k.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221028.86edusan0k.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gXOEI9UHEWl7fD30I6/kmsaPYkzqUTKsGKwfmqMsekT3v9EZwKp
 ffv82lebXhSP/lQ/K4zIfrsuu5nWnUArXRzVHYL2wpLr2o9KpOhdKIgM9XiuDee0c13S4Q3
 rWgECpzcr3UB7j36PEF2pQzA8RgUKmCJwVIYcJXL+STfKHJYeRjZuknOPqh0zNmil2A2qlV
 fBx+9m5znl8bN1MQlkmaQ==
UI-OutboundReport: notjunk:1;M01:P0:bg3zYwN11QM=;AlSMPS1rQTyn1icSv4JMIxziwiR
 9c7ZXsV52hHyUq+sb93TDVb8caurIeYaBZuNqYwzuekVm7DVE+cnNokCPuCqchqUKeVnKBESe
 bIm7Qv5X107klN76etap5BUMCCGXg+p2wga0Mey+v7Rf02BPPH/qVwLTjBhZB9jcA9CU5xn69
 3zvl1gR08G4q/1uzZjDj479wVZki06oSb44IX6kPcB0xQZMqQNmLIvvHCbFFYb7xbxIpLK7lm
 XxDekz6x3oYDBMc3E/4aMsk4yabcVzm/Bmm+GMQXtDz4pkK1YKLYImG3kOxzdsiaLiSyLvlMh
 i0/TQ6r2aYHg4yPMr6ohE8iPKO2w4Z5a/hgiDpaTpi8cHpwc/viHZWTLk3/E9LdbI0iBt5eS+
 BBihpafhBfvkIKfZfC7Imf2fG8JFhSBbxt4Y0cBNqCWzn3IATqkYcf8vpP906l3475CSc5cnI
 iWQfDT0RApALZ65gJiwbX86/A4ZYow2fDqKqudnmZVAeBGwNkstmEgHyLf+iHCbuQ2kNWOfUY
 0jzHG6HXUNS26B9PvIPDNIirG34sYDR+MgDKlP65xmlOBTJ0YnluYuw/wEDQqrMKRSCdbNO6u
 gjOFpeM1v/Jo79BItywuDWe5h/NvZwdmtuUCXijw/WJAIWxL3xoI/VDREuGuXO+hXYH658oxM
 LlIglIhNbRVIO8mGLCqYlte6HNoZ0HImdNDdS9trfaKrfACsC92vdvHq7CKRPQXiPlNXoNA46
 AzpQQDGipnfobg1uSch1j08XuUrUAO4qqaaWJk7gRvE+lt8gGFMVDbK3nmx+7xoRbQLR3lR0u
 /W/81F0YwQfgETJJ0vmgEcXo+MLnTM507ZSOscEA7037LsEbu6Ry1ZsFKs9j/afx0Nck2S3Is
 04w1bqeiiUSFw3INIH6+Z8b4/IuAhTM5x989veCX5UiX+srERJtSZHioMsCjAS7FIXRuUpALs
 40QnFSG6aIJG3H+ijr8fn5KcUPA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.10.22 um 23:46 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Thu, Oct 27 2022, Ren=C3=A9 Scharfe wrote:
>
>> Replace the convenience functions run_command_v_opt() et. al. and use
>> struct child_process and run_command() directly instead, for an overall
>> code reduction and a simpler and more flexible API that allows creating
>> argument lists without magic numbers and reduced risk of memory leaks.
>>
>> This is a broken-out and polished version of the original scratch at
>> https://lore.kernel.org/git/9d924a5d-5c72-fbe6-270c-a8f6c5fc5850@web.de=
/
>>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
>>   merge: remove always-the-same "verbose" arguments
>>
>> Ren=C3=A9 Scharfe (7):
>>   bisect--helper: factor out do_bisect_run()
>>   use child_process members "args" and "env" directly
>>   use child_process member "args" instead of string array variable
>>   replace and remove run_command_v_opt_cd_env()
>>   replace and remove run_command_v_opt_tr2()
>>   replace and remove run_command_v_opt_cd_env_tr2()
>>   replace and remove run_command_v_opt()
>
> Even though I had a an earlier alternate series series[1] for this I'd
> be happy to see this version go in. I left some comments here and there,
> but with/without a re-roll am happy to give this:
>
> 	Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> I think I would have just gone for this in the first place, but thought
> that people loved the convenience functions too much. It can be hard to
> judge sentiments in advance :)
>
> One reason I hadn't re-submitted something is that there were
> outstanding new conflicts with "seen", and I see from applying this
> topic & merging it that it conflicts somewhat heavily. Junio seems to be
> on-board with this though, so maybe he won't mind.
>
> I didn't see any glaring instances where this made things worse, so
> maybe we didn't need these convenience wrappers in the first place.

Right, and I think this is important.

>
> But from the earlier discussion it does seema bit like we tossed the
> very notion out because some didn't like the duplicating of struct
> members with the flags (which I also doen't like).
>
> So I came up with the below experiment on top, it's not an attempt to
> convert all callers, just a demo.
>
> Maybe you think some ideas here are worth using, I probably won't pursue
> it (but maybe as ideas for some other future API).
>
> It's a combination of stuff, some of which you might like, some not,
> namely:
>
> - Have the API work the same way, but just have a run_commandl(&opt,
>   ...) in addition to the run_command(). It's just a trivial wrapper to
>   push stuff into &cmd.args for you.
>
> - I saw a few callers that could have perhaps used a similarly trivial
>   run_commandv(), but that doesn't benefit from LAST_ARG_MUST_BE_NULL,
>   so I didn't bother.

I thought about that as well, but at least for me is probably a just a
case of loss aversion, which I have aplenty.  run_command_v_opt() alone
isn't bad and patch 8 on its own probably wouldn't fly, so I mentally
cling to it.  But without it the API is untangled and simpler.  Only a
single way to specify flags and arguments, no shortcuts for special
combinations.  Overall easier to use once we forget the old ways.

>
> - I wish C had a nicer syntax for not just declaring but squashing
>   together compile_time bracketed lists (think set operations). But the
>   below "CHILD_PROCESS_INIT_LIST" is a pretty good poor man's version.
>
>   I see gcc/clang nicely give us safety rails for that with
>   "-Woverride-init", for this sort of "opts struct with internal stuff,
>   but also user options" I think it works out very nicely.
>

That's a nice and simple macro.  I played with a gross variant =C3=A0 la

  #define CHILD_PROCESS_INIT_EX(...) { .args =3D STRVEC_INIT, __VA_ARGS__ =
}

which would allow e.g.

  struct child_process cmd =3D CHILD_PROCESS_INIT_EX(.git_cmd =3D 1);

Yours is better, but they share the downside of not actually saving any
lines of code..

> - We have quite a few callers that want "on error, die", so maybe we
>   should have something like that "on_error" sooner than later.

We could add a die_on_error bit for that, or start_command_or_die() and
run_command_or_die() variants (there I go again, multiplying APIs..).
They could report the failed command, which a caller can't do because
the internal strvec is already cleared once it learns of the failure.

>
> On clever (but perhaps overly clever) thing I didn't use, but played
> with recently in another context, is that now with C99 you can also do:
>
> 	int run_commandl(struct child_process *cmd, ...);
> 	#define run_command(...) run_command_1(__VA_ARGS__, NULL)
>
> I.e. make the API itself support all of:
>
> 	run_command(&cmd);
> 	run_command(&cmd, "reboot");
> 	run_command(&cmd, "reboot", NULL);
>
> I haven't made up my mind on whether that's just overly clever, or
> outright insane :)

Neither, I'd say.  By combining two operations it's less flexible than
a pure run method plus direct access to a strvec member.  It's a
shortcut that may save a line but requires more effort to extend its
callers, e.g. to conditionally add a new argument.

>
> diff --git a/bisect.c b/bisect.c
> index ec7487e6836..ef4f80650f7 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -740,9 +740,8 @@ enum bisect_error bisect_checkout(const struct objec=
t_id *bisect_rev,
>  		struct child_process cmd =3D CHILD_PROCESS_INIT;
>
>  		cmd.git_cmd =3D 1;
> -		strvec_pushl(&cmd.args, "checkout", "-q",
> -			     oid_to_hex(bisect_rev), "--", NULL);
> -		if (run_command(&cmd))
> +		if (run_commandl(&cmd, "checkout", "-q",
> +				 oid_to_hex(bisect_rev), "--", NULL))
>  			/*
>  			 * Errors in `run_command()` itself, signaled by res < 0,
>  			 * and errors in the child process, signaled by res > 0
> diff --git a/builtin/am.c b/builtin/am.c
> index 20aea0d2487..3b7df32ce22 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -2189,10 +2189,9 @@ static int show_patch(struct am_state *state, enu=
m show_patch_type sub_mode)
>  	if (!is_null_oid(&state->orig_commit)) {
>  		struct child_process cmd =3D CHILD_PROCESS_INIT;
>
> -		strvec_pushl(&cmd.args, "show", oid_to_hex(&state->orig_commit),
> -			     "--", NULL);
>  		cmd.git_cmd =3D 1;
> -		return run_command(&cmd);
> +		return run_commandl(&cmd, "show", oid_to_hex(&state->orig_commit),
> +				    "--", NULL);
>  	}
>
>  	switch (sub_mode) {
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 1d2ce8a0e12..087d21c614a 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -764,12 +764,12 @@ static enum bisect_error bisect_start(struct bisec=
t_terms *terms, const char **a
>  		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
>  		strbuf_trim(&start_head);
>  		if (!no_checkout) {
> -			struct child_process cmd =3D CHILD_PROCESS_INIT;
> -
> -			cmd.git_cmd =3D 1;
> -			strvec_pushl(&cmd.args, "checkout", start_head.buf,
> -				     "--", NULL);
> -			if (run_command(&cmd)) {
> +			struct child_process cmd =3D {
> +				CHILD_PROCESS_INIT_LIST,
> +				.git_cmd =3D 1,
> +			};
> +			if (run_commandl(&cmd, "checkout", start_head.buf,
> +					 "--", NULL)) {
>  				res =3D error(_("checking out '%s' failed."
>  						 " Try 'git bisect start "
>  						 "<valid-branch>'."),
> @@ -1147,8 +1147,7 @@ static int do_bisect_run(const char *command)
>
>  	printf(_("running %s\n"), command);
>  	cmd.use_shell =3D 1;
> -	strvec_push(&cmd.args, command);
> -	return run_command(&cmd);
> +	return run_commandl(&cmd, command, NULL);
>  }
>
>  static int verify_good(const struct bisect_terms *terms, const char *co=
mmand)
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 0e4348686b6..80d09e0fbf1 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -655,7 +655,6 @@ static int git_sparse_checkout_init(const char *repo=
)
>  {
>  	struct child_process cmd =3D CHILD_PROCESS_INIT;
>  	int result =3D 0;
> -	strvec_pushl(&cmd.args, "-C", repo, "sparse-checkout", "set", NULL);
>
>  	/*
>  	 * We must apply the setting in the current process
> @@ -664,7 +663,7 @@ static int git_sparse_checkout_init(const char *repo=
)
>  	core_apply_sparse_checkout =3D 1;
>
>  	cmd.git_cmd =3D 1;
> -	if (run_command(&cmd)) {
> +	if (run_commandl(&cmd, "-C", repo, "sparse-checkout", "set", NULL)) {
>  		error(_("failed to initialize sparse-checkout"));
>  		result =3D 1;
>  	}
> @@ -868,13 +867,14 @@ static void dissociate_from_references(void)
>  	char *alternates =3D git_pathdup("objects/info/alternates");
>
>  	if (!access(alternates, F_OK)) {
> -		struct child_process cmd =3D CHILD_PROCESS_INIT;
> -
> -		cmd.git_cmd =3D 1;
> -		cmd.no_stdin =3D 1;
> -		strvec_pushl(&cmd.args, "repack", "-a", "-d", NULL);
> -		if (run_command(&cmd))
> -			die(_("cannot repack to clean up"));
> +		struct child_process cmd =3D {
> +			CHILD_PROCESS_INIT_LIST,
> +			.git_cmd =3D 1,
> +			.no_stdin =3D 1,
> +			.on_error =3D CHILD_PROCESS_ON_ERROR_DIE,
> +		};
> +
> +		run_commandl(&cmd, "repack", "-a", "-d", NULL);
>  		if (unlink(alternates) && errno !=3D ENOENT)
>  			die_errno(_("cannot unlink temporary alternates file"));
>  	}
> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index d7f08c8a7fa..b4165b5a8ae 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -44,11 +44,12 @@ static int difftool_config(const char *var, const ch=
ar *value, void *cb)
>
>  static int print_tool_help(void)
>  {
> -	struct child_process cmd =3D CHILD_PROCESS_INIT;
> -
> -	cmd.git_cmd =3D 1;
> -	strvec_pushl(&cmd.args, "mergetool", "--tool-help=3Ddiff", NULL);
> -	return run_command(&cmd);
> +	struct child_process cmd =3D {
> +		CHILD_PROCESS_INIT_LIST,
> +		.git_cmd =3D 1,
> +	};
> +
> +	return run_commandl(&cmd, "mergetool", "--tool-help=3Ddiff", NULL);
>  }
>
>  static int parse_index_info(char *p, int *mode1, int *mode2,
> diff --git a/git.c b/git.c
> index 6662548986f..93179f44f78 100644
> --- a/git.c
> +++ b/git.c
> @@ -724,7 +724,13 @@ static void handle_builtin(int argc, const char **a=
rgv)
>
>  static void execv_dashed_external(const char **argv)
>  {
> -	struct child_process cmd =3D CHILD_PROCESS_INIT;
> +	struct child_process cmd =3D {
> +		CHILD_PROCESS_INIT_LIST,
> +		.clean_on_exit =3D 1,
> +		.wait_after_clean =3D 1,
> +		.silent_exec_failure =3D 1,
> +		.trace2_child_class =3D "dashed",
> +	};
>  	int status;
>
>  	if (get_super_prefix())
> @@ -736,10 +742,6 @@ static void execv_dashed_external(const char **argv=
)
>
>  	strvec_pushf(&cmd.args, "git-%s", argv[0]);
>  	strvec_pushv(&cmd.args, argv + 1);
> -	cmd.clean_on_exit =3D 1;
> -	cmd.wait_after_clean =3D 1;
> -	cmd.silent_exec_failure =3D 1;
> -	cmd.trace2_child_class =3D "dashed";
>
>  	trace2_cmd_name("_run_dashed_");
>
> diff --git a/run-command.c b/run-command.c
> index 23e100dffc4..4b20aa1b577 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -993,15 +993,45 @@ int finish_command_in_signal(struct child_process =
*cmd)
>
>  int run_command(struct child_process *cmd)
>  {
> -	int code;
> +	int starting =3D 1;
> +	int code =3D 0;
>
>  	if (cmd->out < 0 || cmd->err < 0)
>  		BUG("run_command with a pipe can cause deadlock");
>
>  	code =3D start_command(cmd);
>  	if (code)
> +		goto error;
> +	starting =3D 0;
> +	code =3D finish_command(cmd);
> +	if (!code)
> +		return 0;
> +error:
> +	switch (cmd->on_error) {
> +	case CHILD_PROCESS_ON_ERROR_DIE:
> +		die(starting ?
> +		    _("start_command() for '%s' failed (error code %d)") :
> +		    _("'%s': got non-zero exit code '%d'"),
> +		    cmd->args.v[0], code);
> +		break;
> +	case CHILD_PROCESS_ON_ERROR_RETURN:
>  		return code;
> -	return finish_command(cmd);
> +	default:
> +		BUG("unreachable");
> +	}
> +}
> +
> +int run_commandl(struct child_process *cmd, ...)
> +{
> +	va_list ap;
> +	const char *arg;
> +
> +	va_start(ap, cmd);
> +	while ((arg =3D va_arg(ap, const char *)))
> +		strvec_push(&cmd->args, arg);
> +	va_end(ap);
> +
> +	return run_command(cmd);
>  }
>
>  #ifndef NO_PTHREADS
> diff --git a/run-command.h b/run-command.h
> index fe2717ad11e..71e390350ed 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -15,7 +15,22 @@
>   * produces in the caller in order to process it.
>   */
>
> +enum child_process_on_error {
> +	/**
> +	 * Return a status code from run_command(). Set to 0 so that
> +	 * it'll be { 0 } init'd. If it's specified in a
> +	 * CHILD_PROCESS_INIT_LIST initialization we don't want a
> +	 * "-Woverride-init" warning.
> +	 */
> +	CHILD_PROCESS_ON_ERROR_RETURN =3D 0,
>
> +	/**
> +	 * die() with some sensible message if run_command() would
> +	 * have returned a non-zero exit code.
> +	 */
> +	CHILD_PROCESS_ON_ERROR_DIE,
> +};
> +
>  /**
>   * This describes the arguments, redirections, and environment of a
>   * command to run in a sub-process.
> @@ -42,6 +57,10 @@
>   *		redirected.
>   */
>  struct child_process {
> +	/**
> +	 * Error behavior, see "enum child_process_on_error" above.
> +	 */
> +	enum child_process_on_error on_error;
>
>  	/**
>  	 * The .args is a `struct strvec', use that API to manipulate
> @@ -144,10 +163,11 @@ struct child_process {
>  	void (*clean_on_exit_handler)(struct child_process *process);
>  };
>
> -#define CHILD_PROCESS_INIT { \
> +#define CHILD_PROCESS_INIT_LIST \
> +	/* .on_error =3D CHILD_PROCESS_ON_ERROR_RETURN */ \
>  	.args =3D STRVEC_INIT, \
> -	.env =3D STRVEC_INIT, \
> -}
> +	.env =3D STRVEC_INIT
> +#define CHILD_PROCESS_INIT { CHILD_PROCESS_INIT_LIST }
>
>  /**
>   * The functions: child_process_init, start_command, finish_command,
> @@ -218,6 +238,14 @@ int finish_command_in_signal(struct child_process *=
);
>   */
>  int run_command(struct child_process *);
>
> +/**
> + * Like run_command() but takes a variable number of arguments, which
> + * will be appended with the equivalent of strvec_pushl(&cmd.args,
> + * ...) before invoking run_command().
> + */
> +LAST_ARG_MUST_BE_NULL
> +int run_commandl(struct child_process *cmd, ...);
> +
>  /*
>   * Trigger an auto-gc
>   */
