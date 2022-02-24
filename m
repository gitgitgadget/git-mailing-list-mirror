Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301A2C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 22:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbiBXWfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 17:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbiBXWfK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 17:35:10 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C971E016F
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:34:36 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l2-20020a7bc342000000b0037fa585de26so4230278wmj.1
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y95ZMwIHo9+VnpX5HPp/0PS46dpHI3rJjbv80WTdFp4=;
        b=gWCJaBU5bTIZFPi/cQbIOkRiDdPiOZOiL6b62rhvHp/BtozTkRTAFAGGnRowsC4hZl
         Bzs7MDLAt+N6imLL977NtX07j8AqQ3xlGEGUxIL0kqA29/4moWWhWhh94df8SXJ03mxY
         XXRA0vmcYrjcSsk4z5Zxkm1uKtaJhA+hSrsvteHneFM9vej/VNI93gIkDuud5860WCz2
         15wnEpj/wIv3ocly85DOoY0W+C0sooPUL64DIlxxXdhECRLD0iYEqcLRtlGTs4vML4ka
         YxiApczsrDI+5t5xwp78lrwRkeZTHnMFe6XvVH3P8hzcEXhMeTfPQMbWpGwhQdfGvBLu
         FWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Y95ZMwIHo9+VnpX5HPp/0PS46dpHI3rJjbv80WTdFp4=;
        b=QmAyqqgo7RCkr+glfV5WutFfrMSx/FgyN2UmOrA3z4ssKqGHvNv3yNLusi2nUrTIf+
         K38zpkxbkiNnl45WCPLFK3iOTwnnCV8powlLN6qpjWQl09SEKc1RQjp2QbLrIhjqAGqV
         hFs3RtbiD+LEPsijXSWDHXs1znS7xXsBdVf2QHm6XknS+nixaNO9/WFJov5R9jmZfIKa
         QozkSAm4oV1jHrCgml8U1kNIH5aTwunw9/EaydqLrlE/w/uVdgsht6Po7HZvBPAry5Ja
         ACfl6QkhZ8mHYdxw+RN/lnvjE0qBVVzKJcTmG/fdP33diS2t9qK0Na+C0lmPXsqz7hhE
         CXPA==
X-Gm-Message-State: AOAM532FcbLG9/aVbKb7zRxhJzZImyHrwv6lrKhwGka97VNCF9y6RIW/
        Lcght9u4BEp3rsj5+nplkJQJorH3sTE=
X-Google-Smtp-Source: ABdhPJwx7p9QtDdDmtdPVLd5z/c8sSfvWmc6rT5JZCwJjxLhpRMVETukt6CK3FlL6oMZMKyyh/JcAg==
X-Received: by 2002:a05:600c:1e85:b0:381:2d3f:d620 with SMTP id be5-20020a05600c1e8500b003812d3fd620mr184001wmb.11.1645742074885;
        Thu, 24 Feb 2022 14:34:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b0037c08110db7sm585946wmq.9.2022.02.24.14.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 14:34:34 -0800 (PST)
Message-Id: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 22:34:26 +0000
Subject: [PATCH v2 0/7] Sparse index: integrate with 'read-tree'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like previous integrations [1] [2], this series allows 'git read-tree' to
operate using a sparse index.

The first two patches are bugfixes for issues found while implementing the
'read-tree' integration:

 * The first (patch 1/7) fixes an edge case in which a repo with no in-cone
   files or directories would have its root collapsed into a sparse
   directory; the fix ensures the root directory is never collapsed into a
   sparse directory.
 * The second (patch 2/7) corrects the 'git status' reporting of changes
   nested inside the subdirectory of a sparse directory, ensuring that the
   modified file (not the subdirectory) is correctly reported as having
   changes.

The remainder of the series focuses on utilizing the sparse index in 'git
read-tree'. After some baseline behavior-establishing tests (patch 3/7),
sparse index usage is trivially enabled (patch 4/7) for 'read-tree' except:

 * usage with '--prefix'
 * two- and three-way merge

These cases require additional changes in order to work as expected (i.e.,
outwardly matching non-sparse index sparse-checkout). For the former, the
sparse index can be enabled as long as the index is expanded when the prefix
is a directory outside the sparse cone (patch 5/7). For the latter, sparse
directories that cannot be trivially merged must have their contents merged
file-by-file, done by recursively traversing the trees represented by the
sparse directories (patches 6/7 & 7/7).


Changes since V1
================

 * switched an empty string check from '!strlen(path)' to the
   slightly-less-expensive '!*path'

Thanks!

 * Victoria

[1]
https://lore.kernel.org/git/pull.1109.v2.git.1641924306.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/pull.1048.v6.git.1638201164.gitgitgadget@gmail.com/

Victoria Dye (7):
  sparse-index: prevent repo root from becoming sparse
  status: fix nested sparse directory diff in sparse index
  read-tree: expand sparse checkout test coverage
  read-tree: integrate with sparse index
  read-tree: narrow scope of index expansion for '--prefix'
  read-tree: make two-way merge sparse-aware
  read-tree: make three-way merge sparse-aware

 builtin/read-tree.c                      |  10 +-
 dir.c                                    |   7 +-
 t/perf/p2000-sparse-operations.sh        |   1 +
 t/t1092-sparse-checkout-compatibility.sh | 129 +++++++++++++++++++++++
 unpack-trees.c                           | 121 ++++++++++++++++++++-
 wt-status.c                              |   9 ++
 6 files changed, 268 insertions(+), 9 deletions(-)


base-commit: e6ebfd0e8cbbd10878070c8a356b5ad1b3ca464e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1157%2Fvdye%2Fsparse%2Fread-tree-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1157/vdye/sparse/read-tree-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1157

Range-diff vs v1:

 1:  90da1f9f33a ! 1:  744668eeece sparse-index: prevent repo root from becoming sparse
     @@ Commit message
          non-cone sparse-checkouts), the new check does not cause additional changes
          to how sparse patterns are applied.
      
     +    Helped-by: Derrick Stolee <derrickstolee@github.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## dir.c ##
     @@ dir.c: static int path_in_sparse_checkout_1(const char *path,
      +	 * patterns, or the patterns are of the wrong type.
       	 */
      -	if (init_sparse_checkout_patterns(istate) ||
     -+	if (!strlen(path) ||
     ++	if (!*path ||
      +	    init_sparse_checkout_patterns(istate) ||
       	    (require_cone_mode &&
       	     !istate->sparse_checkout_patterns->use_cone_patterns))
 2:  c21c9b9be34 = 2:  f0cff03b95d status: fix nested sparse directory diff in sparse index
 3:  ac42ae21d4a = 3:  ffe0b6aff2b read-tree: expand sparse checkout test coverage
 4:  5ee193bfa87 = 4:  cb7e0cf419c read-tree: integrate with sparse index
 5:  bea482b6b28 = 5:  4f05fa70209 read-tree: narrow scope of index expansion for '--prefix'
 6:  9fdcab038b2 = 6:  94c2aad2f93 read-tree: make two-way merge sparse-aware
 7:  1502e9acb32 = 7:  c4080e99d6e read-tree: make three-way merge sparse-aware

-- 
gitgitgadget
