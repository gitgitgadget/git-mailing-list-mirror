Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E43FC433E1
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 21:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BF0F20656
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 21:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZCGVm4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgGNVfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgGNVfC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 17:35:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93194C061755
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 14:35:02 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s10so211779wrw.12
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 14:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=LWlu1ksfQveATVd3hUAPnTm7G7iEY8CvfcbrvTHsOGw=;
        b=WZCGVm4u0swEYDbnCnSYl2PwRlsDp3d1ci1DN/MaDjLKE0MHL8TPB8W44RO4BfrM+l
         709FW6nSboOc0ZxxJfF5pNA3aPdz1R/zoc3UXs5oO7RW2oTkowYfNZGCbScks8WqQ9ED
         nVZJ4Y1qrB/lMWaxMTVPjaw3BBh35p6l32v1fanfkDY+2YSsXxRZJs9XVzDshMcL3n9B
         TkI/macSTXaRpmp8C0gDituYPHrJwLwHDMy2wEnhQy/TcuucopegmwA7lBxN+4rpeb9J
         f9WPSJyU+v1GsJkiX62asiCMjyct7efloi2RqUsC+qOIXvUs1ANc1GznTxkWTBZa1jtc
         N/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=LWlu1ksfQveATVd3hUAPnTm7G7iEY8CvfcbrvTHsOGw=;
        b=lIQPp3bNlUXwhvcr2Br8RQFVEqewcCcVDQ2EIr7mA2VRno9nnBTHgMmcMxaE1IBY2H
         if8eevQzzWekIgLSsuew9gbwv2iYhKOFUySuYEg/59wJwAeGC7EFPMUWC9XxZgFmtHqK
         876bunrGWwHOEK1XzHTGD99fz4DqMwIss+9qm2RnXmoK/KzidcV5tsU3njo8RBoozUyq
         X2D1H/X7lalRI6GNz7+hO3ozktBGe68olNkVqSESHwT8vYNDrEDDOVkzD/44twKHh1dT
         zF1TUsSUJLoiTslvMvkaSeNDiHrEM8VVSJcQqwPrJjgVrpdzsr+4go57YNPmgk/26hK4
         Wm1A==
X-Gm-Message-State: AOAM533ZRhq8sjzL7HL24QxSmB+ef6axKUZeX0//GWPsZ0UrPkwIT3b+
        oMtQbDLxYFuyQrTUkkZdFb/THLrNseT5LnUrRnHy2ZC1
X-Google-Smtp-Source: ABdhPJwjVfGfgEO5gzoziXXzOXpYYvin1CGtUgRdGFv2ED3glct8MEp/FL5IpUqtWhm4GsJYCxh4S8kmGExshD/n/oY=
X-Received: by 2002:adf:8b18:: with SMTP id n24mr8366364wra.372.1594762500498;
 Tue, 14 Jul 2020 14:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <CABXAcUxw5EA6jPB93C-Cfg-tycLMQSKUgrLkLXSQUZPHeEva9Q@mail.gmail.com>
 <CABXAcUzvZgHwsfL8VaevnDeyyce_5sWtd2istA55CgnzFE1Z6A@mail.gmail.com>
In-Reply-To: <CABXAcUzvZgHwsfL8VaevnDeyyce_5sWtd2istA55CgnzFE1Z6A@mail.gmail.com>
From:   Clement Moyroud <clement.moyroud@gmail.com>
Date:   Tue, 14 Jul 2020 14:34:49 -0700
Message-ID: <CABXAcUx9ubCi485xoawSERH4pEjAFJcfGbdNiRL7KkwAmFrMsw@mail.gmail.com>
Subject: Re: 'git rev-parse --show-toplevel' errors out with per-worktree configs
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > IOW, this works:
> > git clone <url> non-bare
> > (cd non-bare && git worktree add -b master2 ../wtree1 master)
> > (cd wtree1 && git rev-parse --show-toplevel)
> >
> > This does not:
> > git clone -c extensions.worktreeConfig=3Dtrue <url> bare.git
> > (cd bare.git && git worktree add -b master2 ../wtree2 master)
> > (cd wtree2 && git rev-parse --show-toplevel)
> >
>
> Sorry, I mixed up my examples.
>
> This works:
> git clone -c extensions.worktreeConfig=3Dtrue <url> non-bare
> (cd non-bare && git worktree add -b master2 ../wtree1 master)
> (cd wtree1 && git rev-parse --show-toplevel)
>
> This does not:
> git clone -c extensions.worktreeConfig=3Dtrue --mirror <url> bare.git
> (cd bare.git && git worktree add -b master2 ../wtree2 master)
> (cd wtree2 && git rev-parse --show-toplevel)

OK, I figured it out by looking at environment.c. The issue is that
the base mirror is bare, but the worktree isn't. This makes it work:
(cd wtree2 && git config --worktree core.bare true)

This is confusing - should this be set automatically, or referenced
more clearly in the 'Configuration File' section of the git-worktree
doc?

Thanks,

Cl=C3=A9ment
