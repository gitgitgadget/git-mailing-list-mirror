Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0784AC433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 01:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A293764DE0
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 01:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhCSBEV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 21:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhCSBER (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 21:04:17 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93627C06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 18:04:17 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id n8so3024628oie.10
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 18:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XVYQqUKu2z36Hi7KamWGUYJMHpiicpxmsCLCYkLtWG4=;
        b=PqCJ957rqC5ABbCsTmosIJu+rU25G867uLOaDtJsaWSETvcqWNTYXnnhoIgB+zkpIl
         BxZFmGP0zB9sO9ErV8BRVV8d2FLCx4MV3WxU41w/aFxuzE1tBtb6VN4GS+6eS1dSsmW+
         RGnIXA4ruk2B0RdZiU8l3OvNjPXR9m2XPi0kq6ATbI4eTMgWZqj72as3XmfRutV5To9d
         vkDuVJ16ydLlH7QuFYlgV4qDemVdTRR7PllCZLxcIpLuQM/B2ggy+g0WW86frygLyS7n
         2KdtiFmdfvC65CRs6q9bIdDwdBWpxoe3111QfMMyZltdvFUfVppF8ARoTlrPaJIqPLQt
         ArEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XVYQqUKu2z36Hi7KamWGUYJMHpiicpxmsCLCYkLtWG4=;
        b=dHX/yll5hAJA5pevDp25rfjINvjAHcfAyQ5hXlg0eUnIOoJayDj0LzpQ7vCJ5jWJ4F
         CS+SLyR15WzbhWhsrlYPNMKg1GavtdUweOZPRXmhMXmX196owcvyN4kxvIWvl7hFC7mE
         4ZYZsQJh49Fz4pxdNvn/g8qNA86ingriat3qNwV9Gv7kk7p6luglcU25aB7G7ZO563/B
         NGTk48DWDJiGgiP5f0cbhGrnxo/WzwqdPPlzfWCKT23W3otIaRAVb5Rqc2cDkL0yBTLO
         Uc3x884PLD8pSCAt8E0AtdUeYjlqYR2U4PStpvn4pDBIN2/wKFaxPe07+lMt+8m9IswJ
         Zi8Q==
X-Gm-Message-State: AOAM530o48KnaGSmvciHjOcTFLXm3+nsFJufozU8rg5MVFwkuzMDDSbe
        jTWXxW4jhB/TC//srlDJlCvII/kD1HoRZzxtjUY=
X-Google-Smtp-Source: ABdhPJxub/sv3aZ7jRgN2RVXHkFrSnjE9DN+xBmaa7kRB8FliWo89p32Je0XDUsvJz94gNETlJd2GyCb38H1DGC01E0=
X-Received: by 2002:a05:6808:a8a:: with SMTP id q10mr5046533oij.167.1616115856959;
 Thu, 18 Mar 2021 18:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqblbhtoa6.fsf@gitster.g> <CABPp-BGkvUK3Xs6ZsWwv_C_tdJN-84ebBcxZCAoRu+sX7aWQ8g@mail.gmail.com>
 <xmqqeegcqe0t.fsf@gitster.g>
In-Reply-To: <xmqqeegcqe0t.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 18 Mar 2021 18:04:05 -0700
Message-ID: <CABPp-BHckvLF1q_Wr4=rC33BDg3o+4Ob+WUn0LGe6RwCM6DjjA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2021, #05; Wed, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 18, 2021 at 3:43 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> * en/ort-perf-batch-8 (2021-02-26) 10 commits
...
> >>  Will cook in 'next'.
> >
> > I think it's ready to merge to master.
>
> When a "will merge to 'next'" topic is merged to 'next', its label
> is mechanically rewritten to "will merge to 'master'" outside the
> pre-release freeze, and to "will cook in 'next'" while pre-release
> freeze.  So for the topics labelled with "Will cook in 'next'", by
> default they should turn into "Will merge to 'master'".
>
> That was why I was specifically asking for topics to be KICKED OUT
> of 'next', to give them a fresh start without having to do "oops,
> this was a mistake, let's patch it up".

Okay, color me confused.  You said in your original email:

"""
Many topics marked as "Will cook in 'next'" should be marked for
merging to 'master' now, but that hasn't happened yet.  Please
nominate those that should be kicked back from 'next' to 'seen', if
there are any.  Please also nominate those that should be among the
first batch of topics to be in 'master'.
"""

You had two "Please" statements in that paragrah.  I've nominated
topics for kicking-out before, but didn't know of any relevant topics
this time.  I did, however, think of one that I thought was worth
nominating for your second request.  Maybe I'm still misunderstanding
something important here, but I'm worried about exasperating you any
further so I'll just drop it.  I was trying to be helpful, sorry that
I wasn't.

> > Here are some reviewed topics that haven't been cooking yet, that I
> > personally think are worth picking up (at least for seen and probably
> > for next rather soonish):
>
> Thanks for a useful list of topics.  At this point, topics that are
> not picked up are not because they are not ready/worth, but because
> there are too many of them sent during the pre-release freeze.

Totally understood.  I wasn't trying to imply anything, I just know
it's hard to keep up with all the email (I honestly have no idea how
you do it as much as you do).  I know that especially when you're
busy, you might avoid picking up topics that look like they're just
going to continue churning.  I figured that it might be useful, out of
the topics not yet picked up, to highlight ones I knew of where the
current reviewers appeared to be happy at the state of the series.  If
my guesses at what might be helpful isn't, do let me know and I'll
avoid repeating.

> > * My ort-perf-batch-10 ("skip even more irrelevant renames") series:
> > https://lore.kernel.org/git/8422759a-a4a3-4dc6-4ae7-4a61896b9946@gmail.=
com/;
> > (the review comment there is addressed by the next patch series in
> > this list)
>
> There are 8, 9 and now this 10 in flight, which is two topics too
> many to have in flight at the same time X-<.  Luckily -8 seems to be
> good for 'master', so there is no risk of having to rewind it
> anymore, which makes the burden of having to carry multiple dependent
> topics at the same time.

Well 9 is "skip irrelevant renames" and 10 is "skip more irrelevant
renames" so they can be combined into one.  In fact, the "declare
merge ort stable" series was primarily addressing an issue reviewers
found with those series, so it could be lumped in too.  Would you like
me to resubmit that as one bigger series?  (The whole thing has been
reviewed by Stolee and about a third has been reviewed by =C3=86var, if
that matters to the answer.)

Also, moving forward, to avoid the risk of rewinds...

I had been trying to avoid the risk of rewinds by waiting until any
given series was fixed to the satisfaction of those who had spoken up
and reviewed it (and ensuring that included at least one person),
before I would submit another series.  If that's not sufficient, what
should I be doing instead?

Thanks,
Elijah
