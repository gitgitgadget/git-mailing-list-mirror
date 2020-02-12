Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B45C352A4
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 19:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858E22082F
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 19:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNfqcBRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgBLTTO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:19:14 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:51689 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBLTTO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 14:19:14 -0500
Received: by mail-wm1-f50.google.com with SMTP id t23so3613547wmi.1
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 11:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=F4hEVXLuXIRK/E4EdMJKxYmJ98cSVHXHJUVXCc4MVH8=;
        b=RNfqcBRKbVlYt9dgKeA3ZNIsR2BJ71TgUz88Vh/l3wHJt55O/VXu3kTtBsoxpGgCJ+
         svbEBYEbbNqt9tOchE3MsKqDYG2Hi6LCN4qs95FFCqlj5hT02Dw2gmgLiRzjo/+K6W/N
         OR9BHL0Q5AN1NPIhLvQnPefMZwAxcbwfKCp6AXlXMIFsscFvxYI5dNcpuLzUmrhjje7o
         0B3AvFDmeE0TAHilRc6tVoMYk0EfFIl2GX2rrY+NIRS4gnvZr1KmLBHaWyBPO5xjbqUN
         iEgfHsAR/byd4DtChJOnvmV8gwBTUcfpNoWgUmxFJQmm16bfnAwEG8UyX9WqX3XWZmAt
         hHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F4hEVXLuXIRK/E4EdMJKxYmJ98cSVHXHJUVXCc4MVH8=;
        b=I0xsT3SCRdO2/A4X5iJD2zitOQG+pdU1DH805CscJZ1s7HcSFzQejhTa2QjanqGwsI
         kWKCp9etXZ4tWoTTrbOnlnRiClSkbH3hMglrjfoEKyhBT3GI0GdUsWLeVHPBMhyS9Bf4
         0LIlqynEoxOyvqBLOiGJenf5s9mL6i0iKxKBb0pMk3gQQkx2cG1ZQzhGNzGN32AdkNLq
         MRtxsloq5lquoak7juQV4C4/vfKgWYy9mtwx/z6YmEAJrBB6dYUwhfJCzeElsjUr/VDi
         cXiOivEzMfgDM4QrTNSSRHI2xGRaKDjV+ucjaCi64L+A9s1cGtCXjj9TT8S1TYezUah1
         81hQ==
X-Gm-Message-State: APjAAAWF5d2G6qZrukzH/TxXpwNxF0Y//965yjY+TiKnatqwyr2SEZ9b
        HMGT03P6gSOLeAeoIyV/WMx+VdY+
X-Google-Smtp-Source: APXvYqxoS6AfMlcsDYl19JbPl7kGCGiVFuDHO9WwhD7L59pTAcGjRo+k6cZbqZ1m+Qg4LKhuv7cR2Q==
X-Received: by 2002:a7b:c1da:: with SMTP id a26mr578805wmj.155.1581535152286;
        Wed, 12 Feb 2020 11:19:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p5sm1732538wrt.79.2020.02.12.11.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 11:19:11 -0800 (PST)
Message-Id: <pull.545.git.1581535151.gitgitgadget@gmail.com>
From:   "Parth Gala via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Feb 2020 19:19:06 +0000
Subject: [PATCH 0/5] object.c: localize global the_repository variable into r
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Parth Gala <parthpgala@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have created this commit in response to 
https://github.com/gitgitgadget/git/issues/379#issue-503866117. All the
functions in object.c which relied on 'the_repository' have been modified.
The functions calling these functions in object.c consisted calls to other
functions using 'the_repository' as well, and although I intended to use 'r'
at all those instances, I thought it would make more sense when we would
deal with their callee functions in another similar patch. What do you think
?

Signed-off-by: Parth Gala parthpgala@gmail.com [parthpgala@gmail.com]

Parth Gala (5):
  object.c: get_max_object_index and get_indexed_object accept 'r'
    parameter
  object.c: lookup_unknown_object() accept 'r' as parameter
  object.c: parse_object_or_die() accept 'r' as parameter
  object.c: clear_object_flags() accept 'r' as parameter
  object.c: clear_commit_marks_all() accept 'r' as parameter

 builtin/checkout.c               |  3 ++-
 builtin/fsck.c                   |  8 +++++---
 builtin/grep.c                   |  6 ++++--
 builtin/index-pack.c             |  5 +++--
 builtin/log.c                    |  3 ++-
 builtin/name-rev.c               |  5 +++--
 builtin/pack-objects.c           |  3 ++-
 builtin/prune.c                  |  3 ++-
 bundle.c                         |  8 +++++---
 http-push.c                      |  3 ++-
 object.c                         | 32 ++++++++++++++++----------------
 object.h                         | 12 ++++++------
 pack-bitmap.c                    |  5 +++--
 reachable.c                      |  6 ++++--
 refs.c                           |  3 ++-
 revision.c                       |  3 ++-
 shallow.c                        | 13 ++++++++-----
 t/helper/test-example-decorate.c |  7 ++++---
 upload-pack.c                    | 19 ++++++++++++-------
 walker.c                         |  3 ++-
 20 files changed, 89 insertions(+), 61 deletions(-)


base-commit: 0ad714499976290d9a0229230cbe4efae930b8dc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-545%2FParthGala2k%2Flocalize-the_repository-variable-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-545/ParthGala2k/localize-the_repository-variable-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/545
-- 
gitgitgadget
