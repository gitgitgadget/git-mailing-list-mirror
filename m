Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66A8F4F1
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734481852; cv=none; b=Fdyh5tA33rH/npZrgk21LxgWDUISeN8L+6YiOju/xep3yY3POQUY946OXkUbbUvlOe3hGXw2Yj//3Q6YyNy+7eVCZaAYTP+JYjQQ+H4a87mur/oPQyZK+kn8k6/LJ5fv705Em2Fl4ykMnwR3YtHvVgar5qEnYrezR3hXZ61XBc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734481852; c=relaxed/simple;
	bh=vVpqkECFlp6NictV7sBYUuZVSE3uoftNsF/MwQVL7jU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nF8XSyzSkj1Yb1HjRtDoTKUhs3b95xyDN6MKF2betBKjQUiIHEopb1weA64d88la0078EIAm+H/hgIVvB60NwgYb7rqk2aRgE44RWdZd3s6YP7vAsNPyCqu62AtNfSAnEDtuXvwq3lgpGQ45Gx3/IRbCAJ6SGQYjcuUZEp0siV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDVe5wHv; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDVe5wHv"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3863494591bso3179247f8f.1
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 16:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734481849; x=1735086649; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErGm4tSBk/JoHMUBU//u4+scAXNMH/r+al1Sd4jBaiQ=;
        b=YDVe5wHvWbhmNfvg2/4plQoSWiiu3eS9KBKIz0+sxk6h0cm9V0mYD4h/gUG8Lmb1x5
         E5JeqxKF1wY83wWI9P/pPdExKdOmdSGxObIgcrC40+U1M4hKSmfsbVJ8rg7bvYhEDVd5
         VH7sbDICj/2du6hWDRR3A5xrklQWWK1KpaPq89XWUV69A3LQya5W7S2ZrStWyVktGlza
         qQkc16NXZ28kumo57tbS/rffyOPWA7tRgJDWUJHFrWfndPnPD81Q3gAPbdM3VXo+9aWI
         GT4SUNHc7YmL2j5mcwoDHQgvB2Px8uQthtKBtmLyoJa/S/KHaxQcfcjrHZM5ioz8OM7v
         nlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734481849; x=1735086649;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErGm4tSBk/JoHMUBU//u4+scAXNMH/r+al1Sd4jBaiQ=;
        b=QMNF0SupZpYv6+09qBXKq9pktWg//dUJx095/pM4L9ZMaMaaADuKoL34aQexw+R3xK
         rYqn3m77VvFHT8kKFcMkhHb7udZ677Z9H4CzyeQixIXvUFa5q0uccJ8o0oB+RRsxmsnA
         LOPf7ldWSGvWWRfl47nQhBiMO/dLMVuLqHlfFWhEWCTjl7e5CBEDU0/Juc66RPTTQqV7
         9l/+FXQ3s51k179O406xNPNgEdZks81tu+mNBq59m4QIfXvdNV2+vvzSCV1buMaYrWev
         sBEiqQasyEpm2uR7afgUfMiXC3OQsFCrjEArIy0JLZXjthobvrhsmi+lQ0n1S/4EvdjX
         76yQ==
X-Gm-Message-State: AOJu0YxpvklyeiYE41uI1SiU/0ZTuiuVm/gNWHuqQRWF1azRxmzEqm0w
	j7onvY4yvb+/4QbrGIvoXlmxaOxXPE0nvFY8KznZ+sA0MenK1JsbVSVocA==
X-Gm-Gg: ASbGncuNT7S0PS6jx48Rhcdf9p1Kr85P+wAvN2BUTQwUgLknXPCOtSaR7KpK3yZVTNG
	m2Uvnb4dUgWakh/QA89TvYufRp4exhLvmiFHfNccC8zH9ro+QZADFjdDCDquAdixu2rNkuNy/LU
	N0d+7Bkg9HURbGGdvRFWbtqDyiMbmLdGTHj+8PlyFEAhg4/F0bYNzerMhIDE+N8UPFe3RJ+Su9o
	GeCQQQzIEJVcJ2+o2xMfMlfGJIjznOtk3YVExsJ/i8UvzHZho6ENUxekQ==
X-Google-Smtp-Source: AGHT+IE/t9+QrfA5Y4awN68eNCl604Ig8AKkDCfCS74kVnlC6XZOvwaQsslhMMx1yNHTHOWDZKdmVA==
X-Received: by 2002:a5d:584b:0:b0:385:ee59:44f1 with SMTP id ffacd0b85a97d-388e4d8495emr613100f8f.20.1734481848608;
        Tue, 17 Dec 2024 16:30:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8060848sm12480749f8f.106.2024.12.17.16.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:30:48 -0800 (PST)
Message-Id: <pull.1390.v7.git.git.1734481847156.gitgitgadget@gmail.com>
In-Reply-To: <pull.1390.v6.git.git.1670356394394.gitgitgadget@gmail.com>
References: <pull.1390.v6.git.git.1670356394394.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 00:30:46 +0000
Subject: [PATCH v7] revision: use calloc instead of malloc where possible
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "Jeff Hostetler [ ]" <git@jeffhostetler.com>,
    "=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason [ ]" <avarab@gmail.com>,
    "Bagas Sanjaya [ ]" <bagasdotme@gmail.com>,
    AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

We can avoid having to call memset by calling calloc

Signed-off-by: Seija <doremylover123@gmail.com>
---
    revision: use calloc instead of malloc where possible
    
    We can avoid having to call memset by calling calloc
    
    Signed-off-by: Seija doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1390%2FAreaZR%2Fcalloc-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1390/AreaZR/calloc-v7
Pull-Request: https://github.com/git/git/pull/1390

Range-diff vs v6:

 1:  e012cf5c158 ! 1:  e91cea8dea8 revision: use calloc instead of malloc where possible
     @@
       ## Metadata ##
     -Author: Seija <doremylover123@gmail.com>
     +Author: Seija Kijin <doremylover123@gmail.com>
      
       ## Commit message ##
          revision: use calloc instead of malloc where possible
      
          We can avoid having to call memset by calling calloc
      
     -    Signed-off-by: Seija doremylover123@gmail.com
     +    Signed-off-by: Seija <doremylover123@gmail.com>
      
       ## builtin/pack-redundant.c ##
      @@ builtin/pack-redundant.c: static inline struct llist_item *llist_item_get(void)
     @@ builtin/pack-redundant.c: static inline struct llist_item *llist_item_get(void)
      -	(*list)->size = 0;
      -}
      -
     - static struct llist * llist_copy(struct llist *list)
     + static void llist_free(struct llist *list)
       {
     + 	for (struct llist_item *i = list->front, *next; i; i = next) {
     +@@ builtin/pack-redundant.c: static struct llist * llist_copy(struct llist *list)
       	struct llist *ret;
       	struct llist_item *new_item, *old_item, *prev;
       
     @@ builtin/pack-redundant.c: static struct pack_list * add_pack(struct packed_git *
       
       	if (open_pack_index(p))
       		return NULL;
     -@@ builtin/pack-redundant.c: int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
     +@@ builtin/pack-redundant.c: int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
       		scan_alt_odb_packs();
       
       	/* ignore objects given on stdin */
      -	llist_init(&ignore);
      +	CALLOC_ARRAY(ignore, 1);
       	if (!isatty(0)) {
     + 		struct object_id oid;
       		while (fgets(buf, sizeof(buf), stdin)) {
     - 			oid = xmalloc(sizeof(*oid));
      
       ## remote.c ##
      @@ remote.c: void apply_push_cas(struct push_cas_option *cas,
     @@ submodule.c: static struct fetch_task *fetch_task_create(struct submodule_parall
      +
      +	CALLOC_ARRAY(task, 1);
       
     - 	task->sub = submodule_from_path(spf->r, treeish_name, path);
     - 
     + 	if (validate_submodule_path(path) < 0)
     + 		exit(128);


 builtin/pack-redundant.c | 17 +++++------------
 remote.c                 |  4 ++--
 submodule.c              | 10 +++++-----
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index bc61990a933..7015a85bf78 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -63,13 +63,6 @@ static inline struct llist_item *llist_item_get(void)
 	return new_item;
 }
 
-static inline void llist_init(struct llist **list)
-{
-	*list = xmalloc(sizeof(struct llist));
-	(*list)->front = (*list)->back = NULL;
-	(*list)->size = 0;
-}
-
 static void llist_free(struct llist *list)
 {
 	for (struct llist_item *i = list->front, *next; i; i = next) {
@@ -84,7 +77,7 @@ static struct llist * llist_copy(struct llist *list)
 	struct llist *ret;
 	struct llist_item *new_item, *old_item, *prev;
 
-	llist_init(&ret);
+	CALLOC_ARRAY(ret, 1);
 
 	if ((ret->size = list->size) == 0)
 		return ret;
@@ -480,7 +473,7 @@ static void load_all_objects(void)
 	struct pack_list *pl = local_packs;
 	struct llist_item *hint, *l;
 
-	llist_init(&all_objects);
+	CALLOC_ARRAY(all_objects, 1);
 
 	while (pl) {
 		hint = NULL;
@@ -507,7 +500,7 @@ static void cmp_local_packs(void)
 
 	/* only one packfile */
 	if (!pl->next) {
-		llist_init(&pl->unique_objects);
+		CALLOC_ARRAY(pl->unique_objects, 1);
 		return;
 	}
 
@@ -544,7 +537,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 		return NULL;
 
 	l.pack = p;
-	llist_init(&l.remaining_objects);
+	CALLOC_ARRAY(l.remaining_objects, 1);
 
 	if (open_pack_index(p))
 		return NULL;
@@ -650,7 +643,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
 		scan_alt_odb_packs();
 
 	/* ignore objects given on stdin */
-	llist_init(&ignore);
+	CALLOC_ARRAY(ignore, 1);
 	if (!isatty(0)) {
 		struct object_id oid;
 		while (fgets(buf, sizeof(buf), stdin)) {
diff --git a/remote.c b/remote.c
index 10104d11e3c..462ff105273 100644
--- a/remote.c
+++ b/remote.c
@@ -2854,9 +2854,9 @@ void apply_push_cas(struct push_cas_option *cas,
 
 struct remote_state *remote_state_new(void)
 {
-	struct remote_state *r = xmalloc(sizeof(*r));
+	struct remote_state *r;
 
-	memset(r, 0, sizeof(*r));
+	CALLOC_ARRAY(r, 1);
 
 	hashmap_init(&r->remotes_hash, remotes_hash_cmp, NULL, 0);
 	hashmap_init(&r->branches_hash, branches_hash_cmp, NULL, 0);
diff --git a/submodule.c b/submodule.c
index 7ec564854d0..7707c6f48f0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1489,14 +1489,13 @@ struct fetch_task {
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
 
@@ -1536,8 +1535,9 @@ static struct fetch_task *fetch_task_create(struct submodule_parallel_fetch *spf
 					    const char *path,
 					    const struct object_id *treeish_name)
 {
-	struct fetch_task *task = xmalloc(sizeof(*task));
-	memset(task, 0, sizeof(*task));
+	struct fetch_task *task;
+
+	CALLOC_ARRAY(task, 1);
 
 	if (validate_submodule_path(path) < 0)
 		exit(128);

base-commit: 2ccc89b0c16c51561da90d21cfbb4b58cc877bf6
-- 
gitgitgadget
