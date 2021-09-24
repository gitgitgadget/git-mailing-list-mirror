Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701E1C433FE
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E1C6124F
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347285AbhIXPlK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 11:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347221AbhIXPk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 11:40:58 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9071C061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t8so28808509wrq.4
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S+9e4DSe77dvVgiDAcpgdRbCJzwJrdluslPwAilivOc=;
        b=DoRbiz+OYsR9Tr2FEAXVigyHH00Wb7F9mAwy3+R+mCCO6y4Mh3v5dvlnsSyMZLYiv2
         47Tg4nRidWrrSo/CGnZ89awu8sJZOsJ+c+kMec8z0TNw2AhzjNqXF6I6tHak0pFt/1jp
         h4CRXXb/pBDf9YG0bTnoiGEHHgoVBd36g+bNlKgHI6K5OI/Pl9PCuusnlwCDelrSqfPB
         +KpzU+4mtkPI3/7u0oaun+dXY5BmhKXzHiN5qfBkPQvRycWgwt+6ezakTZZwxxMSE3ij
         yMNxl9BbZ6p8+WsdTEw45ML8c90WfXJTArl8xRO20IfvsXcrvqbM1bXIzaZXiuTG5yih
         H5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S+9e4DSe77dvVgiDAcpgdRbCJzwJrdluslPwAilivOc=;
        b=3nGwfu2MdQf/FFlY4L+UF2rINNGHzRo/msTH5rV/8wzNItVzsY7KdwVQvW9EKk2f27
         +2pc/gh1XWphuGB57bdqB3t/iMVDcqk03VcIdc1ohuhGzHSFl3L31+bqgOIOWlBhFNSu
         Di6uiJh3bS07fTEXbTO1g1IqX/it/uq/EPJ8FmgItybY0zxGovHI6xEG1oMJwUvUWwUd
         iKQd5Vl8uYpw5q+m8Dff+o50JaIhrXCl6AWKAc7jG9CdNtxZbBuOP36VkM5Gjnbt2GNd
         L2mW3xhRGpZDOIQAMSleUFdjDnxCBTiRwgP5JNQbONLO9O4f/ERKMvr6XM+X2NQx43k5
         ldBw==
X-Gm-Message-State: AOAM53013oGIclhJnBPPzfVBjXBwaeoME1QhM98TASsmMJzssTJIXQDm
        UgchmdbxxVNI7gArbvs1Bvt6ffjtyUs=
X-Google-Smtp-Source: ABdhPJygs+XujYL/gkrBNwdqaxOdi+cOmtHfnYs/g3fQojReG/ustyGb4IyAF2TOjWnBakHc6TOABA==
X-Received: by 2002:adf:dc0d:: with SMTP id t13mr2940691wri.158.1632497961458;
        Fri, 24 Sep 2021 08:39:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m128sm6784893wme.0.2021.09.24.08.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 08:39:21 -0700 (PDT)
Message-Id: <99d50921ef4b787a0cc67d05a1a92f64a91b25d3.1632497954.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
References: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
        <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 15:39:11 +0000
Subject: [PATCH v4 10/13] rm: add --sparse option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As we did previously in 'git add', add a '--sparse' option to 'git rm'
that allows modifying paths outside of the sparse-checkout definition.
The existing checks in 'git rm' are restricted to tracked files that
have the SKIP_WORKTREE bit in the current index. Future changes will
cause 'git rm' to reject removing paths outside of the sparse-checkout
definition, even if they are untracked or do not have the SKIP_WORKTREE
bit.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-rm.txt      |  6 ++++++
 builtin/rm.c                  |  8 ++++++--
 t/t3602-rm-sparse-checkout.sh | 12 ++++++++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 26e9b284704..81bc23f3cdb 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -72,6 +72,12 @@ For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 --ignore-unmatch::
 	Exit with a zero status even if no files matched.
 
+--sparse::
+	Allow updating index entries outside of the sparse-checkout cone.
+	Normally, `git rm` refuses to update index entries whose paths do
+	not fit within the sparse-checkout cone. See
+	linkgit:git-sparse-checkout[1] for more.
+
 -q::
 --quiet::
 	`git rm` normally outputs one line (in the form of an `rm` command)
diff --git a/builtin/rm.c b/builtin/rm.c
index 8a24c715e02..4208f3f9a5f 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -237,6 +237,7 @@ static int check_local_mod(struct object_id *head, int index_only)
 
 static int show_only = 0, force = 0, index_only = 0, recursive = 0, quiet = 0;
 static int ignore_unmatch = 0, pathspec_file_nul;
+static int include_sparse;
 static char *pathspec_from_file;
 
 static struct option builtin_rm_options[] = {
@@ -247,6 +248,7 @@ static struct option builtin_rm_options[] = {
 	OPT_BOOL('r', NULL,             &recursive,  N_("allow recursive removal")),
 	OPT_BOOL( 0 , "ignore-unmatch", &ignore_unmatch,
 				N_("exit with a zero status even if nothing matched")),
+	OPT_BOOL(0, "sparse", &include_sparse, N_("allow updating entries outside of the sparse-checkout cone")),
 	OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
 	OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 	OPT_END(),
@@ -298,7 +300,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
-		if (ce_skip_worktree(ce))
+
+		if (!include_sparse && ce_skip_worktree(ce))
 			continue;
 		if (!ce_path_match(&the_index, ce, &pathspec, seen))
 			continue;
@@ -322,7 +325,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 				seen_any = 1;
 			else if (ignore_unmatch)
 				continue;
-			else if (matches_skip_worktree(&pathspec, i, &skip_worktree_seen))
+			else if (!include_sparse &&
+				 matches_skip_worktree(&pathspec, i, &skip_worktree_seen))
 				string_list_append(&only_match_skip_worktree, original);
 			else
 				die(_("pathspec '%s' did not match any files"), original);
diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
index e9e9a15c74c..493c8f636b8 100755
--- a/t/t3602-rm-sparse-checkout.sh
+++ b/t/t3602-rm-sparse-checkout.sh
@@ -43,6 +43,18 @@ test_expect_success 'recursive rm does not remove sparse entries' '
 	test_cmp expected actual
 '
 
+test_expect_success 'recursive rm --sparse removes sparse entries' '
+	git reset --hard &&
+	git sparse-checkout set "sub/dir" &&
+	git rm --sparse -r sub &&
+	git status --porcelain -uno >actual &&
+	cat >expected <<-\EOF &&
+	D  sub/d
+	D  sub/dir/e
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'rm obeys advice.updateSparsePath' '
 	git reset --hard &&
 	git sparse-checkout set a &&
-- 
gitgitgadget

