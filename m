Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D917C4332F
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EDCE60F4B
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhJ3Ve1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhJ3Ve0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:34:26 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A39EC061570;
        Sat, 30 Oct 2021 14:31:55 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m22so22302551wrb.0;
        Sat, 30 Oct 2021 14:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fn/yC9dQ+cdFMTs7+hVYN9RwP973zbjYwKitz0z5vTU=;
        b=c/eZvOeqhurpQwvJnH5PhqxLfsvYX0A78tAjol/u+Be7HuvNrViaeXWJLzGLQp9bpi
         o14SqSiApHzgsqxxCeZUqonMMo/LATzpTgwA/oqQQq9iwscCNAU2neQj9uaVTieBeQQZ
         bGuGypgkfpgnamnIOrHWa21q1o8BB2dAx0jlmvwnCd5dPLXctAkRW37LHLlYaAfdt0M7
         fiJURlO9SGBDpcNTy3g7HgpnJjrc9LGw5y41h4fycuV3c5t6t9JW5TobJHi6QVi+QDIG
         ODt1irpoA4HUTW/DcHTVXQPkvNDBhb55ITOI02j3RT37+x3LTesydBJ+tzM4sRz2/7yc
         D3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fn/yC9dQ+cdFMTs7+hVYN9RwP973zbjYwKitz0z5vTU=;
        b=jwlr4BaJLwxcxMlm8rquDV8ipODLezco5ceE0imy3Q43+6VN5hKY8ByY5P236alUi+
         3vDSnPlMFAPP0yflvUAkPIk7cLvLRjxPTbn643OM8apVsPUTWKYm7JhsUCGQiQqPGEFN
         vzIbuUN+VzuME5fVVVRWrOBdpGkh1lL7OEsjTptb/RJTpi/4FzOfIVdJiTF43kYjYnZ4
         KqN24VEcAhSkN8Fqa1Ofa2EWv+PUmVJMy6766WYDAzG/xRyJ6XIjuYVeyXxc1AyFVN+k
         f/PXlVV8Q+u71ZRuWCn1ufs8N2p3MbX+DRvghoNoOmOMj8EIzNDwu4arwsjQ4Ts73LEj
         uUbA==
X-Gm-Message-State: AOAM532uZ7SpfgpdWL0AtLbV6TfTzqhSLjF7zahy00MWu5wzqj1/mQAy
        YZXpnhFXjRCcQgv+WllWJFI=
X-Google-Smtp-Source: ABdhPJy1v0IHl38vwJSQHkoCi+puWHJWUzjv7R9copvnZeJzlQK7zy1kwZCcF3L9vdk1Qp69r7gxIw==
X-Received: by 2002:adf:aac5:: with SMTP id i5mr13643160wrc.67.1635629513034;
        Sat, 30 Oct 2021 14:31:53 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id c79sm2948689wme.43.2021.10.30.14.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 14:31:52 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     git@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH 00/22] man2: Add [[deprecated]] attribute
Date:   Sat, 30 Oct 2021 23:31:10 +0200
Message-Id: <20211030213131.140429-1-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Michael,

I added the C2X [[deprecated]] attribute to the prototypes of some
system calls.  All of the cases where I added that were already
marked as deprecated or obsolete somewhere in the manual page,
so this is just about uniformity and visual effect rather than
a new deprecation notice.

There are cases where the syscalls have been simply removed, and
so they are obviously not to be used any more.

There are cases where some implementation (not necessarily Linux)
is dangerous.

In some other cases, the functions have been obsoleted by POSIX,
but are still there in Linux without any deprecation notices.
In these cases, if there's no clear replacement, or if the
replacement is not a straight drop-in, or if the replacement adds
more complexity, I didn't add the [[deprecated]] attribute.

A list of the system calls that I skipped in this patch set:

- utime(2)
	Many filesystems have 1 second resolution, so it makes
	sense to use it in those cases.  git(1) for example uses
	utime(2) consistently.  Although deprecated by POSIX, it
	is still part of POSIX; if it ever removes it, we can
	reconsider.

- setpgrp(2) (the POSIX/SysV version)
	POSIX deprecated it (not yet removed), but the manual page
	doesn't mention any replacement.

Cheers,

Alex


---

Alejandro Colomar (22):
  bdflush.2: SYNOPSIS: Mark as [[deprecated]]
  create_module.2: SYNOPSIS: Mark as [[deprecated]]
  get_kernel_syms.2: SYNOPSIS: Mark as [[deprecated]]
  getunwind.2: SYNOPSIS: Mark as [[deprecated]]
  iopl.2: SYNOPSIS: Mark as [[deprecated]]
  query_module.2: SYNOPSIS: Mark as [[deprecated]]
  remap_file_pages.2: SYNOPSIS: Mark as [[deprecated]]
  sigprocmask.2: SYNOPSIS: Mark the legacy system call as [[deprecated]]
  statfs.2: SYNOPSIS: Mark as [[deprecated]]
  stime.2: SYNOPSIS: Mark as [[deprecated]]
  ustat.2: SYNOPSIS: Mark as [[deprecated]]
  pthread_mutex_consistent.3: Mark *_np() old function as [[deprecated]]
  sysctl.2: SYNOPSIS: Mark as [[deprecated]]
  vfork.2: SYNOPSIS: Mark as [[deprecated]]
  tkill.2: SYNOPSIS: Mark tkill() as [[deprecated]]
  sgetmask.2: SYNOPSIS: Mark as [[deprecated]]
  getitimer.2: SYNOPSIS: Mark as [[deprecated]]
  futimesat.2: SYNOPSIS: Mark as [[deprecated]]
  gettimeofday.2: SYNOPSIS: Mark as [[deprecated]]
  setpgid.2: SYNOPSIS: Mark BSD versions of getpgrp() and setpgrp() as
    [[deprecated]]
  sysfs.2: SYNOPSIS: Mark as [[deprecated]]
  uselib.2: SYNOPSIS: Mark as [[deprecated]]

 man2/bdflush.2                  |  4 ++--
 man2/create_module.2            |  2 +-
 man2/futimesat.2                |  4 ++--
 man2/get_kernel_syms.2          |  2 +-
 man2/getitimer.2                |  7 ++++---
 man2/gettimeofday.2             |  8 ++++----
 man2/getunwind.2                |  3 ++-
 man2/iopl.2                     |  2 +-
 man2/query_module.2             |  5 +++--
 man2/remap_file_pages.2         |  5 +++--
 man2/setpgid.2                  |  8 ++++----
 man2/sgetmask.2                 |  4 ++--
 man2/sigprocmask.2              | 12 +++++++-----
 man2/statfs.2                   |  4 ++--
 man2/stime.2                    |  2 +-
 man2/sysctl.2                   |  2 +-
 man2/sysfs.2                    |  6 +++---
 man2/tkill.2                    |  2 +-
 man2/uselib.2                   |  2 +-
 man2/ustat.2                    |  2 +-
 man2/vfork.2                    |  2 +-
 man3/pthread_mutex_consistent.3 |  1 +
 22 files changed, 48 insertions(+), 41 deletions(-)

-- 
2.33.1

