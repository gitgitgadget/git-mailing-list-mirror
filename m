Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33944C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 22:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A2B460FE6
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 22:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhH0Wvd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 18:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbhH0Wvd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 18:51:33 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35218C0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 15:50:43 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id k5so17491186lfu.4
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 15:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fRscHGYgaA4YrdSn7ERAG9Qtn9lJwn5sN7zmnJ04ghY=;
        b=iM/EuNpafyebhvyFBgCKEhMS7ZLpMmS4FgulGTYevskREqEWjwol3kDp8SP2rBypmE
         76y1RQLLrS8TZ5WLzPcE1QDyiYJn/qIjvw0aEyvwJEvmkuYR0UR2Bg6hEs6iALWfAfDQ
         tL8YjW2TtfrcC9eX2pT4m+6KcJaR+yWuC7Bifvz17KYpRamEUZN9Ih+PNF1adIiOI2y/
         fzihH5UBRtAns5b4/sHZvhD+KCKQoluW4Ok+S907Yo1fOP9vZYENEuFTNOzkRxEoz23X
         OuLDdZSXqm6QO56+C1Flg071GskOkRP6biaOw5y+9RXyeGgPoYcN1AZx0FxqTua+yXj+
         RsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fRscHGYgaA4YrdSn7ERAG9Qtn9lJwn5sN7zmnJ04ghY=;
        b=S6A7Fd26R9j8mkMT+NHasbFEe3rLaZNzdxN1C1LRVjgF3872Po1TCQ+4vcC5BLoCH9
         BSHpIM9NJuYeg0dEQHmPjenNzTIalL+vTQ2iA87kVK5oed4BsAeXHb18mEel6I+DiAbD
         CHVtcrsGi4p3ofE2FxasYL16kqNBlWJF7XuR5zam2TrmP9YK+Mg+DG9/5GdythD6TjsB
         y/xG2FED3vDkwhiduNXzLLGUZEeUacRx8hZVKyUDdiInmv1kREoo61zw7Tt2q46b9U6d
         RXEZW3BbXPB5pmy3ZBKiqT9hOleywc3wP4NthOxgnZLVauXaSfBepghDPhfIlnUZzBMk
         IZvA==
X-Gm-Message-State: AOAM531b7SYUgrFwHVmgeJM8x8rPGc8IWB04vph+RLXSzK1rdyjDADU/
        k6GuOGiRgbNHfd5x28KeuV8KFl/SHJFXuZzBhmzYRvQkmdJ2daRU
X-Google-Smtp-Source: ABdhPJyaxBX5qmWNqwkhzbpKp+WMAHhy4vpKIamhdHRVwVIHrn2zttErrxdKBtBpFOJxnudiPVoBBHJeXmUz9w5GZQc=
X-Received: by 2002:ac2:4e68:: with SMTP id y8mr8229584lfs.527.1630104641550;
 Fri, 27 Aug 2021 15:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <e80fcfa932cca394c5c8b349cafadb0754a594dd.1629842085.git.gitgitgadget@gmail.com>
 <CAHd-oW7D1jikE5ByS36AjACfSJoZeekLCKzX2MRRfayKwKv=qQ@mail.gmail.com>
In-Reply-To: <CAHd-oW7D1jikE5ByS36AjACfSJoZeekLCKzX2MRRfayKwKv=qQ@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 27 Aug 2021 19:50:30 -0300
Message-ID: <CAHd-oW5uzek9Ewdw+jXdw6L9WiwC-xz3O3tRr38HRruB8puDkg@mail.gmail.com>
Subject: Re: [PATCH 05/13] add: fail when adding an untracked sparse file
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 27, 2021 at 6:06 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> While I was playing with this patch, I did the following:
>
> echo a >a
> echo b >b
> git add .
> git commit -m files
> git sparse-checkout set a
> echo c >c
> git add c
>
> And the last `git add` was successful in adding the untracked `c` file
> which is outside the sparse checkout. I'm not sure if I'm doing
> something wrong, but it seems that `path_in_sparse_checkout()` returns
> UNDECIDED for `c`. Is it because there was no pattern in the list
> explicitly excluding it? And if so, should we consider UNDECIDED as
> NOT_MATCHED for `path_in_sparse_checkout()`?

Please disconsider this, It was my fault indeed. I had applied the
patches onto the wrong base. Now I fetched them again but from the GGG
tag, and my manual test worked as expected.
