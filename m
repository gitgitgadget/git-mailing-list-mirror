Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E11C433E7
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 23:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F8B20758
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 23:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpSP88J9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439715AbgJQXnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 19:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438647AbgJQXnH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 19:43:07 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6BFC061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 16:43:23 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id w25so1752541oos.10
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 16:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IZU7zY1PKvKmgb/qRB5QE6lfJYwL5weOGZdCw7QpxBQ=;
        b=dpSP88J9sWbwysUckhT6PqgaCzensqO1s+WGm5NxV0jTnNPNrxKfeQhKZXi4+33xuy
         6szXzOEi1k6jWKxJyxX/rxnkjbFjMMiR/RyOM2W+vxG9hZO5opw3P3/YXfxPWIY0VKla
         oqTMoQRiAK53syByiZD9vZrSSeiUIpwbdoAq5rwPvV8L5UZUkxnDDBTyssHaZNxYpIx6
         yHbMkLB85fKmiha/7NStDjTovcTvsDws/09NcAIylGJW77sPupQUSDQ+T2ZFn6/CxGa7
         IUJk//vQ5JQwqrIk7NmP1YkfnuBWQhG00/mDudXVbw2HCk1McsTZG7mb9fXcy0+69Ful
         zfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IZU7zY1PKvKmgb/qRB5QE6lfJYwL5weOGZdCw7QpxBQ=;
        b=IzH//yOeNH+CQtfCGnxOTH9IX6D0syE1H5bFUgUoJ84TUUWzCqQzOs1bPat/pXCb0P
         kaUEWHhsTgAomKvcf6fJxiPiEANTXyBg7nAQnVPlTlwqE59YBwM8br6zMUSa91LK4UXR
         JAvzxnX5lba15VSZ3XamUPqxCTfj/+R3/+60tOg2Grn9Bq5RczCN5m0dlN/v0gF6Sdrf
         LUyUhihiOEvpcDE56uKYOT9fx9FAiBzvyC+0uHwmb9EmnJOY3KRovbLAALF83C7yFb8G
         zZidIkuOci019zO9iAGt6nhpgYWvshiEbBsUBN5PJ0vOMUYtvkoOjYN2iV7i6LKPuUjl
         EKtA==
X-Gm-Message-State: AOAM5312f7c7K8lt976nPNOQBZNs3Y7V80zB68aNDbY08aDBdOq3Swk9
        s2+G3As73hN83RHBQMt6tFwXWQr4KT5X6lbjScQ=
X-Google-Smtp-Source: ABdhPJxrqjhSMdbRszrBoPkKhyH+PGIcaX56Pl0VB1kMcXoyMXUkpc6VIG4BlNTRLuHPr8icrrxZ/NpcwYm+Tb+LMrA=
X-Received: by 2002:a4a:4c92:: with SMTP id a140mr7805512oob.32.1602978202306;
 Sat, 17 Oct 2020 16:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.878.v4.git.git.1602876532.gitgitgadget@gmail.com>
 <pull.878.v5.git.git.1602888652.gitgitgadget@gmail.com> <389c2c171a07b156fe956ac535033a8b67af51a9.1602888652.git.gitgitgadget@gmail.com>
 <89279674-a1b5-930a-e682-b47aafeb11b7@gmail.com>
In-Reply-To: <89279674-a1b5-930a-e682-b47aafeb11b7@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 17 Oct 2020 16:43:10 -0700
Message-ID: <CABPp-BGXpjYkHEYb_WR0Miy+dHLtZWLjFb3G-EhSi+AOx0voHg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] test-lib: allow selecting tests by substring/glob
 with --run
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 16, 2020 at 4:25 PM Andrei Rybak <rybak.a.v@gmail.com> wrote:
>
> On 2020-10-17 00:50, Elijah Newren via GitGitGadget wrote:
>
> [trim]
>
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index ef31f40037..debfd73fd6 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -769,6 +769,8 @@ match_pattern_list () {
> >  }
> >
> >  match_test_selector_list () {
> > +     operation="$1"
> > +     shift
> >       title="$1"
> >       shift
> >       arg="$1"
> > @@ -777,7 +779,7 @@ match_test_selector_list () {
> >
> >       # Both commas and whitespace are accepted as separators.
>
> This comment becomes outdated with the change below.

Sigh...indeed.  Thanks for pointing it out; I'll send out v6 soon with the fix.
