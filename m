Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFA7C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 17:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243576AbiBWRzo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 12:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243573AbiBWRzn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 12:55:43 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B7464F6
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:55:14 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j22so14838140wrb.13
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=D3qwZC/Mpfs6m3rbEr+0KW4r8PevEp+qRCR8Bm/+bSU=;
        b=nTjcDv0pgiAgxbGDN/7xtST6DQUHWt9ZdSAij3JcLsUTwOEandam3GoSoB+ksgR+Bl
         Tz0k91lr9SfbxEgtfErpr8N8qG/k0LwSWQ5VhFuSbogjBx0KuvxV5v6OiS8bzAj0jt6F
         /HLowGlYJUMHFMEI1SwDn22rW55E9IGuOanwwULskWN54y4m3Mznw9QVZpQ+X1n4zVCg
         5T23t1fpQZswK9n6Erd3/lt16UtWmR7vZth/rpxnnj5zqXjH9+D5qaywOMsniLzNLzQi
         YDWOFszPxfGLyylw2Wk+zPFaUG8sc15ad3ZPe8C20+WB5p4M/+8ZHcoRtP7UjXVRoxKo
         TxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D3qwZC/Mpfs6m3rbEr+0KW4r8PevEp+qRCR8Bm/+bSU=;
        b=wkFYwgSB6HPyYbHzJeTp5mfszBJWWyChymIuJQeLnYZ9ZmkgMjuSaibOGRD2Drcsqn
         BFeDM0dKG+unhWbdP0cDLwQhhbdfePqcabPdCgaqRiom22Ly6G9AaG2DJE6hJW796MZT
         EfEOxtS9dhZemrr2VINcddqq1r+5jWV1c03iC/BkcmONS/VnP3PwQBcA5exvOCMT2uay
         1IYOFw09/9OlO/ckAhKKmbEzp0mpoCPAW5wzfUpOMnTrNFEQTRF3v4RFPu29GWvT8wzr
         xxsrDFFMO86AdM4VtA8en4z6YpA4uCW7nbQn/rUTaYnGEVtoKmFiPzOU+QazyYJnRhUG
         2LVw==
X-Gm-Message-State: AOAM533cpKN+9n+o9mDaNShauF1GQEEz/BYmv9N4mKytJHXvzHoPxrhC
        n0DLFezrmpPbLNu+86uyzFgil69s9I4=
X-Google-Smtp-Source: ABdhPJyfM7RdaAhznlLBh61+2NZElC8Z0aa9kCmDOQSK+tPAmIPFppGDdoFuisdNw5ywKmQtLClF5Q==
X-Received: by 2002:adf:f007:0:b0:1ed:becf:c59d with SMTP id j7-20020adff007000000b001edbecfc59dmr548737wro.203.1645638912889;
        Wed, 23 Feb 2022 09:55:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z4sm184955wrr.82.2022.02.23.09.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 09:55:12 -0800 (PST)
Message-Id: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 17:55:00 +0000
Subject: [PATCH 00/11] Partial bundles
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While discussing bundle-URIs [1], it came to my attention that bundles have
no way to specify an object filter, so bundles cannot be used with partial
clones.

[1]
https://lore.kernel.org/git/7fab28bf-54e7-d0e9-110a-53fad6244cc9@gmail.com/

This series provides a way to fix that by adding a 'filter' capability to
the bundle file format and allowing one to create a partial bundle with 'git
bundle create --filter=blob:none '.

There are a couple things that I want to point out about this implementation
that could use some high-level feedback:

 1. I moved the '--filter' parsing into setup_revisions() instead of adding
    another place to parse it. This works for 'git bundle' but it also
    allows it to be parsed successfully in commands such as 'git diff' which
    doesn't make sense. Options such as '--objects' are already being parsed
    there, and they don't make sense either, so I want some thoughts on
    this.

 2. If someone uses 'git clone partial.bdl partial' where 'partial.bdl' is a
    filtered bundle, then the clone will fail with a message such as

fatal: missing blob object '9444604d515c0b162e37e59accd54a0bac50ed2e' fatal:
remote did not send all necessary objects

This might be fine. We don't expect users to clone partial bundles or fetch
partial bundles into an unfiltered repo and these failures are expected. It
is possible that we could put in custom logic to fail faster by reading the
bundle header for a filter.

Generally, the idea is to open this up as a potential way to bootstrap a
clone of a partial clone using a set of precomputed partial bundles.

Thanks, -Stolee

Derrick Stolee (11):
  index-pack: document and test the --promisor option
  revision: put object filter into struct rev_info
  pack-objects: use rev.filter when possible
  pack-bitmap: drop filter in prepare_bitmap_walk()
  list-objects: consolidate traverse_commit_list[_filtered]
  MyFirstObjectWalk: update recommended usage
  bundle: safely handle --objects option
  bundle: parse filter capability
  rev-list: move --filter parsing into revision.c
  bundle: create filtered bundles
  bundle: unbundle promisor packs

 Documentation/MyFirstObjectWalk.txt | 44 ++++++---------
 Documentation/git-index-pack.txt    |  8 +++
 builtin/pack-objects.c              |  9 +--
 builtin/rev-list.c                  | 29 +++-------
 bundle.c                            | 87 ++++++++++++++++++++++++-----
 bundle.h                            |  3 +
 list-objects-filter-options.c       |  2 +-
 list-objects-filter-options.h       |  5 ++
 list-objects.c                      | 25 +++------
 list-objects.h                      | 12 +++-
 pack-bitmap.c                       | 24 ++++----
 pack-bitmap.h                       |  2 -
 reachable.c                         |  2 +-
 revision.c                          | 11 ++++
 revision.h                          |  4 ++
 t/t5300-pack-object.sh              |  4 +-
 t/t6020-bundle-misc.sh              | 48 ++++++++++++++++
 17 files changed, 215 insertions(+), 104 deletions(-)


base-commit: 45fe28c951c3e70666ee4ef8379772851a8e4d32
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1159%2Fderrickstolee%2Fbundle%2Fpartial-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1159/derrickstolee/bundle/partial-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1159
-- 
gitgitgadget
