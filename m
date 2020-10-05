Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160CDC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 23:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2D3420756
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 23:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U49/xpZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgJEXjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 19:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgJEXjG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 19:39:06 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6324AC0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 16:39:06 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id l126so7944256pfd.5
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 16:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y/FUUEK+bJCZ6isW4Xq+t7yUpCsGPn5s6lCXIwH6Mv0=;
        b=U49/xpZPofKiP7uACPor1KE9LNXFTzDhrBIwvQusw4MYM4TKSA3r4sNY5BQMUDARJh
         cb6Qy/lVgk6zW/LTP4Mvn3JmNu9st/z9JMXwltfpYWNinhm2hPhXJuwqbF6LceySs9uj
         rWvQftfo8nRWAVBYZ2dt+WQQPeOD/lLXcNRUEQcW7oRw0KYGNOnmYDdYJaRuvlxL/pzZ
         bLCwZbl+ckDJb/uqLHFoyZKxvzGvHGFcbxB2UJFVtMSFJ+J05G5+qgolzUicJn5qwtAh
         phc9YCUPr+r+w6os4mnsUUGTtbK8YHTMx+8nP2Qf5lGF8ZcpqcA806CKJXDTmPRuvcrH
         47eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y/FUUEK+bJCZ6isW4Xq+t7yUpCsGPn5s6lCXIwH6Mv0=;
        b=qnb9vEB0bcxe3GX2LFTAmgMM43slX5Vp1ct+X0CtAt7mPQqynSRbz0eWpRs2JmEPos
         n9YBtVkOvYOWROnl1HlmTmu4opeNJJ3wcBCItdVq8TgdZwqDfY3HbcN9FGwPohr1xF9e
         GOY7EaRmQgoaQ/lQH0Dmy5AWVs04MJO5imjhwBFNAtX8VVmNMhtI4CkzybuirLD6ZeQ8
         ZzwIEE+rekpuhOePFf1vgxOLtfUCANYiHGqlZaM8irCcnz1T+ohDlp1eTaGxxbmRvtwq
         YVrvoGtJQQttvtw01MjPS+utPPjnYM4eXfKmetgZcd4U0OP2aqiviSp4VGuKABVqnutJ
         DxTw==
X-Gm-Message-State: AOAM530xS/HFwvWZ2WL6Na6VUvywcpxG/7jtLExqiku1Jvo87zBG6CkK
        lAP7rbDFGnlI7UYDZHj72XzGyL8fG8I=
X-Google-Smtp-Source: ABdhPJxiQXhtr0+UcvSuhjLbiw0XUhy9q6win/X1cG/8xAgrpiRTGrDqtgE/8pUdVKZ3HSTWEnW3kg==
X-Received: by 2002:a63:b64a:: with SMTP id v10mr1588017pgt.192.1601941145872;
        Mon, 05 Oct 2020 16:39:05 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id 189sm818036pfw.123.2020.10.05.16.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 16:39:05 -0700 (PDT)
Date:   Mon, 5 Oct 2020 16:39:03 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 6/9] hook: add 'run' subcommand
Message-ID: <20201005233903.GD1393696@google.com>
References: <20200909004939.1942347-1-emilyshaffer@google.com>
 <20200909004939.1942347-7-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909004939.1942347-7-emilyshaffer@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Emily Shaffer wrote:

> In order to enable hooks to be run as an external process, by a
> standalone Git command, or by tools which wrap Git, provide an external
> means to run all configured hook commands for a given hook event.

Exciting!

I would even be tempted to put this earlier in the series: providing a
"git hook run" command that only supports legacy hooks and then
improving it from there to support config-based hooks.  This ordering is
also fine, though.

[...]
> ---
>  builtin/hook.c                | 30 ++++++++++++++++++++
>  hook.c                        | 52 ++++++++++++++++++++++++++++++++---
>  hook.h                        |  3 ++
>  t/t1360-config-based-hooks.sh | 28 +++++++++++++++++++
>  4 files changed, 109 insertions(+), 4 deletions(-)

Needs docs.

[...]
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -5,9 +5,11 @@
[...]
> +static int run(int argc, const char **argv, const char *prefix)
> +{
> +	struct strbuf hookname = STRBUF_INIT;
> +	struct strvec envs = STRVEC_INIT;
> +	struct strvec args = STRVEC_INIT;
> +
> +	struct option run_options[] = {
> +		OPT_STRVEC('e', "env", &envs, N_("var"),
> +			   N_("environment variables for hook to use")),
> +		OPT_STRVEC('a', "arg", &args, N_("args"),
> +			   N_("argument to pass to hook")),
> +		OPT_END(),
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, run_options,
> +			     builtin_hook_usage, 0);
> +
> +	if (argc < 1)
> +		usage_msg_opt(_("a hookname must be provided to operate on."),
> +			      builtin_hook_usage, run_options);

Error message nit: what does it mean to operate on a hookname?

Perhaps this should allude to the usage string?

	usage_msg_opt(_("missing <hookname> parameter"), ...);

Or to match the conversational approach of commands like "clone":

	usage_msg_opt(_("You must specify a hook to run."), ...);

[...]
> --- a/hook.c
> +++ b/hook.c
> @@ -2,6 +2,7 @@
>  
>  #include "hook.h"
>  #include "config.h"
> +#include "run-command.h"
>  
>  /*
>   * NEEDSWORK: a stateful hook_head means we can't run two hook events in the
> @@ -21,13 +22,15 @@ void free_hook(struct hook *ptr)
>  	}
>  }
>  
> -static void emplace_hook(struct list_head *pos, const char *command)
> +static void emplace_hook(struct list_head *pos, const char *command, int quoted)
>  {
>  	struct hook *to_add = malloc(sizeof(struct hook));
>  	to_add->origin = current_config_scope();
>  	strbuf_init(&to_add->command, 0);
> -	/* even with use_shell, run_command() needs quotes */
> -	strbuf_addf(&to_add->command, "'%s'", command);
> +	if (quoted)
> +		strbuf_addf(&to_add->command, "'%s'", command);
> +	else
> +		strbuf_addstr(&to_add->command, command);
>  
>  	list_add_tail(&to_add->list, pos);
>  }

This would need to use sq_quote_* to be safe, but we can do something
simpler: if we accumulate parameters in an argv_array passed to
run_command, then they will be safely passed to the shell without
triggering expansion.

Thanks,
Jonathan
