Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A534C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 00:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiJZAF3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 20:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiJZAF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 20:05:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F33261D90
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 17:05:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id i5-20020a1c3b05000000b003cf47dcd316so318134wma.4
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 17:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rF5qUYM7dYapbbyXEyEdfRfHNHcNmwixFjjUsy16f4c=;
        b=fDa/ipkRYkw12WqKqZi9EjifC2KFqYF1cyU+D43+5N1G4eVpMoe693x3gzkFk6uNqw
         WQyWkJZLkiq71lefAlFTmyzEb+KmaV7h8IOQEANQISG9XzRjmW+T5HBdcr0ddAHhwVXn
         TleLHCg/a6a+LFUFvGxJvOLPiWBXqR4vwXdZq7YIjtKUXuhGbPDC47VqB0j/0+s4xXy/
         FwvqN697nA6SWAV2fEfnKVRD5L4RLSYban6zpVqmNXkK8/3ba6ss2FFBfwTs2SBUpmBc
         gNGVcLQjl6t+M1Ib7ElAP1ip/M7r4cyCFOn11tARvZj4lEXbK9gziuKIBfJPCr9HFL4B
         cF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rF5qUYM7dYapbbyXEyEdfRfHNHcNmwixFjjUsy16f4c=;
        b=NRoUdmsHZcohxoVe6T+8eh38VrTIhJtJYSROyqNr0tBMrZ3bGehnQtQOmJUbxailkF
         X31y+x6229PDDd7iDRsw1fKTI9daLEkzFc1iVu0UnHBg+k/8hs1dVyH8AEK3t4BewcpE
         UZjFbNP6N/qz8GxLRDlbgveBo3SeiIbLqWwHyTHnMEjtGxiIAAQMqdFuEEHBc9bgOs5p
         CmVpykYJEXoeTrMSILopHv+eUcmqL53e07KLot8p7Hq9Nz+CFO+OiX9a5i0Jyfguuhhx
         AtReFBePhjcoJgQzEXa3Cos6lXQE8Bx8DhCtOwyz59ao8Ro5vMaceVRvJSQOfVon/jCL
         PqpQ==
X-Gm-Message-State: ACrzQf2mp7P/DxWBKoENQWy0Qo4z9XWaeNVpLRSKWSPO8iA8xKUjlNk2
        LpHXbucITIUG90M8hDGJjM+N5On1bG4=
X-Google-Smtp-Source: AMsMyM5RmbnEqjncq7E4CAD4SPb7US0/h5DXaCJWY1T5bmc1qgdyNgqytyaQu+eioNIaqW6lbfpYfg==
X-Received: by 2002:a7b:cc15:0:b0:3b4:ca90:970d with SMTP id f21-20020a7bcc15000000b003b4ca90970dmr469042wmh.198.1666742723591;
        Tue, 25 Oct 2022 17:05:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k3-20020a5d6283000000b0023677e1157fsm3788079wru.56.2022.10.25.17.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 17:05:23 -0700 (PDT)
Message-Id: <pull.1368.git.git.1666742722502.gitgitgadget@gmail.com>
From:   "Anh Le via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Oct 2022 00:05:22 +0000
Subject: [PATCH] index: add trace2 region for clear skip worktree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Timothy Jones <timothy@canva.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Anh Le <anh@canva.com>, Anh Le <anh@canva.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Anh Le <anh@canva.com>

In a large repository using sparse checkout, checking
whether a file marked with skip worktree is present
on disk and its skip worktree bit should be cleared
can take a considerable amount of time. Add a trace2
region to surface this information.

Signed-off-by: Anh Le <anh@canva.com>
---
    index: add trace2 region for clear skip worktree
    
    In large repository using sparse checkout, checking whether a file
    marked with skip worktree is present on disk and its skip worktree bit
    should be cleared can take a considerable amount of time. Add a trace2
    region to surface this information.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1368%2FHaizzz%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1368/Haizzz/master-v1
Pull-Request: https://github.com/git/git/pull/1368

 sparse-index.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index e4a54ce1943..d11049c8aeb 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -493,24 +493,33 @@ void clear_skip_worktree_from_present_files(struct index_state *istate)
 	int dir_found = 1;
 
 	int i;
+	intmax_t path_count = 0;
+	intmax_t restart_count = 0;
 
 	if (!core_apply_sparse_checkout ||
 	    sparse_expect_files_outside_of_patterns)
 		return;
 
+	trace2_region_enter("index", "clear_skip_worktree_from_present_files", istate->repo);
 restart:
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 
-		if (ce_skip_worktree(ce) &&
-		    path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
-			if (S_ISSPARSEDIR(ce->ce_mode)) {
-				ensure_full_index(istate);
-				goto restart;
+		if (ce_skip_worktree(ce)) {
+			path_count++;
+			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
+				if (S_ISSPARSEDIR(ce->ce_mode)) {
+					ensure_full_index(istate);
+					restart_count++;
+					goto restart;
+				}
+				ce->ce_flags &= ~CE_SKIP_WORKTREE;
 			}
-			ce->ce_flags &= ~CE_SKIP_WORKTREE;
 		}
 	}
+	trace2_data_intmax("index", istate->repo, "clear_skip_worktree_from_present_files/path_count", path_count);
+	trace2_data_intmax("index", istate->repo, "clear_skip_worktree_from_present_files/restart_count", restart_count);
+	trace2_region_leave("index", "clear_skip_worktree_from_present_files", istate->repo);
 }
 
 /*

base-commit: 1fc3c0ad407008c2f71dd9ae1241d8b75f8ef886
-- 
gitgitgadget
