Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39F4C2D0A3
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 862B622245
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGTKZYZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgKBUoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgKBUn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:43:59 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB710C061A04
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:43:59 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id u127so16032470oib.6
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=llZ/sYfVCTbOwTTD+7xVMPnkot9bZxKUdVwXEV8C+tY=;
        b=nGTKZYZWugCu6ZXce2+hMQupvtdQ3ut3YdN45g7JxeyGaA0SiDA2OXKp1dvZaw9RqG
         TqISG1Ul6TgvTOCxF5n4rGSlIUdx9k0+zS0QEZsn3hajYdmQzpuArQ22dC2ii/4H4sBz
         P1RUlJ0uL9BERMbR7tuxiZBMWeRXsCLnq5DIzKyXcuzHr9cx6RajG3zBj00ZAzGPbm5P
         E/eEg2uDWwDAKSveODDLrHMdZMiDDe7/Ed/6VLTiEEyW8nIPmYveNZg5c+YcJVTESlnM
         evCumiYc70KOgIkcTDN4FxbUn3Zd1B/GDAe8TnWwEmdoFD8bQgvtWRRYUQVrCsSRYJ96
         cpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=llZ/sYfVCTbOwTTD+7xVMPnkot9bZxKUdVwXEV8C+tY=;
        b=EzzXsJ/ca47+oIapDSkI6QRbT8ebVX25WyByZCi69mht2kInuS9TL0JhTF36nzQS1c
         zrs+NmeoXBr90w3dBJxUH4FROd+VSQ00DgwHQXgz/STF+UsGMJyi8tOJ2hkWEfL3YVRM
         IYf9Omuk3wSdBr1K41qeVDROSOrUN4/nxMAvZhOlT/g52EWuuFlA+Ib0psd5wwMyuyw6
         3E7kGhxqt9Ru+t+8CF1IvFhua2f+NDzYyIqhsFbS19SvDmXV9rEilQTse5/iqDw9Fp0M
         kHkQFKt3IFoUuv/l0Ctd4sYLwz2cyvgB+TELuMHTqKX3iKeGcatPiCO1KFOuie12oDng
         xpcA==
X-Gm-Message-State: AOAM533IPlj02vvNJ4mFEGHwp6S6yfYF7OYSdeXCCfBeF2l3oB075gVc
        iVvIlz1rrBLtnU/0vy1a/KxvQi/luw2spg==
X-Google-Smtp-Source: ABdhPJybBTiGRTl1nuA7+7n0P/izuqr8POkj8l3ouxNIvW2LTT6XKwbCJmpMQidGQbwSSxUOGUZNeA==
X-Received: by 2002:aca:ab91:: with SMTP id u139mr6513oie.28.1604349838816;
        Mon, 02 Nov 2020 12:43:58 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id t27sm3848512otc.14.2020.11.02.12.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:43:58 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 09/20] merge-ort: record stage and auxiliary info for every path
Date:   Mon,  2 Nov 2020 12:43:33 -0800
Message-Id: <20201102204344.342633-10-newren@gmail.com>
X-Mailer: git-send-email 2.29.0.471.ga4f56089c0
In-Reply-To: <20201102204344.342633-1-newren@gmail.com>
References: <20201102204344.342633-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a helper function, setup_path_info(), which can be used to record
all the information we want in a merged_info or conflict_info.  While
there is currently only one caller of this new function, and some of its
particular parameters are fixed, future callers of this function will be
added later.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 0ff90981cf..bef3c648a0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -77,6 +77,51 @@ static int err(struct merge_options *opt, const char *err, ...)
 	return -1;
 }
 
+static void setup_path_info(struct merge_options *opt,
+			    struct string_list_item *result,
+			    const char *current_dir_name,
+			    int current_dir_name_len,
+			    char *fullpath, /* we'll take over ownership */
+			    struct name_entry *names,
+			    struct name_entry *merged_version,
+			    unsigned is_null,     /* boolean */
+			    unsigned df_conflict, /* boolean */
+			    unsigned filemask,
+			    unsigned dirmask,
+			    int resolved          /* boolean */)
+{
+	struct conflict_info *path_info;
+
+	assert(!is_null || resolved);
+	assert(!df_conflict || !resolved); /* df_conflict implies !resolved */
+	assert(resolved == (merged_version != NULL));
+
+	path_info = xcalloc(1, resolved ? sizeof(struct merged_info) :
+					  sizeof(struct conflict_info));
+	path_info->merged.directory_name = current_dir_name;
+	path_info->merged.basename_offset = current_dir_name_len;
+	path_info->merged.clean = !!resolved;
+	if (resolved) {
+		path_info->merged.result.mode = merged_version->mode;
+		oidcpy(&path_info->merged.result.oid, &merged_version->oid);
+		path_info->merged.is_null = !!is_null;
+	} else {
+		int i;
+
+		for (i = 0; i < 3; i++) {
+			path_info->pathnames[i] = fullpath;
+			path_info->stages[i].mode = names[i].mode;
+			oidcpy(&path_info->stages[i].oid, &names[i].oid);
+		}
+		path_info->filemask = filemask;
+		path_info->dirmask = dirmask;
+		path_info->df_conflict = !!df_conflict;
+	}
+	strmap_put(&opt->priv->paths, fullpath, path_info);
+	result->string = fullpath;
+	result->util = path_info;
+}
+
 static int collect_merge_info_callback(int n,
 				       unsigned long mask,
 				       unsigned long dirmask,
@@ -91,10 +136,12 @@ static int collect_merge_info_callback(int n,
 	 */
 	struct merge_options *opt = info->data;
 	struct merge_options_internal *opti = opt->priv;
-	struct conflict_info *ci;
+	struct string_list_item pi;  /* Path Info */
+	struct conflict_info *ci; /* pi.util when there's a conflict */
 	struct name_entry *p;
 	size_t len;
 	char *fullpath;
+	const char *dirname = opti->current_dir_name;
 	unsigned filemask = mask & ~dirmask;
 	unsigned match_mask = 0; /* will be updated below */
 	unsigned mbase_null = !(mask & 1);
@@ -157,13 +204,13 @@ static int collect_merge_info_callback(int n,
 	make_traverse_path(fullpath, len+1, info, p->path, p->pathlen);
 
 	/*
-	 * TODO: record information about the path other than all zeros,
-	 * so we can resolve later in process_entries.
+	 * Record information about the path so we can resolve later in
+	 * process_entries.
 	 */
-	ci = xcalloc(1, sizeof(struct conflict_info));
-	ci->df_conflict = df_conflict;
+	setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
+			names, NULL, 0, df_conflict, filemask, dirmask, 0);
+	ci = pi.util;
 	ci->match_mask = match_mask;
-	strmap_put(&opti->paths, fullpath, ci);
 
 	/* If dirmask, recurse into subdirectories */
 	if (dirmask) {
@@ -204,7 +251,7 @@ static int collect_merge_info_callback(int n,
 		}
 
 		original_dir_name = opti->current_dir_name;
-		opti->current_dir_name = fullpath;
+		opti->current_dir_name = pi.string;
 		ret = traverse_trees(NULL, 3, t, &newinfo);
 		opti->current_dir_name = original_dir_name;
 
-- 
2.29.0.471.ga4f56089c0

