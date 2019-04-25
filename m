Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 412951F453
	for <e@80x24.org>; Thu, 25 Apr 2019 09:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfDYJqI (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 05:46:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39163 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfDYJqH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 05:46:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id e92so9031039plb.6
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 02:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XEemIIYkjbjhzmj+mSDfFc9oGsyS5PASSxXEI3nKEno=;
        b=G8mj7siNnH8WS+0mFW+PszZiV4IfpQDfNvdW6/SncVigpuXvc6yVnUPYyv8rUtUYm2
         ff5NryWvvcvARx4L2hHngMxp7tx//9IODeNJusFvJsCx0jPSdck4tfTA40x6STv8nuLD
         vGDW6ltqRrQWhqDDkpAJLWoD5jpGAIT+m7A0ZGrjqrnIi9eysWbfCKoupLEz/3hbxPRq
         8I3Trd3V6796zXd53E7Xz0FSqdub8EFFyLv/E6SucneeFTBWLdoEaTgbZ+piwrFVkbUI
         nmik29b9XGU2RsffcAetjjSpK73bUF6t6QMCapF+fzXXNecLg/7quiwRrFenwRTRsnME
         7M9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XEemIIYkjbjhzmj+mSDfFc9oGsyS5PASSxXEI3nKEno=;
        b=bZx7MCD7uNU6DZVYGO6U3IPJppoVzkcKBwLiBq5Up7RAeqUwtrqFgshjMzQ8C/osec
         c9RiG3tVN5UzJeayLHJruwleJPeBlariaiRiYmlhwrKWypL2jhdZcAIkkinc6sGrnw+f
         HpzNIZh72pGuD0gMK/cHYB04FL60uaUZmcjlr2eC4xdVwkWSUbFPqS68Div2VPIotmk6
         d+LXl9+hIh1heAOS0WDkZYtGgjF/mYpxISMQkhmiCzc6JOX3CeRXMoA0y0kyTZYw1mdm
         Tvfo1iunXOVleYIRo/1SP0bGn4oHSyeSIAvtmN9fgRgeKdER7f591t4l63+ZlWfL3CGR
         KkQQ==
X-Gm-Message-State: APjAAAVm7dht3x+jHEU6oi4r+GEpE3PJKMT7x6VKqScnZSCUPuIlu+Zb
        H6ZvbHIjrzHnUekWEY6hy2M=
X-Google-Smtp-Source: APXvYqwRuysgcjYuVPA8NRqQErJqgyMmy6DZErzIg9ya70jWrtHZ6Dv6Tf6QSq+5a0JbNDlb/Y2ikw==
X-Received: by 2002:a17:902:a01:: with SMTP id 1mr37915368plo.36.1556185566855;
        Thu, 25 Apr 2019 02:46:06 -0700 (PDT)
Received: from ash ([115.73.128.9])
        by smtp.gmail.com with ESMTPSA id s19sm12669844pgj.62.2019.04.25.02.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:46:05 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 25 Apr 2019 16:46:01 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        jacob.keller@gmail.com, newren@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v3 00/16] Add new command 'restore'
Date:   Thu, 25 Apr 2019 16:45:44 +0700
Message-Id: <20190425094600.15673-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.854.ge34a79f761
In-Reply-To: <20190411131218.19195-1-pclouds@gmail.com>
References: <20190411131218.19195-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 changes are really small

- gitcli.txt is updated to mention the --staged/--worktree pair, in
  comparison to --cached/--index which is also mention there.

- The patch 'rm --staged' is dropped. It could come back. But if it
  does, it should be in a series where commands that take
  --cached/--index will now take both --staged/--worktree. Those are
  'rm', 'apply', 'check-attr', 'grep', 'diff' and maybe 'ls-files'.
  
  In other words we support --staged/--worktree everywhere while
  --cached/--index still remains because of muscle memory. This is
  of course only a good move if --staged/--worktree is much better
  than --cached/--index.

- Since there's a chance this series may end up in 'master' and get
  released, and I'm still worried that I screwed up somewhere, the last
  patch declares the two commands experimental for maybe one or two
  release cycles.
  
  If the reception is good, we revert that patch. If something
  horrible is found, we can still change the default behavior without
  anybody yelling at us. Or worst case scenario, we remove both
  commands and declare a failed experiment.

PS. the intent-to-add support is still not in. But it should be in
before the experimental status is removed.

Nguyễn Thái Ngọc Duy (16):
  checkout: split part of it to new command 'restore'
  restore: take tree-ish from --source option instead
  restore: make pathspec mandatory
  restore: disable overlay mode by default
  checkout: factor out worktree checkout code
  restore: add --worktree and --staged
  restore: reject invalid combinations with --staged
  restore: default to --source=HEAD when only --staged is specified
  restore: replace --force with --ignore-unmerged
  restore: support --patch
  t: add tests for restore
  completion: support restore
  user-manual.txt: prefer 'merge --abort' over 'reset --hard'
  doc: promote "git restore"
  help: move git-diff and git-reset to different groups
  Declare both git-switch and git-restore experimental

 .gitignore                             |   1 +
 Documentation/config/interactive.txt   |   3 +-
 Documentation/git-checkout.txt         |   3 +-
 Documentation/git-clean.txt            |   2 +-
 Documentation/git-commit.txt           |   2 +-
 Documentation/git-format-patch.txt     |   2 +-
 Documentation/git-reset.txt            |  13 +-
 Documentation/git-restore.txt (new)    | 185 +++++++++++++++
 Documentation/git-revert.txt           |   7 +-
 Documentation/git-switch.txt           |   2 +
 Documentation/git.txt                  |  20 ++
 Documentation/gitcli.txt               |  16 +-
 Documentation/giteveryday.txt          |   5 +-
 Documentation/gittutorial-2.txt        |   4 +-
 Documentation/gittutorial.txt          |   2 +-
 Documentation/user-manual.txt          |  14 +-
 Makefile                               |   1 +
 builtin.h                              |   1 +
 builtin/checkout.c                     | 299 +++++++++++++++++++------
 builtin/clone.c                        |   2 +-
 builtin/commit.c                       |   2 +-
 command-list.txt                       |   7 +-
 contrib/completion/git-completion.bash |  15 ++
 git-add--interactive.perl              |  52 +++++
 git.c                                  |   1 +
 t/lib-patch-mode.sh                    |  12 +
 t/t2070-restore.sh (new +x)            |  99 ++++++++
 t/t2071-restore-patch.sh (new +x)      | 110 +++++++++
 t/t7508-status.sh                      |  82 +++----
 t/t7512-status-help.sh                 |  20 +-
 wt-status.c                            |  26 ++-
 31 files changed, 850 insertions(+), 160 deletions(-)
 create mode 100644 Documentation/git-restore.txt
 create mode 100755 t/t2070-restore.sh
 create mode 100755 t/t2071-restore-patch.sh

Range-diff dựa trên v2:
 1:  41788fc2d2 !  1:  0d5ea2b7fe checkout: split part of it to new command 'restore'
    @@ -342,6 +342,29 @@
      Low-level commands (plumbing)
      -----------------------------
     
    + diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
    + --- a/Documentation/gitcli.txt
    + +++ b/Documentation/gitcli.txt
    +@@
    + http://marc.info/?l=git&m=119150393620273 for further
    + information.
    + 
    ++Some other commands that also work on files in the working tree and/or
    ++in the index can take `--staged` and/or `--worktree`.
    ++
    ++* `--staged` is exactly like `--cached`, which is used to ask a
    ++  command to only work on the index, not the working tree.
    ++
    ++* `--worktree` is the opposite, to ask a command to work on the
    ++  working tree only, not the index.
    ++
    ++* The two options can be specified together to ask a command to work
    ++  on both the index and the working tree.
    ++
    + GIT
    + ---
    + Part of the linkgit:git[1] suite
    +
      diff --git a/Makefile b/Makefile
      --- a/Makefile
      +++ b/Makefile
 2:  253dfb42ae =  2:  c3c6e7762a restore: take tree-ish from --source option instead
 3:  0266c4d982 =  3:  0fbf963e7d restore: make pathspec mandatory
 4:  ae4dd4c24e =  4:  2509bebf32 restore: disable overlay mode by default
 5:  c51dd232c0 =  5:  206c507f7d checkout: factor out worktree checkout code
 6:  6b19ddb1b3 =  6:  656bfcd659 restore: add --worktree and --staged
 7:  3f1031cc23 =  7:  f2d3aa1027 restore: reject invalid combinations with --staged
 8:  d6d9bed95c =  8:  57efad405d restore: default to --source=HEAD when only --staged is specified
 9:  fca91f3cca =  9:  3c6b32c223 restore: replace --force with --ignore-unmerged
10:  079273e2df = 10:  6665d7523b restore: support --patch
11:  9d28d167fa = 11:  d7bda0c0cc t: add tests for restore
12:  acd490f8b0 = 12:  e4622aff3d completion: support restore
13:  336a7d8921 = 13:  787b0e485e user-manual.txt: prefer 'merge --abort' over 'reset --hard'
14:  3b81b27255 = 14:  0df020c2c8 doc: promote "git restore"
15:  ce7e890524 <  -:  ---------- rm: add --staged as alias for --cached
16:  763aa1d6f1 = 15:  3302b1b0e1 help: move git-diff and git-reset to different groups
 -:  ---------- > 16:  ffeea858a7 Declare both git-switch and git-restore experimental
-- 
2.21.0.854.ge34a79f761

