Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A77C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB19961100
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhJ2NyC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 09:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhJ2NyA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 09:54:00 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5085C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:51:30 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m22so16365613wrb.0
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+eg35DJMCdU5TsE9YAXGI0p0oomtGVacKPQUl53M+C0=;
        b=EWsglNEiuWAXzUfiYJxM+x+QU7lVL29IeIqP6N1niotX6S9mWKb3nUxunjbIg2ZMPA
         Zl5rIR8oL9IVyqfNgvdvlfnTfnWnwpMd1NHgsbv/b5BhiTjvHba9hrYDSuW4tpOaIr1e
         HzprehDKtp3RbxPovNAmGysZdhKbYSSPLeTPR+gzPYlYC1X/d4BGaqFW4wczgxtLHEjw
         0o0zSNcUDqRW7chwKd9HBZJsrnwGfW+Q3Yd4RvaFy4kndHaP2OMtX1PC0rANJSxWsYtK
         BN7XLC1aEjAmNlirvLrX/QDcV31vuX3bpegF26eDIKxBAo52XPXNyfJ5Ga+1y2mGwFU5
         KIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+eg35DJMCdU5TsE9YAXGI0p0oomtGVacKPQUl53M+C0=;
        b=W3/RfSjtbyIBgjo+hep3ogWZXK7DrlU9pMYc3YvUzNZovLQZ+vdXebl7eztRLpCt84
         djgaQ7jC+VwVzvMnbaZ7de4AS7urkjK4p+dEP9yL60uAvsHH+/tObuMrg5+d5z4nrbkC
         4cHqdYH5NpXkh6DyBoJhgQyGWtI5Uh/2Qng++THbjLA2EzvGgrn6r8tYnUqcYtuzU3ZU
         XyzzdqyWu4Lb0CFyFdzMhyGcV+sDvIcL+YrlEwelUe9kXxFhbnA5VRw1+lr4YpX68zRw
         B8rAZ4TN+YjLOWEUTKUSF1NWe4uuUyx6+0FOoiAxDiHRw7v/LtsqFx6fX+FkdAv+7FBw
         X6NQ==
X-Gm-Message-State: AOAM533EPudUa0+6Za9ryPKhvcZltQ/kbjwtxOtzlpULYcYXV9RG/blA
        s4kVKenDqp261Zlj/GHbGxLhvFc95bE=
X-Google-Smtp-Source: ABdhPJyAV9YODI6ANTKQn5yn98/A+lcUudZy+Vob5Q8n+CjF/YyEt5KmJ3ma7iheMLmdS2ZVl6g+nw==
X-Received: by 2002:a05:6000:44:: with SMTP id k4mr14597513wrx.68.1635515489452;
        Fri, 29 Oct 2021 06:51:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8sm5766575wrj.41.2021.10.29.06.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 06:51:29 -0700 (PDT)
Message-Id: <91351ac4bded2c19264cd2009e90ee71fcf67b81.1635515487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com>
References: <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
        <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 13:51:24 +0000
Subject: [PATCH v4 2/4] sparse-index: avoid unnecessary cache tree clearing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

When converting a full index to sparse, clear and recreate the cache tree
only if the cache tree is not fully valid. The convert_to_sparse operation
should exit silently if a cache tree update cannot be successfully completed
(e.g., due to a conflicted entry state). However, because this failure
scenario only occurs when at least a portion of the cache tree is invalid,
we can save ourselves the cost of clearing and recreating the cache tree by
skipping the check when the cache tree is fully valid.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Co-authored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 sparse-index.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index 7b7ff79e044..85613cd8a3a 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -175,17 +175,20 @@ int convert_to_sparse(struct index_state *istate, int flags)
 	if (index_has_unmerged_entries(istate))
 		return 0;
 
-	/* Clear and recompute the cache-tree */
-	cache_tree_free(&istate->cache_tree);
-	/*
-	 * Silently return if there is a problem with the cache tree update,
-	 * which might just be due to a conflict state in some entry.
-	 *
-	 * This might create new tree objects, so be sure to use
-	 * WRITE_TREE_MISSING_OK.
-	 */
-	if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
-		return 0;
+	if (!cache_tree_fully_valid(istate->cache_tree)) {
+		/* Clear and recompute the cache-tree */
+		cache_tree_free(&istate->cache_tree);
+
+		/*
+		 * Silently return if there is a problem with the cache tree update,
+		 * which might just be due to a conflict state in some entry.
+		 *
+		 * This might create new tree objects, so be sure to use
+		 * WRITE_TREE_MISSING_OK.
+		 */
+		if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
+			return 0;
+	}
 
 	remove_fsmonitor(istate);
 
-- 
gitgitgadget

