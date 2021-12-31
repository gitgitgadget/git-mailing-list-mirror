Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDBEC433FE
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 05:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhLaFEL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 00:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhLaFEI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 00:04:08 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DD8C061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 21:04:08 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r17so54148039wrc.3
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 21:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HsHj2KxDWTA9QM6TZSN11NDwemvgrQd3pHbka8fElO8=;
        b=UpmRmGP0FbaDBlz6iqimRaxKPMzk3guOU3Rh6fURB328qses/SkLwQ1dfA6p7+ZBkN
         xPWo5/Yq29ZwOZwhmqDOVUU3g00703xbmksAQu9dUo4noKJMcDEInihA1dSrsrsRCbpF
         7/M7a1ER2kD7EgvlQgz952Yc89tmF72Xd2xO2pZXRko2D/V/muq3u504rLPLCDWF6rkb
         apJ8vk7hDX8dGX7SDMId3Dyk01dXYxh78I1Wj//7iulOZaan6jHV2EcSZJbSUhk/Rqvc
         wIvAdltsF2UrecN+YlxmGWI4ecg4d1xTnDuhT1G1YZq0uEG4Uxx8tg6SOVUMViUPO5dA
         xCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HsHj2KxDWTA9QM6TZSN11NDwemvgrQd3pHbka8fElO8=;
        b=sgMSYktvEgKex5k7B3DFfELMwJx4LvQD/pW//y4CSaArmLPjJ9s4AlcJHXrXDkrtgW
         7pdCuYlwK+z0bQ0VuyBolFYWjuuh4UXAsXh1MnocmG68OK+pFhRn+2ZMDCnltaoMzVhb
         XM7pV2bbUKChFGv7RaFZZTYAHBCt+VSfGx0Nd8auoKvrDHxiioFWv+NaKtlNO0lUsFuL
         rHjwZTqos3BskZDaeC9zMVsd2cGPhqjS9T+ljMR/t3AcyhvDHK+/XKaekWiC6kanxJ0X
         CtNd+JkcADITRDP9ZQX+6d0juVgA8YLajM3ArU6bJlo2083FO18PPMh8mkzGjoMnDRdx
         wU1w==
X-Gm-Message-State: AOAM5319Sd/LDpvm8TE0RZg4+658sPw4dyq7OWtoMsVU+aYbgv0m9B2+
        DOl/iAO7puby+UYiCtBQs096vGbYoSQ=
X-Google-Smtp-Source: ABdhPJyFDeMgQdYQEEIcWaACkbKiyCfQKL18+eNtVQHhZQYoNLWR/eV6rERvX3tS9rpNdlqcI8FM2A==
X-Received: by 2002:adf:fa81:: with SMTP id h1mr4826196wrr.19.1640927046598;
        Thu, 30 Dec 2021 21:04:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h19sm24527432wmm.13.2021.12.30.21.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 21:04:06 -0800 (PST)
Message-Id: <a7c7910d834b2e46ee6c5063db48f9cf551d0a35.1640927044.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Dec 2021 05:03:57 +0000
Subject: [PATCH 1/8] merge-tree: rename merge_trees() to trivial_merge_trees()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

merge-recursive.h defined its own merge_trees() function, different than
the one found in builtin/merge-tree.c.  That was okay in the past, but
we want merge-tree to be able to use the merge-ort functions, which will
end up including merge-recursive.h.  Rename the function found in
builtin/merge-tree.c to avoid the conflict.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge-tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 5dc94d6f880..06f9eee9f78 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -28,7 +28,7 @@ static void add_merge_entry(struct merge_list *entry)
 	merge_result_end = &entry->next;
 }
 
-static void merge_trees(struct tree_desc t[3], const char *base);
+static void trivial_merge_trees(struct tree_desc t[3], const char *base);
 
 static const char *explanation(struct merge_list *entry)
 {
@@ -225,7 +225,7 @@ static void unresolved_directory(const struct traverse_info *info,
 	buf2 = fill_tree_descriptor(r, t + 2, ENTRY_OID(n + 2));
 #undef ENTRY_OID
 
-	merge_trees(t, newbase);
+	trivial_merge_trees(t, newbase);
 
 	free(buf0);
 	free(buf1);
@@ -342,7 +342,7 @@ static int threeway_callback(int n, unsigned long mask, unsigned long dirmask, s
 	return mask;
 }
 
-static void merge_trees(struct tree_desc t[3], const char *base)
+static void trivial_merge_trees(struct tree_desc t[3], const char *base)
 {
 	struct traverse_info info;
 
@@ -378,7 +378,7 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	buf1 = get_tree_descriptor(r, t+0, argv[1]);
 	buf2 = get_tree_descriptor(r, t+1, argv[2]);
 	buf3 = get_tree_descriptor(r, t+2, argv[3]);
-	merge_trees(t, "");
+	trivial_merge_trees(t, "");
 	free(buf1);
 	free(buf2);
 	free(buf3);
-- 
gitgitgadget

