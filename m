Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4553C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 20:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343819AbhK3UxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 15:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343817AbhK3Uwl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 15:52:41 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBA4C061759
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 12:49:13 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id m25so21554209qtq.13
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 12:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=hmF6z2gYxx51jXgfLX/tIiU9WlU77rqH8aUAjjOS/Eg=;
        b=gXD4guyTcgNUD6thI/XCQLLN2dN9VKAkk2o0G4/PY5OLrHGno6heeZDwsH8UYsIDvI
         eta93Xv3bWmw71cwlEvj8XXfdRhvXwzgoQ1smJPjsICmw2BKVo6xr2hplok8A8dPeBaD
         IgmKBTwUgE8Nr8nwD9BbAc7XdxQSyu3gnIpG/1Jdr1L/aPLmQFoxbKHWpOh+JejGFpF3
         QLfsDwwDEL1SticMuZZbRd3soulkK/W6ImqfciGVe3hSsRE/KmTdYQlNaoI3NNvfbH69
         7yIogXoXcjFckgSHWvuIb0T4/IjR9m7xlMiUYuh2yx+efT5ZEPrgyYPf//qUX8yymZxU
         3fXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hmF6z2gYxx51jXgfLX/tIiU9WlU77rqH8aUAjjOS/Eg=;
        b=mlP94qQXgaOSzUIurAcxU1ARUkqk2ZsGybVU3NwseUBkL1uOw0FM8Y+ND+ScpTbFdL
         a1maCJXX61vcbK+Bn0WEs14HtmdgeHFOkQSk/5k7aKQrZNLdciWlLiIaL8mti7QEgnBO
         6W3TMtXGCoJxkneZX6JrgFlTXi8o1SiZdBdCDn0LOlPv0IXdkFrjYKncxzoGNOjVdgtO
         /1FChOtksWm7AtrGr/eH5TNRFeSaA2vJKJFlJBmH92hwujI4jom0p3Nagr2wI5FaYaRP
         bej6VW5SwvUgfOy+hwXwbH7OEFHYn/Pkw0zMk7Ufdy7J7WS2yjIAVaziLzwauqIGJKZ2
         MdIw==
X-Gm-Message-State: AOAM532Dfck+J0KIE8ckrzTAjn84o7Svljuk/lAjz/papgttYr6kxUbs
        osOKtwQ+XinNs/DTYkXpbHtu/JCcIkJLbbcZ+K1NYJ5O5+o=
X-Google-Smtp-Source: ABdhPJyjGJFX1EAvZn1Je+buAVN+brp51RcRMd8UAR7R7cHf88JFUeGGggEuFnVFHWPlkXSid5Tapgm7C5QCoKyOyYY=
X-Received: by 2002:ac8:5c8f:: with SMTP id r15mr2082821qta.465.1638305352527;
 Tue, 30 Nov 2021 12:49:12 -0800 (PST)
MIME-Version: 1.0
From:   Noel Yap <noel.yap@gmail.com>
Date:   Tue, 30 Nov 2021 12:48:46 -0800
Message-ID: <CALa_nQ=Q1h9b_BZcg9AeJurLeRpGrpUFuyoMz-DYKB3bgFJj4Q@mail.gmail.com>
Subject: `git diff` after `git checkout from-branch -- files` reports nothing
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

`git checkout -b to-branch; git checkout from-branch -- filenames; git
status; git diff`

What did you expect to happen? (Expected behavior)

`git status` expected to show updated files and `git diff` expected to
show file changes.

What happened instead? (Actual behavior)

`git status` showed updated files but `git diff` showed no file changes.

What's different between what you expected and what actually happened?

`git diff` was expected to show file changes but it showed nothing instead.

Anything else you want to add:

If I `git reset -q HEAD -- filenames`, `git diff` starts showing file changes.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.11.0-36-generic #40~20.04.1-Ubuntu SMP Sat Sep 18
02:14:19 UTC 2021 x86_64
compiler info: gnuc: 9.3
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
applypatch-msg
commit-msg
post-applypatch
post-checkout
post-commit
post-merge
post-receive
post-rewrite
post-update
pre-applypatch
pre-auto-gc
pre-commit
pre-merge-commit
pre-push
pre-rebase
pre-receive
prepare-commit-msg
push-to-checkout
sendemail-validate
update
