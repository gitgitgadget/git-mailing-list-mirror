Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E32F1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 20:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754762AbeARUzg (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 15:55:36 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:46817 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752062AbeARUzf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 15:55:35 -0500
Received: by mail-io0-f180.google.com with SMTP id f34so21029800ioi.13
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 12:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=DCpMH5q4oBjvQkiVndFlQ7W3kAhN6P6PHTFYg0xrURw=;
        b=ngFMJoNK6uxACoQeM+RMAE/Rj1BURyGilcAiPAnzeiK/6lrHEgHQ+vI8IVVqsHcg09
         9nXrB6SAhtvsYm2+5IGo1CtZk6sStEfv9Oh2nJ/ZUYaQVl3/HZmTCGkaQAWNtSiHqfEn
         4Ap/lQRImjF6QH4CW2ptwoiD+8qmEaFt9sY8b9Qvw0gsubkmKWCUj0deMqc1mTOMeFaR
         rEu96Fu/Rj7r9GfwcbQI0Gnv/8nzwtet5OQ2hKg/1ExLCa3mkxltja870+n0b40ES36J
         spO+n5PM1WbYnsKQRSBnE3za8RBAcso9MsaMkKxejajjy0N5IFD2a2lTruEjlzZ4xGX3
         Dg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DCpMH5q4oBjvQkiVndFlQ7W3kAhN6P6PHTFYg0xrURw=;
        b=PqBJ16cv4mUL1Yr62Npb+NwneAbNTwfdC5qKLq9wDcpb+ZKZCjYKylvhMz1SVHOkMc
         q3fQzG7GXXvgNE2HJnZEJ9rx7CvmpO9VgkCgEpkvbR99Iwnte1RIRhUeSCd5e/AtuoZY
         6KslDo2QPJ/RB+UsuOe/hpynXCDjfrODKgO6c2ouB+X5CpaSsjAQ5WhOxMKGYFBw54Qz
         8DnZS8NikRRIMIj9DLrwNJkpW08eJpCwyJGsxVNth8u6dUpSgWlNbZMiERiC3cMjKnWH
         m/TlsMl0a9EwgZuULc4MT2OFV+kXoiXWKnl3vgaW58eb7sZp8lqazp21o+f28LsW9EXz
         5VTA==
X-Gm-Message-State: AKGB3mKysv1MRUVgpIHO9n2BZvJ3D43SR0rLHURh+SNbOTnFVWEWa687
        jUvUe7ruu0nDfmJCCPRr3kPA+H3Zdvv7JM9d+xnsFg==
X-Google-Smtp-Source: ACJfBoteaXLCP/eKQ7zYjE4ZytcmsXE0SddK2igPl+QKF4Ppz9dnDSzkw94S876KlTqw3JWqBJ4NOKO3p6Kf4dGiZRU=
X-Received: by 10.107.197.5 with SMTP id v5mr48456737iof.281.1516308934688;
 Thu, 18 Jan 2018 12:55:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.111.70 with HTTP; Thu, 18 Jan 2018 12:55:34 -0800 (PST)
From:   =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>
Date:   Thu, 18 Jan 2018 23:55:34 +0300
Message-ID: <CALwADsGfB10f5+nOFN-pHCt4z1SkWMcvSHn8KokcyCM0V6K-BA@mail.gmail.com>
Subject: git 2.16.0 segfaults on clone of specific repo
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I found that git 2.16.0 segfaults on clone of vim-colorschemes repo.
See the log below.

alexbool@alexbool-osx ~/Documents> lldb -- git clone
https://github.com/flazz/vim-colorschemes.git
(lldb) target create "git"
Current executable set to 'git' (x86_64).
(lldb) settings set -- target.run-args  "clone"
"https://github.com/flazz/vim-colorschemes.git"
(lldb) run
Process 25643 launched: '/usr/local/bin/git' (x86_64)
Cloning into 'vim-colorschemes'...
remote: Counting objects: 1457, done.
remote: Total 1457 (delta 0), reused 0 (delta 0), pack-reused 1457
Receiving objects: 100% (1457/1457), 1.43 MiB | 289.00 KiB/s, done.
Resolving deltas: 100% (424/424), done.
Process 25643 stopped
* thread #1, queue = 'com.apple.main-thread', stop reason =
EXC_BAD_ACCESS (code=1, address=0x48)
    frame #0: 0x00000001000f7c3d git`ce_match_stat_basic + 263
git`ce_match_stat_basic:
->  0x1000f7c3d <+263>: movq   0x48(%rax), %rsi
    0x1000f7c41 <+267>: movl   $0x14, %edx
    0x1000f7c46 <+272>: movq   %r14, %rdi
    0x1000f7c49 <+275>: callq  0x1001659fa               ; symbol stub
for: memcmp
Target 0: (git) stopped.
(lldb) bt
* thread #1, queue = 'com.apple.main-thread', stop reason =
EXC_BAD_ACCESS (code=1, address=0x48)
  * frame #0: 0x00000001000f7c3d git`ce_match_stat_basic + 263
    frame #1: 0x00000001000f7ae8 git`ie_match_stat + 108
    frame #2: 0x00000001000bbe07 git`checkout_entry + 266
    frame #3: 0x0000000100144ff9 git`unpack_trees + 2317
    frame #4: 0x0000000100017e13 git`cmd_clone + 5733
    frame #5: 0x0000000100001ea3 git`handle_builtin + 532
    frame #6: 0x0000000100001954 git`cmd_main + 263
    frame #7: 0x0000000100079a28 git`main + 80
    frame #8: 0x00007fff64d76115 libdyld.dylib`start + 1
(lldb) ^D
alexbool@alexbool-osx ~/Documents> git --version
git version 2.16.0

OS: macOS 10.13.2
git installed from homebrew
