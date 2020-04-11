Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07983C2D0EC
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 01:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CF22082D
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 01:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gagawghg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgDKBDE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 21:03:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37421 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgDKBDD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 21:03:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id z6so4431594wml.2
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 18:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=vRujB7iPYsbIKlFGU6Uf0GnVzzuJwVuLI/QXycVvilE=;
        b=gagawghgaXmH8juXqAsnS1xS8D2gh3q/Hu8YVQB8r+rZXVUMvxbeWaW0dxc/W586Jd
         cbSWcfOJuJAJcDj0en4SASBYJFP82GRpoSmugkWYK9IgQPbXLH3s3Lk6Qy+UQTyIgfZZ
         1sjsEHoBR0dZ26Ag50SBbMiyVr4+4T/4zj8XWEKw6Dzqvakb/ZnFNOOkPCuBSAMpkzMJ
         FuaQPE/tzJr/MRH/IA894c59TILZWOQHrrtnfFrAq8vNbkyVS5faEK5LHPP6oOUGSBBj
         OmrUEVZhL53VThX6/4zR5u5mAlBrlcsZQKYIJJgA6LFpa/nQfAhc5NYGBUd5K0X8OUsJ
         8o1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vRujB7iPYsbIKlFGU6Uf0GnVzzuJwVuLI/QXycVvilE=;
        b=LBsICuR4tKQ7KuVWIfexdKqVOgRB8bHmAQBFYeta5HFPMtqAlMUQ2fx4R9GyUMSSWy
         zlK2ju+2dzB8VXqxjAhbS+7j8mnMjfLkyJ4e3bTpLYWyjGN59BdfrAcKo6WiMNVtOsZ4
         nbGP71glz+vN7cK2Qug/UaSyUiIeZtTLkC9xJnpsJzFarqidquik2dT5VihVIG85Ba7n
         nIkjlB0JHAEMbNa9j+ufEspsFQDh1Pef/zK0cChVSnvJaTLbo3Ju7CTjv6cFzJX3PZeF
         +/BUJS2fyM/zQ3lgSnJqFua6/kU395xAZ0kwNT6Z3tAQL3LffUXgSM0OSys5SUTTu9bX
         ZhLg==
X-Gm-Message-State: AGi0PubB/BYO7XWpalH0MGZMzYhnBnF/uJMKpZtmuxJqFM18dkrIuQQT
        Io9qqQN3IZpPgIamTatJdZqs1kTo
X-Google-Smtp-Source: APiQypKFLIqQm/0JjL5UcUOaxLiLgIWOACFJubl4nJVdxnRZCQI4nHuPshz3Gijc1aze7nHQRFzsYQ==
X-Received: by 2002:a1c:750a:: with SMTP id o10mr7468511wmc.161.1586566982539;
        Fri, 10 Apr 2020 18:03:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r3sm5217371wrm.35.2020.04.10.18.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 18:03:02 -0700 (PDT)
Message-Id: <pull.609.git.1586566981.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 11 Apr 2020 01:02:58 +0000
Subject: [PATCH 0/3] Integrate changed-path Bloom filters with 'git blame'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, jnareb@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the changed-path Bloom filters are relatively stable, then I propose
trying to build upon them as a way to discover any deficiencies. Also, it's
good to use them when we can.

The goal I set out to achieve was to use Bloom filters as much as possible
in git blame. I think I have achieved most of that, except I did not
integrate it with the -C mode. In that case, the blob-diff computation takes
a majority of the computation time, so short-circuiting the tree diff using
Bloom filters. Also, it's just really complicated. If someone else thinks
there is an easy win there, then please go ahead and give it a try with the
extra logic presented here in PATCH 3.

While I was playing around with Bloom filters and git blame, I purposefully
got it working with some scenarios but not all. Then I tried to trigger a
failing build in the blame tests using GIT_TEST_COMMIT_GRAPH=1 and 
GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1. But the tests all succeeded!

Examining the data, I see that the commit-graph didn't have the Bloom filter
chunks at all. This is because we are not setting the flag to write them in
the right spot. The GIT_TEST_COMMIT_GRAPH=1 variable triggers a commit-graph
write during git commit, so we need to update the code there instead of just
inspecting the variable in git commit-graph write. (This is PATCH 2.)

By updating this variable, I saw some test failures in other tests regarding
non-exact pathspecs. I fixed these in PATCH 1 so we keep clean builds.

I based this change on [1] but it would apply cleanly (and logically) on
gs/commit-graph-path-filter

Thanks, -Stolee

[1] 
https://lore.kernel.org/git/pull.601.v2.git.1586437211842.gitgitgadget@gmail.com/

Derrick Stolee (3):
  revision: complicated pathspecs disable filters
  commit: write commit-graph with bloom filters
  blame: use changed-path Bloom filters

 blame.c          | 139 ++++++++++++++++++++++++++++++++++++++++++++---
 blame.h          |   6 ++
 builtin/blame.c  |  10 ++++
 builtin/commit.c |   4 +-
 revision.c       |   9 +++
 5 files changed, 158 insertions(+), 10 deletions(-)


base-commit: f4df00a0dd448edce0e854a97f63598fefe27d27
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-609%2Fderrickstolee%2Fbloom-blame-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-609/derrickstolee/bloom-blame-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/609
-- 
gitgitgadget
