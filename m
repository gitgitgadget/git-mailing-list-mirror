Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CB2C432BE
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 22:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D569260F56
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 22:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhHCWqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 18:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhHCWqi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 18:46:38 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9055CC061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 15:46:25 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w6so621033oiv.11
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 15:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jAdjl8swGPo2MUSBI8YtvpvsOF6A9SNx0C+py/oBMwI=;
        b=spABOM42298dyKBXbmUyzETjru/4ahOBbnxMPUAzf1GNTZbduxpMKF/nzThwpXc/L6
         VPqI0lQk+pBIA6jfRefAIZA1i0+lW4m6kcMKzgkjk5RA6zH4Bq4zLnxJDv4v4eyyDLGe
         sPAAr6Udap73pGgEOhGdJKaMpgVqXr3IqqnGRPM8ku9+3nZGkMK3Y86OoRJE1IUsmfeO
         wdNo5grfDQU3/qx1ahPtd/xLixopsYgQV9RqUocm8OYoUsR/kV7G/pvLol6eVCYF37Zs
         QvwffW+WKi9Q4r/nKRlGlqJZwa9Wt3vuWk8gdW/UDxuLHHN0DIAaV3agDCDrhFsd+PHc
         k9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jAdjl8swGPo2MUSBI8YtvpvsOF6A9SNx0C+py/oBMwI=;
        b=TRIahkNa8x93ie6QGlMmN4zwx/R5mt+rr2M6Btv7QoTsXGP8MElZ/ylD6H6NiUl8bz
         rc+ud/Ma4fzqNiYZHALQQh92Nz5XoFk2lzwrPEZIu4UDP+bcc7+JhdJyaMgejgepzIWT
         nNe30QnZmtJSs0Tlkz9SBO3E/AmDkY/gJucMgH5kEZYCfalFbl3Mub2a7e1e6nJ7z/rM
         UNvrO+ekGo8UXoBdjJ3Mvz2VcI0JGme27coG+OZC+ISKBQLEKdkk5rMJE+5/j19vJDm4
         ef/j6YW7XLCrJLpol5/QF9d/Yw+MkbZBSR2I9XvsUtE6gtdzCpgtbC+6g2GQgxguz5t3
         nxkg==
X-Gm-Message-State: AOAM533qbFAL8YdP+/0EqtaLibvG2hrxKMsYbSa8E2qYN28zoa9nLnF3
        EoqZ9k4aqfbPbTk7b1c4PJRy/HSDsuWLjrjutfs=
X-Google-Smtp-Source: ABdhPJzYoIO41uMznkPjB939/7R6HMr3gGcJBFm067hCCX4xlmHOqnDUwp2RPnX7V5QrntXSA2tGBh+ZFtWc7u7DLjA=
X-Received: by 2002:aca:d644:: with SMTP id n65mr15972474oig.31.1628030784871;
 Tue, 03 Aug 2021 15:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com>
 <YQlnNXgk3qcGb5Bk@coredump.intra.peff.net> <xmqqim0mtc3u.fsf@gitster.g>
In-Reply-To: <xmqqim0mtc3u.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Aug 2021 16:46:13 -0600
Message-ID: <CABPp-BH=+d1xQaaBkLpRu91FJtQwh7GyGuve_ZwSwCUz5VreNQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] [RFC] Switch default merge backend from recursive to ort
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 3, 2021 at 4:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > It would make sense to me to do the switch in 'next' early in the
> > post-v2.33 cycle. It can cook there for a bit, but I think we have found
> > that it's much more likely to see actual use once it hits 'master'. So I
> > don't see a particular reason to have it sit in 'next' for a long time.
> > We should get as much exposure in 'master' during the v2.34 cycle as
> > possible.
>
> I do not mind queuing what is available today to 'next' to gain 2
> more weeks of dogfood time during the pre-release freeze.

So I think I made a small mess here.  Much of the second patch wasn't
specific to the change of default, so I decided to split it up into a
bunch of tiny documentation fixes that could be beneficial before 2.33
(https://lore.kernel.org/git/pull.1059.git.git.1628004920.gitgitgadget@gmail.com/)

So, perhaps I should submit a v2 of this series which is based on that
other one; then the second patch will only have the pieces specific to
the change of default left.

> If an
> simple escape hatch that lets us say "anytime we ask ort, use
> recursive instead as an emergency measure" can be added with a
> trivially obvious small patch, that would be a plus.

I think what you're asking for here is the `pull.twohead` config
option that has existed for a while (despite its name, it affects
merge, rebase, cherry-pick, and revert).
