Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E33C32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7B62084D
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qrpff.net header.i=@qrpff.net header.b="irV/AstU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbgAPClP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:41:15 -0500
Received: from bonobo.elm.relay.mailchannels.net ([23.83.212.22]:49245 "EHLO
        bonobo.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729503AbgAPClP (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Jan 2020 21:41:15 -0500
X-Sender-Id: dreamhost|x-authsender|stevie@qrpff.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CD419502041
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 02:41:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a67.g.dreamhost.com (100-96-4-61.trex.outbound.svc.cluster.local [100.96.4.61])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 1F36A502025
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 02:41:12 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|stevie@qrpff.net
Received: from pdx1-sub0-mail-a67.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.5);
        Thu, 16 Jan 2020 02:41:12 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|stevie@qrpff.net
X-MailChannels-Auth-Id: dreamhost
X-Fearful-Average: 1d3f6d2f08ca690f_1579142472548_382146239
X-MC-Loop-Signature: 1579142472548:2488382066
X-MC-Ingress-Time: 1579142472548
Received: from pdx1-sub0-mail-a67.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a67.g.dreamhost.com (Postfix) with ESMTP id A8AA7B160B
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 18:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=qrpff.net; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=qrpff.net; bh=EyM3ZQSl3UEmmwImrOfCPAdMZck=; b=i
        rV/AstUsgyklevf2IvBJxljdHK1xAXOBTuayH0c0liEPXIZfyv8oKTJ3OWXBUSAW
        v5i4lJMdVBL/VRClOGMod6yKaaOXX3sXwi2YCvyDPSdyw/KDTOvi3AtFk6VEIWx+
        PdJX21aJbjbhOQ2NbMl/e4nNi32Z5eHh6fYKQEjBCM=
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stevie@qrpff.net)
        by pdx1-sub0-mail-a67.g.dreamhost.com (Postfix) with ESMTPSA id E9B74B160F
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 18:41:08 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id o13so20856678ljg.4
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 18:41:08 -0800 (PST)
X-Gm-Message-State: APjAAAWY9dSYXHJyVhrbzoEmmNcoLt+KMxtjygM8iXoeUHwRz46lyn0h
        XYVXjR/S0zuL+eVbo2JC5vSI+Be2An/vwUWPzew=
X-Google-Smtp-Source: APXvYqwXk1zkafXx6NGbNWKkccvUHxjUHOeD/5J6d59o4YFEkQyE7b86sljkTcDBVhuCdRMAqAp4nzzeQxGGoLAZR04=
X-Received: by 2002:a2e:7005:: with SMTP id l5mr881520ljc.230.1579142466834;
 Wed, 15 Jan 2020 18:41:06 -0800 (PST)
MIME-Version: 1.0
References: <CAD_xR9f7jHnCByOaOVJvxdW2c5dPHM8OUDwZhcPL1iTVR3NzmQ@mail.gmail.com>
 <CAP8UFD3dr3XdZSm88qoGDajSoFMx-TJZfxsMGqhFMKA6dEWj4A@mail.gmail.com>
In-Reply-To: <CAP8UFD3dr3XdZSm88qoGDajSoFMx-TJZfxsMGqhFMKA6dEWj4A@mail.gmail.com>
X-DH-BACKEND: pdx1-sub0-mail-a67
From:   Stephen Oberholtzer <stevie@qrpff.net>
Date:   Wed, 15 Jan 2020 21:40:54 -0500
X-Gmail-Original-Message-ID: <CAD_xR9cC_MrrqGoHuBsfuVAQ=qVMd0rjXvp22+8ed-D=4TQRbA@mail.gmail.com>
Message-ID: <CAD_xR9cC_MrrqGoHuBsfuVAQ=qVMd0rjXvp22+8ed-D=4TQRbA@mail.gmail.com>
Subject: Re: [RFC] Proposal: New options for git bisect run to control the
 interpretation of exit codes
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrtdeggdegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfhgjhfffkffuvfgtsehttdertddttdejnecuhfhrohhmpefuthgvphhhvghnucfqsggvrhhhohhlthiivghruceoshhtvghvihgvsehqrhhpfhhfrdhnvghtqeenucfkphepvddtledrkeehrddvtdekrddujeegnecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopehmrghilhdqlhhjuddqfhdujeegrdhgohhoghhlvgdrtghomhdpihhnvghtpedvtdelrdekhedrvddtkedrudejgedprhgvthhurhhnqdhprghthhepufhtvghphhgvnhcuqfgsvghrhhholhhtiigvrhcuoehsthgvvhhivgesqhhrphhffhdrnhgvtheqpdhmrghilhhfrhhomhepshhtvghvihgvsehqrhhpfhhfrdhnvghtpdhnrhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 15, 2020 at 7:39 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sat, Jan 11, 2020 at 2:43 AM Stephen Oberholtzer <stevie@qrpff.net> wrote:
> >
> In many cases I have found that something like the following would do:
>
> git bisect run sh -c "make || exit 125; setup_script || exit 255;
> run_cmd >log 2>&1 || exit 255; (! grep foo log)"
>
> but I understand that some people may prefer options like the one you suggest.

Yeah,  A lot of this stuff can be easily done if you're a skilled
shell scripter.  But it's easier to do it _wrong_, especially for
something non-trivial.

> >
> > For more precise control over bisect run's interpretation of the command's
> > exit status, you can use one or more `--<term>-status=<list>` options:
> >
> > <term>::
> >   One of the following:
> >   * `skip` (`--skip-status`)
> >   * `old` or the corresponding term specified in the bisect start call
> >      (`--old-status` or `--good-status`)
> >   * `new` or the corresponding term specified in the bisect start call
> >      (`--new-status` or `--bad-status`)
> > <list>::
> > A comma-separated list of values (e.g. 1) or ranges (e.g. 1-10).
> >
> > (It should be noted that specifying --old-status is unlikely to be useful
> > without a corresponding --new-status option.)
>
> This is not clear from what has been documented above.

I'm not sure what you're referring to here, especially regarding "what
has been documented above".
All of that stuff is still in my documentation notes.

>
> > This feature can make a few things much easier:
> >
> >  * If you want to bisect a "fix", you can use (as an example)
> >
> > ---------------
> > $ git bisect run --old-status=1-127 --new-status=0 my_script arguments
> > ---------------
>
> Yeah, that seems useful. It is not clear though if 125 then means
> "old" or still "skip".

Well, it is clear if you read the entire thing.  But as you pointed
out below, I ought to reorder the text a bit.

>
> >    -----------------
> >    $ git bisect run --new-status=99 sh -c 'setup-test && (run-test || exit 99)'
> >    -----------------
> >
>
> Yeah but `sh -c 'setup-test || exit 255; run-test'` should work fine
> in this case too.

Yep, and it only works because there's a flaw in my example: it
assumes that all nonzero exit codes from run-test are conclusive
results.  But if run-test died from a signal (say, SEGV or INT or an
oom KILL) that overly-simplistic || is going to turn all of them into
99s.  If we were watching for a SEGV or INT or KILL, that's awesome.
But if we were looking for something else, then we've misclassified
the result!

That's one of the major problems with || -- it boils down the
process's exit code to a simple boolean.

I'm going to rewrite my example to say "if run-test exits with code 99
if the defect is present" and just do setup-test && run--test.

>
> The above doesn't tell what happens if a status is both on the
> --old-status and on the --new-status lists...

No, the below does.

>
> >  * Otherwise, the command is treated as having experienced a fatal error,
> >    and run will terminate with a nonzero exit status.
>
> ...so it seems that it is an error only when such a status code is
> actually received by `git bisect run`.
>
> Some people could argue though that `--new-status=0 --old-status=0`
> should be detected as an error as soon as `git bisect run` is
> launched.

There are a few reasons for not raising an error immediately:
- Such a check would not be free.  While the example you gave is
simple enough, things can quickly get complicated.  A generalized
version would have to check every single status from 0 to 255
  (that said, I can see some value in proactively checking 0 and 1
before starting the run, just as a sanity check)
-  If there _is_ an ambiguous exit code, it doesn't actually matter
unless it's actually encountered
- If the user makes such a mistake, the bisection doesn't go off the
rails; it just halts.  A simple 'git bisect good' or 'git bisect bad',
followed by another call to "run" with corrected options, will address
the issue.

>
> It would be nice if the above clarification about priority was before
> the examples you gave.

Yeah, I'll reorder things.

>
> Well when bisect run was implemented the main concern was to make it
> abort immediately in case of a signal and to consider common non zero
> status code as "bad". A signal would result in an status code greater
> than 128, so it was decided to split the [1-255] range in two more or
> less equal parts, so [1-128] would be "bad" and [129-255] would be
> "abort". Then "split" was added and given special code 125.

Oh, yes, I understand the reasoning behind the current behavior; that
doesn't change the fact that trying to work around it can be awkward.

>
> > However, 126 and 127 are mapped to "git bisect bad" -- as in, "this commit
> > definitely contains the bug that I am searching for".
>
> Yeah, it might have been better to use [126-255] for "abort".
>
> I think though that 126 and 127 should still be rare. And git bisect
> might be used to debug software written in shell (Git itself had many
> commands written in shell a long time ago) where 126 or 127 could come
> from errors in the software itself not from the testing scripts.

"rare" doesn't mean "impossible" -- and in fact, the 'command not
found' exit code was tripped on one of my early runs when an error in
my test script left it in the wrong directory.

But you make an excellent point that seems to support my proposal: If
you're bisecting a shell script issue, you probably want to treat
126-127 as signifying "bad" commits, but if you're not, you probably
want 126-127 to abort the run because it means your test itself
malfunctioned.

The little project I was working on that set me down this path took
15-20 minutes per iteration, and was bisecting through over 64K
commits; I believe it ended up testing about 20 revisions (due to
merges).  A single false positive/negative, especially early on, could
have resulted in hours wasted.

> > If you're using a shell script to run your test, a false 'good' result can
> > easily be prevented by putting 'set -e' at the top of the script.
>
> Sometimes it is easier to understand a script when it properly checks
> for errors and produces good error messages than when it uses `set
> -e`.

Perhaps, but not necessarily -- and _definitely_ not if you're not
experienced with shell scripting.
Shell scripting feels incredibly fragile; every bit you add is a
chance to make a mistake.

In contrast, "set -exuo pipefail" makes life really easy: You can see
everything the script does, and you can be confident that as soon as
something goes wrong, your script will stop right away.

> > What would have been a great deal simpler is if I could have just picked
> > an exit code that none of the other commands in my script would ever
> > return (such as 99), and told git to treat any code other than 0 or 99 as
> > a fatal error.  Which is essentially what I ended up doing (or trying to),
> > but unfamiliar with shell scripting as I was, I had several issues.
>
> I think there might have been easier ways.
>
> See above the alternative I suggested to `git bisect run
> --new-status=99 sh -c 'setup-test && (run-test || exit 99)'`.

There's a bootstrapping issue, here: If someone's unfamiliar with
shell scripting, how would they know how to construct such a thing?
If you're going to bet, say, five hours of your life on your
one-liner, how can you be confident that it will work reliably?

> Thanks for this!

Thank you for your feedback!

I've got a first draft of the proof-of-concept patch written already;
I'll add a proactive sanity check for exit codes 0 and 1, since that's
cheap and should cover over 99% of cases, do some cleanups to the
documentation and examples, and then add some test cases.

>
> Best,
> Christian.



-- 
-- Stevie-O
Real programmers use COPY CON PROGRAM.EXE
