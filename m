Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A4A51F453
	for <e@80x24.org>; Thu, 25 Oct 2018 18:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeJZDAw (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 23:00:52 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:46098 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbeJZDAv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 23:00:51 -0400
Received: by mail-ed1-f45.google.com with SMTP id v18-v6so1789504edq.13
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 11:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Tr+9DQwOwN6jzRkleiOGsshiW+I5X2+4b0SXH6jHKk=;
        b=lYa6Lh+IF7WXesZ8qPkv5uSjWAkPRoCgCmqdNmmCBTZpnOV5ZOnvfenO0chQ7i/8bf
         gb/cy/9UNM6s5JYhggTqtlnwP+fa2mmXe6F75nan9zXw7g223OA4Vj/Et+3C4f/8wj85
         y7yUSqeoUnVl7aJpLENRKYs8DjrSQB2a6Uzztg5yCkWu+2RnYf7a9ukyt2pXl2qd2HUu
         3H0FLxt6aANx1CJFAeSnljnRHdv5voJOg28VGSbtV6PCHM3+87eyEGCpYmvqYlDGRhdH
         6cuQgiUpbZeX9NI0RX0Mc+feCCd7fnBBhcMTOaqxBAS58uxzQei44kaOzUUJjgLGrUt4
         cnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Tr+9DQwOwN6jzRkleiOGsshiW+I5X2+4b0SXH6jHKk=;
        b=TcLHsO3pof4B/AgFRbpmxEd49Oiwh5h0TQO9CAIXLgMMPAa1ohjsTq9p9RuBG7hOx4
         n0zRklB9Xaga1jOZ1AcT0QmL01df7DrGCBcNQaVibq4tad53HA5o/35FMz2xbiVOSN5P
         y7MZ8dUxQw0Z6pU/dtOWsXT8/loXpm7rN5WpZZqY4oxPTOu6GsoY9e13HPiW+OtcRZmR
         fDmL7m+Yydw/Ai8VRzxjv+re05Snfvswb1XafhE1R0l1RFKUGMAtUdWhfRdQE5WJcFz5
         2QI9bE8oMjyU/zC2+8Yov/Nx9oatC/XKAfG3jwUitRyUasY4wHFIsigAUnbpBVPmjxIf
         Mrnw==
X-Gm-Message-State: AGRZ1gIcC24SXEsRyCxIs2u11sFJRIlxZLQ4Ztc9KlcCd0bIiOHuj41l
        9WhHMbDoaT+t6vJRH/YBqdMO69B1GpNKmXy30ZV4DwuBa3GWRQ==
X-Google-Smtp-Source: AJdET5dHaMr3D6LimlaruRfMfxn74+Qp4H8Q7+/0xwaIJCI2F333Srm9OZYReJOO6dhao+/gZYuSBCckxVu5mvJF00Q=
X-Received: by 2002:a50:ba89:: with SMTP id x9-v6mr204651ede.191.1540492017698;
 Thu, 25 Oct 2018 11:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAGw6cBvLDNtYT6vfHcxmX0S_SS1vmYVCEkSD_ixah6cGKJ4H9w@mail.gmail.com>
 <CAGw6cBvaC+TEOM9Tjdbs5zkz2hzW4649=4rsAo58cNOVHOQS=Q@mail.gmail.com>
In-Reply-To: <CAGw6cBvaC+TEOM9Tjdbs5zkz2hzW4649=4rsAo58cNOVHOQS=Q@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 25 Oct 2018 11:26:46 -0700
Message-ID: <CAGZ79ka=tkKYNkPmSjhomcfAPbEg6PQPSRtpe3uq2B45fNoyjg@mail.gmail.com>
Subject: Re: Confusing behavior with ignored submodules and `git commit -a`
To:     mforney@mforney.org
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 25, 2018 at 11:03 AM Michael Forney <mforney@mforney.org> wrote:
>
> On 2018-03-16, Michael Forney <mforney@mforney.org> wrote:
> > Hi,
> >
> > In the past few months have noticed some confusing behavior with
> > ignored submodules. I finally got around to bisecting this to commit
> > 5556808690ea245708fb80383be5c1afee2fb3eb (add, reset: ensure
> > submodules can be added or reset).

Uh. :(

See the discussion starting at
https://public-inbox.org/git/20170725213928.125998-4-bmwill@google.com/
specifically
https://public-inbox.org/git/xmqqinieq49v.fsf@gitster.mtv.corp.google.com/


> >
> > Here is a demonstration of the problem:
> >
[...]
> > Up to here is all expected.

Makes sense.

> > However, if I go to update `foo.txt` and
> > commit with `git commit -a`, changes to inner get recorded
> > unexpectedly. What's worse is the shortstat output of `git commit -a`,
> > and the diff output of `git show` give no indication that the
> > submodule was changed.

This is really bad. git-status and git-commit share some code,
and we'll populate the commit message with a status output.
So it seems reasonable to expect the status and the commit to match,
i.e. if status tells me there is no change, then commit should not record
the submodule update.

> > $ git commit -a -m 'update foo.txt'
> > [master 6ec564c] update foo.txt
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > $ git show
> > commit 6ec564c15ddae099c71f01750b4c434557525653 (HEAD -> master)
> > Author: Michael Forney <mforney@mforney.org>
> > Date:   Fri Mar 16 20:18:37 2018 -0700
> >
> >     update foo.txt
> >
> > diff --git a/foo.txt b/foo.txt
> > index d00491f..0cfbf08 100644
> > --- a/foo.txt
> > +++ b/foo.txt
> > @@ -1 +1 @@
> > -1
> > +2
> > $
> >
> > There have been a couple occasions where I accidentally pushed local
> > changes to ignored submodules because of this. Since they don't show
> > up in the log output, it is difficult to figure out what actually has
> > gone wrong.

How was it prevented before? Just by git commit -a not picking up the
submodule change?

> >
> > Anyway, since the bisected commit (555680869) only mentions add and
> > reset, I'm assuming that this is a regression and not a deliberate
> > behavior change. The documentation for submodule.<name>.ignore states
> > that the setting should only affect `git status` and the diff family.
> > In terms of my expectations, I would go further and say it should only
> > affect `git status` and diffs against the working tree.
> >
> > I took a brief look through the relevant sources, and it wasn't clear
> > to me how to fix this without accidentally changing the behavior of
> > other subcommands.
> >
> > Any help with this issue is appreciated!

I guess reverting that commit is not a good idea now, as
I would expect something to break.

Maybe looking through the series 614ea03a71
(Merge branch 'bw/submodule-config-cleanup', 2017-08-26)
to understand why it happened in the context would be a good start.

> I accidentally pushed local changes to ignored submodules again due to this.
>
> Can anyone confirm whether this is the intended behavior of ignore? If
> it is, then at least the documentation needs an update saying that
> `commit -a` will commit all submodule changes, even if they are
> ignored.

The docs say "(but it will nonetheless show up in the output of
status and commit when it has been staged)" as well, so that commit
sounds like a regression?

Stefan
