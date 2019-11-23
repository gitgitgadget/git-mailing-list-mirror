Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB2DC432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 19:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1922206D4
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 19:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPYMkaaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKWT4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 14:56:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56260 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfKWT4o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 14:56:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so11062568wmb.5
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 11:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=YuwrxYZ8TgIaFe4NKVRQDW25zk0Wlr39Dh3nEA1XUKU=;
        b=rPYMkaaSWu88dfceJwdfMgQ51Irwn40FQOwIjaa67r7xsF4PEVI6F8A2JlaNvOQ53S
         hYCA3jPat9WihApHNKuexqz7mA+KJte9iqN4/dQHvNwT69XvNuUKpXjVHoZHioUuUkfD
         JfAw75FHaF+llraMknSrtxv+c6X+NLqCOEYrEgebaplGZtCUEjTzrUweynM3OjbP5HC6
         CIPyGgbvtmOzSJdejxgLvtsDz9s1AUncy9HWApY8pFCsAaVYsL0hHqjIBt4uAaPPvNYo
         1j4dvQIZfIpvI2aklEohZ/oECTDZ0JW5FA9+sj4pcJKNnBD8s5/Kwk0lD0uSiHbrvjgL
         wEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YuwrxYZ8TgIaFe4NKVRQDW25zk0Wlr39Dh3nEA1XUKU=;
        b=MRVLLghGs2dEr7SToO5tZLN0dcchtR9UszM78QwYjvHaSJdCwx/5oh6GKRrPBZwApn
         zSiE4bkR9zCsnQZhZTeOZ3IhEqkqmKBpmyUsBjbYwZjk5kqh6vI88wTa9f4Iomyc1JzV
         zXP9FCgQpVRFUN3U1wmhstFj+hcIoO+JfGbJSizL23lg2KmNaCuDfNmfWlLZrETIFY6x
         Rbu5kyIR52IQejkzCRm/U34K/f8LMcyTzxq+trUIC11vgnCvjtUXqU279oXPBDWRhPnd
         J//6RgQgv5L0rGynROelgmqOIsSH9u0sl836FK1hvRNE9R+VJAJw6jHesAUC6CoRRhD9
         b28g==
X-Gm-Message-State: APjAAAU5cjd/vmNCNNIPy4JtvjdowEgYYWtGD6THlYhg5l5KcHDwFqbA
        ffGwZW2zgROydPYeFjlK6AJp5JWL
X-Google-Smtp-Source: APXvYqyRdrvD978MYxqFYeuYyudUPlObFl9oV5W7n+u569rpW7OvOq4N1VVgIvdh1ng922AtW6fAHg==
X-Received: by 2002:a1c:7507:: with SMTP id o7mr21518624wmc.163.1574539002237;
        Sat, 23 Nov 2019 11:56:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w188sm3073120wmg.32.2019.11.23.11.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2019 11:56:41 -0800 (PST)
Message-Id: <pull.475.git.1574539001.gitgitgadget@gmail.com>
From:   "Nika Layzell via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Nov 2019 19:56:39 +0000
Subject: [PATCH 0/1] add--interactive: skip index refresh in reset patch mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nika Layzell <nika@thelayzells.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The refresh command is called from git-add--interactive to ensure that git's
view of the worktree is up-to-date. This is necessary for most commands
which use git-add--interactive, as they are interacting with the worktree,
however it's not necessary for git-reset, which exclusively operates on the
index. This patch skips the refresh call when performing a git-reset -p,
which can improve performance on large repositories which have out-of-date,
or no, caches of the current worktree state.

I chose to use the existing FILTER property of the flavour to make this
decision. A separate REFRESH property could be added instead.

Nika Layzell (1):
  add--interactive: skip index refresh in reset patch mode

 git-add--interactive.perl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-475%2Fmystor%2Findex-only-refresh-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-475/mystor/index-only-refresh-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/475
-- 
gitgitgadget
