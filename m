Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2701FC43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF92206E6
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo7vUede"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgC0AtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:49:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39013 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbgC0AtT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 20:49:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id a9so10571232wmj.4
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 17:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DluivwQB0UWgRj4ycznmh9I5VdagHc5AZ2URTnRPllw=;
        b=Mo7vUedeqXVVSoMaPsdM5NBZnIVAMxvZrw13q5m1Rm+20TKofLDrtNcN+luXyVg4/J
         d1AVdJ4N3dH039YnuSTcjQPHqkwPlfRcKLbkAL93aWMQEriJzQHhkmSbm/6VFT2G0vT4
         EB69sV4Gu0GRvv1Iv1rvyglShaHF6K5YPdzT8PcSH+MhWggu6rzmKFaqTanU94ArF9Dn
         pWNAEGZ/q/bruzgeTdL0kpHc4E5n6UXBskJ5oMJA4o0443WCOTDwCLJTH4uvUGTXwdXT
         GxojfPmnEyNg9N1U5xvYm6qZWxXZoN8OwpCk99uWF1hYMxXmSbX7OxnMOyETktL6dfOW
         5HfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DluivwQB0UWgRj4ycznmh9I5VdagHc5AZ2URTnRPllw=;
        b=B5CUfVFNjRKiNJulka2LaO64sKtuhg4CIWRKPWEn7f/ZmYvl9NSggM8C9rU8GIskFL
         q8CNDpcNA07OKvSatQfRqvqHAo4AJtJjV/ZDfrAJMsqciTWiAUpg3BnLzjcmwON+a8Z4
         SzhjqR5svlU48tXT6YppvGmMAGQqFzhSUZalCcvo29/d0Rn+TDNXcLI/8eDjm5vJEUz8
         UooQgNiVQHWOMmN/MJ8gfg9vqZhaHlBn/6LRLsx+P93ZQ/MlKCejD0lzowYsjTMD/e0N
         muZlaV6bz/rwSafCwlCRrDUEpk9H2bKqcct79fyGo75GvcQJC/fvisb8ZQv9ApBjiAM3
         8i+w==
X-Gm-Message-State: ANhLgQ3GvHYam34lLIr6YTtEAmgRiaU6x0p5OQz4VFCC+qsDJBOUovMS
        JmGqOS3fFHGFN4/yNM/UQCThTiSW
X-Google-Smtp-Source: ADFU+vv9zmQXykX9bei4VBiZYu8vVbbA36x+/8CRBIeuS8Xel35Ntn3cuRw31d+0kpZVudskfiv0bA==
X-Received: by 2002:a05:600c:2048:: with SMTP id p8mr2623437wmg.58.1585270156234;
        Thu, 26 Mar 2020 17:49:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9sm6038032wrx.48.2020.03.26.17.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 17:49:15 -0700 (PDT)
Message-Id: <844306c3e86ef67591cc086decb2b760e7d710a3.1585270142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
References: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
        <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 00:49:00 +0000
Subject: [PATCH v3 17/18] unpack-trees: failure to set SKIP_WORKTREE bits
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

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
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
index dec044339df..b43f3e775ad 100644
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

