Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB863C4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78F220719
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HdmScidi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgCWVnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:43:50 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:48742 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgCWVnu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 17:43:50 -0400
Received: by mail-pf1-f202.google.com with SMTP id h24so12343671pfn.15
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 14:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=N0AMDFv4U6Cc5abBR1qhavoBhO3vkd68MAXyYvl0QD4=;
        b=HdmScidiTGF2dj2C2WWKeAAm9nEMQk7xDahi1mK2mfxrcCtYLADKfKgzygq0BcIYFl
         BrRgHzsavepBwrGsJUsaorAYyddNAmkWqjAq5ym6viOLHMhBSioL9sSkvuj+Wdn5Fzje
         lev5pWfEndvbMtXRoPsT3VIR7iS6ivD7EerKJAgEqF1TP5bwesHR0WKQ606JzLY3SdSx
         Ezgb8R+dOrsoj2pddngvbapuo3iA/jfki1bSNcVLN+5hX4w/glPLZavOGIbNKLbSxQ7K
         ucuKgqr/2PPpihU6ioqmpbg8L4jR+i6R7zvYJHV6NTgn+VoGTqHk53vvG6MP6vI3ubmx
         F0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=N0AMDFv4U6Cc5abBR1qhavoBhO3vkd68MAXyYvl0QD4=;
        b=WWHbg7Cq+mqweZtChp7Na1BKNnCDFtAHx/kt7jFgHizJ810xyv0qeSxqa3+VFHjH+o
         KwliS5dBVz+SApQoIxQex5GNseXqQpO0xQSXRHCy1a+MRz8CHDn0sDO8dgaqGUdHW08r
         dqeQ/PXasUifMMDmV66KFOpi0xNQRUwBxTlsnzB72D9xQQeRdnPXjj2+lSvnY4avSMce
         nX1LXU8raQMgsvk/P8FcDz5XoFJEtR71ADrHIUOBmfNUwO+Oqk2wSXgCM0YkYJafojMh
         R9x3BntkUF9KXVKt0x5slFCf6mfRIAuGr6ssgLYTaGnHnhfBvdK+/5FdFfME7Lw6HNkY
         SaMA==
X-Gm-Message-State: ANhLgQ0iZPVz346ZnGcaVBoTyiUug4OI3YMExVld0DmuAjC59iLXuHwG
        UmgWeCG40wi4UEK4VVZjMB00Cs+oIfKtD93P7eaqo6kOMxOzKp2V7N4LWZlDg9h35kMFjTXePLF
        10EIz6A7a/6i/d8KCQpYPoznevy4f8iamYQuCDVvFZ7HHw1qT/TZQPBpgAyU6m5q/XMKqQ6nCqw
        ==
X-Google-Smtp-Source: ADFU+vu+NnfQyOOTp7spqaHdNVYALNRz0318Np8Y9LAQuofb/CrrDbO5F3hdiM2FV4Y7q95ON9yYrA8YSfmXx82iMv0=
X-Received: by 2002:a17:90a:2710:: with SMTP id o16mr1627348pje.110.1584999827364;
 Mon, 23 Mar 2020 14:43:47 -0700 (PDT)
Date:   Mon, 23 Mar 2020 14:43:35 -0700
In-Reply-To: 20200302230400.107428-1-emilyshaffer@google.com
Message-Id: <20200323214340.182724-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v10 0/5] add git-bugreport tool
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Martin=20=C3=85gren?=" <martin.agren@gmail.com>,
        Aaron Schrab <aaron@schrab.com>,
        Danh Doan <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "=?UTF-8?q?SZEDERG=C3=A1bor?=" <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since v9, a few minor fixes only related to MS and clang compatibility,
plus a warning about strbuf_addf vs strbuf_addstr. I have made no
changes to the build setup for v10, so it's still built as a standalone
which is invoked via the cmd_main helper. There is plenty of time to
change the way we build it later if we want, but I generally agree with
the sentiment "let's get something checked in".

GitGitGadget CI is running at:
https://github.com/gitgitgadget/git/pull/573

 - Emily

Emily Shaffer (5):
  help: move list_config_help to builtin/help
  bugreport: add tool to generate debugging info
  bugreport: gather git version and build info
  bugreport: add uname info
  bugreport: add compiler info

 .gitignore                      |   2 +
 Documentation/git-bugreport.txt |  52 ++++++++++++
 Makefile                        |  18 +++-
 bugreport.c                     | 142 ++++++++++++++++++++++++++++++++
 builtin/help.c                  |  86 +++++++++++++++++++
 command-list.txt                |   1 +
 compat/compiler.h               |  38 +++++++++
 generate-cmdlist.sh             |  19 -----
 generate-configlist.sh          |  21 +++++
 help.c                          | 131 +++++++----------------------
 help.h                          |   2 +-
 strbuf.c                        |   4 +
 strbuf.h                        |   1 +
 t/t0091-bugreport.sh            |  61 ++++++++++++++
 14 files changed, 452 insertions(+), 126 deletions(-)
 create mode 100644 Documentation/git-bugreport.txt
 create mode 100644 bugreport.c
 create mode 100644 compat/compiler.h
 create mode 100755 generate-configlist.sh
 create mode 100755 t/t0091-bugreport.sh

-- 
2.25.1.696.g5e7596f4ac-goog

