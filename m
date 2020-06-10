Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3450C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 06:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B67D120801
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 06:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Clr0Md3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgFJG46 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgFJG45 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 02:56:57 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1C3C03E96B
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 23:56:57 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z9so1054080ljh.13
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 23:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u7nl955LpHxJ6pRvW+dl/I1xHC3cRkiwRfkLNLCq9AY=;
        b=Clr0Md3uhW2T4gKiLzqdBsqrPr3KRsYTpKsObOobxoaIuY6460zKj7iJ7l17ugMPwZ
         I/yGFa5UBfCh/I4en3lmEF0kLy8vZcd27R6iPUBFGPhsPoGDY5HYZErW9NOhP3ZpS1ra
         eiROISW/kfVSe1e9QVhQ5mcNmjbbDnoAYqHNko/aiz6/iHOtY3s1L4jEeqywDbAZwUMs
         j18qUEA9hzlzAZhmUHfXUGwEwGI+7YIt3pv/tsb7ueEHbmRy/KOe1KoAa48z1Qq4+yYJ
         k3tRF7sL49vPxmyE0HSDTA12xrF1vo/oqHTVl2FjGVmzfmh7c3xFlcnkxA8DE7cCfGjl
         j+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u7nl955LpHxJ6pRvW+dl/I1xHC3cRkiwRfkLNLCq9AY=;
        b=gJQtlCfy92FJ3srhiIcdjvu6ScAatYVpFCzTRCnlAtodgc306YMxiuerpfYmU1rJzT
         Dt1sFCGYuX4PwI8BrvRKnYPGMmVMNwZpFH328LYUNf/KvK8Y6oUtN+tzjHpL3+N5yS48
         pOzND6D57eFF0jH15zyp71gWEuDed/WwS5WFluC/BcfZtXIw6tlf6IQ0RgtTazX77nq2
         C1SjUjSVsp+4d/LWEOoL5NGEYmPZyfTko3hmQREP4UHmyiaf48hvzFFNxZRtGMHwkxtg
         KaWtzZY7kqrKGlTYT0EjcEhQBR5SwlJrR8A+LbOAwh/MMbFm7F5SZoHbRNPpspDyxf2w
         mEfA==
X-Gm-Message-State: AOAM531ZpVgQhEgaXOIxZTqaJgpigdBkwa2Dx9n5PDFmoPVvoPP5vxt+
        sS/wqsZq98elh2c0B0LFSM5Jd+JJKYpu+YsFRru0037WI+Y=
X-Google-Smtp-Source: ABdhPJzUfMEJySlZOg2mZ2rTGWz9C3xg161w/kgLMSMJH6Z6TSE+Z2LCr/JDxtwbpEf2aB9tYT1dSm/raMd/kYpgw0g=
X-Received: by 2002:a2e:81c5:: with SMTP id s5mr924227ljg.372.1591772215154;
 Tue, 09 Jun 2020 23:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
 <pull.539.v16.git.1591380199.gitgitgadget@gmail.com> <xmqq7dwfhlwt.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dwfhlwt.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwenn@gmail.com>
Date:   Wed, 10 Jun 2020 08:56:43 +0200
Message-ID: <CAOw_e7ZzEyb+21QHcNGcj5A8N501-a5fF3HNL0Jq6uD8S37G6A@mail.gmail.com>
Subject: Re: [PATCH v16 00/14] Reftable support git-core
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "hanwen@google.com" <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 1:14 AM Junio C Hamano <gitster@pobox.com> wrote:

> > Some issues:
> >
> >  * many tests inspect .git/{logs,heads}/ directly.
> >  * worktrees broken.
>
> Are these with or without GIT_TEST_REFTABLE=1?

worktrees are broken with reftable, because HEAD is per-worktree ref,
and I haven't decided how to handle those for reftable.

> The patches (with the fix-up I saw today) applied on top of your
> refs clean-up topic seems to pass the tests (without setting
> GIT_TEST_REFTABLE) as the whole, but when merged at the tip of 'pu',
> many tests fail (please see [*1*], for examples).  I suspect that
> there may be some topics in flight that add more direct access to
> the .git/refs/ hierarchy, and/or there may be stupid mismerges (I'd
> especially appreciate it if you can spot any).

Curious; I'll have a look.

There is also:

reftable/stack_test.c:27:7: error: incompatible pointer types
initializing 'PREC_DIR *' with an expression of type 'DIR *'
[-Werror,-Wincompatible-pointer-types]
        DIR *dir = fdopendir(fd);

on OSX. What is the proper dialect for reading out a directory within
the git source code? opendir and fdopendir are POSIX, so I'm surprised
this fails.

-- 
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
