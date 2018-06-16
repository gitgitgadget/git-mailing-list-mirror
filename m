Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 679781F403
	for <e@80x24.org>; Sat, 16 Jun 2018 05:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756807AbeFPFmJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 01:42:09 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41557 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755014AbeFPFmE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 01:42:04 -0400
Received: by mail-lf0-f67.google.com with SMTP id d24-v6so17512698lfa.8
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 22:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f0QHEp+cUdAoEOQ4IR3YYwCYW5EED//POR0aFHYePwM=;
        b=OdBGs8DGtzLWpwTC4kPE7/JhRmG47T5B6rT4lwiJwRg/jq7C0Y9WnOI0rINHB+NC0M
         yALOBdV0BjD16tY+nBnw84JOGz1CpQuczXblQsANklU6moHcx5HtVnhkcQiKE2QRTuV2
         3rysb4OPvb0eF+M+zLpQZbB+DlGmV+AJfdPm65BfcegeeXtisnvp+hyZaByVuHOK6H7x
         Ffq0yLvNPyWn3d8X+Bl8P8kPHE2Rg0aLgOrlOKSRDZyCgdc7PrAHaY4wPe2rd8/vXcH4
         93ZotKfRTCAq/hJCKLg72iL7cdTljll30Q2Q+N18hDJo3LzmkdnvghFwsiGePo4QuVlz
         OMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f0QHEp+cUdAoEOQ4IR3YYwCYW5EED//POR0aFHYePwM=;
        b=nfqz1tBXsLx3SIYUtxVJqQZ2gEJydU/40yRQooQB1ORtleKMT2FLv41Vnb+Tv1B1oX
         rLeT4DmemWIplLx4wsJucijhELYg30NOrBxA0DlthGqy/ZgW2SIff5JjFaKKBzpB9BM1
         slhtMo3cy/EWfvPFD1Q698NHpzCJQ6606UDEY0B1O0sCbnAK/VPUaxU5oqhGMr3hTIDr
         k5QP5bll0BArd8SpM0XAIt3jEsUtwZmWA4HbiZKf6pEAc5v1bVpNpPTLGUrMxcnKHh9b
         ZKCTrv0dQjuBxHMX90iCZsHFGK48C8spwrdHSy98cx1f15XCHw9CpmlbtFY4agF6hyiE
         wXGw==
X-Gm-Message-State: APt69E2eH9e1PBWZ9/tMJWh/jfBMLBsO26v7reaQYBFWkrE2meEGhX/4
        TlwCf0N7cMSorNTP8D524B3Dhw==
X-Google-Smtp-Source: ADUXVKJ2wDsjA9ERW5fkUsGYseoMzSlLk5u6YBs1fg0DzzOcIV94XVxEg1PJE6NyH9ZMmInlg1FrsQ==
X-Received: by 2002:a2e:994f:: with SMTP id r15-v6mr2939993ljj.53.1529127723020;
        Fri, 15 Jun 2018 22:42:03 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g5-v6sm1745194lje.21.2018.06.15.22.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 22:42:02 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/15] apply.c: stop using index compat macros
Date:   Sat, 16 Jun 2018 07:41:44 +0200
Message-Id: <20180616054157.32433-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180616054157.32433-1-pclouds@gmail.com>
References: <20180616054157.32433-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 apply.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/apply.c b/apply.c
index d79e61591b..57a7d3cafd 100644
--- a/apply.c
+++ b/apply.c
@@ -3378,7 +3378,8 @@ static int verify_index_match(const struct cache_entry *ce, struct stat *st)
 			return -1;
 		return 0;
 	}
-	return ce_match_stat(ce, st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
+	return ie_match_stat(&the_index, ce, st,
+			     CE_MATCH_IGNORE_VALID | CE_MATCH_IGNORE_SKIP_WORKTREE);
 }
 
 #define SUBMODULE_PATCH_WITHOUT_INDEX 1
@@ -3511,10 +3512,10 @@ static int load_current(struct apply_state *state,
 	if (!patch->is_new)
 		BUG("patch to %s is not a creation", patch->old_name);
 
-	pos = cache_name_pos(name, strlen(name));
+	pos = index_name_pos(&the_index, name, strlen(name));
 	if (pos < 0)
 		return error(_("%s: does not exist in index"), name);
-	ce = active_cache[pos];
+	ce = the_index.cache[pos];
 	if (lstat(name, &st)) {
 		if (errno != ENOENT)
 			return error_errno("%s", name);
@@ -3680,13 +3681,14 @@ static int check_preimage(struct apply_state *state,
 	}
 
 	if (state->check_index && !previous) {
-		int pos = cache_name_pos(old_name, strlen(old_name));
+		int pos = index_name_pos(&the_index, old_name,
+					 strlen(old_name));
 		if (pos < 0) {
 			if (patch->is_new < 0)
 				goto is_new;
 			return error(_("%s: does not exist in index"), old_name);
 		}
-		*ce = active_cache[pos];
+		*ce = the_index.cache[pos];
 		if (stat_ret < 0) {
 			if (checkout_target(&the_index, *ce, st))
 				return -1;
@@ -3735,7 +3737,7 @@ static int check_to_create(struct apply_state *state,
 	struct stat nst;
 
 	if (state->check_index &&
-	    cache_name_pos(new_name, strlen(new_name)) >= 0 &&
+	    index_name_pos(&the_index, new_name, strlen(new_name)) >= 0 &&
 	    !ok_if_exists)
 		return EXISTS_IN_INDEX;
 	if (state->cached)
@@ -3824,7 +3826,8 @@ static int path_is_beyond_symlink_1(struct apply_state *state, struct strbuf *na
 		if (state->check_index) {
 			struct cache_entry *ce;
 
-			ce = cache_file_exists(name->buf, name->len, ignore_case);
+			ce = index_file_exists(&the_index, name->buf,
+					       name->len, ignore_case);
 			if (ce && S_ISLNK(ce->ce_mode))
 				return 1;
 		} else {
@@ -3999,9 +4002,10 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 static int read_apply_cache(struct apply_state *state)
 {
 	if (state->index_file)
-		return read_cache_from(state->index_file);
+		return read_index_from(&the_index, state->index_file,
+				       get_git_dir());
 	else
-		return read_cache();
+		return read_index(&the_index);
 }
 
 /* This function tries to read the object name from the current index */
@@ -4012,10 +4016,10 @@ static int get_current_oid(struct apply_state *state, const char *path,
 
 	if (read_apply_cache(state) < 0)
 		return -1;
-	pos = cache_name_pos(path, strlen(path));
+	pos = index_name_pos(&the_index, path, strlen(path));
 	if (pos < 0)
 		return -1;
-	oidcpy(oid, &active_cache[pos]->oid);
+	oidcpy(oid, &the_index.cache[pos]->oid);
 	return 0;
 }
 
@@ -4243,7 +4247,7 @@ static void patch_stats(struct apply_state *state, struct patch *patch)
 static int remove_file(struct apply_state *state, struct patch *patch, int rmdir_empty)
 {
 	if (state->update_index) {
-		if (remove_file_from_cache(patch->old_name) < 0)
+		if (remove_file_from_index(&the_index, patch->old_name) < 0)
 			return error(_("unable to remove %s from index"), patch->old_name);
 	}
 	if (!state->cached) {
@@ -4297,7 +4301,7 @@ static int add_index_file(struct apply_state *state,
 				       "for newly created file %s"), path);
 		}
 	}
-	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0) {
+	if (add_index_entry(&the_index, ce, ADD_CACHE_OK_TO_ADD) < 0) {
 		free(ce);
 		return error(_("unable to add cache entry for %s"), path);
 	}
@@ -4431,7 +4435,7 @@ static int add_conflicted_stages_file(struct apply_state *state,
 	ce_size = cache_entry_size(namelen);
 	mode = patch->new_mode ? patch->new_mode : (S_IFREG | 0644);
 
-	remove_file_from_cache(patch->new_name);
+	remove_file_from_index(&the_index, patch->new_name);
 	for (stage = 1; stage < 4; stage++) {
 		if (is_null_oid(&patch->threeway_stage[stage - 1]))
 			continue;
@@ -4441,7 +4445,7 @@ static int add_conflicted_stages_file(struct apply_state *state,
 		ce->ce_flags = create_ce_flags(stage);
 		ce->ce_namelen = namelen;
 		oidcpy(&ce->oid, &patch->threeway_stage[stage - 1]);
-		if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0) {
+		if (add_index_entry(&the_index, ce, ADD_CACHE_OK_TO_ADD) < 0) {
 			free(ce);
 			return error(_("unable to add cache entry for %s"),
 				     patch->new_name);
-- 
2.18.0.rc0.333.g22e6ee6cdf

