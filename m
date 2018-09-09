Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D68E31F404
	for <e@80x24.org>; Sun,  9 Sep 2018 08:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbeIINns (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 09:43:48 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:39137 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeIINnq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 09:43:46 -0400
Received: by mail-lj1-f171.google.com with SMTP id l15-v6so15396391lji.6
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 01:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WuXvr6xx9Si4ZiiYy9ZVNeAkt4RIYRb60lpT8GyijUg=;
        b=LXur6hfB42YNctbM4Ya0h3/gJGLZweEPfssUsaccHhWk4w3lmjQbuHbHV8FTW/4h+S
         +2lCKhES+IrlZs7upuFs1N75hK3JU4JEmIjlJ+mDAJOwQovQKAQqso9ktXynNsL0DcU3
         K1LeHNnFkYV+s649TLIHmB5mFv0OtGVmcpPfZUTogqN0JAoPDvs99R1Ku9uC5ytcXe9I
         o7lBJkbyVIyEJObgbrsuH4kCh7W3WsnnoPZoZZDGeL4P4BHx67mULgKMcnaNpC3vHk8f
         29W4Aa6lXYQShTJolroZKZShFhDyVe2gRNQcLyuMrJDI90rXr5UH+9GWhaDruVavOHjm
         Uycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WuXvr6xx9Si4ZiiYy9ZVNeAkt4RIYRb60lpT8GyijUg=;
        b=SGyufbAIqFjj35Wts3t0H+W9iu4o0HmbgoxB3aNHb1J7H160ZomBVlNWXPc+cah1Z8
         gvKmaW6yzig66TAvdMW2E5EjlYLLlHlD31dHiPCm5Ky//5CrjDZuEOsxRS14kwBnpPcf
         47Zos4Eq0gjq/tgMjp++rfvWqztkXzx/NdeyzlFCDJu1JhNk4aa4T5H13V4UAroxECXT
         8XN1SwqDCncf722k3GBTvNZw+4eqRRCB6X4FE58pJ+Xe40rAXSMBtvIVRASXF92cN533
         PYv6ZxpiWpKqpWdCDNX2MXog2fwqIL/BLPQZg44SQZ2kGH8smrDhDuwTf2a1xj/ndKXy
         W51g==
X-Gm-Message-State: APzg51AqkBvMbemC/deoybFP0z1/iIKForo6umE59rfwOKManAGHaNQn
        nJed6J4l76DsJd5mtpE95pw=
X-Google-Smtp-Source: ANB0VdYP3RwMNioCyV4ohkg0IfHD5iaDnmbSyCnKwqGhz4XhH/WnrqwUYPvFofd4L2hvULmhlRg78A==
X-Received: by 2002:a2e:59d1:: with SMTP id g78-v6mr9714202ljf.79.1536483287250;
        Sun, 09 Sep 2018 01:54:47 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g16-v6sm2102525lfb.5.2018.09.09.01.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 01:54:46 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 14/23] patch-ids.c: remove implicit dependency on the_index
Date:   Sun,  9 Sep 2018 10:54:09 +0200
Message-Id: <20180909085418.31531-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180909085418.31531-1-pclouds@gmail.com>
References: <20180903180932.32260-1-pclouds@gmail.com>
 <20180909085418.31531-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.19.0.rc0.337.ge906d732e7

