Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EDA31F42D
	for <e@80x24.org>; Sat, 12 May 2018 08:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750854AbeELIAm (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 04:00:42 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45688 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeELIAj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 04:00:39 -0400
Received: by mail-lf0-f66.google.com with SMTP id q2-v6so11013824lfc.12
        for <git@vger.kernel.org>; Sat, 12 May 2018 01:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7rhWRYprIAfUNLOUcFeT3PtTx9EBt8sZEBIrDY7CN4=;
        b=eJXbxbp2KjJ/ggzDyL8EY0WWaltlDoqY3DV2wWOva/KKzcryVcV/W3CXL26wHxTwxo
         6KwPieg/8vxYvxKu0a6zXMbRtPwawbhQoYyGmddUso4eqfAR5WGV1HNzVnkuYOtgf63j
         QmfPx2RCU02J3en36D4PGv1kip/U4aE9md8Hefb+vX+YFF0xzpPOrxnnYqly5tCswOmj
         A+mGuSC4+czeLjdOIykUHS0w4/Xc5g3FcKgOxcwF2uWIPCQcXFAwPipJ2ImZ2d9PfJZP
         mnJdSptxPUc/N4aH6uuyLxxlSU5yqYZpdPt6XgK56pss9DYGBOZVhO2G46jgylYgn0ob
         /3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7rhWRYprIAfUNLOUcFeT3PtTx9EBt8sZEBIrDY7CN4=;
        b=T1b3RgiSAQvAnkFdxGjut02uFoqxeTubUMQDBtLCkyT2GZavZvAfRQst1Xe0EVZsgZ
         +JoZz8eJtUynXnW8UjtSkYnDqnbrNycwCA72ECplh4zXdoE5Iy5TjJG8W0gfHVsNhatY
         7RIMyHyiP/XIX7KXOGBOS5jcG/IK/+5rkpKljQYs9+gseIJOL9z9tLG5zz/knujmZBDH
         GgFThGMHMRMQTaDwkvFRIMDfFEQAkObhpH6AmYP8CJQPwEuWz61VMqtKvGwz0B/o7+Ew
         c3rwoMBCOzYldOheL1ooCPw5KX/j0AKV1p/FVoLlZ5TB5UQizDRFouVXcVvfteuERrMO
         rxMw==
X-Gm-Message-State: ALKqPwcjwPwRlzxKDXt61hJyoSGXbMKLWfVsWGNIb2ljPRsI0iZr3GH5
        ASdaL6n3axlRNYQnotzzhZ8BZQ==
X-Google-Smtp-Source: AB8JxZrcAQ1XkIZBWa/UEhfHQfz20z70a8SB/SxarAqbMxnPcUDvLYGvAye+XL9ULuCIC7pSuZA4Aw==
X-Received: by 2002:a2e:638f:: with SMTP id s15-v6mr510310lje.78.1526112037032;
        Sat, 12 May 2018 01:00:37 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i20-v6sm1055369lfe.69.2018.05.12.01.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 01:00:36 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/12] sequencer.c: use commit-slab to associate todo items to commits
Date:   Sat, 12 May 2018 10:00:21 +0200
Message-Id: <20180512080028.29611-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180512080028.29611-1-pclouds@gmail.com>
References: <20180512080028.29611-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's done so that commit->util can be removed. See more explanation in
the commit that removes commit->util.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sequencer.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5993ffe060..1a0a6916e3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3362,6 +3362,8 @@ static int subject2item_cmp(const void *fndata,
 	return key ? strcmp(a->subject, key) : strcmp(a->subject, b->subject);
 }
 
+define_commit_slab(commit_todo_item, struct todo_item *);
+
 /*
  * Rearrange the todo list that has both "pick commit-id msg" and "pick
  * commit-id fixup!/squash! msg" in it so that the latter is put immediately
@@ -3378,6 +3380,7 @@ int rearrange_squash(void)
 	struct hashmap subject2item;
 	int res = 0, rearranged = 0, *next, *tail, i;
 	char **subjects;
+	struct commit_todo_item commit_todo;
 
 	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
 		return -1;
@@ -3386,6 +3389,7 @@ int rearrange_squash(void)
 		return -1;
 	}
 
+	init_commit_todo_item(&commit_todo);
 	/*
 	 * The hashmap maps onelines to the respective todo list index.
 	 *
@@ -3416,10 +3420,11 @@ int rearrange_squash(void)
 
 		if (is_fixup(item->command)) {
 			todo_list_release(&todo_list);
+			clear_commit_todo_item(&commit_todo);
 			return error(_("the script was already rearranged."));
 		}
 
-		item->commit->util = item;
+		*commit_todo_item_at(&commit_todo, item->commit) = item;
 
 		parse_commit(item->commit);
 		commit_buffer = get_commit_buffer(item->commit, NULL);
@@ -3446,9 +3451,9 @@ int rearrange_squash(void)
 			else if (!strchr(p, ' ') &&
 				 (commit2 =
 				  lookup_commit_reference_by_name(p)) &&
-				 commit2->util)
+				 *commit_todo_item_at(&commit_todo, commit2))
 				/* found by commit name */
-				i2 = (struct todo_item *)commit2->util
+				i2 = *commit_todo_item_peek(&commit_todo, commit2)
 					- todo_list.items;
 			else {
 				/* copy can be a prefix of the commit subject */
@@ -3527,5 +3532,6 @@ int rearrange_squash(void)
 	hashmap_free(&subject2item, 1);
 	todo_list_release(&todo_list);
 
+	clear_commit_todo_item(&commit_todo);
 	return res;
 }
-- 
2.17.0.705.g3525833791

