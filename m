Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E91BC35273
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 13:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352696AbiBGNsq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 08:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448356AbiBGNL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 08:11:29 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEDFC03FED3
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 05:11:05 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id u3so972809oiv.12
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 05:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5yWHWWqrHeiuUHvC9YqLQn7eOVRkVgzl6iSnR0ZgtaA=;
        b=qY6a1skAWwRkpV570hj3SCW/sqvczcghKkUsN7IYMdNvWTMR4OeVIt+cLDUOxmBBaq
         PA2iTRrhk/kHhqYjG+rhHNxSJLl9TXFQOGZ9xlxB2Dq1hid+932ihx+dO5dOVAJXX21x
         QjvOkt9WcMY4JJ+jjmtyCC7mpKeiRUimQwkkGQSdHfQ44otfJFAvC+bTbNd6AmpkAt6Q
         6O/g/ac94iF2YnFRna7USk36kGtZG9Mdh9SHaAwT1ZKBkkPVGXyyovq7QvEDOwodeMdo
         d7XU34Z04KAOMvtCObMcvR5D8crMOox5HEa3oqXaz48JaUQ12U7nYyVLwnB6ES3EtIQ3
         ijHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5yWHWWqrHeiuUHvC9YqLQn7eOVRkVgzl6iSnR0ZgtaA=;
        b=I4PsVWbbh4dqYNrjmZB854jedpGj/OHFZFBeIezluQChSj1vzslFxeKUlDkkNvpvt6
         jpnAxDS4gcFedEqRjxzaW1MOwSK8smppxzQgs4TF2mzYlfG9hL9iycekPKYFo0REspAQ
         eD3HYmx/o24IUKAsXiWNqJuxg/a9qkyvai1VuLzD1cHB3KsyL6JgUpxkbbnJX2KGWsWT
         4Om4BEkx3ZthjuiaEncAF8bkpJLcTt/0mMt/f2ixTwyT0PDIJbBK6uzFU+ZAj+xCBoBP
         /HrpNfR5RA2l3wXx14o42PuBUGlpb3tBdtOQFIxOwvEYVhc262U7nWTqPSK87zWtqjuV
         nCOQ==
X-Gm-Message-State: AOAM532x3i0Kax0W60k/USCkl1e/mrk5SBjhi9D1Z7ITCo9St3ZoVH7v
        CAI2mmSGow8iYF1ZvsPV0K+tf2N21DfTXazCc2R4Rt7VJI8=
X-Google-Smtp-Source: ABdhPJzgLXgul3/OpekDD8is70E7PiCIzP+LTZ8/+1GcyjeKZBTmA0oR4grdx1w0XXpwZfKyQnyL9zKVB8YGq7yJEDY=
X-Received: by 2002:a05:6808:d47:: with SMTP id w7mr7101932oik.78.1644239462403;
 Mon, 07 Feb 2022 05:11:02 -0800 (PST)
MIME-Version: 1.0
References: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
 <CAPig+cS5tOr2NRJmAC1BNQPKYyeLXy0iy36q35-y7rFkrWewJw@mail.gmail.com>
 <CAJyCBOSd7pVedwexMn7HGQfJeVcOUJ4VVgYKYt+7TjQz7QCf1Q@mail.gmail.com> <CAPig+cQATBiwGMhXk+WFLGDKw6it9ZwTRxXO7+upy4Yk+M-crQ@mail.gmail.com>
In-Reply-To: <CAPig+cQATBiwGMhXk+WFLGDKw6it9ZwTRxXO7+upy4Yk+M-crQ@mail.gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Mon, 7 Feb 2022 21:10:51 +0800
Message-ID: <CAJyCBOQjvcDzUau_vv3=H-5Q5oPkFawgQ+FxePub19Q9yuqrUg@mail.gmail.com>
Subject: Re: [GSoC][PATCH] lib-read-tree-m-3way: modernize a test script (style)
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Got it, I'm learning along the way, and thanks for the reply!

--
Thanks,
Shaoxuan

On Sat, Feb 5, 2022 at 7:59 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, Jan 28, 2022 at 4:51 AM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
> > On Fri, Jan 28, 2022 at 4:34 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > In this case, the indentation of the entire body of the for-loop needs
> > > to be fixed to use tabs rather than spaces, however, fixing all the
> > > indentation problems together with the other problems can make for a
> > > too-noisy patch for reviewers to really see what is going on. As such,
> > > it may be better to make this a multi-patch series in which one patch
> > > fixes indentation problems only.
> >
> > > As mentioned above, changing the body of the test from double- to
> > > single-quoted string should (presumably) be okay since the body gets
> > > eval'd and `$p` will be visible at the time of `eval`, however, mixing
> > > this sort of change in with all the other changes being made makes it
> > > hard for reviewers to spot such little details, let alone reason about
> > > correctness. As such, switching of quote types is also probably the
> > > sort of change which should be split out into its own patch. The same
> > > comment applies to other changes following this one.
> >
> > I think so. I was thinking fixing all the general styling issues in one
> > patch (since they are all style related), but now I realize that the general
> > style patch can be divided into sub-patches for clearer review experience.
> >
> > And my question is, should I do this "multi-patch series" thing in the form of
> > "-v<n>" (all under this thread), e.g. "v2" or "v3"? Or I just submit
> > multiple patches separately (a new thread for each one)?
>
> A multi-patch series as v2, v3, etc. would indeed be appropriate, as
> you already figured out[1] before I got around to answering belatedly.
>
> > > Overall, with the exception of the test title which needs to
> > > interpolate `$p`, the rest of the changes are probably reasonable and
> > > benign. It's important to understand that lengthy patches like this
> > > full of mechanical changes tend to be quite taxing on reviewers, so
> > > it's a good idea to help in any way you can to ease the review burden.
> > > This can be done, for instance, by making only a single type of change
> > > per patch (i.e. indentation fixes), or by limiting the scope or
> > > breadth of the changes, which is especially important for this sort of
> >
> > I'm not quite sure what this means, and I quote, "limiting the scope or
> > breadth of the changes". Are you suggesting, for example,
> > fixing fewer occurrences of tab indentation issue in a patch; or, for
> > example, limiting the
> > fix to a specific "test_expect_success" block, and do multiple patches
> > sequentially?
>
> Sorry for being unclear. I just meant that as a microproject, it would
> have worked equally well to pick a much smaller test script with style
> problems (if you could find one) rather than a long script. After all,
> the purpose of a microproject is to give you experience with the
> submission-review process and to give reviewers and mentors an idea of
> how you interact. It's the process which is important, in this case,
> not the size of the submission.
>
> Anyhow, it looks like Junio is happy with your v3 and will be merging
> it down to "next", so it all worked out.
>
> [1]: https://lore.kernel.org/git/20220202064300.3601-1-shaoxuan.yuan02@gmail.com/
> [2]: https://lore.kernel.org/git/xmqqr18jnr2t.fsf@gitster.g/
