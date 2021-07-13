Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41395C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 18:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D85C61375
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 18:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhGMSMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 14:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhGMSMD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 14:12:03 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19631C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 11:09:12 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id hc15so4595608ejc.4
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 11:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Rw/bA9Lt2RJqUIBZltiY89uXQYB2EN+Km+piggfm50s=;
        b=hrCAhcTG5/XcQUlDy+SOR9Se9pNru2AxaK2dfm2PXFlz7bidMyM0yRbdHL5IH1lmxZ
         7dF5hEAcjJdIYnhE6z1Lk+UrMWr9BmXUOSmlddiiSl4ubW6vjDeFus3cGcNTDkmSGmV9
         LzOAeMio2PKTVAHNvBTrPAbVgQm4WeOzOrnuoaokmqmByA8Thiqxow6EeVekcNC+4Crv
         OIMR/hChxHQak3EknX+dCerwcFkuNQIWG7N/LUmVyKdccwQpqpbBALsNbTOLU9xLAmLy
         2SU0CnocmZKnsTrC5QlNDfb18vkm5ai9DgfeoIlm/fTK7eJXS6zqIMATB2M8qFG7SS+c
         96xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Rw/bA9Lt2RJqUIBZltiY89uXQYB2EN+Km+piggfm50s=;
        b=k5kesIlTzK3KONgY7iDcF+V3Sj4zvSBAdPRnKTnkEfR7B9L34X28gNaSLWGdhy7jx4
         mGWsnqaI3bdClfvd4VtI/2k2ObuOUSMhM7GJjochHoy5RVzf04Ytk406OzZ0ywGlc4J4
         VGzM7vKYYiTCtDHvHaEXo2paj/uk3G8FykXQFyDaCNufiSfgsIJuBHkfFWI2CC+BEnsO
         GDRLNi76ZMl+cZXXkob6iV0u1MKix/WjI+J3b/nj6NT9OwaD2YDHX7BmzBs0rKBu4RmF
         7sKV/A4wqTph9PYXfM21Q+PCFLT2r2s2s2++iJEqKyS8vp+xenup4Aw+3SUVbCnaUKwA
         kffA==
X-Gm-Message-State: AOAM5328eH742k5jDnFTI3H92fIJs1n79bVEbhqeirc1mUGn0VpdC+py
        jA/FTbT+HJLX8ec3vbqqMAk=
X-Google-Smtp-Source: ABdhPJzhGJc92cIqQnZCzlP1TV0X3/J3u0QJPv0zU3pC6arHiCQqpgFavhe9R98drtKF5RO70CaJpQ==
X-Received: by 2002:a17:906:72d0:: with SMTP id m16mr7283078ejl.36.1626199750427;
        Tue, 13 Jul 2021 11:09:10 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d2sm8245173ejo.13.2021.07.13.11.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 11:09:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 14/34] fsmonitor--daemon: implement 'start' command
Date:   Tue, 13 Jul 2021 19:54:57 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <9fe902aad87f1192705fb69ea212a2d066d0286d.1625150864.git.gitgitgadget@gmail.com>
 <87a6n5d600.fsf@evledraar.gmail.com>
 <80fb703d-0f88-110e-5a5c-e8e9a90bbc17@jeffhostetler.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <80fb703d-0f88-110e-5a5c-e8e9a90bbc17@jeffhostetler.com>
Message-ID: <87sg0i2iid.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 13 2021, Jeff Hostetler wrote:

> My response here is in addition to Dscho's remarks on this topic.
> He makes excellent points that I'll just #include here.  I do want
> to add my own $0.02 here.
>
> On 7/1/21 6:18 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
>>=20
>>> +#ifdef GIT_WINDOWS_NATIVE
>>> +/*
>>> + * Create a background process to run the daemon.  It should be comple=
tely
>>> + * disassociated from the terminal.
>>> + *
>>> + * Conceptually like `daemonize()` but different because Windows does =
not
>>> + * have `fork(2)`.  Spawn a normal Windows child process but without t=
he
>>> + * limitations of `start_command()` and `finish_command()`.
>>> + *
>>> + * The child process execs the "git fsmonitor--daemon run" command.
>>> + *
>>> + * The current process returns so that the caller can wait for the chi=
ld
>>> + * to startup before exiting.
>>> + */
>>> +static int spawn_background_fsmonitor_daemon(pid_t *pid)
>>> +{
>>> +	char git_exe[MAX_PATH];
>>> +	struct strvec args =3D STRVEC_INIT;
>>> +	int in, out;
>>> +
>>> +	GetModuleFileNameA(NULL, git_exe, MAX_PATH);
>>> +
>>> +	in =3D open("/dev/null", O_RDONLY);
>>> +	out =3D open("/dev/null", O_WRONLY);
>>> +
>>> +	strvec_push(&args, git_exe);
>>> +	strvec_push(&args, "fsmonitor--daemon");
>>> +	strvec_push(&args, "run");
>>> +	strvec_pushf(&args, "--ipc-threads=3D%d", fsmonitor__ipc_threads);
>>> +
>>> +	*pid =3D mingw_spawnvpe(args.v[0], args.v, NULL, NULL, in, out, out);
>>> +	close(in);
>>> +	close(out);
>>> +
>>> +	strvec_clear(&args);
>>> +
>>> +	if (*pid < 0)
>>> +		return error(_("could not spawn fsmonitor--daemon in the background"=
));
>>> +
>>> +	return 0;
>>> +}
>>> +#else
>>> +/*
>>> + * Create a background process to run the daemon.  It should be comple=
tely
>>> + * disassociated from the terminal.
>>> + *
>>> + * This is adapted from `daemonize()`.  Use `fork()` to directly
>>> + * create and run the daemon in the child process.
>>> + *
>>> + * The fork-child can just call the run code; it does not need to exec
>>> + * it.
>>> + *
>>> + * The fork-parent returns the child PID so that we can wait for the
>>> + * child to startup before exiting.
>>> + */
>>> +static int spawn_background_fsmonitor_daemon(pid_t *pid)
>>> +{
>>> +	*pid =3D fork();
>>> +
>>> +	switch (*pid) {
>>> +	case 0:
>>> +		if (setsid() =3D=3D -1)
>>> +			error_errno(_("setsid failed"));
>>> +		close(0);
>>> +		close(1);
>>> +		close(2);
>>> +		sanitize_stdfds();
>>> +
>>> +		return !!fsmonitor_run_daemon();
>>> +
>>> +	case -1:
>>> +		return error_errno(_("could not spawn fsmonitor--daemon in the backg=
round"));
>>> +
>>> +	default:
>>> +		return 0;
>>> +	}
>>> +}
>>> +#endif
>> The spawn_background_fsmonitor_daemon() function here is almost the
>> same
>> as daemonize(). I wonder if this & the Windows-specific one you have
>> here can't be refactored into an API from what's now in setup.c.
>> Then we could make builtin/gc.c and daemon.c use that, so Windows
>> could
>> have background GC, and we'd have a more battle-tested central codepath
>> for this tricky bit.
>>=20
>
> I'd rather not refactor all of this and add unnecessary generality
> and complexity just to save duplicating some of the code in daemonize().
>
> And I'd rather not destabilize existing commands like gc and daemon
> by changing the daemonize() layer on them.  If those commands need help,
> let's have a separate conversation _later_ about what help they need
> and if it makes sense to combine them.

Johannes suggested in
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2107052336480.8230@tvgsbejvaq=
bjf.bet/
that (if I understand that correctly, and I just skimmed the linked isse
some days ago), that even if such a refactoring was done these two
functions are solving subtly different problems, or something. I.e. we
couldn't use it for daemonize().

Which I'd say is interesting for the code comments/commit message at
least, i.e. how they're solving subtly different problems (not being
able to run this & not being able to test on Windows I haven't poked at
it myself).

>> It seems to me like the only limitations on it are to have this return
>> slightly more general things (e.g. not set its own errors, return
>> structured data), and maybe some callback for what to do in the
>> child/parent.
>
> There are several issues here when trying to start a background process
> and we're already on the edge of the behavioral differences between
> Windows and Unix -- let's not make things more confusing with multiple
> callbacks, returning structures, custom errors, and etc.
>
> Also, since Windows doesn't do fork(), we don't have child/parent
> branches in the call, so this whole "just pretend it's all Unix"
> model doesn't work.

Fair enough, And I think replied-to above.

> Even if we did pretend I'd still need ifdef'd callback routines to
> either call `fsmonitor_run_daemon()` or build a command line (or have
> blocks of functions that "just happen to never be called on one
> platform or the other").
>
>
> What I have here is an API that the primary (read: parent) calls
> and gets back a 0 or -1 (with error message).  And that's it.
> The primary can then wait for the child (whether from fork or
> CreateProcess) to become responsive or fail to start.  And then
> the primary can exit (with or without error).
>
> So I think we're good.  Yes, there is an ifdef here, but I think
> it is worth it.

FWIW what I was noting here & elsewhere is that yes, you need to ifdef
some of it, but the code you're proposing to add here is using a
different pattern than the one generally preferred in this codebase.

I.e. check out how we do it for threading, we intentionally compile the
"if (thread) {code}" clauses on platforms we know don't have threading,
ditto the code around PCRE in grep.c.=20

Similarly, here in e.g. spawn_background_fsmonitor_daemon just the
GetModuleFileNameA() and mingw_spawnvpe() are Windows-specifics (and
could be calls to some helper that *is* ifdef'd).

In this case it's not a big deal, but as a general pattern it helps to
e.g. avoid subtle syntax errors in nested ifdefs and the like, and
generally encourages keeping the ifdef'd code as small as possible.

>>> +/*
>>> + * This is adapted from `wait_or_whine()`.  Watch the child process and
>>> + * let it get started and begin listening for requests on the socket
>>> + * before reporting our success.
>>> + */
>>> +static int wait_for_background_startup(pid_t pid_child)
>>> +{
>>> +	int status;
>>> +	pid_t pid_seen;
>>> +	enum ipc_active_state s;
>>> +	time_t time_limit, now;
>>> +
>>> +	time(&time_limit);
>>> +	time_limit +=3D fsmonitor__start_timeout_sec;
>>> +
>>> +	for (;;) {
>>> +		pid_seen =3D waitpid(pid_child, &status, WNOHANG);
>>> +
>>> +		if (pid_seen =3D=3D -1)
>>> +			return error_errno(_("waitpid failed"));
>>> +		else if (pid_seen =3D=3D 0) {
>>> +			/*
>>> +			 * The child is still running (this should be
>>> +			 * the normal case).  Try to connect to it on
>>> +			 * the socket and see if it is ready for
>>> +			 * business.
>>> +			 *
>>> +			 * If there is another daemon already running,
>>> +			 * our child will fail to start (possibly
>>> +			 * after a timeout on the lock), but we don't
>>> +			 * care (who responds) if the socket is live.
>>> +			 */
>>> +			s =3D fsmonitor_ipc__get_state();
>>> +			if (s =3D=3D IPC_STATE__LISTENING)
>>> +				return 0;
>>> +
>>> +			time(&now);
>>> +			if (now > time_limit)
>>> +				return error(_("fsmonitor--daemon not online yet"));
>>> +		} else if (pid_seen =3D=3D pid_child) {
>>> +			/*
>>> +			 * The new child daemon process shutdown while
>>> +			 * it was starting up, so it is not listening
>>> +			 * on the socket.
>>> +			 *
>>> +			 * Try to ping the socket in the odd chance
>>> +			 * that another daemon started (or was already
>>> +			 * running) while our child was starting.
>>> +			 *
>>> +			 * Again, we don't care who services the socket.
>>> +			 */
>>> +			s =3D fsmonitor_ipc__get_state();
>>> +			if (s =3D=3D IPC_STATE__LISTENING)
>>> +				return 0;
>>> +
>>> +			/*
>>> +			 * We don't care about the WEXITSTATUS() nor
>>> +			 * any of the WIF*(status) values because
>>> +			 * `cmd_fsmonitor__daemon()` does the `!!result`
>>> +			 * trick on all function return values.
>>> +			 *
>>> +			 * So it is sufficient to just report the
>>> +			 * early shutdown as an error.
>>> +			 */
>>> +			return error(_("fsmonitor--daemon failed to start"));
>>> +		} else
>>> +			return error(_("waitpid is confused"));
>>> +	}
>>> +}
>> Ditto this. could we extend the wait_or_whine() function (or some
>> extended version thereof) to do what you need with callbacks?
>> It seems the main difference is just being able to pass down a flag
>> for
>> waitpid(), and the loop needing to check EINTR or not depending on
>> whether WNOHANG is passed.
>> For e.g. the "We don't care about the WEXITSTATUS()" you'd get that
>> behavior with an adjusted wait_or_whine(). Wouldn't it be better to
>> report what exit status it exits with e.g. if the top-level process is
>> signalled? We do so in trace2 for other things we spawn...
>>=20
>
> Again, I don't want to mix my usage here with the existing code
> and destabilize all existing callers.  Here we are spinning to give
> the child a chance to *start* and confirm that it is in a listening
> state and ready for connections.  We do not wait for the child to
> exit (unless it dies quickly without becoming ready).
>
> We want to end our wait as soon as we confirm that the child is
> ready and return.  All I really need from the system is `waitpid()`.

Will this code behave correctly if the daemon we start is signalled per
the WIFSIGNALED() cases the code this is derived handles, but this does
not?

But sure, I just meant to point out that the flip side to "destabilize
all existing callers" is reviewing new code that may be subtly buggy,
and those subtle bugs (if any) would be smoked out if we were forced to
extend run-command.c, i.e. to use whatever feature(s) this needs for all
existing callers.
