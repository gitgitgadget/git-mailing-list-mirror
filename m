Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A9671F453
	for <e@80x24.org>; Fri, 19 Oct 2018 14:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeJSW7O (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 18:59:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34778 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJSW7O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 18:59:14 -0400
Received: by mail-lf1-f66.google.com with SMTP id n26-v6so6772024lfl.1
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RonBt4Cqb/kDe3nboghyGp87QDXg8lcdE88q2Wn0BGc=;
        b=F/iknlSa06I46fDUnKbZAIYJHetlcdA1LBgMYgauTrig7V6KLQbS+mTdnABQdn1M66
         UzHaQJFRYkDUcbzLbAYsCRZX50ZAbaVHPggwpqtPA+KIIH9Y/LI8fFuQQx18F7p/sL+u
         EL3Nu6S/pTIZn5AR1jrBXV1Ybi2l0hB3+BwqeZrnXG7+PUEsuXAV3VhLnXTh9KNpoBZv
         6EebFkN3w31+476cIXStu1udBxVstylY2SJ+wh3iNwDrygMtSJxFHrnYfPwyljzW2bIv
         LbSoJPDMs4eWYJ1stKi7B4K3QjDo/tawT3Uk+qg01wzEEE4s65Dr1vAOvvl+3AedVHV5
         fjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RonBt4Cqb/kDe3nboghyGp87QDXg8lcdE88q2Wn0BGc=;
        b=GWJUyS9gt3fLjYjF2sSehOzm/PkbFLjTGwUQT3cU3QJDqvyVgO56loWDBZ3QsNRavj
         qRT2TIy1LUQDmIdsCchiFdYGsnUpmYhuGvA+EwabHNiW09WHZMfePxvOYrcxtXYZeopU
         rnM00rE2zLwYGQ/SOMUcD586P1HraD4WwDhoVzVy7BwmPGUzKaONo3P0BMpqA8CmT1Lw
         BQ8j9M3/V9ldl24pEsXfjmHomxjKCykz81wDoVa+/YIGCdHvND7y1CsP7vjH4Se9D7Dg
         QOCmMWgcqFCaQXkAi9QKfJGihvhRCXN0F9HRFtW16dYen8lTKlTe9PnrRefVUd2ZqxF+
         n+hw==
X-Gm-Message-State: ABuFfoi0yIM0yqspFY2fD/6lky5wwoJ/VAM+9+ytSZt1eXItzAlRkJ2L
        JAb5HJB71tWZDaB9AuqJVeC5QQnx
X-Google-Smtp-Source: ACcGV62jV2PIYThJ12dX/Z1BRhXlAfWq4xkyNVZEHqDb9/0guVjvKiRQiH/ogvhHbXizfpZao92+bg==
X-Received: by 2002:a19:2a4b:: with SMTP id f72mr1610536lfl.139.1539960764173;
        Fri, 19 Oct 2018 07:52:44 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g64-v6sm4002414lfe.87.2018.10.19.07.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 07:52:43 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/19] wt-status.c: remove implicit dependency the_repository
Date:   Fri, 19 Oct 2018 16:52:20 +0200
Message-Id: <20181019145237.16079-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181019145237.16079-1-pclouds@gmail.com>
References: <20181019145237.16079-1-pclouds@gmail.com>
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
index 2a05619211..d6d3923eb2 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1412,7 +1412,7 @@ char *get_head_description(void)
 	struct strbuf desc = STRBUF_INIT;
 	struct wt_status_state state;
 	memset(&state, 0, sizeof(state));
-	wt_status_get_state(&state, 1);
+	wt_status_get_state(the_repository, &state, 1);
 	if (state.rebase_in_progress ||
 	    state.rebase_interactive_in_progress) {
 		if (state.branch)
diff --git a/wt-status.c b/wt-status.c
index 0378bc2a48..3632276236 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -756,7 +756,7 @@ void wt_status_collect(struct wt_status *s)
 		wt_status_collect_changes_index(s);
 	wt_status_collect_untracked(s);
 
-	wt_status_get_state(&s->state, s->branch && !strcmp(s->branch, "HEAD"));
+	wt_status_get_state(s->repo, &s->state, s->branch && !strcmp(s->branch, "HEAD"));
 	if (s->state.merge_in_progress && !has_unmerged(s))
 		s->committable = 1;
 }
@@ -1483,7 +1483,8 @@ static int grab_1st_switch(struct object_id *ooid, struct object_id *noid,
 	return 1;
 }
 
-static void wt_status_get_detached_from(struct wt_status_state *state)
+static void wt_status_get_detached_from(struct repository *r,
+					struct wt_status_state *state)
 {
 	struct grab_1st_switch_cbdata cb;
 	struct commit *commit;
@@ -1500,7 +1501,7 @@ static void wt_status_get_detached_from(struct wt_status_state *state)
 	    /* sha1 is a commit? match without further lookup */
 	    (oideq(&cb.noid, &oid) ||
 	     /* perhaps sha1 is a tag, try to dereference to a commit */
-	     ((commit = lookup_commit_reference_gently(the_repository, &oid, 1)) != NULL &&
+	     ((commit = lookup_commit_reference_gently(r, &oid, 1)) != NULL &&
 	      oideq(&cb.noid, &commit->object.oid)))) {
 		const char *from = ref;
 		if (!skip_prefix(from, "refs/tags/", &from))
@@ -1557,30 +1558,31 @@ int wt_status_check_bisect(const struct worktree *wt,
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
index 84653595e3..9dde7091f6 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -134,7 +134,9 @@ void wt_status_prepare(struct wt_status *s, struct repository *repo);
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
2.19.1.647.g708186aaf9

