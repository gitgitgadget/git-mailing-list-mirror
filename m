Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EC0C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 18:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948642067C
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 18:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ody5gTL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCLSjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:39:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37425 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCLSjU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 14:39:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id i12so2110434otp.4
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 11:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9yDOJX5rJVWYzugBp3Ruf/Ad8YCpVvByp6rQNxBO/Yw=;
        b=ody5gTL0KVXxbS+lPyue7536I7W9iXKPb0fixlTG21jNIe1v0BPg0hf0PNMyUSbBTw
         X4Gr29ovwZhOhjaxjm9z79eYDOMwMPs6516yZrCkL6BLjMB1dwQIBk56HKvopZJ2NI6a
         Bgt2nh59Fu4kH00FFPaUbDxAczl/+QOdCdBnM50WVGaRHl29+rEVWtvl5QKeZ8IxWEr7
         /0k7E8ztI2rmCVIN/Klq7OhA1wokUBU7EmpE83239Xtgvjj8rF1bE74hK+cz89OJNYH+
         ZxYXysKQWLY/0ras8RX8/F2ukkvNkw4LW1Yh9IHE+T2Ogq+9LxiK3lXhDQ+I2iQGCZlI
         X4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9yDOJX5rJVWYzugBp3Ruf/Ad8YCpVvByp6rQNxBO/Yw=;
        b=ZQbQ0dhG3IS3GRxpEMhgWflWC2IjuoDmoCOUTjhl5XJe3M6i7lPnZLGG+Tk2MlwqE1
         W1MyXrhFODPCRdmhXk8RVXrldvEKbdYBjwniQ8VVoQnWbB1R5bmlCKPAzqIZz3uLD19s
         ksDtMSL5KhFnd75rRIr7UsRLR+HELWigQKfAOxdIUaolYi7tXFMDx65dDunZ87x/MhmQ
         x2P0hm+qQvHEQCbtuSDO8+VTzqaNrVxcP0hpR5kfLIpbGUXKlMllr383QUB2wl+NriaO
         NZ32tBNN5S1u+xpPGQTylBNB3fjLzqN7ovDYvqaTvSF7740aoe3bgrn8Zedg4+jecS8U
         rA7g==
X-Gm-Message-State: ANhLgQ3ej13gHZeearUaNeFbrJGnYQ3v3vUYnbSSMV530hlYmzEv2NGB
        sH/EM3HimsVrY+ffEsN5d0teOvJdFPloJGYKOn0=
X-Google-Smtp-Source: ADFU+vs1pBB1xcK4jcY0CFL9rwbU0y9AlBc+qsMIZ87vGs6AUheQdhW4kdIZZoRZhYnFJ6B0cP0wfSbkYhdtOWP+jx4=
X-Received: by 2002:a9d:a51:: with SMTP id 75mr7344151otg.112.1584038359267;
 Thu, 12 Mar 2020 11:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
 <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com> <ad8339aebf28ec84c22ed59cef06614d204adb55.1581802602.git.gitgitgadget@gmail.com>
 <20200312151318.GM212281@google.com> <CABPp-BHyNvxQZ5q=9WXXESTPmxFe4fAiE5roGeV2H+XJ_cpDmg@mail.gmail.com>
 <20200312175548.GC120942@google.com>
In-Reply-To: <20200312175548.GC120942@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 12 Mar 2020 11:39:08 -0700
Message-ID: <CABPp-BFLwpa019Prd3nf7s4BY2jWp8utOvJD9pzHcbg66b8fWw@mail.gmail.com>
Subject: Re: [PATCH v5 20/20] rebase: rename the two primary rebase backends
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 10:55 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Elijah Newren wrote:
> > On Thu, Mar 12, 2020 at 8:13 AM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> >> This broke quite a few upstream users for us today when we rolled out a
> >> next with this patch added on top. To shim around the post-commit hook
> >> issue, we had set a system config for all our users to use
> >> merge.backend=am; the machinery is pretty intolerant to a wrongly
> >> configured backend name (die() rather than a warning and fallback).
> >>
> >> Would it make more sense to deal with an unrecognized backend by falling
> >> back to the default backend, instead?
> [...]
> > Sorry for the pain.  The earlier part of the series had only ever made
> > it to next, and was reverted there, and thus, in my thinking, in the
> > new cycle no one would have ever seen the intermediate state.  (Oops,
> > I forgot about cases where people tried out next towards the end of
> > last cycle before it was reverted and decided to set config based upon
> > it.)
>
> Right, I'm mostly interested in this for the future: do we expect the
> list of backends to only grow over time, or do we want to support
> removing and renaming backends?  In the latter case, how can we support
> people sharing config between multiple Git versions with their
> merge.backend settings?

Good questions.  We have already stated that backends might be
"removed" or at least "ignored"; from Documentation/config/rebase.txt:

rebase.backend::
        Default backend to use for rebasing.  Possible choices are
        'apply' or 'merge'.  In the future, if the merge backend gains
        all remaining capabilities of the apply backend, this setting
        may become unused.

In other words, we're already telling users that 'apply' might mean
'merge' in future versions of git.  (Or at least that was my mental
model; perhaps I should tighten up the wording to state it that way?)

I hadn't thought in terms of adding backends, especially since we've
been trying to remove them, though given our history[1] maybe I should
have.  I guess it's possible we could introduce another backend[2],
though we don't necessarily have to make it possible to configure
every backend as the default.  For example, despite the technical
existence of another backend right now, I did not make
'preserve-merges' a possible setting since it is already deprecated.
(And to go on a bit of a tangent, I think that if someone is not in
the middle of a rebase and tries to start one with the -p flag, we
should just throw a warning and pretend they passed -r.  We should
kill preserve-merges as much as possible.  Anyway, enough of that
tangent...)

[1] By my count, we've had at least five rebase backends: apply/am,
merge-via-shell-out-to-merge-recursive-builtin,
legacy-interactive-via-shell,
interactive-as-builtin-and-now-called-merge, and preserve-merges.  I
think at one point all five co-existed.  And I wouldn't be surprised
if I've forgotten, overlooked, or otherwise missed others.

[2] Maybe I even started one with
https://github.com/newren/git/blob/git-merge-2020-demo/builtin/fast-rebase.c,
but unless it's just too hard to refactor sequencer.c &
builtin/rebase.c to make use of merge-ort (AND quit forking
subprocesses other than with --exec and -s AND avoid writing state
files unless and until you hit a conflict), I'm thinking that dies as
nothing more than a demo.

> > I'm a little worried about ignoring the setting and just picking one;
> > if the setting has been marked and they set it to e.g. "appply" (one
> > too many p's), then does it really make sense to just show a warning
> > but continue using the backend they didn't want, especially since they
> > may miss the warning among the rest of the output?  I'd rather go the
> > route of improving the message, perhaps:
> >         _("Unknown rebase.backend config setting: %s")
> > Would that work for you?
>
> What if we support multiple merge.backend values, with semantics:
>
> - last recognized value wins
> - if no value is specified, use the default
> - if values are specified but none are recognized, error out with a
>   clear error message
>
> ?

Sure, but...isn't that what we already do, other than maybe the
'clear' part of step 3?  ('merge' and 'apply' are recognized values.
If no value is specified, the default of merge is used.  If values are
specified but none are recognized, it errors out.)  Would my suggested
change above fix it so that we can consider it sufficiently clear, or
do you want something else?

> > Also, I thought that you and Jonathan were going to be changing the
> > post-commit hook handling[1][2].  Does this mean that you've punted on
> > that, and I need to make some kind of change here to get you to switch
> > over?
>
> The setting was a stopgap; our interest in this upstream is primarily
> from the point of view of "we ran into this, so let's take the
> opportunity to help others that might run into similar issues in the
> future".

Thanks for flagging it; I appreciate it.  Is my suggested rewording of
the error message helpful?  Have I missed or misunderstood anything
else you were trying to bring up?
