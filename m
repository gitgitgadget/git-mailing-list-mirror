Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4476EC433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 02:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352186AbiA2CQc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 21:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352181AbiA2CQa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 21:16:30 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3BCC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 18:16:29 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id f17so14223414wrx.1
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 18:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=c+hNrlnkqnoDS+PrIU0JfC7dhGRvz+/ja1UmZNEETag=;
        b=BGl+quxTTeZdG9hqfNegkexji56+aQzxAzqocIQQdO+8FmmIyJmlm9RuNXT5JFzsYQ
         tA+ceV7//HWUyp2Zjx7UXDGZ53nkNCgDL52C5B5bCl/WMeW3zFMCNpyz3SN2vpN0LuM5
         tifdrmywn27exQY6u/remYOlRbGTyazAU2+vWkgxpOAMryOA0JRBn94FE2XULHpnw3/b
         7FpbsfT2iwX88VD9oSTWK8XKxzBulCzTXOlR4VnJoWEKb0kHktIk0kO5U4zXX8kICBtN
         pEXr54Qw435UocjpA2zbih7nqYsXf8IOJUNRWyFU0ibil0jAzklO1uhXJfrRmDPXfF6/
         YEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c+hNrlnkqnoDS+PrIU0JfC7dhGRvz+/ja1UmZNEETag=;
        b=0vbdd7VOdEKFXprAzbOuaubG1eQk9KLVZJ/W5ZPtBF+3Fb1hLkQVpGClWi/TPLtOuD
         tmEw29dq8oE5XCeW6MA31e4wlcEKSP/nGPrrP1GufqLoypjfkgjCSyiX0ku13KYbQlFt
         UCkO4VjppagkJ75MqmEg/gelahGmbmMvnW3pzvleCzbGol23h/ozmFWK2Fjfk2OTmeYp
         91VRj8VEIqET3wkou46oiWPuRQctSczSjpzdFbtOuG2uKMrRWTGomLH6HYBphK97s29P
         VgoIvVXblN1y3vJV3vGxRigj+XaJcOL7DTgMFB1F4ZxqgX327O8upq6rjr58e4vIjdo3
         37oA==
X-Gm-Message-State: AOAM533XIJAxgtauo3ndMz2bSYQvMMTzIhBqN0uUAMNF0bOta/PWzBhs
        CilXHWUKL8wtYyS+IQ2/PvRv1qWqlYw=
X-Google-Smtp-Source: ABdhPJx7vrMb9rz2wTviAOZWskeaNM7wpiTzXqinv1k/v5Vl/D4GL0G1j0t/emMmDefy1qYmBZgquQ==
X-Received: by 2002:adf:df89:: with SMTP id z9mr8997905wrl.686.1643422588187;
        Fri, 28 Jan 2022 18:16:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15sm5755007wrp.41.2022.01.28.18.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 18:16:27 -0800 (PST)
Message-Id: <pull.1136.git.1643422586267.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 29 Jan 2022 02:16:26 +0000
Subject: [PATCH] 2.35.1.txt: clarify the rebase/stash regression
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

rebase and stash still worked in v2.35.0 in a secondary worktree so
long as they were invoked from the toplevel directory.  Update the
release note to clarify this.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    2.35.1.txt: clarify the rebase/stash regression
    
    I haven't seen the release notes go out; I'm hoping this patch is seen
    in time...

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1136%2Fnewren%2Fregression-clarification-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1136/newren/regression-clarification-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1136

 Documentation/RelNotes/2.35.1.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes/2.35.1.txt b/Documentation/RelNotes/2.35.1.txt
index 726ba250ef3..0661d8c6e5e 100644
--- a/Documentation/RelNotes/2.35.1.txt
+++ b/Documentation/RelNotes/2.35.1.txt
@@ -2,5 +2,5 @@ Git v2.35.1 Release Notes
 =========================
 
 Git 2.35 shipped with a regression that broke use of "rebase" and
-"stash" in a secondary worktree.  This maintenance release ought to
-fix it.
+"stash" when run from a subdirectory within a secondary worktree.
+This maintenance release fixes it.

base-commit: 5d01301f2b865aa8dba1654d3f447ce9d21db0b5
-- 
gitgitgadget
