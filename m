Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C65C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1158C610E8
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbhI0Qfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 12:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbhI0Qfc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 12:35:32 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B512AC06176C
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a131so1027476wmd.1
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Do76wM0OPvO9kahfV2sjcKK/sz7g2IIRR/4/OtP4ObI=;
        b=qqG4XF6/XWzfjXfdqduHKNpoDkIOd2GccgwbfxNsrwmIAvk54BszB7tLhF4WuID0f5
         QLjq9PO7FVvTGEfwB9NMR5Dbw9m/7yTBh6OUg2qvVwnv0tvMBhA0hw6phFN+mg0yVnNg
         4oYI1QxXaGRqRdl4jKYolVJ9i1A6jg73qZwWt5mdMGxM7vTAu95TfL7ktOGrKKw7lcs+
         UTqbHLy3I4uUMz553Ina7WDyz6VPrWYsVce5yS2yzFvywJpNb7iCGHw9EwD0nXr1OMOS
         6HLwF7c0md1YVFTsX6j7zXYH8nW7aICb7hcLXjjHOLHZMGd32n/gRqSBnEd4xW7kQRd7
         3Ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Do76wM0OPvO9kahfV2sjcKK/sz7g2IIRR/4/OtP4ObI=;
        b=eXswiqTr5l6nONPRwUfUOb4l7gteZDb/uRL/Q2UmKtWPs5CwUuS+iBneAuBuzeFHVI
         siKxif5lb+TGxzmPUZ9c2UsWheHTgLVCxXaRPd9Svbmnc6rUd22UGJntPoTjmz7KR53d
         2n0nB0qWzFsIa9d9cZjAUwYATxtF1m2Q9XRYrGQz899pfr3LK4xLdziT6NEkw8UqkTA2
         PUipq/pAxeE3dwFrRozX08QtEe5ZuZS8libpvjIshs9nihnTpMfFoB0o6oTmsrGWJWZf
         X/KJ8v2wVRasJoIi+hbmvXpoaTh99f/0Y4d9AV1Ca614bqREiemiOwBZaZZ8rQRq+IcZ
         um9g==
X-Gm-Message-State: AOAM531+2+T6rwozbKSCPy7fGJ518xJUDwluKETyD52GQLz2chsQ2m3X
        GTsZF8es2bp+RI9dQfriSgK6lPOvV5E=
X-Google-Smtp-Source: ABdhPJwj68T3RFe1pvix1sNMqkjMNqr2DQCgaztxFjkw61dtuyVzx071AkuX83YKl4a+hhMktVvUog==
X-Received: by 2002:a05:600c:298:: with SMTP id 24mr24678wmk.18.1632760432405;
        Mon, 27 Sep 2021 09:33:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4sm3391wml.28.2021.09.27.09.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:33:52 -0700 (PDT)
Message-Id: <0d119142778dce8617dd9b2c102b5f5bfdc9dc0f.1632760428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
        <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Sep 2021 16:33:42 +0000
Subject: [PATCH v3 05/11] unpack-trees: make dir an internal-only struct
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Avoid accidental misuse or confusion over ownership by clearly making
unpack_trees_options.dir an internal-only variable.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 7 +++++--
 unpack-trees.h | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 1e4eae1dc7d..e067cce0fcd 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1694,9 +1694,12 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	static struct cache_entry *dfc;
 	struct pattern_list pl;
 	int free_pattern_list = 0;
+	struct dir_struct dir = DIR_INIT;
 
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
+	if (o->dir)
+		BUG("o->dir is for internal use only");
 
 	trace_performance_enter();
 	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
@@ -1708,7 +1711,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	}
 
 	if (!o->preserve_ignored) {
-		CALLOC_ARRAY(o->dir, 1);
+		o->dir = &dir;
 		o->dir->flags |= DIR_SHOW_IGNORED;
 		setup_standard_excludes(o->dir);
 	}
@@ -1876,7 +1879,7 @@ done:
 		clear_pattern_list(&pl);
 	if (o->dir) {
 		dir_clear(o->dir);
-		FREE_AND_NULL(o->dir);
+		o->dir = NULL;
 	}
 	trace2_region_leave("unpack_trees", "unpack_trees", the_repository);
 	trace_performance_leave("unpack_trees");
diff --git a/unpack-trees.h b/unpack-trees.h
index f98cfd49d7b..61da25dafee 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -67,7 +67,6 @@ struct unpack_trees_options {
 		     dry_run;
 	const char *prefix;
 	int cache_bottom;
-	struct dir_struct *dir;
 	struct pathspec *pathspec;
 	merge_fn_t fn;
 	const char *msgs[NB_UNPACK_TREES_WARNING_TYPES];
@@ -89,6 +88,7 @@ struct unpack_trees_options {
 	struct index_state result;
 
 	struct pattern_list *pl; /* for internal use */
+	struct dir_struct *dir; /* for internal use only */
 	struct checkout_metadata meta;
 };
 
-- 
gitgitgadget

