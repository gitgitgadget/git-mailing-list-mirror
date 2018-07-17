Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E87231F597
	for <e@80x24.org>; Tue, 17 Jul 2018 18:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbeGQS4T (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 14:56:19 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50246 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbeGQS4T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 14:56:19 -0400
Received: by mail-wm0-f65.google.com with SMTP id v25-v6so332416wmc.0
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 11:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=f7i90l5CohvhO/tTezePb2m7HhMiqfBxeXln1ISrFNQ=;
        b=bNke5OYO3J8IVBIsGIFsmOcpVS3C7JXzNOd9e0dZlSNpKksXkpNF8SEkBmVHe8yqKa
         TNZjEKzDOchx5AQovNjMx9mvkh/9bewchNWYZqvAGGZoZSniDTiWKq1VT3K5mt4tvjYR
         n4hV0wx+PIdL5vpeBqIWi5fZE4JxEJHH+YuKJHlJO62bkdLs0bWZeVzaBBwbpBK8gJA8
         +4lw0WDJcObFA3FPCLZz23XFYrqXBVJh/3HpGKm1GhRwMW0VYLmbi4x76PwjNkOejCY7
         YA55vXBh2UapsYd0vPkbadOABo0RfNuA+7zSP90irL+x5u5pqkLKn5rwD/cxzm7ASZos
         Yvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=f7i90l5CohvhO/tTezePb2m7HhMiqfBxeXln1ISrFNQ=;
        b=FQXtZsRjbbnYudxHxK2Jm1Yh/8uGoWcNHQESxG10WIjuZcxy3MngavMO4JQFRULtKn
         6OJw8MRhY04C9OFCNNcgqDx6dhQAd2yuiCyZh/x4iLWPYQxPfjZ2G25KL6SEHLGwIGkQ
         qm9ozv/d3/wbcKJC/HL1nfdmOOmry9KPAUNEyngH9CZxSU4Dvl5y3TAsL3zDOqbLp0SY
         UYoNpe+FBi3u7mMeh55UarDHu2IREyYDReUOtV50cbPjOAJGkFlM6rOiRCmSFpp8oBXx
         2fkmhANNFLcnjnWqrQpy3Sn8YxrH+bW90wOcy4yu14AYpU0Zpjip/6E6SvgnfaP84j9M
         hjDg==
X-Gm-Message-State: AOUpUlGXp5C97N+JU5jlWQd/yby70UwsdZpfMEmtq6hSd4xaC1OvWB/a
        ke2foJcUv9C1aJIQ/zYKYtY=
X-Google-Smtp-Source: AAOMgpcHBLaosPG9spbhcHCuXvnOo2ttmjj2vcFar3S9dMmEif7k5wFyelIqICLH1I7qHDzk7WgGlQ==
X-Received: by 2002:a1c:3743:: with SMTP id e64-v6mr2021457wma.63.1531851746696;
        Tue, 17 Jul 2018 11:22:26 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q70-v6sm285428wmd.45.2018.07.17.11.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 11:22:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] gc: exit with status 128 on failure
References: <20180716172717.237373-1-jonathantanmy@google.com>
        <20180717065151.GA177907@aiede.svl.corp.google.com>
        <20180717065416.GC177907@aiede.svl.corp.google.com>
Date:   Tue, 17 Jul 2018 11:22:25 -0700
In-Reply-To: <20180717065416.GC177907@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Mon, 16 Jul 2018 23:54:16 -0700")
Message-ID: <xmqqtvoxoh7i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> A value of -1 returned from cmd_gc gets propagated to exit(),
> resulting in an exit status of 255.  Use die instead for a clearer
> error message and a controlled exit.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> As in
> https://public-inbox.org/git/20180716225639.GK11513@aiede.svl.corp.google.com/.
> The only change is splitting out patch 1/3.
>
>  builtin/gc.c  | 35 ++++++++++++++---------------------
>  t/t6500-gc.sh |  2 +-
>  2 files changed, 15 insertions(+), 22 deletions(-)

I double checked "return' in cmd_gc() and this patch catches them
all.  Good clean-up.

Thanks.

> diff --git a/builtin/gc.c b/builtin/gc.c
> index d69fc4c0b0..95c8afd07b 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -438,10 +438,9 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>  	return NULL;
>  }
>  
> -static int report_last_gc_error(void)
> +static void report_last_gc_error(void)
>  {
>  	struct strbuf sb = STRBUF_INIT;
> -	int ret = 0;
>  	ssize_t len;
>  	struct stat st;
>  	char *gc_log_path = git_pathdup("gc.log");
> @@ -450,8 +449,7 @@ static int report_last_gc_error(void)
>  		if (errno == ENOENT)
>  			goto done;
>  
> -		ret = error_errno(_("cannot stat '%s'"), gc_log_path);
> -		goto done;
> +		die_errno(_("cannot stat '%s'"), gc_log_path);
>  	}
>  
>  	if (st.st_mtime < gc_log_expire_time)
> @@ -459,9 +457,9 @@ static int report_last_gc_error(void)
>  
>  	len = strbuf_read_file(&sb, gc_log_path, 0);
>  	if (len < 0)
> -		ret = error_errno(_("cannot read '%s'"), gc_log_path);
> +		die_errno(_("cannot read '%s'"), gc_log_path);
>  	else if (len > 0)
> -		ret = error(_("The last gc run reported the following. "
> +		die(_("The last gc run reported the following. "
>  			       "Please correct the root cause\n"
>  			       "and remove %s.\n"
>  			       "Automatic cleanup will not be performed "
> @@ -471,20 +469,18 @@ static int report_last_gc_error(void)
>  	strbuf_release(&sb);
>  done:
>  	free(gc_log_path);
> -	return ret;
>  }
>  
> -static int gc_before_repack(void)
> +static void gc_before_repack(void)
>  {
>  	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
> -		return error(FAILED_RUN, pack_refs_cmd.argv[0]);
> +		die(FAILED_RUN, pack_refs_cmd.argv[0]);
>  
>  	if (prune_reflogs && run_command_v_opt(reflog.argv, RUN_GIT_CMD))
> -		return error(FAILED_RUN, reflog.argv[0]);
> +		die(FAILED_RUN, reflog.argv[0]);
>  
>  	pack_refs = 0;
>  	prune_reflogs = 0;
> -	return 0;
>  }
>  
>  int cmd_gc(int argc, const char **argv, const char *prefix)
> @@ -565,13 +561,11 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
>  		}
>  		if (detach_auto) {
> -			if (report_last_gc_error())
> -				return -1;
> +			report_last_gc_error(); /* dies on error */
>  
>  			if (lock_repo_for_gc(force, &pid))
>  				return 0;
> -			if (gc_before_repack())
> -				return -1;
> +			gc_before_repack(); /* dies on failure */
>  			delete_tempfile(&pidfile);
>  
>  			/*
> @@ -611,12 +605,11 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  		atexit(process_log_file_at_exit);
>  	}
>  
> -	if (gc_before_repack())
> -		return -1;
> +	gc_before_repack();
>  
>  	if (!repository_format_precious_objects) {
>  		if (run_command_v_opt(repack.argv, RUN_GIT_CMD))
> -			return error(FAILED_RUN, repack.argv[0]);
> +			die(FAILED_RUN, repack.argv[0]);
>  
>  		if (prune_expire) {
>  			argv_array_push(&prune, prune_expire);
> @@ -626,18 +619,18 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  				argv_array_push(&prune,
>  						"--exclude-promisor-objects");
>  			if (run_command_v_opt(prune.argv, RUN_GIT_CMD))
> -				return error(FAILED_RUN, prune.argv[0]);
> +				die(FAILED_RUN, prune.argv[0]);
>  		}
>  	}
>  
>  	if (prune_worktrees_expire) {
>  		argv_array_push(&prune_worktrees, prune_worktrees_expire);
>  		if (run_command_v_opt(prune_worktrees.argv, RUN_GIT_CMD))
> -			return error(FAILED_RUN, prune_worktrees.argv[0]);
> +			die(FAILED_RUN, prune_worktrees.argv[0]);
>  	}
>  
>  	if (run_command_v_opt(rerere.argv, RUN_GIT_CMD))
> -		return error(FAILED_RUN, rerere.argv[0]);
> +		die(FAILED_RUN, rerere.argv[0]);
>  
>  	report_garbage = report_pack_garbage;
>  	reprepare_packed_git(the_repository);
> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index 818435f04e..c474a94a9f 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -117,7 +117,7 @@ test_expect_success 'background auto gc does not run if gc.log is present and re
>  	test_config gc.autodetach true &&
>  	echo fleem >.git/gc.log &&
>  	test_must_fail git gc --auto 2>err &&
> -	test_i18ngrep "^error:" err &&
> +	test_i18ngrep "^fatal:" err &&
>  	test_config gc.logexpiry 5.days &&
>  	test-tool chmtime =-345600 .git/gc.log &&
>  	test_must_fail git gc --auto &&
