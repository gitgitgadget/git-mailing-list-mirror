Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADE272036B
	for <e@80x24.org>; Tue, 10 Oct 2017 13:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756234AbdJJNnX (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 09:43:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54996 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756048AbdJJNnW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 09:43:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id i124so5462869wmf.3
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 06:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=wLY16gl5tytSsWMJC4Zk7cRurVoYDfhNo0rdDUWg18E=;
        b=JZzMq+MEErf8tsnmRx2WvTaJntZUe2Dsb27RIshiKu2MRvyyQrp6kaKiASy7uvPrfh
         REX0Nx5/v5w67WlXuhK5jiTsbxNORE2OtkgBz6Si1hCcpFFZ5bM+fZot6xERK9Flzz3C
         D3C4RUAJG0aB44rZAHNnluTS80xyRuFuK99AoANKpyiDnje2QmLcXOHg/GYD1vQWzJL6
         FHBuOgjfaZCvZq182KqbBhZJpyP1xB0mDUkw8FYEyZEayUFAUjKkzbGYMAHInZ2mN8mr
         4frhB0rSOJNZdKUL1buwRa7DJ9V/gipL95ys/YRVDHrzG86sT4lPrGPEcHm19MFYTlHu
         g63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=wLY16gl5tytSsWMJC4Zk7cRurVoYDfhNo0rdDUWg18E=;
        b=IcU9sZcNRX95P+M/2rda72h94e3twzCCNw1Gtjuu6+CW9GlcCKHiSWI3gdG4vHmexQ
         YnKFAh6voxMZwmwc7YX7ZNmZ/VjbVXd0/XiEHYnaO90VLqvVqaPlhTkQDcXtdt4XsAsn
         RVU8myfAH9wCpFBqkL6h+6oV8jx4ppOm/QyP4s0a99UrgmdcoHYwlDgOhuJslTFTR6NH
         N9T98th+qr4V0j4i9knFMCQmFtGi7tHB22nb5TRw6UF51OTpSJfL7UVbmesOaADIWbJm
         rZeYZ+hrf4LYvj9TT4RAADjU2klSoH+ZkHVPW8Ttv2dOzCW2qk5VIRX8p+OGXrjUDNmB
         GS9w==
X-Gm-Message-State: AMCzsaWSRAwI+GqUen8YU4quzV4JmLGyQ3irvEtrXdpp1lhZdIIIixCu
        k8Yz6tBD68nfRVUCwhXJDhHbwQ==
X-Google-Smtp-Source: AOwi7QCs+Mztc3x0acIknhLTMzUi5Mehat2lIlML3AY7X3x2g94l596d/EjfPUJMttKfvEaTA6+7Gg==
X-Received: by 10.28.15.198 with SMTP id 189mr10552949wmp.140.1507643000747;
        Tue, 10 Oct 2017 06:43:20 -0700 (PDT)
Received: from localhost.localdomain (x4db0fdcc.dyn.telefonica.de. [77.176.253.204])
        by smtp.gmail.com with ESMTPSA id 4sm4659906wmz.33.2017.10.10.06.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Oct 2017 06:43:20 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] describe: do not use cmd_*() as a subroutine
Date:   Tue, 10 Oct 2017 15:43:09 +0200
Message-Id: <20171010134309.13803-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.0.rc0.108.gb76db4b4e
In-Reply-To: <20171010040604.26029-2-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> The cmd_foo() function is a moral equivalent of 'main' for a Git
> subcommand 'git foo', and as such, it is allowed to do many things
> that make it unsuitable to be called as a subroutine, including
> 
>  - call exit(3) to terminate the process;
> 
>  - allocate resource held and used throughout its lifetime, without
>    releasing it upon return/exit;
> 
>  - rely on global variables being initialized at program startup,
>    and update them as needed, making another clean invocation of the
>    function impossible.
> 
> The call to cmd_diff_index() "git describe" makes has been working
> by accident that the function did not call exit(3); it sets a bad
> precedent for people to cut and paste.

The subject implies to me that this patch eliminates all cmd_*() calls
in builtin/describe.c, but a call to cmd_name_rev() still remains.

However, that call is special in the sense that cmd_describe() returns
immediately thereafter, so none of the above three points are an issue
there.  Someone might argue that it still sets a bad precedent, but I
won't :)  To avoid the direct cmd_name_rev() call we would have to use
run_command(), because there are no libified helper functions
available to do the job, adding the overhead of a fork()+exec(),
though only once or nonce, depending on cmdline options.

Maybe you already considered all this WRT that cmd_name_rev() call, I
don't know.  In any case, I think at least the subject line should
spell out cmd_diff_index().


Gábor


> We could invoke it via the run_command() interface, but the diff
> family of commands have helper functions in diff-lib.c that are
> meant to be usable as subroutines, and using the latter does not
> make the resulting code all that longer.  Use it.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/describe.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/describe.c b/builtin/describe.c
> index 89ea1cdd60..50263759cb 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -7,12 +7,12 @@
>  #include "builtin.h"
>  #include "exec_cmd.h"
>  #include "parse-options.h"
> +#include "revision.h"
>  #include "diff.h"
>  #include "hashmap.h"
>  #include "argv-array.h"
>  #include "run-command.h"
>  
> -#define SEEN		(1u << 0)
>  #define MAX_TAGS	(FLAG_BITS - 1)
>  
>  static const char * const describe_usage[] = {
> @@ -532,7 +532,9 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>  			}
>  		} else if (dirty) {
>  			static struct lock_file index_lock;
> -			int fd;
> +			struct rev_info revs;
> +			struct argv_array args = ARGV_ARRAY_INIT;
> +			int fd, result;
>  
>  			read_cache_preload(NULL);
>  			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
> @@ -541,8 +543,13 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>  			if (0 <= fd)
>  				update_index_if_able(&the_index, &index_lock);
>  
> -			if (!cmd_diff_index(ARRAY_SIZE(diff_index_args) - 1,
> -					    diff_index_args, prefix))
> +			init_revisions(&revs, prefix);
> +			argv_array_pushv(&args, diff_index_args);
> +			if (setup_revisions(args.argc, args.argv, &revs, NULL) != 1)
> +				BUG("malformed internal diff-index command line");
> +			result = run_diff_index(&revs, 0);
> +
> +			if (!diff_result_code(&revs.diffopt, result))
>  				suffix = NULL;
>  			else
>  				suffix = dirty;
> -- 
> 2.15.0-rc0-203-g4c8d0e28b1
