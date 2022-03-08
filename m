Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB501C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 07:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344667AbiCHHlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 02:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344638AbiCHHky (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 02:40:54 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C7E3DDFB
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 23:39:58 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so868707wmj.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 23:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gsuKuXVMAafwFyt95VXG+6VfrukFCSpgnCFPbj6/MgI=;
        b=LBE0oX/ubeJGlnoq0QmRUfRL+rfSC2UrYD+PS8jqJgeyoCRt+DF/ki3ior4q1ILhTx
         o2A+WZBd9p1bFx4H6zPcb5/Pv7QzdVGQAqf/uAxX+ilSD12tcbgvZrcAohqS1hooO5tv
         ZpsgX1OhDqhuxaS9CwTnQyyUgXxK139tczFCwTgbzd0FnBJFALqGGwlxrgv7Tjzqsqce
         /u8CAl0xHs5/kk6Ry/54494iHn1/vCUglfBsNIDWOP7ky5sBdAMNvvDGHy5RFoksIhOh
         ELSneumx/6IDYxxoCHsZYSgiYfM5InBjUAixXQu5rb8mQOLEMjgQ5grwaCGjXyTDHiP7
         jqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gsuKuXVMAafwFyt95VXG+6VfrukFCSpgnCFPbj6/MgI=;
        b=jymGwpJmv0BjrZN8aaA/LiH9RJlT/dpAsGUPj8MshnSYDZSYpRdzgLxzzTpApf7MWQ
         QoIlaHWIh2LFT2zqOEbaMpJZpeBGMTjB8NMKMfTZbI7dwcqrw5mZgm6IVgK8nINTNsRq
         WPkp64GMueDSKetCjY7+RA1i+magwfqY3TF1PJmmwKOvEw9HOOq+8Ke2ycnT6XTH+tOB
         Z6CJGlL3NaElWQRHEajxnqzBpuCfDM6wZXSpdcoeRopZyUSz+T6gVmaSkSMELGLfYaBS
         MlmKOw6diR3j91/0jAvShg9q2nA3cOPpP/QRPh/vAr6x2veEPszNta0+PheAO8M/u9l6
         ugeQ==
X-Gm-Message-State: AOAM5320CkTW0KsH6X5sEKP3yf3+4Hm13XOvPzsZkDtL0uzjJzit851c
        AupK+FYB3F9FV685ReutD08bkyjJ8ko=
X-Google-Smtp-Source: ABdhPJw+S4FgoAdR7DZeBulOy1aFN2LgAw3ucmR6tKKxRz4eD4XjCbxy6t00UXwdPHXauRw0b/2RjQ==
X-Received: by 2002:a1c:6a01:0:b0:37f:1b18:6b17 with SMTP id f1-20020a1c6a01000000b0037f1b186b17mr2313344wmc.146.1646725196576;
        Mon, 07 Mar 2022 23:39:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d4d83000000b001f1d72a6f97sm8799207wru.50.2022.03.07.23.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 23:39:56 -0800 (PST)
Message-Id: <bdbf61ee6a0c3cff1a570f4ef166f38afd9a4242.1646725188.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 07:39:46 +0000
Subject: [PATCH 7/9] git-sparse-checkout.txt: flesh out non-cone mode pattern
 discussion a bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 2cfb1d8f599..35e4e2d809e 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -273,12 +273,23 @@ manually to ensure Git can behave optimally.
 INTERNALS -- FULL PATTERN SET
 -----------------------------
 
-By default, the sparse-checkout file uses the same syntax as `.gitignore`
-files.
-
-While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
-files are included, you can also specify what files are _not_ included,
-using negative patterns. For example, to remove the file `unwanted`:
+As noted above, the sparse-checkout file uses the same syntax as
+`.gitignore` files; see linkgit:gitignore[5] for details.  Here,
+though, the patterns are usually being used to select which files to
+include rather than which files to exclude.  (However, it can get a
+bit confusing since gitignore-style patterns have negations defined by
+patterns which begin with a '!', so you can also select files to _not_
+include.)
+
+For example, to select everything, and then to remove the file
+`unwanted` (so that every file will appear in your working tree except
+the file named `unwanted`):
+
+    git sparse-checkout set --no-cone '/*' '!unwanted'
+
+These patterns are just placed into the
+`$GIT_DIR/info/sparse-checkout` as-is, so the contents of that file
+at this point would be
 
 ----------------
 /*
-- 
gitgitgadget

