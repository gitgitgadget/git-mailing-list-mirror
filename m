Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA53CE7A94
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 11:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjIYLv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjIYLvP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 07:51:15 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B89DA
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:51:09 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40528376459so62615385e9.3
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695642667; x=1696247467; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9dUm89CGfIwaCERGUXZ4FfAtS4+A06lMXPHusBs8+k=;
        b=dF0h6IIHK/k88BvzYFgApkPUKeyB1xdOTmoW2zuGcU9IfoiPvRkYay5Jq4EgrmKfL7
         NCMU8mGj6SZ2svQz8xolqrsozpoMOgshi5SoEy5j8V6GKhqBa6L3+MzD6uSh9SuM7BqB
         LDsUPNJ3/cfRIg3njEXDxt/cKQQo7r8QUsAUb06NYL8neqpCjj2esjCe4FuNf0GngOUG
         RcISqMzSd4U9ak1UBiex/4s4POY6x7RMJjPmdtrFYQ+31n8HhB5eLjTnhbjXNN/YWUrf
         3xRlaQiRlTWZfOQ5xD7oopuLIMwpmfzC8S7ctY+IgXQWph2DmwDod4xKl+cs4kpTJKlr
         IHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695642667; x=1696247467;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9dUm89CGfIwaCERGUXZ4FfAtS4+A06lMXPHusBs8+k=;
        b=SX3UPT9K7K5Y7MmkPrGcNjO3KHFHj2usg3fMXrn8nPXqeeEjKVWDOHy3QHRXU/0E+Y
         c5oz+Byr0HiFh9NtqBZFmqMOZNGH2y31BKOHUgGJFEVKRgzhFU5juOhYEkPgyEiuZGn2
         yn94LeM/emSe/e4ELwx5hSbJlZrK/MGx5tAzTVffITP96KufvDtlNDe5Reqqta8+yhdG
         T9kDgBl/IW8OBhhiCWPrGWByTfw6SqEI8LY8EdexGrlUQrMdvBAxrvF/CUxDk+TqydSj
         KON0yNF+Fnwzh2RXNWGXISKwe6rQ0I8yLadWAmcQHeFsRK09VeqDwSnoRr+0a2wllHVo
         aGiw==
X-Gm-Message-State: AOJu0YzrWNj5+fXJULdR98m3api0YTySWSz+V9GetPngbIn1FrRPlUo+
        qV4/XIWyoGd9RbpNi5tsxzzks5BguWg=
X-Google-Smtp-Source: AGHT+IEQ5218rnquorW+7EcpmiphlnDzVH/oC7XYBPqkbcCn0CTIYIT5Qc91hl6nuBii9mdyhwUTVw==
X-Received: by 2002:a7b:ca5a:0:b0:3fe:f74c:b4f6 with SMTP id m26-20020a7bca5a000000b003fef74cb4f6mr5714913wml.17.1695642667582;
        Mon, 25 Sep 2023 04:51:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c294600b0040472ad9a3dsm11917014wmd.14.2023.09.25.04.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 04:51:07 -0700 (PDT)
Message-ID: <b45cc4b8a25c7ef9a918f4c6cef2581ac392b2d7.1695642662.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1588.v2.git.1695642662.gitgitgadget@gmail.com>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
        <pull.1588.v2.git.1695642662.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Sep 2023 11:51:02 +0000
Subject: [PATCH v2 6/6] coverity: detect and report when the token or project
 is incorrect
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When trying to obtain the MD5 of the Coverity Scan Tool (in order to
decide whether a cached version can be used or a new version has to be
downloaded), it is possible to get a 401 (Authorization required) due to
either an incorrect token, or even more likely due to an incorrect
Coverity project name.

Seeing an authorization failure that is caused by an incorrect project
name was somewhat surprising to me when developing the Coverity
workflow, as I found such a failure suggestive of an incorrect token
instead.

So let's provide a helpful error message about that specifically when
encountering authentication issues.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/coverity.yml | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
index 53f9ee6a418..ae76c06e7ce 100644
--- a/.github/workflows/coverity.yml
+++ b/.github/workflows/coverity.yml
@@ -80,7 +80,18 @@ jobs:
                    --fail \
                    --form token='${{ secrets.COVERITY_SCAN_TOKEN }}' \
                    --form project="$COVERITY_PROJECT" \
-                   --form md5=1) &&
+                   --form md5=1)
+          case $? in
+          0) ;; # okay
+          *22*) # 40x, i.e. access denied
+            echo "::error::incorrect token or project?" >&2
+            exit 1
+            ;;
+          *) # other error
+            echo "::error::Failed to retrieve MD5" >&2
+            exit 1
+            ;;
+          esac
           echo "hash=$MD5" >>$GITHUB_OUTPUT
 
       # Try to cache the tool to avoid downloading 1GB+ on every run.
-- 
gitgitgadget
