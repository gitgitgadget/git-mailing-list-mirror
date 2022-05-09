Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73E6C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 23:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbiEIXgi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 19:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiEIXgh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 19:36:37 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31DB3121B
        for <git@vger.kernel.org>; Mon,  9 May 2022 16:32:42 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id f15-20020a63380f000000b003c6c6e053beso2034980pga.18
        for <git@vger.kernel.org>; Mon, 09 May 2022 16:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=QTKJGuKrHKV9Tw+rerm8/z7d465LnAx1ipaBPhBeg8w=;
        b=X/qDZAD+e96Ml9T++wkvxHRb9XdZgPdqppAdwCe5bBA4J+X8S56bJ5bl7o+VITcLR8
         o/TTQp5JvpeZJDuMytY9PFjcjz65e2LK/frh+fNvfnMi+/Jtq0mbNGVDoY2ERh3i02hZ
         lLYcMrl8MDntECRY9RfOsIeNnajWYtdCG284I7gV9nq501IZyeCPYjtmpW7vQMdWYVLY
         NW6wrEI/y33EVVdQaVSC+Tw2vZLFqxxae+K6W9HFkkSjgC4ntXB2VQvBjEybtwvpFinU
         tC3BOySnXg8ZB98kOA/wdrsNS31vQdXHBJGZBEw+yq4jkcVqBjn2UesfgMR1CfeWwmk6
         I2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=QTKJGuKrHKV9Tw+rerm8/z7d465LnAx1ipaBPhBeg8w=;
        b=adHNMh/aRor5/J20j6mHxirShpTY2GJvY9VhB5LPrYUsro15u015HBjBYYST63nGOH
         XUu1gyDC3roLuyuC9YyhMpcw4UmwSXZrVifYJBKkixVN+BWMkR9ioit0iu140qDe98JP
         f4ZzN3GxGvXlf/TMNqOC2EpzRhy4zb+plvw54BJLkLOksYszrSV7BXSDCqTgCzwffXJX
         uyKNEMZ7P5INZnUX2UXWxaC+2+722UPqUnsXBtDxkCkvlJVYcMTAo+XS7Yz+/zFy1dBO
         E3lIuExXAmPTfBwNEJ1a/Qd2Sq6iuAQigAtZWqWceWfIEix9ZtJphFwH9XqthRygNluq
         QAoA==
X-Gm-Message-State: AOAM5309kxkJQmU9yObJDVtfiEuc7dc73f5QKQc3dIcjafHkLQNAuu5p
        QoOsYgcyzcTlTS20JnbHlOjiTgCadYStcw==
X-Google-Smtp-Source: ABdhPJwqWJLGqZ7bVPj40NNfMejfIhS9suOPX54pWgUesJ21cxFHdAKODwVORXZE4HdiRgAEnB/+m40dXoe2Yg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:9041:0:b0:3aa:f1aa:bb68 with SMTP id
 a62-20020a639041000000b003aaf1aabb68mr14822468pge.27.1652139162180; Mon, 09
 May 2022 16:32:42 -0700 (PDT)
Date:   Mon, 09 May 2022 16:32:31 -0700
In-Reply-To: <CAFnZ=JNE_Sa3TsKghBPj1d0cz3kc6o91Ogj-op8o6qK8t9hPgg@mail.gmail.com>
Message-Id: <kl6l5yme8epc.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <CAFnZ=JNE_Sa3TsKghBPj1d0cz3kc6o91Ogj-op8o6qK8t9hPgg@mail.gmail.com>
Subject: Re: Bug Report: fetch.recurseSubmodules doesn't affect git pull as
 otherwise stated in the git config docs
From:   Glen Choo <chooglen@google.com>
To:     Huang Zou <huang.zou@schrodinger.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Huang Zou <huang.zou@schrodinger.com> writes:

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> 1) Set the following configs:
>  git config submodule.recurse true
>  git config fetch.recurseSubmodules false
> 2) On a repo with submodules, run:
> git pull
>
> What did you expect to happen? (Expected behavior)
> git pull doesn't recursively fetch submodules
>
> What happened instead? (Actual behavior)
> Submodules are fetched recursively
>
> What's different between what you expected and what actually happened?
> Submodules are fetched recursively
>
> Anything else you want to add:
> git fetch works as intended. The documentation for fetch.recurseSubmodules
> states that "This option controls whether git fetch (and the underlying
> fetch in git pull)" so I would naturally expect git pull to behave the same
> as git fetch
>
>
>
> [System Info]
> git version:
> git version 2.36.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Darwin 19.6.0 Darwin Kernel Version 19.6.0: Tue Aug 24 20:28:00 PDT
> 2021; root:xnu-6153.141.40~1/RELEASE_X86_64 x86_64
> compiler info: clang: 12.0.0 (clang-1200.0.32.29)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /usr/local/bin/bash
>
>
> [Enabled Hooks]
> pre-commit
>
> Thanks,
> Huang

I've sent a fix at [1] :) I intended for the patch to be sent in reply
to this thread, but I clearly don't know how to use GitGitGadget
correctly. Whoops

[1] https://lore.kernel.org/git/pull.1262.git.git.1652138854255.gitgitgadget@gmail.com/
