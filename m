Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506CCC433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 14:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36BC460F56
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 14:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242637AbhJ0OmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 10:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238962AbhJ0Olz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 10:41:55 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BB8C061767
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 07:39:29 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y205-20020a1c7dd6000000b0032cc8c2800fso5582869wmc.4
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 07:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+dch2aTLAv85TXXA5lgJ4m8qNH4dps5WqL8q9u/O5kk=;
        b=bII53/sIC1NfTxjRcrbZJCY9Z2EUfYZpA4UyFtuBmOTn/tFHLtHEF437rmdKG/QrQ0
         fxPJH8Dg/9p0uc8onsLJFZCGMTbTliGwmsQsIHr2XLEveU+VxuRxCxTT7+BB8H68TVl5
         r/lS6wubgw4sU2yekqr+XBIVrsbi2RWaXWpMtw84kFeeGNd539ME+6xBsrCpmqQTQwyL
         pWD1OMg/DP6KLMiFdDMdYHMPSl1839nhnqDJLitjGmqafNY338BXHfwDa2RCXVDawEEk
         k053FodA6GQj1WMeP6oXZDtC3OYencTexfMUb2qjpatH7c5540gbqWmYoqlePVVFMdJG
         a6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+dch2aTLAv85TXXA5lgJ4m8qNH4dps5WqL8q9u/O5kk=;
        b=FnkzsOeJ5puwM3h3iSCSyc+W9ErNsRJ102KlFp/EtRvawYMdCkJsHcHo3X9/iG+Cum
         URdST+9PPmxDRerMKTfGW7uA8q1955R5+zadqjXnKo+f10FvghvrspsEyhVQNfVMvAcp
         0Jrs2+JPo2xzGZx5Ye2e7n9sYXNqzFBwRyqIqeo2cLhpqp0GpzQ/WhoknBSi6RjGa8dR
         R4HvzLngUI45bdnAYmHGqcMNyFJvQWZ3mJyNdQ+73qaM3xL/F7847Gc0jJ3wn/qemRX1
         NXmA+cN+oQ1NjvwUp45hSpHGDa8jYS+9ei+1rqnljYbiy/q9xe8viYG6BCMjPitAsm48
         ISMQ==
X-Gm-Message-State: AOAM532JdASlEJS63gYb9sE09Ud639SMo7UvarkWOeIOXyXi8DmD+r08
        YdjyqJ5aTYKjXkZ4A280VxDMKTwGjj0=
X-Google-Smtp-Source: ABdhPJwGDuazfhjwHma73IE6kKyPfisW7FuWVnRZJvvsf7b7qaN/lJUvz5WshWqY2d5G5BHZziLmUg==
X-Received: by 2002:a7b:cc8c:: with SMTP id p12mr2477701wma.158.1635345567599;
        Wed, 27 Oct 2021 07:39:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o2sm85031wrg.1.2021.10.27.07.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 07:39:27 -0700 (PDT)
Message-Id: <217ae44541878b712b45db9525a6de5b854f27bb.1635345563.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
References: <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
        <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 14:39:20 +0000
Subject: [PATCH v5 5/8] reset: integrate with sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Disable `command_requires_full_index` repo setting and add
`ensure_full_index` guards around code paths that cannot yet use sparse
directory index entries. `reset --soft` does not modify the index, so no
compatibility changes are needed for it to function without expanding the
index. For all other reset modes (`--mixed`, `--hard`, `--keep`, `--merge`),
the full index is expanded to prevent cache tree corruption and invalid
variable accesses.

Additionally, the `read_cache()` check verifying an uncorrupted index is
moved after argument parsing and preparing the repo settings. The index is
not used by the preceding argument handling, but `read_cache()` must be run
*after* enabling sparse index for the command (so that the index is not
expanded unnecessarily) and *before* using the index for reset (so that it
is verified as uncorrupted).

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/reset.c | 10 +++++++---
 cache-tree.c    |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index e441b6601b9..0ac0de7dc97 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -180,6 +180,7 @@ static int read_from_tree(const struct pathspec *pathspec,
 	opt.flags.override_submodule_config = 1;
 	opt.repo = the_repository;
 
+	ensure_full_index(&the_index);
 	if (do_diff_cache(tree_oid, &opt))
 		return 1;
 	diffcore_std(&opt);
@@ -257,9 +258,6 @@ static void parse_args(struct pathspec *pathspec,
 	}
 	*rev_ret = rev;
 
-	if (read_cache() < 0)
-		die(_("index file corrupt"));
-
 	parse_pathspec(pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
 		       (patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0),
@@ -405,6 +403,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (intent_to_add && reset_type != MIXED)
 		die(_("-N can only be used with --mixed"));
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
+	if (read_cache() < 0)
+		die(_("index file corrupt"));
+
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset
 	 * the index file to the tree object we are switching to. */
diff --git a/cache-tree.c b/cache-tree.c
index 90919f9e345..9be19c85b66 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -776,6 +776,7 @@ void prime_cache_tree(struct repository *r,
 	cache_tree_free(&istate->cache_tree);
 	istate->cache_tree = cache_tree();
 
+	ensure_full_index(istate);
 	prime_cache_tree_rec(r, istate->cache_tree, tree);
 	istate->cache_changed |= CACHE_TREE_CHANGED;
 	trace2_region_leave("cache-tree", "prime_cache_tree", the_repository);
-- 
gitgitgadget

