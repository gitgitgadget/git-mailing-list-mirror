Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E75E81F453
	for <e@80x24.org>; Fri,  3 May 2019 20:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfECUSY (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 16:18:24 -0400
Received: from mail-it1-f181.google.com ([209.85.166.181]:34926 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfECUSY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 16:18:24 -0400
Received: by mail-it1-f181.google.com with SMTP id l140so11011495itb.0
        for <git@vger.kernel.org>; Fri, 03 May 2019 13:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=tDEDmIeFWkkGrCxCeVtkb0K4vRsux5Pt7zYIyBtgdVg=;
        b=sEkwQUDpT2N7UDkh1kUryUnFHmfx5HuTXjtQaCZHxut2dY88N8K4MN3XbKr+yeGxAK
         hNP9kj8Lty/z8mpxdAAk30t1fAToY3TT9xtouzxsLLelO5Wi9MsM9cpqMTGkgTMLs8kr
         BMheP+M46Gs3bLjyBOCq8GLLPloxgOcVnXEAsWgjUgw/x4q9tMcimGy9BYtW1+qG3NBB
         NZUK/khlMYd8s4+YJIyZjtGbgAGiSrpT7Ov8XjgJVOjinQXtXT3R04uHT+rG0Z4hZB5v
         MzjOcIeTzRYtvSr2JXHo0klOn07nkUGYR7ru42dDnrtVibJdDjvBwyRIl45WySGts+69
         wl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=tDEDmIeFWkkGrCxCeVtkb0K4vRsux5Pt7zYIyBtgdVg=;
        b=kRHYlP5kYS1zbHUPgIYsV7fMNtfrwuThdXAcuyFdb3L8oUOc1blWOklK/mBSsmdXbv
         jIS1MBrkWntxqeBe4X6/K3OjkxMU52rUd8DBmF3mJeqwzPlAmnwzG+2ADRfwlbo4WsXU
         lkkCB5NZUDF3TPpZyfVfaQ6iKDMOSZy2U8rPF/ZmAXI1xYMqLBTZuD9NskjmKrKHUT7e
         6x6YNpwD4Nb/6At68CObS0UjKNHu/fzWz5s9m0sGlophHI38ekQsYjsIz6BDZpRo4oUd
         gGVsd9MVEvQVoZht2QZeTLFS2PHzP3fau75/h9ooc3eIXGQ2QTG0pYJwuCM+STOMDNxw
         4C6Q==
X-Gm-Message-State: APjAAAW6llT500EQ8FOjJmHK7tjaxgelftqOi6aD/xAYT6Zg22jdJwTD
        oqfZzKnC45FtUgbv9uJYtB4lRlSRivxmmWmBGKVhC3Yd
X-Google-Smtp-Source: APXvYqxS18MZUiPDWN5aqISIIPCjlNYpXFcP8sBPlUm8MNwxUZg8JjqGMNqnjRJwrKKfIsxHEFvAnVGglO/X3pT476s=
X-Received: by 2002:a24:1104:: with SMTP id 4mr7416474itf.10.1556914703618;
 Fri, 03 May 2019 13:18:23 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Fri, 3 May 2019 16:18:02 -0400
Message-ID: <CAH8yC8kqHDDqsu++3an69Oq--hhabV8LGawD3uccykFYQDFvsw@mail.gmail.com>
Subject: not ok 41 - test ident field is working
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I'm catching one failed self test under a sanitizer build. It looks
like there's some latent UB present during 'make check'

ok 39 - using --untracked-cache does not fail when core.untrackedCache is false
ok 40 - setting core.untrackedCache to keep
not ok 41 - test ident field is working
#
#               mkdir ../other_worktree &&
#               cp -R done dthree dtwo four three ../other_worktree &&
#               GIT_WORK_TREE=../other_worktree git status 2>../err &&
#               echo "warning: untracked cache is disabled on this
system or location" >../expect &&
#               test_i18ncmp ../expect ../err
#
ok 42 - untracked cache survives a checkout
ok 43 - untracked cache survives a commit

I found one file called 'err' and it has:

$ cat "./t/trash directory.t7063-status-untracked-cache/err"
read-cache.c:1943:22: runtime error: load of misaligned address 0x7fba278d61ab f
or type 'unsigned int', which requires 4 byte alignment
0x7fba278d61ab: note: pointer points here
 55  4e 54 52 00 00 02 9b 76  4c 6f 63 61 74 69 6f 6e  20 2f 68 6f 6d 65 2f 6a
77 61 6c 74 6f 6e 2f
              ^
dir.c:2860:18: runtime error: load of misaligned address 0x7fba278d626e for type
 'unsigned int', which requires 4 byte alignment
0x7fba278d626e: note: pointer points here
 00 00 00 00 00 00  00 06 13 26 3c 09 78 fb  9f ad 16 b2 d5 80 fb 80  0b 6d 81 1
c 3f f0 00 00  00 00
             ^
ewah/ewah_io.c:97:19: runtime error: load of misaligned address 0x7fba278d62f5 f
or type 'unsigned int', which requires 4 byte alignment
0x7fba278d62f5: note: pointer points here
 74 77 6f 00 00 00 00  06 00 00 00 02 00 00 00  02 00 00 00 00 00 00 00  00 00 0
0 00 3f 00 00 00  00
             ^
ewah/ewah_io.c:103:41: runtime error: load of misaligned address 0x7fba278d62f9
for type 'unsigned int', which requires 4 byte alignment
0x7fba278d62f9: note: pointer points here
 00 00 00  06 00 00 00 02 00 00 00  02 00 00 00 00 00 00 00  00 00 00 00 3f 00 0
0 00  00 00 00 00 06
              ^
ewah/ewah_io.c:129:29: runtime error: load of misaligned address 0x7fba278d630d
for type 'unsigned int', which requires 4 byte alignment
0x7fba278d630d: note: pointer points here
 00 00 00 3f 00 00 00  00 00 00 00 06 00 00 00  02 00 00 00 02 00 00 00  00 00 0
0 00 00 00 00 00  3c
             ^
warning: untracked cache is disabled on this system or location

Jeff
