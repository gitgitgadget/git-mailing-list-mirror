Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BCEC4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 02:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CB2123D20
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 02:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgLJCkI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 21:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgLJCkA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 21:40:00 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E603C0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 18:39:20 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id m5so3858753wrx.9
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 18:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7DuakkEVBCauqHN76yS8qtxIgiIhyI1tqm3Z2TE9N3k=;
        b=G7rX09+vdKjoPGkbUeMWM4nSQiYOPW6iOFe62GLWENHcsaaC3A/ZCwC0wZ/ZROPvLA
         KoVi+cW+aw0dLUMVZMp+sWhlidEjbLqVNJKYQ8QaetZQ+TXu7y/b1TXo2IRnsifz8939
         CKczbbfkkEh9+hb+ARb/xOzvkJWC1kK11elEYOTqC5voeEuqkwzBW4sNsT8I78q2JbB1
         uOUritT9JKUNlocAstjNoFX1zVBDQEQY3BucVzCCm7kD4YYykho/tsMRUXieWw5/AvLQ
         Y/vwVvrNomHW8lAwiA/eifxVatPdoqaQSJRz1zf3PT0a+zHaUyo40MHkznizR/otyw7P
         Bxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7DuakkEVBCauqHN76yS8qtxIgiIhyI1tqm3Z2TE9N3k=;
        b=f29X75RqdbtYtBrUXp2yIsEvMFlm+lwn2/eBcJT4ELt3D2Wko8az06h729lsZqyxo4
         opSlhLu+is/FW8c3yDVQc+NXN/sLuFl45oUObEjHv2ghYob+g9aOVSNiJj3q4atu5wf/
         zY7cozldzrukd+cOHH4/igXjkcE2Yyj2V0ApuBjuUvY1NB30RrTIb/8KEll7NkUpE+B9
         Jvm/8faQbNWSZLv7/Zq8MDGoN5+YC9FDc0yhQuLQamsQnJhbSPt/IVuHZdWzWN2KHEHK
         uhKPlATznHMlPYrLK62PZcyM3/qs48p5k20U5NAl9IongLRwmTWe9XOltIVzzIbMFcPm
         7yqA==
X-Gm-Message-State: AOAM532Bd7OaZdCxJGVQxt0aAX0uOMclhKfTe7SMBeDPGn7YK0KUAXCc
        FmArgplF0b+KritLOSqIfOHjsPq0hy/5mwYiCAU=
X-Google-Smtp-Source: ABdhPJze6KlIuvbRCEgcLUJj/cNPhXjd+OEEuzZgix5zS4bnhZrCBbdC6OhK5Ojfg3l0z/g7m1JujHNE0MmkFXymeDc=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr5454908wrr.319.1607567958993;
 Wed, 09 Dec 2020 18:39:18 -0800 (PST)
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
 <xmqq360h8286.fsf@gitster.c.googlers.com> <CAMP44s3KCoDfRXzarJw5AE7UsY-=eP6GbHzdDcdrs2rsw5tL+w@mail.gmail.com>
 <xmqqy2i86ok1.fsf@gitster.c.googlers.com> <CAMP44s13YFZeOMz6V5sPdOnLXD-v3aQZiP7vvXXNfQLZP4Puwg@mail.gmail.com>
 <CABPp-BGZcmHhge7JnM12baL_86yV-+7z4kkvFwUUrP+db8QD8Q@mail.gmail.com>
In-Reply-To: <CABPp-BGZcmHhge7JnM12baL_86yV-+7z4kkvFwUUrP+db8QD8Q@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 9 Dec 2020 20:39:07 -0600
Message-ID: <CAMP44s2zEi7WqiwZMN8CRzjQ+1CjPpagpTqhAtX9Vx4a5XKoWg@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
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

Hello,

On Wed, Dec 9, 2020 at 1:05 PM Elijah Newren <newren@gmail.com> wrote:
> On Wed, Dec 9, 2020 at 1:53 AM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:

> > I could do some mail archeology if you want, but this issue starts to
> > be mentioned at least since 2010, and virtually everyone (except one
> > person) agreed the default must change, even Linus Torvalds. Reading
> > back what Linus said [5], it's something very, *very* close to what
> > I'm proposing (I would argue my proposal is better).
> >
> > So you let me know. Do you want me to dig a decade of discussions and
> > coalesce those conclusions into a summary so we can decide how to
> > proceed? Or should I drop the plan? Only that if we drop it, I
> > *guarantee* we will discuss it yet again years later.
> >
> > Moreover, this is the reason why I split the series in 3. Even if you
> > decide you don't want to change the default, part I of the series can
> > still be merged *today*, and everyone would benefit.
>
> Have I missed some subtlety here?  This whole email appears to me to
> be arguing against a strawman.  Reading Junio's other emails in this
> thread[1][2], it's pretty clear he thinks the current behavior is
> buggy and suggests how it should be changed.  From what I can tell,
> you appear to be arguing against doing nothing and against only
> accepting perfection, neither of which were positions I saw anyone
> take.  In fact, the positions you argue for at length appear to
> exactly match the ones he took[1][2].  What am I missing?

People change their minds.

Perhaps I misinterpreted something, but when Junio said "I dunno" I
take it to mean: he is unsure my proposal "pull.mode=ff-only" makes
sense. He also said "for anybody who uses git for real, [force
-ff-only] would be pretty much a useless default", which I take it to
mean that perhaps we shouldn't change the default to that.

Back in 2013 Junio said "I now see how such a default makes sense."
[1], but we are in 2020 and such a default that made sense is not the
default.

Mind reading is a really bad habbit [2]; I don't know what other
people think, and I would not presume to know.

All I know is that the path forward is unclear. And because I
prognosticated that, I split the series in 3 parts, and I've yet to
see any objection to part I, which would improve the situation for
users *today*.

So, while we make up our collective minds, there's no reason to bother
our users with an annoying warning on *every* *single* *pull*.

Cheers.

[1] https://lore.kernel.org/git/7vli74baym.fsf@alter.siamese.dyndns.org/
[2] https://cogbtherapy.com/cbt-blog/common-cognitive-distortions-mind-reading

-- 
Felipe Contreras
