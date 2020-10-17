Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989F1C433E7
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 08:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5946020759
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 08:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSJLwzS0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437699AbgJQI1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 04:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437686AbgJQI1o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 04:27:44 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE391C061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 01:27:43 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id f37so4747571otf.12
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 01:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K35ddLGIKfdsBWOppGLPla4BRXkFiJhOe+HibU24C5c=;
        b=sSJLwzS0CJLN1hYt77joBfeYns70F8ZZxohn76nUEjrUohIn6vo71EZr0u6jzv0wZw
         geOkFVbpyiU+c/d99GCxNNj4GvH+jkSU3flJEl94pSOCDzWcqG+/egFLDt6+OATz/rdU
         y4g7n/JfEsbg+BDCdMAm2yyVI+CUH56MayEKGXDqkgtm9hLl6JDH5k3WYtCcevqvD+c1
         TmD0ENpVQ5vhkUNHYoZGgWPZft9MOEZi/e+ZdACDQYx3sr2PvzEfEhwHPKzV5IBdoV5y
         tBirK36RvODKGyVLmoiWYMSTQbPwoPCYYz6naHuRK+LZbUJyqFcu3f6+rY2HXQjkrNYx
         mVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K35ddLGIKfdsBWOppGLPla4BRXkFiJhOe+HibU24C5c=;
        b=aAxVRssoheCHKdwPHt9zO+76VG09FS8442jovreHasAWtujaNMoAU8UaX5E5bQdCS9
         SuS3qwR3ngDbmDlYs9RHAVT+yfmwZpjaaDg1bL+rgCkUX/GhjpGEIgB+pPzWhGmKHyyP
         erm23BJDi5wwD1lHzl3q5uq6GBgOpPLCnCUb+qJSDpjApu0xH5AAwCEK+HtBBYp7fbFW
         9XQVrERJH/XiJ2SeSmTYbnX7bMkWNJXvySeIDtsFQJI0LR4YjoUh0cc902Oxz3dDy7yp
         HqA91/Rldox82ZRfWqSmR7yRjkKbfcCYjLZT2jQwnuHpey7ncs0KgYnHpo56BrvdM4Gj
         BTxA==
X-Gm-Message-State: AOAM530t+PxB8YQoA3yT5pH4XsmOtowhCuHaz2v3DM1nzexAwIJi7kaw
        hkrp0vecRCF8pxBl6JYLEEkgHcUoLWxGsGzz/cQ=
X-Google-Smtp-Source: ABdhPJzxelZBu3Q7U5d1MwrVebhZv+V3iXVWtr6rjiOKxfclO4c5EFNQCHRJSny2oHCx30CLlrb970O5gwbqQeoQob0=
X-Received: by 2002:a05:6830:1f4d:: with SMTP id u13mr5169717oth.184.1602923263254;
 Sat, 17 Oct 2020 01:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201015175709.20121-1-charvi077@gmail.com> <CAP8UFD1J8hpcfyzMKvqy67-bMZipzsUvR9f1cXxtPR9Co5hNRA@mail.gmail.com>
In-Reply-To: <CAP8UFD1J8hpcfyzMKvqy67-bMZipzsUvR9f1cXxtPR9Co5hNRA@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Sat, 17 Oct 2020 13:57:32 +0530
Message-ID: <CAPSFM5dL4KvRcXO3N+doQdPx=WtUKzcoqCxEAVqfsKJFc+YqGw@mail.gmail.com>
Subject: Re: [PATCH 0/5][Outreachy] modernizing the test scripts
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, phillip.wood123@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 16 Oct 2020 at 18:24, Christian Couder
<christian.couder@gmail.com> wrote:

Thank you Christian, I have sent the new updated patch series .
>
> On Thu, Oct 15, 2020 at 7:57 PM charvi-077 <charvi077@gmail.com> wrote:
> >
> > This is my first patch series to the GIT mailing list. I followed the
> > link[1] and t7001 patches to modernize and clean up the test scripts.
>
> Thanks for getting started contributing!
>
> > This patch series :
> >  -modernize the three test scripts : t7101, t7201 and t102.
>
> s/t102/t7102/
>
> On https://git.github.io/Outreachy-21-Microprojects/ we say:
>
> "Find one test script that needs some of the same changes and make them."
>
> So working only one test script, for example only t7101, would have
> been better than working on 3 test scripts. Now that you started
> working on 3 test scripts, it's ok to finish modernizing all these 3
> test scripts though.
>
Yes, I agree this but t7101 has very minor changes required that I
have completed so I switched to another one simultaneously . But in
future I will make sure to follow this practise . Also, till now I
have done majority of the changes as mentioned in the link in all the
three scripts and will try to do more and complete it .

> >  - cleans up with 5 types of changes in all the three scripts.
> >    1. Converting the old old style test format to new one
>
> s/old old/old/
>
> >    2. Removing blankspaces in test bodies
> >    3. Removing whitespaces after the redirect operator, according to
> >       Codingguidelines .
>
> s/Codingguidelines/CodingGuidelines/
>
> >    4. Using git -C instead of cd
> >    5. Placing all commands in seperate lines.
>
> s/seperate/separate/
>
> > Also, I have tested the scripts and set up travis CI[2].
>
> Nice!
>
> Thanks,
> Christian.

Thanks and Regards,
Charvi
