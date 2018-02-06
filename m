Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7D1E1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeBFAZU (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:25:20 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44118 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752416AbeBFAZP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:25:15 -0500
Received: by mail-pg0-f68.google.com with SMTP id r1so161050pgn.11
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i6882gUmQacnlrzPytE10bALT5qyROV0GXw+zpjc8ow=;
        b=b0KNcZNL0Uv42tAAteeulbv9s/uBmXdor/IFAxk0MZZPhNe+Od/wFrps8VfbL0GCo/
         RXFrQzwf0ymu34OmU0Ak3YZKFwP2+pJOsi8MMORA4kZLyGCl11//YK6q6+z2Ylf/jZpw
         +MRB7VMDTxTNfJcIjwhYONBGP+U8tNpP+WpyQeUHLecAF42PP3u+l5woC4uxH+yJOIBn
         WB3MEdNLcORxQ2pTeVjIJCFslybxqm//mlt0DAY4du13G8f41bZOCrl5SerhlRDDm8Rn
         M0S3mya56n8g2gugBcgHyI831vxJjNHW0ftCI0/hdjfL3B/cN61cDX8O8uJK4FPRD8xd
         PuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i6882gUmQacnlrzPytE10bALT5qyROV0GXw+zpjc8ow=;
        b=VlZHEwL6pw1c7oPfF097r7m5dGdwUFsdZrSSs3DJs9HXnucPY13mlUfMriDF9Zus10
         RAtLrGgakFHcjcE0x1sv+vh5N+TCcCeVOpzvL5xc4zdPIV3R3NToZn84YmHWrGrxCv4D
         1AS5eFba+NQOppyoQaoANQhYhyMnnM7X1+GSqUuAj3iocvqP//abrc1VINxLlUxQY2LI
         oxk32YwGKoOGmCt2sx75TifCn9LDfS+vGwXDY6D7l7QFXVZyPq5sWnrGCpKotqCTKg7y
         wgvKVw3Ts3zhwL7boj9sksZMti887+TyQCZsbWOn4ggWwT9A/boHBUW/AKMsfhhftsBG
         j5Xg==
X-Gm-Message-State: APf1xPCqAaLrDrAzTZglaBdJ4VWBmPWWlIvWAYCQbhgrkWM4jcFZMnR3
        UGDdsXtzGV30qEeZLgVGlTN/8lWVYCg=
X-Google-Smtp-Source: AH8x2252+y4/aljp7JJxmvwIEgMycRIysKGOX9dYhROz/RdyN04lY5T6PglaQ5qsnn66iuE0yDqFGw==
X-Received: by 10.98.33.199 with SMTP id o68mr566626pfj.78.1517876714598;
        Mon, 05 Feb 2018 16:25:14 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id r13sm325380pgq.25.2018.02.05.16.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:25:14 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 146/194] commit: add repository argument to get_cached_commit_buffer
Date:   Mon,  5 Feb 2018 16:17:01 -0800
Message-Id: <20180206001749.218943-48-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of get_cached_commit_buffer to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/rev-list.c | 2 +-
 commit.c           | 4 ++--
 commit.h           | 3 ++-
 log-tree.c         | 2 +-
 object.c           | 2 +-
 pretty.c           | 2 +-
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 3c2ae454ea..e28e7426a5 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -133,7 +133,7 @@ static void show_commit(struct commit *commit, void *data)
 	else
 		putchar('\n');
 
-	if (revs->verbose_header && get_cached_commit_buffer(commit, NULL)) {
+	if (revs->verbose_header && get_cached_commit_buffer(the_repository, commit, NULL)) {
 		struct strbuf buf = STRBUF_INIT;
 		struct pretty_print_context ctx = {0};
 		ctx.abbrev = revs->abbrev;
diff --git a/commit.c b/commit.c
index 5de78c73fd..1863900824 100644
--- a/commit.c
+++ b/commit.c
@@ -257,7 +257,7 @@ void set_commit_buffer_the_repository(struct commit *commit, void *buffer, unsig
 	v->size = size;
 }
 
-const void *get_cached_commit_buffer(const struct commit *commit, unsigned long *sizep)
+const void *get_cached_commit_buffer_the_repository(const struct commit *commit, unsigned long *sizep)
 {
 	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
 	if (!v) {
@@ -272,7 +272,7 @@ const void *get_cached_commit_buffer(const struct commit *commit, unsigned long
 
 const void *get_commit_buffer(const struct commit *commit, unsigned long *sizep)
 {
-	const void *ret = get_cached_commit_buffer(commit, sizep);
+	const void *ret = get_cached_commit_buffer(the_repository, commit, sizep);
 	if (!ret) {
 		enum object_type type;
 		unsigned long size;
diff --git a/commit.h b/commit.h
index d3ec52d1c1..bcecb23722 100644
--- a/commit.h
+++ b/commit.h
@@ -86,7 +86,8 @@ void set_commit_buffer_the_repository(struct commit *, void *buffer, unsigned lo
  * Get any cached object buffer associated with the commit. Returns NULL
  * if none. The resulting memory should not be freed.
  */
-const void *get_cached_commit_buffer(const struct commit *, unsigned long *size);
+#define get_cached_commit_buffer(r, c, s) get_cached_commit_buffer_##r(c, s)
+const void *get_cached_commit_buffer_the_repository(const struct commit *, unsigned long *size);
 
 /*
  * Get the commit's object contents, either from cache or by reading the object
diff --git a/log-tree.c b/log-tree.c
index 9fb333605b..c6d2883190 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -661,7 +661,7 @@ void show_log(struct rev_info *opt)
 		show_mergetag(opt, commit);
 	}
 
-	if (!get_cached_commit_buffer(commit, NULL))
+	if (!get_cached_commit_buffer(the_repository, commit, NULL))
 		return;
 
 	if (opt->show_notes) {
diff --git a/object.c b/object.c
index 7d848b5b7a..c2268990dd 100644
--- a/object.c
+++ b/object.c
@@ -214,7 +214,7 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
 		if (commit) {
 			if (parse_commit_buffer(the_repository, commit, buffer, size))
 				return NULL;
-			if (!get_cached_commit_buffer(commit, NULL)) {
+			if (!get_cached_commit_buffer(the_repository, commit, NULL)) {
 				set_commit_buffer(the_repository, commit, buffer, size);
 				*eaten_p = 1;
 			}
diff --git a/pretty.c b/pretty.c
index 478af1a860..f82d30cd97 100644
--- a/pretty.c
+++ b/pretty.c
@@ -630,7 +630,7 @@ const char *logmsg_reencode(const struct commit *commit,
 		 * the cached copy from get_commit_buffer, we need to duplicate it
 		 * to avoid munging the cached copy.
 		 */
-		if (msg == get_cached_commit_buffer(commit, NULL))
+		if (msg == get_cached_commit_buffer(the_repository, commit, NULL))
 			out = xstrdup(msg);
 		else
 			out = (char *)msg;
-- 
2.15.1.433.g936d1b9894.dirty

