Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB105C05027
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 01:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjAUBzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 20:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjAUBzm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 20:55:42 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CB580BB0
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 17:55:35 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id q8so5304329wmo.5
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 17:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gK2s93dygSJMI2nZj+qpmrYr/09wCvz66gnVFtBFYN4=;
        b=KJAmkEQ299MXlg0KfqbxwHXMZ/tqAVlDLMM8YsN26LJYfjlDDO+2mvCRvHtCk5xuSa
         vPCv2lHggwgTU3WytS+E0m7xJqO8hPOQ96sIYIM95fTpoJKSAFzrcud5/mJDQekTuQnM
         ivtQ1w8dGIet1U25n/jf+OJFzucxAv/txG27SfOBdbx3TsPiclT+S+xPBqlLdiSjk5P3
         /g0cbzU/kFBWUXmTRbS4/FH43ffNSx1agG+bMdcGxluuVXEKNuw2td4B/NQ8Zog62MUP
         DhJutLRM2SOtK3P+eSS/0zzR2PKhwaPm7UZGB5Y3DAykolhwULwsfsoKieS0CnCVHsJB
         0fWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gK2s93dygSJMI2nZj+qpmrYr/09wCvz66gnVFtBFYN4=;
        b=qEhr6xwDwVDXEX9im4LuhXUBzWbo8Lh0wYobUjDF+jeKNeD+MoIFgzGdE7T35Lwdqb
         cSMKhGqECJlCE+pdloRQ847c5Qkb7GU+xB62o77TUPM2KEt/vDsHXI2ibvTv/Ma4tRL8
         x2FiUnvEC0VnyQaCW5soWiLcwLm4JL6gWUdSw633Mhdg9HrW3lSiNPK4VV+c2F3nZTX6
         ZWr53d0h0a8q/bsUu26LGF4vOl2gjhBKEV3hh93hCYGONG1c1j6EkyToa3vWCGeKBz6i
         lAiAErFDpJc9fFqld3Uz9bVVpAC3kjmZnqZNasigrCA0wnfTusFrhfMK9eHIU1kR37wI
         ukIA==
X-Gm-Message-State: AFqh2kp3UVUI/yLgjXbUmV55GQCttEQ5gVA/bpj1iFceXa8l7QYFGH2e
        9qesYJbPvXO2oO3a4p7pYr98EWSmO0Y=
X-Google-Smtp-Source: AMrXdXulKtDpppV6yEMQP0HBOwRbA8x5sNY0tgfo+AiY0/55vlyJBGYcGYuMCHAU4R9xa9UuOcKxpw==
X-Received: by 2002:a1c:4b19:0:b0:3da:fb5c:8754 with SMTP id y25-20020a1c4b19000000b003dafb5c8754mr12588858wma.2.1674266133411;
        Fri, 20 Jan 2023 17:55:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b002bcaa47bf78sm27585106wrr.26.2023.01.20.17.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 17:55:33 -0800 (PST)
Message-Id: <0e8b06163f2b21748a19f32d515aecb16cd4574b.1674266126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
References: <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com>
        <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Jan 2023 01:55:26 +0000
Subject: [PATCH v3 7/7] rebase: fix formatting of rebase
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
index 00a9e22bc32..140c984d0ea 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -331,7 +331,6 @@ See also INCOMPATIBLE OPTIONS below.
 	upstream changes, the behavior towards them is controlled by
 	the `--empty` flag.)
 +
-
 In the absence of `--keep-base` (or if `--no-reapply-cherry-picks` is
 given), these commits will be automatically dropped.  Because this
 necessitates reading all upstream commits, this can be expensive in
@@ -340,7 +339,6 @@ read. When using the 'merge' backend, warnings will be issued for each
 dropped commit (unless `--quiet` is given). Advice will also be issued
 unless `advice.skippedCherryPicks` is set to false (see
 linkgit:git-config[1]).
-
 +
 `--reapply-cherry-picks` allows rebase to forgo reading all upstream
 commits, potentially improving performance.
-- 
gitgitgadget
