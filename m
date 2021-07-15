Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C13C12002
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 02:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E8F161377
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 02:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhGOCon (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 22:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhGOCom (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 22:44:42 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B56C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 19:41:49 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so4635580otp.8
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 19:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=grvQqkTdtH44kHTwx7bV1mKkKe9oq1TdhuSn+fuW8Mw=;
        b=FYwbGkhBSXXnyDs7rnaZtEgxwml/qt4bx/sR8PSyVLC6sT/xr2+rIK/NovVIiPZ1Ez
         +2TLoBWVgDqReaJvAcvtLL0Ht2VsI0uvgsxGPYVlYB/JueUJgrRFFyiLM5e+WO9HM7ru
         qmsO1hZscP5Xyh/4npE6yq/V/2+0EayiRL8uRnLpuGqoXticPcq2OTnCKweyfxOMaBS+
         vjDuK1yGZLX5lAgvN6VJNZ8Ve76XkwSMgovKhOOVAu6cU8WOLgMZ4nTbhf9Ppr29ygFE
         HK+C3UeB7EvdOmIFax4YuM2pLH/f64umm4XmjhsBmrvGhYOKV5Q8jdGlhiJYd7VE/TQM
         tDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=grvQqkTdtH44kHTwx7bV1mKkKe9oq1TdhuSn+fuW8Mw=;
        b=el72yj8CST3MdA2W4FTGQq+ldYMlYJMmmYy1IwuKioX7aAKUL9KjtPlZ+/4pDuyhg2
         L217XgXTPGlOHh3m0BwGXcYB7EED8xd8E0LTO6MM8yP590kMoXdtC802NBerCxcHEuEv
         jWC0vuq/CI1bCUNX6jt7aSGd1a6WVfAXx+fixhgSzNqPeChkHOsCV0J5URNRmWOkMpt2
         GsFKmTDn6JN2dWU87VZrw8l/9e6RsgKcocdfMl452+eeDDfw6gMf/xkUbcGamxMtmzx8
         iu4vx6fIWPBJ3tQbI0+h452B4Psb033AOlHGZybXK/UXCTbwed5aeZcW8TkkDiMMTSE7
         UXmg==
X-Gm-Message-State: AOAM5301SaYGWLD1hjIT2olYCfO0ft6ZThTVh+o50bYCo37q73WUgM4o
        r6r78iEALl+QDLpVcNiSBJrFiGpSY6fv6lVgyM0=
X-Google-Smtp-Source: ABdhPJy+WAJ+hzaTk0tVPvZUcrsklbfwnuV1FC6pWdIUQsyjjVlJNMafGznxZZyuhqXTYRDKHxaOWLUKHcZH2S2M0AU=
X-Received: by 2002:a05:6830:1d73:: with SMTP id l19mr1255377oti.316.1626316909137;
 Wed, 14 Jul 2021 19:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
 <pull.932.v9.git.1626268360.gitgitgadget@gmail.com> <xmqqim1cvdh6.fsf@gitster.g>
In-Reply-To: <xmqqim1cvdh6.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 14 Jul 2021 19:41:38 -0700
Message-ID: <CABPp-BHP_jbQQX=5XRF3fVYvDGBsvWpuXeFg0RFePD47L_8U8w@mail.gmail.com>
Subject: Re: [PATCH v9 00/16] Sparse-index: integrate with status
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 1:37 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This is the first "payoff" series in the sparse-index work. It makes 'git
> > status' very fast when a sparse-index is enabled on a repository with
> > cone-mode sparse-checkout (and a small populated set).
>
> The first payoff turning out to be  a long time coming ;-)

True, but much, much less time than it took between when I started the
merge machinery overhaul and its first big payoffs.  ;-)
