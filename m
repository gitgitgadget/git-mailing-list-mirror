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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B86C4320A
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDDD66056C
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbhHJS3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbhHJS3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 14:29:24 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAE6C0613C1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 11:29:02 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id x22-20020ac873160000b0290296247136b4so1089877qto.0
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7kT9KT3PWid+LlsUUoSA6Eluvw4gok6mOYY25WMN1lo=;
        b=p93keTeqX1Q7TbLo+cCJ2fjm1dPCyVcKz7PRI0rl7oYLdCUNsr8umvxX954z72C6K2
         eS1kB6+IqAsPuhnMhAS0kKRh297rphLaSmvyoc/NpDJL7gLnEIfyq6njbwnxZdFp86yb
         UJAG+uowO4qokl/TOxNcn2d3JjY7Po2r2+YK3A/toBoneY/HnEbYRbkBVtb1RFZLln3X
         g3GV2sJC6SEvv9rcaOJ5h9YgbSdgvO/jnW+5TFuwc8WCf7zZ+u2Yc4GPH2jPeOaykAYZ
         j1fw+wWWeCdfWoCw1oQkL7M8Nwy5XMUScxcdz/ecbtAJQVBlkroy3WCVUT7sfvR9F59a
         Lryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7kT9KT3PWid+LlsUUoSA6Eluvw4gok6mOYY25WMN1lo=;
        b=Zkq7yW5zc8m9pHrzBa/CTpkki9nvHiUxlOX+BtOsei27KyWpXjMRhgtGE3uY1pa9BP
         u5mtQZQMv3ZJ6ErUmmdarhwViOjgpcT+5tjW14DzfLNKad1YmNLwrNQ3ZCAq5bJSx9l3
         IugGmukyYdypFEkd+hCnAKEE/parRJQzBVIK42eKM5P3vCKlwFN4/9W0zcvTjG4JjmSW
         /GUZ4VHGntvdRsWPLnHyKqY0QpM2cwBNY7TgXpkXxgb5ECAQdgJFg1zrdGLn8lDChHxy
         j6o2dlrIQ8oce34Y66Zoq6JoLypLwL6OXgifvP1V8OrdQGWA0+30F/88msHb3GwhEbgm
         232Q==
X-Gm-Message-State: AOAM5312tPb8I6r9SIWjD1VpWaPfXX96YJPyqB9K76bWUxY+heSnsAQx
        +redTEutWg4MyvEhlVAAlzcomSHUicW/TozX45ttYHUjkSTFg+xJhYKbmYHbQwLA9VzBCCllb6/
        TUzUIBh4VO4vtG9h6nzK9hUWy1TAznuu8jlo0MNETJD1PyBkCP3K/HRyFrBY2ZIkw0R4Fe6u7xn
        H4
X-Google-Smtp-Source: ABdhPJy7KVKyOVJldLwbxD2jWzXnovUPH7xvAkWMm7p1NH/4xJKWvhTb8/BOWRyAvkt7IYOFSXZyXjzVHag/AFTfCbHB
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:e62:: with SMTP id
 jz2mr30428202qvb.54.1628620141368; Tue, 10 Aug 2021 11:29:01 -0700 (PDT)
Date:   Tue, 10 Aug 2021 11:28:44 -0700
In-Reply-To: <cover.1628618950.git.jonathantanmy@google.com>
Message-Id: <b2df2455871dc5c94ec804e9c0ce935c19da335f.1628618950.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH 6/7] grep: add repository to OID grep sources
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Record the repository whenever an OID grep source is created, and teach
the worker threads to explicitly provide the repository when accessing
objects.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/grep.c | 2 +-
 grep.c         | 7 +++++--
 grep.h         | 4 +++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 5a40e18e47..ea6df6dca4 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -347,7 +347,7 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 	struct grep_source gs;
 
 	grep_source_name(opt, filename, tree_name_len, &pathbuf);
-	grep_source_init_oid(&gs, pathbuf.buf, path, oid);
+	grep_source_init_oid(&gs, pathbuf.buf, path, oid, opt->repo);
 	strbuf_release(&pathbuf);
 
 	if (num_threads > 1) {
diff --git a/grep.c b/grep.c
index ba3711dc56..14c677b4ae 100644
--- a/grep.c
+++ b/grep.c
@@ -1853,7 +1853,8 @@ void grep_source_init_file(struct grep_source *gs, const char *name,
 }
 
 void grep_source_init_oid(struct grep_source *gs, const char *name,
-			  const char *path, const struct object_id *oid)
+			  const char *path, const struct object_id *oid,
+			  struct repository *repo)
 {
 	gs->type = GREP_SOURCE_OID;
 	gs->name = xstrdup_or_null(name);
@@ -1862,6 +1863,7 @@ void grep_source_init_oid(struct grep_source *gs, const char *name,
 	gs->size = 0;
 	gs->driver = NULL;
 	gs->identifier = oiddup(oid);
+	gs->repo = repo;
 }
 
 void grep_source_init_buf(struct grep_source *gs)
@@ -1901,7 +1903,8 @@ static int grep_source_load_oid(struct grep_source *gs)
 {
 	enum object_type type;
 
-	gs->buf = read_object_file(gs->identifier, &type, &gs->size);
+	gs->buf = repo_read_object_file(gs->repo, gs->identifier, &type,
+					&gs->size);
 	if (!gs->buf)
 		return error(_("'%s': unable to read %s"),
 			     gs->name,
diff --git a/grep.h b/grep.h
index f4a3090f1c..c5234f9b38 100644
--- a/grep.h
+++ b/grep.h
@@ -187,6 +187,7 @@ struct grep_source {
 		GREP_SOURCE_BUF,
 	} type;
 	void *identifier;
+	struct repository *repo; /* if GREP_SOURCE_OID */
 
 	char *buf;
 	unsigned long size;
@@ -198,7 +199,8 @@ struct grep_source {
 void grep_source_init_file(struct grep_source *gs, const char *name,
 			   const char *path);
 void grep_source_init_oid(struct grep_source *gs, const char *name,
-			  const char *path, const struct object_id *oid);
+			  const char *path, const struct object_id *oid,
+			  struct repository *repo);
 void grep_source_init_buf(struct grep_source *gs);
 void grep_source_clear_data(struct grep_source *gs);
 void grep_source_clear(struct grep_source *gs);
-- 
2.33.0.rc1.237.g0d66db33f3-goog

