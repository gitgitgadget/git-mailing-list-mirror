Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3228C433DF
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 10:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E69222C8
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 10:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rg3cnqyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393296AbgJTKsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 06:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390218AbgJTKsS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 06:48:18 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402B4C061755
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 03:48:18 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id u127so1666147oib.6
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 03:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=uMOSOo/Kc4Bt1+p8AKuebE8NBVkr+Tx9tchjqcXf9p4=;
        b=rg3cnqyRprxm4y9WKEDkrwW0kVj+cH/QLEUrOEpHkp4ywYzOWWRVwVt/ECqr2/TDl1
         7jk3d6gbWHSRtiJM9Q4ETEoCntPbCq/0n7Vzt5PxX3FETO+vFNYfrHlWaI8GQ+L7Vczb
         quLZISe0H9oEKKGvRWdrsjP/eCxR6yuav4UknJ879RGdsCjHoG5TUbGzWzwT0S6SNMhQ
         cmEPEqhIT2bYCUPxiQc22FzYH+qeb7xDhfFvKVUfQI6cL4XBKpW9R8z7JdDpNrVnIfDJ
         pMEkNSD9fICeELi1XFxG2/ftTaZrxm3mqFz5bhDlb7idLvOuV584qodJR81mBtP68vQ7
         9QsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=uMOSOo/Kc4Bt1+p8AKuebE8NBVkr+Tx9tchjqcXf9p4=;
        b=VfF3AlZtGm0L29rX/TgaVMWCepBltAIljWFq3oqpctKPfNjdkTbtTPcrRbKvcHN7++
         iJjmUG+7IRN6XwmtpwMAVOdXS5nf1NtZnCcweOI10X+VZrgxN/Qc4r7wCR9UqhkkDR8T
         pkiUE+SmwR4IvZ+En8j7ejXqOCX84i4Q1UnMDZCZLdSqpoqLSFTe6GKl8Fe+/tFBw48X
         mPxUbr6bXL/+GzGLb/yrN6mmoqxE51MryLU22dm2krKVcmrJbCksbEG9RLK136ktOXSf
         weBvo8y5gu3pUrPVutJkBt+Z7AGK0BSnWEbYKoTxxpJDRiQjFxGF96JfIlQsvHuJFd4X
         GRXQ==
X-Gm-Message-State: AOAM531b3OasifddLfmq40ZSWoP0F0Fe3AauIMMkqMfyrD79gMslgx9t
        13J8rs9y0UlNlQqZS4n1bQr7vPA3gi7CSLXOVCqCn2LJAMg=
X-Google-Smtp-Source: ABdhPJxo/OGLYD+zt5I+RxIVb570Cmoi7JAZGcMPzFkGjr5IVU2MULnoE7dJA+E2JxafQ3oJBTTfIL12g7C84iJOaZc=
X-Received: by 2002:a05:6808:3bc:: with SMTP id n28mr1276433oie.171.1603190897017;
 Tue, 20 Oct 2020 03:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <CANZ9uZyL=+LNS-+2p3ukSPg_UXxjfcjD8QPVF4p0NF5-+eYMYA@mail.gmail.com>
 <20201017203822.GG490427@camp.crustytoothpaste.net>
In-Reply-To: <20201017203822.GG490427@camp.crustytoothpaste.net>
From:   Sri Harsha Akavaram <harsha.akavaram@gmail.com>
Date:   Tue, 20 Oct 2020 16:18:05 +0530
Message-ID: <CANZ9uZyGQiRjk2Uwi0YGYRWiH4BX2SGanaJEZKW8vbmO6WM0qg@mail.gmail.com>
Subject: Re: about git hooks
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Sri Harsha Akavaramu <harsha.akavaram@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Awesome, thanks! for your reply

On Sun, Oct 18, 2020 at 2:08 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-10-17 at 14:24:10, Sri Harsha Akavaramu wrote:
> > Hi git,
>
> Hey,
>
> > I just wanted to know something about git hooks.
> >
> > we use GitHub enterprise and I'm the owner of the GitHub.
> > I'm trying to understand that I want to pose the pre-commit and
> > post-commit rules on all the developers by default and is there a way
> > to pose git hook restrictions on all developers on default.
> >
> > I came to know when reading with the documentation we cant push hooks
> > to source control. Then what is the best preferred way to pose
> > pre-commit things on all developers using the repository?
>
> This is a great question, and it's kind of answered in our FAQ[0].  The
> short answer is that you don't.
>
> It's possible for any user to simply bypass pre-commit hooks with
> --no-verify without being noticed, and there are a lot of good reasons
> to do so.  For example, if I need to make a large set of changes, I may
> make a large number of temporary commits, one each time I make a change
> that works.  Those commits won't meet anybody's set of standards and
> therefore won't pass the hook, and I'll need to clean them up later, but
> that helps me organize my development process in a useful way.  The hook
> here would just be an annoyance that gets in the way.
>
> You may wish to provide hooks and an install script for the benefit of
> the user who wants them, but anything that runs on a developer system
> cannot be an effective control.
>
> The right way to add checks that need to apply to all users is to use
> either a pre-receive hook or a CI system, plus code review.  That lets
> your tooling verify things like commit message formatting, code
> formatting, tests, and other things you'll want to check before merge.
> The code review, besides being a best practice for finding bugs and
> problems before merge, also prevents developers from neutering the CI
> system by disabling it from working properly.
>
> That's the way that most organizations handle these problems, and
> generally it works pretty well.
>
> [0] https://git-scm.com/docs/gitfaq#Documentation/gitfaq.txt-HowdoIusehookstopreventusersfrommakingcertainchanges
> --
> brian m. carlson (he/him or they/them)
> Houston, Texas, US



-- 

With Regards,
SriHarsha Akavaramu,
+919493841589.
