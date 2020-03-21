Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506BFC4332D
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0E720663
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvSkiuES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgCUSA2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:00:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40483 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbgCUSA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:00:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id w26so4785073edu.7
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 11:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bmN3sd17HaFUpvR96N6/ugb3XtLrD8Rkn7fgln3YO5E=;
        b=fvSkiuESyOpq0ZXHPEP/bnt9aPDFEAVIAwItmINB95x38JmHbc7QQjJNfNtP39BKZi
         47qdmXGivbMOJJIBxbdHhCnamU0N0jbe3G/SmSkYRO6O5bK4O5R7dhPRI8l9Me6ad1A/
         4/JO5hLXbmFHnOMR+QwFR0t69Tff2kvTUTvZZMSQA840SabgP2xlwqJ+O3i0Yj4almyD
         AW4Me4Bs53QoNM3OG9lHTBfMGZSopnjANqBM/YZIAHgrdSOK/K9DkjOb8hX9kWfExqaQ
         TjWWzRVBqYW/Dc29FuDzW6higbAOI1Cp3r9STSWJdywqDB/SAci8zKgD5dHkYhdye3aq
         HNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bmN3sd17HaFUpvR96N6/ugb3XtLrD8Rkn7fgln3YO5E=;
        b=kcPj6Z5vSjEJ8BdB9hZ7Rjx9Zj3UfYKnVuDi258Ys1o6xoWg2c+/lGdorefg5jqJIb
         Y3xzSAA4ubs4NRFnCvi/G0ISvdhYpQKNWFMix30c8iX9HPzqUenaY+GM7HPesxOkW96R
         siFPIfxP2Z7BjpioUCaeFIWa0zH8CH+/2CSoCYh1rcoMKUN5U1mMDgwvPugs4n6up5ei
         MNk+JhqHUAIf/kw8L0vc5BEgx8qgrQXEyirbOlbMR55jHsAb7ria1mm46FPBLuccIl7j
         ehCttA7g+grvSWlgXwbCoJT+Z+nyjJ6Rbk6tkCu1Ygo2wrUH4MY+31QPsIy/txzAQqEN
         nRVA==
X-Gm-Message-State: ANhLgQ0peLquMn61yqCpwHF4dFRcxou0GkAwosC55/VlfLuxryOm4KJq
        h4hwCh8A21V556A8wthRaWZzQ4E/
X-Google-Smtp-Source: ADFU+vuWuf9IZgOOddKt+YbWbXTvwg5mAl8V3i6yyabsC7h3l3HpzIjeheywRzH3zEntUgciq7snuw==
X-Received: by 2002:a05:6402:2cd:: with SMTP id b13mr13813714edx.68.1584813623205;
        Sat, 21 Mar 2020 11:00:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 94sm626653eda.7.2020.03.21.11.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 11:00:22 -0700 (PDT)
Message-Id: <fa997a1c72f8ff15a6487475679ad9d20a9d3a0e.1584813609.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
        <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Mar 2020 18:00:08 +0000
Subject: [PATCH v2 17/18] unpack-trees: failure to set SKIP_WORKTREE bits
 always just a warning
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

Setting and clearing of the SKIP_WORKTREE bit is not only done when
users run 'sparse-checkout'; other commands such as 'checkout' also run
through unpack_trees() which has logic for handling this special bit.
As such, we need to consider how they handle special cases.  A couple
comparison points should help explain the rationale for changing how
unpack_trees() handles these bits:

    Ignoring sparse checkouts for a moment, if you are switching
    branches and have dirty changes, it is only considered an error that
    will prevent the branch switching from being successful if the dirty
    file happens to be one of the paths with different contents.

    SKIP_WORKTREE has always been considered advisory; for example, if
    rebase or merge need or even want to materialize a path as part of
    their work, they have always been allowed to do so regardless of the
    SKIP_WORKTREE setting.  This has been used for unmerged paths, but
    it was often used for paths it wasn't needed just because it made
    the code simpler.  It was a best-effort consideration, and when it
    materialized paths contrary to the SKIP_WORKTREE setting, it was
    never required to even print a warning message.

In the past if you trying to run e.g. 'git checkout' and:
  1) you had a path that was materialized and had some dirty changes
  2) the path was listed in $GITDIR/info/sparse-checkout
  3) this path did not different between the current and target branches
then despite the comparison points above, the inability to set
SKIP_WORKTREE was treated as a *hard* error that would abort the
checkout operation.  This is completely inconsistent with how
SKIP_WORKTREE is handled elsewhere, and rather annoying for users as
leaving the paths materialized in the working copy (with a simple
warning) should present no problem at all.

Downgrade any errors from inability to toggle the SKIP_WORKTREE bit to a
warning and allow the operations to continue.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1011-read-tree-sparse-checkout.sh | 11 +++++-----
 t/t2018-checkout-branch.sh           | 22 ++++++++++++++++++++
 unpack-trees.c                       | 31 ++++++++++++++--------------
 3 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index eb44bafb593..63223e13bd1 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -233,18 +233,19 @@ test_expect_success 'read-tree --reset removes outside worktree' '
 	test_must_be_empty result
 '
 
-test_expect_success 'print errors when failed to update worktree' '
+test_expect_success 'print warnings when some worktree updates disabled' '
 	echo sub >.git/info/sparse-checkout &&
 	git checkout -f init &&
 	mkdir sub &&
 	touch sub/added sub/addedtoo &&
-	test_must_fail git checkout top 2>actual &&
+	# Use -q to suppress "Previous HEAD position" and "Head is now at" msgs
+	git checkout -q top 2>actual &&
 	cat >expected <<\EOF &&
-error: The following untracked working tree files would be overwritten by checkout:
+warning: The following paths were already present and thus not updated despite sparse patterns:
 	sub/added
 	sub/addedtoo
-Please move or remove them before you switch branches.
-Aborting
+
+After fixing the above paths, you may want to run `git sparse-checkout reapply`.
 EOF
 	test_i18ncmp expected actual
 '
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index bbca7ef8da6..21583154d8e 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -238,4 +238,26 @@ test_expect_success 'checkout -b after clone --no-checkout does a checkout of HE
 	test_path_is_file dest/a.t
 '
 
+test_expect_success 'checkout -b to a new branch preserves mergeable changes despite sparse-checkout' '
+	test_when_finished "
+		git reset --hard &&
+		git checkout branch1-scratch &&
+		test_might_fail git branch -D branch3 &&
+		git config core.sparseCheckout false &&
+		rm .git/info/sparse-checkout" &&
+
+	test_commit file2 &&
+
+	echo stuff >>file1 &&
+	echo file2 >.git/info/sparse-checkout &&
+	git config core.sparseCheckout true &&
+
+	CURHEAD=$(git rev-parse HEAD) &&
+	do_checkout branch3 $CURHEAD &&
+
+	echo file1 >expect &&
+	git diff --name-only >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 298241a5e0e..cab2177c951 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1701,23 +1701,15 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 			 * correct CE_NEW_SKIP_WORKTREE
 			 */
 			if (ce->ce_flags & CE_ADDED &&
-			    verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o)) {
-				if (!o->show_all_errors)
-					goto return_failed;
-				ret = -1;
-			}
+			    verify_absent(ce, WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN, o))
+				ret = 1;
+
+			if (apply_sparse_checkout(&o->result, ce, o))
+				ret = 1;
 
-			if (apply_sparse_checkout(&o->result, ce, o)) {
-				if (!o->show_all_errors)
-					goto return_failed;
-				ret = -1;
-			}
 			if (!ce_skip_worktree(ce))
 				empty_worktree = 0;
-
 		}
-		if (ret < 0)
-			goto return_failed;
 		/*
 		 * Sparse checkout is meant to narrow down checkout area
 		 * but it does not make sense to narrow down to empty working
@@ -1728,6 +1720,15 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 			ret = unpack_failed(o, "Sparse checkout leaves no entry on working directory");
 			goto done;
 		}
+		if (ret == 1) {
+			/*
+			 * Inability to sparsify or de-sparsify individual
+			 * paths is not an error, but just a warning.
+			 */
+			if (o->show_all_errors)
+				display_warning_msgs(o);
+			ret = 0;
+		}
 	}
 
 	ret = check_updates(o, &o->result) ? (-2) : 0;
@@ -1759,10 +1760,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	return ret;
 
 return_failed:
-	if (o->show_all_errors) {
+	if (o->show_all_errors)
 		display_error_msgs(o);
-		display_warning_msgs(o);
-	}
 	mark_all_ce_unused(o->src_index);
 	ret = unpack_failed(o, NULL);
 	if (o->exiting_early)
-- 
gitgitgadget

