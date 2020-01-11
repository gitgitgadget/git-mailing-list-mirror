Return-Path: <SRS0=hslh=3A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC6DC282DD
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 01:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD67020721
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 01:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qrpff.net header.i=@qrpff.net header.b="OQvR2Arp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgAKBvm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 20:51:42 -0500
Received: from bonobo.elm.relay.mailchannels.net ([23.83.212.22]:61324 "EHLO
        bonobo.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727980AbgAKBvm (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Jan 2020 20:51:42 -0500
X-Sender-Id: dreamhost|x-authsender|stevie@qrpff.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6DFE15001C4
        for <git@vger.kernel.org>; Sat, 11 Jan 2020 01:42:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a30.g.dreamhost.com (100-96-4-61.trex.outbound.svc.cluster.local [100.96.4.61])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D4C26500772
        for <git@vger.kernel.org>; Sat, 11 Jan 2020 01:42:53 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|stevie@qrpff.net
Received: from pdx1-sub0-mail-a30.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.5);
        Sat, 11 Jan 2020 01:42:54 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|stevie@qrpff.net
X-MailChannels-Auth-Id: dreamhost
X-Ski-Share: 4ff9a5d679e09fdc_1578706974126_113747664
X-MC-Loop-Signature: 1578706974126:2021237824
X-MC-Ingress-Time: 1578706974126
Received: from pdx1-sub0-mail-a30.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a30.g.dreamhost.com (Postfix) with ESMTP id 9B885B1CA4
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 17:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=qrpff.net; h=mime-version
        :from:date:message-id:subject:to:cc:content-type; s=qrpff.net;
         bh=vEHBQyX9PHKz+UMPBd70LxAXWmg=; b=OQvR2ArpyC1EMHxudznkFjn93yrH
        165KegGZS2h7GFXAPrAz2oVEmgTuCkh0XoCBounRe4kcYrdDrg8LGIs+H0BANctg
        vwf/2PtjOOeOdWds81qik5mBrHDS3QjuLL1zi4BGjgfKARPaDoRzvReu7+bM4Sks
        e5dCRMHgg6eBHPU=
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stevie@qrpff.net)
        by pdx1-sub0-mail-a30.g.dreamhost.com (Postfix) with ESMTPSA id 3745AB1C9C
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 17:42:48 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id n25so2895136lfl.0
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 17:42:48 -0800 (PST)
X-Gm-Message-State: APjAAAUibaZFRRBOjJi/g7dTrsLPhR+CqCr2fmphtXxi7gTkOtVa7vS4
        tAb5Lna9wr7Jdz3BjSZ10oaZGPys/KX54I5azDQ=
X-Google-Smtp-Source: APXvYqwQttSkRTQEHos6wQ2RfQl0mBYog7lvPYeD1MTDxdgT11EDbAinfgKITenI5ZM1tOSR5dBIKBNJMVyP4yaIzSI=
X-Received: by 2002:a05:6512:488:: with SMTP id v8mr4217555lfq.173.1578706966226;
 Fri, 10 Jan 2020 17:42:46 -0800 (PST)
MIME-Version: 1.0
X-DH-BACKEND: pdx1-sub0-mail-a30
From:   Stephen Oberholtzer <stevie@qrpff.net>
Date:   Fri, 10 Jan 2020 20:42:35 -0500
X-Gmail-Original-Message-ID: <CAD_xR9f7jHnCByOaOVJvxdW2c5dPHM8OUDwZhcPL1iTVR3NzmQ@mail.gmail.com>
Message-ID: <CAD_xR9f7jHnCByOaOVJvxdW2c5dPHM8OUDwZhcPL1iTVR3NzmQ@mail.gmail.com>
Subject: [RFC] Proposal: New options for git bisect run to control the
 interpretation of exit codes
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 0
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdeigedgfeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucenucfjughrpegghfffkffuvfgtsehttdertddttdejnecuhfhrohhmpefuthgvphhhvghnucfqsggvrhhhohhlthiivghruceoshhtvghvihgvsehqrhhpfhhfrdhnvghtqeenucfkphepvddtledrkeehrdduieejrdegkeenucfrrghrrghmpehmohguvgepshhmthhppdhhvghlohepmhgrihhlqdhlfhduqdhfgeekrdhgohhoghhlvgdrtghomhdpihhnvghtpedvtdelrdekhedrudeijedrgeekpdhrvghtuhhrnhdqphgrthhhpefuthgvphhhvghnucfqsggvrhhhohhlthiivghruceoshhtvghvihgvsehqrhhpfhhfrdhnvghtqedpmhgrihhlfhhrohhmpehsthgvvhhivgesqhhrphhffhdrnhgvthdpnhhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After considering the responses I got for my --invert-status proposal, I
went back to the drawing board and considered how it might interact with
another feature I was going to propose.  This is the result.

To avoid repeating myself, I'm going to start with an example of what I
imagine putting into Documentation/git-bisect.txt, to document this
feature.  After the second snip line, you can find my justification for
this feature, as well as some preemptive answers to questions I expect
people to have.

>8----------------------------------------------------------------------8<

{at top}

git bisect run [--(old|good|<term-old>)-status=<list>]
[--(new|bad|<term-new>)-status=<list>]
[--skip-status=<list>] [--] <cmd>...

{below the paragraph beginning with "The special exit code 125")

Custom exit status mappings
^^^^^^^^^^^^^^^^^^^^^^^^^^^

The previous paragraphs describe how the exit status of <cmd> is mapped
to one of four actions:

 * `old`/`good`, which defaults to exit status 0.

 * `new`/`bad`, which defaults to exit status 1-127 except 125.

 * `skip`, which defaults to exit status 125.

 * Any status not mapped to one of the first three is treated as a fatal
   error, causing `git bisect run` to immediately terminate with a
   nonzero exit status.

For more precise control over bisect run's interpretation of the command's
exit status, you can use one or more `--<term>-status=<list>` options:

<term>::
  One of the following:
  * `skip` (`--skip-status`)
  * `old` or the corresponding term specified in the bisect start call
     (`--old-status` or `--good-status`)
  * `new` or the corresponding term specified in the bisect start call
     (`--new-status` or `--bad-status`)
<list>::
A comma-separated list of values (e.g. 1) or ranges (e.g. 1-10).

(It should be noted that specifying --old-status is unlikely to be useful
without a corresponding --new-status option.)

This feature can make a few things much easier:

 * If you want to bisect a "fix", you can use (as an example)

---------------
$ git bisect run --old-status=1-127 --new-status=0 my_script arguments
---------------

 * If the test involves some fundamentally-unreliable aspects such as I/O
  (for example, a network connection could be disrupted, or a file write
   could fail due to disk space issues), you can specify something like
   --new-status=99, and then any exit status other than 0 or 99 will be
   treated as a fatal error:

   -----------------
   $ git bisect run --new-status=99 sh -c 'setup-test && (run-test || exit 99)'
   -----------------

   If setup-test exits with a nonzero status code (except 99), then the
   run will abort with an error, rather than assume that the current commit
   contains the issue being bisected.


The default status code lists are as follows:
  --skip-status=125
  --old-status=0
  --new-status=1-127

The priority of each classification is as follows:

 * If the status code is on the --skip-status list, the action is "skip".
   Note that this takes precedence over the --old-status and --new-status
   lists; doing so simplifies the specification of --new-status.

 * If the status is on the --old-status list, *and* not on the --new-status
   list, the action is "old" (or "good").

 * If the status is on the --new-status list, *and* not on the --old-status
   list, the action is "new" (or "bad").

 * Otherwise, the command is treated as having experienced a fatal error,
   and run will terminate with a nonzero exit status.

In the last case, the bisection will be left where it was; you may correct
the error and perform another bisect run, or you may finish the bisection
with manual good/bad commands.

>8----------------------------------------------------------------------8<

The motivation
==============

First, an excerpt from the current documentation for 'git bisect':

> 126 and 127 are used by POSIX shells to signal specific error status
> (127 is for command not found, 126 is for command found but not executable
> - these details do not matter, as they are normal errors in the script,
> as far as bisect run is concerned

This shows a fundamental disconnect between bisect run's view of the
world and reality.  I submit that, in reality, status codes 126 and 127 are
overwhelmingly likely indicators that the script did not work correctly,
in which case the run should be halted so the user may correct the issue.
However, 126 and 127 are mapped to "git bisect bad" -- as in, "this commit
definitely contains the bug that I am searching for".


Let's consider the consequences of an inappropriate status code:

- 'good':  The bisect will incorrectly select the wrong commit (specifically,
  a later commit than the one that actually introduced the issue.)

  This will also indirectly result in more trials than would otherwise be
  necessary to determine the result, because the bisection will have to be
  restarted at the point where the mistake occurred.  (In the worst possible
  case, where a mistake occurs on the first step, the bisection will take
  at least twice as long.)

- 'bad': The bisect will incorrectly select the wrong commit (specifically,
  an earlier commit than the one that actually introduced the issue.)

  Like 'good', this will also indirectly result in extra trials.

- 'skip': The bisect will unnecessarily test at least one extra commit for
  each false 'skip' result.  In the worst case, it may not be able to narrow
  down the issue to a single commit.

- Abort: The bisection stops until the user restarts it.  No extra commits
  are tested, though if the user isn't paying attention, the wallclock
  time will take longer than usual.

In particular, the behavior of a false match on 'good' or 'bad' is *at best*
extra time needed to do the bisection.  At worst -- if the user is not
familiar with the code in question -- a great deal of confusion and time-
wasting can result as the user investigates the wrong commit.  As such, it
is critical that you have no false 'good' or 'bad' results.


If you're using a shell script to run your test, a false 'good' result can
easily be prevented by putting 'set -e' at the top of the script.

Avoiding a false 'bad' result is far more difficult, especially if the test
is complex and you're not familiar with shell scripting in general.  (The
man page for bash, on my machine, is 3725 lines long, and does not lend
itself well to searching.)  For the task that set me down this path, it
took me about six iterations to create a robust script that would return
the exit code that git wanted,  and _it still didn't work right in all
cases_.


What would have been a great deal simpler is if I could have just picked
an exit code that none of the other commands in my script would ever
return (such as 99), and told git to treat any code other than 0 or 99 as
a fatal error.  Which is essentially what I ended up doing (or trying to),
but unfamiliar with shell scripting as I was, I had several issues.

If I can make it easy for someone to use bisect run without them having
to learn any otherwise-unnecessary shell scripting constructs, I would
consider that a win.


Pre-emptive Q&A
===============

Q: Why allow ranges?  Why not restrict it to single status codes?
A: It allows for a simpler implementation, because the default 'bad' status
   list is a already a range (1-124,126-127).  By supporting ranges,
   we need only one single code path:

   exit_bad=1-124,126-127
   # override exit_bad if --bad-status is specified
   # check exit code against exit_bad

Q: Why treat any exit code that's on both the 'old' and 'new' lists as a
   fatal error?
A: Because it's obviously a mistake, and we don't know the correct way
   to interpret it.  By halting the run and returning an error, we can
   return control to the user, who can fix it by fixing the overlapping
   lists and re-running the command.

Q: Why not an error when a code is on both 'old' and 'skip', or 'new' and
   'skip'?
A: Two reasons:
   1. As I detailed earlier, a false 'skip' is less problematic than a
      false 'new'/'bad'.
   2. By prioritizing 'skip' over 'new', the default behavior for 'new'
      can be written as '1-127' instead of '1-124,126-127'.


-- 
-- Stevie-O
Real programmers use COPY CON PROGRAM.EXE
