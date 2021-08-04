Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79001C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 20:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BEA661040
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 20:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbhHDUyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 16:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbhHDUyB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 16:54:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BC0C061799
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 13:53:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q3-20020a25bfc30000b02905592911c932so4157252ybm.15
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 13:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=t6vY3P2Qx4mXnfsT0b+WpkPovb2REJLiw1rNNBmg2xs=;
        b=PW83vcuYNJ5M4ERiuzyhNhCEeC9bfiIUEDecG+HOcgz+1ui0pPvCN5IZFvc61BJBIQ
         4IKRD6H6ysG2VgPn+1Qn0HugPPkuAHlOk7Yt9tFxWqlAmyJUPNR4fhmtPeJrh5nwWPvy
         76tpDxldiPNKsxF9iZBbWBK/F95ZPaJDdORqMOeKMn65lQfTVS7aofZaeleUK9O6uDV3
         KCW61j3VcuDP2RTuLGJUdtVe5+zu3yYh1Th38O4yqzBYO/eNShMN/KaTV31RO9P2D6VY
         vkpvlONgrc6J5ghr0wbl+CGnapEV0AC/tsAmCAMfxAjoUrfCxmQBQY7KGL8GmyfTAiBd
         4vLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=t6vY3P2Qx4mXnfsT0b+WpkPovb2REJLiw1rNNBmg2xs=;
        b=ojgwjQU+eeq7SQU6uPj6hvlG1oXPx5gD1fhe63uRnXsjDWx7sSlGosX7J47hH6ZRgJ
         IWYvSqc0hD8MGiAKS+SEAdP4N2XbvFRMwRbcAgQocgDFMzJKM3dkLjL0eOG0P9cQ4/43
         wybAXUcCI2J4j8iyCQtpY0ViXU7hmxL70dlzeYxWp7IcgFNBZ27QFW95iWFsB78wee6Q
         hq9tLb5NEV++exFTI9ZN3ajK/nJEqpByIIgFUSxWrg3rz5pc1GY5c1mS/KQfPgtNL2ig
         o1l8/7stMPM4Us/zFWKw7vwGkrsfHnBCs6hV0IbPtMwHLNeNyDiIh7jXcKzSttsJWQBU
         1PXg==
X-Gm-Message-State: AOAM531UbsSUwHWS3linen18q6XhLX6SJOiMb43E9s6kWyyK9TmeXKYr
        JY0+nJYyLjKeJ5GNaL8L7/4+WK+XvyZ30DuMBm4DFmxO98xW0gNFDHof3AlwCZj79KD8eyRGq6B
        Hm+bSd0sCuvYiv4OFnEFCKPLXb6rzqtbEAcKDQx9iZuC8XTeOw4FtWrj1eeSuDGQ=
X-Google-Smtp-Source: ABdhPJzsf5YfENaLXmo0bvRcUbMmSuhoNVGTTq1AMJ06A1oYGynXmIMvkr1QD7ODjBf2DekD5JfkUcMjvpHeUQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:9758:1083:3c28:c541])
 (user=steadmon job=sendgmr) by 2002:a25:3046:: with SMTP id
 w67mr1761332ybw.134.1628110427047; Wed, 04 Aug 2021 13:53:47 -0700 (PDT)
Date:   Wed,  4 Aug 2021 13:53:45 -0700
Message-Id: <4d83766ab3425a5f4b361df2ac505d07fefd7899.1628109852.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [RFC PATCH] sequencer: warn on skipping previously seen commit
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Silently skipping commits when rebasing with --no-reapply-cherry-picks
(currently the default behavior) can cause user confusion. Issue a
warning in this case so that users are aware of what's happening.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---

We've had some complaints at $JOB where users were confused when
rebasing branches that contained commits that were previously
cherry-picked into their master branch. How do folks feel about adding a
warning in this case?

 sequencer.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7f07cd00f3..8888031c7b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5099,6 +5099,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
 	int rebase_cousins = flags & TODO_LIST_REBASE_COUSINS;
 	int root_with_onto = flags & TODO_LIST_ROOT_WITH_ONTO;
+	int skipped_commit = 0;
 	struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
 	struct strbuf label = STRBUF_INIT;
 	struct commit_list *commits = NULL, **tail = &commits, *iter;
@@ -5149,8 +5150,12 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		oidset_insert(&interesting, &commit->object.oid);
 
 		is_empty = is_original_commit_empty(commit);
-		if (!is_empty && (commit->object.flags & PATCHSAME))
+		if (!is_empty && (commit->object.flags & PATCHSAME)) {
+			warning(_("skipped previously seen commit %s"),
+				short_commit_name(commit));
+			skipped_commit = 1;
 			continue;
+		}
 		if (is_empty && !keep_empty)
 			continue;
 
@@ -5214,6 +5219,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		oidcpy(&entry->entry.oid, &commit->object.oid);
 		oidmap_put(&commit2todo, entry);
 	}
+	if (skipped_commit)
+		warning(_("use --reapply-cherry-picks to include skipped commits"));
 
 	/*
 	 * Second phase:
@@ -5334,6 +5341,7 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 	const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
 	int rebase_merges = flags & TODO_LIST_REBASE_MERGES;
 	int reapply_cherry_picks = flags & TODO_LIST_REAPPLY_CHERRY_PICKS;
+	int skipped_commit = 0;
 
 	repo_init_revisions(r, &revs, NULL);
 	revs.verbose_header = 1;
@@ -5369,8 +5377,12 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 	while ((commit = get_revision(&revs))) {
 		int is_empty = is_original_commit_empty(commit);
 
-		if (!is_empty && (commit->object.flags & PATCHSAME))
+		if (!is_empty && (commit->object.flags & PATCHSAME)) {
+			warning(_("skipped previously seen commit %s"),
+				short_commit_name(commit));
+			skipped_commit = 1;
 			continue;
+		}
 		if (is_empty && !keep_empty)
 			continue;
 		strbuf_addf(out, "%s %s ", insn,
@@ -5380,6 +5392,8 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 			strbuf_addf(out, " %c empty", comment_line_char);
 		strbuf_addch(out, '\n');
 	}
+	if (skipped_commit)
+		warning(_("use --reapply-cherry-picks to include skipped commits"));
 	return 0;
 }
 
-- 
2.32.0.554.ge1b32706d8-goog

