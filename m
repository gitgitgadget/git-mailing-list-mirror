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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF55C433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8942920724
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zm/AEzO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389346AbgF3PQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389343AbgF3PQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 11:16:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63F6C061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:16:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j4so18141413wrp.10
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQ1wkzN9lR6tWZXEUOgKfa/3UH1sWqah3MpNf7gsGbg=;
        b=Zm/AEzO4ZGFutU9h1p5aZTDin3hjJZfh4i+W/taFuO81h3+9FbnFcdUdkNdE6uEvXV
         e3vMY9ezkLVHxNTxv18E4DTXY5s70giqJ41I1krcVY89fzh6NN3z4hXXap2I577Df2Cy
         hFXk8Qepb+ANMaiOyDnHsZAI++Xa1yj3dTixQtn87V4jgyRDlscfIuMpGg+hIVxFont2
         sp4miyQMdWxhW+CDLYhv2IltagNaSVDi449HFrKdPwErcfcK79VY/JheCiB8tWgIUK66
         WBhP8Yzc2PLN8Dey5e4XSsuWxXWeHWr94JKC7sRYWRjWfBH1q5Xx8jDgzzcl3WENhxzA
         Jm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQ1wkzN9lR6tWZXEUOgKfa/3UH1sWqah3MpNf7gsGbg=;
        b=ELs7+BThl0VTG7W5u5pk0UJ3lx/WrlVhnp3eDQ0hhXs8PXUIJauRgvUxEtbf4srXA5
         Js+v7y99EDO2nyAyI97y56HdlFaU2B1qjD518nP9q+qAqYZVcIzitFup+kDUUs9Su6M3
         pMvSyLgRSSKeN0PU88+y7WFU5pjAP3V+ndut+gbQJdbTaMf31mbxOe8CP2hdIdz2jcy8
         tAJYbumflo5EJmmy5xezt9cjZRIzJ64M9g0x6fxPnSyjvRQusK/x1/pMX9aXLQ4EAj8h
         vDORzmXGFJwwQqQOSpRfibcEZgwHRS5ktN9ZIRfJthVC2FmMArgsTEFUKcP/88ps7Tf3
         m17Q==
X-Gm-Message-State: AOAM530FziEM5utTnQPzUsgqEbotlQvjrGBk6KScCMB0OBMx5takFvW/
        8TJysXmhR6sygMzdb6FTY8nHBCJz
X-Google-Smtp-Source: ABdhPJw2TGuNTRY7x9oDm/NmIU+l7aKYAUUwys4rkJHav/WX3CZnl89gKosCETY7peLi7ZqGUPDu6Q==
X-Received: by 2002:a05:6000:1107:: with SMTP id z7mr21877555wrw.355.1593530186306;
        Tue, 30 Jun 2020 08:16:26 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-323-12.w86-199.abo.wanadoo.fr. [86.199.210.12])
        by smtp.googlemail.com with ESMTPSA id 63sm4263911wra.86.2020.06.30.08.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 08:16:25 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 2/6] stash: remove the second index in stash_working_tree()
Date:   Tue, 30 Jun 2020 17:15:54 +0200
Message-Id: <20200630151558.20975-3-alban.gruin@gmail.com>
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

This removes the second index used in stash_working_tree() to simplify
the code.

The calls to set_alternative_index_output() are dropped to extract
`i_tree' to the main index, and `GIT_INDEX_FILE' is no longer set before
starting `update-index'.  When it exits, the index has changed, and must
be discarded.

With this commit, reset_tree() does not need to be called at the
beginning of stash_working_tree(), because it is only called by
do_create_stash(), which sets the index at `i_tree', and
save_untracked_files() does not change the main index.  But it will
become useful again in a later commit, when save_untracked_file() will
be rewritten to use the "main" index, so I did not remove it.

At the end of the function, the tree is reset to `i_tree'.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/stash.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 9baa8b379e..2535335275 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1059,17 +1059,14 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 	struct rev_info rev;
 	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
 	struct strbuf diff_output = STRBUF_INIT;
-	struct index_state istate = { NULL };
 
 	init_revisions(&rev, NULL);
 	copy_pathspec(&rev.prune_data, ps);
 
-	set_alternate_index_output(stash_index_path.buf);
 	if (reset_tree(&info->i_tree, 0, 0)) {
 		ret = -1;
 		goto done;
 	}
-	set_alternate_index_output(NULL);
 
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = add_diff_to_buf;
@@ -1091,8 +1088,6 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 	argv_array_pushl(&cp_upd_index.args, "update-index",
 			 "--ignore-skip-worktree-entries",
 			 "-z", "--add", "--remove", "--stdin", NULL);
-	argv_array_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
-			 stash_index_path.buf);
 
 	if (pipe_command(&cp_upd_index, diff_output.buf, diff_output.len,
 			 NULL, 0, NULL, 0)) {
@@ -1100,19 +1095,16 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 		goto done;
 	}
 
-	if (write_index_as_tree(&info->w_tree, &istate, stash_index_path.buf, 0,
-				NULL)) {
+	discard_cache();
+	if (write_cache_as_tree(&info->w_tree, 0, NULL) ||
+	    reset_tree(&info->i_tree, 0, 1))
 		ret = -1;
-		goto done;
-	}
 
 done:
-	discard_index(&istate);
 	UNLEAK(rev);
 	object_array_clear(&rev.pending);
 	clear_pathspec(&rev.prune_data);
 	strbuf_release(&diff_output);
-	remove_path(stash_index_path.buf);
 	return ret;
 }
 
-- 
2.20.1

