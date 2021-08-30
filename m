Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C419C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0370C60F5C
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhH3UPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhH3UPp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 16:15:45 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379EAC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 13:14:51 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id q39so21381203oiw.12
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 13:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8AvySyKNzU1meN/5VIh2JOfW9h1jpYYVRrm1OqqlXsQ=;
        b=l8+zeIN7Ehm67EqeEcHMc9tBm7aRDQywT+tRTZvvjPVq4Cu9oBfPupCgOld3ULaeRS
         yi8unFq2T8DtiDE3rDYMYUxyAH71nUO7zno8POrHGfF0OGPp2Z2/3/B2WhOZ+hqTaPP1
         k7zwncp3l3HEV7Kb5uJd9rY3P9VaYWwRKYCOgsUmsiQHQrkvvZ5GtEks42skJuYA5kwd
         KnimwXmdpr9pFKfPS0TFGKthEy2zIS5MgzUZU6hBxbAjbnEtdA5s9FhXDsSlvfgCBh3S
         k6ov6kslU5lNdsBjAX7S2+XTNkbOxk5GqJe6B95Gy8NMR3x41ybVDNdZPWC7T+sA3MEE
         AzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8AvySyKNzU1meN/5VIh2JOfW9h1jpYYVRrm1OqqlXsQ=;
        b=J3SyNhcQzke74Fmw9hvUfIxF5xa5FyIs/O5CndX9cOYxPdFbxwOEL7mHyNLcGV4ptC
         OgQNgHmwyE5z0Oz5E2ycFeypmLCMVadCwZ6ui0mfLLDbfeUtsEf6XoaWnVStMt7Ow8rZ
         Lplcx1VsdhsO8tkdqJhhWynichhgT+NUUumISn2DfNTREmLoPA+qYeq4eqls3dmV/zZl
         h/giBUKq+O1T3OiH2RWawRtuiCBXeQzFqUCAto+eHwYkckXVCzvC8kC/YarDNTiMho2j
         EPmWCjNF+FfT0D2lulz18YRSulypOAzl6HJzFPkawuzhbJZcU3EKNPNwUoft8ICU3A/a
         qNVw==
X-Gm-Message-State: AOAM5339fYq+W1sgGShGs0lML8zIS35WG0K1MDo60LgRqLD7Yb7nh0zG
        9cQgtkE91TEINSbSX3GaYijt1lbNQxnqt6oOirY=
X-Google-Smtp-Source: ABdhPJwXlcaQiWCyHPydIOqFqolpn60etQFrSL2britKIDo1itgV6EAeVRysTJEw4Ipv1aKMtpaIikkl+BKjoWoP7kQ=
X-Received: by 2002:aca:bfc6:: with SMTP id p189mr672043oif.167.1630354490650;
 Mon, 30 Aug 2021 13:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
 <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com> <CABPp-BG01tXnd_UhYJDX4Tm_EcXGju9CkB8BXU0XS-YAWEuaeQ@mail.gmail.com>
 <CABPp-BH2+Vq4gLnOyRg4AdNhZgZuFf5+XBW6JMmSzGxoppEctA@mail.gmail.com> <9b4adc13-d362-455f-60f6-fe7d16608ae6@gmail.com>
In-Reply-To: <9b4adc13-d362-455f-60f6-fe7d16608ae6@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 30 Aug 2021 13:14:39 -0700
Message-ID: <CABPp-BGq7CccMVC4fCtH6wTz2Mcms3UxAk5VTr4RSP0RugTVmg@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] Sparse index: delete ignored files outside
 sparse cone
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 6:34 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/27/2021 6:01 PM, Elijah Newren wrote:
> > Sorry, one more thing...
> >
> > On Fri, Aug 27, 2021 at 2:56 PM Elijah Newren <newren@gmail.com> wrote:
> >>
> >> On Tue, Aug 24, 2021 at 2:51 PM Derrick Stolee via GitGitGadget
> >> <gitgitgadget@gmail.com> wrote:
> >
> >>>   8:  febef675f05 !  9:  c19d93ec5d7 sparse-checkout: clear tracked sparse dirs
> >>>      @@ Commit message
> >>>           the sparse directory. This depends on the indexed version of the file,
> >>>           so the sparse directory must be expanded.
> >>>
> >>>      +    We must take special care to look for untracked, non-ignored files in
> >>>      +    these directories before deleting them. We do not want to delete any
> >>>      +    meaningful work that the users were doing in those directories and
> >>>      +    perhaps forgot to add and commit before switching sparse-checkout
> >>>      +    definitions. Since those untracked files might be code files that
> >>>      +    generated ignored build output, also do not delete any ignored files
> >>>      +    from these directories in that case. The users can recover their state
> >>>      +    by resetting their sparse-checkout definition to include that directory
> >>>      +    and continue. Alternatively, they can see the warning that is presented
> >>>      +    and delete the directory themselves to regain the performance they
> >>>      +    expect.
> >
> > Will deleting the directory regain the performance they expect, or is
> > another step needed?  In other worse, will the sparsification of the
> > paths under the no-longer-needed directory into a sparse directory
> > entry just happen automatically as part of some other command like
> > commit/add, or do they need to manually run `git sparse-checkout
> > reapply`?
>
> If the directory is gone, then their performance returns to as they
> expect, since the next Git command will not need to expand the index
> to detect the difference between tracked, untracked, and ignored files
> within the sparse directory.
>
> (Recall that the index is stored as sparse even if it expands to a
> full one in-memory during execution.)

Right, as with the other email, this was the piece that hadn't quite
stuck or registered for me.  Thanks for clarifying.
