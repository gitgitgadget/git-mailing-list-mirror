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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1A6C4320A
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 429D860724
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhHJS33 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbhHJS3U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 14:29:20 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5A5C06179A
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 11:28:57 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 61-20020a17090a09c3b029017897f47801so2981238pjo.8
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 11:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cHd0Ukyo+rz3HUNqXuM0nD0K08OXY+RDavbMnHgg9i4=;
        b=ToD+GMvgoeqGmPZFSBbqpENBK1CvOcAZqGZHOgPlM/FA88gmy0FzqgiArNIg336oEy
         i/OMXOwi39jfk0A+DcGUhxx0fqYYfEOi4pEJm3i5NlLNAj4hji4E8MG0xDFSsVcKoiW5
         SLD4d+xNoQsfUc2w5z3dUtDt/6eF0NbhkjwH1J2IUwxUbMwXq+z7ycTk+/K240P/YhgD
         Buq8eUvXcMtxWikwVvcGuNUCcGNWMRhkdYmHDQvRlJZyAqdpWmP/GlB2l0zzlAkuyhZ5
         XJ9cbvEZ2WZGH4wUoA35a+Ow7A5VzQCSXDQRvdhkRlhhZneVqotn2V2sHj1aa9R83XWo
         eZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cHd0Ukyo+rz3HUNqXuM0nD0K08OXY+RDavbMnHgg9i4=;
        b=ZirnJnrExZdJSXmdwDPyT1zXPMF1PAuLWUXCF57Md5n1uU2XtoA9pe2fQgkwPnx7uA
         S7cLMdVf3fk01g5jhFZ9Tw+HhIntKWftznEmh0twecc/WX2uyZHV2CTy+S9c/D+8wT04
         sMNbJPn4GWvpjGus1LvMP0GYNVoJxry0PM7RNS45qmKRlIxdWT7nPq8jFTFNtfpYa1DZ
         QBwdK2fT5jSRFLlvPsOrgu3nph8V29U3c32fIPszqiIhsIov/5IMJiu06YEb7nRXWUhG
         GEhM8Z1YhTQPl2EMbJz3HoS9QHeGrJcEzh8sY9/jJypktuZjf2yMTPhvaHn3U+ezzmzg
         JJIw==
X-Gm-Message-State: AOAM530gaCTx2lGnCuv2C2iOE46yS4WP/OFgyUJtlqbsibcnhVkW6Rzb
        KRKofOeTfbF8U1I0wqoGw8yihovcivGCGk+DLBjxUjrcFHAzoaARDzUYbDoilxbEixYSMz5sQIh
        vKshDpANgRJEaYg0FAUzZSqQ1H3eqS2nRljp0A2wtuFf/gBBsdc9PW+sBYiC3PRqqX30S93T81H
        b/
X-Google-Smtp-Source: ABdhPJzPoBKu0G/qlNsk1N0zg3DV1Yxt/uHV/t4F3Se7r+Ydlu+Y9PW6PiPBEw1rIpnna/rFg5Cv8E0y7ljMKIBRWqUc
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:88c8:0:b029:3a3:94e9:8ab0 with
 SMTP id l191-20020a6288c80000b02903a394e98ab0mr30814683pfd.2.1628620136441;
 Tue, 10 Aug 2021 11:28:56 -0700 (PDT)
Date:   Tue, 10 Aug 2021 11:28:41 -0700
In-Reply-To: <cover.1628618950.git.jonathantanmy@google.com>
Message-Id: <e5e6a0dc1ef59b2ab419816e463814d93115e7f6.1628618950.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH 3/7] grep: typesafe versions of grep_source_init
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
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
 grep.c         | 43 +++++++++++++++++++++++++++----------------
 grep.h         |  8 +++++---
 3 files changed, 34 insertions(+), 21 deletions(-)

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
index 424a39591b..ba3711dc56 100644
--- a/grep.c
+++ b/grep.c
@@ -1830,7 +1830,7 @@ int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size)
 	struct grep_source gs;
 	int r;
 
-	grep_source_init(&gs, GREP_SOURCE_BUF, NULL, NULL, NULL);
+	grep_source_init_buf(&gs);
 	gs.buf = buf;
 	gs.size = size;
 
@@ -1840,28 +1840,39 @@ int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size)
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
+}
+
+void grep_source_init_buf(struct grep_source *gs)
+{
+	gs->type = GREP_SOURCE_BUF;
+	gs->name = NULL;
+	gs->path = NULL;
+	gs->buf = NULL;
+	gs->size = 0;
+	gs->driver = NULL;
+	gs->identifier = NULL;
 }
 
 void grep_source_clear(struct grep_source *gs)
diff --git a/grep.h b/grep.h
index 72f82b1e30..f4a3090f1c 100644
--- a/grep.h
+++ b/grep.h
@@ -195,9 +195,11 @@ struct grep_source {
 	struct userdiff_driver *driver;
 };
 
-void grep_source_init(struct grep_source *gs, enum grep_source_type type,
-		      const char *name, const char *path,
-		      const void *identifier);
+void grep_source_init_file(struct grep_source *gs, const char *name,
+			   const char *path);
+void grep_source_init_oid(struct grep_source *gs, const char *name,
+			  const char *path, const struct object_id *oid);
+void grep_source_init_buf(struct grep_source *gs);
 void grep_source_clear_data(struct grep_source *gs);
 void grep_source_clear(struct grep_source *gs);
 void grep_source_load_driver(struct grep_source *gs,
-- 
2.33.0.rc1.237.g0d66db33f3-goog

