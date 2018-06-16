Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D27AB1F403
	for <e@80x24.org>; Sat, 16 Jun 2018 05:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932368AbeFPFmU (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 01:42:20 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:38240 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932284AbeFPFmR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 01:42:17 -0400
Received: by mail-lf0-f52.google.com with SMTP id i83-v6so17517981lfh.5
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 22:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CBXMFiCEBL6Fzxwzmi+YPUWxOvQAwjB2az75ZPfXfdQ=;
        b=scviwQbIIXm4PorocpbM1UBJSOe/tYoFztyqpNuyRSmh40PAxdx3tb4QErSmjF6sLl
         xb98gX0PwR6RZ/F72m+Wd2PoZNtfWF3x56ra4kE67rM4rw8DIK6sees7Ij+ILeqnzxLA
         4ovKQh0dHs0KQ6pmAe7YHEbMxgkFMh0XRMb5OYLMkNjWMDrWBKbD7Ebkl2sPjEk804OG
         nKfihhQFVuQi0Aykf/rArWndQAy0JxXo/1DBHYJgt+zXe58H9gpE2VQrhtYUZaQoamyv
         sA/3zifCOLnYsZMFVOyliS4XMjdOrfxP6CoGkuOuxaI3fdpNA0SRBjCMsV3+votMHBj6
         2Gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CBXMFiCEBL6Fzxwzmi+YPUWxOvQAwjB2az75ZPfXfdQ=;
        b=FkpsfX8MCL+ynPPJuk67pcUxeoPakSVuP9mh8DgCM0Anfd5eRT4snlHfXJ/OsdEoR9
         c1QbBrOU3mpTi7XC8aVC3dEHpLXb+GLQbDJp2B5tEv9vD1kPqhk1TZaTiSORggZa2OuV
         9uZAOytVZyrYyLHkRilmg2y6S7c2RqV5Tw0W5yezchocQ5qhEnfsBXnpSrVFC+xci1cA
         3kI7dogc2swENO9DLqtuCSSpoNsjkci7KfDBix/m0NnfiCQTEzkcGhoX4V5f/yXuU8vO
         kaDsL3K/Ra/wx+PilKc49FGSB65yByQq7i8VFAwngXKwfumNr+ecYsS8xEIjL3byu5nc
         zeuw==
X-Gm-Message-State: APt69E24M9v4jkVSbzr2YKkHfZj5de3TnYQTvUdEYWFbYP9j7AtAVCXN
        J1DS84MPkXAHmmGrEAYSftUN0w==
X-Google-Smtp-Source: ADUXVKLFByPhW/gOKP2IlMncAU92EcqFrl5xWk8I8mtLajyWF8T6OpGbx7z6Hz7UEjDAvEpKilMn6g==
X-Received: by 2002:a19:d86a:: with SMTP id p103-v6mr2895735lfg.36.1529127735486;
        Fri, 15 Jun 2018 22:42:15 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g5-v6sm1745194lje.21.2018.06.15.22.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 22:42:14 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/15] wt-status.c: stop using index compat macros
Date:   Sat, 16 Jun 2018 07:41:56 +0200
Message-Id: <20180616054157.32433-15-pclouds@gmail.com>
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
 wt-status.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index d1c05145a4..9859a43ec8 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -499,14 +499,14 @@ static int unmerged_mask(const char *path)
 	int pos, mask;
 	const struct cache_entry *ce;
 
-	pos = cache_name_pos(path, strlen(path));
+	pos = index_name_pos(&the_index, path, strlen(path));
 	if (0 <= pos)
 		return 0;
 
 	mask = 0;
 	pos = -pos-1;
-	while (pos < active_nr) {
-		ce = active_cache[pos++];
+	while (pos < the_index.cache_nr) {
+		ce = the_index.cache[pos++];
 		if (strcmp(ce->name, path) || !ce_stage(ce))
 			break;
 		mask |= (1 << (ce_stage(ce) - 1));
@@ -642,10 +642,10 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 {
 	int i;
 
-	for (i = 0; i < active_nr; i++) {
+	for (i = 0; i < the_index.cache_nr; i++) {
 		struct string_list_item *it;
 		struct wt_status_change_data *d;
-		const struct cache_entry *ce = active_cache[i];
+		const struct cache_entry *ce = the_index.cache[i];
 
 		if (!ce_path_match(ce, &s->pathspec, NULL))
 			continue;
@@ -702,7 +702,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
-		if (cache_name_is_other(ent->name, ent->len) &&
+		if (index_name_is_other(&the_index, ent->name, ent->len) &&
 		    dir_path_match(ent, &s->pathspec, 0, NULL))
 			string_list_insert(&s->untracked, ent->name);
 		free(ent);
@@ -710,7 +710,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 
 	for (i = 0; i < dir.ignored_nr; i++) {
 		struct dir_entry *ent = dir.ignored[i];
-		if (cache_name_is_other(ent->name, ent->len) &&
+		if (index_name_is_other(&the_index, ent->name, ent->len) &&
 		    dir_path_match(ent, &s->pathspec, 0, NULL))
 			string_list_insert(&s->ignored, ent->name);
 		free(ent);
@@ -2180,11 +2180,11 @@ static void wt_porcelain_v2_print_unmerged_entry(
 	 */
 	memset(stages, 0, sizeof(stages));
 	sum = 0;
-	pos = cache_name_pos(it->string, strlen(it->string));
+	pos = index_name_pos(&the_index, it->string, strlen(it->string));
 	assert(pos < 0);
 	pos = -pos-1;
-	while (pos < active_nr) {
-		ce = active_cache[pos++];
+	while (pos < the_index.cache_nr) {
+		ce = the_index.cache[pos++];
 		stage = ce_stage(ce);
 		if (strcmp(ce->name, it->string) || !stage)
 			break;
@@ -2333,7 +2333,7 @@ int has_uncommitted_changes(int ignore_submodules)
 	struct rev_info rev_info;
 	int result;
 
-	if (is_cache_unborn())
+	if (is_index_unborn(&the_index))
 		return 0;
 
 	init_revisions(&rev_info, NULL);
@@ -2356,7 +2356,7 @@ int require_clean_work_tree(const char *action, const char *hint, int ignore_sub
 	int err = 0, fd;
 
 	fd = hold_locked_index(&lock_file, 0);
-	refresh_cache(REFRESH_QUIET);
+	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
 	if (0 <= fd)
 		update_index_if_able(&the_index, &lock_file);
 	rollback_lock_file(&lock_file);
-- 
2.18.0.rc0.333.g22e6ee6cdf

