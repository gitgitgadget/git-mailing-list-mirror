Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409ACC0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 15:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjHAPXq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 11:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjHAPXo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 11:23:44 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1BE2133
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 08:23:38 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe2bc2701bso5045305e9.2
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 08:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690903416; x=1691508216;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2dHNxdeYNlXbs3XDttxVk6u7DRpgrC7B383DHwPTBw=;
        b=reZga2AqcK2uydsKjwpxcnUpWBFugoeIB2qANEkNiiW4LdGtOeXLWO+x+leSG3KUve
         7g9uYpKFe6BXXUzvYeBY2zLtu4yFW+7USYCpo9BRE2ate/NQ02CEli/IgdP0QdGmxWGB
         hpqYK8Np/+AXBkWUQLWwuH6o+n1v5A+zazrrZ+wzIuZcLPbIyPMyVIkJ2OxxBqe8QHr/
         71aqKwrpY/IeGJ5r/nu88tcovMSGiKt89/zZfDcWIG++bOCGxuHIcHUieD1UBaZXWveU
         uDeLtE190rLj9cRF97klEyNxu5PD7vPErEoxB7QWSbK0+BNrRcxPQ8dEHcjxf9u5XQ94
         iOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690903416; x=1691508216;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2dHNxdeYNlXbs3XDttxVk6u7DRpgrC7B383DHwPTBw=;
        b=FZVMLCIqWvlHmyAE4m7Pv4c3N8fKHhScPMxCD29fWzrLVZvBnHu2aeElWK5k4bFF+7
         lZmSqb+GLjliV5U3vF5nz1XTYcmp5v3Kn6pV2jZSCWgrpiLAP8+CdQ5oN/7UcudKisxq
         cmXy0izdLaIMfr/n3i2Rti4Rx7Xwjkut18qnZEmNLgx+8kFW+Z8kLjFi00oth2vjTcoV
         MfEcNfrmDk4t1IN+4dwo4gnfXHgoHMVHAG57ZjYFe71FZbH6sZ4paHq1rahDvRchby0v
         rMdlJSjxddS8h0+rq6tLHuWKI4k5vxfRuGQzopztP3HK1ICP2fsAg0Mz68ixf4sqBzmQ
         904w==
X-Gm-Message-State: ABy/qLbkyLpMlYwnOLY7sEhrnSz6AlnCKXzixRQNlHNxOd34HOCmkz2M
        pmeqUqnptRFyyPjuMYwuehOwtw6vi3I=
X-Google-Smtp-Source: APBJJlERRCABJ04GNl2HKYSQN93ma66gsGuED2UwiQVqFSyh8t/y6kzriYgRS8XiU6rTogVNBsuaIA==
X-Received: by 2002:a1c:7c03:0:b0:3fe:2140:f504 with SMTP id x3-20020a1c7c03000000b003fe2140f504mr2662422wmc.20.1690903416170;
        Tue, 01 Aug 2023 08:23:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c22c300b003fe13c3ece7sm10201827wmg.10.2023.08.01.08.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 08:23:35 -0700 (PDT)
Message-ID: <e2a758eb4a5df0fab189b3dd235a1651a0c10342.1690903412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
        <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Aug 2023 15:23:27 +0000
Subject: [PATCH v3 2/7] rebase -i: remove patch file after conflict resolution
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When a rebase stops for the user to resolve conflicts it writes a patch
for the conflicting commit to .git/rebase-merge/patch. This file has
been written since the introduction of "git-rebase-interactive.sh" in
1b1dce4bae7 (Teach rebase an interactive mode, 2007-06-25). I assume the
idea was to enable the user inspect the conflicting commit in the same
way as they could for the patch based rebase. This file should be
deleted when the rebase continues as if the rebase stops for a failed
"exec" command or a "break" command it is confusing to the user if there
is a stale patch lying around from an unrelated command. As the path is
now used in two different places rebase_path_patch() is added and used
to obtain the path for the patch.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                | 13 +++++++++----
 t/t3418-rebase-continue.sh | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index de66bda9d5b..70b0a7023b0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -138,6 +138,11 @@ static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
  * the commit object name of the corresponding patch.
  */
 static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
+/*
+ * When we stop for the user to resolve conflicts this file contains
+ * the patch of the commit that is being picked.
+ */
+static GIT_PATH_FUNC(rebase_path_patch, "rebase-merge/patch")
 /*
  * For the post-rewrite hook, we make a list of rewritten commits and
  * their new sha1s.  The rewritten-pending list keeps the sha1s of
@@ -3507,7 +3512,6 @@ static int make_patch(struct repository *r,
 		return -1;
 	res |= write_rebase_head(&commit->object.oid);
 
-	strbuf_addf(&buf, "%s/patch", get_dir(opts));
 	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
 	repo_init_revisions(r, &log_tree_opt, NULL);
 	log_tree_opt.abbrev = 0;
@@ -3515,15 +3519,15 @@ static int make_patch(struct repository *r,
 	log_tree_opt.diffopt.output_format = DIFF_FORMAT_PATCH;
 	log_tree_opt.disable_stdin = 1;
 	log_tree_opt.no_commit_id = 1;
-	log_tree_opt.diffopt.file = fopen(buf.buf, "w");
+	log_tree_opt.diffopt.file = fopen(rebase_path_patch(), "w");
 	log_tree_opt.diffopt.use_color = GIT_COLOR_NEVER;
 	if (!log_tree_opt.diffopt.file)
-		res |= error_errno(_("could not open '%s'"), buf.buf);
+		res |= error_errno(_("could not open '%s'"),
+				   rebase_path_patch());
 	else {
 		res |= log_tree_commit(&log_tree_opt, commit);
 		fclose(log_tree_opt.diffopt.file);
 	}
-	strbuf_reset(&buf);
 
 	strbuf_addf(&buf, "%s/message", get_dir(opts));
 	if (!file_exists(buf.buf)) {
@@ -4659,6 +4663,7 @@ static int pick_commits(struct repository *r,
 	unlink(rebase_path_message());
 	unlink(rebase_path_stopped_sha());
 	unlink(rebase_path_amend());
+	unlink(rebase_path_patch());
 
 	while (todo_list->current < todo_list->nr) {
 		struct todo_item *item = todo_list->items + todo_list->current;
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 2d0789e554b..261e7cd754c 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -244,6 +244,24 @@ test_expect_success 'the todo command "break" works' '
 	test_path_is_file execed
 '
 
+test_expect_success 'patch file is removed before break command' '
+	test_when_finished "git rebase --abort" &&
+	cat >todo <<-\EOF &&
+	pick commit-new-file-F2-on-topic-branch
+	break
+	EOF
+
+	(
+		set_replace_editor todo &&
+		test_must_fail git rebase -i --onto commit-new-file-F2 HEAD
+	) &&
+	test_path_is_file .git/rebase-merge/patch &&
+	echo 22>F2 &&
+	git add F2 &&
+	git rebase --continue &&
+	test_path_is_missing .git/rebase-merge/patch
+'
+
 test_expect_success '--reschedule-failed-exec' '
 	test_when_finished "git rebase --abort" &&
 	test_must_fail git rebase -x false --reschedule-failed-exec HEAD^ &&
-- 
gitgitgadget

