Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF4FC43332
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD25520663
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVaBnbAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgCUSA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:00:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45986 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgCUSAY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:00:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id u59so11091130edc.12
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 11:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6+Ph8fPeEj1mOiCZYJEJURNIzieULKQ0K58PWR+HQn4=;
        b=AVaBnbAvj8o0eLxa/iR+EwCiCFO6VJb8frqdE2DZ4HLDmMpXD1UGwwtF+XlJmvfsM4
         ZCJljiZaj/+xjZpz4WPhPZ5pFo4SMs8lTYjVrsElDYQLqYOjPzWQRWxmVpaf6BZmaA6b
         5iER6Rlaesl51MyMi/xcbP8uU3IgcjyH/cMP3ZHtBzOqraOfJllfUnSrl4uDxjvXHrvD
         JadSvBgXdRptu2Y6Ll2HYGUVFy9SJiA8MMQnE8wgXvfr5SdAFhZqQ7gGvYbKAh9YqZTP
         X2mlDCnIGAxE6xd3avL8596dXUPQXBZm/CXkTdu1RQT84PW9W9Xs8yMIyO4wJH9OPnIk
         aXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6+Ph8fPeEj1mOiCZYJEJURNIzieULKQ0K58PWR+HQn4=;
        b=jpcoz7tpPzfNxVuIIJKE0HPfdtSzqy/rJX8SFqn3uVzNT0mRJNW5qZelQ4RARQFByR
         6sVEhM9BlQ9j+J8dQEg/8L0idW/R3ljTFoxh6Rm/Mo99alWRZIftsyH1HsfEHuM/Pq1H
         J5RSl03L7o3sou4E+f8anmj5CDVtWtE4Nxorr8cDnWUmeIOTLYf0ACcUxt2DOnsqTk81
         Y9pKuG35/1iRFHZNNH4uRA2vUwlcGMKU6r6vVsVmFmiDV6SPqIZQ0SLjxNj5pt4sMGqZ
         WAi0ANJUt4nEGZDuHhn4yubG7OuFAi7Pmb/9HSpggtm1uqHeFvU6c/GmEw5NsiiJhbAC
         pkpA==
X-Gm-Message-State: ANhLgQ0oCwViNZc4e24kdPDHiFm2acDBYHYYBxJuayrCBt5+c0fz5BKC
        RE+XroYguG11WYtbLSfsQplMyqTm
X-Google-Smtp-Source: ADFU+vsI94UBxkvMFmaJphvKCb1PDmGDMXIXzYcgO6LPLkfVo0pCr9xkc5PHZU93eS68r0r32ThJzQ==
X-Received: by 2002:a17:906:fc01:: with SMTP id ov1mr13602703ejb.65.1584813622260;
        Sat, 21 Mar 2020 11:00:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b20sm646700edt.93.2020.03.21.11.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 11:00:21 -0700 (PDT)
Message-Id: <f664a6dcbb3c3369aa7b94386894da1d437e3295.1584813609.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
        <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Mar 2020 18:00:07 +0000
Subject: [PATCH v2 16/18] unpack-trees: provide warnings on sparse updates for
 unmerged paths too
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When sparse-checkout runs to update the list of sparsity patterns, it
gives warnings if it can't remove paths from the working tree because
those files have dirty changes.  Add a similar warning for unmerged
paths as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1091-sparse-checkout-builtin.sh | 24 ++++++++++++++++++++++++
 unpack-trees.c                     | 30 ++++++++++++++++++++++++++++++
 unpack-trees.h                     |  1 +
 3 files changed, 55 insertions(+)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 11eb567f3fb..39093bcd5ec 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -342,6 +342,30 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status'
 	git -C dirty sparse-checkout disable
 '
 
+test_expect_success 'sparse-checkout (init|set|disable) warns with unmerged status' '
+	git clone repo unmerged &&
+
+	cat >input <<-EOF &&
+	0 0000000000000000000000000000000000000000	folder1/a
+	100644 $(git -C unmerged rev-parse HEAD:folder1/a) 1	folder1/a
+	EOF
+	git -C unmerged update-index --index-info <input &&
+
+	git -C unmerged sparse-checkout init 2>err &&
+	test_i18ngrep "warning.*The following paths are unmerged" err &&
+
+	git -C unmerged sparse-checkout set /folder2/* /deep/deeper1/* &&
+	test_i18ngrep "warning.*The following paths are unmerged" err &&
+
+	git -C unmerged sparse-checkout disable &&
+	test_i18ngrep "warning.*The following paths are unmerged" err &&
+
+	git -C unmerged reset --hard &&
+	git -C unmerged sparse-checkout init &&
+	git -C unmerged sparse-checkout set /folder2/* /deep/deeper1/* &&
+	git -C unmerged sparse-checkout disable
+'
+
 test_expect_success 'cone mode: set with core.ignoreCase=true' '
 	rm repo/.git/info/sparse-checkout &&
 	git -C repo sparse-checkout init --cone &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 7c24933016b..298241a5e0e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -52,6 +52,9 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
 	/* WARNING_SPARSE_NOT_UPTODATE_FILE */
 	"Path '%s' not uptodate; will not remove from working tree.",
 
+	/* WARNING_SPARSE_UNMERGED_FILE */
+	"Path '%s' unmerged; will not remove from working tree.",
+
 	/* WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN */
 	"Path '%s' already present; will not overwrite with sparse update.",
 };
@@ -173,6 +176,8 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 
 	msgs[WARNING_SPARSE_NOT_UPTODATE_FILE] =
 		_("The following paths are not up to date and were left despite sparse patterns:\n%s");
+	msgs[WARNING_SPARSE_UNMERGED_FILE] =
+		_("The following paths are unmerged and were left despite sparse patterns:\n%s");
 	msgs[WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN] =
 		_("The following paths were already present and thus not updated despite sparse patterns:\n%s");
 
@@ -548,6 +553,23 @@ static int apply_sparse_checkout(struct index_state *istate,
 	return 0;
 }
 
+static int warn_conflicted_path(struct index_state *istate,
+				int i,
+				struct unpack_trees_options *o)
+{
+	char *conflicting_path = istate->cache[i]->name;
+	int count = 0;
+
+	add_rejected_path(o, WARNING_SPARSE_UNMERGED_FILE, conflicting_path);
+
+	/* Find out how many higher stage entries at same path */
+	while (++count < istate->cache_nr &&
+	       !strcmp(conflicting_path,
+		       istate->cache[i+count]->name))
+		/* do nothing */;
+	return count;
+}
+
 static inline int call_unpack_fn(const struct cache_entry * const *src,
 				 struct unpack_trees_options *o)
 {
@@ -1793,6 +1815,14 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
 	for (i = 0; i < o->src_index->cache_nr; i++) {
 		struct cache_entry *ce = o->src_index->cache[i];
 
+
+		if (ce_stage(ce)) {
+			/* -1 because for loop will increment by 1 */
+			i += warn_conflicted_path(o->src_index, i, o) - 1;
+			ret = UPDATE_SPARSITY_WARNINGS;
+			continue;
+		}
+
 		if (apply_sparse_checkout(o->src_index, ce, o))
 			ret = UPDATE_SPARSITY_WARNINGS;
 
diff --git a/unpack-trees.h b/unpack-trees.h
index d91c65ae453..f970fd6c2f4 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -27,6 +27,7 @@ enum unpack_trees_error_types {
 	NB_UNPACK_TREES_ERROR_TYPES,
 
 	WARNING_SPARSE_NOT_UPTODATE_FILE,
+	WARNING_SPARSE_UNMERGED_FILE,
 	WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN,
 
 	NB_UNPACK_TREES_WARNING_TYPES,
-- 
gitgitgadget

