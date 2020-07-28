Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596D9C433DF
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 22:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F1AC2070B
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 22:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QxvKsXpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgG1WZE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729270AbgG1WZD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 18:25:03 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC078C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 15:25:03 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id u10so14379240qvj.23
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 15:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=C4+RKKFaVbj2s22MVgvYqIb+fEpzJy1Q0PQxIGphq+4=;
        b=QxvKsXpA1hkHbA+YVUzin2ZZUotY32mI0SWH30ac0NOURfKziUBsqW79TbfDbmBDKO
         qGx3j1XbeliRXUUnQj9RN0vPrrcTk+aC2ujRDHd11FJ5SI0niQ4llUn9FbjplzzGruwO
         6xd9oa94ArQYp1tleGty5LBDCpvihWhRy5kTPDKaZED/ERHZMCjLWTWD4WDcCklSTs9D
         p1xu95to0OODEH7dP9VxxLT7bDWdb20Zl2vJn0AJ8lvT5EkNcPu144hVzZFkpNn0MImq
         7zsVakt53hMjLL962C5ea6Sx8uChJIaRIvpYzFyKOrtCYPx8UPX3gvT0w11w4SzTKnjw
         vHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=C4+RKKFaVbj2s22MVgvYqIb+fEpzJy1Q0PQxIGphq+4=;
        b=RtS6/J2Q2EEyFeiEwdd2kkdpx5TaC4GjI2k//DUYNk4V8w6UhgHrC6sTDLYF/ExATm
         VnlN8BS2KmQujB9CDFafHkRYL5enjw+49rZipOGeqkEyfkdWcEpJmKDLPIXkSA9oC3NK
         OGtmhJjasKHR+rmnFNbSpdp0B9KM8VIaAP3SsSNUftKDRJPfIEGGfn+ULu4Iy7S/Fzze
         iHBXtxRzpKPobnsR4rQxTLrCvGsfGiDjcr1cX137ige8OXVsMGxjcAp8CjfCnsS+mGhZ
         sRoQZjC20XLBMvE4F35Yyk85GR+8xfz4NybFBwsStxNKi9WPdROlAGwEhT/ZpEnFUMqF
         myQg==
X-Gm-Message-State: AOAM530iqQyOXWNRRkwBCPhC9/T8YpPWIqTI+ofVOo6MMx1o/Rv8F0Ld
        LZzJkLrZyigwfu6bjuUQG/l3VoC+mFdcr3sWgzfRmlKSjVFJrk+EAERjCHRgff7cDuNP1tPJWLm
        qMTFQnpcBm/iTEKKiXX6A5IiJx9eac9FL2+FeOgJ2c3vvEYQq6oVxiLC2UkF2InEs3Uvm+ujYhw
        ==
X-Google-Smtp-Source: ABdhPJxdrE4Q5JP5txe3oMgjviJ/V79qQNlO73mkDFo1bMCYzVXYM9c6jBP1rnsUeojh22K4W5gp9cMmEvG4KwiEvHw=
X-Received: by 2002:a0c:8224:: with SMTP id h33mr16433848qva.52.1595975102787;
 Tue, 28 Jul 2020 15:25:02 -0700 (PDT)
Date:   Tue, 28 Jul 2020 15:24:49 -0700
In-Reply-To: <20200521185414.43760-1-emilyshaffer@google.com>
Message-Id: <20200728222455.3023400-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v3 0/6] propose config-based hooks
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
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

After taking a few weeks to work on other items, I've got another update
to the config-based hook series. Patches 5 and 6 are RFC - a sketch of
how the hook library could run the appropriate set of hooks. There's
more work to do, which I'll outline later in the cover letter.

Since last time, I took into account review comments, including Dscho's
fixups to make the tests work in Windows. It seems those tests are
passing now, according to the GH Actions run:
https://github.com/nasamuffin/git/actions/runs/186242637

One thing I didn't decide on was the benefit of moving the hookcmd
resolution outside of the hook config pass; that code is unchanged. I
still haven't decided quite which approach I like better, but it's still
on my mind.

In the 'run_hook()' implementation I flipped the 'use_shell' bit, which
by my understanding only uses a shell if it can't find the command in
PATH; this seems like a reasonable approach especially because the code
is so brief, but I'm interested in hearing why I'm wrong or it won't
work well :)

There is still some work I've got locally which isn't quite ready:
 - support for hook.runHookDir. This is turning into a yak shave about
   who decides where and when to display or run the hookdir hook. I
   think I've got it mostly figured out and there's a patch locally, but
   it's not polished.
 - Drafts for 'git hook add' and 'git hook edit'. These features are
   probably the most complicated part of the series, but it's possible
   to use config-based hooks without them. In the interest of getting
   something out for people to try on their own, I'll probably leave
   these for later.
 - Support for stdin redirection to hooks. Since this means we want to
   point the same stdin to multiple processes, I'm thinking it will be
   slightly complicated. Maybe someone has a hint for me? :) Without
   having looked at what's available or not yet, I'm planning to do this
   by reading the whole stdin to memory and then streaming it to each
   process in turn, as I can't seek back to the beginning of the stream
   when I start each new process.
 - Conversion of codebase to use the hook library instead. Partly, this
   is gated on the previous point - there are plenty of callers who,
   instead of using run-command's run_hook_*(), just use find_hook() and
   roll their own struct child_process so they can use stdin/stdout. I
   do plan to consider the hook lib's run_hooks() implementation as
   non-final until I start this process - I'm expecting to learn more
   about what I do and don't have to support when I do this.

Thanks, all. Hopefully I can do better than a 2-month wait for the
series after this one... although I imagine I cursed myself by saying
that. :)

 - Emily


Emily Shaffer (6):
  doc: propose hooks managed by the config
  hook: scaffolding for git-hook subcommand
  hook: add list command
  hook: add --porcelain to list command
  parse-options: parse into argv_array
  hook: add 'run' subcommand

 .gitignore                                    |   1 +
 Documentation/Makefile                        |   1 +
 Documentation/git-hook.txt                    |  63 ++++
 Documentation/technical/api-parse-options.txt |   5 +
 .../technical/config-based-hooks.txt          | 354 ++++++++++++++++++
 Makefile                                      |   2 +
 builtin.h                                     |   1 +
 builtin/hook.c                                | 107 ++++++
 git.c                                         |   1 +
 hook.c                                        | 132 +++++++
 hook.h                                        |  18 +
 parse-options-cb.c                            |  16 +
 parse-options.h                               |   4 +
 t/t1360-config-based-hooks.sh                 | 115 ++++++
 14 files changed, 820 insertions(+)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 Documentation/technical/config-based-hooks.txt
 create mode 100644 builtin/hook.c
 create mode 100644 hook.c
 create mode 100644 hook.h
 create mode 100755 t/t1360-config-based-hooks.sh

-- 
2.28.0.rc0.142.g3c755180ce-goog

