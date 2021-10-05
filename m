Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C5DC433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 13:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81F0761090
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 13:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbhJENXA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 09:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbhJENWx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 09:22:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490C0C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 06:21:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a11-20020a7bc1cb000000b0030d6aae48b5so2873679wmj.4
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 06:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eqLVmiatgqvUMXys9C2h3HzvqIRcQW4fhYbW7/JKGVE=;
        b=mu6dwm9zYmDsFZ4K8P0H8ZbQRP6mtjIChGKvRTJ0d1jhDVEeDVpPai5PXqLH60tuhK
         ZD2OXF2ausuD4kYbf77uxP4FXwtDxGopDtTL6/IUZHwIYWBt+p8FpdIX8jIGRVzak9Qd
         cCB3hNzOK8WQODg6zA9JEOHkEoKpWBT5hQw3iZMxkcPfy48filpuDQ9g8tdR7A6h1aGt
         snJwVrIcvu/SZTjKuQ3OhxwFruNbwcoJr7aqGi2m9loA+F/G7eHOcrgLn/YeGRiXiJFd
         ZFVxhdEIGXGG6zN9BreksWN1cq1kJSxS2WKM8sjgdyKqsRlgC1CjeP8ADCk2RHHlPegD
         JiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eqLVmiatgqvUMXys9C2h3HzvqIRcQW4fhYbW7/JKGVE=;
        b=LYIZJh+0qztlyIrGBa+VanA1eJXLYyxMGFmbnXSHJ7v4cRXVWJxxBmHMqQM6R4JRMV
         FL03efGFJXTS+9AxriHcTfQ4ui9/NbrNYAN6ySYNT1FktFi8lBvVFkbEq3ThIZKfYF9i
         jqYs6SdF9Yw82k8/dKsLeGl3BSngBjt7fbwtK+exsUAVu8KoZ1cf1H6q2m9iM3NaOksT
         wXpG1KrljGCqDgFLH4XpoLubUaipr4AG/MNSLfhZXTcUupSRfAzgEpK4Q1ORVtVBxo1d
         8CVX/iseyTts6JiYtlXeKcK9EcnGY86V2aaYYsPwmZTZ9MXxseGrpt4uNvWhlCnFV2ig
         M3YA==
X-Gm-Message-State: AOAM530jKEgTd6z9FHkn0Ytwd7aNKYWP7tMdv1snRB9WuJX+/tRzQGBI
        981aalhsSqcW3z57/l+pL/DYxDgZmT4=
X-Google-Smtp-Source: ABdhPJx167pMQcEXwAgEnGCzwfc0xzlCCMkMwRiQxcOPAzFPbfBFjRA3am433/PjycRAofyY0MkGTg==
X-Received: by 2002:a05:600c:a49:: with SMTP id c9mr3336100wmq.159.1633440061951;
        Tue, 05 Oct 2021 06:21:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e15sm1267767wrr.38.2021.10.05.06.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 06:21:01 -0700 (PDT)
Message-Id: <5eaae0825af4cee84040b784c32190bb1de2f919.1633440057.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
        <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Oct 2021 13:20:56 +0000
Subject: [PATCH v2 6/7] reset: make --mixed sparse-aware
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
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
index e1f2a2bb2c4..ceb9b122897 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -175,6 +175,8 @@ static int read_from_tree(const struct pathspec *pathspec,
 			  int intent_to_add)
 {
 	struct diff_options opt;
+	unsigned int i;
+	char *skip_worktree_seen = NULL;
 
 	memset(&opt, 0, sizeof(opt));
 	copy_pathspec(&opt.pathspec, pathspec);
@@ -182,9 +184,35 @@ static int read_from_tree(const struct pathspec *pathspec,
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
index e301ef5633a..4afcbc2d673 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -804,11 +804,22 @@ test_expect_success 'sparse-index is not expanded' '
 		ensure_not_expanded reset --hard $ref || return 1
 	done &&
 
+	ensure_not_expanded reset --mixed base &&
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

