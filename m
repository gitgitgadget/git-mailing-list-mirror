Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D680AC2D0E4
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 00:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9CA206F7
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 00:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/gpJntg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgKYA2u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 19:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbgKYA2u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 19:28:50 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AEBC0613D4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 16:28:49 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id e7so213845wrv.6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 16:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+zF+OIfrq42ILEwM3EJkC6Qz7E6Cr1xW8/+wX5RhGjI=;
        b=m/gpJntguXkEEVmDA1m8VN04yQsO6U0Nb4Xc+4zAYRT3CWVFYZNjilMml6Cl0xExXC
         kvafZLc9V8NyV9DMridQslygAkVIze6KF1YR+56s9aSLYq3K+hAD7nKhLHHRIyv2XA8Z
         ipp6qrCGjjq4vK0KeTQWJkBX/etLFMmfs2xSXQ1+WP4Rnj9rw1AAeNgrUbA2+X+WZElH
         j1BllE9epGE4HDg76Kgo1SfqtLmGvTyr6AD0Hs7ytaM9rF9EBTiestyqSSG4ASLNOc1+
         2b/NYY84EJ9f4X6nTjcSrSxiGJi+BLD+X42tuplFKZad71YNVuMa0R3dEWsbcEUBEYuw
         7vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+zF+OIfrq42ILEwM3EJkC6Qz7E6Cr1xW8/+wX5RhGjI=;
        b=Un2GsDh51HQXWj6iKelWV4g5jkXZy+P0og6/jSEYn0jOWA5Viy/AIYjftHpJh+5TUf
         sdlUhZ2eOkqlNdyD61Q0Fyfr5p4qkFh3KpcdxeAhQQkaQVYIDsdTgpehpw/8sesv5soH
         9NRYH1DHnJbkzFIbkbwNeLosy4UzAVhms3d+EwUrjSiveER/2lG4Q4sn58rq0J5+fN1I
         AkcYrOSYiA36Yu3LY5tc559s9u1g5Cyu4xTv1C5o6wnvKsYQsWhgBIO0rpI3JKBbofaJ
         tS2CRBveTjZBnJwVWkL1CrRFLQuF+vMksR6bABhyB3dadLiE+TdFcgkt5QwuunvgqS+c
         1NOA==
X-Gm-Message-State: AOAM531CN9GW/YYafNXJ/3FGcxsSmuYit2kR5U+O91cRQmBiYyt0sM/O
        Z7/feAuwmu21/ZibPk2UvNb3yjgYXPCRwwby+pw=
X-Google-Smtp-Source: ABdhPJx+RXSyQQhD3DHUQPM9uX7anAqQI/rYpOYRnmkTHSq9E6Mc7/vcKz1r+DVHXrBPCjfyzSRsAobvu3sQVFxRjkU=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr1087785wrv.255.1606264128520;
 Tue, 24 Nov 2020 16:28:48 -0800 (PST)
MIME-Version: 1.0
References: <20201122164641.2091160-1-felipe.contreras@gmail.com>
 <X7y5Wxu1eY4k6753@coredump.intra.peff.net> <xmqqlfeqjzi1.fsf@gitster.c.googlers.com>
 <CAMP44s0PwJ8qEuCCpavshpm0GqV8p37rF8McR2=gdCk2kj+JiQ@mail.gmail.com>
 <xmqqo8jmgyrd.fsf@gitster.c.googlers.com> <CA+P7+xr8_s0Fq_TGjDjHEPpGJ8Br5x7omY1fsg0HjcXjutyRkg@mail.gmail.com>
 <xmqqk0uagxei.fsf@gitster.c.googlers.com> <CA+P7+xp_iTnkdbWoDSRZustvjk5BRJOPD=snae8D1Fe_uXqO7g@mail.gmail.com>
In-Reply-To: <CA+P7+xp_iTnkdbWoDSRZustvjk5BRJOPD=snae8D1Fe_uXqO7g@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 24 Nov 2020 18:28:37 -0600
Message-ID: <CAMP44s0F9TijOQ=JvosX_3z_F6wRtKe3gF=0NxrqucW4gAuzHQ@mail.gmail.com>
Subject: Re: [PATCH] refspec: make @ a valid refspec
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git <git@vger.kernel.org>,
        Brandon Williams <bwilliams.eng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 5:47 PM Jacob Keller <jacob.keller@gmail.com> wrote:
>
> On Tue, Nov 24, 2020 at 3:14 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Jacob Keller <jacob.keller@gmail.com> writes:
> >
> > >> Worse yet, @{4} does not refer to HEAD@{4} but refers to the 4-th
> > >> previous commit the current branch pointed at, so a mnemonic for the
> > >> end user to remember the distinction between the two is that a bare
> > >> "@" is different from HEAD, which is a total opposite X-<.
> > >>
> > >
> > > However, @{0} *does* refer to what is currently checked out, which
> > > would be head.. So in a sense @ meaning "the current branch" and
> > > applying @{0} would always be HEAD, no?
> >
> > Not really.
> >
> > It happens to hold true for @{0}, because by definition you couldn't
> > have been on a different branch than the current one when you made
> > the topmost commit on the current branch.  For @{1} and higher, it
> > is always "where was the current branch at N commits ago?" which is
> > different from "where was the HEAD at N commits ago?", unless you
> > always use a single branch and never switch away.
>
> Right, once you add anything greater than zero it breaks down.. but
> think about it a little differently: "@{N}" is sort of eliding the
> branch name, which means we use the current branch. "branch@" (if it
> were valid syntax) would be eliding the number which means "the most
> recent version of branch". Thus, eliding both and using just "@" would
> mean "the most recent version of the current branch", which cannot be
> anything other than HEAD.

Yes, but to me HEAD is supposed to mean "the current branch", so
"branch@{1}" and "HEAD@{1}" should be the same, and they are not. So
to me they are the other way around.

1. branch@{1}, HEAD@{1}, @@{1}: current branch 1 commit ago
2. @{1}: 1 commit ago in general

Since it's the opposite of what I would expect, I simply don't use
these notations.

-- 
Felipe Contreras
