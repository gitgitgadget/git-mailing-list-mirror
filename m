Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E139DC433E9
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B910564FC5
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhCKCLF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhCKCLC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:02 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C437AC061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:10:51 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a63so23851427yba.2
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=/u6GtMlaEFsMIH7ZTQbu9ASKIpMZF83QJoN4q+ZRf+A=;
        b=QDI7I2xPxayq9qYJtcmkrHNpv4RSwe/QJGAXMcZv0NFIpH3unHvUvFfLLIK4nQ1Tq3
         Fr47fvo39Ls9d/gX66bMUHxS+AmG4bdiBXFmU6i1zJl4KlFvHac6kXk+VaUtwFLOG+Xc
         ZAi5M3bSfMq/g6Shr8apurP4dtAywWF/ripKuXZdFxEe24YLc4/W/GLSj6Am4ZvSBLey
         lQnJfdvRwnZ8UHxOCbGgXkiuCQ21XXQyS+Ixr+vBKpvacP2ow0y2zia9T/u8pmISkZl0
         pUGbsqASdKU5qnCAtYaben1lJ/rwvEKQniSh3rbuFKmOEJhwbVS9Al5pARSz63EsSFOd
         pEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=/u6GtMlaEFsMIH7ZTQbu9ASKIpMZF83QJoN4q+ZRf+A=;
        b=PQOgktT4zlXx1ZDpqAUmknwZdPFwLUb2tysgJdpiH29qjirRMsshpWgcgYkhxLrHtm
         QJ4/N6NtNkNxpvFs4s3gDh9JjfKbIL1JYPjLR87vTn3zpos3fsyhn+jh29bPbHY7ObdA
         dAyedEhPYMv4aD6oOXaWUbr4pF+8q/rReoDwOqsnGuthUwHK5SXhTg5B+9T6oZwu8xv6
         0XPlA0jSx9XHavQFXCaAaVqfRW6vOCmv9sMA4woN4ZCFede18N6tjsc+Z90kzOzk2psA
         pDYrQFXzdBIlDW8onOmObuJVi/VZPdj6Q1GOB46hJQy0lZcMy83TSzYTjC1dMyaY5XUf
         jGTw==
X-Gm-Message-State: AOAM533qMbB0FpLkP78079nhT5+lnBiBLPa7JjWwCArnTvf5i06ZZIMS
        AyQ086oAriOHdc36m+J/b5PTPWZ++Q/RP5uQeN21ASCKECmoSGtEZGAImuAmeVW6ircD8+zIhda
        u8qNB1+g38jPvvOy05NZjnU9txJUuLw38RYgmpiTiWWNUGbVDWvgE/LEAIjKM2ZbogqeoPaMh+Q
        ==
X-Google-Smtp-Source: ABdhPJzFnW1199zJPzGxvDASDBzU8Ph0iksMiJ4SKGTOZdjqC9uNT5+E/T2iXAQSzUfpVD0S/SwCo14ZsTPGeeASfpM=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a25:9383:: with SMTP id
 a3mr8160654ybm.215.1615428650743; Wed, 10 Mar 2021 18:10:50 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:00 -0800
In-Reply-To: 20201222000220.1491091-1-emilyshaffer@google.com
Message-Id: <20210311021037.3001235-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 00/37] config-based hooks
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since v7:
- Addressed Jonathan Tan's review of part I
- Addressed Junio's review of part I and II
- Combined parts I and II

I think the updates to patch 1 between the rest of the work I've been
doing probably have covered =C3=86var's comments.

More details about per-patch changes found in the notes on each mail (I
hope).

I know that Junio was talking about merging v7 after Josh Steadmon's
review and I asked him not to - this reroll has those changes from
Jonathan Tan's review that I was wanting to wait for.

Thanks!
 - Emily

Emily Shaffer (37):
  doc: propose hooks managed by the config
  hook: scaffolding for git-hook subcommand
  hook: add list command
  hook: include hookdir hook in list
  hook: teach hook.runHookDir
  hook: implement hookcmd.<name>.skip
  parse-options: parse into strvec
  hook: add 'run' subcommand
  hook: introduce hook_exists()
  hook: support passing stdin to hooks
  run-command: allow stdin for run_processes_parallel
  hook: allow parallel hook execution
  hook: allow specifying working directory for hooks
  run-command: add stdin callback for parallelization
  hook: provide stdin by string_list or callback
  run-command: allow capturing of collated output
  hooks: allow callers to capture output
  commit: use config-based hooks
  am: convert applypatch hooks to use config
  merge: use config-based hooks for post-merge hook
  gc: use hook library for pre-auto-gc hook
  rebase: teach pre-rebase to use hook.h
  read-cache: convert post-index-change hook to use config
  receive-pack: convert push-to-checkout hook to hook.h
  git-p4: use 'git hook' to run hooks
  hooks: convert 'post-checkout' hook to hook library
  hook: convert 'post-rewrite' hook to config
  transport: convert pre-push hook to use config
  reference-transaction: look for hooks in config
  receive-pack: convert 'update' hook to hook.h
  proc-receive: acquire hook list from hook.h
  post-update: use hook.h library
  receive-pack: convert receive hooks to hook.h
  bugreport: use hook_exists instead of find_hook
  git-send-email: use 'git hook run' for 'sendemail-validate'
  run-command: stop thinking about hooks
  docs: unify githooks and git-hook manpages

 .gitignore                                    |   1 +
 Documentation/Makefile                        |   1 +
 Documentation/config/hook.txt                 |  27 +
 Documentation/git-hook.txt                    | 161 ++++
 Documentation/githooks.txt                    | 655 +---------------
 Documentation/native-hooks.txt                | 708 ++++++++++++++++++
 Documentation/technical/api-parse-options.txt |   7 +
 .../technical/config-based-hooks.txt          | 369 +++++++++
 Makefile                                      |   2 +
 builtin.h                                     |   1 +
 builtin/am.c                                  |  33 +-
 builtin/bugreport.c                           |   4 +-
 builtin/checkout.c                            |  19 +-
 builtin/clone.c                               |   8 +-
 builtin/commit.c                              |  11 +-
 builtin/fetch.c                               |   1 +
 builtin/gc.c                                  |   5 +-
 builtin/hook.c                                | 176 +++++
 builtin/merge.c                               |  15 +-
 builtin/rebase.c                              |   9 +-
 builtin/receive-pack.c                        | 329 ++++----
 builtin/submodule--helper.c                   |   2 +-
 builtin/worktree.c                            |  31 +-
 command-list.txt                              |   1 +
 commit.c                                      |  22 +-
 commit.h                                      |   3 +-
 git-p4.py                                     |  67 +-
 git-send-email.perl                           |  21 +-
 git.c                                         |   1 +
 hook.c                                        | 480 ++++++++++++
 hook.h                                        | 138 ++++
 parse-options-cb.c                            |  16 +
 parse-options.h                               |   4 +
 read-cache.c                                  |  13 +-
 refs.c                                        |  43 +-
 reset.c                                       |  16 +-
 run-command.c                                 | 156 ++--
 run-command.h                                 |  55 +-
 sequencer.c                                   |  90 +--
 submodule.c                                   |   1 +
 t/helper/test-run-command.c                   |  46 +-
 t/t0061-run-command.sh                        |  37 +
 t/t1360-config-based-hooks.sh                 | 303 ++++++++
 t/t1416-ref-transaction-hooks.sh              |  12 +-
 t/t5411/test-0015-too-many-hooks-error.sh     |  47 ++
 ...3-pre-commit-and-pre-merge-commit-hooks.sh |  17 +-
 t/t9001-send-email.sh                         |  11 +-
 transport.c                                   |  59 +-
 48 files changed, 3052 insertions(+), 1182 deletions(-)
 create mode 100644 Documentation/config/hook.txt
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 Documentation/native-hooks.txt
 create mode 100644 Documentation/technical/config-based-hooks.txt
 create mode 100644 builtin/hook.c
 create mode 100644 hook.c
 create mode 100644 hook.h
 create mode 100755 t/t1360-config-based-hooks.sh
 create mode 100644 t/t5411/test-0015-too-many-hooks-error.sh

--=20
2.31.0.rc2.261.g7f71774620-goog

