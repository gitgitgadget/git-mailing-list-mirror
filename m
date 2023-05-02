Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6B7C77B75
	for <git@archiver.kernel.org>; Tue,  2 May 2023 21:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjEBVPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 17:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjEBVPS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 17:15:18 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618161734
        for <git@vger.kernel.org>; Tue,  2 May 2023 14:15:11 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-51b8837479fso4039695a12.3
        for <git@vger.kernel.org>; Tue, 02 May 2023 14:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683062111; x=1685654111;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sqTg0GYKKz7bBZ07Q0VVOcFWV0uH9Yk7doQ0avuK6Rw=;
        b=fJyPhTyb++wMm9s76Y0W0LfO5nbgRaJQa/xtgSQIuoxgXZuYFv+QCFCNf2Yvjr7zA+
         rBzucuoEUMU3P9Nbg+pgN+1gQh7LVD0e0lzB15cz+g9L85vDo3ETTO+XhJxTL7d/i4fF
         R1l6f9L0tWWT/pe3/nYeHcAhcBXG0Y/xcvxPd6yYnJngsK5Nc5flwC/Asco51pmwNPwK
         oyw6QjturuGa7T9Oqp9K62++nILcle6swgHnpvpWscsdODYO/OsktIopRyFZWOeqqOkx
         Ad9aaPjsaT0JyagMac5CHCjfID97VB0eOKJTAc87i5u2M4fX/Omfoib1dDlCe0GJTnoJ
         e54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683062111; x=1685654111;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sqTg0GYKKz7bBZ07Q0VVOcFWV0uH9Yk7doQ0avuK6Rw=;
        b=UvSrg4Qb59aCTpNyf7JFICf5tVTHD3Jw78/pfrC9t57axnhSIjBWgY0QImp+IuopEz
         MDUY4InxzE57Q0vTg/oWhJzzLmLV1iiOa6PzXvf6hYrqciEjEVq3+bN+JpXJ7fz4j5A6
         BXd8+buxGA3541CixaywTW0qcPzwFUPlzuUAcAmhhqmP463hLT8TrdN2Comvu+iFiHVD
         Xp9b4MYWnB3YSwaK/7gkq6K58h4MTxiPGM2ZG+lxLxx6Xik3t556nUdMO1r3EPmyR+J4
         8/WIH8yDcD6Qx9GIiSKvfyggYYDvEFEywkPa6oULL+D+DmJmkDWckCgj2+GSYN6IpMJG
         GuDA==
X-Gm-Message-State: AC+VfDxjpXcfC4FSA6iwOcAAUZJubNhWWysU6R2s/Pf871Vtl99GYgII
        Yo03K6CjFExmSf2LEV+DsHZbBY5a9qO8Yb5EdGrzUA7NzYYKK6KcllfkbMPZt02XoGLF6ovwobd
        WJqjxEjR+AmDQDryrUtmsItJhOb4weSEL8ALzicgwsx4vvNW0E9ZxWcGYgtJpBakGuw==
X-Google-Smtp-Source: ACHHUZ6+Td6Eo2S7fRlDJy7yoTjuZZOcXSkV+MoYfzTY9OnGAeSfKh+bOsJKRPzHoXeHyiVHzfiY8ExwoAdYgB0=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:8148:0:b0:51b:fa5:7bce with SMTP id
 t69-20020a638148000000b0051b0fa57bcemr4667057pgd.1.1683062110666; Tue, 02 May
 2023 14:15:10 -0700 (PDT)
Date:   Tue,  2 May 2023 21:14:51 +0000
In-Reply-To: <20230502211454.1673000-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230502211454.1673000-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502211454.1673000-4-calvinwan@google.com>
Subject: [PATCH 3/6] object-name: move related functions to object-name
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move object-name-related functions from strbuf.[ch] to object-name.[ch]
since they do not belong in a low-level library.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 object-name.c | 15 +++++++++++++++
 object-name.h |  9 +++++++++
 pretty.c      |  1 +
 strbuf.c      | 16 ----------------
 strbuf.h      | 10 ----------
 5 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/object-name.c b/object-name.c
index 538e8a8f62..c2e82aceea 100644
--- a/object-name.c
+++ b/object-name.c
@@ -766,6 +766,21 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 		find_abbrev_len_for_pack(p, mad);
 }
 
+void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
+				   const struct object_id *oid, int abbrev_len)
+{
+	int r;
+	strbuf_grow(sb, GIT_MAX_HEXSZ + 1);
+	r = repo_find_unique_abbrev_r(repo, sb->buf + sb->len, oid, abbrev_len);
+	strbuf_setlen(sb, sb->len + r);
+}
+
+void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
+			      int abbrev_len)
+{
+	strbuf_repo_add_unique_abbrev(sb, the_repository, oid, abbrev_len);
+}
+
 int repo_find_unique_abbrev_r(struct repository *r, char *hex,
 			      const struct object_id *oid, int len)
 {
diff --git a/object-name.h b/object-name.h
index 1d63698f42..9ae5223071 100644
--- a/object-name.h
+++ b/object-name.h
@@ -40,6 +40,15 @@ struct object_context {
 const char *repo_find_unique_abbrev(struct repository *r, const struct object_id *oid, int len);
 int repo_find_unique_abbrev_r(struct repository *r, char *hex, const struct object_id *oid, int len);
 
+/**
+ * Add the abbreviation, as generated by repo_find_unique_abbrev(), of `sha1` to
+ * the strbuf `sb`.
+ */
+void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
+				   const struct object_id *oid, int abbrev_len);
+void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
+			      int abbrev_len);
+
 int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
 __attribute__((format (printf, 2, 3)))
 int get_oidf(struct object_id *oid, const char *fmt, ...);
diff --git a/pretty.c b/pretty.c
index 0bb938021b..78bac2d818 100644
--- a/pretty.c
+++ b/pretty.c
@@ -18,6 +18,7 @@
 #include "gpg-interface.h"
 #include "trailer.h"
 #include "run-command.h"
+#include "object-name.h"
 
 /*
  * The limit for formatting directives, which enable the caller to append
diff --git a/strbuf.c b/strbuf.c
index da2693b21f..6533559e95 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -3,7 +3,6 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-name.h"
 #include "refs.h"
 #include "string-list.h"
 #include "utf8.h"
@@ -1023,21 +1022,6 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
 	strbuf_setlen(sb, sb->len + len);
 }
 
-void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
-				   const struct object_id *oid, int abbrev_len)
-{
-	int r;
-	strbuf_grow(sb, GIT_MAX_HEXSZ + 1);
-	r = repo_find_unique_abbrev_r(repo, sb->buf + sb->len, oid, abbrev_len);
-	strbuf_setlen(sb, sb->len + r);
-}
-
-void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
-			      int abbrev_len)
-{
-	strbuf_repo_add_unique_abbrev(sb, the_repository, oid, abbrev_len);
-}
-
 /*
  * Returns the length of a line, without trailing spaces.
  *
diff --git a/strbuf.h b/strbuf.h
index 1a4c07a053..b6d53c1cbe 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -608,16 +608,6 @@ void strbuf_add_separated_string_list(struct strbuf *str,
  */
 void strbuf_list_free(struct strbuf **list);
 
-/**
- * Add the abbreviation, as generated by repo_find_unique_abbrev(), of `sha1` to
- * the strbuf `sb`.
- */
-struct repository;
-void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
-				   const struct object_id *oid, int abbrev_len);
-void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
-			      int abbrev_len);
-
 /*
  * Remove the filename from the provided path string. If the path
  * contains a trailing separator, then the path is considered a directory
-- 
2.40.1.495.gc816e09b53d-goog

