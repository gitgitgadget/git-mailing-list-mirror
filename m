Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98FAC433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 18:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7587F208D5
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 18:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9rnAV30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgJMSVt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 14:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbgJMSVt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 14:21:49 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D6DC0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 11:21:48 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t77so393739oie.4
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 11:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LxG/oAcH0UvLjhRiWUkiQ6yduvNeWqi4335ANq3+Zug=;
        b=n9rnAV30AzA3Q6gVubH+CBm28jcGl3mmmzFd+ypoQLOG4Z9ENthPa7ulrktbRGUYRy
         k3a/gjlhC3lNd8ORKjTbHUaaiIpRmJoGq4QO5RGlDJ4ajamc/ZTe/TbiPLrmlR0xYa+B
         iJksdFfV1vPHV7yRXb325VP8u12BGhZtZKDFMzv8NKxi89SN+TXOpXJj32fZB0GMM6fc
         IjQu6Em4uQzo2ee2UjOlQluKYUKAdRIRZd+FB2NKzfsisaYRgXDt9VCcsV1sZammUsE2
         oAk7k8wgk6ZBdhtS9K14PzJOfScX5Y1WniPkIE5mnVED/MKKAAWlbk0Q+PsY+RRFLc9A
         X38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LxG/oAcH0UvLjhRiWUkiQ6yduvNeWqi4335ANq3+Zug=;
        b=tDNONSeN9eIvCrLRPZ//3p+b9j4Ye5AJ43niJ37tVnqqp+05Jsa3zY1nbbAeSHIx70
         LOkeJHFaI2v4DdE6/Tqxn+FTM2Lp/F5D+t0SK0bNAXGbAgRRd+6nkXaqluOEYO8Z2Gvv
         2bgh7rsSdeaRSR/nVotdr5QhxPKHDpGMPxxWqlVkF6xh6q3uiKsd8Dg9k5s1BiIglld3
         N8/1eqYtSYVIyOSwdqEI+waZOlwmQEpaMoWNdRP+yX5COzJvdtopcEjAYDHuw2wJl/yQ
         fYXNp4YG6Ypg+fyeXGQx2hoEXdofXFAXkmlts46ra+6JQCvrX62I3TT7t3RAaEh3y5ur
         d6eQ==
X-Gm-Message-State: AOAM5333w8LAGgAb9yj4W5BR9/LrEZLOPrvnYj3tFT1q53SR2AAW1wU7
        mu/VVCCTWm+xUYm6Akz48/gCpYrxTEM0Ov/EOh0f4G7afi2R3Q==
X-Google-Smtp-Source: ABdhPJyR2UGsFwXZPM5VMLzlUPRAIW0zfaLOj4t7JNx/Bcu79gu+n2zm19Hu2l4Y7ftDQ8MyRl7Pbdmq++nuFNUjnxw=
X-Received: by 2002:aca:ec92:: with SMTP id k140mr670388oih.39.1602613307802;
 Tue, 13 Oct 2020 11:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <46fce3a844c90b4078578f5aa2058bd6825af1d6.1602545164.git.gitgitgadget@gmail.com>
 <20201013153901.GA1913367@nand.local> <CABPp-BF4bqNXGusoUgzKUTecaR9bzXJbVODGVB2kqX5qTp2Fug@mail.gmail.com>
 <20201013172835.GA1917721@nand.local>
In-Reply-To: <20201013172835.GA1917721@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Oct 2020 11:21:36 -0700
Message-ID: <CABPp-BHN6s6W03uH3WssUk0ukzgkBSiVXg3_K5m_XKNGtCSxiQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] test-lib: allow selecting tests by substring/regex
 with --run
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 10:28 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Tue, Oct 13, 2020 at 10:23:32AM -0700, Elijah Newren wrote:
> > On Tue, Oct 13, 2020 at 8:39 AM Taylor Blau <me@ttaylorr.com> wrote:
> > > This piece of documentation looks to be now out of date; it mentions a
> > > "test or range of tests", but that only covers a two of the now four
> > > ways to describe a test.
> >
> > Personally, I had read "test or range of tests" as general enough to
> > cover all the cases (I would have agreed that "test *number* or range
> > of tests" would sound out of date), and just left it.  However, if
> > there's something clearer, I'm happy to adopt it.  Do you have an
> > alternate wording suggestion?
>
> Maybe "test selectors"? You could even say something like "test
> selectors (e.g., the test number, a range, a substring/regular
> expression)". I don't know, though; I don't feel strongly about it.

Earlier in the document, the --run option is defined as
   --run=<test-selector>::
which might suggest to some readers that "test-selector" is the
combination of all the selections and thus that you can only negate
the whole series rather than individual components of it.

Perhaps we can just nuke this sentence with a slight tweak of the
paragraph before it to include slightly more about the "optional
negation prefix".  I'll send an updated series that does that.
