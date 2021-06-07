Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5601BC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A75E61057
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhFGMhb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:37:31 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:36711 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhFGMh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 08:37:27 -0400
Received: by mail-wr1-f41.google.com with SMTP id e11so7207299wrg.3
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 05:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=smXFtkXovHCA1EwmRIxXBky+6I9XveV7+FJ/L5SZCoA=;
        b=B0qBX+SwaT3QwgkMcHoHJJaTi4wJnnh98nD2qWhHe9PcSNUbL6i54NhterlKPmPZU2
         vAYl3Gs2QV9TAdKskErs7txesfdi3CVYSuhY3XnXYF6UlQCdta+7FBYxwlecDTih6oUZ
         Rnmkzpi3dATN/w8GcVM1a4mWkHFTGV2C5ccLESSX0BGb6jqKinoIVk8h7nTvxN631HcM
         mvdTnRen/e2l7tukY1mpm7d6hKb+/a6XA1YBPpsekLjRRZN1BYFyJvBiWzZja8ySNb/2
         uE2zIjQu7vesMs3M+yAyiED//ief3xlh9PDeeod2piwKdT57i7gRJ5AiQrb9FT64iBvR
         Jvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=smXFtkXovHCA1EwmRIxXBky+6I9XveV7+FJ/L5SZCoA=;
        b=tj3FQ67eurM1oeSL9oS7tOamIoJti76D/bxyVX/YEpusJsDZtNmxcXcu5iZO7N+Zdf
         bLK5M7GDeAA333UVnykdMzWtItHUWsCXXBQYRBArw758xia8KSWgPcOIFXP2Ovum7OtF
         ceEwQlpfohNHyiIGcFyDaWv//M7mpczDolxKp2toI/VMEEPXWLLa/rV+eqMll3ZC4qAQ
         WAkONepSNREgD4qgevedDo4fJJbOphQ08Fi9wwRlsuYM1EDHpyNnH9BqKVccE4/1puJR
         degBsXajQDBQELARrlnoaw50NtH/jAcMsHWBxg0iWuCQo6GibrU4KrKYcDtb4o8y0y5L
         YwQQ==
X-Gm-Message-State: AOAM532KUJeH5joSYr+zT/+cwQ/hjOV15z2mLZgCXYLbJJXiaHFmClbX
        mYmU7LAReOClMJWbMc0BSLbYqAMnAGM=
X-Google-Smtp-Source: ABdhPJxgX82AIdCUTO2sGjpW4lWUd1o7zMbpRmgtRH1K2AXj7Y8CqCuUqRkb8wrAAfLEssgxoW9myw==
X-Received: by 2002:a5d:64a4:: with SMTP id m4mr6327797wrp.185.1623069261784;
        Mon, 07 Jun 2021 05:34:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17sm7062915wrp.36.2021.06.07.05.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 05:34:21 -0700 (PDT)
Message-Id: <02f2c7b63982cfbafc300e1cd901473d5b9b7297.1623069253.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
        <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 12:34:11 +0000
Subject: [PATCH v5 13/14] wt-status: expand added sparse directory entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

It is difficult, but possible, to get into a state where we intend to
add a directory that is outside of the sparse-checkout definition. Add a
test to t1092-sparse-checkout-compatibility.sh that demonstrates this
using a combination of 'git reset --mixed' and 'git checkout --orphan'.

This test failed before because the output of 'git status
--porcelain=v2' would not match on the lines for folder1/:

* The sparse-checkout repo (with a full index) would output each path
  name that is intended to be added.

* The sparse-index repo would only output that "folder1/" is staged for
  addition.

The status should report the full list of files to be added, and so this
sparse-directory entry should be expanded to a full list when reaching
it inside the wt_status_collect_changes_initial() method. Use
read_tree_at() to assist.

Somehow, this loop over the cache entries was not guarded by
ensure_full_index() as intended.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 36 +++++++++++++++++
 wt-status.c                              | 50 ++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 099dc2bf440f..39b86fbe2be6 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -521,4 +521,40 @@ test_expect_success 'sparse-index is not expanded' '
 	test_region ! index ensure_full_index trace2.txt
 '
 
+test_expect_success 'reset mixed and checkout orphan' '
+	init_repos &&
+
+	test_all_match git checkout rename-out-to-in &&
+
+	# Sparse checkouts do not agree with full checkouts about
+	# how to report a directory/file conflict during a reset.
+	# This command would fail with test_all_match because the
+	# full checkout reports "T folder1/0/1" while a sparse
+	# checkout reports "D folder1/0/1". This matches because
+	# the sparse checkouts skip "adding" the other side of
+	# the conflict.
+	test_sparse_match git reset --mixed HEAD~1 &&
+	test_sparse_match test-tool read-cache --table --expand &&
+	test_sparse_match git status --porcelain=v2 &&
+	test_sparse_match git status --porcelain=v2 &&
+
+	# At this point, sparse-checkouts behave differently
+	# from the full-checkout.
+	test_sparse_match git checkout --orphan new-branch &&
+	test_sparse_match test-tool read-cache --table --expand &&
+	test_sparse_match git status --porcelain=v2 &&
+	test_sparse_match git status --porcelain=v2
+'
+
+test_expect_success 'add everything with deep new file' '
+	init_repos &&
+
+	run_on_sparse git sparse-checkout set deep/deeper1/deepest &&
+
+	run_on_all touch deep/deeper1/x &&
+	test_all_match git add . &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git status --porcelain=v2
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index 0425169c1895..90db8bd659fa 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -654,6 +654,34 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	run_diff_index(&rev, 1);
 }
 
+static int add_file_to_list(const struct object_id *oid,
+			    struct strbuf *base, const char *path,
+			    unsigned int mode, void *context)
+{
+	struct string_list_item *it;
+	struct wt_status_change_data *d;
+	struct wt_status *s = context;
+	char *full_name;
+
+	if (S_ISDIR(mode))
+		return READ_TREE_RECURSIVE;
+
+	full_name = xstrfmt("%s%s", base->buf, path);
+	it = string_list_insert(&s->change, full_name);
+	d = it->util;
+	if (!d) {
+		CALLOC_ARRAY(d, 1);
+		it->util = d;
+	}
+
+	d->index_status = DIFF_STATUS_ADDED;
+	/* Leave {mode,oid}_head zero for adds. */
+	d->mode_index = mode;
+	oidcpy(&d->oid_index, oid);
+	s->committable = 1;
+	return 0;
+}
+
 static void wt_status_collect_changes_initial(struct wt_status *s)
 {
 	struct index_state *istate = s->repo->index;
@@ -668,6 +696,28 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 			continue;
 		if (ce_intent_to_add(ce))
 			continue;
+		if (S_ISSPARSEDIR(ce->ce_mode)) {
+			/*
+			 * This is a sparse directory entry, so we want to collect all
+			 * of the added files within the tree. This requires recursively
+			 * expanding the trees to find the elements that are new in this
+			 * tree and marking them with DIFF_STATUS_ADDED.
+			 */
+			struct strbuf base = STRBUF_INIT;
+			struct pathspec ps;
+			struct tree *tree = lookup_tree(istate->repo, &ce->oid);
+
+			memset(&ps, 0, sizeof(ps));
+			ps.recursive = 1;
+			ps.has_wildcard = 1;
+			ps.max_depth = -1;
+
+			strbuf_add(&base, ce->name, ce->ce_namelen);
+			read_tree_at(istate->repo, tree, &base, &ps,
+				     add_file_to_list, s);
+			continue;
+		}
+
 		it = string_list_insert(&s->change, ce->name);
 		d = it->util;
 		if (!d) {
-- 
gitgitgadget

