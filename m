Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9261C433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 20:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D3782311A
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 20:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732869AbgLKSo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 13:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgLKSoN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 13:44:13 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF09BC0613CF
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 10:43:32 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id j20so4638778otq.5
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 10:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FKE6F4IDHgLwOKxJJ7ZXAiON15y25JvevwPponb5fSM=;
        b=MkNFl2u6uwZ1vEOFZHZmWo6bTDG2omkuEPlu6tZDZCfh5KWOXFAFWWt87UOOW3QWUj
         OvgOdZ1tnxKkJ2pxnZ4AEFZpgSs1vyO83g0EefgYKlEwG73Ha6wAtbuKp6hxnsb+zdxR
         SLtn3QCDa7XJ5JTi/I3aXb4iF0ERRBU27I2cynWs/STSvQ1ghDOSSONbHxOHTWIJD1CU
         vRGAv6NqalogCpYkDG2XEiDKzKXffkiOhE9N85tcpwXtM1eWS3YUyh7dnrc+o17Xd5I8
         9pRMY4QpR787Yqw6Ynse5keEVeC40zk6GIxtxm3iPBqZe3X0DbkmOrn7JlFyKYnbXJ/c
         8cEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKE6F4IDHgLwOKxJJ7ZXAiON15y25JvevwPponb5fSM=;
        b=ACCpuDKZIA8DXnaMZaEaym0lj3RKeVjcQ60q9m55KytRIttmRKJJ44ICGNoexVuRvU
         BLr0QNVf6bMU5CmdMgVC3S9K1oT7nmQAI20ocE38pqseEf/gKhTLarkrlclloAPr33cJ
         lRbwR2IL+/67t3r4kXPPiaWryx4+45aOg6EhDv28eKQtGDbyH3effkLNX4BlWV1MVYUv
         OYRKsqw9j0GuM2d3MZYe9hDuh1pJ9PFgKXZK8D1UCgDz7lQvKMmVh3wjTwfmzD7WG/Ds
         Q4MFZ4Xb+elNdATdzDoSwHaSo5mjadF86lgLeDiPG/zRQXa/kF/fE9cuvBMo3wKWW1ic
         5PnQ==
X-Gm-Message-State: AOAM530DisOHNPqucZsdBIbuetH2JGU3ozhWDXu+ZO68yycp4Goi4Wni
        Mx2jATTCkMXkwRTeWkUdykgRtUrgwE6tW7RY8rM=
X-Google-Smtp-Source: ABdhPJwcxM5/ZYXslK2sY92a84YxTsiOdsTEzU2K/C9d5O9/+eddrQ24fLYkZSWRY/w0kPvwjqezQ+RQUx3OFmB9qjc=
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr10725488oth.316.1607712212258;
 Fri, 11 Dec 2020 10:43:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <207bb9a837cb855721daa88caaad80e37cb40ffe.1607542887.git.gitgitgadget@gmail.com>
 <8d744966-2344-1dbc-f2a2-7411be3bfc8b@gmail.com>
In-Reply-To: <8d744966-2344-1dbc-f2a2-7411be3bfc8b@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Dec 2020 10:43:21 -0800
Message-ID: <CABPp-BErHFVQ0Omrnn7c=x+apwXmd=T8=xdPTkypb5DOJPWNuw@mail.gmail.com>
Subject: Re: [PATCH 04/11] merge-ort: implement compare_pairs() and collect_renames()
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 10, 2020 at 7:00 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/9/2020 2:41 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
>
> Perhaps worth pointing out comparison to score_compare()

That comparison might be slightly misleading due to this line from
collect_renames():
+               p->score = side_index;
Since diffcore-rename has already used the percentage similarity to
determine if two files are a rename and has recorded that in a
separate field, I don't need the percentage similarity anymore.  So
the score is no longer needful at this point.  However, I needed a way
to somehow record which side of the merge each diff_filepair came from
and I can't just add a field to the diff_filepair struct (especially
since its only use is in merge-ort).  I know, I know, I'm evil.
Creating a new struct just so I could have something that contained a
diff_filepair and another auxiliary field just felt so ugly, so I just
reused this one field instead.  And I did use that field to "rank" or
"sort" the pairs, so doesn't that make it a valid "score"?  :-)

I should probably add a big comment about this just above that line.
I've meant to do that a multiple different times, but oddly enough
this thought has only occurred to me while I'm out running or
otherwise away from the computer.  Until now, of course.

> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-ort.c | 27 +++++++++++++++++++++++++--
> >  1 file changed, 25 insertions(+), 2 deletions(-)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 1ff637e57af..3cdf8124b85 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -625,7 +625,13 @@ static int process_renames(struct merge_options *opt,
> >
> >  static int compare_pairs(const void *a_, const void *b_)
> >  {
> > -     die("Not yet implemented.");
> > +     const struct diff_filepair *a = *((const struct diff_filepair **)a_);
> > +     const struct diff_filepair *b = *((const struct diff_filepair **)b_);
> > +
> > +     int cmp = strcmp(a->one->path, b->one->path);
> > +     if (cmp)
> > +             return cmp;
> > +     return a->score - b->score;
>
> Hm. I wasn't sure what would happen when subtracting these
> "unsigned short" scores, but I see that score_compare() does
> the same. Any potential for an existing, hidden bug here?

In the case of compare_pairs(), a->score and b->score have a minimum
value of 1 and a maximum value of 2 (note above where I set score to
the side index).  I believe most platforms will have an int big enough
to store the result of that subtraction.

I'm not sure why I bother with the secondary sort, though.  It shouldn't matter.

Which is probably a good thing, because strcmp(a, b) gives us
ascending order, and a - b gives us descending order.  That's messed
up.  Honestly, it doesn't matter because all I really needed from the
sort was for diff_filepairs with the same source name to be adjacent
(so that I can check for rename/rename(1to2) conflicts be comparing
adjacent pairs), but still it's annoying that the function contradicts
itself on the desired order.  And it'll trigger whenever the same path
is renamed by both sides of history, which we have a number of
testcases for in the testsuite.  So that confirms that the secondary
sort just doesn't matter.  I'll get rid of it and just use strcmp.
