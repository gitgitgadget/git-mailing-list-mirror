Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79709C433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 18:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiEPSMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 14:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245237AbiEPSLp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 14:11:45 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0DB3DA44
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:11:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a5so17816122wrp.7
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PKKhfPaob0S5doQJeOE3/jb2mSeIHDX+N92uXEC0GVs=;
        b=qr49prPbu6Yp/HpAWUYk5wIP1BJAkkWbo1ISG3X/dcUQ4ND1epT2p3WNZvWI15UVRZ
         zqKJA4JjqVcb6dXBCKeyZBWOAhm9aNkVBKx2vb8XttkheOGxxW+7pBiViQDm0YN/uymA
         TdkmF8pg0jP9NpLBhlSY7VH5j8+kbF9XkEL+BXqmJn7am9h022nGknYVLSmX22MF3k6+
         50wKPsDHoZg4n3+gGhIlA7R5dzdcLIkz3Wa9q18S1kVyzpxt9kq1k5ADPBwvJaMjYzOs
         IsPX/eNPVN1ktVUmcpD+3NV0qiScW35JMuSAWw3Ykgb0f2aJ9tKyJZ5N2omqpznF4BwJ
         psFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PKKhfPaob0S5doQJeOE3/jb2mSeIHDX+N92uXEC0GVs=;
        b=y2MZ5bYRm15+X8rNlVRYR/PxvLzt9Cbsn8GSjE+UIaTsbsaZf0TYSSrq74JtpZadc6
         zMR4QYYs8W1a5hxGFUwWhplrGI4+I/PAuTKg5FGUisE/sOIKFZjxMvWo3ABazbb3440m
         msyPNREmuCtW7QfOcVSWRFp9YcR8aXSvV5T7zYBKCE54dd1SeYN8GOrqyFVLhJnhDxxx
         GR/t70OqkypGRv4PesMBsknsstWnP35qXY7x59zifB6I+0/gADSj0YRtbOPA2Y2vuJ1Z
         Akrqh2tWFm6hLthtTZHEcC/5bzn5StEejqTy5ItUqq6G9nm6u38TVzFyNkkA9bi2hzNT
         VJag==
X-Gm-Message-State: AOAM5303/iC9qCA8EPO5saRuCqQOZT4Rx3R5nucbQfzAjBezvxB1rqbO
        fj/ql9+bZKu5sILvzkqsXOLoaoYyEd4=
X-Google-Smtp-Source: ABdhPJwri3prlU6tsx3AF19B4FqAMy21V3dIo03PyK6c160GrO1ueEHUUsKwS7SnMDF1yw5vybZx0Q==
X-Received: by 2002:adf:d1e3:0:b0:20c:6684:9b10 with SMTP id g3-20020adfd1e3000000b0020c66849b10mr15487423wrd.53.1652724700825;
        Mon, 16 May 2022 11:11:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o20-20020a1c4d14000000b0039453fe55a7sm13819288wmh.35.2022.05.16.11.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:11:40 -0700 (PDT)
Message-Id: <5c7546ab07080b43972b265eb2eee3de0c5396a2.1652724693.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 May 2022 18:11:30 +0000
Subject: [PATCH 5/8] sparse-index: partially expand directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The expand_to_pattern_list() method expands sparse directory entries
to their list of contained files when either the pattern list is NULL or
the directory is contained in the new pattern list's cone mode patterns.

It is possible that the pattern list has a recursive match with a
directory 'A/B/C/' and so an existing sparse directory 'A/B/' would need
to be expanded. If there exists a directory 'A/B/D/', then that
directory should not be expanded and instead we can create a sparse
directory.

To implement this, we plug into the add_path_to_index() callback for the
call to read_tree_at(). Since we now need access to both the index we
are writing and the pattern list we are comparing, create a 'struct
modify_index_context' to use as a data transfer object. It is important
that we use the given pattern list since we will use this pattern list
to change the sparse-checkout patterns and cannot use
istate->sparse_checkout_patterns.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 sparse-index.c | 46 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index 79e8ff087bc..3d8eed585b5 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -9,6 +9,11 @@
 #include "dir.h"
 #include "fsmonitor.h"
 
+struct modify_index_context {
+	struct index_state *write;
+	struct pattern_list *pl;
+};
+
 static struct cache_entry *construct_sparse_dir_entry(
 				struct index_state *istate,
 				const char *sparse_dir,
@@ -231,18 +236,41 @@ static int add_path_to_index(const struct object_id *oid,
 			     struct strbuf *base, const char *path,
 			     unsigned int mode, void *context)
 {
-	struct index_state *istate = (struct index_state *)context;
+	struct modify_index_context *ctx = (struct modify_index_context *)context;
 	struct cache_entry *ce;
 	size_t len = base->len;
 
-	if (S_ISDIR(mode))
-		return READ_TREE_RECURSIVE;
+	if (S_ISDIR(mode)) {
+		int dtype;
+		size_t baselen = base->len;
+		if (!ctx->pl)
+			return READ_TREE_RECURSIVE;
 
-	strbuf_addstr(base, path);
+		/*
+		 * Have we expanded to a point outside of the sparse-checkout?
+		 */
+		strbuf_addstr(base, path);
+		strbuf_add(base, "/-", 2);
+
+		if (path_matches_pattern_list(base->buf, base->len,
+					      NULL, &dtype,
+					      ctx->pl, ctx->write)) {
+			strbuf_setlen(base, baselen);
+			return READ_TREE_RECURSIVE;
+		}
 
-	ce = make_cache_entry(istate, mode, oid, base->buf, 0, 0);
+		/*
+		 * The path "{base}{path}/" is a sparse directory. Create the correct
+		 * name for inserting the entry into the idnex.
+		 */
+		strbuf_setlen(base, base->len - 1);
+	} else {
+		strbuf_addstr(base, path);
+	}
+
+	ce = make_cache_entry(ctx->write, mode, oid, base->buf, 0, 0);
 	ce->ce_flags |= CE_SKIP_WORKTREE | CE_EXTENDED;
-	set_index_entry(istate, istate->cache_nr++, ce);
+	set_index_entry(ctx->write, ctx->write->cache_nr++, ce);
 
 	strbuf_setlen(base, len);
 	return 0;
@@ -254,6 +282,7 @@ void expand_to_pattern_list(struct index_state *istate,
 	int i;
 	struct index_state *full;
 	struct strbuf base = STRBUF_INIT;
+	struct modify_index_context ctx;
 
 	/*
 	 * If the index is already full, then keep it full. We will convert
@@ -294,6 +323,9 @@ void expand_to_pattern_list(struct index_state *istate,
 	full->cache_nr = 0;
 	ALLOC_ARRAY(full->cache, full->cache_alloc);
 
+	ctx.write = full;
+	ctx.pl = pl;
+
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		struct tree *tree;
@@ -319,7 +351,7 @@ void expand_to_pattern_list(struct index_state *istate,
 		strbuf_add(&base, ce->name, strlen(ce->name));
 
 		read_tree_at(istate->repo, tree, &base, &ps,
-			     add_path_to_index, full);
+			     add_path_to_index, &ctx);
 
 		/* free directory entries. full entries are re-used */
 		discard_cache_entry(ce);
-- 
gitgitgadget

