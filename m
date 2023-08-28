Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFE4C83F11
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 12:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjH1MwX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 08:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjH1MwH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 08:52:07 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C20119
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 05:52:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bf1f632b8so427114166b.1
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 05:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693227120; x=1693831920;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n+VcGrApiflvek5LupkfJE2H6Bs188aBnPaK8hu7IoU=;
        b=AnoVKb/o4Gv2xjyFB+Ott6IAj4NwRU9v7gOG9moMHQA1YKhOoato3ZCMTOE+KicRmV
         Y5d3xLEzEpLwl0hzxRhySXjUjaM2eB0e3YfzFHUArFHC0m6kyS+eMkpINHfHvhvc5b4x
         i9wXfaN96X8z3zRL0JTGXqqwjRm5GmxfL78NOVZ/ayu+vUlqfPQqYavqCucjI8PPDYek
         rwR3q9dTZCvgbIeinLyHFnEteCdaIS8e+0TXiGGen48+IHEvqAXQuggiCOIjT2zHyPs3
         i5TXE4pMbFD6diUsCblDl2YnciRQPu1zXfpchhPnOdz/5Klj2ym96NM2czZ2keKGTiKj
         FqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693227120; x=1693831920;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n+VcGrApiflvek5LupkfJE2H6Bs188aBnPaK8hu7IoU=;
        b=AAjPCvwzjrSUhwPjueGFmG+SKUEcNcNGpQdwdOcNwvbpLZY890kddecgjhiSkN7NBE
         wmHiKsieFm9yQicPu0g7YixESj8KOOeZ+vU8EDgkoztTWwb3NLncpJggfSy6JnvACiB1
         EYVk/XT5vE98fRXxFujM4oIoQdLicqe0RrY7qkdzSBIKlN0FmCH+MALQSiRvE+0XFETv
         pCSwye7pjI/45oT1fxX32ZOU8NFYg+J3gQkD/8VSnTuyxtZ8cFEimryCK0/ZvM9SrxyY
         0KVgyvjgKwmlfiYDCBV8vycM18ThArcSz/MietNwmtCDyZnVNbeaZtOgE+N4af2KBP+J
         7lZw==
X-Gm-Message-State: AOJu0YzOQvhnRU3oPTP5JLwKB8n5fly5Q7QIitDOUlhFvqM32AEK5qOZ
        PbmUxV7oyv4ve9D10IIU5SPpdcIMzDjwgzQOL7cr8FSdC7I=
X-Google-Smtp-Source: AGHT+IEYQImc44ZMgOitz1Oft0HG8xLHj/6YmjddNsLoiQHgzyviBTcuLVS9+rw6a0t5qDgDOfQpLORO904NZitUriE=
X-Received: by 2002:a17:907:a04d:b0:9a1:e758:fc6e with SMTP id
 gz13-20020a170907a04d00b009a1e758fc6emr10823209ejc.10.1693227120461; Mon, 28
 Aug 2023 05:52:00 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Dexter_Ponta=C3=B1eles?= <dexterdexter@gmail.com>
Date:   Mon, 28 Aug 2023 14:51:49 +0200
Message-ID: <CAKg1MfiTM3DhZF_He0EjtGUWZkkpMMRQAnbd6ywJ708LWvJkHA@mail.gmail.com>
Subject: Bug report
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
I was trying to merge another branch to my branch but then got
conflicts. After resolving the conflicts, I wanted to continue the
merge operation but a hook was failing. I wanted to bypass this hook
by adding --no-verify flag: git merge --continue --no-verify

What did you expect to happen? (Expected behavior)
I expected the merge operation to continue, bypassing the hook

What happened instead? (Actual behavior)
git command failed with error `fatal: --continue expects no arguments`

What's different between what you expected and what actually happened?
The operation failed instead of proceeding with the git merge operation

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.42.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.6.0 Darwin Kernel Version 22.6.0: Wed Jul  5 22:22:05
PDT 2023; root:xnu-8796.141.3~6/RELEASE_ARM64_T6000 arm64
compiler info: clang: 14.0.3 (clang-1403.0.22.14.1)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
