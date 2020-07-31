Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52B5C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 16:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B65206D8
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 16:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grwcUo2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbgGaQwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733184AbgGaQwO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 12:52:14 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB250C061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 09:52:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f1so28041352wro.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 09:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UUA0POsVVJ22ojoGFsyScNlZG8/SiQ8wYyZG/EocrrU=;
        b=grwcUo2PlerU5iQobSJUdrV/3QezcSUPWQ1go85eAWDamctKphNxzaiqNDscN6ewFg
         HOLvaFFhERK4V1a9QoNl5ISMZOHBSMb/1v7JsKPU05gS8iL9IiObyKhZ5ESdaa+fDhsn
         /g9RnqoNt6izFH2ODgLKRZdyRfpjNDyDO+rlGrsY5w57FZnhsCTwNdrhmt1d3exbwxro
         eBQLAe+2T+FBuixSmr/B8Iqi002OSR6WtUtUetwSndW8sjrzsogOdCMrt55ti3wRBByp
         tD2yZCnGIXBgQ8f1n46oR0fh+7dbndM4QqUkHVvLZODMppod5iNHrjgNFx9bZCwthBh6
         aeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUA0POsVVJ22ojoGFsyScNlZG8/SiQ8wYyZG/EocrrU=;
        b=KiV3BulMYxEdmOlSxh1VNqEo1a7G0IY3i52SzRE6W8ihoKTiQml1IVgD1nhyRlLLqk
         oxLRGQWHbo015znqBTYUi9OVWUm4GA4GB6CIECZdyWuFYXzWRquq0mOxP4iChBkRwHbv
         Fxkz97wUUgu2e9vkcg4aEEV+8SClcFkTRaBGoQftMgLFKsPWSbv9Yf0xuQJiZz8bgODh
         KqPL7flIaBZH5e6RQe0MXWq2tLUVqerSlIB4cv/b0OZi1GXjw1HRRqITU08+03iaKahw
         rHL68+6RbSGM7hPEe7nn5Sv1bbiJd9jWEW39hHcC4h7KPV/j00TWskS74Sp59FsKPRaO
         YHmg==
X-Gm-Message-State: AOAM531QMPV0gw/fa4w1D9eJPKKjIP/tDeUoybYQSzQqYMVu/S2mqAYB
        MPJ8+6y3IOzhYbgRvobzOJfFbfss
X-Google-Smtp-Source: ABdhPJwlojeq3hGY8KB3nglbK5xzJgZTpC6zDi81UFpolGsSVKKbaX+Njnn1RAqdp/k2c+1aS27ynQ==
X-Received: by 2002:a5d:6aca:: with SMTP id u10mr2605858wrw.365.1596214332135;
        Fri, 31 Jul 2020 09:52:12 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-421-163.w2-6.abo.wanadoo.fr. [2.6.84.163])
        by smtp.googlemail.com with ESMTPSA id t14sm15169134wrg.38.2020.07.31.09.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:52:11 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 3/6] stash: remove the second index in stash_patch()
Date:   Fri, 31 Jul 2020 18:51:37 +0200
Message-Id: <20200731165140.29197-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200731165140.29197-1-alban.gruin@gmail.com>
References: <20200630151558.20975-1-alban.gruin@gmail.com>
 <20200731165140.29197-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This removes the second index used in stash_patch().

This function starts by resetting the index (which is set at `i_tree')
to HEAD, which has been stored in `b_commit' by do_create_stash(), and
the call to `read-tree' is replaced by reset_tree().  The index is
discarded after run_add_interactive(), but not `diff-tree' as this
command should not change it.

Since the index has been changed, and subsequent code might be sensitive
to this, it is reset to `i_tree' at the end of the function.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/stash.c | 47 ++++++++++-------------------------------------
 1 file changed, 10 insertions(+), 37 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 2535335275..eaeb7bc8c4 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -995,51 +995,24 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 		       struct strbuf *out_patch, int quiet)
 {
 	int ret = 0;
-	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
 	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
-	struct index_state istate = { NULL };
-	char *old_index_env = NULL, *old_repo_index_file;
 
-	remove_path(stash_index_path.buf);
-
-	cp_read_tree.git_cmd = 1;
-	argv_array_pushl(&cp_read_tree.args, "read-tree", "HEAD", NULL);
-	argv_array_pushf(&cp_read_tree.env_array, "GIT_INDEX_FILE=%s",
-			 stash_index_path.buf);
-	if (run_command(&cp_read_tree)) {
-		ret = -1;
-		goto done;
-	}
+	if (reset_tree(&info->b_commit, 0, 1))
+		return -1;
 
 	/* Find out what the user wants. */
-	old_repo_index_file = the_repository->index_file;
-	the_repository->index_file = stash_index_path.buf;
-	old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
-	setenv(INDEX_ENVIRONMENT, the_repository->index_file, 1);
-
 	ret = run_add_interactive(NULL, "--patch=stash", ps);
 
-	the_repository->index_file = old_repo_index_file;
-	if (old_index_env && *old_index_env)
-		setenv(INDEX_ENVIRONMENT, old_index_env, 1);
-	else
-		unsetenv(INDEX_ENVIRONMENT);
-	FREE_AND_NULL(old_index_env);
-
 	/* State of the working tree. */
-	if (write_index_as_tree(&info->w_tree, &istate, stash_index_path.buf, 0,
-				NULL)) {
-		ret = -1;
-		goto done;
-	}
+	discard_cache();
+	if (write_cache_as_tree(&info->w_tree, 0, NULL))
+		return -1;
 
 	cp_diff_tree.git_cmd = 1;
 	argv_array_pushl(&cp_diff_tree.args, "diff-tree", "-p", "-U1", "HEAD",
 			 oid_to_hex(&info->w_tree), "--", NULL);
-	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
-		ret = -1;
-		goto done;
-	}
+	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0))
+		return -1;
 
 	if (!out_patch->len) {
 		if (!quiet)
@@ -1047,9 +1020,9 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 		ret = 1;
 	}
 
-done:
-	discard_index(&istate);
-	remove_path(stash_index_path.buf);
+	if (reset_tree(&info->i_tree, 0, 1))
+		return -1;
+
 	return ret;
 }
 
-- 
2.20.1

