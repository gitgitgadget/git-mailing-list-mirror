Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DD291F436
	for <e@80x24.org>; Sun, 26 Aug 2018 10:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeHZNpj (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 09:45:39 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:39897 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbeHZNph (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 09:45:37 -0400
Received: by mail-lj1-f175.google.com with SMTP id l15-v6so10022836lji.6
        for <git@vger.kernel.org>; Sun, 26 Aug 2018 03:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zMmEKOGiuBhRKGHIzVl/N99YTFcyRmNpJUlGnSRXVUI=;
        b=ZL5rs9tKaz8XrrMibVmwy5tiBdOVxgJhrLfrSuAVOdYdrp3jjZuePrTT5gAnJyxNi2
         MSODVyLsm2RUqRVdNGNTHCSnWLB4MpibykWauNUe+JEh+Frv6Abzl9/dzM8FXjBFXVvJ
         4j4bBdXO555TR2CHLppkh19/tIMstGSjc0Z3sdCvfPzz6Ih+rjDJXobrAjuQIDeYlYxt
         yLIr8QBWsuMMHYVJVwW6pnzr8aO30urmtXWS7wLuDmS0E0Zym8YWcTmVmoGNTuuDCbRC
         4kTkO6HIdZxl2l8SII5QHFGjRtgGaMsc0f1MUZqkI2oUz/MRaB+mZcjKZN9E8QTfONa8
         7AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zMmEKOGiuBhRKGHIzVl/N99YTFcyRmNpJUlGnSRXVUI=;
        b=Lyc6xngasHW0MqXf4Try41fePJbvwOAZfGKeL59bWFBu11fwSDzYAfW6itjlilMocE
         rRQhFjZ2QRhMf9EMs11DtxeTmG1rpH9S4a7IFvKxjG6T9P2XsUutZkhLqakKjsF/cirp
         bXl8n7SXcRq21uCf7OpPRKN9hXJgz0FgpyTAhXRihPzYMHj5B7EjEqgHDQEUBFxdYDa8
         6j1UmzvCuyVrK3jTsYdPXz+JLbGWVA7s0zo5F3p07LUHqmt/ZRoSH0baerhHyEqmCtnV
         aJQYG1sOQEWoPfsomLJcoJbP88/GMFQTkLSftJ4+m+aZF4NalawU21EYeqg45oHT5N5A
         1FKw==
X-Gm-Message-State: APzg51Cx7JGMqcw/hx3xM5b/sQNj0MogpDOByprasv8ZUkJEerY7qxed
        dYCHSMl9D+yf0uDIagJNsbHdzYxX
X-Google-Smtp-Source: ANB0VdbUNUrdsi0pYEHVvLXN57oJuYZ0ptkgKyDGRI68RU1TsZhePzmiGOamu9tQo4JIWgzvTDwf0w==
X-Received: by 2002:a2e:650e:: with SMTP id z14-v6mr5496523ljb.62.1535277809442;
        Sun, 26 Aug 2018 03:03:29 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z5-v6sm2276882lfg.75.2018.08.26.03.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 03:03:28 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/21] patch-ids.c: remove implicit dependency on the_index
Date:   Sun, 26 Aug 2018 12:03:05 +0200
Message-Id: <20180826100314.5137-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180826100314.5137-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/log.c | 2 +-
 patch-ids.c   | 4 ++--
 patch-ids.h   | 3 ++-
 revision.c    | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 33084102e0..2910122d90 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -914,7 +914,7 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 	if ((flags1 & UNINTERESTING) == (flags2 & UNINTERESTING))
 		die(_("Not a range."));
 
-	init_patch_ids(ids);
+	init_patch_ids(ids, the_repository);
 
 	/* given a range a..b get all patch ids for b..a */
 	init_revisions(&check_rev, rev->prefix);
diff --git a/patch-ids.c b/patch-ids.c
index 9084604c77..72ef9e4e8a 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -56,10 +56,10 @@ static int patch_id_cmp(const void *cmpfn_data,
 	return oidcmp(&a->patch_id, &b->patch_id);
 }
 
-int init_patch_ids(struct patch_ids *ids)
+int init_patch_ids(struct patch_ids *ids, struct repository *repo)
 {
 	memset(ids, 0, sizeof(*ids));
-	diff_setup(&ids->diffopts, the_repository);
+	diff_setup(&ids->diffopts, repo);
 	ids->diffopts.detect_rename = 0;
 	ids->diffopts.flags.recursive = 1;
 	diff_setup_done(&ids->diffopts);
diff --git a/patch-ids.h b/patch-ids.h
index 79ac9a8498..1d4cf618f9 100644
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
+int init_patch_ids(struct patch_ids *, struct repository *);
 int free_patch_ids(struct patch_ids *);
 struct patch_id *add_commit_patch_id(struct commit *, struct patch_ids *);
 struct patch_id *has_commit_patch_id(struct commit *, struct patch_ids *);
diff --git a/revision.c b/revision.c
index bfcb0f2a00..d4a539dc69 100644
--- a/revision.c
+++ b/revision.c
@@ -877,7 +877,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 		return;
 
 	left_first = left_count < right_count;
-	init_patch_ids(&ids);
+	init_patch_ids(&ids, the_repository);
 	ids.diffopts.pathspec = revs->diffopt.pathspec;
 
 	/* Compute patch-ids for one side */
-- 
2.19.0.rc0.337.ge906d732e7

