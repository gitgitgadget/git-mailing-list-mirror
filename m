Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9CEE95A8E
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 13:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376382AbjJINVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 09:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376376AbjJINVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 09:21:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD4E91
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 06:21:05 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9ba081173a3so399723066b.1
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 06:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696857662; x=1697462462; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lN9aVFIm0GU1VTMU43WKqTcz55+JGLS9Ykd57qQjLyI=;
        b=XU7f3u6x4nyeBWIl9S3W3iVf3NxA9HIN/9G7DOBJEEL3HqE8yWX+5WPxbu+rNeM/sC
         Vl2SG562kCGYLQNcrsHLu1bxq9sJIIhj9eRRspdLKA8qkKJjg03PXdabXIeIyH7eUq/l
         kp/iOiJ0OWKMan91entoNShbKhWwYDNvnT7kfSB4j5KBhLWXwktK6uw2vVFK0JEx7Y0t
         Ex0BsPMaaFd9iuchfOkJJb/zeUQhNplvt8TzbvH/PPvkhG/uF6Wu3KdTO0wPHyMP+2td
         MdoxgKazKWC61Hb7Pdj0my3PMiwc2EylPswqbR9wCRnTFTdBdijLT7dcptYMUlYaA4yI
         r9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696857662; x=1697462462;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lN9aVFIm0GU1VTMU43WKqTcz55+JGLS9Ykd57qQjLyI=;
        b=aDILRNH9Gx9Wyo3iHUFTkit4I/zu/RvIRGb0fzcZ4bQPoeob+dEbUcwpiOKg/TcLdm
         QrHy1VzqET+U8d1e9T7cJLDGrjdCnVRzzWReMYjW0f+gFfmpALkv/Vi7jZFYp4aLz5qq
         ILZuOrTnQ3FTWVU0xv7XzW32JZKj93/v786zl1nwcf1hu7GbHAzbUg4bnrLGCZ4Ocpn8
         Y0nEpAImAKEBalCu/lp4CLtvWqy2wleZHsqNc4bfDdBg0QU4rpkAp2hIidubM9cMFWSr
         zxWzRbzw2StsVpMhYz550syjJwSdPknIY508FOhGIxRSa+2vQMioefydHHJjkxPA25Xn
         Ac6w==
X-Gm-Message-State: AOJu0YxYZo/0uJpgxOt+J1YA3hD6XpJCqyUTo1rg8R41Zevq5HFtXVTB
        /jQhGvReppQzBawseiShr9e9DeJJZvI=
X-Google-Smtp-Source: AGHT+IEHWOIea+7NzrSN8DZNAji6rxywW6AlEGIiTLJtVHE5Tcaad9eCsaFjuKrX0ZoxY8ZU270tkg==
X-Received: by 2002:a17:906:53da:b0:9b2:6c37:22ee with SMTP id p26-20020a17090653da00b009b26c3722eemr13886047ejo.21.1696857661630;
        Mon, 09 Oct 2023 06:21:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a4-20020a05600c224400b003fe2b081661sm13515531wmm.30.2023.10.09.06.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 06:21:01 -0700 (PDT)
Message-ID: <pull.1583.v3.git.git.1696857660374.gitgitgadget@gmail.com>
In-Reply-To: <pull.1583.v2.git.git.1696781998420.gitgitgadget@gmail.com>
References: <pull.1583.v2.git.git.1696781998420.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Oct 2023 13:21:00 +0000
Subject: [PATCH v3] merge-ort: initialize repo in index state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, John Cai <johncai86@gmail.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

initialize_attr_index() does not initialize the repo member of
attr_index. Starting in 44451a2e5e (attr: teach "--attr-source=<tree>"
global option to "git", 2023-05-06), this became a problem because
istate->repo gets passed down the call chain starting in
git_check_attr(). This gets passed all the way down to
replace_refs_enabled(), which segfaults when accessing r->gitdir.

Fix this by initializing the repository in the index state.

Signed-off-by: John Cai <johncai86@gmail.com>
Helped-by: Christian Couder <christian.couder@gmail.com>
---
    merge-ort: initialize repo in index state
    
    initialize_attr_index() does not initialize the repo member of
    attr_index. Starting in 44451a2e5e (attr: teach "--attr-source=" global
    option to "git", 2023-05-06), this became a problem because istate->repo
    gets passed down the call chain starting in git_check_attr(). This gets
    passed all the way down to replace_refs_enabled(), which segfaults when
    accessing r->gitdir.
    
    Fix this by initializing the repository in the index state.
    
    Changes since V2:
    
     * fixed test by using printf instead of echo
    
    Changes since v1:
    
     * using opt->repo to avoid hardcoding another the_repository
     * clarified test

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1583%2Fjohn-cai%2Fjc%2Fpopulate-repo-when-init-attr-index-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1583/john-cai/jc/populate-repo-when-init-attr-index-v3
Pull-Request: https://github.com/git/git/pull/1583

Range-diff vs v2:

 1:  e178236064a ! 1:  792b01fa616 merge-ort: initialize repo in index state
     @@ t/t4300-merge-tree.sh: EXPECTED
      +		git checkout @{-1} &&
      +		tree=$(git --attr-source=gitattributes merge-tree --write-tree \
      +		--merge-base "$base" --end-of-options "$source" "$merge") &&
     -+		echo "foo\nbar\nbaz" >expect &&
     ++		printf "foo\nbar\nbaz\n" >expect &&
      +		git cat-file -p "$tree:file1" >actual &&
      +		test_cmp expect actual
      +	)


 merge-ort.c           |  1 +
 t/t4300-merge-tree.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 7857ce9fbd1..36537256613 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1902,6 +1902,7 @@ static void initialize_attr_index(struct merge_options *opt)
 	struct index_state *attr_index = &opt->priv->attr_index;
 	struct cache_entry *ce;
 
+	attr_index->repo = opt->repo;
 	attr_index->initialized = 1;
 
 	if (!opt->renormalize)
diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index 57c4f26e461..c3a03e54187 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -86,6 +86,33 @@ EXPECTED
 	test_cmp expected actual
 '
 
+test_expect_success '3-way merge with --attr-source' '
+	test_when_finished rm -rf 3-way &&
+	git init 3-way &&
+	(
+		cd 3-way &&
+		test_commit initial file1 foo &&
+		base=$(git rev-parse HEAD) &&
+		git checkout -b brancha &&
+		echo bar >>file1 &&
+		git commit -am "adding bar" &&
+		source=$(git rev-parse HEAD) &&
+		git checkout @{-1} &&
+		git checkout -b branchb &&
+		echo baz >>file1 &&
+		git commit -am "adding baz" &&
+		merge=$(git rev-parse HEAD) &&
+		git checkout -b gitattributes &&
+		test_commit "gitattributes" .gitattributes "file1 merge=union" &&
+		git checkout @{-1} &&
+		tree=$(git --attr-source=gitattributes merge-tree --write-tree \
+		--merge-base "$base" --end-of-options "$source" "$merge") &&
+		printf "foo\nbar\nbaz\n" >expect &&
+		git cat-file -p "$tree:file1" >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'file change A, B (same)' '
 	git reset --hard initial &&
 	test_commit "change-a-b-same-A" "initial-file" "AAA" &&

base-commit: 493f4622739e9b64f24b465b21aa85870dd9dc09
-- 
gitgitgadget
