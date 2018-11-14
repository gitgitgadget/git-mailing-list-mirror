Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F6D41F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbeKNKOj (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:14:39 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:39427 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeKNKOj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:14:39 -0500
Received: by mail-it1-f201.google.com with SMTP id l15-v6so16326393ita.4
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J6zxwZwbL1Z82LBVdSj3y0+cy288hJlU7+cbFX77ISY=;
        b=JvRO2LFb+aJl+2X73JLQ+YGHrjX9MEKDfTSIvRq45lO6q3NOhy2xPfpyeHnDBfcl3A
         co57rebVqY1t/XiSQMnZLhPUB5LIMB8poIbEnz0OP7LNldX3+2FFwP1Ial3wE3FVozax
         cx3D8d3YzTNKZd1ioLeHoKFhVx0PwbI+k+3RNt1UaFIDgQFLktBWT8IL86fV39xsmUWQ
         s9I//QmNlOGWW3IekZFw1P3LpVX/MDZlCje3ixQodlWyiPayO6Cn8fEU2dBMKOYlWT2t
         j+NolNmeVP7UnlTm3AJR5Ay7Vgi65iMqvUolaAINyxxXVKlG6ZleKap9gVTDIZMT9PxW
         UuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J6zxwZwbL1Z82LBVdSj3y0+cy288hJlU7+cbFX77ISY=;
        b=dDeagoVX1PWRoDXY5j+3llFORHp+iI6AeU0+jneQvzXG2sYAynBqfEgvdv8Il6aALi
         aotYrfobdkzs9ErnIiAAgzBviWtcpLlC/zUpXDSoJjwSVc94XkcYM1kxdexM9KWaUr+J
         hvjm0w3nu5usjIhDNIk7hibxdJ9R3si2A6jcuS3n0kf1HW+K5O16TIrzQINwLL3ElVIi
         K6gdf7iQPL94D2ZLjst5BSEyBkZqJeGptY6smhDYRV+qurrnrYm0feoQwHcNHgedU8Yh
         DIckyYBkbqTDnqb+Jfmw7dBfgSfYpAQ35L00XIEsELcW0XSlXlsidDm2FSEjEa26FHcr
         /YVQ==
X-Gm-Message-State: AA+aEWayCoSPzlVHrapJscVC//IiD9WI4NiClcim+S0yQC2hzEmYfIPM
        anHI7FnL+kuNJWOZysV/yWFHhKL8qqqD
X-Google-Smtp-Source: AJdET5etvJ2a+Olq2fRP3pqje6BSVmmvJMfwyJ9uPk5SuUE8Ecq/7iCKawtf9hu3vtrAMuiO3nv7qylJVVoU
X-Received: by 2002:a24:1741:: with SMTP id 62-v6mr73507ith.1.1542154436486;
 Tue, 13 Nov 2018 16:13:56 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:12:53 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-11-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 10/23] commit-reach.c: allow remove_redundant to handle any repo
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit-reach.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index a53b31e6a2..81015830cb 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -156,7 +156,7 @@ struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 	return ret;
 }
 
-static int remove_redundant(struct commit **array, int cnt)
+static int remove_redundant(struct repository *r, struct commit **array, int cnt)
 {
 	/*
 	 * Some commit in the array may be an ancestor of
@@ -174,7 +174,7 @@ static int remove_redundant(struct commit **array, int cnt)
 	ALLOC_ARRAY(filled_index, cnt - 1);
 
 	for (i = 0; i < cnt; i++)
-		parse_commit(array[i]);
+		repo_parse_commit(r, array[i]);
 	for (i = 0; i < cnt; i++) {
 		struct commit_list *common;
 		uint32_t min_generation = array[i]->generation;
@@ -190,7 +190,7 @@ static int remove_redundant(struct commit **array, int cnt)
 			if (array[j]->generation < min_generation)
 				min_generation = array[j]->generation;
 		}
-		common = paint_down_to_common(the_repository, array[i], filled,
+		common = paint_down_to_common(r, array[i], filled,
 					      work, min_generation);
 		if (array[i]->object.flags & PARENT2)
 			redundant[i] = 1;
@@ -249,7 +249,7 @@ static struct commit_list *get_merge_bases_many_0(struct commit *one,
 	clear_commit_marks(one, all_flags);
 	clear_commit_marks_many(n, twos, all_flags);
 
-	cnt = remove_redundant(rslt, cnt);
+	cnt = remove_redundant(the_repository, rslt, cnt);
 	result = NULL;
 	for (i = 0; i < cnt; i++)
 		commit_list_insert_by_date(rslt[i], &result);
@@ -370,7 +370,7 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 			p->item->object.flags &= ~STALE;
 		}
 	}
-	num_head = remove_redundant(array, num_head);
+	num_head = remove_redundant(the_repository, array, num_head);
 	for (i = 0; i < num_head; i++)
 		tail = &commit_list_insert(array[i], tail)->next;
 	free(array);
-- 
2.19.1.1215.g8438c0b245-goog

