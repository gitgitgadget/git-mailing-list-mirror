Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D27CC43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 01:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbiGEBd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 21:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiGEBdw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 21:33:52 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F707678
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 18:33:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bk26so351880wrb.11
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 18:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QOTHiPJzQNAwKxGQWS9EdTgIq+qlsjFjhPWGo/M+7S0=;
        b=kxg1JSeUSVenc/7vrFfaNLQ/DPCeURAXkoxngm+Ws3MDLuFRl9xnHyH5mnkE0t6bqe
         W3PNWGPxWYW1lVn5bef5ZBTXttH0wrZCgiZ+zubcrgmDgsLHTN8a2xMu1uID8cZzroMO
         4dw3NavZ9UvfPjgfO7lrwL6PtlX+/Jjhegnjv29Jm+y7osvGjwxsn6djqdjv6wK20L6j
         0HOeWcOaEV9hn64h2JxcEE2fYDGKl92V6zLiHOi7mBqAoeOSIpfxBXTl/sBiKwscUwNs
         OuPMB6kfxqYgfAvQtghf45vGFjNVntW+hjOUIzAWK3JhBSkVAIB1B1Y5sHFu3kELsznY
         GAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QOTHiPJzQNAwKxGQWS9EdTgIq+qlsjFjhPWGo/M+7S0=;
        b=bFK/H9vAtkAVIYaw1DGNVty29rgYR12utizRwbuiNqHXhwbzEEqJzof/Zd9v55klmv
         1VJkR9RhnHmXuIDb1XyBuHmuHaQCcmo5wLKudUYLq/zrNcCC/RU0MvZR/srftYkX4iCd
         vVWX3IAjzjzdhHbmvRYlSgjD7/9cUco39alRiRrluI3/oyM8Jsvqdl/XsGytGPEgZxqK
         /cP3K02KHrq+lATGnXnVPt42eWeU3A+5SddfBJT3SsesdYTjamycuvAXXWFsE99OHsz9
         9P/OUyobkiQ0+8XjCOM4+JlAWkXZ6LZS2AlGAdPYsGR3300bmnUVc3y1s2dO5JBH0Ofe
         yVsA==
X-Gm-Message-State: AJIora/wTbLZ7KIF8W2BCG5/mJlkByX7aI8lT+J4hyOu3J+ft8QRtfWc
        WdvsunOQsYXRfEzFPWV5xDEizoB3aec=
X-Google-Smtp-Source: AGRyM1uSAwkhc4NOubRD6FWK/RbyLkkpaJFevEUT8cMFB/YItQfaDEWnXfLpAdxJHA50FwmvjE81cg==
X-Received: by 2002:a5d:4e03:0:b0:21d:6d7b:e9b8 with SMTP id p3-20020a5d4e03000000b0021d6d7be9b8mr5095725wrt.259.1656984828591;
        Mon, 04 Jul 2022 18:33:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y5-20020a056000108500b002167efdd549sm3240245wrw.38.2022.07.04.18.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 18:33:47 -0700 (PDT)
Message-Id: <a16a1c4d947d66751db1a4c0ab832c67fc3c9ce2.1656984823.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1268.v4.git.1656984823.gitgitgadget@gmail.com>
References: <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>
        <pull.1268.v4.git.1656984823.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jul 2022 01:33:39 +0000
Subject: [PATCH v4 1/5] t6423: add tests of dual directory rename plus add/add
 conflict
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This is an attempt at minimalizing a testcase reported by Glen Choo
with tensorflow where merge-ort would report an assertion failure:

    Assertion failed: (ci->filemask == 2 || ci->filemask == 4), function apply_directory_rename_modifications, file merge-ort.c, line 2410

reversing the direction of the merge provides a different error:

    error: cache entry has null sha1: ...
    fatal: unable to write .git/index

so we add testcases for both.  With these new testcases, the
recursive strategy differs in that it returns the latter error for
both merge directions.

These testcases are somehow a little different than Glen's original
tensorflow testcase in that these ones trigger a bug with the recursive
algorithm whereas his testcase didn't.  I figure that means these
testcases somehow manage to be more comprehensive.

Reported-by: Glen Choo <chooglen@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 105 ++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 479db32cd62..ed5586de28c 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5199,6 +5199,111 @@ test_expect_success '12k: Directory rename with sibling causes rename-to-self' '
 	)
 '
 
+# Testcase 12l, Both sides rename a directory into the other side, both add
+#   a file which after directory renames are the same filename
+#   Commit O: sub1/file,                 sub2/other
+#   Commit A: sub3/file,                 sub2/{other, new_add_add_file_1}
+#   Commit B: sub1/{file, newfile}, sub1/sub2/{other, new_add_add_file_2}
+#
+#   In words:
+#     A: sub1/ -> sub3/, add sub2/new_add_add_file_1
+#     B: sub2/ -> sub1/sub2, add sub1/newfile, add sub1/sub2/new_add_add_file_2
+#
+#   Expected: sub3/{file, newfile, sub2/other}
+#             CONFLICT (add/add): sub1/sub2/new_add_add_file
+#
+#   Note that sub1/newfile is not extraneous.  Directory renames are only
+#   detected if they are needed, and they are only needed if the old directory
+#   had a new file added on the opposite side of history.  So sub1/newfile
+#   is needed for there to be a sub1/ -> sub3/ rename.
+
+test_setup_12l () {
+	test_create_repo 12l_$1 &&
+	(
+		cd 12l_$1 &&
+
+		mkdir sub1 sub2
+		echo file >sub1/file &&
+		echo other >sub2/other &&
+		git add sub1 sub2 &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv sub1 sub3 &&
+		echo conflicting >sub2/new_add_add_file &&
+		git add sub2 &&
+		test_tick &&
+		git add -u &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo dissimilar >sub2/new_add_add_file &&
+		echo brand >sub1/newfile &&
+		git add sub1 sub2 &&
+		git mv sub2 sub1 &&
+		test_tick &&
+		git commit -m "B"
+	)
+}
+
+test_expect_merge_algorithm failure failure '12l (B into A): Rename into each other + add/add conflict' '
+	test_setup_12l BintoA &&
+	(
+		cd 12l_BintoA &&
+
+		git checkout -q A^0 &&
+
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 &&
+
+		test_stdout_line_count = 5 git ls-files -s &&
+
+		git rev-parse >actual \
+			:0:sub3/file :0:sub3/newfile :0:sub3/sub2/other \
+			:2:sub1/sub2/new_add_add_file \
+			:3:sub1/sub2/new_add_add_file &&
+		git rev-parse >expect \
+			O:sub1/file  B:sub1/newfile O:sub2/other \
+			A:sub2/new_add_add_file \
+			B:sub1/sub2/new_add_add_file &&
+		test_cmp expect actual &&
+
+		git ls-files -o >actual &&
+		test_write_lines actual expect >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_merge_algorithm failure failure '12l (A into B): Rename into each other + add/add conflict' '
+	test_setup_12l AintoB &&
+	(
+		cd 12l_AintoB &&
+
+		git checkout -q B^0 &&
+
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive A^0 &&
+
+		test_stdout_line_count = 5 git ls-files -s &&
+
+		git rev-parse >actual \
+			:0:sub3/file :0:sub3/newfile :0:sub3/sub2/other \
+			:2:sub1/sub2/new_add_add_file \
+			:3:sub1/sub2/new_add_add_file &&
+		git rev-parse >expect \
+			O:sub1/file  B:sub1/newfile O:sub2/other \
+			B:sub1/sub2/new_add_add_file \
+			A:sub2/new_add_add_file &&
+		test_cmp expect actual &&
+
+		git ls-files -o >actual &&
+		test_write_lines actual expect >expect &&
+		test_cmp expect actual
+	)
+'
+
 ###########################################################################
 # SECTION 13: Checking informational and conflict messages
 #
-- 
gitgitgadget

