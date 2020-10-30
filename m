Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA56DC4741F
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45BFA21582
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDt0aDTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgJ3Dmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgJ3Dmg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:42:36 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922DCC0613E5
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:42:04 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id j21so4417755ota.13
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVz3L0N1RYV+ebIGzq6lJCdFUN9PJKLCVgG1iuddNDw=;
        b=CDt0aDTaaA9MDSQCc+F+CBVrXviBvYZJ1KzbIGRO5B94fzxBseg+R6V3wz5ah/UGi6
         /LeJeTvUthRJKscDz8NQsUfypNZ1q52l3hhXa5UIbzojmNHoA8ObgEO/V6TIpastkBMJ
         ueqh3S70Vo9LK5nXUK8XjqOf+ajYFS4XwqcEoOSgeA+uz1XhBKnAkuJyM86z4IoY+Qq5
         7eEIpMjW5JZ9laW9whjpIqlMyjbGDOa2vkk9C7N7s4nn0AeveahrJZt78IhWcJDR0CFB
         FkYEikuizUu73Q2Jo9T8c2hwYYGPTmXCbp+ObX7I1eCLZR9ObPxSb/+GtPZIPH+/8qRE
         hfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVz3L0N1RYV+ebIGzq6lJCdFUN9PJKLCVgG1iuddNDw=;
        b=LLsdCTpBnsERKIyU0/kHOSQQ5QukfKz8BBvCuCRwNkus/5eQFXOCk+59q2ON8yraOW
         3nXW+H/sPwUl1psSJTFw64FIVt+aLrpUvmD4atm83hmJYQxhU970EAMupHqssXvQ2zzZ
         47u4mE3Hin0CfHvL/WM4tLj3USxlE87kocDCPs63LGeuaQghDQ4/i+f0FXGrhWB/RO/6
         fS0MyjCpoxxQjez6sE8IeQYQFlK53XzGOt+BBDb0DHyLINtucQRMY93jZTNewWHkRHan
         +L9CuDASc7asatLxbZB5grCEoqUMF5VsJBP6X114+H5o/y2M2yk8GbvZvIaijvY0ZKpp
         MHdA==
X-Gm-Message-State: AOAM531oKdTKOiUti3BphRrzW5zuxY7KC3ARkiWC9EPK8O3E1usU8kw8
        dUSkwVW9aPHc4/qz8Gccbozz10K0jUMgYw==
X-Google-Smtp-Source: ABdhPJyWTMM7P3piDCIu1RxNxyxLoy4YvqF2Y4qO81etzuoKIsGc+DReFZPG9YLjQfr4K45DtqLCUA==
X-Received: by 2002:a9d:7586:: with SMTP id s6mr211195otk.46.1604029323811;
        Thu, 29 Oct 2020 20:42:03 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x13sm1047063otg.66.2020.10.29.20.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:42:03 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 20/20] merge-ort: free data structures in merge_finalize()
Date:   Thu, 29 Oct 2020 20:41:31 -0700
Message-Id: <20201030034131.1479968-21-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.56.ga287c268e6.dirty
In-Reply-To: <20201030034131.1479968-1-newren@gmail.com>
References: <20201030034131.1479968-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 0b091c86eb..9cd1845c37 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -840,7 +840,29 @@ void merge_switch_to_result(struct merge_options *opt,
 void merge_finalize(struct merge_options *opt,
 		    struct merge_result *result)
 {
-	die("Not yet implemented");
+	struct merge_options_internal *opti = result->priv;
+
+	assert(opt->priv == NULL);
+
+	/*
+	 * We marked opti->paths with strdup_strings = 0, so that we
+	 * wouldn't have to make another copy of the fullpath created by
+	 * make_traverse_path from setup_path_info().  But, now that we've
+	 * used it and have no other references to these strings, it is time
+	 * to deallocate them, which we do by just setting strdup_string = 1
+	 * before the strmaps are cleared.
+	 */
+	opti->paths.strdup_strings = 1;
+	strmap_clear(&opti->paths, 1);
+
+	/*
+	 * All strings and util fields in opti->unmerged are a subset
+	 * of those in opti->paths.  We don't want to deallocate
+	 * anything twice, so we don't set strdup_strings and we pass 0 for
+	 * free_util.
+	 */
+	strmap_clear(&opti->unmerged, 0);
+	FREE_AND_NULL(opti);
 }
 
 static void merge_start(struct merge_options *opt, struct merge_result *result)
-- 
2.29.1.56.ga287c268e6.dirty

