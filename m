Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E17C32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 00:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E2822464
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 00:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAof53JC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgAPAj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 19:39:58 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:33803 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgAPAj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 19:39:58 -0500
Received: by mail-ed1-f53.google.com with SMTP id l8so17315837edw.1
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 16:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JxUy3OmFvVL1ewOxJ9hVIWD8KTG526TsDEfJ/B3WYH0=;
        b=oAof53JCsBdaioZXLuGQeVrW38DmhusH5vJ7n+6syF+Q30wG02HYLE+ALis13QRX0s
         9uk3H6Vo8WdvdLvNY7cw6p2eGWg3DOSrD0M2IWPxbY9SoiHj8mCZ/oQrNJ7UFr41fHko
         SRx5Zxq8BQsxq+7M00fi0PlDzB7NlHsPOL4G4vVHnco0es8dAHAfJn79f+8WiNHQXAZ2
         tivUYh/8rjiQB7bOgExTH8ncttpxHl+sP6iJaC7wI4spLBh9gBZZV1QKDmguX7W0DGUY
         F3o8fJu4PGgl5MKrE61gL3r2Zjo0TnjGLKTgoGgMuq2QoWvTCxtDIlaLBbi7cdseQ3fB
         LTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JxUy3OmFvVL1ewOxJ9hVIWD8KTG526TsDEfJ/B3WYH0=;
        b=V1YAbD5LmMxWu9UzzIhVDugi3L6Qv5jF3ZERRb+wy3CQ1JGWelD/New7J5BbhXRSOP
         kNMKJH9yLOzhE7qBODf1NZbZ7rBnhDlQwA/Go/03ey+zo4w2jHJ/3f0Sz2zVEFFpwvel
         OeFsQIgkb3ClDpHnOcN2z2Nl/qRjAyNrFW/uegwT4930vgI20gRlZLpUWnbH02TlqENw
         NyYvsewi0eZrGveResLoZ/MYXEofbWr5zRgcLzCYU14QeyqtU1NUrpeKvKvWqWB43YR2
         T7ptUYCmIGu+1MQrGg58x2OD8NbvxL9AqEcF8WSmqIW70ibvlRuAdHf9mi/HBKxXzv4p
         pHSw==
X-Gm-Message-State: APjAAAX3atYz0ZGfw+VW5Mbpij02otp8fFQ33v7nyRsZ30N6GTFI96C8
        XNyEqyGuEtQ8ByvhBAQveRhlxz+x+88qSADowlM=
X-Google-Smtp-Source: APXvYqxdYV6bAXkPuZDz9AwnGM/zPWVQv9I1heVpyziAcg+sYF9lPjBthpiI18ME8iTqdSf78IjBADGP+PHjuom4rCI=
X-Received: by 2002:a50:f382:: with SMTP id g2mr33720786edm.260.1579135195645;
 Wed, 15 Jan 2020 16:39:55 -0800 (PST)
MIME-Version: 1.0
References: <CAD_xR9f7jHnCByOaOVJvxdW2c5dPHM8OUDwZhcPL1iTVR3NzmQ@mail.gmail.com>
In-Reply-To: <CAD_xR9f7jHnCByOaOVJvxdW2c5dPHM8OUDwZhcPL1iTVR3NzmQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 16 Jan 2020 01:39:44 +0100
Message-ID: <CAP8UFD3dr3XdZSm88qoGDajSoFMx-TJZfxsMGqhFMKA6dEWj4A@mail.gmail.com>
Subject: Re: [RFC] Proposal: New options for git bisect run to control the
 interpretation of exit codes
To:     Stephen Oberholtzer <stevie@qrpff.net>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 11, 2020 at 2:43 AM Stephen Oberholtzer <stevie@qrpff.net> wrote:
>
> After considering the responses I got for my --invert-status proposal, I
> went back to the drawing board and considered how it might interact with
> another feature I was going to propose.  This is the result.
>
> To avoid repeating myself, I'm going to start with an example of what I
> imagine putting into Documentation/git-bisect.txt, to document this
> feature.  After the second snip line, you can find my justification for
> this feature, as well as some preemptive answers to questions I expect
> people to have.

Ok.

> >8----------------------------------------------------------------------8<
>
> {at top}
>
> git bisect run [--(old|good|<term-old>)-status=<list>]
> [--(new|bad|<term-new>)-status=<list>]
> [--skip-status=<list>] [--] <cmd>...

That seems interesting.

In many cases I have found that something like the following would do:

git bisect run sh -c "make || exit 125; setup_script || exit 255;
run_cmd >log 2>&1 || exit 255; (! grep foo log)"

but I understand that some people may prefer options like the one you suggest.

> {below the paragraph beginning with "The special exit code 125")
>
> Custom exit status mappings
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> The previous paragraphs describe how the exit status of <cmd> is mapped
> to one of four actions:
>
>  * `old`/`good`, which defaults to exit status 0.
>
>  * `new`/`bad`, which defaults to exit status 1-127 except 125.
>
>  * `skip`, which defaults to exit status 125.
>
>  * Any status not mapped to one of the first three is treated as a fatal
>    error, causing `git bisect run` to immediately terminate with a
>    nonzero exit status.
>
> For more precise control over bisect run's interpretation of the command's
> exit status, you can use one or more `--<term>-status=<list>` options:
>
> <term>::
>   One of the following:
>   * `skip` (`--skip-status`)
>   * `old` or the corresponding term specified in the bisect start call
>      (`--old-status` or `--good-status`)
>   * `new` or the corresponding term specified in the bisect start call
>      (`--new-status` or `--bad-status`)
> <list>::
> A comma-separated list of values (e.g. 1) or ranges (e.g. 1-10).
>
> (It should be noted that specifying --old-status is unlikely to be useful
> without a corresponding --new-status option.)

This is not clear from what has been documented above.

> This feature can make a few things much easier:
>
>  * If you want to bisect a "fix", you can use (as an example)
>
> ---------------
> $ git bisect run --old-status=1-127 --new-status=0 my_script arguments
> ---------------

Yeah, that seems useful. It is not clear though if 125 then means
"old" or still "skip".

>  * If the test involves some fundamentally-unreliable aspects such as I/O
>   (for example, a network connection could be disrupted, or a file write
>    could fail due to disk space issues), you can specify something like
>    --new-status=99, and then any exit status other than 0 or 99 will be
>    treated as a fatal error:
>
>    -----------------
>    $ git bisect run --new-status=99 sh -c 'setup-test && (run-test || exit 99)'
>    -----------------
>
>    If setup-test exits with a nonzero status code (except 99), then the
>    run will abort with an error, rather than assume that the current commit
>    contains the issue being bisected.

Yeah but `sh -c 'setup-test || exit 255; run-test'` should work fine
in this case too.

> The default status code lists are as follows:
>   --skip-status=125
>   --old-status=0
>   --new-status=1-127
>
> The priority of each classification is as follows:
>
>  * If the status code is on the --skip-status list, the action is "skip".
>    Note that this takes precedence over the --old-status and --new-status
>    lists; doing so simplifies the specification of --new-status.
>
>  * If the status is on the --old-status list, *and* not on the --new-status
>    list, the action is "old" (or "good").
>
>  * If the status is on the --new-status list, *and* not on the --old-status
>    list, the action is "new" (or "bad").

The above doesn't tell what happens if a status is both on the
--old-status and on the --new-status lists...

>  * Otherwise, the command is treated as having experienced a fatal error,
>    and run will terminate with a nonzero exit status.

...so it seems that it is an error only when such a status code is
actually received by `git bisect run`.

Some people could argue though that `--new-status=0 --old-status=0`
should be detected as an error as soon as `git bisect run` is
launched.

> In the last case, the bisection will be left where it was; you may correct
> the error and perform another bisect run, or you may finish the bisection
> with manual good/bad commands.

It would be nice if the above clarification about priority was before
the examples you gave.

> >8----------------------------------------------------------------------8<
>
> The motivation
> ==============
>
> First, an excerpt from the current documentation for 'git bisect':
>
> > 126 and 127 are used by POSIX shells to signal specific error status
> > (127 is for command not found, 126 is for command found but not executable
> > - these details do not matter, as they are normal errors in the script,
> > as far as bisect run is concerned
>
> This shows a fundamental disconnect between bisect run's view of the
> world and reality.  I submit that, in reality, status codes 126 and 127 are
> overwhelmingly likely indicators that the script did not work correctly,
> in which case the run should be halted so the user may correct the issue.

Well when bisect run was implemented the main concern was to make it
abort immediately in case of a signal and to consider common non zero
status code as "bad". A signal would result in an status code greater
than 128, so it was decided to split the [1-255] range in two more or
less equal parts, so [1-128] would be "bad" and [129-255] would be
"abort". Then "split" was added and given special code 125.

> However, 126 and 127 are mapped to "git bisect bad" -- as in, "this commit
> definitely contains the bug that I am searching for".

Yeah, it might have been better to use [126-255] for "abort".

I think though that 126 and 127 should still be rare. And git bisect
might be used to debug software written in shell (Git itself had many
commands written in shell a long time ago) where 126 or 127 could come
from errors in the software itself not from the testing scripts.

> Let's consider the consequences of an inappropriate status code:
>
> - 'good':  The bisect will incorrectly select the wrong commit (specifically,
>   a later commit than the one that actually introduced the issue.)
>
>   This will also indirectly result in more trials than would otherwise be
>   necessary to determine the result, because the bisection will have to be
>   restarted at the point where the mistake occurred.  (In the worst possible
>   case, where a mistake occurs on the first step, the bisection will take
>   at least twice as long.)
>
> - 'bad': The bisect will incorrectly select the wrong commit (specifically,
>   an earlier commit than the one that actually introduced the issue.)
>
>   Like 'good', this will also indirectly result in extra trials.
>
> - 'skip': The bisect will unnecessarily test at least one extra commit for
>   each false 'skip' result.  In the worst case, it may not be able to narrow
>   down the issue to a single commit.
>
> - Abort: The bisection stops until the user restarts it.  No extra commits
>   are tested, though if the user isn't paying attention, the wallclock
>   time will take longer than usual.
>
> In particular, the behavior of a false match on 'good' or 'bad' is *at best*
> extra time needed to do the bisection.  At worst -- if the user is not
> familiar with the code in question -- a great deal of confusion and time-
> wasting can result as the user investigates the wrong commit.  As such, it
> is critical that you have no false 'good' or 'bad' results.

I agree with that.

> If you're using a shell script to run your test, a false 'good' result can
> easily be prevented by putting 'set -e' at the top of the script.

Sometimes it is easier to understand a script when it properly checks
for errors and produces good error messages than when it uses `set
-e`.

> Avoiding a false 'bad' result is far more difficult, especially if the test
> is complex and you're not familiar with shell scripting in general.  (The
> man page for bash, on my machine, is 3725 lines long, and does not lend
> itself well to searching.)  For the task that set me down this path, it
> took me about six iterations to create a robust script that would return
> the exit code that git wanted,  and _it still didn't work right in all
> cases_.

I agree that it is not always easy.

> What would have been a great deal simpler is if I could have just picked
> an exit code that none of the other commands in my script would ever
> return (such as 99), and told git to treat any code other than 0 or 99 as
> a fatal error.  Which is essentially what I ended up doing (or trying to),
> but unfamiliar with shell scripting as I was, I had several issues.

I think there might have been easier ways.

See above the alternative I suggested to `git bisect run
--new-status=99 sh -c 'setup-test && (run-test || exit 99)'`.

> If I can make it easy for someone to use bisect run without them having
> to learn any otherwise-unnecessary shell scripting constructs, I would
> consider that a win.

I agree that in some cases the options you suggest could seem simpler
for some people.

> Pre-emptive Q&A
> ===============

Thanks for this!

Best,
Christian.
