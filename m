Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF1EC433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69E7620724
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiNF9lIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389351AbgF3PQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389343AbgF3PQb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 11:16:31 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53541C061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:16:31 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so17584887wrw.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UBVnXfBJF9lQX3a7Ibd8m+x5HaSMVcia4QtZlBo0xfA=;
        b=WiNF9lIzLsGzxuf8nmJ64vlJ04qzbRryuRomgJALy/zWxlyrHGCvkrAZ4ZwKvUE2Om
         FjRn+afpESGh04ppQ12ahfvyTUGkozxNsTPU0WZNA7/zlz2S4qDWNclT64PJqn/nCGJ0
         4zz16GBchFYxSzKFPXUiEiAGr3rxDq4seRgpWQ0omWTYXnGmqyiEi0kcX3w7RdJGJFE8
         hWkD06z0GxyB891AOW/06Pr2hU/WfMRA5vP7yWXPt+JNVGn63t8JJz3Kouu2RMa04p+H
         rhB4h+kFSig+aHG6Kpr0Q38xUNfDxztJWpC/WVw6QUfRKEtlVYeIuiC27WW+7NsdlDgE
         Z94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UBVnXfBJF9lQX3a7Ibd8m+x5HaSMVcia4QtZlBo0xfA=;
        b=nnuGDWaJ/cSlZZ9+1WXd/doymBQNw41nbe8jYnp+m6bcRYEbZgjLCXI4o9vDOmhJ5B
         FwexXdmWwl7ynz0pcgl1G29ib9SU2snGdk0C/i/wYShcGQlWEGvqd9O2DWvwF1i8/AqC
         pPHMWg0t2ZBOreET0pIlEmn8MPhB6+Prtk+fU2W69gDrpqj0hLhOk5ptANtwiqHYfiIp
         fsjVLdZjEoDjSZcvcn89VqACXUDSIcwEUWd61Vmz5EcB/cD9S4Xn63e0Ko/f0SDRzAmN
         cGtliT3CqUHh5sSJb22axx2/b6Hd03nkhW7D9l3PhPkTWz/4zOPK5Tci84iY6BQOqo9n
         EvXQ==
X-Gm-Message-State: AOAM530J5cHHqcO6SNZU5MVjlk2q5bUTZW3f3ihMw07oj0r97yzhyqKY
        mQ9GftKo/XKh2idRrbdhgAiDzjww
X-Google-Smtp-Source: ABdhPJx1u+19Q8UjVUQRJiqdBapF+ihNDUwccHtBsUYTZfU7ZrGgQeB54zjCExD+qriZWR58ibgFGA==
X-Received: by 2002:adf:e50a:: with SMTP id j10mr23717435wrm.71.1593530189714;
        Tue, 30 Jun 2020 08:16:29 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-323-12.w86-199.abo.wanadoo.fr. [86.199.210.12])
        by smtp.googlemail.com with ESMTPSA id 63sm4263911wra.86.2020.06.30.08.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 08:16:28 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 4/6] stash: remove the second index in save_untracked_files()
Date:   Tue, 30 Jun 2020 17:15:56 +0200
Message-Id: <20200630151558.20975-5-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630151558.20975-1-alban.gruin@gmail.com>
References: <20200505104849.13602-1-alban.gruin@gmail.com>
 <20200630151558.20975-1-alban.gruin@gmail.com>
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
index is discarded after this command exits.

As the only caller of this function is do_create_stash(), and the next
user of the index is either save_untracked_files() or stash_patch(),
which both want a different tree, the index is left as-is at the end.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/stash.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

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
+
+	if (pipe_command(&cp_upd_index, files.buf, files.len, NULL, 0,
+			 NULL, 0))
+		return -1;
+
+	discard_cache();
+	if (write_cache_as_tree(&info->u_tree, 0, NULL))
+		return -1;
 
 	strbuf_addf(&untracked_msg, "untracked files on %s\n", msg->buf);
-	if (pipe_command(&cp_upd_index, files.buf, files.len, NULL, 0,
-			 NULL, 0)) {
-		ret = -1;
-		goto done;
-	}
-
-	if (write_index_as_tree(&info->u_tree, &istate, stash_index_path.buf, 0,
-				NULL)) {
-		ret = -1;
-		goto done;
-	}
-
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
2.20.1

