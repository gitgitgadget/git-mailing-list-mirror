Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4926AC433E0
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 14:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29CB820772
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 14:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlvbUHwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgFCOOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgFCOOV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 10:14:21 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD60AC08C5C0
        for <git@vger.kernel.org>; Wed,  3 Jun 2020 07:14:21 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id p9so518657oot.12
        for <git@vger.kernel.org>; Wed, 03 Jun 2020 07:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HYbrKCJgVwAAqPNRXrGQXXKwuJzox3IWdbKLOrl8VUk=;
        b=nlvbUHwNhWiJdrFYbTlnvikD2jqwKwsjQwiMcM8sze/QB72NY+z/Ny9uzaoHj2KGmv
         3dvFRIMrPoQfEg6XWwrZDv3SRzpsHVqV8tu+59qTiwfaxmXC2af8jMbwNecDwqnJ9Yr5
         n6ja8Vzk+qyXJpIqWAme3e2nW0guYmM7fPuo0Kg8FgynyR+uLKYDhEz+SMGKkpEe2FN8
         oLFnHVozSN6Du7pQanGGEQQMZ0VyEX4zYF5R4q5XqQJZGlhonC2fz4YzS1cWbuKNe+vA
         svJIRruTjP8akW0s9+BCRgNd3shk+2+D8bV2BoK6G7D1NlqJGADJjQuonK1iTMGfDRIB
         9b6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HYbrKCJgVwAAqPNRXrGQXXKwuJzox3IWdbKLOrl8VUk=;
        b=cPxgYyagztj1gxwDtY23rfDZz+S9zra89gkgs3Xmdk7KnkIb9TwLgP8F2159GbY8G0
         v+v7bdNXt3BSQ3YVgfS0mJDddbrNdvofvBJ9p1ZpoE0G2kb4fEoucEsCIYW2X5irRze/
         Pro6EDMrA9uNDhT1a9BnTD3Y3n42VNT7jP+0M+Oo5KdNpHJDUwOATs2iZMqUW6sHBuBx
         UrO7iRjApJcmETA+vIhr8ANOPWRNilI5wNXmHtLXGbW15jAly/5x/7TR9gU93D1tDlqM
         sRx1CfoYObrdOJzdAFHK8LiXMO6kWY7t2x1Pm+PHgIvDCHC0wklG62QOkuFuIljTkRmW
         vh5A==
X-Gm-Message-State: AOAM531vEx4QibSm6Stfy+/1YuK32YkZD+kST5D8Xev8dzIUp3RhblCx
        asHsUMB2bdQHNaKVkHHkyvDABPxCqRvWVx5zsKw=
X-Google-Smtp-Source: ABdhPJxaPrhDznMFYi56x7x3lrURvQ46z9OyT1Ai2+YrvuwG4Tbp42rewH0tPo9cbhuH41FMePNy+YaoZ3Wo37YrpN4=
X-Received: by 2002:a4a:8688:: with SMTP id x8mr130187ooh.7.1591193661070;
 Wed, 03 Jun 2020 07:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAJmdR_pG74x0Zn43MSm7zXNcoitqjjOy+WnhyGBW+oFjVFLbRQ@mail.gmail.com>
In-Reply-To: <CAJmdR_pG74x0Zn43MSm7zXNcoitqjjOy+WnhyGBW+oFjVFLbRQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 3 Jun 2020 07:14:09 -0700
Message-ID: <CABPp-BEPOn_JL1FDA-z1jfkfej4dEbbODkcmzNWwY7V-=WsMVw@mail.gmail.com>
Subject: Re: Possible regression in `git grep --untracked` pathspec matching
 in v2.27.0
To:     John Millikin <jmillikin@stripe.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Jun 2, 2020 at 8:30 PM John Millikin <jmillikin@stripe.com> wrote:
>
> In v2.26.2 and earlier, `git grep --untracked` with negative pathspec patterns
> would filter out paths matching those patterns. In v2.27.0, this no longer works
> as expected.
>
> Example output:
>
> # v2.26.2 (good)
> $ ./git grep --untracked --files-with-matches -e '.' -- 'quote.*' ':!quote.c'
> quote.h
> $
>
> # v2.27.0 (bad)
> $ ./git grep --untracked --files-with-matches -e '.' -- 'quote.*' ':!quote.c'
> quote.c
> quote.h
> $
>
> I've bisected the change to commit 95c11ecc73f286e0a95d9591ae98f1221efe4633,
> which changed the handling of path matches in callers of `fill_directory()`.
>
> It's not clear from git-grep(1) whether the old or new behavior is "correct",
> so I request that the fix include a clarification of expected semantics.
>
> Thanks,
> - John Millikin

Oh, fun, an issue from _that_ series.  At least the commit you
bisected to wasn't 8d92fb292706 (dir: replace exponential algorithm
with a linear one, 2020-04-01), though.

Thanks for the detailed report.  I'll try to get some time to take a
look later this week.

Elijah
