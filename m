Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA5881F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbeKJPdp (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:33:45 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41797 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbeKJPdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:33:09 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so2826325lfj.8
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SmNnVQOLU1ncYiVyTuDFVBgarxfg6sFni5/84VW23S0=;
        b=Uu4VxNjSqjfkjFbjwQV8egV+K3MIUsPzHPv0qbqw6/mOSvpoSFLnAzl24xQpc8RjWv
         hdYE7DoLiu5++vPeY/TguznBlRDw4T27G3SrQeh/eGbAna4DeTlYK5aLGsr7bW02nvt0
         cRRbNKmiF0mQItXET3Q2yZehVWd3iSqD5li+zGJDvk4IdayrKecvTRK9sx8j2z6KRDjg
         312L902NlO7TEEFGTStn4HGhnbp2MbwH+EFNNykRBtRvqRKNc5r+U23GrflvBZRsXDXG
         ijvG7cjt4U4Wq4vHeboRJK5FKx4JEe8tcMaYUb6Ur/HUwdU9R1aJAznjNR2PXtbl89D+
         p7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SmNnVQOLU1ncYiVyTuDFVBgarxfg6sFni5/84VW23S0=;
        b=e3hkJ5ZIevbA8FDGMdw9ge25o4bHjesz8yrVZX1MQ40TlCK2qJPhmNImVosbIfQexa
         vR6nxkZFnQL852SvUxlSSdGyf7cXRw1vtwKqsx38U3Qpaue0akBlmbS7F6R2UgoNM01J
         6nU/GA9QoIWNjytbX8pP2zAuKObzDvAUMR2hVyzUQMxBJVtCKhc9hVBZ51oyCHtILjJt
         NQJlXu9ZlyDjHF3CWknfmAZIAOfkfSpSMt49XLLQf8RKwXsF9FvijELHfuXHlWUphXTt
         mjNDowE5NtUHOtx6DnlBMECIKWfdY+WYFBXI3ZTGrNyRmq8vs+ZBH2cplZt8KC6c09qd
         uCvQ==
X-Gm-Message-State: AGRZ1gIUgi918rh1AH7G50J/7QOEuo9ihUT3MdTw01akeaGf7mhLhiPA
        1MqoPdMyCjP+4RxB4ywpwoaKYshR
X-Google-Smtp-Source: AJdET5dfdTdv5WOh3Vw1aFAhS4PwMiifCG33Iv3dCeoKsvxu1LbpYiiFQCnF2e4LwRbl2G0isPQh5Q==
X-Received: by 2002:a19:8c1b:: with SMTP id o27mr6650260lfd.90.1541828961905;
        Fri, 09 Nov 2018 21:49:21 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h3sm144445lfj.25.2018.11.09.21.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:49:21 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 02/22] wt-status.c: remove implicit dependency the_repository
Date:   Sat, 10 Nov 2018 06:48:50 +0100
Message-Id: <20181110054910.10568-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110054910.10568-1-pclouds@gmail.com>
References: <20181110054910.10568-1-pclouds@gmail.com>
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
 wt-status.c  | 18 ++++++++++--------
 wt-status.h  |  4 +++-
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 0c45ed9d94..c4eaf30313 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1413,7 +1413,7 @@ char *get_head_description(void)
 	struct strbuf desc = STRBUF_INIT;
 	struct wt_status_state state;
 	memset(&state, 0, sizeof(state));
-	wt_status_get_state(&state, 1);
+	wt_status_get_state(the_repository, &state, 1);
 	if (state.rebase_in_progress ||
 	    state.rebase_interactive_in_progress) {
 		if (state.branch)
diff --git a/wt-status.c b/wt-status.c
index 6d401b2c24..e582c54238 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -755,7 +755,7 @@ void wt_status_collect(struct wt_status *s)
 		wt_status_collect_changes_index(s);
 	wt_status_collect_untracked(s);
 
-	wt_status_get_state(&s->state, s->branch && !strcmp(s->branch, "HEAD"));
+	wt_status_get_state(s->repo, &s->state, s->branch && !strcmp(s->branch, "HEAD"));
 	if (s->state.merge_in_progress && !has_unmerged(s))
 		s->committable = 1;
 }
@@ -1482,7 +1482,8 @@ static int grab_1st_switch(struct object_id *ooid, struct object_id *noid,
 	return 1;
 }
 
-static void wt_status_get_detached_from(struct wt_status_state *state)
+static void wt_status_get_detached_from(struct repository *r,
+					struct wt_status_state *state)
 {
 	struct grab_1st_switch_cbdata cb;
 	struct commit *commit;
@@ -1499,7 +1500,7 @@ static void wt_status_get_detached_from(struct wt_status_state *state)
 	    /* sha1 is a commit? match without further lookup */
 	    (oideq(&cb.noid, &oid) ||
 	     /* perhaps sha1 is a tag, try to dereference to a commit */
-	     ((commit = lookup_commit_reference_gently(the_repository, &oid, 1)) != NULL &&
+	     ((commit = lookup_commit_reference_gently(r, &oid, 1)) != NULL &&
 	      oideq(&cb.noid, &commit->object.oid)))) {
 		const char *from = ref;
 		if (!skip_prefix(from, "refs/tags/", &from))
@@ -1556,30 +1557,31 @@ int wt_status_check_bisect(const struct worktree *wt,
 	return 0;
 }
 
-void wt_status_get_state(struct wt_status_state *state,
+void wt_status_get_state(struct repository *r,
+			 struct wt_status_state *state,
 			 int get_detached_from)
 {
 	struct stat st;
 	struct object_id oid;
 
-	if (!stat(git_path_merge_head(the_repository), &st)) {
+	if (!stat(git_path_merge_head(r), &st)) {
 		state->merge_in_progress = 1;
 	} else if (wt_status_check_rebase(NULL, state)) {
 		;		/* all set */
-	} else if (!stat(git_path_cherry_pick_head(the_repository), &st) &&
+	} else if (!stat(git_path_cherry_pick_head(r), &st) &&
 			!get_oid("CHERRY_PICK_HEAD", &oid)) {
 		state->cherry_pick_in_progress = 1;
 		oidcpy(&state->cherry_pick_head_oid, &oid);
 	}
 	wt_status_check_bisect(NULL, state);
-	if (!stat(git_path_revert_head(the_repository), &st) &&
+	if (!stat(git_path_revert_head(r), &st) &&
 	    !get_oid("REVERT_HEAD", &oid)) {
 		state->revert_in_progress = 1;
 		oidcpy(&state->revert_head_oid, &oid);
 	}
 
 	if (get_detached_from)
-		wt_status_get_detached_from(state);
+		wt_status_get_detached_from(r, state);
 }
 
 static void wt_longstatus_print_state(struct wt_status *s)
diff --git a/wt-status.h b/wt-status.h
index 8375e816fb..3a95975032 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -134,7 +134,9 @@ void wt_status_prepare(struct repository *r, struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
 void wt_status_collect_free_buffers(struct wt_status *s);
-void wt_status_get_state(struct wt_status_state *state, int get_detached_from);
+void wt_status_get_state(struct repository *repo,
+			 struct wt_status_state *state,
+			 int get_detached_from);
 int wt_status_check_rebase(const struct worktree *wt,
 			   struct wt_status_state *state);
 int wt_status_check_bisect(const struct worktree *wt,
-- 
2.19.1.1231.g84aef82467

