Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3308C433E7
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 13:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE5B21655
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 13:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9YmxuUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgJRN7u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 09:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgJRN7u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 09:59:50 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D88C061755
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 06:59:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g12so8465969wrp.10
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 06:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Qy0r/rRjIpfWXBRZ92E6y2UXaWsIXRx70HsGCaxGWA=;
        b=Z9YmxuUstS/To7RNOJnXbCNiRM/xsEy6P+I6Lc613phaJW5Il0nX+cElmqLgZxciRG
         2vjD/bTw6z1K2eqi+FNy/KotoaLifIbsQqdcIqE0U+2rDUYRbqt9hDA7PVHlttZYfBdM
         eRpMerRFpFFzYZbY8WF7PhLH5hja4Gw9e9uRDTz5d6M5y5WjydFLDr/6hnt0y7Qk6a3z
         o2d38m68fPQXw3lF8KNBOO0ARwI3noA53c8R69uPjCTI/vb37nydYvPXdVJhgwSHd2rj
         4/X1kYj9zWXrOrUeQPkBWMqsEE1nxYxsbXBnpomiIGAkCrrGpMdEY1/062IJ/Vc3CkFB
         4T0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Qy0r/rRjIpfWXBRZ92E6y2UXaWsIXRx70HsGCaxGWA=;
        b=KZt9YLgcba0FFn5In9r6Q9PK7gHtrA/h1MwMtumUwiOcq1RqM2x65tx5P+AG986UUm
         X3yiaq+bG5Zs0GP6Fq4I84JjvMYSHc1bCzMV9xNRG34p1oG5BKS0LTBMkE3KnwhBboTH
         aNYIJ9JR0H/IBq7hjXmZ9zuDVtvDTirDG3ZQ2sUToPg1K0tWGI2zm0NxDx9uyP/+UVEi
         tik+9cw240xunyJPoCkB86ZH0sRJR3W39tTwoAeJK2eILOyrws+AwVuCXXXYwVW/cGhA
         LQEKmeVLtalbiz0ZfHr0/1UIVX6M1Y8gStnlz2wBZF3Qe2HTCD2WdW4xKGC7dvxn7Fo/
         MuvA==
X-Gm-Message-State: AOAM530+/vIhs+Nlkoat4lGNNm+PZCOk8c14oV6yfKco+ftE8MBoWhwv
        6BwI4eaDeNlfqE5mYuLLfaXZ0+UzxdVJ0cLbEwM=
X-Google-Smtp-Source: ABdhPJzwMNeEfPhGpbC/skuFJWoBEOrCr3OXrxv5xYd6O5olRP16/MRuKtdVRTDvOnDBJRSvgsa5S+8f+QOhrpiBn3o=
X-Received: by 2002:adf:ff8e:: with SMTP id j14mr15711496wrr.255.1603029588341;
 Sun, 18 Oct 2020 06:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.git.git.1602950552.gitgitgadget@gmail.com>
 <0a1550cb225591a53118bd8f7782d95de5a4df34.1602950552.git.gitgitgadget@gmail.com>
 <CAPig+cRuutHJ64aXQy5X9h-Vg4=_NKKyL57KdwbvXj4cGRS1PQ@mail.gmail.com>
In-Reply-To: <CAPig+cRuutHJ64aXQy5X9h-Vg4=_NKKyL57KdwbvXj4cGRS1PQ@mail.gmail.com>
From:   Amanda Shafack <shafack.likhene@gmail.com>
Date:   Sun, 18 Oct 2020 14:59:12 +0100
Message-ID: <CAGxm6oXhW8x2jkN-P4emhp6BvAwk6urzFTauQBDhJdMV_0d1fg@mail.gmail.com>
Subject: Re: [PATCH 2/2] t2200: modify code syntax
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Amanda Shafack via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I agree with you. I have made these changes as well.
Thanks


On Sun, Oct 18, 2020 at 6:56 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sat, Oct 17, 2020 at 12:02 PM Amanda Shafack via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Using the logical not operator on both the git and grep command is
> > redundant, since the main check is done at the level of the grep
> > command.
> >
> > Apply the logical not operator only to the grep command.
> > ---
> > diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
> > @@ -179,10 +179,8 @@ test_expect_success 'add -u resolves unmerged paths' '
> > -       ! (
> > -               git ls-files >actual &&
> > -               grep "non-existent" actual
> > -       )
> > +       git ls-files >actual &&
> > +       ! grep "non-existent" actual
>
> The commit message talks only about redundancy of applying the logical
> NOT operator to the combined subshell content, but what it misses is
> that transformation of:
>
>     ! (git ls-files | grep "non-existent")
>
> in patch [1/2] into:
>
>     ! (
>         git ls-files >actual &&
>         grep "non-existent" actual
>     )
>
> is actively wrong. In particular, if `git ls-files` itself fails, then
> the `grep` will never get run, and the subshell will exit with a
> failure, however, the NOT then turns that failure into a success,
> which is quite undesirable. The test should fail if either `git
> ls-files` fails or if the `grep` expectation is not met; it should not
> succeed when `git ls-files` fails.
>
> So, the correct thing to do is to merge [1/2] and [2/2] into a single
> patch which directly transforms:
>
>     ! (git ls-files | grep "non-existent")
>
> into:
>
>     git ls-files >actual &&
>     ! grep "non-existent" actual



-- 

Cheers!

Amanda  Shafack
