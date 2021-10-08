Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3DBC433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 22:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D89660F35
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 22:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243683AbhJHWcc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 18:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243610AbhJHWcb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 18:32:31 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE51C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 15:30:35 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t9so43704499lfd.1
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 15:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WCB/5929vTCFKOoPkAVXo1hkQYDFPUkBNXHLFAGhTDQ=;
        b=qP7K84TjYqt2puTwSAJ5wPRwhVXCnA2f4dHQpI1CMppjQtxCq85mFVGUHxKsWw6dDQ
         xLGOTgofHNCCzHLohxSYiujp/AC9B3dJ9WKbwtpnEWaOw7jfO+F+yh6jLeO/eWQEIF0T
         VyuTvv3MTOSH915wm1KQKuaA0Ej5uF4MW77kclw9iouqtLpzgTlcb+JTcxWdDcuP2ZjJ
         tyPLI7/uyKGHNGK7mm1mNetxfZkFeK62zkjk7baL7J1yo6WipkMhYPq9wJKHLXWs9bYB
         eJUPh+q/67it4mL20B8UYxcwxGrswtosWHVN+57Z+Hhpbv5IvMirD3Zv7G/bk4V9GbVt
         DKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WCB/5929vTCFKOoPkAVXo1hkQYDFPUkBNXHLFAGhTDQ=;
        b=I0P8g/qCDzvcUi9YAglDfmkP/E7c1Z2L/5RjGrymF2hp0xmHAwMwMzIYK3eL8g9Xre
         ECTsUHNKilgEfY0c9FLEvT5ZLdNrNDuC7hFfnMwwd/6oimNWZAmqcpoFaCHOQ3PgUt3+
         BvRzQjAweVQIIEVz3WI6eIK3c49neY2cw99f805SffKXjRYhobjnGh1xmTpMkdHvjyu1
         AP5ieajEEaeX+HbpIx8MTGAtzR2HYarscwfzQBvpoUl2AGFkk8PEaMgv482khJqxsOmZ
         kbZRDs8ff6mvgNdlKgPnuL6KqYvpMkR1Ej6LqZA2bw8An5lZNYjmWaVy6YhljuMco+iY
         A1KQ==
X-Gm-Message-State: AOAM5319Q/+ho+X0LplpD3mcolZwXdP7aLwmix8E3c73CeBJL6K2rgBw
        xsQL74PQC89v6MZeeqIs6W6DwtU0rdUzlKqcyWlHcbX0
X-Google-Smtp-Source: ABdhPJzNiqr+yOjxYODqr0FOEpXs6A20ikogNvrfqR9+HO1a+8/pSQePJ2HrKYtTo+7tIjYrDkRicf8fEF4CTlrL0+E=
X-Received: by 2002:a19:6b04:: with SMTP id d4mr12917310lfa.74.1633732233737;
 Fri, 08 Oct 2021 15:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8rzhmsi7.fsf@gitster.g> <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
 <87v92lxhh4.fsf@evledraar.gmail.com> <xmqqilykliiz.fsf@gitster.g>
 <20210928210059.vy5isvmcj75vufdu@neerajsi-x1.localdomain> <xmqq8rzgi8a7.fsf@gitster.g>
 <CANQDOddZ-KYTB4q0nYNDinis8aKktm6Ek6F+mJouTV-yRtTpUw@mail.gmail.com>
 <xmqq4k9spk8p.fsf@gitster.g> <CABPp-BE=7+XifO3mAzNB90Y0vatvhwk7wwM4ptBrg79BhiFqSg@mail.gmail.com>
In-Reply-To: <CABPp-BE=7+XifO3mAzNB90Y0vatvhwk7wwM4ptBrg79BhiFqSg@mail.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Fri, 8 Oct 2021 15:30:22 -0700
Message-ID: <CANQDOdeSjKsGUYacGwx-fnigqiocbyDOfz2O8im6-7txDCuZzQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Junio.  I'd be happy to have my change go in first.  I'm hoping
that we'll be able to get a lot of mileage with batch mode in Git For
Windows early on.

Thanks,
Neeraj

On Thu, Oct 7, 2021 at 11:52 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Oct 7, 2021 at 3:01 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Neeraj Singh <nksingh85@gmail.com> writes:
> >
> > > Elijah,
> > >
> > > Here's a branch of your changes based on the amalgamated tmp-objdir code:
> > > https://github.com/neerajsi-msft/git/commits/neerajsi/remerge-diff
> > >
> > > This commit adapts your code to use the amalgamated API:
> > > https://github.com/neerajsi-msft/git/commit/725328fe1d8be8326d2ddef78e164ca21450b100
> >
> > It seems that the discussion petered out at this point.
> >
> > Right now I have a version of ns/remerge-diff before this adjustment
> > in 'seen', and Neeraj's latest version is kept out of 'seen' as they
> > do not play well together without an adjustment like that.
> >
> > What's the good way forward?  I do not deeply care which one goes
> > first, but I have a feeling that the need by remerge-diff that wants
> > to discard temporary objects would involve more work to make it safe
> > than the need by batched fsync where newly created objects will not
> > be discarded but merely moved to the primary store before the end of
> > the operation, so from that point of view, it seems simpler and
> > safer to queue ns/batched-fsync topic first (especially given that
> > it is a no-op until the end-user opts into the experiment), and have
> > a remerge-diff that uses the infrastructure from Neeraj's topic.
> >
> > What's your take on the rebase Neeraj made, Elijah (at the URL
> > above)?
>
> I meant to dig further, but nearly all my git time in the last week
> and a half was attempting to keep up with other patch reviews.  My git
> time is fast disappearing in the near term, and it's not clear how
> much, if any, time I'll have to work on patches (or even continued
> reviewing) before, say, mid-November.  I most likely won't be able to
> do any discussion-prep work in advance of the Git Contributor's
> Summit, and might not even be able to attend anymore.
>
> I had looked over Neeraj's patches and they looked reasonable.  I
> thought there might be some tweaks that I could try out, but at this
> point, just take what he has and keep my topic as expecting an update.
> I'll circle back eventually.
>
> Sorry for the delay.
