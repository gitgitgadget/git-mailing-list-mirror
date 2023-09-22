Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27773CD4F57
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 10:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbjIVKmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 06:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjIVKmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 06:42:16 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FC5AB
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 03:42:07 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3226b8de467so1168010f8f.3
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 03:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695379325; x=1695984125; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T7odiwkgsesSEh3BMdiKAa4Jlci+EwG7TBGWUg43InQ=;
        b=hvVAbZH2Nt6eRjLvtQIAZShkqCb6uObkjh0r7D+cCqYtFlJQhLUNDt+jVqWVjJTnUF
         QDQ18LfR6N0eahME/06kTMfKdl491Vao8vbYzuG3C7pw8CROU34SdVdArjdncTcxHkBZ
         EyfDpSVqjc+xZeDQ4QdVqKaewmARu9wkfU9f8TS3Cdpot3RLmgD1+sXFj4J4SBJdLaUY
         vfDwzy0tKEMrXJcYroMwsgw336UegdoggDBvObwj7iBbLEvP0oRx7JLPCuNrDr2QdeUj
         RzaUqU2YwCkTRdVeUUqCq3+pgSFsOlAjCDsod7Q4hQlISgq/5miOd7QJXxm/Fdomhpos
         Aopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695379325; x=1695984125;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7odiwkgsesSEh3BMdiKAa4Jlci+EwG7TBGWUg43InQ=;
        b=AM+3TqA5MOPBoIQEXr+dyTW9HBGRPVzVAwM8M5/RyuHLCpC81RQ2z0XeFBcZFjzIb0
         qd5C416/mcmSQGmViIZuB3tAPafSiAtu1rwJsXt81ju/GujA5eXvgqL8sp909e7h21iA
         rAZk58k+ZwES+cPFddMg4EvkUoYnYSZ7NsCfFEvPfEmmZ9iuz97TeGCX/U8HNfXICPdx
         QK1wZciTVQx3Dkh89lBmbrxN5NbmHFOv71oBeBVYwkx2t42Qb7wxg7GgdvmtlWimz9rN
         3Mg9nfPmI2H7ISETixNCVOS3CpynwAxs58uaN3aIhfBUMFZOOxv/IGSq2vv6PDnoJI0J
         Tt+w==
X-Gm-Message-State: AOJu0Yxa1xE6psu4knGE+AA3DUaoOAS7t0k+1GaQEJ2h+Teu93bhpI4K
        D1AkikLbj8SvOeTBr/7K3nNoLSqJCCQ=
X-Google-Smtp-Source: AGHT+IHZn1DIiEWXBFsRXXc0i6qONEvTMbOdvNWLN7oez/TMJF1glugpw/LuLs4hQOkc3tt95Vo71w==
X-Received: by 2002:a5d:560c:0:b0:31f:d8ba:c997 with SMTP id l12-20020a5d560c000000b0031fd8bac997mr7045778wrv.41.1695379325040;
        Fri, 22 Sep 2023 03:42:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a4-20020adff7c4000000b0031fc9402b47sm4193907wrq.4.2023.09.22.03.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 03:42:04 -0700 (PDT)
Message-ID: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 10:41:57 +0000
Subject: [PATCH 0/6] Add a GitHub workflow to submit builds to Coverity Scan
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Coverity [https://scan.coverity.com/] is a powerful static analysis tool
that helps prevent vulnerabilities. It is free to use by open source
projects, and Git benefits from this, as well as Git for Windows. As is the
case with many powerful tools, using Coverity comes with its own set of
challenges, one of which being that submitting a build is quite laborious.

The help with this, the Git for Windows project has an Azure Pipeline for
several years already to automate submitting builds to Coverity Scan:
https://dev.azure.com/git-for-windows/git/_build/index?definitionId=35

It is time to move this automation off of Azure Pipelines, and I thought
that the Git project itself might as well benefit from this workflow.

Since Coverity build submissions require access (and a token to
authenticate), this workflow is skipped by default. To enable it, the
repository variable
[https://docs.github.com/en/actions/learn-github-actions/variables]
ENABLE_COVERITY_SCAN_FOR_BRANCHES needs to be added. Its value needs to be a
JSON string array containing the branch names, e.g. ["master", "next"].
Further, two repository secrets
[https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions]
need to be set: COVERITY_SCAN_EMAIL and COVERITY_SCAN_TOKEN.

An example run in the Git for Windows project can be admired here:
https://github.com/git-for-windows/git/actions/runs/6272393351/job/17033838405

To prove out that it would also work with the git Coverity project and
building on operating systems other than Windows, I added two throw-away
commits disabling the actual submission of the build to Coverity Scan (and
also the main.yml CI to save on electrons) and pushed the branch to my fork.
The ubuntu-latest run
[https://github.com/dscho/git/actions/runs/6272014876/job/17032859462], the
windows-latest run
[https://github.com/dscho/git/actions/runs/6272014876/job/17032859234] and
the macos-latest run
[https://github.com/dscho/git/actions/runs/6272014876/job/17032710138] all
worked as expected.

This patch series is based on that Azure Pipeline, the support code in
https://github.com/git-for-windows/build-extra/blob/0e0b919073fb/please.sh#L835-L968,
and is very loosely inspired by
https://lore.kernel.org/git/4590e1381feb8962cadf2b40b22086531d662ef8.1692675172.git.me@ttaylorr.com/
(but you may not know it from comparing the patches because they look so
vastly different). The reason why this patch series is so different is quite
sad because I got very excited about the simplicity of using the GitHub
Action vapier/coverity-scan-action. On paper, this Action looks really neat,
but its implementation left me wanting, in particular because it does not
even work (cov-configure must be called these days, and that Action simply
does not, causing the entire build to fail), lacks support for Windows and
macOS, fails to cache the Coverity Tool if the build fails for reasons
unrelated to downloading & extracting the tool, and the activity in its
issue tracker suggests to me that it is neither used nor maintained
actively.

This patch series is based on v2.42.0, but would apply literally everywhere
because it adds a new file and modifies no existing one.

Johannes Schindelin (6):
  ci: add a GitHub workflow to submit Coverity scans
  coverity: cache the Coverity Build Tool
  coverity: allow overriding the Coverity project
  coverity: support building on Windows
  coverity: allow running on macOS
  coverity: detect and report when the token or project is incorrect

 .github/workflows/coverity.yml | 159 +++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)
 create mode 100644 .github/workflows/coverity.yml


base-commit: 43c8a30d150ecede9709c1f2527c8fba92c65f40
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1588%2Fdscho%2Fcoverity-workflow-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1588/dscho/coverity-workflow-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1588
-- 
gitgitgadget
