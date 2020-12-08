Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5021C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 03:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 865E723A59
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 03:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgLHDP6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 22:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgLHDP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 22:15:57 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834F9C061793
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 19:15:17 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id m5so5144116wrx.9
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 19:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FO+irQxJkrLWPjRqjFPfrpciITDuvl/TBAcEYYKw8ZM=;
        b=FhQsgfj9jAjEoLW2iukdvE8jZ5Fd+2pg0H9nN9/+XYwY/ENVxZQvNpviUd0IHfB6Y9
         VLpguLrtgE2SehH7n66GLENYW6XPGy8TDc7nDgOvBcMscI77obMYzSK5ouu81nIxaJAj
         2XD5/NIEf/Vji8tFfZpzeToRmecakPwF7uiu0fSRDvYgeLkTZSf5Fjk7vYdIN7J6KCz4
         fOwk1/+VBDRirO/L1r9qJLKJ2NBFURcmyBteMlwmLkyxSbWib52xfTW2O3vQEbmSi/Dp
         wl8u46HE/j2NtiClI4IKquCBg5pVxiZjiTyipWAkHCy5DnIzilTgBDkgm4oRf5VZdpkJ
         X/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FO+irQxJkrLWPjRqjFPfrpciITDuvl/TBAcEYYKw8ZM=;
        b=VtG9jeJSNu/GYPGjJzsE9HaBoGf0EhYSGJ4jzW1CFHJ6VUvZPQaB47H7cQaecE5ZQ/
         3VZh0uMGCcRCIrvinau6BT6Yy46jVbl5ONPvVv8ZXJr1mljNR/2B2W8F1y/B+zbSlYjg
         lyMUCHZ4cY1/u5ootbtRUurmueo4X4Tzm9HDjsm3hJ4DTdvH16DHR96tsEMpP6yFdJhq
         Bnmty/cuhQNRLejVdVP/NgFiAer9pIRv7rTQwq8WxoII02t3kbcVNuI0+hO5r35rRhTO
         wUg7fnk79LAHwWS9p6w8QOY2DzhyowGRr1Yrr8iI98QV1/0N7Rmh2NjotUXrO7vPs4sV
         djCA==
X-Gm-Message-State: AOAM530TU/AlVAwWSTCxpLKOjxT4SV555V53myyLnKzr1hJT+QkGkUw+
        2A5H1jqKhue0sx+CjUqu12AjnazWBJemtq7XLCA=
X-Google-Smtp-Source: ABdhPJwdVFbbdV+VrsJvkMOGg9CvCGRFxdJhmvkp7QEcx6t50CrWq6paMFfPkck+9dtqR4I7UFX0ElRPUNJbLAq8tb8=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr23018720wrv.255.1607397316211;
 Mon, 07 Dec 2020 19:15:16 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-3-felipe.contreras@gmail.com> <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
 <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
 <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
 <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
 <CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com>
 <CAMP44s2L24jhCG9ps72--ZiJkXUovR726jCf8JTLHAs0jV7Whg@mail.gmail.com>
 <CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc7mBLGbw0Qw@mail.gmail.com>
 <xmqqeek2cc14.fsf@gitster.c.googlers.com> <CAMP44s2XFQoda_PMULWha-rj9HhNfEddO5fikmswk9=AWN4RCw@mail.gmail.com>
 <xmqqpn3lbhxn.fsf@gitster.c.googlers.com> <CAMP44s2nmVnXiBA8S=vHBZznuRNKKe=xGOEBJ80MYhA_XCqNkg@mail.gmail.com>
 <xmqqlfe99yvy.fsf@gitster.c.googlers.com> <CA+P7+xp=UGd0iK8uLxnqH0iycrxo--8on3d0Z+jsuyhpV-fVew@mail.gmail.com>
 <xmqq360h8286.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq360h8286.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 7 Dec 2020 21:15:05 -0600
Message-ID: <CAMP44s3KCoDfRXzarJw5AE7UsY-=eP6GbHzdDcdrs2rsw5tL+w@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 7, 2020 at 8:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.keller@gmail.com> writes:
>
> > I think the key point is that this "in the future" is referring to "a
> > future version of git will make this an error"
> >
> > This might be better if it said something like "The pull was not
> > fast-forward. In a future version of git you will need to specify
> > whether to merge or rebase, using pull.mode"
>
> Oh, I've actually been assuming that the current "warn but go ahead
> anyway asssuming the preference is to merge" can just be declared as
> a bug (iow, there is no need to say 'in the future'---we'd fix the
> bug right away).

It is a bug, in my opinion. If we were not planning on changing the
default, I would say drop the warning altogether.

*But*, if we are going to change the default, the warning can be
repurposed to say "in the future this will fail". That requires other
changes though.

> > or something similar. In theory, this warning will go away once that
> > future version of git changes so that pull.mode defaults to ff-only.
> >
> > The difference being that a warning will allow the command to continue
> > doing the default of today (merging), where as an error will stop the
> > command essentially just after the fetch portion finishes, without
> > changing the branch.

Exactly. And we can choose between those behaviors with a
configuration, like it happened with push.default.

> Yup.  If we want to take things slow, that is fine by me as well,
> but I am not sure if that is even necessary, given how annoying the
> existing "loudly warn but still go ahead" behaviour is, and how easy
> for existing users to have squelched the annoyance by choosing
> between rebase and merge already.  I've always assumed that any
> existing users who started using Git in the past several years have
> already set pull.rebase to one or the other value and they won't be
> affected by fixing "git pull" to just error out.

Existing users that are using up-to-date distributions, maybe. Debian
stable is using v2.20.1. In general it's not a good idea to assume
anything about our users. Recently a user of Oh My Zsh reported an
issue with the backwards compatibility code of git-completion; he was
using v2.17 I think.

That is exemplified by the fact that this whole thread started from a
user that refused to configure pull.rebase and expected the Git
project to just do the right thing (which is basically choosing a
useful default).

Cheers.

-- 
Felipe Contreras
