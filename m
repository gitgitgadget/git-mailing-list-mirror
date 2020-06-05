Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B775CC433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 22:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82CF3206A2
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 22:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ACZ4epwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgFEWzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 18:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgFEWzR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 18:55:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAF1C08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 15:55:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k15so13807462ybt.4
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 15:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=RNh3cyaXuhgCVkNkxScn1etA1iTUvlcz6l5As42MnIA=;
        b=ACZ4epwbDX++TnZS17wNhqdd6P4zeFIg2CHSb2hH1vHFLiOY30+DUUQcxqYXkspyoF
         Duz/dOya/2aECbuvm67jyE2RALlYSgmZd8iwMvWZWKERnCYjLrd6OvV/7fGZFttx8XnG
         IKrefzeawbyVMnGY8TqU+UpRXmk38L70Rf6O/CSXgHZB4ouQsMTs2QdLZum6478V5qPm
         x2e6D6r4z7seu5EFVWnHLOlwGA9zlRngrF90dkIiQCQhXmL4WHkous5stVcXxXmc7g7B
         hI8EXtX4qEJr/e2WtqKQMvP0bEloa+ueaMAY7L60AJ2t58gF6uoH9BYpzqzmY/dbaDlJ
         Djgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=RNh3cyaXuhgCVkNkxScn1etA1iTUvlcz6l5As42MnIA=;
        b=THgddI3x0EKCJS2Y20yIYVVCKVQr5JD3g9FQuIP99dZ2+z+P5GBz+NSDtaVn1HrI3I
         OJJvaT/6RfUEKCNMPHdRtZP869AjiDmyAPzViToi3t5lnjQQUDM5aAQ8xFRhG9vP87om
         fkYIbWOf37FYqY07C1006b0J71Gs4eF1Bk3XFLMejnjU+b0HgrN9lLsV+IFWUUXozX8N
         U9xJxycG8qtqrMFUbD8x1y87ZCGE8tzVAY783LU+sLs7s4ZAkRZdtogziIXP/NTnmvBK
         Utsu4wlXHKyuegrciC8gU5tYC1YCBmfJ4PCVCM7l0RUvovH/YHd/nwRXLjXJEqQ1VSpQ
         f6+g==
X-Gm-Message-State: AOAM531Zqy/+LOTPr5NmDinV34f2x0OmHpOKFvB1DHh6tqrYgADp+5T6
        gf4kR2xVjH+Qn/io3VwLnZYE1yTpGIgg5FG7+6AuJmDRUJleSqebEN9ekrZ91oT1wBp/NvzqZ/i
        L/bnlgbh0atirXG/Xl3eUghomJUBvX4PGFlAzhoOvcRLQfLRvAh3tAmFa/ylovK0=
X-Google-Smtp-Source: ABdhPJyK7qqihqBVaZNZUfskLuSvAGG3b4kYSHmYOjCi7MlsK6XQTB4gqjnERy4d/PWTVWIFYZqLClgt5pLm0w==
X-Received: by 2002:a5b:d0a:: with SMTP id y10mr5623600ybp.32.1591397716345;
 Fri, 05 Jun 2020 15:55:16 -0700 (PDT)
Date:   Fri,  5 Jun 2020 15:55:14 -0700
Message-Id: <35063a0ab4edbaa5bd5b0138e6a6a5b36a8664c5.1591397562.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH] fuzz-commit-graph: properly free graph struct
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the provided free_commit_graph() to properly free the commit graph
in fuzz-commit-graph. Otherwise, the fuzzer itself leaks memory when the
struct contains pointers to allocated memory.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 fuzz-commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fuzz-commit-graph.c b/fuzz-commit-graph.c
index 9fd1c04edd..430817214d 100644
--- a/fuzz-commit-graph.c
+++ b/fuzz-commit-graph.c
@@ -12,7 +12,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	initialize_the_repository();
 	g = parse_commit_graph((void *)data, size);
 	repo_clear(the_repository);
-	free(g);
+	free_commit_graph(g);
 
 	return 0;
 }
-- 
2.27.0.278.ge193c7cf3a9-goog

