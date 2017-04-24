Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B02761FE90
	for <e@80x24.org>; Mon, 24 Apr 2017 10:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1167144AbdDXKCk (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 06:02:40 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:36256 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1168304AbdDXKBi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 06:01:38 -0400
Received: by mail-it0-f50.google.com with SMTP id g66so53048216ite.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xyDqSWiiyu1GNzU/pVhi5Vvpp2bZ08nTrviHoDMZLCs=;
        b=Us+ikDXNEy5MdoeGpQs0jcNpdVuiFhdBbAgUEv3e50YwlxM4RwNVgc6mJmng/tCLHF
         q9J3hlIbkLYQflyZRObVp3fjt74HZ3MoWJsT4nz85HOxS4vy/o7YO2ezXpf/zdIpnpt0
         D7pBPwF3ApT0NEgyOH1M+7yc0PLmIHqOKTjpYf6yPCWbg5mbpA7j2I5+akBdLtVyUaH4
         HbsnbfN1TGc9XF/zuwSZ/Wey7ZVpvmfMqT6e8IinIIOsC5UMPuzrz3Wfuc7LiBOsRz0H
         /LfPzLr3xiyWUUYWu6mok6KfZyuq79Rmb1TLrxNmpmRKYZ9G00DCPYHWY/j5CbfHmuXH
         MrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xyDqSWiiyu1GNzU/pVhi5Vvpp2bZ08nTrviHoDMZLCs=;
        b=YYKC9mDgp2WE7j/UrsXU1BvdPKj5cGuzlOP/BccTHp/wVjoEWuLT0fuwoG34WepIhp
         7vvhwmqpRRnb/NByDDK1ayichvYskVD2iO6fsaYIr+BGF/z7+DIqejnJpnJjmdkVFXTx
         KvRa5QAa6ClX6qwDx7jpyecyaexPERH9yxQLGJBnZ1jHxDqxBV78EN5v1+Nf3Iwb8f1B
         IelZerbq3ou+5OovItSyC3o3rJLaxZB5Q+XOuJ0VNLlPQsoOM7bJZsFPHFgZdn2IBZjM
         96XFeKi+9IkaS+x91G4+NBjGlbxo1xvgiOyvuymk74R+jRMcseZplNCkEmQjhsFCI1mo
         VM3g==
X-Gm-Message-State: AN3rC/627UseVemVjts3/Vq3+oRBkTrko9xgqmLzNERTWSq/Idc3Rfnv
        N03BjyPeT80FLQ==
X-Received: by 10.99.67.3 with SMTP id q3mr23934530pga.221.1493028096582;
        Mon, 24 Apr 2017 03:01:36 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id s83sm29510124pfa.128.2017.04.24.03.01.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2017 03:01:35 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Apr 2017 17:01:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 0/6] Kill manual ref parsing code in worktree.c
Date:   Mon, 24 Apr 2017 17:01:18 +0700
Message-Id: <20170424100124.24637-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170404102123.25315-1-pclouds@gmail.com>
References: <20170404102123.25315-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v5 chanes are mostly cosmetic:

diff --git a/refs.c b/refs.c
index 5d31fb6bcf..7972720256 100644
--- a/refs.c
+++ b/refs.c
@@ -1530,11 +1530,7 @@ struct ref_store *get_main_ref_store(void)
 	if (main_ref_store)
 		return main_ref_store;
 
-	main_ref_store = ref_store_init(get_git_dir(),
-					(REF_STORE_READ |
-					 REF_STORE_WRITE |
-					 REF_STORE_ODB |
-					 REF_STORE_MAIN));
+	main_ref_store = ref_store_init(get_git_dir(), REF_STORE_ALL_CAPS);
 	return main_ref_store;
 }
 
@@ -1597,9 +1593,6 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 struct ref_store *get_worktree_ref_store(const struct worktree *wt)
 {
 	struct ref_store *refs;
-	unsigned int refs_all_capabilities =
-		REF_STORE_READ | REF_STORE_WRITE |
-		REF_STORE_ODB | REF_STORE_MAIN;
 	const char *id;
 
 	if (wt->is_current)
@@ -1612,10 +1605,10 @@ struct ref_store *get_worktree_ref_store(const struct worktree *wt)
 
 	if (wt->id)
 		refs = ref_store_init(git_common_path("worktrees/%s", wt->id),
-				      refs_all_capabilities);
+				      REF_STORE_ALL_CAPS);
 	else
 		refs = ref_store_init(get_git_common_dir(),
-				      refs_all_capabilities);
+				      REF_STORE_ALL_CAPS);
 
 	if (refs)
 		register_ref_store_map(&worktree_ref_stores, "worktree",
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 690498698e..b26f7e41ce 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -467,6 +467,10 @@ struct ref_store;
 #define REF_STORE_WRITE		(1 << 1) /* can perform update operations */
 #define REF_STORE_ODB		(1 << 2) /* has access to object database */
 #define REF_STORE_MAIN		(1 << 3)
+#define REF_STORE_ALL_CAPS	(REF_STORE_READ | \
+				 REF_STORE_WRITE | \
+				 REF_STORE_ODB | \
+				 REF_STORE_MAIN)
 
 /*
  * Initialize the ref_store for the specified gitdir. These functions

Nguyễn Thái Ngọc Duy (6):
  environment.c: fix potential segfault by get_git_common_dir()
  refs.c: make submodule ref store hashmap generic
  refs: add REFS_STORE_ALL_CAPS
  refs: introduce get_worktree_ref_store()
  worktree.c: kill parse_ref() in favor of refs_resolve_ref_unsafe()
  refs: kill set_worktree_head_symref()

 branch.c                               |  15 ++---
 environment.c                          |   2 +
 refs.c                                 | 100 ++++++++++++++++++++------------
 refs.h                                 |  12 +---
 refs/files-backend.c                   |  44 --------------
 refs/refs-internal.h                   |   4 ++
 t/helper/test-ref-store.c              |  18 ++++++
 t/t1407-worktree-ref-store.sh (new +x) |  52 +++++++++++++++++
 worktree.c                             | 102 +++++++++------------------------
 worktree.h                             |   2 +-
 10 files changed, 177 insertions(+), 174 deletions(-)
 create mode 100755 t/t1407-worktree-ref-store.sh

-- 
2.11.0.157.gd943d85

