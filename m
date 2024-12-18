Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3813A182C5
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 02:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734488555; cv=none; b=ALrUbuZRWvxZ+a3VBY6rA9CLvIzEX5l7egwDvogjujZaYRO9JryTKvf9ExCF2e4yP7k3zVc8iTJsqGxLLJd5WSTHl8HWyziIkgfa2tSBtOsOodfAAX/BEvjXmY/zr5IRm0riMKqcnkybB5HG3EWYnEuvSa8bubKMcTfOKmE/CRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734488555; c=relaxed/simple;
	bh=+1BmgzxgOqLkdO09A82O8O1bwSFDRFIEhtWlRuwbwdU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=VjaoC4f6l4oVNuoBPgpeAodcX4rhOzxHx5iKPdvma7oq3Of7Udlh4MNkthJvjtrIL7hg+av7O0oSa+0iJskXxgtsOXjQMpf4STd5js62bnuhefM7PbGA19o65SEi/p32fLAPUP5E7oto0UuZeI38JJBNOIB7K8XR8Wu36x/78Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZI1Bczp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZI1Bczp"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436341f575fso46986995e9.1
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 18:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734488551; x=1735093351; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tTzeMq9M+nxOnsYQZwKy2Q0xF2o7jPmSp7BqxW1scNg=;
        b=DZI1BczpQOg0Jz8RdR7fspmiMw4szcG6jysQcFuNlKT+SBczknlKmCZAZ6JoyCr1yM
         cCPRnQYTlg34kRo1acSOk79xCFeFTbU2paa+/ibnjhbmC4obF4/G6OHIW5TG+ccEdmBw
         Z5XGGHQGNe+cUzsRMWGi9jjfpBp78F7Fpq/L6yVu68ZZAq3mzmAqr19xRE2gtRAlV//e
         nCeLWtewc39NeN9Tdt1gZZV/oNQUg7ksme1sUbIaeSYjaE5T2gEn48MFwEqL2iX/2pDE
         xkKmWlB1q26x3WdQ3mbv50z+VKJ9Mou0Q+OvVnn3IZjZ5AnfUBps8KnrnonRugrdFgEe
         dp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734488551; x=1735093351;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTzeMq9M+nxOnsYQZwKy2Q0xF2o7jPmSp7BqxW1scNg=;
        b=Rt93ehk7aJxn22FXKyENMbwLgqXQr8993Ov+tVnBDxtyVMLHQ1rB2o0+nZudPuzYaS
         vfm3g/9hZWcSj/mGVhOtgYiUkWwKjONbvFgiz8YspRiW2bSDPx3GlfDaztR1EDG7QQx4
         jO5BRY/CCONoWK2t2Fw+zwhjcYwwrQitTmzPnwfrugwhKflK5li6LT0lJi2GD8B+8FgC
         r/oUR5uBNUilDY1oWpX+ipqtUEdJ0X3pkVYA4DEnbk3G7UQTLroBXsJQjVzAhhVSV05X
         tDr555ZXol1JZpdMFprw9eba+HF8kf8ZUmlbR5XoJ9dYTn0tO0s5hRzMXSaozth6OGww
         C+Ow==
X-Gm-Message-State: AOJu0YwYM587tlFLZnw2wQHK2IoRqfGhG4Iks18slyuVJDmpGIcZzhAw
	o/YuSaTNRVqgJlTuK4YBa9kGKJ7NJ+W/k5utzPl9xWyR5Bnd3BZYOlwUQw==
X-Gm-Gg: ASbGncvz8g0WwXC4bPljX+n7dc/yT/7PUNOGuoh3JawCq9MXhUkDNuBSy9SCtw+PxkQ
	NuqnrMjxsQumGnVZyzS8NVqsYwnHe/cOw7+XTMD0CnHCgV6CfOriaX2dLvEYoMsVqY+hJR0PgHx
	bdwnP/EvkwKIRt8SkT8lAXds7+FyCBREApYo/u0BA9JlYIZg6nf+Cf7RTY0zqOJFdEkZQCKtgoT
	31DlVNDrLeF/JhRUn2V6VZr195N2fnvDxIGnOq35olWjxL/x1jLtRQkKw==
X-Google-Smtp-Source: AGHT+IHRx6f1E2k2njxLHn2/Ju0pPPUmQavANvNDnfZjzdt58I8KzULpbI7v9Fu1+QHO0bPZ41b7vg==
X-Received: by 2002:a5d:47cf:0:b0:386:43c9:3ac2 with SMTP id ffacd0b85a97d-388e4d83912mr760992f8f.15.1734488550576;
        Tue, 17 Dec 2024 18:22:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8060144sm12878058f8f.89.2024.12.17.18.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 18:22:30 -0800 (PST)
Message-Id: <pull.1849.git.git.1734488549111.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 02:22:28 +0000
Subject: [PATCH] git: use U to denote unsigned to prevent UB
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
Cc: AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

1 << can be UB if 1 ends up overflowing and
being assigned to an unsigned int or long.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    git: use U to denote unsigned to prevent UB
    
    1 << can be UB if 1 ends up overflowing and being assigned to an
    unsigned int or long.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1849%2FAreaZR%2F1U-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1849/AreaZR/1U-v1
Pull-Request: https://github.com/git/git/pull/1849

 builtin/checkout.c     |  2 +-
 builtin/merge-tree.c   |  4 ++--
 builtin/receive-pack.c |  2 +-
 color.c                |  4 ++--
 delta-islands.c        |  2 +-
 diff-delta.c           |  2 +-
 diff.c                 |  2 +-
 help.c                 |  2 +-
 imap-send.c            |  2 +-
 merge-ort.c            | 18 +++++++++---------
 xdiff/xhistogram.c     |  2 +-
 xdiff/xprepare.c       |  4 ++--
 12 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5e5afa0f267..a636e71e05c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -223,7 +223,7 @@ static int check_stages(unsigned stages, const struct cache_entry *ce, int pos)
 		ce = the_repository->index->cache[pos];
 		if (strcmp(name, ce->name))
 			break;
-		seen |= (1 << ce_stage(ce));
+		seen |= (1U << ce_stage(ce));
 		pos++;
 	}
 	if ((stages & seen) != stages)
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index c5ed472967a..d0104dfa0c7 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -270,13 +270,13 @@ static void unresolved(const struct traverse_info *info, struct name_entry n[3])
 	unsigned dirmask = 0, mask = 0;
 
 	for (i = 0; i < 3; i++) {
-		mask |= (1 << i);
+		mask |= (1U << i);
 		/*
 		 * Treat missing entries as directories so that we return
 		 * after unresolved_directory has handled this.
 		 */
 		if (!n[i].mode || S_ISDIR(n[i].mode))
-			dirmask |= (1 << i);
+			dirmask |= (1U << i);
 	}
 
 	unresolved_directory(info, n);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9d2c07f68da..b958eeee8fe 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1306,7 +1306,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	struct shallow_lock shallow_lock = SHALLOW_LOCK_INIT;
 	struct oid_array extra = OID_ARRAY_INIT;
 	struct check_connected_options opt = CHECK_CONNECTED_INIT;
-	uint32_t mask = 1 << (cmd->index % 32);
+	uint32_t mask = 1U << (cmd->index % 32);
 	int i;
 
 	trace_printf_key(&trace_shallow,
diff --git a/color.c b/color.c
index 227a5ab2f42..ab9a3d2a097 100644
--- a/color.c
+++ b/color.c
@@ -317,7 +317,7 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 		}
 		val = parse_attr(word, wordlen);
 		if (0 <= val)
-			attr |= (1 << val);
+			attr |= (1U << val);
 		else
 			goto bad;
 	}
@@ -340,7 +340,7 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 			sep++;
 
 		for (i = 0; attr; i++) {
-			unsigned bit = (1 << i);
+			unsigned bit = (1U << i);
 			if (!(attr & bit))
 				continue;
 			attr &= ~bit;
diff --git a/delta-islands.c b/delta-islands.c
index 84435512593..a041cfa1ab3 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -78,7 +78,7 @@ static int island_bitmap_is_subset(struct island_bitmap *self,
 }
 
 #define ISLAND_BITMAP_BLOCK(x) (x / 32)
-#define ISLAND_BITMAP_MASK(x) (1 << (x % 32))
+#define ISLAND_BITMAP_MASK(x) (1U << (x % 32))
 
 static void island_bitmap_set(struct island_bitmap *self, uint32_t i)
 {
diff --git a/diff-delta.c b/diff-delta.c
index 77fea08dfb0..fbdfec7037f 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -156,7 +156,7 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	}
 	hsize = entries / 4;
 	for (i = 4; (1u << i) < hsize; i++);
-	hsize = 1 << i;
+	hsize = 1u << i;
 	hmask = hsize - 1;
 
 	/* allocate lookup index */
diff --git a/diff.c b/diff.c
index 266ddf18e73..021df059e0b 100644
--- a/diff.c
+++ b/diff.c
@@ -4815,7 +4815,7 @@ static void prepare_filter_bits(void)
 
 	if (!filter_bit[DIFF_STATUS_ADDED]) {
 		for (i = 0; diff_status_letters[i]; i++)
-			filter_bit[(int) diff_status_letters[i]] = (1 << i);
+			filter_bit[(int) diff_status_letters[i]] = (1U << i);
 	}
 }
 
diff --git a/help.c b/help.c
index 8a830ba35c6..839596156fe 100644
--- a/help.c
+++ b/help.c
@@ -394,7 +394,7 @@ void list_cmds_by_category(struct string_list *list,
 
 	for (i = 0; category_names[i]; i++) {
 		if (!strcmp(cat, category_names[i])) {
-			cat_id = 1UL << i;
+			cat_id = 1U << i;
 			break;
 		}
 	}
diff --git a/imap-send.c b/imap-send.c
index 25c68fd90d7..fdb9e658e70 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -644,7 +644,7 @@ static void parse_capability(struct imap *imap, char *cmd)
 	while ((arg = next_arg(&cmd)))
 		for (i = 0; i < ARRAY_SIZE(cap_list); i++)
 			if (!strcmp(cap_list[i], arg))
-				imap->caps |= 1 << i;
+				imap->caps |= 1U << i;
 	imap->rcaps = imap->caps;
 }
 
diff --git a/merge-ort.c b/merge-ort.c
index 11029c10be3..5a99bec7a04 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1218,7 +1218,7 @@ static void collect_rename_info(struct merge_options *opt,
 		return;
 
 	for (side = MERGE_SIDE1; side <= MERGE_SIDE2; ++side) {
-		unsigned side_mask = (1 << side);
+		unsigned side_mask = (1U << side);
 
 		/* Check for deletion on side */
 		if ((filemask & 1) && !(filemask & side_mask))
@@ -2026,7 +2026,7 @@ static void initialize_attr_index(struct merge_options *opt)
 
 		ASSIGN_AND_VERIFY_CI(ci, mi);
 		for (stage = 0; stage < 3; stage++) {
-			unsigned stage_mask = (1 << stage);
+			unsigned stage_mask = (1U << stage);
 
 			if (!(ci->filemask & stage_mask))
 				continue;
@@ -2362,7 +2362,7 @@ static char *handle_path_level_conflicts(struct merge_options *opt,
 	 */
 	if (c_info->reported_already) {
 		clean = 0;
-	} else if (path_in_way(&opt->priv->paths, new_path, 1 << side_index)) {
+	} else if (path_in_way(&opt->priv->paths, new_path, 1U << side_index)) {
 		c_info->reported_already = 1;
 		strbuf_add_separated_string_list(&collision_paths, ", ",
 						 &c_info->source_files);
@@ -2747,7 +2747,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 		ci->filemask = 0;
 		ci->merged.clean = 1;
 		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
-			if (ci->dirmask & (1 << i))
+			if (ci->dirmask & (1U << i))
 				continue;
 			/* zero out any entries related to files */
 			ci->stages[i].mode = 0;
@@ -2915,7 +2915,7 @@ static int process_renames(struct merge_options *opt,
 				assert(side1 == side2);
 				memcpy(&side1->stages[0], &base->stages[0],
 				       sizeof(merged));
-				side1->filemask |= (1 << MERGE_BASE);
+				side1->filemask |= (1U << MERGE_BASE);
 				/* Mark base as resolved by removal */
 				base->merged.is_null = 1;
 				base->merged.clean = 1;
@@ -3002,7 +3002,7 @@ static int process_renames(struct merge_options *opt,
 		target_index = pair->score; /* from collect_renames() */
 		assert(target_index == 1 || target_index == 2);
 		other_source_index = 3 - target_index;
-		old_sidemask = (1 << other_source_index); /* 2 or 4 */
+		old_sidemask = (1U << other_source_index); /* 2 or 4 */
 		source_deleted = (oldinfo->filemask == 1);
 		collision = ((newinfo->filemask & old_sidemask) != 0);
 		type_changed = !source_deleted &&
@@ -3116,7 +3116,7 @@ static int process_renames(struct merge_options *opt,
 			 */
 			memcpy(&newinfo->stages[0], &oldinfo->stages[0],
 			       sizeof(newinfo->stages[0]));
-			newinfo->filemask |= (1 << MERGE_BASE);
+			newinfo->filemask |= (1U << MERGE_BASE);
 			newinfo->pathnames[0] = oldpath;
 			if (type_changed) {
 				/* rename vs. typechange */
@@ -3139,7 +3139,7 @@ static int process_renames(struct merge_options *opt,
 				memcpy(&newinfo->stages[other_source_index],
 				       &oldinfo->stages[other_source_index],
 				       sizeof(newinfo->stages[0]));
-				newinfo->filemask |= (1 << other_source_index);
+				newinfo->filemask |= (1U << other_source_index);
 				newinfo->pathnames[other_source_index] = oldpath;
 			}
 		}
@@ -3990,7 +3990,7 @@ static int process_entry(struct merge_options *opt,
 		ci->match_mask = (ci->match_mask & ~ci->dirmask);
 		ci->dirmask = 0;
 		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
-			if (ci->filemask & (1 << i))
+			if (ci->filemask & (1U << i))
 				continue;
 			ci->stages[i].mode = 0;
 			oidcpy(&ci->stages[i].oid, null_oid());
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 16a8fe2f3f3..18a037a3ba8 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -265,7 +265,7 @@ static int find_lcs(xpparam_t const *xpp, xdfenv_t *env,
 	index.rcha.head = NULL;
 
 	index.table_bits = xdl_hashbits(count1);
-	index.records_size = 1 << index.table_bits;
+	index.records_size = 1U << index.table_bits;
 	if (!XDL_CALLOC_ARRAY(index.records, index.records_size))
 		goto cleanup;
 
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index c84549f6c50..18c176462ec 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -72,7 +72,7 @@ static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
 	cf->flags = flags;
 
 	cf->hbits = xdl_hashbits((unsigned int) size);
-	cf->hsize = 1 << cf->hbits;
+	cf->hsize = 1U << cf->hbits;
 
 	if (xdl_cha_init(&cf->ncha, sizeof(xdlclass_t), size / 4 + 1) < 0) {
 
@@ -174,7 +174,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 		goto abort;
 
 	hbits = xdl_hashbits((unsigned int) narec);
-	hsize = 1 << hbits;
+	hsize = 1U << hbits;
 	if (!XDL_CALLOC_ARRAY(rhash, hsize))
 		goto abort;
 

base-commit: 063bcebf0c917140ca0e705cbe0fdea127e90086
-- 
gitgitgadget
