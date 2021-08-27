Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB192C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 22:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B645B60EFE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 22:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbhH0WCc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 18:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhH0WCb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 18:02:31 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717B9C0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 15:01:42 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id s20so11524263oiw.3
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 15:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YInRDDugVXwQyvVdV3MxEuJdZapufKd2ZitJuOxw1U8=;
        b=fldbp0gmF5CpHReIDk2mPcv6Dz8lsEAqvviT22w6xV6F68mf0vg0e1Aloh8DrDTeYP
         VXUm3xvhz7G0m0JFmwbd0OA214z+JCjrwazAane8EAFYS4fVTpylpM8KmYQBG+yhUSWd
         lLPs7dk8j0yWXWM/ufblx4AF3/jKm9aB+XSM7CYx3lYvGEZqrznVTCoGECQJTRKP3I21
         Oz9ejiIN4SlJiB6j1bZXjdAHN3SdeR+xDFbd0xIUVFce1R6YA/m5i/P9Bs3KrasBSNhX
         ujN+foBIbrNTVSsxYVHLNr/fZ8/5xYJLSsp1QbsO1e/S8t7kxnrJrjGAztd/ATWchfNH
         HdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YInRDDugVXwQyvVdV3MxEuJdZapufKd2ZitJuOxw1U8=;
        b=CGTH4Ht5W7ifELIufxZvr39bqbt9/9zZzfaQu6guMXtPIWMvh24J/qKartxROQFX7r
         eO4GAbBRSV4zYtrMfr6k2B8QOBZ34Ry5ga+tmV8OFs/n5nDx6Pe431qozmvYFkvnKdHc
         yp8zoM47GOgdkYBpUZDXXdSRb424/0Sovoilj02daWJ5bA4dxgrstT+nFz28acTNUVba
         kSzo3q98Mmj6/B11/ln9rfXQ8i7zMXXQRm+0cCZ/P15qyeTvnOvjJ7JEHLn32p3Qnw+6
         mZExJzOAjalu09FeLDgF28m2Al/BnrLOdx7xPJUQBSIscVS6TgfVSWbhAF1iIn9NK7I9
         VKvw==
X-Gm-Message-State: AOAM532N/XE7rKJ9eH4esPJaurUO2RumBdpqnNSJHLgjp/0sf6EWK8Ta
        kp1iEyYaPkVKFNUZekzdWWhXjKlJ6+k1PlOvXnU=
X-Google-Smtp-Source: ABdhPJzhZmniiYCq8/t8opUoy7F0xS7hImJmoMhgQWC/tvD4c8VEMeJWk7CuBnMAUVvlkDZYy26TuojS23TrRGFUzj0=
X-Received: by 2002:a05:6808:1787:: with SMTP id bg7mr16379852oib.39.1630101701849;
 Fri, 27 Aug 2021 15:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
 <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com> <CABPp-BG01tXnd_UhYJDX4Tm_EcXGju9CkB8BXU0XS-YAWEuaeQ@mail.gmail.com>
In-Reply-To: <CABPp-BG01tXnd_UhYJDX4Tm_EcXGju9CkB8BXU0XS-YAWEuaeQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Aug 2021 15:01:30 -0700
Message-ID: <CABPp-BH2+Vq4gLnOyRg4AdNhZgZuFf5+XBW6JMmSzGxoppEctA@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] Sparse index: delete ignored files outside
 sparse cone
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, one more thing...

On Fri, Aug 27, 2021 at 2:56 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Aug 24, 2021 at 2:51 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:

> >   8:  febef675f05 !  9:  c19d93ec5d7 sparse-checkout: clear tracked sparse dirs
> >      @@ Commit message
> >           the sparse directory. This depends on the indexed version of the file,
> >           so the sparse directory must be expanded.
> >
> >      +    We must take special care to look for untracked, non-ignored files in
> >      +    these directories before deleting them. We do not want to delete any
> >      +    meaningful work that the users were doing in those directories and
> >      +    perhaps forgot to add and commit before switching sparse-checkout
> >      +    definitions. Since those untracked files might be code files that
> >      +    generated ignored build output, also do not delete any ignored files
> >      +    from these directories in that case. The users can recover their state
> >      +    by resetting their sparse-checkout definition to include that directory
> >      +    and continue. Alternatively, they can see the warning that is presented
> >      +    and delete the directory themselves to regain the performance they
> >      +    expect.

Will deleting the directory regain the performance they expect, or is
another step needed?  In other worse, will the sparsification of the
paths under the no-longer-needed directory into a sparse directory
entry just happen automatically as part of some other command like
commit/add, or do they need to manually run `git sparse-checkout
reapply`?

> >      +
> >           By deleting the sparse directories when changing scope (or running 'git
> >           sparse-checkout reapply') we regain these performance benefits as if the
> >           repository was in a clean state.
> >      @@ Documentation/git-sparse-checkout.txt: case-insensitive check. This corrects for
> >        'git sparse-checkout set' command to reflect the expected cone in the working
> >        directory.
> >
> >      -+The cone mode sparse-checkout patterns will also remove ignored files that
> >      -+are not within the sparse-checkout definition. This is important behavior
> >      -+to preserve the performance of the sparse index, but also matches that
> >      -+cone mode patterns care about directories, not files. If there exist files
> >      -+that are untracked and not ignored, then Git will not delete files within
> >      -+that directory other than the tracked files that are now out of scope.
> >      -+These files should be removed manually to ensure Git can behave optimally.
> >      ++When changing the sparse-checkout patterns in cone mode, Git will inspect each
> >      ++tracked directory that is not within the sparse-checkout cone to see if it
> >      ++contains any untracked files. If all of those files are ignored due to the
> >      ++`.gitignore` patterns, then the directory will be deleted. If any of the
> >      ++untracked files within that directory is not ignored, then no deletions will
> >      ++occur within that directory and a warning message will appear. If these files
> >      ++are important, then reset your sparse-checkout definition so they are included,
> >      ++use `git add` and `git commit` to store them, then remove any remaining files
> >      ++manually to ensure Git can behave optimally.
