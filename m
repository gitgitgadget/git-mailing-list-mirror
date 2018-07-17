Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B39CE1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 08:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbeGQJba (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 05:31:30 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35907 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbeGQJba (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 05:31:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id t3-v6so559054eds.3
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 01:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=sBZfpF+tMCWOftRyjIUfrzntVl8CxS7UYbTe8SRZTro=;
        b=UBOUhTM87gwrwNU0o5VviWn1jw8JsGSMmaYXaU5MX1iouG4BdbCoJaRZ8xbrn/l7WW
         OGRKVwHTeEIFDM9mlZT0PUVfAyBMEJdZrhSwf8BGhE1j+H/3kQMa4Hf7gLUT98Z/in51
         /jXEmyw09dfHgpgHn/RTLOQeAEacqbRMXROB1y9JIEazIyV2LpLxRlS2lNKIxisaWJF1
         Bcu+PypQWsk3dvi9Edxg6D2dcO+u102ED6lGJyuNiXmFOWEZeX99dHheSPlPHLC0lUTv
         2Xp1IY/HarlCeg+taOhLOYfDesUdAi6bz5gJab1JMVwhNEdi3k/sbYCssPaeZjrmYPKy
         K+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=sBZfpF+tMCWOftRyjIUfrzntVl8CxS7UYbTe8SRZTro=;
        b=KkI5+vVaeB4EZuEAOJ3QZLsUW8cfd2+8nEo+p9JuAnGcMcmLHhvsrNX0ybLmcr6Alp
         59DuJmOCoEWHV9v6ng4+RHeEcvbo5KHGWw8cehOlUq/Ruau1shavO8bKDq1lq/ZvZ/Jx
         rKKyqzTSayKsd0pui29e5qXpiVx2dWf5S5FuoaNM4EdR+r++0QQ89Q7RnXObSaRG3TEr
         ExXzndrX7U6D/h9IDSHWW5KqYRBdBa8Ac/UCV9ONvZfGUwJk9XRbglby9ny4hIlFOV01
         4MitBhwCZH9zVcO9hxlF7tPknc20YyWVXD3v4AJX24e25v+vQmlHOmxH0YXwiXpUT9vP
         wRjg==
X-Gm-Message-State: AOUpUlFrIf2FxXZJVZl2bkX8jeWZNLpS55X4h8pvsmR6EClwIfbmJ4c5
        w7e9xQMO/gwfMBDwP4aNAEBMkHfw
X-Google-Smtp-Source: AAOMgpdwG+VvZukaHRroD+8/lqX3lxfege/EdSkvxVEZnPr+8WGj+hRdQU8yxRv4Imj4OnM2wxNDDA==
X-Received: by 2002:a50:9ece:: with SMTP id a72-v6mr1472706edf.92.1531817993116;
        Tue, 17 Jul 2018 01:59:53 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id l91-v6sm263143edl.22.2018.07.17.01.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 01:59:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
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
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180717015339.GL11513@aiede.svl.corp.google.com>
Date:   Tue, 17 Jul 2018 10:59:50 +0200
Message-ID: <87d0vmck55.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 17 2018, Jonathan Nieder wrote:

> Hi,
>
> Jeff King wrote:
>> On Mon, Jul 16, 2018 at 03:56:39PM -0700, Jonathan Nieder wrote:
>
>>> The calling command in the motivating example is Android's "repo" tool:
>>>
>>>             bare_git.gc('--auto')
>>>
>>> from https://gerrit-review.googlesource.com/c/git-repo/+/10598/.  I
>>> think it's reasonable that it expects a status code of 0 in the normal
>>> case.  So life is less simple than I hoped.
>>
>> IMHO it should ignore the return code, since that's what Git does
>> itself. And at any rate, you'd miss errors from daemonized gc's (at
>> least until the _next_ one runs and propagates the error code).

I've read this whole thread, and as Peff noted I've barked up this
particular tree before[1] without coming up with a solution myself.

So please don't take the following as critique of any way of moving
forward, I'm just trying to poke holes in what you're doing to make sure
we don't have regressions to the currently (sucky) logic.

> That suggests a possible improvement.  If all callers should be
> ignoring the exit code, can we make the exit code in daemonize mode
> unconditionally zero in this kind of case?

That doesn't make sense to me. Just because git itself is happily
ignoring the exit code I don't think that should mean there shouldn't be
a meaningful exit code. Why don't you just ignore the exit code in the
repo tool as well?

Now e.g. automation I have to see if git-gc ---auto is having issues
can't just be 'git gc --auto || echo fail @ {hostname}' across a fleet
of servers, but will need to start caring if stderr was emitted to.

I don't care if we e.g. have a 'git gc --auto --exit-code' similar to
what git-diff does, but it doesn't make sense to me that we *know* we
can't background the gc due to a previous error and then always return
0. Having to parse STDERR to see if it *really* failed is un-unixy,
let's use exit codes. That's what they're for.

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

I think you're conflating two things here in a way that (if I'm reading
this correctly) produces a pretty bad regression for users.

 a) If we have something in the gc.log we keep yelling at users until we
    reach the gc.logExpiry, this was the subject of my thread back in
    January. This sucks, and should be fixed somehow.

    Maybe we should only emit the warning once, e.g. creating a
    .git/gc.log.wasemitted marker and as long as its ctime is later than
    the mtime on .git/gc.log we don't emit it again).

    But that also creates the UX problem that it's easy to miss this
    message in the middle of some huge "fetch" output. Perhaps we should
    just start emitting this as part of "git status" or something (or
    solve the root cause, as Peff notes...).

 b) We *also* use this presence of a gc.log as a marker for "we failed
    too recently, let's not try again until after a day".

The semantics of b) are very useful, and just because they're tied up
with a) right now, let's not throw out b) just because we're trying to
solve a).

We have dev machines with limited I/O & CPU/memory that occasionally
break the gc.auto limit, I really don't want those churning a background
"git gc" on every fetch/commit etc. until we're finally below the
gc.auto limit (possibly days later), which would be a side-effect of
printing the .git/gc.log once and then removing it.

> To solve (3), we could
> introduce a gc.lastrun file that is touched whenever "gc --auto" runs
> successfully and make "gc --auto" a no-op for a while after each run.

This would work around my concern with b) above in most cases by
introducing a purely time-based rate limit, but I'm uneasy about this
change in git-gc semantics.

Right now one thing we do right is we always try to look at the actual
state of the repo with too_many_packs() and too_many_loose_objects().

We don't assume the state of your repo hasn't drastically changed
recently. That means that we do the right thing and gc when the repo
needs it, not just because we GC'd recently enough.

With these proposed semantics we'd skip a needed GC (potentially for
days, depending on the default) just because we recently ran one.

In many environments, such as on busy servers, we could have tens of
thousands of packs by this point, since this facility would (presumably)
bypass both gc.autoPackLimit and gc.auto in favor of only running gc at
a maximum of every N minutes, similarly in a local checkout I could have
a crapload of loose objects because I ran a big rebase or a
filter-branch on one of my branches.

1. https://public-inbox.org/git/87inc89j38.fsf@evledraar.gmail.com/

> -- >8 --
> Subject: gc: do not return error for prior errors in daemonized mode
>
> Some build machines started failing to fetch updated source using
> "repo sync", with error
>
>   error: The last gc run reported the following. Please correct the root cause
>   and remove /build/.repo/projects/tools/git.git/gc.log.
>   Automatic cleanup will not be performed until the file is removed.
>
>   warning: There are too many unreachable loose objects; run 'git prune' to remove them.
>
> The cause takes some time to describe.
>
> In v2.0.0-rc0~145^2 (gc: config option for running --auto in
> background, 2014-02-08), "git gc --auto" learned to run in the
> background instead of blocking the invoking command.  In this mode, it
> closed stderr to avoid interleaving output with any subsequent
> commands, causing warnings like the above to be swallowed; v2.6.3~24^2
> (gc: save log from daemonized gc --auto and print it next time,
> 2015-09-19) addressed this by storing any diagnostic output in
> .git/gc.log and allowing the next "git gc --auto" run to print it.
>
> To avoid wasteful repeated fruitless gcs, when gc.log is present, the
> subsequent "gc --auto" would die after print its contents.  Most git
> commands, such as "git fetch", ignore the exit status from "git gc
> --auto" so all is well at this point: the user gets to see the error
> message, and the fetch succeeds, without a wasteful additional attempt
> at an automatic gc.
>
> External tools like repo[1], though, do care about the exit status
> from "git gc --auto".  In non-daemonized mode, the exit status is
> straightforward: if there is an error, it is nonzero, but after a
> warning like the above, the status is zero.  The daemonized mode, as a
> side effect of the other properties provided, offers a very strange
> exit code convention:
>
>  - if no housekeeping was required, the exit status is 0
>
>  - the first real run, after forking into the background, returns exit
>    status 0 unconditionally.  The parent process has no way to know
>    whether gc will succeed.
>
>  - if there is any diagnostic output in gc.log, subsequent runs return
>    a nonzero exit status to indicate that gc was not triggered.
>
> There's nothing for the calling program to act on on the basis of that
> error.  Use status 0 consistently instead, to indicate that we decided
> not to run a gc (just like if no housekeeping was required).  This
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
