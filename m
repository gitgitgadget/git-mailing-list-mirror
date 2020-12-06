Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B26C433FE
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 01:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C6B223104
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 01:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgLFBC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 20:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgLFBC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 20:02:28 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D979C0613CF
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 17:01:48 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id w3so8511360otp.13
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 17:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SqQhEbieIA1BCH/l369uaY5AouBHXS55ILvQ2yqtvWY=;
        b=fhO3Kah7zKtqbke3MaUQTwdULZPUuYXbJW9GOntOItIFgqeF+cOZ0V6nUq/JyCyCKI
         Sps/Kz+JRTCG3Joa/LnFoJnL51Xzld+d9d0o4ugg+Ukc6raYL8V6BcgH3IIDP8So55Dm
         0IdFbkRDClLtdXa/bhd2e2dv+YPFgoLbm5S+GxQoO0Jip9L+k11dEX2nD8S+NinW5dSr
         ZhjPPxJJy3yVVZ/ksoSzwcwat1gffI7d427fxlHr7fuDtbO7me6LbNqAHhoAj8oNLdFm
         7r8piDfSdFtraV9D0MZbLu6C/jHSIN2k7MeDj+dcBklHAi7PHAmB2gPw/g5sMA/w8nOI
         50FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SqQhEbieIA1BCH/l369uaY5AouBHXS55ILvQ2yqtvWY=;
        b=cqrX4n5q8cf0rQKZckw+Z5lztPmcwbCRnwLwC9xICp9tHA6ifzQs//s4TOUxU7cSRT
         osjbemj2GjEDYYuVH+H8Yzcefip0Mg4UFNYNxsmP9RbWOzBtbG/KFK+AjMLca2fX1XZP
         Cn8qrrtOuFVy/MuoCLITKwKayQGORp9dEo9m8oF2f6kyKJCK3KQaeY79eIMkIHASLPhP
         q5rZodSm+zZwj44C/auIGKPdBeEAuVlThCQLtR5THIY5dFw3eF2kd97WSy2wOdGMufUp
         jctuPbkAhiY7wT5omEDkurrN8XsNiWvMmfB1QERcH0Fe9UIIoeLWzkXn8pRMoW8WOnjt
         t8Yg==
X-Gm-Message-State: AOAM530qDznSIyaq/isz0btlB8br845AMo5usUMbqxbUn9gzPFMoHkwl
        7cSeI2Wa2XM3GfaIbreFM5Vb0OzmqvF6Y+6WOh4=
X-Google-Smtp-Source: ABdhPJzdvCKl3mrt6NR3hfVD+YmdL4q3v6645tNIjrP/karUKvR6kA2f5sASOBKPkiiHyw7AqDOD48vTOppF4oXxU8w=
X-Received: by 2002:a05:6830:1d6a:: with SMTP id l10mr8409351oti.345.1607216507194;
 Sat, 05 Dec 2020 17:01:47 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-3-felipe.contreras@gmail.com> <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
 <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
 <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
 <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
 <CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com> <CAMP44s2L24jhCG9ps72--ZiJkXUovR726jCf8JTLHAs0jV7Whg@mail.gmail.com>
In-Reply-To: <CAMP44s2L24jhCG9ps72--ZiJkXUovR726jCf8JTLHAs0jV7Whg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 5 Dec 2020 17:01:36 -0800
Message-ID: <CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc7mBLGbw0Qw@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 5, 2020 at 1:28 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> On Sat, Dec 5, 2020 at 10:28 AM Elijah Newren <newren@gmail.com> wrote:
> > On Fri, Dec 4, 2020 at 5:56 PM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
>
> > > Well, I already said I partly agree with you: in the --ff-only case
> > > the suggestion should not be brought forward.
> > >
> > > But in the "git pull" default case, *today* it's doing a merge. If
> > > uttering --merge and thus making the current behavior explicit instea=
d
> > > of implicit seems dangerous it's because it is. But not documenting i=
t
> > > doesn't make it any less dangerous.
> >
> > Sounds like we agree that the future should be ff-only-as-default.  I
> > also agree with you that the primary problem is the current default
> > behavior, and I'll agree with you that documenting the current default
> > is okay.  However, I disagree that your wording here:
> >
> > +                       "If unsure, run \"git pull --no-rebase\".\n"
> >
> > does anything of the sort.  It does not mention that this is the
> > default behavior the users would get if they provided no flags.
>
> But that is not the warning, this is the warning:
>
>   Pulling without specifying how to reconcile divergent branches is disco=
uraged;
>   you need to specify if you want a merge, a rebase, or a fast-forward.
>   You can squelch this message by running one of the following commands:
>
>     git config pull.rebase false  # merge (the default strategy)
>     git config pull.rebase true   # rebase
>     git config pull.ff only       # fast-forward only
>
>   You can replace "git config" with "git config --global" to set a defaul=
t
>   preference for all repositories.
>   If unsure, run "git pull --merge".
>   Read "git pull --help" for more information.
>
> This warning says:
>
> 1. There's 3 options: merge, rebase, fast-forward
> 2. merge is the default strategy
> 3. If unsure, specify --merge (the default strategy)
>
> So taken altogether it does say what is the default strategy.

We don't need to take them together.  #2 by itself states the default
strategy.  I don't see why defending #3 as being for the purpose of
documenting the default strategy is helpful, since it doesn't do that.

> > More
> > importantly, it makes a recommendation...and one that undercuts the
> > point of the message.
>
> So?
>
> When boarding a plane the flight attendants do a safety demonstration
> that passengers should pay attention to. If one passenger is not
> paying attention (listening to music on headphones, and reading a
> book) what should the crew do?
>
> 1. Remove the passenger's headphones and force him to pay attention to
> the safety demonstration
> 2. Let the passenger ignore the safety demonstration
>
> Human beings are independent agents responsible for their own actions.
> You as a separate human being--a crew member--can argue that it's not
> in the best interest of the passenger to ignore the safety
> demonstration, and you may be right, but the passenger decisions are
> still the passenger's decisions, even if they are bad.
>
> Do you think the crew should disregard the passenger's volition and
> force him to pay attention to the safety demonstration?
>
> > It makes it feel like the message shouldn't
> > exist at all in any circumstances.  I even suspect that adding that
> > sentence may undercut any efforts towards changing the default to
> > ff-only-as-default.  While I'm a big fan of most of what you've done
> > in this series, I will object to its merging for as long as this
> > stays.  (I definitely don't have veto power or anything close to it,
> > just stating what my opinion is.)
>
> The current warning should not exist at all.
>
> The complaint from V=C3=ADt Ondruch [1] that reignited this series is a
> valid one. A *permanent* warning is not good. We should have a
> *temporary* warning with the express purpose of notifying users of an
> upcoming change.
>
> If we have not yet decided on what should be the default (Junio seems
> to have casted some doubt on the consensus [2]), and we don't have a

Useful link there.  Based on his comments, we may want to make
--ff-only, --merge, and --rebase all be mutually exclusive and result
in an error message if more than one is specified at the command line.
(But still have the command line countermand any option set in the
config, of course).

> clear path forward to implement such change (we can't even tell users
> to use "pull.ff=3Donly", since eventually it may be
> "pull.mode=3Dff-only"), then we must remove the warning.
>
> It was a mistake to put a *permanent* warning before deciding to
> change the default.
>
> So, there's two options:
>
> 1. We decide on a path forward and fix the warning so it *temporarily*
> explains what will happen in the future
> 2. We remove the *permanent* warning
>
> Since we are already here, we might as well take advantage of that
> warning and repurpose it. But in the meantime--while the git project
> decides what to do, and what configurations to suggest the users to
> change--we should at the very least waste as little as the user's time
> as possible, and give him/her a quick opt-out.
>
> Yes, a quick opt-out defeats the purpose of a warning, but we must
> respect the users' volition. The user may be on a deadline trying to
> push some changes to production before the weekend, and after a system
> update be annoyed with this warning on every pull. The user may not
> have time to look at the warning, decide he wants to read the warning
> in the future, maybe next Monday, and thus not configure anything to
> silence it.
>
> What's wrong with a user saying "I don't have time for this now,
> please tell me what to do for now, I'll look at the warning later"? If
> anything for those users the configuration is the wrong thing to do,
> because being in a hurry they just choose the first configuration and
> forget about the warning without actually looking at it (because they
> didn't have time), and it will not appear any more. By typing "git
> pull --merge" the user can get rid of the warning *for now*, but the
> next time he does "git pull" the warning will reappear, and at that
> time perhaps the user does have the time to read it, and look at the
> manpage.
>
> Nobody likes their workflow to be interrupted and be forced to do anythin=
g.
>
> I don't think my patches plus that suggestion for a quick opt-out are
> in any way worse than the current situation. If you think they are,
> then we'll just have to agree to disagree.

Yes, we can agree to disagree on this particular point.
