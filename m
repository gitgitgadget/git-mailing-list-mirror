Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 234121F516
	for <e@80x24.org>; Thu, 21 Jun 2018 22:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933624AbeFUWDc (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 18:03:32 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38320 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933559AbeFUWDb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 18:03:31 -0400
Received: by mail-wr0-f194.google.com with SMTP id e18-v6so4684768wrs.5
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 15:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9lTeJV+JzJUZ3iP+tZ1netyM+JcI+PTjkHGi+NVg330=;
        b=uLtdaAK/8BD/H6nm3ggM0rFjCvJYw+zeDaDr8a0MesCHgQPVo54jnQxM5Y4TvqWcN9
         ljvVbK2z8wWAoTPHX/elB5FDp19xBH3tNE/c5bezvvuVFlf0wz78TlJOJeTdcom/OpSi
         rgUb74yGI3GZW7zzALRRsAeet4nk4B+GH+MB3maK5T8eUT9yddMlqIMl/QfpdTiYrY+M
         aovsTvnEn+ntTVt6PEFsMLvnxp0XblRMgrC1zD3/Ix7GN8ib4Vi/iZKZT51bLw7N1CKv
         DsDXAXqlGImSbXUE7djwnFVOOMRAir8pBFca+LD7x2qUUXnENU272HvsgZA3zCbULa0N
         tnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9lTeJV+JzJUZ3iP+tZ1netyM+JcI+PTjkHGi+NVg330=;
        b=iYY3H7vwjWLP1PO/Ff95pZDxcq0LLC7Y39mHBUgfNk68wDElFDiH/dYS4E25aBF0Sc
         lmHaBNTDDfOqKdE5c9+PD/W+IDUXijm4nPw8zCNMyQC+SWpkbmI/X/dZXST4yykTt/86
         2ozfAkLgu1vaG0ahOrw7sExARPUeK55x/fV5k45WuZpzoqfRWui3DFhC/jSKtBiEDpCl
         mWtTnAYO8y58pNHKyt/2zESmnYl4pD9ot6cQVIpafHY9kxNscHzz8iMYUF567zECjRPf
         DwO3PXaE3/XBAejNd9rTMpvahU1cgXFiw7JZO/46q25FqhRfRy5NqueV4iQmmCLjM+Ri
         /atA==
X-Gm-Message-State: APt69E1xLwVYPYqqiC7xeBsXGapVQwRV7Ae4yOVKu/FBzR6xNyaK0loz
        Zh/d1UkNlfHslRKn0b9zSA8=
X-Google-Smtp-Source: ADUXVKKJJpm074bVNXRYIgbtjO6D7tdb8QLLcljAWVvqGX5YSpbT9HeqvIOM9Boo27q3mMoSytLf+Q==
X-Received: by 2002:adf:9897:: with SMTP id w23-v6mr6377797wrb.9.1529618609679;
        Thu, 21 Jun 2018 15:03:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u70-v6sm230802wmd.3.2018.06.21.15.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 15:03:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC][PATCH v3 1/3] sequencer: add a new function to silence a command, except if it fails.
References: <20180619154421.14999-1-alban.gruin@gmail.com>
        <20180621141732.19952-1-alban.gruin@gmail.com>
        <20180621141732.19952-2-alban.gruin@gmail.com>
Date:   Thu, 21 Jun 2018 15:03:27 -0700
In-Reply-To: <20180621141732.19952-2-alban.gruin@gmail.com> (Alban Gruin's
        message of "Thu, 21 Jun 2018 16:17:30 +0200")
Message-ID: <xmqqk1qrre4w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> This adds a new function, run_command_silent_on_success(), to
> redirect the stdout and stderr of a command to a strbuf, and then to run
> that command. This strbuf is printed only if the command fails. It is
> functionnaly similar to output() from git-rebase.sh.
>
> run_git_commit() is then refactored to use of
> run_command_silent_on_success().

It might be just a difference in viewpoint, but I think it is more
customary in this project (hence it will be easier to understand and
accept by readers of the patch) if a change like this is explained
NOT as "introducing a new function and then rewrite an existing code
to use it", and instead as "extract a helper function from an
existing code so that future callers can reuse it."

> +static int run_command_silent_on_success(struct child_process *cmd)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	int rc;
> +
> +	cmd->stdout_to_stderr = 1;
> +	rc = pipe_command(cmd,
> +			  NULL, 0,
> +			  /* stdout is already redirected */

I can see that this comment was inherited from the original place
this code was lifted from (and that is why I say this is not "adding
a new helper and rewriting an existing piece of code to use it" but
is "extracting this function out of an existing code for future
reuse"), but does it still make sense in the new context to keep the
same comment?

The original in run_git_commit() made the .stdout_to_stderr=1
assignment many lines before it called pipe_command(), and it made
sense to remind readers why we are passing NULL to the out buffer
and only passing the err buffer here.  But in the context of this
new helper function, the redirection that may make such a reminder
necessary sits immediately before the pipe_command() call for
everybody to see.

> +			  NULL, 0,
> +			  &buf, 0);
> +
> +	if (rc)
> +		fputs(buf.buf, stderr);
> +	strbuf_release(&buf);
> +	return rc;
> +}

> @@ -820,18 +838,11 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>  
>  	cmd.git_cmd = 1;
>  
> -	if (is_rebase_i(opts)) {
> -		if (!(flags & EDIT_MSG)) {
> -			cmd.stdout_to_stderr = 1;
> -			cmd.err = -1;
> -		}
> +	if (is_rebase_i(opts) && read_env_script(&cmd.env_array)) {
> +		const char *gpg_opt = gpg_sign_opt_quoted(opts);
>  
> -		if (read_env_script(&cmd.env_array)) {
> -			const char *gpg_opt = gpg_sign_opt_quoted(opts);
> -
> -			return error(_(staged_changes_advice),
> -				     gpg_opt, gpg_opt);
> -		}
> +		return error(_(staged_changes_advice),
> +			     gpg_opt, gpg_opt);
>  	}

The original in this hunk is criminally incomprehensible ;-)  The
assignment of .stdout_to_stderr=1 does not have to happen this early
in the code, and also using .err being -1 to communicate that the
"capture and show error only upon error" magic is going to be used
to the later code is unnecessarily opaque.  The new code gets rid
of that ugliness from this earlier hunk and instead makes this part
only about reading the various state files (and reporting failure to
do so).

> @@ -861,20 +872,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>  	if (opts->allow_empty_message)
>  		argv_array_push(&cmd.args, "--allow-empty-message");
>  
> -	if (cmd.err == -1) {
> -		/* hide stderr on success */
> -		struct strbuf buf = STRBUF_INIT;
> -		int rc = pipe_command(&cmd,
> -				      NULL, 0,
> -				      /* stdout is already redirected */
> -				      NULL, 0,
> -				      &buf, 0);
> -		if (rc)
> -			fputs(buf.buf, stderr);
> -		strbuf_release(&buf);
> -		return rc;
> -	}
> -
> +	if (is_rebase_i(opts) && !(flags & EDIT_MSG))
> +		return run_command_silent_on_success(&cmd);
>  	return run_command(&cmd);
>  }

And then, the updated code in this hunk checks the EDIT_MSG bit
instead.  It probably is easier to understand the code if you added
an "else" after, to highlight the fact that this is choosing one out
of two possible ways to run "cmd", i.e.

	if (is_rebase_i(opts) && !(flags & EDIT_MSG))
		return run_command_silent_on_success(&cmd);
	else
		return run_command(&cmd);

