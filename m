Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A097C4332F
	for <git@archiver.kernel.org>; Fri, 23 Dec 2022 19:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiLWTZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Dec 2022 14:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiLWTZr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2022 14:25:47 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19B0BC38
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 11:25:46 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso1547034wmb.3
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 11:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=di/LJXrsNMGG8elDrTZrKEeWEo0/27QjDiAP69l8WQw=;
        b=FeU3pM9brSjN3XQENwlCUHGprIBC+UzAZkBulKIxh2dnOiKE48CT7KTeO1K0zXDcLz
         uAUQj8jv1XgDefdPfb1TNmCFcSrONiSCCWG2k0hWSIC32EMWgP7Wg0Okl/nFvSq0ttiO
         0RYb58FFovfOboKao5x9ulSWzKO1XS2RIx8c8E5IqzScJC3RvGJ8gMZDqtk/JxT/ZTjL
         24lJigKoYCG8gPnqMqIP0z+UH1xEY9t8msc9aZ5h3UeAXup1mnrsRltYMC8gg4Ktaipd
         xdNIzPUbraNTAM8lNl3ZfUhStEoBWxeC15kK3zohljfax86T78CgsrnccARmZc0TMS9a
         4ksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=di/LJXrsNMGG8elDrTZrKEeWEo0/27QjDiAP69l8WQw=;
        b=Tb4znEgBv3T3qIk8eFykayWgs6KDnc1mX8tKqcHXL8dGaWNutytd8l/wx51vK2jkhe
         L4jHHFQpgI4+8DkMSbjT9JeEFtGnt/4jwf6D6DF/291KjwHzsczwOFL9ZDg2IS27QW4r
         6SnKwCw66r7h1O00NvbqiPDdlv6gCBtH2JfZrjHdwXAZPR5TsBLm6r/Vo0sYbTqmDU90
         G0qONlFGPZ+FOEt4Ya6ZgIIDbe/uRM/y7Cw1AEms8BsqAsA9aTWZLMRZ6uZNWUXpci9x
         IYeI2sIeMrbZ5BzAlgsBkUZYQuSM1KoKMiMaMzTfeBh8n4csPGi035D/3b5chzo/O/xJ
         gOuA==
X-Gm-Message-State: AFqh2kq+gvbdkFv6qAZsohuvWVENKHSQeFCo2i0YNW0ugeOUfgBOPa6/
        UZN7tiunJIozNOYt41p0cQxyk5t5VIE=
X-Google-Smtp-Source: AMrXdXu3+DKDghWu48Kah+ScxUgBz3R7ua/DW9kHZ5B5CdxmFq4kQ01ATnWaTqDUz1BwtiGhzrM/3g==
X-Received: by 2002:a05:600c:4854:b0:3d3:5a4a:90ff with SMTP id j20-20020a05600c485400b003d35a4a90ffmr8369579wmo.23.1671823545414;
        Fri, 23 Dec 2022 11:25:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc7-20020a05600c524700b003a3442f1229sm11695418wmb.29.2022.12.23.11.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 11:25:45 -0800 (PST)
Message-Id: <pull.1415.v2.git.git.1671823544512.gitgitgadget@gmail.com>
In-Reply-To: <pull.1415.git.git.1671746464482.gitgitgadget@gmail.com>
References: <pull.1415.git.git.1671746464482.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Dec 2022 19:25:44 +0000
Subject: [PATCH v2] range-diff: check for NULL over comparisons
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

Although at first it may seem easier to
check for the same comparison that
determined whether a_util or b_util is NULL
or not, checking for null directly
would make more sense for developers
and static analysis tools, which false-flag
this area specifically as having potential NULL
pointers.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    range-diff: check for NULL over comparisons
    
    Although at first it may seem easier to check for the same comparison
    that determined whether a_util or b_util is NULL or not, checking for
    null directly would make more sense for developers and static analysis
    tools, which false-flag this area specifically as having potential NULL
    pointers.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1415%2FAtariDreams%2Fmore-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1415/AtariDreams/more-v2
Pull-Request: https://github.com/git/git/pull/1415

Range-diff vs v1:

 1:  b0e92aaf227 ! 1:  e3d850ff3ea range-diff: heck for NULL over comparisons
     @@ Metadata
      Author: Seija Kijin <doremylover123@gmail.com>
      
       ## Commit message ##
     -    range-diff: heck for NULL over comparisons
     +    range-diff: check for NULL over comparisons
      
          Although at first it may seem easier to
          check for the same comparison that


 range-diff.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 8b7d81adc1b..a5f5996c0ec 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -506,11 +506,11 @@ static void output(struct string_list *a, struct string_list *b,
 		b_util = j < b->nr ? b->items[j].util : NULL;
 
 		/* Skip all the already-shown commits from the LHS. */
-		while (i < a->nr && a_util->shown)
+		while (a_util && a_util->shown)
 			a_util = ++i < a->nr ? a->items[i].util : NULL;
 
 		/* Show unmatched LHS commit whose predecessors were shown. */
-		if (i < a->nr && a_util->matching < 0) {
+		if (a_util && a_util->matching < 0) {
 			if (!range_diff_opts->right_only)
 				output_pair_header(&opts, patch_no_width,
 					   &buf, &dashes, a_util, NULL);
@@ -519,7 +519,7 @@ static void output(struct string_list *a, struct string_list *b,
 		}
 
 		/* Show unmatched RHS commits. */
-		while (j < b->nr && b_util->matching < 0) {
+		while (b_util && b_util->matching < 0) {
 			if (!range_diff_opts->left_only)
 				output_pair_header(&opts, patch_no_width,
 					   &buf, &dashes, NULL, b_util);
@@ -527,7 +527,7 @@ static void output(struct string_list *a, struct string_list *b,
 		}
 
 		/* Show matching LHS/RHS pair. */
-		if (j < b->nr) {
+		if (b_util) {
 			a_util = a->items[b_util->matching].util;
 			output_pair_header(&opts, patch_no_width,
 					   &buf, &dashes, a_util, b_util);

base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
-- 
gitgitgadget
