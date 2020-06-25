Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C87C433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4947A206BE
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDoTlC1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404832AbgFYMtO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404800AbgFYMtI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 08:49:08 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9748C0613ED
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so5682154wrs.11
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u3q6LT8tzjTrVZzU8OLU0WIXhGYdhNBcBuI6j0C3xTI=;
        b=CDoTlC1c3pwuFasfu0N6G2KQNRM/XeLC87MoPvSMw8iGPr9QH/TYlPUluCI6Yky8Nd
         ls/5YDPFuo0xpr6sjLjcnQVr+pfe0q2kOqJ9M/Fi5u9oOoWc8C/gfQo44sWYVx5OQJf7
         OkMue0S8PE4fD8WXdSKOZwqPl9urTRiuw5PSUpFsq/enfJLBvdiSf+ssh2OZu8VhhS1x
         qmWymxUmRwK7gzaVHjE+aR67hvpSx723uLZYi084RIXWDFJG4hAT+tgr1f7Y6xk2xHro
         WWudUIsiGlPlXBoNZEep+ySpsz7L+1O0hMZ0yFPmpK+I0vO9CEveqvmunuJcC4SrStsY
         LRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u3q6LT8tzjTrVZzU8OLU0WIXhGYdhNBcBuI6j0C3xTI=;
        b=CachlVBZODZn/BGaBB7VWNhoWZH9u7oSMg/YnOY8UZU8nllrhRuDFHZjUZbttrGmlK
         Z4NLwuhbeGTsQiByspk0WI+wDfiI7lR1xvGfzfRslS/+N0CIUK+LTXSfz0cpAv0J/XO3
         nGlyr8zBTTqKsRh8FBbjcLx+n2MdUerG+uCHAZqQF8EnSLaUhCTvF0mPRr1wNSRbVwuH
         AVi1ny02x17dPohkkrksWw9yp2eI89rCjK+DpvcS/YWaJcNkFCydqKCVkaueFvxKxNuf
         qXl1UlGfH8FSL7GGTGw6zQpiTvT2t5eplNGowz9kyXKUMks/5JreXaos/n3oNLqR7brY
         gBkQ==
X-Gm-Message-State: AOAM531eI4xM2ulEYCxxzm7svq7x7PZU9UV9Y3uZml0tagE7m7ziDfyE
        Uad9sQUdw12g6f7AbnyrwchPfk2r
X-Google-Smtp-Source: ABdhPJzCza06lHXrRfXBr+lTUGUt/nsJ+Q0iNtk5N5lTMrrwKG0Y+ag9etE/MeGiqLRgzSlQQk0VVw==
X-Received: by 2002:a5d:40c9:: with SMTP id b9mr5380389wrq.425.1593089346352;
        Thu, 25 Jun 2020 05:49:06 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-308-216.w86-199.abo.wanadoo.fr. [86.199.91.216])
        by smtp.googlemail.com with ESMTPSA id y16sm31563409wro.71.2020.06.25.05.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:49:05 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 10/17] merge-recursive: move better_branch_name() to merge.c
Date:   Thu, 25 Jun 2020 14:19:46 +0200
Message-Id: <20200625121953.16991-11-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625121953.16991-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

get_better_branch_name() will be used by rebase-octopus once it is
rewritten in C, so instead of duplicating it, this moves this function
preventively inside an appropriate file in libgit.a.  This function is
also renamed to reflect its usage by merge strategies.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---

Notes:
    This patch is best viewed with `--color-moved'.

 builtin/merge-recursive.c | 16 ++--------------
 cache.h                   |  2 +-
 merge.c                   | 12 ++++++++++++
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index a4bfd8fc51..972243b5e9 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -8,18 +8,6 @@
 static const char builtin_merge_recursive_usage[] =
 	"git %s <base>... -- <head> <remote> ...";
 
-static char *better_branch_name(const char *branch)
-{
-	static char githead_env[8 + GIT_MAX_HEXSZ + 1];
-	char *name;
-
-	if (strlen(branch) != the_hash_algo->hexsz)
-		return xstrdup(branch);
-	xsnprintf(githead_env, sizeof(githead_env), "GITHEAD_%s", branch);
-	name = getenv(githead_env);
-	return xstrdup(name ? name : branch);
-}
-
 int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 {
 	const struct object_id *bases[21];
@@ -75,8 +63,8 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	if (get_oid(o.branch2, &h2))
 		die(_("could not resolve ref '%s'"), o.branch2);
 
-	o.branch1 = better1 = better_branch_name(o.branch1);
-	o.branch2 = better2 = better_branch_name(o.branch2);
+	o.branch1 = better1 = merge_get_better_branch_name(o.branch1);
+	o.branch2 = better2 = merge_get_better_branch_name(o.branch2);
 
 	if (o.verbosity >= 3)
 		printf(_("Merging %s with %s\n"), o.branch1, o.branch2);
diff --git a/cache.h b/cache.h
index 0f0485ecfe..bbbd8e352d 100644
--- a/cache.h
+++ b/cache.h
@@ -1915,7 +1915,7 @@ int checkout_fast_forward(struct repository *r,
 			  const struct object_id *from,
 			  const struct object_id *to,
 			  int overwrite_ignore);
-
+char *merge_get_better_branch_name(const char *branch);
 
 int sane_execvp(const char *file, char *const argv[]);
 
diff --git a/merge.c b/merge.c
index aa36de2f64..5f3d05268f 100644
--- a/merge.c
+++ b/merge.c
@@ -108,3 +108,15 @@ int checkout_fast_forward(struct repository *r,
 		return error(_("unable to write new index file"));
 	return 0;
 }
+
+char *merge_get_better_branch_name(const char *branch)
+{
+	static char githead_env[8 + GIT_MAX_HEXSZ + 1];
+	char *name;
+
+	if (strlen(branch) != the_hash_algo->hexsz)
+		return xstrdup(branch);
+	xsnprintf(githead_env, sizeof(githead_env), "GITHEAD_%s", branch);
+	name = getenv(githead_env);
+	return xstrdup(name ? name : branch);
+}
-- 
2.27.0.139.gc9c318d6bf

