Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23448C433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 19:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245056AbiEaTIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 15:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiEaTIu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 15:08:50 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE55C8A32E
        for <git@vger.kernel.org>; Tue, 31 May 2022 12:08:49 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-300312ba5e2so151102877b3.0
        for <git@vger.kernel.org>; Tue, 31 May 2022 12:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=4lqtVpLedsxV95pBJA4yE7BnBY3BpYC1ZG80KuX8aRg=;
        b=o1wsWFvkfsuETAK5zMi6yRQ7jsb/SNNMlvAg7l/oxhA1StNGsJvBNTetqQONlm8zxI
         jtA6K41oAzW9CF9aHQSVEgB6Fqc+kqZZlSZ2hsueSv+n7LPJHooD6ZpkOLtyEeA4aT+q
         Ii6X9erjl1YSpc9AcrWqZCymdr18prMyZY+/yZyVJrw+sEBMrc5Agok39pvoAAd3UVhZ
         sF7ZSojOW383UwNRee9qtW0TE9QtnngcYDp0cLMOfd6ST7XbZRoW+p9r06Y8hnQsDhPZ
         crj2jY84nAzo1IA1BKEGBG0KW87cJoWPzcqW2jmMoa8FFDWu7dO6hr8b/w9ahtCgD2mu
         DZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4lqtVpLedsxV95pBJA4yE7BnBY3BpYC1ZG80KuX8aRg=;
        b=uPDyzqMTWEt4q/r8OmpV8r8HiS236ThxJFxmBs1GXe/LuXcAlwzpJhrLzWDvuYo18a
         DoQNCfaNaKJRtJcOp+S8e5odawQ4zR/OjdbFiE0SNEQ5TG/gdGjLfpWGJkWD0eR2Cr5f
         VviILIOEPyX7LHYWeHjKifrKinOIR2RXJ7OlmtEpIARAmnSiYP+RoB6eBUfwUDwqMte4
         ZBkF1vHna6nPZ4wMIVYJy64gU/AtiMHXaiqjG1n09dvQnDFn5/A8okVeD2uaSGtZES7s
         SwFNPhQVKX9MWYv5G7Q7ZfvBPv0uPvICLrOxn05R6EQ/R2bqbbeKgqKkROZ1whCGvtlZ
         EcPQ==
X-Gm-Message-State: AOAM531oDX/SdbPvYlzJ2eZPW7mid0v0ioNuEAYY8y5ZNv70OuNRbBiH
        seGYKuAkbipsCCN39KiVKegNFWw2ohZjTm0Jyu9zlAjnnXs=
X-Google-Smtp-Source: ABdhPJzLlfcmzPOY5H9AZT4EEndN0HgHY1n9+fr5IyccK0PsdWJg0C9TT4sirRvcNry80PefgFqnswFjvlAYqo4kfWA=
X-Received: by 2002:a81:1317:0:b0:30c:44fb:8839 with SMTP id
 23-20020a811317000000b0030c44fb8839mr13936295ywt.247.1654024129086; Tue, 31
 May 2022 12:08:49 -0700 (PDT)
MIME-Version: 1.0
From:   Benedek Kozma <cyberbeni@gmail.com>
Date:   Tue, 31 May 2022 21:08:38 +0200
Message-ID: <CAN8jHOhn+tNn2cR7X_fPyyLF-ADiScD2gymKY9H2ZFb+UdkJSw@mail.gmail.com>
Subject: Bug: fsmonitor--daemon doesn't pick up submodule changes
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
git status
cd submodule
git checkout origin/HEAD
cd ..
git status

What did you expect to happen? (Expected behavior)
the second git status showing that a submodule changed

What happened instead? (Actual behavior)
second git status also shows up to date

What's different between what you expected and what actually happened?

Anything else you want to add:
I have core.fsmonitor set to true in ~/.gitconfig
If I run `git status` with git version 2.32.1 then 2.36.1 will also
correctly report the submodule as changed after the next git status
(because I don't have an fsmonitor script named true, using git 2.32.1
will reset my cache)

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.36.1
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 21.5.0 Darwin Kernel Version 21.5.0: Tue Apr 26 21:08:37
PDT 2022; root:xnu-8020.121.3~4/RELEASE_ARM64_T6000 arm64
compiler info: clang: 13.1.6 (clang-1316.0.21.2)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
pre-commit
