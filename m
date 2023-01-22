Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78D2C25B50
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 03:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjAVDGT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 22:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjAVDGR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 22:06:17 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D5C2278C
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 19:06:16 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso2903007wmb.0
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 19:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tOAtW6vbKE577oxusGmZGNce/HhlbjStKlRtvzuXwLQ=;
        b=KDfcjMJY8MVB6z12IMcI2P+kp7x6kntZxHuzSXTrQaKeunv14OfhkHJcvxc4xMPPPp
         Xh4cAX3oG2zjwDOlJm4JShpqExbPEmTPpasahb2p9aS6nAAGtypLNZhsyj15vxDfJGVF
         SmNfhKsf+K5qRmj41qY3Xd+LVHqMqoPAwVyd6GX5Kt3hWqKNLyfkNhHHg//EJjg1t0ln
         HTpQScbY1jEA+gxgiIQ3h/7SevPZbhCTxl3ylNDj4k3obpvXcviGgnJVe9Hjl+rQfBlA
         YCBwpB4BbQHN6p5GCPWmdHP3Wms2LcrwXX3aBe3+zJdUgP5hkAg2HV4OI9+zgiHjCCQd
         SEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOAtW6vbKE577oxusGmZGNce/HhlbjStKlRtvzuXwLQ=;
        b=UeX7YkAJBeEIM4tkxC2+NYbNoErJRLbF30MOJ3ryMNhuSO9vjkurZOuwP2sXpkYjIW
         gl2rwEJSKA1wCsKmV5B1NiCxiXI9aJZE1I38SXBJiZrRwCxbun7dDuZogknV8i9DM1sF
         CoU5R0V4I6H92WTTZIktv33oO0L5z4S6/26tD+VRyPdwXl2Uo0msOF5K/KdDP666sVxF
         H/LZBVBM3Uf5h8jXv24AMkpvZa84oc7pkM4wZiO6H9G1vSoh8suTGnrHvzrAuMKXHbRv
         usJXg/qSVrk0e47uNFSXRLtX1A1G/W4101MKMse84gBxrf0RLqi1oLuS+fQ6REC4nqkg
         ZXXw==
X-Gm-Message-State: AFqh2koTrrbBTDGLvcMboI6LQXGci0TMLrNEW4HCa5KLsKqSJ7VrzNAe
        Rszi1t/5dxZ5HQNBkH+6L4mfjb8FA0k=
X-Google-Smtp-Source: AMrXdXtBP7iab9PKoZpVhlTQJHHineW/SI9sGJyKFBt3ljx6FmdUAg3VhqDa66eUBqRDPuiuKylLzg==
X-Received: by 2002:a05:600c:a29e:b0:3d9:ee01:ae5b with SMTP id hu30-20020a05600ca29e00b003d9ee01ae5bmr19161038wmb.12.1674356775115;
        Sat, 21 Jan 2023 19:06:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c378600b003d9fba3c7a4sm6728002wmr.16.2023.01.21.19.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 19:06:14 -0800 (PST)
Message-Id: <pull.1441.git.git.1674356774172.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 22 Jan 2023 03:06:14 +0000
Subject: [PATCH] attr: fix instructions on how to check attrs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

The instructions in attr.h describing what functions to call to check
attributes is missing the index as the first argument to git_check_attr.

Fix this to make it consistent with the actual function signature.

Signed-off-by: John Cai <johncai86@gmail.com>
---
    attr: fix instructions on how to check attrs
    
    The instructions in attr.h describing what functions to call to check
    attributes is missing the index as the first argument to git_check_attr.
    
    Fix this to make it consistent with the actual function signature.
    
    Signed-off-by: John Cai johncai86@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1441%2Fjohn-cai%2Fjc%2Ffix-attr-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1441/john-cai/jc/fix-attr-docs-v1
Pull-Request: https://github.com/git/git/pull/1441

 attr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.h b/attr.h
index 2f22dffadb3..47f1111f391 100644
--- a/attr.h
+++ b/attr.h
@@ -45,7 +45,7 @@
  * const char *path;
  *
  * setup_check();
- * git_check_attr(path, check);
+ * git_check_attr(&the_index, path, check);
  * ------------
  *
  * - Act on `.value` member of the result, left in `check->items[]`:

base-commit: 904d404274fef6695c78a6b055edd184b72e2f9b
-- 
gitgitgadget
