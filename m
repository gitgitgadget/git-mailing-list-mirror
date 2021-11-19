Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164CFC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 10:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1C1861A86
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 10:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhKSKaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 05:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhKSKaC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 05:30:02 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F622C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 02:27:01 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id d64so6235468pgc.7
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 02:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgF5tpvnjrhPODt1ZX7Kmtxhi0i4wjq2FWLzAFRBb1Q=;
        b=LreMDEsimuX5CDlBf4s6MXwJRLRNsNsQE2RLIrSaROZPIr6lC0lwSG8ZU8A8OxyZ6Y
         eVZdUTm5Qr9zSUqCuhF8c2uen9/jvu6yBKoZ0EX+BYFdEgaGJAADFm60s052v+zjTFbU
         ldyuYsjDsXIt0rpxxMbcarQe3r9vScHs4a6Q6VEN+zvWOqJIdLfdyYXWusszC1XF2OCC
         Namr5luWoCHYFnHdn93ISKgKm19s+GX7/MI63+rkpONreHZwThDJxQzmdiVu3RHdsjpZ
         4oyygdpdRLKaCp0cVXqeoGt1oqFdCHtdR7DUdZ7UOUqHpI0CURNhoR0xm94WFvvXEsLS
         xXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgF5tpvnjrhPODt1ZX7Kmtxhi0i4wjq2FWLzAFRBb1Q=;
        b=pqheomyuegMqPX7aPAmcUChuQnLJui1MIjkpoBEgZpj1YQxCi9VErFD72vzH7pMuQ0
         /B7TY2EF6ie+muWAtA6MVHXgEuFM8NguoUjZJUr70vtf+/8G7u9cmimCgoDcNKtf1tgn
         ZkWd3DAuDsWJqmRIjQEKxfX00uRLbQeabIJRR6ILqs8JkiErJLpLPBitIuj0T6WLjqn+
         e9vEM1JGAG6WWtc9XJYvWq9pMWzQFvLDqAOXzpKxHiG+TjjkB9rXMC+7O370WXdClV5Q
         IQNRiybJO7ovCv1rkkObQCV2dM9nlGHiEsVAGPA9XdV3lr4X8Js+cOodJ3pD3d9KWWsH
         /Alg==
X-Gm-Message-State: AOAM532AwbLjki7Ru9ziaL+eYI9vPCsTYQMquqjH9AN0/a4CW26hRYe4
        ZVZThMi8dgi75KGJifbwLAjT6RfXb32nLfXTh/MhwjueTl0=
X-Google-Smtp-Source: ABdhPJwaEzu/6fC8X3jFUeB4ZzwWv/mHLRhTUeWW65mDAkHv1faBVFfPwloWxL30xWfAHSXdwUTibFMO/r+QAkLPgmA=
X-Received: by 2002:a62:1544:0:b0:49f:f74e:8327 with SMTP id
 65-20020a621544000000b0049ff74e8327mr21568990pfv.55.1637317620973; Fri, 19
 Nov 2021 02:27:00 -0800 (PST)
MIME-Version: 1.0
References: <CAMn8hCcFLR-YyLaawtbtjpVUKd45Z4C6t1kWj+-WBZVNtNgozw@mail.gmail.com>
 <20211119090037.m4zfzovaitfj35l3@fs>
In-Reply-To: <20211119090037.m4zfzovaitfj35l3@fs>
From:   Thor Andreas Rognan <thor.rognan@gmail.com>
Date:   Fri, 19 Nov 2021 11:26:44 +0100
Message-ID: <CAMn8hCf1ypU4Bwt8bDgai86QFTdORPyaHiE7W+=tx_rKbchz4w@mail.gmail.com>
Subject: Re: Ambiguous verification response when ssh-based signatures
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Fabian,

Thank you for your quick response! Commands and output below:

$ ssh -V
OpenSSH_8.1p1, LibreSSL 2.7.3

$ GIT_TRACE=1 git commit -m "Trace keygen commands with GIT_TRACE"
11:13:49.771601 git.c:455               trace: built-in: git commit -m
'Trace keygen commands with GIT_TRACE'
11:13:49.776095 run-command.c:668       trace: run_command: ssh-keygen
-Y sign -n git -f
/var/folders/jj/sfgpggbj5b13gvljxf977zq80000gn/T//.git_signing_key_tmp1FkZ52
/var/folders/jj/sfgpggbj5b13gvljxf977zq80000gn/T//.git_signing_buffer_tmpBweN52
11:13:49.814072 run-command.c:668       trace: run_command: git
maintenance run --auto --no-quiet
11:13:49.819952 git.c:455               trace: built-in: git
maintenance run --auto --no-quiet
[main 633e567] Trace keygen commands with GIT_TRACE
 1 file changed, 59 insertions(+)
 create mode 100644 git-bugreport-2021-11-19-0311.txt

$ GIT_TRACE=1 git verify-commit HEAD
11:14:40.274423 git.c:455               trace: built-in: git verify-commit HEAD
11:14:40.277417 run-command.c:668       trace: run_command: ssh-keygen
-Y find-principals -f ~/.config/git/allowed_signers -s
/var/folders/jj/sfgpggbj5b13gvljxf977zq80000gn/T//.git_vtag_tmpEI3SAu
11:14:40.284075 run-command.c:668       trace: run_command: ssh-keygen
-Y check-novalidate -n git -s
/var/folders/jj/sfgpggbj5b13gvljxf977zq80000gn/T//.git_vtag_tmpEI3SAu
Good "git" signature with ED25519 key
SHA256:x3FRAl3XR188M9KR3UE+TuG3jkZzPQMjfBo+ddbM0dk
Too few arguments for sign/verify: missing namespace

Best regards,
Thor

On Fri, 19 Nov 2021 at 10:00, Fabian Stelzer <fs@gigacodes.de> wrote:
>
> On 19.11.2021 03:46, Thor Andreas Rognan wrote:
> >Thank you for filling out a Git bug report!
> >Please answer the following questions to help us understand your issue.
> >
> >What did you do before the bug happened? (Steps to reproduce your issue)
> >
> >$ ssh-keygen -t ed25519 -C "me@example.com"
> >$ mkdir -pv ~/tmp/example && cd ~/tmp/example && git init
> >$ git config commit.gpgsign true
> >$ git config gpg.format ssh
> >$ git config user.signingkey "$(cat ~/.ssh/id_ed25519.pub)"
> >$ mkdir -p ~/.config/git/ && touch ~/.config/git/allowed_signers\
> > && chmod 0600 ~/.config/git/allowed_signers
> >$ cat ~/.ssh/id_ed25519.pub | awk '{print email " " $0}' email=$(git
> >config user.email)\
> > >> ~/.config/git/allowed_signers
> >$ git config gpg.ssh.allowedSignersFile "$HOME/.config/git/allowed_signers"
> >$ git commit --allow-empty -m "Initial commit"
> >$ git verify-commit HEAD
> >
> >What did you expect to happen? (Expected behavior)
> >
> >A verified signature without any error message.
> >
> >What happened instead? (Actual behavior)
> >
> >$ git verify-commit HEAD
> >Good "git" signature with ED25519 key SHA256:...
> >Too few arguments for sign/verify: missing namespace
> >$ git log --show-signature
> >commit 4697b474dd5ec0de14870d5b0eba5f579b852bbd (HEAD -> main)
> >Good "git" signature with ED25519 key SHA256:...
> >Too few arguments for sign/verify: missing namespace^M
> >
> >What's different between what you expected and what actually happened?
> >
> >Ambiguous signature verification message.
> >
> >Anything else you want to add:
> >
> >Please review the rest of the bug report below.
> >You can delete any lines you don't wish to share.
> >
> >
> >[System Info]
> >git version:
> >git version 2.34.0
> >cpu: x86_64
> >no commit associated with this build
> >sizeof-long: 8
> >sizeof-size_t: 8
> >shell-path: /bin/sh
> >uname: Darwin 20.6.0 Darwin Kernel Version 20.6.0: Mon Aug 30 06:12:21
> >PDT 2021; root:xnu-7195.141.6~3/RELEASE_X86_64 x86_64
> >compiler info: clang: 13.0.0 (clang-1300.0.29.3)
> >libc info: no libc information available
> >$SHELL (typically, interactive shell): /usr/local/bin/bash
> >
> >
> >[Enabled Hooks]
>
> Hi Thor,
> thanks for your report. I'm curious why verify complains about a missing
> namespace. This parameter is basically hard coded to every command :/
> What version of openssh are you using (ssh -V)?
> Also, could you run the sign & the verify with a `GIT_TRACE=1`?
> This way we can see what the actual keygen commands are that are
> executed.
>
> Thanks,
> Fabian
