Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86682C61DA2
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 06:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjAVGM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 01:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAVGMv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 01:12:51 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9376CCDFD
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 22:12:49 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d14so4430288wrr.9
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 22:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdKGnak+F7uE8hQxj75ON3mmkyVQCQGc9Jht14MetNg=;
        b=XcUYmMwetNWldntVPO0nFbJAaCZw2udRO54pTl6Rv2e064SkdFpIyaBL2sYZnDFNa1
         Up48vMWEkj4SyNOdXXV+03xcvp7dZkInbX9p/XADXaRhU6BMfGNt+NdXLH8eXx6klhGD
         n++9KV4RB6YLrdkrX97w8oIWaJBY7Yi57KW3XhHm3eby1jV8P2761/YY+rGBaEX7PuqE
         Z8RLX5Px+fBmGN/Qhh50nS6Qrn/DoJts7y1kz/3tK5JcTAqZhiZ566nVudbTb0vxfrgL
         IIVCduu6d2ciAtP7XzZ1oyRLRPYJ1JIrF3+arB/GXS4woXQ6xHXQUJzci4uRRXWbgteI
         la3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdKGnak+F7uE8hQxj75ON3mmkyVQCQGc9Jht14MetNg=;
        b=ek1d+bbuXxXHcEqzNURy4Ms5n8cDMRvYXqy1HOqm1cZ7dBlobrZatxDckvkFvceIbr
         CZruL2eN1Uy1i5/2wWzZ5O3O7fbtnxnMEH1UHqN+S7pYW5j8UKLeNTZ3r81pVkulht9Q
         trD+kmSOCuVao24Fvc5uWWu3cxCntTip9pg81exPMMUL4VIdgDgCwgqQ6WlbXMpMUIU+
         M3B74+RPFx1lGXgJdptRWsvg+dJT9zCsno8xJWwlyO/PZQhnj/m5Pp8orW2mHS4WrK0r
         y06dtcSc53VGScIbLiqRqqqA3I3KdrkTLT0uW0X5X+iOFtVSVEtOb3S6mEj5lt0GJhdm
         Qvbw==
X-Gm-Message-State: AFqh2kp4k19Zlrqym+QtY92gRi/Bkx5UGcdUUOIITUreokyxsnHAByHD
        hpcuTzl3I6Si3wdOMe10setk3YxXAas=
X-Google-Smtp-Source: AMrXdXskuiX2mH84IjIaQ2inXnf352H8jfKJ19hVPy1/ZoKljCz0DrKHLLPJzHQ1lPEAK7P3lUzvIg==
X-Received: by 2002:a05:6000:546:b0:2be:3501:3645 with SMTP id b6-20020a056000054600b002be35013645mr12159419wrf.38.1674367967942;
        Sat, 21 Jan 2023 22:12:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ba29-20020a0560001c1d00b002b065272da2sm18775126wrb.13.2023.01.21.22.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 22:12:47 -0800 (PST)
Message-Id: <74a216bf0c02d4cb3e91b0de9e5fcd617f611672.1674367961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
References: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
        <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 22 Jan 2023 06:12:38 +0000
Subject: [PATCH v4 7/9] rebase: fix formatting of rebase
 --reapply-cherry-picks option in docs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit ce5238a690 ("rebase --keep-base: imply --reapply-cherry-picks",
2022-10-17) accidentally added some blank lines that cause extra
paragraphs about --reapply-cherry-picks to be considered not part of
the documentation of that option.  Remove the blank lines to make it
clear we are still discussing --reapply-cherry-picks.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 1ba691e4c5f..9f794f5bdcc 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -338,7 +338,6 @@ See also INCOMPATIBLE OPTIONS below.
 	upstream changes, the behavior towards them is controlled by
 	the `--empty` flag.)
 +
-
 In the absence of `--keep-base` (or if `--no-reapply-cherry-picks` is
 given), these commits will be automatically dropped.  Because this
 necessitates reading all upstream commits, this can be expensive in
@@ -347,7 +346,6 @@ read. When using the 'merge' backend, warnings will be issued for each
 dropped commit (unless `--quiet` is given). Advice will also be issued
 unless `advice.skippedCherryPicks` is set to false (see
 linkgit:git-config[1]).
-
 +
 `--reapply-cherry-picks` allows rebase to forgo reading all upstream
 commits, potentially improving performance.
-- 
gitgitgadget

