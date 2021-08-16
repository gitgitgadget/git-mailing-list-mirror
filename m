Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F8FC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E59CB60F39
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhHPVKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 17:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbhHPVKi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 17:10:38 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E11C0613C1
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 14:10:06 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id y3-20020a17090a8b03b02901787416b139so941103pjn.4
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 14:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gcuBlYHDN5+v6e09KvbwSDMhCeBJ0Ai0Ad7+1TXjHdo=;
        b=wE9sHjYuzLK+A4waI+ttDgMHYwEv5uSdpHOPFDEzMEF25aHGcaBNWIDNEd82tdWG/7
         qCRTSPKQAdWm20WRootptqNM5GStmAV68lKNvGJzDhnn6PnY1MNxu3saFI7MEkr7vwT5
         xwnPDNj0VLzpnMwi+eGWHPTDZoXdEIocBQ79Pbkff804axvVJtHBJGSYxUpXCFCodGQD
         ovQxVZXQRSJ7X/XPZTUPDKSg4YopTMj6UqhQLsIXRoaU/Ov4RxOJ56fnTs4sOi6C4qyC
         ZjZMARTauefWVjOnUb7HxAteNr39/dYxF4Y/7NARACkYkGl6/yKFvIhEGPge84WYjGJ9
         G8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gcuBlYHDN5+v6e09KvbwSDMhCeBJ0Ai0Ad7+1TXjHdo=;
        b=Mwm+SRItk41VBUqFuQ8pw6NXMspd9vccrjhaYBh9HmKZevu7wNHYKifZiMMvx9SMEM
         VLMRI0LgCJiGkZTf6yqorxqxBpdJvNreepiqjcMksN4wq7rIDp0M0TcmhUrGuK+9EvNK
         LdgVp+J59fTETBM72w5P/1xk9UdgjmiNNHb6OdWljRUMVkKv2X9zDo5zDTgG7FeW2mPe
         cDAJDElCPUGeIaeCv2ZaLk3OxWtEWCRPOusR27CwEjZcWvlnjYuC6RiMq7mmLbaNmTYP
         EjtaN2rCqs1LLQigU6/X1sBzDPg8LAegeIL39WWHfLZzAnsTo1jtDTVVGXB5ZqN1FC/F
         9Yaw==
X-Gm-Message-State: AOAM531+6F4fJlEKGOeSl1tPm5SF8O3uUQDo/e28TTWXqa8iL/lfn9b/
        qFipU3wF2bXznpTXa3+X48XOtKNj20gmXSBXbwYkX9ygixApqUPPNcrtefjez6Kejqs0bsyWgGp
        wc6c+aI8B8t+zDLgPMCskC836aYPB9taxdL0LiKSlA2B229OhdEyJR1YGafnN1YKvZsXgXA6IOz
        6Y
X-Google-Smtp-Source: ABdhPJxzWJKk6O/lcC+ml11YlsgMkj1H6jpYRNxxiItA1hfF7LsCQ9oQrhzKgVFfsIvtudiDFyq01I1g+9kDElqEF4AR
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:da8a:b029:12c:4261:a2d6 with
 SMTP id j10-20020a170902da8ab029012c4261a2d6mr147822plx.50.1629148206146;
 Mon, 16 Aug 2021 14:10:06 -0700 (PDT)
Date:   Mon, 16 Aug 2021 14:09:53 -0700
In-Reply-To: <cover.1629148153.git.jonathantanmy@google.com>
Message-Id: <aa3f1f3c8908bd497ef506db466fc123eaccf21d.1629148153.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com> <cover.1629148153.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v3 3/8] grep: typesafe versions of grep_source_init
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, matheus.bernardino@usp.br,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

grep_source_init() can create "struct grep_source" objects and,
depending on the value of the type passed, some void-pointer parameters have
different meanings. Because one of these types (GREP_SOURCE_OID) will
require an additional parameter in a subsequent patch, take the
opportunity to increase clarity and type safety by replacing this
function with individual functions for each type.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/grep.c |  4 ++--
 grep.c         | 46 ++++++++++++++++++++++++++++------------------
 grep.h         |  7 ++++---
 3 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 87bcb934a2..e454335e9d 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -333,7 +333,7 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 	struct grep_source gs;
 
 	grep_source_name(opt, filename, tree_name_len, &pathbuf);
-	grep_source_init(&gs, GREP_SOURCE_OID, pathbuf.buf, path, oid);
+	grep_source_init_oid(&gs, pathbuf.buf, path, oid);
 	strbuf_release(&pathbuf);
 
 	if (num_threads > 1) {
@@ -359,7 +359,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	struct grep_source gs;
 
 	grep_source_name(opt, filename, 0, &buf);
-	grep_source_init(&gs, GREP_SOURCE_FILE, buf.buf, filename, filename);
+	grep_source_init_file(&gs, buf.buf, filename);
 	strbuf_release(&buf);
 
 	if (num_threads > 1) {
diff --git a/grep.c b/grep.c
index 424a39591b..8a8105c2eb 100644
--- a/grep.c
+++ b/grep.c
@@ -1825,14 +1825,24 @@ int grep_source(struct grep_opt *opt, struct grep_source *gs)
 	return grep_source_1(opt, gs, 0);
 }
 
+static void grep_source_init_buf(struct grep_source *gs, char *buf,
+				 unsigned long size)
+{
+	gs->type = GREP_SOURCE_BUF;
+	gs->name = NULL;
+	gs->path = NULL;
+	gs->buf = buf;
+	gs->size = size;
+	gs->driver = NULL;
+	gs->identifier = NULL;
+}
+
 int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size)
 {
 	struct grep_source gs;
 	int r;
 
-	grep_source_init(&gs, GREP_SOURCE_BUF, NULL, NULL, NULL);
-	gs.buf = buf;
-	gs.size = size;
+	grep_source_init_buf(&gs, buf, size);
 
 	r = grep_source(opt, &gs);
 
@@ -1840,28 +1850,28 @@ int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size)
 	return r;
 }
 
-void grep_source_init(struct grep_source *gs, enum grep_source_type type,
-		      const char *name, const char *path,
-		      const void *identifier)
+void grep_source_init_file(struct grep_source *gs, const char *name,
+			   const char *path)
 {
-	gs->type = type;
+	gs->type = GREP_SOURCE_FILE;
 	gs->name = xstrdup_or_null(name);
 	gs->path = xstrdup_or_null(path);
 	gs->buf = NULL;
 	gs->size = 0;
 	gs->driver = NULL;
+	gs->identifier = xstrdup(path);
+}
 
-	switch (type) {
-	case GREP_SOURCE_FILE:
-		gs->identifier = xstrdup(identifier);
-		break;
-	case GREP_SOURCE_OID:
-		gs->identifier = oiddup(identifier);
-		break;
-	case GREP_SOURCE_BUF:
-		gs->identifier = NULL;
-		break;
-	}
+void grep_source_init_oid(struct grep_source *gs, const char *name,
+			  const char *path, const struct object_id *oid)
+{
+	gs->type = GREP_SOURCE_OID;
+	gs->name = xstrdup_or_null(name);
+	gs->path = xstrdup_or_null(path);
+	gs->buf = NULL;
+	gs->size = 0;
+	gs->driver = NULL;
+	gs->identifier = oiddup(oid);
 }
 
 void grep_source_clear(struct grep_source *gs)
diff --git a/grep.h b/grep.h
index 72f82b1e30..480b3f5bba 100644
--- a/grep.h
+++ b/grep.h
@@ -195,9 +195,10 @@ struct grep_source {
 	struct userdiff_driver *driver;
 };
 
-void grep_source_init(struct grep_source *gs, enum grep_source_type type,
-		      const char *name, const char *path,
-		      const void *identifier);
+void grep_source_init_file(struct grep_source *gs, const char *name,
+			   const char *path);
+void grep_source_init_oid(struct grep_source *gs, const char *name,
+			  const char *path, const struct object_id *oid);
 void grep_source_clear_data(struct grep_source *gs);
 void grep_source_clear(struct grep_source *gs);
 void grep_source_load_driver(struct grep_source *gs,
-- 
2.33.0.rc1.237.g0d66db33f3-goog

