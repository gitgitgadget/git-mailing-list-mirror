Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32F8C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF5560F21
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhJKUce (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 16:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbhJKUc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 16:32:29 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792E3C061749
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 13:30:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r18so59983373wrg.6
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 13:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+dch2aTLAv85TXXA5lgJ4m8qNH4dps5WqL8q9u/O5kk=;
        b=J9SA2mkxmgHUu2WWyukME+Czy1HiZvCkLyEg61TLRDoAux5vodZRRofa2+BQiWKyzO
         UciiFX9TSzIIXMwVvrVxzUdFlh/Pxd+0fiz9UBeStAjxTtNM5RWlzOMovOvP1xB27/VW
         n9SW8m9+f/0MSYlJt35YATikOcUYugKvMJGuG1oEw4vcwnK1gPpD0q/c+Z6Qhd4BfCrR
         tmZJDm4x5hbsLSE2R2Wvd3EAqrGMw3PHm19oIiqVyPXvWLMw4MmtL7dIJEDo1fwjYvWJ
         O03Vooi+2ARu2i6OBZp3hZVU4riRMNxpS+X2OoFsCdD5mxW9NFR/3S2CLTXd9GTmUbXc
         I/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+dch2aTLAv85TXXA5lgJ4m8qNH4dps5WqL8q9u/O5kk=;
        b=GFXRRc7mJgX6U3lkxtyu4Z35wjR2AF2jDBW4O5hVnshpOCwBn7R0L2PDOBLX2VvVdL
         lEs+FCGIBMa9YNWSJHt05RgYQKbUNBcmMRMxtBmYWSnAq41UX2N5bkLS4/zcxBgl+kyY
         4YWSrY5KV5bb7WW/BFMkgjRHlllNs92I2ExEkd+OtSKGoy1qgbjzKUtS3f3Sh1z8TgKz
         u/Kws4zTlQHAczi/TOzfEKKq9UfoGFNe780HNgeVN8uqZ9CxKkTyIyemBBkDtXOWbOSY
         XXEAOhihDyspagG26hthcQBLpcTf0AyqP3r4y3x7I9NDI9n7UW/oJbbJQqvL3U1UD0Wv
         MlBA==
X-Gm-Message-State: AOAM533xCvS8GwJVL331qG4izDvlj9bL4m5IZRFB6NZbs0zlCO1ylDV5
        7W4DugL2CJyo0/1rB576tvSFkoBn61c=
X-Google-Smtp-Source: ABdhPJxxfKqcBNgIFdZRWNbyMMkF57Iz5iYGXnlxuz+ub5ZhlNOvBkIoRfYs+KX5p75lCix1Ktcdlg==
X-Received: by 2002:adf:b350:: with SMTP id k16mr26740077wrd.368.1633984227065;
        Mon, 11 Oct 2021 13:30:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v4sm490517wmh.23.2021.10.11.13.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 13:30:26 -0700 (PDT)
Message-Id: <62fdbf2ad261e5820d42590100d38972c6d5e490.1633984222.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
References: <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
        <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 Oct 2021 20:30:19 +0000
Subject: [PATCH v4 5/8] reset: integrate with sparse index
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

