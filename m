Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A47C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 14:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E8F61A55
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 14:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351945AbhI3OxC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 10:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351940AbhI3Owu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 10:52:50 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A42C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 07:51:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u18so10551141wrg.5
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 07:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qAk86aBmKlCy4z8JyEWL95ajU/tKM5J+bszwzD+1GQM=;
        b=XmCzfMXu41eGGjl1mfGJK8I0UXCHmvSyUAlMxgfF3UH1cu28cD2mqk7ALhlP7WlILZ
         hn0rDsgeg2VbcHpEgplNPMTMk2uWZ+aUqN4arBQUqw22VFwsNgo8KJypzgwlvfKruQtt
         kJvlGqFZEc91G7UqcUb1e4+pK1XvZXK4U9DRosTIUlUrP8ZlgfvJ1gu+UZMKsLILa/iA
         /tO3ig6defc3iKeryqc92nBfLv48OkH4Y+txvTkg0kH6WAE7Mqf87IYsRucy935wbUms
         WFX3/1H8MmbjpgfdIccja/6XUTq1wuq/pRCuwbGNvhx8OzMN42D4IiP+B4x6XBGdq1F5
         fDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qAk86aBmKlCy4z8JyEWL95ajU/tKM5J+bszwzD+1GQM=;
        b=gSK2j6wVH/G50f+yxf6EY0Z1wvf7NTWs5AF3K5zv0tyXUAz/bIwt5LiXktoTJ/NBzS
         rYLje/2shiM1o0ITOmcSThQUSbFZ6kq4Qnec0aLhg5Ume8R9jbowVWtFCTq3yRgghp8w
         5ZQF/41CDDOW4TNkfDHR7SuzFpbeIfN7wNz04P9LJUTYkHtH7cOv045QEtwccadqcrfg
         DOFcAomEeXrz7WGBCt73yGCUxoVm55AxgqHzfRHrvtopD/TkLcg5ARXwvro3MU3W5aoA
         qgk5zZ+Vxq3Nj/MFDDguheKZZFx63qWDCapvPqxtPi3/5lUDKli/fkp28xbc/KNUWS4n
         Pnqw==
X-Gm-Message-State: AOAM533RCON6EzMTw+2htzSjupMpcaEZs1/hOoogb2uVmAlDFOElNMoq
        LcVHb45EPq7rCksyjvGrw8dclzxAr6M=
X-Google-Smtp-Source: ABdhPJxqniqvKmHMNqrqzzQuP4zVoJ5nZcRo1XULFPw2O28mP0/+dVMqurVJApdyDYiGHhvKM4hXhw==
X-Received: by 2002:adf:9bd3:: with SMTP id e19mr772480wrc.136.1633013466614;
        Thu, 30 Sep 2021 07:51:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c132sm5120291wma.22.2021.09.30.07.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:51:06 -0700 (PDT)
Message-Id: <e7cda32efb63c63cf60513ec447418fd97ab3fa9.1633013461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Sep 2021 14:51:00 +0000
Subject: [PATCH 6/7] reset: make --mixed sparse-aware
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Sparse directory entries are "diffed" as trees in `diff_cache` (used
internally by `reset --mixed`), following a code path separate from
individual file handling. The use of `diff_tree_oid` there requires setting
explicit `change` and `add_remove` functions to process the internal
contents of a sparse directory.

Additionally, the `recursive` diff option handles cases in which `reset
--mixed` must diff/merge files that are nested multiple levels deep in a
sparse directory.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/reset.c                          | 30 +++++++++++++++++++++++-
 t/t1092-sparse-checkout-compatibility.sh | 13 +++++++++-
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 92b9a3815c7..2d95ce76f20 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -196,6 +196,8 @@ static int read_from_tree(const struct pathspec *pathspec,
 			  int intent_to_add)
 {
 	struct diff_options opt;
+	unsigned int i;
+	char *skip_worktree_seen = NULL;
 
 	memset(&opt, 0, sizeof(opt));
 	copy_pathspec(&opt.pathspec, pathspec);
@@ -203,9 +205,35 @@ static int read_from_tree(const struct pathspec *pathspec,
 	opt.format_callback = update_index_from_diff;
 	opt.format_callback_data = &intent_to_add;
 	opt.flags.override_submodule_config = 1;
+	opt.flags.recursive = 1;
 	opt.repo = the_repository;
+	opt.change = diff_change;
+	opt.add_remove = diff_addremove;
+
+	/*
+	 * When pathspec is given for resetting a cone-mode sparse checkout, it may
+	 * identify entries that are nested in sparse directories, in which case the
+	 * index should be expanded. For the sake of efficiency, this check is
+	 * overly-cautious: anything with a wildcard or a magic prefix requires
+	 * expansion, as well as literal paths that aren't in the sparse checkout
+	 * definition AND don't match any directory in the index.
+	 */
+	if (pathspec->nr && the_index.sparse_index) {
+		if (pathspec->magic || pathspec->has_wildcard) {
+			ensure_full_index(&the_index);
+		} else {
+			for (i = 0; i < pathspec->nr; i++) {
+				if (!path_in_cone_mode_sparse_checkout(pathspec->items[i].original, &the_index) &&
+				    !matches_skip_worktree(pathspec, i, &skip_worktree_seen)) {
+					ensure_full_index(&the_index);
+					break;
+				}
+			}
+		}
+	}
+
+	free(skip_worktree_seen);
 
-	ensure_full_index(&the_index);
 	if (do_diff_cache(tree_oid, &opt))
 		return 1;
 	diffcore_std(&opt);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 0b6ff0de17d..c9b9ef4992c 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -801,14 +801,25 @@ test_expect_success 'sparse-index is not expanded' '
 	for ref in update-deep update-folder1 update-folder2 update-deep
 	do
 		echo >>sparse-index/README.md &&
+		ensure_not_expanded reset --mixed $ref
 		ensure_not_expanded reset --hard $ref || return 1
 	done &&
 
 	ensure_not_expanded reset --hard update-deep &&
 	ensure_not_expanded reset --keep base &&
 	ensure_not_expanded reset --merge update-deep &&
-	ensure_not_expanded reset --hard &&
 
+	ensure_not_expanded reset base -- deep/a &&
+	ensure_not_expanded reset base -- nonexistent-file &&
+	ensure_not_expanded reset deepest -- deep &&
+
+	# Although folder1 is outside the sparse definition, it exists as a
+	# directory entry in the index, so it will be reset without needing to
+	# expand the full index.
+	ensure_not_expanded reset --hard update-folder1 &&
+	ensure_not_expanded reset base -- folder1 &&
+
+	ensure_not_expanded reset --hard update-deep &&
 	ensure_not_expanded checkout -f update-deep &&
 	test_config -C sparse-index pull.twohead ort &&
 	(
-- 
gitgitgadget

