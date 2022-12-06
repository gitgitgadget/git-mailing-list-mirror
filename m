Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32019C352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 19:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiLFTx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 14:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiLFTxS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 14:53:18 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4F112754
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 11:53:17 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id m14so25040043wrh.7
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 11:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sF3g9v0dkK3JKvNPyZA672XRy4acoN7QYjopozQrF4c=;
        b=gyassw4l3Nxtq6BEgwz5Sdg2OjlPAGeLaOB1E0kLjbYjN5/gweE+EDaGqBgaVbF+GO
         5gQ7/E7LUxKLw03fWBq7XW1nMeBqpkSIGfX0v81awWFAWtdVYfbbDIXxXcsWicT9QKUk
         i+el8UT/wvgLcJyIFFwhq/Y2PVwBKc6lebDtAkRuUxIOkRh+ZGPYb3g+j2//8kF1OabY
         wGibSxDw+mXOgKamB0aTNfOE7q/kovUYBWRKli7GTB7mBnW+bQCpj2UnED83VFQB8VOW
         T8eOw2d452HfgJfIdZ+o7j8ntrNIuVvs6UHo/q3dTFmr8WcOIEwjPUY9mFlMJbIn+l8X
         dOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sF3g9v0dkK3JKvNPyZA672XRy4acoN7QYjopozQrF4c=;
        b=COZDTF+kuK+r76Z9nsiLLfGthznhH40fXTvGLrFHto4FN9piXKGMdIWy9YR2to5agd
         9fPNYHvFRpiuFq0Uu031zDmawuSGW9+eMmE9/m4A5gpm4s1jHEB4uFGEvsU5u5CI0S3V
         KSWR2AaBJA5RF0D2dUQw8L13FnosH/Wfvl/37/VxUcolQCYG7LSYjBW8o5gJvrpYGKgx
         hJ0aED2rw6j4Gb/QAC2/l28+JZUCZmvyGtpNO1bLkBAEi5C0UG1McBinI2bctvYXiVgp
         VOogPGa4gF+DoanrLssMdtNKWCUBdbQMmk+pP5YDcap5Hx6VeZnBPGsV/d/dnHqDMb+K
         K2Tw==
X-Gm-Message-State: ANoB5pn/fZYS+LHIsi0ZUKaqfQiPAG89bm+VqWzJa2rHIn27Zk/0ERym
        Rn8Ng8YdNXsjy3Jw0ZyhAj4XfL9IN5M=
X-Google-Smtp-Source: AA0mqf78M3zmHM/X1ja03DK94ZBYZPBMuXZQ50BhGpH2yTe0M6q8oDktPsL3Akw4miAjtvjEQQ+BaQ==
X-Received: by 2002:a5d:4f8f:0:b0:242:28c6:2373 with SMTP id d15-20020a5d4f8f000000b0024228c62373mr19920579wru.292.1670356395412;
        Tue, 06 Dec 2022 11:53:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o16-20020adfead0000000b00241cfa9333fsm17766072wrn.5.2022.12.06.11.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 11:53:15 -0800 (PST)
Message-Id: <pull.1390.v6.git.git.1670356394394.gitgitgadget@gmail.com>
In-Reply-To: <pull.1390.v5.git.git.1670348301601.gitgitgadget@gmail.com>
References: <pull.1390.v5.git.git.1670348301601.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Dec 2022 19:53:14 +0000
Subject: [PATCH v6] revision: use calloc instead of malloc where possible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija <doremylover123@gmail.com>

We can avoid having to call memset by calling calloc

Signed-off-by: Seija doremylover123@gmail.com
---
    revision: use calloc instead of malloc where possible
    
    We can avoid having to call memset by calling calloc
    
    Signed-off-by: Seija doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1390%2FAtariDreams%2Fcalloc-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1390/AtariDreams/calloc-v6
Pull-Request: https://github.com/git/git/pull/1390

Range-diff vs v5:

 1:  8072fa30e4f ! 1:  e012cf5c158 revision: use calloc instead of malloc where possible
     @@ Metadata
       ## Commit message ##
          revision: use calloc instead of malloc where possible
      
     -    We can avoid having to call memset by calling calloc directly
     +    We can avoid having to call memset by calling calloc
      
          Signed-off-by: Seija doremylover123@gmail.com
      


 builtin/pack-redundant.c | 17 +++++------------
 remote.c                 |  4 ++--
 submodule.c              | 10 +++++-----
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index ecd49ca268f..ce5be807cf0 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -59,19 +59,12 @@ static inline struct llist_item *llist_item_get(void)
 	return new_item;
 }
 
-static inline void llist_init(struct llist **list)
-{
-	*list = xmalloc(sizeof(struct llist));
-	(*list)->front = (*list)->back = NULL;
-	(*list)->size = 0;
-}
-
 static struct llist * llist_copy(struct llist *list)
 {
 	struct llist *ret;
 	struct llist_item *new_item, *old_item, *prev;
 
-	llist_init(&ret);
+	CALLOC_ARRAY(ret, 1);
 
 	if ((ret->size = list->size) == 0)
 		return ret;
@@ -448,7 +441,7 @@ static void load_all_objects(void)
 	struct pack_list *pl = local_packs;
 	struct llist_item *hint, *l;
 
-	llist_init(&all_objects);
+	CALLOC_ARRAY(all_objects, 1);
 
 	while (pl) {
 		hint = NULL;
@@ -475,7 +468,7 @@ static void cmp_local_packs(void)
 
 	/* only one packfile */
 	if (!pl->next) {
-		llist_init(&pl->unique_objects);
+		CALLOC_ARRAY(pl->unique_objects, 1);
 		return;
 	}
 
@@ -512,7 +505,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 		return NULL;
 
 	l.pack = p;
-	llist_init(&l.remaining_objects);
+	CALLOC_ARRAY(l.remaining_objects, 1);
 
 	if (open_pack_index(p))
 		return NULL;
@@ -620,7 +613,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 		scan_alt_odb_packs();
 
 	/* ignore objects given on stdin */
-	llist_init(&ignore);
+	CALLOC_ARRAY(ignore, 1);
 	if (!isatty(0)) {
 		while (fgets(buf, sizeof(buf), stdin)) {
 			oid = xmalloc(sizeof(*oid));
diff --git a/remote.c b/remote.c
index 60869beebe7..475a1d18af0 100644
--- a/remote.c
+++ b/remote.c
@@ -2741,9 +2741,9 @@ void apply_push_cas(struct push_cas_option *cas,
 
 struct remote_state *remote_state_new(void)
 {
-	struct remote_state *r = xmalloc(sizeof(*r));
+	struct remote_state *r;
 
-	memset(r, 0, sizeof(*r));
+	CALLOC_ARRAY(r, 1);
 
 	hashmap_init(&r->remotes_hash, remotes_hash_cmp, NULL, 0);
 	hashmap_init(&r->branches_hash, branches_hash_cmp, NULL, 0);
diff --git a/submodule.c b/submodule.c
index 8ac2fca855d..015102a83d6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1458,14 +1458,13 @@ struct fetch_task {
  */
 static const struct submodule *get_non_gitmodules_submodule(const char *path)
 {
-	struct submodule *ret = NULL;
+	struct submodule *ret;
 	const char *name = default_name_or_path(path);
 
 	if (!name)
 		return NULL;
 
-	ret = xmalloc(sizeof(*ret));
-	memset(ret, 0, sizeof(*ret));
+	CALLOC_ARRAY(ret, 1);
 	ret->path = name;
 	ret->name = name;
 
@@ -1504,8 +1503,9 @@ static struct fetch_task *fetch_task_create(struct submodule_parallel_fetch *spf
 					    const char *path,
 					    const struct object_id *treeish_name)
 {
-	struct fetch_task *task = xmalloc(sizeof(*task));
-	memset(task, 0, sizeof(*task));
+	struct fetch_task *task;
+
+	CALLOC_ARRAY(task, 1);
 
 	task->sub = submodule_from_path(spf->r, treeish_name, path);
 

base-commit: 2e71cbbddd64695d43383c25c7a054ac4ff86882
-- 
gitgitgadget
