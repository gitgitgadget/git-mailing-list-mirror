Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262F1C77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 17:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjDNR6s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 13:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDNR6p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 13:58:45 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DF87DB6
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:58:43 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k27-20020a05600c1c9b00b003f0a9f022beso2398546wms.1
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681495122; x=1684087122;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bAs+0aOGHBLkcL5yxlo6xyrRuKcHb3n8K90rZopGoc=;
        b=ESw/GZqgOMRaUBo+oBfCHXH3NNMkctf3ZgTCsXbBB5tqCktWHU0ffqtddr6R0CG10K
         jBaKRFyxejO8c9Rd97j1yR6qABQzpd84bZWbmXtXe4QL16gnV2h3igls8EE8sLRTtkCO
         NjaYea56V8eCtvsfQ4UwLVXOhe5wX1AkH2ic5h7F4Wlk/n6VoR5ZcL6bVgCo54dEpbPc
         P2oysP7AQYy1rvUacNuARl1sqspbXjNebnJPAhGxdMw+5bAxNM5gd/GyAAVBRK141x0F
         E0ldU/41Ne+1EboWjGtiI3TdATEzl+0lAJrLzbFmlEueVf7pfbPygGqPz0Eq6+KfShAU
         hMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681495122; x=1684087122;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bAs+0aOGHBLkcL5yxlo6xyrRuKcHb3n8K90rZopGoc=;
        b=GYIEysYA2ALw5IUaHaNJJjZLccEejNt2pw+JioeRXDXaSJCKzLHQV1emYVvIRcKA0U
         i7LGP8jabFlZWA88wLYOefr2jDH3feVBOHI1l+DP6CQnv9F5tXuDD91HFKWFF+67gj5a
         8532o0v09/cjEdAwHq6KQpE25LgkLWymLZ7YJzsrex7tmhIhTINXI1iEe/obptmGLWbE
         LDhmfCuyJUAb5UsSFlQM4GCSncQkSRxvhp4R1XbZku+ojUrNblW8nZXJyaJqOH1K5Hrq
         88Fdxh2NGnv6PBvSj/CaQiGhcTQOHawjL91FypOtJqpwj3Rqn0jaTr/Ja+iHJ+K9j6nQ
         yiIw==
X-Gm-Message-State: AAQBX9eG0CU5b7DacIdzIpwpYR5WHlVIz0ENcsovcwNf1n1RidQZeLQg
        Eb7159W+leKJ7aYmj6/6qv9C0ibNmho=
X-Google-Smtp-Source: AKy350Z4DIN85EHUlGOXE5dPfvRWz5TYt9O/HUrSga6aGRKxPmaJba+3s6BS80DpQh/wM4xLCWGVlg==
X-Received: by 2002:a1c:7510:0:b0:3ee:289a:43a7 with SMTP id o16-20020a1c7510000000b003ee289a43a7mr5161227wmc.22.1681495121882;
        Fri, 14 Apr 2023 10:58:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c378800b003ed2433aa4asm4760198wmr.41.2023.04.14.10.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 10:58:41 -0700 (PDT)
Message-Id: <62b68829c5aeaa28a79192b55058e87a0ef72816.1681495119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Apr 2023 17:58:36 +0000
Subject: [PATCH 3/5] git-merge.txt: modernize word choice in "True merge"
 section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The "True merge" section of the 'git merge' documentation mentions that
in case of conflicts, the conflicted working tree files contain "the
result of the "merge" program". This probably refers to RCS' 'merge'
program, which is mentioned further down under "How conflicts are
presented".

Since it is not clear at that point of the document which program is
referred to, and since most modern readers probably do not relate to RCS
anyway, let's just write "the merge operation" instead.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-merge.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 0aeff572a59..23aefe28851 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -194,7 +194,7 @@ happens:
    versions: stage 1 stores the version from the common ancestor,
    stage 2 from `HEAD`, and stage 3 from `MERGE_HEAD` (you
    can inspect the stages with `git ls-files -u`).  The working
-   tree files contain the result of the "merge" program; i.e. 3-way
+   tree files contain the result of the merge operation; i.e. 3-way
    merge results with familiar conflict markers `<<<` `===` `>>>`.
 5. No other changes are made.  In particular, the local
    modifications you had before you started merge will stay the
-- 
gitgitgadget

