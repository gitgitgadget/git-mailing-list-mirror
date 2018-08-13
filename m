Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6DA81F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbeHMS6m (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42643 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbeHMS6l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:41 -0400
Received: by mail-lj1-f193.google.com with SMTP id f1-v6so13014049ljc.9
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7dpbDNd97HPa+O8wkl96cUElC6hzW8DlQWxGmTbV+U4=;
        b=KWagEd0zKslQCdPZCFZgl6POl4Q+jvNyRmehk2Q8mTMA8g0Mgf1F++GS718W21h0aE
         erbDvliaXvPvDaPnPYCwk3mjnCPrn88JHSAWVpRdSfWZ21wVHyhSmoUF3LD8MWdU9mAS
         QaqzTQ5TwdamTZ+F7haNWvnNhPmkArzIfDoWNHX3E9xjN4k/0CRcJ1Sz79mRQZA3l9DV
         MLI557Ujom1xyS2x8TwMSOCsIDLyWjpImoLlB+tmaGfjywr7U/84e8jUHuePpr3Yzvzs
         11l8NV8inr+lF1c9EAMEEvuVkVDgnkppUkj0RDI3WpGaODxFXoHhUINqMBMBOEYzc6/T
         XGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7dpbDNd97HPa+O8wkl96cUElC6hzW8DlQWxGmTbV+U4=;
        b=jritc3x/iKjTTmlrTeEU1VI6FdZbxE/j2XXN5mTLvm8/OGem7lDVXaAzPVyvoOkAJf
         th6JXq0RwqPDO6u8IMbL3Vi51y+qc7g/cS+IRE3Nw5OOTCB/UOxYCWGIy0K8jbBKgvoX
         U23kFdNKh/S50YfoHZvSeaUUusNljzMk1fzI+XAtC81yBAeLgoK2kJbhqmdKVpWd70v5
         1hx//itdDr1Lw3ddUQMvJmKbv06j+gu7JVqG1FzrybQsEeScf/3RChf/SrfTyXFnyugU
         iq7kSUHBF3SUmOiAeTgTi9JiS+xxme0+AJwtPmST54mPMvYXPZ+/4C7MrshrddP9vwJk
         zl8w==
X-Gm-Message-State: AOUpUlFTRMlLugUmC3ljxFF9OpHnx3UUy+dvvCdtTnZbOI0lLaWBsvK1
        cZIF+qOLu2ZqJ2x2GiOT1Mw1n/2I
X-Google-Smtp-Source: AA+uWPxOAg93fr1ZW94mME23xEEdZeJc3kibCwQJS1xzCW7AGywjjiOWZXsKIYpTByxq5sE9/nsw6A==
X-Received: by 2002:a2e:1101:: with SMTP id f1-v6mr12464460lje.75.1534176945487;
        Mon, 13 Aug 2018 09:15:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 23/24] apply.c: remove implicit dependency on the_index
Date:   Mon, 13 Aug 2018 18:14:40 +0200
Message-Id: <20180813161441.16824-24-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180813161441.16824-1-pclouds@gmail.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use apply_state->repo->index instead of the_index (in most cases,
unless we need to use a temporary index in some functions). Let the
callers (am and apply) tell us what to use, instead of always assuming
to operate on the_index.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 apply.c | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/apply.c b/apply.c
index 3704850ef2..e485fbc6bc 100644
--- a/apply.c
+++ b/apply.c
@@ -3385,7 +3385,8 @@ static int verify_index_match(struct apply_state *state,
 			return -1;
 		return 0;
 	}
-	return ce_match_stat(ce, st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
+	return ie_match_stat(state->repo->index, ce, st,
+			     CE_MATCH_IGNORE_VALID | CE_MATCH_IGNORE_SKIP_WORKTREE);
 }
 
 #define SUBMODULE_PATCH_WITHOUT_INDEX 1
@@ -3518,14 +3519,14 @@ static int load_current(struct apply_state *state,
 	if (!patch->is_new)
 		BUG("patch to %s is not a creation", patch->old_name);
 
-	pos = cache_name_pos(name, strlen(name));
+	pos = index_name_pos(state->repo->index, name, strlen(name));
 	if (pos < 0)
 		return error(_("%s: does not exist in index"), name);
-	ce = active_cache[pos];
+	ce = state->repo->index->cache[pos];
 	if (lstat(name, &st)) {
 		if (errno != ENOENT)
 			return error_errno("%s", name);
-		if (checkout_target(&the_index, ce, &st))
+		if (checkout_target(state->repo->index, ce, &st))
 			return -1;
 	}
 	if (verify_index_match(state, ce, &st))
@@ -3687,15 +3688,16 @@ static int check_preimage(struct apply_state *state,
 	}
 
 	if (state->check_index && !previous) {
-		int pos = cache_name_pos(old_name, strlen(old_name));
+		int pos = index_name_pos(state->repo->index, old_name,
+					 strlen(old_name));
 		if (pos < 0) {
 			if (patch->is_new < 0)
 				goto is_new;
 			return error(_("%s: does not exist in index"), old_name);
 		}
-		*ce = active_cache[pos];
+		*ce = state->repo->index->cache[pos];
 		if (stat_ret < 0) {
-			if (checkout_target(&the_index, *ce, st))
+			if (checkout_target(state->repo->index, *ce, st))
 				return -1;
 		}
 		if (!state->cached && verify_index_match(state, *ce, st))
@@ -3742,7 +3744,7 @@ static int check_to_create(struct apply_state *state,
 	struct stat nst;
 
 	if (state->check_index &&
-	    cache_name_pos(new_name, strlen(new_name)) >= 0 &&
+	    index_name_pos(state->repo->index, new_name, strlen(new_name)) >= 0 &&
 	    !ok_if_exists)
 		return EXISTS_IN_INDEX;
 	if (state->cached)
@@ -3831,7 +3833,8 @@ static int path_is_beyond_symlink_1(struct apply_state *state, struct strbuf *na
 		if (state->check_index) {
 			struct cache_entry *ce;
 
-			ce = cache_file_exists(name->buf, name->len, ignore_case);
+			ce = index_file_exists(state->repo->index, name->buf,
+					       name->len, ignore_case);
 			if (ce && S_ISLNK(ce->ce_mode))
 				return 1;
 		} else {
@@ -4006,9 +4009,10 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 static int read_apply_cache(struct apply_state *state)
 {
 	if (state->index_file)
-		return read_cache_from(state->index_file);
+		return read_index_from(state->repo->index, state->index_file,
+				       get_git_dir());
 	else
-		return read_cache();
+		return read_index(state->repo->index);
 }
 
 /* This function tries to read the object name from the current index */
@@ -4019,10 +4023,10 @@ static int get_current_oid(struct apply_state *state, const char *path,
 
 	if (read_apply_cache(state) < 0)
 		return -1;
-	pos = cache_name_pos(path, strlen(path));
+	pos = index_name_pos(state->repo->index, path, strlen(path));
 	if (pos < 0)
 		return -1;
-	oidcpy(oid, &active_cache[pos]->oid);
+	oidcpy(oid, &state->repo->index->cache[pos]->oid);
 	return 0;
 }
 
@@ -4250,7 +4254,7 @@ static void patch_stats(struct apply_state *state, struct patch *patch)
 static int remove_file(struct apply_state *state, struct patch *patch, int rmdir_empty)
 {
 	if (state->update_index && !state->ita_only) {
-		if (remove_file_from_cache(patch->old_name) < 0)
+		if (remove_file_from_index(state->repo->index, patch->old_name) < 0)
 			return error(_("unable to remove %s from index"), patch->old_name);
 	}
 	if (!state->cached) {
@@ -4271,7 +4275,7 @@ static int add_index_file(struct apply_state *state,
 	struct cache_entry *ce;
 	int namelen = strlen(path);
 
-	ce = make_empty_cache_entry(&the_index, namelen);
+	ce = make_empty_cache_entry(state->repo->index, namelen);
 	memcpy(ce->name, path, namelen);
 	ce->ce_mode = create_ce_mode(mode);
 	ce->ce_flags = create_ce_flags(0);
@@ -4303,7 +4307,7 @@ static int add_index_file(struct apply_state *state,
 				       "for newly created file %s"), path);
 		}
 	}
-	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0) {
+	if (add_index_entry(state->repo->index, ce, ADD_CACHE_OK_TO_ADD) < 0) {
 		discard_cache_entry(ce);
 		return error(_("unable to add cache entry for %s"), path);
 	}
@@ -4341,7 +4345,7 @@ static int try_create_file(struct apply_state *state, const char *path,
 	if (fd < 0)
 		return 1;
 
-	if (convert_to_working_tree(&the_index, path, buf, size, &nbuf)) {
+	if (convert_to_working_tree(state->repo->index, path, buf, size, &nbuf)) {
 		size = nbuf.len;
 		buf  = nbuf.buf;
 	}
@@ -4438,17 +4442,17 @@ static int add_conflicted_stages_file(struct apply_state *state,
 	namelen = strlen(patch->new_name);
 	mode = patch->new_mode ? patch->new_mode : (S_IFREG | 0644);
 
-	remove_file_from_cache(patch->new_name);
+	remove_file_from_index(state->repo->index, patch->new_name);
 	for (stage = 1; stage < 4; stage++) {
 		if (is_null_oid(&patch->threeway_stage[stage - 1]))
 			continue;
-		ce = make_empty_cache_entry(&the_index, namelen);
+		ce = make_empty_cache_entry(state->repo->index, namelen);
 		memcpy(ce->name, patch->new_name, namelen);
 		ce->ce_mode = create_ce_mode(mode);
 		ce->ce_flags = create_ce_flags(stage);
 		ce->ce_namelen = namelen;
 		oidcpy(&ce->oid, &patch->threeway_stage[stage - 1]);
-		if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0) {
+		if (add_index_entry(state->repo->index, ce, ADD_CACHE_OK_TO_ADD) < 0) {
 			discard_cache_entry(ce);
 			return error(_("unable to add cache entry for %s"),
 				     patch->new_name);
@@ -4897,7 +4901,7 @@ int apply_all_patches(struct apply_state *state,
 	}
 
 	if (state->update_index) {
-		res = write_locked_index(&the_index, &state->lock_file, COMMIT_LOCK);
+		res = write_locked_index(state->repo->index, &state->lock_file, COMMIT_LOCK);
 		if (res) {
 			error(_("Unable to write new index file"));
 			res = -128;
-- 
2.18.0.1004.g6639190530

