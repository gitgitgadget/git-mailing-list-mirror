Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BA5E20248
	for <e@80x24.org>; Thu, 28 Mar 2019 13:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfC1Na7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 09:30:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36406 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfC1Na7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 09:30:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id s16so7966146edr.3
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 06:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=6K243ZZWfZqDXy6NPvA3J07gD89C2LWO6n8UU7ipIMc=;
        b=LgrJxo4RxavxqrMF9JV9z31iyRY0VdTKnycBbXvTVlrnv/NMWfPgaGBNLUCpwtPDr7
         4PMFzu7lu6s64KpdtD+gnb1xB8qzfwb8NqYzDEmrjykemoUf/tLe0toqMVqaOTmelHDd
         LdRk6bRNQE82HkJGaB/AcmrX5vkodj+9nKH9HMuMXZ0liN8nXg4h229y7ONAsGPryYic
         4IwXJwkb6p4rNxbbLRUtQCg+mtmffFcGiaq13tX5ne2XevhmxSOBIxfkrrDJQmSXANc6
         3lu+8NMQgFTv5VwSSU8tD3BdukhTBssGGRXxtJYe2MI6/enHon2U6gmtihusCnHwSvvZ
         nmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6K243ZZWfZqDXy6NPvA3J07gD89C2LWO6n8UU7ipIMc=;
        b=CsN5ojtrwvWwTJpB3chjnXbM7/kyaH3DxdFCo2XvUocw+0LgD8myQ+ZXDV32rE6dQy
         EpFyfhLfj5WEIY+BN4dJN9/zrbp143j7jaNC1joAuW5r+A+tt+PCR9do1cvZeplalOPu
         K/rfnapm0Q4SvPHGwKt1qdYAMlJYGVT+zfJngJJ5YNEalFTOycFQLZCho3hTrPmbcKYf
         OdLqgoet5K3ZAegaobAE5K/CmQUcFeSTffvQVbzdXmu0Y8HAoEWnJaopIhX6vaPHqWoE
         ko00W/pbFQfAtBI4GMEtKmQPwDi7OMtm1k+dGgAkccZ2lE8WzYl6Hx6sVF9b+rz92kiD
         ooRw==
X-Gm-Message-State: APjAAAW6lqJzhW0AqCpwQLvcjgqqDSCGV663j4viXC6rXqvIIg1lVp9o
        etQLHkoM7SGaFi971uK+O9HHDJZq
X-Google-Smtp-Source: APXvYqwEU8U+E6m93cUGr22bnI8fY4fQ6uMu/o1yTT2HB6xiWYWX/ufAvCW+DEclsiZo05/Z2Y6GuA==
X-Received: by 2002:a50:ad58:: with SMTP id z24mr28235771edc.75.1553779857192;
        Thu, 28 Mar 2019 06:30:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c57sm8329976ede.28.2019.03.28.06.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 06:30:52 -0700 (PDT)
Date:   Thu, 28 Mar 2019 06:30:52 -0700 (PDT)
X-Google-Original-Date: Thu, 28 Mar 2019 13:30:47 GMT
Message-Id: <pull.169.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/4] trace2: load trace2 settings from system config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git to load default Trace2 settings from the system config (usually
"/etc/gitconfig"). The existing GIT_TR2_* environment variables can be used
to override the new system defaults. It also includes a little startup
refactoring.

Note: I found interactive testing of this feature to be awkward on some
platforms because of the use of prefix- or runtime-prefix-relative locations
for the system configuration. It was easy to accidentally use an officially
installed version of git to set a system config variable in the official
system config directory; and then when testing with the test version of git,
that value would not be seen because it was looking for the system config
file in a different directory.

Jeff Hostetler (4):
  trace2: refactor setting process starting time
  trace2: add absolute elapsed time to start event
  trace2: find exec-dir before trace2 initialization
  trace2: use system config for default trace2 settings

 Documentation/technical/api-trace2.txt |  54 +++++++++--
 Makefile                               |   1 +
 common-main.c                          |   6 +-
 compat/mingw.c                         |   2 +
 t/t0210-trace2-normal.sh               |  41 +++++++-
 t/t0211-trace2-perf.sh                 |  53 ++++++++---
 t/t0212-trace2-event.sh                |  52 +++++++++-
 trace2.c                               |  19 +++-
 trace2.h                               |  24 ++++-
 trace2/tr2_cfg.c                       |   7 +-
 trace2/tr2_dst.c                       |  24 ++---
 trace2/tr2_dst.h                       |   3 +-
 trace2/tr2_sysenv.c                    | 125 +++++++++++++++++++++++++
 trace2/tr2_sysenv.h                    |  36 +++++++
 trace2/tr2_tgt.h                       |   1 +
 trace2/tr2_tgt_event.c                 |  24 ++---
 trace2/tr2_tgt_normal.c                |  13 +--
 trace2/tr2_tgt_perf.c                  |  17 ++--
 trace2/tr2_tls.c                       |  38 +++++---
 trace2/tr2_tls.h                       |   8 +-
 20 files changed, 455 insertions(+), 93 deletions(-)
 create mode 100644 trace2/tr2_sysenv.c
 create mode 100644 trace2/tr2_sysenv.h


base-commit: 041f5ea1cf987a4068ef5f39ba0a09be85952064
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-169%2Fjeffhostetler%2Fcore-tr2-startup-and-sysenv-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-169/jeffhostetler/core-tr2-startup-and-sysenv-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/169
-- 
gitgitgadget
