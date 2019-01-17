Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B9241F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfAQNGe (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:06:34 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:40376 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfAQNGe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:06:34 -0500
Received: by mail-pl1-f182.google.com with SMTP id u18so4728744plq.7
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5SB6ipV/KOENimEW3NlYtoYvpMmAPzikgU4l8afb85g=;
        b=qsPzpwpnRqa9B5m0kAyNZHSStXY1CPWofDZrHeL51CpNuOpy5n9zAzbJqNRTDQ/eOK
         nj1tKBVd4cTPJ6qCY5gAqotEEotl2YWIP3jivxCL9RwEKJIShgLCxRR27BZnN/LituRB
         jQHvEE4Em4el5cQuwCVWQMJPX0dOuv/cZ1aZbr2Ht+pdcYDwmMjdceSlRCz8NO7K++5a
         ePsppZ++bR6qiZOZtDsZZkRrNwzniF9LbVvAYjRVUPM6GRWwK5Dg6/hXvo7ujcJGd4Li
         eltR4DDLzeut45k3W38tvPjW2vNyi8A/h2I9p9X5kDGOlLur7uGliwvCO0tmmA4dELQu
         J0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5SB6ipV/KOENimEW3NlYtoYvpMmAPzikgU4l8afb85g=;
        b=qkesjBG0OUVIeggpcX96/GDKxBrSJw8oijTtjPE67UiSPkhrsRifIuZl71sjLOeTXL
         SIPq9U+TuhCa6fonMlMN5iVZgvBFMCQhWs9pa20917a8Lkxh2P+KWgDFUSzJkfxEpWEC
         e9l95p5ZN6yeeoiru61i92TBdu+Rc+DrFORdraZCIQDOx87CDhsSVyUHrjCBs/dkTyIF
         eJ862J2LVIZMFnweradrr+HUmXwe/fqAwjB7MuH27QWq6/45oQBfvLJLs2MoosAs2jlr
         ZDCI22YGP0cO8ArgM/PtFkV6KRRIG0PMpAc8dR3Os/fiwMtmMjhg4Rbcgqna69wNzDyu
         DXEA==
X-Gm-Message-State: AJcUukfvxJO7OgDBMf7YayrCOO+U3dz8Yf+YMa92gOivNalKz+kOjd0g
        Rl6U6zzWYPmO419QZQNUKRtZGuXK
X-Google-Smtp-Source: ALg8bN424/1ikSp/YQQSkjSu9wEWh1niM/IYpL8jaPPP3W83gFn2n8HKXqkMRrm5Uh3UmCqJ3tXw0Q==
X-Received: by 2002:a17:902:1105:: with SMTP id d5mr14460054pla.47.1547730392910;
        Thu, 17 Jan 2019 05:06:32 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id i193sm7513278pgc.22.2019.01.17.05.06.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:06:32 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:06:27 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/76] Convert diff opt parser to parse_options()
Date:   Thu, 17 Jan 2019 20:04:59 +0700
Message-Id: <20190117130615.18732-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series converts diff option parsing to using parse-options. There
are a couple benefits of using parse-options, including "git <cmd> -h"
output, completion and less duplicate work.

This is the first half. The second one would be converting the option
parser in revision.c.  After that, the end game is, any command can
take a 'struct option[]' somewhere from diff/rev code, remove the
options they are not interested, then merge with their own options and
do parse_options() just once. There will be no separate parse phase
for revision/diff anymore.

I sent a sneak peek [1] last year and got two good comments. I take it
people at least did not oppose to this. The most interesting parts are
at the top and bottom. The middle is just boring conversion, usually
one option per patch.

This will conflict with pw/diff-color-moved-ws-fix on 'pu' because
that series adds --no-color-moved-ws option. I redid the same thing in
73/76 so that conflict resolution could be simply taking this side of
change.

This series is also available for fetching here

https://gitlab.com/pclouds/git/commits/diff-opt-parse-options

[1] http://public-inbox.org/git/20181227162536.15895-1-pclouds@gmail.com/

Nguyễn Thái Ngọc Duy (76):
  parse-options.h: remove extern on function prototypes
  parse-options: add one-shot mode
  parse-options: allow keep-unknown + stop-at-non-opt combination
  parse-options: disable option abbreviation with PARSE_OPT_KEEP_UNKNOWN
  parse-options: add OPT_BITOP()
  parse-options: stop abusing 'callback' for lowlevel callbacks
  parse-options: avoid magic return codes
  parse-options: allow ll_callback with OPTION_CALLBACK
  diff.h: keep forward struct declarations sorted
  diff.h: avoid bit fields in struct diff_flags
  diff.c: prepare to use parse_options() for parsing
  diff.c: convert -u|-p|--patch
  diff.c: convert -U|--unified
  diff.c: convert -W|--[no-]function-context
  diff.c: convert --raw
  diff.c: convert --patch-with-raw
  diff.c: convert --numstat and --shortstat
  diff.c: convert --dirstat and friends
  diff.c: convert --check
  diff.c: convert --summary
  diff.c: convert --patch-with-stat
  diff.c: convert --name-only
  diff.c: convert --name-status
  diff.c: convert -s|--no-patch
  diff.c: convert --stat*
  diff.c: convert --[no-]compact-summary
  diff.c: convert --output-*
  diff.c: convert -B|--break-rewrites
  diff.c: convert -M|--find-renames
  diff.c: convert -D|--irreversible-delete
  diff.c: convert -C|--find-copies
  diff.c: convert --find-copies-harder
  diff.c: convert --no-renames|--[no--rename-empty
  diff.c: convert --relative
  diff.c: convert --[no-]minimal
  diff.c: convert --ignore-some-changes
  diff.c: convert --[no-]indent-heuristic
  diff.c: convert --patience
  diff.c: convert --histogram
  diff.c: convert --diff-algorithm
  diff.c: convert --anchored
  diff.c: convert --binary
  diff.c: convert --full-index
  diff.c: convert -a|--text
  diff.c: convert -R
  diff.c: convert --[no-]follow
  diff.c: convert --[no-]color
  diff.c: convert --word-diff
  diff.c: convert --word-diff-regex
  diff.c: convert --color-words
  diff.c: convert --exit-code
  diff.c: convert --quiet
  diff.c: convert --ext-diff
  diff.c: convert --textconv
  diff.c: convert --ignore-submodules
  diff.c: convert --submodule
  diff.c: convert --ws-error-highlight
  diff.c: convert --ita-[in]visible-in-index
  diff.c: convert -z
  diff.c: convert -l
  diff.c: convert -S|-G
  diff.c: convert --pickaxe-all|--pickaxe-regex
  diff.c: convert -O
  diff.c: convert --find-object
  diff.c: convert --diff-filter
  diff.c: convert --[no-]abbrev
  diff.c: convert --[src|dst]-prefix
  diff.c: convert --line-prefix
  diff.c: convert --no-prefix
  diff.c: convert --inter-hunk-context
  diff.c: convert --color-moved
  diff.c: convert --color-moved-ws
  diff.c: allow --no-color-moved-ws
  range-diff: use parse_options() instead of diff_opt_parse()
  diff --no-index: use parse_options() instead of diff_opt_parse()
  am: avoid diff_opt_parse()

 Documentation/diff-options.txt |   24 +-
 builtin/am.c                   |    4 +-
 builtin/blame.c                |    2 +-
 builtin/diff.c                 |   21 +-
 builtin/merge.c                |    9 +-
 builtin/range-diff.c           |   26 +-
 builtin/update-index.c         |   41 +-
 diff-no-index.c                |   49 +-
 diff.c                         | 1136 ++++++++++++++++++++------------
 diff.h                         |   85 +--
 parse-options-cb.c             |   11 +-
 parse-options.c                |  152 +++--
 parse-options.h                |  114 ++--
 t/t4053-diff-no-index.sh       |    3 +-
 t/t7800-difftool.sh            |    4 +-
 15 files changed, 1054 insertions(+), 627 deletions(-)

-- 
2.20.0.482.g66447595a7

