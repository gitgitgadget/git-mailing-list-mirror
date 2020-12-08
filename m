Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8C8C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB9A23A3B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgLHA6Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgLHA6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:58:25 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6E8C061793
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:57:44 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id x6so10647940wro.11
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TUvxLb/bLQq8+pQ2S6Y0d9bCja5vNnDdfitNXQqu3do=;
        b=ht+LvGSwtczUDlW7fGodzsCiVjCymCDbk8Nbua0nIlhL5i7f7vaD/zIu8uSaBb1NXT
         YvRMlnC2FnrdohP/x3XtYRzQG2OnjmphU6eMVt5zxB2pGxh+oJa5RCZpbFQaAiJlAWdl
         ztTQ9alZg2W4UNQacKPYnj+fhyr8rsze4zJfbF4AYtTg+ouHBQBNfko2JHYC/GzWqmyW
         RcUbAbusppYaUH/fQNzZkPIAwr1qbJk5En+rALVEfKqWDOA19RX79SF3YI0Ktf1zE+3u
         cHAiuoVthDDsyT/7WtOQijDKdKJ6tonUSpWch7ZF67KzOdrBeRnJyPlJn8zqgQBNFxJ+
         jPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TUvxLb/bLQq8+pQ2S6Y0d9bCja5vNnDdfitNXQqu3do=;
        b=HYq4ohth1Q9E2W8MUKUYbggX23lGAjVhTsclWJltC/sd+l046z86JmbJMOsPtEUAC+
         BJYUpfMz9tr2MpIjv9Pq5DDlrt/ei0eY2G+z2wt/I7eSzICcfGQRXOqjOxlOxWXgMskQ
         RCCNxt8YsszkLcSjEop8X4CVkS+2WCBLn6z9qIp4fD1LADYWhNZEWOe2AqLJMQ0TsEwx
         nIIE2SpyauL36tSp14v4TDBkS2WUlKXNPI3qsTK4a+KfwsbTckMqTgk6CVAt1Om6kuC7
         lLSXNnVcVdPnZXFYE+VKKPlX7eOwKsrRQ3unKnj+hbqhRdNe3y8i7ZOW/g335YQmTtd+
         uMHQ==
X-Gm-Message-State: AOAM533JFFBFGJnUcxUNwssavApJy01Psx7dYPHYmm+Ob8hT3IY6h5qx
        u22YnrYoQ457Gn5uVOjsDswDPo4lsbiae9Fp/CXoyrDG3J7HVFkk
X-Google-Smtp-Source: ABdhPJwTWWF9ign2QDwgIxfCyLc9LE1Bn8FCFlFkgLqHzAsLvaCGuxHJ3GOnZW8ryq8MhK2QEVo93NZypUzH2RnseoE=
X-Received: by 2002:a5d:68c9:: with SMTP id p9mr14937741wrw.139.1607389063359;
 Mon, 07 Dec 2020 16:57:43 -0800 (PST)
MIME-Version: 1.0
References: <20201208002648.1370414-1-felipe.contreras@gmail.com>
In-Reply-To: <20201208002648.1370414-1-felipe.contreras@gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 7 Dec 2020 18:57:32 -0600
Message-ID: <CAMP44s2hUCd9qc83LReGyjy8N+u++eK6VjwGhDhrX0f0SbKmig@mail.gmail.com>
Subject: Re: [PATCH v4 00/19] pull: default ff-only mode
To:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio, this is intended for you, I will describe step by step how the
warning evolves.

Step 0: This is what we have today:

  Pulling without specifying how to reconcile divergent branches is
  discouraged. You can squelch this message by running one of the following
  commands sometime before your next pull:

    git config pull.rebase false  # merge (the default strategy)
    git config pull.rebase true   # rebase
    git config pull.ff only       # fast-forward only

  You can replace "git config" with "git config --global" to set a default
  preference for all repositories. You can also pass --rebase, --no-rebase,
  or --ff-only on the command line to override the configured default per
  invocation.

> Felipe Contreras (19):
>   doc: pull: explain what is a fast-forward
>   pull: improve default warning

Step 1: This is low-hanging fruit that can be fixed today without any
change in behavior:

  Pulling without specifying how to reconcile divergent branches is discouraged;
  you need to specify if you want a merge, or a rebase.
  You can squelch this message by running one of the following commands:

    git config pull.rebase false  # merge (the default strategy)
    git config pull.rebase true   # rebase
    git config pull.ff only       # fast-forward only

  You can replace "git config" with "git config --global" to set a default
  preference for all repositories.
  If unsure, run "git pull --no-rebase".
  Read "git pull --help" for more information.

>   pull: refactor fast-forward check
>   pull: cleanup autostash check
>   pull: trivial cleanup
>   pull: move default warning
>   pull: display default warning only when non-ff

At this point we can update the warning to mention that we are inside
a non-fast-forward case. But it's not necessary.

>   pull: trivial whitespace style fix
>   pull: introduce --merge option

s/--no-rebase/--merge/

>   pull: show warning with --ff
>   rebase: add REBASE_DEFAULT
>   pull: move configurations fetches
>   test: merge-pull-config: trivial cleanup
>   test: pull-options: revert unnecessary changes
>   pull: trivial memory fix

This is the end of part I. At this point the default mode is still
"merge", and the only behavior change is that the warning is printed
only on the non-fast-forward case.

========================================================================

>   pull: add pull.mode

Step 2: pull.mode={merge,rebase} are specified

  Pulling without specifying how to reconcile divergent branches is discouraged;
  you need to specify if you want a merge, or a rebase.
  You can squelch this message by running one of the following commands:

    git config pull.mode merge    # (the default strategy)
    git config pull.mode rebase
    git config pull.ff only       # fast-forward only

  You can replace "git config" with "git config --global" to set a default
  preference for all repositories.
  If unsure, run "git pull --merge".
  Read "git pull --help" for more information.

>   pull: add pull.mode=ff-only

Step 3: Now pull.mode=ff-only

  Pulling without specifying how to reconcile divergent branches is discouraged;
  you need to specify if you want a merge, or a rebase.
  You can squelch this message by running one of the following commands:

    git config pull.mode merge    # (the default strategy)
    git config pull.mode rebase
    git config pull.mode ff-only  # fast-forward only

  You can replace "git config" with "git config --global" to set a default
  preference for all repositories.
  If unsure, run "git pull --merge".
  Read "git pull --help" for more information.

However, now in addition to the warning, there's an error message:

  The pull was not fast-forward, please either merge or rebase.

This error message is *only* triggered when the user has manually
configured "pull.mode=ff-only". And it is an error. The program dies.

And it's not meant to be temporary; it's permanent behavior.

>   pull: advice of future changes

Step 4: Now that pull.mode=ff-only is in place, we can aim for it
being the default, and we can tell our users that it will be the
default in the future.

  The pull was not fast-forward, in the future you will have to choose
a merge, or a rebase.

  To quell this message you have two main options:

  1. Adopt the new behavior:

    git config --global pull.mode ff-only

  2. Maintain the current behavior:

    git config --global pull.mode merge

  For now we will fall back to the traditional behavior (merge).
  Read "git pull --help" for more information.

This is the end of part II. At this point the default is still "merge".

Unlike part I, in part II we have committed to pull.mode=ff-only to be
the new default, and we are already telling users that they can use
this new mode to test the new behavior.

We should probably stay a couple of releases at this point, with this
warning, and the new behavior already configurable.

Elijah: notice how there's no mention of `git pull --merge`, because
in my opinion now we are telling users this is a temporary *warning*,
and the way to get rid of it properly should be very clear.

========================================================================

>   future: pull: enable ff-only mode by default

The last patch finally enables the ff-only mode by default, and the
warning is removed forever.

The only thing that remains now is the fatal error:

  The pull was not fast-forward, please either merge or rebase.

This fatal error is avoided by pull.mode=merge, pull.mode=rebase,
pull.rebase=true, pull.rebase=false, pull.rebase=$other, --merge, or
--rebase.

It *only* happens when the user does a vanilla "git pull", it's a
non-fast-forward update, the user has configured pull.mode=ff-only or
has not configured any of the above.

Is it more clear what is my proposal?

Cheers.

-- 
Felipe Contreras
