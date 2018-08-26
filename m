Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9341E1F404
	for <e@80x24.org>; Sun, 26 Aug 2018 10:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeHZNpr (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 09:45:47 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44455 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeHZNpr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 09:45:47 -0400
Received: by mail-lf1-f68.google.com with SMTP id g6-v6so9703033lfb.11
        for <git@vger.kernel.org>; Sun, 26 Aug 2018 03:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F5YeWhdeEVYIE62Wh/PLY3+KUmlkvX0Ero0bD+7QEcc=;
        b=dz7NNeilsdbltXQqhW+CvZVJEcGveSI9vmjx09z8hs55F7CYJ0ijJpxDh+2ZldXBa+
         rcZLHZapF2znAhZrwfKVWZtFhVKdx+fM67iY5pe8wtw8wHF7RyvFM3+KtVqvXqVwxPVg
         mJGMTE/jz5tAIWvkMw5rodHxHPQZXs8M8j70kU+Ypy0fTgktvCAr/dtpSIaaXLY7FdaF
         Wdf5mw247AH4jpldx7UE4fDjmDehgszLQEspx5mw30/S0txrIdq3Pn25TrreVb56wtT9
         fc52GEVylqh63jLQGzsUmIxsr299iv0jKHQTPbKRKFdyjL0glTEOulhc7lehtsK4Rr6H
         whfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F5YeWhdeEVYIE62Wh/PLY3+KUmlkvX0Ero0bD+7QEcc=;
        b=GUDefnqz41gjsALL/aryr63mxyj/R5/3XHF/H2JTzHQ98/DoMitXPpfhztp8SIqsHL
         VcwLJJIZILkBweaG4CKCYRcxnsea1UzllfMdi+znQuZ2DFGP/LClf/55knhHtTv9ooz3
         pQzK403N6XfdiOZZNg1YKe5EM/TleIF8XEAbG9TtrZCK2xk7QTFsci6Q5k7cvFFEp4pm
         suN62fdYEwbPHmCHHST86QotYbewjJKpd/aGQO/CfwS0e9iL3IicuYa4ioG3s9qvyfRX
         exDH0LwroMCWytW4byXMM8xEhqp0wurkqiLvzOhm6hP/i6ABCGF3LvzoSO1/KPRb+mNq
         eP6w==
X-Gm-Message-State: APzg51Cvy9fleYaKJzsx1mu9+Q5b0suDwl16t/C8vSOxi+imjsokudY2
        rS/eujbegPG6Y3bjycbs+KxYwn0n
X-Google-Smtp-Source: ANB0VdaVBKBSZBecktUIYFhKrgaR8x9b71UYIpFdOqVypOrhhAJe7a3NWSQNGcH5Px/IFUwArPDXww==
X-Received: by 2002:a19:f015:: with SMTP id p21-v6mr5792938lfc.56.1535277819261;
        Sun, 26 Aug 2018 03:03:39 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z5-v6sm2276882lfg.75.2018.08.26.03.03.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 03:03:38 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 21/21] wt-status.c: remove implicit dependency the_repository
Date:   Sun, 26 Aug 2018 12:03:14 +0200
Message-Id: <20180826100314.5137-22-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180826100314.5137-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 ref-filter.c |  2 +-
 wt-status.c  | 24 +++++++++++++-----------
 wt-status.h  |  4 +++-
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 0bccfceff2..1b229b84da 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1409,7 +1409,7 @@ char *get_head_description(void)
 	struct strbuf desc = STRBUF_INIT;
 	struct wt_status_state state;
 	memset(&state, 0, sizeof(state));
-	wt_status_get_state(&state, 1);
+	wt_status_get_state(the_repository, &state, 1);
 	if (state.rebase_in_progress ||
 	    state.rebase_interactive_in_progress) {
 		if (state.branch)
diff --git a/wt-status.c b/wt-status.c
index 57bc2aac0f..1d3a5fe267 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1322,7 +1322,7 @@ static void show_rebase_in_progress(struct wt_status *s,
 			status_printf_ln(s, color,
 				_("  (use \"git rebase --abort\" to check out the original branch)"));
 		}
-	} else if (state->rebase_in_progress || !stat(git_path_merge_msg(the_repository), &st)) {
+	} else if (state->rebase_in_progress || !stat(git_path_merge_msg(s->repo), &st)) {
 		print_rebase_state(s, state, color);
 		if (s->hints)
 			status_printf_ln(s, color,
@@ -1477,7 +1477,8 @@ static int grab_1st_switch(struct object_id *ooid, struct object_id *noid,
 	return 1;
 }
 
-static void wt_status_get_detached_from(struct wt_status_state *state)
+static void wt_status_get_detached_from(struct repository *repo,
+					struct wt_status_state *state)
 {
 	struct grab_1st_switch_cbdata cb;
 	struct commit *commit;
@@ -1494,7 +1495,7 @@ static void wt_status_get_detached_from(struct wt_status_state *state)
 	    /* sha1 is a commit? match without further lookup */
 	    (!oidcmp(&cb.noid, &oid) ||
 	     /* perhaps sha1 is a tag, try to dereference to a commit */
-	     ((commit = lookup_commit_reference_gently(the_repository, &oid, 1)) != NULL &&
+	     ((commit = lookup_commit_reference_gently(repo, &oid, 1)) != NULL &&
 	      !oidcmp(&cb.noid, &commit->object.oid)))) {
 		const char *from = ref;
 		if (!skip_prefix(from, "refs/tags/", &from))
@@ -1551,30 +1552,31 @@ int wt_status_check_bisect(const struct worktree *wt,
 	return 0;
 }
 
-void wt_status_get_state(struct wt_status_state *state,
+void wt_status_get_state(struct repository *repo,
+			 struct wt_status_state *state,
 			 int get_detached_from)
 {
 	struct stat st;
 	struct object_id oid;
 
-	if (!stat(git_path_merge_head(the_repository), &st)) {
+	if (!stat(git_path_merge_head(repo), &st)) {
 		state->merge_in_progress = 1;
 	} else if (wt_status_check_rebase(NULL, state)) {
 		;		/* all set */
-	} else if (!stat(git_path_cherry_pick_head(the_repository), &st) &&
+	} else if (!stat(git_path_cherry_pick_head(repo), &st) &&
 			!get_oid("CHERRY_PICK_HEAD", &oid)) {
 		state->cherry_pick_in_progress = 1;
 		oidcpy(&state->cherry_pick_head_oid, &oid);
 	}
 	wt_status_check_bisect(NULL, state);
-	if (!stat(git_path_revert_head(the_repository), &st) &&
+	if (!stat(git_path_revert_head(repo), &st) &&
 	    !get_oid("REVERT_HEAD", &oid)) {
 		state->revert_in_progress = 1;
 		oidcpy(&state->revert_head_oid, &oid);
 	}
 
 	if (get_detached_from)
-		wt_status_get_detached_from(state);
+		wt_status_get_detached_from(repo, state);
 }
 
 static void wt_longstatus_print_state(struct wt_status *s,
@@ -1602,7 +1604,7 @@ static void wt_longstatus_print(struct wt_status *s)
 	struct wt_status_state state;
 
 	memset(&state, 0, sizeof(state));
-	wt_status_get_state(&state,
+	wt_status_get_state(s->repo, &state,
 			    s->branch && !strcmp(s->branch, "HEAD"));
 
 	if (s->branch) {
@@ -1947,7 +1949,7 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 	char eol = s->null_termination ? '\0' : '\n';
 
 	memset(&state, 0, sizeof(state));
-	wt_status_get_state(&state, s->branch && !strcmp(s->branch, "HEAD"));
+	wt_status_get_state(s->repo, &state, s->branch && !strcmp(s->branch, "HEAD"));
 
 	fprintf(s->fp, "# branch.oid %s%c",
 			(s->is_initial ? "(initial)" : sha1_to_hex(s->sha1_commit)),
@@ -2355,7 +2357,7 @@ int has_uncommitted_changes(struct repository *repo,
 		 * We have no head (or it's corrupt); use the empty tree,
 		 * which will complain if the index is non-empty.
 		 */
-		struct tree *tree = lookup_tree(the_repository, the_hash_algo->empty_tree);
+		struct tree *tree = lookup_tree(repo, the_hash_algo->empty_tree);
 		add_pending_object(&rev_info, &tree->object, "");
 	}
 
diff --git a/wt-status.h b/wt-status.h
index 253c5ce7ec..9e8337e9db 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -132,7 +132,9 @@ void wt_status_add_cut_line(FILE *fp);
 void wt_status_prepare(struct wt_status *s, struct repository *repo);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
-void wt_status_get_state(struct wt_status_state *state, int get_detached_from);
+void wt_status_get_state(struct repository *repo,
+			 struct wt_status_state *state,
+			 int get_detached_from);
 int wt_status_check_rebase(const struct worktree *wt,
 			   struct wt_status_state *state);
 int wt_status_check_bisect(const struct worktree *wt,
-- 
2.19.0.rc0.337.ge906d732e7

