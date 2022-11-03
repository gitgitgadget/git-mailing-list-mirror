Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DEEC433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 10:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiKCKuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 06:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiKCKu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 06:50:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7236ADEB9
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 03:50:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id cl5so2123244wrb.9
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 03:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6j6YbjLRw0DZiSswyrRiP+B9r3p2IpYOi+x6huF3xHE=;
        b=AaG+J0QzR5zV34MfNDssOVwfnBGXXdrrYL3bSe3DF5wLF3dK2+xveMHhTUggJBVv0/
         bbJzWRKyifrtXLN2ymleQDZTCuEyVqoEFjPISXXeIPbritE4Lsb2VMUXPklagNDY/J3t
         yHxdaexjhZW/k5dFIvJqzEUzGf8/PVqqjSCVpqvRz4YKHfQMjc0TNr5/5LPcvixHwXT5
         vyUbpeXK31EWolex1V/S7jAPFnFz+z4t9TMAaKYr8KAe9oHCbISw+LsugOgDaACizVId
         ERIqfkeBgXvqKXRjC6NR/FJ3wcQqxAAGUSJbtPrZzEpHBYgk72zsLF08RDR64z82e359
         rTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6j6YbjLRw0DZiSswyrRiP+B9r3p2IpYOi+x6huF3xHE=;
        b=Ppb8DxHP8qoLblTjsXdbVE2kxCZt6VlTXg/V/aEKF7ibLwhNwfYXbjP8XxelWfKmDk
         krfOWhakgDvnnQDVMW7SoMmh8qF5rlpBRWc+d3WYm6eXGHD0VX+ul1ccVQAGMw88fQ3X
         Co3DSraUaMG28neABorT7V84AvsrJiY5iZiaH5Yd2QKM/YdXdsUSt1g16TXyDCfD7K7L
         qblIKLhS2gKKWhYaV6wgSEQZ7whnkng1C8CRy/aCa4IXeZ9bqhZqS/lsJ18OpFl9htg/
         j5H5ErJdCiL10N11VPo0rNCRnuZcxkFRvs8jAN5uBvAl5FVOlcdK8kfqLHLYB57EecEE
         s4ag==
X-Gm-Message-State: ACrzQf0CcL6KGT3BrOr3qDHCgTL0Syh1H8gjJI8i0lUrL+Ci5FSN0Wjl
        mq9P0iR+os+nKOQ0BV18RPtqU9QkWUc=
X-Google-Smtp-Source: AMsMyM6KHPfzBTU3v+sRc2fg40TiuBmMNG3Y4LD/mNiyIQPPWfxPzUhGft03AFjUA/vxtuP+SBJZ/g==
X-Received: by 2002:adf:f9c9:0:b0:236:9c40:c57c with SMTP id w9-20020adff9c9000000b002369c40c57cmr18222916wrr.47.1667472624792;
        Thu, 03 Nov 2022 03:50:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8-20020a05600c34c800b003b476cabf1csm866725wmq.26.2022.11.03.03.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 03:50:24 -0700 (PDT)
Message-Id: <40d56544e6e319605d02bab743a6e957ff0a5926.1667472621.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1397.v6.git.1667472621.gitgitgadget@gmail.com>
References: <pull.1397.v5.git.1667446182.gitgitgadget@gmail.com>
        <pull.1397.v6.git.1667472621.gitgitgadget@gmail.com>
From:   "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Nov 2022 10:50:21 +0000
Subject: [PATCH v6 2/2] merge-tree.c: allow specifying the merge-base when
 --stdin is passed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, kylezhao <kylezhao@tencent.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Kyle Zhao <kylezhao@tencent.com>,
        Kyle Zhao <kylezhao@tencent.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kyle Zhao <kylezhao@tencent.com>

The previous commit added a `--merge-base` option in order to allow
using a specified merge-base for the merge.  Extend the input accepted
by `--stdin` to also allow a specified merge-base with each merge
requested.  For example:

    printf "<b3> -- <b1> <b2>" | git merge-tree --stdin

does a merge of b1 and b2, and uses b3 as the merge-base.

Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
---
 Documentation/git-merge-tree.txt | 14 ++++++++++++-
 builtin/merge-tree.c             | 21 ++++++++++++++++++--
 t/t4301-merge-tree-write-tree.sh | 34 ++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index d9dacb2ce54..298c133fdb6 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -66,7 +66,8 @@ OPTIONS
 
 --merge-base=<commit>::
 	Instead of finding the merge-bases for <branch1> and <branch2>,
-	specify a merge-base for the merge.
+	specify a merge-base for the merge. This option is incompatible
+	with `--stdin`.
 
 [[OUTPUT]]
 OUTPUT
@@ -220,6 +221,17 @@ with linkgit:git-merge[1]:
   * any messages that would have been printed to stdout (the
     <<IM,Informational messages>>)
 
+INPUT FORMAT
+------------
+'git merge-tree --stdin' input format is fully text based. Each line
+has this format:
+
+	[<base-commit> -- ]<branch1> <branch2>
+
+If one line is separated by `--`, the string before the separator is
+used for specifying a merge-base for the merge and the string after
+the separator describes the branches to be merged.
+
 MISTAKES TO AVOID
 -----------------
 
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 62c6d43cdb9..330f779e8bc 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -557,12 +557,29 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 		while (strbuf_getline_lf(&buf, stdin) != EOF) {
 			struct strbuf **split;
 			int result;
+			const char *input_merge_base = NULL;
 
 			split = strbuf_split(&buf, ' ');
-			if (!split[0] || !split[1] || split[2])
+			if (!split[0] || !split[1])
 				die(_("malformed input line: '%s'."), buf.buf);
 			strbuf_rtrim(split[0]);
-			result = real_merge(&o, merge_base, split[0]->buf, split[1]->buf, prefix);
+			strbuf_rtrim(split[1]);
+
+			/* parse the merge-base */
+			if (!strcmp(split[1]->buf, "--")) {
+				input_merge_base = split[0]->buf;
+			}
+
+			if (input_merge_base && split[2] && split[3] && !split[4]) {
+				strbuf_rtrim(split[2]);
+				strbuf_rtrim(split[3]);
+				result = real_merge(&o, input_merge_base, split[2]->buf, split[3]->buf, prefix);
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
index 6db96ccbaae..22b43f0003e 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -860,6 +860,13 @@ test_expect_success '--stdin with both a successful and a conflicted merge' '
 	test_cmp expect actual
 '
 
+
+test_expect_success '--merge-base is incompatible with --stdin' '
+	test_must_fail git merge-tree --merge-base=side1 --stdin 2>expect &&
+
+	grep "^fatal: --merge-base is incompatible with --stdin" expect
+'
+
 # specify merge-base as parent of branch2
 # git merge-tree --write-tree --merge-base=c2 c1 c3
 #   Commit c1: add file1
@@ -887,4 +894,31 @@ test_expect_success 'specify merge-base as parent of branch2' '
 	test_cmp expect actual
 '
 
+# Since the earlier tests have verified that individual merge-tree calls
+# are doing the right thing, this test case is only used to test whether
+# the input format is available.
+
+test_expect_success 'check the input format when --stdin is passed' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo c1 &&
+	test_commit -C repo c2 &&
+	test_commit -C repo c3 &&
+	printf "c1 c3\nc2 -- c1 c3\nc2 c3" | git -C repo merge-tree --stdin >actual &&
+
+	printf "1\0" >expect &&
+	git -C repo merge-tree --write-tree -z c1 c3 >>expect &&
+	printf "\0" >>expect &&
+
+	printf "1\0" >>expect &&
+	git -C repo merge-tree --write-tree -z --merge-base=c2 c1 c3 >>expect &&
+	printf "\0" >>expect &&
+
+	printf "1\0" >>expect &&
+	git -C repo merge-tree --write-tree -z c2 c3 >>expect &&
+	printf "\0" >>expect &&
+
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
