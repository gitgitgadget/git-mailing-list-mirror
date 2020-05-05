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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219C5C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 10:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFD07206A5
	for <git@archiver.kernel.org>; Tue,  5 May 2020 10:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5ePsGX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgEEKxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 06:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbgEEKxg (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 06:53:36 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B032DC061A10
        for <git@vger.kernel.org>; Tue,  5 May 2020 03:53:35 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l18so2158840wrn.6
        for <git@vger.kernel.org>; Tue, 05 May 2020 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KM117VLDCfXLrGZJrTHWfpfhH0YbT1LqQuHLCBOUJ6c=;
        b=i5ePsGX4rKoLBSMv5LVjZRufQjvvLPDpcdT/Xefx/a4lFronwd+ilEULSUduyy0uAs
         nNovi9gxuGeEGJkYSydCM8llXYbtP+iC7qZZ4Eqer21iIbAOYmddSZF1z2q29H/JKYgt
         kcFroESZW7+JTHwYqI5pg4IBAswhQc/nJ5rEKGvZatKvrgBhb5y5WgIpWvRJJkGlpogi
         mduXfdjpKMypAQ/9V0Lhzanm9SrawOAlQtHE0fvwE8fjcLgAUWQfz80VC57nnp6Z2eKB
         RqCOGIsuyQs4l1zJoGSFLHMoa5y50Oy5w4D4v1FO0ymn2oJvZYYiHRpyCr8fEcY19yz9
         gKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KM117VLDCfXLrGZJrTHWfpfhH0YbT1LqQuHLCBOUJ6c=;
        b=Av18DQXM2SPXeuKabqFkrUvxGXMEaR8XN0WXqwX3UH6rzeAATGMCM4OXdDLvIgLxiL
         WvvL9HCQnFcupZOLA7Sduz9aKNf3l+FklAepvm+mXN1An1TUPXJzv6EVeZlKiERvL47Z
         Vyvndscr8vUvrDgW0haLd+ywuc3AoSErB5sFQdJeY9Eq8GnzBxKxhQPHubwC7udWA7KK
         J9JI9jNPWOuSTvx3o39CEliM2BQWnuCPlDSnnGQzT6gpJFmtMLsIJc76XiRNIR9UuV6Q
         6B8fgEzAl4CdINFfHDFe8S4Ww6Gbu7Ado7UnPvsDdaawSBvcg728BhN0as2aYyVJwbtt
         mmdA==
X-Gm-Message-State: AGi0PuaJkGNK/yssiuywYweUX2QZrBI9XWKoLmtazcRKkmknqHcndXo3
        q22u2/UPyEaDY1QtSW88sIntrFDV
X-Google-Smtp-Source: APiQypKyc0yQLCG+eCB3wkjSASuDncQb4/YWjKdUTIXhrNxQXtXghSO7D5Ez3V18R1tYko/XAuFPkQ==
X-Received: by 2002:adf:ab57:: with SMTP id r23mr3325554wrc.180.1588676014210;
        Tue, 05 May 2020 03:53:34 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-654-1-289-61.w86-199.abo.wanadoo.fr. [86.199.72.61])
        by smtp.googlemail.com with ESMTPSA id b85sm3170326wmb.21.2020.05.05.03.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 03:53:33 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 4/6] stash: remove the second index in save_untracked_files()
Date:   Tue,  5 May 2020 12:48:47 +0200
Message-Id: <20200505104849.13602-5-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505104849.13602-1-alban.gruin@gmail.com>
References: <20200505104849.13602-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This removes the second index used in save_untracked_files().

This functions creates a new commit with no parents, and a tree
containing only untracked files, so the tree is reset to the empty tree
at the beginning (hence the need for reset_tree() to accept constant
trees).  The environment of `update-index' is no longer updated, and the
index is discarded after this command exited.

As the only caller of this function is do_create_stash(), and the next
user of the index is either save_untracked_files() or stash_patch(),
which both want a different tree, the index is left as-is at the end.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/stash.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index eaeb7bc8c4..cbe37cd24b 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -954,41 +954,36 @@ static int check_changes(const struct pathspec *ps, int include_untracked,
 static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 				struct strbuf files)
 {
-	int ret = 0;
 	struct strbuf untracked_msg = STRBUF_INIT;
 	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
-	struct index_state istate = { NULL };
+
+	if (reset_tree(the_hash_algo->empty_tree, 0, 1))
+		return -1;
 
 	cp_upd_index.git_cmd = 1;
 	argv_array_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
 			 "--remove", "--stdin", NULL);
-	argv_array_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
-			 stash_index_path.buf);
 
-	strbuf_addf(&untracked_msg, "untracked files on %s\n", msg->buf);
 	if (pipe_command(&cp_upd_index, files.buf, files.len, NULL, 0,
-			 NULL, 0)) {
-		ret = -1;
-		goto done;
-	}
+			 NULL, 0))
+		return -1;
 
-	if (write_index_as_tree(&info->u_tree, &istate, stash_index_path.buf, 0,
-				NULL)) {
-		ret = -1;
-		goto done;
-	}
+	discard_cache();
+	if (write_cache_as_tree(&info->u_tree, 0, NULL))
+		return -1;
 
+	strbuf_addf(&untracked_msg, "untracked files on %s\n", msg->buf);
 	if (commit_tree(untracked_msg.buf, untracked_msg.len,
 			&info->u_tree, NULL, &info->u_commit, NULL, NULL)) {
-		ret = -1;
-		goto done;
+		strbuf_release(&untracked_msg);
+		return -1;
 	}
 
-done:
-	discard_index(&istate);
+	/* Do not reset the tree, as either stash_patch() or
+	 * stash_working_tree() will do it. */
+
 	strbuf_release(&untracked_msg);
-	remove_path(stash_index_path.buf);
-	return ret;
+	return 0;
 }
 
 static int stash_patch(struct stash_info *info, const struct pathspec *ps,
-- 
2.26.2

