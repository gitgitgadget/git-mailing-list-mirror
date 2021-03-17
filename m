Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66FBC4360C
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5F8264F69
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhCQU5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbhCQU4v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:56:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA21C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so2110467wmj.1
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RW+D7f1oxJxmgGd2avNnijAV0J33kwdMVcTvFxLDRcs=;
        b=piNEnS934iRtcrXkkbEdN7OMt1hNrCCQBQsg9kgkydpGC+GHv8uFSK2oP18cMqg2gI
         XOgWfuIcQBzdeBHs4mBs/7RGvlzsNe7xxCmYNoDyzV08ZlG7ikyNjncUrsJkdcGJWQny
         O1zkRFK4/OwdKYDwLGOQwG4LA0tYAy+njNOXXnJNelu3AVuOEZFgdpVbrDSu8FmgN7ve
         vUyk2hExu1umNv2qliDdZ09656CnfQwSExGwm46pmK9Ortt4TXehhoCeZ3wzgtQ6OLtW
         4/k+gWw0QDJd9FZ/Kzmsos6euB+SagSEEeeiH1A36vT+l3May8ObD7yur3X/bd1Lua7H
         zJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RW+D7f1oxJxmgGd2avNnijAV0J33kwdMVcTvFxLDRcs=;
        b=dRl8SVAg+k1p0sLkK5901AnvTGkKfxDS/RlsGanCRWmMST80fuZPv+j9wEtz3oTBKe
         euJgBQaXxPN1tcm6VdBVBHfI6UUvd80bvHBu3iQ6VsqyD7V2GMGYuKa7iXm1iNYwNZwY
         cAKXV/rhh9NpXPa7anZgLcxVn6jXbKwOYR41QzpyKMoJv9S5hU1mU9px0PrZoF459ko9
         TCwu6sq6cEoMpgZlZ1sjmqH8XEmncXHzwZBxoNShxMQGIjsqsdQGJCib9+YL7V/m9Go/
         D7E+rJDjhEIdsnIJN0cDAEky/7diRd6iIiU/AtS1+h+0LqPxMVAKAMulaSq64FWHdfoO
         TrhQ==
X-Gm-Message-State: AOAM531/d3ZiRPA+2CyUdoBQfrolQB5+VV+CxQ6K2uqHJEpgN2J+VqB8
        Gn5iJcqIQlJR6h1OANb0ov7R3G9/RJQ=
X-Google-Smtp-Source: ABdhPJxQ4At3D4tLrgsL8kJyJSvX077XOwAJPvoVuPuMfCuXh+PP2tUbOxPN9H93BcVClEuPjS2aUg==
X-Received: by 2002:a1c:a958:: with SMTP id s85mr626836wme.4.1616014609379;
        Wed, 17 Mar 2021 13:56:49 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-299-135.w86-199.abo.wanadoo.fr. [86.199.82.135])
        by smtp.googlemail.com with ESMTPSA id g5sm158452wrq.30.2021.03.17.13.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:56:48 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 10/15] merge-recursive: move better_branch_name() to merge.c
Date:   Wed, 17 Mar 2021 21:49:34 +0100
Message-Id: <20210317204939.17890-11-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317204939.17890-1-alban.gruin@gmail.com>
References: <20201124115315.13311-1-alban.gruin@gmail.com>
 <20210317204939.17890-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

better_branch_name() will be used by merge-octopus once it is rewritten
in C, so instead of duplicating it, this moves this function
preventively inside an appropriate file in libgit.a.  This function is
also renamed to reflect its usage by merge strategies.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
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
index 41e30c0da2..e89a8c3404 100644
--- a/cache.h
+++ b/cache.h
@@ -1852,7 +1852,7 @@ int checkout_fast_forward(struct repository *r,
 			  const struct object_id *from,
 			  const struct object_id *to,
 			  int overwrite_ignore);
-
+char *merge_get_better_branch_name(const char *branch);
 
 int sane_execvp(const char *file, char *const argv[]);
 
diff --git a/merge.c b/merge.c
index 5fb88af102..801d673c5f 100644
--- a/merge.c
+++ b/merge.c
@@ -109,3 +109,15 @@ int checkout_fast_forward(struct repository *r,
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
2.31.0

