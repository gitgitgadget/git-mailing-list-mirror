Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C2BC5519F
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 00:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07002246E4
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 00:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtcCuu5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgKSAbH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 19:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgKSAbH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 19:31:07 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45231C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 16:31:07 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w14so2738484pfd.7
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 16:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cD6XhJhnsCnzHB/op0vSBLaD2hju8QrF/68f2oH4VGQ=;
        b=KtcCuu5CmUacWvvJBkMJvT9xe1h0RtGgeVQeVJySXTET2GVAVNy5H1YhvFPb5LcrlG
         0UMWS34B4dLyP7cVLoYGkkn4UQvDzXFGkF/0963EnTTz/91CKdiZJviJi9WHe6Rt85OZ
         Vq4fI+NaR11SOIkKFO9eiTt46EzMxn/ptlKI8jQKrQ5mhZJLh+yUtR9FezYxMfFYKu2M
         CQfgHGsJpXMndYb8aKtrd5Vrqbyq/PJnz2IhnZAjQ1it2Nei4Qk7q7NHo8rp0kaVCKTw
         /LEbsFdH9Vw+BGDDbewKXRrJXzpOS0m+m6pGp+aQIuus0MJlZb9/aSKlJsZOJaWDid3M
         7HoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cD6XhJhnsCnzHB/op0vSBLaD2hju8QrF/68f2oH4VGQ=;
        b=ZF8wUIU07got7bMJRU0JjjPsNEL1LSA7fk00HIRms6gRC4JP9De2Uyjqe+gf6FqBOv
         Ffu3bO6SFTHeecrbIjgJZ7BwvgKoZ8LCgdPCTxPWY3NTO2TgcbaKIhGaWbAqcWMamJy4
         6vsL1lk8n0GYe4LcC/UbrxWy396cIXpOBhkqN6XdGf6ex+TfhD9o52BBz22vWZ1Ww13Z
         8WjFvFGWxHBMz4Ppi2v4CrcSurzL+MPDk+Ia+XZCV306sdIW9bdaNqYX7AZtVuV/giE3
         bLXMc5EUh38D7P+MnTK2cB4Usz+ALquV0qDzGnnXyfuWKe1e9c3nKAJzw4n5aI1J2bAl
         cLGw==
X-Gm-Message-State: AOAM531M/GpL73yP9EzeYczaK9ZZk08hwCEm93f/nTB95i9eTBsJMJIa
        Rdcqm0fstP+j0INPL7VT8kmgRZ3PLW6fuvRrJ4w=
X-Google-Smtp-Source: ABdhPJwwaU/IzSSFe3cGDQ+ZcIT36Cq6EerNHIbWacpTSg4XLPcmu7fNRaaQd7PVy43Uczuz7GcvNNIpMNZCblCfu6M=
X-Received: by 2002:a65:60c3:: with SMTP id r3mr3453006pgv.300.1605745866618;
 Wed, 18 Nov 2020 16:31:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
 <87r1oraewl.fsf@x220.int.ebiederm.org> <xmqqv9e34mq5.fsf@gitster.c.googlers.com>
 <1389dabc-33c9-1e65-a3de-43729a6c2e70@iee.email> <nycvar.QRO.7.76.6.2011190057370.56@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2011190057370.56@tvgsbejvaqbjf.bet>
From:   Peter Hadlaw <hadlawp@gmail.com>
Date:   Wed, 18 Nov 2020 18:30:43 -0600
Message-ID: <CABrPy+HYji9yD4pjYcGpmRq488nSgwEMfqFMOsxbmhO3GaXctA@mail.gmail.com>
Subject: Re: [PATCH 00/28] Use main as default branch name
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Junio C Hamano <gitster@pobox.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

It's worth noting that the word "slave" comes from the en_slav_ement
of Slavs (the Slavic people of Eastern Europe).

I encourage the whole git team to really think about the changes you are making.

It was just reported to me that a professional friend of mine had
confusion as to why,
after initializing a new repository, they couldn't navigate to the
`master` branch of their repository.

I understand this is back-of-the-napkin type math but stay with me for
one moment.
I also understand GitHub is not all of git users, but I just pulled
the number to help me out here.

If GitHub has 40 million users but let's say half of them aren't
active, so now we are at 20 million.
(Replace this number with how many actual users of git are out there.)

Let's even say half of them are on board and aware of this "harmless"
change to a more "sensitive" doublespeak representation of the
"master" copy/branch of the repo.

That leaves us with 10 million users of git that are either unaware or
are not on board. Let's say it takes 3 minutes for a user to search on
the web why exactly they can't
navigate to their "master" branch. That's 30 million minutes of time
wasted, or about 57 man-YEARs of time wasted.... for what?

When do we put our foot down and say enough is enough, and not
everything is offensive?

Again, please reconsider making this change towards doublespeak and
consider the ramifications of how much actual human life & time will
be wasted.

Kind Regards,
Peter

On Wed, Nov 18, 2020 at 6:01 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Philip,
>
> On Wed, 18 Nov 2020, Philip Oakley wrote:
>
> > An alternative in the other direction is to go with the 'not currently
> > on any branch' (detached at nowhere) but then require users to
> > deliberately create their first branch with their chosen name. This
> > moves the 'backward incompatibility' to a different place, which may be
> > easier to manage.
>
> It might be easier to manage for _us_, the Git developers. But every user
> who initializes a repository and wants to push now needs to take the extra
> step to give their unnamed branch ("detached HEAD" is _still_ confusing
> new users!!!) a name.
>
> That would be much more disruptive than choosing a "rather dull and
> boring" name instead of a rather racially-charged one.
>
> And we promised to try to minimize the disruption to Git users.
>
> Ciao,
> Dscho



-- 
Peter
