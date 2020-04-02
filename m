Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44F3C10F26
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 05:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97246206F5
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 05:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6h99NxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgDBFPt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 01:15:49 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46589 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgDBFPt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 01:15:49 -0400
Received: by mail-oi1-f194.google.com with SMTP id q204so1716214oia.13
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 22:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0ANoA1+uHJkorPPcoe44A803XaN1cisznpHg+TByGY=;
        b=j6h99NxS6uXWZy/yEonXv2jR6/puXCQvJsDf6Hgyw6vaZhOAkaHl5HltygRWo4Fi1F
         G3t54yL2cI54nrVdS6C8TVbc8xzdgf4syYTdnlAkExGrlD1QT41plRHjIJZ7DIdOYrqY
         I2PwgmdzkdgBOJ6wzaXQ1zx1CFaOLXKn6TiR9hnmD4xT7nOaEntwHp5IM29A0WZJA13U
         R9o/z9DSr8MY3LATdSm5Qoit2x5psLTSm9oN5SyeocJyF9OSiQE8LVOgQYhRHlU2l6WQ
         MTfzSj0WfKUJLyGzGP/RNiRQxreUPiH/isFTs7Av+LP35RLAMqBmZ6JJFqfffj1XJHCS
         fDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0ANoA1+uHJkorPPcoe44A803XaN1cisznpHg+TByGY=;
        b=RHK6ZD6xGJ0miiMe+qk8zDVaGJtJfFa7rbUGuT4jouDS5r3nuWBg5zchnPyoZFlbYD
         DyZ4wc97VlzwGt+zHmoHrr97y5WojsYuOLPx9x58k18yQELyvTaf3kn7CjLwaNc3eZRp
         aye+yKuxlskzdkDxxaaD0tIvl2yoc1TB0VPFnw5VqNV9lUCTt1/nPSvOOA8OAFb4JQ3B
         A/kWoT0ScNvVlXfHFZlSH9op1I4LzRaECFNKYAmdAx9fqzJo/LaCfLmfiYZ2aqewGBb1
         PPtxiDYpvzbMThyGkdTfmeLiFCFGx/bNEyGJPB+Pc/g1v8BGi+P4mFXwP1xcTrec8Jvx
         d7FA==
X-Gm-Message-State: AGi0PubqbVNGCPXjePXEc3rDhZTsOl8n38VJsgyyTVfBQdib7DXc5c7g
        TM8WWrRQ2KbKIsXOiNstgaFtxw5fqArSINKtKp0=
X-Google-Smtp-Source: APiQypJAQj0LJj1+91JWqQahYJ3S3rDrWlBGswOyu8o2jvC6lQWMeY72NAPsy6geUYoKPLHlFc/CzDzpOUtjG89dMD8=
X-Received: by 2002:aca:4b84:: with SMTP id y126mr985890oia.31.1585804547961;
 Wed, 01 Apr 2020 22:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.746.git.git.1585773096145.gitgitgadget@gmail.com> <24197.9157.362143.972556@chiark.greenend.org.uk>
In-Reply-To: <24197.9157.362143.972556@chiark.greenend.org.uk>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 1 Apr 2020 22:15:37 -0700
Message-ID: <CABPp-BGo=6W5wfba7us8ca3eAfz04v8WxyOQ96DkoXn2fV=J1Q@mail.gmail.com>
Subject: Re: [PATCH] sequencer: honor GIT_REFLOG_ACTION
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Gevers <elbrus@debian.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 1, 2020 at 4:29 PM Ian Jackson
<ijackson@chiark.greenend.org.uk> wrote:
>
> Hi.  Thanks for looking at this.
>
> Elijah Newren via GitGitGadget writes ("[PATCH] sequencer: honor GIT_REFLOG_ACTION"):
> >     I'm not the best with getenv/setenv. The xstrdup() wrapping is
> >     apparently necessary on mac and bsd. The xstrdup seems like it leaves us
> >     with a memory leak, but since setenv(3) says to not alter or free it, I
> >     think it's right. Anyone have any alternative suggestions?
>
> I can try to help.  It's not entirely trivial.
>
> The setenv interface is a wrapper around putenv.  putenv has had a
> variety of different semantics.  Some of these sets of semantics
> cannot be used to re-set the same environment variable without a
> memory leak - and even figuring out what semantics you have would be
> complex and tend to produce code which would fail in bad ways.
> There's a short summary of the situation in Linux's putenv(3).
>
> Would it be possible for git to arrange to set GIT_REFLOG_ACTION only
> when it is invoking subprocesses ?  Otherwise it would update, and
> look at, a global variable of its own.  (Or a parameter to relevant
> functions if one doesn't like the action-at-a-distance effect of a
> global.)
>
> And, it seems to me that the reflog handling should be centralised.
>
> > +     char *reflog_action = getenv("GIT_REFLOG_ACTION");
> >
> >       va_start(ap, fmt);
> >       strbuf_reset(&buf);
> > -     strbuf_addstr(&buf, action_name(opts));
> > +     strbuf_addstr(&buf, reflog_action ? reflog_action : action_name(opts));
>
> Open coding this kind of thing at every site which needs to think
> about the reflog actions will surely result in some of the instances
> having bugs.
>
> Writing a single function that contans this (or most of it) would
> happily decouple all of its call sites from literally asking about
> getenv("GIT_REFLOG_ACTION") thereby making it easier to do the
> indirection-through-program-variables I suggest.

That sounds great, but I'm not sure that "only when invoking
subprocesses" will limit the places where we set the environment
variable all that much; it might actually expand it.  I wasn't there
for the whole history, but my understanding is the rebase code has
slowly transformed from the original all-shell rebase
implementation(s), to being a helper program that the shell could call
into for parts of its operations and passing control back and forth
between shell and C, to being a reimplementation of just invoking the
same commands that the shell script would have, to slowly transforming
into an actual library where invocations of other git subprocesses are
being replaced with relevant function calls.  It's a long cleanup
process that is still ongoing.  I'd like to get to the point where we
only invoke subprocesses if the user specifies --exec or a special
merge strategy, but that's a goal with a longer term timeframe than
fixing a 2.26 regression.

> Having said that,
>
> > diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
> > index 61b76f33019..927a4f4a4e4 100755
> > --- a/t/t3406-rebase-message.sh
> > +++ b/t/t3406-rebase-message.sh
>
> This test case convinces me that the patch has the right behaviour for
> at least the case I care about :-).

Cool, sounds like it's a good immediate fix for the 2.26 regression,
and then longer term as we continue refactoring we can hopefully
isolate subprocess handling and writing of state.

As a heads up, though, my personal plans for rebase (subject to buy-in
from other stakeholders) is to make it do a lot more in-memory work.
In particular, this means for common cases there will be no subprocess
invocations, no writing of any state unless/until you hit a conflict,
no updating of any files in the working tree until all commits have
been created (or a conflict is hit), and no updating of the branch
until after all the commits have been created.  Thus, for the common
cases with no conflicts, there would only be 1 entry in the reflog of
HEAD the entire operation, rather than approximately 1 per commit.  I
have a proof-of-concept showing these ideas work for basic cases.  So,
I hope your tests don't depend on the number of entries added to
HEAD's reflog.
