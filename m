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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34144C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 21:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06ACC60FC3
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 21:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbhHMVGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 17:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbhHMVF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 17:05:59 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B850BC0617AF
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 14:05:32 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k3-20020a170902c403b029012d1b645e45so6865657plk.4
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 14:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gcuBlYHDN5+v6e09KvbwSDMhCeBJ0Ai0Ad7+1TXjHdo=;
        b=j5HTD/TPIVTJtco7nEGAQLJroTPpEtO6rYhJwuV/873MQUBcLHpVl24NMZKI1C67UF
         FYBGKUitRLoWknNtN8+cPdaXDpaJFOLK6+6wOlLehxITTuQtGEyOvBFcZqPo85SeXGBe
         bQXC1Kb4Gsi5fr8eAcleDk8m5tUeBap8JDqWNeMBOwDo/0ZgSVn7Admnk1Rx88d38Aif
         5bqbtlmgs8jcD0WkXv3BzqgRPR15WafsttbQVxgcL+Z27E0tb6hwCB/sWC0ZAgXMtgX5
         CPyvuaek6Y6jKhf/W7aGU7fTFapLGpYAy3PckxXAEtF6vsZ2s1VmBitt5ki1NHV8z3zB
         k7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gcuBlYHDN5+v6e09KvbwSDMhCeBJ0Ai0Ad7+1TXjHdo=;
        b=DEOhEeWrf+Ed9Ip6pJqCsHbuqlEJliDaAhe/bT4jw7smsMcakQlIVXVvdVbvyE0OX5
         vM9TDGmJsJ9KLpfowyrmnhmpMGk4n0XR0oT2gAjhSMBo3BYbMtjVifLhKBuSg+lL5Exh
         594LWr5z1Hga7/sokRDuWGiP0ACmx43xAgkqsDFhX/TT2Oh1pIJPZjD0l0sSFt1vbwBN
         3F7rsaLfXkjtLYg1i7zqGCTchHQzObC35SvErUYNJK3Sblsdn/JeLZ4STW6qmN8AOfiJ
         +RPz+j6reLYLQa4yz7xLvUaEREuiH1AxPAwtyUxFMvExO1gqnn4xUz1FCquyzO+AZ+A/
         EQ4w==
X-Gm-Message-State: AOAM533qOtr80qklkVbqdY/ObeY/E3gMzg3jAeIdi0NSnBEV6NY3jTU1
        BVU8t989LzqBkVe34Wy/AiNkN1jtZxKOcDH1duD3nvAelRaNp89SS9PW2WQEUUMMm2iJjkHNYm8
        BtrcIIwkr1v9DFU11INcSm8VwSYSMvcWGnBBlfrhkExg3sUGtUDIu2kTjA75OOUfVog3O2H269p
        Tg
X-Google-Smtp-Source: ABdhPJwZmw9Cl7ECIz9m0rLjsnFL7/mO/tRM6CBK8QDcvagPskEeqOvTdq7P4D5pKOB1sWC43h6iTMWidq5trUsSq+SJ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:b414:0:b029:317:52d:7fd5 with
 SMTP id h20-20020a62b4140000b0290317052d7fd5mr4325156pfn.30.1628888732158;
 Fri, 13 Aug 2021 14:05:32 -0700 (PDT)
Date:   Fri, 13 Aug 2021 14:05:18 -0700
In-Reply-To: <cover.1628888668.git.jonathantanmy@google.com>
Message-Id: <aa3f1f3c8908bd497ef506db466fc123eaccf21d.1628888668.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com> <cover.1628888668.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v2 3/8] grep: typesafe versions of grep_source_init
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, matheus.bernardino@usp.br,
        emilyshaffer@google.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, steadmon@google.com
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

