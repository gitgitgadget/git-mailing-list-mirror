Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAD7F1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 16:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbcG2QUZ (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 12:20:25 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33783 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130AbcG2QUW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 12:20:22 -0400
Received: by mail-pa0-f65.google.com with SMTP id q2so5454705pap.0
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 09:20:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9Xl5tEAg1fQ9S0rQBCXobKjNPRTPC5EvCZjDu5pfxs0=;
        b=PgHXQ0XKuWByLd/6QCeNqKPseedVONRn25Jg3NS5/4VggVtmrnFl7fe/cKsN72aCak
         lJG7YdQ4Ci3rIkm0lmK8Dox4ioWpBJTM3Fhdg0vij6bplNl2Fnae98MU3YPbmWbYwszX
         UlWbTIGNanCrej4qhisjsDlHxNxCwTE66TDS8ndK2UsDpz8unGJbVxz50DBq0506+i7u
         VKDcGzco4ri3bL8r5zfA40uholwii7pXtDM1eEdv4E8ihSI1l0cmfqHKlybKxRpWEu1S
         c9PzseqLnYcmJiutztxdPg5fqUWdcbC1PYPTRwc5hdb1giRTEJKNBGVvz4YI8At6Bcx3
         NtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9Xl5tEAg1fQ9S0rQBCXobKjNPRTPC5EvCZjDu5pfxs0=;
        b=FvR0ztV6KmmW4arkemGfT32BkedaEsuAgu2m4CXo9WTc5xTUaD6ZuD5Fb0jS4Ei2d6
         eQ1rI8ubQliByNOCfuqYiYphvlpm559A81xhpWUUv8HJCtDoMwHIl+iPkUhtuPVDgUpX
         GscXCIbuK0IJw4uwCgzvAUJE76L/Xd1Z+kn8cIfSWJAaqFtNtwvR8qCvmg3CC/r/plJz
         1CfKC8VKRA2pG1jY3CFtgqcjnOT+K5FCK534rbcebXTZEbUCGeDg6jP73XD/Hfq62eJV
         ASXA/umgaFxkniJd7q69PM4/zsSJxcdv4zi+UQuG//xOkN6g5okQBQCljKNJxPhesmwr
         UdfQ==
X-Gm-Message-State: AEkoousk1wmk4jESiv0Xlr24KMRE3scwgX08Kf5WXMcBRZEXZ6riFWJvUxOd8YsqkXTMoA==
X-Received: by 10.66.72.40 with SMTP id a8mr70992585pav.15.1469809222195;
        Fri, 29 Jul 2016 09:20:22 -0700 (PDT)
Received: from DESKTOP-SLJ7FNG.northamerica.corp.microsoft.com ([2001:4898:8010:1::5b0])
        by smtp.gmail.com with ESMTPSA id i69sm26193282pfk.30.2016.07.29.09.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 09:20:21 -0700 (PDT)
From:	Kevin Willford <kcwillford@gmail.com>
To:	git@vger.kernel.org
Cc:	Kevin Willford <kewillf@microsoft.com>,
	Kevin Willford <kcwillford@gmail.com>
Subject: [[PATCH v2] 2/4] patch-ids: replace the seen indicator with a commit pointer
Date:	Fri, 29 Jul 2016 12:19:18 -0400
Message-Id: <20160729161920.3792-3-kcwillford@gmail.com>
X-Mailer: git-send-email 2.9.2.gvfs.2.42.gb7633a3
In-Reply-To: <20160729161920.3792-1-kcwillford@gmail.com>
References: <20160729161920.3792-1-kcwillford@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Kevin Willford <kewillf@microsoft.com>

The cherry_pick_list was looping through the original side checking the
seen indicator and setting the cherry_flag on the commit.  If we save
off the commit in the patch_id we can set the cherry_flag on the correct
commit when running through the other side when a patch_id match is found.

Signed-off-by: Kevin Willford <kcwillford@gmail.com>
---
 patch-ids.c |  1 +
 patch-ids.h |  2 +-
 revision.c  | 18 +++---------------
 3 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/patch-ids.c b/patch-ids.c
index db31fa6..bafaae2 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -43,6 +43,7 @@ static int init_patch_id_entry(struct patch_id *patch,
 			       struct commit *commit,
 			       struct patch_ids *ids)
 {
+	patch->commit = commit;
 	if (commit_patch_id(commit, &ids->diffopts, patch->patch_id))
 		return -1;
 
diff --git a/patch-ids.h b/patch-ids.h
index 9569ee0..dea1ecd 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -4,7 +4,7 @@
 struct patch_id {
 	struct hashmap_entry ent;
 	unsigned char patch_id[GIT_SHA1_RAWSZ];
-	char seen;
+	struct commit *commit;
 };
 
 struct patch_ids {
diff --git a/revision.c b/revision.c
index edba5b7..19cc067 100644
--- a/revision.c
+++ b/revision.c
@@ -846,7 +846,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 		 */
 		if (left_first != !!(flags & SYMMETRIC_LEFT))
 			continue;
-		commit->util = add_commit_patch_id(commit, &ids);
+		add_commit_patch_id(commit, &ids);
 	}
 
 	/* either cherry_mark or cherry_pick are true */
@@ -873,21 +873,9 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 		id = has_commit_patch_id(commit, &ids);
 		if (!id)
 			continue;
-		id->seen = 1;
-		commit->object.flags |= cherry_flag;
-	}
 
-	/* Now check the original side for seen ones */
-	for (p = list; p; p = p->next) {
-		struct commit *commit = p->item;
-		struct patch_id *ent;
-
-		ent = commit->util;
-		if (!ent)
-			continue;
-		if (ent->seen)
-			commit->object.flags |= cherry_flag;
-		commit->util = NULL;
+		commit->object.flags |= cherry_flag;
+		id->commit->object.flags |= cherry_flag;
 	}
 
 	free_patch_ids(&ids);
-- 
2.9.2.gvfs.2.42.gb7633a3

