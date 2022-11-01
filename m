Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3D5FA3743
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 08:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiKAIzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 04:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKAIzK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 04:55:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6992217E25
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 01:55:09 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so9496334wmb.0
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 01:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7j4pK/twic9MZEd7id4p6fJ/0t3Ay1LH6QdY2JBBK6g=;
        b=lK1WqeJhDoRBFXH926AYLa9Zc4SYFQ84f2A70DudeVqrk0sE7kvfwrlG+NLvTzcOAv
         +fsCmc/WZv7u/E0+G0G4uY3Uf1nsYlM3f+JaX7410Np3IDmQ/+6co3YcCVMtlPAJ+WtF
         7CiwCH2DQsZZgnYlLWuVh+fOCMPx0DAxOnSZipVFqOb3eDrq2pVpEB4WhuW0LHYRwxws
         Ln5auZlxF3vwMKMBA60BSdEeR8ZErTUKkHbNg7FXlN8pZdo1dgruWihRfRg/k6MFw+b1
         +Mtq2PWcRN+1vi0jXKGeRCQrqL96Gl9L73k+FvzHwfVFE4TNhsX+M1t23QdjhWGGdO7l
         fy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7j4pK/twic9MZEd7id4p6fJ/0t3Ay1LH6QdY2JBBK6g=;
        b=ScVgc1aecEEdpqc11eS3cVF7gKcqVmzg4PpTO5LjwyxxZYCClfXvvLEFjH1en28Xhe
         crwkMtlfsG5OMDBe++hCYrJsAjzUfGTAp26zJ6F0Z/E4SYZsVatQofeZ/g9dLuU5jY8k
         OWPeHVphsuvpmwfAifK/rG6fK5ltU2hTSQVSF7LmNrTIAVgj/GcAZWqVx0RQvmO6dp0T
         4OsLJQErfhcrkDrJlh1f9jsuUxNi9F7BcMnMAobNIqp29XQYGSc5cjcgx71hVwNdGEYw
         rX/48nb8cn1Rh8Nrp7RH2Of/8X2dLuRGXQcgozHjBSs9By3USXEQCWs+TFdkBhDE45qb
         pxOA==
X-Gm-Message-State: ACrzQf2GmonMe8wqkfSeeQVBwPSTJXSR/cxLYpbAuJzxh8DVo34OCAZS
        Z3bmVG6aG3ziKKdXzyLKrTAy9LZeOMA=
X-Google-Smtp-Source: AMsMyM6yBucLRx6wQNih+b20M55zGTXn/yep6PRhYVVJFMpcm4TWhtshk52kJyNv0214LNm07hDmAA==
X-Received: by 2002:a05:600c:21d7:b0:3cf:7d8a:42e2 with SMTP id x23-20020a05600c21d700b003cf7d8a42e2mr1889191wmj.202.1667292907648;
        Tue, 01 Nov 2022 01:55:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i10-20020adffdca000000b00236674840e9sm9395629wrs.59.2022.11.01.01.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 01:55:07 -0700 (PDT)
Message-Id: <db47fbc663eb0f3a1fc9a063dfb1051bc64601af.1667292904.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1397.v4.git.1667292904.gitgitgadget@gmail.com>
References: <pull.1397.v3.git.1667014975042.gitgitgadget@gmail.com>
        <pull.1397.v4.git.1667292904.gitgitgadget@gmail.com>
From:   "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Nov 2022 08:55:04 +0000
Subject: [PATCH v4 2/2] merge-tree.c: support --merge-base in conjunction with
 --stdin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, kylezhao <kylezhao@tencent.com>,
        Kyle Zhao <kylezhao@tencent.com>,
        Kyle Zhao <kylezhao@tencent.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kyle Zhao <kylezhao@tencent.com>

The previous change add "--merge-base" option in order to allow users to
specify merge-base for the merge. But it doesn't compatible well with
--stdin, because multiple batched merges can only have the same specified
base.

This patch allows users to pass --merge-base option into the input line,
such as:

    printf "--merge-base=<b3> <b1> <b2>" | git merge-tree --stdin

This does a merge of b1 and b2, and uses b3 as the merge-base.

Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
---
 Documentation/git-merge-tree.txt |  3 ++-
 builtin/merge-tree.c             | 22 ++++++++++++++++++++--
 t/t4301-merge-tree-write-tree.sh | 21 +++++++++++++++++++++
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index d9dacb2ce54..be6a11bbaec 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -66,7 +66,8 @@ OPTIONS
 
 --merge-base=<commit>::
 	Instead of finding the merge-bases for <branch1> and <branch2>,
-	specify a merge-base for the merge.
+	specify a merge-base for the merge. When --stdin is passed, this
+	option should be passed into the input line.
 
 [[OUTPUT]]
 OUTPUT
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index f402b807c0f..7a8049e7b0c 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -551,16 +551,34 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 
 		if (o.mode == MODE_TRIVIAL)
 			die(_("--trivial-merge is incompatible with all other options"));
+		if (merge_base)
+			die(_("--merge-base should be passed into the input line"));
 		line_termination = '\0';
 		while (strbuf_getline_lf(&buf, stdin) != EOF) {
 			struct strbuf **split;
 			int result;
+			const char *input_merge_base = NULL;
+			const char *arg;
 
 			split = strbuf_split(&buf, ' ');
-			if (!split[0] || !split[1] || split[2])
+			if (!split[0] || !split[1])
 				die(_("malformed input line: '%s'."), buf.buf);
 			strbuf_rtrim(split[0]);
-			result = real_merge(&o, merge_base, split[0]->buf, split[1]->buf, prefix);
+
+			/* parse --merge-base=<commit> option */
+			arg = split[0]->buf;
+			if (skip_prefix(arg, "--merge-base=", &arg))
+				input_merge_base = arg;
+
+			if (input_merge_base && split[2] && !split[3]) {
+				strbuf_rtrim(split[1]);
+				result = real_merge(&o, input_merge_base, split[1]->buf, split[2]->buf, prefix);
+			} else if (!input_merge_base && !split[2]) {
+				result = real_merge(&o, NULL, split[0]->buf, split[1]->buf, prefix);
+			} else {
+				die(_("malformed input line: '%s'."), buf.buf);
+			}
+
 			if (result < 0)
 				die(_("merging cannot continue; got unclean result of %d"), result);
 			strbuf_list_free(split);
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 5b0073d3dcd..aec2c00b91f 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -860,6 +860,13 @@ test_expect_success '--stdin with both a successful and a conflicted merge' '
 	test_cmp expect actual
 '
 
+
+test_expect_success '--merge-base is incompatible with --stdin' '
+	test_must_fail git merge-tree --merge-base=side1 --stdin 2>expect &&
+
+	grep "^fatal: --merge-base should be passed into the input line" expect
+'
+
 # specify merge-base as parent of branch2
 # git merge-tree --write-tree --merge-base=c2 c1 c3
 #   Commit c1: add file1
@@ -890,4 +897,18 @@ test_expect_success 'specify merge-base as parent of branch2' '
 	)
 '
 
+test_expect_success '--stdin with both a normal merge and a merge-base specified merge' '
+	cd base-b2-p &&
+	printf "c1 c3\n--merge-base=c2 c1 c3" | git merge-tree --stdin >actual &&
+
+	printf "1\0" >expect &&
+	git merge-tree --write-tree -z c1 c3 >>expect &&
+	printf "\0" >>expect &&
+
+	printf "1\0" >>expect &&
+	git merge-tree --write-tree -z --merge-base=c2 c1 c3 >>expect &&
+	printf "\0" >>expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
