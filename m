Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056FDC433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C288B64E79
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbhBQVE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbhBQVEB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 16:04:01 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67034C06178A
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:02:48 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id t62so25231qke.7
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zq+Yi2HL4q2Lmum2IocGaq5/oM1Ro8YZzxVQXhldSNc=;
        b=xS46RDtulNOLKxcPdkwgFN7ukFuGIGPRV6T0lXuIkICbaeHJHfKvyPRJrsjH4q12Bf
         x/HDzMp9a4m35QcNZav9BCjghO4z5aSsoZLhJBwGlQXE53kURr66APmmmi+ijwkP3qT4
         o2222v4NHWT8PaFeanKTgbpmUpn/ZpAV2Ak0ucusPJ4kfozyoA9Iicgvdhi7q8GHNUA3
         FqQMl9UaXwic7n9mdkJOnDT202JY6xnoqtk9o36Ig6jFUqHjWq7sqy7lZkvDzi+R2maT
         ukWw7p5N7EBaVImjqUcXF4w2QmxH3KR9xuWxEAzI6+uV//DNxdNq2d5sj9yOSg0hkzp/
         90pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zq+Yi2HL4q2Lmum2IocGaq5/oM1Ro8YZzxVQXhldSNc=;
        b=ql3od24aqXM+Xh7IKa+/bK5dIPuTIBj8f0WMTEot8tplNttPhOCi0uYV+gVViWwjND
         UHyvXa+T+VlBHVLZy0/5kr1Ft1zXdpjo8BuEAkKWO8Ccr2j6a2eJB9ijzGogQykufxZ4
         8QGHSOskLsXwv99o8amMkjr6Jo5EZHQVxnFbTUO4yjLR66Sp9TRp+tqTTZXQZeEIbsBg
         PG5E5eEql8HrNlm34gT+zHsvgaqF7pFJ/IlncaSMGXYLRatad5v9T4ltVcEFI1BpnIQY
         5uLdzMzRY5cT3C/rdlvBx3hDc1JJxrVAdtR/auJhsva/aRLEiqA9uJEPa+ZszFyv3cDe
         MQsQ==
X-Gm-Message-State: AOAM531faN3GBssz7Au7a8T/faUST8thdnhlgwnNvNg0w+8UuKfqeD7a
        KZso7WE24sRk3V9AI9xvmc50LxqCokeaAg==
X-Google-Smtp-Source: ABdhPJxU3I2tnpohHfoomEAUBjmBWEJWeP1kJ+SZJ9D3+0Pk9NjaaZ/zJgQWHMclrB5brIH9tj34Hg==
X-Received: by 2002:a37:4a56:: with SMTP id x83mr1136972qka.205.1613595767210;
        Wed, 17 Feb 2021 13:02:47 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id o194sm2438459qke.101.2021.02.17.13.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:02:46 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com
Subject: [RFC PATCH 5/7] pathspec: allow to ignore SKIP_WORKTREE entries on index matching
Date:   Wed, 17 Feb 2021 18:02:28 -0300
Message-Id: <82a3b4247a3635ebef4bb7c5e13f93e71147a98a.1613593946.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1613593946.git.matheus.bernardino@usp.br>
References: <cover.1613593946.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the 'ignore_skip_worktree' boolean parameter to both
add_pathspec_matches_against_index() and
find_pathspecs_matching_against_index(). When true, these functions will
not try to match the given pathspec with SKIP_WORKTREE entries. This
will be used in a future patch to make `git add` display a hint
when the pathspec matches only sparse paths.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/add.c          |  4 ++--
 builtin/check-ignore.c |  2 +-
 pathspec.c             | 10 +++++++---
 pathspec.h             |  5 +++--
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index e10a039070..9f0f6ebaff 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -170,7 +170,7 @@ static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec,
 			*dst++ = entry;
 	}
 	dir->nr = dst - dir->entries;
-	add_pathspec_matches_against_index(pathspec, &the_index, seen);
+	add_pathspec_matches_against_index(pathspec, &the_index, seen, 0);
 	return seen;
 }
 
@@ -571,7 +571,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		int i;
 
 		if (!seen)
-			seen = find_pathspecs_matching_against_index(&pathspec, &the_index);
+			seen = find_pathspecs_matching_against_index(&pathspec, &the_index, 0);
 
 		/*
 		 * file_exists() assumes exact match
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 3c652748d5..235b7fc905 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -100,7 +100,7 @@ static int check_ignore(struct dir_struct *dir,
 	 * should not be ignored, in order to be consistent with
 	 * 'git status', 'git add' etc.
 	 */
-	seen = find_pathspecs_matching_against_index(&pathspec, &the_index);
+	seen = find_pathspecs_matching_against_index(&pathspec, &the_index, 0);
 	for (i = 0; i < pathspec.nr; i++) {
 		full_path = pathspec.items[i].match;
 		pattern = NULL;
diff --git a/pathspec.c b/pathspec.c
index 7a229d8d22..e5e6b7458d 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -21,7 +21,7 @@
  */
 void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 					const struct index_state *istate,
-					char *seen)
+					char *seen, int ignore_skip_worktree)
 {
 	int num_unmatched = 0, i;
 
@@ -38,6 +38,8 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 		return;
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
+		if (ignore_skip_worktree && ce_skip_worktree(ce))
+			continue;
 		ce_path_match(istate, ce, pathspec, seen);
 	}
 }
@@ -51,10 +53,12 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
  * given pathspecs achieves against all items in the index.
  */
 char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
-					    const struct index_state *istate)
+					    const struct index_state *istate,
+					    int ignore_skip_worktree)
 {
 	char *seen = xcalloc(pathspec->nr, 1);
-	add_pathspec_matches_against_index(pathspec, istate, seen);
+	add_pathspec_matches_against_index(pathspec, istate, seen,
+					   ignore_skip_worktree);
 	return seen;
 }
 
diff --git a/pathspec.h b/pathspec.h
index 454ce364fa..8202882ecd 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -151,9 +151,10 @@ static inline int ps_strcmp(const struct pathspec_item *item,
 
 void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 					const struct index_state *istate,
-					char *seen);
+					char *seen, int ignore_skip_worktree);
 char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
-					    const struct index_state *istate);
+					    const struct index_state *istate,
+					    int ignore_skip_worktree);
 int match_pathspec_attrs(const struct index_state *istate,
 			 const char *name, int namelen,
 			 const struct pathspec_item *item);
-- 
2.29.2

