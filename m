Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EA5B1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbeKNKOy (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:14:54 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:35603 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731191AbeKNKOx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:14:53 -0500
Received: by mail-it1-f202.google.com with SMTP id e19-v6so12984513itc.0
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=darsJglboYFXdBV0PtDEBbxKvHxm+QT0RA6oYl1qQTo=;
        b=wL45PdnCIzGChZsSPBW1QtS7igfQSAr22w64u8fJGdtFamUNLYpQq96TULnmRLstPT
         3aJVVeVv8ic07WIaW4ba0ba8jS3u5s6lZVylmZfV/sblO4w9mPQHW3i7lSLCuuo3iAaP
         J/TiXfNnO5WxJDSWwx5+AFNZ9W3HHJy3QtJSXW9vsq2b8KnyAELTNhYAPd5YdiELE6Y3
         ACFhgOrN5/v/+jQ4rUQFU4OrC+pFkCeKrVNmMHXJHwe7Ed1MTwUijwW5Tz6alhpub4SZ
         dRLTMxUkIdSJWKXmjqy3sZB5e3AM6HgZ5OlxCtgjooXT2pnXxCQeH85hRZFerIZp3px1
         Qq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=darsJglboYFXdBV0PtDEBbxKvHxm+QT0RA6oYl1qQTo=;
        b=VWmh7nctSpM8nPjcIM3ryZ9MxegeoUB4AErvvKoqH6ys1YWV+wKIeYX5zfS+Ex28PV
         28YvlFd38ETogexyLj/5LBaS3g7FjzJbyG3uCJHQGRu+/0oNIyvVEB2jLuxo0fj5MlzG
         gUQ9VgMRd6izgr4nZd6vfICFhzlwWKORaC9Jggsd2voBhLk4yJl5mncq0nUN+mWQLj5u
         W521nSo0dPvi8Jz5R8dnozmB6xYcUc1u/karYRZEiFKMSt/oBcILwqBY0l3cMkyHZz1e
         KU+keKDjIDH3mMnJz9HtRkcImjOOcQXOHMo6mu5/7wWHSJXMUjVVX0Yyqiwry5NUNzYk
         0/Rw==
X-Gm-Message-State: AGRZ1gJk8LsKGe5Hl3IDkMsvaorVQCBaMX//rfrdRaoxt0M6E9W90gOW
        slY1vAAwBMGJ7IVgv/5gti8G/f1ffrvR
X-Google-Smtp-Source: AJdET5fd05/NL1Po+jP4G21NUHoIMH++ho5ND9FeqI5FcJKYH72lG9tbVHRtO043LJxEstTTVa68jo46R8X0
X-Received: by 2002:a24:9085:: with SMTP id x127-v6mr65542itd.17.1542154450611;
 Tue, 13 Nov 2018 16:14:10 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:12:58 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-16-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 15/23] commit: prepare repo_unuse_commit_buffer to handle any repo
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c                                        | 6 ++++--
 commit.h                                        | 7 ++++++-
 contrib/coccinelle/the_repository.pending.cocci | 8 ++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index 4034def16c..7d2f3a9a93 100644
--- a/commit.c
+++ b/commit.c
@@ -318,10 +318,12 @@ const void *repo_get_commit_buffer(struct repository *r,
 	return ret;
 }
 
-void unuse_commit_buffer(const struct commit *commit, const void *buffer)
+void repo_unuse_commit_buffer(struct repository *r,
+			      const struct commit *commit,
+			      const void *buffer)
 {
 	struct commit_buffer *v = buffer_slab_peek(
-		the_repository->parsed_objects->buffer_slab, commit);
+		r->parsed_objects->buffer_slab, commit);
 	if (!(v && v->buffer == buffer))
 		free((void *)buffer);
 }
diff --git a/commit.h b/commit.h
index 591a77a5bb..57375e3239 100644
--- a/commit.h
+++ b/commit.h
@@ -130,7 +130,12 @@ const void *repo_get_commit_buffer(struct repository *r,
  * from an earlier call to get_commit_buffer.  The buffer may or may not be
  * freed by this call; callers should not access the memory afterwards.
  */
-void unuse_commit_buffer(const struct commit *, const void *buffer);
+void repo_unuse_commit_buffer(struct repository *r,
+			      const struct commit *,
+			      const void *buffer);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define unuse_commit_buffer(c, b) repo_unuse_commit_buffer(the_repository, c, b)
+#endif
 
 /*
  * Free any cached object buffer associated with the commit.
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 4018e6eaf7..516f19ffee 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -115,3 +115,11 @@ expression F;
 - get_commit_buffer(
 + repo_get_commit_buffer(the_repository,
   E, F);
+
+@@
+expression E;
+expression F;
+@@
+- unuse_commit_buffer(
++ repo_unuse_commit_buffer(the_repository,
+  E, F);
-- 
2.19.1.1215.g8438c0b245-goog

