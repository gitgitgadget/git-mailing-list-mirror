Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49859C636CB
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 17:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3524D613E3
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 17:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhGPSAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 14:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhGPSAn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 14:00:43 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB738C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 10:57:46 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id w191-20020a62ddc80000b0290318fa423788so7509493pff.11
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 10:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pRh1RnFCGDzmM08Gbxp9NcO+yTdXdAwZH58QqQde5jA=;
        b=Ax7gLBABz1a8N/4Ljmr9qY/5xMDTDpLCW/w+IYgN/9HlgYoTsvSjyAmsQXkWEyyw+u
         1uXWgFj/9YkMp0BbilZM4514PzuoPwHgRK3E2YIWVGylNkOIrBoDMSE5AJQeOrZkzkc9
         E69LXEaK4XK84JD2UJ21jKG6VGugERSk/K1jEZKjEoppVBgFXpiObOEYCaxKLzvKhonC
         0rEfkeCgt9eABpVLVRk9mBxW8AvI9bMIt4qo+tyOufuEkSarS+pVXyt0d/XUXS2m1Oo5
         3LctnD83a67tIIQ3zDMC1izQwbVA+xthoeMQcFo8XaHhTwMQ5oMviZXR45zRz0wuO6HH
         L3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pRh1RnFCGDzmM08Gbxp9NcO+yTdXdAwZH58QqQde5jA=;
        b=GSj80mXwhQCDAy7k8daP8UmkXSqAXBmVqlf7Udg//3VITR1pPcKc+PhFSfthE+3HxQ
         HKxfIDFiH4MBHIZcyW4dOE0z6fCNSx+3Ii85mPUItuRSoR9PNGBOEXj7OMNhTXeYwOOK
         waLimbzyinvJxmDWy6kQnth28KOc12khKPtZtXn/mzuAV4rRkVTS2cavCHHsoeo/tBcM
         82BhEQtIbyg+MJ/2ln2LkmaTFdY/7zmhV9PeC9BQDWuQ//UJ6CjCyqzWu9L5A03pkHXO
         xJaWnVQAgj41UvP+LueGvlizfwz3hVd18fUvMd2ApoAmJxXf6fiDHecVz0TB4fC0cfjA
         7U2w==
X-Gm-Message-State: AOAM532anWAXSVzT2jFtVnCTmG6fikMrl8iFzQKE5t0twKLjVoGzs9Cl
        zSDFdYtLbMkbsWRbeTjugEkbhLxYj8E+UB/Fu69sYguKC069Y+i2a7MCkf/9qBB8gUnMQ8Dv7ec
        IZdeES+TrVBlXEslZmE++UEweWoNP3qb0ff9pOajgaSuNTYCMe/PkhGZSmNKoKby7+02NjTdXev
        A4
X-Google-Smtp-Source: ABdhPJzOQcP2pSZYBmSfa2gbSGrNxTkWrY0oyotQovCfXhBOuvP8T3Q4STck7Hq8V1vxwDjUKRS6hGJeBRO2YkeD62M9
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:ccc:b029:334:e26:fd5d with
 SMTP id b12-20020a056a000cccb02903340e26fd5dmr5603854pfv.14.1626458266176;
 Fri, 16 Jul 2021 10:57:46 -0700 (PDT)
Date:   Fri, 16 Jul 2021 10:57:39 -0700
In-Reply-To: <cover.1623881977.git.jonathantanmy@google.com>
Message-Id: <cover.1626453569.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1623881977.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [RFC PATCH v2 0/2] MVP implementation of remote-suggested hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, iankaz@google.com,
        sandals@crustytoothpaste.net, avarab@gmail.com,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's an updated version of the remote-suggested hooks RFC, hopefully
addressing some of the concerns people have brought up (e.g.
auto-updating without letting the user verify, or prompting about hooks
by default). It consists of two main parts:

 - Non-interactive prompts during certain Git commands about the
   existence of hooks. These prompts are turned *off* by default.

 - New "git hook" subcommands that can install these hooks (so that the
   aforementioned Git prompts or out-of-band installation instructions
   can tell users to install these hooks in a platform-independent way).
   These subcommands work whether or not prompts are enabled.

You can see how they work in patch 2's t1361.

In doing this, I have tried to scope down the overall effort as much as
possible (to avoid security risks as much as possible, among other
things), concentrating on situations that server-side hooks cannot
handle. I think the main thing is that server-side hooks can check and
prompt upon push, but they cannot catch problems that the client could
have noticed upon commit; if the end user pushes a commit chain and only
notices problems then, the user would have to redo the commits (possibly
through an interactive rebase on the spot). Catching problems upon
commit would prevent this problem, only necessitating amending the
commit.

In the Gerrit use case, Gerrit requires a specific "Change-Id" trailer
in the commit message, but I can foresee the same issue in projects that
require their commit messages to fit a certain template or projects that
want lints to be run but their builds, for some reason, don't run
arbitrary code (or they have no builds at all).

To that end, I have added a prompt for the "commit-msg" hook if the
remote has suggested one, but there are none currently installed.
(Similar prompts could be added for other commit-related hooks.) The
other prompts are upon clone and upon fetch (if the hooks have been
updated).

Jonathan Tan (2):
  hook: move list of hooks
  hook: remote-suggested hooks

 builtin/bugreport.c               |  38 +-----
 builtin/clone.c                   |  12 ++
 builtin/fetch.c                   |  17 +++
 builtin/hook.c                    |  17 ++-
 hook.c                            | 185 +++++++++++++++++++++++++++++-
 hook.h                            |   6 +
 t/t1361-remote-suggested-hooks.sh | 105 +++++++++++++++++
 7 files changed, 340 insertions(+), 40 deletions(-)
 create mode 100755 t/t1361-remote-suggested-hooks.sh

-- 
2.32.0.402.g57bb445576-goog

