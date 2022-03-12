Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14793C433F5
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 03:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiCLDMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 22:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiCLDMn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 22:12:43 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21104293F12
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 19:11:30 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so6376829wmb.3
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 19:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OIWHVaXUU1GgLk38QHAKqM6YI1ciLeNWXBz6gu03WNs=;
        b=gFLPAAa9fhZuri0i4xjxERQA4imtwlI3NZlLulNQWbVsY7/U+x7o/nqqD6hUfhOatO
         QfUybTvvrzKfk193xlFw9XYRR//djUAtN1pEr9ffH7jwi62ZHkPGAn1+esDxf3iEGpuw
         CxlUnr+GCy4Atcq3OoZHdfiZT+gTO/SMnzVgzM8sXCnVBx5j0a6/KZc1PWF5Az0PhhHP
         U+cIzRX7klxsw6siWwEy+YZ2h7IOARXmiGEnyH6dbEcYEJ6vJGesGyKU/hQeXWBDID9Q
         FjtUoJXyDIIwxYXK53+U73beoaFmAskacN+k+rtWzyIfBwaq0yUR0kPj3Wfxdclz8fX7
         Y+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OIWHVaXUU1GgLk38QHAKqM6YI1ciLeNWXBz6gu03WNs=;
        b=blpGXd9uWwG3hXAQpYXRPfMTqEKhOmzj7KyQZK4NG0byu6ij4CyE6y4hBlqwWzeRhT
         njzLPmuwWZdaAQKFcwvHl9aqf0NsSa0bQOU8KZanKh8YQNNGDNML//r6xajH5xNGzttk
         WnEczpxhGCqW3gqSYtOQzzJuRYynmFi9QOex3FPlB4ixfahRkLP+z4UB5FsKejVcrXtD
         dz5Anw6yI2shVZoKxsXRNcy3nPDSq43+ZUoeWN5M+GWJz69vjN1WACJnV7e5VvCPEYc9
         kBBluA23bnm8P4m/chNVKwW06mym9vdhd8LbtTmcq74u607eKBhUIOhmLjwokZPmWRoI
         osxw==
X-Gm-Message-State: AOAM532jkFaZc8gfN4C2n7iARnjG7mRz1JV2NAol6J7btkPAXgn6kU2B
        NagaYTPI4G2wlbR+/asgAHoVsegdHt8=
X-Google-Smtp-Source: ABdhPJzN+7urtNuJGdoBB1/sqdw/fiL+Xt8w/Kyj4XH4OizM5C4U7lgvChFYftgDzAUPu7m7uZzGRg==
X-Received: by 2002:a05:600c:3541:b0:389:95b2:5f63 with SMTP id i1-20020a05600c354100b0038995b25f63mr18101554wmq.126.1647054688501;
        Fri, 11 Mar 2022 19:11:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k17-20020a05600c1c9100b00386bb6e9c50sm18267652wms.45.2022.03.11.19.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 19:11:28 -0800 (PST)
Message-Id: <78028ecaa58f2c0b395b417cfa2543e73ab51fae.1647054681.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
        <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Mar 2022 03:11:19 +0000
Subject: [PATCH v2 7/9] git-sparse-checkout.txt: flesh out non-cone mode
 pattern discussion a bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
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
index dddf5ac6942..ae6ea8b48b0 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -274,12 +274,23 @@ manually to ensure Git can behave optimally.
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

