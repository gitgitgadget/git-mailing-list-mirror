Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD03C2D0DC
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 16:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECFF20866
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 16:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsTazSjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgABQOS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 11:14:18 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42435 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbgABQOS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 11:14:18 -0500
Received: by mail-ed1-f66.google.com with SMTP id e10so39510648edv.9
        for <git@vger.kernel.org>; Thu, 02 Jan 2020 08:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=9bZD3SaxZIg50kqZf2JgTGCc/E7A0AbZyRY3ULvPJLk=;
        b=hsTazSjp1+mKUlK1SdP3sOcWSbaKV69Tiq/K5kl9ig8KgCo6+ROlUcIJH4PJ6IkbL+
         16Tobfm0ZgyWVyyja/+7o7swAkMiigcdDorGfH//T8i2oyYk7DViXAnmxozUeybvqJkm
         2+v5lCd1Tga+LQgEw01DRSEq/vdOvpyrrhjlYbagxsQvYfmyeuC7iSs/4hpiiY3hR9mw
         bj9WgupFCkpOoe5vb2RXV0bqg0He5L56xrHWKwmDdFrRG35Aw5Jr9NJ2RdJZ2cRj0ra/
         c2oARdL1DGNkJezXeXKaVETgSFuK2fvVp1TPOuV6BKBzSWJZg8v8qL/S/b1MVGGVxq2c
         V0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9bZD3SaxZIg50kqZf2JgTGCc/E7A0AbZyRY3ULvPJLk=;
        b=a5yixVYaa0Ej2j6b2T8c/eeFLglAjLi678GUlFH4GjkaqbJnlfcSB8ufP9uML5ejg0
         IdgmBsP+6l6f99c1a8LAFlKUM2GMktGkx3PgQhTMroA40dIDQA6Kygkc1GlWVUHLGv4t
         iavFuowT5gM6M51IZIjRt3prK5KFXWx+VhwTa2zlFIDINuxjODQ2r7bFqJvPfTvd2AHD
         I8fzJQ96HV7TWAEFMKtx5sx2uwaeFiDK+fySMZakB2vyWs2OoIRQ/nWvohS+I2X6aovE
         FJUzKAOWe7yfLA8/NtUHLqd8okV+IDY8iKS1rcy65StpFHkEuONxG2ou4ODbKWD4BFXf
         8k5w==
X-Gm-Message-State: APjAAAXenll+nwY7Hz+9WQFkmUdsR6JQ4nIhJE0L1qBcjNfx0gdH/65l
        p5+Ds3m0gyqVdjH7M92JKQb+ke94
X-Google-Smtp-Source: APXvYqxMWjgdyydvb77DT4ACBhlCdeiwqNXiccCrpUS10L9XVtDjHEBUGW+bGReqINHKuWAbFdJBig==
X-Received: by 2002:a17:906:cb94:: with SMTP id mf20mr90819705ejb.252.1577981655990;
        Thu, 02 Jan 2020 08:14:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g8sm6982053edm.78.2020.01.02.08.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 08:14:15 -0800 (PST)
Message-Id: <pull.509.git.1577981654.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Jan 2020 16:14:13 +0000
Subject: [PATCH 0/1] [PERF BUG] Fix size_mult option in fetch.writeCommitGraph
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I found this while doing some digging into fetch behavior and split commit
graphs. I had been running fetch.writeCommitGraph=true on my local repos for
a while and noticed that the commit-graph chains were much longer than
expected.

The reason is silly, and the commit message includes all the details.

This behavior exists since v2.24.0, so I'm not sure if it makes the bar for
v2.25.0 this late in the release cycle. At minimum, the change is very small
and unlikely to cause more pain.

This is only a performance bug, and the effect is relatively small. A large
list of commit-graph files slows down the commit lookup time as we need to
perform a linear number of binary searches. This only affects finding the
first commit(s) in a commit walk, as after that we can navigate quickly to
the correct position using graph_pos. When a user runs gc (with 
gc.writeCommitGraph=true, on by default), the chain collapses to a single
level, fixing the performance problem.

Thanks, -Stolee

Derrick Stolee (1):
  fetch: set size_multiple in split_commit_graph_opts

 builtin/fetch.c | 4 +---
 commit-graph.c  | 4 +++-
 2 files changed, 4 insertions(+), 4 deletions(-)


base-commit: 99c33bed562b41de6ce9bd3fd561303d39645048
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-509%2Fderrickstolee%2Ffetch-write-commit-graph-split-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-509/derrickstolee/fetch-write-commit-graph-split-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/509
-- 
gitgitgadget
