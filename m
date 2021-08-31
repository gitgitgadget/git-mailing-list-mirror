Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C35C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 08:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB15460F92
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 08:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240261AbhHaI1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 04:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240255AbhHaI1U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 04:27:20 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8BFC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 01:26:24 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q11so26319831wrr.9
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 01:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=8zV7Z4IRtred1RsKbXPkE8EFzLy1m/yYqpqwi9V5vQM=;
        b=vVy4QjUQiJIOBtLiKBMbzMbKBjnTfbJJ35QM3EMmKQ0Bh/nxxA4mwV4r4yEXy6ZgEx
         l9nExbR6zaFWYi0xz/uo/asvsvZkFZGpPGEZQ3nhgpQWRGB3S+cPAskWhPHVTL80RMVX
         ewA/QAkxr7NO9PeueNa0qTHvFyu21nW4NdOseowT4ffhhH7mdpOeuivAESiDOZLvE10m
         uodjpiwjzpdJ/KK7iv0TuH9Fe84nce7RzvLnKZTMHKms3m3OTxzUIPZfF2JE9bXEIGIv
         w9UR2WSNi+OAhUI33t6FpNyVPvVjEDeluVTd6VxDf7YzEb8htGDGxNY2SONk0Q1lVeic
         oQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=8zV7Z4IRtred1RsKbXPkE8EFzLy1m/yYqpqwi9V5vQM=;
        b=jsD/p5OonrkxaMLa/c2Xsv4ejXyze/8PWs1pFBDdRWdQi/WuN8bcP/M6LqxnQKR0HN
         SHS0Zq5ymx4xeLD5c8BVS6+Zrvu0YnlnknhsOBFB1+YApzB1eLP8mfTKtboL35FMzFFr
         TNcOuJePZqJZqWW6UBkq/HSt6Ch0zNp1GgJgN25JrNnaM31rtWYJggdynXKO5Ka9+mFd
         b256YMCVQPr1gubE8w6kTxpoKsJwqMbrone3RhbSUUA4iwgpRoIL0OueHe2KA4M8Pk6p
         mB5uwFKzp0vP5JrohBRvsLgQeCZ3SbI0YphaJeKbIMeKsy1jNRwwZOCSn9CaAD+01cr0
         20TA==
X-Gm-Message-State: AOAM532X3wqRzCYp4ofVysZsdzqg9R6b4NJUa1fj0WKgj80cxNZWeWMq
        urqT8di8TaSEr0DMGw7LimI=
X-Google-Smtp-Source: ABdhPJzBKEAkZ6v5R/UECzsLGP3JQZx97MbxFfJSbYeX+dZ/YTN1e55FRxHGl3lCba1HfUpUZBFwNQ==
X-Received: by 2002:adf:c18a:: with SMTP id x10mr22715184wre.302.1630398383459;
        Tue, 31 Aug 2021 01:26:23 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r26sm1853427wmh.27.2021.08.31.01.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 01:26:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 08/15] scalar: implement the `clone` subcommand
Date:   Tue, 31 Aug 2021 10:23:55 +0200
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
 <2cbf0b611133df5fa7eed1bf38460f9d119d2a6e.1630359290.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <2cbf0b611133df5fa7eed1bf38460f9d119d2a6e.1630359290.git.gitgitgadget@gmail.com>
Message-ID: <87a6kyxbo1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 30 2021, Johannes Schindelin via GitGitGadget wrote:

> This implements Scalar's opinionated `clone` command: it tries to use a
> partial clone and sets up a sparse checkout by default. In contrast to
> `git clone`, `scalar clone` sets up the worktree in the `src/`
> subdirectory, to encourage a separation between the source files and the
> build output (which helps Git tremendously because it avoids untracked
> files that have to be specifically ignored when refreshing the index).

Perhaps nobody else wondered this while reading this, but I thought this
might be some sparse/worktree magic where cloning into "foo" would have
"foo/.git", but the worktree was somehow magically mapped at foo/src/".

But no, it just takes your "scalar clone <url> foo" and translates it to
"foo/src", so you'll get a directory at "foo".

> Note: We intentionally use a slightly wasteful `set_config()` function
> (which does not reuse a single `strbuf`, for example, though performance
> _really_ does not matter here) for convenience and readability.

FWIW I think the commit message could do without this, that part of the
code is obviously not performance sensitive at all. But maybe an
explicit note helps anyway...
