Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E5AC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 18:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 414306135E
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 18:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355696AbhJASRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 14:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355832AbhJASRh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 14:17:37 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D344C0613E4
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 11:15:40 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v18so36899658edc.11
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 11:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=do6JEbXZHdOWGENqNDW8Xw5NTC75isDAEUgY7M9WALk=;
        b=A1cKRyJo/BNQ33ahGkp2nfQyOzYL+VT3lKERyrFp7+VlvG29sY3k8awkN2Nho5OoyX
         hI2tLzf8cZlAtIulQV8wtmij0/IdzlNikdCz447BeAuw8EJ2QJZGWAwNVuF3T2E0Gugj
         vrgCzXf1iWTzmXJaYd34ml2pgngCBWQdR7hDBtm6zhMCeF3HKLxOq/LSZPfK7izMrLWG
         Sq3VX9b3Mk0PrXJY5wmY/2ePMFxhoicCCuy1EClDpWJdKCQiQsO8VE+AQ44+S5UaUvFe
         6136ZFTakGQp/e2yRM68J9UFNCJ8vxYJf1lh+MhQoOJn8HPEwGjSOCbQkWQjmhH+lqmn
         F/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=do6JEbXZHdOWGENqNDW8Xw5NTC75isDAEUgY7M9WALk=;
        b=xpHyBE/t5ReZCxAJbPfciH9lWXODexh2RdYgZVGEBh7jLyt+UNZ/5Y+dRjen39mvmy
         Z//CP4sn4qZBNmUQIoXc4ALpkP1vm0+OzrTd5qPWjt1NTEUZDwmWr/85WB09fKKAw1uu
         BkJjJhksdPfkcoMc9NL60nTNKOz96WBA97VPz+ltqY19EbdT4Qw8cJxXaq1tJcglnxwt
         TXqofNniX/87PZX2z+DUEsSC26/tFavPHZeuZB3zQ0hV4fTEXOdYT0Zj6fIMmfKPfDRG
         CYhmVmIKoZTfMb0c+PUNq6HU+cOx7laxzOM4qieYwQlvaFh4dWP0KMjNz1pmihl6UWDH
         F1WQ==
X-Gm-Message-State: AOAM532677itNhf136Idqj+/V1Ji1vIfDKRVWqQp6QOkID/H2X1gGldx
        uBzLr7IWOUNG2BVTAKurDpMqUd1od297eeuoegI=
X-Google-Smtp-Source: ABdhPJxWQg0jO4cfO4eqEHxwFDLHMZcOREvYKrxSICHt7gvitKytWhUPggqZyuS1FSGJPVOgno3OoNbVDHTdzkxuZDQ=
X-Received: by 2002:aa7:cfc4:: with SMTP id r4mr15735956edy.244.1633112139041;
 Fri, 01 Oct 2021 11:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8rzhmsi7.fsf@gitster.g> <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
 <YVOn3hDsb5pnxR53@coredump.intra.peff.net> <20210929184339.GA19712@neerajsi-x1.localdomain>
 <YVVyUkwYNfkEqNfU@coredump.intra.peff.net> <CABPp-BH6ZzC9p94xda3SqfL0JjxoVAb3oV57a9cpg2ZDc=5NNA@mail.gmail.com>
 <xmqq7dew8yq6.fsf@gitster.g> <CANQDOdcBEQQS4c22AiXhAB6sEABWP-kRhmq8Vdd6KG0GemSa9g@mail.gmail.com>
In-Reply-To: <CANQDOdcBEQQS4c22AiXhAB6sEABWP-kRhmq8Vdd6KG0GemSa9g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 1 Oct 2021 11:15:27 -0700
Message-ID: <CABPp-BFe+A0rC+n3DDYEPXw3HAjhC7wFU2KX4bw1LV3wO3a6WA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 1, 2021 at 10:39 AM Neeraj Singh <nksingh85@gmail.com> wrote:
>
> On Fri, Oct 1, 2021 at 10:02 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Elijah Newren <newren@gmail.com> writes:
> >
> > > Said another way, I don't think anything should be writing a critical
> > > file that needs to be durable when we're in the middle of a
> > > "read-only" process like git-log.  The only things written should be
> > > temporary stuff, like the automatic remerge calculation from
> > > merge-ort, the textconv cache optimization stuff, or perhaps future
> > > gitattributes transformation caching.  All that stuff can safely be
> > > blown away at the completion of each merge.
> >
> > The textconv cache can be populated/written during "git log -p" into
> > the object store to persist.  With or without "--remerge-diff", we
> > can make design decision to either
> >
> >  - use temporary object store to discard everything we create at the
> >    end in one-go, or
> >
> >  - write them into the object store to let later gc to handle the
> >    crufts.
> >
> > The former will disable persistent write access to the cache.  It
> > still allows accesses the cached data during the same process,
> > though.  We so far deemed that textconv cache, when the user enables
> > it, is valuable enough to make persistent.  Perhaps remerge-diff's
> > tentative merge result may fall into the same category?  Some folks
> > may want to cache, others may not.
> >
> > If we were to use the same notes-cache mechanism, we record the tree
> > object (perhaps the object name) as the cached value for the merge
> > commit in question.  Hopefully most of the merges are clean merges,
> > and "caching" the results of the recreation of the merge would cost
> > almost nothing.  We need objects to record the fact that "this merge
> > has cached result" in the notes-cache, but the tree object that
> > represents the cached result is already in the history the merge
> > belongs to.
> >
>
> Elijah,
> To Junio's point, I'm also curious about why it's so important to
> aggressively purge the
> mechanical merge cache that you want to do it after each diff
> operation rather than once
> at the end.

Performance; I don't want to accumulate hundreds of thousands of loose
objects and pay the penalty from them sitting around, especially when
I know they're cruft.  (My original implementation from a year ago did
just clean out once at the end.)

For more details, see
https://lore.kernel.org/git/CABPp-BGsjq3ts4A6wKLYcopD9rknM+LXXi8qR_SLEpmU+x7KNQ@mail.gmail.com/,
starting with "It'd be _much_ slower".  Or the email I just sent to
Junio.
