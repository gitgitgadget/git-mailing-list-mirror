Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EE261F597
	for <e@80x24.org>; Sun, 22 Jul 2018 09:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbeGVKyG (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 06:54:06 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:38237 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbeGVKyG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 06:54:06 -0400
Received: by mail-it0-f46.google.com with SMTP id v71-v6so19914437itb.3
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 02:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bntMYbNgG9AB1/olWv69W5xB1NIWxvaD+WLasYLzUo4=;
        b=qftyGCtJnbgqb83IGepO0a8buNteDDLkld3Yf9Z1MhA3Am7B7xDDMz8ZHw+LJdS9IB
         i4eBhn8GGcXNe+FuFx5PKWMdMyUYFiMWTe8v9BSRu3zLUW9zPJHKM0X89JaLEuLLewWO
         z9S0v4UG1lnAbV2WIXqb/DnUY0sQmENoPVQ3Anl9nRHXosLqjYtOvDvaRVvQussOWX56
         Sk9mFe9Byaq7CvgexKxQH5CUCh/4D02qQml5PO8ZC5u6F8TN/DZySPvHUhuk0lLOrRlw
         qZx/UhP6H7290QU9OQu7yurMcV7M6NYOVLnELkA9sGxBVQpWH1Y9AGQnuC8l3zqCJhSP
         x0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=bntMYbNgG9AB1/olWv69W5xB1NIWxvaD+WLasYLzUo4=;
        b=N5TpJ9x8WMo50owq4iOFKzlTDGfTTr41JOYotAJaURvW21tDQU3X8O4SkJz4oZFA3r
         fnBrsZyFfZTNdMIRlvrXy95tVguT98u7/mmiXeNOdzr+3fwt6Ooh4QHBe0idY1A22EPf
         xSe77zSUOC3j5J/8RvJF/z6igSspnIFU5xCJ+G9BbbcGS6h+oGVrsk/RquDxPEdqGNn3
         seRYnFcgesQjxbtUoLOTrm7y/J8DQcQRqgvuFkEbS2rgnynhvfX6SOIUTcpz48ke8pMS
         2ybIaHyRWmPPtPw8+Z4mMilg/PKFx9sOE5MxBkFPbNdbAWEekxds5GXQTGmJeMSyhlJu
         /8LQ==
X-Gm-Message-State: AOUpUlHuXhkXZxn2AxCLarw40bO9MMzMJkEgg1eyT6rSfeKh+sjqmbiQ
        sS7Gjc5T/PrV5bqYk/v4XmBRFCxx
X-Google-Smtp-Source: AAOMgpeUnWQ5SNDm+SCqlSVENYD1+fT5ITFfLLPQvWwLoOerm1dEs0KIK8aMwFwC5cQK618B7fA4Vg==
X-Received: by 2002:a24:35c8:: with SMTP id k191-v6mr6888842ita.81.1532253476235;
        Sun, 22 Jul 2018 02:57:56 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id w13-v6sm3681298itb.29.2018.07.22.02.57.54
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 02:57:55 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 00/14] format-patch: add --interdiff and --range-diff options
Date:   Sun, 22 Jul 2018 05:57:03 -0400
Message-Id: <20180722095717.17912-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When re-submitting a patch series, it is often helpful (for reviewers)
to include an interdiff or range-diff against the previous version.
Doing so requires manually running git-diff or git-range-diff and
copy/pasting the result into the cover letter of the new version.

This series automates the process by introducing git-format-patch
options --interdiff and --range-diff which insert such a diff into the
cover-letter or into the commentary section of the lone patch of a
1-patch series. In the latter case, the interdiff or range-diff is
indented to avoid confusing git-am and human readers.

Patches 1-6 add --interdiff and can apply directly on 'master'.
Patches 7-14 add --range-diff and apply atop js/range-diff v4[1].

An earlier RFC[2] implemented only --range-diff, and only for the
cover-letter.

Changes since the RFC:

* add --interdiff option for cover-letter and lone patch

* based on js/range-diff v4[1]

* --range-diff works with lone patch (no longer limited to cover
  letter)

* --range-diff colors output when used with --stdout, just as patches
  themselves are already colored

* --range-diff takes advantage of libified range-diff mechanism in v4
  rather than invoking git-range-diff command

No interdiff or range-diff is included in this cover-letter since the
implementation changed dramatically.

[1]: https://public-inbox.org/git/pull.1.v4.git.gitgitgadget@gmail.com/
[2]: https://public-inbox.org/git/20180530080325.37520-1-sunshine@sunshineco.com/

Eric Sunshine (14):
  format-patch: allow additional generated content in
    make_cover_letter()
  format-patch: add --interdiff option to embed diff in cover letter
  format-patch: teach --interdiff to respect -v/--reroll-count
  interdiff: teach show_interdiff() to indent interdiff
  log-tree: show_log: make commentary block delimiting reusable
  format-patch: allow --interdiff to apply to a lone-patch
  range-diff: respect diff_option.file rather than assuming 'stdout'
  range-diff: publish default creation factor
  range-diff: relieve callers of low-level configuration burden
  format-patch: add --range-diff option to embed diff in cover letter
  format-patch: extend --range-diff to accept revision range
  format-patch: teach --range-diff to respect -v/--reroll-count
  format-patch: add --creation-factor tweak for --range-diff
  format-patch: allow --range-diff to apply to a lone-patch

 Documentation/git-format-patch.txt |  29 ++++++
 Makefile                           |   1 +
 builtin/log.c                      | 139 ++++++++++++++++++++++++-----
 builtin/range-diff.c               |  25 ++----
 interdiff.c                        |  28 ++++++
 interdiff.h                        |   8 ++
 log-tree.c                         |  52 +++++++++--
 range-diff.c                       |  26 +++++-
 range-diff.h                       |   5 +-
 revision.h                         |  11 +++
 t/t3206-range-diff.sh              |  12 +++
 t/t4014-format-patch.sh            |  34 +++++++
 12 files changed, 319 insertions(+), 51 deletions(-)
 create mode 100644 interdiff.c
 create mode 100644 interdiff.h

-- 
2.18.0.345.g5c9ce644c3

