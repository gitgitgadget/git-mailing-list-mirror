Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28E7C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 18:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA9B61263
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 18:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355679AbhJASOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 14:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355673AbhJASOU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 14:14:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83806C06177E
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 11:12:35 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id v10so38116525edj.10
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WROJz6IqvMCiX7kQ7Bmsc8bIXSe0jUuvhX6+cbHmFgo=;
        b=Y8O7HkmeHIomD+XaVUle5nOFfqNI0K4BtrN33FgizwvInCmAzSzT+bosXdL9YOPdz/
         egy4yAhZNJPNoYHhmInSzoQYYx0J57HlDI74zbHxO3q5ziEgAUjWcykXHg8CaQ+Iaxcg
         MUPdtY6yxLvCrrH3LxNbDIKqsEwWqcIMF0DTKZAE5tdI6PO7SltIiwf27RrGFDQhKE3X
         huPW/zy1nHAh6sRIaZ+g521UaOF8NDg3D548FyNXXWLc2Ae3TNYY2H1NqFhaAEnpw7j6
         nPeZwy5l1eJ+DuVl6+N7y1YoSq/E4P4yK/tNDmEythl3w/4s8zoep/rTjhnCg8eR3/HF
         cqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WROJz6IqvMCiX7kQ7Bmsc8bIXSe0jUuvhX6+cbHmFgo=;
        b=B3phKs9Cu+YFbYIpGbTvZpjSlC+Ye08D+FC18T6RftVPA9dMaHu5q/4C4GiESLKZNf
         6oc39JgO6G+FOsWOypfYNbj2N3MSJuErdFgJFjIjwhveMkTwEfOz/zj2NIHoLPVQoOx8
         ZHpGgeegdt4IqD5E5xGycrvooXo221fYbtLXQT2bZZCOL76S0TO57kzXnH8HZkPtAVne
         yKIxdvLVm+o5GxVj9mFg8iLu4+KLYwvFBFChQHCieKURWHXGcGA7C8lh7vXTO8G+5L4V
         U/5ka2rahiabP9KzmS8ooPwIZWHX2ez6azH6vl+ZiZLwx34rPUcQa31f9F2CfSeYbsay
         TG2g==
X-Gm-Message-State: AOAM533JHkHw2UqI2oMQwJw5oFB5FP6uJf+/vFxekQtfZpCCfW/+PG0U
        DIW9CBfKLME3DqnfhzG+ZhhwIOjK4tj+2pSVMy0=
X-Google-Smtp-Source: ABdhPJyA9XG92Qvpet6gMBqzx6136fS3K9iVrFJxC+uh/Hinf7lVyEv01qiLKuRySATLyXlp8OaNBxJ9+kVfLv4JBsg=
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr7926371eji.434.1633111953964;
 Fri, 01 Oct 2021 11:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8rzhmsi7.fsf@gitster.g> <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
 <YVOn3hDsb5pnxR53@coredump.intra.peff.net> <20210929184339.GA19712@neerajsi-x1.localdomain>
 <YVVyUkwYNfkEqNfU@coredump.intra.peff.net> <CABPp-BH6ZzC9p94xda3SqfL0JjxoVAb3oV57a9cpg2ZDc=5NNA@mail.gmail.com>
 <xmqq7dew8yq6.fsf@gitster.g>
In-Reply-To: <xmqq7dew8yq6.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 1 Oct 2021 11:12:22 -0700
Message-ID: <CABPp-BEhLQ3b8OCn3EbTa=g7uh_YXmkQuuGazn=OsT=bG3ot1w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Neeraj Singh <nksingh85@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 1, 2021 at 10:02 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Said another way, I don't think anything should be writing a critical
> > file that needs to be durable when we're in the middle of a
> > "read-only" process like git-log.  The only things written should be
> > temporary stuff, like the automatic remerge calculation from
> > merge-ort, the textconv cache optimization stuff, or perhaps future
> > gitattributes transformation caching.  All that stuff can safely be
> > blown away at the completion of each merge.
>
> The textconv cache can be populated/written during "git log -p" into
> the object store to persist.  With or without "--remerge-diff", we
> can make design decision to either
>
>  - use temporary object store to discard everything we create at the
>    end in one-go, or
>
>  - write them into the object store to let later gc to handle the
>    crufts.
>
> The former will disable persistent write access to the cache.  It
> still allows accesses the cached data during the same process,
> though.  We so far deemed that textconv cache, when the user enables
> it, is valuable enough to make persistent.  Perhaps remerge-diff's
> tentative merge result may fall into the same category?  Some folks
> may want to cache, others may not.
>
> If we were to use the same notes-cache mechanism, we record the tree
> object (perhaps the object name) as the cached value for the merge
> commit in question.  Hopefully most of the merges are clean merges,
> and "caching" the results of the recreation of the merge would cost
> almost nothing.  We need objects to record the fact that "this merge
> has cached result" in the notes-cache, but the tree object that
> represents the cached result is already in the history the merge
> belongs to.

I'm not sure this performance caching for remerge-diff makes any
sense, for multiple reasons:

1) Does the cache become invalidated when the merge algorithm changes
or when config options change (--remerge-diff shows the difference
between what an automatic merge would do, but an automatic merge's
results depend on the current algorithm and various merge.*, diff.*,
etc. config options the user can set).  Do we re-cache each variant?
Do we expire the cache at some point?

2) The performance aspect seems suspect at best, and likely to backfire.  Badly:

2a) Let's say there's 100,000 merge commits in your history (so small
history roughly the size of linux.git).  `git log --remerge-diff` thus
repeats 100,000 merges, creating loose objects for them.  Perhaps only
1 in 10 merges needs any loose objects created (because the rest of
the merges were clean).  But those that do have conflicts will need to
create both new blobs and any necessary new trees that use those new
blobs.  Who knows how many blobs and trees are needed, but let's just
use 10 total blobs+trees per merge that has conflicts as a guesstimate
of the average.  Thus `git log --remerge-diff` will need to create
100,000 * 1/10 * 10 = 100,000 loose objects while it runs.  Preserving
all those files to cache the results slows things down
considerably...until they are gc'ed.  If we do the notes-cache thing,
then yes these objects would become packed.  Perhaps you're suggested
doing an automatic gc (or several) as part of running --remerge-diff,
but that's super slow itself.  When I implemented that, it felt worse
to me than just letting loose objects pile up.

2b) Note that my implementation didn't just clear out the tmp-objdir
at the _end_ of the remerge-diff (which was the easiest to implement),
but cleared it out after each merge, because that was much faster with
as many objects as can accumulate.

2c) Is --remerge-diff slow enough to even merit the complicated effort
of caching results?  --remerge-diff is faster than --cc in my testing,
so why is it even worth the pain to cache?



So with that out of the way, let's return to discussing the textconv
cache.  If the remerge-diff results aren't cached, isn't it unsafe to
allow the textconv cache to persist anything while remerge-diff is
running because it could create corruption?  We could still let the
textconv cache persist results when remerge-diff is not in use, but I
think we _want_ anything written by the textconv cache during
remerge-diff to be thrown away because there's a risk it references a
temporary object created by remerge-diff that will be deleted.

With all that in mind, to me, it seems like using the tmp-objdir as
the primary object store in combination with the refs quarantine is
actually the safest solution for this usecase.  Am I missing
something?
