Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D98C433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 01:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37D7920725
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 01:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SjOj2sls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgGJBmx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 21:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgGJBmw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 21:42:52 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECB5C08C5CE
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 18:42:52 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id l19so3291872qke.6
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 18:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hPGzFQaPorhNkIjOwSmno9136wLX3eSr/7lzSNdKENQ=;
        b=SjOj2slsi6/6O+P4P1b5zzSuuyNHVwBRTl1QM5YJNITOqCZewBVS6PFMXeRh50rqNx
         IY6mQESr6mPli/CWZ3jAfhfOBh0EixmA3CroL1hoVzbl90xOkc7Ds7xrGHxqC7lAFtN5
         lBWnMNVqv2s4mXV3DCe5EeZhtPzL13s5699LzaIe+4OW2ULphXmwSOpuP06XSh11fr03
         DpSALwfMlRBjyx7NmOIKxrvm4vkI+Dn8cJZChDHvhfnv82Dk9LQrtizC1Uwrod4V4Tdh
         6P+5dNG3ecrzxgjEJ6+dM9VDhNlEHAIodyTQAqBkw4Q0lYTt/Ap1Cqt/eH92jfZN1IDO
         3P8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hPGzFQaPorhNkIjOwSmno9136wLX3eSr/7lzSNdKENQ=;
        b=kVBRQ9PC45EdsO7c9scOeUEfG37JJ5gyalWEjig13m8y9c8XyIFu0ZhJA0qICEFoJQ
         m8+JOINpHZr31tGg2b8b1ov41Mnz9iuBJh5X96Xi6EshrdcwvrUQ05KFnDg6UDLPFN35
         Fxviha5GJFfUrVJ7c8mtraQAG+luvGWNvxrNsnAOekdxXF6RYEUaMOSBNXLKq5nx9ojY
         1fPk5io/JrYjMR4xODydxnimCUlQlpbcnXgFNxLWVLIJfbcL2hoqUCiXAPIGFtP8lipI
         d90FoEYAL6FehKmTlHIdkK09MCc/Mqc2VYNPC93HZ2tueNpvr649Boks6HWaiC16tpMX
         DS6g==
X-Gm-Message-State: AOAM531owBPdVGrjof/8anL9MvgLtcgp42F8OR0tM9XZqF2b7b3I/tRh
        ykr6uvAUNnkIQDsoSfdYgLFaiGqAKsYBpMopAEUJCHS46THdivdfkLLV0LJd0qQesV0rtxnIEV/
        3ktBOgYRMlKPCfsn5Jj01ayLimnb9XHFkMOOl+4vsjnvObALSepSnrVzLQ5MGUAmAnghROV1FkA
        ==
X-Google-Smtp-Source: ABdhPJx1uSIPxdiI5X5mMTL+xgJckUj7Cb5smhMkIjmoPRZS1OVlqTMOjipQmEObVqhuVAcUAr7aIGXanErCIy8qupU=
X-Received: by 2002:a05:6214:13c6:: with SMTP id cg6mr66596743qvb.160.1594345371565;
 Thu, 09 Jul 2020 18:42:51 -0700 (PDT)
Date:   Thu,  9 Jul 2020 18:42:40 -0700
Message-Id: <20200710014242.1088216-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH 0/2] enable progress traces even when quiet
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a simple but large-scale change, because it changes an API and
fixes all callers. The bulk of the change is in the first patch,
including justification in the commit message; the second patch is only
tidying I noticed while fixing compiler errors from the former. If that
churn is unwanted I'm happy to drop it.

I wanted to do this change because we received reports that 'git clone'
was only logging traces sometimes, not all the time. An alternative
approach would have been to move the 'if (verbose)' wrappers to surround
calls to 'display_progress()' - but this would have worked in
builtin/index-pack.c (where the reported bug was happening) only because
of that code's use of static global flags. Placing the onus on the
caller to ensure that trace collection occurs, even in quiet mode, is
flimsy and error-prone. Adding another flag to 'struct progress' ensures
that trace collection is consistent regardless of how the caller
organizes their code.

In a couple of cases, this does result in some additional work
calculating titles and object counts where previously there wasn't;
however, since those values will be used by the trace logger, I don't
consider it a waste of resources.

Finally, 'git rev-list' has one weird case where it takes the progress
title as an argument (i.e. 'git rev-list --progress "Working hard" ...')
and also null-checks that string to decide whether to calle
'start_progress()' - in this case, I added a placeholder text for the
traces to show. Bikeshedding welcome here.

 - Emily

Emily Shaffer (2):
  progress: create progress struct in 'verbose' mode
  progress: remove redundant null-checking

 builtin/blame.c             |   4 +-
 builtin/commit-graph.c      |   8 +-
 builtin/fsck.c              |  25 +++----
 builtin/index-pack.c        |  16 ++--
 builtin/log.c               |   4 +-
 builtin/pack-objects.c      |  18 ++---
 builtin/prune.c             |   4 +-
 builtin/rev-list.c          |   9 ++-
 builtin/unpack-objects.c    |   3 +-
 commit-graph.c              | 143 +++++++++++++++++-------------------
 delta-islands.c             |   4 +-
 diffcore-rename.c           |   9 +--
 entry.c                     |   2 +-
 midx.c                      |  43 +++++------
 pack-bitmap-write.c         |   8 +-
 pack-bitmap.c               |   5 +-
 preload-index.c             |   7 +-
 progress.c                  |  27 ++++---
 progress.h                  |  10 ++-
 prune-packed.c              |   4 +-
 read-cache.c                |  15 ++--
 t/helper/test-progress.c    |   6 +-
 t/t0500-progress-display.sh |  27 +++++++
 unpack-trees.c              |  14 ++--
 walker.c                    |   4 +-
 25 files changed, 217 insertions(+), 202 deletions(-)

-- 
2.27.0.383.g050319c2ae-goog

