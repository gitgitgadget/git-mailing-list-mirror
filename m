Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B455DC433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 07:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A58208DB
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 07:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESCOZUdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgIQHps (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 03:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgIQHol (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 03:44:41 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E80C06178B
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 00:44:40 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id u13so885765pgh.1
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 00:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ohlI/n/JKJljO3yX0hgsgo5XZdcGjFSecrCS1nY3RJY=;
        b=ESCOZUdmtBjzXy2puSs+wykZa4NTuv3XYAdzk6Fli5fEXoAENuiqbOuh49dBKxQfzH
         4TuIv4x4g0P1VYwJyOaZ6gTGQh6v2LfxiZIJO4YB50vvuyNgkY3TyF9QLcMWUV9EGRIz
         9XSqhQOuOuYTbWH3FnH8CMb6mE9Y3WAkGW17vHzxfyu7U7KxqBD2owfmcamrBoOlvL1w
         AkytFltFQPQPB/fIj7d2p13M6KHeLJSu+H+omkAALqsvOwU7pfnE4ovz0czpIH3yBwxq
         luzabcG+Bj5gKF+mRgzpHZ4cnjFBhx5KhPYosVRA+q5AQLtyEcWeHEORAwPgMfyfDiGc
         QNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ohlI/n/JKJljO3yX0hgsgo5XZdcGjFSecrCS1nY3RJY=;
        b=EF4XDDkCnm/4WvAL8NClBCvrwkMfQ6WU3Ah3lTunqBhEOJRvTOLh4JKAwhAX6pk/rt
         xW4Yt34mAfg8yJC09cytQaS5mK77tp4tArP5jBdb784wre7oQ2w9UZdaa0AlbPs+1sMc
         k9XSJy14UD5x9ghtpSTxMxH3ggT4xqLuwP10nRphRvyMkRivGlEYBunW87v1Hbi3ULUD
         Xd0UkkScQIJuFcEpZ4acA4VWp/m3zpZ5iMsoJEOV3P1YNXWfs4R2LBlGGUD9ADK7q26p
         8uT1nvhzZ1fFbPqiPqIdCezVQzqYifxy9r5rujTCQhcsTBCOtsi8d1FjNJdulnLhOv7m
         GTbg==
X-Gm-Message-State: AOAM531ZA2FbDZxjkZg9mCoN33L44UR5YaLy2fKIhJiUmtT/FB8jn9NA
        jiYuYUyuZkpRZcGw44SJkrX4yGdSKpbplg==
X-Google-Smtp-Source: ABdhPJxSnf10xkVSr46ovAQe2U6lBSpIFVRhIo2tJNLPUcmGsJguPg5Pt8L9eTn+URNa6irg5bb1Aw==
X-Received: by 2002:a63:1402:: with SMTP id u2mr20096391pgl.400.1600328679189;
        Thu, 17 Sep 2020 00:44:39 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id j9sm4931711pfc.175.2020.09.17.00.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 00:44:38 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 06/10] diff-lib: define diff_get_merge_base()
Date:   Thu, 17 Sep 2020 00:44:10 -0700
Message-Id: <6aac57ca022963fb41d93905e41dff36dccd5969.1600328335.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1600328335.git.liu.denton@gmail.com>
References: <cover.1599723087.git.liu.denton@gmail.com> <cover.1600328335.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, we will be using this function to implement
--merge-base functionality in various diff commands.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 diff-lib.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 diff.h     |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index 0a0e69113c..e01c3f0612 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -13,6 +13,7 @@
 #include "submodule.h"
 #include "dir.h"
 #include "fsmonitor.h"
+#include "commit-reach.h"
 
 /*
  * diff-files
@@ -518,6 +519,53 @@ static int diff_cache(struct rev_info *revs,
 	return unpack_trees(1, &t, &opts);
 }
 
+void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb)
+{
+	int i;
+	struct commit *mb_child[2] = {0};
+	struct commit_list *merge_bases;
+
+	for (i = 0; i < revs->pending.nr; i++) {
+		struct object *obj = revs->pending.objects[i].item;
+		if (obj->flags)
+			die(_("--merge-base does not work with ranges"));
+		if (obj->type != OBJ_COMMIT)
+			die(_("--merge-base only works with commits"));
+	}
+
+	/*
+	 * This check must go after the for loop above because A...B
+	 * ranges produce three pending commits, resulting in a
+	 * misleading error message.
+	 */
+	if (revs->pending.nr > ARRAY_SIZE(mb_child))
+		die(_("--merge-base does not work with more than two commits"));
+
+	for (i = 0; i < revs->pending.nr; i++)
+		mb_child[i] = lookup_commit_reference(the_repository, &revs->pending.objects[i].item->oid);
+	if (revs->pending.nr < ARRAY_SIZE(mb_child)) {
+		struct object_id oid;
+
+		if (revs->pending.nr != 1)
+			BUG("unexpected revs->pending.nr: %d", revs->pending.nr);
+
+		if (get_oid("HEAD", &oid))
+			die(_("unable to get HEAD"));
+
+		mb_child[1] = lookup_commit_reference(the_repository, &oid);
+	}
+
+	merge_bases = repo_get_merge_bases(the_repository, mb_child[0], mb_child[1]);
+	if (!merge_bases)
+		die(_("no merge base found"));
+	if (merge_bases->next)
+		die(_("multiple merge bases found"));
+
+	oidcpy(mb, &merge_bases->item->object.oid);
+
+	free_commit_list(merge_bases);
+}
+
 int run_diff_index(struct rev_info *revs, unsigned int option)
 {
 	struct object_array_entry *ent;
diff --git a/diff.h b/diff.h
index 0cc874f2d5..ae2bb7001a 100644
--- a/diff.h
+++ b/diff.h
@@ -580,6 +580,8 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc);
  */
 const char *diff_aligned_abbrev(const struct object_id *sha1, int);
 
+void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb);
+
 /* do not report anything on removed paths */
 #define DIFF_SILENT_ON_REMOVED 01
 /* report racily-clean paths as modified */
-- 
2.28.0.618.gf4bc123cb7

