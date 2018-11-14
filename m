Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92D591F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbeKNKOv (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:14:51 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:33938 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731191AbeKNKOu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:14:50 -0500
Received: by mail-yw1-f73.google.com with SMTP id j186-v6so4467737ywj.1
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4oPSJiLpae3XBaLljvdnmh4s6/Kyu2e/v7ySXbNXtWk=;
        b=DCYBE/Z34seTqq23LqD8foGaMwG304YE7Msc939seto1SZL9lisx1P6vOrp9DGIQBD
         hlrCxnQEKU7pWnUPbPzYFsDR7LpD7iULQSYrmhVIA+qu2rHAQiPZDkcqub6nm+M7c1yE
         QnYjQzVUFm2rqIr+RG1vBklljH2G5RXi7vAQ+EBIPess6nQijoPwjK0TW3MJQMIuQf2M
         sabYQj8AsQtWhP8zd1x8Z0CKgdjIrwcVS+/nyCIvolSqUvMyn9TwtpTvCUXHNhkTxyA6
         QSJ30DWv1K4YmJ3spfOdkw3BqN8hvaCzM0m3UXtKsmJ3rRDOU/z6uIIDCjqOAzZPce7C
         B+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4oPSJiLpae3XBaLljvdnmh4s6/Kyu2e/v7ySXbNXtWk=;
        b=Xt66CDmRVOOgAG4hPhFb0y/BY2JoKWo6AVEFBrxJthXYMVDsroL22+NVa5CJMCybq/
         rmBkXyjUTItRLTN0a9TBUHoF70k/slSR21iWGrjf0IcwClUPcdzc7oARuORgy0UauPWN
         OorOYtdW5WVe9zMkAU3zB9ZgsAhiHyQ6UFdDwZzoVD/t1IvY/drLqU6QZwqlLYRN/Qrj
         ePhG0J0t6MT6/2m2LPaHwbkh4UClXFbFtMwpMCXufGEhmJ7vRRdMfTkz9RoA4ExfejkB
         ogJPDuX5bdx5II7tMmdjmKXgFLfBd0le0Yl4iygaBG1yrpxHxQ7gr9xHgao4s2cGjBI5
         h9pw==
X-Gm-Message-State: AGRZ1gIvDPzK0pJNzkhEUnSkt/bmxbYG3/Z59aJJfIaWWOgmeWjmEF9n
        zGABy3DOXqN4LK+9MnjGRnzJCZoTKTC7
X-Google-Smtp-Source: AJdET5fkUR4OdES77XtTiAdZs7NmlhySv+GiV1rZULAmI+g0I2XR1QZTs5cH3gEAp5Kf7mHT8W5zeXflgI32
X-Received: by 2002:a81:77d4:: with SMTP id s203-v6mr3639440ywc.7.1542154447335;
 Tue, 13 Nov 2018 16:14:07 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:12:57 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-15-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 14/23] commit: prepare get_commit_buffer to handle any repo
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
 commit.c                                        | 8 +++++---
 commit.h                                        | 7 ++++++-
 contrib/coccinelle/the_repository.pending.cocci | 8 ++++++++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 7a931d7fd4..4034def16c 100644
--- a/commit.c
+++ b/commit.c
@@ -297,13 +297,15 @@ const void *get_cached_commit_buffer(struct repository *r, const struct commit *
 	return v->buffer;
 }
 
-const void *get_commit_buffer(const struct commit *commit, unsigned long *sizep)
+const void *repo_get_commit_buffer(struct repository *r,
+				   const struct commit *commit,
+				   unsigned long *sizep)
 {
-	const void *ret = get_cached_commit_buffer(the_repository, commit, sizep);
+	const void *ret = get_cached_commit_buffer(r, commit, sizep);
 	if (!ret) {
 		enum object_type type;
 		unsigned long size;
-		ret = read_object_file(&commit->object.oid, &type, &size);
+		ret = repo_read_object_file(r, &commit->object.oid, &type, &size);
 		if (!ret)
 			die("cannot read commit object %s",
 			    oid_to_hex(&commit->object.oid));
diff --git a/commit.h b/commit.h
index 08935f9a19..591a77a5bb 100644
--- a/commit.h
+++ b/commit.h
@@ -117,7 +117,12 @@ const void *get_cached_commit_buffer(struct repository *, const struct commit *,
  * from disk. The resulting memory should not be modified, and must be given
  * to unuse_commit_buffer when the caller is done.
  */
-const void *get_commit_buffer(const struct commit *, unsigned long *size);
+const void *repo_get_commit_buffer(struct repository *r,
+				   const struct commit *,
+				   unsigned long *size);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define get_commit_buffer(c, s) repo_get_commit_buffer(the_repository, c, s)
+#endif
 
 /*
  * Tell the commit subsytem that we are done with a particular commit buffer.
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 8c6a71bf64..4018e6eaf7 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -107,3 +107,11 @@ expression G;
 - in_merge_bases_many(
 + repo_in_merge_bases_many(the_repository,
   E, F, G);
+
+@@
+expression E;
+expression F;
+@@
+- get_commit_buffer(
++ repo_get_commit_buffer(the_repository,
+  E, F);
-- 
2.19.1.1215.g8438c0b245-goog

