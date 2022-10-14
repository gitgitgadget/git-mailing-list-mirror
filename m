Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D2EC433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 08:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJNI5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 04:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiJNI4z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 04:56:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C3014EC59
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:56:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j16so6541905wrh.5
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/4Dq1QgV2JNAqErlRrcWkHAf7qMlUWqxrQda3S1yo4=;
        b=TItNL9iD5nRKo1SdarlhLIgL4JYvszd2a9SEHqVJhgVtEjhFASdv1UFn7Zsw86mjm6
         7W/r50fjjDYJ6gF4TtLpKNoTpEWoN+SjUJlqzNCEtBhJ1jwS2JrnaWNq32vA20fjEVDG
         wtyPHZv9HG7tK19jrYXUkQTZXD/WcZ95RnU6A1O7vvEFzr0mljd/lp8sCS2SxVDCCUYq
         4YBmrf6LBI061ucYXWWooTN/EEUD38FU1jNiaefLSJ1cVu7YtM/KqorZ53EnTr7heywv
         S5XkdhLEAZzZ7UCNM1a9DaI4BmWMvVVH6Mi0lqZgJ2qMcmwmhyFLlQ8vfQx6PGEbpcgW
         Au7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/4Dq1QgV2JNAqErlRrcWkHAf7qMlUWqxrQda3S1yo4=;
        b=eo4/xNjp/cO/WJvVGItWjoU5axLqriAYznu+GFKzt6tdOmnzmPPKs4qpID518qXuLL
         gNRIjPw8OkWVVjMUpDqc2yl1aV65+zWKmwilLxU8Pw57H4epQbeJZ8CT1cxcBoRD6FsJ
         H8MB5f+IIfuznvVeQHfSJuYxWtVCsQlFD5vb4tDBACgieTE2PDb7nHMmTKM6xMBBHNd1
         tFHl8tLl60rQgjLUr9SPR+nTymB22aEWKI6egatbKQTGD6Os/URWVl8VDUosaooWVzBS
         gkTXF/pduooxbn9vtiIHqzktU4CRAW4W/R/W7RttZsfbmZRfe2WtDLLYfcU+CI6wCSyG
         6q5w==
X-Gm-Message-State: ACrzQf2WS5et8kcgG1vcSQ03UmPQjfctEEWxQ1ohHpM//gv8SM7a9+EP
        FIMjB3wmkzwIPLGw6uVcAkD38nTloOM=
X-Google-Smtp-Source: AMsMyM4ur3+ZxaYSLa4XobB7LTXD30NH1pXNe2d9ElgHbTfaPd9GkABey6P1HD6kZZct48lbRzvfVg==
X-Received: by 2002:a5d:5688:0:b0:232:3648:7aa3 with SMTP id f8-20020a5d5688000000b0023236487aa3mr2569652wrv.664.1665737813043;
        Fri, 14 Oct 2022 01:56:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d15-20020adffd8f000000b0022e309d35f8sm1475795wrr.12.2022.10.14.01.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:56:52 -0700 (PDT)
Message-Id: <69440797f302729d59f19c0994916e193c9dbf58.1665737804.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
References: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
        <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 08:56:44 +0000
Subject: [PATCH v3 7/7] documentation: format-patch: clarify requirements for
 patch-ids to match
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>, Jerry Zhang <Jerry@skydio.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jerry Zhang <Jerry@skydio.com>

The documentation for format-patch advertises that the ids
it generates for prerequisite patches are the same as piping
the patch into "git patch-id". Clarify here that this is only
true if the patch was generated with -U3, and for binary patches,
with --full-index.

Note that the actual equivalence isn't currently tested. Aside
from a few cases fixed in this patch series, I've seen some
uncommon situations where "git diff" and the internal diff api
actually generate equally valid diffs of the same length, but
with lines reordered, which results in different patch-ids.

Signed-off-by: Jerry Zhang <Jerry@skydio.com>
---
 Documentation/git-format-patch.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index dfcc7da4c21..566d4b486dd 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -668,8 +668,8 @@ of 'base commit' in topological order before the patches can be applied.
 The 'base commit' is shown as "base-commit: " followed by the 40-hex of
 the commit object name.  A 'prerequisite patch' is shown as
 "prerequisite-patch-id: " followed by the 40-hex 'patch id', which can
-be obtained by passing the patch through the `git patch-id --stable`
-command.
+be obtained by passing the patch (generated with -U3 --full-index) through
+the `git patch-id --stable` command.
 
 Imagine that on top of the public commit P, you applied well-known
 patches X, Y and Z from somebody else, and then built your three-patch
-- 
gitgitgadget
