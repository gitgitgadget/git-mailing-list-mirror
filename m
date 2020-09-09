Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9EBC43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 00:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 165832177B
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 00:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="D2OIRqSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgIIAt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 20:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgIIAtt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 20:49:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC12C061573
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 17:49:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v3so842673ybb.22
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 17:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=z/XTynXML4jGnkGkgvARRXdzsZzlJ753dCYPVs0WIHg=;
        b=D2OIRqSg3BrGQFBpahLeOW8Bzoqb3oLZuW5IyCuhlW6quG91zj4ug39C9fAAEqB5EL
         9vt3VABe7QOmrMevwCiI5qu0Sm+hrDbJhtPIWfRzTOpVi2B4v4ZAyo2aRDC1YdD+0dh5
         gWFutjfDl1ZzQMIwVQIt/nPGM5Clx+xG61tDq0Fq2su5epx3LL+ZqTDw5Z18FUM1texs
         OgNDfYQjM31I1TIebaNG9Rm/giW5Cu2PM+SssYhgxJhR9KT+HT7Fzfm8akiGeQ6SxetG
         uRUjayYz2hRBAiqn8FTonQrqHePVtn3CDu/edipG0cZ42ELOZ+TJ8hoc5FibIzPelsHQ
         awsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :subject:from:to:cc;
        bh=z/XTynXML4jGnkGkgvARRXdzsZzlJ753dCYPVs0WIHg=;
        b=tmRz8Kcuwlvdtz06qa8fIVgJezY/9JWwetEbfVBWPG855UYJV7ukU9fWq6ux6lTYzE
         08RnNzxb4OsiJtBMTLwHX7SIHnviZ2Ad7/dvMVFOlDt8+RdTyGxL2lw/0jxclUw3nyzb
         DzyhltaG80x/Hb7nf2gbKy9XipV7azpU4rJO+yBwe6R2aPyMV5wSn6DV0xC1jdFP8OQF
         t1evwZFr11Gj3hNm22Hja7jZ4aqeKSaO6SGfx1RIIhO4Dk29kSiO4zqy4IvmkUhHRTA+
         83XrwWMhB8xeHHIBAyyl7nDp7GKohCVYiyY9nw5o+8wVTRQ7cjQkI620Q4nWDPK//yUq
         iDIA==
X-Gm-Message-State: AOAM530Dce/ym5ZtkNVsWB2eHcnGCadZ+tpmm358HWleHAPEle20+cwc
        yTGdA5xwBZZonMjdSgJcv8eyioPOe7fdPKEqPpcyFrpwS5mLA8bL6Ci06w29sa93wxBCqAh6sW2
        y+DTaJtaUCbpYg0zYfbKV/N5X8jlMnmxo/9a7o+FG311x66nIoCHK207bpBm6qYeYO73yFg4VpA
        ==
X-Google-Smtp-Source: ABdhPJxqrrD3YNdu/mfC1EiBn03odiUumu3VZm0ueav+c6YP/h6UdCBNvL6+BmurQSkxISbGBQtrWKq7Jq1HY00Ey/4=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a25:1f44:: with SMTP id
 f65mr2460155ybf.438.1599612588127; Tue, 08 Sep 2020 17:49:48 -0700 (PDT)
Date:   Tue,  8 Sep 2020 17:49:30 -0700
In-Reply-To: <20200728222455.3023400-1-emilyshaffer@google.com>
Message-Id: <20200909004939.1942347-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v4 0/9] propose config-based hooks
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

Since v3, the biggest change is the conversion of commit hooks to use the new
hook machinery. The first change ("commit: use config-based hooks") is the
important part; the second change ("run_commit_hook: take strvec instead of varargs")
is probably subjective, but I thought it was a decent tech debt reduction.

I wanted to send this reroll quickly since I had promised it in standup last
week, but I've got pretty good progress locally on the patch for configuring
"hook.runHookDir"; I'm planning to send that soon, probably this week.

 - Emily

Emily Shaffer (9):
  doc: propose hooks managed by the config
  hook: scaffolding for git-hook subcommand
  hook: add list command
  hook: add --porcelain to list command
  parse-options: parse into strvec
  hook: add 'run' subcommand
  hook: replace run-command.h:find_hook
  commit: use config-based hooks
  run_commit_hook: take strvec instead of varargs

 .gitignore                                    |   1 +
 Documentation/Makefile                        |   1 +
 Documentation/git-hook.txt                    |  63 ++++
 Documentation/technical/api-parse-options.txt |   5 +
 .../technical/config-based-hooks.txt          | 354 ++++++++++++++++++
 Makefile                                      |   2 +
 builtin.h                                     |   1 +
 builtin/commit.c                              |  49 +--
 builtin/hook.c                                | 107 ++++++
 builtin/merge.c                               |  23 +-
 commit.c                                      |  12 +-
 commit.h                                      |   5 +-
 git.c                                         |   1 +
 hook.c                                        | 155 ++++++++
 hook.h                                        |  19 +
 parse-options-cb.c                            |  16 +
 parse-options.h                               |   4 +
 sequencer.c                                   |  15 +-
 t/t1360-config-based-hooks.sh                 | 115 ++++++
 ...3-pre-commit-and-pre-merge-commit-hooks.sh |  13 +
 20 files changed, 918 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 Documentation/technical/config-based-hooks.txt
 create mode 100644 builtin/hook.c
 create mode 100644 hook.c
 create mode 100644 hook.h
 create mode 100755 t/t1360-config-based-hooks.sh

-- 
2.28.0.rc0.142.g3c755180ce-goog

