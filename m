Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 122921FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 17:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934944AbeAKRxU (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 12:53:20 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46108 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932621AbeAKRxT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 12:53:19 -0500
Received: by mail-pg0-f65.google.com with SMTP id s9so849772pgq.13
        for <git@vger.kernel.org>; Thu, 11 Jan 2018 09:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GEGVCDjl9VuKrHPOzsqjf8baKRS6aQehu/TlkJqyRGQ=;
        b=fTIuTuKi6l68qovSyz90nDIiSs5q37nXD41RUKOzZ8l0zTNa/j6IFg79Jy0MX1C0Jh
         Rt1QEJe3tafA/1YgFWtK1Oa2AbtPVxDu8FDyeYp3bE9ae0s3hUgapS7CzwgdE9d3v2PJ
         +Xt9e6M1od8K4sxbYaGsT543DfmdzQUxzjBHKWAUypfl8lRy7W7XGO4jh7/G4ayjmUli
         oYteTSdqIOMds2+opsDG3AhURKqxdkvHqaZUDA96RjUr0O9onLBKMNn+aosQ8HVFLlj2
         vxDIpdWJNsYVTe7jdUNf5NT+B+lHFY1WutahL5bOilPlLGonhumRs9i9gAZ0clq2A166
         6nCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GEGVCDjl9VuKrHPOzsqjf8baKRS6aQehu/TlkJqyRGQ=;
        b=hYGWQ4OOkMafvf19LXPLPshmWcNYndzXBl7HnlAByGPinwaS1lbq55jD98n4ns64tY
         I7oFW3dRMzvBS2/qBYzjR6W+wX/YioCim2LDYayXzh29OQsgu/LpEwSjFeN24EKhj7tn
         1JH95clfxmcw6k3ZLMHw5JZ5+nE3r5raEcsneq5dsfaYt9hOuB+u+raZIMB9wgjX69U8
         EqKnFPmNntZlmBDaTAGvbJFKbycShSSnX+P+9SN8Hy1X6AEUs7O1cY6/XvqnIO1ZcG7E
         kAHgZ1ExLbCmZJ0kw6+NOnNhNeC3NbaDZIqvQjzphZRSjA7bahMEVqksR0V2Nq7XzgxN
         8TNA==
X-Gm-Message-State: AKwxytcED3G715y1fRDYcPZvNssXGcBZDBCXAeaULa3WOVwxpK6CaQVE
        a7GpCV+Pzjkj0d/ZwLk1lVkNtw==
X-Google-Smtp-Source: ACJfBouIc4blPq4oL4PiWO0jpT1FeevtEd3avAJtSGRUiNgh5uaNUgi+Mphj3+XkqOIWGEJml/i2GA==
X-Received: by 10.101.97.10 with SMTP id z10mr3810545pgu.24.1515693198407;
        Thu, 11 Jan 2018 09:53:18 -0800 (PST)
Received: from google.com ([2620:0:100e:422:3800:a714:ab3:b606])
        by smtp.gmail.com with ESMTPSA id r13sm34821044pgq.25.2018.01.11.09.53.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 Jan 2018 09:53:17 -0800 (PST)
Date:   Thu, 11 Jan 2018 09:53:16 -0800
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] run-command.c: print env vars when GIT_TRACE is set
Message-ID: <20180111175316.GD91567@google.com>
References: <20180110104835.22905-1-pclouds@gmail.com>
 <20180111094712.2551-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180111094712.2551-1-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/11, Nguyễn Thái Ngọc Duy wrote:
> Occasionally submodule code could execute new commands with GIT_DIR set
> to some submodule. GIT_TRACE prints just the command line which makes it
> hard to tell that it's not really executed on this repository.
> 
> Print modified env variables (compared to parent environment) in this
> case. Actually only modified or new variables are printed. Variable
> deletion is suppressed because they are often used to clean up
> repo-specific variables that git passes around between processes. When
> submodule code executes commands on another repo, it clears all these
> variables, _many_ of these, that make the output really noisy.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  v2 fixes up commit message to clarify about "env delta" and why var
>  deletion is not printed.
> 
>  It also keeps child_process tracing in one place/function, this
>  should make it easier to trace more e.g. cwd and stuff.
> 
>  Though, Stefan, while i'm not opposed to trace every single setting
>  in child_process, including variable deletion, cwd and even more, it
>  may be not that often needed for a "casual" developer.
>  
>  I suggest we have something like $GIT_TRACE_EXEC instead that could
>  be super verbose when we need it and leave $GIT_TRACE with a
>  reasonable subset.
> 
>  run-command.c |  3 ++-
>  trace.c       | 39 +++++++++++++++++++++++++++++++++++++++
>  trace.h       |  3 +++
>  3 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/run-command.c b/run-command.c
> index 31fc5ea86e..002074b128 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -624,7 +624,8 @@ int start_command(struct child_process *cmd)
>  		cmd->err = fderr[0];
>  	}
>  
> -	trace_argv_printf(cmd->argv, "trace: run_command:");
> +	trace_run_command(cmd);
> +
>  	fflush(NULL);
>  
>  #ifndef GIT_WINDOWS_NATIVE
> diff --git a/trace.c b/trace.c
> index b7530b51a9..e5e46e2a09 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -23,6 +23,7 @@
>  
>  #include "cache.h"
>  #include "quote.h"
> +#include "run-command.h"
>  
>  struct trace_key trace_default_key = { "GIT_TRACE", 0, 0, 0 };
>  struct trace_key trace_perf_key = TRACE_KEY_INIT(PERFORMANCE);
> @@ -272,6 +273,44 @@ void trace_performance_fl(const char *file, int line, uint64_t nanos,
>  #endif /* HAVE_VARIADIC_MACROS */
>  
>  
> +static void concatenate_env(struct strbuf *dst, const char *const *env)
> +{
> +	int i;
> +
> +	/* Copy into destination buffer. */
> +	strbuf_grow(dst, 255);
> +	for (i = 0; env[i]; ++i) {
> +		/*
> +		 * the main interesting is setting new vars
> +		 * e.g. GIT_DIR, ignore the unsetting to reduce noise.
> +		 */

Patch looks good to me! Only nit is this comment which reads funny which i
pointed out in v1.

> +		if (!strchr(env[i], '='))
> +			continue;
> +		strbuf_addch(dst, ' ');
> +		sq_quote_buf(dst, env[i]);
> +	}
> +}
> +
> +void trace_run_command(const struct child_process *cp)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	if (!prepare_trace_line(NULL, 0, &trace_default_key, &buf))
> +		return;
> +
> +	strbuf_addf(&buf, "trace: run_command:");
> +
> +	/*
> +	 * caller is responsible for setting this if the main source
> +	 * is actually in cp->env_array
> +	 */
> +	if (cp->env)
> +		concatenate_env(&buf, cp->env);
> +
> +	sq_quote_argv(&buf, cp->argv, 0);
> +	print_trace_line(&trace_default_key, &buf);
> +}
> +
>  static const char *quote_crnl(const char *path)
>  {
>  	static struct strbuf new_path = STRBUF_INIT;
> diff --git a/trace.h b/trace.h
> index 88055abef7..e54c687f26 100644
> --- a/trace.h
> +++ b/trace.h
> @@ -4,6 +4,8 @@
>  #include "git-compat-util.h"
>  #include "strbuf.h"
>  
> +struct child_process;
> +
>  struct trace_key {
>  	const char * const key;
>  	int fd;
> @@ -17,6 +19,7 @@ extern struct trace_key trace_default_key;
>  extern struct trace_key trace_perf_key;
>  
>  extern void trace_repo_setup(const char *prefix);
> +extern void trace_run_command(const struct child_process *cp);
>  extern int trace_want(struct trace_key *key);
>  extern void trace_disable(struct trace_key *key);
>  extern uint64_t getnanotime(void);
> -- 
> 2.15.1.600.g899a5f85c6
> 

-- 
Brandon Williams
