Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79B3C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4DD61003
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhDTNYY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhDTNYX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 09:24:23 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD23C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:23:51 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id r20so43492437ljk.4
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zjFSWm0wXxnOE338MRRe/xURKKHU32aYJJ7+RIZ1Vo=;
        b=m+dbxjcpFhHbeHiqDY5DVve+V8MFp5xALC/Ozgw581ciQXQgRR3OW07mP3yb++Pm5y
         F2xM8V8tklspXpUEjROeMvFZNn8OGuCxLMbK7+l9U4lF5gmkWhVyXH9wGeFGxQYLIw9N
         xnf4f+4sLFIoFsBXBeQH89Nl33TdZaSiB/cMnVddQaL9pp6m2WIYog52w7XrSlAw1MzA
         +qKybKwLGrTPT659pCAW2FepyhNRTR5jt3HC81rPpS1iAQMrGBDbyl3NhE2PO4aaGSxJ
         s+Mto9FXRPWY0CApckLnIchc3EMcv6b5c3qNUxuFI6SpGwcW6RKnxK9+c4sabbHSaCHz
         FdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zjFSWm0wXxnOE338MRRe/xURKKHU32aYJJ7+RIZ1Vo=;
        b=V2IFiTYCoAnfZzYB2KQYYhRO8uK5j64PZKDAoYn7JDLC1Uf0B9ClSjq/wh15ZIaLKv
         eRirv+53AoxweLvkFehMlIO7ywZ+SIKbl2jtacABF5/f07s70xM8uBsMvb2u4oLXYpys
         RLaMIGL/zZM7dMAAeGcYkDLky2pvf94sYw5J0jsxb79e+nY2sdwz1Gxhj1IenbQTCHdt
         /hJihaO/693t2A/xSYF1CZqtFD04uqJY+HjIlVxmPSUWjTQgUMkfXUZwTRXgEO8AlGbg
         pPvuS0BS1JQK5wPUEIkTdw21FVarlOOMcmOO8b45uHYsshcaXoUrXziypLktSPT94zhN
         ta7w==
X-Gm-Message-State: AOAM5303WD0mHJUquJ8qOyOlVuWgA7AGT4p3Ko5giWtX0bYPp04SFDU4
        cjheNGkQUsL1rujiPbDu551FFE+laaRbuP1JfY7X4A==
X-Google-Smtp-Source: ABdhPJyCeyyN7JTevr99w9ruYtdr1albLAIi9qvtqr9SeM3XBzZv2Ekpb+KjxDcAbanQ9o2WWudbKepR4BrSvxfWroA=
X-Received: by 2002:a2e:b175:: with SMTP id a21mr15086289ljm.248.1618925029596;
 Tue, 20 Apr 2021 06:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqtuo17t6t.fsf@gitster.g>
In-Reply-To: <xmqqtuo17t6t.fsf@gitster.g>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 20 Apr 2021 10:23:38 -0300
Message-ID: <CAHd-oW7n-wc+TBYjZ1sh6tPc18mB2pXyBh5L382rG72+0RGafw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2021, #05; Mon, 19)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Junio

On Mon, Apr 19, 2021 at 8:25 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * mt/add-rm-in-sparse-checkout (2021-04-08) 7 commits
>  - rm: honor sparse checkout patterns
>  - add: warn when asked to update SKIP_WORKTREE entries
>  - refresh_index(): add flag to ignore SKIP_WORKTREE entries
>  - pathspec: allow to ignore SKIP_WORKTREE entries on index matching
>  - add: make --chmod and --renormalize honor sparse checkouts
>  - t3705: add tests for `git add` in sparse checkouts
>  - add: include magic part of pathspec on --refresh error
>
>  "git add" and "git rm" learned not to touch those paths that are
>  outside of sparse checkout.

Oops, sorry I ended up not replying to your recent message [1] about
whether or not this was ready for 'next'. But yeah, I don't have any
pending changes planned; I think it's ready :) Elijah also signaled he
is OK with the current version [2].

[1]: https://lore.kernel.org/git/xmqqzgxxkj8v.fsf@gitster.g/
[2]: https://lore.kernel.org/git/CABPp-BE=KfQTj0ad3uBS90MA1EDkHFV8kXi7xbEMDcnoi-MiOg@mail.gmail.com/
