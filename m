Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27C2C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 03:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B460460FF3
	for <git@archiver.kernel.org>; Tue, 18 May 2021 03:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243894AbhERDgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 23:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243059AbhERDgO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 23:36:14 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C520C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 20:34:51 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so7510832oto.0
        for <git@vger.kernel.org>; Mon, 17 May 2021 20:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P5gCok09iA4JfxyKVhOcojyCeMS47vaOZ+kRL2MLBEA=;
        b=gluPhiI1DHQZjq/S9kpgqyac/uvgu7ugSK6su1+uLzgCHbRktVJ/MnRiMPi+PD4KUG
         /5hAJfUNsnYB6cZt3atEZ9Pe73rmSti+ovDG3s57Xlve/mRlIAL6SzyQN48m/PK4gkcu
         vvYwZj0fpMekYDtO5yaM9k0ZEFz6KHSYF0j/eUzxGsloFu89BjwkSKbmaUWJWo267mZh
         sOXIrssjOogjra9i8KbJzhoU0lmH82JqCAfmsxORVOHnIcnjl54yiZaAzJCFApYUY1YE
         BWbm5vaTcQQkT2JG0eQdfHJfrl0H8c3PnbenhTNdXGa+5dhprvCYN6mKOKWcKa0KHobI
         FQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5gCok09iA4JfxyKVhOcojyCeMS47vaOZ+kRL2MLBEA=;
        b=EyEQg8Smx90EUlVUpgesX5PtDEyFZXoaANFUuGB8Bq3KIPmWfjptr8u9xm6VxtE/B5
         H/VUQP14jg6enOaGAZx4+Nf1xgnmOX+ydvWzMKybo3X0L5Rf/PBt5plwybTck222MN4e
         pNYDmmwdoYDcgdjvoqpGxXU5bnriHRnV2olFRJy65XtDIokXxH9D1a1crInyxFgl0B4X
         v7zjOSHqUhC2RdvgakG7Pgjpjjxe8fPTYBzONm1YY/0iaMkhYO5MSMsgXthtca5kMXek
         TrRheiPJBCx69B7dYYL/E8UPgEx5duT6Mpsnp9Oq1g7yMuSuyuhWJp+hyBzUhM52v45T
         npUA==
X-Gm-Message-State: AOAM532PWnRTe/4wsSimHetI0Ggy9BBAbd9/zg6fnZ2mPofrVnL+wl4e
        PPj5vcuLlNA0GaxX/Fl6WXxN+X9/zqr5Biwfu1bMIUJmTrI=
X-Google-Smtp-Source: ABdhPJwnK/a0r4QMkCS3qy02sMxh/PqB4k3yklGH4rd/Js9+qlL8BAb4SrDLtAIh4HuWUh0Vzt1Ph7kRmycmFWtUbfs=
X-Received: by 2002:a9d:67c5:: with SMTP id c5mr2403624otn.162.1621308890321;
 Mon, 17 May 2021 20:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
 <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com> <b7c6176560bda67e146d0402f927180dace534a2.1620840502.git.gitgitgadget@gmail.com>
 <2b7ba27c-5ffa-0ef0-6c7a-4da45f979b9c@gmail.com>
In-Reply-To: <2b7ba27c-5ffa-0ef0-6c7a-4da45f979b9c@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 May 2021 20:34:39 -0700
Message-ID: <CABPp-BF7PrSK=yFvAVQe+vpNTv_j1ZTgh_HQeJVeGZeGk=499Q@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] dir: introduce readdir_skip_dot_and_dotdot() helper
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 17, 2021 at 10:22 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 5/12/2021 1:28 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Many places in the code were doing
> >     while ((d = readdir(dir)) != NULL) {
> >         if (is_dot_or_dotdot(d->d_name))
> >             continue;
> >         ...process d...
> >     }
> > Introduce a readdir_skip_dot_and_dotdot() helper to make that a one-liner:
> >     while ((d = readdir_skip_dot_and_dotdot(dir)) != NULL) {
> >         ...process d...
> >     }
> >
> > This helper particularly simplifies checks for empty directories.
> >
> > Also use this helper in read_cached_dir() so that our statistics are
> > consistent across platforms.  (In other words, read_cached_dir() should
> > have been using is_dot_or_dotdot() and skipping such entries, but did
> > not and left it to treat_path() to detect and mark such entries as
> > path_none.)
>
> I like the idea of this helper!
>
> > +struct dirent *
> > +readdir_skip_dot_and_dotdot(DIR *dirp)
>
> nit: This seems like an accidental newline between the
> return type and the method name.

I would fix this, but the patch is already in next.  If Junio decides
to revert the last two patches out of next because of the
Signed-off-by issue on the previous patch, then I'll resubmit this
patch as well with this issue fixed.
