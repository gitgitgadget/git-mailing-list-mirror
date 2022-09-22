Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A847C6FA8B
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 07:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiIVH1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 03:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiIVH1f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 03:27:35 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198BAC88A9
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 00:27:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g3so13967429wrq.13
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 00:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=f/xupWM/n1cwfYYsQDDOoGKBalX8Yb1Ujg38c4SeCEw=;
        b=O1i6SHUKavu3WhOoFTfG/ZtOkMUx8fnc2lfHVV5EhYRAKCNtEIL6MEEJL8ZQAm31HO
         kdjEHRHVONkXQ3s+IbGuC6lrr2fpYeZba75Lh7zOwyjKd/dc0k/LDaNuolV3ejXtXl+O
         USN4Agegkl9PmT4j8K7mhCFuHA7/ewg3jZV3uffU0F3R7isvvhJto9PlIL4B6vQ+UFlO
         oiD2Kh7Welc3v2ytUK+zRMsny9a4OvZAaAHSmKUTpb3rwbqJZWuCeszT5HXun5W285jH
         GnCzEFHaX0k9C4y/wRC4KNCkFfq7qCrawbAJO/xLXAt43xPG0JQoRAfveIXANnctcJEd
         Ncwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=f/xupWM/n1cwfYYsQDDOoGKBalX8Yb1Ujg38c4SeCEw=;
        b=S1iHyVHRmSLW9KJ0rDcEmt7p2TLC7VRDscsNjbUQ2DvopyzgvYIMDC5UI7bo86br1W
         lALAvIBd/tTLy0yZg2XA63SSSyiva9Ub44DciA5xqBKD7tjb1Jr46iUXdLasIQUKWX4R
         AgIkhlaZcaPNYLFtnxMc+rjX9zpknFmcGVHYFMDJdE1yBWGVZebbdfBYkhWPtOSlAAiq
         fwZcohlv3FsqB6ace2Gm/WXEZcdJOXAmUrOd1m40MUbIbvnc32FzlqAkSFUg0kRaXJ9O
         6pN/q0B7LeFabwYt2K3CLG4dfkCsWtnzudiTZU98KT8YtyBEB5uqXqLGzWo6Sm+QUwCc
         ZszA==
X-Gm-Message-State: ACrzQf1ekQ0SxeelgCw4YuyToqeDcs+a5zxVtxHf9H06mv2jxRQ1dMbf
        PYnkoDDYPqfLdL9jcyANNNFO352au8M=
X-Google-Smtp-Source: AMsMyM7Vga5vH08TGa83ArWPR+/Vkndni21zPy8acXBkqwh91agcepjCMdHQNEIouHIQStuwbwJOSQ==
X-Received: by 2002:adf:fa81:0:b0:224:f260:2523 with SMTP id h1-20020adffa81000000b00224f2602523mr1029740wrr.26.1663831652176;
        Thu, 22 Sep 2022 00:27:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c4ece00b003b477532e66sm9066774wmq.2.2022.09.22.00.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 00:27:31 -0700 (PDT)
Message-Id: <pull.1337.git.git.1663831649705.gitgitgadget@gmail.com>
From:   "Alex via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Sep 2022 07:27:29 +0000
Subject: [PATCH] ci: restrict workflow's github token permissions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex <aleksandrosansan@gmail.com>,
        sashashura <aleksandrosansan@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: sashashura <aleksandrosansan@gmail.com>

Currently the workflow runs with the following permissions:
GITHUB_TOKEN Permissions
  Actions: write
  Checks: write
  Contents: write
  Deployments: write
  Discussions: write
  Issues: write
  Metadata: read
  Packages: write
  Pages: write
  PullRequests: write
  RepositoryProjects: write
  SecurityEvents: write
  Statuses: write

Signed-off-by: sashashura <aleksandrosansan@gmail.com>
---
    ci: restrict workflow's github token permissions
    
    This PR adds explicit permissions section
    [https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#permissions]
    to workflows. This is a security best practice because by default
    workflows run with extended set of permissions
    [https://docs.github.com/en/actions/security-guides/automatic-token-authentication#permissions-for-the-github_token]
    (except from on: pull_request from external forks
    [https://securitylab.github.com/research/github-actions-preventing-pwn-requests/]).
    By specifying any permission explicitly all others are set to none. By
    using the principle of least privilege the damage a compromised workflow
    can do (because of an injection
    [https://securitylab.github.com/research/github-actions-untrusted-input/]
    or compromised third party tool or action) is restricted. It is
    recommended to have most strict permissions on the top level
    [https://github.com/ossf/scorecard/blob/main/docs/checks.md#token-permissions]
    and grant write permissions on job level
    [https://docs.github.com/en/actions/using-jobs/assigning-permissions-to-jobs]
    case by case.
    
    check-whitespace.yml is triggered by pull_request only and receives
    restricted token already. l10n.yml has permissions on job level already.
    So I didn't make any changes to them. In both cases it is possible to
    add explicit global lever permissions just for consistency if you
    prefer. Let me know.
    
    Currently
    [https://github.com/git/git/actions/runs/3100948073/jobs/5021781329] the
    workflow runs with the following permissions: GITHUB_TOKEN Permissions
    Actions: write Checks: write Contents: write Deployments: write
    Discussions: write Issues: write Metadata: read Packages: write Pages:
    write PullRequests: write RepositoryProjects: write SecurityEvents:
    write Statuses: write

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1337%2Fsashashura%2Fpatch-2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1337/sashashura/patch-2-v1
Pull-Request: https://github.com/git/git/pull/1337

 .github/workflows/main.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 831f4df56c5..3ce9302c589 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -5,8 +5,14 @@ on: [push, pull_request]
 env:
   DEVELOPER: 1
 
+permissions:
+  contents: read
+
 jobs:
   ci-config:
+    permissions:
+      contents: read
+      actions: read # for github.actions.getWorkflowRun
     name: config
     runs-on: ubuntu-latest
     outputs:

base-commit: dda7228a83e2e9ff584bf6adbf55910565b41e14
-- 
gitgitgadget
