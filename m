Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7D4C2D0E4
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 01:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7202C2343E
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 01:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395484AbgLKOMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 09:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390571AbgLKOLl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 09:11:41 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B83C0613CF
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 06:11:00 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a12so9167005wrv.8
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 06:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ktM5ME3t8px68f+M6cBhXfD7VP4fHOVQEfHAbNzd4z4=;
        b=C6CHGDi4bmQ/a58w0SiW1crvK35FJXm1IE6Fh6/FpD8JpfRmiJzs7TENXkO3tKlff7
         bKICUhitNTNNvjHfNqQG+3hcCTB6zbOJJlWNzvcqDo3tR6vF9MlVbiyXQBW8qN4oDx6K
         jh/FR/dTlyc1P+bZ9gFqluIarTAz5yGsW/awjtAxW9zW4zHExjl3LGGGsSLTY98kpuHC
         aBIOb0tIBx3ThMrnTNiZD0KSR81qoKp5uWRFzbNjRoo2mwDUbG3SCY1JJ1e6gXuoNrm7
         C9LW0SNN8x4oYrJ/sh29lAwzq3HIJISx5dFl6/lBegovtSkVmMUPysUwQOuR1K9CYrNm
         O4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ktM5ME3t8px68f+M6cBhXfD7VP4fHOVQEfHAbNzd4z4=;
        b=LgY1JIsrR3MF1GXZ/eV2sYItC/p3ugPxaWz4E154hUdh6Hvo1s96QfJUFnjT04WEDx
         UirN0T+hyZ8bef+PF57QJiXI5xQ48mB7JvdyunA0fdv2+00s90mlp1VO1vHeChh2jVCL
         1Uw2vARzeZfaiCoqCvh9KzV7vVPbtbXHi6ICru6ux9sZJGrddGG36PaFH3Y/lrDgD3JO
         gG2/Bd97YlJPs90MfRgnurkvwlcVu+9xQi87KFirbhBYm7/htmqmwuK3rJLFuvHTAoBI
         +LRnXXELfFDDSBkoBtyIdqWa1RmHEK5ZfaAzeAuI88wArqZdyD50hPN7OC1Dghx9qSxO
         yulQ==
X-Gm-Message-State: AOAM532sE2X2o+PXg5P3gdjEzAXcBQNsjpT4gyTkqIzenxn2Q1HOYlV9
        +1+BLON0MixzodCQevqUOm20oyvJh5H3uykbMpQ=
X-Google-Smtp-Source: ABdhPJxJ6BZ3lwReCVJvSOFvrrZc8IdxFb38G69VQ4KzckRSwQErWcdpdh0W1RBoZP3PXl5UD1/Q01+FJAxxNK6eOow=
X-Received: by 2002:a5d:68c9:: with SMTP id p9mr14164782wrw.139.1607695859474;
 Fri, 11 Dec 2020 06:10:59 -0800 (PST)
MIME-Version: 1.0
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2012091502000.25979@tvgsbejvaqbjf.bet>
 <xmqqk0tq1xf3.fsf@gitster.c.googlers.com> <20201210152715.GQ52960@mit.edu>
 <xmqqim99wm61.fsf@gitster.c.googlers.com> <CAMP44s2Po25VyHs-xQG0_oKhAOvPK_PNu5edQkYYsScZeBw1nw@mail.gmail.com>
 <xmqqim98inml.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqim98inml.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 11 Dec 2020 08:10:48 -0600
Message-ID: <CAMP44s1MMGN-uUf0NFBrmza0n-p0+evTqFBBM5YqdQapEVy-TQ@mail.gmail.com>
Subject: Re: fc/pull-merge-rebase, was Re: What's cooking in git.git (Dec
 2020, #01; Tue, 8)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 11, 2020 at 5:32 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > On Thu, Dec 10, 2020 at 12:28 PM Junio C Hamano <gitster@pobox.com> wrote:
> > ...
> >> how much damage are we causing to
> >> existing users who expect the command to work the way it currently
> >> does?
> >
> > Zero. Because my proposal does *not* make the pull fail, it merely
> > prints a warning that it will change in the future.
>
> The approach to hold the "future" patch of and keep giving a
> "warning" is still likely to cause damage to people like Ted and
> Dscho (both gave examples of workflowsand automation that currently
> happily creating merges as the user expects, while the user just
> ignores the warning, without being configured at all), when finally
> the "future" patch (after fixing the test breakages, of course)
> lands.

That's right. But it doesn't have to land.

If after seeing the warning too many people complain about the
upcoming change, we can backtrack and decide not to pull the trigger.

> They just ignored the current loud messages---I do not see
> any reason to expect the updated "warning" would have any effect on
> them and help them to prepare for the future default change.

Nobody has offered them the chance to set "pull.mode=ff-only".

So how do you know they will not take the offer of something they
haven't been offered yet?

There's only one way to know.

> It is either being dishonest or deliberatly closing eyes to say
> "Zero" after hearing what they said, I would have to say.

It is a fact that a different warning (which is what I'm proposing)
will not affect them. There's no two ways about it.

Moreover, Ts'o said that he is already typing "git pull --rebase", so
he won't be affected.

We can leave this warning indefinitely; one year, two years... until
v3.0 is released. As much time as is needed, and after ten years
decide we don't want to pull the trigger after all.

Take a look at what happened with `merge.defaultToUpstream`. You
introduced it in 2011 after others and I suggested it:

93e535a5b7 (merge: merge with the default upstream branch without
argument, 2011-03-23)

And it was not actually made the default until 2014:

a01f7f2ba0 (merge: enable defaulttoupstream by default, 2014-04-20)

But *only* after we were confident this is what users actually wanted.

This gives us the best of all worlds; 1) a configuration that is sane
and potentially most people want to use, and they can use, as an
opt-in, 2) a potential to flip the switch and make this behavior the
default any time we want (after it has been extensively tested), and
3) the potential to backtrack and leave it forever as an option, and
never make it a default.

Cheers.

-- 
Felipe Contreras
