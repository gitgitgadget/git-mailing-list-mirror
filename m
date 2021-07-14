Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AC4C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 599B0613BE
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbhGNReR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 13:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhGNReR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 13:34:17 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7446CC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:31:25 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id s23so3194951oij.0
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ZyvAKL6g7qnflVplqimzCxO7M0BhBB9bjJfUzLsKqdE=;
        b=WDMvY6uxXTOuYj11v98Re+mcjdCThT9OaDHCsDXbK/R7/4WVnuLsxbzGvrP+WaUbGt
         eytr+7LJvoR/Z7yC80LZSPDoX0MES6uW0LzUjA8BYT0XnuEKlpYkXZI9gEDwSQYlknh9
         5EmvyCdJbwOlVTwTjEG0o+iGDnZ9CLDV9/4Q9RtbBNWOz/HDFJ2F8D4JebKMvdAEnqfc
         g0Z5Efl1+juJJe7NMwu4BaelcEtHPH0OemDdq8cAScTj8yRwxUzLYca2YetUc0Pn9X8W
         R6NFZLw9M4mlg4qY0ZzdvE0cB5qtaCKiI3JesxPtMrKyjEG/+sCHu3jqHlciKIPePAja
         mFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ZyvAKL6g7qnflVplqimzCxO7M0BhBB9bjJfUzLsKqdE=;
        b=PQscZH0iFxo5dZAdCrFFxSjJC0MloaHCGG6k/ksoN+wTkQXr9wLSnGb5OpexETIGIZ
         h51m7z9i3nWDE2u1Qsot0PWZQGoCGxr1s9zXJEpmTcbsrAChJLoMmEs6S5oU3pgmJNs+
         XF5ZSTNbyyKDvWC6iW5B6EdX9SJOUb2KG/RFrwt2RMMzXp9fCk8YZtzuiJ7615vziqMC
         Q6gM92uUbvtkbW4GuzBbEITGLgICazSz26U53Nq0cAIIrgQMZLs7bgSv4KqoFz9LQ2c7
         O2X97rWjfOlpyVOcwIC49m7PGmUWTIfeQsq3guj9InYameEfto8fuX9kRlk9rH7H0rDu
         fdTg==
X-Gm-Message-State: AOAM533oTc1DNTE5Cymyc0ifmUtXCGVq0IMM9d0Z+4iOwXPPDooxLzyj
        nQ3KKEjfCMi6iFPPHDHUlvY=
X-Google-Smtp-Source: ABdhPJz69MjZCZEPXrIuzhDjVIdsAa6mjAreWi30ot4NG53lLb0OGkSu57Ix7IYow/pjvvlPJx3TvQ==
X-Received: by 2002:aca:3285:: with SMTP id y127mr8263280oiy.115.1626283884852;
        Wed, 14 Jul 2021 10:31:24 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id v26sm525858oof.30.2021.07.14.10.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 10:31:24 -0700 (PDT)
Date:   Wed, 14 Jul 2021 12:31:22 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <60ef1f6a83b61_9460a208cc@natae.notmuch>
In-Reply-To: <CABPp-BEqnTuDgC0Bb+feFj=vBB48wdb60thO+Pq3N0jL74jH8Q@mail.gmail.com>
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
 <CAL3xRKdOyVWvcLXK7zoXtFPiHBjgL24zi5hhg+3yjowwSUPgmg@mail.gmail.com>
 <CABPp-BEqnTuDgC0Bb+feFj=vBB48wdb60thO+Pq3N0jL74jH8Q@mail.gmail.com>
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding is
 impossible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Wed, Jul 14, 2021 at 1:37 AM Son Luong Ngoc <sluongng@gmail.com> wrote:
> > I am out of the loop in this thread but I have been seeing strange behaviors
> > with pull.rebase=true in the 'next' branch and also in the 'master'
> > branch in recent days.
> 
> I'm not surprised it happens with recent versions, but I'd expect this
> to have happened with older versions too.  Is this not reproducible
> with git-2.32.0 or older git versions?

I already provided an accurate target [1].

> >   > git version
> >   git version 2.32.0.432.gabb21c7263
> >   > git config -l | grep pull
> >   pull.rebase=true
> >   pull.ff=false
> 
> So, you have conflicting configuration options set.  pull.ff=false
> maps to --no-ff which is documented to create a merge.
> pull.rebase=true maps to --rebase which says to run a rebase.
> 
> You probably want to drop one of these.

`pull.ff` will be honored by `git pull --merge`.

[1] https://lore.kernel.org/git/60eeff69293fb_10e52087a@natae.notmuch/

-- 
Felipe Contreras
