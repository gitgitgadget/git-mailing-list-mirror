Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768A4C433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 03:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 434F2611ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 03:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhDWDRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 23:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhDWDRl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 23:17:41 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB86C061574
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 20:17:06 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id e18-20020a17090ac212b029014dedae7057so537633pjt.6
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 20:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=H8JFRw70MIAMlI1X/NFeKFLZd6m44GDM3r6uE+7MwCI=;
        b=ga/InklrI9R5XlCZXidWPL4N4Mm0nNh9WGD1iv5qwusk/IA9FOiAOvVQK9zvo/94Hg
         42m/pJo0a1jsgSs1FiAN2305t72CZnR9h6XWJmoXMP/nQ5262XUKF730C9ee+kWIiC5E
         IfsDkbCU1dCF+K1nE4s4ueoZtMVFcqs9g8Zd4KgAqMnheYN89BduZ1N25/VUwQZHSC+7
         20uNhd9OcdFSbbqeX9lzhyq1oqm6T5ZDor2KOcdBiKXOgLPLb8RPDbqgyhLsiNfv0TkK
         xJXbQS/ZJIcPWm2uvKtQnqBVOORP8mq+k9ZT0NUN1+IwHGbO5BnfVD/PRedM9GKDFUWT
         twsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=H8JFRw70MIAMlI1X/NFeKFLZd6m44GDM3r6uE+7MwCI=;
        b=lyXzxjSLyxmd0etlOpsZkAPWSwmbRKC94sxWhjZ/k47FIHpTxZisrJ9ArfpDeNVnwR
         0wYjuiATU81qPzQzpcMR3OD0oBp7hfDZb4obYSgWQOhmDWHd7zTfO59r3Y4wxn36oqIz
         HSRhiRvSnBXmy7yZMfycRhAHSRl+eE6Rh7ESKV2iNWa6WHzScrFaUjV6SC4rJqzghEC0
         css3fJcO/vYTjVhg5/59SfB0bSlhs/C9sc35dIxNdS/rg1wtHiryWv7y8PcFUqQc/fSz
         tETN7RQSN2iFQzvfMkpddhYU1/3cx2jmMVinub3TFp7HirtDUwJlrSMR0kjXTrWRizc3
         to4g==
X-Gm-Message-State: AOAM531jngvz2VW02jkT6SmCK8Poldbl6jF0ZnZln76UrgMEHdBhHnnF
        QSCy1Uv2oHu2WqyZTSVpzviiCpvX+JrxD5M2jztSV8diZqKYeJX0MXFkTnJGGLB3q1WfWQuRAev
        /LEp4VqZiupIahmUNmebJlAshssHEyGB8+u/0/j9Gsjp/n9njAKsnN/pDRpes+/tJkfDnrmzTM5
        42
X-Google-Smtp-Source: ABdhPJwghrPdP2RlxGUpbX1+K3LasDwaZfJOvdOFC0iNX5m0C/i+atHJknWar957Z2w2PabqGa16SK4TkedDWV55L3Ml
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:903:1ca:b029:ea:fc69:b6ed with
 SMTP id e10-20020a17090301cab02900eafc69b6edmr1944299plh.80.1619147825230;
 Thu, 22 Apr 2021 20:17:05 -0700 (PDT)
Date:   Thu, 22 Apr 2021 20:16:59 -0700
Message-Id: <20210423031659.2362659-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH] cache-tree: avoid needless promisor object fetch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In update_one() (used only by cache_tree_update()), there is an object
existence check that, if it fails, will automatically trigger a lazy
fetch in a partial clone. But the fetch is not necessary - the object is
not actually being used.

Replace that check with two checks: an object existence check that does
not fetch, and then a check that that object is a promisor object.

Doing this avoids multiple lazy fetches when merging two trees in a
partial clone, as noticed at $DAYJOB.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Another alternative is to think about whether the object existence check
here is needed in the first place.

There might also be other places we can make a similar change in
update_one(), but I limited myself to what's needed to solve the
specific case we discovered at $DAYJOB.
---
 cache-tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index add1f07713..6728722597 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -6,6 +6,7 @@
 #include "object-store.h"
 #include "replace-object.h"
 #include "promisor-remote.h"
+#include "packfile.h"
 
 #ifndef DEBUG_CACHE_TREE
 #define DEBUG_CACHE_TREE 0
@@ -362,7 +363,9 @@ static int update_one(struct cache_tree *it,
 			(has_promisor_remote() &&
 			 ce_skip_worktree(ce));
 		if (is_null_oid(oid) ||
-		    (!ce_missing_ok && !has_object_file(oid))) {
+		    (!ce_missing_ok &&
+		     !has_object_file_with_flags(oid, OBJECT_INFO_SKIP_FETCH_OBJECT) &&
+		     !is_promisor_object(oid))) {
 			strbuf_release(&buffer);
 			if (expected_missing)
 				return -1;
-- 
2.31.1.498.g6c1eba8ee3d-goog

