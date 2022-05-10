Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9229BC433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 17:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347859AbiEJRTi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 13:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347852AbiEJRTe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 13:19:34 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C1A2BF30D
        for <git@vger.kernel.org>; Tue, 10 May 2022 10:15:35 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id n10so3631381qvi.5
        for <git@vger.kernel.org>; Tue, 10 May 2022 10:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Yc6fvMyaT71kyKEGqWRvRRFggEK9ImxhEewFTpVu6s=;
        b=IMcMYaSHNxPeNRLGANixZibRfLNHpKNLI9vTFM0ZCYMt6xTvzAjLcc2SwIX7+80xWu
         XfH2nsCeRgLSSALr1nbLjiucrdFBCF34u1iTw5Z6vs+hh0yHl3bQ5ErXaorZCa2fhydC
         h6Af2Rz702Vy7JiUDQe32ioAX95siHxG3DiOharvkMkf4nGuU9o8xfaJP8VLLF9LTJSC
         CSWjlpJ5kaNth622Kh0JjLanBHBh93Rlmfgf07BgLqiNop/DtPlBB9LP9WETPcQ+bXHJ
         TI+JmPuemAUdgxxDENCVQgezdB1WUqkMGlzLJ5maBU6Wzx0MwqZfmiaK8rUzwSLzjcdo
         oq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Yc6fvMyaT71kyKEGqWRvRRFggEK9ImxhEewFTpVu6s=;
        b=VBZx3bfe5sJtCaZfE6kZgTxXTlUahVOqHKzLsZhqt4O1TBSo/351KJ3lLfxqrGuGh4
         UGPgv/XL3LHS7UBhUU+4HkSw4LIil5HHzewxS+uC8VPHsislTFxzh/gm/2Oip1YV9Jf4
         reQwbQ+bwq/9lFRTiiIR/Isyv5zN0izWd2neeEUqrE0eXJILjd8OIFKMeIO4NVyL72wR
         CnfiEhtSxtoyBDJZLBw8GeR70EwC0ZmpTEczVO0tY0/UDTPHWSes2yOnFfDXu0WJVuKw
         NQwmUcQUln2IGuaUL3p11HA2W1eTuoa1IZIjyBxzYh5tTmWnco5Nbm2XVSsrSWvsOqcf
         LKKg==
X-Gm-Message-State: AOAM532Xl5Y65BOammXN6Qddv7mBrwMefMH+AQwaYEPFo007c5FBgSVG
        xRpFfjBrjl84+1Tx1nikyqn8e+H8qzQwdQ==
X-Google-Smtp-Source: ABdhPJyHBrNDr4CqJ/28mCZM4uODmJQaq2ss7Pz4yJwLNJ9jQHK9YWvpmczt6sMeNnc8oAdGBxveOA==
X-Received: by 2002:a05:6214:194e:b0:45a:d8e3:2d3f with SMTP id q14-20020a056214194e00b0045ad8e32d3fmr18766910qvk.59.1652202934669;
        Tue, 10 May 2022 10:15:34 -0700 (PDT)
Received: from localhost.localdomain (pool-100-33-115-203.nycmny.fios.verizon.net. [100.33.115.203])
        by smtp.gmail.com with ESMTPSA id x74-20020a37634d000000b0069ff51425a2sm8963787qkb.120.2022.05.10.10.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 10:15:34 -0700 (PDT)
From:   Goss Geppert <gg.oss.dev@gmail.com>
X-Google-Original-From: Goss Geppert <ggossdev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v2 1/2] dir: consider worktree config in path recursion
Date:   Tue, 10 May 2022 17:15:26 +0000
Message-Id: <20220510171527.25778-2-ggossdev@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220510171527.25778-1-ggossdev@gmail.com>
References: <20220505203234.21586-1-ggossdev@gmail.com>
 <20220510171527.25778-1-ggossdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 8d92fb2927 (dir: replace exponential algorithm with a linear one,
2020-04-01) the following no longer works:

    1) Initialize a repository.
    2) Set the `core.worktree` location to a parent directory of the
       default worktree.
    3) Add a file located in the default worktree location to the index
       (i.e. anywhere in the immediate parent directory of the gitdir).

This commit adds a check to determine whether a nested repository that
is encountered in recursing a path is actually `the_repository`.  If so,
simply treat the directory as if it doesn't contain a nested repository.

Prior to this commit, the `add` operation was silently ignored.

Signed-off-by: Goss Geppert <ggossdev@gmail.com>
---
 dir.c                          | 22 +++++++++
 t/t2205-add-worktree-config.sh | 89 ++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100755 t/t2205-add-worktree-config.sh

diff --git a/dir.c b/dir.c
index f2b0f24210..a1886e61a3 100644
--- a/dir.c
+++ b/dir.c
@@ -1893,9 +1893,31 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 
 	if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
 		!(dir->flags & DIR_NO_GITLINKS)) {
+		/*
+		 * Determine if `dirname` is a nested repo by confirming that:
+		 * 1) we are in a nonbare repository, and
+		 * 2) `dirname` is not an immediate parent of `the_repository->gitdir`,
+		 *    which could occur if the `worktree` location was manually
+		 *    configured by the user; see t2205 testcases 1a-1d for examples
+		 *    where this matters
+		 */
 		struct strbuf sb = STRBUF_INIT;
 		strbuf_addstr(&sb, dirname);
 		nested_repo = is_nonbare_repository_dir(&sb);
+
+		if (nested_repo) {
+			char *real_dirname, *real_gitdir;
+			strbuf_reset(&sb);
+			strbuf_addstr(&sb, dirname);
+			strbuf_complete(&sb, '/');
+			strbuf_addstr(&sb, ".git");
+			real_dirname = real_pathdup(sb.buf, 0);
+			real_gitdir = real_pathdup(the_repository->gitdir, 0);
+
+			nested_repo = !!strcmp(real_dirname, real_gitdir);
+			free(real_gitdir);
+			free(real_dirname);
+		}
 		strbuf_release(&sb);
 	}
 	if (nested_repo) {
diff --git a/t/t2205-add-worktree-config.sh b/t/t2205-add-worktree-config.sh
new file mode 100755
index 0000000000..ca70cf3fe2
--- /dev/null
+++ b/t/t2205-add-worktree-config.sh
@@ -0,0 +1,89 @@
+#!/bin/sh
+
+test_description='directory traversal respects worktree config
+
+This test configures the repository`s worktree to be two levels above the
+`.git` directory and checks whether we are able to add to the index those files
+that are in either (1) the manually configured worktree directory or (2) the
+standard worktree location with respect to the `.git` directory (i.e. ensuring
+that the encountered `.git` directory is not treated as belonging to a foreign
+nested repository)'
+
+. ./test-lib.sh
+
+test_expect_success '1a: setup' '
+	test_create_repo test1 &&
+	git --git-dir="test1/.git" config core.worktree "$(pwd)" &&
+
+	mkdir -p outside-tracked outside-untracked &&
+	mkdir -p test1/inside-tracked test1/inside-untracked &&
+	>file-tracked &&
+	>file-untracked &&
+	>outside-tracked/file &&
+	>outside-untracked/file &&
+	>test1/file-tracked &&
+	>test1/file-untracked &&
+	>test1/inside-tracked/file &&
+	>test1/inside-untracked/file &&
+
+	cat >expect-tracked-unsorted <<-EOF &&
+	../file-tracked
+	../outside-tracked/file
+	file-tracked
+	inside-tracked/file
+	EOF
+
+	cat >expect-untracked-unsorted <<-EOF &&
+	../file-untracked
+	../outside-untracked/file
+	file-untracked
+	inside-untracked/file
+	EOF
+
+	cat expect-tracked-unsorted expect-untracked-unsorted >expect-all-unsorted &&
+
+	cat >.gitignore <<-EOF
+	.gitignore
+	actual-*
+	expect-*
+	EOF
+'
+
+test_expect_success '1b: pre-add all' '
+	local parent_dir="$(pwd)" &&
+	(
+		cd test1 &&
+		git ls-files -o --exclude-standard "$parent_dir" >../actual-all-unsorted
+	) &&
+	sort actual-all-unsorted >actual-all &&
+	sort expect-all-unsorted >expect-all &&
+	test_cmp expect-all actual-all
+'
+
+test_expect_success '1c: post-add tracked' '
+	local parent_dir="$(pwd)" &&
+	(
+		cd test1 &&
+		git add file-tracked &&
+		git add inside-tracked &&
+		git add ../outside-tracked &&
+		git add "$parent_dir/file-tracked" &&
+		git ls-files "$parent_dir" >../actual-tracked-unsorted
+	) &&
+	sort actual-tracked-unsorted >actual-tracked &&
+	sort expect-tracked-unsorted >expect-tracked &&
+	test_cmp expect-tracked actual-tracked
+'
+
+test_expect_success '1d: post-add untracked' '
+	local parent_dir="$(pwd)" &&
+	(
+		cd test1 &&
+		git ls-files -o --exclude-standard "$parent_dir" >../actual-untracked-unsorted
+	) &&
+	sort actual-untracked-unsorted >actual-untracked &&
+	sort expect-untracked-unsorted >expect-untracked &&
+	test_cmp expect-untracked actual-untracked
+'
+
+test_done
-- 
2.36.0

