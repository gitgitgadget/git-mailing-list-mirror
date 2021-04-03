Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83C6C433ED
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 09:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732786120F
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 09:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbhDCJEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 05:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbhDCJEd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 05:04:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDE0C0613E6
        for <git@vger.kernel.org>; Sat,  3 Apr 2021 02:04:29 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id dm8so7574835edb.2
        for <git@vger.kernel.org>; Sat, 03 Apr 2021 02:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=EGu7VJN1HXEjMUjwL9LA+dCLpM5oU1txuppYbSlYdgw=;
        b=UnhdrTe7A/T1+qMuWWv16tOI/dV1/7Xzf7oMsOZcKuKPKZqKlKplfFAKeup63oPDLd
         QHHq7I4EhgX2SYrvh1CM2Gx2su9nJzBScaBZQ20Y8KH02zJfo0ebnqrJG/BI0eqBtTxU
         wsoZsp3YYNrvxyHugZabPEu6Go+BidvDOD57525Rt8A5QozSF+H8xz1NtqmeYBNIwQAN
         27ZQS4jYGDKFh8FrX2WxwmIxs90yXlbEuFB7K/jJvXfm104FXowKOhZoKzL34bfZjiw5
         28O0ht2O7PEDP7RkGmbgmpNwjK4A5rlHZOeEk/Dr5Zl2NSAu01/CHVGOp3zQlEMXxRVh
         2Wxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=EGu7VJN1HXEjMUjwL9LA+dCLpM5oU1txuppYbSlYdgw=;
        b=KsMuLGIj0SYdEu5odkNbs8H8LRFhmqA/jA8lKvSTu38qkRArPVCHdVJU6+Fzb/lNAk
         Z3kSGCPwV9o9goEStIS4+HOqozO7G/AiS6ZqW0AoASH5XCuHbjqt2aiEowtAbSYG27NN
         /gRjPex6GrktOeRh75EB/pFYvChBqT2zIulfzsCwGSTLH4tDdZtnn/MF28agH/SAXIV4
         8YQfC0ZtEBXRLWDBg1dmKLU6mPk3M94zQk4zIAQGxrrDY9Ib4Upq6/lsGOW6/BWnEwJ+
         NaLSADhqT/ebe5rl8sD3ZZkEdhnAUJYuEGTpnTBz3iGIZzIKvdTL3u9MrYZF3wJOOwgR
         ppFQ==
X-Gm-Message-State: AOAM531dp+k9y7mWsW7u3Rom4JbrgRP4gNQ53vhAmxJrAAPGL+rWpiGT
        ypAL1IEC0ginJ5wZZtigQ1JPrsCCGCQ=
X-Google-Smtp-Source: ABdhPJz4P2qF89lp1Sm94G6DIvd2yVtcaOd3JYgsg+vQzTvMG/yn4pPSk3zH2MMp5ngxb4wvFaf+Vw==
X-Received: by 2002:a05:6402:4245:: with SMTP id g5mr20074252edb.306.1617440668078;
        Sat, 03 Apr 2021 02:04:28 -0700 (PDT)
Received: from szeder.dev (94-21-58-238.pool.digikabel.hu. [94.21.58.238])
        by smtp.gmail.com with ESMTPSA id h8sm6697827ede.25.2021.04.03.02.04.27
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:04:27 -0700 (PDT)
Date:   Sat, 3 Apr 2021 11:04:25 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: rather slow 'git repack' in 'blob:none' partial clones
Message-ID: <20210403090412.GH2271@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

here are trace timings of running 'git gc' in a "normal" and in a
'blob:none' partial clone:

  $ git clone --bare https://github.com/git/git git-full.git
  $ GIT_TRACE_PERFORMANCE=2 /usr/bin/time --format='elapsed: %E  max RSS: %Mk' git -C git-full.git/ gc
  10:35:24.007277 trace.c:487             performance: 0.001550225 s: git command: /usr/local/libexec/git-core/git pack-refs --all --prune
  10:35:24.044641 trace.c:487             performance: 0.035631270 s: git command: /usr/local/libexec/git-core/git reflog expire --all
  10:35:24.061070 read-cache.c:2315       performance: 0.000008506 s:  read cache ./index
  Enumerating objects: 305283, done.
  Counting objects: 100% (305283/305283), done.
  Delta compression using up to 4 threads
  Compressing objects: 100% (75016/75016), done.
  Writing objects: 100% (305283/305283), done.
  Total 305283 (delta 227928), reused 305283 (delta 227928), pack-reused 0
  10:35:32.604546 trace.c:487             performance: 8.555651283 s: git command: /usr/local/libexec/git-core/git pack-objects --local --delta-base-offset objects/pack/.tmp-2946975-pack --keep-true-parents --honor-pack-keep --non-empty --all --reflog --indexed-objects --unpack-unreachable=2.weeks.ago
  10:35:32.680597 trace.c:487             performance: 8.633068356 s: git command: /usr/local/libexec/git-core/git repack -d -l -A --unpack-unreachable=2.weeks.ago
  10:35:32.683130 trace.c:487             performance: 0.000959377 s: git command: /usr/local/libexec/git-core/git prune --expire 2.weeks.ago
  10:35:32.684401 trace.c:487             performance: 0.000180173 s: git command: /usr/local/libexec/git-core/git worktree prune --expire 3.months.ago
  10:35:32.685730 trace.c:487             performance: 0.000263898 s: git command: /usr/local/libexec/git-core/git rerere gc
  10:35:33.514816 trace.c:487             performance: 9.511597988 s: git command: git -C git-full.git/ gc
  elapsed: 0:09.51  max RSS: 358964k

  $ git clone --bare --filter=blob:none https://github.com/git/git git-partial.git
  $ GIT_TRACE_PERFORMANCE=2 /usr/bin/time --format='elapsed: %E  max RSS: %Mk' git -C git-partial.git/ gc
  10:35:47.637735 trace.c:487             performance: 0.000872539 s: git command: /usr/local/libexec/git-core/git pack-refs --all --prune
  10:35:47.675498 trace.c:487             performance: 0.036246403 s: git command: /usr/local/libexec/git-core/git reflog expire --all
  Enumerating objects: 188205, done.
  Counting objects: 100% (188205/188205), done.
  Delta compression using up to 4 threads
  Compressing objects: 100% (66520/66520), done.
  Writing objects: 100% (188205/188205), done.
  Total 188205 (delta 119967), reused 188205 (delta 119967), pack-reused 0
  10:35:50.081709 trace.c:487             performance: 2.402625839 s: git command: /usr/local/libexec/git-core/git pack-objects --local --delta-base-offset objects/pack/.tmp-2946990-pack
  10:35:50.100131 read-cache.c:2315       performance: 0.000009979 s:  read cache ./index
  10:37:04.973541 trace.c:487             performance: 74.885793630 s: git command: /usr/local/libexec/git-core/git pack-objects --local --delta-base-offset objects/pack/.tmp-2946990-pack --keep-true-parents --honor-pack-keep --non-empty --all --reflog --indexed-objects --exclude-promisor-objects --unpack-unreachable=2.weeks.ago
  Removing duplicate objects: 100% (256/256), done.
  10:37:07.482791 trace.c:487             performance: 79.804973525 s: git command: /usr/local/libexec/git-core/git repack -d -l -A --unpack-unreachable=2.weeks.ago
  10:37:07.549333 trace.c:487             performance: 0.008025426 s: git command: /usr/local/libexec/git-core/git prune --expire 2.weeks.ago --exclude-promisor-objects
  10:37:07.552499 trace.c:487             performance: 0.000362981 s: git command: /usr/local/libexec/git-core/git worktree prune --expire 3.months.ago
  10:37:07.554521 trace.c:487             performance: 0.000273834 s: git command: /usr/local/libexec/git-core/git rerere gc
  10:37:10.168233 trace.c:487             performance: 82.533331484 s: git command: git -C git-partial.git/ gc
  elapsed: 1:22.54  max RSS: 1891832k

Notice the ~9s vs. 82s runtime and ~350M vs. 1.9G memory consumption
increase.  What's going on here?

Also note that that second 'git pack-objects' invocation doesn't show
any progress for ~75s.

FWIW, doing the same in a 'tree:0' partial clone is fast.

