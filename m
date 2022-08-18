Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11283C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 07:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243685AbiHRHPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 03:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243611AbiHRHPf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 03:15:35 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2782185A95
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 00:15:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id ay12so398188wmb.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 00:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=3/pqxET8XJCTVx5EhMnfRh2yD1k5RKRC3z0FxdL5ejY=;
        b=oqXU7FdGpOe72isC0PlldKbVca1yMqzb0eXZOcGcdS6vrYcnbQAFYTqdNb3xHogfO5
         O+Zz9/OgJm3Q6aCNzKoGczDKYGjueQYC7kfpT7q44Y9Ht6JbA2U2OlewwD+cq8eeVpU0
         xy7wSAHMnsSOXBq/l3Etmmvu3jLNNLH/Rt6Y3wEjMZF3kZIibEOcPsskdL3b3KfqHApR
         6oFhhw5Wttfzj+va0P9TpLE3LTI4cwQUdwUVvV6lE/1+nwxL6XVTY1joUfiWCbqBF8U2
         mR8tb+VvPP3KAfOHCQQT8uwXATB43qgPeEkgW/+tCU4MIJU7a5QAyFOuX0DtKgJs70f8
         p1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=3/pqxET8XJCTVx5EhMnfRh2yD1k5RKRC3z0FxdL5ejY=;
        b=KwbMlfY3HAz7Jl2POfLbUtinQGHJA8A7vzOYuE+hDP5gBXdkq4bVXPfJD5cwN2yDsi
         WhSrNEJ30gO8RbVY1eHBgWJ5rE0/FGDyI4+5Gyby3KU3u+bd15FZro7vVFqE3dvrULSI
         SUn43j73Q3uL6ihBHqlf5/krQ5NJ5joQgkv2hDqfIJzM2Xjj1VLtWX8lkw6/oZJrJjV1
         83PzHBbudA5yGporyuXHuZErfFl5WfRRs/WHw0BwsdUiY5I03MhJZI+0dx87bbr1OFKg
         GQSRJ80s7Ipl+NvPZlcgNTgYXQxRICHoHCxb0lXIp8ETSa+vI8Nz6HTNYRrB5C5A8Ns8
         dsBA==
X-Gm-Message-State: ACgBeo0d6+0hCQwpaAIKK9yGbcMIpxTc/fEMozmg7zdHtMDDgCknU3bM
        +EV0dGtkIJ1cw1UOHFlIq1kcrqAmfyw=
X-Google-Smtp-Source: AA6agR7XrSSSljCtKNZ+VAC7bpgmmVKCAlV7K0P1a3o1qmHDkCoTse/Bv3g0+X9221v42ph1oDelPg==
X-Received: by 2002:a05:600c:1e01:b0:3a5:a418:f9c7 with SMTP id ay1-20020a05600c1e0100b003a5a418f9c7mr945334wmb.169.1660806932467;
        Thu, 18 Aug 2022 00:15:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g1-20020adffc81000000b0022520aba90asm551543wrr.107.2022.08.18.00.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 00:15:31 -0700 (PDT)
Message-Id: <4c4a8f028d4e0a60aa30ba8c049aed339bd02381.1660806927.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1325.v3.git.1660806927.gitgitgadget@gmail.com>
References: <pull.1325.v2.git.1660718028.gitgitgadget@gmail.com>
        <pull.1325.v3.git.1660806927.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 07:15:27 +0000
Subject: [PATCH v3 3/3] merge-ort: provide helpful submodule update message
 when possible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In commit 4057523a40 ("submodule merge: update conflict error message",
2022-08-04), a more detailed message was provided when submodules
conflict, in order to help users know how to resolve those conflicts.
There were a couple situations for which a different message would be
more appropriate, but that commit left handling those for future work.
Unfortunately, that commit would check if any submodules were of the
type that it didn't know how to explain, and, if so, would avoid
providing the more detailed explanation even for the submodules it did
know how to explain.

Change this to have the code print the helpful messages for the subset
of submodules it knows how to explain.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 8f14f1ad0b2..d94e3f17d7b 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4490,21 +4490,17 @@ static void print_submodule_conflict_suggestion(struct string_list *csub) {
 	if (!csub->nr)
 		return;
 
-	/*
-	 * NEEDSWORK: The steps to resolve these errors deserve a more
-	 * detailed explanation than what is currently printed below.
-	 */
+	strbuf_add_separated_string_list(&subs, " ", csub);
 	for_each_string_list_item(item, csub) {
 		struct conflicted_submodule_item *util = item->util;
 
+		/*
+		 * NEEDSWORK: The steps to resolve these errors deserve a more
+		 * detailed explanation than what is currently printed below.
+		 */
 		if (util->flag == CONFLICT_SUBMODULE_NOT_INITIALIZED ||
-			util->flag == CONFLICT_SUBMODULE_HISTORY_NOT_AVAILABLE)
-			return;
-	}
-
-	strbuf_add_separated_string_list(&subs, " ", csub);
-	for_each_string_list_item(item, csub) {
-		struct conflicted_submodule_item *util = item->util;
+		    util->flag == CONFLICT_SUBMODULE_HISTORY_NOT_AVAILABLE)
+			continue;
 
 		/*
 		 * TRANSLATORS: This is a line of advice to resolve a merge
-- 
gitgitgadget
