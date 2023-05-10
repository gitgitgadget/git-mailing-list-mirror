Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06F5C77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 22:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbjEJW4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 18:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbjEJWzz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 18:55:55 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551D955BE
        for <git@vger.kernel.org>; Wed, 10 May 2023 15:55:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-307c040797bso617894f8f.3
        for <git@vger.kernel.org>; Wed, 10 May 2023 15:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683759340; x=1686351340;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLF17RMkDWQZaPscNLEkVOshiQA/le+SgNc4KUNkIDk=;
        b=DQbm+A2KhmBMUIcXIN9VN9MESJv7N2eZH4kOOPIhc8w22WTOVMO792Jburr+Va8YOQ
         3h+uChpPMlm+sNQbSk17LcAjTqy0iqS3ex9bGnqyFx6aLDTs67EKZXFzvO98SpghSCE1
         E3XWrlmvzF2APiEXqwtxqfzlK7zhL4gaTAtJKSN93UOCOp9gn+Uqri5MSkKnhJX6wBQy
         BZYf0NaAvPeV28sUYjKyAI87hqqR7Njcd8NXeWrKh4NNxenxNbc91BFQ9hvWydfqI18h
         MpiWTP5iKZ0Xyn2LvXRXlJm1LPDwHGMO1TElh1TC736vo+HgH5tAhOtbY8PJqM54zG5O
         +SEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683759340; x=1686351340;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLF17RMkDWQZaPscNLEkVOshiQA/le+SgNc4KUNkIDk=;
        b=U42rVfbc8twvfcPd3L6xCz/+BKymPvlge/OE4N52TR82oyDYnFQH84ypRubB0fvup5
         AcGPpS+kvm65ifA81BKDFQ1j5V9XdP72eYeb/70WsL15zMim9JWwoSKTYEBlwXhC+Cav
         DRYj5hTeUrulVedQWDf1Rohf/jp14TNbwQxE2bCMMWEYCYviusdmI7w33mNRwGpGkUed
         HGy61yYTABFb2x0rcaj9/pQiDgHunmkUn7rPIQJZyGpI5ZVHldorm5yKhJ0N4k2pCaEF
         DqcQaBTRGQpf/tIoQQRHa0F95eaofPzZvHmi2QE4RzC93agPfcezllDlSH3m+NGlWVsI
         KAtw==
X-Gm-Message-State: AC+VfDzbClI45erLRAjhSKhjMDlTv+gUjUcnP6k2Paws81RbLLp+ychm
        WTiUB2RYAHjGUH++QCZqpB9nDtAzOew=
X-Google-Smtp-Source: ACHHUZ6lZXPGfQDJ3PcnABy2DjCC9OsLpC5SoHhJL1LXdDYWJsSnnSsZAEYmN3KJunochUaESTotfw==
X-Received: by 2002:a5d:6990:0:b0:306:31fb:1c3e with SMTP id g16-20020a5d6990000000b0030631fb1c3emr12776504wru.26.1683759340387;
        Wed, 10 May 2023 15:55:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600000cc00b0030795b2be15sm10908038wrx.103.2023.05.10.15.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 15:55:40 -0700 (PDT)
Message-Id: <2ac7c7a7c615db75a46076b58a51d363bc2daf2e.1683759338.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1531.git.1683759338.gitgitgadget@gmail.com>
References: <pull.1531.git.1683759338.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 May 2023 22:55:37 +0000
Subject: [PATCH 1/2] rebase --update-refs: fix loops
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `total_nr` field in the `todo_list` structure merely serves display
purposes, and should only be used when generating the progress message.

In these two instances, however, we want to loop over all of the
commands in the parsed rebase script. The loop limit therefore needs to
be `nr`, which refers to the count of commands in the current
`todo_list`.

This is important because the two numbers, `nr` and `total_nr` can
differ wildly, e.g. due to `total_nr` _not_ counting comments or empty
lines, while `nr` skips any commands that already moved from the
`git-rebase-todo` file to the `done` file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5f22b7cd377..f5d89abdc5e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4202,7 +4202,7 @@ void todo_list_filter_update_refs(struct repository *r,
 		if (!is_null_oid(&rec->after))
 			continue;
 
-		for (j = 0; !found && j < todo_list->total_nr; j++) {
+		for (j = 0; !found && j < todo_list->nr; j++) {
 			struct todo_item *item = &todo_list->items[j];
 			const char *arg = todo_list->buf.buf + item->arg_offset;
 
@@ -4232,7 +4232,7 @@ void todo_list_filter_update_refs(struct repository *r,
 	 * For each todo_item, check if its ref is in the update_refs list.
 	 * If not, then add it as an un-updated ref.
 	 */
-	for (i = 0; i < todo_list->total_nr; i++) {
+	for (i = 0; i < todo_list->nr; i++) {
 		struct todo_item *item = &todo_list->items[i];
 		const char *arg = todo_list->buf.buf + item->arg_offset;
 		int j, found = 0;
-- 
gitgitgadget

