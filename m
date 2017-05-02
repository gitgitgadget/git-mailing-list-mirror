Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91CC9207E3
	for <e@80x24.org>; Tue,  2 May 2017 22:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751629AbdEBWYW (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:24:22 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34688 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbdEBWX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:57 -0400
Received: by mail-pg0-f42.google.com with SMTP id v1so68095695pgv.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5owdphUVKYp0psDe8EokLIHQVR65sl3G2duznmtSXEE=;
        b=f2Rt8Qby8xA2kQBlaNGWf20ED5djxL1yuqMZVo1Qh67SRo8715poZjmyjHviIhgF9i
         /uSD3lUxP6sbXE3kT+p6zNS2ds2z+tTXSqwfYWjuMofO4sGZmZQoIFR2ptcfIGSF4j4A
         sGLqO8DiVgd/QTGYZgVeiD4KT4+A0Jlr8I7wlGrQQl1bE8gpNeauiNeq6wi+yVrVL0Ke
         KjYHq9JvpaOgXK49NCsSfG2OHQhi8yOW6+mT6gvKEdGwcSjqTO0T5wUCpBpIhKGxO/bV
         Wszd8R91pT+lsPkeS0r4RQvoNT/vc5XK1XSansX4aUiXnrpyFNWhWcr5KTCiaAHvbKku
         +8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5owdphUVKYp0psDe8EokLIHQVR65sl3G2duznmtSXEE=;
        b=rmJ1kOZbr+0uiVMOqCqtuqu4P+kC+Fqt/sGfWQR3p7IbwLvulsvzx5/vfXC/HJ5fpR
         8nzs6dxlgc06oEJ1ds52eNH5U397wHPWPLuqjhqDvANUShu9EIG67FA0JnzsFL1xQPta
         A4uTOm9V3/p6UGO22SInK95ApOcifPVf3na/9BaY17e6T0+HmBj4pEhRfIqx6z/9WgNb
         /+ft4pOQE4+bO7O0+utr7BWY/7BcNwEXO3qtpGRQWZau4gv8M3PiLAjWGg62h9kqSoWk
         2PpVIiZe5MckL08+KDXaL9mgY9U4R9ERbG7RAw5+aAsxcZCyGyEL12YQy47BzxDH1IVf
         nlog==
X-Gm-Message-State: AN3rC/4vXoEo3gz4D7EqkkCbKBYRd+6esN57cYdw0TsxonunVbwxCVAT
        GqnFdJTkA5uOBcDw
X-Received: by 10.99.149.20 with SMTP id p20mr18945275pgd.112.1493763836860;
        Tue, 02 May 2017 15:23:56 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id l3sm669462pfj.130.2017.05.02.15.23.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:56 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 23/24] cache.h: drop ce_match_stat
Date:   Tue,  2 May 2017 15:23:21 -0700
Message-Id: <20170502222322.21055-24-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

coccinelle patch:
@@ expression ce, st, options; @@
-ce_match_stat(ce, st, options)
+ie_match_stat(&the_index, ce, st, options)

Additionally drop the define from cache.h manually.

Note that there is an empty define section in cache.h now.
The cleanup of that is done in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 apply.c                | 3 ++-
 builtin/rm.c           | 2 +-
 builtin/update-index.c | 2 +-
 cache.h                | 1 -
 check-racy.c           | 4 ++--
 diff-lib.c             | 2 +-
 diff.c                 | 2 +-
 entry.c                | 3 ++-
 submodule.c            | 2 +-
 9 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/apply.c b/apply.c
index 8a61f19d03..46bc5a20b9 100644
--- a/apply.c
+++ b/apply.c
@@ -3364,7 +3364,8 @@ static int verify_index_match(const struct cache_entry *ce, struct stat *st)
 			return -1;
 		return 0;
 	}
-	return ce_match_stat(ce, st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
+	return ie_match_stat(&the_index, ce, st,
+			     CE_MATCH_IGNORE_VALID | CE_MATCH_IGNORE_SKIP_WORKTREE);
 }
 
 #define SUBMODULE_PATCH_WITHOUT_INDEX 1
diff --git a/builtin/rm.c b/builtin/rm.c
index f479100298..51b64f2bae 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -163,7 +163,7 @@ static int check_local_mod(struct object_id *head, int index_only)
 		 * Is the index different from the file in the work tree?
 		 * If it's a submodule, is its work tree modified?
 		 */
-		if (ce_match_stat(ce, &st, 0) ||
+		if (ie_match_stat(&the_index, ce, &st, 0) ||
 		    (S_ISGITLINK(ce->ce_mode) &&
 		     bad_to_remove_submodule(ce->name,
 				SUBMODULE_REMOVAL_DIE_ON_ERROR |
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 9cbd346f95..042f4c94cf 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -268,7 +268,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 	struct cache_entry *ce;
 
 	/* Was the old index entry already up-to-date? */
-	if (old && !ce_stage(old) && !ce_match_stat(old, st, 0))
+	if (old && !ce_stage(old) && !ie_match_stat(&the_index, old, st, 0))
 		return 0;
 
 	size = cache_entry_size(len);
diff --git a/cache.h b/cache.h
index c34fc4fd40..f2a45eda9a 100644
--- a/cache.h
+++ b/cache.h
@@ -354,7 +354,6 @@ extern void free_name_hash(struct index_state *istate);
 
 
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
-#define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #endif
 
 enum object_type {
diff --git a/check-racy.c b/check-racy.c
index 6599ae84cf..485d7ab8f8 100644
--- a/check-racy.c
+++ b/check-racy.c
@@ -16,9 +16,9 @@ int main(int ac, char **av)
 			continue;
 		}
 
-		if (ce_match_stat(ce, &st, 0))
+		if (ie_match_stat(&the_index, ce, &st, 0))
 			dirty++;
-		else if (ce_match_stat(ce, &st, CE_MATCH_RACY_IS_DIRTY))
+		else if (ie_match_stat(&the_index, ce, &st, CE_MATCH_RACY_IS_DIRTY))
 			racy++;
 		else
 			clean++;
diff --git a/diff-lib.c b/diff-lib.c
index de59ec0459..4ca3ce9c90 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -69,7 +69,7 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 				     struct stat *st, unsigned ce_option,
 				     unsigned *dirty_submodule)
 {
-	int changed = ce_match_stat(ce, st, ce_option);
+	int changed = ie_match_stat(&the_index, ce, st, ce_option);
 	if (S_ISGITLINK(ce->ce_mode)) {
 		unsigned orig_flags = diffopt->flags;
 		if (!DIFF_OPT_TST(diffopt, OVERRIDE_SUBMODULE_CONFIG))
diff --git a/diff.c b/diff.c
index f2ee40fe21..bd1478f6c9 100644
--- a/diff.c
+++ b/diff.c
@@ -2782,7 +2782,7 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	 * If ce matches the file in the work tree, we can reuse it.
 	 */
 	if (ce_uptodate(ce) ||
-	    (!lstat(name, &st) && !ce_match_stat(ce, &st, 0)))
+	    (!lstat(name, &st) && !ie_match_stat(&the_index, ce, &st, 0)))
 		return 1;
 
 	return 0;
diff --git a/entry.c b/entry.c
index d2b512da90..d3a34c9cc4 100644
--- a/entry.c
+++ b/entry.c
@@ -266,7 +266,8 @@ int checkout_entry(struct cache_entry *ce,
 
 	if (!check_path(path.buf, path.len, &st, state->base_dir_len)) {
 		const struct submodule *sub;
-		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
+		unsigned changed = ie_match_stat(&the_index, ce, &st,
+						 CE_MATCH_IGNORE_VALID | CE_MATCH_IGNORE_SKIP_WORKTREE);
 		/*
 		 * Needs to be checked before !changed returns early,
 		 * as the possibly empty directory was not changed
diff --git a/submodule.c b/submodule.c
index 6587bc0d84..43997f237e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -191,7 +191,7 @@ void gitmodules_config(void)
 		} else if (pos < the_index.cache_nr) {
 			struct stat st;
 			if (lstat(".gitmodules", &st) == 0 &&
-			    ce_match_stat(the_index.cache[pos], &st, 0) & DATA_CHANGED)
+			    ie_match_stat(&the_index, the_index.cache[pos], &st, 0) & DATA_CHANGED)
 				gitmodules_is_modified = 1;
 		}
 
-- 
2.13.0.rc1.39.ga6db8bfa24

