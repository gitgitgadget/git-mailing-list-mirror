Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CF2C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 14:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiLGOeu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 09:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiLGOer (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 09:34:47 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3E449085
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 06:34:45 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m4-20020a05600c3b0400b003d1cb516ce0so1156569wms.4
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 06:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3lbsUXsX4QDHLsVyWRGwYr1rFpXg7abGuNXULKPQgo=;
        b=Leugf6vrly/iyC6OIvKu4WtuP1onDBuGS3vNcj/0j6AQaWKihM3mXAKQjVaKtIYcFr
         JqkT1wC3ulJXXLOEkGZy5A4ej5vS9UWjGAokkwu556c5RLZzo6R0OnZPiNqYfStqDGlU
         dbk9qln0pPIkYm2uiD1JVrPwiw1aM4/wrzSdJS8twQWMKtSnYdUbCLDfR2ah45vL7qXm
         m1PmZiLorpPqMJoBanztlKWNEbwkOQxIcvVbeWngviRGe6fjYTag/7eeR8Hw1gnTYxFf
         2tnlWCt934lTKPftZQcvXw6QIS1l+79oR/Cv95z6NU0Qdhjw0iAkkobMbRdYA0sxqsFn
         YkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3lbsUXsX4QDHLsVyWRGwYr1rFpXg7abGuNXULKPQgo=;
        b=N2NYh8J2rO+7Mq8yvdkON8XvKf7fEQFYrU+Ymq42ZYBwAeMjVZFg5oHarUdQq9pRlC
         8G/kIFnZjU4eGDrZof0jGYdBGXfQbZrHAG2klm79Jbg0YWmRwEW360xHNiiZzPniGc50
         YF0koIxD3EXIqvvVR7lhlaKNYi16jUsLvr7T4kHFQcUL1/4lLeJdn842pd3MMv7ITXty
         dAitqlkMCrVtqACMSDOKWeFYKEZMf5ysAU6OjeIs4yi4Crn0q8VncZD2GHzPfFgL6rGn
         BQJRNsmSYvogglyyYQ5gHGyCl84svo9J2INAlIDxsGSw1ldaDlrwBTuZAqfdVpWiZA3Z
         kPLA==
X-Gm-Message-State: ANoB5pmNM5fx5gm2cqVFktO1GlU0dzy+HULNt8SQ6PjIOCu5IHoY2UO9
        f6HmrH9OrZBvxfiC3gbFwejhacaiPjw=
X-Google-Smtp-Source: AA0mqf7Pd6edRLV+J0U78CgIo72guJSYSUalkdQghMf4Ro23bPjphPO3lxZA09bvcQpdRGiufd3nYA==
X-Received: by 2002:a1c:e903:0:b0:3a8:4d01:28e8 with SMTP id q3-20020a1ce903000000b003a84d0128e8mr54372561wmc.94.1670423683819;
        Wed, 07 Dec 2022 06:34:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l5-20020a5d5605000000b002367ad808a9sm19549700wrv.30.2022.12.07.06.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:34:42 -0800 (PST)
Message-Id: <472481561f03900fb519065d88ae8af910bea794.1670423680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1440.git.1670423680.gitgitgadget@gmail.com>
References: <pull.1440.git.1670423680.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Dec 2022 14:34:37 +0000
Subject: [PATCH 1/4] ci: use a newer `github-script` version
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The old version we currently use runs in node.js v12.x, which is being
deprecated in GitHub Actions. The new version uses node.js v16.x.

Incidentally, this also avoids the warning about the deprecated
`::set-output::` workflow command because the newer version of the
`github-script` Action uses the recommended new way to specify outputs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 .github/workflows/main.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 5262823eb1c..43d47824dd3 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -37,14 +37,14 @@ jobs:
           echo "::set-output name=enabled::$enabled"
       - name: skip if the commit or tree was already tested
         id: skip-if-redundant
-        uses: actions/github-script@v3
+        uses: actions/github-script@v6
         if: steps.check-ref.outputs.enabled == 'yes'
         with:
           github-token: ${{secrets.GITHUB_TOKEN}}
           script: |
             try {
               // Figure out workflow ID, commit and tree
-              const { data: run } = await github.actions.getWorkflowRun({
+              const { data: run } = await github.rest.actions.getWorkflowRun({
                 owner: context.repo.owner,
                 repo: context.repo.repo,
                 run_id: context.runId,
@@ -54,7 +54,7 @@ jobs:
               const tree_id = run.head_commit.tree_id;
 
               // See whether there is a successful run for that commit or tree
-              const { data: runs } = await github.actions.listWorkflowRuns({
+              const { data: runs } = await github.rest.actions.listWorkflowRuns({
                 owner: context.repo.owner,
                 repo: context.repo.repo,
                 per_page: 500,
-- 
gitgitgadget

