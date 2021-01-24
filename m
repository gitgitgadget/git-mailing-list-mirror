Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C46C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 07:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B18C222CB3
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 07:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbhAXHvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 02:51:49 -0500
Received: from mail-ej1-f53.google.com ([209.85.218.53]:41084 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbhAXHvr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 02:51:47 -0500
Received: by mail-ej1-f53.google.com with SMTP id g12so13546171ejf.8
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 23:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cyai1kWYIPCQnns4Qxuzry3fqwHzJxWEiWfBL2X3nDw=;
        b=ZRQfKHa35md4ViJZMJBVFBepcgGDb5q3DkJRIDxo/Jz2x6yRsKSQfge3NW9p0zLaq2
         mk/rFQpZ6EQDdZDVi19+gIedaDZ7OANQVLqSHEGZc1SLqCoCk6ylsin7dX49332NqfHp
         EiEl0Nn4oDdpjNfdboaV5aA+VT0BFqjhTyKYcxOCGTUserqPN+brvVvovL/H5yX/9Gt7
         KOuVj7dJF5g1cZ8pcMpWTEZq6vRy+9I6n731nrwSIc0mSxz9wtyzz9gnQY18rmF/wAEu
         W8HgEiOV8nv/FWmlZMGazm1BDvdXqDAdiA9/X5QHpYPm2O9kOR0fYsPN/smJFKjPgIfX
         41vw==
X-Gm-Message-State: AOAM532U1zZ9lxMTwGMzzyJ4ZHXTr9FV9efZCivVQYu4mb7aCDOrbQZa
        u/eWjPoUy7+D+9CgfWCD56FoFCjA6Z64VOkRx2fjzhH2zeE=
X-Google-Smtp-Source: ABdhPJy3EgREJPlyc6+g5YzKhyKSo8/sfOC7di35lqAA28/e8h6IDPyd9ahdCs/JTj5vYwV2CZzEfxw+E9NJdfaamqI=
X-Received: by 2002:a17:906:1c0a:: with SMTP id k10mr288935ejg.138.1611474666293;
 Sat, 23 Jan 2021 23:51:06 -0800 (PST)
MIME-Version: 1.0
References: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
 <20210119212739.77882-1-rafaeloliveira.cs@gmail.com> <20210119212739.77882-5-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20210119212739.77882-5-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 24 Jan 2021 02:50:55 -0500
Message-ID: <CAPig+cQobybm7mddLws5v3F9A+uy2b5gV=UB10KG=iQAhFcBAA@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] t2402: ensure locked worktree is properly cleaned up
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 4:28 PM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> In c57b3367be (worktree: teach `list` to annotate locked worktree,
> 2020-10-11) introduced a new test to ensure locked worktrees are listed
> with "locked" annotation. However, the test does not clean up after
> itself as "git worktree prune" is not going to remove the locked worktree
> in the first place. This not only leaves the test in an unclean state it
> also potentially breaks following tests that relies on the
> "git worktree list" output.

A couple grammos:

1) Drop "In" from the start of the first sentence.
2) s/relies/rely/

But please do not re-roll just for this. It's good enough as-is.

The patch itself is fine.

> Let's fix that by unlocking the worktree before the "prune" command.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
