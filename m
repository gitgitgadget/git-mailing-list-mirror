Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 924251F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbeBFAZq (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:25:46 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43284 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbeBFAZm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:25:42 -0500
Received: by mail-pl0-f67.google.com with SMTP id f4so123095plr.10
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pgA7dGf7DctlYAAHaf6MfbnhCrRjfww0hNyLanGvGnE=;
        b=SW29oNZFLhzxQQ9Y5WMStIURSKQj3qOHHDrcPgtpXSsOsozd0yCTbRSsAQM+xKaH3U
         Czgevqo9u3WWCti0Ur2wonbbohvg08+Z5riSetwR4eokwIspL7nvUsnNSC4UzK/b6bdS
         Se39K2+koQQMltwS7/3FCeNiKUNJTkt/6ucrFWVQEMsmZ3nyHeTVcRjlPIn4N/9xtI1I
         dbzlw61tvrQUvoE86GQxfF1gXVX2C1Q4UvNMp1zIaSpxXe+Iaswp9JWiQG7T/5GVbC72
         RlnVxYpEsHSH2yDbiCxf1dfxNkKuNMzHfHTRk9k+vGnob+nX/k37F8mAfsnMxqwrmcEl
         1iRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pgA7dGf7DctlYAAHaf6MfbnhCrRjfww0hNyLanGvGnE=;
        b=QcdR/uIY7LclvNf+Ve4T2EuSm3Z9NKoWneAuu5GB4rf/I9A2BbKpB8vbh1tpMpCd1E
         jjGGLim+eWBUnxEoOKGjDAA2ySoYNrAKML1InVcNYiHGGnOIi5N465hyUkBHjowaTfDc
         t7A/18ZkIZzr03gTQnehpgDQ/uNN3jo+jI3r5UWYPeFwLHP/ls6AXxDraO2IM6A9Yo+N
         PMIV6SQh6qc3l8M+Lc+uIOOt+CHsNGaKVerDo+crNfMN4H/SxCj4BXmNSBPd/OOu1W1B
         9YcxcjUcCxWbX1YhnOVOROc869zRlK/9NpivzU1HWTRawc7QI0J4MCqO1Qk/SAH7b107
         v7RA==
X-Gm-Message-State: APf1xPBXhx8LUKjI+zKD1pyLLRQ36tEaJGOpmWnbXEFEvKWXpg0BO/o7
        ulaQhyCJoNYsPhtSXiAOgyfglGrHPDs=
X-Google-Smtp-Source: AH8x227hxUA4bBU38yQsi44bbrdnWR2wNHd4vR6kHJLnag13t/scJbqQxoLFul1vdO02TifLfoZtCA==
X-Received: by 2002:a17:902:183:: with SMTP id b3-v6mr542427plb.383.1517876741967;
        Mon, 05 Feb 2018 16:25:41 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id j12sm306927pfa.95.2018.02.05.16.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:25:41 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 148/194] commit: add repository argument to free_commit_buffer
Date:   Mon,  5 Feb 2018 16:17:03 -0800
Message-Id: <20180206001749.218943-50-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of free_commit_buffer to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fsck.c     | 2 +-
 builtin/log.c      | 4 ++--
 builtin/rev-list.c | 2 +-
 commit.c           | 2 +-
 commit.h           | 3 ++-
 5 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 2e8b298384..01c612f75f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -365,7 +365,7 @@ static int fsck_obj(struct object *obj)
 	if (obj->type == OBJ_TREE)
 		free_tree_buffer((struct tree *)obj);
 	if (obj->type == OBJ_COMMIT)
-		free_commit_buffer((struct commit *)obj);
+		free_commit_buffer(the_repository, (struct commit *)obj);
 	return err;
 }
 
diff --git a/builtin/log.c b/builtin/log.c
index 7080c5f776..12426e685f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -386,7 +386,7 @@ static int cmd_log_walk(struct rev_info *rev)
 			 * We may show a given commit multiple times when
 			 * walking the reflogs.
 			 */
-			free_commit_buffer(commit);
+			free_commit_buffer(the_repository, commit);
 			free_commit_list(commit->parents);
 			commit->parents = NULL;
 		}
@@ -1813,7 +1813,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		    open_next_file(rev.numbered_files ? NULL : commit, NULL, &rev, quiet))
 			die(_("Failed to create output files"));
 		shown = log_tree_commit(&rev, commit);
-		free_commit_buffer(commit);
+		free_commit_buffer(the_repository, commit);
 
 		/* We put one extra blank line between formatted
 		 * patches and this flag is used by log-tree code
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index e28e7426a5..142ba35fdb 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -193,7 +193,7 @@ static void finish_commit(struct commit *commit, void *data)
 		free_commit_list(commit->parents);
 		commit->parents = NULL;
 	}
-	free_commit_buffer(commit);
+	free_commit_buffer(the_repository, commit);
 }
 
 static inline void finish_object__ma(struct object *obj)
diff --git a/commit.c b/commit.c
index fa578a2d22..8ef8619dec 100644
--- a/commit.c
+++ b/commit.c
@@ -297,7 +297,7 @@ void unuse_commit_buffer_the_repository(const struct commit *commit, const void
 		free((void *)buffer);
 }
 
-void free_commit_buffer(struct commit *commit)
+void free_commit_buffer_the_repository(struct commit *commit)
 {
 	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
 	if (v) {
diff --git a/commit.h b/commit.h
index 85dd52d1bf..8892989b1d 100644
--- a/commit.h
+++ b/commit.h
@@ -108,7 +108,8 @@ void unuse_commit_buffer_the_repository(const struct commit *, const void *buffe
 /*
  * Free any cached object buffer associated with the commit.
  */
-void free_commit_buffer(struct commit *);
+#define free_commit_buffer(r, c) free_commit_buffer_##r(c)
+void free_commit_buffer_the_repository(struct commit *);
 
 /*
  * Disassociate any cached object buffer from the commit, but do not free it.
-- 
2.15.1.433.g936d1b9894.dirty

