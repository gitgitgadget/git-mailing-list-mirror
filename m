Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68E1C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjDAPuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjDAPum (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:50:42 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8807E1EFC4
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:50:40 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-17aceccdcf6so26292795fac.9
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680364239;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mYcUCB3e+jdIKavlfWKX5ftTzT7hK9uIJhVZbO6emNM=;
        b=l0sM2WzUM9XaYcraKfgGS2stcjnTJXmDTp2GcNltXzJbfgnBGtSr760DapVY6dAuBS
         eRuAFydxTm4zDg5byz6M6AI7H+P8ZJYj+eUKfFlOc3bIiJNgM0eAqsrxvfeuI8shtUlf
         ELqbcNpA5Qar+f+DRoCUeuMSyQhXcSe0Wohtvo8/pswOm0TgPUd158sDJTxXxgu+UuHZ
         09fjOGTec7PTJ5pbmD9uzZCs2CqMdahqGSqssIRSRJ755j1mgGYbujTe6C6FiVnyXSyA
         wf9mRZPSHcBz6aMLvEEYYric8DYhyfrChnf07KzKUE1fUVGVo5PwZV8spPuhhyBduJEs
         QPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680364239;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mYcUCB3e+jdIKavlfWKX5ftTzT7hK9uIJhVZbO6emNM=;
        b=0zA6kdy1ubcjvQohhFnFiovAtcEvcFatslH/Znw0qfpzMnhdVTv9Yc76j5d6nOoqaf
         3umTd0ZIBFszq5FbA7z9JNEnKiBOUH1S5zWa3ZKfunXwm9j88sinuj/fQtO++1W1+82X
         kOaYz9iwbn2VwM+Qsl/wdNlKUWeD2GaU1kJoGWL77ab5yqi3pcvQkZKm1h/JOx6Pm1Ot
         0V/+/82qzW9IOpJiqL6g+e6uExHouet+qJn5UjandgZcphNcCvxYD4kGZz4+hG83aelZ
         eHN9ALU1BGto3LcE0WpbMMJ+IMVFtv/pMGaWvp3mZVC4YjDtUOakcxNA4aiAeekFzNqw
         p7Iw==
X-Gm-Message-State: AAQBX9cPoiYYso2cMFePJkTL8/5ZygVxbG5ij9MoiJN4HTEfeX+931Xl
        fdWEq4RihJSLWwrfJolzOV7Ah7xnQMrb2khyn2JIQioICtk=
X-Google-Smtp-Source: AKy350YcEENOh/Eqz8xcMrlY3XCMfmy1GUVDhfEUWw8hcfKzt77Cd4/T2bThLaHSNbAT/W9XNgFjF18RYTToqsXiUxE=
X-Received: by 2002:a05:6870:738c:b0:180:5b56:87d2 with SMTP id
 z12-20020a056870738c00b001805b5687d2mr1058615oam.1.1680364239565; Sat, 01 Apr
 2023 08:50:39 -0700 (PDT)
MIME-Version: 1.0
From:   Matt Gardner <four712@gmail.com>
Date:   Sat, 1 Apr 2023 11:50:28 -0400
Message-ID: <CA+MNPvgceR3s30LaCS716NGw+8S47CQZTqFno=vE2XAuiBA7Kw@mail.gmail.com>
Subject: macOS git grep change in required character classes
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!

Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

$ mkdir git-grep-test
$ cd git-grep-test
$ git init
$ echo "sub test { return; }" > test.pl
$ git grep --untracked -E \\btest\\b

What did you expect to happen? (Expected behavior)

It should find the results like the following:

test.pl:sub test { return; }

What happened instead? (Actual behavior)

No results found

What's different between what you expected and what actually happened?

To get results, you have to use BSD style character classes:

$ git grep --untracked -E \[\[:\<:\]\]test\[\[:\>:\]\]

test.pl:sub test { return; }

Anything else you want to add:

Testing in both git 2.24 and 2.34 (the only other version I have
access to at the moment), \\b and other GNU style character classes
return results.

My best guess is that
https://github.com/git/git/commit/1819ad327b7a1f19540a819813b70a0e8a7f798f
is causing git grep -E to require BSD style regular expression
character classes.  I don't know if this is a bug or an unadvertised
change in behavior.  In either case, it is frustrating.  Any person or
tool would have to know which version of git they have and which
operating system they are on to get results.

Please review the rest of the bug report below.

You can delete any lines you don't wish to share.
[System Info]
git version:
git version 2.40.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 19.6.0 Darwin Kernel Version 19.6.0: Tue Jun 21 21:18:39
PDT 2022; root:xnu-6153.141.66~1/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.0 (clang-1200.0.32.29)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
