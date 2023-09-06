Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1A6EE14A5
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 15:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242534AbjIFPXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 11:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242517AbjIFPXC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 11:23:02 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06900173D
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 08:22:58 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4018af103bcso7540455e9.1
        for <git@vger.kernel.org>; Wed, 06 Sep 2023 08:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694013776; x=1694618576; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3pGS1eGtJAgJD9MdPr3soUbnoVHR3IJEaWtzaYwrb8=;
        b=m+dY2zPGC3HEefCOtG18ad67frb37GxA5x/1aMBYnWXBGC6qLit3BZN2FQvuCy0/3a
         78OOAroU2t3DymKRT8EvXhZzSrwLpgMWe9L+/wVcOhXfTTIMHtCbrWEFahWrzrc1HyVK
         OZo49ImQmKJUDY4A2FTWaeEgbVVXJSsd85yTj790JFRvHkFNkbnrBZNdumt1mM87xh8X
         v93iIT8s+n2F0WrCiXHkmnExOoSEJja1cDQwCt2trfNCS6qwt5YOnev7fKUVRPXDGQab
         PIe7OxBu/VHI1SYpwr4OmgntUrkd5AkzIn1Ao/sS3/OMp9MwQ5+xzwigLIpP1w7HxNGL
         IWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694013776; x=1694618576;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3pGS1eGtJAgJD9MdPr3soUbnoVHR3IJEaWtzaYwrb8=;
        b=NqhUg+7j1jzvYWA0uAfo3bBtwoGycLqAVegxxWfc3P8PqCMApH+DoPxdlGgy1dTw+c
         jF1x9SBQmHy6LTpYiUQXYi2uslbf1x2ntGMvY64+61XlB5ef9h/MEijQTCv/xVBKNvAt
         dUW/3COJA+RxupujOq7M62RboiBJOQOiheeBqnjaDcblkbtWdGLcQuh3CgqdEtBJuIBV
         7SsRdgrGyL9tpWGXK8piAFyGWbwP9EQL/BvScG7o91NtoaMDj13oeA4WIlDOekVQSToN
         vCQxQTzoNQ0SgCmZTzlTLldZ3v/MwvuKNYuzF3vJk45HQvbTkbGnmy1qoJX8kiJebw2n
         R5Jw==
X-Gm-Message-State: AOJu0YxPQpRYy5wErgOOrtTECbzIvHvfp/ZOVm7FG/XT5raoSsl9lzPO
        F/JvGpjHCE6XrwYSQdSXqfAahbkGYGg=
X-Google-Smtp-Source: AGHT+IFL4rpgUqj+1x1NIZMWQiGh1mkg3QxScK72KrQafwwXm6bcte78BFdWBt4dlQ13l//0qwoZQw==
X-Received: by 2002:a05:600c:5247:b0:3fe:f4b0:634a with SMTP id fc7-20020a05600c524700b003fef4b0634amr2831019wmb.19.1694013775917;
        Wed, 06 Sep 2023 08:22:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e2-20020a05600c218200b003fef5402d2dsm23403338wme.8.2023.09.06.08.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 08:22:55 -0700 (PDT)
Message-ID: <f540ed1d6076640f131ef302f7ca66a9cdba40d3.1694013772.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1492.v4.git.1694013771.gitgitgadget@gmail.com>
References: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
        <pull.1492.v4.git.1694013771.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Sep 2023 15:22:46 +0000
Subject: [PATCH v4 2/7] rebase -i: remove patch file after conflict resolution
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

To construct the path write_patch() previously used get_dir() which
returns different paths depending on whether we're rebasing or
cherry-picking/reverting. As this function is only called when
rebasing it is safe to use a hard coded string for the directory
instead. An assertion is added to make sure we don't starting calling
this function when cherry-picking in the future.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                | 16 ++++++++++++----
 t/t3418-rebase-continue.sh | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index de66bda9d5b..c1911b0fc14 100644
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
@@ -3502,12 +3507,14 @@ static int make_patch(struct repository *r,
 	char hex[GIT_MAX_HEXSZ + 1];
 	int res = 0;
 
+	if (!is_rebase_i(opts))
+		BUG("make_patch should only be called when rebasing");
+
 	oid_to_hex_r(hex, &commit->object.oid);
 	if (write_message(hex, strlen(hex), rebase_path_stopped_sha(), 1) < 0)
 		return -1;
 	res |= write_rebase_head(&commit->object.oid);
 
-	strbuf_addf(&buf, "%s/patch", get_dir(opts));
 	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
 	repo_init_revisions(r, &log_tree_opt, NULL);
 	log_tree_opt.abbrev = 0;
@@ -3515,15 +3522,15 @@ static int make_patch(struct repository *r,
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
@@ -4659,6 +4666,7 @@ static int pick_commits(struct repository *r,
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

