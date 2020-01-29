Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E399FC33C9E
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 02:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC502051A
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 02:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SU6vuIjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgA2CAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 21:00:07 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36169 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgA2CAG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 21:00:06 -0500
Received: by mail-qk1-f195.google.com with SMTP id w25so9827292qki.3
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 18:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r00pz4Uh/T78gV3gHtd0miAssx6GSbKOyoKf+x3ZUvI=;
        b=SU6vuIjFYkpQzeQCUzcTJmc254tDcANKO5rUGpciXJ25SAMHYsKu9AQX6EEsDf/g+C
         waOR2fpNGQqLwb11sUVGP4P/r4ExyypF5wCZB7SPbjJbaPiiGEoYcHCcdPMqcOgSyali
         xWeN6kLloMlR0BZLRHAaKMwOo7/6v92FnGF++YH3QNayyPmGJQxSH6YSlXV91iGcnZhT
         LktgUptORTy4G37bNBzuw49hLN63HqVDJZGPR+3AMX3LoG8iubHPPIPe2rEnaRs384wh
         rdX2F/gL59OQMMFVc6exJlotPYK5e+dWfMKK0a2NPD0aRKSplcZ0M3Rjs4L0V2gRnwnf
         YuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r00pz4Uh/T78gV3gHtd0miAssx6GSbKOyoKf+x3ZUvI=;
        b=U7hZLcuO684+tEi2Ay15aRBfYxDTv2/4xQ0JGibsfRy8/Ivd1IT+tUvy9ZhagywZml
         PmuP1pOPqUNCR1WgPmQAHRSSWJsp/DO3KRtkWBLiPOYv+15ARzF5ULbMrho1tGI50r73
         zsEhAwjrxCobcuqnCNJ8ZTDQZw4AfxGgUVC9gilgMxP7TebOmeYr6fsuEo7QcfPPq/lT
         /SBHhe0IyxLpq+7WRo0ktePTuUA8i9A7clK0Fd491Q3ygMiyYPz7h5jbyAzW6r36J+vp
         E6uYn9FFrUwpo26xUMLCZKeMerZ4uC9J9Y2H9oH783xq+WBTC6bLl3UX1gQ3rTc1rrNb
         vpeg==
X-Gm-Message-State: APjAAAXgoldsdaNqfw7zi+tKRIZv5iURnt26t3SV0N14dX3RGi81jYUp
        1d8dJhh4MJvhh2VTNpCBjYLqW4xrFUrZWMHuDANOkUN+
X-Google-Smtp-Source: APXvYqyw7dZ/oeQWK40+EYn/EwG4WlNDVt9wxMMNjGy/07gdcLfeheGLhQH6do5Nej6E2tUuOWgvEevIOv+bgJYjUBg=
X-Received: by 2002:a37:d0c:: with SMTP id 12mr25854715qkn.464.1580263205630;
 Tue, 28 Jan 2020 18:00:05 -0800 (PST)
MIME-Version: 1.0
References: <CAOTb1wfoMf338VPRYcjAv+EaMYQxKJ=kP6-qMykG-LfxPrWuag@mail.gmail.com>
 <20200127055509.GA12108@coredump.intra.peff.net> <CAOTb1wd9D3YytevTt0cGnw1o-9cN1-yxCqbuH4oLH1KB6mzEeA@mail.gmail.com>
 <20200128094801.GC574544@coredump.intra.peff.net>
In-Reply-To: <20200128094801.GC574544@coredump.intra.peff.net>
From:   Chris Jerdonek <chris.jerdonek@gmail.com>
Date:   Tue, 28 Jan 2020 17:59:54 -0800
Message-ID: <CAOTb1wecnwXrOqJa-dq1zyS1ydgQ-c_b_GX7FkWzJPtGk6xL3g@mail.gmail.com>
Subject: Re: git-clone --single-branch clones objects outside of branch
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 1:48 AM Jeff King <peff@peff.net> wrote:
> On Sun, Jan 26, 2020 at 10:46:07PM -0800, Chris Jerdonek wrote:
> > I'm guessing other flags also don't apply when --local is being used.
> > For example, I'm guessing --reference is also ignored when using
> > --local, but I haven't checked yet to confirm. It would be nice if the
> > documentation gave a heads up in cases like these. Even if hard links
> > are being used, it's not clear from the docs whether the objects are
> > filtered first, prior to hard linking, when flags like --single-branch
> > and --reference are passed.
>
> No, "--reference" behaves as usual.

On this, I found that --reference does behave differently in the way
that I suspected. For example, when run with the default --local, I
found that git-clone will create hard links in the new repo to loose
objects, even if those objects already exist in the reference
repository. When run with --non-local, the objects in the reference
repository weren't copied (I didn't find them in the cloned repo's
pack file).

So in addition to --single-branch, this seems to be another case where
`git-clone --local` will ignore the provided options when deciding
what files inside .git/objects/ to hard-link. It just hard-links
everything. This is another example of something that I think would be
worth mentioning in the docs in some form. Currently, the
documentation for --reference suggests that objects won't be created
in the new repo if they already exist in the reference repository.

--Chris

> However, "--depth" is ignored (and
> issues a warning). I don't think it would be wrong to issue a warning
> when --single-branch is used locally (though it would not be "single
> branch is ignored, since it does impact which refs are copied). But I
> kind of wonder if it would be annoying for people who don't care about
> having the extra objects reachable.
