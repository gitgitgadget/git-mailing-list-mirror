Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266F7C47256
	for <git@archiver.kernel.org>; Tue,  5 May 2020 10:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0093120658
	for <git@archiver.kernel.org>; Tue,  5 May 2020 10:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyA34GCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgEEKxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 06:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728762AbgEEKxf (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 06:53:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B12C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 03:53:34 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so1800429wmh.3
        for <git@vger.kernel.org>; Tue, 05 May 2020 03:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8XpY9fXIlhN+Z+9PBUOVMB/cMosT7z9DzR4FqM2yEDY=;
        b=EyA34GCj93Dym0w7ADgh/DEc9qsokjE+jlaTw68BsgQoCTQQZz1pYsm1xX0Q/zjqht
         /1ZgVUaM6inZpiLvH3+hmXEXORw0v0wXa2MPQAqPpKV69NFghcaJeeYrIRCStllm2w0F
         8p0p3VKQZ7L7vNZvls88R2uPHKoPzXMqY6q4Lt6GqpKif0PDKg+mXc3gRl5bW9zHBDqH
         MMTxz8T3DIqCl2BTgjt/oIGPba2Tsf8rXR3zJMGx+W98B/52dhGNPSg1WIARG83dWB3X
         SpPzHX/J4T86JJaR5jF9x47FKwD602QqZTODyj9tIIGQZV4meMJ5HYVTYgwN0RvgEUW2
         T6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8XpY9fXIlhN+Z+9PBUOVMB/cMosT7z9DzR4FqM2yEDY=;
        b=NGPgwc7hUicpxHFVjrByBs2zI0B4bdFqCe/6w4bT2O0okF5EtVrf6qFk+NnMF7tpSJ
         O9yFYMmLl6/PRrRlOFjd+LWp/Fds5Kej28aGQMUBsTaipf3LjHd8/w+iIloYPHCDqDo3
         KKrChgibXujS5aunEEyIEklF774onIq6wtjAVnhDMVo58NAYDxx9piXirD4grSbPMxSx
         26YRJmy/owh2bBGEBXzG49C0AzfDPjXW6L9/lkbs+PVMI6/lThRqS6ajs9eN7gtXBseK
         AkzSLbCNQ7VYeHRezgz8eyALixmxKQBSgdmetqDclVD6kddfsOK0Tnx0Xasn615ZpnBj
         RpZA==
X-Gm-Message-State: AGi0PubDOevZ/HeCoauEhMlEMnYiKuO0t+kALy0lgvRwA4l3kipaZGv4
        ZiYvU+Thl4MEuil7/tZXqbVgdwHN
X-Google-Smtp-Source: APiQypIQnbkfQ6mtrwGKY/663eDKFU68pJA1zQOSOIu8KN8vND9CsYqcJAPYq5WwfxWAHeq2PQHJ1A==
X-Received: by 2002:a1c:1d4b:: with SMTP id d72mr2709583wmd.19.1588676013121;
        Tue, 05 May 2020 03:53:33 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-654-1-289-61.w86-199.abo.wanadoo.fr. [86.199.72.61])
        by smtp.googlemail.com with ESMTPSA id b85sm3170326wmb.21.2020.05.05.03.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 03:53:32 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 3/6] stash: remove the second index in stash_patch()
Date:   Tue,  5 May 2020 12:48:46 +0200
Message-Id: <20200505104849.13602-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505104849.13602-1-alban.gruin@gmail.com>
References: <20200505104849.13602-1-alban.gruin@gmail.com>
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
-
-	remove_path(stash_index_path.buf);
 
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
2.26.2

