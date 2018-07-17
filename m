Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C07411F597
	for <e@80x24.org>; Tue, 17 Jul 2018 18:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbeGQSnd (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 14:43:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42386 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbeGQSnd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 14:43:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so2128420wrs.9
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 11:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bNjClC6vncbYl4c7+SafsGADJ6LUlnaYYaXenKCf3k0=;
        b=qZnbYyU4M3llYkPuhlVF8Udcb6qjKhuHdgqIqtOsOEcvatwRl6cGAuomKVZ3doOrGa
         /ctm4jnxLxuWtsUSKjO8FK/VmG2KmAmS3mXdAXbeM4CQDZ3IbAN2UpH4uDUfancdpHdC
         ePTMK4Lfm4m6XkVbN3gspc5Y2flhFnQqHCmf35PO7REGw76B79Z4eC9p5sSeZT/IPT22
         18jyEQbaN5MoOhtpZ8c+w7Blg7DxQHLSHAM9xLI7GRnONST+nCSfO2301vCm3pfDBo5Q
         jBiLB0kTLo/fFnEsMgk/cxnDMFSc028Xeht8tMuH8F7tlGguNu/iKOeNDRob6Ql3C1+s
         W+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bNjClC6vncbYl4c7+SafsGADJ6LUlnaYYaXenKCf3k0=;
        b=FU9JAP2FYP92h5iqHADXPwxv5kawm/lL1ddFNpXTBJ9gIdYsPLhicWl9yuRpKzEz3H
         ITqUiRsSoTJl1mhyYy0iAx7+Ip9uhze/gj+eyIJ0unPMqfKQj/KqtZsxTO7ICihSGjGk
         h2Grvt/fwvdKoXPOmuMYGCfHWg90YRgY1ZC5o2Vvnkq8ViS4oDT7iZY42A3F4sRmPyr7
         KxAlLuIemgkEDjAl9SVvGH+rfass77E/q9fI9W86yxNbc7HrxAvLUJt5xFBXNtfqpbOD
         pW6nXZSuWde0hT14lsB/lLvjD2vMon2zinYtA0ZqLn3gP0d8i6M9BF6BAoBbNmrqO+yh
         cNzg==
X-Gm-Message-State: AOUpUlEBPHaf02PdlcgBJT1UPbfnoDhkQnzCtwT0DcIPCLWdSXKOUd8u
        Tr/KZAD9o4FTBuOIbHBOLxY=
X-Google-Smtp-Source: AAOMgpdJH2Pl8jgAj2YFmrI0XKV5/iI/pXYN+Zp3scjP65sBoOp6MPzVu2WdoJ8l6iBHJsOqpOELoQ==
X-Received: by 2002:adf:ab14:: with SMTP id q20-v6mr2049013wrc.239.1531850982547;
        Tue, 17 Jul 2018 11:09:42 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i6-v6sm2859191wrr.10.2018.07.17.11.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 11:09:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        git@vger.kernel.org, Andrii Dehtiarov <adehtiarov@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] gc: do not warn about too many loose objects
References: <20180716195431.GD11513@aiede.svl.corp.google.com>
        <20180716202915.GC25189@sigill.intra.peff.net>
        <20180716203753.GE11513@aiede.svl.corp.google.com>
        <20180716210938.GF25189@sigill.intra.peff.net>
        <20180716214003.GH11513@aiede.svl.corp.google.com>
        <20180716214539.GL25189@sigill.intra.peff.net>
        <20180716220306.GI11513@aiede.svl.corp.google.com>
        <20180716224337.GB12482@sigill.intra.peff.net>
        <20180716225639.GK11513@aiede.svl.corp.google.com>
        <20180716232603.GB13570@sigill.intra.peff.net>
        <20180717015339.GL11513@aiede.svl.corp.google.com>
Date:   Tue, 17 Jul 2018 11:09:40 -0700
In-Reply-To: <20180717015339.GL11513@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Mon, 16 Jul 2018 18:53:39 -0700")
Message-ID: <xmqq36whpwd7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> That doesn't really solve the problem:
>
>  1. "gc --auto" would produce noise *every time it runs* until gc.log
>     is removed, for example via expiry
>
>  2. "gc --auto" would not do any garbage collection until gc.log is
>     removed, for example by expiry
>
>  3. "gc --auto" would still not ratelimit itself, for example when
>     there are a large number of loose unreachable objects that is not
>     large enough to hit the loose object threshold.
>
> but maybe it's better than the present state.
>
> To solve (1) and (2), we could introduce a gc.warnings file that
> behaves like gc.log except that it only gets printed once and then
> self-destructs, allowing gc --auto to proceed.  

That makes it not rate-limit, no?

> To solve (3), we could
> introduce a gc.lastrun file that is touched whenever "gc --auto" runs
> successfully and make "gc --auto" a no-op for a while after each run.

Does absolute time-interval make sense here?  Some repositories may
be busily churning new objects and for them 5-minute interval may be
too infrequent, while other repositories may be relatively slow and
once a day may be sufficient for them.  I wonder if we can somehow
auto-tune this.

> To avoid wasteful repeated fruitless gcs, when gc.log is present, the
> subsequent "gc --auto" would die after print its contents.  Most git

s/print/&ing/

> commands, such as "git fetch", ignore the exit status from "git gc
> --auto" so all is well at this point: the user gets to see the error
> message, and the fetch succeeds, without a wasteful additional attempt
> at an automatic gc.

The above, by saying "Most git commands", leaves readers want to
know "then what are minority git commands that do not correctly do
so?"  If you are not going to answer that question, it probably is
better not to even say "Most".

> External tools like repo[1], though, do care about the exit status
> from "git gc --auto".  In non-daemonized mode, the exit status is
> straightforward: if there is an error, it is nonzero, but after a
> warning like the above, the status is zero.  The daemonized mode, as a
> side effect of the other properties provided, offers a very strange
> exit code convention:
>
>  - if no housekeeping was required, the exit status is 0

OK.

>  - the first real run, after forking into the background, returns exit
>    status 0 unconditionally.  The parent process has no way to know
>    whether gc will succeed.

Understandable; allowing the parent to exit before we know the
outcome of the gc is the whole point of backgrounding.

>  - if there is any diagnostic output in gc.log, subsequent runs return
>    a nonzero exit status to indicate that gc was not triggered.

This is unfortunate.

> There's nothing for the calling program to act on on the basis of that
> error.  Use status 0 consistently instead, to indicate that we decided
> not to run a gc (just like if no housekeeping was required).  

s/.$/ in the last case./  And I fully agree with the reasoning.

> This
> way, repo and similar tools can get the benefit of the same behavior
> as tools like "git fetch" that ignore the exit status from gc --auto.
>
> Once the period of time described by gc.pruneExpire elapses, the
> unreachable loose objects will be removed by "git gc --auto"
> automatically.
>
> [1] https://gerrit-review.googlesource.com/c/git-repo/+/10598/
>
> Reported-by: Andrii Dehtiarov <adehtiarov@google.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  Documentation/config.txt |  3 ++-
>  builtin/gc.c             | 16 +++++++++++-----
>  t/t6500-gc.sh            |  6 +++---
>  3 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1cc18a828c..5eaa4aaa7d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1649,7 +1649,8 @@ will be repacked. After this the number of packs should go below
>  gc.autoPackLimit and gc.bigPackThreshold should be respected again.
>  
>  gc.logExpiry::
> -	If the file gc.log exists, then `git gc --auto` won't run
> +	If the file gc.log exists, then `git gc --auto` will print
> +	its content and exit with status zero instead of running
>  	unless that file is more than 'gc.logExpiry' old.  Default is
>  	"1.day".  See `gc.pruneExpire` for more ways to specify its
>  	value.
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 2bebc52bda..484ab21b8c 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -438,7 +438,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>  	return NULL;
>  }
>  
> -static void report_last_gc_error(void)
> +static int report_last_gc_error(void)
>  {
>  	struct strbuf sb = STRBUF_INIT;
>  	ssize_t ret;
> @@ -449,7 +449,7 @@ static void report_last_gc_error(void)
>  		if (errno == ENOENT)
>  			goto done;
>  
> -		die_errno(_("cannot stat '%s'"), gc_log_path);
> +		return error_errno(_("cannot stat '%s'"), gc_log_path);
>  	}
>  
>  	if (st.st_mtime < gc_log_expire_time)
> @@ -457,9 +457,9 @@ static void report_last_gc_error(void)
>  
>  	ret = strbuf_read_file(&sb, gc_log_path, 0);
>  	if (ret < 0)
> -		die_errno(_("cannot read '%s'"), gc_log_path);
> +		return error_errno(_("cannot read '%s'"), gc_log_path);
>  	if (ret > 0)
> -		die(_("The last gc run reported the following. "
> +		return error(_("The last gc run reported the following. "
>  			       "Please correct the root cause\n"
>  			       "and remove %s.\n"
>  			       "Automatic cleanup will not be performed "
> @@ -469,6 +469,7 @@ static void report_last_gc_error(void)
>  	strbuf_release(&sb);
>  done:
>  	free(gc_log_path);
> +	return 0;
>  }
>  
>  static void gc_before_repack(void)
> @@ -561,7 +562,12 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
>  		}
>  		if (detach_auto) {
> -			report_last_gc_error(); /* dies on error */
> +			if (report_last_gc_error())
> +				/*
> +				 * A previous gc failed. We've reported the
> +				 * error, so there's nothing left to do.
> +				 */
> +				return 0;
>  
>  			if (lock_repo_for_gc(force, &pid))
>  				return 0;
> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index c474a94a9f..3e62df616c 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -116,11 +116,11 @@ test_expect_success 'background auto gc does not run if gc.log is present and re
>  	test_config gc.autopacklimit 1 &&
>  	test_config gc.autodetach true &&
>  	echo fleem >.git/gc.log &&
> -	test_must_fail git gc --auto 2>err &&
> -	test_i18ngrep "^fatal:" err &&
> +	git gc --auto 2>err &&
> +	test_i18ngrep "^error:" err &&
>  	test_config gc.logexpiry 5.days &&
>  	test-tool chmtime =-345600 .git/gc.log &&
> -	test_must_fail git gc --auto &&
> +	git gc --auto &&
>  	test_config gc.logexpiry 2.days &&
>  	run_and_wait_for_auto_gc &&
>  	ls .git/objects/pack/pack-*.pack >packs &&
