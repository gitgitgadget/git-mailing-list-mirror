Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF8081F453
	for <e@80x24.org>; Fri, 21 Sep 2018 15:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390626AbeIUVrg (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 17:47:36 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:43131 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390577AbeIUVrf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 17:47:35 -0400
Received: by mail-lj1-f172.google.com with SMTP id m84-v6so12080415lje.10
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 08:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b4M3/LpaK5y6T0f/lyATtjEwjT7ofK1Os5gKnJL4DhU=;
        b=L2w4FC1nMEQXUHWXZowGLHMthKHCJQYqHyEpjCDZuz/8FggY2rHcnTSh7lRmxW3nN6
         EcMlVDBvBKDk10aFM1kte6GS6R8Vez/yHS+i4S6CnGgUD5LF5GIx0tKzi7f9rW2G1aNI
         +GmUsMwTqbSzHu5egOrUioEvQqoBOjss5QI/gYgvoIljgHXY5OpOvriplBMwNrs6LGRW
         uvbzPtLeSbcsxkZ8QhsyGRiWNJE7uKMA1S0luYypIWzOHOYVLYVz/IrYNpRpY+ClrIna
         y4GWYqqMZvha1L+I2KF6tM8BtOkLH62/s9WW+ctkF1ud9OE9yiGZzPNy5en7ijzF7xx9
         E86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b4M3/LpaK5y6T0f/lyATtjEwjT7ofK1Os5gKnJL4DhU=;
        b=fzKw0lOhFg+YxQrIrT2lziBqEspsexKp6JqKRWxPRw/afaMtSgzoDH3EbdZkPOyJjN
         YdkhlsbAOCGMhbBrfjE1ZYbalYxQ1E0ad0Cw3DZ2NF0dbNb55p2DyykUaBsxJuqB8pY/
         L94ucgIoHXer7UXUo6tzKkOrIs6GuwtNnt4dE3OcJxfzrCtj5Wf5RNIr51W0BEkmhDBx
         UiGdnXOeOZY/zUuwRPptR6OHCMay+og7QqOWK5/502OeO75g7FQ/04nLG7vDg38v8x7c
         lAXScUyi8W+G2MVmR9Mk2cB9FK3AjA9Rzg/iPQXAv8HJWdv90cVH+J9HdskSI8/FH/87
         +LSg==
X-Gm-Message-State: ABuFfogfpe5f4G5q1dsP+GoPu2eUG0tMB1oyEPKO1tTOOrwy6B3Of2vL
        1QTstKKimS7oG/quUlmcT6a6A60I
X-Google-Smtp-Source: ACcGV63Sh1Tq/6t5ZE6XpBuskPm+byPRsLRQiXkRohlXh2hhdtaNs1qPlahunn8IMQVXfImjvzsdNg==
X-Received: by 2002:a2e:97c8:: with SMTP id m8-v6mr2529765ljj.52.1537545483876;
        Fri, 21 Sep 2018 08:58:03 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o19-v6sm2192978lfk.30.2018.09.21.08.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:58:03 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Subject: [PATCH v5 14/23] patch-ids.c: remove implicit dependency on the_index
Date:   Fri, 21 Sep 2018 17:57:30 +0200
Message-Id: <20180921155739.14407-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.640.gcd3aa10a8a
In-Reply-To: <20180921155739.14407-1-pclouds@gmail.com>
References: <20180915161759.8272-1-pclouds@gmail.com>
 <20180921155739.14407-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c | 2 +-
 patch-ids.c   | 4 ++--
 patch-ids.h   | 3 ++-
 revision.c    | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 4b602236d6..978fe7c10f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -914,7 +914,7 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 	if ((flags1 & UNINTERESTING) == (flags2 & UNINTERESTING))
 		die(_("Not a range."));
 
-	init_patch_ids(ids);
+	init_patch_ids(the_repository, ids);
 
 	/* given a range a..b get all patch ids for b..a */
 	init_revisions(&check_rev, rev->prefix);
diff --git a/patch-ids.c b/patch-ids.c
index 342950c79d..7da86047d9 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -56,10 +56,10 @@ static int patch_id_cmp(const void *cmpfn_data,
 	return oidcmp(&a->patch_id, &b->patch_id);
 }
 
-int init_patch_ids(struct patch_ids *ids)
+int init_patch_ids(struct repository *r, struct patch_ids *ids)
 {
 	memset(ids, 0, sizeof(*ids));
-	repo_diff_setup(the_repository, &ids->diffopts);
+	repo_diff_setup(r, &ids->diffopts);
 	ids->diffopts.detect_rename = 0;
 	ids->diffopts.flags.recursive = 1;
 	diff_setup_done(&ids->diffopts);
diff --git a/patch-ids.h b/patch-ids.h
index 79ac9a8498..82a12b66f8 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -6,6 +6,7 @@
 
 struct commit;
 struct object_id;
+struct repository;
 
 struct patch_id {
 	struct hashmap_entry ent;
@@ -20,7 +21,7 @@ struct patch_ids {
 
 int commit_patch_id(struct commit *commit, struct diff_options *options,
 		    struct object_id *oid, int);
-int init_patch_ids(struct patch_ids *);
+int init_patch_ids(struct repository *, struct patch_ids *);
 int free_patch_ids(struct patch_ids *);
 struct patch_id *add_commit_patch_id(struct commit *, struct patch_ids *);
 struct patch_id *has_commit_patch_id(struct commit *, struct patch_ids *);
diff --git a/revision.c b/revision.c
index 0c6dc8c163..d70587678c 100644
--- a/revision.c
+++ b/revision.c
@@ -877,7 +877,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 		return;
 
 	left_first = left_count < right_count;
-	init_patch_ids(&ids);
+	init_patch_ids(the_repository, &ids);
 	ids.diffopts.pathspec = revs->diffopt.pathspec;
 
 	/* Compute patch-ids for one side */
-- 
2.19.0.640.gcd3aa10a8a

