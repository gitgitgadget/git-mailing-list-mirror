Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9DCC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C92B46115C
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhJDBOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 21:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbhJDBNz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 21:13:55 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DA6C061780
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 18:12:07 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so17960461wmc.0
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 18:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p48KRnpOfchQnOG9X0rMF/mHh+ir0F6XO5Uhimc1rMQ=;
        b=mpfXpOit++u1zTb80HYa3P9nNaoWR+708jny3TPEVnPJLvVBoDdqOH9KtyW+gvhKUA
         0J8CEy4VeptXibC9CroYD50vH86uDwEQALyrj67+zL6KZ0EbU2Flb9q8PWagXtmrrDSV
         rM90guBv3L4XXvaW1530enDEeV66+iDWINVF4vRKBSy41LrMbBiu77syCWy1lbuXZ5Lo
         wWFVIgQGhR4+GjTZF4SDLnzWhQaj2F3BrplSdxtQAgZJKxUMhzc4puJU/ljJpqLwyOJX
         isVXQ+TaFGzvK8dZJoRCxEnahW60kzd5Yl6SLrBlvgDv7d2OyTumC3zuDDtbWOUb7LQP
         UE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p48KRnpOfchQnOG9X0rMF/mHh+ir0F6XO5Uhimc1rMQ=;
        b=79Yt7Zlmz9GZ8jtiCI7oHu+Ch3EsKHap7Nhel+2NYSaw9n7C1zOFdB7x8l4cULz/Ar
         0aleNU1QaeVVnImN2DpH8socB9THycqQDewAyrAVJCpgxbRPm1NOiQwXGflZenlOdK4Z
         8GLBGYD2vDz6JvzV+skZpoHFTC2nJtMBatRxU+p1McKImArSrfEDwLTMJqG4OdTMSeDa
         mPqJ7U4S8Xg+50iZ9Mh/nEue9YgzamRNhYp3fmvIe0p4N4Tw7lznQVg/dK9p+/vg9elx
         dR4dgFrkx0F0sJyrwKuYf7pY6G0dnCiqcY1MlicOhv/pcicJnsgALPP95kAQ/oIdi+G+
         aMkw==
X-Gm-Message-State: AOAM530vvqbuESrpbIVTjxN6WIKn0ufxrzEKUqkXrpK+gy48CFHpURIN
        2g9LQs44KXb54GNO2l/wrmE2lkzghFhPEQ==
X-Google-Smtp-Source: ABdhPJwtF8aWxusiREVsGwcdpwenQeglba029GIUvRa/NJYRrphWPr2sA5ODB2i3bY1c2W1wlDVtGQ==
X-Received: by 2002:a05:600c:1ca8:: with SMTP id k40mr15710389wms.27.1633309925528;
        Sun, 03 Oct 2021 18:12:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q3sm12384317wmc.25.2021.10.03.18.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:12:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v4 04/10] unpack-trees: rename "dir" to "private_dir"
Date:   Mon,  4 Oct 2021 03:11:53 +0200
Message-Id: <RFC-patch-v4-04.10-296c1e03673-20211004T004902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g83021034c5d
In-Reply-To: <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
References: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com> <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Until the introduction of the "preserve_ignored" flag in the preceding
commit callers who wanted its behavior needed to adjust "dir.flags"
and call setup_standard_excludes() themselves.

Now that we have no external users of "dir" anymore let's rename it to
"private_dir" and add a comment indicating that we'd like it not to be
messed with by external callers. This should avoid avoid accidental
misuse or confusion over its ownership.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 unpack-trees.c | 10 +++++-----
 unpack-trees.h |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 02bc999c6c3..512011cfa42 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -196,7 +196,7 @@ void unpack_trees_options_init(struct unpack_trees_options *o)
 void unpack_trees_options_release(struct unpack_trees_options *opts)
 {
 	strvec_clear(&opts->msgs_to_free);
-	dir_clear(&opts->dir);
+	dir_clear(&opts->private_dir);
 }
 
 static int do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
@@ -1712,8 +1712,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	}
 
 	if (!o->preserve_ignored) {
-		o->dir.flags |= DIR_SHOW_IGNORED;
-		setup_standard_excludes(&o->dir);
+		o->private_dir.flags |= DIR_SHOW_IGNORED;
+		setup_standard_excludes(&o->private_dir);
 	}
 
 	if (!core_apply_sparse_checkout || !o->update)
@@ -2141,7 +2141,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	 */
 	pathbuf = xstrfmt("%.*s/", namelen, ce->name);
 
-	d.exclude_per_dir = o->dir.exclude_per_dir;
+	d.exclude_per_dir = o->private_dir.exclude_per_dir;
 	i = read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
 	dir_clear(&d);
 	free(pathbuf);
@@ -2183,7 +2183,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 	if (ignore_case && icase_exists(o, name, len, st))
 		return 0;
 
-	if (is_excluded(&o->dir, o->src_index, name, &dtype))
+	if (is_excluded(&o->private_dir, o->src_index, name, &dtype))
 		/*
 		 * ce->name is explicitly excluded, so it is Ok to
 		 * overwrite it.
diff --git a/unpack-trees.h b/unpack-trees.h
index 65a8d99d4ef..2eb633bf771 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -70,7 +70,7 @@ struct unpack_trees_options {
 		     dry_run;
 	const char *prefix;
 	int cache_bottom;
-	struct dir_struct dir;
+	struct dir_struct private_dir; /* for internal use only */
 	struct pathspec *pathspec;
 	merge_fn_t fn;
 	const char *msgs[NB_UNPACK_TREES_WARNING_TYPES];
@@ -97,7 +97,7 @@ struct unpack_trees_options {
 
 #define UNPACK_TREES_OPTIONS_INIT { \
 	.msgs_to_free = STRVEC_INIT, \
-	.dir = DIR_INIT, \
+	.private_dir = DIR_INIT, \
 }
 void unpack_trees_options_init(struct unpack_trees_options *o);
 
-- 
2.33.0.1404.g83021034c5d

