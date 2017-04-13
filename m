Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 098E420960
	for <e@80x24.org>; Thu, 13 Apr 2017 22:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbdDMWld (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 18:41:33 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33147 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdDMWlc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 18:41:32 -0400
Received: by mail-pf0-f180.google.com with SMTP id s16so34273185pfs.0
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 15:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eWoxH9yhZxkxbh3ZXMj9nT4o3j6dPchSyACjjBgNVdQ=;
        b=XK3YSC1DBooIZWLJAcKOjvbwfnMbvgx3U0/ASCulFAC00kQn2px92FBdW+DtAxMT6v
         HQPOOnEQ+DDN7KqYQ+X36UvY5htfJLmWYngzkOMInM8vLJ/lTjenkza/wifiLN71yyGM
         XRma7vQGqb1z5V4JqhCwlpfpLjD1jSPwjSU8NTzZsKQWb+8FvuUc+1YbEQDh6ycH2ptU
         67+uxya7WNL8kF1aHtEYlI6CmWIpNNXqB3D2Bnxo6TydUtn7k0JaQrFxQbkbmYTTbNSl
         +7ebHst6T3YvUdjj+6kMAZgNgIxlSO5YFQ73yyg7v/hUXQx9cDTQMKLC2U+/ex1aNHuF
         f8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eWoxH9yhZxkxbh3ZXMj9nT4o3j6dPchSyACjjBgNVdQ=;
        b=A+3Fy5Z2dTx9Tt8rAdL9nUjNTMV2s65LSae9LMGoe923RI11xiszlC2s5iUVJxe4tn
         w/ozFoXI5+/Zql0iJ4IRUPaeyMKzLdphd8/NxW/8ac7hePbqowBOTy3R7jXqffhGdi7S
         IBHFpa5/KEDVwIqIX66hY/mi9SXIjSXQ+GLFYZ4Jr3fnLEZFVE4hd61XHJcFFuba5o+c
         QoJ5J6+JM7JmCV9/Kpue5RBuMzxx8Y7KQBzqDM/jgFsf/JcRXNCidwAUQOY2L9oikywd
         QS1dSK8PRvv5JAI3v2YTfdvjqcr0h4XFfSl2VhhyUIHPnz052XD5wFHBVYhzNAVr09yT
         +3Ow==
X-Gm-Message-State: AN3rC/4P/uRalCZ3dFkzlBl1gcM94VDOTtvPr110ZTRZHZnxaj/dpjaI
        9F7ul3i45PN3Tdtu4lgU/Q==
X-Received: by 10.98.28.193 with SMTP id c184mr4376579pfc.212.1492123291306;
        Thu, 13 Apr 2017 15:41:31 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:1426:66e2:260b:9db9])
        by smtp.gmail.com with ESMTPSA id 129sm83531pgj.23.2017.04.13.15.41.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 15:41:30 -0700 (PDT)
Date:   Thu, 13 Apr 2017 15:41:29 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, e@80x24.org
Subject: Re: [PATCH v2 2/6] run-command: prepare command before forking
Message-ID: <20170413224129.GB115420@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170413183252.4713-1-bmwill@google.com>
 <20170413183252.4713-3-bmwill@google.com>
 <20170413211447.GC10084@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170413211447.GC10084@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/13, Jonathan Nieder wrote:
> Hi,
> 
> Brandon Williams wrote:
> 
> > In order to avoid allocation between 'fork()' and 'exec()' the argv
> > array used in the exec call is prepared prior to forking the process.
> 
> nit: s/(the argv array.*) is prepared/prepare \1/
> 
> Git's commit messages are in the imperative mood, as if they are
> ordering the code or the computer to do something.
> 
> More importantly, the commit message is a good place to explain some
> of the motivation behind the patch so that people can understand what
> the patch is for by reading it without having to dig into mailing list
> archives and get the discussion there.
> 
> E.g. this could say
> 
> - that grep tests are intermittently failing in configurations using
>   some versions of tcmalloc
> 
> - that the cause is interaction between fork and threads: malloc holds
>   a lock that those versions of tcmalloc doesn't release in a
>   pthread_atfork handler
> 
> - that according to [1] we need to only call async-signal-safe
>   operations between fork and exec.  Using malloc to build the argv
>   array isn't async-signal-safe
> 
> [1] http://pubs.opengroup.org/onlinepubs/009695399/functions/fork.html
> 
> > In addition to this, the function used to exec is changed from
> > 'execvp()' to 'execv()' as the (p) variant of exec has the potential to
> > call malloc during the path resolution it performs.
> 
> *puzzled* is execvp actually allowed to call malloc?

It could possible as it isn't async-signal-safe.

> 
> Could this part go in a separate patch?  That would make it easier to
> review.

I'll break this conversion out to a different patch.

> 
> [...]
> > +++ b/run-command.c
> [...]
> > +	/*
> > +	 * If there are no '/' characters in the command then perform a path
> > +	 * lookup and use the resolved path as the command to exec.  If there
> > +	 * are no '/' characters or if the command wasn't found in the path,
> > +	 * have exec attempt to invoke the command directly.
> > +	 */
> > +	if (!strchr(out->argv[0], '/')) {
> > +		char *program = locate_in_PATH(out->argv[0]);
> > +		if (program) {
> > +			free((char *)out->argv[0]);
> > +			out->argv[0] = program;
> > +		}
> > +	}
> 
> This does one half of what execvp does but leaves out the other half.
> http://pubs.opengroup.org/onlinepubs/009695399/functions/exec.html
> explains:
> 
>   There are two distinct ways in which the contents of the process
>   image file may cause the execution to fail, distinguished by the
>   setting of errno to either [ENOEXEC] or [EINVAL] (see the ERRORS
>   section). In the cases where the other members of the exec family of
>   functions would fail and set errno to [ENOEXEC], the execlp() and
>   execvp() functions shall execute a command interpreter and the
>   environment of the executed command shall be as if the process
>   invoked the sh utility using execl() as follows:
> 
>   execl(<shell path>, arg0, file, arg1, ..., (char *)0);
> 
> I think this is what the first patch in the series was about.  Do we
> want to drop that support?
> 
> I think we need to keep it, since it is easy for authors of e.g.
> credential helpers to accidentally rely on it.
> 
> [...]
> > @@ -437,12 +458,9 @@ int start_command(struct child_process *cmd)
> >  					unsetenv(*cmd->env);
> >  			}
> >  		}
> > -		if (cmd->git_cmd)
> > -			execv_git_cmd(cmd->argv);
> > -		else if (cmd->use_shell)
> > -			execv_shell_cmd(cmd->argv);
> > -		else
> > -			sane_execvp(cmd->argv[0], (char *const*) cmd->argv);
> > +
> > +		execv(argv.argv[0], (char *const *) argv.argv);
> 
> What happens in the case sane_execvp was trying to handle?  Does
> prepare_cmd need error handling for when the command isn't found?
> 
> Sorry this got so fussy.
> 
> Thanks and hope that helps,
> Jonathan

-- 
Brandon Williams
