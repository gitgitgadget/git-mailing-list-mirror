Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8032C1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 18:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbeICWbs (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 18:31:48 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:35668 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeICWbs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 18:31:48 -0400
Received: by mail-lf1-f42.google.com with SMTP id q13-v6so1047991lfc.2
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 11:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zMmEKOGiuBhRKGHIzVl/N99YTFcyRmNpJUlGnSRXVUI=;
        b=aXHteqoxNbNCILx2JgU9RkVlOH+NUIyqGnAQnulKdMdfELnHvSVe46TLdzUcpXKU88
         t3b6dryMc4K/NjG1TslZIEUB5dEl7KRPQFXeZpKRj6MQi0Yi+Vmzv9zbGdIv+cS/coSL
         VkB0LzmIC4cqpVn8HqoYHhXIB5G2SC1UI2RaPn0A5G0qfp/5m6cE0mXizH6Bw8BCEeQy
         4QzA/5fi82gisBtVt78uHBz1oIL8VEkHp79bngg/0Sa8gMPSFxWapWqDu0c0yByUBbhR
         yeuyWedBjpR56F1lHo9fgWSDcnoSW7jRdgtG1a3C2N297L/jp9271z1HWiFJrKboupx3
         SsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zMmEKOGiuBhRKGHIzVl/N99YTFcyRmNpJUlGnSRXVUI=;
        b=poJ481ALboyJ2k/hBr0y8HODh46fU6coZADZUPj0UwbbCim+h0cFAM+gqilcxcy82c
         Haf6lqN9sq+RdU1EDgG66j/tvygViJzxC6A2TTzSJ1PmJWPgJlFnJqRL6HZY9oRV9g4l
         LTJbyeP7jLvkDXGZpoVD7GZ5m9x09FejBY9ycJoPzpq1y6fK1aZHhsynhPIVQr/u58HL
         Eby7j5t055JpyDQr/p3EYwULLVB5qytGzkKTjtW5N5XalRXrg6W4xoIDqGxNgMtc5QG7
         TkqLpZzV+E8OItH0BjrGUNj6rsgFlbUO9smU7j2BvXo6HD3BQW6XU1OG605bSYUVMfqg
         aP7Q==
X-Gm-Message-State: APzg51CHSvHA2IXwo05RE1RezQ33cUBhP9C1te52jqdYWQDrwqnNImFj
        QjjDvZ+Ix3Oh4xbdXTfhv7A=
X-Google-Smtp-Source: ANB0VdawNlQTkST1jviieQstusVf3XeXzURxDvCZwNSipr0eANcn/aHHsM22m9sx53EEM5BC2K1pbA==
X-Received: by 2002:a19:e307:: with SMTP id a7-v6mr18002434lfh.125.1535998227323;
        Mon, 03 Sep 2018 11:10:27 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x20-v6sm3706062lfi.8.2018.09.03.11.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:10:26 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 14/24] patch-ids.c: remove implicit dependency on the_index
Date:   Mon,  3 Sep 2018 20:09:22 +0200
Message-Id: <20180903180932.32260-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180903180932.32260-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
 <20180903180932.32260-1-pclouds@gmail.com>
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

