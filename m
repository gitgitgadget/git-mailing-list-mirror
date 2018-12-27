Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF7D6211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 16:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbeL0QZr (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 11:25:47 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35759 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeL0QZr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 11:25:47 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so13006588lfc.2
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 08:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DaLxTQe4ep/XOGAaDUiZt8SufXJ84A9bNcCuIS/zZH4=;
        b=W7eXOkWFvhf5lHvkgjcpAmJ5DpNR8OIeFFL+xvHRyo5uSN2ac9ldgV0d+VQyQ6Dzxl
         rLJJyuy61xEChFVT7ogZFcgNc/aM10lheNduchYJ/wwGxjUmRSBxsLzKabDL3oWTIZU/
         SYBCD+pkF2bopCKAPoB7kL1XgYuR673UZi4LKQA1igX0+3nQghcc9xmJxx/Jbj76GFYj
         p32WycBFMqgC+nfBn+PVm1tYIWt+/AAEq4nf3R5l28G1Coj5MDQ8ak3rzn3CoDWjnjyy
         7oSHWTB2rrbWLzNWGpR9ftCq5T+UmQSCDdxEiRFjLrNBHyzeYUxJmCCXl22jH95LOSdF
         Xd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DaLxTQe4ep/XOGAaDUiZt8SufXJ84A9bNcCuIS/zZH4=;
        b=VjlKfS062OYzZexuVjPtPqhmEaI7x55bbsQOgm6skud1br9dMCPfSO+mh+Pg/WV503
         FC8JkuWPF1J6zox10XuTPEQfiOZcGJ4Ygv77g6sXZiIUV4bon4b1o6L+feCvgNHR1Elr
         Oa4ejUw3pt6QsP/kn+D/Z4/D0P46zd3IwGV3v+XWW0l7ccfAJyoZ5XLdRS9YPb7GgZwB
         UCK/Djlpt9LBzNHhtxXWKbHtK+5G8OHgw7EgoM9JnhOc6hl8LC9F5GqG2BF1+mI5I6fK
         n9TsEryYzooLXM1qgi826XEHqEjFFh+iU+Heo7+zzth/GEFJottEhXd43Vs63Th5pwms
         XJ1A==
X-Gm-Message-State: AA+aEWbSGAkyEhx4YD3d/yFsZPQlgVBx9onfIUJudanNyHYbYnLK+3kg
        7dwFA/wgK934WDdT3HvvDTXR4slH
X-Google-Smtp-Source: AFSGD/VsQpi92xDpv+OYwQPIKJvzVcfBzMYlspsrekO7HPllwIVA+oikyLyEeTBCtoyFQRlmteASwg==
X-Received: by 2002:a19:3b45:: with SMTP id i66mr12993512lfa.28.1545927944437;
        Thu, 27 Dec 2018 08:25:44 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id a127sm7643106lfe.73.2018.12.27.08.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 08:25:43 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/75] Convert diff opt parser to parse_options()
Date:   Thu, 27 Dec 2018 17:25:21 +0100
Message-Id: <20181227162536.15895-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a sneak peek of converting diff_opt_parse() to 'struct
option'. The end game is builtin commands can just add diff options to
their 'struct option[]' array, do parse_options() like usual and have
diff parsing for free.

Besides simplifying the parsing code, there are also more benefits of
using struct option, e.g. tab completion and "git cmd -h".

I'm not sending full series because it's looong, the middle is not
that interesting, and I would need to wait for
sb/diff-color-moved-config-option-fixup (and Brian's --literally too,
probably) to land before sending something mergeable. But main patches
are sent here for review.

This is of course just the beginning. Once revision.c parser is
converted, diff_opt_parse() will be killed off, more commands can take
use diff option array directly. And perhaps the diff option array will
be split up into smaller ones to give callers more control what's part
of the command.

Nguyễn Thái Ngọc Duy (75):
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
 diff.c                         | 1132 ++++++++++++++++++++------------
 diff.h                         |   85 +--
 parse-options-cb.c             |   11 +-
 parse-options.c                |  152 +++--
 parse-options.h                |  116 ++--
 t/t4053-diff-no-index.sh       |    3 +-
 t/t7800-difftool.sh            |    4 +-
 15 files changed, 1051 insertions(+), 628 deletions(-)

-- 
2.20.0.482.g66447595a7

