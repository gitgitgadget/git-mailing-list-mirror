Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445EAC4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 18:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F3B421775
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 18:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFbDnuY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgI0S0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 14:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgI0S0S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 14:26:18 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF446C0613CE
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 11:26:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j2so9402471wrx.7
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 11:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j3Yi+zi4WfO9seNIkgpsl5VZG5p/yVrGvpstIQwTREA=;
        b=VFbDnuY33RJiIs0AqzWuQl4yUMseAWBYbMm7391LKsWSIEFYS/7vP+Nwk/TgnLOEis
         XWzWBsLekHYDg9FDky/Mk2B8hJL6xExjSNKFR228yJMr6l9m1LUlNZ6yalOaOAOTh8zN
         OLO/ilWxLQTNvEa4zk/0mKnSjASOcn23oxLZnT/NlSsYu6z0MLx6HiHhEcipfsYQWfVr
         HJGxSh0ZFwa/TE74sIFUSJNT/FRZJd2AZ4sdIM6bx2HE12VMViC7JLnF2n31kq0bkDoy
         RM16cWeA1fBxMjjT1g9o6GXBASj/JsI7eF0GdrhtRAXihxAAT8FCQyi7YC1zbg3hhsVy
         FHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3Yi+zi4WfO9seNIkgpsl5VZG5p/yVrGvpstIQwTREA=;
        b=k12q1CTU2AaJa8Xn1B3ZtgY8UPzFLxN86WAKljPx6eZR2ppA7hYNUbzxAIMa1/8buW
         jBwoYtsH1DLKCvFLXPY+VxlA6g6ZMoa70yp+VglLmE+dtqX7v87FCqzBqrmOn5jU9N6e
         7kWWpUolRKrHH+dqlo/emgC/GBMAn/dUXeTAKiIHp9skSLPE49QegTDMYQJ2bpMh79Mm
         3TzG2ESo3tOo0umHj1dZ/8GcE+y1nXi2v/3XjKr/3lWfnK4D1/BgSUhNF+zgnzQkbk+j
         Y49rK4QOaaW8hEJHq7iPy4VdFMqUgveEIGGWg5BgPdtHFFgQ3BbdpuLeUlXHVf8Yw4ya
         l/yg==
X-Gm-Message-State: AOAM531wb6aTGQHeeeGN+NhiUlk7sO6U1d6lcn2UalMhBfibEjYrNnNJ
        KLzzWOSn7vH827oOvVBcZ38QYcrOVvb/D1GrSyWBm3KO9gY=
X-Google-Smtp-Source: ABdhPJxd7Ag92l8o6VJRc1cPvQerEXhsT+g5h+JpF3ig+JTOmTaA4P9jfPO/i4sIm8fo+25t1aVETaWH7EmQGMjUCvo=
X-Received: by 2002:a5d:5306:: with SMTP id e6mr15389610wrv.156.1601231176104;
 Sun, 27 Sep 2020 11:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAKqNo6RJqp94uLMf8Biuo=ZvMZB9Mq6RRMrUgsLW4u1ks+mnOA@mail.gmail.com>
 <877dsffaq0.fsf@kyleam.com>
In-Reply-To: <877dsffaq0.fsf@kyleam.com>
From:   Matthew Timothy Kennerly <mtkennerly@gmail.com>
Date:   Sun, 27 Sep 2020 14:26:05 -0400
Message-ID: <CAKqNo6QCa2bGF3Uj-0ewh-_O+_qTOeOFYOM2k_daXw-vGg+xVg@mail.gmail.com>
Subject: Re: Differences in compound tag sorting between 2.27.0 and 2.21.0
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good call - I see the old behavior with 2.26.0.

> $ git tag --sort -taggerdate --sort '-*committerdate'

That gives me the desired result with the annotated tag example I
gave, but if I do the same repository setup steps with lightweight
tags, then it inverts the order:

    # Lightweight tag repo
    $ git tag --merged HEAD --sort -taggerdate --sort '-*committerdate'
    v0.1.0
    v0.1.1
    v0.2.0

It looks like I can support both setups at once by using
-committerdate plus -*committerdate, though:

    # Annotated tag repo
    $ git tag --merged HEAD --sort -taggerdate --sort -committerdate
--sort '-*committerdate'
    v0.2.0
    v0.1.1
    v0.1.0

    # Lightweight tag repo
    $ git tag --merged HEAD --sort -taggerdate --sort -committerdate
--sort '-*committerdate'
    v0.2.0
    v0.1.0
    v0.1.1

It's fine for me that the order isn't exactly the same, as long as
v0.2.0 is listed first.

Thanks for the help!

MTK

On Sun, Sep 27, 2020 at 12:25 PM Kyle Meyer <kyle@kyleam.com> wrote:
>
> Matthew Timothy Kennerly writes:
>
> > Hello,
> >
> > I've run into a difference in the results for a compound tag sort
> > between 2.21.0 and 2.27.0 (I believe also applies to 2.28.0), and I'm
> > not sure if it's an intentional difference or if there's still some
> > way to achieve the old behavior with newer Git versions. For
> > reference, I'm using Windows.
>
> This sounds like it's probably related to the fix in 7c5045fc18
> (ref-filter: apply fallback refname sort only after all user sorts,
> 2020-05-03).  That was part of the 2.27.0 release.  Let's see if that
> explains what you're seeing.
>
> > I need to sort tags first by the date of the pointed commit, then by
> > the date of the tag creation when available (I understand that
> > lightweight tags don't store their creation date, so multiple
> > lightweight tags on a single commit may not sort consistently). Let me
> > give a concrete example.
> >
> > Given a repository with this setup, using annotated tags:
> >
> > git init
> > echo hi > foo.txt
> > git add .
> > git commit -m "first"
> > git tag v0.1.0 -m "A"
> > echo bye > foo.txt
> > git add .
> > git commit -m "second"
> > git tag v0.2.0 -m "B"
> > git tag v0.1.1 HEAD~1 -m "C"
> >
> > I get the desired sort results in 2.21.0:
> >
> > $ git tag --merged HEAD --sort -taggerdate --sort -committerdate
> > v0.2.0
> > v0.1.1
> > v0.1.0
>
> As far as I understand, committerdate should have no effect on annotated
> tags (i.e. it's always a tie).  So I'd guess that you're just happening
> to see the sorting you expect due the inappropriate refname fallback
> described in 7c5045fc18:
>
>   This worked correctly for a single "--sort" option, but not for multiple
>   ones. We'd break any ties in the first key with the refname and never
>   evaluate the second key at all.
>
> > However, in 2.27.0, the first listed tag is the tag that was most
> > recently created, rather than the one pointing to the newest commit:
> >
> >
> > $ git tag --merged HEAD --sort -taggerdate --sort -committerdate
> > v0.1.1
> > v0.2.0
> > v0.1.0
>
> Based on the description above, I think the second key (-taggerdate) is
> now coming into play.
>
> > If this is intentional, how can I achieve the desired sort order in
> > newer versions of Git?
>
> Try using * to refer to the commit that the tag points to:
>
>     $ git tag --sort -taggerdate --sort '-*committerdate'
