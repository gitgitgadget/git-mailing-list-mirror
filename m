Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10392C2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA9382076E
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=webstech-net.20150623.gappssmtp.com header.i=@webstech-net.20150623.gappssmtp.com header.b="CVDo1nYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgIVWll (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 18:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVWll (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 18:41:41 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C698C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:41:41 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id p15so10375305qvk.5
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=webstech-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WeO8q9Cr/xAXCkh6Wc/m0ZejHjdC+tapboVbfavRKjw=;
        b=CVDo1nYq2NfGcxFJ01WdeiiEeVX207Z4R4KbhD6kEip4PGMdThb2uvssUiOGJqouAZ
         tQrgMpNwAkNABNW7t3Bs3tVxAsyf7prW+oNlBRsWH6XvVBhl1ITDkPbqNddHW6kdlhbh
         Bse7bu1q2rbqsXrSAwCdbfv6GIGHWGrEHrdC6wb2CTyxQi+3xxbuMI2uj31rUI7GfMSd
         CqF/yYSOe+aF992j0NG+XjKVi0oF+nO4yDN/YX22xTOEmaEAGcpz1XyfXl9rAbd5cLuu
         eXXnBIc3ftEvs3ZE0q3AhakCoAsENSUcVwGfiS6wcGdgUxrMBiGZrDEOYhzvGCrXftd/
         a77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WeO8q9Cr/xAXCkh6Wc/m0ZejHjdC+tapboVbfavRKjw=;
        b=JjY+QXqw9wxp0Sf6g4phQzdNciWUWZEPDADTtGJdTvbg0erT5te6UZZQfwG7eHiRJY
         UMwJ5HngAFKgkdSJCswqZ9ERmAXAEm0gu1vWahP+/6fsoLdW7kOADcjSutWGUqpylk6X
         QZ0flE0biHa38+EdDB5zOLqtYzfIN1zpxuO92w+Go5VmJKjyBBVC2sB23RxoCy7T1jfd
         yH2ON5Vd46FCf71+seUrWLxrWLM0k56SJTYoG7cAMFG2yVA/T+fiVTDiywYdZK27g6yK
         eRd4MckygMyCk6aiYSGGOSGyd7Xhtvj7AWN9kwaqmys0qTGixyBSc0TQW0q4CDvNUw9d
         LFYA==
X-Gm-Message-State: AOAM530oikM7SMx8ITYyZvYap58pOjDEhpdYClidpi4t1Q+Loxraa+tC
        8Tr9uLSenypkbzlMR5OKRcpXQJpOdzj+xWDSmhdP9Yku6vqqy8XKeh0=
X-Google-Smtp-Source: ABdhPJxeKNb58nQyZ6BciQIfPpWxQ2m9czBaC/IpAvAKGZ+mAcgnAHeIyXTLM15+FIdkyB2L/LD+SqVcDmqjwTjGh9o=
X-Received: by 2002:a0c:f194:: with SMTP id m20mr8450458qvl.9.1600814500333;
 Tue, 22 Sep 2020 15:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.709.git.1600759684548.gitgitgadget@gmail.com>
 <20200922170745.GA541915@coredump.intra.peff.net> <xmqq1ritlmrk.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1ritlmrk.fsf@gitster.c.googlers.com>
From:   Chris Webster <chris@webstech.net>
Date:   Tue, 22 Sep 2020 15:41:57 -0700
Message-ID: <CAGT1KpU4Kjv2PEAA7-bNbGp2DFvfsKqABuUK68128xkLjdcEhA@mail.gmail.com>
Subject: Re: [PATCH] ci: github action - add check for whitespace errors
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 22, 2020 at 10:55 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> >  - this will run only on PRs. That's helpful for people using
> >    GitGitGadget, but it might also be useful for people just running the
> >    CI by pushing branches, or looking at CI builds of Junio's next or
> >    seen branches. Could we make it work there? Obviously we wouldn't be
> >    able to rely on having PR data, but I wonder if "git log
> >    HEAD..$branch" would be sufficient.
>
> Yes, I like that very much.  If a push triggers a CI run to notice
> whitespace breakage and other mechanically detectable errors, that
> would prevent embarrassment before even a pull request is opened.

This was originally started as a push action which was expected to be
in the GitGitGadget workflow.  It was changed to run on PRs using the
more helpful PR data.  The original GitGitGadget issue suggested a
build target to run the check, which could have been part of the CI
build (or a local build).  Doing the check later as part of the PR
process is consistent with GitGitGadget performing linting on the PR
request, with similar opportunities for embarrassment.

...chris.
