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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B0BC433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 16:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0009F206D8
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 16:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcBJDILy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733290AbgGaQwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733019AbgGaQwL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 12:52:11 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A37EC061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 09:52:11 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r4so25629136wrx.9
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQ1wkzN9lR6tWZXEUOgKfa/3UH1sWqah3MpNf7gsGbg=;
        b=bcBJDILy8GMUKMc7SEdHjc1LB87LHkGkdE3JC4Ufy2h9+5brnmavmfVOsNPnF8P2IP
         TysNAKtmheFveUZMUXg1PeLEQkWMaw0cLROflbXmfC9b/WqjuRlAzNlTHJb3GNEkVHDr
         mTc7CsLxyIWZ5OSmdY5w7+YIe2yLgWDWFJ/tCn03NjEdq2v5NLqBV6CYVTdeq+gvUSAn
         ivNeD3X9ltUQ451UEqDD/zVKoLfbhqamUSx5Di+oAfwzhjenmydFBBpFfY9UfBzz5yzn
         jRVrcmvDhO9v5T57JCLwsgL7RUH78OphjnCbq8PM4vuCxog1Ql4jOOgRTj059x4GApQL
         rC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQ1wkzN9lR6tWZXEUOgKfa/3UH1sWqah3MpNf7gsGbg=;
        b=Ief/YTjJcCgK/qyblHwWX5uRZwtriIhKN2BA2qY0ZSWxAGXusJ4inEfU1YJ2uc5vXF
         3/LAJU5EVoZcBJv3soXAARWR+b9H6fdUqSzymsVGzbLykMubc/WiqmR+PvpKodqQrQDK
         ZxOV/DtoXtTgvqdTyaSY54FrKaHcrnMnpBt7rWZJO15CfoujwCFJqp49RWRIeNMOHTfG
         Q1OpZH1G1zwD34301CTjWvodu8jrYy9sVU6xmf6a/Uske1es5altmYnNGZGLgFkbTrhr
         XfuJICGN/LoX5T4x9cl61dvlfzQc7jJ3Z9P0ygN6lWzuMNBx8HjRy3QIJHdXmk5Ey4CA
         2gpQ==
X-Gm-Message-State: AOAM532AXJGJs0usVUs+8GMfS7dsD4aQOl4jYhOZ6oWTSCl4aMctDXIU
        tzEV3DpBFc9LZmkmTNEg1QYkBFg7
X-Google-Smtp-Source: ABdhPJzzM+ezV0i73pI+Az56/GLJwMPlXD0osHZGQR12C1GAVn0+hzYuWJNGv1dqkh0bFt6OcDynbg==
X-Received: by 2002:a5d:5485:: with SMTP id h5mr4021109wrv.427.1596214330092;
        Fri, 31 Jul 2020 09:52:10 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-421-163.w2-6.abo.wanadoo.fr. [2.6.84.163])
        by smtp.googlemail.com with ESMTPSA id t14sm15169134wrg.38.2020.07.31.09.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:52:09 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 2/6] stash: remove the second index in stash_working_tree()
Date:   Fri, 31 Jul 2020 18:51:36 +0200
Message-Id: <20200731165140.29197-3-alban.gruin@gmail.com>
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

