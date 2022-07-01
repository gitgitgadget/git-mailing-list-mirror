Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A673C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 05:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiGAFX1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 01:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiGAFXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 01:23:25 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7F4167F5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 22:23:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r81-20020a1c4454000000b003a0297a61ddso3012363wma.2
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 22:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QOTHiPJzQNAwKxGQWS9EdTgIq+qlsjFjhPWGo/M+7S0=;
        b=X18g80ROGd6prGF1cK96IRcN3QV9oxkNBC4ucSZs2T01L8F3HOuRwMc85XxAzJP21g
         gT7rVtYLoiLYPmqCvPLTX9+dhDwZTPFvkRAGmtE+9R9wZNjeAb+oEHpiQxibApevp9NV
         uli3dfx0A58EmQ25cqgzBi3NE1qm1+16Ikx4FwXvutIAX0KFS9HYExgufAVXvarn3x62
         GdgW9OTs8LTSc4SGEQ/zkUU2G17tF1qyVi7JIXL8Nd41BEChOGhuy9xizyWjVD1VpwxK
         tpNovQqRf81oh4zNTT0Fjs+XesJaMKBF30s0iUn3mtFApzJbGKDijPA/fU2NwkvR+MUK
         o8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QOTHiPJzQNAwKxGQWS9EdTgIq+qlsjFjhPWGo/M+7S0=;
        b=1ErXwR4JWGOBtP6W9j8MzljPxdPIrD1KsWDCdvaw+BwDG8JcjgNst7HM4HQpSTLMV8
         WSHcTiPbJWH15RTHJEP09fYq3x21+RY7BdPJPiRyH3iOMEgfK1H6BtXdx0Tkl2mif1HU
         Y90Hu/vCxfNYqIavhZs7hOYO3UClikls8iMLM3gqdyS7yxIK2W9//6CIr29DzlfRYVdR
         j4Nr8pjJyhDgVvRd9E3B/LrvUrYHqWPDj1GdfTs8YCyETU2dZUUf+D4NycUSflzAUH63
         N+EZSWxE3JoQHRuaNPtYLki2I0ZwIey7xPiPXH6m6H2rFuS1lbuLWh0asGd80z+1Xqql
         Im0Q==
X-Gm-Message-State: AJIora+TvTq4cx4MRqM2PE2DUOXY6nH5I7t0Eqanr7cM4YLohzsnV6LF
        oZJ4JgLMSRk2idqwO5EHGNPw97PcL+A=
X-Google-Smtp-Source: AGRyM1tApPMwOLbCjMdRZijjFGgCyFKQ9yDhxszvXqEpd8QNoS7DLxIZknVjhT3GxY4MiVPy6y8Qbg==
X-Received: by 2002:a05:600c:2258:b0:3a1:8cba:646 with SMTP id a24-20020a05600c225800b003a18cba0646mr1615407wmm.7.1656653003117;
        Thu, 30 Jun 2022 22:23:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d42d2000000b0021a56cda047sm20581465wrr.60.2022.06.30.22.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 22:23:22 -0700 (PDT)
Message-Id: <a16a1c4d947d66751db1a4c0ab832c67fc3c9ce2.1656653000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>
References: <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com>
        <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jul 2022 05:23:16 +0000
Subject: [PATCH v3 1/5] t6423: add tests of dual directory rename plus add/add
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

