Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6805C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 10:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4106420BED
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 10:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx2/Ftos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389195AbgJOKSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 06:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389099AbgJOKSW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 06:18:22 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D4CC061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 03:18:22 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id m17so3619906ioo.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 03:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dlhq+D1U15GMXab1oKTiehIL7jR/mOiMB082KS7gqSQ=;
        b=Jx2/Ftosl+VLsfR318nT4dI6rcSJTL4cNQR1u1S9l6xNP8DUEYBcEocNtXhrX846kZ
         TlVTtUpl64XgYofX79mKRN94VHfRtu9bPAqnusrhpWul7lQv5UDZxywpTugsJUGBYd9P
         R4RqqzljKgwW73CuuxIkevPYTMyYLQyx7KnMNVKQMzfAtByg2pN1qBK7tstUfnraII/G
         jUCEcUwq21AX8TMZ6m3VE1o/S+gopZmj8SrhP3lyjOnNhuk6azrVDVR2J8W3xhsuHHLv
         p/hAQHijQguHjj9ML0PWWLrIqNQ/hc0AGVEphMPHoXTvyZeaNaR4pMHbZnaADxOM8EKr
         romQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dlhq+D1U15GMXab1oKTiehIL7jR/mOiMB082KS7gqSQ=;
        b=r2iXm57jm7gJkvUIcRIfBpFQoMuddddvoCk6CbeeRJXZHKbCrDaen4BmAot2kUfjvJ
         R7bIxDWxb+02EQADSFaoB7NQQ0vejwGTMxI+tWmi+c/NGFJOxTGK50wDm1gh45JI5T7W
         bwAgoTpDZsyB7Ex1PUeuD/V4FCaATHg/ruRnTjIo4AKkO6XUuAijgcclWGoDTNTjVFso
         prtTg0onsT5Kb/ogQLgdf5rattSPQ0SWYQxs0BmS8XLLc+ID/WtgHYWTUjnYmwzAfqtb
         tFYJ3RUpb798iUKYYuyLFpbg9wLqciTnSItbwdAMu2H5r3y9jLpQ7GdFSz7dLGdvlEED
         1oOg==
X-Gm-Message-State: AOAM532Gpe5SYJMTUcxTLrsMUdY9Erunvj5sMa4yVsOrcuwBIHSEl50z
        T1nd1qOrQvwCsuBjCdYljEUJ+y53mfarlPfsZtk=
X-Google-Smtp-Source: ABdhPJwOOigv2enHqmIriBJws7O37LMCzy4uYLW/b8Td53V8y6Y/m99YoITDifzA4VxiJmGVW4eA+k8diDZQU6VMaMM=
X-Received: by 2002:a05:6638:2208:: with SMTP id l8mr2984673jas.22.1602757101975;
 Thu, 15 Oct 2020 03:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHjREB4gsyOrdnhp0_9rs0wv5q5H47-3RcB3fm5NY+L=3SYnMA@mail.gmail.com>
 <22e3d737-8621-9f20-307e-fc4c2a47ec0c@gmail.com> <CAHjREB59HjZAs98wMPtMANcHUaXGou7CYg9vAacc3m4uz1yUug@mail.gmail.com>
 <7d691f37-b8b7-510d-ba46-51a4a7587226@gmail.com> <CAHjREB6j6BqZ49wX5uqEOiysTAm8Oo7N=EFpcoovWKkBghBjxQ@mail.gmail.com>
 <xmqq362jsahk.fsf@gitster.c.googlers.com> <CAHjREB4Qw78xS-T=LA80yVf_u3=Hbpxg5tqBnP1QK44FRkBFOQ@mail.gmail.com>
 <3c0bf417-b3d5-b615-c605-49a5d8be4e06@gmail.com>
In-Reply-To: <3c0bf417-b3d5-b615-c605-49a5d8be4e06@gmail.com>
From:   Sangeeta NB <sangunb09@gmail.com>
Date:   Thu, 15 Oct 2020 15:48:11 +0530
Message-ID: <CAHjREB7xhBWHUCJ+T78i6dDGQr055sMAaYzG4gaQSr0T88cseg@mail.gmail.com>
Subject: Re: [Outreachy] Introduction
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, kaartic.sivaraam@gmail.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,

> I've got a fixup which I'll post after this which gets rid of the global
> flag and instead uses a flag in struct diff_options.

Thanks for the patch, I was thinking about something on similar lines
but couldn't come up with anything.

Also, one thing I observed that when I add a printf statement in
wt-status.c, something like this:

--- a/wt-status.c
+++ b/wt-status.c
@@ -601,11 +601,11 @@ static void
wt_status_collect_changes_worktree(struct wt_status *s)
        rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
        rev.diffopt.flags.dirty_submodules = 1;
        rev.diffopt.ita_invisible_in_index = 1;
+       printf("a printf statement\n");
        if (!s->show_untracked_files)

then git status shows output:

sh-3.2$ git status -s -uno --ignore-submodules=none
a printf statement
 m submod

which is what is expected. But when I comment out the printf statement
it again gives no output. I couldn't understand why this is taking
place and how can a printf line modify the behavior of git status.

> I thinking it would be worth considering if
> some of them should instead be changed to pass --ignore-submodules=none
> rather than changing the expected result.

Ya, that's a good suggestion. Would look at those tests again and see
if I can pass the --ignore-submodules=none option.

Thanks
