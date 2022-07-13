Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B6FC433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 00:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiGMARl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 20:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGMARj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 20:17:39 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C73E27CE7
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 17:17:37 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ss3so11098971ejc.11
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 17:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+LnjrLhlhFu+de5A1iOJFzLSg6M4a+X2v91qeHaPWRU=;
        b=i7GNQN2G04WBUQBtQmFE9Taxq6la1w7i1XUSdOr1EqOuXdsl6h2GMxukdf+Opy7RAa
         Qi/C1vAiQoj9zZDEA+rOmbd185IMVqYA+0wrpUCAoczna8fUbE5EUP3H2tDn6ixSHRTr
         Pz98tEh7QJ+6x8Dji/iamuEhRwXYONudFJCl/BJKGvySp2p7WJyNE6By80LhhTuxWYWc
         fqMqaU1NJkrdiPw/8cyC/PR1UMbeXI+C5IwdlkpSe3ExnqwXfuIMPVlbk8XwQGhTYoQz
         0R1NG8gZomaf1oTLTzMI8KbkL9DmTCP370qFnk1IdlVbX0VewxhxgIKR03Sa7svckPpS
         TF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+LnjrLhlhFu+de5A1iOJFzLSg6M4a+X2v91qeHaPWRU=;
        b=v78ZYwrA+jVmOxu3mA0/STUNWgVL0Bqu6JBNMyOEEBq7jyXzqlGdcLbbw2aFo0/24O
         x7nMOwo6HMN5J2d/TKgncaxzkP5t9AofWBKg7VNx+VxvnZcDpAmyDgwNY5E6SEH6n+Ca
         AYXu2f9x++DEta0g2cMS3KiOfgCWeNWuEMFByIbZnMmlhdK7+6yCGgc/9QYeMenIFC2i
         5iJApLX5TjW9Dt0BWHMebBrOdl3gKxoy0v9rbOGTvlhSkxFtqGl/wLiDKfc930jeE0gY
         oWWmb4TQ7p0qdincYA3RttLHwaf/5GynnmSYt5rzF+GH6JLU+EU1RbEBEYPTGfq+HiZq
         7Ddw==
X-Gm-Message-State: AJIora/i0BLHkxRtbB/BMDVu5ag8QHgkCLN22wlO1Qm6og07l1Rg3uFq
        W83agd6qcdF9C3b8j+UTSBmwUO+t2X4+wgB1M5xGBcnzyzw=
X-Google-Smtp-Source: AGRyM1sS3na/J6gb22R/lkVd7ZQ/wcDHM1eiEM1N8auuMG+ORnC6O6D5PVdHhp/9PVueEmTC5Yi8aYkLB8x5db9H0gU=
X-Received: by 2002:a17:906:6a15:b0:72b:8ce2:9f9f with SMTP id
 qw21-20020a1709066a1500b0072b8ce29f9fmr766347ejc.100.1657671455164; Tue, 12
 Jul 2022 17:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAC4O8c9izkV5vbnE6MH8-RwnxRbUONxJxYZO+hb1J0ewuDtX+w@mail.gmail.com>
In-Reply-To: <CAC4O8c9izkV5vbnE6MH8-RwnxRbUONxJxYZO+hb1J0ewuDtX+w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 12 Jul 2022 17:17:23 -0700
Message-ID: <CABPp-BG5qjp9Rx+=CCeLMiOH2Bqpa3kmBWRWdu7fTtPM-H=3kA@mail.gmail.com>
Subject: Re: BUG: git-check-ignore documentation doesn't come close to
 describing what it really does
To:     Britton Kerin <britton.kerin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks for the report.

On Tue, Jul 12, 2022 at 4:34 PM Britton Kerin <britton.kerin@gmail.com> wrote:
>
> It begins:
>
>        For each pathname given via the command-line or from a file via
> --stdin, check whether
>        the file is excluded by .gitignore (or other input files to the
> exclude mechanism) and output
>        the path if it is excluded.

I suspect we're having an aliasing problem that you're not
recognizing.  "ignored" and "excluded" are used interchangeably, note
that patterns from the $GIT_DIR/info/exclude files and patterns from
the file pointed to by core.excludesFile are also lumped together with
the patterns from all the .gitignore files (see the gitignore manual
page).  Further, the internal code refers to them all as "excludes"
not as "ignores".

(And then we adopted the same syntax for sparse checkouts, except we
used it to mark things that should be included, and we referred
everyone to the documentation about "excludes" to learn the format for
what to "include".  Ugh.)

>
> In fact it just reports matches from .gitignore etc:

Yes, it outputs the paths that are excluded, as the documentation
said.  Perhaps there's a way to reword it to make this clearer?  I
don't think we can get rid of the alias given the fact that
$GIT_DIR/info/exclude and core.excludesFile are hard-coded and must be
kept for backward compatibility.  But suggestions to improve the
wording would be great.

Maybe it'd be as simple as replacing "is excluded" with "matches an
ignore/exclude rule"?

>      $ cat .gitignore
>      *.o
>      !*.dont_ignore
>      $ ls
>      bar.o.dont_ignore  foo.o
>      $ git check-ignore -v -n *
>      .gitignore:2:!*.dont_ignore bar.o.dont_ignore
>      .gitignore:1:*.o foo.o
>      $ # Even more confusing without -v -n:
>      $ git check-ignore *
>      bar.o.dont_ignore
>      foo.o
>
> The EXIT STATUS section is even more wrong:
>
>      EXIT STATUS
>             0
>                 One or more of the provided paths is ignored.

"is ignored", meaning "matches an ignore/exclude rule".  Perhaps we
should update the docs with that textual change?

>             1
>                 None of the provided paths are ignored.

and replace "are ignored" with the same phrase here?

>
>             128
>                 A fatal error was encountered.
>
> but:
>
>      $ if git check-ignore foo.o.dont_ignore; then echo exited true;
> else echo exited false; fi
>      foo.o.dont_ignore

So the filename matched one of the rules, causing the filename to be printed.

>      exited true

and it returned a 0 exit status, since one of the provided paths was
ignored, as documented.

>      $
>
> IMO the behavior of git-check-ignore is the correct and useful
> behavior

I'm with you here.

> and the documentation should simply be fixed

Yes, I agree it's easy to misinterpret.  Would my suggested changes help?

> to reflect the
> fact that it just lists matching entries rather than wrongly claiming
> that it returns the overall result of the ignore calculation.

I think I understood where the problems were in the documentation that
could lead to misinterpretations in the other two cases you mentioned
earlier in your email, but I don't understand this one.  Even the
first sentence you quoted included the phrase that it could "output
the path", so I'm not sure where you think it claims that it'd return
the overall result of the ignore calculation.  Could you point out
what in the document led you to believe it was claiming this?  Maybe I
could suggest wording improvements for it as well.  Or maybe you have
some.
